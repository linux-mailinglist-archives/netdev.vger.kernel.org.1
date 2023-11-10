Return-Path: <netdev+bounces-47154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF717E853D
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 22:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CA51C20B02
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 21:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD273C6A0;
	Fri, 10 Nov 2023 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="mIlwY7kY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FDC3D384
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 21:46:37 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3684205
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 13:46:36 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6d33298f8fdso1333819a34.1
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 13:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1699652795; x=1700257595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLe3lb2hGG6BKY8VKxjXOdMwIHzjt2Xzi/SZMN4U9pQ=;
        b=mIlwY7kY40voni0XCKsCZfCSmoVasPEyO6OLBk86v0DnfaBs8XC/jbfNibO+50a1tk
         OH5QFW2cD0G3/2NByfOn+o+vi6SclP9eCR73JP3M9FeVx4EqiIqi/JS4QR+dI9xQUXtd
         UJoZF7BGRRZKkO6OeLzS5BJMNJrCXZFdLTg6PpZ6U8+oqG9n3wu2v6ChG6w5gYQBj7Zy
         F/V3CEapUzxz9t7mU2SnegWiyayFHviAXSzgJCcjeLia08lp4JQ5Ba9omz7TbM1i2GDc
         6sw7uaTC0FmobfUXuuU/86rI1jJFWZ7gdTA20Mbwj8jL73oMhxiDPrr6fqyo9OYdBWIm
         cv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699652795; x=1700257595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLe3lb2hGG6BKY8VKxjXOdMwIHzjt2Xzi/SZMN4U9pQ=;
        b=O5BHpXRxTGRZq+ml+XWiG99ax3yIw+0BKGHizlU2Xm2YDUZIGvtxg80P51qDIV3gft
         H/DNK2y6GGHdQCe1zBsgCai59+4wIeqhE/J3HLTfp0yNzB+H38wglgl0zDF9/uNP+r0Z
         PTASd6d3yJBE44rnpKN3Ha1UMyWDS/1sn9LN4gVU5bEKJOuhCTJFw1zG0vvYY1g0DBAF
         x0bavaNCsXwY4xObE4uV2wlr66ruRPzFUvU0WboTsGGDQFzyR6nNK8XvL142q+yPGPyt
         xVL+RvnBSP7BkR6dxaDO1Vk9QsK5IBL7v9BkSlQEnirrIdiFQfemfNZR+A3u3vInvytm
         Osfw==
X-Gm-Message-State: AOJu0YwQaZnUEYZ0u4NJrfU19hCZ3TNUJ4mrEqPUeYd1te8PQN9+hBSh
	aV/0tAYV+WFWr3NEa7Cvh9EOaA==
X-Google-Smtp-Source: AGHT+IFfRjqFbhxMzqjNmYZKKCw1hXtiZvt192jOO4FRp+wRuWgKSOzDirk15CUzpjLua1NclYerhg==
X-Received: by 2002:a05:6870:9f84:b0:1ea:cdcb:5a2b with SMTP id xm4-20020a0568709f8400b001eacdcb5a2bmr475306oab.54.1699652795754;
        Fri, 10 Nov 2023 13:46:35 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c3:6a74:a464:c4ff:7a79:ee97])
        by smtp.gmail.com with ESMTPSA id d13-20020a056a00244d00b006b90f1706f1sm166343pfj.134.2023.11.10.13.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 13:46:35 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Cc: mleitner@redhat.com,
	vladbu@nvidia.com,
	paulb@nvidia.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next RFC v5 3/4] net/sched: cls_api: Expose tc block to the datapath
Date: Fri, 10 Nov 2023 18:46:17 -0300
Message-ID: <20231110214618.1883611-4-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231110214618.1883611-1-victor@mojatatu.com>
References: <20231110214618.1883611-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The datapath can now find the block of the port in which the packet arrived
at.

In the next patch we show a simple action(blockcast) that multicasts to all
ports except for the port in which the packet arrived on.

Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 include/net/sch_generic.h | 2 ++
 net/sched/cls_api.c       | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index cefca55dd4f9..479bc195bb0f 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -487,6 +487,8 @@ struct tcf_block {
 	struct mutex proto_destroy_lock; /* Lock for proto_destroy hashtable. */
 };
 
+struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index);
+
 static inline bool lockdep_tcf_chain_is_locked(struct tcf_chain *chain)
 {
 	return lockdep_is_held(&chain->filter_chain_lock);
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 42f760ab7e43..e7015c2dbbbb 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1012,12 +1012,13 @@ static struct tcf_block *tcf_block_create(struct net *net, struct Qdisc *q,
 	return block;
 }
 
-static struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index)
+struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index)
 {
 	struct tcf_net *tn = net_generic(net, tcf_net_id);
 
 	return idr_find(&tn->idr, block_index);
 }
+EXPORT_SYMBOL(tcf_block_lookup);
 
 static struct tcf_block *tcf_block_refcnt_get(struct net *net, u32 block_index)
 {
-- 
2.25.1


