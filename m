Return-Path: <netdev+bounces-256811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAojB2Klg2l3rgMAu9opvQ
	(envelope-from <netdev+bounces-256811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 21:00:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0D5EC504
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 21:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6EC8300B5BC
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 20:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD862E7BDE;
	Wed,  4 Feb 2026 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="S4THZHFt"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9363C23BD02
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770235230; cv=none; b=srfzXvVknHtRId6bT0g2N2bxmt+iP6XIBE9a/n/XTe0MKpRcY4A2dhG1OgV52MHi04th5KqIFuWj+pNwX8zGtPRkIaPZZK/gC+oZ0hyQKW4YdTTxJ4XjIfdVZo0/rRKbNJEm6Zc/Rd6kwKQMl7mKfFcEjGe7dL4nOfBQJNVTu70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770235230; c=relaxed/simple;
	bh=nW+unrerB/cbLtA1UiEQFladZ+My5JzDyBWzNM95keA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBNd6d64MUEUpid+GxBk52MuzPPmcI1SRgyJGOTjvM8ZA/XrxilD3shukaen/6is+1aetKEhxg+pVcEVSNuVfy0vsGVIXKjw6uouPuHyOmjKBrMe3vHIk6L6jQI8wxcfEsVUSSHzOOlR1Sp+zXhM+TwUKp7FrO313z+LAS3ioug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=S4THZHFt; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=nW+unrerB/cbLtA1UiEQFladZ+My5JzDyBWzNM95keA=; b=S4THZHFtHn/WeNSsp5GmKJNsf0
	PQ+Fq2ZQZw1LopvowKkt5kOr6E8H0dCasHBSbNJC/VPXjYa5k0h8GKXBLAq9fAbGFCDpRf0UZDabU
	aZ/iz2gp6/dOWdQ/Fjnl3pYJWfEizqNx1PdMYpJvwQvZnnOmxKQpJcqRI8cx8u4wFglbckWRm1MWG
	UL3B5zNUJxfk/oncWTojuVCE2wePliVAImUZH2usufSG1lnluz/lSpmuiU748wV52rFQSfxxM6t6t
	NVM9/O6k1kfRqSdd05l8WzVr05MEB76snbtaNJVzPDnDs7aWwvHuFAeAFYiDxmYOpWaoJ7Mza9vVt
	ob1myTXQ==;
Received: from i53875ac7.versanet.de ([83.135.90.199] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vnj2y-0070wb-UO; Wed, 04 Feb 2026 21:00:21 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Andrew Lunn <andrew@lunn.ch>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
Subject:
 Re: [PATCH net-next 3/6] net: stmmac: rk: rk3328: gmac2phy only supports RMII
Date: Wed, 04 Feb 2026 21:00:20 +0100
Message-ID: <4037444.q0ZmV6gNhb@diego>
In-Reply-To: <E1vnYxw-00000007hox-0DqH@rmk-PC.armlinux.org.uk>
References:
 <aYMN2gZMfLPKuukG@shell.armlinux.org.uk>
 <E1vnYxw-00000007hox-0DqH@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256811-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[sntech.de:+];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sntech.de:email,sntech.de:dkim,armlinux.org.uk:email]
X-Rspamd-Queue-Id: AB0D5EC504
X-Rspamd-Action: no action

Am Mittwoch, 4. Februar 2026, 10:14:28 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Russell King (Oracle):
> As detailed in a previous commit ("net: stmmac: rk: convert rk3328 to
> use bsp_priv->id") rk3328 gmac2phy only supports RMII, whereas gmac2io
> supports both RMII and RGMII. Clear supports_rgmii for gmac2phy.
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de> #px30,rk3328 gmac2io,rk3568,rk3=
588

Sadly the rk3328-board I have only uses the gmac2io controller.



