Return-Path: <netdev+bounces-15390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9FF747513
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 17:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178F1280EB0
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D81763CB;
	Tue,  4 Jul 2023 15:15:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E527A2C
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 15:15:07 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C900EE6D
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 08:15:06 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1b05d63080cso5797176fac.2
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 08:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688483706; x=1691075706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7MwfusD+WYaHPGP2rD1nSf4RcXGTHesalNFXHmmYxns=;
        b=DTyVMg9FLoIQ/yezkQ/tuFGi2OUqEW94FFOEBaG6GZ+jI0vKKd2LphTjLnhMavpNRj
         cMlqNTakiaCNEYzkMOUgBSJLtEIrhaO2jLww3ofspEcYAYsnRD3POfFvKUqmkwHcadHs
         MoO5YLRddFLgN9JWHYC5p+5sYlDa3kGVqcD8WZp/gjCUGLNcX4G+h78XKXjwi7p3cb21
         gHIsSvNdic5wjYTjQiOAbH5BM1SCSxhEcsUpI1Zety+3Q2TWP47kC24hGy//mG9J6jZj
         WvxmRVYTT55ANOtk2V45BjxJjjax60d2Z/FHRAz3L7NJl48GFzNH3Ge1VZ0SI0kzqG/I
         BvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688483706; x=1691075706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7MwfusD+WYaHPGP2rD1nSf4RcXGTHesalNFXHmmYxns=;
        b=g2kRD1aHa9oPIE/ioe1T3OayR48gW6O9N6UTRBUKXbkbwYVJNcIY0OgCkvVKmbfdkH
         aiYC9kTjkCBJABW/0/NXtvrfQ8voH7QsLOHvnB8o7BZ8hO/CpES6Lpjs2VoBI7xCytcR
         UwPXZXhqgJRkAK0NjXAp7bRCqWUncgc+rlSq9WUKp0cJLl1/zA8Bl4w3y/1h6xKs+0/2
         YA61dxqdq8fyTt+j5k+9tN6Q6g2gv4eGzG0fbfy/V2shaGovCQhsKUz/CGi3cB+1ilc5
         1ULTeQNCm57gaKOmaKG+NZ9Xh4+18NKZOJXODyrg5djzhZtC+FZ3yEP/WK0fxfMblRZI
         15og==
X-Gm-Message-State: AC+VfDwc7giqEwqfm/EK3DkiEIq1lm7Fc6+yanPVj9FeI1kEK1i/1BcW
	rfUhD5dNkVah+Abm/zWr+v4dgYF5V/V8olVGqRQ=
X-Google-Smtp-Source: ACHHUZ522FQ8kEHZ3cVp1ls8kJFfD2HCsiamnyItGHOapRn3/eyHCVTTNCHdnjjUOzmt552Jt2PzNg==
X-Received: by 2002:a05:6870:9d8d:b0:1b0:18cc:d9fb with SMTP id pv13-20020a0568709d8d00b001b018ccd9fbmr16176283oab.24.1688483706003;
        Tue, 04 Jul 2023 08:15:06 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c0:f126:5457:8acf:73e7:5bf2])
        by smtp.gmail.com with ESMTPSA id s1-20020a9d7581000000b006b8abc7a738sm3946146otk.69.2023.07.04.08.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:15:05 -0700 (PDT)
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
	kernel@mojatatu.com
Subject: [PATCH net 0/5] net: sched: Undo tcf_bind_filter in case of errors in set callbacks
Date: Tue,  4 Jul 2023 12:14:51 -0300
Message-Id: <20230704151456.52334-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.40.1
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

Five different classifier (fw, bpf, u32, matchall, and flower) are
calling tcf_bind_filter in their callbacks, but weren't undoing it by
calling tcf_unbind_filter if their was an error after binding.

This patch set fixes all this by calling tcf_unbind_filter in such
cases.

This set also undoes a refcount decrement in cls_u32 when an update
fails under specific conditions which are described in patch #4.

Victor Nogueira (5):
  net: sched: cls_bpf: Undo tcf_bind_filter in case of an error
  net: sched: cls_matchall: Undo tcf_bind_filter in case of failure
    after mall_set_parms
  net: sched: cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode
  net: sched: cls_u32: Undo refcount decrement in case update failed
  net: sched: cls_flower: Undo tcf_bind_filter if fl_set_key fails

 net/sched/cls_bpf.c      |  8 ++++++--
 net/sched/cls_flower.c   | 29 +++++++++++++++++++++++++----
 net/sched/cls_matchall.c |  8 ++++++--
 net/sched/cls_u32.c      | 32 ++++++++++++++++++++++++++------
 4 files changed, 63 insertions(+), 14 deletions(-)

-- 
2.25.1


