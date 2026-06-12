Return-Path: <netdev+bounces-298776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nQXJMwRVLGoyPgQAu9opvQ
	(envelope-from <netdev+bounces-298776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:50:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F8B67BD9D
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:50:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=multikernel-io.20251104.gappssmtp.com header.s=20251104 header.b=HralDdkV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298776-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298776-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA795308F353
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DCF3624B2;
	Fri, 12 Jun 2026 18:50:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF17306764
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 18:50:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781290242; cv=none; b=lSZ0Jr+JY+XVVJNpYEWmiK08hsfHMfX17zPNvB0V5p96Fm4bOi1k1I+ktAgT/1k4ZP8yKqYwcmpg1r8gJQWyuphoPkXdaBnxb0n0iA+P87YzT3u7tPQSEhaOzCkjV0e+147Yxe2TgFHx/MlqvX8OXm5lZNtnoTFtqo73HZL2AQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781290242; c=relaxed/simple;
	bh=cH0sbHpGDI2zSSn4EEZ3+++ongnezOXwOw62K6eWxFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2Q+Lq2Zi8ChLGb4zPv7xWYLpzDSADrg5VrTDxXp4MVS4h6rQdepZVXbr8qar7ExKm6I+hVfTi4z8rhJUJRIauhhJHvB3QswKdCXrA1+EKVdfNRziVQ7gb7HODBoO1unp633htUhS7Eun8F/bGUl6BpQbVmLxeR6IHUCOVN6tXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=HralDdkV; arc=none smtp.client-ip=74.125.82.47
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-13810b63a1aso2905663c88.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 11:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1781290240; x=1781895040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z5loRl3eYzvVf7VQj1JR5txRoZaeLRgFG2nXkMFwavg=;
        b=HralDdkV9tzSH0vGsT7ivAjB6EBmUewSQnyGoZcWG73aFnHhphoz5Vdt662CrQri2k
         65bs/jM6l7Q62qunfTK3Rzf9VIwP+YXqhI5ohUvxGYxcbhNBvG2gIGyjaclPQBbVi8Sf
         9CFGDsRDCz4LxRggeMu6QP3GXAe+L5lJ2A05BhaBTO5pWXRr5h1f5rc+t4F7jR3UIN0O
         NCrSU6w+eqMjCfPO8HkEZbOlVCZmSRYO7jYzzFPcS5rE+Yaax1cBc3v2PC1OXhW+Tkxe
         YGmXbmgBspYT/9YtAojuF5R9lG3InxKNzihM/ankdHoHV29E95dzFXKBeX0RVDnQnQlB
         +arA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781290240; x=1781895040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5loRl3eYzvVf7VQj1JR5txRoZaeLRgFG2nXkMFwavg=;
        b=jOtLIYL3fw9I183NumBIsu6wvYDNVGNZv+4rXkiUX212pLQKbuZlCOEeWDdwsgbzbH
         Cv1JXdfVcG31iAL4oZcJQPmFXBifv8TuVK+bhsVUiqoIPiG9FXKc4ufx3CtiJ1PDvLVy
         xnnpLCuifiZCL+PkvJRYXR1J3YilwmoFUJygRPA9Jmvoo/O+6l3z+AeuDpUd0hadOiK5
         NGBp9VXmPjxqipxef6hIfx+BqeZlC74UxhPEFKe21LsGbrqS+NscVjFZGRKOSKKsXFQC
         Vl/7U/sVZKG74DJa9qsrHb+VOoqVlMDu42SHY3PHcxaQmIDK/DdwPxODkBUoGzfA5INl
         DzjA==
X-Gm-Message-State: AOJu0YyZnTI3XTtE2Z/EbuCbCTwMa42qJQhvRBZ70VEJDi2bOdQwBtar
	pAFfxug4ZcyqRCpxzwjccY6d/py2UZElkd/lmYIXJ0fnC5o9oQkJLIadGT4SrlUv+WtCI1R5KoK
	ni9MPwwdqsg==
X-Gm-Gg: Acq92OFOgnXzZpJmYSaFjhM+rzADV0rYFdFXCe3vpol9JaKxFIjqqsKRW9QaxuFWjPD
	0EsqYK9pxZqrQ7wiN5oFO2wXn5KoD7LVVr2oWLFrBknia67wmUntySeK8WWQrJnn1YwD5vqEjXW
	y7y5naYM45hFS+n4w92gfEffu74t4wya5hwTIYapQPIFngMF/PAESzfTvMAEfLYrGSX53JyKbBv
	8HqtA2H4J9dS0u35eI26faQeXyGSbixLBzDkDoZNvqnU+jtf6Es1Pl3k6PQJtaK//84zvB1c+6O
	XtWD4K1Zk8AJXDRdg5MzNrIpPIcb3+wFy064E1kstgWV1+Krxid9zad86R5CUZmPeKoMKHWamQ6
	zwcwyzA3BnEF3QtI3hkooHedffareoGLSZ4W8dnqbbB3O82/gEIkfoPQCreRX/Zs3S0rLF+RJuY
	cHYhgTFykEca6yl7jnri24SiWHcmmuBXsEfxo7hcxJDamqS0ptygXqbw==
X-Received: by 2002:a05:7022:79f:b0:137:ea7d:a5fc with SMTP id a92af1059eb24-1384bba7dfbmr2200924c88.22.1781290239578;
        Fri, 12 Jun 2026 11:50:39 -0700 (PDT)
Received: from localhost ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b8f9889sm3005394c88.3.2026.06.12.11.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:50:38 -0700 (PDT)
Date: Fri, 12 Jun 2026 11:50:37 -0700
From: Cong Wang <cwang@multikernel.io>
To: John Ericson <mail@johnericson.me>
Cc: network dev <netdev@vger.kernel.org>, Li Chen <me@linux.beauty>
Subject: Re: [RFC] connectat()/bindat() or an alternative design
Message-ID: <aixU_RccxS_BKhgX@pop-os.localdomain>
References: <b1af80fc-a57c-408d-bdfe-fa6bae26eaca@app.fastmail.com>
 <aicbyQIC2qEveNd-@pop-os.localdomain>
 <455281ec-3ee1-4f27-989b-c239f0690d8b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455281ec-3ee1-4f27-989b-c239f0690d8b@app.fastmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[multikernel-io.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298776-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mail@johnericson.me,m:netdev@vger.kernel.org,m:me@linux.beauty,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[multikernel.io];
	FORGED_SENDER(0.00)[cwang@multikernel.io,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[multikernel-io.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cwang@multikernel.io,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[multikernel.io:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pop-os.localdomain:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26F8B67BD9D

On Wed, Jun 10, 2026 at 10:08:57PM -0400, John Ericson wrote:
> Hi Cong,
> 
> On Mon, Jun 8, 2026, at 3:45 PM, Cong Wang wrote:
> > Hi John,
> >
> > [...]
> >
> > Thanks for bringing this up.
> 
> Sure, thanks for replying to me!
> 
> > I have no doubt connectat()/bindat() helps closing TOCTOU for Unix
> > sockets. However, it would be nicer to describe your use case here,
> > especially what the problems are without it. This would help more to
> > jusify your proposal here than just getting aligned with openat() or
> > BSD.
> >
> > Hope this helps.
> >
> > Regards,
> > Cong
> 
> Yeah, happy to talk about that. Hope this is not too long a reply!
> 
> First, for some background context, I am a developer of the Nix package
> manager. And this, plus my own personal taste, always has me thinking
> about ways we can run processes with fewer privileges. The
> no-ambient-authority capsicum/cloudabi/wasi/whatever dream has lived in
> my head rent-free for many years :). Now these days, with LLMs, it feels
> like these nice-to-have yak shaves of mine are finally worth dusting off
> and striking off the bucket list.
> 
> Also in recent months, we Nix developers have been putting a bunch of
> work into using more `openat2` and friends, and I have no doubt that we
> will continue down this path (even on Windows!). We aim to be an
> exemplar program for following the "always work relative to a file
> descriptor" discipline. It's good for security, but also makes for code
> that --- I believe --- is just more elegant and nicer to read.
> 
> ----
> 
> Nearer term use case: slightly less ugly long path socket opening in
> Nix:

"Nix needs it" is a much better justification than "BSD already has it".
:) So please add this to your patch description/cover letter.

> 
> If you look at [1] you can see a PR I've asked my coworker to draft to
> improve binding and connecting code to cope with longer file paths,
> something which does come up in practice when we are running multiple
> tests with multiple daemons in parallel.
> 
> Now, I think it is safe to say that this code was already quite complex,
> and in this patch only gets *more* complex. The current interfaces make
> supporting longer paths quite annoying. (Though, once we remove the
> `open` and switch to an `*at`-style interface in the wrapper (if macOS
> lets us), it will get less bad.)
> 
> So the first use case would be getting something nicer than the
> `/proc/self/fd/<N>` dance the linked code falls back to. It is good that
> `/proc/self/fd/<N>` exists for legacy code, but it is an unergonomic way
> to do file-descriptor-relative paths, and should be a fallback, never
> the first choice. A real fd parameter along with a regular path pointer
> would buy two concrete wins:
> 
> 1. A clean, separate file descriptor parameter, the way `openat` has one
>    --- rather than assembling a `/proc` path by hand.
> 
> 2. Normal `PATH_MAX` room for the real pathname, rather than cramming
>    `/proc/self/fd/<N>` (plus any residual path after it) into the small
>    `sun_path` field of `struct sockaddr_un`.
> 
> ----
> 
> Longer term use case: anonymous listening sockets, avoiding advertising
> sockets to potential clients using ambient authority mechanisms
> altogether:
> 
> Some more background: I think this whole business of listening
> unix sockets necessarily living in the file system is a bit silly, since
> there is nothing to put on disk --- it's just a mechanism to communicate
> to clients where they should connect. Now ostensibly, Linux agrees ---
> that is why Linux's *abstract* Unix domain sockets were created. But I
> really don't like this because we have just replaced one ambient
> authority contraption (the root filesystem) with another (the abstract
> socket name space in the network namespace). The problems with ambient
> authority remain all the same (and indeed, our experience with Nix has
> been that network namespace unsharing when you do want to do some
> outside world network access is much more work than filesystem namespace
> unsharing).

Indeed, it would be very hard to change since it is coded in UDS API since
probably day 1.

Just curious: any reason not to use TCP loopback here?

> 
> What I would really like to do is go further than what I proposed, and
> separate the binding of a unix socket from the placing in the file
> system.
> 
> Today, with only existing UAPIs, the closest you can get is a scratch
> path you pin with `O_PATH` and immediately unlink:
> 
>     /* server */
>     int lfd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
>     struct sockaddr_un a = { .sun_family = AF_UNIX };
>     strcpy(a.sun_path, "/tmp/scratchXXXXXX");
>     bind(lfd, (struct sockaddr *)&a, sizeof a);

Any reason not to use abstract socket?

       abstract
              an abstract socket address is distinguished (from a
              pathname socket) by the fact that sun_path[0] is a null
              byte ('\0').  The socket's address in this namespace is
              given by the additional bytes in sun_path that are covered
              by the specified length of the address structure.  (Null
              bytes in the name have no special significance.)  The name
              has no connection with filesystem pathnames.  When the
              address of an abstract socket is returned, the returned
              addrlen is greater than sizeof(sa_family_t) (i.e., greater
              than 2), and the name of the socket is contained in the
              first (addrlen - sizeof(sa_family_t)) bytes of sun_path.


>     int addrfd = open(a.sun_path, O_PATH | O_CLOEXEC); /* pin the socket inode */
>     unlink(a.sun_path);                                /* nameless now */
>     listen(lfd, 64);
> 
>     /* client, handed `addrfd` -- but still has to *name* it, via /proc magic */
>     struct sockaddr_un c = { .sun_family = AF_UNIX };
>     sprintf(c.sun_path, "/proc/self/fd/%d", addrfd);
>     connect(cfd, (struct sockaddr *)&c, sizeof c);
> 
> So even though I hold the socket by descriptor, I still route a pathname
> (`/proc/self/fd/...`) to reach it, and I have to deal with the
> `/tmp/scratchXXXXXX` proper temp file usage.
> 
> What I'd actually want is to sidestep all those nuisances entirely.
> 
> The important piece is a `bind` variation: like binding an abstract unix
> socket, except that it publishes no abstract socket name, so the *only*
> way to connect to the socket is to be given an fd referring to it.
> 
> A matching `connect` variation is more of a nice-to-have: it lets a
> client connect straight through that fd, rather than having to name it
> via `/proc/self/fd` as above.
> 
> Put together:
> 
>     /* server */
>     int lfd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
>     int addrfd = bind_anon(lfd, /*flags, for the future*/0);  /* proposed: no filesystem or abstract name */
>     listen(lfd, 64);
> 
>     /* client, handed `addrfd` -- connect straight to the descriptor */
>     connectat(addrfd, cfd, NULL, 0, AT_EMPTY_PATH);   /* proposed */
> 
> I would use this *a lot*! First of all, in our testing code, I would use
> this, and not even bother (on Linux at least) putting the test daemon
> socket on a (probably quite long) path; I would just rig up the test
> harness to pass the fd to the client process with an environment
> variable (local not global naming!) indicating to the process which file
> descriptor it should connect to.
> 
> If that sounds vaguely like systemd socket activation, yes it should.
> Socket activating *servers*, as we do today, is great, but I would also
> modify my init system to pass these listening sockets to *client*
> services. At that point, servers should ditch any sort of `getsockopt`
> authentication (which they are likely to implement incorrectly or in an
> ad-hoc manner), and instead rely on the init system to make sure only
> services/users which are authorized to connect to a given server have
> been given its listening socket file descriptor.
> 

Thanks,
Cong

