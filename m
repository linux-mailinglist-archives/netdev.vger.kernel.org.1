Return-Path: <netdev+bounces-19995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6389A75D3E9
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 21:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457BA1C213EA
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 19:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8C8214FD;
	Fri, 21 Jul 2023 19:14:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C404A20FA2
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 19:14:24 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8891E30EA
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:14:23 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1baa6fc33f1so1747060fac.1
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689966862; x=1690571662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=es5JtZv/aJwupD57RfxWnKLHkh4uDr06m4MLwiD+W+8=;
        b=3sBPuPd4TkXKN15CGq4aW+eqmVn5cYSRphMLqAIDnyFSuE9vjK+S3GuXF1MN3VsEEq
         Jrlz5pWo7QBycNLNyQXCPHGpkCW7F9jKkqNf6tJ7Lmmv/lXjEYQRoJsk8mGYdoCaHQCk
         cuT775840Z8pBuZn2CzH5Nm9CDAE5h6uHFfAq6KCrykcDNz4teIsN8AdaLTXB7EcF/fs
         0fhfYptrZTOKOCe4MIHfZlTtnyVLY/okfjxJHe6wPy0Bf/7crW8mi+YE/CzX48uOo1MM
         OtRTv1yH5QBqNhb3rtaqMlgLl9HOzZ1fCQ0YPpRvUDEVAI2ZeUb6hGTcTDMo9mEoXwI1
         MOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689966862; x=1690571662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=es5JtZv/aJwupD57RfxWnKLHkh4uDr06m4MLwiD+W+8=;
        b=B/Z8XlNkzjOv3dIwmInJDhhI8LfERWK9QrQSK+WOaM3kn9jtFXrSFHMwcnfM5vee5Q
         Q2zc35Pp8N6Ku2Guec2mx3rKfhLoItZBzfnM3bhy3Vm1r8tvVarYI/sSP7IlFolpiXiO
         mX0lGlSXPNoNS/tGJKg4S1gGHj4SXddylhO1XgEWIj/OiqWysDF98Xxpa7eAva4OECHS
         0FL9ligSHBZEOpR/3jhbkkROnPOn276QP8K28w4KZcBZBHwsA3ODP0nP9/2GI96I2Rve
         5VYYxY3Ba6R64jQCCc8HLxNt+CLPtmK/alHlYLSzqWoQBQNh5BGq1LEOEWv6712OYRUZ
         5ETw==
X-Gm-Message-State: ABy/qLZXDRJhDeKdvShvAxaunbQu/yZRLWx+SE2BHcxqGS/DyWML8M7V
	4SVL412PwcHV8dGJa5mMU7oOq3au58/au7hX6Ok=
X-Google-Smtp-Source: APBJJlHQ1tPVhIpf0cmch5vOVoub2NyFT4g9GF7hvOsEUhr5MNI6Chwo+2P2ACNSBlIkhgKOh7IDuQ==
X-Received: by 2002:a05:6870:fba4:b0:1ba:9b87:8590 with SMTP id kv36-20020a056870fba400b001ba9b878590mr2913760oab.55.1689966862797;
        Fri, 21 Jul 2023 12:14:22 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:2414:7bdd:b686:c769])
        by smtp.gmail.com with ESMTPSA id e3-20020a056870944300b001b04434d934sm1813731oal.34.2023.07.21.12.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:14:22 -0700 (PDT)
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
Subject: [PATCH net-next 5/5] net/sched: sch_qfq: warn about class in use while deleting
Date: Fri, 21 Jul 2023 16:13:32 -0300
Message-Id: <20230721191332.1424997-6-pctammela@mojatatu.com>
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
 net/sched/sch_qfq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 2515828d99a6..7a0427353cf8 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -544,8 +544,10 @@ static int qfq_delete_class(struct Qdisc *sch, unsigned long arg,
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


