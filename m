Return-Path: <netdev+bounces-59999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE3E81D0DF
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 01:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC9328107C
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 00:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137D0384;
	Sat, 23 Dec 2023 00:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h64JUqLU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90379ECB
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 00:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ba52d0f9feso1801104b6e.0
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 16:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703292834; x=1703897634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cK7kJHTVafdsQS7PU7GA+orFROjeokysvEhQHyINr0=;
        b=h64JUqLUEZI+Uk9PptFFlHKdPuHYht4uSmr5eHBmm6LijwndRjrbFafybROxJRauaL
         umb7rMOoA8aFqU2bdl9Ol8NHomzgDKsbwBp42Y5akzW29iOvfbc6X0ezl+0AdGbgHDX+
         fpjVA6IgPTwQbKc4KXcL3ZIeFGZLPLpWRIl7N/ephdEqzk+7aciH3EX1qGelR6oVEyEX
         EhfeHDOyLv9O2qT0ueLwqQUGjYYITpCdE9oP30Yd6DHrF1DDgrjBAQ2+AZxHnbCC3GEo
         Qn60PKZMxi+VZhotwPVM3vpKCnAulMYyVKagYceQZMNRjUTS4RVCGiZZkKwZP+YU4hvt
         d7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703292834; x=1703897634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cK7kJHTVafdsQS7PU7GA+orFROjeokysvEhQHyINr0=;
        b=GJPyv5aFBdLo+RgKIXNAWfcxIPi3Jpg+dsa8Iy+h9uhxle4XnnQGp65jO+1MpyLWCA
         EhvzjV0yEAuj1/1Ci5vqU32DmJENp7j9tH0mTIlX+dhTOmR9BH0xn1/YyDuhpTtb3QLe
         ZmxmjP/5ATKMg1GnFldyBqsEKKtCjY2OMFU0EOcjhhVrr93ej2VYARGDoFPrY7CnSb+H
         PGV9SMyqiX1zd99TiRkn/+8CM9Z3HuJgMKu5+Ogrh63Rm9CMxVSUxWTu1uDfc1Vx72Ia
         6NumeNrv9UXxap0HItVRl60qQVLnT/V2c4/kV2et+RR92nRggUNyF6A8e2cJt/4AcJJN
         qWMg==
X-Gm-Message-State: AOJu0YxuVYvDF4sUgEs3DkAc5HN0eEOE6lVc6daJa8p6oZiDhGWSfmmQ
	AhM3DdHjfcFxVj0jdmISUBeJWL2jWGDwPdtz
X-Google-Smtp-Source: AGHT+IEw54J38M7Q0R06FS6kYxPBTo8/nvCXXSp6PbkiuDtDPOHnqSFfz0l57qxPbnFL17dD6b/UjA==
X-Received: by 2002:a05:6808:4447:b0:3bb:89aa:dfaa with SMTP id ep7-20020a056808444700b003bb89aadfaamr2540673oib.40.1703292833872;
        Fri, 22 Dec 2023 16:53:53 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id iz11-20020a170902ef8b00b001d076c2e336sm4028257plb.100.2023.12.22.16.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 16:53:53 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arinc.unal@arinc9.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next v3 4/8] net: dsa: realtek: merge common and interface modules into realtek-dsa
Date: Fri, 22 Dec 2023 21:46:32 -0300
Message-ID: <20231223005253.17891-5-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223005253.17891-1-luizluca@gmail.com>
References: <20231223005253.17891-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since realtek-common and realtek-{smi,mdio} are always loaded together,
we can optimize resource usage by consolidating them into a single
module.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/Kconfig          | 4 ++--
 drivers/net/dsa/realtek/Makefile         | 7 ++++---
 drivers/net/dsa/realtek/realtek-common.c | 1 +
 drivers/net/dsa/realtek/realtek-mdio.c   | 4 ----
 drivers/net/dsa/realtek/realtek-smi.c    | 4 ----
 5 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
index 9d182fde11b4..6989972eebc3 100644
--- a/drivers/net/dsa/realtek/Kconfig
+++ b/drivers/net/dsa/realtek/Kconfig
@@ -16,14 +16,14 @@ menuconfig NET_DSA_REALTEK
 if NET_DSA_REALTEK
 
 config NET_DSA_REALTEK_MDIO
-	tristate "Realtek MDIO interface support"
+	bool "Realtek MDIO interface support"
 	depends on OF
 	help
 	  Select to enable support for registering switches configured
 	  through MDIO.
 
 config NET_DSA_REALTEK_SMI
-	tristate "Realtek SMI interface support"
+	bool "Realtek SMI interface support"
 	depends on OF
 	help
 	  Select to enable support for registering switches connected
diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index f4f9c6340d5f..cea0e761d20f 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_NET_DSA_REALTEK)		+= realtek-dsa.o
-realtek-dsa-objs			:= realtek-common.o
-obj-$(CONFIG_NET_DSA_REALTEK_MDIO) 	+= realtek-mdio.o
-obj-$(CONFIG_NET_DSA_REALTEK_SMI) 	+= realtek-smi.o
+realtek-dsa-objs-y			:= realtek-common.o
+realtek-dsa-objs-$(CONFIG_NET_DSA_REALTEK_MDIO) += realtek-mdio.o
+realtek-dsa-objs-$(CONFIG_NET_DSA_REALTEK_SMI) += realtek-smi.o
+realtek-dsa-objs			:= $(realtek-dsa-objs-y)
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
 rtl8366-objs 				:= rtl8366-core.o rtl8366rb.o
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
index 80b37e5fe780..dcf859ea78ab 100644
--- a/drivers/net/dsa/realtek/realtek-common.c
+++ b/drivers/net/dsa/realtek/realtek-common.c
@@ -128,5 +128,6 @@ void realtek_common_remove(struct realtek_priv *priv)
 EXPORT_SYMBOL(realtek_common_remove);
 
 MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
+MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Realtek DSA switches common module");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 1eed09ab3aa1..967f6c1e8df0 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -177,7 +177,3 @@ void realtek_mdio_shutdown(struct mdio_device *mdiodev)
 	dev_set_drvdata(&mdiodev->dev, NULL);
 }
 EXPORT_SYMBOL_GPL(realtek_mdio_shutdown);
-
-MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
-MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via MDIO interface");
-MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index fc54190839cf..2b2c6e34bae5 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -456,7 +456,3 @@ void realtek_smi_shutdown(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 }
 EXPORT_SYMBOL_GPL(realtek_smi_shutdown);
-
-MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
-MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via SMI interface");
-MODULE_LICENSE("GPL");
-- 
2.43.0


