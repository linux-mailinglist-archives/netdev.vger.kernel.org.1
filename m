Return-Path: <netdev+bounces-30427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A635787463
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 17:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA241C20E83
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD7A134CE;
	Thu, 24 Aug 2023 15:38:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB34288E8
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 15:38:02 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC65E5C
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 08:38:00 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5711f6dff8cso8163eaf.3
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 08:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692891480; x=1693496280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aUkCY97T1BbkhkMOxefM8DQCFeMDu/bcRSUlfxMti24=;
        b=H6T0UUZuoaroQ/oca3qWwbQTPNnIYPGv5+yCDqlwZSMeaI1iPr+pl7o0VLj8382roV
         08JIrvVmkxLcCi4FtQpMZZ45mPlTvPPNBzFREkg67D++3aoPq9TlTOT8IrGLowo26ysw
         MKYAWqhkFXXPAVW9UMZoB/ygZJxK9q9imiGnQfzqPp3vOmRiZpxG0fhw0WQPshrdGVcW
         WZZyMPY1tNHqa3UBmXr/fgeOdkLxHyjzxKwpZeS0RkUSKJs/VvyEeIVcSBRru81MK7qt
         81wIlS49myeoa3y3QfPKSO9GdNrVZgHq0reqvrUatTuYSWhiVNxV4iBaWwpO7F8bFNlO
         ssBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692891480; x=1693496280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUkCY97T1BbkhkMOxefM8DQCFeMDu/bcRSUlfxMti24=;
        b=XDYrMN4+7Oo/Aoe+9qLWarVYq4q5ac1bw82JA688SIa5lrXkrSxY40J5DwQUldylyg
         4nP+dShn/2QzsScWp0Kw550wMsGIXeq1iB491RtWrtSpNZuu/wG3mXVVethgFCWNwxr8
         XxY2qyEFaiq2imMGaNZYvn2vWXVwMnbzGWSREfO4TVHesJTAFxwOEAgszAlf3gPRXgoG
         FhAsVm88UIL7geKLKXr4lpwraFBALOsixYM9vlXBC9dAZtMkO1gJ6uEZFl9/ahIOmXFJ
         fL2tOc9OuAHorVnSBSA3rVMXmLxFLEuNALkdgHnjl1L4aFUknC8Sdg/3pA7y/cnf6svl
         zXFA==
X-Gm-Message-State: AOJu0YyQ9Nykdl7Xfbvaz37SM2quYvVicsNKvKvU9e2vC1DfSZed0uI7
	NagqmMVykllzh7tZi8mr0UBQrD4wJhi8ThbJUMk=
X-Google-Smtp-Source: AGHT+IGchMs+XlOGhM56QNdbc4UNkUr82VseCJ047MsoDD86kBIYA1XSxIExt6sFFSYcsjfyAPjcuA==
X-Received: by 2002:a4a:6211:0:b0:56e:a1d3:747e with SMTP id x17-20020a4a6211000000b0056ea1d3747emr2456135ooc.6.1692891479819;
        Thu, 24 Aug 2023 08:37:59 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:ebd6:5010:2cd8:55fb])
        by smtp.gmail.com with ESMTPSA id q126-20020a4a4b84000000b0056c81dedb3bsm7592392ooa.8.2023.08.24.08.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 08:37:59 -0700 (PDT)
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
	dcaratti@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH RFC net-next v2 0/4] selftests/tc-testing: parallel tdc
Date: Thu, 24 Aug 2023 12:37:32 -0300
Message-Id: <20230824153736.629961-1-pctammela@mojatatu.com>
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

As the number of tdc tests is growing, so is our completion wall time.
One of the ideas to improve this is to run tests in parallel, as they
are self contained.

This series allows for tests to run in parallel, in batches of 32 tests.
Not all tests can run in parallel as they might conflict with each other.
The code will still honor this requirement even when trying to run the
tests over the worker pool.

In order to make this happen we had to localize the test resources
(patches 1 and 2), where instead of having all tests sharing one single
namespace and veths devices each test now gets it's own local namespace and devices.

Even though the tests serialize over rtnl_lock in the kernel, we
measured a speedup of about 3x in a test VM.

v1->v2: https://lore.kernel.org/all/20230728154059.1866057-1-pctammela@mojatatu.com/
   - Add worker pool

Pedro Tammela (4):
  selftests/tc-testing: localize test resources
  selftests/tc-testing: update test definitions for local resources
  selftests/tc-testing: implement tdc parallel test run
  selftests/tc-testing: update tdc documentation

 tools/testing/selftests/tc-testing/README     |  65 +---
 .../testing/selftests/tc-testing/TdcPlugin.py |   4 +-
 .../selftests/tc-testing/TdcResults.py        |   3 +-
 .../tc-testing/plugin-lib/nsPlugin.py         | 194 ++++++++----
 .../tc-testing/plugin-lib/rootPlugin.py       |   4 +-
 .../tc-testing/plugin-lib/valgrindPlugin.py   |   5 +-
 .../tc-testing/tc-tests/actions/connmark.json |  45 +++
 .../tc-testing/tc-tests/actions/csum.json     |  69 +++++
 .../tc-testing/tc-tests/actions/ct.json       |  54 ++++
 .../tc-testing/tc-tests/actions/ctinfo.json   |  36 +++
 .../tc-testing/tc-tests/actions/gact.json     |  75 +++++
 .../tc-testing/tc-tests/actions/gate.json     |  36 +++
 .../tc-testing/tc-tests/actions/ife.json      | 144 +++++++++
 .../tc-testing/tc-tests/actions/mirred.json   |  72 +++++
 .../tc-testing/tc-tests/actions/mpls.json     | 159 ++++++++++
 .../tc-testing/tc-tests/actions/nat.json      |  81 +++++
 .../tc-testing/tc-tests/actions/pedit.json    | 198 ++++++++++++
 .../tc-testing/tc-tests/actions/police.json   | 102 +++++++
 .../tc-testing/tc-tests/actions/sample.json   |  87 ++++++
 .../tc-testing/tc-tests/actions/simple.json   |  27 ++
 .../tc-testing/tc-tests/actions/skbedit.json  |  90 ++++++
 .../tc-testing/tc-tests/actions/skbmod.json   |  54 ++++
 .../tc-tests/actions/tunnel_key.json          | 117 ++++++++
 .../tc-testing/tc-tests/actions/vlan.json     | 108 +++++++
 .../tc-testing/tc-tests/actions/xt.json       |  24 ++
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
 .../tc-testing/tc-tests/qdiscs/teql.json      |  34 +--
 tools/testing/selftests/tc-testing/tdc.py     | 250 +++++++++++----
 58 files changed, 2720 insertions(+), 1288 deletions(-)

-- 
2.39.2


