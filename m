Return-Path: <netdev+bounces-282443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOWBEwY68mlypAEAu9opvQ
	(envelope-from <netdev+bounces-282443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:04:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3872497EF6
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBE55306B3BC
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B3E413233;
	Wed, 29 Apr 2026 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="2wO2sW//";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="ijUiT+bw"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5F7410D1D;
	Wed, 29 Apr 2026 17:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482107; cv=none; b=WJQh68Aw791560sUOqataWJWD18Wdjyh9XT/HFPGezMuiS+mycZPBzZiklN8BvwETJosjcDxJNdXPx0n1etWHI15qhnDnpBTrSxOePw/kDGph8xi5uip91NIbdTn5rimv8wRzsMZTN+qVI+69S0/STSHPXbVe0UME3rqaupG5Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482107; c=relaxed/simple;
	bh=eol+1DnsahDPt0HbY+ktrtopC/qEvd8XCdKez3IJQ2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pJuOQQxq7TI+xSR7X9szLnycGFOH1Fvh37G6uvIqTPPJw+jXQ1+uVh5KDNoKk66Nf5qoEnGTEYS5NZMCKiozdJjp6giEZyZRwuk3Yh2ZDXHEBBE0lwWB8hqmWP7uHGUPZ8DG5WO6xRTiDdKIVz3wTz65pFbLR3jiClzF+Zwxc9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=2wO2sW//; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ijUiT+bw; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777482104;
	bh=eol+1DnsahDPt0HbY+ktrtopC/qEvd8XCdKez3IJQ2A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=2wO2sW//jt6UMP6gWHHyrIy47r+HxSwmEeM4ORaNt2cqJOBT5rRGYOisnC6vYdEVq
	 QlhSAtZhfJYHN10lHEGqo8KrsAhQYLT1o8m34Id9EEZLEbaIP+p3Rh3dJNjd95lsCY
	 kBYjVD9xFACfVqUkEch6TGsPj6kpvVUtgeLPqygHTBEjSayqHS/6IkngIJa9dq5u5j
	 xeVSsCYON3VMVnbDI7wlqd6z/C3SLtIqm8a2rmziuUzsFq+G5iEYoBMI/nF0kg/SpK
	 1QLqmwqtb3sXlJyFAVSrZP3iCivdyUPSSGd783pOf3YIblHMgCkNlX+UNvSJxkmDNd
	 soojGrT0tpGRQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 2024B481B1; Wed, 29 Apr 2026 17:01:44 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777482099;
	bh=eol+1DnsahDPt0HbY+ktrtopC/qEvd8XCdKez3IJQ2A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ijUiT+bw9ccWDhIFwFxJslyLTldV2dt3yFOkYkkb+P27irR/9srbTv5LeCTKAwRnm
	 eHdusg2W3SeuZfZM6t6A5CDmEEFa3+Ky32x3AQ2dtEvqzzSw8Wk8aURxDJ3jz+/1wG
	 WWlM1nnMh84uZ3HyhVMaN7YKyl8s9rIXWcqFvbxp7Eg4VfbtMYk6GogyM6bNaXZDBl
	 JyukrGI6MrOM1nBrj2fAMYBnC6XS0H0k+5tG1RFsbIpZ1IE7u3PrBlqxHuMudXIX7R
	 xfCcyrKHrU8BXTclr33p+GA4bAfzaM8J1obGsrmUDrEg8gbbK2zXRVYYhg+m9M9Ja2
	 mK5usLur71ehA==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 895794818A;
	Wed, 29 Apr 2026 17:01:39 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 29 Apr 2026 19:01:12 +0200
Subject: [PATCH net-next v2 4/4] r8152: Add firmware upload capability for
 RTL8157/RTL8159
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-rtl8159_net_next-v2-4-bab3cd4e4c66@birger-koblitz.de>
References: <20260429-rtl8159_net_next-v2-0-bab3cd4e4c66@birger-koblitz.de>
In-Reply-To: <20260429-rtl8159_net_next-v2-0-bab3cd4e4c66@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>, 
 Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: D3872497EF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-282443-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birger-koblitz.de:email,birger-koblitz.de:dkim,birger-koblitz.de:mid]

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
---
 drivers/net/usb/r8152.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 9fcad3dac76f8aa76ef074cabd3b08348dc234bc..8d880afd88c9392cd873a5015a0d7feee538ac7f 100644
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
@@ -7996,12 +7997,14 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
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
 
@@ -9949,6 +9952,8 @@ static int rtl_ops_init(struct r8152 *tp)
 #define FIRMWARE_8153C_1	"rtl_nic/rtl8153c-1.fw"
 #define FIRMWARE_8156A_2	"rtl_nic/rtl8156a-2.fw"
 #define FIRMWARE_8156B_2	"rtl_nic/rtl8156b-2.fw"
+#define FIRMWARE_8157_1		"rtl_nic/rtl8157-1.fw"
+#define FIRMWARE_8159_1		"rtl_nic/rtl8159-1.fw"
 
 MODULE_FIRMWARE(FIRMWARE_8153A_2);
 MODULE_FIRMWARE(FIRMWARE_8153A_3);
@@ -9957,6 +9962,8 @@ MODULE_FIRMWARE(FIRMWARE_8153B_2);
 MODULE_FIRMWARE(FIRMWARE_8153C_1);
 MODULE_FIRMWARE(FIRMWARE_8156A_2);
 MODULE_FIRMWARE(FIRMWARE_8156B_2);
+MODULE_FIRMWARE(FIRMWARE_8157_1);
+MODULE_FIRMWARE(FIRMWARE_8159_1);
 
 static int rtl_fw_init(struct r8152 *tp)
 {
@@ -9995,6 +10002,12 @@ static int rtl_fw_init(struct r8152 *tp)
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


