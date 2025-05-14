Return-Path: <netdev+bounces-190370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD1AAB684F
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 12:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D573A5420
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 10:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4023926F46B;
	Wed, 14 May 2025 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iAA3qGji"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60130200B99;
	Wed, 14 May 2025 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747216872; cv=none; b=U1XfEs+DnTt+Xl5f4juKizzDelzsQWuGe3BDBRqPr2SIPrEoamQfdBtzY4I/BP8ASADBP9cNNoyqhp6mas+U1NTIbKsLVAb0gPwhZD3mpMuqm2QVtnlVS+eUZZrIZs609e8u5iUpws1SMJ22ZweQnxuSJbavzS9upTEArhtMj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747216872; c=relaxed/simple;
	bh=xgejKCY26b7QnWUrHBoSnHvtIr2J2lGHRx2kHSUwXUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsiVJs1NcZRAcfWUZzyvCpBpZsE6Svk/wX+kFWh05amszecCQzhHFZUtA49D9OEp1FDhW8C0bU7Aiha/vK50e/hcV4FSdswlnFQP3KX93elWlrp6whznCVdjBE4tHv8WaCdGaKiRb455z0rR1NGRw1rcEZRpXEwITsVnK65pVEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iAA3qGji; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 162C943B0C;
	Wed, 14 May 2025 10:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747216862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0cBmAD5G29UYSNRJHoUJrQxri296/wPmhf/JLxSLT5M=;
	b=iAA3qGji0wSuWTpqIQ9sjB4VDUj0LEd6kzA80IlnQ0WF7FZw04sU/H4cSf+lcOr65wQVod
	uPsDM3sdQ/mSptxPKwjVknLpw9FOOgU6Z1D83Qga9/ddZQ84uwHH9ORGtSDEFm4oEA1phh
	bJot1WHALXUmbhVppXfvCapmt653uj4CTaRSjaXMUAfCttP+k/fdXP3RHMZiOKYMke+80T
	RJvBJ+QQ4+fYOTMZJECfxLfKKg2ubHIPXmbgsoXvPshWum+PVvm2MiaGSR7wonyafeePVd
	KXjsq2maAd5CbUEwxHGKxBQOYsJ0nyyKhT0n6D3OcIro1KQIi27DRyulv47h5A==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Antoine Tenart <atenart@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net-next 3/3] net: phy: dp83869: Support 1000Base-X SFP modules
Date: Wed, 14 May 2025 12:00:54 +0200
Message-ID: <4702428.LvFx2qVVIh@fw-rgant>
In-Reply-To: <3iyvm6curoco35xuyos5llxvnvopvphl5cnndaacg2v5jiu3l7@aaic3jfqhjaz>
References:
 <20250514-dp83869-1000basex-v1-0-1bdb3c9c3d63@bootlin.com>
 <20250514-dp83869-1000basex-v1-3-1bdb3c9c3d63@bootlin.com>
 <3iyvm6curoco35xuyos5llxvnvopvphl5cnndaacg2v5jiu3l7@aaic3jfqhjaz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2419873.ElGaqSPkdT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeiieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhggtgesghdtreertddtjeenucfhrhhomheptfhomhgrihhnucfirghnthhoihhsuceorhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhvdelkeevgfeijedtudeiheefffejhfelgeduuefhleetudeiudektdeiheelgfenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepfhifqdhrghgrnhhtrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheprghtvghnrghrtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegur
 ghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: romain.gantois@bootlin.com

--nextPart2419873.ElGaqSPkdT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Antoine Tenart <atenart@kernel.org>
Date: Wed, 14 May 2025 12:00:54 +0200
Message-ID: <4702428.LvFx2qVVIh@fw-rgant>
MIME-Version: 1.0

