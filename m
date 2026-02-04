Return-Path: <netdev+bounces-256812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGWtMKmlg2l3rgMAu9opvQ
	(envelope-from <netdev+bounces-256812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 21:01:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 334A4EC537
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 21:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 684A9300C98A
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 20:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AE830DED1;
	Wed,  4 Feb 2026 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="t1vzuh4B"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AB91F0994
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770235300; cv=none; b=cOnx+SJ2T//jXyCbyoEJ6wCoY4FUytHhVnRDdAfxkakvv4lfYLYFIfqk+J3eePEL6zN9CINP3JD/aPGJGPTqDxm/75LrY+Orry77x53WbmZBz138Fr3gD1PxJOOOXbCtk0Tpet6I2WZOpV9MGjZ0KNJ7qVr02lx/MaIruthgxJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770235300; c=relaxed/simple;
	bh=+tYsQLwGziPHF42RBTTroOYOUEXabptYdKJrp3JzRek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhuVLFBc+yQs7jwsMt5n3lENlAiX6Vr3PcA/MA1QAKpFOoXE70qSBsdxGNyRLjEx96VN3CksoJrRUGzIiqju7/g4aRi6WK5mC1DbZ2ejU0kBlniLjmBEELS10xqxPubtYILpvhEWwSuFlWtef8JKGF4jAlZg5dtaebQR8dRCYI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=t1vzuh4B; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Kd5J4KD+UWilIWXl775s3u3AtyqpuOqe1d0igb4DjAA=; b=t1vzuh4BbUI7J8iR5DF6aPXWu9
	cRtor9rSOEClYtro/eJzqXsDxY1ywe6TGGvU5O9n5Hk8vm+q+BrFZJifHcC55IEY+0ODy+z5hyqM7
	B60pbQ9Jgn2LCQYdppcEiH5llI1QB4NbPb2B/7C/ybfAT3n9xcYKVhdalqfUVQwVM+u+r+Og4qEiN
	xgzswZdFjAsPvvBrJOuSDtLYippmhkiClUgHWbvzT792dOmvEdRaBv46sQbmrhmTTU9vlUra2V3NB
	sTITHHb1Xxb8/C8MbAiIczc+6fMdbJTVM2vikQ1mrertPl2tgRBrIk02sJuydrSBANQQCAjNsqe18
	WQt2CSkQ==;
Received: from i53875ac7.versanet.de ([83.135.90.199] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vnj3v-0070xM-9X; Wed, 04 Feb 2026 21:01:19 +0100
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
 Re: [PATCH net-next 4/6] net: stmmac: rk: rk3528: gmac0 only supports RMII
Date: Wed, 04 Feb 2026 21:01:19 +0100
Message-ID: <3881472.Sgy9Pd6rRy@diego>
In-Reply-To: <E1vnYy1-00000007hp3-0hKm@rmk-PC.armlinux.org.uk>
References:
 <aYMN2gZMfLPKuukG@shell.armlinux.org.uk>
 <E1vnYy1-00000007hp3-0hKm@rmk-PC.armlinux.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256812-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sntech.de:email,sntech.de:dkim,armlinux.org.uk:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.2:email]
X-Rspamd-Queue-Id: 334A4EC537
X-Rspamd-Action: no action

Am Mittwoch, 4. Februar 2026, 10:14:33 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Russell King (Oracle):
> RK3528 gmac0 dtsi contains:
>=20
>                 gmac0: ethernet@ffbd0000 {
>                         phy-handle =3D <&rmii0_phy>;
>                         phy-mode =3D "rmii";
>=20
>                         mdio0: mdio {
>                                 rmii0_phy: ethernet-phy@2 {
>                                         phy-is-integrated;
>                                 };
>                         };
>                 };
>=20
> This follows the same pattern as rk3328, where this gmac instance
> only supports RMII. Disable RGMII in phylink's supported_interfaces
> mask for this gmac instance.
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>





