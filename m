Return-Path: <netdev+bounces-286342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFbiLeK3AGplLwEAu9opvQ
	(envelope-from <netdev+bounces-286342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:52:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F421505387
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E090F300764A
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 16:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A503B27F8;
	Sun, 10 May 2026 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIttxXmA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25D7366066;
	Sun, 10 May 2026 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778431968; cv=none; b=dvuBgamsIqTOUcTIicjj9eazEP/fmE5Iyejw/ulUDTeZGxOndNDW7JHQgfSkZ/pgnqvweOnnExnIFGR1eRtCDtHQgYWi1oBxus/p79nsgu4GDlG76bzUryYMFeYkANKxLhEQpZMIuOykpOAV4ZnCjlzLbd8TBfklVUa85lkSR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778431968; c=relaxed/simple;
	bh=Wt27c8yUp4nBvAgbQgl0CFl+X/lZLklaSUaR5eqjmvs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uw1TMp+3UYMJru8ZOfzAiHQcjkXRtD2uPwi0Cf4nQLgO61yNe099RLyUUF+a1dTLczu+l4t9EDsldrcPscmVxvx2XQ3+FsZH0+bg/xZ07SRYMB2VzPRWRwSQjzGXWcswTx4er3SBHzzkMa4dyaCnHDjEDo1tyFT3os8jhdcEwJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIttxXmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECB1C2BCB8;
	Sun, 10 May 2026 16:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778431967;
	bh=Wt27c8yUp4nBvAgbQgl0CFl+X/lZLklaSUaR5eqjmvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FIttxXmA5kNnMDJMvEg20SClCNuHwC/DVB5d2v18vbh69NMUhI7FikVh+CRwhjTAa
	 U/Nl74e6J9SFTja4yVfJjLiWTx5YYFUUkFrCcKSfifQXDhW6/kA9KcJx9Shy4bi2l+
	 TtV7MmVYKm14+b2mpIY5kr3Wynz/gUqMcvuExikWH33QC4J7g8nBvbRiuaU+51UwfC
	 x254TXt2edbCLEat+WTKaWBQCKgolTAfQyMp0fVQNLqz3STzjCLesRTXKeYb4umXC0
	 CnFaKd6yvq64GepcU0dKosiEzhVpaiQ/k6gke5Z59vauuYOdSSpBkbejHEJxdJHceT
	 ilmra89xu9YXg==
Date: Sun, 10 May 2026 09:52:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?w43DsWlnbw==?= Huguet <ihuguet@riseup.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Sabrina Dubroca
 <sd@queasysnail.net>, Filip Pokryvka <fpokryvk@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] netdevsim: get link via ethtool, set via
 sysfs
Message-ID: <20260510095246.5c8f6d0b@kernel.org>
In-Reply-To: <20260510164337.7611-1-ihuguet@riseup.net>
References: <20260510164337.7611-1-ihuguet@riseup.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2F421505387
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286342-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, 10 May 2026 18:43:32 +0200 =C3=8D=C3=B1igo Huguet wrote:
> Allow to read the carrier status of a netdevsim device via ethtool, like
> most of Ethernet devices allow.
>=20
> Also, allow to set its carrier status via sysfs. Currently it's only
> possible by linking a peer device and setting its admin state to
> UP/DOWN. By editing the carrier status via sysfs tests that need to
> check carrier related stuff may be simpler.
>=20
> The third patch add the proper selftest for both things, and the fourth
> and fifth fix a few small bugs in the selftest itself.

Could you please explain your motivation? Feels quite trivial,
so it's not immediately obvious why we need tests.

