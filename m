Return-Path: <netdev+bounces-248245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC64D059DA
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7FDF30146F0
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 18:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946702FD1BF;
	Thu,  8 Jan 2026 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="tXDlQCeV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8C4286D70
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897734; cv=none; b=EN7LlL2QRyrNzd89C9TFic/CoYwwDRxeAqagwWI1cdUZqA1eykKmgNSLnSkAtywWJMeLPeHPW7GZepXqs3GajrL1n/Osp+A0otvZng4eZedaNUe939T+zxXXSfvjIVjXaEiyVg/VY211OROf5kmBKtViol2oxn2Wby9pnjemkQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897734; c=relaxed/simple;
	bh=5AhcDwpfR+YII5+gCn87seKs+lCY2e2+wFBN2fIYU4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE9CBlUzj+xV340t5YA9tLjqkLSe1aJsLL751O7QTyzUxwIqfLkH+d3UO5F2ouTq4DLCHNY2T1iTvMJOVQknM6awiTNKYNkxP7ElSM0z3okSZp6Hg3KxBMAXtUoEpJFOnRu+QYXzs/GyUl7FCz7npDGFrVDsKiJucji/5ooBxjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=tXDlQCeV; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dnDKB5mwyzhyb;
	Thu,  8 Jan 2026 19:42:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1767897726;
	bh=y3jrhHg5FUx7kF7ivKJ7o2ZPDRDDiYTDDrcyS1yBIpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tXDlQCeVQGf2kBOcNAdDXCUJtXZwsibr5Bn6v/MRWbBIxKa4oMgobVLIg4AH97ZHV
	 CRLjv9hCH8cvUcvZ2vVJpY1c+6Wxt2yVkx9psmDA21Ci4CRmB4MQmTwG6+3dYujbjW
	 E+ebe8PmGnPEDyFHe1+h4b5r3+KwhHkSU59uHuxo=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dnDK94t2VzXJF;
	Thu,  8 Jan 2026 19:42:05 +0100 (CET)
Date: Thu, 8 Jan 2026 19:42:00 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Justin Suess <utilityemal77@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Simon Horman <horms@kernel.org>, linux-security-module@vger.kernel.org, 
	Tingmao Wang <m@maowtm.org>, netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
Message-ID: <20260108.gaiDoe7Faghi@digikod.net>
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
 <CAAVpQUCF3uES6j22P1TYzgKByw+E4EqpM=+OFyqtRGStGWxH+Q@mail.gmail.com>
 <aVuaqij9nXhLfAvN@google.com>
 <CAAVpQUB6gnfovRZAg_BfVKPuS868dFj7HxthbxRL-nZvcsOzCg@mail.gmail.com>
 <aV5WTGvQB0XI8Q_N@google.com>
 <CAAVpQUAd==+Pw02+E6UC-qwaDNm7aFg+Q9YDbWzyniShAkAhFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUAd==+Pw02+E6UC-qwaDNm7aFg+Q9YDbWzyniShAkAhFQ@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Jan 08, 2026 at 02:17:05AM -0800, Kuniyuki Iwashima wrote:
> On Wed, Jan 7, 2026 at 4:49 AM Günther Noack <gnoack@google.com> wrote:
> >
> > On Tue, Jan 06, 2026 at 11:33:32PM -0800, Kuniyuki Iwashima wrote:
> > > +VFS maintainers
> > >
> > > On Mon, Jan 5, 2026 at 3:04 AM Günther Noack <gnoack@google.com> wrote:
> > > >
> > > > Hello!
> > > >
> > > > On Sun, Jan 04, 2026 at 11:46:46PM -0800, Kuniyuki Iwashima wrote:
> > > > > On Wed, Dec 31, 2025 at 1:33 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > > > > > Motivation
> > > > > > ---
> > > > > >
> > > > > > For AF_UNIX sockets bound to a filesystem path (aka named sockets), one
> > > > > > identifying object from a policy perspective is the path passed to
> > > > > > connect(2). However, this operation currently restricts LSMs that rely
> > > > > > on VFS-based mediation, because the pathname resolved during connect()
> > > > > > is not preserved in a form visible to existing hooks before connection
> > > > > > establishment.
> > > > >
> > > > > Why can't LSM use unix_sk(other)->path in security_unix_stream_connect()
> > > > > and security_unix_may_send() ?
> > > >
> > > > Thanks for bringing it up!
> > > >
> > > > That path is set by the process that acts as the listening side for
> > > > the socket.  The listening and the connecting process might not live
> > > > in the same mount namespace, and in that case, it would not match the
> > > > path which is passed by the client in the struct sockaddr_un.
> > >
> > > Thanks for the explanation !
> > >
> > > So basically what you need is resolving unix_sk(sk)->addr.name
> > > by kern_path() and comparing its d_backing_inode(path.dentry)
> > > with d_backing_inode (unix_sk(sk)->path.dendtry).

