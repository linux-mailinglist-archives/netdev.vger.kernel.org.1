Return-Path: <netdev+bounces-174850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B77A61062
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 12:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576B63B9B51
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 11:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80B31FAC37;
	Fri, 14 Mar 2025 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gOg5Repm"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A4E18CBF2;
	Fri, 14 Mar 2025 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952879; cv=none; b=XOV3g9aNGnvV/QccWEmGexKlFs1p/gpLQiK/GmqW94rVu3d0cqMRsCM8ikOs4HImUfMHJTzCP2+Hj5Mn2v6pXXAB3w9cOCzkIlqhJtW9GTHeAIAXTyI3Ul6+gxUjW32htyyKooZAPkU0/WsCnrCZk1PDMXbgR9erb8urUPev76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952879; c=relaxed/simple;
	bh=mgEzyDx0kJzXlOCfhoMyMCO6ULwoHS1KQrO2S70Es5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOCclsV2LY6ilhD1FGqe5I4851gpnD+kTmQ8W4tfD0Bx/f4VdCU8KRM6p7Q9i9qD8Qnn2O+iIcNppbSuZUYTXS2X8Iem9Gctaz5+ghiqtY9o5HOS6lRT2Qz2f7YDuBQxkuDNPyKIdcVRdBaeqzRNgwiAzI5bbGtp8fq2O+511ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gOg5Repm; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A43344385;
	Fri, 14 Mar 2025 11:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741952869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmqktEn2OYB6PTygxAHkkzldHdqoQw8rh5G64rlD07s=;
	b=gOg5Repm7jx90KdMCTBWK6lmbYhBAT8mWuYdmusXc5O3ReifoYsZzA0k0V3u/vwF17eW9c
	3Pti0uLq7r5E/xlrZ4jQn2ZWR33TKYhrkO/QhWEwrf38IAnzO6fc0JegUO4wyvKEXYAtaf
	fSuFZ9OqEbiZWTBulan+nR3qFzJlEO3MrPbIjNwOzjlStadAAh49wKmNIAw3uE0Kh8ai5B
	iCgo0vd9LBrwiDdHAD69onrjeeUGjG3hAIc4vYSLeyCzmOl9lhPliqjFl1tMpLudSOJ5pL
	jDd2HHszh/r2S4SqOUKMXFPk++jmGUGtGLPK1gA2zokJ/equp0d+vrcixUbs8g==
Date: Fri, 14 Mar 2025 12:47:46 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux
 <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, David Miller
 <davem@davemloft.net>, Xu Liang <lxu@maxlinear.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH net-next 2/4] net: phy: tja11xx: remove call to
 devm_hwmon_sanitize_name
Message-ID: <20250314124746.033a19d3@fedora-2.home>
In-Reply-To: <5bb890a8-6436-4aa9-a5ea-5377c67a1d2d@gmail.com>
References: <198f3cd0-6c39-4783-afe7-95576a4b8539@gmail.com>
	<4452cb7e-1a2f-4213-b49f-9de196be9204@gmail.com>
	<20250314084554.322e790c@fedora-2.home>
	<5bb890a8-6436-4aa9-a5ea-5377c67a1d2d@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdqvddrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdpr
 hgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehlgihusehmrgiglhhinhgvrghrrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

On Fri, 14 Mar 2025 12:26:33 +0100
Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 14.03.2025 08:45, Maxime Chevallier wrote:
> > Hello Heiner,
> > 
> > On Thu, 13 Mar 2025 20:45:06 +0100
> > Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >   
> >> Since c909e68f8127 ("hwmon: (core) Use device name as a fallback in
> >> devm_hwmon_device_register_with_info") we can simply provide NULL
> >> as name argument.
> >>
> >> Note that neither priv->hwmon_name nor priv->hwmon_dev are used
> >> outside tja11xx_hwmon_register.
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >>  drivers/net/phy/nxp-tja11xx.c | 19 +++++--------------
> >>  1 file changed, 5 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
> >> index 601094fe2..07e94a247 100644
> >> --- a/drivers/net/phy/nxp-tja11xx.c
> >> +++ b/drivers/net/phy/nxp-tja11xx.c
> >> @@ -87,8 +87,6 @@
> >>  #define TJA110X_RMII_MODE_REFCLK_IN       BIT(0)
> >>  
> >>  struct tja11xx_priv {
> >> -	char		*hwmon_name;
> >> -	struct device	*hwmon_dev;
> >>  	struct phy_device *phydev;
> >>  	struct work_struct phy_register_work;
> >>  	u32 flags;
> >> @@ -508,19 +506,12 @@ static const struct hwmon_chip_info tja11xx_hwmon_chip_info = {
> >>  static int tja11xx_hwmon_register(struct phy_device *phydev,
> >>  				  struct tja11xx_priv *priv)
> >>  {
> >> -	struct device *dev = &phydev->mdio.dev;
> >> -
> >> -	priv->hwmon_name = devm_hwmon_sanitize_name(dev, dev_name(dev));
> >> -	if (IS_ERR(priv->hwmon_name))
> >> -		return PTR_ERR(priv->hwmon_name);
> >> -
> >> -	priv->hwmon_dev =
> >> -		devm_hwmon_device_register_with_info(dev, priv->hwmon_name,
> >> -						     phydev,
> >> -						     &tja11xx_hwmon_chip_info,
> >> -						     NULL);
> >> +	struct device *hdev, *dev = &phydev->mdio.dev;
> >>  
> >> -	return PTR_ERR_OR_ZERO(priv->hwmon_dev);
> >> +	hdev = devm_hwmon_device_register_with_info(dev, NULL, phydev,
> >> +						    &tja11xx_hwmon_chip_info,
> >> +						    NULL);
> >> +	return PTR_ERR_OR_ZERO(hdev);
> >>  }  
> > 
> > The change look correct to me, however I think you can go one step
> > further and remove the field tja11xx_priv.hwmon_name as well as
> > hwmon_dev.
> >   
> This is part of the patch. Or what do you mean?

Uh you are correct :( meh OK sory for the noise then, morning coffee
didn't go through entirely this morning it seems.

Maxime


