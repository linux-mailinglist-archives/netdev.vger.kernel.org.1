Return-Path: <netdev+bounces-19990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D930C75D3BF
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 21:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B958281DDC
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 19:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB011F956;
	Fri, 21 Jul 2023 19:14:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232F20F98
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 19:14:08 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648B530E3
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:14:07 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1b06da65bdbso1736799fac.1
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689966846; x=1690571646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YaSaprQllttTvLA4XkvwDxuCrBR+wVGj6wOAhoUY2Xo=;
        b=mBUqc0zylIQU7wkMJREKkSiEiIIpU2kqZenWucIaeJaIPvxfwZHEsbs/r0BTeJBd4P
         qq5lUe3IbzTov4Ln3/+FuEQ5aM45lLgP2RXku0BZca/vxOGGDP8jt+vHaw/16mELrijO
         i+ZnhzpXPslSKMy9mFTSXDRSWtfsRwBK+Y9cZY9ivEcFJTJi86ujhztNW57I3MbANQof
         DNaflW6Oq0z5nsaApvD/E14pbpFpusVieVKVGDNDw7QUJ+f/NovDMQdFZNFrINGSq25/
         SwjumWCnfXu1S/OpHXJv/Qm/tfvUSjdpt/78MLCwdpeh1o35cWYdpvR5UpAhE+M4Ztvy
         B5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689966846; x=1690571646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YaSaprQllttTvLA4XkvwDxuCrBR+wVGj6wOAhoUY2Xo=;
        b=VCqZrVVyeYF67e4sW2DPh6El1AwyxRLf/+PcuOW/QZOcFDk9H9ReAS++l55RWxGHmJ
         hL3XMpDkKnHOXDhi/CGcpYJKBIp/6+VEdxJmppbnZ0xfMrjTJWfXk+Ym2Tj5fdO6lYN7
         LZ6Z9jjyCNXdD90yM/q5Xi/lUxsaGA72ZVJtV2HsE53v9QCupjpppfvZh3/PMWr6gfkx
         eq1qA2p0UwnB3xyFR9GHFBDB3ropgjUc+DsiYoPysA9rmDnpPut5cUkg5dr8yTR/p4vX
         6rFUwVrixx0xyvipq5tUm7LTy4YxXrNYbHoHH3Xzgbpu5zL012n8scG/ETApCEM/pkSl
         X4eQ==
X-Gm-Message-State: ABy/qLY6qks7V7Muab2NLzerAaggCvgmt9RwF5KXCslb7jSguAnqEf8b
	1atMttZ6R/bgpmwzvhTdseEqPhIuz8j18QhQ//c=
X-Google-Smtp-Source: APBJJlHeN2DYmDs5y6BTOuBxVgQRboGTINpelDN72SQBIeN+ywr7hnvVgxxvlGKcIq20Belc83yftA==
X-Received: by 2002:a05:6870:8289:b0:1ac:dabb:f743 with SMTP id q9-20020a056870828900b001acdabbf743mr3147864oae.25.1689966846503;
        Fri, 21 Jul 2023 12:14:06 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:2414:7bdd:b686:c769])
        by smtp.gmail.com with ESMTPSA id e3-20020a056870944300b001b04434d934sm1813731oal.34.2023.07.21.12.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:14:06 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 0/5]  net/sched: improve class lifetime handling
Date: Fri, 21 Jul 2023 16:13:27 -0300
Message-Id: <20230721191332.1424997-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
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

Valis says[0]:
============
Three classifiers (cls_fw, cls_u32 and cls_route) always copy
tcf_result struct into the new instance of the filter on update.

This causes a problem when updating a filter bound to a class,
as tcf_unbind_filter() is always called on the old instance in the
success path, decreasing filter_cnt of the still referenced class
and allowing it to be deleted, leading to a use-after-free.
============

Turns out these could have been spotted easily with proper warnings.
Improve the current class lifetime with wrappers that check for
overflow/underflow.

While at it add an extack for when a class in use is deleted.

[0] https://lore.kernel.org/all/20230721174856.3045-1-sec@valis.email/


Pedro Tammela (5):
  net/sched: wrap open coded Qdics class filter counter
  net/sched: sch_drr: warn about class in use while deleting
  net/sched: sch_hfsc: warn about class in use while deleting
  net/sched: sch_htb: warn about class in use while deleting
  net/sched: sch_qfq: warn about class in use while deleting

 include/net/sch_generic.h |  1 +
 include/net/tc_class.h    | 33 +++++++++++++++++++++++++++++++++
 net/sched/sch_drr.c       | 12 +++++++-----
 net/sched/sch_hfsc.c      | 11 +++++++----
 net/sched/sch_htb.c       | 11 ++++++-----
 net/sched/sch_qfq.c       | 11 ++++++-----
 6 files changed, 60 insertions(+), 19 deletions(-)
 create mode 100644 include/net/tc_class.h

-- 
2.39.2


