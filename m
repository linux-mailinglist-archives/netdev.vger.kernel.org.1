Return-Path: <netdev+bounces-138271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF81C9ACBCD
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39785B22C17
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD591BBBC6;
	Wed, 23 Oct 2024 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xZGDszS0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270201B6CF2;
	Wed, 23 Oct 2024 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692038; cv=none; b=dVIqKfCnsN/cp/I2mgFvNeK9GcMfi/uu1hcHhOxlL8aVls+c3h/+ei78cTaxmjWo/b7iecrWG0eOmnJQQaQd9+a4sCZo6fQT/9F92jZo7blybsQ/fuQgJDHD/90VxcVLxaPR9D09IY6yw0faI1KKc7BvToShAhi7UYimrKswWfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692038; c=relaxed/simple;
	bh=vDu21KttbhxDeYYYeNC4ErQM15g2BQYuwWPsF049BGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnCsKMI1IZ2LgchrgldeJDxEZOR4NDu8JpE4cZz9RTjXeYIgSDKXJZcVccBJ335k16V1CB8sRyI8MlwoPnIO8oFVyAz/PgWNlsLnppPBBTgl12d325NGDcyrBagqR/XAn9yUm/FAiVJ+bs/qI8Fo3c7rAxpug7LJDA7YkA69C7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xZGDszS0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=l/uxCPWZdk38OiWXzdesEV0fnXNio1Jg35V7PQMY1z8=; b=xZGDszS0nQg+O55KK/WAYDWl1o
	SV42buSruM5TZPxI/xeAb3ef/W2NXYQBDeqeH6LnzHquU51DYn00F7QU6nRAPfthb9HzfEnTvdDv9
	t0L70FpQ3/uigCxgrZAIihkbQTs73lisdQClANaob7ry1J/h0jz0wN2N71/tl+igbRHI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3buQ-00AyKh-FJ; Wed, 23 Oct 2024 16:00:22 +0200
Date: Wed, 23 Oct 2024 16:00:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/7] net: hibmcge: Add debugfs supported in this
 module
Message-ID: <924e9c5c-f4a8-4db5-bbe8-964505191849@lunn.ch>
References: <20241023134213.3359092-1-shaojijie@huawei.com>
 <20241023134213.3359092-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023134213.3359092-3-shaojijie@huawei.com>

> +static int hbg_dbg_dev_spec(struct seq_file *s, void *unused)
> +{
> +	struct net_device *netdev = dev_get_drvdata(s->private);
> +	struct hbg_priv *priv = netdev_priv(netdev);
> +	struct hbg_dev_specs *specs;
> +
> +	specs = &priv->dev_specs;
> +	seq_printf(s, "mac id: %u\n", specs->mac_id);
> +	seq_printf(s, "phy addr: %u\n", specs->phy_addr);
> +	seq_printf(s, "mac addr: %pM\n", specs->mac_addr.sa_data);
> +	seq_printf(s, "vlan layers: %u\n", specs->vlan_layers);
> +	seq_printf(s, "max frame len: %u\n", specs->max_frame_len);
> +	seq_printf(s, "min mtu: %u, max mtu: %u\n",
> +		   specs->min_mtu, specs->max_mtu);

I think these are all available via standard APIs. There is no need to
have them in debugfs as well.

> +	seq_printf(s, "mdio frequency: %u\n", specs->mdio_frequency);

Is this interesting? Are you clocking it greater than 2.5MHz?

> +static int hbg_dbg_irq_info(struct seq_file *s, void *unused)
> +{
> +	struct net_device *netdev = dev_get_drvdata(s->private);
> +	struct hbg_priv *priv = netdev_priv(netdev);
> +	struct hbg_irq_info *info;
> +	u32 i;
> +
> +	for (i = 0; i < priv->vectors.info_array_len; i++) {
> +		info = &priv->vectors.info_array[i];
> +		seq_printf(s,
> +			   "%-20s: is enabled: %s, print: %s, count: %llu\n",
> +			   info->name,
> +			   hbg_get_bool_str(hbg_hw_irq_is_enabled(priv,
> +								  info->mask)),
> +			   hbg_get_bool_str(info->need_print),
> +			   info->count);
> +	}

How does this differ from what is available already from the IRQ
subsystem?

> +static int hbg_dbg_nic_state(struct seq_file *s, void *unused)
> +{
> +	struct net_device *netdev = dev_get_drvdata(s->private);
> +	struct hbg_priv *priv = netdev_priv(netdev);
> +
> +	seq_printf(s, "event handling state: %s\n",
> +		   hbg_get_bool_str(test_bit(HBG_NIC_STATE_EVENT_HANDLING,
> +					     &priv->state)));
> +
> +	seq_printf(s, "tx timeout cnt: %llu\n", priv->stats.tx_timeout_cnt);

Don't you have this via ethtool -S ?

> @@ -209,6 +210,10 @@ static int hbg_init(struct hbg_priv *priv)
>  	if (ret)
>  		return ret;
>  
> +	ret = hbg_debugfs_init(priv);
> +	if (ret)
> +		return ret;
> +

There is no need to test the results from debugfs calls.

> +static int __init hbg_module_init(void)
> +{
> +	int ret;
> +
> +	hbg_debugfs_register();
> +	ret = pci_register_driver(&hbg_driver);
> +	if (ret)
> +		hbg_debugfs_unregister();

This seems odd. I would expect that each device has its own debugfs,
there is nothing global.

	Andrew

