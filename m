Return-Path: <netdev+bounces-304474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NBueDdSDR2qrZwAAu9opvQ
	(envelope-from <netdev+bounces-304474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:41:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A2F700BD8
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:41:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=e9MFh+yA;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304474-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304474-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08985304C065
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 09:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8505A3B14A3;
	Fri,  3 Jul 2026 09:32:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DC7381EBB;
	Fri,  3 Jul 2026 09:32:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783071126; cv=none; b=cIJhCax6Mj3/vWxVNkM3+8b/HtJs9roilF4sbBLaMk+3FrWbKSakv6dMFy/gp+AU0OoskC+qzTMqF+aOdUbTGYQK+vADjVhQq5trEba07VPigWNDiP4RDIJXUyRE4zR58dKbEeABdvZCK/Cy/UmbazdddGYo5mhNiH8VToiazPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783071126; c=relaxed/simple;
	bh=n9XJEkc+DowG9Obr4NUQaCy1/3OPEUMahQYjpJe65oU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=a+zXmJJC5jywlA2hq6mgI5wiagtiNsLpdiEmmgelvtRsT1/Q12ov0PSEu9CC415dXx2DdBXZdXNE58mrnqVb7xF4V2ZjdHcIuik6Mb+qAQsNs/1dI9KiQLZtGoIoNWhnCPTSEEk7Qi3YM2oW8spvrmFiJqkiOtzswNBQ58rrw9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9MFh+yA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19821F000E9;
	Fri,  3 Jul 2026 09:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783071124;
	bh=ARJjvdhtSZCnWgEd0trqgpLbvyNLpvUgzO6qa5p73UM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=e9MFh+yABLy2CPe8HOcWFFQvIivncfb0irowyxUQghRkows1pifnaZW05tS6k7K4a
	 0on7bvVhK5eZSdywVJLzlsMo3wKv8kymFppmegCgr4r0fcB4t/jxZjQHBoyYeX6vSt
	 vQlDfcpRVWJ5H7pZEx1h2R7LoSK1OA7fhQa6gmfVtuD9zMYmR3Euri9B7ey7Jf14wf
	 eFKivx9mqjKYdSNG1UXaem/s9lKgeQ9qac7qs8+ac4TKM3lliutOM5FcAZS/9f2uiB
	 A09lj9LBbVwsyfxrdPvzVbugEZBbE4SIopUb/K9TLBNTuruASCJrDXoE9m5QISPJle
	 sOc20WO/NzHxg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH 3/3] coredump, net: remove `SOCK_COREDUMP`
From: Christian Brauner <brauner@kernel.org>
To: John Ericson <mail@johnericson.me>
Cc: Christian Brauner <brauner@kernel.org>, 
 John Ericson <John.Ericson@obsidian.systems>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Cong Wang <cwang@multikernel.io>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, 
 David Rheinsberg <david@readahead.eu>, Andy Lutomirski <luto@kernel.org>, 
 Sergei Zimmerman <sergei@zimmerman.foo>, 
 network dev <netdev@vger.kernel.org>, 
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
 LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <7acb650b-a0de-4244-861f-4dda70ca8993@app.fastmail.com>
References: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
 <20260703073948.2541875-4-John.Ericson@Obsidian.Systems>
 <20260703-umgehen-auftun-anlagen-826bf59dfcb5@brauner>
 <7acb650b-a0de-4244-861f-4dda70ca8993@app.fastmail.com>
Date: Fri, 03 Jul 2026 11:31:58 +0200
Message-Id: <20260703-karierte-gemolken-restaurant-fb5a0601423c@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4247; i=brauner@kernel.org;
 h=from:subject:message-id; bh=n9XJEkc+DowG9Obr4NUQaCy1/3OPEUMahQYjpJe65oU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5N05I/Hj03KVPvdeemq/pa1qy9dqFSff5HoqKHl3zs
 +pzXeujhI5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJNOkw/C/OeRxxsn6jQbXh
 j2q5vgvxm7pypm/4djB3yZ99ghdX+B5n+GekG3v229WtIfk1AjveWj34nsv+11Wj3WwN25akkyY
 FR7kA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mail@johnericson.me,m:brauner@kernel.org,m:John.Ericson@obsidian.systems,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:cwang@multikernel.io,m:kuniyu@google.com,m:horms@kernel.org,m:david@readahead.eu,m:luto@kernel.org,m:sergei@zimmerman.foo,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:mic@digikod.net,m:gnoack@google.com,m:paul@paul-moore.com,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304474-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,brauner:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0A2F700BD8

