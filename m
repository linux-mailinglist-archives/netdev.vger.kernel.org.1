Return-Path: <netdev+bounces-35318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 419647A8DAC
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 22:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E1C281D8A
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 20:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8E71A5A4;
	Wed, 20 Sep 2023 20:17:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF9341235
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 20:17:20 +0000 (UTC)
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553A3B9
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 13:17:18 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id af79cd13be357-76dcf1d8905so17276985a.1
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 13:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695241037; x=1695845837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aQXsiBEzn/ykqwFugABCLTdDmR3Km67mI3QA7N0wltg=;
        b=Og04wfWgYUK9vMHLXL/fwR3QsGTL7ltfCJ0zq5HhQmf7OXGsqtJSZie9CiGgWKTucB
         pUDAhGjtNVn425UFklmJ+nheMYWWtjIzd1Ue48C59dFD7fj6Gtkl74NgHK6eh/yfrNXX
         7m07QP1olvgdZwYNYiAjXzMQFmUXQstASH7wNRl9bLB5LywmiOr+O1Y1eFLjnlctXIxt
         4awyJpFCiJ8xLuCmYQe7g1EYJgW5brPDo8Df2T1KmiApqQICk05rQG2JEV9NEq9ebTaP
         CnVGuq06Asskte027xvNVAnlmGiN5/gT7Pg5d/5S87dBa4DvtNyHEXk6ETAb7uE2yvkK
         rHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695241037; x=1695845837;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQXsiBEzn/ykqwFugABCLTdDmR3Km67mI3QA7N0wltg=;
        b=HCMYMHtTfXow2ER6MFt5m+6hH/ateCJi4fuzCi/P7stVWgOaDYtkeq+/HW64QQjb+5
         atBZwKksXPNPWwO0mKZEtMuSToE0svymhekT8eSGl6/7MwFeInVCasSyXlGDZUHUBsBA
         lLlJBO2Zm9ui9Gl9BwvZjQsK7pMFJnzTvKvg8URWsuwV+zozVlu4ERW6eHNCGvRgwS3a
         EJAA8JlAJbflYn5yY/TS9CZMdiEbZKcESavje4dRoPRQKzp22yBUvDf8S/qFrpXdlLzV
         FisvSMLgQUIKDGm5bD1siU6nU+XPtv7ReOfkKEO+AstqoOaXmPc59Slx/0hrSY1o+g/e
         +8ZQ==
X-Gm-Message-State: AOJu0YwwaY4eP2ey0CIoz76jP9jISw4g3aajLbycGl0luH7QqPg46BBe
	jWsVEjPgKRgrqUAuCZ/6SOvYzqVLYdzgiQ==
X-Google-Smtp-Source: AGHT+IEgS0fUKG7/N7Dsu8qryGHmdZWFeFHrnFpF94jpfXHOe0FN1yxhaNGL+5SFq0UdJMrDrJ2Z3vaPpXIxMw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:481:b0:76d:be7d:97d8 with SMTP
 id 1-20020a05620a048100b0076dbe7d97d8mr50792qkr.3.1695241037207; Wed, 20 Sep
 2023 13:17:17 -0700 (PDT)
Date: Wed, 20 Sep 2023 20:17:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920201715.418491-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/5] net_sched: sch_fq: round of improvements
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For FQ tenth anniversary, it was time for making it faster.

The FQ part (as in Fair Queue) is rather expensive, because
we have to classify packets and store them in a per-flow structure,
and add this per-flow structure in a hash table. Then the RR lists
also add cache line misses.

Most fq qdisc are almost idle. Trying to share NIC bandwidth has
no benefits, thus the qdisc could behave like a FIFO.

This series brings a 5 % throughput increase in intensive
tcp_rr workload, and 13 % increase for (unpaced) UDP packets.

v2: removed an extra label (build bot).
    Fix an accidental increase of stat_internal_packets counter
    in fast path.
    Added "constify qdisc_priv()" patch to allow fq_fastpath_check()
    first parameter to be const.
    typo on 'eligible' (Willem)

Eric Dumazet (5):
  net_sched: constify qdisc_priv()
  net_sched: sch_fq: struct sched_data reorg
  net_sched: sch_fq: change how @inactive is tracked
  net_sched: sch_fq: add fast path for mostly idle qdisc
  net_sched: sch_fq: always garbage collect

 include/net/pkt_sched.h        |   8 +-
 include/uapi/linux/pkt_sched.h |   1 +
 net/sched/sch_fq.c             | 148 +++++++++++++++++++++++----------
 3 files changed, 110 insertions(+), 47 deletions(-)

-- 
2.42.0.459.ge4e396fd5e-goog


