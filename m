Return-Path: <netdev+bounces-144423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E7D9C70B6
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 14:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A121F279AB
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 13:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5481E0DBB;
	Wed, 13 Nov 2024 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6AnEJ3H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D861E04B3;
	Wed, 13 Nov 2024 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504789; cv=none; b=eALVNi5uWtQfbzWH4NslCmBndhTXLUDpO7MybqbHFH7X9a45ekPg2Qzc2ZjsI3Np40+U0W+HO2EaMoPC8EJ2MMitNy/ARhw8C2Hqol5pqi2cbuXwg34ByLrT+AfSeqcjkQT59xmvBvogVK4VPLqX8BME1+0Er+Q2fJSZbJ3aanI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504789; c=relaxed/simple;
	bh=Lw+7jUWZ437Jrqf60KJhCkbD9qpzU8DyvAxFOcixE60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irhaXkeg1BTjVDN/uq0NlN1KBRxfKrzZgvNj9oJ/XCw1qQbsMDgv87u3W0xo8dJhkc/nBLlHW4YQMjnwgbcQRb3JyLhz/zZzydM52n6KhNnMBP0gJnZdIsJbwsK/ltpHKBQtgFOhyRkhl9tGPRHhgfu8tX6DgfCRXIug2ZY137Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6AnEJ3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFF2C4CECD;
	Wed, 13 Nov 2024 13:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731504787;
	bh=Lw+7jUWZ437Jrqf60KJhCkbD9qpzU8DyvAxFOcixE60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6AnEJ3H2xfABS2BOnlRR89lVBYcfgldJ5uIJ7LAIEKP3TCthwEjyUg+0IerE5xFR
	 aVr7OC3IsRrp/uqeBqOarXoiQC8QDNrvkdxs0tUHRrjzB9NicVrk0fiknpmysaoeWj
	 6kllLm4sRAolRLM8d+b4bAqI67lrI/9akLq4tSTM3IrkwnDT9P/JqOeyy7V+XEk0Uk
	 +XBG0ZqeUVPXqT3x2BM9+WGUhdWJl947LnugQ0lGrh/08wSIQH6a25IWGyMRCK8fp1
	 anTmL89a0vLdiBtiVYPauUtIXR7pL0WlcKwYfh/Abg/qskgi/7G+ZAqGvYnSmvtVHr
	 9uJ+wH6kpQtbQ==
Date: Wed, 13 Nov 2024 13:33:01 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 net-next 3/7] net: hibmcge: Add unicast frame filter
 supported in this module
Message-ID: <20241113133301.GZ4507@kernel.org>
References: <20241111145558.1965325-1-shaojijie@huawei.com>
 <20241111145558.1965325-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111145558.1965325-4-shaojijie@huawei.com>

On Mon, Nov 11, 2024 at 10:55:54PM +0800, Jijie Shao wrote:
> MAC supports filtering unmatched unicast packets according to
> the MAC address table. This patch adds the support for
> unicast frame filtering.
> 
> To support automatic restoration of MAC entries
> after reset, the driver saves a copy of MAC entries in the driver.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

...

> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c

...

>  static int hbg_net_set_mac_address(struct net_device *netdev, void *addr)
>  {
>  	struct hbg_priv *priv = netdev_priv(netdev);
>  	u8 *mac_addr;
> +	bool is_exists;
> +	u32 index;

nit: If you have to respin for some other reason,
     please arrange these local variables in reverse
     xmas tree order - longest line to shortest.

     Also, from an English language PoV, is_exists is a bit tautological.
     Not that it really matters, but maybe addr_exists would work?

>  
>  	mac_addr = ((struct sockaddr *)addr)->sa_data;
>  
>  	if (!is_valid_ether_addr(mac_addr))
>  		return -EADDRNOTAVAIL;
>  
> -	hbg_hw_set_uc_addr(priv, ether_addr_to_u64(mac_addr));
> -	dev_addr_set(netdev, mac_addr);
> +	/* The index of host mac is always 0.
> +	 * If new mac address already exists,
> +	 * delete the existing mac address and
> +	 * add it to the position with index 0.
> +	 */
> +	is_exists = !hbg_get_index_from_mac_table(priv, mac_addr, &index);
> +	hbg_set_mac_to_mac_table(priv, 0, mac_addr);
> +	if (is_exists)
> +		hbg_set_mac_to_mac_table(priv, index, NULL);
>  
> +	dev_addr_set(netdev, mac_addr);
>  	return 0;
>  }
>  

...

