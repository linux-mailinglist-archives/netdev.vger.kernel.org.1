Return-Path: <netdev+bounces-245122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FBFCC7363
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 12:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B2C63019364
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 11:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4B335773D;
	Wed, 17 Dec 2025 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hzn5TUur"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE51346A09
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765968495; cv=none; b=DiRt31+PjKThVPzTUEyRduv+DPOEcB2fBxn4MsR01aFSIZ6S7o7i43rEPrV9mYFr3z7Yuh/phDgEWcslcvPM/2w5cr8oJzWqW2PQwmS+gute1gyM6g9qdTf//WSCjmaB/C++/n9gxHJ6UeYF0EM+V52WfMBzT2YfDEu3NQ4Dh0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765968495; c=relaxed/simple;
	bh=S8/hIF0JQ716SNjjY2NJ06gPP6RNxSpNHo/0EZVx2Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q+PmtzY4MJX4ypgdvn6XUY3B2f5J4piIJhuPCGVz8skOcdIfid3NLINOQLDKUvY/LJ03wDY/BrkVSqKZYfgldK9tsNTcUkKbCAdmqWhn3hjmScK0EzDFrgdTmmao6g59ivF/nFm8lAa9Ymz4mV8V4xkV2uWJqUFBy4tqNchPKs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hzn5TUur; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-8b2627269d5so572371685a.2
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 02:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765968493; x=1766573293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iumUatrrnCjoPfYu8EKqrL2BwLDkPXeiPMjDaH/63tE=;
        b=GCYxX4sbqHw5/keQ8HGX97G/Se8RESfciEQGeIt+vHTuzZF+EAC8fMmV9H4HSg4MVx
         mBiBQqbBdEfMeeleAgO2hZaXm4DVBb5njfLO3IgxEnbSXobsNIHyGVLb2eiPNbvdIGVW
         +P4kdCNzCs3Ezy1AHfqCjX8n1OTGUg1aG2GKySCwE3V8IPJ+5zZ9BEbjOqJR2Gi4eNfM
         Bnbd7PDL/TQe/02SKh7wH+WFAq5mPkPmyITEM/EWHNaYhP4crpG3OduWAOvH+7UiTLwa
         aYIxFtc+DxXcCxWsnDLzpCRRsEEsIigHUcmqzei/Vl4xwTYAYgbs64qfK1+lcxveEfSw
         Ffxw==
X-Gm-Message-State: AOJu0YwgkgVBgYBKxDyWtpz4C3HghpAh5PpxXvMvwSvMOb7uG8IfiCDA
	3mLIjm1brvufiOG/urhVeNE76hF9iOdFATpAVnZw4L/reYKxpdOdKwwYrI1sH6wd0N+w/Scw3xz
	q0lO2Cf2sywR8JF8eccg0oiB+9DMKsMo4qOrMBVNw0wRZPoPjAt3z0N9QNxw8+5BVZ4t+3nI3n+
	h1NnlzuIyPNY9zz2JL1q+RoKlMXLa0BR47k0S9vcIthICBmm0XKErpCPYO6p6qWNz98UP473rfu
	foKEqzvW+ZNIfmEpPJnviI=
X-Gm-Gg: AY/fxX68y0JLLo/Mtp+1at0D8SQObEpnw8GVxWax+Qnu647oTdtYWyK0Zd1JAZHFQm4
	Tszw+WKfE3HR8SU3D65uU3DNuFmamd9e1LWGjjF8GxDmbDQhkbHo7DmJ+7eQ+cnpCYArNYVnaHG
	Y2P8D3nnsC0fwTwgWuOpurQXb9Gp20sikBCGzS2jMTlTctLH3prDJaZYNcJO72+rhpMPpeyeKxb
	ymdYNJmAt4tHt8/QmN+9ru/+PYvVKfgP/7BYjGtcCtnlwuHargbYs1/OygfkeQLK/eZIF2H0kke
	Fkl7Tq++jb73ZGWNr68xQianSc2REgsMmLn677YiJVk2fnY22bX5SVDXcYaZ9HLf122I1TQWW80
	g/AtBDAg46bV4IRBuZywNd/v1xf5759UJo05xLfF3blakpNZQ5Nl1h9cDXRjl4UBC3tnvy+vihr
	k3FKYm7NqjOhGJe9ovffASrRAfFyOKLCyI+HZj1YYDaa9/v/TogOGGkw==
