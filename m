Return-Path: <netdev+bounces-16653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD45D74E26E
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 02:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCEB1C20C5A
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 00:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323C017C7;
	Tue, 11 Jul 2023 00:05:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A6E17C2
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 00:04:59 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA13C1A7
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 17:04:58 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-55e1ae72dceso3678356eaf.3
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 17:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689033898; x=1691625898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=60j+4xER6SZGRT6bq5UBrsfZVg2QOd/RhKRdqPsy9Z4=;
        b=sZPJ75+NHI7+/yyI/815iXI/vy272HQLGy/VKG8FhGv/0i6HGldNz0XJaoVmpQ7ekX
         fVbB1Apc6mdUuv1R8qODWeeW8+W6LMhA0RGfl+QgZupmmrylvUu6MG3W2K2S+NG3qLKX
         EJ0K3rPvied4XXj16Gcq16R11AgYwA+Hwo6XuCFCL4v3D8P4BLa2XwBPAS1h9kb1FisP
         b3HgTo5hkFZcvxVpI8X61XUM50GMFbS5y1OyNl9moXkyrJouwhR/rB0tvLPkLPxpfMYi
         BIydU4XhL+3VyTLAUu0W8lfahaNSBIviKPkkaWm3WmdwIyu9oLtF2jiycVl/POrngCfj
         hauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689033898; x=1691625898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60j+4xER6SZGRT6bq5UBrsfZVg2QOd/RhKRdqPsy9Z4=;
        b=NUR7JGx+yMfOXHfTTaJfigB+6mYMpH4Q2RRCh5tGCIcyscso7S8MzMAIPtkOv+FLMN
         u+JZcb3OcKa8pxVXdfQZcGO17wH+0FOkjOC47NKjbdgwIrS/xalSlcJpSYyBRFFCABxa
         afUGDwXXpb+lEBsiYWi1pzTCbuhwMQt+d0uHDGGBoxVImSwdcNYPNR3pf4ZUB9IaVJYL
         CPXhzRdiR7wFldQNbkU+7DCWoGg5p6z+tmL0RvAUrODYhljPNbSHHzCYwQ7Y5BmXwawZ
         OslGAI+aOAlqGW/AKCjYHg2if65xdfbM1s7fnqEdrIR7ZjaQAMx4cLvWUkP/oUkhCLSt
         fOTg==
X-Gm-Message-State: ABy/qLYwBAh5E0V2ZCOF/99xsRKyP20qRYN4vC7uz3+qUY0XyrlfaN/b
	7MfZauOfIQEIV8VkaZ8Le2PFOlTZdHilFAb6TeY=
X-Google-Smtp-Source: APBJJlGfqew83vRQjDi8Ec0dZ91VBj+c1FG1dbhrj7+M4Ugsfxj1pjgAqFDeuIE60FMSxTMJ/uJ1YQ==
X-Received: by 2002:a4a:4fcf:0:b0:566:3723:a030 with SMTP id c198-20020a4a4fcf000000b005663723a030mr9144781oob.2.1689033898000;
        Mon, 10 Jul 2023 17:04:58 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:5048:750f:5697:17a3])
        by smtp.gmail.com with ESMTPSA id 123-20020a4a0d81000000b0056422cfb35csm332212oob.40.2023.07.10.17.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 17:04:57 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mysuryan@cisco.com,
	vijaynsu@cisco.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net] net/sched: make psched_mtu() RTNL-less safe
Date: Mon, 10 Jul 2023 21:04:29 -0300
Message-Id: <20230711000429.558248-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
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

Eric Dumazet says[1]:
---
Speaking of psched_mtu(), I see that net/sched/sch_pie.c is using it
without holding RTNL, so dev->mtu can be changed underneath.
KCSAN could issue a warning.
---

Annotate dev->mtu with READ_ONCE() so KCSAN don't issue a warning.

[1] https://lore.kernel.org/all/CANn89iJoJO5VtaJ-2=_d2aOQhb0Xw8iBT_Cxqp2HyuS-zj6azw@mail.gmail.com/

Fixes: d4b36210c2e6 ("net: pkt_sched: PIE AQM scheme")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 include/net/pkt_sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index e98aac9d5ad5..15960564e0c3 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -134,7 +134,7 @@ extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
  */
 static inline unsigned int psched_mtu(const struct net_device *dev)
 {
-	return dev->mtu + dev->hard_header_len;
+	return READ_ONCE(dev->mtu) + dev->hard_header_len;
 }
 
 static inline struct net *qdisc_net(struct Qdisc *q)
-- 
2.39.2


