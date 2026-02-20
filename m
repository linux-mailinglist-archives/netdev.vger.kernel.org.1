Return-Path: <netdev+bounces-259768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFWjJPjMmGmuMgMAu9opvQ
	(envelope-from <netdev+bounces-259768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:07:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A8516AE6B
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A7EF300753E
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773932FF67A;
	Fri, 20 Feb 2026 21:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="fk/H3Xmn"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04027603F
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771621621; cv=pass; b=blI55Zxga2rxbBTLwdoLt4yax0syGvtNCyeCsQHRHcri50BDbsGd68N2Qw2aN4m5PETi4xjTN0DssA/4VwcBocHQHYtzpUn+v0okhi2BMcN+Pih0T+lD6mYywYnbWTgQUlvA4hxcjRDkOEf16hxZ6/JrceYGQmLoe4jK4UkIxLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771621621; c=relaxed/simple;
	bh=952KXAFJSHUBF7Wp3LcevwqNCOxCxVfc2LydUNSnSs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWrY5oWqqeAqKw03KnhaSap8kzNYFK2yRr+Q9yX10wzjpX6F8X+pDzjrT5duA/Xim8eik2x/9RLn+ZjDLqv4GtIry/36Os8W5aq4QhzKu6KgHhkGJnqjC8YVIa/KpyxRDcyopSKt133tS4yqMDT88Vd4I5EPE4bk8l8jIurex38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=fk/H3Xmn; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1771621614; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M5lFz+PxPTuicKgkRwTkYFTTjz6VvjqtngX6p8gQjuhpYv/MAEbRFTrOnNckIkDGTiMOkODBNDG/UXQawvNs0QVQsQM3JUxsrwoIuj3mP4TmERn9Zj4SHOQ0ga+xXiXXiC/amkLwmnIIQ0jUl6y5tM1pHTNMg3jS5zDO2aELG3s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771621614; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2RzDXCdvdte4eTcBgkyxXddX18NQMV7ymX15Qv7HVco=; 
	b=hv2s3AxAauEbHdEdv7iAQxVTY7y9OEl+Lky81atfCtBlekBgZyUYfkg9J9EhH1ZP8fOpg2ZqfwY5kYpFtINlSfgj8nLzu5/PSolbYg6VsNIfponExkYN5hoPUu6sEBmUoPn8vPCyE1PP4jtbjgrxj+ljzSuF0YD4H2PNB277W5k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771621614;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2RzDXCdvdte4eTcBgkyxXddX18NQMV7ymX15Qv7HVco=;
	b=fk/H3XmnN942QO9rRx8uk1VUTnjnepx0pNmG93UxCjKP5p1EVVuPNvzRyGYSgvQv
	RNsTAB1D/FDpgh3AxMOAhXoV8ooUX5f6Hjf7Dj2y8p3ARVfL9KuQuZc3J5FxQV/0x3N
	PtP0wkxs4pkOuN1mJ3+acYZY6Qfn0GS7tqsI1YSrld5jMWtk/OEU8L5zNDHjDR0+5ky
	E7KFiZTD/2vExTW80s7mTg/VUwCYNvq7YDOpiZg4gdExicoT5aBwnefh93ZJYuWGrFy
	UG3b0C+gUWjpOddirwOHx9Mi6roLPmQUnQDu99oYk3pFGpYq1tcWluuGHdJ89FHebsx
	0b/QY9CJ4A==
Received: by mx.zohomail.com with SMTPS id 177162161073768.72922586067318;
	Fri, 20 Feb 2026 13:06:50 -0800 (PST)
Message-ID: <f679687c-49ab-4d06-8d9f-97b0a79c3822@machnikowski.net>
Date: Fri, 20 Feb 2026 22:06:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] netdevsim: Implement basic ptp support
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, kuba@kernel.org
Cc: richardcochran@gmail.com, netdev@vger.kernel.org, milena.olech@intel.com
References: <20260219140530.2148-1-maciek@machnikowski.net>
 <20260219140530.2148-3-maciek@machnikowski.net>
 <willemdebruijn.kernel.1957319fee759@gmail.com>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <willemdebruijn.kernel.1957319fee759@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-259768-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[machnikowski.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,intel.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,machnikowski.net:mid,machnikowski.net:dkim,machnikowski.net:email]
X-Rspamd-Queue-Id: 27A8516AE6B
X-Rspamd-Action: no action



