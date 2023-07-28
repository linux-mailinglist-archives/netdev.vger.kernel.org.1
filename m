Return-Path: <netdev+bounces-22331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EB17670B5
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B38B2827AB
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CB51401E;
	Fri, 28 Jul 2023 15:36:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9B914A86
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:36:05 +0000 (UTC)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EB1E4F
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:36:04 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-563531a3ad2so1623912eaf.3
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690558563; x=1691163363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iO4gG3RNXbc8CK10QgS8sY57Q/Zq1jk/6wJgK1vauZM=;
        b=zxL11t5Ms8co4jDxcS+qcQcljRmtd754G6R52wpIRjUeHLBwxy3FAISZKpUjMxfAIJ
         9yFOH3Z6o9yL1xCZNjtptBTR/v4v7sW1Wkzl4xRevvs7e7X3+EZap9Antqd+ti3caV2a
         0CXilq8fKS17HBxg9tzDvCw0xUbctSk97qlD1or2fx0bRl/BGBpMCIC0m5N34vHMkEQr
         gdxE7gtzZnn9aLAFj96p5iJJS9ppRsEo/L5nbyz2gpddxPwOvK18n0m6RAi5GgzA9EtZ
         iucmK55g1BfoIhujW+nybxX+JKzEYLo6BwDzLiOF4P1SmaA8bA7CMhlW9Evw/WUthbXd
         OGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690558563; x=1691163363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iO4gG3RNXbc8CK10QgS8sY57Q/Zq1jk/6wJgK1vauZM=;
        b=BGGZYckPVWIYFXYEMxeEQ3jj8K3nsaxpWRCGA3DW0HYKd+GpiWjWaYl277LFnVdI16
         d+ejrSVIijqMv4Ar25ecYmZnxXpmq6uxSSmL+c9yzgXHhlBTYa5wlnG6htaKdD3oVm/W
         sc6t/m4G940t8r6G/lelTYz4MjvM+irl7GXw1ss555sFYYuwuqazYOLMjOT/fnJpkYY2
         Sd1qPVRq9nh7yCwpRCfe2CEBDiuuZJkLOmSQB6+dsXajMsGYtG+xhfEGqcxEuVHA+VMh
         vGWTIhOiN+vk5KLu9d/4cXu04lJmruHG9z3PqibuPle3E3keZ8hpru1zJjfqGf4/0H+a
         wDeg==
X-Gm-Message-State: ABy/qLalD/WHXB7KPVNxigXzEdPnTaKxoUByq9MU7HBb63x43wezWHxE
	Rmt657OPafcPeT/D0/6ZKd2hrG5VeR4+o8LwR2A=
X-Google-Smtp-Source: APBJJlF2WKJGlO2oexifgnK+drVCLkjQBiLAQ9GA1Sfn6cdmoX+8MqEcpBnhlP/NF4JWueuEEM8mMw==
X-Received: by 2002:a54:448d:0:b0:3a4:232c:5d7e with SMTP id v13-20020a54448d000000b003a4232c5d7emr3760203oiv.5.1690558563439;
        Fri, 28 Jul 2023 08:36:03 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:81ef:7444:5901:c19d])
        by smtp.gmail.com with ESMTPSA id u8-20020a544388000000b003a3b321712fsm1732893oiv.35.2023.07.28.08.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:36:03 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/5] net/sched: sch_htb: warn about class in use while deleting
Date: Fri, 28 Jul 2023 12:35:36 -0300
Message-Id: <20230728153537.1865379-5-pctammela@mojatatu.com>
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
 net/sched/sch_htb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 05c8291865ae..0d947414e616 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1709,8 +1709,10 @@ static int htb_delete(struct Qdisc *sch, unsigned long arg,
 	 * tc subsys guarantee us that in htb_destroy it holds no class
 	 * refs so that we can remove children safely there ?
 	 */
-	if (cl->children || qdisc_class_in_use(&cl->common))
+	if (cl->children || qdisc_class_in_use(&cl->common)) {
+		NL_SET_ERR_MSG(extack, "HTB class in use");
 		return -EBUSY;
+	}
 
 	if (!cl->level && htb_parent_last_child(cl))
 		last_child = 1;
-- 
2.39.2


