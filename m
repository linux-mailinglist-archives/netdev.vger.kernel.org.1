Return-Path: <netdev+bounces-268924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP9MG3VnumnnWAIAu9opvQ
	(envelope-from <netdev+bounces-268924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:51:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 069B32B86F1
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA57630094F5
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AE938F25D;
	Wed, 18 Mar 2026 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="g+f6U5iK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B165386459
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773823726; cv=none; b=QxAwYYbEgqAgsm7uUGzcgX9NtcNO1Tr5ym7u59vHQ+r2SJMYwqt9tIstWg9T7wXWEBAFmtlKg7zzvlz5/dwK4PB4XYHE3rJ7q3YZwCREQoYzxASaD0bsyvaZHKP+APAQyy2RJTvtbaNDHdkTF6feSA720gCC0viX86AxavxoqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773823726; c=relaxed/simple;
	bh=UR/nXpuCBspCXE+lzekYX2SJ7tdoA0dohclCQYpSjTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0gHrygllf/iMt64PHGOMa1okMmkgDfNZUXPKbF1nYs4XvbKn/jJPPB1feddfNl0+MattmnbrhmTWK2QDDJwAx4IWUoYj5+Z6fyPYUXB4O4OBxfuPz10x9Ma8lvxQ6Lr7N84VLMp6IXkbH+5Dno6ceD0VdrwkexZs/Ea/ZBuCE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=g+f6U5iK; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fbMtZ07l9z9TM;
	Wed, 18 Mar 2026 09:48:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773823717;
	bh=CcvTuGAfaIcT/ORomhueMOe6/GJ0Q9rLnTjixizSyEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g+f6U5iKoqszKnih54WK93Z1lUPRYsepUOPJW/NbbgLe+3ItPLoo0koenuYZepkcn
	 SskPVZbjz0yj8OykZEWxB2vcq+uis9rxakjxfGePXCSFGrIEbVEWHIL87d2i3pfBzl
	 4t3AxaLMD1ctRzRmaql8oET2P3Ug5bugTO3tDnYc=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fbMtT6BLNz1kh;
	Wed, 18 Mar 2026 09:48:31 +0100 (CET)
Date: Wed, 18 Mar 2026 09:48:26 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 1/9] lsm: Add LSM hook security_unix_find
Message-ID: <20260318.In1aekohyivu@digikod.net>
References: <20260315222150.121952-2-gnoack3000@gmail.com>
 <2697b9f672967b1318630f2ffa21914f@paul-moore.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2697b9f672967b1318630f2ffa21914f@paul-moore.com>
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [-0.89 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.77)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[paul-moore.com,gmail.com,namei.org,hallyn.com,maowtm.org,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,linutronix.de,kernel.org,zeniv.linux.org.uk];
	DKIM_TRACE(0.00)[digikod.net:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[digikod.net];
	TAGGED_FROM(0.00)[bounces-268924-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 069B32B86F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 05:34:57PM -0400, Paul Moore wrote:
> On Mar 15, 2026 =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com> wrote:
> > 
> > Add a LSM hook security_unix_find.
> > 
> > This hook is called to check the path of a named unix socket before a
> > connection is initiated. The peer socket may be inspected as well.
> > 
> > Why existing hooks are unsuitable:
> > 
> > Existing socket hooks, security_unix_stream_connect(),
> > security_unix_may_send(), and security_socket_connect() don't provide
> > TOCTOU-free / namespace independent access to the paths of sockets.
> > 
> > (1) We cannot resolve the path from the struct sockaddr in existing hooks.
> > This requires another path lookup. A change in the path between the
> > two lookups will cause a TOCTOU bug.
> > 
> > (2) We cannot use the struct path from the listening socket, because it
> > may be bound to a path in a different namespace than the caller,
> > resulting in a path that cannot be referenced at policy creation time.
> > 
> > Cc: Günther Noack <gnoack3000@gmail.com>
> > Cc: Tingmao Wang <m@maowtm.org>
> > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > ---
> >  include/linux/lsm_hook_defs.h |  5 +++++
> >  include/linux/security.h      | 11 +++++++++++
> >  net/unix/af_unix.c            | 13 ++++++++++---
> >  security/security.c           | 20 ++++++++++++++++++++
> >  4 files changed, 46 insertions(+), 3 deletions(-)
> 
> Some really minor nitpicky things (below), but nothing critical.
> However, as we discussed, I would like to see the AppArmor folks comment
> on the new hook before we merge anything as I know they have an interest
> here.

John, Georgia, we've been discussing this new hook for a few months now
but didn't hear from you yet.  We plan to merge this patch series with
the 7.1 merge window (in a few weeks), so before that I'd like to merge
it in -next in a few days to get a broader coverage.  I'm pretty sure
this hook will work well with AppArmor too, but could you please take
look to confirm?

