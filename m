Return-Path: <netdev+bounces-16149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BAE74B954
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 00:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445881C210D4
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 22:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4854717AC8;
	Fri,  7 Jul 2023 22:01:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE5E10977
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 22:01:22 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D9AB7
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 15:01:20 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b708b97418so2226063a34.3
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 15:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688767280; x=1691359280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SCmKdcZCL6Q4vlfG0tET4T7Ol3E6f+P/LYs+zuO1hLY=;
        b=paz9m6WEfu8n5iMwc3LFfQ48lAsmmOAFJ6Y935daIW8xyEMfKajTgW3WASpB+uqUl4
         zPJuFiP4pgNSUvPEURPySpPg65PXI91AePGsvzhrAXCroiE1/+XFVO99pq7bdiLtek+2
         iWZ3psS5SYIL0AL4mHIBcgUPhHguuJ2aQFavsnOEn3cE91VE31GXV0TJLdHARk+ZaqPz
         tlR4ujdr7mipkwLpldACPm/tUi+leKPj4qdkfg6Y5QHcop0gIERSo3kedTl/kbtZoiuf
         cxwgGNgHenFJlSXrFYplZABaNG0vQN9l9X+kndVD2hS3rOaYFH1awg+2LDCXcd4RQqOD
         4n4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688767280; x=1691359280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCmKdcZCL6Q4vlfG0tET4T7Ol3E6f+P/LYs+zuO1hLY=;
        b=Uu7uaxgcrTnFnQTVYS9tn79i7QBzhr87hiwurr4qV5lvUTJf+fVLL7EVeaPzBqct0e
         2a7KKD72iOFCqlAscg4xATPrEfpz0RCvSxD0tZ+i02WkAySKnUdKVgmYs8jfVKUvj7qO
         LYjAZBwVasIsCdkHZkNHLPNC5Fahjz3V66sK2ZN8RuMTWn1Od9sjDwIk1iD1eSpFp2V5
         1WeGJRmoYNGLfcPgu5QN8n60P7VJWrW3M26iEbHyGrkT86pZoBqQqYYCUXyu/WrndEOW
         GgLIqsDJlPTZsDZihpnrbMlfj+BH/Tfm79Im9TZ+54goe0LVkBHCLVBBzkcN3Sct193Y
         O0Pw==
X-Gm-Message-State: ABy/qLaNgxZ+bXLHVPkdWaja36chBNbiDGGeCoPmRbBAzGfgr+GwbGQj
	PPlTtXsY5IPvl6c+VQHiZH1AnIDrWdfTmYg4Dsg=
X-Google-Smtp-Source: APBJJlHPCtYkMlkkVUb1bAZLSil0Bu7Zq1JoYOvlm6NBRhT7jDAODD9FY8/wAX+r8a8u/jd5525aug==
X-Received: by 2002:a05:6830:3b04:b0:6b5:6b95:5876 with SMTP id dk4-20020a0568303b0400b006b56b955876mr7221005otb.25.1688767280018;
        Fri, 07 Jul 2023 15:01:20 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:9dd1:feea:c9a4:7223])
        by smtp.gmail.com with ESMTPSA id p9-20020a9d76c9000000b006b45be2fdc2sm2055533otl.65.2023.07.07.15.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 15:01:19 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	shaozhengchao@huawei.com,
	victor@mojatatu.com,
	simon.horman@corigine.com,
	paolo.valente@unimore.it,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net v2 0/4] net/sched: fixes for sch_qfq
Date: Fri,  7 Jul 2023 18:59:56 -0300
Message-Id: <20230707220000.461410-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patch 1 fixes a regression introduced in 6.4 where the MTU size could be
bigger than 'lmax'.

Patch 3 fixes an issue where the code doesn't account for qdisc_pkt_len()
returning a size bigger then 'lmax'.

Patches 2 and 4 are selftests for the issues above.

v1 -> v2:
 - Added another fix and selftest for sch_qfq
 - Addressed comment by Simon
 - Added Jamal acks and Shaozheng tested by

Pedro Tammela (4):
  net/sched: sch_qfq: reintroduce lmax bound check for MTU
  selftests: tc-testing: add tests for qfq mtu sanity check
  net/sched: sch_qfq: account for stab overhead in qfq_enqueue
  selftests: tc-testing: add test for qfq with stab overhead

 net/sched/sch_qfq.c                           | 18 +++-
 .../tc-testing/tc-tests/qdiscs/qfq.json       | 86 +++++++++++++++++++
 2 files changed, 101 insertions(+), 3 deletions(-)

-- 
2.39.2


