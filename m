Return-Path: <netdev+bounces-38016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D617B860F
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 19:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id CBC491F22B63
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 17:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EC01C6A0;
	Wed,  4 Oct 2023 17:03:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7E1C68D
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 17:03:11 +0000 (UTC)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA69895
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 10:03:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-27777174297so1638938a91.3
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 10:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1696438989; x=1697043789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XjKe52uxoEWYByCO7w/+hku1MO8es+pHrQpVHj97Wg0=;
        b=btDwhkfwARzaBkTua/K4I23EE6fbIMxSg9BeXXiMYrJe9kmHdB/b0fzt+3kH7dqVZm
         YaC82mr/gQJ7PsDOm50abbA+rRsA+5njkQO7iMSxAQqZ58XBKgHeaT1SJ8JdxxbO4FUo
         SW/LJMCSViFeOzMBJfwJJEV9xoIgX3MEV4cm/IdLr2Q6rXmjod7n+mCHbKp6vRg/Lij3
         xrN8XTmrcn9Vf6PU9dy4VMUEYLoS9gQXNrqBU8wEX5JXq3rtwJzbK74fjKDCwCT3uVz7
         48M0UICCHf9OIT+1KhIu6SvFu9Vvombqc1K4GnduPF0Vx2yEMHLqXxwPBmwSLL0ju0qH
         Ai4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696438989; x=1697043789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XjKe52uxoEWYByCO7w/+hku1MO8es+pHrQpVHj97Wg0=;
        b=wl9GMgsccvhmX7qwC9X8ibvFBS3MYcXbdfPwVr2jbjQNFSFgC8dhfb06GMFVyI5jcX
         KHmPuzXtP5gwMxkkCuslRHYOfxWFsfQd442o0vzTuFEpGUpUv+g2tFfjhuP6uqR8aDL+
         yCiLAdTtPV8XOit2Sfl04FZnQ+uU5tmQD5kfu0YRN3w/SM4+Y4GCVv15JYz1B/vepfLV
         dXjO4SLAd6BjbJ7aKIEdH1ajoQGPaoO1kBjKsVE1w05DZuEPvQg1vDZbH2ntWZ/nx8fX
         KkVprx/B+vEO4CprTL60cNpwfz3x2GcedX2r8j+zHdmMMqeOAl/q16uhEfAtCWyNgptt
         JOBQ==
X-Gm-Message-State: AOJu0YyHbo/N/0cM/OrtGuGKtKYM7EhZyfJZx9KgxBZxdS1Xze21fji+
	SsMv9I//o4IaxVvFQ9qkDxVnOxCPOEEzAjg3Bpc=
X-Google-Smtp-Source: AGHT+IF/yVO1B4A7pVumqaFuqeUirFvCAN2K3INB753u764HBXMclVpD5qSScXvEw8xQujxzu1buZA==
X-Received: by 2002:a17:90b:1a8c:b0:274:bf7a:60ed with SMTP id ng12-20020a17090b1a8c00b00274bf7a60edmr2833596pjb.12.1696438988696;
        Wed, 04 Oct 2023 10:03:08 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902778c00b001bdc8a5e96csm3965382pll.169.2023.10.04.10.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 10:03:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] ila: fix array overflow warning
Date: Wed,  4 Oct 2023 10:02:58 -0700
Message-Id: <20231004170258.25575-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Aliasing a 64 bit value seems to confuse Gcc 12.2.
ipila.c:57:32: warning: ‘addr’ may be used uninitialized [-Wmaybe-uninitialized]

Use a union instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/ipila.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/ip/ipila.c b/ip/ipila.c
index 23b19a108862..f4387e039f97 100644
--- a/ip/ipila.c
+++ b/ip/ipila.c
@@ -47,14 +47,17 @@ static int genl_family = -1;
 
 static void print_addr64(__u64 addr, char *buff, size_t len)
 {
-	__u16 *words = (__u16 *)&addr;
+	union {
+		__u64 id64;
+		__u16 words[4];
+	} id = { .id64 = addr };
 	__u16 v;
 	int i, ret;
 	size_t written = 0;
 	char *sep = ":";
 
 	for (i = 0; i < 4; i++) {
-		v = ntohs(words[i]);
+		v = ntohs(id.words[i]);
 
 		if (i == 3)
 			sep = "";
-- 
2.39.2


