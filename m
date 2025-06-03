Return-Path: <netdev+bounces-194721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5735ACC223
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5942D189141F
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 08:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56997281505;
	Tue,  3 Jun 2025 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="luMmEvSE"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA0E281366;
	Tue,  3 Jun 2025 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748939116; cv=none; b=esrvxSJt8H/zJsvCq9W6StjMhH1BwN/+31MXkX+rjcY1XzAblzeigE0DfTB9ExkF8Aqxcgafz7ZA67NRa0oFTgI0OCSlJtn3Roh5isAKSSHrRggEYEGIKCK4OmEWAmuyeCIukY+f7R7r62/TC3G9EwZb9JqoSpiHKAVP+o895Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748939116; c=relaxed/simple;
	bh=mD8VjPyoqaKuC3clq+RCUo799yyJLx4+YF9RhTuOFfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9lIEdlNmG+NdYJ7CcSs9ccyvUVpw/hll7m5a33tyGdDtqrk95mOD4jsC6YYcSbCwiAozKxGQZK6rXZSLf6XxDiAtD0lVSJ7jRarakglnlc+18iGigFRRJBAA9WwfdTp8yGZuq80q+k+DkNerTUCDcmmHo6WorJDton4qAXj7Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=luMmEvSE; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 61365433B3;
	Tue,  3 Jun 2025 08:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748939105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvE4v/teYoqJosrINMVYN/Bfwi93R1//+VcwLW4T2aA=;
	b=luMmEvSELhi+UGbOmANXiklV4WPpfGbOrZbRWqzWnZv+ryVBfow1+xQYqC6QJdzuIfoXBs
	WhezUoubrT4Lo4HBiIPjCeGNoqduE1CPbf754Q5wTOUHlA79IXwUse72QP+ZPPDTiMnhrn
	pU7fgs19FqlmZHR9r+SbCjvV19CsRHUI7uGv8lR29U4Or5MviFIwoa1vyazotv8tHXctek
	lDt++/HXaGT5QZb44G+6XnnE8nlTErnVt+O1hJ4YeTJoSXsOufjeL+PgXICht4F306sgvu
	0ZSIwvWWkYqCDbea2TeGwBhCtrtS1eVS6phEZdBh2TAL5HtvNZnuZLxE3RnNYA==
Date: Tue, 3 Jun 2025 10:25:00 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <thomas.petazzoni@bootlin.com>,
 <linux-arm-kernel@lists.infradead.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, "shenjian15@huawei.com"
 <shenjian15@huawei.com>
Subject: Re: [PATCH net-next v5 07/13] net: phy: phy_caps: Allow looking-up
 link caps based on speed and duplex
Message-ID: <20250603102500.4ec743cf@fedora>
In-Reply-To: <5bbf1201-e803-40ea-a081-c25919f5e89d@huawei.com>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
	<20250307173611.129125-8-maxime.chevallier@bootlin.com>
	<5bbf1201-e803-40ea-a081-c25919f5e89d@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdegtddtheculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeuhfefgffgtdfhgffhvdfhhffhteeutdektefghfetveehheejjefgudeiudehudenucfkphepvdduvddruddthedrudehtddrvdehvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvuddvrddutdehrdduhedtrddvhedvpdhhvghlohepfhgvughorhgrpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepshhhrghojhhijhhivgeshhhurgifvghirdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrt
 ghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello again,

On Thu, 29 May 2025 17:36:11 +0800
Jijie Shao <shaojijie@huawei.com> wrote:

>
>=20
> Hi Maxime,  fc81e257d19f ("net: phy: phy_caps: Allow looking-up link caps=
 based on speed and duplex") might have different behavior than the modific=
ation.
> My case is set 10M Half with disable autoneg both sides and I expect it is
> link in 10M Half. But now, it is link in 10M Full=EF=BC=8Cwhich is not wh=
at I
> expect.
>=20
> I used followed command and trace how phy worked.
> 	ethtool -s eth1 autoneg off speed 10 duplex half
> The log is showed as followed:
> ethtool-13127	[067]	6164.771853: phy_ethtool_ksettings set: (phy_ethtool =
ksettings set+0x0/0x200) duplex=3D0 speed=3D10
> kworker/u322:2-11096	[070]	6164.771853:	_phy_start_aneq: ( _phy_start_ane=
g+0x0/0xb8) duplex=3D0 speed=3D10
> kworker/u322:2-11096	[070]	6164.771854:	phy_caps_lookup: (phy_caps_lookup=
+0x0/0xf0) duplex=3D0 speed=3D10
> kworker/u322:2-11096	[070]	6164.771855:	phy_config_aneg: (phy_config_aneg=
+0x0/0x70) duplex=3D1 speed=3D10
> kworker/u322:2-11096	[070]	6164.771856:	genphy_config_aneg:	(__genphy_con=
fig_aneg+0X0/0X270) duplex=3D1 speed=3D10

I managed to get a bit of time to look into this, and indeed I was able
to reproduce the issue locally.

I'll send a patch ASAP, based on the the prototype patch I gave in the
previous reply.

Thanks for reporting,

Maxime