I would definitely prefer to avoid any kind of hack to try to detect
potential race conditions. :)  I think it would also be more difficult
to maintain.

A well-defined hook would avoid race conditions by design, simplify
kernel code, and document the security check.

> > >
> > > If the new hook is only used by Landlock, I'd prefer doing that on
> > > the existing connect() hooks.

I guess other security modules would like to rely on that too.

> >
> > I've talked about that in the "Alternative: Use existing LSM hooks" section in
> > https://lore.kernel.org/all/20260101134102.25938-1-gnoack3000@gmail.com/
> >
> > If we resolve unix_sk(sk)->addr.name ourselves in the Landlock hook
> > again, we would resolve the path twice: Once in unix_find_bsd() in
> > net/unix/af_unix.c (the Time-Of-Use), and once in the Landlock
> > security hook for the connect() operation (the Time-Of-Check).
> >
> > If I understand you correctly, you are suggesting that we check that
> > the inode resolved by af_unix
> > (d_backing_inode(unix_sk(sk)->path.dentry)) is the same as the one
> > that we resolve in Landlock ourselves, and therefore we can detect the
> > TOCTOU race and pretend that this is equivalent to the case where
> > af_unix resolved to the same inode with the path that Landlock
> > observed?
> >
> > If the walked file system hierarchy changes in between these two
> > accesses, Landlock enforces the policy based on path elements that
> > have changed in between.
> >
> > * We start with a Landlock policy where Unix connect() is restricted
> >   by default, but is permitted on "foo/bar2" and everything underneath
> >   it.  The hierarchy is:
> >
> >   foo/
> >       bar/
> >           baz.sock
> >       bar2/        <--- Landlock rule: socket connect() allowed here and below
> >
> > * We connect() to the path "foo/bar/baz.sock"
> > * af_unix.c path lookup resolves "foo/bar/baz.sock" (TOU)
> >   This works because Landlock is not checked at this point yet.
> > * In between the two lookups:
> >   * the directory foo/bar gets renamed to foo/bar.old
> >   * foo/bar2 gets moved to foo/bar
> >   * baz.sock gets moved into the (new) foo/bar directory
> > * Landlock check: path lookup of "foo/bar/baz.sock" (TOC)
> >   and subsequent policy check using the resolved path.
> >
> >   This succeeds because connect() is permitted on foo/bar2 and
> >   beneath.  We also check that the resolved inode is the same as the
> >   one resolved by af_unix.c.
> >
> > And now the reasoning is basically that this is fine because the
> > (inode) result of the two lookups was the same and we pretend that the
> > Landlock path lookup was the one where the actual permission check was
> > done?
> 
> Right.  IIUC, even in your patch, the file could be renamed
> while LSM is checking the path, no ?

Yes but that should not be an issue wrt to the security policy.  The
check should atomic and consistent with the unix socket path resolution
used by the network stack.  In fact, comparing paths would potentially
forbid such rename, whereas this might be legitimate.

> I think holding the
> path ref does not lock concurrent rename operations.

We cannot hold a path ref without potential VFS issues.