On 2026-07-03 05:08 -0400, John Ericson wrote:
> On Fri, Jul 3, 2026, at 4:11 AM, Christian Brauner wrote:
> > I don't think dragging the bowels of net/ into fs/coredump.c just for
> > the sake of getting a purely internal SOCK_COREDUMP flag out of the way
> > is the right way to go.
> >
> > I suspect the saner thing to do would be to introduce a primitive for
> > connecting to an AF_UNIX path-based socket directly instead of this
> > weird dance here, no?
> >
> > int kernel_unix_connect(const char *path, struct socket *socket, unsigned int o_flags, int type)
> >
> > then my kthread changes would collapse this into:
> >
> > scoped_with_init_fs()
> > retval = kernel_unix_connect(path, socket, O_NONBLOCK, SOCK_STREAM);
> 
> That works for this case, but the destination I am trying to eventually
> reach is being allowed (in userspace) to connect to unbound sockets by
> their fd --- no path, no abstract socket name.

But these are orthogonal changes. It sill doesn't mean we should sprawl
net internals over coredump code anymore than we already have to. I'm
fond of kernel_unix_connect() int dfd, const char *path even would be
fine.

>     unix_connectat(int fd, const char *path, struct socket *socket,
>                    unsigned int at_flags, unsigned int o_flags,
>                    int type)
> 
> is a mouthful, but it would work. Still, there is a subtlety about the
> retry logic. When one does something like:
> 
> > connect(..."/dev/fd/N",...)
> 
> it will repeatedly re-lookup "/dev/fd/N" until the timeout is reached. I
> consider that pretty terrible --- the rest of the program could race to
> change what that file descriptor (number) refers to. Therefore, I think
> table stakes to make a good `unix_connectat` is to make the
> `AT_EMPTY_PATH` case not re-lookup the socket.

I have no idea how this has any bearong on the three helper split.

> (making a sockfs file descriptor work is separate, I already have the
> patch for that, I can include it.)
> 
> > The two helpers also make no sense to me and force a bunch of cleanup on
> > the caller as well.
> 
> I am fine with `unix_connectat`, but just for reference, me breaking up
> the steps is because I generally like the decomposition of `fverb`
> rather than `verbat` system calls, since the latter would typically be
> used with `openat` or so. It seems the `kernel_*` "syscalls" generally
> take `struct path` rather than strings, which seems good and in the

There's a time to follow precedence and there's a time to do what the
maintainability demands. I think here clearly we don't want to pass a
struct path. That makes no sense because we don't care about using that
object at all. It's merely an intermediate jumping point. This is
fundamentally about connecting from the kernel to a specific pathname
that functions as a socket address. Intermediary objects don't matter
(yet).

> spirit of that decomposition, but then even `struct path` is overkill to
> refer to a socket. So putting all that together, the final composition I
> had was:
> 
> 1. string path (from /proc/...) -> `struct path`
> 2. `struct path` -> `struct sock *`
> 3. connect to `struct sock *`
> 
> So I quite liked those 3 orthogonal knobs, vs an all-singing-all-dancing
> `unix_connectat`. (I suppose making it `struct socket *` would make it
> slightly less internals-y?) But again, anything that puts us on track to
> being able to connect to an unbound socket without procfs is good enough
> for me.

To me this reads like you're introducing moving parts for the sake of a
philosophical argument. I couldn't care less about that. What matters is
maintainability. Having three knobs that introduce potentially three
separate cleanup requirements and exposing three different objects when
it's not needed is just a burden.

> 
> > I'm not sure why we would go on altering all kinds of LSM hooks as well.
> 
> That's in the commit message, it is because without `SOCK_COREDUMP`
> those are all dead code. Instead of removing them in this commit, I can
> just keep those flags, or remove them in a separate commit. Fine

Do it as a separte commit once we've decided to do this, I think.


