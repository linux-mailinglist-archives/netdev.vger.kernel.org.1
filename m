Return-Path: <netdev+bounces-19994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 830A575D3E1
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 21:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4C4281C52
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 19:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF45F20FA0;
	Fri, 21 Jul 2023 19:14:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F0D20F8F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 19:14:21 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190411FD7
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:14:20 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bb0cadd3ccso1203424a34.3
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689966859; x=1690571659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJI8u1OoqoMHKia3oHwzHWPwrl2DGn1yYK3yVhK5gfk=;
        b=lYVjiX5dRYt3/n/tiNLLW06FTLgZ+QCAyRAAw+A+nPMacCs7rWOoKWF1aTOLuyKYHP
         mSr2lVaqyf7Ekw0NkZJ9SYNVohMx5LDGIQ5iOQw6FLIBDlEGl0zbLb74ivq4K/QdaWgo
         AhyfcHcUfAFmoV9/SnqXCppm8/BZPgozTDL5U92tD/k4q75fVlzwkuFqVPwq/yu+IxeR
         Tfz446GNFPbBzROq4lgEvg8DQxisTiSB2PqmNRXvl2IMzUQOOt8/uADeaEzywfBr+hsB
         zyG6Zn17vjlPmbT5iPPySqCYxx0mdYNYLLbMRPMUhyZa6IqtXy/CFCbf0IhIIe37hf8y
         nIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689966859; x=1690571659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJI8u1OoqoMHKia3oHwzHWPwrl2DGn1yYK3yVhK5gfk=;
        b=kc87s9Y2cn1rUQX8kx8BjvdXLD9KXo0Mtu6bcKQVHIvyMB22EHhQRdpzFBuGr4W2F+
         eTIFenRbuC/rDbLgdtogMyYp4iUHy7Uvt1Zi9hQKlpBO1XW0zVckgGvLFe0xVOFrSSxE
         L+8nKOESqJ89cqCkO7Dbcnzjo2Nx71XwBy54ANoFHlHq7oWmIamPiLy8U8hV+bzixBTh
         O+EuWLix5klbQi3dbHpH7uJxQARpyqbSHkwYFnuXCO7XDvAtVib8fyz9GKIDO070Gsop
         Yi7IHx4ts8Xj5Ei6gwUxgrGyFWDVUh5Qo81nYjxEVmn/G3QErRN3W5/V3y5Zmbxh48Xw
         QifQ==
X-Gm-Message-State: ABy/qLYT8EJlXwjlx8+T7JcauSGF2HRJFbl5BPKdaGYG/v8wQRn+Vryc
	zPpp2l7C9nu9WSnHNZqgvcfXdCDtV6z3tgNckbY=
X-Google-Smtp-Source: APBJJlHjsKd5Lsh044ZjTTQQP2DnHsjglirBOZ2zT6GJfew0Ugy/Z8zVNioWDr1ArfPfIINcK3HTfA==
X-Received: by 2002:a05:6871:411:b0:1b0:f90:4c91 with SMTP id d17-20020a056871041100b001b00f904c91mr3201746oag.8.1689966859257;
        Fri, 21 Jul 2023 12:14:19 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:2414:7bdd:b686:c769])
        by smtp.gmail.com with ESMTPSA id e3-20020a056870944300b001b04434d934sm1813731oal.34.2023.07.21.12.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:14:18 -0700 (PDT)
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
Subject: [PATCH net-next 4/5] net/sched: sch_htb: warn about class in use while deleting
Date: Fri, 21 Jul 2023 16:13:31 -0300
Message-Id: <20230721191332.1424997-5-pctammela@mojatatu.com>
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
 net/sched/sch_htb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 5223b63cec00..8e8660a145c3 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1710,8 +1710,10 @@ static int htb_delete(struct Qdisc *sch, unsigned long arg,
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