On Wednesday, 14 May 2025 11:01:07 CEST Antoine Tenart wrote:
> On Wed, May 14, 2025 at 09:49:59AM +0200, Romain Gantois wrote:
> > +static int dp83869_port_configure_serdes(struct phy_port *port, bool
> > enable, +					 phy_interface_t interface)
> > +{
> > +	struct phy_device *phydev = port_phydev(port);
> > +	struct dp83869_private *dp83869;
> > +	int ret;
> > +
> > +	if (!enable)
> > +		return 0;
> > +
> > +	dp83869 = phydev->priv;
> > +
> > +	switch (interface) {
> > +	case PHY_INTERFACE_MODE_1000BASEX:
> > +		dp83869->mode = DP83869_RGMII_1000_BASE;
> > +		break;
> > +	default:
> > +		phydev_err(phydev, "Incompatible SFP module inserted\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = dp83869_configure_mode(phydev, dp83869);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Update advertisement */
> > +	if (mutex_trylock(&phydev->lock)) {
> > +		ret = dp83869_config_aneg(phydev);
> > +		mutex_unlock(&phydev->lock);
> > +	}
> 
> Just skimmed through this quickly and it's not clear to me why aneg is
> restarted only if there was no contention on the global phydev lock;
> it's not guaranteed a concurrent holder would do the same. If this is
> intended, a comment would be welcomed.

The reasoning here is that there are code paths which call 
dp83869_port_configure_serdes() with phydev->lock already held, for example:

phy_start() -> sfp_upstream_start() -> sfp_start() -> \
	sfp_sm_event() -> __sfp_sm_event() -> sfp_sm_module() -> \ 
	sfp_module_insert() -> phy_sfp_module_insert() -> \
	dp83869_port_configure_serdes()

so taking this lock could result in a deadlock.

mutex_trylock() is definitely not a perfect solution though, but I went with it
partly because the marvell-88x2222 driver already does it this way, and partly 
because if phydev->lock() is held, then there's a solid chance that the phy 
state machine is already taking care of reconfiguring the advertisement. 
However, I'll admit that this is a bit of a shaky argument.

If someone has a better solution in mind, I'll gladly hear it out, but for now 
I guess I'll just add a comment explaining why trylock() is being used.

Thanks!

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart2419873.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEYFZBShRwOvLlRRy+3R9U/FLj284FAmgkadYACgkQ3R9U/FLj
286kbBAAibjDg6Go6aP54fLnt6EVxt/93lm7K4gVHOfRktWGmeIJljLPhlQVFGIM
1WxCumiEiHJ5ArWHAWJglGs30SK0MkQxiaah0Czok1EDSX64KXCMK9EA1R/4UeFJ
Z5IsIOyJiuvF79r6bf93BpLJohubx9ikxrF9BStp+VeNw3MmJHKtDPqTV+rI8KLu
kCCiJWiYrXiUggUbtEToL4y/KNUmW2TXeIX/u/Hrsq2ydVjUHuzEv0Do9s7h7Jmd
jLHHaiy0597ij1z2DUdLLpuuTKEbFkTDcDhFssiOK+3+QPDcdGe/k+KUm4OpxTFp
LbSh2gPAIZSe3WkaOioL0IEAdgM+ZcqdcV5gKlOMCBJi5oEPetmqk6F/bAg6j/qk
b+xz1FLuDO8mhwVRZ6n/X/2Iff7ec8S7NvelAftPLthDQPYNpVu1yxR3EQMSPuTs
YT7pi90XVtIK8kBT/l1SKN7XFOTC3VDefD5fKB5ZyFqwiqmtdvlaYOkU+Mj0/UYg
fTAjGX0soK17EEbyg2jWT34PDDGkk91daTIXSm6aZn8stfRm0iMSpCag65mgQipS
04joVQnSKLTmBdhtFVxttBvd2vlXS6ga5vlomdNO1EYgb00gMPrhx5iXo1KsuBZF
2KO35EHQNRPsq05uXI2mw4jLB7eZ/vLtJKnZpi/NpAA/ZJYp/58=
=fBHx
-----END PGP SIGNATURE-----

--nextPart2419873.ElGaqSPkdT--




