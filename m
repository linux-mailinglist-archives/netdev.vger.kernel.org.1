Return-Path: <netdev+bounces-272835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QnWpFvheyGmilAUAu9opvQ
	(envelope-from <netdev+bounces-272835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 00:06:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 046A5350324
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 00:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D33783015A49
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 23:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32BE3081D6;
	Sat, 28 Mar 2026 23:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="leUaEJ7h"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103DF18DB26;
	Sat, 28 Mar 2026 23:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774739177; cv=none; b=Dhluh8aEKgfc1FZWIWIt0mqTLSZS1d701CDkZT8fyynmWs6gmAFFHPvgbFqUA1bRfsFhKoKFxvlssG6pQp3vnl5bhqKVy4uruigZSDSkWLJmyTpG7jIvTTtb2DLcxXoodEEN30G059RDG41lsiet8+QpOMXI5M/cWCWFRhLZipQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774739177; c=relaxed/simple;
	bh=FPOu8B6t/521kfmff/8kN00xbw2z1bT/3GgPyFG+W4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nX5gWpGwwa2Z9gsRAkSS2skJNuFy2ve+tPlGX3Jvq59xfWPrDJcG7y2ytuxRe9WOXcOURQy8368WNU0DdPGxKI819DEFsx7hpdYG/RONeAE/+nQJLWRtakB+pfWf1G1P1H9ig63wvh7X/NeK7PlsI8rLXW7BfEalSWGQGOYJehk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=leUaEJ7h; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 75E0BA5860;
	Sun, 29 Mar 2026 00:06:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774739170; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=NX6MIOE+M+icOJYthTgBSqdYyilm3huvYTpkM+GA0hc=;
	b=leUaEJ7hEGlnXxdnuldMuUyHkq4e6Q4IDAVeT1AWeyaZ5j/3iL1zqH6WwltmMkyWfACiD6
	i+kdBz7HUtwLV8kiQChvHRxsqcG3hUneV6W/alIRlr+8Omjua9KRQ/JbXo7Vk4XFxwfVIo
	NQhW1HOB3xi3DYJKrEC2Djj0DcK5pkQ6q93bJIeoNY8ANKO8dT+M7lKu9xfnv7KZRUpgw6
	fnfvo10cAW8jI3l/2mcGqFs2f9gOa9Iq0jzcEp/xowcdImi1MchPiJCOqwoboLE8fxAqJO
	tOKuMEoa3An1iDRE9AvuU793y/N4PPtCjQBKpZjfaRl0ESKjOK/3+PGJJk2XWQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org
Subject: [PATCH net-next v5 0/6] net: bcmgenet: add XDP support
Date: Sun, 29 Mar 2026 00:05:03 +0100
Message-ID: <20260328230513.415790-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,tipi-net.de,iogearbox.net,davemloft.net,gmail.com,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272835-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:?];
	NEURAL_SPAM(0.00)[1.000];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_DNSFAIL(0.00)[tipi-net.de : query timed out];
	R_DKIM_TEMPFAIL(0.00)[tipi-net.de:s=dkim];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 046A5350324
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add XDP support to the bcmgenet driver, covering XDP_PASS, XDP_DROP,
XDP_TX, XDP_REDIRECT, and ndo_xdp_xmit.

The first patch converts the RX path from the existing kmalloc-based
allocation to page_pool, which is a prerequisite for XDP. The remaining
patches incrementally add XDP functionality and per-action statistics.

Tested on Raspberry Pi CM4 (BCM2711, bcmgenet, 1Gbps link):
- XDP_PASS: 943 Mbit/s TX, 935 Mbit/s RX (no regression vs baseline)
- XDP_PASS latency: 0.164ms avg, 0% packet loss
- XDP_DROP: all inbound traffic blocked as expected
- XDP_TX: TX counter increments (packet reflection working)
- Link flap with XDP attached: no errors
- Program swap under iperf3 load: no errors
- Upstream XDP selftests (xdp.py): pass_sb, drop_sb, tx_sb passing
- XDP-based EtherCAT master (~37 kHz cycle rate, all packet processing
  in BPF/XDP), stable over multiple days

