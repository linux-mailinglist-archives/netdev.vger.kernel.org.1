Return-Path: <netdev+bounces-263239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAhrOhjzpmkzawAAu9opvQ
	(envelope-from <netdev+bounces-263239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:41:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0AD1F1AE3
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C90ED302D9F4
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDC747B425;
	Tue,  3 Mar 2026 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gl1K2c9y"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8D743CEC2;
	Tue,  3 Mar 2026 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548871; cv=none; b=hITvSrwSmtOqTVdxTC6JkdHm3AFoGD5tv5CRYN1CseFfknoxYIPyuTij+ErR8qj1RyTGihZLqo/aXRjmp2uZwTa2mNQm/URydKCv+xlJp1JKgGZvX8zNZ7sWM4Vb6HzPcuPcRAonX3BdRqsl5L0hn7z9TkxEmtcpPkmWvgc/+Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548871; c=relaxed/simple;
	bh=XYzYU09pP4RstlqiOmCC/nVdhgqDhNftVL9IxqbOfUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zc++Y0q9u+FJ03Lzq87islU70oGWBnofYBD6blifFYqtCsJe4IMOulGb3S2dwPhooXUwTnLhwR6o1T2ocwAxrNmk19Cq34uExKQFkszDXdAbot2Hzq1kibAZplO1nEoBZDH8E1bNeFE24RaSr/NS4t1mzijMdr0tuDyklfEg2Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gl1K2c9y; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2DBE9C40FAA;
	Tue,  3 Mar 2026 14:41:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4D57E5FF29;
	Tue,  3 Mar 2026 14:41:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5EE1910368F9A;
	Tue,  3 Mar 2026 15:40:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772548864; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=yXt2SpoaKxPoNpgzuP8qVzFuqEXwzGPBFDbnKw95iaM=;
	b=Gl1K2c9ycssSLU6cc553AjoxxKOGp7poJ4J615WL580AvJ3OXQ4VhE2vmyemmwtfGJ0Li/
	tpqRdGY6bX+x1dlVJiZOB42FHemyfZVmFJAVoJ/2Fi5HaMUhsitdOusWU/IaFUd9xE2WYu
	xMasW6DoBLgTW1J11SKHMra4txz3mTp/L7eT30WuhPqRH8o24zwYmSc8LF4ag0pkRC2O5Z
	PG7oNLctXZPPYoT3E08//En9Q7gCw9uV0S66xB4yJ+kya191rhDQCuykXZFYPOoKChesBG
	zaUWvCU1YKdCGZuGoiLHgy4XaFACXBKSclNp0Zd2/OimKEJt5wiqhzVniFJHFw==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net-next 2/2] net: sfp: manage receiver and transmitter regulators
Date: Tue, 03 Mar 2026 15:40:54 +0100
Message-ID: <2344035.iZASKD2KPV@fw-rgant>
In-Reply-To: <e7a1ab5e-c34d-4ca5-93eb-4f5bcfacdb40@sirena.org.uk>
References:
 <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
 <20260303-sfp-regulators-v1-2-7101ae34cb84@bootlin.com>
 <e7a1ab5e-c34d-4ca5-93eb-4f5bcfacdb40@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2033668.PYKUYFuaPT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: CD0AD1F1AE3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263239-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,bootlin.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[romain.gantois@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[18];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

--nextPart2033668.PYKUYFuaPT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Mar 2026 15:40:54 +0100
Message-ID: <2344035.iZASKD2KPV@fw-rgant>
In-Reply-To: <e7a1ab5e-c34d-4ca5-93eb-4f5bcfacdb40@sirena.org.uk>
MIME-Version: 1.0

Hello Mark,

On Tuesday, 3 March 2026 15:22:40 CET Mark Brown wrote:
> On Tue, Mar 03, 2026 at 02:54:27PM +0100, Romain Gantois wrote:
> > If phandles to receiver and/or transmitter regulators for an SFP device
> > are
> > found, enable them at probe time.
> 
> The driver should unconditionally request whatever power the device
> needs.

Ok, I'll use devm_regulator_get_enable() instead then.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart2033668.PYKUYFuaPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmmm8vYACgkQKCYAIARz
eA71lA/+NBtoWMgEmJuWvgHcxU7Mkz3F5XFB3iQ5QA7mq5NPi2w+/4fJtoVxOOpx
LiAlLYYlsaDGZQLQpawdeewaO2VdrkULOtgfNvpLuci7gQJa98mHPG2AGJBnv5ul
FVNlYyQlNcsKDWW2BTpARemzOT1TeSe55LepS7Es9YuDW3aDPQa2b9x7DsCxCKVp
WbSPBRipXbDciiMuaklVi3GH5PIKUaCoaLKDEcVF7W3z690fX997bc2lsq1NV8EN
6wZEcAPI+6JuByJ3Oah2Scjwt1/vIvG8pk6RACfvsd7rYDareolVw1GPLGpcE0EF
nvEwv6gmWzUGBzSr6dsoBwwcPnWmQ0LTouDjochyyARmv0weCAnI/LZ704rYb6ZO
Stwco6UGPufuCwCPvnbCFVlVTBNz+IDUeTNSYWgzfxoEINBg5gtkMsSzBDPLw06K
ZJukAlEmS1ZiTug3GSQ4hnTtiN1IXiD2W1MI3nOxr3RJANqRWPBxEzZplj1zxFMv
q0ocI9pBghwRxJea56cj6UnQVd81GfgVfo534oHBJn1gAvxk8Sp0gjH6MF3kG9vM
m764IBlj6Q6AmQJgHj4kXOB6p9haz7wWA0B3fnRxqgK0HqyTKqBE2WBxf5k3/yxr
7Z+1K+Z9zPXD9CnPemAKXmqaeTWm5MHVO2Ku85L1bjWrXLtPFvw=
=K8Dd
-----END PGP SIGNATURE-----

--nextPart2033668.PYKUYFuaPT--




