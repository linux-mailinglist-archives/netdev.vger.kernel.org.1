Return-Path: <netdev+bounces-266216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GIaO1M7sGmDhQIAu9opvQ
	(envelope-from <netdev+bounces-266216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:40:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51292253C1B
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC1C2336CD7A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6622A2C1586;
	Tue, 10 Mar 2026 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DnSFh3oI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hnZxPyCR"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6F32D73B9;
	Tue, 10 Mar 2026 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155953; cv=none; b=Bimcgg4uqEJit8B7IpKMf4dw9LqNG4xGAeVLRrTRuKv5sKUaIr1N3BJgtPRiYCO0mW4rdeVxP4l1EF/qbItHYIF+cT914YkkplbRDjMxoZoGkge4ocpA/F9UMJpSMKFyx+dwrXurssZ5dctLSnxY6m7Bepy7la2GxASGBm0c2F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155953; c=relaxed/simple;
	bh=Ljr/QMQoOPoZKUSJdHgCjPhfFZQD/zNp4BqnpTz4VHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpsQXZ0R3PaSgYw0SFnjqAw9aclTFFjIYw/nQjUMH1Jf0A+C+gPXdkp5eqYet8jKYQZb68pkWTcmflYDS0KMnelW6NsfCjVyio9IEYV0/yF3Rw3/iI2xSz7TTlbeaPeuPZMWGx0485fa8Qfn0dlhg1gyS0VmiUDTqYZ4U/E8DKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DnSFh3oI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hnZxPyCR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Mar 2026 16:19:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773155949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0QQFuLh4Ta7ffPBGa1R0HKar7+oTE7a5ZdfRejTMmEM=;
	b=DnSFh3oIAuQXA8reThG1uB2kg/YfHJErPAVzmEhDzoFGZWjpfB/b1R9A7T80+jjdUTLZP/
	mMjD1dVmBvEdBJSbO95ZCNyKw7ccqD4OpAu+AwiI+jFBLd08ER6/kxC7yvfby+2KatMHWD
	QpdR4feypOp13St/WdmddaKm7UqD4MrABWKfkMbCUFAsBmRomKGE8OT8rVHBpAB6M8/fU4
	E/AiEYXR0EWlhhS4QiZ7qp1zYM8h6kPCNfi0za0gQBH/aTF1/Y/6oOJmWjIuQL0jW6YLQv
	DFjWQ1JIRyi/xGXxtfFpt3R2W7mYOWsYX+BRiT6FT5Suz1h8GGzCQCsJx9dY+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773155949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0QQFuLh4Ta7ffPBGa1R0HKar7+oTE7a5ZdfRejTMmEM=;
	b=hnZxPyCRbHI+FEQN2U4VCt7erF7DvWsQvDGMx/XjvzWPOVBIM2sZoKljsXmZdDKIGi4ysl
	bkw1e3jh2z+/ROBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	John Johansen <john.johansen@canonical.com>,
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>,
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Tahera Fahimi <fahimitahera@gmail.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v5 2/9] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <20260310151907.VYySCtJp@linutronix.de>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
 <20260215105158.28132-3-gnoack3000@gmail.com>
 <20260217.lievaS8eeng8@digikod.net>
 <20260220.82a8adda6f95@gnoack.org>
 <20260308.AiYoh5KooBei@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260308.AiYoh5KooBei@digikod.net>
X-Rspamd-Queue-Id: 51292253C1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266216-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,canonical.com,maowtm.org,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Action: no action

On 2026-03-08 10:18:04 [+0100], Micka=C3=ABl Sala=C3=BCn wrote:
> > > dom_other, but please double check.  This lockless call should be made
> > > clear in the LSM hook.  It's OK to not lock the socket before
> > > security_unix_find() (1) because no LSM might implement and (2) they
> > > might not need to lock the socket (e.g. if the caller is not sandboxe=
d).
> > >=20
> > > The updated code should look something like this:
> > >=20
> > > unix_state_unlock(other);
>=20
> unix_state_lock(other) of course...
>=20
> > > if (unlikely(sock_flag(other, SOCK_DEAD) || !other->sk_socket)) {
> > > 	unix_state_unlock(other);
> > > 	return 0;
> > > }
> > >=20
> > > dom_other =3D landlock_cred(other->sk_socket->file->f_cred)->domain;
> > > unix_state_unlock(other);
> >=20
> > Thank you for spotting the locking concern!
> >=20
> > @anyone from netdev, could you please advise on the correct locking
> > approach here?

It is hard to tell where your "other" is from. So it is not clear to me
if the sock can be closed from the other side. If it can then sk_socket
becomes NULL and everything afterwards will be gone.

