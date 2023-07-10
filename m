Return-Path: <netdev+bounces-16592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F60974DF0A
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 22:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E66D1C20BD6
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D953E154BD;
	Mon, 10 Jul 2023 20:17:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE10C14AB0
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 20:17:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732A113E
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689020256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YmlAnwDpnt7QnZH9R1+eVRqHntPGLtyJNksmlK12GAU=;
	b=EOkQN6twhZrgUcYmbPrfnWduq5z+Beqp4QwpmPbVKca1sFR4o28fzHL8eHxF3lo2/wWoK+
	Yr5bkI4ILbZg0t8YecAngOG5aphu/vvbZfDk0AVYcn3ozYeSLIDNEHb4sZUzYBhVcI6Cud
	O7A+BHxx7H4rlgWAxaE0CA7Wvq2xU4o=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-noJKcT9tM_WjzMKiGZbhww-1; Mon, 10 Jul 2023 16:17:35 -0400
X-MC-Unique: noJKcT9tM_WjzMKiGZbhww-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5635b23aa0cso3200388eaf.0
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689020254; x=1691612254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmlAnwDpnt7QnZH9R1+eVRqHntPGLtyJNksmlK12GAU=;
        b=OkBzG8YC5UM1KB2u8EFi+SYCT9mp5TESVlKfrW0QdBe2VFLU/v7x6eC2aezEZ+nsnI
         nAqYLtSQNDtm9IvnNelZEckKHC29PiP68N/cTHx1a0qopKBEjj0hHeqUjoyYSSDAH7tx
         yZvSMXb39AmPyF7FxkVthz/yRnrL3qtHKlhFsOige4aSE+Bv92nDAOe7FsksDwTfrFo0
         z3iqqcSiB4HUIvgVDWOu0tgzqErLFykLUZoHyptunRM7lGiq75s+eQQ9dJU3JwC+p1Yh
         rthgDTqpKgeEW5POgshPwcDH/ZnBH5X+aqpGksMgvYjRhWavs0c6+g+dGRjx9u15nwiP
         0wJQ==
X-Gm-Message-State: ABy/qLY5RBhS9MntxPyZCIJTkMIy7dAnokRfGMqRFpkS9ni56PcpMCjc
	rxkxDg2DsEIKuN4bOmh/OB1sg0DwX4tTnanPjlqTeiXrEKlchfoTBdsBRM3x4OTsiGhB3F5qAKJ
	IJfLBBCHa2AHVsiry
X-Received: by 2002:a05:6870:5254:b0:1b0:4fc5:2e4b with SMTP id o20-20020a056870525400b001b04fc52e4bmr13438904oai.9.1689020254688;
        Mon, 10 Jul 2023 13:17:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFmKqPEtPtyW1H2DGn/G9uxqGi6UQiom7uSU/SpIgU9Y6/TP9FG19pTfynkVg73dr92H4bGyw==
X-Received: by 2002:a05:6870:5254:b0:1b0:4fc5:2e4b with SMTP id o20-20020a056870525400b001b04fc52e4bmr13438882oai.9.1689020254461;
        Mon, 10 Jul 2023 13:17:34 -0700 (PDT)
Received: from halaney-x13s.attlocal.net ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id j12-20020a81920c000000b0056d2a19ad91sm155097ywg.103.2023.07.10.13.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:17:34 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	mcoquelin.stm32@gmail.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	joabreu@synopsys.com,
	alexandre.torgue@foss.st.com,
	peppe.cavallaro@st.com,
	bhupesh.sharma@linaro.org,
	vkoul@kernel.org,
	linux-arm-msm@vger.kernel.org,
	andrew@lunn.ch,
	simon.horman@corigine.com,
	Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next v2 1/3] net: stmmac: dwmac-qcom-ethqos: Use of_get_phy_mode() over device_get_phy_mode()
Date: Mon, 10 Jul 2023 15:06:37 -0500
Message-ID: <20230710201636.200412-2-ahalaney@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710201636.200412-1-ahalaney@redhat.com>
References: <20230710201636.200412-1-ahalaney@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since this driver only uses devicetree, let's move over to
of_get_phy_mode(). That API has an explicit error return and produces a
phy_interface_t directly instead of an int when representing the phy
mode.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

Changes since v1:
    * Convert to using of_get_phy_mode() instead of continuing to use
      device_get_phy_mode() (Andrew Lunn)

 .../net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index e62940414e54..ebafdadb28d5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -4,10 +4,10 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_net.h>
 #include <linux/platform_device.h>
 #include <linux/phy.h>
 #include <linux/phy/phy.h>
-#include <linux/property.h>
 
 #include "stmmac.h"
 #include "stmmac_platform.h"
@@ -104,7 +104,7 @@ struct qcom_ethqos {
 	struct clk *link_clk;
 	struct phy *serdes_phy;
 	unsigned int speed;
-	int phy_mode;
+	phy_interface_t phy_mode;
 
 	const struct ethqos_emac_por *por;
 	unsigned int num_por;
@@ -720,7 +720,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	if (!ethqos)
 		return -ENOMEM;
 
-	ethqos->phy_mode = device_get_phy_mode(dev);
+	ret = of_get_phy_mode(np, &ethqos->phy_mode);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get phy mode\n");
 	switch (ethqos->phy_mode) {
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
@@ -731,8 +733,6 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	case PHY_INTERFACE_MODE_SGMII:
 		ethqos->configure_func = ethqos_configure_sgmii;
 		break;
-	case -ENODEV:
-		return -ENODEV;
 	default:
 		return -EINVAL;
 	}
-- 
2.41.0


