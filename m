Return-Path: <netdev+bounces-269422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qORiLhTku2njpQIAu9opvQ
	(envelope-from <netdev+bounces-269422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:55:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7A62CAAE7
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76E32300492B
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55843CC9E4;
	Thu, 19 Mar 2026 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="cWvR8en9"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379663CCA02;
	Thu, 19 Mar 2026 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921297; cv=none; b=Ol7QwDMtezSzwAgs03kYfIyZQG+VyLC8WlMwqcEudWEdhz29cY26GzZ44Y0ixxyq0pCTL6T44uG7CBaccA5XbrNa3IDfHprEFmv1PqS2KFfQVhTPK/DN5ePeWN8tO/RmLp2MyeAc+mRsOa3EGfCQfZ71VBMV8VjLZ+4qcJzOYsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921297; c=relaxed/simple;
	bh=KDcymmvFDzps4LbZjcmQ9+FgLTLRbkLJeGLPiDnj7gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mohwPXl2Tx6kZ8A1w9eaw2VHzKabx6b6Rn0/fD5vuB+hlrMsI5HhfeGot4nqvm0P1HTvrtf2HNkzhgXYQsqZ1MOjL7qFF33RXOiXcT5CttMxu6sQPuocXi4vn+7ZoTF6DYj5Q7svz+crmMQxodjF2sNTqs0+jEsHaTnnoXYMCl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=cWvR8en9; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D0BFA56FA;
	Thu, 19 Mar 2026 12:54:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773921283; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=jRXsXD3lv/IMC5CqgPXeG8Ah1ReClDBWhZtnvl7yZMA=;
	b=cWvR8en9ipFIKDGSdyET2cxoVh/Wfol7Qyv1zICAZbU4/3hha3zzvmJOOSzBQb8BOt62eV
	bSJuWU/kbEo4iXjBniSQE10NfG4Yz6BHuTelCOgouC/ZBfYA3xjNJSZgIFSmul0IQRUWlP
	LVd0WT0ESiPxoBkOKKejLGc8oh5hkCCo1LIybwLbYB47vXWP3CDOV1zjPOc1ae9NR7rC6g
	ha/eQVCYEWTwJFckmKMAmDwxck/OQ2IIwFyQGWTmn9HthugdRU0bGjr1wvvmg3WO0gpbZB
	5zAYhXX3wL9b2BcF3nfgHZg52zsFtyq+iC3OwG1phzrP1UFnA78zY58kRpEBqg==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Nicolai Buchwitz <nb@tipi-net.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 0/6] net: bcmgenet: add XDP support
Date: Thu, 19 Mar 2026 12:53:53 +0100
Message-ID: <20260319115402.353509-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269422-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[tipi-net.de,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-0.956];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,xdp.py:url]
X-Rspamd-Queue-Id: 5E7A62CAAE7
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
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 608 +++++++++++++++---
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  20 +-
 3 files changed, 537 insertions(+), 92 deletions(-)

--
2.51.0


