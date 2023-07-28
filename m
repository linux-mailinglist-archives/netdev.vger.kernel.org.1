Return-Path: <netdev+bounces-22449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1E67678A1
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096AA1C21128
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 22:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02521FB35;
	Fri, 28 Jul 2023 22:49:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5877525C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 22:49:30 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCA11739
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:49:29 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5774335bb2aso28068397b3.0
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690584568; x=1691189368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aoyc1PKUUfRtEMyQxE6fSua05X/XRpBJJNT33hbYGZM=;
        b=g2+0WlVGaORxvEa/aw3NG7f0R94amP/e0GMu/n/NKiLBynBI3vD9UqPiBbYXpzrtUD
         NUXokkESQYSKs1cWRbhlUw82iHenqUQek/nsMOPfald44RwgKZTAXPLsRSXDeQdaAub4
         Y/S7FngoQiUsLkduHo/Nz3cAhr57Beu5k/OfakfJEuxkoWsezXlKOv/ue1UJK+seDJlI
         wiQbHAR+KxMwN5WiTW0rXL3ZtNgELSeqYqmT7zVaf8CreRjjVTnVRwtgW3/PB1iD+CqH
         kwJpNsXZbDKtP6mDVeSsPrfR/p4z6aU+y9SCPRIjdpGigt1ztKiP/ECUkMi1W4SmXAFR
         o6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690584568; x=1691189368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aoyc1PKUUfRtEMyQxE6fSua05X/XRpBJJNT33hbYGZM=;
        b=T7iKxGKh/0Uk2c+7o4IX1diz/EhOofFk65T/wUxF4/9WAsezy/cPGbEE0OtKIgh7c4
         m7SJXyI/glghgHPdPTjq0+Yp5HLl0RSEL4mDj+97QjWX6uhGV/vw++yDaC2ScappDUiF
         zo4QkZi9Inar90AId1zVjIjCNObsflgLhA2+shx9v1D6QPUc4efXq3ENh/PD6c97hTsQ
         Mo3tb8TkxycQdTmB2PVeyyO/QzNmPP+u9cOGOj4KyhdFKYtqrW5j2OBQ5WDpVja9rpps
         Hy0pE0Cij0hXTzt4GH//noXt7VFEJ27sLtT9gvnL09N2jzpmNTzTWeLzGPQV8jB7GTLr
         LKEA==
X-Gm-Message-State: ABy/qLZWQI7Sn6YIupJixgvfQn8d2DoHwRbwbtbsyjcfcQLK8GDbF2uE
	oL6KSVNd9+2sAemVFjwTE/EJfugfv5dhv1GIMqCp/f2waLDWElTxiTw=
X-Google-Smtp-Source: APBJJlEOEaP5vVvjN1y10JnyM6SWJ+gfiEurDijeGAq3vhUCZ8cG2WdC5aPqpk1ot8gzpHqajxbjT7WKhPCBajKqIDE=
X-Received: by 2002:a0d:db14:0:b0:583:e92c:e3a8 with SMTP id
 d20-20020a0ddb14000000b00583e92ce3a8mr3256803ywe.42.1690584568617; Fri, 28
 Jul 2023 15:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230728154059.1866057-1-pctammela@mojatatu.com>
In-Reply-To: <20230728154059.1866057-1-pctammela@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 28 Jul 2023 18:49:17 -0400
Message-ID: <CAM0EoMnjs4+6PPk_S9uTpFo1Lvd166AwFBZxkj+_BOBAx8yEPA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 0/2] selftests/tc-testing: initial steps for
 parallel tdc
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, dcaratti@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 11:41=E2=80=AFAM Pedro Tammela <pctammela@mojatatu.=
com> wrote:
>
> As the number of tdc tests is growing, so is our completion wall time.
> One of the ideas to improve this is to run tests in parallel, as they
> are self contained. Even though they will serialize over the rtnl lock,
> we expect it to give a nice boost.
>
> A first step is to make each test independent of each other by
> localizing its resource usage. Today tdc shares everything, including
> veth / dummy interfaces and netns. In patch 1 we make all of these
> resources unique per test.
>
> Patch 2 updates the tests to the new model, which also simplified some
> definitions and made them more concise and clearer.
>

Davide, if you get an opportunity can you please test with these
changes and add your tag?

cheers,
jamal

> Pedro Tammela (2):
>   selftests/tc-testing: localize test resources
>   selftests/tc-testing: update test definitions for local resources
>
>  .../testing/selftests/tc-testing/TdcPlugin.py |   4 +-
>  .../tc-testing/plugin-lib/nsPlugin.py         | 183 ++++++++---
>  .../tc-testing/plugin-lib/rootPlugin.py       |   4 +-
>  .../tc-testing/plugin-lib/valgrindPlugin.py   |   5 +-
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
>  .../tc-testing/tc-tests/qdiscs/teql.json      |  14 +-
>  tools/testing/selftests/tc-testing/tdc.py     | 118 +++++---
>  37 files changed, 1001 insertions(+), 1198 deletions(-)
>
> --
> 2.39.2
>

