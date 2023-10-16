Return-Path: <netdev+bounces-41221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E417CA442
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A316C1F21E8D
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2C51CFB7;
	Mon, 16 Oct 2023 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1PFAoPiw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BAD1CAAF
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:36:06 +0000 (UTC)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3535DEB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:36:03 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7b65004396fso938248241.3
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697448962; x=1698053762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KW6wHIgZ5tvZa8mvVUi3fr0IAPovgn8IHJ3t5ikH550=;
        b=1PFAoPiwmit4ss1D9FWLBdBodIXT+ENObLwO6Fde6XHy9yLAJuL4IgPtw+4vaOMj3M
         mhKZH7WoHr5o2sVjGuJlUVabU7rwmL/u0LloLRLm2XyQFAApNq/LR4FZIDcOFz6nP2SA
         07B7BTEhDf2wx+1WRAB9Fr3EAOtDJEv3NGiEzDC3Gekc7oU76fra1LmL72QMmSb4su7m
         K0x2V1z2g+coHLsyvl42QyIFGZjtx9HLBF8xk98L5LT+kKzLeJYgNcscsad8iVWASGR6
         WfoO77UOWJaARHg0QTQBsFG3cUjPPy5nQL8RqBTT8EGNyEmDKYXZjnVimLZhyzrlmDFM
         4vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697448962; x=1698053762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KW6wHIgZ5tvZa8mvVUi3fr0IAPovgn8IHJ3t5ikH550=;
        b=QHJilOzOXWG/dDdUg7hiBBBXUTh+aFS7nOEGb4sum56YhRhR5sV9+mzOvdbdWOHFiA
         YUdieu9ZzXnOsScelHDWW1YfGUstTUyOo7hJUhnfP/p413Gy89yX/s7Pb5GBGQS4L3Nw
         BJdyMkNIlrgjamLckJBvUIarWrnsGBLfk35onIxxMBKaqA805//voLMKSPOnoUwEivnE
         KSwWvcd0Y7UrEl+CHZD2T24u26FH4Kz1kbISOO3bZ+Uf7iu40CiQe5V7pxNKCyqUI+rS
         5eHGwUqhUAGlKf6A/X9Wyfbj08xV8tnMBy+ecNPyuIH2N4KJb91Y1zUee/qhKXMbsAdm
         GzGQ==
X-Gm-Message-State: AOJu0YwluARDTV7dSMIaqKPBNStmvqPwDCFhRGuVCn1rKdYFLgycixYA
	UthY9cyUK165Jz2ZgFYlMT5meySakG3pjzmHI0I=
X-Google-Smtp-Source: AGHT+IG728XEC4XMK89vEhy4mm5vjX39BIqJ6B0sopOcui6dgjqP9XWN6SZ3FmwXgn/wmoujYud0rQ==
X-Received: by 2002:a67:f950:0:b0:44e:8c20:a92d with SMTP id u16-20020a67f950000000b0044e8c20a92dmr26907586vsq.7.1697448961808;
        Mon, 16 Oct 2023 02:36:01 -0700 (PDT)
Received: from majuu.waya ([174.91.6.24])
        by smtp.gmail.com with ESMTPSA id g4-20020a0cf844000000b0065b1bcd0d33sm3292551qvo.93.2023.10.16.02.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 02:36:01 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com
Subject: [PATCH v7 net-next 02/18] net/sched: act_api: increase action kind string length
Date: Mon, 16 Oct 2023 05:35:33 -0400
Message-Id: <20231016093549.181952-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016093549.181952-1-jhs@mojatatu.com>
References: <20231016093549.181952-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
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
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
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
index c7082cc60..75bf73742 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -6,6 +6,7 @@
 #include <linux/pkt_sched.h>
 
 #define TC_COOKIE_MAX_SIZE 16
+#define ACTNAMSIZ 64
 
 /* Action attributes */
 enum {
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 3f3837c12..70c9eba62 100644
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


