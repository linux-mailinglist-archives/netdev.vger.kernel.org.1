Return-Path: <netdev+bounces-269110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDv7D0rlummdcwIAu9opvQ
	(envelope-from <netdev+bounces-269110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:47:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AA52C091C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CC253077ABC
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3513F1679;
	Wed, 18 Mar 2026 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ZlLgFT2O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF063A4520
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850972; cv=none; b=QQeGPPGjx6V3aVJILv/nqOb8KMrlgEjYx2J3skIazarhIu/sHLduuyjqnWYhEiauEgCrmvXJ6KpITc/ZRs1U9wOaD1guHb8SHiw3lmf6M/O/leJ2Bnzn2l8G4e+bLUViUY5ctGFZREXzZhx7BLY+7x2yY91jeuli052s6sf+dfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850972; c=relaxed/simple;
	bh=39uYVicU566x+eNdfwpbYBT6OhThLnYXRsfYT3vtigQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TB1n7XCjdKiC3hajvobts7AxJZYeKocwxZkKGr4W1RkglNkn/JpK22nLLEGpwGxd4JT1BVdD9Yx8MPnLYXYJYQEEOes/71NNsiqdwWW/qcIUkcMF+eFWjSw+fLyU+L/RsBLpiNj8Lv+IJOJVTlyLYK0+ImFoFvoR6Vxfa2yGaV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ZlLgFT2O; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fbYyV2GSZz8wk;
	Wed, 18 Mar 2026 17:22:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773850962;
	bh=p3Z++XLcTQuwq7LFpOkkcdkzdVhx9nvzQHpjzM9/zmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZlLgFT2OEncp31yadr87Y9jvKZJYUJkMrNJHqJwTsBYc/dAXGi4BeaPpglxO1be7a
	 RrAQoHSRx1Pqjy/xKHdMdwT1hfYfQiQTLH1ocUl/3boYN5VPXvZbXyDJt5c0xOzpFD
	 TwZzUJZAQ9G1SM+gDsF4aTSx5updh4a9vlPHF63w=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fbYyR36Bkzlhs;
	Wed, 18 Mar 2026 17:22:39 +0100 (CET)
Date: Wed, 18 Mar 2026 17:22:34 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, 
	linux-security-module@vger.kernel.org, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 1/9] lsm: Add LSM hook security_unix_find
Message-ID: <20260318.wa0eef4tei6I@digikod.net>
References: <20260315222150.121952-2-gnoack3000@gmail.com>
 <2697b9f672967b1318630f2ffa21914f@paul-moore.com>
 <20260318.In1aekohyivu@digikod.net>
 <CAHC9VhRy2j3nYHHnyjsDf9Rk6=5DAzCSrmXgHCpo4arVnfBjRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRy2j3nYHHnyjsDf9Rk6=5DAzCSrmXgHCpo4arVnfBjRw@mail.gmail.com>
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [-0.89 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.77)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269110-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[canonical.com,gmail.com,namei.org,hallyn.com,maowtm.org,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,linutronix.de,kernel.org,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[digikod.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[maowtm.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,digikod.net:dkim,digikod.net:email,digikod.net:mid]
X-Rspamd-Queue-Id: 37AA52C091C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 10:44:26AM -0400, Paul Moore wrote:
> On Wed, Mar 18, 2026 at 4:48 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > On Tue, Mar 17, 2026 at 05:34:57PM -0400, Paul Moore wrote:
> > > On Mar 15, 2026 =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com> wrote:
> > > >
> > > > Add a LSM hook security_unix_find.
> > > >
> > > > This hook is called to check the path of a named unix socket before a
> > > > connection is initiated. The peer socket may be inspected as well.
> > > >
> > > > Why existing hooks are unsuitable:
> > > >
> > > > Existing socket hooks, security_unix_stream_connect(),
> > > > security_unix_may_send(), and security_socket_connect() don't provide
> > > > TOCTOU-free / namespace independent access to the paths of sockets.
> > > >
> > > > (1) We cannot resolve the path from the struct sockaddr in existing hooks.
> > > > This requires another path lookup. A change in the path between the
> > > > two lookups will cause a TOCTOU bug.
> > > >
> > > > (2) We cannot use the struct path from the listening socket, because it
> > > > may be bound to a path in a different namespace than the caller,
> > > > resulting in a path that cannot be referenced at policy creation time.
> > > >
> > > > Cc: Günther Noack <gnoack3000@gmail.com>
> > > > Cc: Tingmao Wang <m@maowtm.org>
> > > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > > ---
> > > >  include/linux/lsm_hook_defs.h |  5 +++++
> > > >  include/linux/security.h      | 11 +++++++++++
> > > >  net/unix/af_unix.c            | 13 ++++++++++---
> > > >  security/security.c           | 20 ++++++++++++++++++++
> > > >  4 files changed, 46 insertions(+), 3 deletions(-)
> > >
> > > Some really minor nitpicky things (below), but nothing critical.
> > > However, as we discussed, I would like to see the AppArmor folks comment
> > > on the new hook before we merge anything as I know they have an interest
> > > here.
> >
> > John, Georgia, we've been discussing this new hook for a few months now
> > but didn't hear from you yet.  We plan to merge this patch series with
> > the 7.1 merge window (in a few weeks), so before that I'd like to merge
> > it in -next in a few days to get a broader coverage.  I'm pretty sure
> > this hook will work well with AppArmor too, but could you please take
> > look to confirm?
> 
> I probably wasn't as clear as I should have been, my apologies.  The
> major reason I held back my ACK on this patch was that I wanted to
> hear from the AA folks regarding the hook's suitability for their
> needs.  While I don't expect they will have an issue with this hook
> as-is, they have expressed interest in the hook, and I would just
> assume make sure it is okay for everyone before we send it to Linus.
> 
> Since this is a feature addition and not a critical bug fix, I will be
> quite upset if this is sent to Linus without review by the AA
> developers and my ACK.

I definitely understand and that makes sense, but even if it is not a
strict fix, please consider that this feature still fixes an important
gap in practice (e.g. run anything outside a sandbox with the help of
systemd; see cover letter and reported issues [1]).  I don't want to
bypass anyone, but given the importance of this change, I don't want to
postpone it either (except if there is a major issue of course, but I
think the review was pretty good).  That's why we'd like to get some
feedback sooner than later.  While waiting for AA folks feedback, would
you still be OK for me to push it to -next to improve test and review
coverage?

[1] https://lore.kernel.org/all/cover.1767115163.git.m@maowtm.org/

