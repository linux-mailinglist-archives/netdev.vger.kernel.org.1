Return-Path: <netdev+bounces-17668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C3B752A1F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 20:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469D41C2142F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0CD1F921;
	Thu, 13 Jul 2023 18:05:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186E11F173
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 18:05:27 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BC2271F
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 11:05:26 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-39ca120c103so836156b6e.2
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 11:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689271525; x=1691863525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vZj4h+6Yk/nzRuccIArEHBriQ4j+wGA3124QyzvZzuE=;
        b=bVxZoXCMeo38bw+i06/BUypFN/wAJ5ERz3aOwZf+3IDdP5CnG8HWAy8+uCoRvSXMo7
         kbxliRu5Ds/ZLJdqmC+QDgvURHnDHuoBbtqAhNcD/gclUgX8YXaizMq6OIWC+JKAVCoU
         rNsdDddk+clZ6RZSJqLfom6KSUW+MPz3eXs5xbuauNSlVbTqKMVNr31fVF9ne8pJcan9
         MxKhtOnS1cU3x8fjoM4wTqhfEYuFjJpkPPBzwhQPUC5rcucUECjouZHljB9ZmUMx3DgS
         M91p6S/sN5YaoNMsF1dWCWQmFf12l4CMUaKRaO6GQHJmpIwFTGJrgMKwJMVJ8E1zjE/N
         LTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689271525; x=1691863525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZj4h+6Yk/nzRuccIArEHBriQ4j+wGA3124QyzvZzuE=;
        b=YmdvAhJ4/lC7oAGYzeDplj5QqPKinRbevYSSVn+2HUdYUbfIWQluOrP0zGkWGdX+ds
         bK2cu4jNV5MPfXbcXFroQWHWRHLP4Vshmpj/ScXmedm9sppwNGR45+6SgWqPAu6e2lMg
         5m3M/UIzXN4xZdQf46VZC2h3/bNbV5xF8v5ZHAmMt+CNcW5Mt5na8tNN9tPJJAqzBWrp
         U5COsHSn/IoGvFfa6Yruh9ru+ykJ8VdumytHh8Pckqrqs9Te0v26rg0r/RVsDCx6dUjE
         Vlb0kRRrtBEmt6uFWZ51+8SNecOog+Djx3Ow1Au7T2hy2ecfWSoU/r/qJrvd61FFQ9xW
         ytjA==
X-Gm-Message-State: ABy/qLaLMCJK5g2Wi52D0xxRx7R9+YDC5gFsE37Prb4Uf2CsNKj7O2wi
	oEgGxWuAg2e00KLRLYLKTmggVVCnqhyQj1BxCpk=
X-Google-Smtp-Source: APBJJlG5b80I/6PBLz3cAxkCzPH9kDxYuuErro8/FF6+lSD0ITkW3N9IEdDkpeBziaXWIsQ3BIVahw==
X-Received: by 2002:aca:f2d6:0:b0:3a3:6cb2:d5bf with SMTP id q205-20020acaf2d6000000b003a36cb2d5bfmr2198282oih.4.1689271525284;
        Thu, 13 Jul 2023 11:05:25 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c1:1622:34af:d3bb:8e9a:95c5])
        by smtp.gmail.com with ESMTPSA id t65-20020a4a5444000000b005660b585a00sm3175299ooa.22.2023.07.13.11.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 11:05:24 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pctammela@mojatatu.com,
	simon.horman@corigine.com,
	kernel@mojatatu.com
Subject: [PATCH net v5 0/5] net: sched: Fixes for classifiers
Date: Thu, 13 Jul 2023 15:05:09 -0300
Message-Id: <20230713180514.592812-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.40.1
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

Four different classifiers (bpf, u32, matchall, and flower) are
calling tcf_bind_filter in their callbacks, but arent't undoing it by
calling tcf_unbind_filter if their was an error after binding.

This patch set fixes all this by calling tcf_unbind_filter in such
cases.

This set also undoes a refcount decrement in cls_u32 when an update
fails under specific conditions which are described in patch #3.

v1 -> v2:
* Remove blank line after fixes tag
* Fix reverse xmas tree issues pointed out by Simon

v2 -> v3:
* Inline functions cls_bpf_set_parms and fl_set_parms to avoid adding
  yet another parameter (and a return value at it) to them.
* Remove similar fixes for u32 and matchall, which will be sent soon,
  once we find a way to do the fixes without adding a return parameter
  to their set_parms functions.

v3 -> v4:
* Inline mall_set_parms to avoid adding yet another parameter.
* Remove set_flags parameter from u32_set_parms and create a separate
  function for calling tcf_bind_filter and tcf_unbind_filter in case of
  failure.
* Change cover letter title to also encompass refcnt fix for u32

v4 -> v5:
* Change back tag to net

Victor Nogueira (5):
  net: sched: cls_matchall: Undo tcf_bind_filter in case of failure
    after mall_set_parms
  net: sched: cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode
  net: sched: cls_u32: Undo refcount decrement in case update failed
  net: sched: cls_bpf: Undo tcf_bind_filter in case of an error
  net: sched: cls_flower: Undo tcf_bind_filter in case of an error

 net/sched/cls_bpf.c      | 99 +++++++++++++++++++---------------------
 net/sched/cls_flower.c   | 99 +++++++++++++++++++---------------------
 net/sched/cls_matchall.c | 35 +++++---------
 net/sched/cls_u32.c      | 48 ++++++++++++++-----
 4 files changed, 143 insertions(+), 138 deletions(-)

-- 
2.25.1


