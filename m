Return-Path: <netdev+bounces-284492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C6aNTkV+mlRJAMAu9opvQ
	(envelope-from <netdev+bounces-284492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:05:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F704D0DA1
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8BF2630422B2
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 15:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7DA48B388;
	Tue,  5 May 2026 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="gZy73bsS";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Vvj1h9Y6"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C322748B375;
	Tue,  5 May 2026 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996604; cv=none; b=WAxdWmCNr0+EGvzRx+impsqNUq1CMhGg6g9RHMehG9I+xj4LyNTY8ttrSmtXzHdmi/3c7c3rxdgfwHum5PUB9BJA0JU7o2SWjQclmxTyQ6/DW049FyDNBnPDeAheVMwzzU+2jd8UjJ9kgfabkCsD0ADMm7bY6FlcwoBYtir+9Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996604; c=relaxed/simple;
	bh=P/nWth4JdW9U9oijroHIeR3esaQQeQ+oA9kKEBeJmFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WTdQJA/ZNw9g1eg/3eQ1UdfynG3zm+Du/HKPf6oGJZOVdSuYkiIxzAf7Zc8TfjPgiHAchhVnVfuttK24cXwm1D8zsJCdM43IA5dhwRdPZTWtgRBJlEhf6H23mb+K4z5zGJc/gQAf9hdsAAir7vx0DHoVa9O8zqsMRnXQ3n1zLFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=gZy73bsS; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Vvj1h9Y6; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777996601;
	bh=P/nWth4JdW9U9oijroHIeR3esaQQeQ+oA9kKEBeJmFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gZy73bsSTAq6574LDxLmLYrhytj6+9zI4qQEzgHDAWGfCYRoR+1zCH5UxG7UlIAZT
	 Rv9M63yW/r1h4sKZprrBx0haXf79KgFpD2wKsKLxnE9aZ/xGPqJy5Y19M6iSdMe1rM
	 eT6CZotcbVqYolprg6K7L9YL8X2twMdaPTtn2ohPqwtjBHk3FlW6O9SsM9XgrDihDb
	 XVB4ldUciAejrjVUtLAMGfdZKvOpyz20BGq3ajoSbOdl3S9Z7pTurkfYm9rcE/6YC1
	 JVwMqzGQFRPrj4pJiSb0gRwvBbBd2VJ0+EGBqcJ+FQNjEWmUgM/tVRd26FnId3AYOq
	 CDmGmQCcCgcsg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 40E41425FD; Tue,  5 May 2026 15:56:41 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777996598;
	bh=P/nWth4JdW9U9oijroHIeR3esaQQeQ+oA9kKEBeJmFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vvj1h9Y6hu/NGgWJpf52X5wlIIGScNAU4CKAUn8ZgWntQJo+jiEYTCUkNWpZ+JTH1
	 OL6hIB8xspxqMmjqUOyckO5qKnPoByirigs/Ed0lTC+BxshNtr+Zu8lYs4iN5VIcMx
	 R70IDajwUUZHNzOBWzOJ1EBuq0fnlHBPg5givZH045mj8HI0wi7oh/swSrZEBRcg5j
	 29gtbiyRA6oMLH09bIkiICw2ngDtIo9tRskBWce4blFb7S1EabVksZQTcoNRTxaSqz
	 L73TVLvwxDDc350vTkTdDQ1aFB6g9eVkvGUyT1lXEu95XfPyb1WeO3njewQ5gD2ML0
	 b4AHgfxIPnxWg==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 0EA8142498;
	Tue,  5 May 2026 15:56:38 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 05 May 2026 17:56:35 +0200
Subject: [PATCH net-next v4 3/3] r8152: Add firmware upload capability for
 RTL8157/RTL8159
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-rtl8159_net_next-v4-3-1a648a9c4d8d@birger-koblitz.de>
References: <20260505-rtl8159_net_next-v4-0-1a648a9c4d8d@birger-koblitz.de>
In-Reply-To: <20260505-rtl8159_net_next-v4-0-1a648a9c4d8d@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>, 
 Birger Koblitz <mail@birger-koblitz.de>, 
 Aleksander Jan Bajkowski <olek2@wp.pl>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: D9F704D0DA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,realtek.com,birger-koblitz.de,wp.pl];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284492-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wp.pl:email,birger-koblitz.de:email,birger-koblitz.de:dkim,birger-koblitz.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

