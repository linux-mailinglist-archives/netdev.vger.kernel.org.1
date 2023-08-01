Return-Path: <netdev+bounces-23160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3392E76B369
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635001C20EB5
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929A1214EC;
	Tue,  1 Aug 2023 11:38:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8784046A0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:38:24 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA52E5C
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:38:22 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-63cebd0a7c5so24854126d6.3
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 04:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690889901; x=1691494701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IURhRS3dUrrX8OCY2s4cD8YTFsy25Gu+YQblfO6j2yA=;
        b=aD2felNGlktecx3NpOZKBTMwwUPChlxqeT7cY4KNv8s6JpaDAh/Hxm3UB2bP2uKGqR
         eSCPHHwRf/xX/U3iYPWBlSo0Vg4BehnO8XW4iNz42w/LyfxXKDTToUPU6Qt0W2YPoVO6
         zKne+OUmoFHXVaV61J9onJpl+3Zv5VPp3Radi/wuKyeAKveaZMiu1LlEYjlB/c7kxlb/
         ajtxw09lMu4uK5SCL9Qx9tpjMprA1jk1tUKByEELLWX+Zkn0aBw1j4wnj1p39ZojBccJ
         tz6P5wS22bvJL/hYYfjs9paBcScAnhi4sXOv6q9oY1yimN1FTnQId9tBKkAKJHI9ZM/h
         ixLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889901; x=1691494701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IURhRS3dUrrX8OCY2s4cD8YTFsy25Gu+YQblfO6j2yA=;
        b=Bs+vE/fYBC5h22PYMMmTc8T6BWAEbxlXGbHEnVvbXDRUUFMc5TsGHmnNsFKqzFgXNP
         IwmRDfQmGj8lpLR6Exf5HMMCtdFzDTfoz0vNru4+TJZcrIj95MOVMQzfcLEvTxFPDKrV
         B3YF2dzsAmKsQlLFrAm5Rq5go6QlX/WjK+UD1AeHDRlNDG/w5vRh5lmI3YmHEMCfeWod
         UXS+1br5viEVv3g3f6ImtYqGOuiOI7MTDg7IlfQs9lmO9djS0bGxGOOFtd8BroQrKzZ3
         WDcrWgRf71iC/r6mqNcteVAlKt4NT7te1yYTqhFR9aB4C75Pk0H+3tBbm8TLdcECvY41
         6uag==
X-Gm-Message-State: ABy/qLZNsenE8CXfIPqxQJG9uKsBRfA+eVFBCDwr2mdu/P3OD0XuAPOf
	XTEj/EsipwAlbJQ4XO/N7zaL2ngHJiIbOqG9f26N4Q==
X-Google-Smtp-Source: APBJJlGyQ05Rz7vBI4gNS4zc2MuebRx2r+gtGo6dYVk8s1VgXWaWGrRvuDHYHcB36QGTZ4BJXGH2GA==
X-Received: by 2002:a0c:aada:0:b0:63c:6d0d:fd3b with SMTP id g26-20020a0caada000000b0063c6d0dfd3bmr9000576qvb.62.1690889901259;
        Tue, 01 Aug 2023 04:38:21 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id j1-20020a0cf501000000b0063d26033b74sm4643738qvm.39.2023.08.01.04.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:38:20 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	Vipin.Jain@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	simon.horman@corigine.com,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com,
	john.andy.fingerhut@intel.com
Subject: [PATCH RFC v5 net-next 02/23] net/sched: act_api: increase action kind string length
Date: Tue,  1 Aug 2023 07:37:46 -0400
Message-Id: <20230801113807.85473-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801113807.85473-1-jhs@mojatatu.com>
References: <20230801113807.85473-1-jhs@mojatatu.com>
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

Increase action kind string length from IFNAMSIZ to 64

The new P4TC dynamic actions, created via templates, will have longer names
of format: "pipeline_name/act_name". IFNAMSIZ is currently 16 and is most
of the times undersized for the above format.
So, to conform to this new format, we increase the maximum name length
to account for this extra string (pipeline name) and the '/' character.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/act_api.h        | 2 +-
 include/uapi/linux/pkt_cls.h | 1 +
 net/sched/act_api.c          | 6 +++---
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 3d40adef1..b38a7029a 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -106,7 +106,7 @@ typedef void (*tc_action_priv_destructor)(void *priv);
 struct tc_action_ops {
 	struct list_head head;
 	struct list_head dyn_head;
-	char    kind[IFNAMSIZ];
+	char    kind[ACTNAMSIZ];
 	enum tca_id  id; /* identifier should match kind */
 	unsigned int	net_id;
 	size_t	size;
diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 648a82f32..1849f4f4b 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -6,6 +6,7 @@
 #include <linux/pkt_sched.h>
 
 #define TC_COOKIE_MAX_SIZE 16
+#define ACTNAMSIZ 64
 
 /* Action attributes */
 enum {
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index e3a660802..a8cb71f05 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -476,7 +476,7 @@ static size_t tcf_action_shared_attrs_size(const struct tc_action *act)
 	rcu_read_unlock();
 
 	return  nla_total_size(0) /* action number nested */
-		+ nla_total_size(IFNAMSIZ) /* TCA_ACT_KIND */
+		+ nla_total_size(ACTNAMSIZ) /* TCA_ACT_KIND */
 		+ cookie_len /* TCA_ACT_COOKIE */
 		+ nla_total_size(sizeof(struct nla_bitfield32)) /* TCA_ACT_HW_STATS */
 		+ nla_total_size(0) /* TCA_ACT_STATS nested */
@@ -1393,7 +1393,7 @@ struct tc_action_ops *tc_action_load_ops(struct net *net, struct nlattr *nla,
 {
 	struct nlattr *tb[TCA_ACT_MAX + 1];
 	struct tc_action_ops *a_o;
-	char act_name[IFNAMSIZ];
+	char act_name[ACTNAMSIZ];
 	struct nlattr *kind;
 	int err;
 
@@ -1408,7 +1408,7 @@ struct tc_action_ops *tc_action_load_ops(struct net *net, struct nlattr *nla,
 			NL_SET_ERR_MSG(extack, "TC action kind must be specified");
 			return ERR_PTR(err);
 		}
-		if (nla_strscpy(act_name, kind, IFNAMSIZ) < 0) {
+		if (nla_strscpy(act_name, kind, ACTNAMSIZ) < 0) {
 			NL_SET_ERR_MSG(extack, "TC action name too long");
 			return ERR_PTR(err);
 		}
-- 
2.34.1


