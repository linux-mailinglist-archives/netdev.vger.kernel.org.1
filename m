Return-Path: <netdev+bounces-22327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721FC7670A2
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA471C218FA
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6C514019;
	Fri, 28 Jul 2023 15:35:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE2213FFD
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:35:54 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12795B5
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:35:53 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a3b7fafd61so1787889b6e.2
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690558552; x=1691163352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ngs5K8Ybs/hyrIKdY9VR4PcKilZb3fvdVlW8q/xkmUw=;
        b=HvVhecODGKfafsM+U5LzQj25l46OMGc8iaBYmRJ4U52/v+qTLDIE6Z7lttTPOlOgRB
         iEYCAAbqSTzV9qNyQiLKulmNGvQ7KJAr0fqB4cR/oTLG2kuQtUP42OXmodh+J/F8Ukji
         E/njRDO1oljcvNvFc2/S/xn1h9QrTHDKKSAFabpZMJsf2BfvX0b1QxEme+3m3pcgFhul
         Y6edu7Vf1jpyB8jfM3hAnlUMVtQgVwIKHtHmhVLnCuhIKOzoo0cbybxW9vTZ8iBC2ePE
         zXizSGahM99x+KgTojyCaRE/jLt0pU8NDQ5wK5FHZzxa7oeqcuzHDMC32oV+jOMg9hbH
         T2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690558552; x=1691163352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngs5K8Ybs/hyrIKdY9VR4PcKilZb3fvdVlW8q/xkmUw=;
        b=FCUTnExXq4I/sd23/yp+8+L+ZYroFKNYOgaafqy5Y26vcaqcy9JzMTXZgsQEEhTDC2
         oAH0nY2z0d21NWoPWyOdDtJiQXbUze+AWGnTTfDmUxHj1aht/h9DEVQqwqCnnGKLMnA7
         xvwS4G0TyUZzfrGuIfWtzUKbA9leqm4rDBNAZNuQsNR4oWKrXSdQ2o08LR1Ac9yCHYRf
         I77+xyaxbhaa58SHWGwWyOGfsW/xIxv1Y9WsIi77TcAkjeCYdwa2uEiD2MMmtV+cDI+j
         myDG5Y8pmHLMuuWQRjut7tjtI8vv1Hi5bBr+WHLJIpBBOzzlkq7GQclEQnWUUnxS2VOO
         RMuw==
X-Gm-Message-State: ABy/qLZjj3LUL3OeUk7n+vN+XrXjtpY+8KDJSSN7PMVpuJkgoBCu+wbz
	3U5a1dSG+tbcJY6XX1p2t5/2ly0KW99RfCcvh+0=
X-Google-Smtp-Source: APBJJlFvBvxYGGtMDnfPWHMSdffJDzcCFgkzPusteOZc/OAsJ5ttuAIj6Y90XBlxd36XI1SINlMdAg==
X-Received: by 2002:a05:6808:15a1:b0:3a1:eb15:5ec4 with SMTP id t33-20020a05680815a100b003a1eb155ec4mr3471480oiw.42.1690558552289;
        Fri, 28 Jul 2023 08:35:52 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:81ef:7444:5901:c19d])
        by smtp.gmail.com with ESMTPSA id u8-20020a544388000000b003a3b321712fsm1732893oiv.35.2023.07.28.08.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:35:51 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/5] net/sched: improve class lifetime handling
Date: Fri, 28 Jul 2023 12:35:32 -0300
Message-Id: <20230728153537.1865379-1-pctammela@mojatatu.com>
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

v1 -> v2:
   - Add ack tag from Jamal
   - Move definitions to sch_generic.h as suggested by Cong

Pedro Tammela (5):
  net/sched: wrap open coded Qdics class filter counter
  net/sched: sch_drr: warn about class in use while deleting
  net/sched: sch_hfsc: warn about class in use while deleting
  net/sched: sch_htb: warn about class in use while deleting
  net/sched: sch_qfq: warn about class in use while deleting

 include/net/sch_generic.h | 26 ++++++++++++++++++++++++++
 net/sched/sch_drr.c       | 11 ++++++-----
 net/sched/sch_hfsc.c      | 10 ++++++----
 net/sched/sch_htb.c       | 10 +++++-----
 net/sched/sch_qfq.c       | 12 ++++++------
 5 files changed, 49 insertions(+), 20 deletions(-)

-- 
2.39.2


