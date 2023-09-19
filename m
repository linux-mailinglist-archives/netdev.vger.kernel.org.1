Return-Path: <netdev+bounces-35002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6569C7A66DF
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 16:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA3B1C2011E
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 14:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8AF28E02;
	Tue, 19 Sep 2023 14:38:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37F83715D
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 14:38:40 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDCE83
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:38:38 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59e6ebdf949so42422187b3.0
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1695134317; x=1695739117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAUGyXs0i57GSYOAuPxhBEumsM60WEwwx14etrnmHUw=;
        b=TA1gGn/Jegdwy8p5sUHTyUnq1EedZU1cgznB1kcFMl7cCiWLzNiN9lp9wvYlWQFWmz
         wKbXex3TrHenu9bFD14bk4DBs3DxKJHBSaxLxQ92ho7eUHcVePEPmzmMoQBmzcdLwV8L
         I+/FaQ8SljAYQWFPmpoamZOAtvzmQ0Ni7jR+j/UmvfkEeZPsPCZ1rhcca8vFXsb46c3/
         oAPceoql5hmj2KNGQO/cief7d1i9bWG2bX9mZl2saYQLXOwFMsZodFo6OXdncH63zBH2
         U3mSfeqJN0ybF6JdcH2cWkzoF59cMTxHLljheLJs+J4UN09Eppacz4xImLKYLln/5dQt
         w/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695134317; x=1695739117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAUGyXs0i57GSYOAuPxhBEumsM60WEwwx14etrnmHUw=;
        b=YB0U4hbJRJzJxhDsSpncZ1eE+MjbXm8NK1+nl6oz3rE62phJcuw5tWvTHhYq7NV/mo
         BLE9BjyVtXLtIU2jylsyLJiNt5i3DFJ14hYZTVXml/KhbNcdO6Xn/geUVrSldbF4JaUY
         f5HP8ysBkPifLf4Ja+QhDSbVypDSIU92+C/jXBwsgvt0p9dKJLF6Ovg5kJQcchZzSyGC
         /oXu0rs16lE+QN+xhNGO94v04F1NuUHxFinFCuK8VzUlWQe3evd/nardjJJA575AqCn0
         C+o6+xPiGHaCKc2SGgFpLKGP+1/5j7uNmlZgDqOHow5DLmV0XmJJbVEtgNAQycibHbvZ
         HjwQ==
X-Gm-Message-State: AOJu0Yy8ZwdaLhX8QVMdKm7Yc0cfqqqD9EN24w9YQ3qKuzMTzpXi3ztS
	7HGAmZbHaU8SU/eyj8Wgp0sXGIBN/YZp+7dGD80L/A==
X-Google-Smtp-Source: AGHT+IEFrOTW2/5yRyEo5mZ6BINBt0MivQOKlx1MGb4+nYPNdAXL2bFWy67ikrq0yrIwQQtUMCF/uMrF5KLw7AM6yfE=
X-Received: by 2002:a0d:e688:0:b0:59b:5bd2:1052 with SMTP id
 p130-20020a0de688000000b0059b5bd21052mr2962344ywe.5.1695134317431; Tue, 19
 Sep 2023 07:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230919135404.1778595-1-pctammela@mojatatu.com>
In-Reply-To: <20230919135404.1778595-1-pctammela@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 19 Sep 2023 10:38:25 -0400
Message-ID: <CAM0EoM=qQF_C1Pz5TQnV=9ETkt3AP49zisCEbEY-KD-mNcmDyQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] selftests/tc-testing: parallel tdc
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 9:54=E2=80=AFAM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> As the number of tdc tests is growing, so is our completion wall time.
> One of the ideas to improve this is to run tests in parallel, as they
> are self contained.
>
> This series allows for tests to run in parallel, in batches of 32 tests.
> Not all tests can run in parallel as they might conflict with each other.
> The code will still honor this requirement even when trying to run the
> tests over the worker pool.
>
> In order to make this happen we had to localize the test resources
> (patches 1 and 2), where instead of having all tests sharing one single
> namespace and veths devices each test now gets it's own local namespace a=
nd devices.
>
> Even though the tests serialize over rtnl_lock in the kernel, we
> measured a speedup of about 3x in a test VM.
>

