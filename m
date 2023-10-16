Return-Path: <netdev+bounces-41482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50EA7CB1C5
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E121281608
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69975328B5;
	Mon, 16 Oct 2023 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="vLFcLjHc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8123C31A7F
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:02:34 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE465AC
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:02:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ca6809fb8aso7695415ad.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697479352; x=1698084152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bik4q+MfE+nk50MPRNV7NlE+KzbPNONGHdwFTXm8Bf0=;
        b=vLFcLjHcSxaUBeoAKHQ4VfPerMzXKif7I/RikKl3nnUGWDxqk8Vv9rMH2g0VzA8KeA
         hwL3s8eoSZ1WnX5UFkBNt346b8n53uvQOQ/2hOZVQyfnZma/Tze/uJpy3WBzf/Xr//5r
         96TGuJK44GuZsaWtYYzTWpct/ELBXY7vlDnf1CYTKgTldJRkEmg11Rr9rZtsGvW0phBe
         iAsB1DjHOnYgm5rxEdpHY/tbeOV4gd4j+uh2x2bZUGGyDErjER9mrhLcd1yLUX4LFdI+
         +eklIqGwJ13HtKgvP5WGELhXz8DSl14N9bVrJ2IV3shT2z2Z4iBKs/bqteFH6xlTtaqu
         Oj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697479352; x=1698084152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bik4q+MfE+nk50MPRNV7NlE+KzbPNONGHdwFTXm8Bf0=;
        b=odrW6gZYD09a2M6yewd3sUjAaUarGYckp3ORe5GGSkbrbcMS1adyXTpsm/ylZOA8Rp
         t0EfK99l37fm4IaA2eRcf59/O/+IuBN3zPDx6qhJT8cIl0xVqFs1q5nTj7nsgEZeODIW
         HQSoZP7GEVFnEUS1CJL0cZ1SNvcnqaM8ZA6TlGEc9EvMx3FBmk5Zl1zzOPpqpZD9vlAN
         LUXt1hoJIVgXl09JF2cn+eP+LYM50DKXyER/arN9dGC2mTZerVY1X0lzEvTFtGQinfbv
         jziuSNIKQIJne/cAiLHGIht/2mZB7ZMoLUBLMJjmUhbDznLe9gfoHgHfOmM6CAd1l+zK
         liPw==
X-Gm-Message-State: AOJu0Yw+p0cYHtavRV9xVrX6n8L+PB9AB0tDdo417jvs5H5c+rEKcutE
	5cZIZ8dCGd+/CgkUD/28jSEThSFqLKLuNS2+B3RaUA==
X-Google-Smtp-Source: AGHT+IHBijnoDC2WTaqDgi7ShjVw0fCKStBmPaXmnZD0OLzggd6MAkJq72iMWfHWLt/rlxP/Zit9TQ==
X-Received: by 2002:a17:902:ec83:b0:1c7:23c9:a7e1 with SMTP id x3-20020a170902ec8300b001c723c9a7e1mr16588plg.26.1697479351959;
        Mon, 16 Oct 2023 11:02:31 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:5164:e0d2:c794:5982])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902eb0600b001c9d011581dsm8732548plb.164.2023.10.16.11.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:02:31 -0700 (PDT)
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
Subject: [PATCH net-next] selftests: tc-testing: add dummy and veth to minimum config
Date: Mon, 16 Oct 2023 15:02:22 -0300
Message-Id: <20231016180222.3065160-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
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

Dummy and VETH are heavily used by tdc. Make sure CI builds using
tc-testing/config pick them up.

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/config | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
index 5aa8705751f0..cf3ff04dfcb2 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -1,3 +1,10 @@
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
-- 
2.39.2


