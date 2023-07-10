Return-Path: <netdev+bounces-16593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA2974DF0B
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 22:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA5C1C20BBF
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9185154A4;
	Mon, 10 Jul 2023 20:17:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD82E156D5
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 20:17:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D54C13E
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689020259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfBCs08BCyvb4rUBf/lFUidTAq5uH0UA99R+iDtQ+Ug=;
	b=Pnya4dSf4foCvV4aRMLFzaJuoB8VBuNFZ9GeishVdwZBhinU4P8rvcFgfeJtugbP0vUBcJ
	/E+N6OTfatjTs3kKboUX2OmR+AwB5QMHWJIi/7xmRi2zWOKecQyXHn5ioTbUs7V7HvQL6j
	RAYVjNpNiRycYE/F2SaJKHLygEeSsBY=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-FH-OcR57NXu079Z5myds6g-1; Mon, 10 Jul 2023 16:17:38 -0400
X-MC-Unique: FH-OcR57NXu079Z5myds6g-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1b443821eefso3301463fac.3
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689020258; x=1691612258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfBCs08BCyvb4rUBf/lFUidTAq5uH0UA99R+iDtQ+Ug=;
        b=ejSvk1RqWC6wtaxLtzw+6RM+uEYD295wA2YZ+we9V5MeMPtgW7Naccp+QeMjqpgrgA
         5N2wFK23KVwQtMyEcZHPpLUqpkWLCc9kQKoOXWFEt/sk2zuN+tBfNiJIN/9IvewPsyoV
         3X62BDgxSCl38d0TQiwVJS4G94XiCap5aybGUm18DIGDcMcZ+GAHwxTiica/BzyRRmr0
         XoZfX56mG9FWvpuirzJIoiYV6MXsrf7JwAYP3V/Ef8jKhi+y0WvUy7WslTilSoE8c1nZ
         DkyeLPbkH2Sb0OqdsgMdlBb6HlQHdfQkrXznvHf3B9YEAgYcbBzN1jRlB2l79OKUvOM9
         9alw==
X-Gm-Message-State: ABy/qLZEhkuwTOTm7jXbhAvYcpY+pdTsp7+/EGPxmvzKJjqSmWjp2me2
	HIKpFuSnn1MbqD3KwQ0DRogy+PVFN9WcBXfdJyLnGobovxqEYuB/nzzzlRibRCuyUTAzxG59xfj
	fuI0jtJkDN3zJIBAQ
X-Received: by 2002:a05:6870:440b:b0:19f:9353:d9b0 with SMTP id u11-20020a056870440b00b0019f9353d9b0mr13312430oah.24.1689020258019;
        Mon, 10 Jul 2023 13:17:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG/yzsbrle2mK4hDSP+ymIcBBFgugjNQj9A986L5d0AncrnW2gjIY3q9PjS07ExUBl/iRYYsw==
X-Received: by 2002:a05:6870:440b:b0:19f:9353:d9b0 with SMTP id u11-20020a056870440b00b0019f9353d9b0mr13312403oah.24.1689020257748;
        Mon, 10 Jul 2023 13:17:37 -0700 (PDT)
Received: from halaney-x13s.attlocal.net ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id j12-20020a81920c000000b0056d2a19ad91sm155097ywg.103.2023.07.10.13.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:17:37 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/3] net: stmmac: dwmac-qcom-ethqos: Use dev_err_probe()
Date: Mon, 10 Jul 2023 15:06:38 -0500
Message-ID: <20230710201636.200412-3-ahalaney@redhat.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Using dev_err_probe() logs to devices_deferred which is helpful
when debugging.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

Changes since v1:
    * Collect tags (Andrew Lunn)

 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index ebafdadb28d5..1e103fd356b7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -710,8 +710,8 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 
 	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat)) {
-		dev_err(dev, "dt configuration failed\n");
-		return PTR_ERR(plat_dat);
+		return dev_err_probe(dev, PTR_ERR(plat_dat),
+				     "dt configuration failed\n");
 	}
 
 	plat_dat->clks_config = ethqos_clks_config;
-- 
2.41.0


