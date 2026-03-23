Return-Path: <netdev+bounces-270382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULbbCe/jwGkbOQQAu9opvQ
	(envelope-from <netdev+bounces-270382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 07:55:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA762ED314
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 07:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B9503004CBD
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 06:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBA93431F5;
	Mon, 23 Mar 2026 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="r26to+PX"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B26420459A;
	Mon, 23 Mar 2026 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774248936; cv=none; b=nvIDcLDtUrssLCzbocDv/FV3vWspSptDvup3NWLAu6UWOwt4ZQZR4WgQJyUiD99Aoszo8EIRFSgprw8RAa0Fb08BOEDfD8j53XafD7LfbAUoZf7+agrVCXIM3TM1UfrSAtmjiab+q68HlozoIDEjsHce32w1xaHGpLwjEiSvtdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774248936; c=relaxed/simple;
	bh=VNGImsJ5QDYPOhZKbld237FsmAGrTdlnphqyJ8mkbyg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EjKBoEVV4dqEMvWde0w8rBfCtA/6fgTrQ85CCooJ12SDO7ekbyrDIdBxtpRBtUgCh1kI9Qy0Ua5f21ReyeB6Gu6YiT5Yh+A8nrSukG31MsqcD4iERvpeRcho6R+8L9s7/NPTfqPndjZhIBt15ujTR0/orZb9BpBTbtlWlkaWhDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=r26to+PX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774248935; x=1805784935;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VNGImsJ5QDYPOhZKbld237FsmAGrTdlnphqyJ8mkbyg=;
  b=r26to+PXYXbgVNpp48KJxibwUFGNb9VlYl/NkLDIwc9pTMm1SlmYET0f
   mWBbNScdzR6z63i3ZmW//0x+zMc9y/P7UI8PEm7VJzCq+vLibkezQATKW
   Fufd4nBggCD5MQ4pwbPONjLvgQl693t//tnOPp9EdGQyTfX8yWRl/HU2P
   FmbNZPkRJlU3WyazPfASlJV4sdVFqhODFf88Qz0UTR0f45wdLSpyjheq2
   ECZn5tW1y6iKdku9l9CcZi9QsfXQZEn4a3LHLUU1wFWmgIzRsxSLEP51x
   OzDURIuvejkiLSO2emTCJskZjcHP8ZjZjPP3SwVOZCa7bxFbKy4cMxL09
   w==;
X-CSE-ConnectionGUID: cY9Y8xw8Sl246yuRcnnIog==
X-CSE-MsgGUID: 7OqT8G+MRh+aiaA46XyVTg==
X-IronPort-AV: E=Sophos;i="6.23,136,1770620400"; 
   d="scan'208";a="55041008"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2026 23:54:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sun, 22 Mar 2026 23:53:57 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Sun, 22 Mar 2026 23:53:53 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux@armlinux.org.uk>,
	<Raju.Lakkaraju@microchip.com>, <maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: lan743x: fix duplex configuration in mac_link_up
Date: Mon, 23 Mar 2026 12:23:45 +0530
Message-ID: <20260323065345.144915-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270382-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1DA762ED314
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver does not explicitly configure the MAC duplex mode when
bringing the link up. As a result, the MAC may retain a stale duplex
setting from a previous link state, leading to duplex mismatches with
the link partner and degraded network performance.

Update lan743x_phylink_mac_link_up() to set or clear the MAC_CR_DPX_
bit according to the negotiated duplex mode.

This ensures the MAC configuration is consistent with the phylink
resolved state.

Fixes: a5f199a8d8a03 ("net: lan743x: Migrate phylib to phylink")
Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 866f6a3da0d9..2939b5e933d2 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3056,6 +3056,11 @@ static void lan743x_phylink_mac_link_up(struct phylink_config *config,
 	else if (speed == SPEED_100)
 		mac_cr |= MAC_CR_CFG_L_;
 
+	if (duplex == DUPLEX_FULL)
+		mac_cr |= MAC_CR_DPX_;
+	else
+		mac_cr &= ~MAC_CR_DPX_;
+
 	lan743x_csr_write(adapter, MAC_CR, mac_cr);
 
 	lan743x_ptp_update_latency(adapter, speed);
-- 
2.34.1


