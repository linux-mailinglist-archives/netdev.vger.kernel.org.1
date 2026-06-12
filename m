Return-Path: <netdev+bounces-298714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /mIFGMgvLGrCNAQAu9opvQ
	(envelope-from <netdev+bounces-298714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:11:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5939B67AC1C
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:11:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QjzHw5MA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298714-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298714-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 781EC300AD71
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F91A3815D0;
	Fri, 12 Jun 2026 16:08:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6DF36A008;
	Fri, 12 Jun 2026 16:08:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280484; cv=none; b=B6VCtDwbyhKeLtZ92DYwBwSfbBY/JVuCLZM9jt148t44COne7H2BlMqjHAUm/e41lAE7XDAqGlTzRwu+646PYW98fh6EIu69Bg5i0cHPdKMLUKa5Mlo0+vnPHIEUFgjl0M+FktQisOFS5jhyVP9h3i7HQ/rHwQQkcPsxTDyCaKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280484; c=relaxed/simple;
	bh=LR2BfBZna3OkeH+hzZlO/JF17554TASaanZ9fHy0NPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4C6Vuhu7B3g+xs+ucgGteK37olLdyVOOcM/GXjLjn+OhQWCrcJ4Q0SGOZsCjH69KaBncRQPXqxT2/Xs76szsho5AooQg0KxNYcKpz+Hw2KkYZ1vMztKQkMKjYK0X9uqe82ETQiKmMXh2/uOrJKa/qznwOSn/s5Yv7XuESr7Y6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjzHw5MA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B412D1F000E9;
	Fri, 12 Jun 2026 16:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781280482;
	bh=yz6KYSR4gT24Ep3/Nz7Y+Zry32zkNaxRVcE0WS2wn8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QjzHw5MAowB7dMdWD33YX9M+vy6L/A8hsa+jsLcIHehALzVYe2F0cEVvqCRHOzp+0
	 IHB2E4bogbhrr5b/elH3o1t/woaFhN+spbuzhUU/obxAgnnecamWzi+dyFryRRh1GQ
	 0pm/kSlpChJQuyNutVxvdGXgvx/Iqhav29feM5dA04YqfbifrgBNrI4iQOyRjDdEh1
	 ywnJCDRMPQrBjI6S3FpjkSibya5nQCbDEvDGxBAcba0mzup1o51BQOuO1cqVNCCPeI
	 OceN1zyHhkh63bDxz/huBY3jZgM/HVSKe01KzabdlK72PDi9MtwE63gj1UcGQjFCio
	 BzdBYA1kBKZmw==
From: Simon Horman <horms@kernel.org>
To: gongfan1@huawei.com
Cc: Simon Horman <horms@kernel.org>,
	wudi234@huawei.com,
	tengpeisen@huawei.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	ioana.ciornei@nxp.com,
	mohsin.bashr@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	luosifu@huawei.com,
	guoxin09@huawei.com,
	zhoushuai28@huawei.com,
	wulike1@huawei.com,
	shijing34@huawei.com,
	zhengjiezhen@h-partners.com,
	maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next v09 2/5] hinic3: Add ethtool statistic ops
Date: Fri, 12 Jun 2026 17:07:51 +0100
Message-ID: <20260612160751.690490-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <d3a84fab341ec7060236a7b74709e48f622df98e.1781062575.git.wudi234@huawei.com>
References: <d3a84fab341ec7060236a7b74709e48f622df98e.1781062575.git.wudi234@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298714-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gongfan1@huawei.com,m:horms@kernel.org,m:wudi234@huawei.com,m:tengpeisen@huawei.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:ioana.ciornei@nxp.com,m:mohsin.bashr@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:luosifu@huawei.com,m:guoxin09@huawei.com,m:zhoushuai28@huawei.com,m:wulike1@huawei.com,m:shijing34@huawei.com,m:zhengjiezhen@h-partners.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:mohsinbashr@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,huawei.com,vger.kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,nxp.com,gmail.com,h-partners.com,bootlin.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5939B67AC1C

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
Subject: hinic3: Add ethtool statistic ops

