Return-Path: <netdev+bounces-36309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FECF7AEE4F
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 16:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 821CCB2095C
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 14:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1BD2AB24;
	Tue, 26 Sep 2023 14:04:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE310125BA
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 14:04:49 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAEBEB
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 07:04:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-404314388ceso95221275e9.2
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 07:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695737087; x=1696341887; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uczmpeiKwXB8axUDwYOEbCY8/ztReOFNjQ1oGbsb9Io=;
        b=CAXusjLdWzcnYCoDlcwZdd1uhgXMosQIhM6x1y8F5sepBIQ7klaORJNNw48zlio9Ej
         ar6s3bZ6ziqZ1513kD9h1Tn1Zr/ocz9/GraKNBlPFn+mjXUsS845g4Ts7EX9cDjHlwuj
         D/nId7LS+eHoCePbXrl1lI315yq45YKhZW+NN3gS0ssaybtfKDg5jHx8K2l0gKNnFimq
         Wm8TxkbHYAGY8LmVs/KvfC4NrzlLBaaJId28y69v3T4LYhBJWPDvz5tuw3g9BhxbCp1I
         SfkLbG+QGQqPjYzUHROsyC1ZVVNhmWkDceGPHPEPYFDG1AH/yjby/fhfoKMTbVT9hkg9
         WJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695737087; x=1696341887;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uczmpeiKwXB8axUDwYOEbCY8/ztReOFNjQ1oGbsb9Io=;
        b=B873/IwDiAKIak+y3AxLIsjIRsxlKsYMQvldVMHxbOkXu0PxVjqoAS9lTEb4A4cNXt
         fefP7xLTqd/i/lb1DYwley1NXsA55JvfcnmGnVC21hSPdtflpfq4/bi277EQKqwbdRxq
         UVcyHWo4ypj0YrRdPkw/QidMoiLkE1XoSMnbgWUf1Kdo+NjniVFgwBlhcynmWDmUKAzn
         usbtB33TN1+9icYm/gNMXUDbukD9JazzCNp7CPDdS/eLyDX6FEba84uogU1Oa2tvkeTB
         1VdYvPjVqW/n8y18hZVm7cf0R4702uob5E/9Vc0RQtNlEiF4ryt2muWQWwoegxkI0Hi8
         cwdQ==
X-Gm-Message-State: AOJu0YxBmAZ0XOCf5lssOW9JBXxqrgAY31gHLmhsGe2TrGOT5osAZINs
	CJslMhdwaOo0AmVeo5kZheUuHg==
X-Google-Smtp-Source: AGHT+IEDz/ZpXWz+o29U1CgHU4VdFdAdoSMqj7ISGG528MHjGDWQoubPXna40xSUkw1fnIeUkF5Zkw==
X-Received: by 2002:a05:600c:220f:b0:405:3466:6b8 with SMTP id z15-20020a05600c220f00b00405346606b8mr8787593wml.12.1695737086989;
        Tue, 26 Sep 2023 07:04:46 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i19-20020a05600c2d9300b004054dcbf92asm10363169wmg.20.2023.09.26.07.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 07:04:46 -0700 (PDT)
Date: Tue, 26 Sep 2023 17:04:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roger Quadros <rogerq@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 1/3 net] net: ethernet: ti: am65-cpsw: Fix error code in
 am65_cpsw_nuss_init_tx_chns()
Message-ID: <4c2073cc-e7ef-4f16-9655-1a46cfed9fe9@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This accidentally returns success, but it should return a negative error
code.

Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Sorry for the delay on this.  I wrote this before traveling and meant
to send it earlier but forgot.

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index bea6fc0f324c..31e84c503e22 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1750,6 +1750,7 @@ static int am65_cpsw_nuss_init_tx_chns(struct am65_cpsw_common *common)
 		if (tx_chn->irq <= 0) {
 			dev_err(dev, "Failed to get tx dma irq %d\n",
 				tx_chn->irq);
+			ret = tx_chn->irq ?: -ENXIO;
 			goto err;
 		}
 
-- 
2.39.2


