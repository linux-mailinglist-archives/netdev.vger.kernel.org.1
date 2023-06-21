Return-Path: <netdev+bounces-12709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BED7389D2
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F2E1C20AED
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D176B19BC0;
	Wed, 21 Jun 2023 15:37:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13A319BA3
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 15:37:46 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA731FE4
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:37:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f6283d0d84so8397508e87.1
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687361830; x=1689953830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXhQ0UIxbIRXJu72M9URbDfOLtQ/Rc/6HlYK7uavKwg=;
        b=ZKNhsBXVBWDsZT+gQdyHtPSF2CiUZVn4CH6FHKpTsKLUctQft/ssO2/+UcidIhXoYH
         yaRcbER3BLmJX2YRyh2Qvhy3wzwg0LeX6QpjXO0PvLPe7V4TFPTDbX0ZVff9ownq7439
         Q8Z7u3EF7o/MgMWDNR6O3IgHWvB5ArH6vvoJD4s16hZbMC2/zBfT7GJ6heD12O0/2E0s
         dbIpgvmhH2I+OKUzQxtKEWgGaisUjfeMOP78NKVcoOKszCa2f2T/SzgjG+ig5aN7ZH+2
         s6Z2FnCYcI4mE5O/rt3od3+4hevgnH0SYppx8dLK49t5XHV9TjyAF7SVqR7RLcEn3ynA
         p80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361830; x=1689953830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXhQ0UIxbIRXJu72M9URbDfOLtQ/Rc/6HlYK7uavKwg=;
        b=OUjlYYB7BwMoTzSD16EP2GYWdjfYzMeADPz6cguWX8p3A+DhzQcQxt3/OISLF0j9dL
         lFTEUQdDFj956O5mMWTxVnsnw7UeNHayI1cvWSiXe7gs5r+nkPzGP+tk3Tzrt+jbM0wO
         lyk1G16aDlmSrYwmPr5yLt+zpnhTKieJSfXI+WyeTcuIdRvFSn0GQ1qqMsP1owKNa707
         oTwE+nyP3/+5ekZHa1cv9xDDTVZ4vxvyC6o/O4uItl+HBO4cwvJC6cnEcBBk9UlA6QID
         7FZm03HEVVk4ls6dt7+KsSmcHnuTvmm23KSS1PvZXGT/iaFi2slCRmeYvLYJ2so7Cwva
         C/SA==
X-Gm-Message-State: AC+VfDxqQS/o8Z8ToPHHQNzRr+qKURNuHs/PRmJxQ/qXGam+WxF0t7RS
	0yFgOrllNcR4vJt2U2pYmy3PPQ==
X-Google-Smtp-Source: ACHHUZ4uJSo2gHx8ZKi/3Nrj3/6juOImyrIJVAJT2kltHhI9yCnZTfyVARk3e8AbVi+9c52J2HXnIg==
X-Received: by 2002:ac2:5f99:0:b0:4f8:6cad:aae7 with SMTP id r25-20020ac25f99000000b004f86cadaae7mr6596886lfe.61.1687361830338;
        Wed, 21 Jun 2023 08:37:10 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f7ed463954sm5322491wme.25.2023.06.21.08.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:37:09 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Junxiao Chang <junxiao.chang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next 08/11] net: stmmac: platform: provide devm_stmmac_probe_config_dt()
Date: Wed, 21 Jun 2023 17:36:47 +0200
Message-Id: <20230621153650.440350-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621153650.440350-1-brgl@bgdev.pl>
References: <20230621153650.440350-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Provide a devres variant of stmmac_probe_config_dt() that allows users to
skip calling stmmac_remove_config_dt() at driver detach.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 35 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  2 ++
 2 files changed, 37 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 58d5c5cc2269..043fdfdef6d4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -8,6 +8,7 @@
   Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
 *******************************************************************************/
 
+#include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/module.h>
@@ -629,6 +630,39 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	return ret;
 }
 
+static void devm_stmmac_remove_config_dt(void *data)
+{
+	struct plat_stmmacenet_data *plat = data;
+
+	/* Platform data argument is unused */
+	stmmac_remove_config_dt(NULL, plat);
+}
+
+/**
+ * devm_stmmac_probe_config_dt
+ * @pdev: platform_device structure
+ * @mac: MAC address to use
+ * Description: Devres variant of stmmac_probe_config_dt(). Does not require
+ * the user to call stmmac_remove_config_dt() at driver detach.
+ */
+struct plat_stmmacenet_data *
+devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
+{
+	struct plat_stmmacenet_data *plat;
+	int ret;
+
+	plat = stmmac_probe_config_dt(pdev, mac);
+	if (IS_ERR(plat))
+		return plat;
+
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       devm_stmmac_remove_config_dt, plat);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return plat;
+}
+
 /**
  * stmmac_remove_config_dt - undo the effects of stmmac_probe_config_dt()
  * @pdev: platform_device structure
@@ -657,6 +691,7 @@ void stmmac_remove_config_dt(struct platform_device *pdev,
 }
 #endif /* CONFIG_OF */
 EXPORT_SYMBOL_GPL(stmmac_probe_config_dt);
+EXPORT_SYMBOL_GPL(devm_stmmac_probe_config_dt);
 EXPORT_SYMBOL_GPL(stmmac_remove_config_dt);
 
 int stmmac_get_platform_resources(struct platform_device *pdev,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
index af52d5aa2b9a..8c1e5b2e9dae 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
@@ -13,6 +13,8 @@
 
 struct plat_stmmacenet_data *
 stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac);
+struct plat_stmmacenet_data *
+devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac);
 void stmmac_remove_config_dt(struct platform_device *pdev,
 			     struct plat_stmmacenet_data *plat);
 
-- 
2.39.2


