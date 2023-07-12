Return-Path: <netdev+bounces-17307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E905275126F
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 23:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5752A1C21075
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 21:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1AEE55D;
	Wed, 12 Jul 2023 21:13:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF519DDC8
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 21:13:55 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6A23C13
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:13:29 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1b060bce5b0so6214774fac.3
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689196407; x=1691788407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xaEiUWqQ8n4H0ZWB5ZhdTuErYaUCfdenhxdMQwih9nM=;
        b=hFMgWSV6IyoB7ndR9WzLR3iX7LRbW+6v7G3kIkbngGU1QxREFK0bCu8hCzcnSTS6/w
         Rz7kCLhq2FMWPX87JGUd/kJhQ3AXgjsVBndYQhisdgXVJ9iNYl528vbm4yXP8F17f0rQ
         NQVpT6o1I+uX8GUoZbpgk2rQ8v0GNkim0+eozaYql7JKuAHzPW9AXba2mprpSQw6jJtk
         wAlhQHT0ZIg/61bexWrnucEHEmBX7EIbjSsAcIqZm5fFgCcT1IibpoD9yM3IK738Xoss
         gj5nEOURvdMhonX7xtjSVM8gZudgsl2+nkzPRuq0RseeB01VgRjeLam8JTqhuIFFpHY1
         2Fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689196407; x=1691788407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xaEiUWqQ8n4H0ZWB5ZhdTuErYaUCfdenhxdMQwih9nM=;
        b=W4MdX+FLaRRmrQJkwOQv2olQFDFUzqGMUQJeQ1qeWtSU4378ENCFOronyxmrp6vcUg
         aTtS3MEhjhJclDgUsUWEXyNbTZCNZOITvD8Y//Pih2uAp0XXrUtrNcm1h55vwtBMXXJg
         xFTLqU3u0ua3nnn+WYdaxvfpVYAlZ/6qeQbIcwI2AJOoxbPnqhdvv8aO2u3L6hB3CR91
         9BpKx6EV2aDNT+rqe389kKnNjJwHb3HnxYaBf8CzOV/aWqO0QpoPXXYNPGKV9heW1RM+
         azDRPPfBv/yVh6+/idTquuJoRraq3rUT9Ncnh+AU0MIF39ZuiidCDr9hfJu5KHo9sED3
         4bIw==
X-Gm-Message-State: ABy/qLanntvnnSYxvbOX50nlE9tISz5d2KWJVhQk4sk8KefGQwlX6Wh0
	dCb3oKCje20Hc+jfjfgIqHH+y4Tfb0dV4j6vQbo=
X-Google-Smtp-Source: APBJJlHEjrIdLWFSI5k/DRpgW5nYnb+Le8f0E5HmCt6eMoIssH0rClTthSE1kSRv/076PM7CXrB1Gg==
X-Received: by 2002:a05:6870:d0cc:b0:1b4:689b:209f with SMTP id k12-20020a056870d0cc00b001b4689b209fmr14544864oaa.52.1689196407200;
        Wed, 12 Jul 2023 14:13:27 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c1:1622:34af:d3bb:8e9a:95c5])
        by smtp.gmail.com with ESMTPSA id zh27-20020a0568716b9b00b001a663e49523sm2387213oab.36.2023.07.12.14.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 14:13:26 -0700 (PDT)
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
Subject: [PATCH net-next v4 0/5] net: sched: Fixes for classifiers
Date: Wed, 12 Jul 2023 18:13:08 -0300
Message-Id: <20230712211313.545268-1-victor@mojatatu.com>
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

Victor Nogueira (5):
  net: sched: cls_matchall: Undo tcf_bind_filter in case of failure
    after mall_set_parms
  net: sched: cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode
  net: sched: cls_u32: Undo refcount decrement in case update failed
  net: sched: cls_bpf: Undo tcf_bind_filter in case of an error
  net: sched: cls_flower: Undo tcf_bind_filter if fl_set_key fails

 net/sched/cls_bpf.c      | 106 +++++++++++++++++++--------------------
 net/sched/cls_flower.c   | 105 +++++++++++++++++++-------------------
 net/sched/cls_matchall.c |  35 +++++--------
 net/sched/cls_u32.c      |  48 ++++++++++++++----
 4 files changed, 153 insertions(+), 141 deletions(-)

-- 
2.25.1


