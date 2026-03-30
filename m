Return-Path: <netdev+bounces-273198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EONnNtl/ymnX9QUAu9opvQ
	(envelope-from <netdev+bounces-273198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:51:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 345C235C586
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E94243052632
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272BF3D47A3;
	Mon, 30 Mar 2026 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CZGIYuLS"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D3A3BFE5A;
	Mon, 30 Mar 2026 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878187; cv=none; b=aBau5dF1Qxww7+CuLQ+8obgTyNORnSweDAfY8BslmjEEWseJ/q1YD7vbwi4xd7EFsaBl+QdMmk2htC+g3NH9Zucteditr0MKd6cZ1L/DDaUhPmWu/XSfvS/4DixJGq0G0Qqx5EkdKyGYL9/4BLI6iJmZIsdTaAYDcpCH1+aILJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878187; c=relaxed/simple;
	bh=nHe8/8Bn9Z2nJjXigStXbXvDUI4dnqVGlmqimDu7dn4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBo48ZEHXu/Vr4joSLZmiwOJzultNKx6QuXK5+ZN33fRxW8AtINyGVFSEJTIbQ7SAX6J0fMM7P72udPrigFRvJ+bP8csWoAytUxVsemeSDt8cZTuolZjGQyfJv5xfEQwCSwdZuW/TMQLSMOHehZwujWXXMKv2Hz+F5YxP7lPur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CZGIYuLS; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774878185; x=1806414185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nHe8/8Bn9Z2nJjXigStXbXvDUI4dnqVGlmqimDu7dn4=;
  b=CZGIYuLSGiObJCUhstyTBo9zy+Lkw1mtdvtR5oqVr3yPBkrbHwkskrGy
   xrhQSBEGzO5E3WRjdzG6RpayRNI7dTkrqbkHFsnxd3HO0Zcg7rMIFTH9Y
   6+f8LTC6FBzwAclbJkty1jyHYfpNbY9/ohhHlOpu4I1CT1tCe9KVZbU0u
   0oqd1jeGylKuw4Qkfgc0qXYiiBdAFp3jH+RU3TKC5AaOZPPwyPw5mYAVS
   gEKxQV1x0g48thIbIIHuxsii8RWggO78NItXLz3KbyUQ87zirvVk+Yo+g
   82LQgtPOkJNe4jqLfbkXEvE/LhyFWW7exD+ehr6V9oRwqy/lWflPqGMkO
   A==;
X-CSE-ConnectionGUID: 2vXt89tESFa2aJsbwP30Hw==
X-CSE-MsgGUID: dgTLrdTORdO5iYnBy3Lu7g==
X-IronPort-AV: E=Sophos;i="6.23,150,1770620400"; 
   d="scan'208";a="54658517"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 06:43:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 30 Mar 2026 06:42:44 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 30 Mar 2026 06:42:40 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <parthiban.veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <steve.glendinning@shawell.net>,
	<UNGLinuxDriver@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH net-next 3/3] net: usb: smsc95xx: suspend PHY during USB suspend
Date: Mon, 30 Mar 2026 19:12:22 +0530
Message-ID: <20260330134222.67597-4-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330134222.67597-1-parthiban.veerasooran@microchip.com>
References: <20260330134222.67597-1-parthiban.veerasooran@microchip.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273198-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,shawell.net];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[parthiban.veerasooran@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,microchip.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 345C235C586
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The smsc95xx driver registers a PHY device but does not currently
propagate suspend events to it when the USB interface is suspended.

Call phy_suspend() from the driver's suspend callback so the attached
PHY can properly enter low-power state during system or runtime
suspend. This aligns smsc95xx suspend handling with other network
drivers that manage an external or integrated PHY.

Without this, the PHY may remain active and fail to execute its own
suspend procedure, leading to unnecessary power consumption or
incorrect resume behavior.

This change is also required for the EVB-LAN8670-USB Rev.D0 device to
support OATC10-compliant sleep and wake functionality.

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/usb/smsc95xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 42e4048b574b..3a6e03b7410a 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1550,6 +1550,12 @@ static int smsc95xx_suspend(struct usb_interface *intf, pm_message_t message)
 
 	pdata->pm_task = current;
 
+	if (pdata->phydev) {
+		ret = phy_suspend(pdata->phydev);
+		if (ret)
+			return ret;
+	}
+
 	ret = usbnet_suspend(intf, message);
 	if (ret < 0) {
 		netdev_warn(dev->net, "usbnet_suspend error\n");
-- 
2.34.1


