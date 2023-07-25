Return-Path: <netdev+bounces-21066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A172762471
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1701C20FAC
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 21:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E2D26B92;
	Tue, 25 Jul 2023 21:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6752F1F188
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 21:30:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C501FEB
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 14:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690320624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6R5PqHz89a5dYS6wq5jIGBjMTrYBr/afZbcaHTTyIA=;
	b=BammLYoDblRMEhIessf1ogwK0egFBi8MdptZnOrnAkwAtaiBpKNBS+pM8uNDntY8/KItGV
	7eFDa1fdDmtnAknrV+hz1kJPlch9yxC/h44AWqBdii+rhqr+lm0NcIS9V2d/T9OPvq0o6L
	SqlhzM2SJ6f53OONeUiv6t/GaYIEyN8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-pxNS2ur_P0OxwWo4nAfDPA-1; Tue, 25 Jul 2023 17:30:21 -0400
X-MC-Unique: pxNS2ur_P0OxwWo4nAfDPA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7656c94fc4eso809011885a.2
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 14:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690320621; x=1690925421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6R5PqHz89a5dYS6wq5jIGBjMTrYBr/afZbcaHTTyIA=;
        b=aRkdJEYnl0iolN0SlJ2uhNXtue+hrZMevcCIB25IBSYrqlMTdR0gsMnB8Bk6imR3YN
         eFW8Ut/P9+oDP4TvdrQP63X7jlgVX+lHH32m7ppbPY2qWhBf9aivkVZtOGPxeriYc6F7
         jgnut1e50+YQowtJY99+xfso9O/NT4w9tMF2Ya2TCmn4WQSWxV4lCKAOcrO5vnUvd8of
         1z2zOzity+llla2r8iAkk5Yam7VI5I/GsIEYm2bKmNOGRMu6wQTn9AAodxGnXmMAuC7I
         2bTt0sSZNqLXMJNBfaE9kGERLn5+qdNdEiUSp+luTjK7qjK0lsaf2K19RQ3mWwTXHvOK
         36NQ==
X-Gm-Message-State: ABy/qLbzZj8kMfi+8wmj8OtOt0ScWm8iAOZhPSgM+98on6ppvcbo0slZ
	ckfLG/DWzDshEv07Ufnq3fCIg5KQh6EBTfq+lGDT0L8rm2BAAchKG69eQjkjyLFJBdoTi1/MJ6Z
	6eKtZJY+vTCRLcyy5
X-Received: by 2002:a05:620a:2545:b0:768:156e:41b8 with SMTP id s5-20020a05620a254500b00768156e41b8mr171811qko.56.1690320621300;
        Tue, 25 Jul 2023 14:30:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEXEDMipNpnjboiVX9tymuPzO29w0eF8hLR09Ab5g7ZDyLrlEARGaZBlmf5qh4U8wb5xzUttQ==
X-Received: by 2002:a05:620a:2545:b0:768:156e:41b8 with SMTP id s5-20020a05620a254500b00768156e41b8mr171797qko.56.1690320620999;
        Tue, 25 Jul 2023 14:30:20 -0700 (PDT)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::17])
        by smtp.gmail.com with ESMTPSA id j3-20020a37c243000000b00767d7307490sm3943067qkm.34.2023.07.25.14.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 14:30:20 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: ahalaney@redhat.com,
	linux-arm-kernel@lists.infradead.org,
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
	jsuraj@qti.qualcomm.com,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v2 2/2] net: stmmac: dwmac-qcom-ethqos: Use max frequency for clk_ptp_ref
Date: Tue, 25 Jul 2023 16:04:26 -0500
Message-ID: <20230725211853.895832-4-ahalaney@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725211853.895832-2-ahalaney@redhat.com>
References: <20230725211853.895832-2-ahalaney@redhat.com>
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
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Qualcomm clocks can set their frequency to a variety of levels
generally. Let's use the max for clk_ptp_ref to ensure the best
timestamping resolution possible.

Without this, the default value of the clock is used. For sa8775p-ride
this is 19.2 MHz, far less than the 230.4 MHz possible.

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 .../stmicro/stmmac/dwmac-qcom-ethqos.c         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 735525ba8b93..a85501874801 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -694,6 +694,23 @@ static void ethqos_clks_disable(void *data)
 	ethqos_clks_config(data, false);
 }
 
+static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
+{
+	struct plat_stmmacenet_data *plat_dat = priv->plat;
+	int err;
+
+	if (!plat_dat->clk_ptp_ref)
+		return;
+
+	/* Max the PTP ref clock out to get the best resolution possible */
+	err = clk_set_rate(plat_dat->clk_ptp_ref, ULONG_MAX);
+	if (err)
+		netdev_err(priv->dev, "Failed to max out clk_ptp_ref: %d\n", err);
+	plat_dat->clk_ptp_rate = clk_get_rate(plat_dat->clk_ptp_ref);
+
+	netdev_dbg(priv->dev, "PTP rate %d\n", plat_dat->clk_ptp_rate);
+}
+
 static int qcom_ethqos_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -779,6 +796,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	plat_dat->bsp_priv = ethqos;
 	plat_dat->fix_mac_speed = ethqos_fix_mac_speed;
 	plat_dat->dump_debug_regs = rgmii_dump;
+	plat_dat->ptp_clk_freq_config = ethqos_ptp_clk_freq_config;
 	plat_dat->has_gmac4 = 1;
 	if (ethqos->has_emac_ge_3)
 		plat_dat->dwmac4_addrs = &data->dwmac4_addrs;
-- 
2.41.0


