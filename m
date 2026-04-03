Return-Path: <netdev+bounces-275169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIKLCkoP0GlQ2wYAu9opvQ
	(envelope-from <netdev+bounces-275169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:04:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 926DC3977D2
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F2FE3077EE3
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 19:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B290F3D667E;
	Fri,  3 Apr 2026 19:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kWdjJYP6"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3439E3D5656
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775242972; cv=none; b=XmdvxQA7G/miJYrgjVNYISLplqt+5gVjfCaMySu9sBTxQmnLUzLDQL2D8BqJ2Pf8JJlu2yyCVTFIth+md6K6liGeo3oEFXkI+6UXfkI1OnznmmRUR/GxMMev+7yRHrAjATQjCPIRa7hLKh2YqXFTRsJiNtQceUCIcfH9oayF5Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775242972; c=relaxed/simple;
	bh=2TMI09FpamYZahfXr+RTwRjwuJl1OVYR05Rg8UryZp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pxODs0JahM8lTsOJPW3UwzYKMFbFP34xRb7TkbvELfnWNLBvEeM4thn5qC8Z8QNDP3LkyUCn/G7sHDk/y+Pl19uuY0RR8uI5r9Y+6WPAvBilomQZzh0TzXOAdDjPxS1fKwQXmd9tTdSE9i/mv6HZ8adLnf5PR6NVMvxcL2nAGho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kWdjJYP6; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C7EDF4E428DA;
	Fri,  3 Apr 2026 19:02:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9E56A603C1;
	Fri,  3 Apr 2026 19:02:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A9F4C10450104;
	Fri,  3 Apr 2026 21:02:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775242968; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4Wv5yQvuj+rgucDv+ANDjV6mURH+Y6I5nT0NY+ugpFU=;
	b=kWdjJYP6WePo47HuUMrKVu7jaB7aJj6o2/xliAwiE/AHbeZUC0k5aHOlloTu22oZ0BLhOb
	XWVVV/zTuJotoNUYH+4bw7C+iB6B9iWjBJoxJSATWqxMC8UZa6ij9nukwouAattEP7nVyy
	3ckAfhzzHo7RLfa5mXyphOw+2tEUzaydA9rnvxh63l8xZ262AsodvUwyhJnEYUiYpp0BZL
	C7OkZpY0rSU5OAbSaeQajy+uepYZbl+0vZbYmT4/gPONFEhXL3uGzwW0aLJP3FAK6ouUtu
	MuMgxMz7hQuupXrYB+0YiLxwIXUQFNdzG6IM4BvQEYWA2xkG5+wnfnrpzKFZkA==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Fri, 03 Apr 2026 21:02:24 +0200
Subject: [PATCH 2/2] ARM: dts: ti: var-som-om44: Add USB Ethernet
 controller node
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-b4-var-som-om44-lan7500-v1-2-0dadde850143@bootlin.com>
References: <20260403-b4-var-som-om44-lan7500-v1-0-0dadde850143@bootlin.com>
In-Reply-To: <20260403-b4-var-som-om44-lan7500-v1-0-0dadde850143@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275169-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.richard@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.3:email,0.0.0.1:email,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 926DC3977D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add USB tree description, including the Gigabit Ethernet controller
(LAN7500). Adding the LAN7500 node will allow the bootloader to patch the
devicetree and set the MAC address.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi b/arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi
index 37d56b3010cff0f6ea6208289da0aba7328067d5..9e04aa70f98227ac0054fea6cd4521ed1323ecbd 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi
@@ -322,4 +322,18 @@ &usbhshost {
 
 &usbhsehci {
 	phys = <&hsusb1_phy>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	usbhub: hub@1 {
+		compatible = "usb424,2514";
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethernet: ethernet@3 {
+			compatible = "usb424,7500";
+			reg = <3>;
+		};
+	};
 };

-- 
2.53.0


