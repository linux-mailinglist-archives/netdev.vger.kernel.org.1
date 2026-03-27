Return-Path: <netdev+bounces-272355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJi2EMr5xWmOEwUAu9opvQ
	(envelope-from <netdev+bounces-272355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:30:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9394E33ECE1
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E87C3011862
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E6236C0D3;
	Fri, 27 Mar 2026 03:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="qiaK4ixx"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7106D36BCFD;
	Fri, 27 Mar 2026 03:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774582214; cv=none; b=M/395tIs5W6RoNzrsstPf76MoqovjGuEf6f4KEAKJLHsdwCfFZX/1rMCB4Z1piD2kubvfBIC7d1na8sTVl3dej3YHGNXIFqaFQ395fkaXp8dHVy2nVlrCP4KXqUmXtpcCP8eBP6hUWykGa0fa1LKS44c65SDQYsN1VkYZaE95lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774582214; c=relaxed/simple;
	bh=b81KdN662/X/cQnamq8uyRN4wBy0hvARXsNQJsKiJAk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KID47A8KdjXEPz3tnD8kgg4A3os2wvo4+OqvYw9WsVJxOB9U4bs1VAZljXL/xsZbCIWDZciFCAs8dmh1MAglVqh3gPQIq9lMOGF/9/TF9eFn4VcD6Pg7Q+0Yjt7GzqA/jxXIUoUOAkrpnlXfCS7FFCVh2X4o8iYaSJ8Ng07ETeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qiaK4ixx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62R3TkkV62864817, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774582186; bh=DFu5p6blwaTSpFrV/yKTr+hM46k87qhBmYMi69YJzP0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=qiaK4ixxVnJqEuhXpx4veOxZWnKCs1NeaPa0mN/aRxMgs+LY0IjfBkn2CvOd14HnC
	 BAZkYMaLAGVcys5i/ZWhr5OY/5h56leSGPIAhHp0KNIRd8+9WqT8s3MUAHQ/l4YHPK
	 B4EsjQpnKEvmG9NL7N3Meg6wdMl5mvFMjecysVYgcV75Fvv7fJAS1VtQ+KZpRwgnvR
	 ypX/m1h6hlbuV0bSuHvE5ufboRRKDJ8jPrINrKKdmbndU+ZIQcWSJpzHJ4hZ8Cr+XV
	 EFwBAC7widjAXb7Vt+Wu2OgKOsp4Q9GorgFkLl7i0ywrnnsWynGc4NiwTLDhQhz109
	 FSktu9iWgAipw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62R3TkkV62864817
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 11:29:46 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 27 Mar 2026 11:29:45 +0800
Received: from RTDOMAIN (172.21.43.26) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 27 Mar 2026 11:29:45 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net] rtase: Fix flow control configuration
Date: Fri, 27 Mar 2026 11:29:43 +0800
Message-ID: <20260327032943.58569-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.40.1
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
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[justinlai0215@realtek.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272355-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Queue-Id: 9394E33ECE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix hardware setting to allow flow control to be configured via
ethtool.

Fixes: 85dd839ad1e5 ("rtase: Implement hardware configuration function")
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase.h      | 4 ++++
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index b9209eb6ea73..9bd6872474c1 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -153,6 +153,10 @@ enum rtase_registers {
 #define RTASE_FORCE_TXFLOW_EN BIT(10)
 #define RTASE_RX_CHKSUM       BIT(5)
 
+	RTASE_GPHY_STD_00 = 0x6024,
+#define RTASE_RXFLOW_EN BIT(7)
+#define RTASE_TXFLOW_EN BIT(6)
+
 	RTASE_Q0_RX_DESC_ADDR0 = 0x00E4,
 	RTASE_Q0_RX_DESC_ADDR4 = 0x00E8,
 	RTASE_Q1_RX_DESC_ADDR0 = 0x4000,
diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index ef13109c49cf..bde9bccfb5a9 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -974,6 +974,9 @@ static void rtase_hw_config(struct net_device *dev)
 	rtase_hw_set_features(dev, dev->features);
 
 	/* enable flow control */
+	reg_data16 = rtase_r16(tp, RTASE_GPHY_STD_00);
+	reg_data16 &= ~(RTASE_TXFLOW_EN | RTASE_RXFLOW_EN);
+	rtase_w16(tp, RTASE_GPHY_STD_00, reg_data16);
 	reg_data16 = rtase_r16(tp, RTASE_CPLUS_CMD);
 	reg_data16 |= (RTASE_FORCE_TXFLOW_EN | RTASE_FORCE_RXFLOW_EN);
 	rtase_w16(tp, RTASE_CPLUS_CMD, reg_data16);
-- 
2.40.1


