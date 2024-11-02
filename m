Return-Path: <netdev+bounces-141242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDF99BA2A6
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 23:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 447DBB20C3A
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 22:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A870215C15A;
	Sat,  2 Nov 2024 22:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="QZYnCU4J"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B165015623A;
	Sat,  2 Nov 2024 22:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730584944; cv=none; b=KkscPwDzm3fGFDWqEt/9BggaWpOGnVn9St30Mpp7bPFVi4aRyrLj2B15nux6Yg40w79bF97UBRoH8rzgAJHvNTVKT3fl+3l6NgOd2MUtZV6cAr0fi55vC287ucZ1NfJSizfEpA5jkcqFz/6B06pN+ZPHsFSidlbtQOb6J5MLtes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730584944; c=relaxed/simple;
	bh=AacYCqHUmtJPlYfAF6vJyVaKt/dBGVe7J8JHSf+sl5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGI8K8ewpSoesiezZfMvs5510ZrEDbBfioMYAGIMAN5aGxmY6q5KCdn+c73V7WLUja9LHY2nLczJRAN1kJecnP2HQ2ozxIEbnqXkb648VgX3IWGjgt4ZdkOzc1WrBqQx413+PC9aWExNz1RJ3VFyrthi5oKoGCV3B2hIkFZYXYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=QZYnCU4J; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=wQZbW1x09RjO1+l/c38k6S/bhV/WigJ4yqeRbvCXxog=; b=QZYnCU4JccSm5k1S
	24MZC+Ue+QvW7H0kbPvnlRBkaPc6I+RpYXWQ3fBmtLBDBYhrPldhF+B6jg3xPCJdrna92Omwmjbbh
	3Gf9vtAceyUR4iMCPQWNIHA1wQM4ln6eu2RgIfVRE5E2WXyfsRbCDwvSAlngYFGphygbf5vJMpBXY
	VvI7+0kWPbopE0dyylzZeDNMqXSyQtu6Yl7p907LmTXKcFWY6yySy7pRyvCf/SX1OP1XXm6l4fOIn
	bqJZOqyhjdZeEhYzctgF6fWAcqieCO4fMhiPv+SjFU0ySN9pp2brNjVS7J45JjrigGiiQqfEfOPmf
	bFKyxZOeu5rzHGjB6g==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1t7MCG-00F7vO-1M;
	Sat, 02 Nov 2024 22:02:16 +0000
Date: Sat, 2 Nov 2024 22:02:16 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: shayagr@amazon.com, akiyano@amazon.com, darinzon@amazon.com,
	ndagan@amazon.com, saeedb@amazon.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ena: Remove deadcode
Message-ID: <ZyahaGcE-y3dxZiO@gallifrey>
References: <20241102215907.79931-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241102215907.79931-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 22:01:56 up 178 days,  9:15,  1 user,  load average: 0.02, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> ena_com_get_dev_basic_stats() has been unused since 2017's
> commit d81db2405613 ("net/ena: refactor ena_get_stats64 to be atomic
> context safe")
> 
> ena_com_get_offload_settings() has been unused since the original
> commit of ENA back in 2016 in
> commit 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic
> Network Adapters (ENA)")
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Oops, resending with the net-next prefix on.

Dave

> ---
>  drivers/net/ethernet/amazon/ena/ena_com.c | 33 -----------------------
>  drivers/net/ethernet/amazon/ena/ena_com.h | 18 -------------
>  2 files changed, 51 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
> index d958cda9e58b..bc23b8fa7a37 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_com.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_com.c
> @@ -2198,21 +2198,6 @@ int ena_com_get_ena_srd_info(struct ena_com_dev *ena_dev,
>  	return ret;
>  }
>  
> -int ena_com_get_dev_basic_stats(struct ena_com_dev *ena_dev,
> -				struct ena_admin_basic_stats *stats)
> -{
> -	struct ena_com_stats_ctx ctx;
> -	int ret;
> -
> -	memset(&ctx, 0x0, sizeof(ctx));
> -	ret = ena_get_dev_stats(ena_dev, &ctx, ENA_ADMIN_GET_STATS_TYPE_BASIC);
> -	if (likely(ret == 0))
> -		memcpy(stats, &ctx.get_resp.u.basic_stats,
> -		       sizeof(ctx.get_resp.u.basic_stats));
> -
> -	return ret;
> -}
> -
>  int ena_com_get_customer_metrics(struct ena_com_dev *ena_dev, char *buffer, u32 len)
>  {
>  	struct ena_admin_aq_get_stats_cmd *get_cmd;
> @@ -2289,24 +2274,6 @@ int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu)
>  	return ret;
>  }
>  
> -int ena_com_get_offload_settings(struct ena_com_dev *ena_dev,
> -				 struct ena_admin_feature_offload_desc *offload)
> -{
> -	int ret;
> -	struct ena_admin_get_feat_resp resp;
> -
> -	ret = ena_com_get_feature(ena_dev, &resp,
> -				  ENA_ADMIN_STATELESS_OFFLOAD_CONFIG, 0);
> -	if (unlikely(ret)) {
> -		netdev_err(ena_dev->net_device, "Failed to get offload capabilities %d\n", ret);
> -		return ret;
> -	}
> -
> -	memcpy(offload, &resp.u.offload, sizeof(resp.u.offload));
> -
> -	return 0;
> -}
> -
>  int ena_com_set_hash_function(struct ena_com_dev *ena_dev)
>  {
>  	struct ena_com_admin_queue *admin_queue = &ena_dev->admin_queue;
> diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h b/drivers/net/ethernet/amazon/ena/ena_com.h
> index a372c5e768a7..20e1529adf3b 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_com.h
> +++ b/drivers/net/ethernet/amazon/ena/ena_com.h
> @@ -591,15 +591,6 @@ int ena_com_set_aenq_config(struct ena_com_dev *ena_dev, u32 groups_flag);
>  int ena_com_get_dev_attr_feat(struct ena_com_dev *ena_dev,
>  			      struct ena_com_dev_get_features_ctx *get_feat_ctx);
>  
> -/* ena_com_get_dev_basic_stats - Get device basic statistics
> - * @ena_dev: ENA communication layer struct
> - * @stats: stats return value
> - *
> - * @return: 0 on Success and negative value otherwise.
> - */
> -int ena_com_get_dev_basic_stats(struct ena_com_dev *ena_dev,
> -				struct ena_admin_basic_stats *stats);
> -
>  /* ena_com_get_eni_stats - Get extended network interface statistics
>   * @ena_dev: ENA communication layer struct
>   * @stats: stats return value
> @@ -635,15 +626,6 @@ int ena_com_get_customer_metrics(struct ena_com_dev *ena_dev, char *buffer, u32
>   */
>  int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu);
>  
> -/* ena_com_get_offload_settings - Retrieve the device offloads capabilities
> - * @ena_dev: ENA communication layer struct
> - * @offlad: offload return value
> - *
> - * @return: 0 on Success and negative value otherwise.
> - */
> -int ena_com_get_offload_settings(struct ena_com_dev *ena_dev,
> -				 struct ena_admin_feature_offload_desc *offload);
> -
>  /* ena_com_rss_init - Init RSS
>   * @ena_dev: ENA communication layer struct
>   * @log_size: indirection log size
> -- 
> 2.47.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

