Return-Path: <netdev+bounces-22329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416B97670AE
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7206D1C21929
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3F91427D;
	Fri, 28 Jul 2023 15:35:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04AA14268
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:35:59 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A55B5
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:35:58 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-565db4666d7so1571595eaf.0
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690558558; x=1691163358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNuNpQZuFjNXy4RfY928yv7WL3BURqXGLN3Mv2kKb3E=;
        b=zYiTJKW1rmUw8aaIJ4R+lAXHknrv5DB1zIjvIhoqFiKcZUIn8TBwRK7Veq3+x5Z8+Z
         Vd54YRCOGkuTkXkRcTQsqTz9C2YOgZd3kAj1s94tTofi7Z5jqLcb42c7d0M8jdKlQkhu
         p+aAU3Rixg7OD2tw3QVWJ3UjBeS9MfoQaCgD6b2X06WkqsaUPPdoM8oqGpuOyrlPYJij
         n5UvkDJ/cZB7Ak3WKnVaJQUBMT1idqk9i+cIETPUg9bQvflCTUL9NzYa0f2z3V6ThpKO
         3M8koISWse+rr6x5VcsCMlGZfWX6romPuijUEKkUU9qdTpI+XZ1aEIqGNFYID5UkeJvg
         a46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690558558; x=1691163358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNuNpQZuFjNXy4RfY928yv7WL3BURqXGLN3Mv2kKb3E=;
        b=Z2QyLhSHCOOk8FD9+zzgzDGAzLvhZsUISn+rdt5BQv1jdsO4M21T5C0fsfOHF6ur2e
         JbELV02CX7UzTHPDXgnxCWXaGWDPgYHInxeT+ocNRW6lEAUZG3maNMwYlVd+AUAECPWT
         mTu4UMQ34MRvfV9y1OdFOzWlmARMWfob4m7RiMBMsbd2qH2e4DDaXMmqONGKQdN3KUHW
         AP3bFQUfO1C7wV0H8J5bswxZvV4OYnH29QALbSBi/PhOtsjKsNRQFtpi1YJrAHVU/pea
         /J1Hw+jrY20AigONTbD1X24zodu5iUrE3Pq5n59xUDj9xq7Z6Z19kBjRMUGu2jF0gnGX
         sGVQ==
X-Gm-Message-State: ABy/qLZiDvMrW3m46ZOL1WRMvFu+6vdcy9MhkrOGsdlrPO5yLeT0zm4y
	tQWZvAvm5Gn1loK2ZKGK3M1SdOdLlnwwYpdpvDY=
X-Google-Smtp-Source: APBJJlE7XubeWkvLXb+bBjo2VzBt4crGCSVwyYiopZYW0aSPO7uFz0WKz+PLuIHQWkCnxn37SVT2JQ==
X-Received: by 2002:a05:6808:14cf:b0:3a3:fbf0:37db with SMTP id f15-20020a05680814cf00b003a3fbf037dbmr3633937oiw.59.1690558557774;
        Fri, 28 Jul 2023 08:35:57 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:81ef:7444:5901:c19d])
        by smtp.gmail.com with ESMTPSA id u8-20020a544388000000b003a3b321712fsm1732893oiv.35.2023.07.28.08.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:35:57 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/5] net/sched: sch_drr: warn about class in use while deleting
Date: Fri, 28 Jul 2023 12:35:34 -0300
Message-Id: <20230728153537.1865379-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728153537.1865379-1-pctammela@mojatatu.com>
References: <20230728153537.1865379-1-pctammela@mojatatu.com>
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

Add extack to warn that delete was rejected because
the class is still in use

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/sch_drr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 1b22b3b741c9..19901e77cd3b 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -149,8 +149,10 @@ static int drr_delete_class(struct Qdisc *sch, unsigned long arg,
 	struct drr_sched *q = qdisc_priv(sch);
 	struct drr_class *cl = (struct drr_class *)arg;
 
-	if (qdisc_class_in_use(&cl->common))
+	if (qdisc_class_in_use(&cl->common)) {
+		NL_SET_ERR_MSG(extack, "DRR class is in use");
 		return -EBUSY;
+	}
 
 	sch_tree_lock(sch);
 
-- 
2.39.2


