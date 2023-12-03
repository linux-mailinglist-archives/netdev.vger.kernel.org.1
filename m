Return-Path: <netdev+bounces-53297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07777802030
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 02:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E188B20B11
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 01:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E449659;
	Sun,  3 Dec 2023 01:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hawknetworks.com header.i=@hawknetworks.com header.b="PXQtfmqR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC0111F
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 17:17:32 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5c659db0ce2so837799a12.0
        for <netdev@vger.kernel.org>; Sat, 02 Dec 2023 17:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hawknetworks.com; s=hawknetworks; t=1701566252; x=1702171052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VJuY8GE58qdOR7T86duPKoW3wzd9Ql6QkE8GpXHr/I4=;
        b=PXQtfmqRUB6cNdVzkWcUJgTlo1jwgR3UCp/dAPAF2E/m/g4uxjj+1x9zAJKcfPpovS
         vK9Jc7u1N8AeRPhLiZ6GJmUG/n5pi2D+TG/sNInvHkmCgtgNTSIWK6rFif66zUt5avMC
         z+K0YUWOwy0tcL8TlRg5+an0/NQEhvl4K//dE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701566252; x=1702171052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJuY8GE58qdOR7T86duPKoW3wzd9Ql6QkE8GpXHr/I4=;
        b=Ub2cLDFvi1zY+2CVmgSuV7kxXKkSJ9+l+0Fi60h/pY7VLYzDaH+5CJBCSiiIX1TrOD
         ON32PHTz9EEIqJUa5yTbScWfbV5AiY8/0kgShQ2PdrmE6TfcUXcNTwuibCjjNu9iRmHO
         ABgqTmOfkfmHrexr7E6iittk03TjRo++l8YSmPuP///HskGfPh1JWtzwm5Ip3cYGzKPO
         0QbuiDZW+Ry/FhBmEnP94bLuq1+6pz47qVFBIvPzqMwmhiduB4rEqEmTL0OD8DUkHeDH
         GyIiYWqSnKzllL9/EbJLEk6m0AzeW2sdfP37X+DiXlWP2Ud02UET4oNmL7iB3juC/iop
         Vkyw==
X-Gm-Message-State: AOJu0Yyjtm5q0peIp7xWIHnijphkfiip6MTCwuyylgJYNf9oqYKDKmvl
	89m0DanEZW3DBhbp1/tKeTsTTA==
X-Google-Smtp-Source: AGHT+IGfaVYI9bV0rdDz70emOMa1CZFH4dogTRDVWXjCON7HkMRGMBsitKlfZ3VEnBZKYwLiMCiSMg==
X-Received: by 2002:a05:6a20:dd92:b0:148:f952:552b with SMTP id kw18-20020a056a20dd9200b00148f952552bmr2146109pzb.51.1701566252028;
        Sat, 02 Dec 2023 17:17:32 -0800 (PST)
Received: from kkane-x1.adsrvr.org ([47.145.249.123])
        by smtp.gmail.com with ESMTPSA id z19-20020a62d113000000b0068ffd56f705sm557766pfg.118.2023.12.02.17.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 17:17:31 -0800 (PST)
From: Kelly Kane <kelly@hawknetworks.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] r8152: add vendor/device ID pair for ASUS USB-C2500
Date: Sat,  2 Dec 2023 17:17:12 -0800
Message-Id: <20231203011712.6314-1-kelly@hawknetworks.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASUS USB-C2500 is an RTL8156 based 2.5G Ethernet controller.

Add the vendor and product ID values to the driver. This makes Ethernet
work with the adapter.

Signed-off-by: Kelly Kane <kelly@hawknetworks.com>
---
 drivers/net/usb/r8152.c   | 1 +
 include/linux/usb/r8152.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index afb20c0ed688..04aaae8a74c3 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9993,6 +9993,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff) },
 	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0601) },
 	{ USB_DEVICE(VENDOR_ID_DLINK,   0xb301) },
+	{ USB_DEVICE(VENDOR_ID_ASUS,    0x1976) },
 	{}
 };
 
diff --git a/include/linux/usb/r8152.h b/include/linux/usb/r8152.h
index 287e9d83fb8b..33a4c146dc19 100644
--- a/include/linux/usb/r8152.h
+++ b/include/linux/usb/r8152.h
@@ -30,6 +30,7 @@
 #define VENDOR_ID_NVIDIA		0x0955
 #define VENDOR_ID_TPLINK		0x2357
 #define VENDOR_ID_DLINK			0x2001
+#define VENDOR_ID_ASUS			0x0b05
 
 #if IS_REACHABLE(CONFIG_USB_RTL8152)
 extern u8 rtl8152_get_version(struct usb_interface *intf);

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.34.1


