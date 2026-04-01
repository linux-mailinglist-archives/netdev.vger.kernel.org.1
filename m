Return-Path: <netdev+bounces-274074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KjUIc0LzWnhZgYAu9opvQ
	(envelope-from <netdev+bounces-274074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:13:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8909D37A3F9
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF571307F71B
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 12:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C722F3C7E05;
	Wed,  1 Apr 2026 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="MthuQN5U"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F41D372661;
	Wed,  1 Apr 2026 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044851; cv=none; b=nRGC1AXUtE1D+VtIflnWTjlcV1u3Dbuo8m+aLQ0NdA8GdXAgMLro2eHhFc7LQB1RSJytg3WH8gmJ0zMh14AZ0OVlCzFjf37zfE/XXB458BxwWDx7GApTxLRjg3iSP6Ys4YYQBbFqDg461lYdUT07GH1ag8YfWeuNnUbT+rJanGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044851; c=relaxed/simple;
	bh=/XVIYgs8c1K0hkydh6nKHYEu03DUZJv/Npx79K6spMQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=knrtHwyEDswH4+cb4g5o6ezbx07ptqYXEIdKycocgiE+0ZTpARBTyO4yKRdXoyukYkzDgzjSuYtPDS/ysxaPcf20di9aUf6SgXpjXiLw3buPJlGJ3kSQPqvUgDz4HNLnsq9SgXXC/UXh2pVfDKqPVLMnzdDfom/m9rGMf/AzKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=MthuQN5U; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 631C0JpiC1033663, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775044819; bh=4rEODMMXW5a9qKNeOVjFTfXYt/R/mm+wrGelqwPbXuo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=MthuQN5Uw2U1dGlbj27XlM2i+65JIxqYGC72RL5+fY8IDIlJwo8tX7kmnD0wi0Qst
	 oj+YGz0nPh5rrQKstZbrvCf9j9SW2m54QcQmwENWxyWio5t0aGXxJwVY+fGgEfaLeL
	 DzzbuWLxwMy4QhYSonCqwACJ1xAl6ReWM8NM34NUQqy6pd7eV4ccY97akFjT7mh52U
	 VO+9XytASa9t7APG62Nqu9lkvbeAXPdAcdTtH93z8SCxK0XB7ZMyWzkfxdTlny4nz7
	 lpx7W2T3/tDvC88jwnBORX10EXnNyeLR+LNm8XY/lvNgqXWeMVjh8z+m+nFuo8vhVW
	 6qmwCIlW3HPxA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 631C0JpiC1033663
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 20:00:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 1 Apr 2026 20:00:17 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 1 Apr 2026 19:55:56 +0800
Received: from fc40.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Wed, 1 Apr 2026 19:55:56 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
        Chih Kai Hsu
	<hsu.chih.kai@realtek.com>
Subject: [PATCH net-next] r8152: Add helper functions for SRAM2
Date: Wed, 1 Apr 2026 19:55:41 +0800
Message-ID: <20260401115542.34601-1-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[hsu.chih.kai@realtek.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-274074-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8909D37A3F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the following helper functions for SRAM2 access to simplify the code
and improve readability:

- sram2_write() - write data to SRAM2 address
- sram2_read() - read data from SRAM2 address
- sram2_write_w0w1() - read-modify-write operation

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 178 +++++++++++++++++-----------------------
 1 file changed, 75 insertions(+), 103 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 8747c55e0a48..1765da5bd6cf 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -213,6 +213,8 @@
 #define OCP_PHY_PATCH_STAT	0xb800
 #define OCP_PHY_PATCH_CMD	0xb820
 #define OCP_PHY_LOCK		0xb82e
+#define OCP_SRAM2_ADDR		0xb87c
+#define OCP_SRAM2_DATA		0xb87e
 #define OCP_ADC_IOFFSET		0xbcfc
 #define OCP_ADC_CFG		0xbc06
 #define OCP_SYSCLK_CFG		0xc416
@@ -1764,6 +1766,27 @@ static void sram_set_bits(struct r8152 *tp, u16 addr, u16 set)
 	sram_write_w0w1(tp, addr, 0, set);
 }
 
+static void sram2_write(struct r8152 *tp, u16 addr, u16 data)
+{
+	ocp_reg_write(tp, OCP_SRAM2_ADDR, addr);
+	ocp_reg_write(tp, OCP_SRAM2_DATA, data);
+}
+
+static u16 sram2_read(struct r8152 *tp, u16 addr)
+{
+	ocp_reg_write(tp, OCP_SRAM2_ADDR, addr);
+	return ocp_reg_read(tp, OCP_SRAM2_DATA);
+}
+
+static void sram2_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
+{
+	u16 data;
+
+	data = sram2_read(tp, addr);
+	data = (data & ~clear) | set;
+	ocp_reg_write(tp, OCP_SRAM2_DATA, data);
+}
+
 static void r8152_mdio_clr_bit(struct r8152 *tp, u16 addr, u16 clear)
 {
 	int data;
@@ -7195,16 +7218,12 @@ static void r8156_hw_phy_cfg(struct r8152 *tp)
 		ocp_reg_write(tp, 0xad4c, 0x00a8);
 		ocp_reg_write(tp, 0xac5c, 0x01ff);
 		ocp_reg_w0w1(tp, 0xac8a, 0xf0, BIT(4) | BIT(5));
-		ocp_reg_write(tp, 0xb87c, 0x8157);
-		ocp_reg_w0w1(tp, 0xb87e, 0xff00, 0x0500);
-		ocp_reg_write(tp, 0xb87c, 0x8159);
-		ocp_reg_w0w1(tp, 0xb87e, 0xff00, 0x0700);
+		sram2_write_w0w1(tp, 0x8157, 0xff00, 0x0500);
+		sram2_write_w0w1(tp, 0x8159, 0xff00, 0x0700);
 
 		/* AAGC */
-		ocp_reg_write(tp, 0xb87c, 0x80a2);
-		ocp_reg_write(tp, 0xb87e, 0x0153);
-		ocp_reg_write(tp, 0xb87c, 0x809c);
-		ocp_reg_write(tp, 0xb87e, 0x0153);
+		sram2_write(tp, 0x80a2, 0x0153);
+		sram2_write(tp, 0x809c, 0x0153);
 
 		/* EEE parameter */
 		ocp_write_word(tp, MCU_TYPE_PLA, PLA_EEE_TXTWSYS_2P5G, 0x0056);
@@ -7402,82 +7421,48 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 		ocp_reg_write(tp, 0xacc8, 0xa0d3);
 		ocp_reg_write(tp, 0xad08, 0x0007);
 
-		ocp_reg_write(tp, 0xb87c, 0x8560);
-		ocp_reg_write(tp, 0xb87e, 0x19cc);
-		ocp_reg_write(tp, 0xb87c, 0x8562);
-		ocp_reg_write(tp, 0xb87e, 0x19cc);
-		ocp_reg_write(tp, 0xb87c, 0x8564);
-		ocp_reg_write(tp, 0xb87e, 0x19cc);
-		ocp_reg_write(tp, 0xb87c, 0x8566);
-		ocp_reg_write(tp, 0xb87e, 0x147d);
-		ocp_reg_write(tp, 0xb87c, 0x8568);
-		ocp_reg_write(tp, 0xb87e, 0x147d);
-		ocp_reg_write(tp, 0xb87c, 0x856a);
-		ocp_reg_write(tp, 0xb87e, 0x147d);
-		ocp_reg_write(tp, 0xb87c, 0x8ffe);
-		ocp_reg_write(tp, 0xb87e, 0x0907);
-		ocp_reg_write(tp, 0xb87c, 0x80d6);
-		ocp_reg_write(tp, 0xb87e, 0x2801);
-		ocp_reg_write(tp, 0xb87c, 0x80f2);
-		ocp_reg_write(tp, 0xb87e, 0x2801);
-		ocp_reg_write(tp, 0xb87c, 0x80f4);
-		ocp_reg_write(tp, 0xb87e, 0x6077);
+		sram2_write(tp, 0x8560, 0x19cc);
+		sram2_write(tp, 0x8562, 0x19cc);
+		sram2_write(tp, 0x8564, 0x19cc);
+		sram2_write(tp, 0x8566, 0x147d);
+		sram2_write(tp, 0x8568, 0x147d);
+		sram2_write(tp, 0x856a, 0x147d);
+		sram2_write(tp, 0x8ffe, 0x0907);
+		sram2_write(tp, 0x80d6, 0x2801);
+		sram2_write(tp, 0x80f2, 0x2801);
+		sram2_write(tp, 0x80f4, 0x6077);
 		ocp_reg_write(tp, 0xb506, 0x01e7);
 
-		ocp_reg_write(tp, 0xb87c, 0x8013);
-		ocp_reg_write(tp, 0xb87e, 0x0700);
-		ocp_reg_write(tp, 0xb87c, 0x8fb9);
-		ocp_reg_write(tp, 0xb87e, 0x2801);
-		ocp_reg_write(tp, 0xb87c, 0x8fba);
-		ocp_reg_write(tp, 0xb87e, 0x0100);
-		ocp_reg_write(tp, 0xb87c, 0x8fbc);
-		ocp_reg_write(tp, 0xb87e, 0x1900);
-		ocp_reg_write(tp, 0xb87c, 0x8fbe);
-		ocp_reg_write(tp, 0xb87e, 0xe100);
-		ocp_reg_write(tp, 0xb87c, 0x8fc0);
-		ocp_reg_write(tp, 0xb87e, 0x0800);
-		ocp_reg_write(tp, 0xb87c, 0x8fc2);
-		ocp_reg_write(tp, 0xb87e, 0xe500);
-		ocp_reg_write(tp, 0xb87c, 0x8fc4);
-		ocp_reg_write(tp, 0xb87e, 0x0f00);
-		ocp_reg_write(tp, 0xb87c, 0x8fc6);
-		ocp_reg_write(tp, 0xb87e, 0xf100);
-		ocp_reg_write(tp, 0xb87c, 0x8fc8);
-		ocp_reg_write(tp, 0xb87e, 0x0400);
-		ocp_reg_write(tp, 0xb87c, 0x8fca);
-		ocp_reg_write(tp, 0xb87e, 0xf300);
-		ocp_reg_write(tp, 0xb87c, 0x8fcc);
-		ocp_reg_write(tp, 0xb87e, 0xfd00);
-		ocp_reg_write(tp, 0xb87c, 0x8fce);
-		ocp_reg_write(tp, 0xb87e, 0xff00);
-		ocp_reg_write(tp, 0xb87c, 0x8fd0);
-		ocp_reg_write(tp, 0xb87e, 0xfb00);
-		ocp_reg_write(tp, 0xb87c, 0x8fd2);
-		ocp_reg_write(tp, 0xb87e, 0x0100);
-		ocp_reg_write(tp, 0xb87c, 0x8fd4);
-		ocp_reg_write(tp, 0xb87e, 0xf400);
-		ocp_reg_write(tp, 0xb87c, 0x8fd6);
-		ocp_reg_write(tp, 0xb87e, 0xff00);
-		ocp_reg_write(tp, 0xb87c, 0x8fd8);
-		ocp_reg_write(tp, 0xb87e, 0xf600);
+		sram2_write(tp, 0x8013, 0x0700);
+		sram2_write(tp, 0x8fb9, 0x2801);
+		sram2_write(tp, 0x8fba, 0x0100);
+		sram2_write(tp, 0x8fbc, 0x1900);
+		sram2_write(tp, 0x8fbe, 0xe100);
+		sram2_write(tp, 0x8fc0, 0x0800);
+		sram2_write(tp, 0x8fc2, 0xe500);
+		sram2_write(tp, 0x8fc4, 0x0f00);
+		sram2_write(tp, 0x8fc6, 0xf100);
+		sram2_write(tp, 0x8fc8, 0x0400);
+		sram2_write(tp, 0x8fca, 0xf300);
+		sram2_write(tp, 0x8fcc, 0xfd00);
+		sram2_write(tp, 0x8fce, 0xff00);
+		sram2_write(tp, 0x8fd0, 0xfb00);
+		sram2_write(tp, 0x8fd2, 0x0100);
+		sram2_write(tp, 0x8fd4, 0xf400);
+		sram2_write(tp, 0x8fd6, 0xff00);
+		sram2_write(tp, 0x8fd8, 0xf600);
 
 		ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_USB_CFG,
 				  EN_XG_LIP | EN_G_LIP);
 
-		ocp_reg_write(tp, 0xb87c, 0x813d);
-		ocp_reg_write(tp, 0xb87e, 0x390e);
-		ocp_reg_write(tp, 0xb87c, 0x814f);
-		ocp_reg_write(tp, 0xb87e, 0x790e);
-		ocp_reg_write(tp, 0xb87c, 0x80b0);
-		ocp_reg_write(tp, 0xb87e, 0x0f31);
+		sram2_write(tp, 0x813d, 0x390e);
+		sram2_write(tp, 0x814f, 0x790e);
+		sram2_write(tp, 0x80b0, 0x0f31);
 		ocp_reg_set_bits(tp, 0xbf4c, BIT(1));
 		ocp_reg_set_bits(tp, 0xbcca, BIT(9) | BIT(8));
-		ocp_reg_write(tp, 0xb87c, 0x8141);
-		ocp_reg_write(tp, 0xb87e, 0x320e);
-		ocp_reg_write(tp, 0xb87c, 0x8153);
-		ocp_reg_write(tp, 0xb87e, 0x720e);
-		ocp_reg_write(tp, 0xb87c, 0x8529);
-		ocp_reg_write(tp, 0xb87e, 0x050e);
+		sram2_write(tp, 0x8141, 0x320e);
+		sram2_write(tp, 0x8153, 0x720e);
+		sram2_write(tp, 0x8529, 0x050e);
 		ocp_reg_clr_bits(tp, OCP_EEE_CFG, CTAP_SHORT_EN);
 
 		sram_write(tp, 0x816c, 0xc4a0);
@@ -7489,27 +7474,17 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 		sram_write(tp, 0x8ff1, 0x0404);
 
 		ocp_reg_write(tp, 0xbf4a, 0x001b);
-		ocp_reg_write(tp, 0xb87c, 0x8033);
-		ocp_reg_write(tp, 0xb87e, 0x7c13);
-		ocp_reg_write(tp, 0xb87c, 0x8037);
-		ocp_reg_write(tp, 0xb87e, 0x7c13);
-		ocp_reg_write(tp, 0xb87c, 0x803b);
-		ocp_reg_write(tp, 0xb87e, 0xfc32);
-		ocp_reg_write(tp, 0xb87c, 0x803f);
-		ocp_reg_write(tp, 0xb87e, 0x7c13);
-		ocp_reg_write(tp, 0xb87c, 0x8043);
-		ocp_reg_write(tp, 0xb87e, 0x7c13);
-		ocp_reg_write(tp, 0xb87c, 0x8047);
-		ocp_reg_write(tp, 0xb87e, 0x7c13);
-
-		ocp_reg_write(tp, 0xb87c, 0x8145);
-		ocp_reg_write(tp, 0xb87e, 0x370e);
-		ocp_reg_write(tp, 0xb87c, 0x8157);
-		ocp_reg_write(tp, 0xb87e, 0x770e);
-		ocp_reg_write(tp, 0xb87c, 0x8169);
-		ocp_reg_write(tp, 0xb87e, 0x0d0a);
-		ocp_reg_write(tp, 0xb87c, 0x817b);
-		ocp_reg_write(tp, 0xb87e, 0x1d0a);
+		sram2_write(tp, 0x8033, 0x7c13);
+		sram2_write(tp, 0x8037, 0x7c13);
+		sram2_write(tp, 0x803b, 0xfc32);
+		sram2_write(tp, 0x803f, 0x7c13);
+		sram2_write(tp, 0x8043, 0x7c13);
+		sram2_write(tp, 0x8047, 0x7c13);
+
+		sram2_write(tp, 0x8145, 0x370e);
+		sram2_write(tp, 0x8157, 0x770e);
+		sram2_write(tp, 0x8169, 0x0d0a);
+		sram2_write(tp, 0x817b, 0x1d0a);
 
 		sram_write_w0w1(tp, 0x8217, 0xff00, 0x5000);
 		sram_write_w0w1(tp, 0x821a, 0xff00, 0x5000);
@@ -7574,12 +7549,9 @@ static void r8156b_hw_phy_cfg(struct r8152 *tp)
 		fallthrough;
 	case RTL_VER_15:
 		/* EEE parameter */
-		ocp_reg_write(tp, 0xb87c, 0x80f5);
-		ocp_reg_write(tp, 0xb87e, 0x760e);
-		ocp_reg_write(tp, 0xb87c, 0x8107);
-		ocp_reg_write(tp, 0xb87e, 0x360e);
-		ocp_reg_write(tp, 0xb87c, 0x8551);
-		ocp_reg_w0w1(tp, 0xb87e, 0xff00, 0x0800);
+		sram2_write(tp, 0x80f5, 0x760e);
+		sram2_write(tp, 0x8107, 0x360e);
+		sram2_write_w0w1(tp, 0x8551, 0xff00, 0x0800);
 
 		/* ADC_PGA parameter */
 		ocp_reg_w0w1(tp, 0xbf00, 0xe000, 0xa000);
-- 
2.34.1


