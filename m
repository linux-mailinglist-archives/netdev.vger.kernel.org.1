Return-Path: <netdev+bounces-166525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DA7A36521
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 19:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D00B3B0944
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 18:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016432690C5;
	Fri, 14 Feb 2025 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="hLjdRIk8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sJD9fa8r"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46BF8635A;
	Fri, 14 Feb 2025 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555984; cv=none; b=TawuGfF9w58Gyq2VsAC5gC+7/bMzaVBgYV0XBe03dHTlKYSnA2GhTf9ke4+qiHCw8rBKPX+XloKA4EIsAHg9bDRgmuskcYxNcF8G42cCMpYzhuoekgYwqXmqXXI9bBQu6WiXOIGblJ6dIqr3b2qI2rWdHRsIKOm4jWwmkQ15vRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555984; c=relaxed/simple;
	bh=DOnSG7k1IKOOoZ/mRj2pv0zIh5TRiXayzbc5Na5k9zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NARQ5mrkPUYIJ50OI0atbi1eOrvnZ2yrrgojbubkk+2FDlEC3g/UnY2FChdXLI0FDrqYMn7UgDeCHyaWiKys8/WDzPfoCvfzx3H9ulKEzXizAO7jZyHSllg1FnE5UugpfkRqwOAGoc7KPGStoCIsthFhfUwG2PcvidLhAOCtq8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=hLjdRIk8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sJD9fa8r; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B17972540143;
	Fri, 14 Feb 2025 12:59:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 14 Feb 2025 12:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1739555981;
	 x=1739642381; bh=U7aXKeY5L+SusQkuMKZbVNZp6+P+8VofpNlRW4Hr6tY=; b=
	hLjdRIk8POslBZBL7LjZ7BJF0nDo6uuaQX/RA9TYq0cQ70+DTzC1lKqzcIMZ2PD1
	Vw4HC8wZ2pRiBfcMbx2KYo8TTiR6gCsD2rbe4crvA5N9g1bkpB56c86fFYXgQeyv
	AX5RCA9MzUHWPOG0RPYGkcJ6hIp5vdlIpyQdVLLp+dbZwNsvBXFenlhUd4kmmFQB
	uhgkRv7fE8hf+EQPTCe2mSSEBiV1MhPRInu9RuHfQTVEIbLg0Au7bwH2SY+xk0YM
	SYKLGVY1FtnsKHex39m+qu6KRYbpslWoW5zQokvUa2jBVBefpp7NWGP/vIV268Xv
	PUMY/kBTwCvXurZbkF72uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739555981; x=
	1739642381; bh=U7aXKeY5L+SusQkuMKZbVNZp6+P+8VofpNlRW4Hr6tY=; b=s
	JD9fa8rU3ay+hiOY0mCm8totB/ex+1+APlrsbCZ2eq0ObkpNEFWdZwWxEuObEZsj
	GbnHE8FhZwubGPmA/uuEl8u1Czpi7FbRJcPM9JxLAhclzfO1gw7Jtf3ilH0257UQ
	GOY6arb1oVAXsi0A6EBPrJ3kR2A7ju0BLsVZwHCBQIgd1rHcHXW+BkOPjyW1rt/q
	Whwvj3RYRpT0cZJ08/tOHHXoH+CBS+spub+0W5blcLhGgP9uZsGbra1SM2xEoc5M
	HdzckySb65bhrg70FKCpqKs4f03tb/NoNPsTwfdGAgkggecskckpw0nVYMwDKPo6
	sGNQsMLkGomdayZicBIfA==
X-ME-Sender: <xms:jISvZ5XUpSWpWlFORvAnOXtUIr-5IwveVt2ZogersW2PFmVPGhp15g>
    <xme:jISvZ5l963vqgGvgsMKyHwziiFlH8hh8AHnP9rLmJ2wfuTpWqBbzJCO108AoVowOn
    7wbUcLMvd3DxtmU73E>
