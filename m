Return-Path: <netdev+bounces-21986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533CE7658AB
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7463D1C215A7
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B581AA8D;
	Thu, 27 Jul 2023 16:30:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2561DA33
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 16:30:11 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC2F26AB
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:30:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d063bd0bae8so1089363276.0
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690475409; x=1691080209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/gMp5cncclcfe3yDM/AM8QV7eRFWNySks3s4/US2Rvk=;
        b=Z7WLT/n68JDpFlkRwTbC1LI+rELxk3nrYBFmwHH5r1LH56hHkUQjKefYUei2wu3lzZ
         MyClCUS6P3N0EHRIAlkCcdg8Ns3oj1g6E2XakcNOMoPgZY0TwMT3eG0xFwuUeBkBrv9k
         3hzQTHFwC6OCJD92oKazw8q9QkCXZZ3AdeSfOFtGAIfQJphBNT3dBTolKn2xfZ9ZRxEl
         +FncUckjk1Usk4lRc0/T7+anAYMntduDqFgOspQGlD9yO1Hlbi3dw955jae0m+AXakL6
         D19o9LjYF/t2wHGHBcx1RqSdgd94vMQkcCyS11fQjL2Ze5JQo8ac5aOA06PqcILheUKE
         4cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690475409; x=1691080209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gMp5cncclcfe3yDM/AM8QV7eRFWNySks3s4/US2Rvk=;
        b=OixaG5SXxMB4xwBSG2MrDnLKrEejdjCGJ2txNSinGTyL2BdcxZ8LHpJX+ult6RPlHN
         5P5ocwb6NondKzksnMOEOZ/cewyE91Ybuv4eWqQN/J0f1ApMH99ORiDreGAhvrbztY2r
         s2HHTO7ksjb3MrrxKiWnWitWnMEiJDiZh1hZdMfDFcyyDkUAhMu/fEExbMA6VyrirGXO
         zx+UATHwpmR1iFMLFJcPHgYqeGG1NDkKmedXUKdgNru8sYUQ7NjLAdWfX+DV2dp1wqJV
         R0fLImjnM7WsVLif9a0GSdm9/9Y+cMeC/YcDV/K0IOkjBt1QQrYv0Lnbd0U9a9EsEb11
         uDmA==
X-Gm-Message-State: ABy/qLYoRvGORzINt0FSrbIBQXgr3b9ZXiZmbJdU/k5ZoGApX7PDV16m
	0w883jphmTAQIPB9WMTxCL2InKNyW451nWhN3C6MFT5vhQY98i9vlz/l3HUnpBF6D98B9YEWIog
	+xkc9C5VZQYtNwTYjuHW0YFU/dCfSPVJuqPUS6AIAK1mwXyktHRTCrA==
X-Google-Smtp-Source: APBJJlHF5gdoI8Ij9WsEwnbXgJyV+tsiaR2Vnn4npkX8tmZX5kI3Q7JfHZ6TYwVzMWcunVjGruKIeYs=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:1c9:b0:c78:c530:6345 with SMTP id
 u9-20020a05690201c900b00c78c5306345mr34119ybh.7.1690475408756; Thu, 27 Jul
 2023 09:30:08 -0700 (PDT)
Date: Thu, 27 Jul 2023 09:30:00 -0700
In-Reply-To: <20230727163001.3952878-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230727163001.3952878-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230727163001.3952878-4-sdf@google.com>
Subject: [PATCH net-next v2 3/4] ynl: regenerate all headers
From: Stanislav Fomichev <sdf@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Also add support to pass topdir to ynl-regen.sh (Jakub) and call
it from the makefile to update the UAPI headers.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
Co-developed-by: Jakub Kicinski <kuba@kernel.org>
---
 include/uapi/linux/netdev.h           | 3 ++-
 tools/include/uapi/linux/netdev.h     | 3 ++-
 tools/net/ynl/Makefile                | 1 +
 tools/net/ynl/generated/netdev-user.c | 6 ++++++
 tools/net/ynl/generated/netdev-user.h | 2 ++
 tools/net/ynl/ynl-regen.sh            | 5 +++++
 6 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index bf71698a1e82..c1634b95c223 100644
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
@@ -34,6 +34,7 @@ enum netdev_xdp_act {
 	NETDEV_XDP_ACT_RX_SG = 32,
 	NETDEV_XDP_ACT_NDO_XMIT_SG = 64,
 
+	/* private: */
 	NETDEV_XDP_ACT_MASK = 127,
 };
 
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index bf71698a1e82..c1634b95c223 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -11,7 +11,7 @@
 
 /**
  * enum netdev_xdp_act
- * @NETDEV_XDP_ACT_BASIC: XDP feautues set supported by all drivers
+ * @NETDEV_XDP_ACT_BASIC: XDP features set supported by all drivers
  *   (XDP_ABORTED, XDP_DROP, XDP_PASS, XDP_TX)
  * @NETDEV_XDP_ACT_REDIRECT: The netdev supports XDP_REDIRECT
  * @NETDEV_XDP_ACT_NDO_XMIT: This feature informs if netdev implements
@@ -34,6 +34,7 @@ enum netdev_xdp_act {
 	NETDEV_XDP_ACT_RX_SG = 32,
 	NETDEV_XDP_ACT_NDO_XMIT_SG = 64,
 
+	/* private: */
 	NETDEV_XDP_ACT_MASK = 127,
 };
 
diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index d664b36deb5b..8156f03e23ac 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -3,6 +3,7 @@
 SUBDIRS = lib generated samples
 
 all: $(SUBDIRS)
+	./ynl-regen.sh -f -p $(PWD)/../../../
 
 $(SUBDIRS):
 	@if [ -f "$@/Makefile" ] ; then \
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
diff --git a/tools/net/ynl/ynl-regen.sh b/tools/net/ynl/ynl-regen.sh
index 8d4ca6a50582..bdba24066cf1 100755
--- a/tools/net/ynl/ynl-regen.sh
+++ b/tools/net/ynl/ynl-regen.sh
@@ -4,15 +4,18 @@
 TOOL=$(dirname $(realpath $0))/ynl-gen-c.py
 
 force=
+search=
 
 while [ ! -z "$1" ]; do
   case "$1" in
     -f ) force=yes; shift ;;
+    -p ) search=$2; shift 2 ;;
     * )  echo "Unrecognized option '$1'"; exit 1 ;;
   esac
 done
 
 KDIR=$(dirname $(dirname $(dirname $(dirname $(realpath $0)))))
+pushd ${search:-$KDIR} >>/dev/null
 
 files=$(git grep --files-with-matches '^/\* YNL-GEN \(kernel\|uapi\|user\)')
 for f in $files; do
@@ -30,3 +33,5 @@ for f in $files; do
     $TOOL --mode ${params[2]} --${params[3]} --spec $KDIR/${params[0]} \
 	  $args -o $f
 done
+
+popd >>/dev/null
-- 
2.41.0.487.g6d72f3e995-goog