Changes since v4:
  - Fixed -Wunused-but-set-variable warning: tx_ring was declared and
    assigned in patch 4 but only used starting in patch 5. Moved
    declaration to patch 5 where it is first used. (Jakub Kicinski)

Changes since v3:
  - Fixed page leak on partial bcmgenet_alloc_rx_buffers() failure:
    free already-allocated rx_cbs before destroying page pool.
    (Simon Horman)
  - Fixed GENET_Q16_TX_BD_CNT defined as 64 instead of 32, matching
    the documented and intended BD allocation. (Simon Horman)
  - Moved XDP TX ring to a separate struct member (xdp_tx_ring)
    instead of expanding tx_rings[] to DESC_INDEX+1. (Justin Chen)
  - Added synchronize_net() before bpf_prog_put() in XDP prog swap
    to ensure NAPI is not still running the old program.
  - Removed goto drop_page inside switch; inlined page_pool_put
    calls in each failure path. (Justin Chen)
  - Removed unnecessary curly braces around case XDP_TX. (Justin Chen)
  - Moved int err hoisting from patch 2 to patch 1 where it belongs.
    (Justin Chen)
  - Kept return type on same line as function name throughout, to
    match existing driver style. (Justin Chen)
    Note: checkpatch flags one alignment CHECK on bcmgenet_xdp_xmit_frame
    as a result; keeping per Justin's preference.
  - Fixed XDP_TX xmit failure path: use xdp_return_frame_rx_napi()
    instead of page_pool_put_full_page() after xdp_convert_buff_to_frame
    to avoid double-free of the backing page.
  - Count XDP TX packets/bytes in TX reclaim so XDP traffic is visible
    in standard network stats (ip -s link show).
  - Added headroom check before TSB prepend in XDP_TX to prevent
    out-of-bounds write when bpf_xdp_adjust_head consumed headroom.

Changes since v2:
  - Fixed xdp_prepare_buff() called with meta_valid=false, causing
    bcmgenet_xdp_build_skb() to compute metasize=UINT_MAX and corrupt
    skb meta_len. Now passes true. (Simon Horman)
  - Removed bcmgenet_dump_tx_queue() for ring 16 in bcmgenet_timeout().
    Ring 16 has no netdev TX queue, so netdev_get_tx_queue(dev, 16)
    accessed beyond the allocated _tx array. (Simon Horman)
  - Fixed checkpatch alignment warnings in patches 4 and 5.

Changes since v1:
  - Fixed tx_rings[DESC_INDEX] out-of-bounds access. Expanded array
    to DESC_INDEX+1 and initialized ring 16 with dedicated BDs.
  - Use ring 16 (hardware default descriptor ring) for XDP TX,
    isolating from normal SKB TX queues.
  - Piggyback ring 16 TX completion on RX NAPI poll (INTRL2_1 bit
    collision with RX ring 0).
  - Fixed ring 16 TX reclaim: skip INTRL2_1 clear, skip BQL
    completion, use non-destructive reclaim in RX poll path.
  - Prepend zeroed TSB before XDP TX frame data (TBUF_64B_EN requires
    64-byte struct status_64 prefix on all TX buffers).
  - Tested with upstream XDP selftests (xdp.py): pass_sb, drop_sb,
    tx_sb all passing. The multi-buffer tests (pass_mb, drop_mb,
    tx_mb) fail because bcmgenet does not support jumbo frames /
    MTU changes; I plan to add ndo_change_mtu support in a follow-up
    series.

Nicolai Buchwitz (6):
  net: bcmgenet: convert RX path to page_pool
  net: bcmgenet: register xdp_rxq_info for each RX ring
  net: bcmgenet: add basic XDP support (PASS/DROP)
  net: bcmgenet: add XDP_TX support
  net: bcmgenet: add XDP_REDIRECT and ndo_xdp_xmit support
  net: bcmgenet: add XDP statistics counters

 drivers/net/ethernet/broadcom/Kconfig         |   1 +
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 641 +++++++++++++++---
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  19 +
 3 files changed, 564 insertions(+), 97 deletions(-)

--
2.51.0


