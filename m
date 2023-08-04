Return-Path: <netdev+bounces-24587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE41770B19
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 23:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3821C21761
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 21:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF8921D2D;
	Fri,  4 Aug 2023 21:35:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17691ED5C
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 21:35:08 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A97C5
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:35:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d1ebc896bd7so2479890276.2
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 14:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691184906; x=1691789706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WambZPDGoqKCs5xLMf1qXXSOXzbwiYHANSsAy4QHxdA=;
        b=DvHIJmnUiqF79V6DniFzD0MICQkGDuTZsuk+skbMnLy6OBq7/KDzbOFhCUAbgUnxke
         3jVLW2FuOhQ2Vl2WaWl4Aphliqm6QxDn2LjjwFp7aOF8t70OWUf2TCbKtH2vx8BuddkD
         PFH2z0ZhovjYD4Wjle1W8Y/0n8vJRGtj0cz/AP9qxEonwyZxNfigYGvhs2Kzow1v2geT
         w++315olmFRd6PA9Td/GQoywLWTm0JOR47ce273Czjf3pF/32q+nBHSFZoNWt07qydMy
         LbJGa89h2+PMgXoHUPbUWbyy0CRqnFHIE2bYaZWKzLk4PwBUjzLeslIHgdUgNTvfPg4Y
         2c/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691184906; x=1691789706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WambZPDGoqKCs5xLMf1qXXSOXzbwiYHANSsAy4QHxdA=;
        b=a20JzMchuoUJ/RX1uhrkffo8JXbws5+vAgRbpKPQl8ry3+RXfry+1o9KFFh+g3FFea
         3nne6bOT/2NNMsSszV+IgkdlWKJuAFzYz90XEI7I6DyQUKMTEm6e+jDxpiBMJubYSGwq
         v5tBoijBVFBMuwIJrugnhlRn7qfoEthvNok0EB7N6vPzIw3aDf1GXJoAJflPBrVSGTIQ
         D+owGTbQis0EWi2vkcYG1LGFcEO4kEsuSeNd8iKNSt1Cn/SngsR/M9KnDDWf+R0DXWAK
         8yUwTCQOHx91Op5UUYE4EftTGG4MugpKifxK5SFfbw9mlECNbA8kBqGqhTXb3vq8o6XU
         2Q/w==
X-Gm-Message-State: AOJu0YxDcnx0bHtewvImUyM/HX1lLElItd564tgdLUq57eFDtJjVwbyo
	62KJYI9ugaIdfV8VtOMM3vMM6jdqV9m3tiqHdwXyjEj3ArY0QqXjymwmZY1RXJ6xnpP8vp4pWgm
	MvgMqjS9z0m/8O77+OOUmeUVDE3w8QvnAKgzGDvy7VD9OdwQ0adOMtFgtmS0UEVwu
X-Google-Smtp-Source: AGHT+IE9GEZ/kDl4o6dAZ6GZTAhd2RfYoOgyVSa+h9jWfzdH0aCzEBV0i9g2sroQxAv7lwf+sEKVjHXO/JhU
X-Received: from wrushilg.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2168])
 (user=rushilg job=sendgmr) by 2002:a05:6902:1614:b0:d0d:c74a:a6c0 with SMTP
 id bw20-20020a056902161400b00d0dc74aa6c0mr15123ybb.2.1691184906551; Fri, 04
 Aug 2023 14:35:06 -0700 (PDT)
Date: Fri,  4 Aug 2023 21:34:44 +0000
In-Reply-To: <20230804213444.2792473-1-rushilg@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230804213444.2792473-1-rushilg@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230804213444.2792473-5-rushilg@google.com>
Subject: [PATCH net-next v2 4/4] gve: update gve.rst
From: Rushil Gupta <rushilg@google.com>
To: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	willemb@google.com, edumazet@google.com, pabeni@redhat.com
Cc: Rushil Gupta <rushilg@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Bailey Forrest <bcf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a note about QPL and RDA mode

Signed-off-by: Rushil Gupta <rushilg@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Bailey Forrest <bcf@google.com>
---
No change in v2
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