The RTL8159 (RTL_VER_17) requires firmware for its PHY in order to work
at connection speeds > 5GBit. Add support for uploading firmware for
the PHY using the existing rtl8152_apply_firmware() function
in r8157_hw_phy_cfg() and set up the correct names for the firmware
files.

This also adds support for uploading firmware for the RTL8157
(RTL_VER_16) PHY, for which firmware is however not strictly necessary
to work. Still, this allows to upload newer versions of the firmware used
by this chip, e.g. to improve interoperability.

If no firmware is found, both the RTL8157 and the RTL8159 will continue
to work.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Tested-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/usb/r8152.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 1e7f20348ac6def85106f1e8bab93a377980c77d..d281ad5ed78eded01876c6064aed95e1f78cfc05 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -4663,10 +4663,11 @@ static bool rtl8152_is_fw_phy_speed_up_ok(struct r8152 *tp, struct fw_phy_speed_
 	case RTL_VER_11:
 	case RTL_VER_12:
 	case RTL_VER_14:
-	case RTL_VER_16:
 		goto out;
 	case RTL_VER_13:
 	case RTL_VER_15:
+	case RTL_VER_16:
+	case RTL_VER_17:
 	default:
 		break;
 	}
@@ -7982,12 +7983,14 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 	data = r8153_phy_status(tp, 0);
 	switch (data) {
 	case PHY_STAT_EXT_INIT:
+		rtl8152_apply_firmware(tp, true);
 		ocp_reg_clr_bits(tp, 0xa466, BIT(0));
 		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
 		break;
 	case PHY_STAT_LAN_ON:
 	case PHY_STAT_PWRDN:
 	default:
+		rtl8152_apply_firmware(tp, false);
 		break;
 	}
 
@@ -9926,6 +9929,8 @@ static int rtl_ops_init(struct r8152 *tp)
 #define FIRMWARE_8153C_1	"rtl_nic/rtl8153c-1.fw"
 #define FIRMWARE_8156A_2	"rtl_nic/rtl8156a-2.fw"
 #define FIRMWARE_8156B_2	"rtl_nic/rtl8156b-2.fw"
+#define FIRMWARE_8157_1		"rtl_nic/rtl8157-1.fw"
+#define FIRMWARE_8159_1		"rtl_nic/rtl8159-1.fw"
 
 MODULE_FIRMWARE(FIRMWARE_8153A_2);
 MODULE_FIRMWARE(FIRMWARE_8153A_3);
@@ -9934,6 +9939,8 @@ MODULE_FIRMWARE(FIRMWARE_8153B_2);
 MODULE_FIRMWARE(FIRMWARE_8153C_1);
 MODULE_FIRMWARE(FIRMWARE_8156A_2);
 MODULE_FIRMWARE(FIRMWARE_8156B_2);
+MODULE_FIRMWARE(FIRMWARE_8157_1);
+MODULE_FIRMWARE(FIRMWARE_8159_1);
 
 static int rtl_fw_init(struct r8152 *tp)
 {
@@ -9972,6 +9979,12 @@ static int rtl_fw_init(struct r8152 *tp)
 		rtl_fw->pre_fw		= r8153b_pre_firmware_1;
 		rtl_fw->post_fw		= r8153c_post_firmware_1;
 		break;
+	case RTL_VER_16:
+		rtl_fw->fw_name		= FIRMWARE_8157_1;
+		break;
+	case RTL_VER_17:
+		rtl_fw->fw_name		= FIRMWARE_8159_1;
+		break;
 	default:
 		break;
 	}

-- 
2.47.3