X-Google-Smtp-Source: AGHT+IG7NROw91Yfxtr9UFhTi9NZX+VYKdmWH2xZ9FQ0iqUm2bKNw6+Rb3AsIJHUm0K8HtX6iiLHnYnGmKwz
X-Received: by 2002:a05:620a:1d02:b0:8b2:e069:690a with SMTP id af79cd13be357-8bb3a3889b9mr2393453285a.68.1765968492724;
        Wed, 17 Dec 2025 02:48:12 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8899dc1aed2sm20347886d6.23.2025.12.17.02.48.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Dec 2025 02:48:12 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b19a112b75so1234200185a.1
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 02:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1765968492; x=1766573292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iumUatrrnCjoPfYu8EKqrL2BwLDkPXeiPMjDaH/63tE=;
        b=hzn5TUurjDpnLiF1MUnm0DlkCNGmZU5tCNZXM8JmkkM2LApB1v0jCaGyXLUGxn9YrX
         AiAGYSdz0EgDUQQqCn5gd4nzhefAmPwv72recL1+kwPbDGp5VWLZHg54H5oe3rtPyIPv
         24yIeq18x75WtHsvyDwap9v1/DloyYKOGLoeA=
X-Received: by 2002:a05:620a:190e:b0:89f:5057:975e with SMTP id af79cd13be357-8bb3a2776fcmr2336143585a.56.1765968492037;
        Wed, 17 Dec 2025 02:48:12 -0800 (PST)
X-Received: by 2002:a05:620a:190e:b0:89f:5057:975e with SMTP id af79cd13be357-8bb3a2776fcmr2336142285a.56.1765968491635;
        Wed, 17 Dec 2025 02:48:11 -0800 (PST)
Received: from lvnvdb1769.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be31c75e9esm375274485a.50.2025.12.17.02.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:48:11 -0800 (PST)
From: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dharmender.garg@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Subject: [PATCH net 1/1] bng_en: update module description
Date: Wed, 17 Dec 2025 02:47:48 -0800
Message-ID: <20251217104748.3004706-1-rajashekar.hudumula@broadcom.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The Broadcom BCM57708/800G NIC family is branded as ThorUltra.
Update the driver description accordingly.

Fixes: 74715c4ab0fa0 ("bng_en: Add PCI interface")
Signed-off-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
---
 drivers/net/ethernet/broadcom/Kconfig          | 8 ++++----
 drivers/net/ethernet/broadcom/bnge/bnge.h      | 2 +-
 drivers/net/ethernet/broadcom/bnge/bnge_core.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index 666522d64775..ca565ace6e6a 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -255,14 +255,14 @@ config BNXT_HWMON
 	  devices, via the hwmon sysfs interface.
 
 config BNGE
-	tristate "Broadcom Ethernet device support"
+	tristate "Broadcom ThorUltra Ethernet device support"
 	depends on PCI
 	select NET_DEVLINK
 	select PAGE_POOL
 	help
-	  This driver supports Broadcom 50/100/200/400/800 gigabit Ethernet cards.
-	  The module will be called bng_en. To compile this driver as a module,
-	  choose M here.
+	  This driver supports Broadcom ThorUltra 50/100/200/400/800 gigabit
+	  Ethernet cards. The module will be called bng_en. To compile this
+	  driver as a module, choose M here.
 
 config BCMASP
 	tristate "Broadcom ASP 2.0 Ethernet support"
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 7aed5f81cd51..0c154995d9ab 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -5,7 +5,7 @@
 #define _BNGE_H_
 
 #define DRV_NAME	"bng_en"
-#define DRV_SUMMARY	"Broadcom 800G Ethernet Linux Driver"
+#define DRV_SUMMARY	"Broadcom ThorUltra NIC Ethernet Driver"
 
 #include <linux/etherdevice.h>
 #include <linux/bnxt/hsi.h>
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index 2c72dd34d50d..312a9db4d75d 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -19,7 +19,7 @@ char bnge_driver_name[] = DRV_NAME;
 static const struct {
 	char *name;
 } board_info[] = {
-	[BCM57708] = { "Broadcom BCM57708 50Gb/100Gb/200Gb/400Gb/800Gb Ethernet" },
+	[BCM57708] = { "Broadcom BCM57708 ThorUltra 50Gb/100Gb/200Gb/400Gb/800Gb Ethernet" },
 };
 
 static const struct pci_device_id bnge_pci_tbl[] = {
-- 
2.51.0


