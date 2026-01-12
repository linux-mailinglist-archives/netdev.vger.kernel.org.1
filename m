Return-Path: <netdev+bounces-248872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB76D1067A
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 04:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2831E3010D58
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 03:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC0930595C;
	Mon, 12 Jan 2026 03:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TSwCJbMX"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D33AD24;
	Mon, 12 Jan 2026 03:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768186958; cv=none; b=Ocg/g7bD1vwRJcLeIRlNvKuXoTjsAA8ceJUCh60RvcFTiZ07XlqazOnp1Isr/f72RCho1+qp15iiURkrZUh+uWN5wExkO4b6v1MpKTztENxAWONwuDxdWtRQYVi4pCZ4mZrZdVmvKywoOqfHCucLGNu2+tkrICVwcP9vHdUABZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768186958; c=relaxed/simple;
	bh=jQO7GEnIll5202pu5gamjQ1MApsLvGnQE17XkTV4JEc=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XVEf7P0LWmsL0/eZkCc9IwnIKx6cInqj+RuNDkT2VhL2IoaoqRf48wXktopEl7935WGUcalBq8UTfo5/NR1g0Konkt/J2iSbvSEfLJI1Lm1bXV4Ffy7ULVt5bwg54SQkEJH773PDSbS3taLC7JeXwliWvKsudLXEC+UqC0cJP4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TSwCJbMX; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kCxw93XK0JhFoCL3kQX5zBZGDffTgRgWgZ7cHl1itrI=;
	b=TSwCJbMXgncDVMGpWoNOtSWLgggOr0pLlrsri1YftS1ehNZPZPCROTdTNxrqsU0mxaJ6z9AIb
	Yn32/uCzjEhrEVcI0hvgwGPPxMdwkyiYhamoccEDQP0CQIAXjzJ8kwf+m/ugRgbhqslx2Al1c3o
	z3mRkEQVS6VENgNCru+6CpI=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dqHCK6zwjzLlSM;
	Mon, 12 Jan 2026 10:59:09 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 87B9A40562;
	Mon, 12 Jan 2026 11:02:27 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 12 Jan 2026 11:02:26 +0800
Message-ID: <6132864a-ac96-447d-aec7-0db6a109c95d@huawei.com>
Date: Mon, 12 Jan 2026 11:02:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 7/8] net: hns: convert to use .get_rx_ring_count
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
 <20260109-grxring_big_v1-v1-7-a0f77f732006@debian.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260109-grxring_big_v1-v1-7-a0f77f732006@debian.org>
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
>   drivers/net/ethernet/hisilicon/hns/hns_ethtool.c | 16 +++-------------
>   1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
> index 60a586a951a0..23b295dedaef 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
> @@ -1230,21 +1230,11 @@ hns_set_rss(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
>   			    rxfh->indir, rxfh->key, rxfh->hfunc);
>   }
>   
> -static int hns_get_rxnfc(struct net_device *netdev,
> -			 struct ethtool_rxnfc *cmd,
> -			 u32 *rule_locs)
> +static u32 hns_get_rx_ring_count(struct net_device *netdev)
>   {
>   	struct hns_nic_priv *priv = netdev_priv(netdev);
>   
> -	switch (cmd->cmd) {
> -	case ETHTOOL_GRXRINGS:
> -		cmd->data = priv->ae_handle->q_num;
> -		break;
> -	default:
> -		return -EOPNOTSUPP;
> -	}
> -
> -	return 0;
> +	return priv->ae_handle->q_num;
>   }
>   
>   static const struct ethtool_ops hns_ethtool_ops = {
> @@ -1273,7 +1263,7 @@ static const struct ethtool_ops hns_ethtool_ops = {
>   	.get_rxfh_indir_size = hns_get_rss_indir_size,
>   	.get_rxfh = hns_get_rss,
>   	.set_rxfh = hns_set_rss,
> -	.get_rxnfc = hns_get_rxnfc,
> +	.get_rx_ring_count = hns_get_rx_ring_count,
>   	.get_link_ksettings  = hns_nic_get_link_ksettings,
>   	.set_link_ksettings  = hns_nic_set_link_ksettings,
>   };
>

