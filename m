Return-Path: <netdev+bounces-21068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1727C762492
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E8F1C20FBD
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 21:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A88A26B94;
	Tue, 25 Jul 2023 21:37:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32401F188
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 21:37:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05731FD2
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 14:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690320613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uK3zP8luGfpdcnVrRakVsTeHLiN3hIMl3KOmXd3egZQ=;
	b=gn8KUKYFx5SvcPtuVvTSf5VoN8OTtAXx2EBnQ+Nt+zswbbyO208LzE5AVrfirFYie66ZKA
	QzYfYJRfS7QjOp1YDIFbtov56EZ4I02sVnGxah7zcSF2c99y3q9oOOdmNF9FEB+MQr9xsv
	YJ+u/EVs24TZigkaAFtYJ4x0FJkq3iQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-5gcdeYgKPGi9Yz07vtspiA-1; Tue, 25 Jul 2023 17:30:12 -0400
X-MC-Unique: 5gcdeYgKPGi9Yz07vtspiA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7683cdabcb7so808398085a.3
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 14:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690320612; x=1690925412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uK3zP8luGfpdcnVrRakVsTeHLiN3hIMl3KOmXd3egZQ=;
        b=c2Z1cT4QsAfsFcNtDiWBb0MTQ8egedEQwDWQOiq/n/+dNQCKhYkuoF/WT7tTJ3h2Hk
         c+Dfk4Bpdsx81YVCSc/dX3gNIshDX1qTVvyt56q+H5iqY1JqiqynN3oBGwnmseJX8CN9
         5S7rUjfdwQ2bkIl6GHUtQxmcZ1HygFs4GFkUulB1Sv0mq+jv9ciOl7HT48cyYCTPpicr
         EVscQEiTE2b1U1pU1jHFmD5Z6TLSvyDNx8PUQee43//3913mQePmSpbREINiBFi06ybV
         kkcYEVCc07Mib7fDrk8Yj41vOhaAlxRnwQCfjnn9Mqqof4co9dKgLoX9ZGQ6l3z+2yve
         n1hQ==
X-Gm-Message-State: ABy/qLbTMLYqVWVgyuybpezzDOiwnKkyDIvUB8cjKqJsCvNb5JZGcEvl
	PoGvhcK4wwzW2GPcgKlvWMPEwxb8l3PMnefgZ/RRfH/6jOab8yZ3mRtHYrkHE2f6HzKqUWp9BOX
	kDXAVZV09Tzfye0Ad
X-Received: by 2002:a05:620a:2545:b0:768:156e:41b8 with SMTP id s5-20020a05620a254500b00768156e41b8mr171370qko.56.1690320612183;
        Tue, 25 Jul 2023 14:30:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFed3Kq4JhRY5nCg9QF+L66gABirAe874NXCX9weK6QU/6x4lyMcM2Gcjb9IOg9DiukLElQKA==
X-Received: by 2002:a05:620a:2545:b0:768:156e:41b8 with SMTP id s5-20020a05620a254500b00768156e41b8mr171347qko.56.1690320611986;
        Tue, 25 Jul 2023 14:30:11 -0700 (PDT)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::17])
        by smtp.gmail.com with ESMTPSA id j3-20020a37c243000000b00767d7307490sm3943067qkm.34.2023.07.25.14.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 14:30:11 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/2] net: stmmac: Make ptp_clk_freq_config variable type explicit
Date: Tue, 25 Jul 2023 16:04:25 -0500
Message-ID: <20230725211853.895832-3-ahalaney@redhat.com>
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
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The priv variable is _always_ of type (struct stmmac_priv *), so let's
stop using (void *) since it isn't abstracting anything.

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 3 +--
 include/linux/stmmac.h                            | 4 +++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 0ffae785d8bd..979c755964b1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -257,9 +257,8 @@ static void intel_speed_mode_2500(struct net_device *ndev, void *intel_data)
 /* Program PTP Clock Frequency for different variant of
  * Intel mGBE that has slightly different GPO mapping
  */
-static void intel_mgbe_ptp_clk_freq_config(void *npriv)
+static void intel_mgbe_ptp_clk_freq_config(struct stmmac_priv *priv)
 {
-	struct stmmac_priv *priv = (struct stmmac_priv *)npriv;
 	struct intel_priv_data *intel_priv;
 	u32 gpio_value;
 
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index ef67dba775d0..3d0702510224 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -76,6 +76,8 @@
 			| DMA_AXI_BLEN_32 | DMA_AXI_BLEN_64 \
 			| DMA_AXI_BLEN_128 | DMA_AXI_BLEN_256)
 
+struct stmmac_priv;
+
 /* Platfrom data for platform device structure's platform_data field */
 
 struct stmmac_mdio_bus_data {
@@ -258,7 +260,7 @@ struct plat_stmmacenet_data {
 	int (*serdes_powerup)(struct net_device *ndev, void *priv);
 	void (*serdes_powerdown)(struct net_device *ndev, void *priv);
 	void (*speed_mode_2500)(struct net_device *ndev, void *priv);
-	void (*ptp_clk_freq_config)(void *priv);
+	void (*ptp_clk_freq_config)(struct stmmac_priv *priv);
 	int (*init)(struct platform_device *pdev, void *priv);
 	void (*exit)(struct platform_device *pdev, void *priv);
 	struct mac_device_info *(*setup)(void *priv);
-- 
2.41.0


