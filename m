Return-Path: <netdev+bounces-15150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DA6745F8E
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 17:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFBF1C208BB
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 15:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ECC100A3;
	Mon,  3 Jul 2023 15:11:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7638CF9CB
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 15:11:13 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57674AD
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:11:12 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1b0606bee45so4205907fac.3
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 08:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688397071; x=1690989071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IlD0SO0Djn3QFwHCfvZXo/x2IFbDuMsDOV/eik7/zd0=;
        b=MhUz2bYms7aUeFFof6w73/SxWaXaQ7cbHmw5Xcuve05qB0Tol9yyojY+N8CarrdmtC
         jpY0yIgRVL2gixJlqyzr0YnHA8yqJ2H5awOnsREkE+BPjDEONl3YWDK/b1tGHXAxEoat
         At8NUI/zX37IyRud1Ocp+ZxIb+YYnzRaaIWFcltkgs9q2C77QoiSzoRAYY/vKMmV0tq2
         CKEixmhpEMC4gXJVZtJegGcg4HyrL2KDoUxcp0VpOYZwZiJQo7qfFXFcWjwfkzrj5z+I
         x23B8aK1V2QWBAikqjTYdiSdbz6/NyBbcBe2LDwEVMDZQpW2SexUdhwTMZRdOa3DQI2+
         uVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688397071; x=1690989071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlD0SO0Djn3QFwHCfvZXo/x2IFbDuMsDOV/eik7/zd0=;
        b=d4K2OTZfvri2fMudmLO4HNU6m/FfY1YTn4omy5SyQQNNO9vV79zuost0JL5Xpja6mG
         MXTc8AIINkvxuG5GJZGwJ7L3tAJ1Bq3VSzwcCOJmaRT5kdmdbMRqwmj0NHG6BeTJAmHE
         pl53pFnjB2JJ9sQZEZv4Qwt7892FdEVXuQtxytCgce7zgkIODqPRxDL8bbRsNkik3o2I
         PmqZAiBDY9flhgjtZGALbAwv0+E4daMv+pait9Bt2BwFRRFeijGqMWYDqtlswllN+C5f
         4hCiGRQIO6AzLAt3+o/XCKzZixP80tbz9AmbWEKKMgCIkS/w4H268gi/UNbA1HAVilbJ
         81cA==
X-Gm-Message-State: AC+VfDxbwbCEAZzS3EBPR2oascVi/uBxxsyQNbre1Ile4krSrbDQsRtv
	csHbzCSgsNB17DUskRumiqigKcZvX8iHZEnBejU=
X-Google-Smtp-Source: ACHHUZ7b2zL1V/OpzakolDDAemYF2mhRTDxwHLJ4ts3VMo+FgFB1wLsmTEdvvmHFoRATGRWoRpGqDA==
X-Received: by 2002:a05:6870:7808:b0:1b0:3043:cb4a with SMTP id hb8-20020a056870780800b001b03043cb4amr12356596oab.0.1688397071587;
        Mon, 03 Jul 2023 08:11:11 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:7e4b:4854:9cb2:8ddc])
        by smtp.gmail.com with ESMTPSA id cm9-20020a056870b60900b0019f188355a8sm12452600oab.17.2023.07.03.08.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 08:11:11 -0700 (PDT)
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
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net 0/2] net/sched: sch_qfq: reintroduce lmax bound check for MTU
Date: Mon,  3 Jul 2023 12:10:36 -0300
Message-Id: <20230703151038.157771-1-pctammela@mojatatu.com>
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

Reintroduce a bound check for lmax when no attribute is provided and MTU
is used. As the MTU is user controlled, it could be set outside of the
supported bounds for sch_qfq.

Patch 2 introduces tdc test cases to check if these requirements are
still being correctly checked.

Pedro Tammela (2):
  net/sched: sch_qfq: reintroduce lmax bound check for MTU
  selftests: tc-testing: add tests for qfq mtu sanity check

 net/sched/sch_qfq.c                           |  9 +++-
 .../tc-testing/tc-tests/qdiscs/qfq.json       | 48 +++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)

-- 
2.39.2


