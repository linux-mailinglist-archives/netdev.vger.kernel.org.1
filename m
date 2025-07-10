Return-Path: <netdev+bounces-205823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B98B00492
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 16:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C027F18969CE
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92C0273D81;
	Thu, 10 Jul 2025 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j2qS9xeJ"
X-Original-To: netdev@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8A7273D83;
	Thu, 10 Jul 2025 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155854; cv=none; b=nfesfiP9Wdtz3PymWl4ZkMj/eDT1tCqDW4+eE9HrEbflmQkuDhdFebSeJmMd6d/yvQWKlNXHIQIM4fVfRNYAIKvs92BNMekIAr1KqBoR6Z6Wu8NTLMSBjxYcB7KyQh9GQoP0SOmg+wkrL8iPpKxIbOE4XvmZGMRZcKpt6TpUTrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155854; c=relaxed/simple;
	bh=PSx4+X7e8v3zOLpUWL/4DUV2HI8ir0zblZuKSds7eI0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g06xedKzhW7lWNOKQxTyZGUSorHVvTNu6zXbSJkT73i7Hf1rD5ss4/0QjKPOK33ICGFVn2I/lBUR+IVfyjmSpyq7BczY3KI1V4e/Ue2yWHqLMa4SGJ0FSqVgDZPjW6ub7gf42dhbIoFwDGoUwVrpka5ypfJ0Boqjf9jZhqquxsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j2qS9xeJ; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2A894420E;
	Thu, 10 Jul 2025 13:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752155850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jYzEVFbOcoerbFCmVvyyJAUamMUFALPVRRp5Gsv6sE=;
	b=j2qS9xeJic71VzF6loIeefzvK+SsgBXzSaUWkyaoxc65edboSuopMahS/++wwY68gjuHxl
	d8+9D4LFLOK4dARuUiORfyP8olFWVYkoqA20PmRCNHHcBWiKln6fJcrMnoLbSh3adgdbFX
	A7xnHGhIlOTacq6q25F++Z9dVxxr0JLti1BkLUzKz2AR/DdXguBp8f5voPgRaUDnOL4Lei
	gKGRbBB9e4R6EfQfefptHRhRmfRxWL+5fgX0eynX/H3cheSipLRy9+/k5MaZn8qtG/DT+o
	ymSh51YPnPJLKe0kU5/h1N7FQ8MAHtcWKDAdMb3Pz51dGRxr+xyfVP2wdL9d/w==
Date: Thu, 10 Jul 2025 15:57:28 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
Subject: Re: [PATCH net-next 3/3] net: fec: add fec_set_hw_mac_addr() helper
 function
Message-ID: <20250710155728.363bcfd6@fedora>
In-Reply-To: <20250710090902.1171180-4-wei.fang@nxp.com>
References: <20250710090902.1171180-1-wei.fang@nxp.com>
	<20250710090902.1171180-4-wei.fang@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepfigvihdrfhgrnhhgsehngihprdgtohhmpdhrtghpthhtohepshhhvghnfigvihdrfigrnhhgsehngihprdgtohhmpdhrtghpthhtohepgihirghonhhinhhgrdifrghnghesnhigphdrtghomhdprhgtphhtthhop
 egrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm

Hi,

On Thu, 10 Jul 2025 17:09:02 +0800
Wei Fang <wei.fang@nxp.com> wrote:

> In the current driver, the MAC address is set in both fec_restart() and
> fec_set_mac_address(), so a generic helper function fec_set_hw_mac_addr()
> is added to set the hardware MAC address to make the code more compact.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 27 +++++++++++++----------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 00f8be4119ed..883b28e59a3c 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1123,6 +1123,18 @@ static void fec_ctrl_reset(struct fec_enet_private *fep, bool allow_wol)
>  	}
>  }
>  
> +static void fec_set_hw_mac_addr(struct net_device *ndev)
> +{
> +	struct fec_enet_private *fep = netdev_priv(ndev);
> +	u32 temp_mac[2];
> +
> +	memcpy(temp_mac, ndev->dev_addr, ETH_ALEN);
> +	writel((__force u32)cpu_to_be32(temp_mac[0]),
> +	       fep->hwp + FEC_ADDR_LOW);
> +	writel((__force u32)cpu_to_be32(temp_mac[1]),
> +	       fep->hwp + FEC_ADDR_HIGH);
> +}

[ ... ]

> -	writel(ndev->dev_addr[3] | (ndev->dev_addr[2] << 8) |
> -		(ndev->dev_addr[1] << 16) | (ndev->dev_addr[0] << 24),
> -		fep->hwp + FEC_ADDR_LOW);
> -	writel((ndev->dev_addr[5] << 16) | (ndev->dev_addr[4] << 24),
> -		fep->hwp + FEC_ADDR_HIGH);
> +	fec_set_hw_mac_addr(ndev);

It's more of a personal preference, but I find this implementation to
be much more readable than the one based on

  writel((__force u32)cpu_to_be32(temp_mac[...]), ...);

Maxime

