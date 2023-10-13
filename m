Return-Path: <netdev+bounces-40843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D132B7C8D3B
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 20:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D71282E79
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 18:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779591BDE7;
	Fri, 13 Oct 2023 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z75SW8rJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F2A134CD
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 18:42:07 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8CD83
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 11:42:05 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53e16f076b3so3885133a12.0
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 11:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697222524; x=1697827324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BlcetPZENt/KWUqTdKuElmZntlZWvFUuRk0MWi//bA8=;
        b=Z75SW8rJLM6vMUcAeZKpUczPTN/YEMJwR6PDl9Vd/m2Gnq/zhUFFKl5V6yoxPRYXWu
         c0Izk0LlqBNlz7n/SLietSdjUf9vWSTysf5bzKGhdbc67enRaeD+DHU8XzHDbBVod8gk
         p2Qp9JK0Q1bjcWRryaUTXeAvjyO6iip/lcUjv0XBsJMGiiaVPEcu1VxYfqQMR8unYKLX
         q7hHJnAVbYnqzu8SlAlqRnttKr/+msC+btuAcqKwV8VV4/Pu8qRL//UlmvGKPakIZFJj
         gRkJdgavPZJ0WqXcS8CGVe+02lAVjlWxfejwx7BdXB0X87HiLB71Xb4KDaHBwMv4HgB4
         S4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697222524; x=1697827324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlcetPZENt/KWUqTdKuElmZntlZWvFUuRk0MWi//bA8=;
        b=hjg30O+cUZ/ZK/yJl+rhhA+dKeY1SPGwOrJY6EdT/rI69cLsPYQeTTjhLR2ETchGDo
         HeDy9hYRitP1WcHaVin2k/ZcMCU+WQ904Bs1bRUgnJME2HenoAsvqJk5we9181ejazAd
         emI/PH3DO5Um1w+q45xyZ4KkQeO+DXo1nrt843J6weZ5A2CPxC1ECj1eRU31O6iR7fyA
         DkzoG8FDuzeXh0+Oslscq6VtoSRKUfscBGLZ615ZV/DhyENL4BbEsV/fBohP60ttaNm4
         BQ1xJZbjXeEQ59WmrEibq+LIxFpyadyN9/27P2ojaZbddYWP4P2OgeZdK6QK5FZAtJog
         AAnA==
X-Gm-Message-State: AOJu0Yy4djkAjnFs34bgwkwHRYhSr7zad3+o3EA05i/JcRTt2/R8Wwtx
	EHlepPJSA3dE2VqBH2RBW0bZqw==
X-Google-Smtp-Source: AGHT+IENdas/HNvJqTs1sK4tay28wAJbuqwId0DuBDkOut5TKAkUJeoLG3Vf6EFnfe2mQpBp5j/wbA==
X-Received: by 2002:a50:d658:0:b0:533:dcb1:5ab4 with SMTP id c24-20020a50d658000000b00533dcb15ab4mr821984edj.18.1697222523963;
        Fri, 13 Oct 2023 11:42:03 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id dm9-20020a05640222c900b0053db1ca293asm4173171edb.19.2023.10.13.11.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 11:42:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Frederic Danis <frederic.danis@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?=E9=BB=84=E6=80=9D=E8=81=AA?= <huangsicong@iie.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH net-next] nfc: nci: fix possible NULL pointer dereference in send_acknowledge()
Date: Fri, 13 Oct 2023 20:41:29 +0200
Message-Id: <20231013184129.18738-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Handle memory allocation failure from nci_skb_alloc() (calling
alloc_skb()) to avoid possible NULL pointer dereference.

Reported-by: 黄思聪 <huangsicong@iie.ac.cn>
Fixes: 391d8a2da787 ("NFC: Add NCI over SPI receive")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 net/nfc/nci/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/nfc/nci/spi.c b/net/nfc/nci/spi.c
index 0935527d1d12..b68150c971d0 100644
--- a/net/nfc/nci/spi.c
+++ b/net/nfc/nci/spi.c
@@ -151,6 +151,8 @@ static int send_acknowledge(struct nci_spi *nspi, u8 acknowledge)
 	int ret;
 
 	skb = nci_skb_alloc(nspi->ndev, 0, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
 
 	/* add the NCI SPI header to the start of the buffer */
 	hdr = skb_push(skb, NCI_SPI_HDR_LEN);
-- 
2.34.1


