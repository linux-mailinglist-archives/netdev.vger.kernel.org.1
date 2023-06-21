Return-Path: <netdev+bounces-12712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1C87389E4
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F011C2029B
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BD219E50;
	Wed, 21 Jun 2023 15:37:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A6A19E44
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 15:37:53 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12563BA
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:37:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f90b8ace97so49811445e9.2
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687361834; x=1689953834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6sVXJ2cleHMEi/0WcOIV4n/ZjjS+cQY293Qzlx7CXQ=;
        b=ytqBTHWqr0O6rcQRNtmKsh6dLK9ftebsw4tdZY0QALt/SZisDjORIlR8rIG6/uV3md
         Fi9A4HVDkOyoWSMA7Mz7056cAx44DmV7cxp+RvXiGtXEmoT53ssbK/UINJgMzKIxvjiX
         i6NQ8irc3evTR/v0RNBj96Z3U0BLUfvP7hZoPoOFthjN4cKd5kn+4dQvMOLTziRTaxA5
         C4MjpzPVOkOSoxgU8IRrMXT42kvmzDvulnhca8o+5D8Rm/UVKjTQQPM0hbKnRFubb8MC
         GcihCfDkvFZHTukagIqhhPGdtFVti8r8T6ObiUbjglX8KjcFlCqOoEerd/t0KuX9ecDg
         G5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361834; x=1689953834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6sVXJ2cleHMEi/0WcOIV4n/ZjjS+cQY293Qzlx7CXQ=;
        b=XVT29TAC5bM0u2yNAcp6y6D56oEp9AmbKYSKL40nV+jcNHNoOfc2PWz8EA9LkijPNf
         FQVQyqzvN7Zv+lCfdbZsn0cdo5FaBxk05p8UsEtUr414MwA7cW5a/r02vR6q/Cd8ZEbS
         2ekHLSBDYx3jenhtGRhnZJEz4UCRV2iKkqV+a787VMoPjQjJuep7ypBPndx47/9ksQrQ
         IUktBOJnze/sDtRyVgkfvb2wDny70lZXYtkhq7g/Zd+ryP5pVSe1KjqDFRFMSgphJGln
         2VFdJontnetdKGkm+D2gZczbzQMnHqZGBlYpZtEvyaECqTNY9iGC3WHoidPHM0zx8vSg
         yFwQ==
X-Gm-Message-State: AC+VfDyg0yRk9G0zb46hIfgvJOGa8HSHG7C20Yemsfds+vPRdHQmgxdM
	tcz7wJz2YYZXyemPc6PiZ/DE1A==
X-Google-Smtp-Source: ACHHUZ6vWMgzwi5LD2ZvSmbyFHyTJXtLbN1jGnRVAYlkgSjDYwX4jrJvwJ0I7n0yZevtJM1G7OlRsA==
X-Received: by 2002:a7b:c8c9:0:b0:3f9:b8df:26ae with SMTP id f9-20020a7bc8c9000000b003f9b8df26aemr3963143wml.34.1687361833803;
        Wed, 21 Jun 2023 08:37:13 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f7ed463954sm5322491wme.25.2023.06.21.08.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:37:13 -0700 (PDT)
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
Subject: [PATCH net-next 11/11] net: stmmac: dwmac-qcom-ethqos: use devm_stmmac_pltfr_probe()
Date: Wed, 21 Jun 2023 17:36:50 +0200
Message-Id: <20230621153650.440350-12-brgl@bgdev.pl>
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

Use the devres variant of stmmac_pltfr_probe() and finally drop the
remove() callback entirely.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 7b9fbcb8d84d..e62940414e54 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -787,7 +787,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		plat_dat->serdes_powerdown  = qcom_ethqos_serdes_powerdown;
 	}
 
-	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
+	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
 static const struct of_device_id qcom_ethqos_match[] = {
@@ -801,7 +801,6 @@ MODULE_DEVICE_TABLE(of, qcom_ethqos_match);
 
 static struct platform_driver qcom_ethqos_driver = {
 	.probe  = qcom_ethqos_probe,
-	.remove_new = stmmac_pltfr_remove_no_dt,
 	.driver = {
 		.name           = "qcom-ethqos",
 		.pm		= &stmmac_pltfr_pm_ops,
-- 
2.39.2


