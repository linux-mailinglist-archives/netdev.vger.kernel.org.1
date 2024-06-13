Return-Path: <netdev+bounces-103019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3287A905FC3
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 02:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42DD284211
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 00:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819B26FD3;
	Thu, 13 Jun 2024 00:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sldmAuZn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581EC811;
	Thu, 13 Jun 2024 00:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718238907; cv=none; b=LV9b7KVCEmzrKAC8ZhppKnKwLmIjeiXYRjtA6WispQ7XhlBkoBYH998Yq/nCbe9wr2Z1oiLizwdnXp4TUTGNDtpYMp8RDkE1gNOD9lFiGG4s3wZl5eBk/m2rKpHLYrYH6+243slshl3rsQ9AF96NEDGp2yERNEgiVjmcCJhcoT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718238907; c=relaxed/simple;
	bh=7aFwdpvO8clQ9xKAqhUlOO2UkMwgfchXYP7k1Pjo6Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3y3CI8cn8YWvi8Zemhg5+PNh0ezOS9Ty6iH8NSun07yd8yNzz7sQ5ID3J4EcOiU3GtO+UiE+20Ha3dgh0ec42QOQP2GBcu/LBkcqVlzM8/Gmkh8AFwv/zhep/yLFslJiK3HhSxh/PKbJUygY6dXgCEDFMKX23g00DmP+Iykseg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sldmAuZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1E7C116B1;
	Thu, 13 Jun 2024 00:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718238906;
	bh=7aFwdpvO8clQ9xKAqhUlOO2UkMwgfchXYP7k1Pjo6Vo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sldmAuZnJENedopcvWeRCvrXft2hCUcbTKilyv/5emcLiCG19LtMYKl2vfkT41URe
	 Sp8F3O0p1RmCg86TkEMCXQIQNIZccbuWGV+5X0lYlqJEl1WejrmCRTNFgR8ZUklchq
	 WWwMJKU5GKTSJA+bmQtrqcJamBmCJrs0aGUIDYiD34J9+1tkpSQAQSiV1ENjtb5F6B
	 fFmE/SfBFmXPOkNkxRQQd2ROfKv1cn3Vw2vPyH7vV/bxGa/mpFo19X6p/XyVDt8xMB
	 u0uup4U0Z5j28elLAuterpisNV/dFHo9yZ4jCowIRUjkXnKYzBNAWDsvEWOCOCk4eb
	 0HzIqviYZlVQg==
Date: Wed, 12 Jun 2024 17:35:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
 <jiri@resnulli.us>, <horms@kernel.org>, <rkannoth@marvell.com>,
 <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v20 10/13] rtase: Implement ethtool function
Message-ID: <20240612173505.095c4117@kernel.org>
In-Reply-To: <20240607084321.7254-11-justinlai0215@realtek.com>
References: <20240607084321.7254-1-justinlai0215@realtek.com>
	<20240607084321.7254-11-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Jun 2024 16:43:18 +0800 Justin Lai wrote:
> Implement the ethtool function to support users to obtain network card
> information, including obtaining various device settings, Report whether
> physical link is up, Report pause parameters, Set pause parameters,
> Return a set of strings that describe the requested objects, Get number
> of strings that @get_strings will write, Return extended statistics
> about the device.

You don't implement get_strings any more.

> +static void rtase_get_drvinfo(struct net_device *dev,
> +			      struct ethtool_drvinfo *drvinfo)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +
> +	strscpy(drvinfo->driver, KBUILD_MODNAME, 32);

sizeof(drvinfo->driver) instead of the literal 32?

> +	strscpy(drvinfo->bus_info, pci_name(tp->pdev), 32);

Can you double check that overwriting these fields is actually needed?
I think core will fill this in for you in ethtool_get_drvinfo()

