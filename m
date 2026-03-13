Return-Path: <netdev+bounces-267342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKhCBxzXs2mzbgAAu9opvQ
	(envelope-from <netdev+bounces-267342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:21:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A853B28061D
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98EC03017254
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CBD33F5BC;
	Fri, 13 Mar 2026 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="pfE7c0x7"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561C7283CB1;
	Fri, 13 Mar 2026 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393689; cv=none; b=RDqFslDRyPPbSzqxigfODuvwgvZwlK6zIvCfJw8p0uYqX5gllsoMQWplctyMqqF6V0CKWe5rUFewy2qRHXpD4YI9fKVkSMrDZjVLftbcPp5KxG3EHBP/pwCDYORBFtks4DtzWzXo888sFeXLOQyQaUwgqQaMMg73j/S+/qu2750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393689; c=relaxed/simple;
	bh=Wxb2u96KoePw869ffsam6tjeZ/4nyHjobdEGPPgNXFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=exZpMA2LzQV3DfJfcyiUEb2ixVWapbLtTODn29Mw7iB6cbhQ87/adroICAygxPIkCZ5APCn0HdI+tSfwCgJL3kn0292HOQ1i2R2zHgDGMXdorijaSoagGZdN6avIuvyeylO16gg8vjoyovdEndDCV2RKz6XdstOnu7fc66it250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=pfE7c0x7; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A6F2CA20FA;
	Fri, 13 Mar 2026 10:21:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773393678; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=vXxZA4KpuJLnz7J4K96OCL4loTIcUeOjHbr5+Mu7vUI=;
	b=pfE7c0x7HO3gko7HTczZ6nfoac53imLjtIn7X51nix1q5itSGglrP0Rz6meDu9E/rIRljQ
	ilhMRtB4X/5cA/c1RlLrBkXKAOdiPBGGswxnqerx7pEKUwFIyjR0YlvYvRqGG+gw5Lx2Gv
	kpNG587mLNFI2nDPTQ0j6wY9P2CsC3Q6SFNADkgSi2cg+v0+d8HKnZ0jiL7KOpGhsVH405
	qJcFhUion5siNHR3X2n9K/8bsGHJqo0lc6c1A1zuQWn5rkFIVunbcU5eIwMgHlVH2QU5CZ
	qgZYcpj6VMx5FsB9WMcV8HcbGWylXzU/h5+5r6t8BRrt8pxXuf9rqnWsb3w9bA==
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
Subject: [PATCH net-next 0/6] net: bcmgenet: add XDP support
Date: Fri, 13 Mar 2026 10:20:55 +0100
Message-ID: <20260313092101.1344954-1-nb@tipi-net.de>
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
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-267342-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A853B28061D
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

Nicolai Buchwitz (6):
  net: bcmgenet: convert RX path to page_pool
  net: bcmgenet: register xdp_rxq_info for each RX ring
  net: bcmgenet: add basic XDP support (PASS/DROP)
  net: bcmgenet: add XDP_TX support
  net: bcmgenet: add XDP_REDIRECT and ndo_xdp_xmit support
  net: bcmgenet: add XDP statistics counters

 drivers/net/ethernet/broadcom/Kconfig         |   1 +
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 484 +++++++++++++++---
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  17 +
 3 files changed, 425 insertions(+), 77 deletions(-)

-- 
2.51.0


