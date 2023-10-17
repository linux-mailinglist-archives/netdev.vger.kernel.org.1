Return-Path: <netdev+bounces-41966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159B37CC75C
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 17:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A67DEB211BC
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0338E450C0;
	Tue, 17 Oct 2023 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="DF1yaUBp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4836242BEB
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 15:23:26 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C6FE8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:23:24 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so4302320b3a.2
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697556204; x=1698161004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1Swj/1+T14fjTbb9ZYweX4Q0wLqf3lf1b+yCUCiWw0=;
        b=DF1yaUBpd/3HGv96ZniqKqLNt8F4T2wodqhF2jbc26GNDdlULCI+yFhsXYLFZAfdPl
         Y7B2KzIncFQThFi7wJ3PEPUrHp/xCgyng8AbrzGVmgaGCXBAXAaF7zj/i3qlaZRClncE
         SJ5rXMlAleU4bI87UakqJKvdCindSMMuY5O/czQQpPmsATXqQkh0xi3A/AuRMIh73R2O
         J3zvgj1MpM2wB3uf3+OSB8xUsG1lpVypb5r32499A7tmctD9OJIrKcVYRkVeO/zdlwYW
         qFPEQ5ciLqLngF1SluQvif+rBZg5g3pvgLiN1cXQ4BN8lKYXKHbEAopVymyv68EaAxWY
         cWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556204; x=1698161004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1Swj/1+T14fjTbb9ZYweX4Q0wLqf3lf1b+yCUCiWw0=;
        b=CuLLKmwFmyHKZv++8KOBWKhIRUf4z58qFz+UlaXyEFPyaaEvwBqC395idX5HK0bJz7
         85HOdOIS7/wXYVnOjIjY/zpS3oR6ncDUxqPoOyqmBADKkF3bl8Zo+c6CEYfM8zcpLCFB
         aJ5NnF2dTCOcmQ7tclJmZo22/xcTWbemxrb1Ig4DauS1T/e34qMwOZi2ZKSwHPjncsjj
         jkrs7pSPxjDlTOI+8slo4eXU4/tiap5r9D4s+b8UvoybDu04AKN7GMbfnf+o8MPJqCFe
         xkIDijR9wRDgPeOj7nL/DMmow2ohfD2Ons0Ua4c+Fw/ppoV+ISU8H+RTs74Ab/lEm9G1
         4Epw==
X-Gm-Message-State: AOJu0YwFLJf44P6+cA+DyFIgWuMDzHKv+W5ZRe5eDBirOI6gFHOtTTEX
	J6LC6uSWlmhF8UE2T/RJaSiIElpxfIn2/yDkuYG4kg==
X-Google-Smtp-Source: AGHT+IGRAz9gJMPJJv4zPxmOJ95VPa/NC4354V4OIwgITDxeGEHHLrYC+3s5JUjg/FX/aEY4/a+vtw==
X-Received: by 2002:a05:6a00:234b:b0:6be:2803:9c92 with SMTP id j11-20020a056a00234b00b006be28039c92mr2808045pfj.32.1697556204022;
        Tue, 17 Oct 2023 08:23:24 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:8ef5:7647:6178:de4e])
        by smtp.gmail.com with ESMTPSA id u191-20020a6385c8000000b005b6f075da0dsm8749pgd.25.2023.10.17.08.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 08:23:23 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 1/2] selftests: tc-testing: add missing Kconfig options to 'config'
Date: Tue, 17 Oct 2023 12:23:08 -0300
Message-Id: <20231017152309.3196320-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017152309.3196320-1-pctammela@mojatatu.com>
References: <20231017152309.3196320-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make sure CI builds using just tc-testing/config can run all tdc tests.
Some tests were broken because of missing knobs.

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/config | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
index 5aa8705751f0..012aa33b341b 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -1,12 +1,21 @@
+#
+# Network
+#
+
+CONFIG_DUMMY=y
+CONFIG_VETH=y
+
 #
 # Core Netfilter Configuration
 #
+CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_MARK=y
 CONFIG_NF_CONNTRACK_ZONES=y
 CONFIG_NF_CONNTRACK_LABELS=y
 CONFIG_NF_CONNTRACK_PROCFS=y
 CONFIG_NF_FLOW_TABLE=m
+CONFIG_NF_TABLES=m
 CONFIG_NF_NAT=m
 CONFIG_NETFILTER_XT_TARGET_LOG=m
 
-- 
2.39.2


