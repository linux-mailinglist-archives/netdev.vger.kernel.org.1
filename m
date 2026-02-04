Return-Path: <netdev+bounces-256831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF6+AEjAg2k6uAMAu9opvQ
	(envelope-from <netdev+bounces-256831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 22:55:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA0BECE1D
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 22:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6380300443F
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 21:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B5138B7BF;
	Wed,  4 Feb 2026 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="keup7KAv"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C05037AA89
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770242113; cv=none; b=ejz5175JT8IFfkaHLks3M1D3fykjYpCDwkra3wot9+soOWuIW3+5ThLE7619rQYkIdZD+6y0MyOr5+SMSWLi10JiZwFykLOu+T8H1OX+yvvvIovOtjjkpmqr18mcnCJ/xRboEqC++6ehrvehu/fjR6banhFQba4o/SN49jrRtEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770242113; c=relaxed/simple;
	bh=/XFMh8wOGIk8OtS0B2DBDV74jiHs9qoXDPf51DmnW24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCKQEqbsz1s2G0wtbePsJff4lCVji3cQ3SegInVIPoPXiSbAp34g3eGzUqZtyrgSPEGV2fv9ezdFKL9uEXYlabIkFnlET0L3VWrBwPhu2N9/HBXr2DReCjE8f7IaQP7R5z/SYEQSnIUAE11ivurb2URvDyrRgsWN4adQD4C37oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=keup7KAv; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=/XFMh8wOGIk8OtS0B2DBDV74jiHs9qoXDPf51DmnW24=; b=keup7KAvGA9+FZiipfKpK5e3Cv
	qINYcuYGtC7GaTnJwqtZ3YIlPw+ASc9VtOCmxEB7ZakuoUmdUO/8yzG3IFwQXrx7HZPuh9BAwnp3m
	Q28m1MM0fGiywdmpeQSnFObnheEV7tXnFkX8Dg6Ackta6bhM4z5BO9Ex1BU979Q3DoQ8kGnQN2w1j
	XNQkOpoItp28C463m4Nfeq+gt6doyWgLH6PmMrxTGTomzlJfXabGkd1/f/mGN3RQeBd+UgLqYPI9A
	Ha/8MXWq47pebtcHvu7vc9lKATwjjueR1Fin0Y9ktKSnn+OPYdfmbTiAIlGjFouJKuv16XTGBA/R7
	HAMmwo8Q==;
Received: from i53875ac7.versanet.de ([83.135.90.199] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vnkpv-0071Uq-7Y; Wed, 04 Feb 2026 22:54:59 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Andrew Lunn <andrew@lunn.ch>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 6/6] net: stmmac: rk: rk3506,
 rk3528 and rk3588 have rmii_mode in clock register
Date: Wed, 04 Feb 2026 22:54:58 +0100
Message-ID: <3238497.eGJsNajkDb@diego>
In-Reply-To: <E1vnYyB-00000007hpF-1dwK@rmk-PC.armlinux.org.uk>
References:
 <aYMN2gZMfLPKuukG@shell.armlinux.org.uk>
 <E1vnYyB-00000007hpF-1dwK@rmk-PC.armlinux.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256831-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1EA0BECE1D
X-Rspamd-Action: no action

Am Mittwoch, 4. Februar 2026, 10:14:43 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Russell King (Oracle):
> rk3506, rk3528 and rk3588 have the rmii_mode bit in the clock GRF
> register rather than the gmac GRF register. Provide a mask for this
> field in the clock register, and convert these SoCs to use this.
> Add the necessary code in rk_gmac_powerup() to write this field.
>=20
> This allows us to get rid of these SoCs set_to_rmii() function. As
> such, we need to mark these SoCs as supporting RMII mode.
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de> #px30,rk3328,rk3568,rk3588




