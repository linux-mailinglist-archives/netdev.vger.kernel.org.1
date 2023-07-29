Return-Path: <netdev+bounces-22544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7A1767F24
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 14:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34831C20AD0
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 12:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C171114AB3;
	Sat, 29 Jul 2023 12:32:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49431427B
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 12:32:22 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FB22D71
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 05:32:21 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-63d2b7d77bfso19756296d6.3
        for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 05:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690633940; x=1691238740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fmBp9ctR8ra9oQO2YYHgfUhrcTHKclK64by0BHsqrsA=;
        b=gPgmFYvTulOpYUa37Eoq731+yVVqpupKHra4Tu5N4eQ2nHqoPcs+uBN1GsOnSvDx3z
         1B81Rkx25fue9FPlTm21a0sDTgNAKqE/Xy2Oi7d4B6lg1Zvl2/jYoQgZbwJnlY8k4Wn5
         TygKGxiKak898xewRTHSHf0m9sd2A3HbE5V7Fj7HIV5Zjd+/ELBx9JvOVs0s7etYssWr
         l9JrNU3q0o0+4VIBzvZIxmFCmuVecLblY3fBPU4Rn1S0SwUBKo4/gmLx3Bgm4/4fI8Rn
         E+6FE3+G4w0TdWqxlXz7kv12KAif9FVvn/7fLqixb7rr61icmVZBPOqMUT52mwnC1psZ
         9rhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690633940; x=1691238740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmBp9ctR8ra9oQO2YYHgfUhrcTHKclK64by0BHsqrsA=;
        b=jGLcuLcH6f49ZtGua7tz+KLOPbrenFB7X2f8hsooXtas9V8WUp3sgEJfOoFiKZDzuf
         EJ+eZB2nas7QaJLKpIH0FtcGV8sU9VmgTmjUL39oSgMzVaS7Iy+XzvlfNxejurnI/wrR
         kuwwVhoN0XlRd4KcuGgLuLntBYHXdbNV5GMDdJK56B6dM+BdnQ9A4Y33jYCctuMnsfXi
         8rt5zG4KEUw2UZPZmMWKol5vV07/3z7Qu50y9pGkbqbAc+StsTjuk0BneXja38TBS4Dj
         GRpzFGRg7Jvr0R7Ioem7zhMPQCV2g74hXamhCaeJabTxRD3jULwYpbP0M3dF04vFSGY9
         DrHA==
X-Gm-Message-State: ABy/qLazNRkoKti0WTCRSFS18k9WHfQ30VzdgS9cB3z9uYMLEkiIXU0j
	FAvNMtFEDRGTWQBsGphSvjr0EpOv0sdnLynJof8I9w==
X-Google-Smtp-Source: APBJJlEqU4/a+xDwuBZd4xNsdZLzj75/B+SmeB2xXB/1GlzD6vEQg6J4hi04sHT6BrmZwOod4+7BzA==
X-Received: by 2002:a0c:b389:0:b0:63c:f999:ba83 with SMTP id t9-20020a0cb389000000b0063cf999ba83mr4204996qve.32.1690633940475;
        Sat, 29 Jul 2023 05:32:20 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id x12-20020a0ce0cc000000b006263c531f61sm2024716qvk.24.2023.07.29.05.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 05:32:19 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	sec@valis.email,
	ramdhan@starlabs.sg,
	billy@starlabs.sg
Subject: [PATCH net v2 0/3] net/sched Bind logic fixes for cls_fw, cls_u32 and cls_route
Date: Sat, 29 Jul 2023 08:31:59 -0400
Message-Id: <20230729123202.72406-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

From: valis <sec@valis.email>

Three classifiers (cls_fw, cls_u32 and cls_route) always copy
tcf_result struct into the new instance of the filter on update.

This causes a problem when updating a filter bound to a class,
as tcf_unbind_filter() is always called on the old instance in the
success path, decreasing filter_cnt of the still referenced class
and allowing it to be deleted, leading to a use-after-free.

This patch set fixes this issue in all affected classifiers by no longer
copying the tcf_result struct from the old filter.

v1 -> v2:
   - Resubmission and SOB by Jamal

valis (3):
  net/sched: cls_u32: No longer copy tcf_result on update to avoid
    use-after-free
  net/sched: cls_fw: No longer copy tcf_result on update to avoid
    use-after-free
  net/sched: cls_route: No longer copy tcf_result on update to avoid
    use-after-free

 net/sched/cls_fw.c    | 1 -
 net/sched/cls_route.c | 1 -
 net/sched/cls_u32.c   | 1 -
 3 files changed, 3 deletions(-)

--
2.34.1

