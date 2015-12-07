Dear future me,

Remember the first time you configured your [personal website](http://jawher.me/) ?

* Installing nginx
* Installing a couple python modules: pelican, markdown, pygments
* Cloning your personal blog from github
* Launching Pelican to build it
* Copy the output to a folder served by nginx

Fun times eh ?

And then you went ahead and started customizing the whole thing:

* Create a [new markdown extension to embed dot](https://github.com/jawher/markdown-dot) files in blog posts
* Create a [new Pygments lexer](https://github.com/jawher/litil-pygments) for your toy language litil
* So you had to install them and their depedencies

But still, you were not content with that.
You felt something was still missing.

Indeed, having to ssh into the server, run git pull and rebuild the blog everytime you pushed a new content was tiresome.

So you said to your self I could totally automate that !
True to your word, you created a tiny server which gets notified by github whenever a push occurs and rebuilds the blog.

Initially you wrote that in Python using a tiny framework called bottle.
Man the code was so compact and beautiful.

But then, to run it as a true service, googling around told you that you should put it behind a WSGi server which itself is behinf nginx.

That's when the fecal matter hit the rotary impeller.
Never forget the hours you spent trying to get the damn thing to work.
Never forget how uwsgi drove you crazy with its cryptic error messages or sullen silence and simple refusal to work.

But you're the man.
You managed to [get it to work](http://jawher.me/2012/03/16/multiple-python-apps-with-nginx-uwsgi-emperor-upstart/).
And things went well for a couple of months.

But, the universe had to step in and pice things up again: your web hosting service launched a new datacenter with much cheaper servers.
You couldn't resist the temptation to grab on of those new shiny and cheap servers.

Problem is, it was a couple of months since you last touched your server configuration.
And like every other developer worth his salt, you didn't document shit.
Even worse, during these months, the universe didn't just hold still for you mister.
No, the different tools you used to build your brittle server were upgraded, multiple times even.
So simply reinstalling the same packages and copying the old configuration files didn't work.
You had to again spend a couple of days fighting with this unholy mess to wrestle it into submission again.

And now, your hosting company has launched a newer and shinier platform.
It even has all the required buzz words of the moment: cloud, openstack.
There's even a cute whale image in their home page.

So of course you had to move to the new platform.

But that's when you said: Enough is enough.
I'm not going to make the same mistakes again.
This time, I'm much older and wiser.
This time, I'm going to use ansible to automate the whole thing.
You promised yourself you're never going to ssh into this new machine, except for debugging purposes.

So here is the result of your efforts:
a beautiful set of ansible playbooks to set everything up for you.

Your truly,
Jawher from the present.

P.S.:
To run this thing, you should execute:

```sh
ansible-playbook playbook.yml -i <an-inventory-file> --ask-vault-pass
```

where `<an-inventory-file>`  would look like:


```yaml
<server-ip-or-host> ansible_ssh_user=<server-user> email=<lets-encrypt-account-email> frontal_port=<frontal-nginx-port>    blog_url=<blog-url>    blog_src=<blog-clone-dir>    blog_dest=<blog-html-output>    blogb_url=<blog-builder-url>    blogb_loc=<blog-builder-location>    blogb_port=<blog-builder-local-port>    blogb_user=<blog-builder-login>    blogb_pwd=<blog-builder-login>  gorex_url=<gorex-url>   gorex_port=<gorex-local-port> gorex_dir=<gorex-static-files-location>
``` 

For example:

```yaml
jawher.me ansible_ssh_user=admin  email=self@email.com frontal_port=80    blog_url=jawher.me    blog_src=/var/www/jawher.me/    blog_dest=/var/www/blog    blogb_url=bb.jawher.me    blogb_loc=/build-blog    blogb_port=8080    blogb_user=jawher    blogb_pwd=nope  gorex_url=rex.jawher.me   gorex_port=8090 gorex_dir=/var/www/gorex/
```

# License

This site is released under the [MIT License](http://www.opensource.org/licenses/mit-license.html).

I doubt this would be much help to others though as it is pretty specific to my specific setup.
