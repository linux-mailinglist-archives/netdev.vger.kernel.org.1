Return-Path: <netdev+bounces-19993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765B975D3D9
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 21:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312F4281E7A
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 19:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFD1214E4;
	Fri, 21 Jul 2023 19:14:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F293B20F9B
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 19:14:18 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B4F30E3
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:14:17 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1ba79f16f4cso1708433fac.3
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689966856; x=1690571656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AbkWQ0yF/f4yJpjsrNS2oADVUpeC80a/nPphQj+X5E=;
        b=SQbh/kXT6WCKAUf/H3gJKJ0fRndsBJLLfoA/hRPw3ioLACxk+fFyLldNKuMxAzxn9j
         KOtfx7IfciEGociokPgeaYDcD9w94SJ/U/K7GNrdtHHJ7vEarklpltFayRxxNi9o8gBu
         UKCoqbKU2bCIExEw64d77VIlHNi3XXn+ZDz6+e6jLWbKDMXiHafcNZbk+II//oWX+fiZ
         rfwdNRctRoxH29oWLzkSzekJHmfa8egwRF3G4WpkY7eIWUDuoz1Gms7c1OuxwbPIxeZe
         +v7KMp34HB712va6607rminJMMKsF6cc/tz4xTDu9+GPpJ3Ivh5LzeQFxW7Djz7VzWi+
         HZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689966856; x=1690571656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AbkWQ0yF/f4yJpjsrNS2oADVUpeC80a/nPphQj+X5E=;
        b=iqfhapN0Eg1RWqD9A79+a0rz1oS+Bgvyf9jsNOKbxOIK2My8JeWVPNpG8mGQzcy8Co
         ljUcZHjSyZo+9XuKKS8QBcoiksm4N2NEXG/1k0YZpeWJZ50zwETO6FjupPC5ftHiLlKL
         4mCjTdgf2fUiVvcY97B4s/L30TfWsylCitQFMqqvydo2nG9PqLn10YUoxBD/VJRhfjaw
         7sySJTxRzPk3/Xntyziz43uzw4dmemN7kJSRIBjMHnPrqplV0cCqjSTghptBX+cpL0xV
         AT3dwtJeeiawKKmDbERdQyXMxQVnDYDVeus+4Ove36YnBZF4keh7ORdL3OIedJTac5+b
         bWSA==
X-Gm-Message-State: ABy/qLbip8A2QH95+g6bEQKrOlLjI9hC0bFPECOTygpz69U5ik98LFfG
	vf1ukXQUo5mMPGCu8mrG0U9syw/rThvRuwIVhdU=
X-Google-Smtp-Source: APBJJlGwg2LNB1DMwPrCcQsFNEkC6DACRa0058thSuSj/t1yCSFrwebzBYExJVAqKNJAskjlmxFnWg==
X-Received: by 2002:a05:6870:b4a2:b0:1b7:60a3:4104 with SMTP id y34-20020a056870b4a200b001b760a34104mr3097272oap.13.1689966855979;
        Fri, 21 Jul 2023 12:14:15 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:2414:7bdd:b686:c769])
        by smtp.gmail.com with ESMTPSA id e3-20020a056870944300b001b04434d934sm1813731oal.34.2023.07.21.12.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:14:15 -0700 (PDT)
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
Subject: [PATCH net-next 3/5] net/sched: sch_hfsc: warn about class in use while deleting
Date: Fri, 21 Jul 2023 16:13:30 -0300
Message-Id: <20230721191332.1424997-4-pctammela@mojatatu.com>
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
 net/sched/sch_hfsc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 122fe775c7ab..4800191f7c49 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1095,8 +1095,10 @@ hfsc_delete_class(struct Qdisc *sch, unsigned long arg,
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


