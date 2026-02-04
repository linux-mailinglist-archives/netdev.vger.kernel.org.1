Return-Path: <netdev+bounces-256649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4G4FLkEWg2lnhgMAu9opvQ
	(envelope-from <netdev+bounces-256649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 10:49:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC57E4106
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 10:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88B81310A0BB
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 09:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5513B5318;
	Wed,  4 Feb 2026 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cDoWAubz"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46343B5314
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770198245; cv=none; b=JeKdr7nbmIlSaPxWx1Wp5gahNL4st3oESQEv4Quf4gi5O1mJ3DJZZX0bItIxvQF5JwD1pUF7tE83iq/SplgAtNKEhpLemlcq4suhlY3MFbF80qB8+ZOmdbdgMoxAtaecm0GfyPmHRaOOaY+1UgjqQshWaTlvHnop1dD9U+4ZxSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770198245; c=relaxed/simple;
	bh=7kBvKSVvA2L+trqhOTB6NmYV1rSOliG6jkxgGaZ2aJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvgmje0qmaOxiA21xh0lzObG0/mMqTqhqhQG/TQHo01U6intyeIHw7/UJg3zvdnPG0+WfCqLa7dRuWHCZEly53ICDqZmgbF5g5jjOMVdzjtDoohOcnLWkY1VcDnqRBGBEV1+GH6KC+UoL2ge3Eek7XGQwNvgib050VHtBkVEk+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cDoWAubz; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 114ABC24394;
	Wed,  4 Feb 2026 09:44:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6AEAC60745;
	Wed,  4 Feb 2026 09:44:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7198D119A865B;
	Wed,  4 Feb 2026 10:43:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770198241; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=w9cK/S9VEg5Sj6NGREX0/AmF5Y2Mv59DI4D5BpBMKuI=;
	b=cDoWAubzmtE494ajM22ZR5dtQKaregG2Oz6hx9eWKztWaIPgbqhnYeBOwwuscFqHhvw/dh
	36uj6EFKs4tuJFqlGS6/Pn16v3oKVAb8THaVRY0Nfty8zgxe8nkv5QwaDZhiqtxHBOa5Yb
	ZMLAdc1/6kvqS8b+l2dhyeeyBAPUhHZbPhAds3k0ZNBEQ26HPKucYKDNVi57o585r9KNwv
	/E3G8wS33Iq7VhXOei4h2ZAoCsYCynKF0UR6deJHot1QRtW773kvjs8jo7rctauMUJAmG9
	IKaInstq8V0+ra+sx3Pp/ysxnvJTBtGVCjLd3zjoKuKwME+HWydQolwpmpGK4A==
Message-ID: <bc094312-8671-432a-ac16-1b1a4d052efd@bootlin.com>
Date: Wed, 4 Feb 2026 10:43:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/6] net: stmmac: rk: rk3528: gmac0 only supports
 RMII
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aYMN2gZMfLPKuukG@shell.armlinux.org.uk>
 <E1vnYy1-00000007hp3-0hKm@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vnYy1-00000007hp3-0hKm@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256649-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_PROHIBIT(0.00)[0.0.0.2:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,ffbd0000:email]
X-Rspamd-Queue-Id: 1FC57E4106
X-Rspamd-Action: no action



On 04/02/2026 10:14, Russell King (Oracle) wrote:
> RK3528 gmac0 dtsi contains:
> 
>                 gmac0: ethernet@ffbd0000 {
>                         phy-handle = <&rmii0_phy>;
>                         phy-mode = "rmii";
> 
>                         mdio0: mdio {
>                                 rmii0_phy: ethernet-phy@2 {
>                                         phy-is-integrated;
>                                 };
>                         };
>                 };
> 
> This follows the same pattern as rk3328, where this gmac instance
> only supports RMII. Disable RGMII in phylink's supported_interfaces
> mask for this gmac instance.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime



