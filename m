Return-Path: <netdev+bounces-269138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM6tMGXaummfcgIAu9opvQ
	(envelope-from <netdev+bounces-269138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:01:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7319C2BFD24
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4DA2300BB82
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAB62D1914;
	Wed, 18 Mar 2026 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XOSgSpBz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51AB2D0C92
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773853142; cv=none; b=BkCxV6IyZ4X8vipDPvrXDaSZ1BYIXQRM1Kwc4Us9C3xK6v/Tls0BAdpBc+fK4wqIyI8GWVabUKRcTbs7zsm2pRbnxP1eq1HC8Py+WchEpT/ATmSW2iHu1O6IfnshW2l/2m9z6/1JnG645pIxOyffiwpyUysbJ6n6XJd6uewQi7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773853142; c=relaxed/simple;
	bh=LQCFyOUUSplp5eShsmV6I/MKXo2fwwMA86XZnghC+IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hADKeoPpsSIKRWI2Raph3rX3FIjfbtMWMsKyGhrVeTQmJ9UXQp+yi6CUi7jxuh063okr4jLDOj9mFvhLbF0+GghGXJ+TeYngx1JQ7fkWppcgq+XJVT9xvX+Yy81jGmU23k85C2CW/84ErDOKlNrALxhsw5BiKSM/a6pG12wwc+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XOSgSpBz; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fbZcD6FnhzdJ7;
	Wed, 18 Mar 2026 17:51:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773852716;
	bh=Xzcs+HBo55vlCaVgM+QV0cRzIBJGQFhXXf13QjKsaAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XOSgSpBz/LzVvF1/5nsaK+hbSMU+A21p7bi30+qhTS7h5u322GZ7i3sahZoIEleYj
	 VW5s0+ERmGELFlgxlxy8X4Z9PHY9al/UriHhWO+8I+VHegPQ97uGhCPXz0aLjC6bVG
	 tds+P12v+ibSico+I2J9Jp89rRKHtHT2fZqbou1U=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fbZcC4Hdrz7GX;
	Wed, 18 Mar 2026 17:51:55 +0100 (CET)
Date: Wed, 18 Mar 2026 17:51:51 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 1/9] lsm: Add LSM hook security_unix_find
Message-ID: <20260318.giez0eib8Ovu@digikod.net>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315222150.121952-2-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [-0.89 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.77)[subject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269138-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[canonical.com,paul-moore.com,namei.org,hallyn.com,maowtm.org,gmail.com,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,linutronix.de,kernel.org,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[22];
	DMARC_NA(0.00)[digikod.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[digikod.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,digikod.net:dkim,digikod.net:mid,maowtm.org:email]
X-Rspamd-Queue-Id: 7319C2BFD24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 11:21:42PM +0100, Günther Noack wrote:
> From: Justin Suess <utilityemal77@gmail.com>
> 
> Add a LSM hook security_unix_find.

Add an LSM hook...

> 
> This hook is called to check the path of a named unix socket before a

UNIX socket

> connection is initiated. The peer socket may be inspected as well.
> 
> Why existing hooks are unsuitable:
> 
> Existing socket hooks, security_unix_stream_connect(),
> security_unix_may_send(), and security_socket_connect() don't provide
> TOCTOU-free / namespace independent access to the paths of sockets.
> 
> (1) We cannot resolve the path from the struct sockaddr in existing hooks.
> This requires another path lookup. A change in the path between the
> two lookups will cause a TOCTOU bug.
> 
> (2) We cannot use the struct path from the listening socket, because it
> may be bound to a path in a different namespace than the caller,
> resulting in a path that cannot be referenced at policy creation time.
> 
> Cc: Günther Noack <gnoack3000@gmail.com>
> Cc: Tingmao Wang <m@maowtm.org>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h |  5 +++++
>  include/linux/security.h      | 11 +++++++++++
>  net/unix/af_unix.c            | 13 ++++++++++---
>  security/security.c           | 20 ++++++++++++++++++++
>  4 files changed, 46 insertions(+), 3 deletions(-)

