Return-Path: <netdev+bounces-31147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E81778BE0B
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 07:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC221C209AE
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 05:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B68463A8;
	Tue, 29 Aug 2023 05:50:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3033E63A3
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 05:50:34 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B283EA
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 22:50:33 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68a3cae6d94so3455772b3a.0
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 22:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693288232; x=1693893032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1kxOCdc0HbVJEqHyG1ggPhHWqDTmAa5xPlzueX/94I=;
        b=TwaiP7UX4N7wiRKVaABOFirOF5MfR/K/JrGrg1XOvEh/ji750MxYfOrbLT3+H2/x9d
         iU7oXAQSqe+sGYs5NKzWT+2ujVZzu6Lc+IBk9dAeN1xJFImzniEwfA/SR3ZCy4qqDnK8
         1XRJzRkC647teUfoF3V7qXQvXPgYxhjVopsBKQaAramyYRbJWMXcbxguvx+dIGfg7aCu
         wQyDRbozEDsLi+yHpP86S+FctCox5RvfPR/Y3UCJkR+5bQjx7+kyVMFhI4JD7Wh7UG0m
         8QJkquvkPPGODuOwE39IagzaVuf2R/k8kCBndsAkxuDORPUv8BLXikVmJuD2qMafzq+S
         Huow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693288232; x=1693893032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1kxOCdc0HbVJEqHyG1ggPhHWqDTmAa5xPlzueX/94I=;
        b=mD3nWo4J7i68xPyItWtaifnIBY+Ys8QAxTrhBTXyBuQHJPEb4rh4fV7Y5GJCSK/6kO
         S3XvSLlFPG4H6NA728Jeq/7UqSctwsS5il39OZpXslI2Ko6jfmb3ATn6n1RmmLe9eDBs
         da1z3blpo7E0hp90goHPCVBuM/7pZLshr4StdldZH4qJkkfimzaE+1zbiKIsFn0TCDct
         WVi0zmPUOBhO2joP0H9KOoZDiZkPLbKyg435YF8gaIMMg48VMms5rlCA5rtsrLFQ/twE
         ymGYSLHbNh5dlAjC9DOQP+4PUdzvWs7bGMAH9R9XNB5H/1xFs5ODeSJZzo3puLG0Yiyh
         uJaQ==
X-Gm-Message-State: AOJu0YwFsXn1KVGMgjDwYst5Itl7c1Uq52h+8wF/ZJKYGj7QgHIMGNou
	rvIHw3L8JXKSpRVmeAvEDpBM+jw5ZgrL40no
X-Google-Smtp-Source: AGHT+IGhzcGKOUIDUA6DgrK+a+DWAXS5rl1Jut/9SEItJ6K8+ttdBIXunwFzMwYS1ubGr9okWRFFsA==
X-Received: by 2002:a05:6a20:914b:b0:13a:43e8:3fb5 with SMTP id x11-20020a056a20914b00b0013a43e83fb5mr34361292pzc.51.1693288232481;
        Mon, 28 Aug 2023 22:50:32 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id b25-20020aa78719000000b00687087d8bc3sm7897713pfo.141.2023.08.28.22.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 22:50:32 -0700 (PDT)
From: Alex Henrie <alexhenrie24@gmail.com>
To: netdev@vger.kernel.org,
	jbohac@suse.cz,
	benoit.boissinot@ens-lyon.org,
	davem@davemloft.net,
	hideaki.yoshifuji@miraclelinux.com,
	dsahern@kernel.org,
	pabeni@redhat.com
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 4/5] Documentation: networking: explain what happens if temp_valid_lft is too small
Date: Mon, 28 Aug 2023 23:44:46 -0600
Message-ID: <20230829054623.104293-5-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829054623.104293-1-alexhenrie24@gmail.com>
References: <20230821011116.21931-1-alexhenrie24@gmail.com>
 <20230829054623.104293-1-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 4a010a7cde7f..ae196e78df88 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2462,7 +2462,9 @@ use_tempaddr - INTEGER
 		* -1 (for point-to-point devices and loopback devices)
 
 temp_valid_lft - INTEGER
-	valid lifetime (in seconds) for temporary addresses.
+	valid lifetime (in seconds) for temporary addresses. If less than the
+	minimum required lifetime (typically 5 seconds), temporary addresses
+	will not be created.
 
 	Default: 172800 (2 days)
 
-- 
2.42.0


