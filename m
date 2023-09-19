Return-Path: <netdev+bounces-34986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BED447A65C5
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 15:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B36F1C21064
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88713374D8;
	Tue, 19 Sep 2023 13:54:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B50F37C8A
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 13:54:30 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B87FF2
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 06:54:28 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1bba7717d3bso3692058fac.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 06:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1695131667; x=1695736467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JX3Ok9Fex8klrOfPP07Z5vtNPFscBz2OnbRl3dFaHDk=;
        b=FsO3yv6Tr15ykb3FOr10S1GfhNKcVwHZvJXQZ+qOl4ezhFFmvZpUgaWYbNHljP2z9L
         PhoQlbMPOnss570tizr4nf9bpTSUcHUpZMs4bmoQKmjluUC+hH8JfjTcMkFB91LU3MIf
         Lb1CBYLkmDUDlxRxCSPNSZm/l3+5AZMZaI+Jz/zJ8IVE5lSYrzeiI52xsbRkNTkSwE5J
         8zfAcROLdeaa+b3giqJakQZVKTVw1hkAPxJ5s5daCyOQHliSm0VcK7HIvFrezI745mKi
         R8vD22+aPH/JURrVu/ihhguJOdcdybC+O4lyEFTPQLOrupQ+qJabma8kCu50buvgIW9e
         Flow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695131667; x=1695736467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JX3Ok9Fex8klrOfPP07Z5vtNPFscBz2OnbRl3dFaHDk=;
        b=q6bKYzS1mIpZkUMgzlsD0ydU7vXKnavLpl/bNW/aFATzQeIJx8LXKSgLxTCcjYb8p3
         64lM5aNoW8FpRLljCYuDSmC2v9E5qXscl4tAM9ygn2AJTue7z+ZPjvhw0WKztRULsrNL
         cU0EA3qvI0IoQmNREmlGslDwIZo4/APjKqvmGLyNk3WVPzyhFbzfRyi4t8tRXID6Qkjw
         T/hTCutU4I648rZkTMG2egILjs+SM1IE/LA60OL8DaAhX9TpH+Yi2DKMZwrDRVVkEGCM
         HZfpiOaPyS+FPw92ajZa8AVR8giYlK5rTRCZeD9kdRnhvIlEbKfsi+Tdnamm3zMjfomj
         H05A==
X-Gm-Message-State: AOJu0Yz1S8XqA6tpVeicUvcvF/AGIrJ6Lnu+Vj2Vn4LmuCUehVbaJoRr
	N8YTkFqkr4bl89WGbuzY9igFROxlSwHq19qUI9U=
X-Google-Smtp-Source: AGHT+IHPcP1V4+J5vSs7lkDRFgx5vzwvPfsh+0JWOPdEkDz2FnhT20xYgLXi1CeMVhXuqFcnBBealg==
X-Received: by 2002:a05:6870:568a:b0:1b7:670e:ad85 with SMTP id p10-20020a056870568a00b001b7670ead85mr15118041oao.49.1695131667690;
        Tue, 19 Sep 2023 06:54:27 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:cd1e:1428:689a:5af3])
        by smtp.gmail.com with ESMTPSA id h22-20020a056870a3d600b001ccab369c09sm6004270oak.42.2023.09.19.06.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 06:54:27 -0700 (PDT)
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
	victor@mojatatu.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 0/4] selftests/tc-testing: parallel tdc
Date: Tue, 19 Sep 2023 10:54:00 -0300
Message-Id: <20230919135404.1778595-1-pctammela@mojatatu.com>
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


