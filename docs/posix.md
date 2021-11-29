# POSIX

## What is POSIX?

[POSIX](https://pubs.opengroup.org/onlinepubs/9699919799.2018edition/) stands for `Portable Operating System Interface`  
and it defines a standard operating system interface and environment.

This includes a command interpreter (or “shell”) and common utility  
programs to support applications portability at the source code level.

### POSIX_ME_HARDER

`POSIX_ME_HARDER` was a short-lived system environment variable  
that could be used to toggle standards-compliant behaviour.

The variable name was later changed to `POSIXLY_CORRECT`.

#### Historical References

##### Richard Stallman: The Coder (LinuxCare Interview) (1999)

[http://linuxcare.com/viewpoints/os-interviews/12-14-99.epl](https://web.archive.org/web/20000929024358/http://linuxcare.com/viewpoints/os-interviews/12-14-99.epl)

```txt
Excerpt from "Richard Stallman: The Coder" - December 14, 1999

Linuxcare: Can you think of any major coups or major features that were
brought to the POSIX table?

Richard: I can't remember any more. That was in the 1980s. However, I do
remember one where we didn't succeed in persuading them. This was in
the POSIX.2 specification for the utilities. They made a decision that
they would follow System V by default, and in System V when you did
"df" or "du" file sizes were measured in disk block units of bytes.

Linuxcare: Right; instead of kilobytes.

Richard: Well, it occurred to me that this was not good for anybody, so I
asked them if they could please change it for the sake of the users.
They said, "No, our rules say we follow System V." So I took a poll
and asked users which they preferred, and it was 20:1 in favor of
kilobytes. I sent them the poll results and they said they didn't
care. Unfortunately, I didn't catch this at a time when I could
officially object to it. It was already approved and we had already
had a chance to object, so all I could do was make a comment. So I
couldn't block approval of the standard because I was a voting member
of the committee. I couldn't block approval of the standard on those
grounds, so instead... speaking of coups, this was about the time of
the coup that eliminated the Soviet Union. So, I posted a notice about
the coup in which the evil repressive forces of POSIX were being
thrown off, and as we speak, teams of new developers are taking
control of the major new utilities because they were making the
changes to support K by default. To have an excuse to say that we
still support the spec, if you define the environment variable,
POSIX_ME_HARDER was the original way. Then a slightly prudish board
member convinced me to change it to POSIXLY_CORRECT which I now think
was a mistake. I should have left it as POSIX_ME_HARDER.
```

##### Democracy Triumphs in Disk Units (Usenet) (1991)

news:gnu.announce | 9108281809.AA03552@mole.gnu.ai.mit.edu

```txt
Date: Wed, 28 Aug 91 14:09:19 -0400
From: rms@gnu.ai.mit.edu (Richard Stallman)
Subject: Democracy Triumphs in Disk Units
To: info-gnu@prep.ai.mit.edu

[Background:  The POSIX committee decreed that disk sizes would be
reported in units of 512 bytes, even though this is confusing and
an anachronism.  A poll was taken to see if people wanted this as
the default behaviour of the GNU project tools.  This article
gave the results of that poll.  --spaf]

Last week users poured out into the streets of the network to rally to
the cause of 1024-byte blocks for measuring disk space.  When people
finally chose sides, it was amazing how few actually stood with the
POSIX Central Committee and its apparatchiks.  Only 20 out of 750
supported the 512ist coup.

In the aftermath, the GNU system has declared its independence,
throwing off the power of the POSIX party.  We are rapidly moving to
eliminate all vestage of 512ist domination.  We have already taken
direct control of df, du, and several other programs, converting them
to use 1024-byte units for measuring output, and to provide ways to
specify input quantities in units of K.

We promise to respect the rights of minorities--even tiny ones.  So
there will be options to request output in units of 512.  Even those
who cannot bear to deviate from the POSIX party line will be provided
for--they can define the environment variable POSIX_ME_HARDER.

But what we really hope is that the POSIX party will itself modernize
its hardline position, and add its support to 1024ist reform.  If the
KGB could do it, there must at least be a chance for POSIX.
```
