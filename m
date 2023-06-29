Return-Path: <netdev+bounces-14522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A406F742424
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D001C20980
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 10:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BDAC8FB;
	Thu, 29 Jun 2023 10:45:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7464C8C9
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 10:45:52 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A6C1FCB
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:45:51 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-635dd1b52a2so4870756d6.3
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688035550; x=1690627550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UisjzPLZxrzZhiXzOtVufNZXYX8my/7SxEXt+8W5bTU=;
        b=25Cx5D1phoOt3KyfN+TbZgUTBpACRRSVtOJ8FG3CPwcPaSaDZb4fpFY+HryhduKC17
         VQgyWHO6JOi5yGzI2E+r9uys9GHYftAxsH4EvV/RHOU6HeEbLhzMNs4KFb6Fkux30etY
         WcGj1uHwkIbbRVen3cglXaQlLaWh3Bc2PBSPwgjJjLhvIngtuOy6CViUMe8IM9mzA21m
         FgMyyDXVDDSYF0U2LFzJXGMwLsvLJTBw02EEtWzrPqFVaw1VyCnkYwT07AoGpbDW/aGo
         Ylx84IGmW+2AT9hfrUg1uI9/p2HLDad+nczF9IfKv4BMDmBvaHf7ev6XTpcKpREEXxDU
         opMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688035550; x=1690627550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UisjzPLZxrzZhiXzOtVufNZXYX8my/7SxEXt+8W5bTU=;
        b=gVniAUIv2ZjoNvlFGfyCKDLjda2h63WO4bn/R721LHs6h4mmQs2G5b2GtQZa2zVh8Q
         JSUn7Uhv+1d7MkEVKCOA+8FQQkp8n0rVIWTXa+N9kc3APFSBvOnTfU8Ukj6k6TZwEMfA
         gTZqcOgg3wFwUFJ5uqZCCR04CUFr1iiLhJ68SBwfjjFXMy2wiYwUb71QqWKI8sttUcjF
         Gp82m5oHc5gjKPgwTNM/zx8x/VroRJXC9AIygJaMBRVsbDTYO4rD0xwMyr8Onj06kWA0
         lpqyTYPsyqHbVHnUiFGJUvlZs3HiaO0aiVz5qCFw/qukZloOHVDrycqP79muuEWHLRWj
         e1vg==
X-Gm-Message-State: AC+VfDyM3HFovrtqE5W0c0x9UxJ2sfWLWGzXQB2cG1OKNi3Xf6PwVtOj
	sn/VEillnt7IvsS5BeCQCFdaDGLx3SeVY8F75h4=
X-Google-Smtp-Source: ACHHUZ6EEGpOAqmMYsauSr3p+/pi6vyOBYHxyaLtRbJcbZ13jvVsVGDMfRy3ghKKeo3PtXayWPsppw==
X-Received: by 2002:a05:6214:1303:b0:626:2bf5:d532 with SMTP id pn3-20020a056214130300b006262bf5d532mr52304077qvb.14.1688035550043;
        Thu, 29 Jun 2023 03:45:50 -0700 (PDT)
Received: from majuu.waya (bras-base-oshwon9577w-grc-12-142-114-148-137.dsl.bell.ca. [142.114.148.137])
        by smtp.gmail.com with ESMTPSA id o9-20020a056214180900b006362d4eeb6esm538453qvw.144.2023.06.29.03.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 03:45:49 -0700 (PDT)
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
	kernel@mojatatu.com,
	mattyk@nvidia.com,
	john.andy.fingerhut@intel.com
Subject: [PATCH RFC v3 net-next 02/21] net/sched: act_api: increase action kind string length
Date: Thu, 29 Jun 2023 06:45:19 -0400
Message-Id: <20230629104538.40863-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629104538.40863-1-jhs@mojatatu.com>
References: <20230629104538.40863-1-jhs@mojatatu.com>
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
index 142fd152b..818e71e13 100644
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


