Return-Path: <netdev+bounces-256809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +INBC7Wkg2nprQMAu9opvQ
	(envelope-from <netdev+bounces-256809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 20:57:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62781EC4C7
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 20:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 429893008A4A
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 19:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3673A1A49;
	Wed,  4 Feb 2026 19:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="dIvU9Ivg"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD37C267B89
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770235057; cv=none; b=Ewd/sDb5agrERUq9FGzyWICd1KYxME6m/iINgvQBQdbXbTofE2tcH73F7t9p3BYSrA4STNykRcrcChxQ3ES1HiqtOd/aUzV3v5iRWpE3aNBPRtgprBMg1GTB+zh7xXLAb/azJAUohVprzcHBHPMhPPJHD7NIYx+vmlL4HVTQTSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770235057; c=relaxed/simple;
	bh=xlx7imhS8egX26fBI66YJcapLdUQv4lJsXpksytMu7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gU/a/6l9ALFKpDWWdlaq9QK6mYvSoJ9DHA5yD6Dv11vevn0Cp2k97qQXjnbU/t8Ilm+vlA5xHenYGwP2ztU2HEujHZrKzXJReUkSPDAxUbvRll4DzVtdYqPg+Vh6o9Gnk6yedgsoYjk9b2MNrcHJgw5HHoVSSjSwmUc2nvsSQWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=dIvU9Ivg; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=xlx7imhS8egX26fBI66YJcapLdUQv4lJsXpksytMu7E=; b=dIvU9IvgO3p2j6fNWBS7K6IHZu
	SXBMK7cCzcttVrJkGOcvsIiSmsyVXNcr8tiQo8l+3bmQ5dhW+Q6qf6C+C1gK5btrMOVy59fLjJEyt
	9pEbloNKFVhF+TAMbfK9Wv0D1EuIdPJ1kdkOKNb8QhjvmQP0OdeBZ35dAsBAo+NXQyle4KkI5C1cH
	vFRFzfFk2I+z66IlowQ6TnkbNrH+lfdd4EmwlYixiY0oXv3UF26aAGekUlhkmiyfeYxOpwdMsgw2f
	le+XSgzInUdW8BemnIxcQmF97bpj4TkpQxUz9DWkTq2TzCs8F/ZeZpqLY3nEn/krNCtb9j9facFVo
	vCTK22eg==;
Received: from i53875ac7.versanet.de ([83.135.90.199] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vnizy-0070uw-LC; Wed, 04 Feb 2026 20:57:15 +0100
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
 Re: [PATCH net-next 1/6] net: stmmac: rk: introduce flags indicating support
 for RGMII/RMII
Date: Wed, 04 Feb 2026 20:57:13 +0100
Message-ID: <3535226.C4sosBPzcN@diego>
In-Reply-To: <E1vnYxl-00000007hol-3XiH@rmk-PC.armlinux.org.uk>
References:
 <aYMN2gZMfLPKuukG@shell.armlinux.org.uk>
 <E1vnYxl-00000007hol-3XiH@rmk-PC.armlinux.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256809-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sntech.de:email,sntech.de:dkim,armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62781EC4C7
X-Rspamd-Action: no action

Am Mittwoch, 4. Februar 2026, 10:14:17 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Russell King (Oracle):
> Introduce two boolean flags into struct rk_priv_data indicating
> whether RGMII and/or RMII is supported for this instance. Use these
> to configure the supported_interfaces mask for phylink, validate the
> interface mode. Initialise these from equivalent flags in the
> rk_gmac_ops or depending on the presence of the ops->set_to_rgmii and
> ops->set_to_mii methods. Finally, make ops->set_to_* optional.
>=20
> This will allow us to get rid of empty set_to_rmii() methods.
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de> #px30,rk3328,rk3568,rk3588




