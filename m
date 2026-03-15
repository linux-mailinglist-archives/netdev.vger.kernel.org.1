Return-Path: <netdev+bounces-267968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IClCOMMpt2kLNQEAu9opvQ
	(envelope-from <netdev+bounces-267968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 22:50:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 470C5292B78
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 22:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D5DD301379D
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 21:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B76137C109;
	Sun, 15 Mar 2026 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="a2pZBRDD"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049C737754B;
	Sun, 15 Mar 2026 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773611408; cv=none; b=qLEFUHJHQh0mRQosSAtSO42KlLCbrqWlHhkiztCI9Lan/rvvNvEb+2gwqfrTogPPVTbB8I1J64zlKJTN178RIXvifhY/mzDbjeSVlBXFIUB1s7+fi2NJwvpB9bEFIucLXvWstpUfmIDrNoRmcZKLQrBcZjhcr49mEwoS+FYZ37U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773611408; c=relaxed/simple;
	bh=d+WIJIXyXTkDIv/eHNe+vwweu639NsTf18saykCWjls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tMukStGK/k8Re8m34PmLyRo4/XjxgBcPnpNFM39tBl4gmOMs0Z12p3gGYsbslZwmXYyndpoMkt/bvzdTjK6ZjYA9P0pm7ncfbM4A6WppGE3EEXQWX8fQGk2jPsfkr7PLsMpVApXssm/nvZjwxR/llgZVJu8VXDFwr+nzqbUjv5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=a2pZBRDD; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 29938A0304;
	Sun, 15 Mar 2026 22:49:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773611397; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=u0vASF/3eYmA3ofjMgZY9cyEbjg2KFkibsZbj/8hDVQ=;
	b=a2pZBRDDybGOPrz/4C2YOacdDQrCt/fKKh9yrXCk1vXCZx9+68L6eDCA7npYeH0LZDfr9s
	cFwAQJ+igm1iTn+WVv6KShIOEwrXh0TDVparluzSx6ejrssK6fRMXVwY2hixKf/bY2bkHR
	6yVDd0aLOMECpS9MoC1jzDzMZi4MKDFRW0O1/PnkFnETh0qdl5Iqw3QSHZSmZukFEKyz5n
	Q1tJ7RCnycdNLurW8kbY7NQEDP6QzJ/uA+FNQlqWqLevq0LPfPnP9jpbBOhmYMTru3YMzw
	/c3o8HKBN0VQYgVhsx7SJ6n7FaTat2wCS6RZ2g9EwhA9xWorVcEavo2GfoNFaw==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Markus=20Bl=C3=B6chl?= <mbloch@rooftopnetworks.de>,
	Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v2 0/6] net: bcmgenet: add XDP support
Date: Sun, 15 Mar 2026 22:49:08 +0100
Message-ID: <20260315214914.1555777-1-nb@tipi-net.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tipi-net.de];
	TAGGED_FROM(0.00)[bounces-267968-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,rooftopnetworks.de,arndb.de,vger.kernel.org,tipi-net.de];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:dkim,tipi-net.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 470C5292B78
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
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 607 +++++++++++++++---
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  20 +-
 3 files changed, 536 insertions(+), 92 deletions(-)

-- 
2.51.0


