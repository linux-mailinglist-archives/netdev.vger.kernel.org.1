Return-Path: <netdev+bounces-307454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1FEWB7gzVmpP1QAAu9opvQ
	(envelope-from <netdev+bounces-307454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:03:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E330754D14
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:03:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YJiEyHuF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307454-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307454-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0805F30987EA
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 12:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990CD44E027;
	Tue, 14 Jul 2026 12:58:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE9D448CFF
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:58:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033927; cv=none; b=LvqvGlBxpmCCT9Nd6bmBNQpmanh3ZY+cmbdb41+seVHr2/h7P8RJLIb4HnwKcU44xSRpgIgTMi6CfzSxt/1NdtAFvgNVyUJSz8aw0obpw4JFOsL2ioOvM+aFbeBmrLx2pdGl3VzxsWZMlXTNYSh0wsOrv7zOGSGaGyW1uKc7YaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033927; c=relaxed/simple;
	bh=hv/2p3O30g4J5S1LHHY0tlua7fnp53UkHxgT0cX0pQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zgwtz8/nhOVlSmSvLFYflNgsFYyTF871eP8kIF7fWPA/5ps+1CQcfuFfLLsXcWbaJB7DrGkjRA1qyXStvaizifoY7TNlbDrWzgQxRBO+uKnS6qcgwwzNXwLmWFd8JfIcxlVegG7sK4Ek+lJ4+tRNgFI9p9lc/JPIO672HDuF6vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJiEyHuF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95AD1F00A3E;
	Tue, 14 Jul 2026 12:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784033926;
	bh=3C5Zz7z6jaqU/key9OpG6xocIqZ2SWzEt8FlkruHztk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YJiEyHuFX3ayB9X9FZKk2paX7L3Ticm5iy1rh3VbMN1251z2WYeT1FcFGnZgeZNzt
	 tsdf4+PoD5JBVeZ1ZdbJ8ZdhcZoVA+vJRN9qpnoohp6EodNi3013X1LK2jwUVfuqyL
	 /NIzYj/V8wSidurQ44WPSWNNgq84cgfZVab8oW0Fu/fazw6TzpLSkPnxAZg30fPEQk
	 KnWBDILKLWeeh4VvS3DOo2YbjDJfnUfEwWbCTWLjD5CSmZS76idtcjRVr6WxRl0Uve
	 DCFpHDm9PjcvEHrFEFfCAlqlZq5LTRY2lDvfibd1iP4ecRvgmYmUkYfTgtySDmSgBE
	 h98D+Xr1dataA==
From: Simon Horman <horms@kernel.org>
To: mmc@linux.ibm.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bjking1@linux.ibm.com,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	davemarq@linux.ibm.com
Subject: Re: [PATCH net-next v3 10/15] ibmveth: Enable multi-queue RX receive path
Date: Tue, 14 Jul 2026 13:55:58 +0100
Message-ID: <20260714125557.1837451-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706193603.8039-11-mmc@linux.ibm.com>
References: <20260706193603.8039-11-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:mmc@linux.ibm.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:bjking1@linux.ibm.com,m:haren@linux.ibm.com,m:ricklind@linux.ibm.com,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:davemarq@linux.ibm.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307454-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E330754D14

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ibmveth: Enable multi-queue RX receive path

This is the first patch that sets multi_queue from H_ILLAN_ATTRIBUTES
and switches registration, buffer posting, and receive to the MQ
hcall path. It also raises num_rx_queues and enables per-queue NAPI.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index b3b3886c3eedb..863e5c68b42c7 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -826,15 +841,23 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>   */
>  static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
>  {
> -	__be64 *p = adapter->buffer_list_addr[0] + 4096 - 8;
> +	int i;
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		__be64 *p = adapter->buffer_list_addr[i] + 4096 - 8;
> +		u64 drops = be64_to_cpup(p);
>  
> -	adapter->rx_no_buffer = be64_to_cpup(p);
> +		if (i == 0)
> +			adapter->rx_no_buffer = drops;
> +	}
>  }

[Severity: Medium]
Will this logic silently discard the hardware drop counts for all queues
other than queue 0?

Since ethtool -S reports the global adapter->rx_no_buffer statistic, shouldn't
this loop accumulate the drops across all queues instead of only recording
them when evaluating the first queue?

[ ... ]

> @@ -842,6 +865,8 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
>  				   int queue_index)
>  {
> +	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
> +	unsigned long flags;
>  	int i;
>  
>  	if (queue_index >= adapter->num_rx_queues)
> @@ -842,6 +865,8 @@ static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
>  
>  	adapter->replenish_task_cycles++;
>  
> +	spin_lock_irqsave(&rxq->replenish_lock, flags);
> +

[Severity: Medium]
With multi-queue RX enabled, can multiple NAPI threads execute this task
concurrently for different queues?

If so, does this non-atomic increment of the global replenish_task_cycles
stat risk data corruption, torn reads on 32-bit platforms, or lost updates?

Similarly, in ibmveth_replenish_buffer_pool():

drivers/net/ethernet/ibm/ibmveth.c:ibmveth_replenish_buffer_pool() {
    ...
    buffers_added += filled;
    adapter->replenish_add_buff_success += filled;
    remaining -= filled;
    ...
}

Even though the caller acquires the per-queue rxq->replenish_lock,
replenish_add_buff_success is a global adapter statistic. Does this update
also race with other CPUs holding the locks for their respective queues?

[ ... ]

> @@ -2268,34 +2299,40 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
>  
>  static int ibmveth_poll(struct napi_struct *napi, int budget)
>  {
[ ... ]
>  		} else {
>  			struct sk_buff *skb, *new_skb;
> -			int length = ibmveth_rxq_frame_length(adapter);
> -			int offset = ibmveth_rxq_frame_offset(adapter);
> -			int csum_good = ibmveth_rxq_csum_good(adapter);
> -			int lrg_pkt = ibmveth_rxq_large_packet(adapter);
> +			int length = ibmveth_rxq_frame_length(adapter, queue_index);
> +			int offset = ibmveth_rxq_frame_offset(adapter, queue_index);
> +			int csum_good = ibmveth_rxq_csum_good(adapter, queue_index);
> +			int lrg_pkt = ibmveth_rxq_large_packet(adapter, queue_index);

[Severity: High]
This isn't a bug introduced by this patch, but does this code validate the
length and offset provided by the hardware descriptor before modifying the
SKB bounds?

Later in ibmveth_poll(), these values are used directly:

drivers/net/ethernet/ibm/ibmveth.c:ibmveth_poll() {
    ...
    skb_reserve(skb, offset);
    skb_put(skb, length);
    ...
}

If the hypervisor provides an untrusted or artificially large length, could
the call to skb_put() trigger an skb_over_panic() and crash the guest
kernel?

[ ... ]

Also, I noticed a potential memory leak in the error unwinding path of
ibmveth_open():

drivers/net/ethernet/ibm/ibmveth.c:ibmveth_open() {
    ...
    if (rc) {
        netdev_err(netdev, "failed to set number of rx queues\n");
        goto out_unregister_queues;
    }
    ...
out_free_buffer_pools:
    ibmveth_free_buffer_pools(adapter);
out_unregister_queues:
    ibmveth_dispose_subordinate_irq_mappings(adapter);
    ibmveth_free_all_queues(adapter);
}

[Severity: Medium]
This is a pre-existing issue, but if netif_set_real_num_rx_queues() fails,
the code jumps to the out_unregister_queues label.

Does this bypass out_free_buffer_pools, leaving the RX buffer pools unfreed
and causing a memory leak when cleaning up after a failure?

