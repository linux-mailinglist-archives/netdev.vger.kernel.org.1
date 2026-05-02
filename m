Return-Path: <netdev+bounces-283370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGpCEPmC9WkHMAIAu9opvQ
	(envelope-from <netdev+bounces-283370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 06:52:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FF44B0F60
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 06:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 471B33034BFC
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 04:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B86B2F1FC7;
	Sat,  2 May 2026 04:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Uf+de1L6";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="GEWB0HAS"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73F2E7BB6;
	Sat,  2 May 2026 04:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777697461; cv=none; b=rMOgIpv8Oza+t3Cyt2zQICJhDWY+El+PxrrQ9QsV/9DQ6dx9WdOMIxeWRzyEm3dbc5jtMM7y3Gak7qahxSZeUehNCOzamaf0+Q4eLJDgHVnnI/HxSwXUHiB5BIEQGX+1QXzJKwxVA7RNXsO0HSgQfQ1bDqa8LDzuWa8OHjdxLu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777697461; c=relaxed/simple;
	bh=/j+KdgXrFyd32qLGN8tIJdWw4prZxjlLtFjpgrKqngo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pe0cjb1+MnMuBv8KvIOXlBJvUOe6MCNj4DT/qCRPYngzyxgGC96rdIH9ESEf9P6lxw4LuA5ovTujPf39lmixhbswrgbz+qfesap3T49RymUabxdyJvgdszCja3VAjlFYSnpHj+IWaM74OiEEuwrBBtHndOqPtFYe6xMAxHsINp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Uf+de1L6; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=GEWB0HAS; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777697458;
	bh=/j+KdgXrFyd32qLGN8tIJdWw4prZxjlLtFjpgrKqngo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Uf+de1L6ba1cmQh5W9u6DHCem3tWhBpH4sLYYXlL4KdxP7mKklgIOHO+JTLj4Myh/
	 o73nS66zYjiFg79rX3kbVZ1kWwN59WZZ12obQuOH0KIUmQkewsxF0XB8X7BlEnXZjH
	 ft+820uaxyc8zZwbnEctzRShniHNGDK1JXZsoJl4wxP3HBOD+45vCjB6z9JI79zMmc
	 d+8cQg1AlhtFBT9xqke9XffCRctm4Rtofek53c11xR0148zbgKQRtWatobAY4TNSQy
	 ZpJNHyZffM4W8zKvb51WBuPnND3HgeEzghy1zNC/P2tTlAxj8jzWd4+TC2jyCCg3am
	 B+zcB1Mr4Km2g==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 6DEC8482C8; Sat,  2 May 2026 04:50:58 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777697455;
	bh=/j+KdgXrFyd32qLGN8tIJdWw4prZxjlLtFjpgrKqngo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GEWB0HASwP+BopFacHE4eT3xm539NokEuSnTmeTH9BmM/x2tKhQdp1K3tmfA3HI1p
	 5LQzzLQOQ30jceIzRBe+VWPUBxQCNIOgA6pzEeXaprHpXO2MYCxPtv1ZsKn/XKMf4W
	 VjyKUvvjPAevdjDdaIhJlK140e4NPstd4NLeI5/PNXMOWgUlO30XObpUYrRpU68ljB
	 9XBigyayWJgGnQcFS0f1L6molOfxRT+EHd6ycSWWPei5KJKCt4dhS+WI90nYCy/4dJ
	 RAiv4tFJ3hYIY95NsQyVIEHhbz1KwxPdzkUiFN9hZVbDEXKg7EYKnsu19gj8xZEocA
	 XpS2rweai0Cvw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 54241482A2;
	Sat,  2 May 2026 04:50:55 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sat, 02 May 2026 06:50:38 +0200
Subject: [PATCH net-next v3 3/3] r8152: Add firmware upload capability for
 RTL8157/RTL8159
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-rtl8159_net_next-v3-3-12c895d46cd6@birger-koblitz.de>
References: <20260502-rtl8159_net_next-v3-0-12c895d46cd6@birger-koblitz.de>
In-Reply-To: <20260502-rtl8159_net_next-v3-0-12c895d46cd6@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>, 
 Birger Koblitz <mail@birger-koblitz.de>, 
 Aleksander Jan Bajkowski <olek2@wp.pl>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 94FF44B0F60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,realtek.com,birger-koblitz.de,wp.pl];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283370-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wp.pl:email,birger-koblitz.de:email,birger-koblitz.de:dkim,birger-koblitz.de:mid]

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
index a2cdd57558c78b025ea61d33b99eca72c19f535f..7efba20de03deb06ac75c3b57a0d0e27b30b8e3a 100644
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
 
@@ -9923,6 +9926,8 @@ static int rtl_ops_init(struct r8152 *tp)
 #define FIRMWARE_8153C_1	"rtl_nic/rtl8153c-1.fw"
 #define FIRMWARE_8156A_2	"rtl_nic/rtl8156a-2.fw"
 #define FIRMWARE_8156B_2	"rtl_nic/rtl8156b-2.fw"
+#define FIRMWARE_8157_1		"rtl_nic/rtl8157-1.fw"
+#define FIRMWARE_8159_1		"rtl_nic/rtl8159-1.fw"
 
 MODULE_FIRMWARE(FIRMWARE_8153A_2);
 MODULE_FIRMWARE(FIRMWARE_8153A_3);
@@ -9931,6 +9936,8 @@ MODULE_FIRMWARE(FIRMWARE_8153B_2);
 MODULE_FIRMWARE(FIRMWARE_8153C_1);
 MODULE_FIRMWARE(FIRMWARE_8156A_2);
 MODULE_FIRMWARE(FIRMWARE_8156B_2);
+MODULE_FIRMWARE(FIRMWARE_8157_1);
+MODULE_FIRMWARE(FIRMWARE_8159_1);
 
 static int rtl_fw_init(struct r8152 *tp)
 {
@@ -9969,6 +9976,12 @@ static int rtl_fw_init(struct r8152 *tp)
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


