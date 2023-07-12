Return-Path: <netdev+bounces-17310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E73751275
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 23:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0346B281842
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 21:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2A0F9D3;
	Wed, 12 Jul 2023 21:14:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F33F9C7
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 21:14:09 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0943B3C30
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:13:43 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-566e793e0a0so57545eaf.2
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689196417; x=1691788417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygoaKbk2Z0CZl3YcpJ29CpaGAc12nXiauBZqZieAcEs=;
        b=sr906EK0fQ4QX9bMGaTnI/Tn8XXRqr3as9eyScmmNE8zyHmI8YgIL4FWN2UL2+Ubp0
         nWEFyX+f5bxA3nsbSueIM4jk2YhkitFOsKJrGts1w6MFaMsrIHPOeqMGGOozxr+BRjB+
         aMEPRE2w/qT5+wPBCPC2axK61AlxDBmM/0KM00YxcVILKMiQzVV1y2zIxi5n0nHVK28R
         41uPCs+DVikvP5W9x99JeAEpzCmQ06yJEt9SrR7+3W3u08TGzy/GhYTBNCMXooFrBgOh
         LZmqmUqxsTHYQuHinYbxtO0E/I4mhgJl4fYrgMQAE8Z2M7nO58YBKMatS9Z9pM40y7Rs
         CbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689196417; x=1691788417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygoaKbk2Z0CZl3YcpJ29CpaGAc12nXiauBZqZieAcEs=;
        b=Uc67JQ0xXvzNXbk6xohTFgF09pkumioYxx6P3DKZsi/ArFQbDI45hxLlLgc6kZX0Nx
         GHudOFlTw0Sic0KLhXPyixw1XJPCNSWzYj5xp2slLoAvML4WG6aeddqhjEZVdS6TGPWb
         JqwuFHDqU7EypET3GHqSHbEbWRL61nwnwRicUMduo+QRLiXFNEVgSjh6WVfoar8K5OJ1
         OLv7FdIPhsfyRAb4kZ+unvV9KU9462VJXqz4CC11zBqTCFUGnKnUgCs2i1gNFsOL+YYm
         2z/RL90XEyLFVwSztTwUVBLJV8bM8qDr8yT0eW0rRdzPy2s9Z9DjzmlvQXFL8e4wAZmH
         d42w==
X-Gm-Message-State: ABy/qLbrDLn1FrSvyvEiBq+gmp0oXnoOxRx3fz02EvwEaBrf/q7vm0tt
	+zwH/PNL42K8eve9A7LKuWHUBhdbMazlkio06rs=
X-Google-Smtp-Source: APBJJlEmDfKsGr7XciKVchAZdo4XHEvHjNQ5LgtmYtwN6fog30zCGpfPEbq8gqCcGvjMq3UFKY5EMg==
X-Received: by 2002:a05:6870:e0d3:b0:1b0:2d25:f5a8 with SMTP id a19-20020a056870e0d300b001b02d25f5a8mr22879729oab.1.1689196417085;
        Wed, 12 Jul 2023 14:13:37 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c1:1622:34af:d3bb:8e9a:95c5])
        by smtp.gmail.com with ESMTPSA id zh27-20020a0568716b9b00b001a663e49523sm2387213oab.36.2023.07.12.14.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 14:13:36 -0700 (PDT)
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
Subject: [PATCH net-next v4 3/5] net: sched: cls_u32: Undo refcount decrement in case update failed
Date: Wed, 12 Jul 2023 18:13:11 -0300
Message-Id: <20230712211313.545268-4-victor@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712211313.545268-1-victor@mojatatu.com>
References: <20230712211313.545268-1-victor@mojatatu.com>
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

In the case of an update, when TCA_U32_LINK is set, u32_set_parms will
decrement the refcount of the ht_down (struct tc_u_hnode) pointer
present in the older u32 filter which we are replacing. However, if
u32_replace_hw_knode errors out, the update command fails and that
ht_down pointer continues decremented. To fix that, when
u32_replace_hw_knode fails, check if ht_down's refcount was decremented
and undo the decrement.

Fixes: d34e3e181395 ("net: cls_u32: Add support for skip-sw flag to tc u32 classifier.")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/cls_u32.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index ed358466d042..5abf31e432ca 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -928,6 +928,13 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		if (err) {
 			u32_unbind_filter(tp, new, tb);
 
+			if (tb[TCA_U32_LINK]) {
+				struct tc_u_hnode *ht_old;
+
+				ht_old = rtnl_dereference(n->ht_down);
+				if (ht_old)
+					ht_old->refcnt++;
+			}
 			__u32_destroy_key(new);
 			return err;
 		}
-- 
2.25.1


