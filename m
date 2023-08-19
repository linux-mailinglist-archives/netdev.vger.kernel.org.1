Return-Path: <netdev+bounces-29147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1819781B73
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 02:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21331C20911
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 00:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01CA7E6;
	Sun, 20 Aug 2023 00:11:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03C9371
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 00:11:07 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4801BC9D1
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 13:55:07 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1c4c6717e61so1470093fac.1
        for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 13:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692478506; x=1693083306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wn4k9ftTfDw2DfyUTvoDeRp5Qh7WVV0UM8HnbbORwHU=;
        b=AcEtTXq21er7mj7URxf5jaF0zZMoKgQuf9/S7SLLk7+fvx43/eulc7cj99ev4NK+19
         Ji3ORE1fhycJPja1zzpDDnts9rAXolx7opRo0mJMrvyXUy2+EUWGB/rVNNxEYzBqx8R8
         lipv+DELIdQ+G7tl5zMCPiPkNl2Hft5R8dlaZJrEK6QU9fSNUNYn7Dh4vUmYzi/MGrsO
         D1QeQE6a5yFfibrN9nBg1qUEOTcfE7yFVvdtT8S19eAN8rgypgnOUkQXSeo+ntnmC8h9
         9SgGS2p3Zsa1GqahdGgffa6bCHclyBj8m4neBNA7EeRWKoHGpU9z8nAFtO7DmNiLePwF
         lS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692478506; x=1693083306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wn4k9ftTfDw2DfyUTvoDeRp5Qh7WVV0UM8HnbbORwHU=;
        b=aFseioDwKCUC1zI2tDB+1jHNM9Yh0QUAOgNuoq22cvbN8dHuC+NSvjhTN0uGZEyHBw
         4JdUz64lM4HSGXpPibSNhcDLfGBpPfUxTTKO18d23KxvQxRH48TSCvSBSP65ei5xGn1R
         YmsxyExrylbMq/A67Lb/YfTJKiK+i4tunJ90hfDz3NI1/lpmmnnkC9Y9HcenGpMhaEGE
         zxt1O2ekIUkrb+NU8a3AGq1Nd7oO8TEDWR4kSf8I12LeQMg1G8lpUzBoC75JZtqNPvo8
         giIyaGxWB0fwJ5iUqJRhYfwTU8R7BmqA7LE0I5ZkV0DJWi4frjdtN5NlKq8EIyjojZ6r
         H1jw==
X-Gm-Message-State: AOJu0YwqGDYAlZR/7JOq81acacTvTI2gPVm92tB87urPUa2xh9I1YUn4
	WHc85vO1kfikRbQMmF47EoSrDGc7nLkbf9HG9qk=
X-Google-Smtp-Source: AGHT+IH89b4e5N2k/nqKzpph5CVoDDjQ5XrP6JZGEsCF681dA74jG76in3XBUrWTx5PP4V+K71Rn8A==
X-Received: by 2002:a05:6870:4692:b0:1bb:933b:e6da with SMTP id a18-20020a056870469200b001bb933be6damr4492484oap.27.1692478506220;
        Sat, 19 Aug 2023 13:55:06 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:675b:d4b6:8d9b:4260])
        by smtp.gmail.com with ESMTPSA id v19-20020a4a9753000000b005660ff9e037sm2193958ooi.25.2023.08.19.13.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 13:55:05 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH iproute2-next] utils: fix get_integer() logic
Date: Sat, 19 Aug 2023 17:54:48 -0300
Message-Id: <20230819205448.428253-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After 3a463c15, get_integer() doesn't return the converted value and
always writes 0 in 'val' in case of success.
Fix the logic so it writes the converted value in 'val'.

Fixes: 3a463c15 ("Add get_long utility and adapt get_integer accordingly"
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 lib/utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/utils.c b/lib/utils.c
index efa01668..99ba7a23 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -142,7 +142,8 @@ int get_integer(int *val, const char *arg, int base)
 {
 	long res;
 
-	res = get_long(NULL, arg, base);
+	if (get_long(&res, arg, base) < 0)
+		return -1;
 
 	/* Outside range of int */
 	if (res < INT_MIN || res > INT_MAX)
-- 
2.39.2


