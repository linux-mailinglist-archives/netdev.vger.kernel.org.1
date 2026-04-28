Return-Path: <netdev+bounces-282073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IWqGtAf8WmRdgEAu9opvQ
	(envelope-from <netdev+bounces-282073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:00:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB5948C23D
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D34D306D0D4
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880E1382299;
	Tue, 28 Apr 2026 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="bo0aRhnb"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE0E2DF701;
	Tue, 28 Apr 2026 20:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777409983; cv=none; b=pC7JJdNjR+PNm0IFy4fkG/2L3oVGTKHaSPi5deu3g9qGL+C6l0/LjoRzhMpZw3paAmQMcXSHq7FKYXe80G+x5yr/nh9Z0sKtZQPkX4hZ3dlF2CU2i4DRVh3prflp5tED1kYYE20xVenxg6nrc2bKP820mZD2VI52G/WJvXokio0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777409983; c=relaxed/simple;
	bh=zL2Jdk0x862O3Djzaya+asUlk//2TbTuvBibPanwHLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PwN125IaqO2Fvc7GS24hWs4lNVmbm3dekQ0X3Kzp4woL5I49GnYfFY0SBiq7juzp3dRfmltFaPcvceDwCOHfOrkNsw+Q7sBzrFjKXk0wnp+2nFALBMxUizk0Mg0nlBWXhrnVMrNe1/5SIeAFydbfTXHSTWKSD3aNT41pN2ewLw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=bo0aRhnb; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 645C8A542E;
	Tue, 28 Apr 2026 22:59:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1777409965; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=94Yy4sdgjWSC9wV4eLPu6oHsDvU1flF0Ht992NUKwMM=;
	b=bo0aRhnbF0c3pgcEn0drHAH/Y+ADQDyD6SIyiV+GMJC7e1BjWWEHV2GYhu1UuJ/HzvXQJ4
	g2vUkLssyLxeVOmB184Bk2/TkLMxANoBYxMgoj7ZERSMiCbCy/CEwmXuwvSGQGjVHSdHU4
	vMR8C3LP+k17dTDXihNYe+n8MK06KyzYqoRlsIbdOACbQwJIZAq1nJz68IVba5QWCtGK4K
	KqlOhsrLv7qv6wHSsjjk/VI6aQZ/syl+7K6sdBQyZJlKXBrB6vUONsZ8OqoU59CJP/PNSV
	9HXkNwY2psKrMuO1gEnEkkS55pLNP13frpXahetYzH5uB2ZuiCja0rmGSBU0nA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org
Subject: [PATCH net-next v8 0/7] net: bcmgenet: add XDP support
Date: Tue, 28 Apr 2026 22:58:37 +0200
Message-ID: <20260428205846.2625550-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: ABB5948C23D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-282073-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[tipi-net.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,lunn.ch,google.com,redhat.com,tipi-net.de,iogearbox.net,davemloft.net,fomichev.me,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:dkim,tipi-net.de:mid]

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

Previous versions:
  v7: https://lore.kernel.org/netdev/20260416054743.1289191-1-nb@tipi-net.de/
  v6: https://lore.kernel.org/netdev/20260406083536.839517-1-nb@tipi-net.de/
  v5: https://lore.kernel.org/netdev/20260328230513.415790-1-nb@tipi-net.de/
  v4: https://lore.kernel.org/netdev/20260323120539.136029-1-nb@tipi-net.de/
  v3: https://lore.kernel.org/netdev/20260319115402.353509-1-nb@tipi-net.de/
  v2: https://lore.kernel.org/netdev/20260315214914.1555777-1-nb@tipi-net.de/
  v1: https://lore.kernel.org/netdev/20260313092101.1344954-1-nb@tipi-net.de/

Changes since v7:
  - No code changes; resubmitted after net-next reopened.

Changes since v6:
  - Removed GENET_XDP_HEADROOM alias, use XDP_PACKET_HEADROOM
    directly. (Jakub Kicinski)
  - Dropped redundant __GFP_NOWARN from page_pool_alloc_pages(),
    page_pool adds it automatically. (Jakub Kicinski)
  - Removed floating code block in desc_rx, moved variables to outer
    scope. (Jakub Kicinski)
  - Make bcmgenet_run_xdp() return XDP_PASS when no program is set,
    removing the if (xdp_prog) indentation from desc_rx.
    (Jakub Kicinski)

Changes since v5:
  - Refactored desc_rx: always prepare xdp_buff and use
    bcmgenet_xdp_build_skb for both XDP and non-XDP paths, treating
    no-prog as XDP_PASS. (Jakub Kicinski)
  - Removed synchronize_net() before bpf_prog_put(), RCU handles
    the grace period. (Jakub Kicinski)
  - Save status->rx_csum before running XDP program to prevent
    bpf_xdp_adjust_head from corrupting the RSB checksum.
    (Jakub Kicinski)
  - Tightened TSB headroom check to include sizeof(struct xdp_frame).
    (Jakub Kicinski)
  - Fixed reclaim gating: check for pending frames on the XDP TX ring
    instead of priv->xdp_prog, so in-flight frames are still reclaimed
    after XDP program detach. (Jakub Kicinski)
  - Removed dead len -= ETH_FCS_LEN in patch 1. (Mohsin Bashir)
  - Added patch 7: minimal ndo_change_mtu that rejects MTU values
    incompatible with XDP when a program is attached. (Mohsin Bashir,
    Florian Fainelli)

Changes since v4:
  - Fixed unused variable warning: moved tx_ring declaration from
    patch 4 to patch 5 where it is first used. (Jakub Kicinski)

Changes since v3:
  - Fixed xdp_prepare_buff() called with meta_valid=false, causing
    bcmgenet_xdp_build_skb() to compute metasize=UINT_MAX and corrupt
    skb meta_len. Now passes true. (Simon Horman)
  - Removed bcmgenet_dump_tx_queue() for ring 16 in bcmgenet_timeout().
    Ring 16 has no netdev TX queue, so netdev_get_tx_queue(dev, 16)
    accessed beyond the allocated _tx array. (Simon Horman)
  - Fixed checkpatch alignment warnings in patches 4 and 5.

Changes since v2:
  - Fixed page leak on partial bcmgenet_alloc_rx_buffers() failure:
    free already-allocated rx_cbs before destroying page pool.
    (Simon Horman)
  - Fixed GENET_Q16_TX_BD_CNT defined as 64 instead of 32.
    (Simon Horman)
  - Moved XDP TX ring to a separate struct member (xdp_tx_ring)
    instead of expanding tx_rings[] to DESC_INDEX+1. (Justin Chen)
  - Added synchronize_net() before bpf_prog_put() in XDP prog swap.
  - Removed goto drop_page inside switch; inlined page_pool_put
    calls in each failure path. (Justin Chen)
  - Removed unnecessary curly braces around case XDP_TX. (Justin Chen)
  - Moved int err hoisting from patch 2 to patch 1. (Justin Chen)
  - Kept return type on same line as function name, per driver
    convention. (Justin Chen)
  - XDP TX packets/bytes now counted in TX reclaim for standard
    network statistics.

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

Nicolai Buchwitz (7):
  net: bcmgenet: convert RX path to page_pool
  net: bcmgenet: register xdp_rxq_info for each RX ring
  net: bcmgenet: add basic XDP support (PASS/DROP)
  net: bcmgenet: add XDP_TX support
  net: bcmgenet: add XDP_REDIRECT and ndo_xdp_xmit support
  net: bcmgenet: add XDP statistics counters
  net: bcmgenet: reject MTU changes incompatible with XDP

 drivers/net/ethernet/broadcom/Kconfig         |   1 +
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 637 +++++++++++++++---
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  19 +
 3 files changed, 559 insertions(+), 98 deletions(-)

--
2.51.0


