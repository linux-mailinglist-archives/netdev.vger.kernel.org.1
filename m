Return-Path: <netdev+bounces-23803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A498D76D9A6
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 23:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E94628105F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 21:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C709713AE8;
	Wed,  2 Aug 2023 21:34:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4AB17ABF
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 21:34:11 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645901BF6
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 14:34:06 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5734d919156so1819317b3.3
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 14:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691012045; x=1691616845;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iRCWRXQMgV7jsJjfRTyCoNuluAlCut1EIdUc/wCruy0=;
        b=117+2dCZcVv7ea0gIe5ZSAB3QriUReBRAkE3ZE9QwextSFdzfZzQV9SGpUqUHLAU2o
         LuGEJCg6ixtMgcPaiO6GjXQFE8MgUOdQ2f7iPNBCHmOiKQsQwd67h7xq4qmIml8vFvC8
         6DVSlINto5ABFz1AFfSHgbXZOnUso7v9pHbZMSUVC6b47LogA/UFHE742KJ4vf6r5tf1
         6MWJ1ClK7f6+y5DZt4njbU/0pyR2etvCQMchVMbCdOaFytiPovG88g6VejQlUyGFLxUS
         4gG9cy0meXUXT9mtEklLC8XmfqCz7lX/htKqbUs7IIJ6VuS46KJ+am8joTqSum7SaR2u
         VWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691012045; x=1691616845;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRCWRXQMgV7jsJjfRTyCoNuluAlCut1EIdUc/wCruy0=;
        b=gNhYyDntg25Ug2RK1cklKPWWAyz3kakWsp2LTBNsudG9EhVYMk7Liq+xnyvOeRSuFc
         RiRC392xVtmzyaiiXhzsvipeKHm2NvjiVzZhdr/MGju/r6TGdCiFRzYCDWyxAjmeVO2c
         ie/fYk7E+mIwUtGSvtVz8N4y1RKAy2scEg/B17a+IlHItpBSAExz+t3dMO0Ro00mfP2n
         QM5ppZ6qiMfcv/+M46GOWjQ6kYSMW9gQkUpifYo4YBZQ/Zr502Pbirvtb8D+cFuMcBHL
         3dbKEfvlCUkptitP8sDzV/R4z/zWeyFT4iyEoHnrb48ulj9GaVdIS7xRkjqtqsIm94r6
         3kUw==
X-Gm-Message-State: ABy/qLY5temUZrbRj7/1g6AvnPd6Kqelw8rC5wXS/CPsQPT7O4q6eBst
	3+0tKY5JH8XhD6FAsTSe0UPNgk9RgbyffrEyA+lgFjUrCPTpRuBjLLk+Ssr78LU2kzYZDrtfszL
	3tJJ7wG71E63DbonVBEdkGzRUwxY0lDq3NgcPxMGa9WJvJwEBT/SeNAKr646/+huc
X-Google-Smtp-Source: APBJJlFKz+RIpE3/psHj7wqGmsITUhtXQcWfoFNFnS9GZVwNvMrOifaHP3mOkQaLdl5UwI3lwiNZR1jhO9xC
X-Received: from wrushilg.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2168])
 (user=rushilg job=sendgmr) by 2002:a81:bd54:0:b0:570:7d9b:9b16 with SMTP id
 n20-20020a81bd54000000b005707d9b9b16mr150302ywk.2.1691012045103; Wed, 02 Aug
 2023 14:34:05 -0700 (PDT)
Date: Wed,  2 Aug 2023 21:33:38 +0000
In-Reply-To: <20230802213338.2391025-1-rushilg@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230802213338.2391025-1-rushilg@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230802213338.2391025-5-rushilg@google.com>
Subject: [PATCH net-next 4/4] gve: update gve.rst
From: Rushil Gupta <rushilg@google.com>
To: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	willemb@google.com, edumazet@google.com, pabeni@redhat.com
Cc: Rushil Gupta <rushilg@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Bailey Forrest <bcf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a note about QPL and RDA mode

Signed-off-by: Rushil Gupta <rushilg@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Bailey Forrest <bcf@google.com>
---
 .../networking/device_drivers/ethernet/google/gve.rst    | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/google/gve.rst b/Documentation/networking/device_drivers/ethernet/google/gve.rst
index 6d73ee78f3d7..31d621bca82e 100644
--- a/Documentation/networking/device_drivers/ethernet/google/gve.rst
+++ b/Documentation/networking/device_drivers/ethernet/google/gve.rst
@@ -52,6 +52,15 @@ Descriptor Formats
 GVE supports two descriptor formats: GQI and DQO. These two formats have
 entirely different descriptors, which will be described below.
 
+Addressing Mode
+------------------
+GVE supports two addressing modes: QPL and RDA.
+QPL ("queue-page-list") mode communicates data through a set of
+pre-registered pages.
+
+For RDA ("raw DMA addressing") mode, the set of pages is dynamic.
+Therefore, the packet buffers can be anywhere in guest memory.
+
 Registers
 ---------
 All registers are MMIO.
-- 
2.41.0.585.gd2178a4bd4-goog


