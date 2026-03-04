Return-Path: <netdev+bounces-263808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FDeBoAoqGkdpAAAu9opvQ
	(envelope-from <netdev+bounces-263808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:41:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D951FFC09
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DB7F30233C9
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 12:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44F3192B75;
	Wed,  4 Mar 2026 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="PyJAML6Z"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB2C18FDBD
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772628091; cv=pass; b=oncL00BYgbrQVEVT7rcVuvT0TWaNk+VkCWSUvIELWQ0wDNJHn8FvijvjmAPIjHUlRlqSP9iX5AyZcsxHLg/XYxj0VjZORz9NqxZbag6Qcat4dFPUsJQYE49lOH+l2wymyaUZH4Ot9sXSWAspZ2wHSiWndbOv4vVCQpP0FFZn5Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772628091; c=relaxed/simple;
	bh=qk2GupJOQAR+hsNg+GUv/QedFQJGOeeIW7PqgczgpK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8DiHMzXnyMLeLr2tg3rNDtQw4RxG8HS0cfc3WejRG9Y+wOUiueg0SQggyv0xXqQ/pqNK11GGLW3XPs3by5/xobScN0Lh1+NZPDzh+2FbnOhyuJrwa4qY2N/AAzdmC9aMteuSa4UQgcc5XtReYj2ch9bpuoHTrAzmfqxgmY+Z6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=PyJAML6Z; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1772628077; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Mv3jZYAOwj2qtZmdm51XJCTCDHROODOaIIOEYqmzax7GHrHpazLtGW8czeHo9ncUsxM24PFDt2ERET0LfCf9LxHnoUwLzHMOngJknnPmWVUHt1UiWzLXNkQ8AMH/4YKa7kWaEa1D65V6iUqqVHQj1c9xY5DE+0HX9mlQoJP9kw0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772628077; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JJ2E5NsmWeupyg71LI3AU+/puD5MlXCeXCog4bGpVeA=; 
	b=EMpABCms4W5a1qYSOSmIAqa0t1Z3Kw8sBxFkePvahFqEMo4LBqEsr6U+eKdiyYkppLPbg+77/YF4JTQVYIjr21gjY9LGsDtXMzKikqlDgzRM813lLwmrRBGCuEBLtA6ebejaT8VfiTcVhVp70AkZyeElDV4UcUkiLH81kPgxmso=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772628077;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=JJ2E5NsmWeupyg71LI3AU+/puD5MlXCeXCog4bGpVeA=;
	b=PyJAML6ZETMwgaYQlGspKxGiKxWSkSs30QcJWo3NExZId/Uqsz1ScBGR8G+Crq/2
	E/WDKQaqM4iKryItyQvSgOypMEXDt/E/eZKfJ/Kp78ZLjRXAbgOaQh/ZVCjPwnq/K3l
	jlhiTyHD2GUxvwOa7vL+pq6JZs12TWwWgqNkVOpobcRYvEXp7qZy5YMA2JDqwOBAFCg
	MuF0BH4nQxyFEerdxCd/dNh5R8PVmsPtqKZLVvQW58w+uOL8b6R+ETXaRkfXmOf31WI
	jktiJDGNSv4iKYLnm16MuG4xs6+A2A9/ovR0RrCcQPfy/3dYa459OyRdT75irf3pB/s
	M2noyLJNOA==
Received: by mx.zohomail.com with SMTPS id 1772628074888705.3410093236516;
	Wed, 4 Mar 2026 04:41:14 -0800 (PST)
Message-ID: <0bc4abf1-97e8-418f-9492-8a3b1006cd01@machnikowski.net>
Date: Wed, 4 Mar 2026 13:41:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 2/3] netdevsim: Implement basic ptp support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, milena.olech@intel.com,
 willemdebruijn.kernel@gmail.com, andrew@lunn.ch, vadim.fedorenko@linux.dev,
 horms@kernel.org
References: <20260225153858.29486-1-maciek@machnikowski.net>
 <20260225153858.29486-3-maciek@machnikowski.net>
 <20260225180150.7eccfb08@kernel.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <20260225180150.7eccfb08@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 82D951FFC09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263808-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[machnikowski.net];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com,lunn.ch,linux.dev,kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 26/02/2026 03:01, Jakub Kicinski wrote:
> On Wed, 25 Feb 2026 16:38:57 +0100 Maciek Machnikowski wrote:
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
> 
> Alphabetical sort please
> 
>>  	struct netdevsim *peer_ns;
>>  	struct netdev_config *cfg;
>> +	bool gen_tx_tstamp = false;
>>  	struct nsim_rq *rq;
> 
> reverse xmas tree
> 
>> +	gen_tx_tstamp = skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP;
>> +	if (gen_tx_tstamp) {
>> +		ptp_info = mock_phc_get_ptp_info(ns->phc);
>> +
>> +		/* Create a copy of tx skb to keep the tx reference */
>> +		skb_orig = skb;
>> +		skb = skb_copy(skb_orig, GFP_ATOMIC);
>> +		skb_shinfo(skb_orig)->tx_flags |= SKBTX_IN_PROGRESS;
>> +
>> +		/* Timestamp as late as possible */
>> +		if (ptp_info)
>> +			ptp_info->gettime64(ptp_info, &tx_ts);
>> +	}
> 
> Do we have to copy the packet? We can't deliver the timestamp before 
> we run Rx, on the original skb?

If we don't we'll get the same timestamps for Rx and Tx side. There's a
single hwtstamps field inside the skb and it's used to deliver tx and rx
tstamp. If I use a single skb I'll get the same tstamp on the
transmitter side and the receiver one.
> 
>>  	if (unlikely(nsim_forward_skb(dev, peer_dev,
>>  				      skb, rq, psp_ext) == NET_RX_DROP))
>>  		goto out_drop_cnt;
> 
> 'Cause I think this leaks skb_orig now.
Will address that (and formatting comments above)
> 
>> +	/* Generate Rx tstamp based on the peer clock */
>> +	ptp_info = mock_phc_get_ptp_info(peer_ns->phc);
>> +	if (ptp_info) {
> 
> we can still gate this on whether timestamps are enabled, no?
Hmmm... that'd need to be gated by the peer's timestamping features -
will check if there's reasonably easy way to add it.
> 
>> +		ptp_info->gettime64(ptp_info, &rx_ts);
>> +		skb_hwtstamps(skb)->hwtstamp = timespec64_to_ktime(rx_ts);
> 


