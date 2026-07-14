Return-Path: <netdev+bounces-307466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QbM+KIc1Vmrp1QAAu9opvQ
	(envelope-from <netdev+bounces-307466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:11:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5047C754E7D
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:11:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RfSX1rbs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307466-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307466-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA9FB3036464
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7735C47885F;
	Tue, 14 Jul 2026 13:08:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C11B4779BE
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 13:08:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034483; cv=none; b=IGR/Kl3LudhHNTMBA5XqVGe6ypL6WEqgLMNUTX0bSFIqSjgwR6LKqxCbIreGOUo4UdF/vuQsudMVCIk6gJS0vhLBW4Wk9sYXoOv+Rq99UNj+PwEMM4Yh+26zZ+arD8ZYlY+iQzxlh7YgDCoETOsQD1/AnDjgUz8NsMyu9AaTYQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034483; c=relaxed/simple;
	bh=vMJAz5vcCLrHE1eCIBfVMLV3Q+CDyKl69z7IQv21VZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1KHXPAFJx0LPe6TPvYv/DeVwlVPenAZsA+vY9hRfQHu2HwCt6tLvcABSwpq241eHbh0ulO7/2dDjyVHTEI5xLvpMNdtJckBrtgpfVKYAiUh/FIzJP0bArykkhM7eie3kcH6yYQoOayxkVXcRu6nqJnP/kgcA8eOg/0ekmzyZQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfSX1rbs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16021F000E9;
	Tue, 14 Jul 2026 13:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784034482;
	bh=OR+TALXUbrDqxIOAyEwXOdpwUaeeSd6LxkFLp/LQ0xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RfSX1rbszvo/lzps5iz4Gm8FU0W6pSskBwPU8lPBHXly0vlOL/70m/UOWKYGzhlrr
	 2/EZo2jDlOpmSwU6j/Hv2vHvmIctbhJ/5HwmRGTW1NtkFkXyylt7Gjl4DNfmsv59g9
	 8muh0afsUEHpFHcqptKt3spGlSQ4mcFLjV9VwEQjp1ZrOINtMREMYwU06DL3Z5clK3
	 P5vK5nVmH+BQu7wP58z1ldhse0HYqQ7Dv1pPgm8wQudq9jvZvyJAAEdjnjjjOYlohP
	 WN9qhgJK8EoBMbtgRedIKczJd8fT3SPn8LOiLmqMJmmzHvjuYgDzX4a8cD+Z6bVvv7
	 eBK+sB+LqioiA==
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
Subject: Re: [PATCH net-next v3 14/15] ibmveth: Wire ethtool set_channels to MQ RX queue resize
Date: Tue, 14 Jul 2026 14:07:52 +0100
Message-ID: <20260714130752.1844153-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706193603.8039-15-mmc@linux.ibm.com>
References: <20260706193603.8039-15-mmc@linux.ibm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307466-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5047C754E7D

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ibmveth: Wire ethtool set_channels to MQ RX queue resize

Expose incremental RX resize through ethtool channel control.
get_channels() reports rx_count from adapter->num_rx_queues and max_rx
as IBMVETH_MAX_RX_QUEUES when MQ firmware is enabled, else 1.
set_channels() validates rx_count is within 1..IBMVETH_MAX_RX_QUEUES.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index ac4d89a66a8db..50a332ab83fd3 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -2534,19 +2534,69 @@ static int ibmveth_set_channels(struct net_device *netdev,
>  				struct ethtool_channels *channels)
>  {
>  	struct ibmveth_adapter *adapter = netdev_priv(netdev);
[ ... ]
> -	if (!(netdev->flags & IFF_UP))
> +	if (!(netdev->flags & IFF_UP)) {
> +		if (goal_rx > 1 && !adapter->multi_queue) {
[ ... ]
> +		/* Stash desired RX count; open() publishes it via
> +		 * netif_set_real_num_rx_queues() after queue registration.
> +		 */
> +		if (goal_rx != adapter->num_rx_queues)
> +			adapter->num_rx_queues = goal_rx;
> +
>  		return netif_set_real_num_tx_queues(netdev, goal);

[Severity: Medium]
If netif_set_real_num_tx_queues() fails and returns an error, the TX
configuration command will fail, but the RX queue count has already been
permanently modified in adapter->num_rx_queues. Will this leave the device in
an inconsistent state where the new RX count is applied on the next open
despite the command failing?

> +	}
[ ... ]
> +	if (goal_rx != old_rx) {
> +		rc = ibmveth_resize_rx_queues_incremental(adapter, goal_rx,
> +							  rxq_entries);

[Severity: High]
Does this new ethtool scale-down path expose an interrupt storm?

Looking at ibmveth_resize_rx_queues_incremental(), when scaling down queues it
disables NAPI before disabling the hardware interrupt:

drivers/net/ethernet/ibm/ibmveth.c:ibmveth_resize_rx_queues_incremental() {
    ...
		for (i = new_count; i < old_count; i++)
			napi_disable(&adapter->napi[i]);

		for (i = new_count; i < old_count; i++)
			ibmveth_drain_rx_queue(adapter, i);

		synchronize_net();
    ...
		/* Disable hypervisor interrupts and wait for handlers to complete
		 * before updating num_rx_queues.
		 */
		for (i = new_count; i < old_count; i++) {
			ibmveth_disable_irq(adapter, i);
    ...
}

If the hypervisor delivers a packet during this window, ibmveth_interrupt()
will execute. Since NAPI is disabled, napi_schedule_prep() fails, causing the
handler to return IRQ_HANDLED without disabling the hardware interrupt. Will
this leave the virtual interrupt asserted and force an infinite interrupt loop?

> +		if (rc) {
> +			netdev_err(netdev, "Failed to resize RX queues: %d\n", rc);
> +			return rc;
> +		}
> +	}
>  
>  	/* We have IBMVETH_MAX_QUEUES netdev_queue's allocated
>  	 * but we may need to alloc/free the ltb's.
>  	 */

[Severity: High]
This is a pre-existing issue, but does this function use an uninitialized
variable in the error path?

When decreasing the number of TX queues (goal < old), the allocation loop for
(i = old; i < goal; i++) is skipped, leaving 'i' uninitialized. If
netif_set_real_num_tx_queues() then fails, the error path assigns old = i;. 

The cleanup loop then uses this garbage value:
	for (i = old; i > goal; i--) {
		if (adapter->tx_ltb_ptr[i - 1])

Will this access adapter->tx_ltb_ptr out of bounds and pass arbitrary pointers
to ibmveth_free_tx_ltb()?

> @@ -2580,7 +2630,7 @@ static int ibmveth_set_channels(struct net_device *netdev,
>  
>  	netif_tx_wake_all_queues(netdev);
>  
> -	return rc;
> +	return 0;

[Severity: High]
Does this unconditional return of 0 mask TX queue configuration failures?

If applying the new TX queue count via netif_set_real_num_tx_queues() fails,
the code handles it locally, but the function exits with 0 regardless. Will
this mislead userspace into believing the TX channel count was successfully
modified?

>  }

