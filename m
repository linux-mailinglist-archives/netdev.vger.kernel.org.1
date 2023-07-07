Return-Path: <netdev+bounces-16150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD1A74B955
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 00:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FDD281958
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 22:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4784717AD4;
	Fri,  7 Jul 2023 22:01:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C21217AC8
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 22:01:26 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB6AB7
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 15:01:25 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b886456f66so1939748a34.0
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 15:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688767284; x=1691359284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBSshbMiCUOyTKW3WH8bAnlcnqbOyyGEgz8YI7SdsNg=;
        b=5oXCqWVlR/ZwOkFqorpzCf/F5nIl8WEVvk1iXVA/yKkivb+9oLW53y7hHoAyC0RjoN
         DOoH2TxsgPjm62GbAgtfSRkgKmOofSTvXGYHQivUp5wW58M4WKH2fjbXMa5GBlTgaeG1
         D8kWJk40ERyUMaafLtpTIwtZ8KunrKyYbkSgeRW/srxao7x8Ur40yjGhBIYZuKUyPXo6
         qxraNdgWX6E5kQSZUiOHNZHEr7UwLTWoPK925bs4/K+K948shPPOBdK0GF18Tw61rZ0T
         A4nhPFrxxjDNlBVQ39nB3nbStIqiovRISkNrRSnhhgMN30I8m6Gl6Tqf2vE/+743Hx4J
         vHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688767284; x=1691359284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBSshbMiCUOyTKW3WH8bAnlcnqbOyyGEgz8YI7SdsNg=;
        b=YacbmIuCLXfZFSjTh7KxZaetQPP5IiYfTWTE8gSZ1sOMFTPZGM3h4q7MPvxW4v9C4U
         aj+pIuoKpeojdfj/MnySeLHTY0jYyTIO74w5ZYZ4YwGLKKCRXhwwPOIWTIG7z5qKRnOJ
         xWKJT9iiUwtvFC9zxx9I7/KGm5SvpGIcBuPlBNiccchRhnjlLSWTFi0Om1JiICCDvcVb
         lbZe+PJ3Mj/yr4cDOi1Uff9hY5sZQQ8QHL3Ogx0x2MJRbtUX6ItQfc+H6bpDsppDt+gq
         7MLM9NQs6F137UpmEmXIvogu7v0/ZZsvnzpNAsl6HWZukU/JcOEzHf+ZIx94biD+ceQo
         lWQg==
X-Gm-Message-State: ABy/qLaBkkD4qrXljsoHcmpuefQdp9bVelaOBO9LMGFPMgaoq/AVanFJ
	M1y6Pl44ZIIBZjPYquT1WI84EfDZuIHGUXCO/zw=
X-Google-Smtp-Source: APBJJlG5xzqOKaVuPpZ29eMTBKsy6e0XuyA2TReqewuLynsOj5SINQVDHmCEEUIYyC68ZgwByfVasg==
X-Received: by 2002:a05:6830:1114:b0:6b7:49e1:f8f2 with SMTP id w20-20020a056830111400b006b749e1f8f2mr6281599otq.20.1688767284009;
        Fri, 07 Jul 2023 15:01:24 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:9dd1:feea:c9a4:7223])
        by smtp.gmail.com with ESMTPSA id p9-20020a9d76c9000000b006b45be2fdc2sm2055533otl.65.2023.07.07.15.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 15:01:23 -0700 (PDT)
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
	paolo.valente@unimore.it,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net v2 1/4] net/sched: sch_qfq: reintroduce lmax bound check for MTU
Date: Fri,  7 Jul 2023 18:59:57 -0300
Message-Id: <20230707220000.461410-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707220000.461410-1-pctammela@mojatatu.com>
References: <20230707220000.461410-1-pctammela@mojatatu.com>
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

25369891fcef deletes a check for the case where no 'lmax' is
specified which 3037933448f6 previously fixed as 'lmax'
could be set to the device's MTU without any bound checking
for QFQ_LMAX_MIN and QFQ_LMAX_MAX. Therefore, reintroduce the check.

Fixes: 25369891fcef ("net/sched: sch_qfq: refactor parsing of netlink parameters")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/sch_qfq.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index dfd9a99e6257..63a5b277c117 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -423,10 +423,17 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	else
 		weight = 1;
 
-	if (tb[TCA_QFQ_LMAX])
+	if (tb[TCA_QFQ_LMAX]) {
 		lmax = nla_get_u32(tb[TCA_QFQ_LMAX]);
-	else
+	} else {
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


