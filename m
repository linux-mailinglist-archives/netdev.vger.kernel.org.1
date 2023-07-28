Return-Path: <netdev+bounces-22332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D89AC7670B7
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9377828278C
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431A214A98;
	Fri, 28 Jul 2023 15:36:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A091401F
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:36:07 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07026B5
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:36:07 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a5ad6087a1so1502953b6e.2
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690558566; x=1691163366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAET9AIuuSytohoQkAuGEwlGHg61B9zRlti8aFOkjnE=;
        b=bu5jAoFWna8XJVFKiq5tIgZtwOfFhcRljVgjxsmKO+8kRANQZs6AgVko9K+aAAeqnm
         2RktRQXrgJD10/DE+3MBootgEyeK8YHEYJGNeR7egBSdurbN+/V777mlV395hpJYKduP
         FQM+CiLS7kiM8aoulN9Wt60mnS36hNPzVo8ZiDmThjb0LW8f3i3EKt3XU80+2qAGZkYE
         gyD+Nf5dKGo8+9RygcgH96v1/ehUz0AY68l2NkaYlT02TcE3flILutLQ5gxpTx7t5SPi
         peKTwSAtgLi1IWyTAxlR2A4hTgO/a4fn2HzLaaGaYU/v330Ocp41o2SbB6BGroeAApDz
         B2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690558566; x=1691163366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAET9AIuuSytohoQkAuGEwlGHg61B9zRlti8aFOkjnE=;
        b=iBmtTesQUJWeNUajvkMgfEIUMBs7hEudRrGR/u5LW93JAymFnIbVJCXt2oSREgcm2h
         mg9TYdBZ2VNZWY0N6pOoBSQtWydkRrmmA/XBTFAVnytVbrOh9iKHiI+P/za9B2sRYEHU
         qkW+ki1BUl4iNAdovOp0foqpdEZGDURchtBW9RZQmuGYKTuqCTXz07jLOv5hPMQEzERL
         fjoJ88+wql37sLVYw8pzkuKvvUxVRazzekgsvtfwiRrJpchgUXFqAf6elQcglT6sybxb
         EKV9ke7asKNBM2LJuPCsc96zNc+wDdn1QxbOz7tOGlgbtTHwvIwnusp9fACZfcDthFv+
         qkVw==
X-Gm-Message-State: ABy/qLa0Mp1qD5uT7d3wwB1Zh3ZP3Jocl8uX0dsszvUfPDZr5HWNlxQ+
	fs7QLScgfnK+jJ2xSUm9muZ8zn04NQGKIL8A4Dk=
X-Google-Smtp-Source: APBJJlE/1xvVOGg+8M3D/XznvK0xbVcDQfzNa9TRXc/GRvZ7BpebtitUSfoNh0Yhrtx3E3pxUXZS2g==
X-Received: by 2002:a05:6808:1893:b0:3a3:63b8:fdc7 with SMTP id bi19-20020a056808189300b003a363b8fdc7mr3564077oib.38.1690558566249;
        Fri, 28 Jul 2023 08:36:06 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:81ef:7444:5901:c19d])
        by smtp.gmail.com with ESMTPSA id u8-20020a544388000000b003a3b321712fsm1732893oiv.35.2023.07.28.08.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:36:06 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/5] net/sched: sch_qfq: warn about class in use while deleting
Date: Fri, 28 Jul 2023 12:35:37 -0300
Message-Id: <20230728153537.1865379-6-pctammela@mojatatu.com>
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
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add extack to warn that delete was rejected because
the class is still in use

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/sch_qfq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 7addc15f01b5..1a25752f1a9a 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -543,8 +543,10 @@ static int qfq_delete_class(struct Qdisc *sch, unsigned long arg,
 	struct qfq_sched *q = qdisc_priv(sch);
 	struct qfq_class *cl = (struct qfq_class *)arg;
 
-	if (qdisc_class_in_use(&cl->common))
+	if (qdisc_class_in_use(&cl->common)) {
+		NL_SET_ERR_MSG_MOD(extack, "QFQ class in use");
 		return -EBUSY;
+	}
 
 	sch_tree_lock(sch);
 
-- 
2.39.2


