Return-Path: <netdev+bounces-15151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8C2745F8F
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 17:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C6C280DDD
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 15:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EA0100A4;
	Mon,  3 Jul 2023 15:11:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA8A100A3
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 15:11:19 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27C7EE
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:11:18 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1b078b34df5so4486168fac.2
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 08:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688397078; x=1690989078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gE+nBbwn4SMzyJShReP15jNqF2zeb2VIQI1us3ERsko=;
        b=UoS3M6sPjZRQGivhAh2BUnab+HwNURo1lMxJ3YGVG6sJ02CsXCNwLRyjNBk2az/UKM
         CuL9C8AOnufWIqDIcK9rfETGLm8Jwt6RjdnyBJ2kJLCv+uiMgD+92zqVCz0L2HqWI21/
         ZTowtUlFxSlz5+1Dvbb/XbbHXwbhA492zImb+cQJDzVW8BWbE8qxxhMeGAU1IKP/xue6
         XdtfWJhoJ19q5ufuvvIGUXTPiaIvC+xBnm33XyDbdF6f3SZ60SmElP/LyjxeoFoU+tFK
         X3Xrvj4gUFMtU2yeWlwmw2XmJjGkisS5g3Bacy/WeG3eBG18nVTkgrKylK+4LKsnb2Jt
         V/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688397078; x=1690989078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gE+nBbwn4SMzyJShReP15jNqF2zeb2VIQI1us3ERsko=;
        b=PV1/j1EEEQH/dryB/0AbY1vRP0zx4fI5HLnUvDxiTL5D1ACXUKekLQOh08mbIPKEwT
         5ikVnXC4RBbdWGaf1xm/6Hr5UoDyAnZ5mvpSHD76Zk0sN9UKinsu3N4YuY4KI/yp9IYN
         IIASg7h65F4UBthskwZ/Ij1pdKjhzMPl6QzRcGgU56QQdX616XBgwlpU+PORSYZGzLk3
         ohEDutlXeYy/6flMTbxgOLobRX6mdzwboQneG5w2M/ib4SpghXPr3zWRcCshF11iOJEe
         ZPKyqO5LKG9wAvrqCeMqm/9XHVzMx0aySDgRP8TmPned6JGk8m+hyOyx8Dujama3nf4y
         ywww==
X-Gm-Message-State: ABy/qLZSfK9H/PyeJFgOcP3TZACTJej1xFD4zYrporMAdqpLqB1+vlPs
	qsxabYa1XuENuACCbkVqxV5nbNpNEPe77w6XXeE=
X-Google-Smtp-Source: APBJJlF2/5d2JrJNcfjW2UvwoOWLDeT10I/dB+7H4kAYQAMFNylq8b95iOvbvnjT3ABiPpxT9b3XAA==
X-Received: by 2002:a05:6871:4e42:b0:1b0:432d:acae with SMTP id uj2-20020a0568714e4200b001b0432dacaemr9236252oab.39.1688397077922;
        Mon, 03 Jul 2023 08:11:17 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:7e4b:4854:9cb2:8ddc])
        by smtp.gmail.com with ESMTPSA id cm9-20020a056870b60900b0019f188355a8sm12452600oab.17.2023.07.03.08.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 08:11:17 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	shaozhengchao@huawei.com,
	victor@mojatatu.com,
	simon.horman@corigine.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net 1/2] net/sched: sch_qfq: reintroduce lmax bound check for MTU
Date: Mon,  3 Jul 2023 12:10:37 -0300
Message-Id: <20230703151038.157771-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703151038.157771-1-pctammela@mojatatu.com>
References: <20230703151038.157771-1-pctammela@mojatatu.com>
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

Commit 25369891fcef deletes a check for the case where no 'lmax' is
specified which commit 3037933448f6 fixes as 'lmax'
could be set to the device's MTU without any bound checking
for QFQ_LMAX_MIN and QFQ_LMAX_MAX. Therefore, reintroduce the check.

Fixes: 25369891fcef ("net/sched: sch_qfq: refactor parsing of netlink parameters")
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/sch_qfq.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index dfd9a99e6257..b624ae539c8c 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -425,8 +425,15 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 
 	if (tb[TCA_QFQ_LMAX])
 		lmax = nla_get_u32(tb[TCA_QFQ_LMAX]);
-	else
+	else {
+		/* MTU size is user controlled */
 		lmax = psched_mtu(qdisc_dev(sch));
+		if (lmax < QFQ_MIN_LMAX || lmax > QFQ_MAX_LMAX) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "MTU size out of bounds for qfq");
+			return -EINVAL;
+		}
+	}
 
 	inv_w = ONE_FP / weight;
 	weight = ONE_FP / inv_w;
-- 
2.39.2


