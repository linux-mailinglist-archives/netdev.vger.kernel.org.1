Return-Path: <netdev+bounces-22330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD1A7670B2
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B8F2827C7
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E5C14290;
	Fri, 28 Jul 2023 15:36:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D44C14268
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:36:02 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B85DE4F
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:36:01 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a1d9b64837so1810494b6e.0
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690558560; x=1691163360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIamuhhg5Mo4/lvYDmdnWkqTyyPCd0CWOrZsKWqJUdQ=;
        b=q4J7lr9cSgYE/yNTxv203Q29zFoXQugTSczGcFjVW9uj1T3khbo01KWGELIz2uTSVV
         0xRgTpp+XoQwza0HO+BBZHq6hQjZBtN09DqxU0DT7qtUOQFDv2NdF+THqrH+3316qxSR
         tPG5/CNxW4/55UoRqzvoxa/JzdCyj4SExKTT7iPpLzaLfHidzP7kulu0fTB3zDJKhJad
         w+bwzl3IWNQf9AoK/LH/9aArTvNVmCk6O571wWdCuuWnGY3nN1VBWLFb7htY7AxWWn7d
         B4FdmPHjOEwIhm2G43H+MvWQLe3N/3L+J6JbwVUYPAmVpBfBWdAyjDVRvzBC+uRYCy7S
         nncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690558560; x=1691163360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIamuhhg5Mo4/lvYDmdnWkqTyyPCd0CWOrZsKWqJUdQ=;
        b=e+D43JgtHj+/RHSfMowxpuC+/8/CkccOXVT+yD0L0pFGSupbraiGzxkv0sxydI28qZ
         085lwFmkuEzuIzSozs/w4rbMwwCXnRUP3pvqf3fDFmm9tIChIFB3kvkTtCwI1SqrKIz+
         n9z32ZFdUY6ZU7NpmI6z3GFLFRYnXBW9JxNQ/xH5QGpP1UDJw3taWtTD6uIEXUi5MwAl
         eu1HpqVG37u1UFEumqv0T/nR0142E0y3sRdykVQ11Amz3+DxRhA2rl050xjaW7De7EFZ
         Z9ThtNeFGUBULBE0cH+z2VaXownW5pFWrhCFkMCjwWBq/U4QlkeIY71d6qJZBZK75hG5
         /hCw==
X-Gm-Message-State: ABy/qLYKhmipePtPRs+n68IbenxQfQZ7hW202eoYlXf6pJyEMUFeDYYk
	LT98eFYP8Die2pHFdhGCYs0PB+3Vt6bNnpIaLIY=
X-Google-Smtp-Source: APBJJlH43BGdQY2i39brIl27smPY/M6uFM+dPAeRVqKW/kOv8OFzvVkMACUjS45EoMcYM4YD11ASXw==
X-Received: by 2002:aca:f0c1:0:b0:3a4:8590:90f2 with SMTP id o184-20020acaf0c1000000b003a4859090f2mr2739720oih.47.1690558560646;
        Fri, 28 Jul 2023 08:36:00 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:81ef:7444:5901:c19d])
        by smtp.gmail.com with ESMTPSA id u8-20020a544388000000b003a3b321712fsm1732893oiv.35.2023.07.28.08.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:36:00 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/5] net/sched: sch_hfsc: warn about class in use while deleting
Date: Fri, 28 Jul 2023 12:35:35 -0300
Message-Id: <20230728153537.1865379-4-pctammela@mojatatu.com>
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
 net/sched/sch_hfsc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 896cb401fdb9..98805303218d 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1094,8 +1094,10 @@ hfsc_delete_class(struct Qdisc *sch, unsigned long arg,
 	struct hfsc_class *cl = (struct hfsc_class *)arg;
 
 	if (cl->level > 0 || qdisc_class_in_use(&cl->cl_common) ||
-	    cl == &q->root)
+	    cl == &q->root) {
+		NL_SET_ERR_MSG(extack, "HFSC class in use");
 		return -EBUSY;
+	}
 
 	sch_tree_lock(sch);
 
-- 
2.39.2


