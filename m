Return-Path: <netdev+bounces-16963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDC674F984
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 23:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4686C2813EE
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 21:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBE81EA97;
	Tue, 11 Jul 2023 21:01:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAFA1E503
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 21:01:16 +0000 (UTC)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB4C10DD
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 14:01:15 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-563531a3ad2so3881220eaf.3
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 14:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689109274; x=1691701274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PWtgP0F96XopLJUgU33QB+JNpam+NY91Ci7wRgILuXw=;
        b=oiKNOuQPMCIf5QygVa3bYHLcO2dryBAjGdjbur2MTTHGTx/9miSKoXdskxOowm/UY7
         VTalneuFY3Bhc11O2eb8dcA2Ru1mBn/dvUFmxkyu6z14kVrlp0D13BsmY/9rK4d78ceQ
         mAhQEuAdLlg386vA+TZXbtJr1kZE3RbuM/C1IMIRVf7Q42Fnn5VyzooTh2ijGJYSL3/u
         mfLjM4d8fDWV0deM6K1odEMSy32Jfy+Vf17ehB5DXCcOK33r6PQR4b48n4BnC1XPyewG
         4R/M+F37sQTQslqxrrfE77uqebPvIYA6alMLSdAngOvYs9JCup1Ue2ta9/EtbpXW+g5m
         7flA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689109274; x=1691701274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWtgP0F96XopLJUgU33QB+JNpam+NY91Ci7wRgILuXw=;
        b=mEXUQT4adl5bQNdgy3LcalPyAG+QrXGA+8fGi008YpTXh8wn7vhuQY6DgnjkahMUmH
         sL+UxJB/a0h330JyMd9AhBsdAwW5phKLCoLgNFv2hq/f8SXlmTGtS1GOAibIgavEQ/Ve
         smvNYpiV2vHDie/91T7wqYq2jGJiS8Q3SMfQ0dvqW3PYWF4weMfuCurLzxzxZMDLoXGc
         0j9yjOQQuwesmK8SF5ao5Yr6gD6wY8DvD/MMRb1LoTFjP9GQLTvIVbyI04KSZ3ig0gYK
         zjDV3rTQk/fn9mfcBNeqGQVIH8pkbOMKMdzLgS9Sk6eQYVFXc6umZJg2CXlvbhqM8eZ/
         iF2Q==
X-Gm-Message-State: ABy/qLZMgsw3d//dU8FqOe6lIH22FtZ2MciEEI80h8fnVFaWd1okOs4Y
	AL4xDeeEl6cted8E+BSSifBJey1xIKkfxyDqRyk=
X-Google-Smtp-Source: APBJJlF7tF6ZEVPBpzMsXMeI7J9kaLJUpN3/+OoRLmSuRMD4STqi7kA3EZMR80QQLvc/SOyfRiz5/g==
X-Received: by 2002:a05:6808:1aa8:b0:3a3:7db0:3a46 with SMTP id bm40-20020a0568081aa800b003a37db03a46mr14554276oib.7.1689109274377;
        Tue, 11 Jul 2023 14:01:14 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:d1e8:1b90:7e91:3217])
        by smtp.gmail.com with ESMTPSA id d5-20020a05680808e500b003a1e965bf39sm1290575oic.2.2023.07.11.14.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 14:01:14 -0700 (PDT)
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
Subject: [PATCH net v3 0/4] net/sched: fixes for sch_qfq
Date: Tue, 11 Jul 2023 18:00:59 -0300
Message-Id: <20230711210103.597831-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patch 1 fixes a regression introduced in 6.4 where the MTU size could be
bigger than 'lmax'.

Patch 3 fixes an issue where the code doesn't account for qdisc_pkt_len()
returning a size bigger then 'lmax'.

Patches 2 and 4 are selftests for the issues above.

v2 -> v3:
 - Added Eric tags
 - Addressed issue in patch 4 pointed by Shaozheng

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


