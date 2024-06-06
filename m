Return-Path: <netdev+bounces-101331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7560D8FE26D
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66DF51C213D5
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D2413D25D;
	Thu,  6 Jun 2024 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNFRkMOe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B0913C9AF;
	Thu,  6 Jun 2024 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665588; cv=none; b=k2eANuBla5ykAwliutTaE7Rs93+wxvhe24Bbtndb3PRanuny3DAsFc5m3eS+L8UdDwiQ4lbM8EqO0Ujk1mXTFCNmSOs7BjWIIp9vayXiQmXjwXaVCIPNF5WBTb4i9LXPSOyyDiTKYLztZEqR2SnZzSwgix7J9ywtMZYe2qI9HYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665588; c=relaxed/simple;
	bh=r5aJ1uJ56F46q+VkVNOqlugxkL6Sfo/qAYHjolzmWyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+ZgglQj1tWMi5hTN2YohdZ24omKWfa9ChuTZq86vatOQY9ghAskGoLwbzkJuWNXRPMKPyZ7JpTXQr53O3xtJE92nE2pstNzNPwM8k8ltX+s7RtU3bZta4JuGnM8sMW5GX7MQUQi23TRH1K7tfFU4ReIlSSkgTlKNuSMhXyrlJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNFRkMOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B864AC3277B;
	Thu,  6 Jun 2024 09:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717665587;
	bh=r5aJ1uJ56F46q+VkVNOqlugxkL6Sfo/qAYHjolzmWyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gNFRkMOeyiX6t68BUwKPxemDQrnod3kOamM9s4oq4amR1rBLsgWQGsBGqQ9Ti6t4S
	 S3Y0ZohSuEKo0nC2jXYUK5V4076P8HFJxWdBwqqPbkOHSu8Wpl9lqBxCmmDZWzHH7s
	 DMDgytWiVFq3IqNuyBdhMNR0Zx2Cl4AtZTl9quzFuY61+P1OAbi5LOTSjXtYXG706B
	 RkLaKg5QjCrBP2iwNyzWDsgHT5hnLDpocmOTJ/j62Eq14o7NtKdaoDFvKixIJwIupc
	 3cZejljsWQ/JEZjhg06tAQSorbCnUwQz0QPgdLW/BPFUYi56H5cT+9ITmRfOlJk5Xk
	 52wccGCrHYzaw==
Date: Thu, 6 Jun 2024 10:19:43 +0100
From: Simon Horman <horms@kernel.org>
To: Kamil =?utf-8?B?SG9yw6Fr?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] net: phy: bcm54811: New link mode for BroadR-Reach
Message-ID: <20240606091943.GC791188@kernel.org>
References: <20240604133654.2626813-1-kamilh@axis.com>
 <20240604133654.2626813-2-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240604133654.2626813-2-kamilh@axis.com>

On Tue, Jun 04, 2024 at 03:36:52PM +0200, Kamil Horák - 2N wrote:
> Introduce a new link mode necessary for 10 MBit single-pair
> connection in BroadR-Reach mode on bcm5481x PHY by Broadcom.
> This new link mode, 10baseT1BRR, is known as 1BR10 in the Broadcom
> terminology. Another link mode to be used is 1BR100 and it is already
> present as 100baseT1, because Broadcom's 1BR100 became 100baseT1
> (IEEE 802.3bw).
> 
> Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
> ---
>  drivers/net/phy/phy-core.c   | 1 +
>  include/uapi/linux/ethtool.h | 1 +
>  net/ethtool/common.c         | 3 +++
>  3 files changed, 5 insertions(+)
> 
> diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
> index 15f349e5995a..4a1972e94107 100644
> --- a/drivers/net/phy/phy-core.c
> +++ b/drivers/net/phy/phy-core.c
> @@ -265,6 +265,7 @@ static const struct phy_setting settings[] = {
>  	PHY_SETTING(     10, FULL,     10baseT1S_Full		),
>  	PHY_SETTING(     10, HALF,     10baseT1S_Half		),
>  	PHY_SETTING(     10, HALF,     10baseT1S_P2MP_Half	),
> +	PHY_SETTING(     10, FULL,     10baseT1BRR_Full		),
>  };
>  #undef PHY_SETTING
>  
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index 8733a3117902..76813ca5cb1d 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -1845,6 +1845,7 @@ enum ethtool_link_mode_bit_indices {
>  	ETHTOOL_LINK_MODE_10baseT1S_Full_BIT		 = 99,
>  	ETHTOOL_LINK_MODE_10baseT1S_Half_BIT		 = 100,
>  	ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT	 = 101,
> +	ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT		 = 102,

Hi Kamil,

I will leave a full review to others, but I think that you need to make a
corresponding change to the BUILD_BUG_ON_MSG() towards the top of
phy_speed_to_str().

>  
>  	/* must be last entry */
>  	__ETHTOOL_LINK_MODE_MASK_NBITS

...

