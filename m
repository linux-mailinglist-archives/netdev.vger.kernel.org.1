Return-Path: <netdev+bounces-298932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W0cOGvIcLWodbwQAu9opvQ
	(envelope-from <netdev+bounces-298932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:03:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F31967E30E
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:03:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298932-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298932-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09A1F300372F
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 09:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CE12EA731;
	Sat, 13 Jun 2026 09:03:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-6.us.a.mail.aliyun.com (out198-6.us.a.mail.aliyun.com [47.90.198.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1EC34A78E;
	Sat, 13 Jun 2026 09:03:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781341418; cv=none; b=mflq/gb+powO1j6p2e8ukQ31qC9MaATHmWxBvbdw9WzR1x6MTG5V5sqH9CyXtrUAWMYvU6P+XFzX8scX3Pnu3AX4ThGpbyWQ1eQSEDXMx8W6LzBsmi98+UIhzJ/9yW2hSN0nj38kh3X3ro3svty2J9B5bUcHAete5uauQPCceU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781341418; c=relaxed/simple;
	bh=+1DA1L0d0ZQaUEn6MpFfOibUMXgSZQsBcriR6mki+vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eP8wNUtBgAYDqKIWMz6sDFIJwvBzvEZSRAV6Cn/A6kfuMBnqz4WEoW+KyVMUo50SK10jWIt80Q6GwrXk/rZi4H9tCW+9re0BohdaXDjI0Dp95mF9Q4jE0g0LRXRew0FlllfSfhLaaMhGKCsDx+6OhItCx218BVso5PgxWiFMngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edatec.cn; spf=pass smtp.mailfrom=edatec.cn; arc=none smtp.client-ip=47.90.198.6
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.4962601|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.176659-0.00160023-0.82174;FP=7628090403777439464|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=zjzhao@edatec.cn;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.hxCTUHx_1781341318;
Received: from lists.debian.org(mailfrom:zjzhao@edatec.cn fp:SMTPD_---.hxCTUHx_1781341318 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 13 Jun 2026 17:03:12 +0800
From: zjzhao@edatec.cn
To: hayeswang@realtek.com
Cc: andrew+netdev@lunn.ch,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zjzhao-eda <zjzhao@edatec.cn>
Subject: [PATCH] r8152: add vendor/device ID for CoreChips SR9900
Date: Sat, 13 Jun 2026 17:01:54 +0800
Message-Id: <20260613090154.1975753-1-zjzhao@edatec.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hayeswang@realtek.com,m:andrew+netdev@lunn.ch,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zjzhao@edatec.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298932-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[edatec.cn];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zjzhao@edatec.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zjzhao@edatec.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,edatec.cn:email,edatec.cn:mid,edatec.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F31967E30E

From: zjzhao-eda <zjzhao@edatec.cn>

The CoreChips SR9900 (0x0fe6:0x9900) is a USB 2.0 10/100
Ethernet adapter. Testing shows it works correctly with the
r8152 driver, reaching wire speed (94 Mbps) with zero packet
loss on both TCP and UDP.

Tested on Raspberry Pi, including hotplug and extended data
transfer.

Signed-off-by: zjzhao-eda <zjzhao@edatec.cn>
---
 drivers/net/usb/r8152.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index d61074178279..ea1733e3619c 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10062,6 +10062,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_DELL,    0xb097) },
 	{ USB_DEVICE(VENDOR_ID_ASUS,    0x1976) },
 	{ USB_DEVICE(VENDOR_ID_TRENDNET, 0xe02b) },
+	{ USB_DEVICE(0x0fe6, 0x9900) },
 	{}
 };
 
-- 
2.34.1


