Return-Path: <netdev+bounces-21105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8A4762773
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 01:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5D2281B0C
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEC027714;
	Tue, 25 Jul 2023 23:35:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B3C8462
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 23:35:28 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52240212E
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:35:25 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-56336f5dc6cso2621650a12.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690328125; x=1690932925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fhBwyRn68UiYHrmsi2mNFbknLPd/TH5EZanmHFk4ess=;
        b=0xNKobqZ/zmVrbfh/k0LcXdm4UPxjlBzHow50E4eiMdHa75rQ5qyMouGMBzj4+yU4q
         07W8Ld2ESfWS66EjZlbMe+q8P6zekSMoMAY/tLuck1K7+rJB2sQCl2V6qnto3mGuG9nZ
         kns6w2Eld2xhWmKUO/UorXfCrT/wQ4Io0BaRUjuNbyin54MqLORms26pUkQcmdnJjTmP
         LY4OomVf2ZSH6djf9mRJqz1TWGv3lYO3sD1fxyQGb7HGLmgiNIkGfnK+pYTNE2fLwe++
         3aiQycStb4Pio9M0Aee30UD7yeY/4sCyzc34fjyYU2Vg0805mgHGBDijssksDV8lGzIu
         KMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690328125; x=1690932925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fhBwyRn68UiYHrmsi2mNFbknLPd/TH5EZanmHFk4ess=;
        b=XDSgBn1kzHOAEO+ZigabPtOYTGuMCg580IJM7uI5BU1gIVnPCByhQwuEOUsryIKRxd
         zqnNGVkC+Ff/ZKOjvJnYX7yCCGqSPtKtAYVabIs3bTxl412V1QBvknm7p7HYceF8TTbD
         DytrewAbmCdaMTyOf/f3LESGzkQED3Lqea/mRqBKhv5Fc+3rMmJ8Y5P1vn+Tveq7+FJn
         1j8cjg2kx3BNx0Nne6+2QqeT6RG9vjw5B4R5HIbkhkczEIB7B0HX+jueIcclm1eECwG8
         RKvNn5c0vyVSuAk4S2An7UAhEBfM4n6LdEqumyKT0kOO4Q91yqpt0D2lAXfGlGq5GM5Q
         NSbA==
X-Gm-Message-State: ABy/qLb1YNHIu09NjTJA8fNJHlHYJEBNj2FrC6UlJ16ILwFTvx8CCd3h
	0gZXwkS2MpBsAd8/uns5thjzcAC5vFlyY20sbHusvUKC2GvT8w5B7T1/xRJvJtgj1VqqdPJIwKg
	0M9w8sJo6vJon/R0uHvkZHFFNincqqkOAFCMbmSO593DkH93hXhxoVA==
X-Google-Smtp-Source: APBJJlHeXxtz3BP3wai++0ifRHd3JODi6fE/XVHM6CfcNY98GICNHB7/Fq23fcbP5Vzo8mxIMRDY1/k=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:3855:0:b0:543:b015:600b with SMTP id
 h21-20020a633855000000b00543b015600bmr2817pgn.8.1690328124075; Tue, 25 Jul
 2023 16:35:24 -0700 (PDT)
Date: Tue, 25 Jul 2023 16:35:16 -0700
In-Reply-To: <20230725233517.2614868-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230725233517.2614868-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725233517.2614868-4-sdf@google.com>
Subject: [PATCH net-next 3/4] ynl: regenerate all headers
From: Stanislav Fomichev <sdf@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Also add small (and simple - no dependencies) makefile rule do update
the UAPI ones.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/uapi/linux/netdev.h           |  4 +++-
 tools/net/ynl/Makefile                | 10 ++++++++++
 tools/net/ynl/generated/netdev-user.c |  6 ++++++
 tools/net/ynl/generated/netdev-user.h |  2 ++
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index bf71698a1e82..1a2f6e320f1c 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -11,7 +11,7 @@
 
 /**
  * enum netdev_xdp_act
- * @NETDEV_XDP_ACT_BASIC: XDP feautues set supported by all drivers
+ * @NETDEV_XDP_ACT_BASIC: XDP features set supported by all drivers
  *   (XDP_ABORTED, XDP_DROP, XDP_PASS, XDP_TX)
  * @NETDEV_XDP_ACT_REDIRECT: The netdev supports XDP_REDIRECT
  * @NETDEV_XDP_ACT_NDO_XMIT: This feature informs if netdev implements
@@ -34,6 +34,8 @@ enum netdev_xdp_act {
 	NETDEV_XDP_ACT_RX_SG = 32,
 	NETDEV_XDP_ACT_NDO_XMIT_SG = 64,
 
+	/* private: */
+
 	NETDEV_XDP_ACT_MASK = 127,
 };
 
diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index d664b36deb5b..f4eacafa9665 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -1,5 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
+DIR_SPEC:=../../../Documentation/netlink/specs
+DIR_UAPI:=../../../include/uapi/linux
+SPECS:=netdev fou handshake
+TOOL:=./ynl-gen-c.py
+
 SUBDIRS = lib generated samples
 
 all: $(SUBDIRS)
@@ -16,4 +21,9 @@ all: $(SUBDIRS)
 		fi \
 	done
 
+generate:
+	for spec in $(SPECS); do \
+		$(TOOL) --spec $(DIR_SPEC)/$$spec.yaml --header --mode uapi > $(DIR_UAPI)/$$spec.h; \
+	done
+
 .PHONY: clean all $(SUBDIRS)
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index 4eb8aefef0cd..68b408ca0f7f 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -50,6 +50,7 @@ struct ynl_policy_attr netdev_dev_policy[NETDEV_A_DEV_MAX + 1] = {
 	[NETDEV_A_DEV_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
 	[NETDEV_A_DEV_PAD] = { .name = "pad", .type = YNL_PT_IGNORE, },
 	[NETDEV_A_DEV_XDP_FEATURES] = { .name = "xdp-features", .type = YNL_PT_U64, },
+	[NETDEV_A_DEV_XDP_ZC_MAX_SEGS] = { .name = "xdp-zc-max-segs", .type = YNL_PT_U32, },
 };
 
 struct ynl_policy_nest netdev_dev_nest = {
@@ -91,6 +92,11 @@ int netdev_dev_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
 				return MNL_CB_ERROR;
 			dst->_present.xdp_features = 1;
 			dst->xdp_features = mnl_attr_get_u64(attr);
+		} else if (type == NETDEV_A_DEV_XDP_ZC_MAX_SEGS) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.xdp_zc_max_segs = 1;
+			dst->xdp_zc_max_segs = mnl_attr_get_u32(attr);
 		}
 	}
 
diff --git a/tools/net/ynl/generated/netdev-user.h b/tools/net/ynl/generated/netdev-user.h
index 5554dc69bb9c..0952d3261f4d 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -47,10 +47,12 @@ struct netdev_dev_get_rsp {
 	struct {
 		__u32 ifindex:1;
 		__u32 xdp_features:1;
+		__u32 xdp_zc_max_segs:1;
 	} _present;
 
 	__u32 ifindex;
 	__u64 xdp_features;
+	__u32 xdp_zc_max_segs;
 };
 
 void netdev_dev_get_rsp_free(struct netdev_dev_get_rsp *rsp);
-- 
2.41.0.487.g6d72f3e995-goog


