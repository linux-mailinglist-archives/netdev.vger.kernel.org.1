Return-Path: <netdev+bounces-22334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153027670CA
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED191C218FE
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C304F14262;
	Fri, 28 Jul 2023 15:41:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA196129
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:41:11 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F5735AF
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:41:09 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bb14c05d77so1931784a34.2
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690558868; x=1691163668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=anwCd4p/pAiVQLldS5whoXIw+JS0Zv1ynLzf9VSDt1o=;
        b=tYpUskKO3s7bLBi3PXn+nek9VIHyia8nCJRWP4wN/svdGctShn0ikWltFJDHGbmYxX
         K9CcCveUlJVadsasuMkhlJAKzuADkKWYGk5iDynwzizCDD7RxOCD3E1GwH854gBEuO0a
         maPrjHRCipshelWWRxLFXRiwsaTK6iWRoRrHR8pZiembdaillpoDfUPohKlq3fdml4HO
         w+ahoYdBuNUfDaananC7rLhpNvPNVH/Ac6deD6b7eJeiCtlTXfRKLCLEyxtvczd7RqW2
         I6H/rSmC/zNhVuNI/CNTSjdDIvefTVVOEGNv8n+oAVYxlGJ+dD5ACb4uqKJTNgHn9JxD
         GJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690558868; x=1691163668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=anwCd4p/pAiVQLldS5whoXIw+JS0Zv1ynLzf9VSDt1o=;
        b=bhE5x5i8f5dzgrtgw7i5qHsQJ2DM4+S4UgIWNzZZhE7eqgMsRYOgd0lnYBi3PdJhk8
         NueMKIGv7PJLqP0Qjdpjuh/Y3Qwz4D1BsZeCswxHKCS4ATKC341wmNOaPLyKO1jth5sl
         T+IloWWejGlvM+4Xn0c7G3udWNPDWt04sd8B65CpioSQMD/F5sGWiMLj0c24bOCX49ir
         4R+mVROjs9LeBfmEGwzjyZCJJjpiEA1ZXKwKeo+OXACGAIjwEeA0VBa9drP4mHfa3UoG
         tVCtFOQ2G98Rm176XZRbKaUg3JvCyvli+tPv8XpZvxB9R/ZvmlaRkdls3Bd/PZ3znQpF
         s9Xw==
X-Gm-Message-State: ABy/qLanG+jATX/lxVNEzjxax2FOj742QVQ09O1xJuqIiLTaw1VOn24L
	Bfr+pB6LyL6XeIpNUTAcA5dSDEywTJhPAvy+Iu4=
X-Google-Smtp-Source: APBJJlELh7WTuI0k5ITs//rZx+ZEN50dys/dK0ZnM2o7keeyI68EkdP/BPgHdaev84yJE1YFuiKwfw==
X-Received: by 2002:a9d:6ace:0:b0:6ba:a084:6a1b with SMTP id m14-20020a9d6ace000000b006baa0846a1bmr3196834otq.10.1690558868326;
        Fri, 28 Jul 2023 08:41:08 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:81ef:7444:5901:c19d])
        by smtp.gmail.com with ESMTPSA id d7-20020a05683018e700b006b9ad7d0046sm1691173otf.57.2023.07.28.08.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:41:07 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	dcaratti@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [RFC PATCH net-next 0/2] selftests/tc-testing: initial steps for parallel tdc
Date: Fri, 28 Jul 2023 12:40:57 -0300
Message-Id: <20230728154059.1866057-1-pctammela@mojatatu.com>
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
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As the number of tdc tests is growing, so is our completion wall time.
One of the ideas to improve this is to run tests in parallel, as they
are self contained. Even though they will serialize over the rtnl lock,
we expect it to give a nice boost.

A first step is to make each test independent of each other by
localizing its resource usage. Today tdc shares everything, including
veth / dummy interfaces and netns. In patch 1 we make all of these
resources unique per test.

Patch 2 updates the tests to the new model, which also simplified some
definitions and made them more concise and clearer.

Pedro Tammela (2):
  selftests/tc-testing: localize test resources
  selftests/tc-testing: update test definitions for local resources

 .../testing/selftests/tc-testing/TdcPlugin.py |   4 +-
 .../tc-testing/plugin-lib/nsPlugin.py         | 183 ++++++++---
 .../tc-testing/plugin-lib/rootPlugin.py       |   4 +-
 .../tc-testing/plugin-lib/valgrindPlugin.py   |   5 +-
 .../tc-testing/tc-tests/filters/bpf.json      |  10 +-
 .../tc-testing/tc-tests/filters/fw.json       | 266 ++++++++--------
 .../tc-testing/tc-tests/filters/matchall.json | 141 +++++----
 .../tc-testing/tc-tests/infra/actions.json    | 144 ++++-----
 .../tc-testing/tc-tests/infra/filter.json     |   9 +-
 .../tc-testing/tc-tests/qdiscs/cake.json      |  82 ++---
 .../tc-testing/tc-tests/qdiscs/cbs.json       |  38 +--
 .../tc-testing/tc-tests/qdiscs/choke.json     |  30 +-
 .../tc-testing/tc-tests/qdiscs/codel.json     |  34 +--
 .../tc-testing/tc-tests/qdiscs/drr.json       |  10 +-
 .../tc-testing/tc-tests/qdiscs/etf.json       |  18 +-
 .../tc-testing/tc-tests/qdiscs/ets.json       | 284 ++++++++++--------
 .../tc-testing/tc-tests/qdiscs/fifo.json      |  98 +++---
 .../tc-testing/tc-tests/qdiscs/fq.json        |  68 +----
 .../tc-testing/tc-tests/qdiscs/fq_codel.json  |  54 +---
 .../tc-testing/tc-tests/qdiscs/fq_pie.json    |   5 +-
 .../tc-testing/tc-tests/qdiscs/gred.json      |  28 +-
 .../tc-testing/tc-tests/qdiscs/hfsc.json      |  26 +-
 .../tc-testing/tc-tests/qdiscs/hhf.json       |  36 +--
 .../tc-testing/tc-tests/qdiscs/htb.json       |  46 +--
 .../tc-testing/tc-tests/qdiscs/ingress.json   |  36 ++-
 .../tc-testing/tc-tests/qdiscs/netem.json     |  62 +---
 .../tc-tests/qdiscs/pfifo_fast.json           |  18 +-
 .../tc-testing/tc-tests/qdiscs/plug.json      |  30 +-
 .../tc-testing/tc-tests/qdiscs/prio.json      |  85 +++---
 .../tc-testing/tc-tests/qdiscs/qfq.json       |  39 +--
 .../tc-testing/tc-tests/qdiscs/red.json       |  34 +--
 .../tc-testing/tc-tests/qdiscs/sfb.json       |  48 +--
 .../tc-testing/tc-tests/qdiscs/sfq.json       |  40 +--
 .../tc-testing/tc-tests/qdiscs/skbprio.json   |  16 +-
 .../tc-testing/tc-tests/qdiscs/tbf.json       |  36 +--
 .../tc-testing/tc-tests/qdiscs/teql.json      |  14 +-
 tools/testing/selftests/tc-testing/tdc.py     | 118 +++++---
 37 files changed, 1001 insertions(+), 1198 deletions(-)

-- 
2.39.2


