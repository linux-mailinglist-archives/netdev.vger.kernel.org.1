Return-Path: <netdev+bounces-261564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Mm7EyKpoGnilQQAu9opvQ
	(envelope-from <netdev+bounces-261564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:12:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F581AEEAA
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AA0C3118719
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FEB46AED3;
	Thu, 26 Feb 2026 20:06:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from secundus.vsp.im (secundus.vsp.im [37.120.170.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BF0466B67;
	Thu, 26 Feb 2026 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.170.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772136389; cv=none; b=F2Nik0CV4eWBGPM48K09RwTgq7+vMEocxahHt35/uVeW7brjiMtoTvgdCbOoED0dT6hg0linlfufjl3P9+xXHIc6qrq2yTR8ILUKWJR1EWNJKMCRkdOO/g/xdsUdDf6LMpANl1lg7fzVNgZhUJNIOenYIc9oXWqiC/tUOpqsAYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772136389; c=relaxed/simple;
	bh=noYG3/qBn3OST/UywZpom0NlY6Lv8Jc1LQsP7RgNiQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mtmxhTr38nz7277PDlNmXG4tIZeZTH8giNHhgEW3edjchH2tTMU5gNt25QQ0MZoyBoVfld6Xqq+m3Tty79NpcN8EyIgtunWSvwBFnizYyHQ4TwMKxgT85eOzdeAFQ5//trBEKHmH6mT1eZnfqPDgTgoGnYqpXM4zbpnYXVdkQzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spreckels.dev; spf=fail smtp.mailfrom=spreckels.dev; arc=none smtp.client-ip=37.120.170.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spreckels.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=spreckels.dev
Received: from sky.vs-b.lan (unknown [IPv6:fd04:f774:a13e:5801:fbeb:e9a5:1c28:3a49])
	by secundus.vsp.im (Postfix) with ESMTP id F146EFFA14;
	Thu, 26 Feb 2026 21:06:15 +0100 (CET)
From: Valentin Spreckels <valentin@spreckels.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Valentin Spreckels <valentin@spreckels.dev>
Subject: [PATCH net-next] net: usb: r8152: add TRENDnet TUC-ET2G
Date: Thu, 26 Feb 2026 20:54:09 +0100
Message-ID: <20260226195409.7891-2-valentin@spreckels.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.84 / 15.00];
	SEM_URIBL_FRESH15(3.00)[spreckels.dev:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261564-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[spreckels.dev];
	GREYLIST(0.00)[pass,body];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[valentin@spreckels.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.988];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,spreckels.dev:mid,spreckels.dev:email]
X-Rspamd-Queue-Id: C7F581AEEAA
X-Rspamd-Action: no action

The TRENDnet TUC-ET2G is a RTL8156 based usb ethernet adapter. Add its
vendor and product IDs.

Signed-off-by: Valentin Spreckels <valentin@spreckels.dev>
---
Resend (to some recipients) because of now resolved mail delivery issues.

 drivers/net/usb/r8152.c   | 1 +
 include/linux/usb/r8152.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 4af85728ac4f6..0c83bbbea2e7c 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10054,6 +10054,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_DLINK,   0xb301) },
 	{ USB_DEVICE(VENDOR_ID_DELL,    0xb097) },
 	{ USB_DEVICE(VENDOR_ID_ASUS,    0x1976) },
+	{ USB_DEVICE(VENDOR_ID_TRENDNET, 0xe02b) },
 	{}
 };
 
diff --git a/include/linux/usb/r8152.h b/include/linux/usb/r8152.h
index 2ca60828f28bb..1502b2a355f98 100644
--- a/include/linux/usb/r8152.h
+++ b/include/linux/usb/r8152.h
@@ -32,6 +32,7 @@
 #define VENDOR_ID_DLINK			0x2001
 #define VENDOR_ID_DELL			0x413c
 #define VENDOR_ID_ASUS			0x0b05
+#define VENDOR_ID_TRENDNET		0x20f4
 
 #if IS_REACHABLE(CONFIG_USB_RTL8152)
 extern u8 rtl8152_get_version(struct usb_interface *intf);
-- 
2.52.0


