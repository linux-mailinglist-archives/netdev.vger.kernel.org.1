Return-Path: <netdev+bounces-13345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7655273B4ED
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6F4281A48
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654885694;
	Fri, 23 Jun 2023 10:09:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250A8BE0
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:09:09 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846C630D2
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:09:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-307d20548adso447392f8f.0
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514944; x=1690106944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXLmQoTjoeXO9UdxG4BxiuLilLfncmL1ryydj7qwo7o=;
        b=iuwXz7mi6f6iU0NcWp3IDb41yk29667vEnsshk9+azB14/0XRb4tvgzz6w39k3UTHI
         j2vrD+bdyXkKEaao49viU132lD8XiB25y1YMMpENHRdDdLKEcum9oFqEvdbKjP9y8da5
         X52/sVYz4RUXsng3XhH2hPu2lKWOiqKCGdDn3pRVnL98PbYqq/rf9NPcW/5o2btPrvg+
         Sk8hWAQFTveGNcA6uCue2YXhwwf96LNTNp+YupxiQO05jM9DUMnk2sR6heUMz7ev+uyV
         /ynJkqHrj/9s+iRGxHi8vNNiaP50BFq9jrS8Dd1LpWOdRl60B/CABBpBNcsavWpemlVF
         h5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514944; x=1690106944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXLmQoTjoeXO9UdxG4BxiuLilLfncmL1ryydj7qwo7o=;
        b=D9RLbUmUZDAoHlBpNyuZdmYtoTw6UJHU4rF+tuNwVI/nVnfHWWJ8TmU201T78bAb5F
         23mcrSss+6O7ymAsSdaXEsK791s2BLchKptYqqVCOJrRuggl9Og5ULec4kB0QlvoU0dO
         boQmHWatLnEUzhE4L3zYUfCFAlpdkDgBOpGp5EI1PWjkNUtAzWPhtIAPUlBf0TPKBOuC
         BQbfIqwX23hTxJQnmSnUfyvFihF6+wUYwPcCyRV47cxzqfpuy7ncInR+c6PaI3jaAB24
         2KIUbXZT87Fg3/D6AGLDkeMFVHh/Tm8pDzkytzuOvJwTTLFMMlgOxfOOneD7E3tHNwV7
         HLTw==
X-Gm-Message-State: AC+VfDwoQAaY2IwYYyR/qdtHTiHWkXjxtiHanVJ08JjkjIRTYdLDERDj
	b9km+Gs+vYWrMI5JREhWZWd06Q==
X-Google-Smtp-Source: ACHHUZ5/NdwcI1og4z221h8R95D/JxwEhxGIovnZLwKRI0b3FDhihpgtidabzJtIHqcrQZ259Ayzyg==
X-Received: by 2002:a05:6000:8d:b0:311:db0:8aff with SMTP id m13-20020a056000008d00b003110db08affmr3377766wrx.70.1687514943901;
        Fri, 23 Jun 2023 03:09:03 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id k18-20020adfe8d2000000b0030ae3a6be4asm9278100wrn.72.2023.06.23.03.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:09:03 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Andrew Halaney <ahalaney@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next v2 10/12] net: stmmac: replace the int_snapshot_en field with a flag
Date: Fri, 23 Jun 2023 12:08:43 +0200
Message-Id: <20230623100845.114085-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623100845.114085-1-brgl@bgdev.pl>
References: <20230623100845.114085-1-brgl@bgdev.pl>
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

Drop the boolean field of the plat_stmmacenet_data structure in favor of a
simple bitfield flag.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c     | 10 +++++-----
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c |  2 +-
 include/linux/stmmac.h                                |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index a3d0da4e9e91..0ffae785d8bd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -329,7 +329,7 @@ static int intel_crosststamp(ktime_t *device,
 	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
 		return -EBUSY;
 
-	priv->plat->int_snapshot_en = 1;
+	priv->plat->flags |= STMMAC_FLAG_INT_SNAPSHOT_EN;
 
 	mutex_lock(&priv->aux_ts_lock);
 	/* Enable Internal snapshot trigger */
@@ -350,7 +350,7 @@ static int intel_crosststamp(ktime_t *device,
 		break;
 	default:
 		mutex_unlock(&priv->aux_ts_lock);
-		priv->plat->int_snapshot_en = 0;
+		priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 		return -EINVAL;
 	}
 	writel(acr_value, ptpaddr + PTP_ACR);
@@ -376,7 +376,7 @@ static int intel_crosststamp(ktime_t *device,
 	if (!wait_event_interruptible_timeout(priv->tstamp_busy_wait,
 					      stmmac_cross_ts_isr(priv),
 					      HZ / 100)) {
-		priv->plat->int_snapshot_en = 0;
+		priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 		return -ETIMEDOUT;
 	}
 
@@ -395,7 +395,7 @@ static int intel_crosststamp(ktime_t *device,
 	}
 
 	system->cycles *= intel_priv->crossts_adj;
-	priv->plat->int_snapshot_en = 0;
+	priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 
 	return 0;
 }
@@ -609,7 +609,7 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	plat->ext_snapshot_num = AUX_SNAPSHOT0;
 
 	plat->crosststamp = intel_crosststamp;
-	plat->int_snapshot_en = 0;
+	plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 
 	/* Setup MSI vector offset specific to Intel mGbE controller */
 	plat->msi_mac_vec = 29;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index afd81aac6644..fa2c3ba7e9fe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -180,7 +180,7 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
 	u64 ptp_time;
 	int i;
 
-	if (priv->plat->int_snapshot_en) {
+	if (priv->plat->flags & STMMAC_FLAG_INT_SNAPSHOT_EN) {
 		wake_up(&priv->tstamp_busy_wait);
 		return;
 	}
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 0a77e8b05d3a..47708ddd57fd 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -213,6 +213,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_VLAN_FAIL_Q_EN		BIT(6)
 #define STMMAC_FLAG_MULTI_MSI_EN		BIT(7)
 #define STMMAC_FLAG_EXT_SNAPSHOT_EN		BIT(8)
+#define STMMAC_FLAG_INT_SNAPSHOT_EN		BIT(9)
 
 struct plat_stmmacenet_data {
 	int bus_id;
@@ -286,7 +287,6 @@ struct plat_stmmacenet_data {
 	struct pci_dev *pdev;
 	int int_snapshot_num;
 	int ext_snapshot_num;
-	bool int_snapshot_en;
 	int msi_mac_vec;
 	int msi_wol_vec;
 	int msi_lpi_vec;
-- 
2.39.2


