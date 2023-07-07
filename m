Return-Path: <netdev+bounces-15970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D669C74AB6A
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 08:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8816E281687
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 06:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC8E210F;
	Fri,  7 Jul 2023 06:53:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6321FB7
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 06:53:58 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180CD1FDB
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 23:53:53 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f96d680399so2157011e87.0
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 23:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688712831; x=1691304831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=je3l1UGSXl3qbNk8Y0jwMEy8+l5L27PFDjg5qrG9/VM=;
        b=OlmknxXpH0FpY4ZDFqL4X7a4ktDxUvlKBybAH2assHjilZkF0Ohr5mcW1awAYieTtn
         Uu043FkOEkIJvbXUh3YUbf4Mtu3xbh02q3sXocl2245ioES9IO2UKJ1oZW0CcAAGLlgV
         fRuAcYZ7ou4yoJUWYpqw+cLvhug+aBZzeD+xdO5AI+U8NN3Vwd3HAdL3UN1WNBSV8gcp
         hJJByFlqSqwVHGDH9uty6mKeheZKEhYVDafoiMa4uox/9yUfEjLZhqf+1OvDCCm1mUAq
         GuTDpET0dr2eWV0wnqixBR+O9WduDZoXR1joMuCyzz+2WPrUK4e4VAxRST8qhueLZj/V
         YIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688712831; x=1691304831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=je3l1UGSXl3qbNk8Y0jwMEy8+l5L27PFDjg5qrG9/VM=;
        b=Ua0dPXxryw5RZcd+lT/OCyeg0nJS2U2iDH9QVXVj6OIa4YEiAIk0hAxd/fvrZIV5Aj
         vc+ddJSsOPSeLs4dibebvhluXKTvi3/5Mjvfr6lqSGF97HwaXgBXVlsUE8rKms5iLrst
         alKXmRfZSZmAi3ZyrgLkefAC8dnjGBhKvhKEvmsdZfOieXjdIoKQPcyhnX+aJqFlCWF1
         NOm6CvLi3v17Yd4KgXbMSAJYrPwXzJSPqNbD68ZwRIMqggvUoQCGhJeBAYRMlklFR4lG
         9xSaXRgwZTpBxQj6ksp3VS71uFjQHc9Ef9z/AjTXn5ygbBJ6HOVCHEFzgBzr+lNcxsWI
         ITXg==
X-Gm-Message-State: ABy/qLYsaF574pvKaSCMF36AA6iS8I2O9v8FRk9oDeAvXqniB/WTgutH
	ZMkSsxjQYooilGpBvDfMOUQ=
X-Google-Smtp-Source: APBJJlFWeXBGagh4fLzcU7Cue0vPz8agr+CvVj1bBSq48hgce233y9prLE6813udH1l35DWMCmcOEg==
X-Received: by 2002:a19:3819:0:b0:4f8:631b:bf77 with SMTP id f25-20020a193819000000b004f8631bbf77mr3785907lfa.22.1688712830733;
        Thu, 06 Jul 2023 23:53:50 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id er23-20020a05651248d700b004fba6f38f87sm558121lfb.24.2023.07.06.23.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 23:53:50 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH net.git] net: bgmac: postpone turning IRQs off to avoid SoC hangs
Date: Fri,  7 Jul 2023 08:53:25 +0200
Message-Id: <20230707065325.11765-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Rafał Miłecki <rafal@milecki.pl>

Turning IRQs off is done by accessing Ethernet controller registers.
That can't be done until device's clock is enabled. It results in a SoC
hang otherwise.

This bug remained unnoticed for years as most bootloaders keep all
Ethernet interfaces turned on. It seems to only affect a niche SoC
family BCM47189. It has two Ethernet controllers but CFE bootloader uses
only the first one.

Fixes: 34322615cbaa ("net: bgmac: Mask interrupts during probe")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/net/ethernet/broadcom/bgmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 1761df8fb7f9..10c7c232cc4e 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1492,8 +1492,6 @@ int bgmac_enet_probe(struct bgmac *bgmac)
 
 	bgmac->in_init = true;
 
-	bgmac_chip_intrs_off(bgmac);
-
 	net_dev->irq = bgmac->irq;
 	SET_NETDEV_DEV(net_dev, bgmac->dev);
 	dev_set_drvdata(bgmac->dev, bgmac);
@@ -1511,6 +1509,8 @@ int bgmac_enet_probe(struct bgmac *bgmac)
 	 */
 	bgmac_clk_enable(bgmac, 0);
 
+	bgmac_chip_intrs_off(bgmac);
+
 	/* This seems to be fixing IRQ by assigning OOB #6 to the core */
 	if (!(bgmac->feature_flags & BGMAC_FEAT_IDM_MASK)) {
 		if (bgmac->feature_flags & BGMAC_FEAT_IRQ_ID_OOB_6)
-- 
2.35.3


