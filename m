Return-Path: <netdev+bounces-17200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D462750CCA
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4771C211B7
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA7A2AB35;
	Wed, 12 Jul 2023 15:40:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B216C24160
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:40:08 +0000 (UTC)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADC11BD5
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:40:04 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-791a0651fa3so2349501241.0
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689176403; x=1691768403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqAMunIjQg4b+DWKEbmOBlkwSanJ21tKzH7b3xa9RSc=;
        b=T7kpfxWMY5YLu2gwz6SK4bc8YTkccXYhS4lu90yuvYqwfDglJDPBJu24KUxPsysyRQ
         PR5aDpm3Oig5nmOnAFh1wfq2Dm/Dg2LxgA1RKcw3EU78kU5vbDQWpV37zkvUR898bsOV
         B13UzzFEd1Vku/LoNHBG4t/V/tTYjni/9zY4Av8wEFbr+Q4iT+qDkUrnyKyVYBnM+tka
         /N47ujLwisfO82Pb1doMFHQiob0alI0AI+BtljjVqTJoJeqomXaHzJKjkXhXdiQ+kGf/
         BZB60Mn1Wu2J0IbuEk8WwA+x9H8N7BK14VE8Qb6ZB6q/qccxuhU4lwNajwJebgyXzeza
         aADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689176403; x=1691768403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqAMunIjQg4b+DWKEbmOBlkwSanJ21tKzH7b3xa9RSc=;
        b=VjcgaKN4xPzIrGLeOeIUusCxo0TqGzho6E5/JaXxy3R9LokhH01LjNS/zA3YBEUPVv
         t+NpqNt9f6F/rh3B42DBumZl8WTGfJ58vvIawKtANHBEHFlHKll7rSDVY7qBWhj9ZYWK
         xPCYyZAZ7LdwvTuN4cCRbw1B/hOI+dM5xCUji/Pq9kL+NPo9rCGk9Vs42TkzNwcR/O9C
         eFVcH6AqgmddBAL3yuPeDasxb8eumzQuY9+eFUJgAr5FpZPBuJWxAYzbjbhV/PKEMJF4
         mmX7G/SJLuuPX4S6SU64NoJUzB6jrgwyNcM3P4D5xOIL29Bz5qUvJBKgTHW5aREb3gKo
         ISPw==
X-Gm-Message-State: ABy/qLa+jJCb62LkyWhhUafxQmn0pT+N8vJi3Ochya2l/ir/FM8nVbfj
	+xThnvlfX/JfCA7+JzHpVxmpsiaHVX32lEMfW6KRMg==
X-Google-Smtp-Source: APBJJlE+ajJSjIIAaxKJjN2CGDi+Q/cTIq6YSV9vIfOkRy9hd19wCOSEJcLl3PySfcjcac9Ft71gMg==
X-Received: by 2002:a67:ce18:0:b0:443:8a7b:f76d with SMTP id s24-20020a67ce18000000b004438a7bf76dmr926560vsl.28.1689176402880;
        Wed, 12 Jul 2023 08:40:02 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id r3-20020a0ccc03000000b0063211e61875sm2283827qvk.14.2023.07.12.08.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:40:02 -0700 (PDT)
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
Subject: [PATCH RFC v4 net-next 02/22] net/sched: act_api: increase action kind string length
Date: Wed, 12 Jul 2023 11:39:29 -0400
Message-Id: <20230712153949.6894-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712153949.6894-1-jhs@mojatatu.com>
References: <20230712153949.6894-1-jhs@mojatatu.com>
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
index 54754deed..a414c0f94 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -105,7 +105,7 @@ typedef void (*tc_action_priv_destructor)(void *priv);
 
 struct tc_action_ops {
 	struct list_head head;
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
index 5e5f299d2..420cf2617 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -479,7 +479,7 @@ static size_t tcf_action_shared_attrs_size(const struct tc_action *act)
 	rcu_read_unlock();
 
 	return  nla_total_size(0) /* action number nested */
-		+ nla_total_size(IFNAMSIZ) /* TCA_ACT_KIND */
+		+ nla_total_size(ACTNAMSIZ) /* TCA_ACT_KIND */
 		+ cookie_len /* TCA_ACT_COOKIE */
 		+ nla_total_size(sizeof(struct nla_bitfield32)) /* TCA_ACT_HW_STATS */
 		+ nla_total_size(0) /* TCA_ACT_STATS nested */
@@ -1404,7 +1404,7 @@ struct tc_action_ops *tc_action_load_ops(struct net *net, struct nlattr *nla,
 {
 	struct nlattr *tb[TCA_ACT_MAX + 1];
 	struct tc_action_ops *a_o;
-	char act_name[IFNAMSIZ];
+	char act_name[ACTNAMSIZ];
 	struct nlattr *kind;
 	int err;
 
@@ -1419,7 +1419,7 @@ struct tc_action_ops *tc_action_load_ops(struct net *net, struct nlattr *nla,
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


