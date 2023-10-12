Return-Path: <netdev+bounces-40510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE957C78D5
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0181D1F209A5
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141CD3F4C9;
	Thu, 12 Oct 2023 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FtNoL2no"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC553F4B5
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:53:07 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F749BB
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:53:05 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7a6fd18abso22447407b3.1
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697147584; x=1697752384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YTkEOzvlwSRqd6Swcq6Hh8KnurUwVBxQe6czHRUN7YA=;
        b=FtNoL2noI3RqR2YnxNeaa8qvVLPTp1yVrdLnAP7wKepMJr2uoStoUFLVA/Ej1FRCx9
         JBPTaJAo/FOU/AmLAsazfYh/exqjHQbu3ZHsg1hklq3LtQ7pnUePUXNjcaPrsr32CjI8
         jfyGQCelOcGO6v0BYZTTm4nphF5qvkweVX7zuDuspmyOIgJDPKb/2YDqIFTrn2yxipVi
         U7mSTxQ1WxBTsusu8sCsKloCD2mIawIxKIVPL0S40zPeD1MC7EbArJfuMlVZ8/MOvV/4
         rD5YAEfckx+VELw0saMifUBbrxLcQW0kk+y67uF7MTH3chKdcxngREoQKi1elLzfUEX6
         qdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697147584; x=1697752384;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTkEOzvlwSRqd6Swcq6Hh8KnurUwVBxQe6czHRUN7YA=;
        b=GTFvzs7wBDhqAGdQrBEVfsyqU0DZRmc2hr4CWvmGskwePoqU8bkPPE10aknvWUg/R1
         TtXPd9RhUygKEtwNOu7vG6A+HVj82U/RKKjZa5nYZ36jimMXXRSUgY+7bL7lvbujBtFE
         e6GjjaLhmCMyu1xT3qbwwJ4wJ3N2V95WvDyobUpmwmpa/1aXbZSx7X9cYzEhtVjdUKoQ
         D2/cwDP07uE9c7TBrnffcfhQZncR25Mz9sP39YHmszBEs9svaLGwMFd9LyxFPW7Qc0rm
         gPr4+I0AuBW7vMdHePwrNlo42vlx1rzqj6e6hST917sHZAx3nFgm3HQSibQ1o3zV2J3j
         EAlg==
X-Gm-Message-State: AOJu0Yx1n3atV7/9zpEa2FJUJ5f8CeRZhQjlDg1dN65tTAKcrT1WYPSH
	43EpLPGIIPP+3S4uVAXTZmTX/FKUz1lfEeWi4Q==
X-Google-Smtp-Source: AGHT+IH3hZtlVts0HOlSErW//1wUr4F64NtzYskB5unXmRyXv32EwZy/FojwDmAhgCdBFp8rnYnYhUpfhdYfQxR12w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:7e4c:0:b0:584:41a6:6cd8 with SMTP
 id p12-20020a817e4c000000b0058441a66cd8mr501646ywn.8.1697147584487; Thu, 12
 Oct 2023 14:53:04 -0700 (PDT)
Date: Thu, 12 Oct 2023 21:53:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAL5qKGUC/x3NQQqDMBBA0avIrDuQREJKryJSbDLWWTSGGZWKe
 HeDy7f5/wAlYVJ4NQcIbaw85wr7aCBOQ/4ScqoGZ1xrjXWoi+RYdkzCG4lipgXLtOMv8fz+rIo RzWCSp2fwwTqooSI08v+edP15Xjy38kl0AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697147583; l=1868;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=vdQUeoyWeauGUEEyEYmjpmzS6T1B4Kyza0zZ2VuUMVU=; b=08rcTE44cKhSckEbxhG3eLzKqTkBARP9qjlbUWs+AlqMspRHIZZZigeo48P5fBG2TNtbAKjvp
 D8L72jxZBnvDlw5D8Lnl4a3l+c5sqVGWu3+A9JBjMYWws5qQcY0Htn6
X-Mailer: b4 0.12.3
Message-ID: <20231012-strncpy-drivers-net-phy-mdio_bus-c-v1-1-15242e6f9ec4@google.com>
Subject: [PATCH] net: mdio: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect mdiodev->modalias to be NUL-terminated based on its usage with
strcmp():
|       return strcmp(mdiodev->modalias, drv->name) == 0;

Moreover, mdiodev->modalias is already zero-allocated:
|       mdiodev = kzalloc(sizeof(*mdiodev), GFP_KERNEL);
... which means the NUL-padding strncpy provides is not necessary.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/phy/mdio_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 25dcaa49ab8b..6cf73c15635b 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -506,7 +506,7 @@ static int mdiobus_create_device(struct mii_bus *bus,
 	if (IS_ERR(mdiodev))
 		return -ENODEV;
 
-	strncpy(mdiodev->modalias, bi->modalias,
+	strscpy(mdiodev->modalias, bi->modalias,
 		sizeof(mdiodev->modalias));
 	mdiodev->bus_match = mdio_device_bus_match;
 	mdiodev->dev.platform_data = (void *)bi->platform_data;

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231012-strncpy-drivers-net-phy-mdio_bus-c-0a0d5e875712

Best regards,
--
Justin Stitt <justinstitt@google.com>