For the patch series:
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> Pedro Tammela (4):
>   selftests/tc-testing: localize test resources
>   selftests/tc-testing: update test definitions for local resources
>   selftests/tc-testing: implement tdc parallel test run
>   selftests/tc-testing: update tdc documentation
>
>  tools/testing/selftests/tc-testing/README     |  65 +---
>  .../testing/selftests/tc-testing/TdcPlugin.py |   4 +-
>  .../selftests/tc-testing/TdcResults.py        |   3 +-
>  .../tc-testing/plugin-lib/nsPlugin.py         | 194 ++++++++----
>  .../tc-testing/plugin-lib/rootPlugin.py       |   4 +-
>  .../tc-testing/plugin-lib/valgrindPlugin.py   |   5 +-
>  .../tc-testing/tc-tests/actions/connmark.json |  45 +++
>  .../tc-testing/tc-tests/actions/csum.json     |  69 +++++
>  .../tc-testing/tc-tests/actions/ct.json       |  54 ++++
>  .../tc-testing/tc-tests/actions/ctinfo.json   |  36 +++
>  .../tc-testing/tc-tests/actions/gact.json     |  75 +++++
>  .../tc-testing/tc-tests/actions/gate.json     |  36 +++
>  .../tc-testing/tc-tests/actions/ife.json      | 144 +++++++++
>  .../tc-testing/tc-tests/actions/mirred.json   |  72 +++++
>  .../tc-testing/tc-tests/actions/mpls.json     | 159 ++++++++++
>  .../tc-testing/tc-tests/actions/nat.json      |  81 +++++
>  .../tc-testing/tc-tests/actions/pedit.json    | 198 ++++++++++++
>  .../tc-testing/tc-tests/actions/police.json   | 102 +++++++
>  .../tc-testing/tc-tests/actions/sample.json   |  87 ++++++
>  .../tc-testing/tc-tests/actions/simple.json   |  27 ++
>  .../tc-testing/tc-tests/actions/skbedit.json  |  90 ++++++
>  .../tc-testing/tc-tests/actions/skbmod.json   |  54 ++++
>  .../tc-tests/actions/tunnel_key.json          | 117 ++++++++
>  .../tc-testing/tc-tests/actions/vlan.json     | 108 +++++++
>  .../tc-testing/tc-tests/actions/xt.json       |  24 ++
>  .../tc-testing/tc-tests/filters/bpf.json      |  10 +-
>  .../tc-testing/tc-tests/filters/fw.json       | 266 ++++++++--------
>  .../tc-testing/tc-tests/filters/matchall.json | 141 +++++----
>  .../tc-testing/tc-tests/infra/actions.json    | 144 ++++-----
>  .../tc-testing/tc-tests/infra/filter.json     |   9 +-
>  .../tc-testing/tc-tests/qdiscs/cake.json      |  82 ++---
>  .../tc-testing/tc-tests/qdiscs/cbs.json       |  38 +--
>  .../tc-testing/tc-tests/qdiscs/choke.json     |  30 +-
>  .../tc-testing/tc-tests/qdiscs/codel.json     |  34 +--
>  .../tc-testing/tc-tests/qdiscs/drr.json       |  10 +-
>  .../tc-testing/tc-tests/qdiscs/etf.json       |  18 +-
>  .../tc-testing/tc-tests/qdiscs/ets.json       | 284 ++++++++++--------
>  .../tc-testing/tc-tests/qdiscs/fifo.json      |  98 +++---
>  .../tc-testing/tc-tests/qdiscs/fq.json        |  68 +----
>  .../tc-testing/tc-tests/qdiscs/fq_codel.json  |  54 +---
>  .../tc-testing/tc-tests/qdiscs/fq_pie.json    |   5 +-
>  .../tc-testing/tc-tests/qdiscs/gred.json      |  28 +-
>  .../tc-testing/tc-tests/qdiscs/hfsc.json      |  26 +-
>  .../tc-testing/tc-tests/qdiscs/hhf.json       |  36 +--
>  .../tc-testing/tc-tests/qdiscs/htb.json       |  46 +--
>  .../tc-testing/tc-tests/qdiscs/ingress.json   |  36 ++-
>  .../tc-testing/tc-tests/qdiscs/netem.json     |  62 +---
>  .../tc-tests/qdiscs/pfifo_fast.json           |  18 +-
>  .../tc-testing/tc-tests/qdiscs/plug.json      |  30 +-
>  .../tc-testing/tc-tests/qdiscs/prio.json      |  85 +++---
>  .../tc-testing/tc-tests/qdiscs/qfq.json       |  39 +--
>  .../tc-testing/tc-tests/qdiscs/red.json       |  34 +--
>  .../tc-testing/tc-tests/qdiscs/sfb.json       |  48 +--
>  .../tc-testing/tc-tests/qdiscs/sfq.json       |  40 +--
>  .../tc-testing/tc-tests/qdiscs/skbprio.json   |  16 +-
>  .../tc-testing/tc-tests/qdiscs/tbf.json       |  36 +--
>  .../tc-testing/tc-tests/qdiscs/teql.json      |  34 +--
>  tools/testing/selftests/tc-testing/tdc.py     | 250 +++++++++++----
>  58 files changed, 2720 insertions(+), 1288 deletions(-)
>
> --
> 2.39.2
>

