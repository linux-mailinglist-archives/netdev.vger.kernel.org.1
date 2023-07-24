Return-Path: <netdev+bounces-20570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D35760279
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462F51C20C67
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 22:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE7711CA2;
	Mon, 24 Jul 2023 22:41:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDF65226
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 22:41:01 +0000 (UTC)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C4B10FA
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 15:40:59 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-348ccbf27eeso10483165ab.0
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 15:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690238458; x=1690843258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iKKgu6i/BBqK+vHvXOuZXXT6jRdj5IPssioGIwoBJF4=;
        b=Hzu3T9XRyiq8KcynvHxfdIrLya3B1g/zWPJ57AoSNqTf6WLvQkAl7lLPBg3JcBQNk7
         XCe5GmZtcSJmpMaCLHK0FdZGTermZaDN2ZyQS4Ic0OBqm+6GU97c6w9+8KhzFlcG8ndH
         iYktX4ihjyT79kvfDkJOWXvTyr4067FfY61ONlueQEe1QBhQva36howY/OQ7g4JF1OkV
         dlHPOavI+CteCqNVxPKtAqABLki/5bkxxnJiloH7qKhJT61LcVGOSaC0rBh+mEIGosjB
         9FmPee5ELruCiQU03d8C/vpfDeCL1GFFBziCMk26YjTUVatDO3qn2gv2slFnpK4rEh9U
         5mRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690238458; x=1690843258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKKgu6i/BBqK+vHvXOuZXXT6jRdj5IPssioGIwoBJF4=;
        b=AGQyNwMxXvvZflAAXM1qbAySvy28eJHSIsfBAvN2t7Aha7jLweD1kR9rkNotPsXwRA
         HFjrugthqoWU2oiXc2zE10m4gEvNWLDtxbhsbl7hGPcTd12vR9BSpDLUQYurwNF4dzk1
         SaJlWh7tl+dbvkMKggA8RZXHT9P5wzLJAd1yK3ajuLsxdFhIwZvddmZInh2rvRT41sIk
         9THylTpu21FGceUx98WTnsGDOdXD4fL1YQaXjGqSt1aLLUIgRWumz+mevybbQSvC33+u
         ONa3+Huv8dFb1sYWyU03P/mm1B034zpQHqX4RZEusA2va350O49HWYsgbB+8YU5MdTwG
         22ag==
X-Gm-Message-State: ABy/qLbH6/ut8d6qT1AczA0hWnTdSY56R919/CrBCqPUcpa++XYB1uKo
	e3DdVuHX5AoKvAhhsPHjH53xfg==
X-Google-Smtp-Source: APBJJlEWt68nkZpbyT0RxibRCLbOdlbisPQd9crre6rbKDCoThNCdcGwvFgg74D0WZSNonJH4u9QYw==
X-Received: by 2002:a05:6e02:b47:b0:348:8163:b6be with SMTP id f7-20020a056e020b4700b003488163b6bemr1218203ilu.30.1690238458732;
        Mon, 24 Jul 2023 15:40:58 -0700 (PDT)
Received: from localhost.localdomain (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id o11-20020a056638124b00b0042b482a8763sm3090952jas.70.2023.07.24.15.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 15:40:58 -0700 (PDT)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: dianders@chromium.org,
	caleb.connolly@linaro.org,
	mka@chromium.org,
	evgreen@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: ipa: only reset hashed tables when supported
Date: Mon, 24 Jul 2023 17:40:55 -0500
Message-Id: <20230724224055.1688854-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Last year, the code that manages GSI channel transactions switched
from using spinlock-protected linked lists to using indexes into the
ring buffer used for a channel.  Recently, Google reported seeing
transaction reference count underflows occasionally during shutdown.

Doug Anderson found a way to reproduce the issue reliably, and
bisected the issue to the commit that eliminated the linked lists
and the lock.  The root cause was ultimately determined to be
related to unused transactions being committed as part of the modem
shutdown cleanup activity.  Unused transactions are not normally
expected (except in error cases).

The modem uses some ranges of IPA-resident memory, and whenever it
shuts down we zero those ranges.  In ipa_filter_reset_table() a
transaction is allocated to zero modem filter table entries.  If
hashing is not supported, hashed table memory should not be zeroed.
But currently nothing prevents that, and the result is an unused
transaction.  Something similar occurs when we zero routing table
entries for the modem.

By preventing any attempt to clear hashed tables when hashing is not
supported, the reference count underflow is avoided in this case.

Note that there likely remains an issue with properly freeing unused
transactions (if they occur due to errors).  This patch addresses
only the underflows that Google originally reported.

Fixes: d338ae28d8a8 ("net: ipa: kill all other transaction lists")
Cc: <stable@vger.kernel.org>	# 6.4.x
Tested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_table.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ipa/ipa_table.c b/drivers/net/ipa/ipa_table.c
index f0529c31d0b6e..7b637bb8b41c8 100644
--- a/drivers/net/ipa/ipa_table.c
+++ b/drivers/net/ipa/ipa_table.c
@@ -273,16 +273,15 @@ static int ipa_filter_reset(struct ipa *ipa, bool modem)
 	if (ret)
 		return ret;
 
-	ret = ipa_filter_reset_table(ipa, true, false, modem);
-	if (ret)
-		return ret;
-
 	ret = ipa_filter_reset_table(ipa, false, true, modem);
+	if (ret || !ipa_table_hash_support(ipa))
+		return ret;
+
+	ret = ipa_filter_reset_table(ipa, true, false, modem);
 	if (ret)
 		return ret;
-	ret = ipa_filter_reset_table(ipa, true, true, modem);
 
-	return ret;
+	return ipa_filter_reset_table(ipa, true, true, modem);
 }
 
 /* The AP routes and modem routes are each contiguous within the
@@ -291,12 +290,13 @@ static int ipa_filter_reset(struct ipa *ipa, bool modem)
  * */
 static int ipa_route_reset(struct ipa *ipa, bool modem)
 {
+	bool hash_support = ipa_table_hash_support(ipa);
 	u32 modem_route_count = ipa->modem_route_count;
 	struct gsi_trans *trans;
 	u16 first;
 	u16 count;
 
-	trans = ipa_cmd_trans_alloc(ipa, 4);
+	trans = ipa_cmd_trans_alloc(ipa, hash_support ? 4 : 2);
 	if (!trans) {
 		dev_err(&ipa->pdev->dev,
 			"no transaction for %s route reset\n",
@@ -313,10 +313,12 @@ static int ipa_route_reset(struct ipa *ipa, bool modem)
 	}
 
 	ipa_table_reset_add(trans, false, false, false, first, count);
-	ipa_table_reset_add(trans, false, true, false, first, count);
-
 	ipa_table_reset_add(trans, false, false, true, first, count);
-	ipa_table_reset_add(trans, false, true, true, first, count);
+
+	if (hash_support) {
+		ipa_table_reset_add(trans, false, true, false, first, count);
+		ipa_table_reset_add(trans, false, true, true, first, count);
+	}
 
 	gsi_trans_commit_wait(trans);
 
-- 
2.34.1


