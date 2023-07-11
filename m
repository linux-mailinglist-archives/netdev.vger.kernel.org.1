Return-Path: <netdev+bounces-16670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C8374E403
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 04:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28231C20AAF
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 02:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3146EC1;
	Tue, 11 Jul 2023 02:16:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41D5A50
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 02:16:46 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F2CFE
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 19:16:45 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b7541d885cso4091915a34.3
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 19:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689041804; x=1691633804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sYGHPH67TvRsUlJPjPa782KQWTnUgo4qSoL20Lkl6V4=;
        b=F+2ylvXDvlLHw9Dh3EmkwTxmCFEINb/+evhO7tVFw/zGvLw/kNLX53ia4ynmeORoz/
         TkQJUXlNTSK9c0EqyRX4UjLgCuZALdRjE5X1BvxMArsM7nDRq2AEqVUJCLhPk5Xsl+D3
         YmNSnADyVyUJrIUWFRmvoSpQeZHkaXIXH87h19qMh5vDIGap+CTPEzkfrtnTR5TGqKQQ
         mj5x99tVqgmGN7URQ/8QA149GvZP9BdSiTZ0euaDUoclc6dB+WboNAlqV2j9LB4ayZ2W
         qKdyuiPFigzUkhjoT3TilTSY5m5zhnUQGcEZZn85rn8z+s10Yq2ebVlCcB6JM9baWRkA
         XDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689041804; x=1691633804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYGHPH67TvRsUlJPjPa782KQWTnUgo4qSoL20Lkl6V4=;
        b=baekiTacRiCn9LoUTnRNm6ag17SjLaYUeHIjrGQe2Q5iWo0XHUZQ6vdwvUm1f5ZNx3
         oLapy8gRvxo26uTXGLilVkw/I1oNzIBphd6l8quZDtuB5eAR3ZAWSrwF9RNp2Z3wf1k0
         9uFdNn4hnqdPA35gzUMji+A6octfwEcsf7/8W/SyJaPxuw/4XBjyn2T4Kmfb6iUNi28b
         g6elu0cGlsowzxkayEElIUqCet2mTK+SAyGOXfG8lXTIK8YQNAhZO1sJ7hgaDPs93N+X
         BRSQ25BG0NinCcP549/4Y49tVWOac1E2vHlbsdTD47atbsB+2StngDJVb61ilr3NhyUC
         9YJQ==
X-Gm-Message-State: ABy/qLaVJyKpTdTOOZqe8nW2S3NLiHrdYmipW5o7tz4bOvzuxQlsTbCN
	HLuGnIXLstFmfUqJLya80cGPonrX7cEaFtkNjq8=
X-Google-Smtp-Source: APBJJlED5XNkzB7LTTlI1r9s4EOCDAHLrdWo08ABQwgJefy6E6oHIDhCtS3LEQXfze3ZcLcG4qrIsg==
X-Received: by 2002:a9d:4b16:0:b0:6b1:5f4a:f52d with SMTP id q22-20020a9d4b16000000b006b15f4af52dmr13631825otf.22.1689041804774;
        Mon, 10 Jul 2023 19:16:44 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:5048:750f:5697:17a3])
        by smtp.gmail.com with ESMTPSA id b9-20020a9d7549000000b006af913c1044sm561495otl.16.2023.07.10.19.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 19:16:44 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH v2 net] net/sched: make psched_mtu() RTNL-less safe
Date: Mon, 10 Jul 2023 23:16:34 -0300
Message-Id: <20230711021634.561598-1-pctammela@mojatatu.com>
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
-------
Speaking of psched_mtu(), I see that net/sched/sch_pie.c is using it
without holding RTNL, so dev->mtu can be changed underneath.
KCSAN could issue a warning.
-------

Annotate dev->mtu with READ_ONCE() so KCSAN don't issue a warning.

[1] https://lore.kernel.org/all/CANn89iJoJO5VtaJ-2=_d2aOQhb0Xw8iBT_Cxqp2HyuS-zj6azw@mail.gmail.com/

v1 -> v2: Fix commit message

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


