Return-Path: <netdev+bounces-28860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EBC78106F
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC09C28240F
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7E1814;
	Fri, 18 Aug 2023 16:36:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D56B39E
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:36:14 +0000 (UTC)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178F03AAE
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:36:12 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-56d6879dcaaso772462eaf.3
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692376571; x=1692981371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vOR4P8p9vhEW7uBhM1tIQQ4sdH1voasvmq3NTtN82AI=;
        b=Y3q9w5Yzh3vDOeJmAnj5CgtNSPP0jXEl1x5YAl1Y1+J22ytwxbSqBE07RTSb+lX8OY
         eV9+xuzDJtIiX/XRFSx9catIUaRgQFQy9vdmB+6gi1p+9lfOmO1fxGOHpFjRD8hVv4wB
         W2PwEW2ZeHgGkV8Gbx07mZE8wUSrUaf7QV3ib+0e11noE1MIPo2CyCdWmiH8wgO9NGJl
         w9TeKIfzwuSzr3RodfVCgaNtykhj07Cl0WTBj/g3GjS+A/+lvBexLR0xqHMwwmPTj5N7
         e6//RY7qiMC4lfxp0GMcDTQr9oyZyAE7hYOMP46PdtvaBoaTXyQ8skWlsPedIKIunPuC
         sYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692376571; x=1692981371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOR4P8p9vhEW7uBhM1tIQQ4sdH1voasvmq3NTtN82AI=;
        b=W1qZRnzwCknSRTlBamucbfhTJ4XGgK44NYglOMXLOTxhBILmTlwBgAR94WTvSgrMn6
         fLD9VaBxr2YlrRTUBRix/iZgGDwa18GWHnIV0DHU2Kw0AKOTWfD6tK9aZbxR4i5tTXyj
         LsWE07/SZ+TUkc9j/+B8QjxV33v8T5F7QEGdK4m2jQ0d2YNLPHNa3tQWePVkiufW6Lom
         +BcPMzGz2UP3ToVdlz+aQrl+iovsy2RNqPSTOJ4jC3ot6Q7YT/dRxnhJTs4+uZDImZ7i
         bKVyYsa1tp+ZnFIeS3AEMgFEOYcmi4Cw32hbGLk6jNV7fa8SR4l/u/PHTEcXypW76BGn
         7bJg==
X-Gm-Message-State: AOJu0YzNB/nv8r5R6+xenC4s5PH1Y64CPYjxd46HjJ4K2pAFhmh0B0H9
	3IAX4Ckuy8nKKlh2AmnxAc8/6Zcb5ejlDu/jWTo=
X-Google-Smtp-Source: AGHT+IGEXl+ZkgGqRiSBmkVPjcXw5SrUIMFwL2pozxRSSrMsO3+K8ujdlDa3O+bMcAjFAG/R3jK0zQ==
X-Received: by 2002:a05:6871:1cd:b0:1be:fe7c:d0a6 with SMTP id q13-20020a05687101cd00b001befe7cd0a6mr3427752oad.2.1692376571294;
        Fri, 18 Aug 2023 09:36:11 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:bdfa:b54a:9d12:de38])
        by smtp.gmail.com with ESMTPSA id f200-20020a4a58d1000000b005634e8c4bbdsm561531oob.11.2023.08.18.09.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 09:36:10 -0700 (PDT)
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
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 0/5] selftests/tc-testing: add tests covering classid
Date: Fri, 18 Aug 2023 13:35:39 -0300
Message-Id: <20230818163544.351104-1-pctammela@mojatatu.com>
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

Patches 1-3 add missing tests covering classid behaviour on tdc for cls_fw,
cls_route and cls_fw. This behaviour was recently fixed by valis[0].

Patch 4 comes from the development done in the previous patches as it turns out
cls_route never returns meaningful errors.

Patch 5 also comes from the development done in the previous patches as
some u32 tests were missing an update to the regex pattern to work
properly.

[0] https://lore.kernel.org/all/20230729123202.72406-1-jhs@mojatatu.com/

Pedro Tammela (5):
  selftests/tc-testing: cls_fw: add tests for classid
  selftest/tc-testing: cls_route: add tests for classid
  selftest/tc-testing: cls_u32: add tests for classid
  net/sched: cls_route: make netlink errors meaningful
  selftests/tc-testing: cls_u32: update tests

 net/sched/cls_route.c                         | 27 +++++-----
 .../tc-testing/tc-tests/filters/fw.json       | 49 +++++++++++++++++++
 .../tc-testing/tc-tests/filters/route.json    | 25 ++++++++++
 .../tc-testing/tc-tests/filters/u32.json      | 35 +++++++++++--
 4 files changed, 119 insertions(+), 17 deletions(-)

-- 
2.39.2


