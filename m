Return-Path: <netdev+bounces-174821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B58F2A60C7E
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 10:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DA427A5AFE
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 08:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FB61E493;
	Fri, 14 Mar 2025 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="CO+I2Npd"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEED153800;
	Fri, 14 Mar 2025 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942845; cv=none; b=WYH6wu2T88JZtSv9UI5KjRjfngF+jqWheeEamJXQ5b9bRtEn+oJ1pSBQRdOYr9gfzNWhBKmc+tNnc2dNIxTTubmanWvEQuB3BMFC7Zp1MAWHAzUfzZpiYUjrvLCL61fFIe3Loyua//z0MYwIjwf7Kpqxhq48OmgzxRrWwZtA+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942845; c=relaxed/simple;
	bh=Z823sMIBtSmRUwV1I+DT2YaMz3HkGJqwNiwsH3j3zsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RiTIL/eAorWoPN8mubdBB/XfksAuwoz9lvbyteFg+JlJUfVUFXDQXKJz+jFpZSCRO4koI30eF8QskRxmLKJ5/T8HZYuxrT5Yf/I/xCc/6Qbv33XgCQ775wRwC87GMexsuoCkjPf+hLWmhSJufm1udB8127v/ehiPgyQ8JlcIP8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=CO+I2Npd; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2EED42047E;
	Fri, 14 Mar 2025 09:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1741942835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2gYY1JMiXCVrx0k9285ZmdwltYFhtlXfBufrR3acPk=;
	b=CO+I2NpdUQgmILYfKbz+eoe5Qgj08VnR31tmv/odKki2xHwmzY3uVRvvAt0tqNPmrlpzZb
	kuYJhbmXqy+7e33RkCcUQ2CzS/+wp2D9aawJV4vJFFyHXdxXnVj6mUk+gXO5zB4TrgrEjm
	nWLHenSMcjjrtll81Lu5CiOWJ3vMrqBpWysZwh6SUQH11o4pz5KeZXznrq+fHqFBvu52AO
	PVNoc+x2NfE3yLh0iOju/YxMFep9pTIcdEjNjqQOFdaXA8nsA8d5/uMp94mjaxf3gHJAnW
	SIf+JldeMI1eUZuBmZsFm0vdv+QFYhMmp65XSjAGdEqg+6Y5Oq1YOsE4SiJWFg==
Message-ID: <757e9a32-9b35-4818-b41b-09eaac97eb8d@yoseli.org>
Date: Fri, 14 Mar 2025 10:00:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: phy: dp83826: Fix TX data voltage support
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250303-dp83826-fixes-v1-0-6901a04f262d@yoseli.org>
 <20250303-dp83826-fixes-v1-1-6901a04f262d@yoseli.org>
Content-Language: en-US, fr
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <20250303-dp83826-fixes-v1-1-6901a04f262d@yoseli.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtgedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheplfgvrghnqdfoihgthhgvlhcujfgruhhtsghoihhsuceojhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgqeenucggtffrrghtthgvrhhnpeefieetgeehvdeggffgffetheehhfetkeefhefhgeeuheetueffueeikefgffffteenucfkphepudelfedrvdefledrudelvddrjeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelfedrvdefledrudelvddrjeegpdhhvghloheplgduledvrdduieekrddvuddurdehvdgnpdhmrghilhhfrhhomhepjhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgpdhnsggprhgtphhtthhopedutddprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesg
 hhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptggrthgrlhhinhdrphhophgvshgtuheslhgvihgtrgdqghgvohhshihsthgvmhhsrdgtohhm
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi there !

On 3/3/25 6:05 PM, Jean-Michel Hautbois wrote:
> When CONFIG_OF_MDIO is not set, the cfg_dac_minus and cfg_dac_plus are
> not set in dp83826_of_init(). This leads to a bad behavior in
> dp83826_config_init: the phy initialization fails, after
> MII_DP83826_VOD_CFG1 and MII_DP83826_VOD_CFG2 are set.
> 
> Fix it by setting the default value for both variables.
> 
> Fixes: d1d77120bc28 ("net: phy: dp83826: support TX data voltage tuning")
> 
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
>   drivers/net/phy/dp83822.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
> index 6599feca1967d705331d6e354205a2485ea962f2..88c49e8fe13e20e97191cddcd0885a6e075ae326 100644
> --- a/drivers/net/phy/dp83822.c
> +++ b/drivers/net/phy/dp83822.c
> @@ -854,6 +854,10 @@ static int dp83822_of_init(struct phy_device *phydev)
>   
>   static void dp83826_of_init(struct phy_device *phydev)
>   {
> +	struct dp83822_private *dp83822 = phydev->priv;
> +
> +	dp83822->cfg_dac_minus = DP83826_CFG_DAC_MINUS_DEFAULT;
> +	dp83822->cfg_dac_plus = DP83826_CFG_DAC_PLUS_DEFAULT;
>   }
>   #endif /* CONFIG_OF_MDIO */
>   
> 

Gentle ping to know if this patch is ok (patch 2/2 is not) and if so, 
should I repost a v2 maybe ?

Thanks !
JM

