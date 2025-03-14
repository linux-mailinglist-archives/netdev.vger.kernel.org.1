Return-Path: <netdev+bounces-174812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2BCA60A48
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 08:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B745C17DA1A
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 07:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BED316D9DF;
	Fri, 14 Mar 2025 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AWhOh1Hx"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DDC14A09A;
	Fri, 14 Mar 2025 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938361; cv=none; b=B7m1hcbbkMp5RZ/2MXMcn0MtkaadB6uBFyCwcg8cTP/jKB901PzS0ZFbE8qFzkyuCzkEwUqfxOa5G4rNhgsKkjDQMcmzUGT0/nlX5fk88XMQJBy8Git5X9xyS1J32EQL8ePEFTuOqWKgRM+l6DFMHFFybikBG/9pLr7MvQIuY4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938361; c=relaxed/simple;
	bh=wrGkeduHJf2FRdetfM7kLNaeu4ZTC4phfwCgw5vRVSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLvYWEphHL18FE/zkvwXtL4xDPmBThb2+2Yf2A020+uiEtZubGOvXtrWfE2pUIqtJLhacrBkN1WzIV43vFYUzPAYpejxPNzpY08pdU+Bjexs/YGs4fW0rvES7IS+/xLHAB5V/jjoDvhXVcoEoVY2a1dX9QVLt624mfNniF3+mTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AWhOh1Hx; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BFA84433EC;
	Fri, 14 Mar 2025 07:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741938357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8yRATkwAJPnxsl83BSKOjShQMMfdWMI6sf8JzOOif9w=;
	b=AWhOh1HxnIUz7vl/wKSKO/qKsxjMwekOryuxHWaNmr8k+wVRXjyKvM/5dQ1GqJgT7uZ7aC
	Ibco3VuXknFeFPcyIbUusAV0K12Uu8sjwMwYZjZ+Clc4g4XX+aFKKC1cl5vn8hYQVkONOH
	an2gEB0MO5AWBXy2xfnwIA3dK7ivyKN9dHlzhk3gHr7oE9U9AoeNommDpjNFPfhdnzYoYQ
	usCccppvwpBzfJvfADfnZPgeQjNEt4utikW3LL+CdH4IjJ43Z8fk7V0dvhksLk445RtYOn
	7Fdf+BhT+YAra1stO/d4XwNzwgNSGj2Ol+XhIqeuCvzDZxnYlpdz87lWAQKV7w==
Date: Fri, 14 Mar 2025 08:45:54 +0100
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
Message-ID: <20250314084554.322e790c@fedora-2.home>
In-Reply-To: <4452cb7e-1a2f-4213-b49f-9de196be9204@gmail.com>
References: <198f3cd0-6c39-4783-afe7-95576a4b8539@gmail.com>
	<4452cb7e-1a2f-4213-b49f-9de196be9204@gmail.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdqvddrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdpr
 hgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehlgihusehmrgiglhhinhgvrghrrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Heiner,

On Thu, 13 Mar 2025 20:45:06 +0100
Heiner Kallweit <hkallweit1@gmail.com> wrote:

> Since c909e68f8127 ("hwmon: (core) Use device name as a fallback in
> devm_hwmon_device_register_with_info") we can simply provide NULL
> as name argument.
> 
> Note that neither priv->hwmon_name nor priv->hwmon_dev are used
> outside tja11xx_hwmon_register.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/nxp-tja11xx.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
> index 601094fe2..07e94a247 100644
> --- a/drivers/net/phy/nxp-tja11xx.c
> +++ b/drivers/net/phy/nxp-tja11xx.c
> @@ -87,8 +87,6 @@
>  #define TJA110X_RMII_MODE_REFCLK_IN       BIT(0)
>  
>  struct tja11xx_priv {
> -	char		*hwmon_name;
> -	struct device	*hwmon_dev;
>  	struct phy_device *phydev;
>  	struct work_struct phy_register_work;
>  	u32 flags;
> @@ -508,19 +506,12 @@ static const struct hwmon_chip_info tja11xx_hwmon_chip_info = {
>  static int tja11xx_hwmon_register(struct phy_device *phydev,
>  				  struct tja11xx_priv *priv)
>  {
> -	struct device *dev = &phydev->mdio.dev;
> -
> -	priv->hwmon_name = devm_hwmon_sanitize_name(dev, dev_name(dev));
> -	if (IS_ERR(priv->hwmon_name))
> -		return PTR_ERR(priv->hwmon_name);
> -
> -	priv->hwmon_dev =
> -		devm_hwmon_device_register_with_info(dev, priv->hwmon_name,
> -						     phydev,
> -						     &tja11xx_hwmon_chip_info,
> -						     NULL);
> +	struct device *hdev, *dev = &phydev->mdio.dev;
>  
> -	return PTR_ERR_OR_ZERO(priv->hwmon_dev);
> +	hdev = devm_hwmon_device_register_with_info(dev, NULL, phydev,
> +						    &tja11xx_hwmon_chip_info,
> +						    NULL);
> +	return PTR_ERR_OR_ZERO(hdev);
>  }

The change look correct to me, however I think you can go one step
further and remove the field tja11xx_priv.hwmon_name as well as
hwmon_dev.

One could argue that we can even remove tja11xx_hwmon_register()
entirely

Thanks,

Maxime

