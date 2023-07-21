Return-Path: <netdev+bounces-19992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AA575D3D0
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 21:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D4E1C21748
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 19:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F73120FA8;
	Fri, 21 Jul 2023 19:14:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840AA200AE
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 19:14:14 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A752B1FD7
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:14:13 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b9c434fe75so1903243a34.0
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689966853; x=1690571653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VM9Q7cyesLc2si0UbKxQInSjwZDdILQ9aJMI0MBwtZM=;
        b=OR5uFZYXX7QsaqbE/k5GOR2lYl2Amm0ZAoJFsKMpV/kdYj3dEbGUakP91HkVP+cURx
         kpjfJA4sCr3ojyGjalvxKhVSGvSWG3PDj0aQ+xxzSoja1OtHGEtm4BBIoD28X7fYXZDk
         ECWW8+UnWIMRkm600AgGYlfB4MwmHlvQkL/pSJ3r2cwlwouixGdO5Yozi9gSem7g2A2P
         /HsKXComCkQO93482yXzwnMUhjxz7ZzNJq7zcW+bqllsHtfdAMQQZOlNZ7szlrJIiVkY
         LNc9MI8WEt9SqjWx+Ny942HaAj7R944FOE5ZEtW7sOfEZCj8gDKdt9r6VE+DWSswhfog
         gxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689966853; x=1690571653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VM9Q7cyesLc2si0UbKxQInSjwZDdILQ9aJMI0MBwtZM=;
        b=bXDKUQ4v3bZXgd8ZN2cHE/oaF3zEjDuJE1lRgIFWCC59csU2yQoB1U1tJpFLkKXWkv
         BQagUxNlYSaMbqk4N00Mus8dcz3q9TQfIzAkvV9/a3i2woPNzzM5QHYLIVW6oESrdyKN
         7Pib5AR54lvlrc8/DjCP4tBYjnceRsOqFiZAGPujqGwDruMU9hOaXl54AGZjh+c7uMrx
         6x7e7WIx06GfSbWWsYdXqDWItqGfjvZpGcP1ZcGlp+FfhpVq0jZ3+IZVspBlWCj2oqZD
         jj+IQEvp8vAz6nO/F2wmbQ71R/MvMk63t2+djFgx2eCzW78390iw3Tx3XhbXIueYLn2c
         HqEA==
X-Gm-Message-State: ABy/qLbow145byYo5A3Qnx6mJD6NJb3ee92bhSaVgAvh7nMBAuvWiK+I
	GIijI8whURW0EtuhtHlcbjd5QJPQyODUwjuOZbk=
X-Google-Smtp-Source: APBJJlFE7mbP98JQhXRMiUgB40PMkXDf7lGLCNx1r8cBhb5iAe2pE1rQYbYxc1znNn/oZpfBI8a4Dg==
X-Received: by 2002:a05:6870:b509:b0:1b7:3cd6:5c5d with SMTP id v9-20020a056870b50900b001b73cd65c5dmr3227265oap.26.1689966852911;
        Fri, 21 Jul 2023 12:14:12 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:2414:7bdd:b686:c769])
        by smtp.gmail.com with ESMTPSA id e3-20020a056870944300b001b04434d934sm1813731oal.34.2023.07.21.12.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:14:12 -0700 (PDT)
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
Subject: [PATCH net-next 2/5] net/sched: sch_drr: warn about class in use while deleting
Date: Fri, 21 Jul 2023 16:13:29 -0300
Message-Id: <20230721191332.1424997-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721191332.1424997-1-pctammela@mojatatu.com>
References: <20230721191332.1424997-1-pctammela@mojatatu.com>
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

Add extack to warn that delete was rejected because
the class is still in use

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/sch_drr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 0bffa01c61bb..32165c8a3bd9 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -150,8 +150,10 @@ static int drr_delete_class(struct Qdisc *sch, unsigned long arg,
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


