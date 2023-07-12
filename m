Return-Path: <netdev+bounces-17309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB7C751274
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 23:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4F62817CE
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 21:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466B3E568;
	Wed, 12 Jul 2023 21:14:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34029F9C7
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 21:14:09 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856293C24
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:13:40 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a3efee1d44so22502b6e.3
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689196414; x=1691788414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jR8TmpoIWjIxC9l7Km0HS+0Osfdr7HEjvGTa1/nC/Qk=;
        b=l11OxOU1xwzCu6/fys6ktEy6IF8UJvIQkAitdU3CCtTo7KCw7vtzn1SZiwr6I/9yJh
         rHSiUQT6Cw5FtqmuRLuzM49CDCr6P3TW1wI3L1I+Ms7mPLfUhNWhmTnWdqxqiSRrz1Oe
         jOXKVvzMjfxBmB0GEnSttzlzuii8eCaSRhW7N7uFvXZ6Ehl5dRmzUaxwUT6explPEToR
         U8+dKv87BPrluSzxZC4vCIObROMDeEHB2VRs2H5DV4+r0TLelKnaordm2kJqoNG06G06
         MFPqvsnwzLf2L++AdxskiTj5n+YPMhrb7KhycewxoyhoHFVta+Npza3teOHdxN3xr3PQ
         zXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689196414; x=1691788414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jR8TmpoIWjIxC9l7Km0HS+0Osfdr7HEjvGTa1/nC/Qk=;
        b=YodkvxUbsuO+GMaDuPmq8Kh9PRfiq6uN+4kVpGaejfBnzcQyLe4Cto6GF2qF02fFiU
         YzW8VPHUFY6WdC4IzRatb/L6orvYQuw15Kxaz/51rODbRI4ZKs9CbZIGOTyGO/S4ng3w
         +SIx9zVnZ3DlavI1f5BNRJSFZYgox80OKR9Tf2uetg03o/DrnQOtrgzhup8Wsz6P5tC2
         c+scx+ZCP8gnRTIo43+bUp6Qb3Avs/IJ8gUGzn+WgXOY+whprIFkepbFf2aMeYZndF0k
         mwS+gUIQUOwUvea2S5Qhy84t+ffv70lA/hhX2vTahgh+3Res+8XixBRnHXChPWwMfDh/
         rqcw==
X-Gm-Message-State: ABy/qLYxe7fW8jha7YK8Cg2G7JySkx6iqdWYIscA/wF1uwbGa83wisEW
	T+Urv7pULTvXkEIx6Azr/+x1h2jMWPS4IxXKuuQ=
X-Google-Smtp-Source: APBJJlEZUWyuYnHj1b7scJPU7cPcFDKOPIXlET4REhxDiYOITDlmTkjTlWI7kEf7G9PKrWK2G0rkow==
X-Received: by 2002:a05:6870:c20e:b0:1b0:1c36:97a with SMTP id z14-20020a056870c20e00b001b01c36097amr20681999oae.27.1689196413882;
        Wed, 12 Jul 2023 14:13:33 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c1:1622:34af:d3bb:8e9a:95c5])
        by smtp.gmail.com with ESMTPSA id zh27-20020a0568716b9b00b001a663e49523sm2387213oab.36.2023.07.12.14.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 14:13:33 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pctammela@mojatatu.com,
	simon.horman@corigine.com,
	kernel@mojatatu.com
Subject: [PATCH net-next v4 2/5] net: sched: cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode fails
Date: Wed, 12 Jul 2023 18:13:10 -0300
Message-Id: <20230712211313.545268-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712211313.545268-1-victor@mojatatu.com>
References: <20230712211313.545268-1-victor@mojatatu.com>
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

When u32_replace_hw_knode fails, we need to undo the tcf_bind_filter
operation done at u32_set_parms.

Fixes: d34e3e181395 ("net: cls_u32: Add support for skip-sw flag to tc u32 classifier.")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/cls_u32.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index d15d50de7980..ed358466d042 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -712,8 +712,23 @@ static const struct nla_policy u32_policy[TCA_U32_MAX + 1] = {
 	[TCA_U32_FLAGS]		= { .type = NLA_U32 },
 };
 
+static void u32_unbind_filter(struct tcf_proto *tp, struct tc_u_knode *n,
+			      struct nlattr **tb)
+{
+	if (tb[TCA_U32_CLASSID])
+		tcf_unbind_filter(tp, &n->res);
+}
+
+static void u32_bind_filter(struct tcf_proto *tp, struct tc_u_knode *n,
+			    unsigned long base, struct nlattr **tb)
+{
+	if (tb[TCA_U32_CLASSID]) {
+		n->res.classid = nla_get_u32(tb[TCA_U32_CLASSID]);
+		tcf_bind_filter(tp, &n->res, base);
+	}
+}
+
 static int u32_set_parms(struct net *net, struct tcf_proto *tp,
-			 unsigned long base,
 			 struct tc_u_knode *n, struct nlattr **tb,
 			 struct nlattr *est, u32 flags, u32 fl_flags,
 			 struct netlink_ext_ack *extack)
@@ -760,10 +775,6 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 		if (ht_old)
 			ht_old->refcnt--;
 	}
-	if (tb[TCA_U32_CLASSID]) {
-		n->res.classid = nla_get_u32(tb[TCA_U32_CLASSID]);
-		tcf_bind_filter(tp, &n->res, base);
-	}
 
 	if (ifindex >= 0)
 		n->ifindex = ifindex;
@@ -903,17 +914,20 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		if (!new)
 			return -ENOMEM;
 
-		err = u32_set_parms(net, tp, base, new, tb,
-				    tca[TCA_RATE], flags, new->flags,
-				    extack);
+		err = u32_set_parms(net, tp, new, tb, tca[TCA_RATE],
+				    flags, new->flags, extack);
 
 		if (err) {
 			__u32_destroy_key(new);
 			return err;
 		}
 
+		u32_bind_filter(tp, new, base, tb);
+
 		err = u32_replace_hw_knode(tp, new, flags, extack);
 		if (err) {
+			u32_unbind_filter(tp, new, tb);
+
 			__u32_destroy_key(new);
 			return err;
 		}
@@ -1074,15 +1088,18 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 	}
 #endif
 
-	err = u32_set_parms(net, tp, base, n, tb, tca[TCA_RATE],
+	err = u32_set_parms(net, tp, n, tb, tca[TCA_RATE],
 			    flags, n->flags, extack);
+
+	u32_bind_filter(tp, n, base, tb);
+
 	if (err == 0) {
 		struct tc_u_knode __rcu **ins;
 		struct tc_u_knode *pins;
 
 		err = u32_replace_hw_knode(tp, n, flags, extack);
 		if (err)
-			goto errhw;
+			goto errunbind;
 
 		if (!tc_in_hw(n->flags))
 			n->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
@@ -1100,7 +1117,9 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		return 0;
 	}
 
-errhw:
+errunbind:
+	u32_unbind_filter(tp, n, tb);
+
 #ifdef CONFIG_CLS_U32_MARK
 	free_percpu(n->pcpu_success);
 #endif
-- 
2.25.1