X-ME-Received: <xmr:jISvZ1ZIiMTYz8FDBID_UeD-untihn8lINmRgspzata4KLM8iNSYjr9Z55NsuQOotMwXVWjdcDGVL8TGFRk6U7PFe7iY-GRqrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheppfhikhhlrghsucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsoh
    guvghrlhhunhguodhrvghnvghsrghssehrrghgnhgrthgvtghhrdhsvgeqnecuggftrfgr
    thhtvghrnhepffekgfdukeeghffhjeetvdeitdegteeikeffieduhfegveetjeevtdffvd
    ekffdtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggvrhhluhhnug
    dorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgvpdhnsggprhgtphhtthhopeduvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughimhgrrdhfvggurhgruhesghhmrg
    hilhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthho
    pehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigse
    grrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghn
    ihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepghhrvghgohhrrdhhvghrsghurhhgvg
    hrsegvfidrthhqqdhgrhhouhhprdgtohhm
X-ME-Proxy: <xmx:jISvZ8V8L6eac1oBMs4w9Ju0axo1KTKN1pU1CIi-AFoutqObU8pZMQ>
    <xmx:jISvZzniMPG0qpuF2pjt9I8yhLRAGadZifPZUdvgkdtSP4pn4l2jjw>
    <xmx:jISvZ5ckghhTzcdB0PxIKgtamqFT_2axzozaVrRMN8O6iwwWAcOibg>
    <xmx:jISvZ9HPGnxrPY2Xlcu_NWJP8rKOa-gqf6GH89cNZBP3xKuaS_kjGg>
    <xmx:jYSvZ29mzulf7CQ7uMGKHht5Z-gCFeuY0hPilmJvLGWtEhusZzMgwoba>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 12:59:40 -0500 (EST)
Date: Fri, 14 Feb 2025 18:59:38 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: phy: marvell-88q2xxx: enable
 temperature sensor in mv88q2xxx_config_init
Message-ID: <20250214175938.GE2392035@ragnatech.se>
References: <20250214-marvell-88q2xxx-cleanup-v1-0-71d67c20f308@gmail.com>
 <20250214-marvell-88q2xxx-cleanup-v1-3-71d67c20f308@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214-marvell-88q2xxx-cleanup-v1-3-71d67c20f308@gmail.com>

Hi Dimitir,

Thanks for your work.

On 2025-02-14 17:32:05 +0100, Dimitri Fedrau wrote:
> Temperature sensor gets enabled for 88Q222X devices in
> mv88q222x_config_init. Move enabling to mv88q2xxx_config_init because
> all 88Q2XXX devices support the temperature sensor.

Is this true for mv88q2110 devices too? The current implementation only 
enables it for mv88q222x devices. The private structure is not even 
initialized for mv88q2110, and currently crashes. I have fixed that [1], 
but I'm not sure if that should be extended to also enable temperature 
sensor for mv88q2110?

> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

In either case with [1] for an unrelated fix this is tested on 
mv88q2110.

Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

1.  https://lore.kernel.org/all/20250214174650.2056949-1-niklas.soderlund+renesas@ragnatech.se/

> ---
>  drivers/net/phy/marvell-88q2xxx.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> index 7b0913968bb404df1d271b040e698a4c8c391705..1859db10b3914f54486c7e6132b10b0353fa49e6 100644
> --- a/drivers/net/phy/marvell-88q2xxx.c
> +++ b/drivers/net/phy/marvell-88q2xxx.c
> @@ -513,6 +513,15 @@ static int mv88q2xxx_config_init(struct phy_device *phydev)
>  			return ret;
>  	}
>  
> +	/* Enable temperature sense */
> +	if (priv->enable_temp) {
> +		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
> +				     MDIO_MMD_PCS_MV_TEMP_SENSOR2,
> +				     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -903,18 +912,6 @@ static int mv88q222x_revb1_revb2_config_init(struct phy_device *phydev)
>  
>  static int mv88q222x_config_init(struct phy_device *phydev)
>  {
> -	struct mv88q2xxx_priv *priv = phydev->priv;
> -	int ret;
> -
> -	/* Enable temperature sense */
> -	if (priv->enable_temp) {
> -		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
> -				     MDIO_MMD_PCS_MV_TEMP_SENSOR2,
> -				     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
>  	if (phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] == PHY_ID_88Q2220_REVB0)
>  		return mv88q222x_revb0_config_init(phydev);
>  	else
> 
> -- 
> 2.39.5
> 

-- 
Kind Regards,
Niklas Söderlund

