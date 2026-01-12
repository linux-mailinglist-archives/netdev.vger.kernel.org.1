Return-Path: <netdev+bounces-248873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D5BD1068C
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 04:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D94853017387
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 03:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534E530171A;
	Mon, 12 Jan 2026 03:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="I10BONYd"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400F6AD24;
	Mon, 12 Jan 2026 03:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768186999; cv=none; b=Ll3avlzXCdfPJlozKq7k4ziiH3KIyAj9bnn7xx/IzdX2/f4u3gj3NR5jyPGvlvZHpctjkd/uUVxZA+QE32TJNLsnDZWt9ndgHqRhbWAU3HBsRlt+iTEKGQc23O3PljMtibWIj2AV8jgUzsNQ7K0lJVnpTaOtuGFoa/3J0VQNflc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768186999; c=relaxed/simple;
	bh=JvobYYXswAoBlUMnM8Ef5WTc/ADA0qlAhQ/ZUScXgfE=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uoSzV7rErG6EjejiJsPOePvEikQpIYUDYaqFP51dd9iKgQC/m/mNy0jk+ow9SQiBNVf+geRksk7t31PJrztvixnFXXd3KNRXOAySj1WMFi6eb5uDcQNvG13sLKmWDPUdFgOEDcBqT3rUQbi7OfeKQIpxTjMbagd+mvKChFZN0KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=I10BONYd; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zHw6pbbmTbjxOwuhFSzvpx3bcGOgrAES/Y46asz+2QE=;
	b=I10BONYdJ2+lZeDEurHaPC4EiB9dPm1VfxAYmTVc/A7Mw/hpzjRcW/tNBpIRiRg15B/rQ6ioS
	bGmzvoib/xIXY/OzdhV6ViCfIbsUyAFLui3oYeZ22YiFIT/nfOUY+CWeNWkJKa3hurloUtHv1OO
	SR5g9Ow3jtNRRYu1GsbfVD0=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dqHCd2Pw1z1T4Jw;
	Mon, 12 Jan 2026 10:59:25 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 02AC04056D;
	Mon, 12 Jan 2026 11:03:15 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 12 Jan 2026 11:03:13 +0800
Message-ID: <b65946e8-a8a9-4bc3-92d8-4a67170e531b@huawei.com>
Date: Mon, 12 Jan 2026 11:03:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 8/8] net: hns3: convert to use .get_rx_ring_count
To: Breno Leitao <leitao@debian.org>, Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
	<sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Bharat Bhushan
	<bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Cai Huoqing
	<cai.huoqing@linux.dev>, Christian Benvenuti <benve@cisco.com>, Satish Kharat
	<satishkh@cisco.com>, Dimitris Michailidis <dmichail@fungible.com>, Manish
 Chopra <manishc@marvell.com>, Jian Shen <shenjian15@huawei.com>, Salil Mehta
	<salil.mehta@huawei.com>
References: <20260109-grxring_big_v1-v1-0-a0f77f732006@debian.org>
 <20260109-grxring_big_v1-v1-8-a0f77f732006@debian.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260109-grxring_big_v1-v1-8-a0f77f732006@debian.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2026/1/10 1:40, Breno Leitao wrote:
> Use the newly introduced .get_rx_ring_count ethtool ops callback instead
> of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Thanks,

Reviewed-by: Jijie Shao <shaojijie@huawei.com>

> ---
>   drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> index a5eefa28454c..6d746a9fb687 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> @@ -988,6 +988,13 @@ static int hns3_get_rxfh_fields(struct net_device *netdev,
>   	return -EOPNOTSUPP;
>   }
>   
> +static u32 hns3_get_rx_ring_count(struct net_device *netdev)
> +{
> +	struct hnae3_handle *h = hns3_get_handle(netdev);
> +
> +	return h->kinfo.num_tqps;
> +}
> +
>   static int hns3_get_rxnfc(struct net_device *netdev,
>   			  struct ethtool_rxnfc *cmd,
>   			  u32 *rule_locs)
> @@ -995,9 +1002,6 @@ static int hns3_get_rxnfc(struct net_device *netdev,
>   	struct hnae3_handle *h = hns3_get_handle(netdev);
>   
>   	switch (cmd->cmd) {
> -	case ETHTOOL_GRXRINGS:
> -		cmd->data = h->kinfo.num_tqps;
> -		return 0;
>   	case ETHTOOL_GRXCLSRLCNT:
>   		if (h->ae_algo->ops->get_fd_rule_cnt)
>   			return h->ae_algo->ops->get_fd_rule_cnt(h, cmd);
> @@ -2148,6 +2152,7 @@ static const struct ethtool_ops hns3vf_ethtool_ops = {
>   	.get_sset_count = hns3_get_sset_count,
>   	.get_rxnfc = hns3_get_rxnfc,
>   	.set_rxnfc = hns3_set_rxnfc,
> +	.get_rx_ring_count = hns3_get_rx_ring_count,
>   	.get_rxfh_key_size = hns3_get_rss_key_size,
>   	.get_rxfh_indir_size = hns3_get_rss_indir_size,
>   	.get_rxfh = hns3_get_rss,
> @@ -2187,6 +2192,7 @@ static const struct ethtool_ops hns3_ethtool_ops = {
>   	.get_sset_count = hns3_get_sset_count,
>   	.get_rxnfc = hns3_get_rxnfc,
>   	.set_rxnfc = hns3_set_rxnfc,
> +	.get_rx_ring_count = hns3_get_rx_ring_count,
>   	.get_rxfh_key_size = hns3_get_rss_key_size,
>   	.get_rxfh_indir_size = hns3_get_rss_indir_size,
>   	.get_rxfh = hns3_get_rss,
>