This commit adds PF/VF statistics functions for TX and RX processing in the
hinic3 driver. It implements various ethtool callbacks to allow detailed
netdev stats monitoring. It also adds a helper for management commands
requiring separate I/O buffers to retrieve expanded MAC stats.

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
[ ... ]
> +static struct hinic3_stats hinic3_function_stats[] = {
> +	HINIC3_FUNC_STAT(tx_unicast_pkts_vport),
[ ... ]
> +static struct hinic3_stats hinic3_port_stats[] = {
> +	HINIC3_PORT_STAT(mac_tx_fragment_pkt_num),

[Severity: Medium]
Does this duplicate standard network counters into the private ethtool strings
interface?

The networking driver guidelines note that stats with a standard UAPI should
not be duplicated in the private strings.

The arrays for function and port stats export standard statistics like unicast
packets or MAC errors. Could these be exposed exclusively through standard
interfaces like rtnl_link_stats64 or ethtool_mac_stats instead?

[ ... ]
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
[ ... ]
> @@ -588,5 +643,10 @@ int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
>  	if (rxq->delta >= HINIC3_RX_BUFFER_WRITE)
>  		hinic3_rx_fill_buffers(rxq);
>  
> +	u64_stats_update_begin(&rxq->rxq_stats.syncp);
> +	rxq->rxq_stats.packets += (u64)nr_pkts;
> +	rxq->rxq_stats.bytes += rx_bytes;
> +	u64_stats_update_end(&rxq->rxq_stats.syncp);

[Severity: Medium]
Does this calculation undercount the number of physical packets received when
Large Receive Offload is active?

Earlier in the loop, the code accounts for aggregated wire packets by adding
the length of the headers for the aggregated packets to the bytes counter.

However, the rxq_stats.packets update only adds the number of host SKBs,
omitting the extra wire packets entirely.

[ ... ]
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
[ ... ]
> @@ -260,6 +267,9 @@ static int hinic3_tx_csum(struct hinic3_txq *txq, struct hinic3_sq_task *task,
>  		if (l4_proto != IPPROTO_UDP ||
>  		    ((struct udphdr *)skb_transport_header(skb))->dest !=
>  		    VXLAN_OFFLOAD_PORT_LE) {
> +			u64_stats_update_begin(&txq->txq_stats.syncp);
> +			txq->txq_stats.unknown_tunnel_pkt++;
> +			u64_stats_update_end(&txq->txq_stats.syncp);
>  			/* Unsupported tunnel packet, disable csum offload */
>  			skb_checksum_help(skb);
>  			return 0;

[Severity: High]
This is a pre-existing issue, but does ignoring the return value of the
software checksum fallback risk silent data corruption?

If the calculation in skb_checksum_help fails, for example due to an
allocation failure when ensuring the buffer is writable, the packet checksum
remains uncalculated. 

Since the error is ignored and 0 is returned, the driver proceeds to transmit
the packet without hardware offload, resulting in a corrupted packet being
sent onto the network.

[ ... ]
> +static void hinic3_get_pkt_stats(struct hinic3_txq *txq, struct sk_buff *skb)
> +{
> +	u32 hdr_len, tx_bytes;
> +	unsigned short pkts;
> +
> +	if (skb_is_gso(skb)) {
> +		hdr_len = (skb_shinfo(skb)->gso_segs - 1) *
> +			  skb_tcp_all_headers(skb);
> +		tx_bytes = skb->len + hdr_len;

[Severity: High]
Can this sequence cause an out-of-bounds read and statistics corruption for
UDP GSO packets?

The code assumes all GSO packets use TCP by calling a helper that reads the
TCP header length. If the driver handles UDP-encapsulated offloads, the
transport header is much shorter. 

Reading the data offset from a TCP header location accesses bytes past the end
of the UDP header. This could read arbitrary payload data as a header length
multiplier, corrupting the tx_bytes statistic and potentially causing a
page fault.

[ ... ]

