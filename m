Return-Path: <netdev+bounces-24955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E487724D9
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 15:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6479F28131F
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D27101FA;
	Mon,  7 Aug 2023 13:02:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B656101F9
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:02:06 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D979D10FD
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 06:02:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe2fb9b4d7so37805295e9.1
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 06:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691413323; x=1692018123;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FpyfDN0eJfDxw+M0r25gq3OoqMM9xi4hx56P+54Pp9g=;
        b=tqzDXiI8OZMqGeDi30tZrTrIMm4sAr8CR7r3GNw8azJFWYk4fdljWuFyz4nHdG1pJZ
         MNoSQAINoB5jmCrh1QmJA2pjNV0vRoX2qXYp4LBBUxbBryTN2nQyHmu0ZYQDBY99oBec
         +YqoTrNG5Bk3/RGlqQAi/wyNVeD6kDKw7W6OiZqSCMQSRm/KWDzHDtTcxkKojxAtjqpk
         lQDUb/iXmx9tLWeIb6ybWXBBIoY0TJv8tQ9zX2LeQcfSypLYaYk0nDXBn2kET2BrIgao
         QA6c7e9eaS1WUis6pnjcHfVId1H4JoKEgO1rvr2MCaSFtdUL3ot7CX80EUnRcTOuEV5b
         /9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691413323; x=1692018123;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpyfDN0eJfDxw+M0r25gq3OoqMM9xi4hx56P+54Pp9g=;
        b=KufqsjXlNEgmO2Mf3tbQERIVylGP95QEC2kjNggRehyfolNZcMwaTjzy1+1ZsRmGvJ
         LTuWa05sHimLkWxiCyvTR0EGtGnHXcCMBJqf0ciPjDg3dhiJhF6rVBuWjHWd1ZKFeqn4
         jxB9jdPAojh8lyUzcR4yf2VTb1+M4QACIY+ubrx90tXDWM0Avgj9Q/aZ4oTEI9wt8XRe
         kPsofLuAdsaJ2EAuFKDcxMlICNZruD7wZ5rcW10qHvcghQiKSQ1O8FJ9btWkbpzlR7J+
         QbO7HtychjUbBkCBbQZ8/3GVs1AwluPh5SyBm5GShyrWNbpCzrqe0py6+BP0Z2+Qcu6S
         kr3w==
X-Gm-Message-State: AOJu0YxfkXlmUWO071Jpk+SICNbjYaomQyPLn8E6clV3Mhadnu0Mp/IY
	ZZGbSu34sD+E7OA317bfiz1NWQ==
X-Google-Smtp-Source: AGHT+IE9xxt35dprXlSxGKthWWSScFtz1rP1Vo++Uz8EQ9YlkYF9+Z7IRPzk0CsRud7BA6OTyf4zCA==
X-Received: by 2002:a05:6000:1203:b0:317:759a:8ca8 with SMTP id e3-20020a056000120300b00317759a8ca8mr5018336wrx.67.1691413321798;
        Mon, 07 Aug 2023 06:02:01 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d4d42000000b00317ca89f6c5sm10423456wru.107.2023.08.07.06.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:02:01 -0700 (PDT)
Date: Mon, 7 Aug 2023 16:01:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net: bcmasp: Prevent array undereflow in
 bcmasp_netfilt_get_init()
Message-ID: <b3b47b25-01fc-4d9f-a6c3-e037ad4d71d7@moroto.mountain>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The "loc" value comes from the user and it can be negative leading to an
an array underflow when we check "priv->net_filters[loc].claimed".  Fix
this by changing the type to u32.

Fixes: c5d511c49587 ("net: bcmasp: Add support for wake on net filters")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Recent code.  Only needed on net-next.

 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 2 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index eb35ced1c8ba..d63d321f3e7b 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -640,7 +640,7 @@ bool bcmasp_netfilt_check_dup(struct bcmasp_intf *intf,
  * If no more open filters return NULL
  */
 struct bcmasp_net_filter *bcmasp_netfilt_get_init(struct bcmasp_intf *intf,
-						  int loc, bool wake_filter,
+						  u32 loc, bool wake_filter,
 						  bool init)
 {
 	struct bcmasp_net_filter *nfilter = NULL;
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.h b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
index 6bfcaa7f95a8..5b512f7f5e94 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.h
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
@@ -566,7 +566,7 @@ void bcmasp_disable_all_filters(struct bcmasp_intf *intf);
 void bcmasp_core_clock_set_intf(struct bcmasp_intf *intf, bool en);
 
 struct bcmasp_net_filter *bcmasp_netfilt_get_init(struct bcmasp_intf *intf,
-						  int loc, bool wake_filter,
+						  u32 loc, bool wake_filter,
 						  bool init);
 
 bool bcmasp_netfilt_check_dup(struct bcmasp_intf *intf,
-- 
2.39.2


