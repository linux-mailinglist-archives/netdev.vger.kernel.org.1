Return-Path: <netdev+bounces-307465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hesjFzw2Vmob1gAAu9opvQ
	(envelope-from <netdev+bounces-307465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:14:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC17754F20
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:14:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XwyYkiEo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307465-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307465-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3967B32BEB6E
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD1D47CC8B;
	Tue, 14 Jul 2026 13:06:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCE0478E53
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 13:06:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034388; cv=none; b=eOJbpurtp/Yrf8upNYckSO3eazPIxc1REh7VYofGO5lXG9DSkqedyNPzkRFf4JK6qP17VbetqBne+mXmBNfAu5Lt8M9hQfWF1dLkbje/zum1MxhfdLPhzCYXHNLML3uiY4nBOnjWgZ2cPXXcojiZt+J/ToX6NBoCGE35r+JGV4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034388; c=relaxed/simple;
	bh=71fgk7/pjKbIL3/bv557fkIpwYnWwWChravaY+wLfFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLrvvGZHNDK2WjKPdjMNFO39KYvi+MZc4bGQRbAUpUbRdyzq5QRxekVsDc+4uB8SjzXqMqILCgCQASO5P1Vx4+EBYE+cQdQJfikI1BJUGq9bK2blzDZCtnSPHh5+jnND2aQRGqVdDJfJzUN+2Pcxsn3ZPR6U+9C1ygV8xQv7G4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwyYkiEo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C10D1F00AC4;
	Tue, 14 Jul 2026 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784034387;
	bh=n5uZic2yQEf6J+MPzYVAL97zNM1jCY/8xBbV5VkLom0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XwyYkiEoqtwMmiD4xVL+MBmHsJCedGnMjYjtF7ZQ2NLepWSeWorhUpxLfvE/DFku0
	 +u3EAX8QG/xj9D79OwLnv8xgPquStq1bk0cMgkhwzpV/AlRtLyaHxTZETFvRpDOm+4
	 O88eKBCgFzRf4rwO4X6bT9pTudZEI9WDJOXd3ZaZeoZbsCpCH9R3aUGTjqvdtSExIm
	 zv8FOfz7QH8Q91sBi96FI/BCUFv9qYnkcKbQ+yhrTwwZ3+kKLjnKmwDsQ8CxYIILRH
	 iPx6zwiqznikPOtZohxKfLMaPiNMDSI5Mc7Syj0ixv5XpCr4vZJOI+E9u9HK5tXd2C
	 9hqISmIpo4bLg==
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
Subject: Re: [PATCH net-next v3 13/15] ibmveth: Implement incremental MQ RX queue resize
Date: Tue, 14 Jul 2026 14:03:46 +0100
Message-ID: <20260714130344.1841551-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706193603.8039-14-mmc@linux.ibm.com>
References: <20260706193603.8039-14-mmc@linux.ibm.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307465-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mmc@linux.ibm.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:bjking1@linux.ibm.com,m:haren@linux.ibm.com,m:ricklind@linux.ibm.com,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:davemarq@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DC17754F20

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
Date:   Mon Jul 6 19:36:01 2026 +0000

ibmveth: Implement incremental MQ RX queue resize
    
Add helpers to register/deregister individual RX queues and scale
queue count up or down while the netdev stays up. Surviving queues
keep PHYP handles, buffer pools, and IRQ state across resize.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index ecc472ee8f71f..ac4d89a66a8db 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -1080,6 +1132,138 @@ static void ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
> +static int
> +ibmveth_alloc_single_rx_queue(struct ibmveth_adapter *adapter, int queue_idx,
> +			      int rxq_entries)
> +{

[ ... ]

> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
> +		adapter->rx_buff_pool[queue_idx][i].size =
> +			adapter->rx_buff_pool[0][i].size;
> +		adapter->rx_buff_pool[queue_idx][i].buff_size =
> +			adapter->rx_buff_pool[0][i].buff_size;
> +		adapter->rx_buff_pool[queue_idx][i].threshold =
> +			adapter->rx_buff_pool[0][i].threshold;
> +		adapter->rx_buff_pool[queue_idx][i].active =
> +			adapter->rx_buff_pool[0][i].active;
> +	}

[Severity: Critical]
Does this loop miss initializing pool->index?

If pool->index remains 0 for all buffer pools on the new queue, when
replenishing, 0 is shifted into the correlator.

Then when receiving, ibmveth_remove_buffer_from_pool() will extract pool=0,
which fetches from the wrong pool and could corrupt the free map of pool 0,
leading to a use-after-free or leak.

[ ... ]

> @@ -1192,6 +1376,49 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
> +static int
> +ibmveth_drain_rx_queue(struct ibmveth_adapter *adapter, int queue_index)
> +{

[ ... ]

> +	while (drained < limit &&
> +	       ibmveth_rxq_pending_buffer(adapter, queue_index)) {
> +		rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, true);

Simon says: I think we can consider the issue below in the context of
            possible follow-up, because I believe the use of this pattern
	    predates this patch.

[Severity: High]
Is a read memory barrier needed between reading the toggle bit in
ibmveth_rxq_pending_buffer() and reading the correlator in
ibmveth_rxq_harvest_buffer()?

Since the hypervisor could be actively writing new descriptors while this is
called, could a weakly-ordered CPU reorder the correlator load before the
toggle bit load, causing us to recycle the wrong buffer?

[ ... ]

> @@ -1491,6 +1718,175 @@ ibmveth_deregister_single_rx_queue(struct ibmveth_adapter *adapter,
> +static int
> +ibmveth_resize_rx_queues_incremental(struct ibmveth_adapter *adapter,
> +				     int new_count, int rxq_entries)
> +{

[ ... ]

> +			rc = ibmveth_enable_irq(adapter, i);
> +			if (rc) {
> +				netdev_err(netdev,
> +					   "Failed to enable IRQ for queue %d: %d\n",
> +					   i, rc);
> +				ibmveth_cleanup_single_rx_interrupt(adapter, i);
> +				ibmveth_deregister_single_rx_queue(adapter, i);
> +				ibmveth_free_single_rx_queue(adapter, i);
> +				goto cleanup_new_queues;
> +			}
> +
> +			napi_enable(&adapter->napi[i]);
> +		}
> +
> +		adapter->num_rx_queues = new_count;

[Severity: High]
What happens if an interrupt fires on the newly added queue before
adapter->num_rx_queues is updated?

If an interrupt fires between ibmveth_enable_irq() and the update of
adapter->num_rx_queues, ibmveth_interrupt() might evaluate:
    WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues)
to true and return IRQ_NONE without masking the interrupt.

Could this lead to an unhandled interrupt storm?

[ ... ]

> +	} else {
> +		netdev_dbg(netdev, "Scale-down: removing queues %d-%d\n",
> +			   new_count, old_count - 1);
> +
> +		for (i = new_count; i < old_count; i++)
> +			napi_disable(&adapter->napi[i]);
> +
> +		for (i = new_count; i < old_count; i++)
> +			ibmveth_drain_rx_queue(adapter, i);
> +
> +		synchronize_net();

[Severity: High]
Can disabling NAPI before disabling the hardware interrupts create an
interrupt storm window?

If the hypervisor asserts an interrupt during synchronize_net(), the hardware
IRQ handler runs. Since NAPI is disabled, it returns IRQ_HANDLED without
masking the interrupt source at the hypervisor, leading immediately to an
IRQ storm and CPU lockup.

> +
> +		rc = netif_set_real_num_rx_queues(netdev, new_count);
> +		if (rc) {
> +			netdev_err(netdev, "Failed to set real RX queues to %d: %d\n",
> +				   new_count, rc);
> +			for (i = new_count; i < old_count; i++)
> +				napi_enable(&adapter->napi[i]);
> +			return rc;
> +		}

[Severity: High]
Is it possible for this error path to permanently stall the RX queues?

It calls napi_enable() but doesn't call ibmveth_replenish_task(). Since the
queues were completely drained of their buffers by ibmveth_drain_rx_queue(),
will the hypervisor have any buffers to place incoming packets?

Without buffers, no interrupts will fire for these queues, and NAPI will
never run again.