> +	if ((value & (RTASE_FORCE_TXFLOW_EN | RTASE_FORCE_RXFLOW_EN)) ==
> +	    (RTASE_FORCE_TXFLOW_EN | RTASE_FORCE_RXFLOW_EN)) {
> +		pause->rx_pause = 1;
> +		pause->tx_pause = 1;
> +	} else if ((value & RTASE_FORCE_TXFLOW_EN)) {

unnecessary parenthesis

> +		pause->tx_pause = 1;
> +	} else if ((value & RTASE_FORCE_RXFLOW_EN)) {

same here

> +		pause->rx_pause = 1;
> +	}
> +}
> +
> +static int rtase_set_pauseparam(struct net_device *dev,
> +				struct ethtool_pauseparam *pause)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	u16 value = rtase_r16(tp, RTASE_CPLUS_CMD);
> +
> +	if (pause->autoneg)
> +		return -EOPNOTSUPP;
> +
> +	value &= ~(RTASE_FORCE_TXFLOW_EN | RTASE_FORCE_RXFLOW_EN);
> +
> +	if (pause->tx_pause)
> +		value |= RTASE_FORCE_TXFLOW_EN;
> +
> +	if (pause->rx_pause)
> +		value |= RTASE_FORCE_RXFLOW_EN;
> +
> +	rtase_w16(tp, RTASE_CPLUS_CMD, value);
> +	return 0;
> +}
> +
> +static void rtase_get_eth_mac_stats(struct net_device *dev,
> +				    struct ethtool_eth_mac_stats *stats)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	const struct rtase_counters *counters;
> +
> +	counters = tp->tally_vaddr;
> +	if (!counters)

you fail probe if this is NULL, why check if here?

> +		return;
> +
> +	rtase_dump_tally_counter(tp);
> +
> +	stats->FramesTransmittedOK = le64_to_cpu(counters->tx_packets);
> +	stats->SingleCollisionFrames = le32_to_cpu(counters->tx_one_collision);
> +	stats->MultipleCollisionFrames =
> +		le32_to_cpu(counters->tx_multi_collision);
> +	stats->FramesReceivedOK = le64_to_cpu(counters->rx_packets);
> +	stats->FrameCheckSequenceErrors = le32_to_cpu(counters->rx_errors);

You dont report this in rtase_get_stats64() as crc errors, are these
really CRC / FCS errors or other errors?

> +	stats->AlignmentErrors = le16_to_cpu(counters->align_errors);
> +	stats->FramesAbortedDueToXSColls = le16_to_cpu(counters->tx_aborted);
> +	stats->FramesLostDueToIntMACXmitError =
> +		le64_to_cpu(counters->tx_errors);
> +	stats->FramesLostDueToIntMACRcvError =
> +		le16_to_cpu(counters->rx_missed);

Are you sure this is the correct statistic to report as?
What's the definition of rx_missed in the datasheet?

Also is 16 bits enough for a packet counter at 5Gbps?
Don't you have to periodically accumulate this counter so that it
doesn't wrap around?

> +	stats->MulticastFramesReceivedOK = le32_to_cpu(counters->rx_multicast);
> +	stats->BroadcastFramesReceivedOK = le64_to_cpu(counters->rx_broadcast);
> +}
> +
> +static const struct ethtool_ops rtase_ethtool_ops = {
> +	.get_drvinfo = rtase_get_drvinfo,
> +	.get_link = ethtool_op_get_link,
> +	.get_link_ksettings = rtase_get_settings,
> +	.get_pauseparam = rtase_get_pauseparam,
> +	.set_pauseparam = rtase_set_pauseparam,
> +	.get_eth_mac_stats = rtase_get_eth_mac_stats,
> +	.get_ts_info = ethtool_op_get_ts_info,
> +};
> +
>  static void rtase_init_netdev_ops(struct net_device *dev)
>  {
>  	dev->netdev_ops = &rtase_netdev_ops;
> +	dev->ethtool_ops = &rtase_ethtool_ops;
>  }
>  
>  static void rtase_reset_interrupt(struct pci_dev *pdev,