On 20/02/2026 21:08, Willem de Bruijn wrote:
> Maciek Machnikowski wrote:
>> Add support for virtual timestamping inside the netdevsim driver.
>> The implementation uses two attached ptp_mock clocks, reads the timestamps
>> of the ones attached either to the netdevsim or its peer and returns
>> timestamps using standard timestamps APIs.
>>
>> This implementation enables running ptp4l on netdevsim adapters.
>>
>> Co-developed-by: Milena Olech <milena.olech@intel.com>
>> Signed-off-by: Milena Olech <milena.olech@intel.com>
>> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
>> ---
>>  drivers/net/netdevsim/ethtool.c   | 12 +++++
>>  drivers/net/netdevsim/netdev.c    | 90 +++++++++++++++++++++++++++++++
>>  drivers/net/netdevsim/netdevsim.h |  1 +
>>  3 files changed, 103 insertions(+)
>>
>> diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
>> index 36a201533..367c7ca8b 100644
>> --- a/drivers/net/netdevsim/ethtool.c
>> +++ b/drivers/net/netdevsim/ethtool.c
>> @@ -201,6 +201,18 @@ static int nsim_get_ts_info(struct net_device *dev,
>>  	struct netdevsim *ns = netdev_priv(dev);
>>  
>>  	info->phc_index = mock_phc_index(ns->phc);
>> +	if (info->phc_index < 0)
>> +		return 0;
>> +
>> +	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
>> +				SOF_TIMESTAMPING_RX_SOFTWARE |
>> +				SOF_TIMESTAMPING_SOFTWARE |
>> +				SOF_TIMESTAMPING_TX_HARDWARE |
>> +				SOF_TIMESTAMPING_RX_HARDWARE |
>> +				SOF_TIMESTAMPING_RAW_HARDWARE;
> 
> preferred model is to populate the device independent defaults with
> ethtool_op_get_ts_info, then extend where relevant. See for instance
> gve_get_ts_info.

Thanks for pointing that one out - will refactor to use the new way.

>> +
>> +	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
>> +	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | BIT(HWTSTAMP_FILTER_ALL);
>>  
>>  	return 0;
>>  }
>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>> index 6285fbefe..b1161c1ca 100644
>> --- a/drivers/net/netdevsim/netdev.c
>> +++ b/drivers/net/netdevsim/netdev.c
>> @@ -30,6 +30,8 @@
>>  #include <net/rtnetlink.h>
>>  #include <net/udp_tunnel.h>
>>  #include <net/busy_poll.h>
>> +#include <linux/ptp_clock_kernel.h>
>> +#include <linux/timecounter.h>
>>  
>>  #include "netdevsim.h"
>>  
>> @@ -119,12 +121,17 @@ static int nsim_forward_skb(struct net_device *tx_dev,
>>  
>>  static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>  {
>> +	struct skb_shared_hwtstamps shhwtstamps = {};
>>  	struct netdevsim *ns = netdev_priv(dev);
>> +	struct ptp_clock_info *ptp_info;
>> +	struct timespec64 tx_ts, rx_ts;
>> +	struct sk_buff *skb_orig = skb;
>>  	struct skb_ext *psp_ext = NULL;
>>  	struct net_device *peer_dev;
>>  	unsigned int len = skb->len;
>>  	struct netdevsim *peer_ns;
>>  	struct netdev_config *cfg;
>> +	bool gen_tx_tstamp = false;
>>  	struct nsim_rq *rq;
>>  	int rxq;
>>  	int dr;
>> @@ -161,6 +168,27 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>  		skb_linearize(skb);
>>  
>>  	skb_tx_timestamp(skb);
>> +	gen_tx_tstamp = skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP;
>> +	if (gen_tx_tstamp) {
>> +		ptp_info = mock_phc_get_ptp_info(ns->phc);
>> +
>> +		/* Create a copy of tx skb to keep the tx reference */
>> +		skb_orig = skb;
>> +		skb = skb_copy(skb_orig, GFP_ATOMIC);
> 
> This should not be needed
> 
> skb_tstamp_tx itself will cal skg_clone or alloc_skb for the
> notification skb.
> 
> Just queue the tx timestamp before nsim_forward_skb?

This is specific to netdevsim and need to be that way - the original skb
gets forwarded to the peer device in the nsim_forward_sk. If I queue the
tx timestamp before forwarding - the same skb would be freed when the
timestamp is delivered.

> 
>> +		skb_shinfo(skb_orig)->tx_flags |= SKBTX_IN_PROGRESS;
>> +
>> +		/* Timestamp as late as possible */
>> +		if (ptp_info)
>> +			ptp_info->gettime64(ptp_info, &tx_ts);
>> +	}
>> +
>> +	/* Generate Rx tstamp based on the peer clock */
>> +	ptp_info = mock_phc_get_ptp_info(peer_ns->phc);
>> +	if (ptp_info) {
>> +		ptp_info->gettime64(ptp_info, &rx_ts);
>> +		skb_hwtstamps(skb)->hwtstamp = timespec64_to_ktime(rx_ts);
>> +	}
>> +
>>  	if (unlikely(nsim_forward_skb(dev, peer_dev,
>>  				      skb, rq, psp_ext) == NET_RX_DROP))
>>  		goto out_drop_cnt;
>> @@ -168,6 +196,13 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>  	if (!hrtimer_active(&rq->napi_timer))
>>  		hrtimer_start(&rq->napi_timer, us_to_ktime(5), HRTIMER_MODE_REL);
>>  
>> +	/* only timestamp the outbound packet if user requested it */
>> +	if (gen_tx_tstamp) {
>> +		shhwtstamps.hwtstamp = timespec64_to_ktime(tx_ts);
>> +		skb_tstamp_tx(skb_orig, &shhwtstamps);
>> +		dev_kfree_skb_any(skb_orig);
>> +	}
>> +
>>  	rcu_read_unlock();
>>  	dev_dstats_tx_add(dev, len);
>>  	return NETDEV_TX_OK;
>> @@ -182,6 +217,59 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>  	return NETDEV_TX_OK;
>>  }
>>  
>> +static int nsim_set_ts_config(struct net_device *netdev,
>> +			      struct kernel_hwtstamp_config *config,
>> +			      struct netlink_ext_ack *extack)
>> +{
>> +	struct netdevsim *ns = netdev_priv(netdev);
>> +
>> +	if (!ns->phc)
>> +		return -EOPNOTSUPP;
>> +
>> +	switch (config->tx_type) {
>> +	case HWTSTAMP_TX_OFF:
>> +		ns->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
>> +		break;
>> +	case HWTSTAMP_TX_ON:
>> +		ns->tstamp_config.tx_type = HWTSTAMP_TX_ON;
>> +		break;
>> +	default:
>> +		return -ERANGE;
>> +	}
>> +
>> +	switch (config->rx_filter) {
>> +	case HWTSTAMP_FILTER_NONE:
>> +		ns->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
>> +		break;
>> +	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
>> +	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
>> +	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
>> +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
>> +	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
>> +	case HWTSTAMP_FILTER_PTP_V2_SYNC:
>> +	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
>> +	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
>> +	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
>> +	case HWTSTAMP_FILTER_NTP_ALL:
>> +	case HWTSTAMP_FILTER_ALL:
>> +		ns->tstamp_config.rx_filter = HWTSTAMP_FILTER_ALL;
>> +		break;
>> +	default:
>> +		return -ERANGE;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int nsim_get_ts_config(struct net_device *netdev,
>> +			      struct kernel_hwtstamp_config *config)
>> +{
>> +	struct netdevsim *ns = netdev_priv(netdev);
>> +
>> +	*config = ns->tstamp_config;
>> +	return 0;
>> +}
>> +
>>  static void nsim_set_rx_mode(struct net_device *dev)
>>  {
>>  }
>> @@ -660,6 +748,8 @@ static const struct net_device_ops nsim_netdev_ops = {
>>  	.ndo_open		= nsim_open,
>>  	.ndo_stop		= nsim_stop,
>>  	.net_shaper_ops		= &nsim_shaper_ops,
>> +	.ndo_hwtstamp_get	= nsim_get_ts_config,
>> +	.ndo_hwtstamp_set	= nsim_set_ts_config,
>>  };
>>  
>>  static const struct net_device_ops nsim_vf_netdev_ops = {
>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>> index f767fc8a7..6d3e8700c 100644
>> --- a/drivers/net/netdevsim/netdevsim.h
>> +++ b/drivers/net/netdevsim/netdevsim.h
>> @@ -103,6 +103,7 @@ struct netdevsim {
>>  	struct net_device *netdev;
>>  	struct nsim_dev *nsim_dev;
>>  	struct nsim_dev_port *nsim_dev_port;
>> +	struct kernel_hwtstamp_config tstamp_config;
>>  	struct mock_phc *phc;
>>  	struct nsim_rq **rq;
>>  
>> -- 
>> 2.53.0
>>
> 
> 

