Return-Path: <netdev+bounces-42778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0057D0157
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 20:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 502C8B21296
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 18:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CF638DE1;
	Thu, 19 Oct 2023 18:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5110B32C6B
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 18:23:57 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E151C131;
	Thu, 19 Oct 2023 11:23:55 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-581b6b93bd1so2789016eaf.1;
        Thu, 19 Oct 2023 11:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697739835; x=1698344635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpHIOU7Wp27GMqgzvqt6rJSsJfWbSlh8Cuc+Zl5+b70=;
        b=dUMfhD0ur8ppNRP1v1Dy2s6wlpVWK75DnZLXy/3xyoKSPEbcIQPwYBtdO7aBqBJE5S
         DCA5bovJfzNox90fSLd7dov6XtqFvfs7MMnIpMlJjMC5O+feQIOnfjHu+Cmr9yKSeMOm
         wN7C8fqQO7y1tWkdWMwsCvSq4vRKLkvlyXE8aJ796vEKQjs9gYXhkk/qUtSWyju5517f
         fy3QIk8/t+JXjMqh5DUp6U1ZFDmj8uHsqhHWsRNN5KgccLVnmvA85MUcNI46ypQZXDw3
         IrrIApC+xR0WBeapPX3WiZdeMJgNzBoHnWiS9nWler/xvFRM0riNmlaNCM58GyJ9zY+R
         uQZw==
X-Gm-Message-State: AOJu0Yw91kNj11VNmcCj59uu/M2LaTrUPd9ZkhLXghRcGqwmrYEAwdS7
	zDfqEHhlQ/QLw1huBmjl0g==
X-Google-Smtp-Source: AGHT+IEmwz13FFh1neKpPPu7IL+lhBzUiWEh8XEkm02/XSoe4aeksRV89U1oEcz8FxPQfNv7woGvzg==
X-Received: by 2002:a4a:d357:0:b0:56e:466c:7393 with SMTP id d23-20020a4ad357000000b0056e466c7393mr2889760oos.5.1697739834989;
        Thu, 19 Oct 2023 11:23:54 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bt33-20020a05683039e100b006c61c098d38sm22518otb.21.2023.10.19.11.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 11:23:54 -0700 (PDT)
Received: (nullmailer pid 833375 invoked by uid 1000);
	Thu, 19 Oct 2023 18:23:53 -0000
From: Rob Herring <robh@kernel.org>
To: Iyappan Subramanian <iyappan@os.amperecomputing.com>, Keyur Chudgar <keyur@os.amperecomputing.com>, Quan Nguyen <quan@os.amperecomputing.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: kernel test robot <lkp@intel.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: mdio: xgene: Fix unused xgene_mdio_of_match warning for !CONFIG_OF
Date: Thu, 19 Oct 2023 13:23:45 -0500
Message-ID: <20231019182345.833136-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a243ecc323b9 ("net: mdio: xgene: Use device_get_match_data()")
dropped the unconditional use of xgene_mdio_of_match resulting in this
warning:

drivers/net/mdio/mdio-xgene.c:303:34: warning: unused variable 'xgene_mdio_of_match' [-Wunused-const-variable]

The fix is to drop of_match_ptr() which is not necessary because DT is
always used for this driver (well, it could in theory support ACPI only,
but CONFIG_OF is always enabled for arm64).

Fixes: a243ecc323b9 ("net: mdio: xgene: Use device_get_match_data()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310170832.xnVXw1bb-lkp@intel.com/
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/net/mdio/mdio-xgene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-xgene.c b/drivers/net/mdio/mdio-xgene.c
index 495fbe35b6ce..2772a3098543 100644
--- a/drivers/net/mdio/mdio-xgene.c
+++ b/drivers/net/mdio/mdio-xgene.c
@@ -437,7 +437,7 @@ static void xgene_mdio_remove(struct platform_device *pdev)
 static struct platform_driver xgene_mdio_driver = {
 	.driver = {
 		.name = "xgene-mdio",
-		.of_match_table = of_match_ptr(xgene_mdio_of_match),
+		.of_match_table = xgene_mdio_of_match,
 		.acpi_match_table = ACPI_PTR(xgene_mdio_acpi_match),
 	},
 	.probe = xgene_mdio_probe,
-- 
2.42.0


