Return-Path: <netdev+bounces-295295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 41/gHimYIWpJJgEAu9opvQ
	(envelope-from <netdev+bounces-295295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:22:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 059B86415F9
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:22:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Agxjkycs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295295-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295295-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 144E930F6086
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C4330ACF6;
	Thu,  4 Jun 2026 15:00:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C51305676;
	Thu,  4 Jun 2026 15:00:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585210; cv=none; b=j4e/9t/ZRMGwKVAEjTATOd4JpLRxPDpeABxG99tXBh27ETNYjdX1WDv+Y6ZmVWMCJbPR2JYfeqhQQBlroDDZcfL1vvgqrOHDU/O0j5p7LGgnwBljbt/ZP1K/IZgQI3jivZhAbV9upXNPjup6biaL3dgddj1Yg3NM7tNNnwUNl1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585210; c=relaxed/simple;
	bh=RE/gTS3gPFSKjAoTr7HHFA1sl61WI4T72/HIlzEGj+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlbgHBMmiH3IVZTyoco2S0FAwTl0ydW6n15pSMFnv4aoGfZc9KI1EKB2EvrOTG5R7TOQegqWj1KzrFYIbqXhS2rd5qPwugMiCYBVPnz8MwcFiJhK0uxxXP6Qcq08qOjBKadBVoIRFxrWLbMQC8Rx3ys9dDj8V7WzpWn0DA2kAtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Agxjkycs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0A21F00893;
	Thu,  4 Jun 2026 15:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780585207;
	bh=naizJbNKOKvlG5/naBBmtjVaCJw02IrRto2ZScNSu/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Agxjkycsemoz6LwkxyQ5dtRrEcZyFw4MlttJx4sD7/ZC66OweTx37s6Yxrb4uG6Bo
	 hN+UlQ9aMZFM1hfVwdbeNI5S4Gqb2jXDyVSlNKr12gf17dC4bSehPbzznNbhzYca71
	 +tanI+t+6SGVARaKisjd71nopyFmyJlar3xireXWsmrsouZ/6yTVHXfe4O00cx1eVM
	 nAGz5hUf54gElKVoeF2Zh/aM9anTRO0Cc4d4bppMP+2FXxikEaUOeCDM6h8QwkGdyl
	 CEeoYb2iigIMoI0kcBBV21QLLY9CFwW9c6Qwb1zdbgAAeXElEhm9D0ZEfgiX1n1wt9
	 6f7H04lfE8cLA==
Date: Thu, 4 Jun 2026 08:00:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, Jose.Abreu@synopsys.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] net: stmmac: L3/L4 filter bug fixes
Message-ID: <20260604080006.5a01ce03@kernel.org>
In-Reply-To: <20260604083350.1701-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260604083350.1701-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
	<20260604083350.1701-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295295-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,altera.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 059B86415F9

On Thu,  4 Jun 2026 01:33:47 -0700
muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> Changes in v2:
> - Split patch 4/4 (ethtool stats) out to net-next per Andrew Lunn's review

Now this posting has 2 cover letters, patchwork latched onto first one
which describes 4 patches, and it's going to wait for patch 4 before
kicking off the CI. Please wait a day and repost again with this fixed
:/