Therefore checking for SOCK_DEAD under unix_state_lock() looks sane.

> > * Do we need ot check SOCK_DEAD?
> >=20
> >   You are saying that we need to do that, but it's not clear to me
> >   why.
> >=20
> >   If you look at the places where unix_find_other() is called in
> >   af_unix.c, then you'll find that all of them check for SOCK_DEAD and
> >   then restart from unix_find_other() if they do actually discover
> >   that the socket is dead.  I think that this is catching this race
> >   condition scenario:
> >=20
> >   * a server socket exists and is alive
> >   * A client connects: af_unix.c's unix_stream_connect() calls
> >     unix_find_other() and finds the server socket...
> >   * (Concurrently): The server closes the socket and enters
> >     unix_release_sock().  This function:
> >     1. disassociates the server sock from the named socket inode
> >        number in the hash table (=3D> future unix_find_other() calls
> >        will fail).
> >     2. calls sock_orphan(), which sets SOCK_DEAD.
> >   * ...(client connection resuming): unix_stream_connect() continues,
> >     grabs the unix_state_lock(), which apparently protects everything
> >     here, checks that the socket is not dead - and discovers that it
> >     IS suddenly dead.  This was not supposed to happen.  The code
> >     recovers from that by retrying everything starting with the
> >     unix_find_other() call.  From unix_release_sock(), we know that
> >     the inode is not associated with the sock any more -- so the
> >     unix_find_socket_by_inode() call should be failing on the next
> >     attempt.
> >=20
> >   (This works with unix_dgram_connect() and unix_dgram_sendmsg() as
> >   well.)
> >=20
> >   The comments next to the SOCK_DEAD checks are also suggesting this.

Sure. You are not the owner I guess. So you hold a reference on it but
the owner can still close it.

> >=20
> > * What lock to use
> >=20
> >   I am having trouble reasoning about what lock is used for what in
> >   this code.
>=20
> It's not clear to me neither, and it looks like it's not consistent
> across protocols.
>=20
> >  =20
> >   Is it possible that the lock protecting ->sk_socket is the
> >   ->sk_callback_lock, not the unix_state_lock()?  The only callers to
> >   sk_set_socket are either sock_orphan/sock_graft (both grabbing
> >   sk_callback_lock), or they are creating new struct sock objects that
> >   they own exclusively, and don't need locks yet.
> >=20
> >   Admittedly, in af_unix.c, sock_orphan() and sock_graft() only get
> >   called in contexts where the unix_state_lock() is held, so it would
> >   probably work as well to lock that, but it is maybe a more
> >   fine-grained approach to use sk_callback_lock?

This is correct. Since only sock_orphan() is used you could go for
sk_callback_lock. For simplicity you could stick to the former lock
which will be accessed later any way. Either of the two block setting of
DEAD.

> > So... how about a scheme where we only check for ->sk_socket not being
> > NULL:
> >=20
> > read_lock_bh(&other->sk_callback_lock);
> > struct sock *other_sk =3D other->sk_socket;
> > if (!other_sk) {
> > 	read_unlock_bh(&other->sk_callback_lock);
> > 	return 0;
> > }
> > /* XXX double check whether we need a lock here too */
> > struct file *file =3D other_sk->file;
> > if (!other_file) {
> > 	read_unlock_bh(&other->sk_callback_lock);
> > 	return 0;
> > }
> > read_unlock_bh(&other->sk_callback_lock);
> >=20
> > If this fails, that would in my understanding also be because the
> > socket has died after the path lookup.  We'd then return 0 (success),
> > because we know that the surrounding SOCK_DEAD logic will repeat
> > everything starting from the path lookup operation (this time likely
> > failing with ECONNREFUSED, but maybe also with a success, if another
> > server process was quick enough).
> >=20
> > Does this sound reasonable?

So if SOCK_DEAD is not set while the lock is held you can reference the
chain without second thoughts.

> Actually, since commit 983512f3a87f ("net: Drop the lock in
> skb_may_tx_timestamp()"), we can just use RCU + READ_ONCE(sk_socket) +
> READ_ONCE(file).  The socket and file should only be freed after the RCU
> grace periode.  As a safeguard, this commit should be a Depends-on.

This is what I concluded. The commit in question did not change the
situation. But if this spreads more I would suggest a helper so that all
user of this short cut can be easily identified. And yes, RCU would be a
key requirement.

> However, it is safer to return -ECONNREFULED when sk_socket or file are
> NULL.
>=20
> I would be good to hear from netdev folks though.
>=20
> TIL, there is an LSM hook for sock_graft().
>=20
> > =E2=80=93G=C3=BCnther

Sebastian

