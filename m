Return-Path: <netdev+bounces-15543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4773748540
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 15:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04D2280EE7
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 13:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7DCC8FD;
	Wed,  5 Jul 2023 13:43:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D8AD2A
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 13:43:41 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810AABA
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 06:43:40 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b87d505e28so5606072a34.2
        for <netdev@vger.kernel.org>; Wed, 05 Jul 2023 06:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688564619; x=1691156619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ylf2Li3pfzZsL7TCxvWjWxxVqSGG81RTAw3x598Kqks=;
        b=y8jfiJSZ9myuDiZpcz81RawS0ybUIRVm4avbaOo3cqPUDpwU/T7p/NkE3ustAQcUfe
         CA+hsGWwMFUggCRWfUzyerd+8E8b2MaSs4ISioXHYmIRCymGIGwcytmY0CYP68By9t0C
         ERKdyDiJBgg9u3mxO3981P/+8EGjPlgeSh/Abl3OTlbw/ziUcmixW3j14BNqLXsNDIlX
         JdUW+4VOQC9Mnu+u8dxMPPu5WZezsuhN6DngoqUCNdJ9n4cQ4i627lkaFPwGstb5iBQ4
         ngYxYWrOph1DbO5kLcE3iNJyXiy8lmYefOR1EuG/zcH5flarJfix4YxNdFxcAmy38dPF
         7p5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688564619; x=1691156619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ylf2Li3pfzZsL7TCxvWjWxxVqSGG81RTAw3x598Kqks=;
        b=W8Hu3bozzYzjdgCSUs8DR34QSer7aZ+rOBxw/fTtRA82hkOXyS35QFW+NF9M3h1RVg
         AO4/IGlG5qSy5XVKNNw/jrIyIgLH330WpV3gDZmZ+zBRKEqOXhekyg2tyvuboGLiIYCf
         8JPcqMQ5cL65SonElR6Qs2kSxtq0BY1g8eSNjwiyQ1IMrz58cg/OQaWUUYRTb6ev0YOC
         DBwxwrliwXr61sQm/kEoZZyvwUZbD6Dadscx/sBLlhey+vKrjLorUAczlZG8wqmgGjx5
         p9k0JFLLttIsO/5SgDvlXjgHLBh/GWHlR5Z5ZLsA7aDc2esiRlk9YoDq4wWnmMB6md50
         HHXA==
X-Gm-Message-State: AC+VfDwuFTFbHp96axtPVyCJgVIux7M7ZWSYOsYttkt2g8f0bSe3PoX8
	m7YvJxwLHhTU5jIjaObY+ASCi+qDfKA/H5y2H04=
X-Google-Smtp-Source: ACHHUZ5YctW+jzf9qybCmKLQrmKkizw0nE00P08cBu/uPUy5whl1if26om+b39qZ2KLL9Rz8zVeguA==
X-Received: by 2002:a9d:77d0:0:b0:6b8:6c43:12ac with SMTP id w16-20020a9d77d0000000b006b86c4312acmr18550547otl.25.1688564619729;
        Wed, 05 Jul 2023 06:43:39 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c0:f126:5457:8acf:73e7:5bf2])
        by smtp.gmail.com with ESMTPSA id n11-20020a9d740b000000b006b73b6b738esm4516450otk.36.2023.07.05.06.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 06:43:39 -0700 (PDT)
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
Subject: [PATCH net v2 0/5] net: sched: Undo tcf_bind_filter in case of errors in set callbacks
Date: Wed,  5 Jul 2023 10:43:24 -0300
Message-Id: <20230705134329.102345-1-victor@mojatatu.com>
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

v1 -> v2:
* Remove blank line after fixes tag
* Fix reverse xmas tree issues pointed out by Simon

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


