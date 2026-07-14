Return-Path: <netdev+bounces-307456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6Ky5DfczVmpn1QAAu9opvQ
	(envelope-from <netdev+bounces-307456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:04:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86977754D47
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:04:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=X7UoAST0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307456-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307456-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 367683004C5D
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D7F450906;
	Tue, 14 Jul 2026 13:00:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8565B3B42E9
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 13:00:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034002; cv=none; b=eqVHfxi4oO/ffvYj/0Woabz9M5aX4jOje1yNI+S75R4n7hPuh85ZUz3m/z4vBofQiNLohlp9Z8gSiOq4SoGN+9eg5h5a0IjC6qvj684Zs0LaQq0CJxJJyCFlOwGQIbz24pt4o9ppziT38e5o9iPA8ESlnCH2BDHE+4zuR4KmO98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034002; c=relaxed/simple;
	bh=H58TWC+TXK/BHRTtX4YvVrPjLOm9dbng8JwYQCqm72g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkDFG6UMruze6srfg6nBnjihsUutm/3Ec57i2XXotdg6eN7jI7o9czUvtLCxApO/vFi3yyJXUAeY2cHhtkHvrPt/eINph/y+H/m/2rtEgOMrIN2exvQU3KJPCSggX4kO5oQsEfWlCshXSS8yEdusTKKtwE095c851cw/crERbXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7UoAST0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB74A1F000E9;
	Tue, 14 Jul 2026 12:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784034001;
	bh=1P/wug/qzmssJOyrjuPPOZYs1q4TmXwKDCPnEXvd4gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X7UoAST0BAf5quQi/hWYb9/7KmQ8gg2QSkoTKrfTgtINsPRIFFRwjvZi/aqt9ZLCq
	 a3YcziUtVcr5f0KXxpdnUdCyRAGNjBpyeqqG7pg5f/uqSC/xcSSA8uUGKN12DISA/1
	 iZjio3PiMymS7yYn4ihVW4iYM4TI8ItkWuU9XoSOBUoAmp7CnavZ7n0E4mEcwDjaC9
	 S6rBJHk/5+tFYxP5SSec+hkag3hmQvojB/ArIID9XmeuMwcTMBVxa3ssvsXr8UOd/t
	 tEvjrhduGsfacZl15DVGJ+MNglU9x6dyC9vGsG+uNbvtiq6dIvCDjoHd/5vo6Qj5OZ
	 +idcKl/dTojHg==
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
Subject: Re: [PATCH net-next v3 11/15] ibmveth: Add per-queue RX and TX statistics collection and reporting
Date: Tue, 14 Jul 2026 13:59:48 +0100
Message-ID: <20260714125948.1841205-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706193603.8039-12-mmc@linux.ibm.com>
References: <20260706193603.8039-12-mmc@linux.ibm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307456-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86977754D47

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ibmveth: Add per-queue RX and TX statistics collection and reporting

This commit introduces per-queue statistics tracking for both receive and
transmit paths in the ibmveth driver. The counters are aggregated for legacy
interfaces and exposed individually via ethtool stringsets.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 863e5c68b42c7..4e3f49b6346fd 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
[ ... ]
> @@ -1655,6 +1655,10 @@ static int ibmveth_open(struct net_device *netdev)
>  	if (rc)
>  		goto out_cleanup_rx_interrupts;
>  
> +	rc = ibmveth_alloc_tx_qstats(adapter);
> +	if (rc)
> +		goto out_free_tx_resources;
> +
>  	netif_tx_start_all_queues(netdev);
>  
>  	netdev_dbg(netdev, "open complete\n");
[ ... ]
>  out_cleanup_rx_interrupts:
>  	ibmveth_cleanup_rx_interrupts(adapter);
>  out_free_tx_resources:
>  	ibmveth_free_tx_resources(adapter);

[Severity: High]
Does the goto out_free_tx_resources on ibmveth_alloc_tx_qstats() failure
bypass the cleanup for RX interrupts?

Since out_free_tx_resources is physically below out_cleanup_rx_interrupts in
ibmveth_open(), failing here leaves the IRQs requested and NAPI enabled. If
an interrupt subsequently fires, could the handler access the freed RX queue
memory and cause a kernel panic?

[ ... ]
> @@ -1699,6 +1699,7 @@ static int ibmveth_close(struct net_device *netdev)
>  		}
>  	}
>  
> +	ibmveth_free_tx_qstats(adapter);
>  	ibmveth_free_tx_resources(adapter);
>  	ibmveth_cleanup_rx_interrupts(adapter);
>  	ibmveth_update_rx_no_buffer(adapter);
[ ... ]
>  	ibmveth_free_rx_qstats(adapter);

[Severity: High]
If ibmveth_close() is called to bring down the interface, does this
unconditionally free adapter->tx_qstats and adapter->rx_qstats without a
grace period?

Since ibmveth_get_stats64() can be called concurrently under RCU, and
ibmveth_start_xmit() can run concurrently if the datapath is not completely
synchronized, could this lead to a use-after-free or NULL pointer dereference
when these functions access the freed arrays?

[ ... ]
> @@ -1967,22 +1967,107 @@ static int ibmveth_set_features(struct net_device *dev,
[ ... ]
> +static void ibmveth_aggregate_rx_qstats(struct ibmveth_adapter *adapter)
> +{
> +	u64 total_invalid = 0;
> +	u64 total_large = 0;
> +	int i;
> +
> +	if (!adapter->rx_qstats)
> +		return;
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		total_invalid += adapter->rx_qstats[i].invalid_buffers;
> +		total_large += adapter->rx_qstats[i].large_packets;
> +	}
> +
> +	adapter->rx_invalid_buffer = total_invalid;
> +	adapter->rx_large_packets = total_large;
> +}

[Severity: High]
Does overwriting adapter->rx_invalid_buffer and other persistent global
counters with the dynamically allocated adapter->rx_qstats values cause a
permanent loss of interface statistics?

When the interface is brought down and back up, ibmveth_close() frees the
queue stats arrays and ibmveth_open() reallocates them as zeroed. Will this
cause all historical statistics to be wiped out on every interface reset,
breaking standard persistence behavior?

[ ... ]
> +static void ibmveth_get_strings(struct net_device *dev, u32 stringset, u8 *data)
> +{
[ ... ]
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		ethtool_sprintf(&p, "rx%d_packets", i);
> +		ethtool_sprintf(&p, "rx%d_bytes", i);

[Severity: Low]
Are these private ethtool stringsets duplicating standard kernel statistics?

According to the subsystem guidelines, per-queue packet and byte statistics
that have a standard UAPI representation (like struct netdev_queue_stats_rx
exported via netlink) should not be duplicated as private ethtool strings.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
> index f7b20fd01acb5..390c660af979e 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.h
> +++ b/drivers/net/ethernet/ibm/ibmveth.h
> @@ -316,9 +316,21 @@ struct ibmveth_rx_queue_stats {
>  	u64 no_buffer_drops;
>  };
>  
> +struct ibmveth_tx_queue_stats {
> +	u64 packets;
> +	u64 bytes;
> +	u64 large_packets;
> +	u64 dropped_packets;
> +	u64 send_failures;
> +	u64 checksum_offload;
> +};

[Severity: Medium]
Will this structure layout prevent cache line false sharing?

The commit message mentions tracking transmit counters per TX queue to avoid
cache line contention, but struct ibmveth_tx_queue_stats appears to be
exactly 48 bytes and lacks cacheline alignment annotations like
____cacheline_aligned. When allocated as a contiguous array, will multiple
CPUs processing different queues end up writing to the same hardware
cacheline?