> 
> To me, it's not a small race and basically it's the same with
> the ops below,
> 
> sk1.bind('test')
> sk1.listen()
> os.rename('test', 'test2')
> sk2.connect('test2')
> 
> sk1.bind('test')
> sk1.listen()
> sk2.connect('test1')
> os.rename('test', 'test2')
> 
> and the important part is whether the path _was_ the
> allowed one when LSM checked the path.

In the case of Landlock's sandboxing, we want to check the path at
connect time because that's when it makes sense for the client wrt to
its request (and its security policy).

FYI, Landlock identifies paths with a set of inodes, so if the unix
socket is explicitly allowed, then a rename may still be allowed by the
security policy.

> 
> >
> > Some pieces of this which I am still unsure about:
> >
> > * What we are supposed to do when the two resolved inodes are not the
> >   same, because we detected the race?  We can not allow the connection
> >   in that case, but it would be wrong to deny it as well.  I'm not
> >   sure whether returning one of the -ERESTART* variants is feasible in
> >   this place and bubbles up correctly to the system call / io_uring
> >   layer.
> 
> Imagine that the rename ops was done a bit earlier, which is
> before the first lookup in unix_find_bsd().  Then, the socket
> will not be found, and -ECONNREFUSED is returned.
> LSM pcan pretend as such.

Yes but this would be inconsistent with the network stack.  It would
introduce a race condition where unix socket cannot be used for
potentially no legitimate reason.

> 
> 
> >
> > * What if other kinds of permission checks happen on a different
> >   lookup code path?  (If another stacked LSM had a similar
> >   implementation with yet another path lookup based on a different
> >   kind of policy, and if a race happened in between, it could at least
> >   be possible that for one variant of the path, it would be OK for
> >   Landlock but not the other LSM, and for the other variant of the
> >   path it would be OK for the other LSM but not Landlock, and then the
> >   connection could get accepted even if that would not have been
> >   allowed on one of the two paths alone.)  I find this a somewhat
> >   brittle implementation approach.
> 
> Do you mean that the evaluation of the stacked LSMs could
> return 0 if one of them allows it even though other LSMs deny ?

If any LSM returns a non-zero value, then the call stops.

I think what Günther wanted to highlight is that a hook call may lead to
different hook implementation calls, and all these implementations should
be able to return consistent results wrt to other calls.

> 
> 
> >
> > * Would have to double check the unix_dgram_connect code paths in
> >   af_unix to see whether this is feasible for DGRAM sockets:
> >
> >   There is a way to connect() a connectionless DGRAM socket, and in
> >   that case, the path lookup in af_unix happens normally only during
> >   connect(),
> 
> Note that connected DGRAM socket can send() data to other sockets
> by specifying the peer name in each send(), and even they can
> disconnect by connect(AF_UNSPEC).

Yes, thanks for pointing this out.  It's the duty of LSMs to correctly
handle this case.  It is handled by Landlock for abstract unix sockets.

> 
> 
> > very far apart from the initial security_unix_may_send()
> >   LSM hook which is used for DGRAM sockets - It would be weird if we
> >   were able to connect() a DGRAM socket, thinking that now all path
> >   lookups are done, but then when you try to send a message through
> >   it, Landlock surprisingly does the path lookup again based on a very
> >   old and possibly outdated path.  If Landlock's path lookup fails
> >   (e.g. because the path has disappeared, or because the inode now
> >   differs), retries won't be able to recover this any more.  Normally,
> >   the path does not need to get resolved any more once the DGRAM
> >   socket is connected.
> >
> >   Noteworthy: When Unix servers restart, they commonly unlink the old
> >   socket inode in the same place and create a new one with bind().  So
> >   as the time window for the race increases, it is actually a common
> >   scenario that a different inode with appear under the same path.
> >
> > I have to digest this idea a bit.  I find it less intuitive than using
> > the exact same struct path with a newly introduced hook, but it does
> > admittedly mitigate the problem somewhat.  I'm just not feeling very
> > comfortable with security policy code that requires difficult
> > reasoning. 🤔 Or maybe I interpreted too much into your suggestion. :)
> > I'd be interested to hear what you think.
> >
> > —Günther

