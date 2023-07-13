Return-Path: <netdev+bounces-17672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBF5752A25
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 20:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7A61C2142F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94208200BC;
	Thu, 13 Jul 2023 18:05:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83483200B3
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 18:05:41 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3F02728
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 11:05:39 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-565f8e359b8so731110eaf.2
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 11:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689271539; x=1691863539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlIZocve4fJZ8/+M2tU4BiuJM8y43OIzDZI1VHdaM28=;
        b=Kv816XtlYe+q+gKcX+1svviN42DSmR+VZPadnxkzYUhjHcw5JAGEojL/zd+e4y4qS5
         Zv26ztXDuiwt/pEC5NY8+ZzXrN3dEtGt2+Sj6H46PJEKEySPjhaeKJ5JtoyB+k5CHq8p
         vAtqpBQzaaT1QB5KeuhGPBlBej6EHe9bWXD6kyJUz65s08FCCwgy2tXBb9d1acF6IdjI
         d2Azz48X8C/RQSVG98di5e3h0FcF1hG33Ox5kRkLqCihJ32ZmCgOXFicI3+C3rEIdAYD
         kr+K++Tax930Xsp5saYzSCe9pEZ+vwUeurlAF2vOvBZ0R2nrTvKRr3NYQNU93C24AaE3
         lA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689271539; x=1691863539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlIZocve4fJZ8/+M2tU4BiuJM8y43OIzDZI1VHdaM28=;
        b=FrfZS82E3zR/oJQ3+O8/wgHtcjhQgo5l61Io//UiD3sl/euslpqWsrIFS70yYZ6vuW
         onrQdcJf2v/rcP1JycbH8DoQy92S83cojFUtfEe+B+0cDOPzkdWhivgoRRwC40CTAr2P
         mdMDTAFvoB6mTj5g1whsRLDNSeQGyYXQ36A6IXflKsArXAYDjHH+8U8PYfYtv3MJNryt
         ortKcOVg9NVHjtFvwLh865SYoUs/bszJTGmNQwZSHxvOOv22PoQ+uzgjE4djqfhkDzhh
         8+VuaY80KZhP1JHm7YbrSfD6SATw813H+/qCrCYgjHsoOubhKU6N7r3gPX1YET94xv0h
         2X+w==
X-Gm-Message-State: ABy/qLZVA50nSrOHk7Aqx5h9NAcf4/4jNriReqaDGHlRuFJgvuY9t9sH
	42aJccxog2OIGz7xKuK4qmYo5+/U65ShY7A29oE=
X-Google-Smtp-Source: APBJJlFnnxS4cAfRPkQgiRmJbUX29jt7mrI9P4gEpQdjj0EQvhcwl7A+16wS5N6HozJBIbE5VgyVbA==
X-Received: by 2002:a4a:2517:0:b0:566:fd47:eb5 with SMTP id g23-20020a4a2517000000b00566fd470eb5mr1992784ooa.0.1689271538869;
        Thu, 13 Jul 2023 11:05:38 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c1:1622:34af:d3bb:8e9a:95c5])
        by smtp.gmail.com with ESMTPSA id t65-20020a4a5444000000b005660b585a00sm3175299ooa.22.2023.07.13.11.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 11:05:38 -0700 (PDT)
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
Subject: [PATCH net v5 4/5] net: sched: cls_bpf: Undo tcf_bind_filter in case of an error
Date: Thu, 13 Jul 2023 15:05:13 -0300
Message-Id: <20230713180514.592812-5-victor@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713180514.592812-1-victor@mojatatu.com>
References: <20230713180514.592812-1-victor@mojatatu.com>
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

If cls_bpf_offload errors out, we must also undo tcf_bind_filter that
was done before the error.

Fix that by calling tcf_unbind_filter in errout_parms.

Fixes: eadb41489fd2 ("net: cls_bpf: add support for marking filters as hardware-only")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 net/sched/cls_bpf.c | 99 +++++++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 52 deletions(-)

diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 466c26df853a..382c7a71f81f 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -406,56 +406,6 @@ static int cls_bpf_prog_from_efd(struct nlattr **tb, struct cls_bpf_prog *prog,
 	return 0;
 }
 
-static int cls_bpf_set_parms(struct net *net, struct tcf_proto *tp,
-			     struct cls_bpf_prog *prog, unsigned long base,
-			     struct nlattr **tb, struct nlattr *est, u32 flags,
-			     struct netlink_ext_ack *extack)
-{
-	bool is_bpf, is_ebpf, have_exts = false;
-	u32 gen_flags = 0;
-	int ret;
-
-	is_bpf = tb[TCA_BPF_OPS_LEN] && tb[TCA_BPF_OPS];
-	is_ebpf = tb[TCA_BPF_FD];
-	if ((!is_bpf && !is_ebpf) || (is_bpf && is_ebpf))
-		return -EINVAL;
-
-	ret = tcf_exts_validate(net, tp, tb, est, &prog->exts, flags,
-				extack);
-	if (ret < 0)
-		return ret;
-
-	if (tb[TCA_BPF_FLAGS]) {
-		u32 bpf_flags = nla_get_u32(tb[TCA_BPF_FLAGS]);
-
-		if (bpf_flags & ~TCA_BPF_FLAG_ACT_DIRECT)
-			return -EINVAL;
-
-		have_exts = bpf_flags & TCA_BPF_FLAG_ACT_DIRECT;
-	}
-	if (tb[TCA_BPF_FLAGS_GEN]) {
-		gen_flags = nla_get_u32(tb[TCA_BPF_FLAGS_GEN]);
-		if (gen_flags & ~CLS_BPF_SUPPORTED_GEN_FLAGS ||
-		    !tc_flags_valid(gen_flags))
-			return -EINVAL;
-	}
-
-	prog->exts_integrated = have_exts;
-	prog->gen_flags = gen_flags;
-
-	ret = is_bpf ? cls_bpf_prog_from_ops(tb, prog) :
-		       cls_bpf_prog_from_efd(tb, prog, gen_flags, tp);
-	if (ret < 0)
-		return ret;
-
-	if (tb[TCA_BPF_CLASSID]) {
-		prog->res.classid = nla_get_u32(tb[TCA_BPF_CLASSID]);
-		tcf_bind_filter(tp, &prog->res, base);
-	}
-
-	return 0;
-}
-
 static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 			  struct tcf_proto *tp, unsigned long base,
 			  u32 handle, struct nlattr **tca,
@@ -463,9 +413,12 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 			  struct netlink_ext_ack *extack)
 {
 	struct cls_bpf_head *head = rtnl_dereference(tp->root);
+	bool is_bpf, is_ebpf, have_exts = false;
 	struct cls_bpf_prog *oldprog = *arg;
 	struct nlattr *tb[TCA_BPF_MAX + 1];
+	bool bound_to_filter = false;
 	struct cls_bpf_prog *prog;
+	u32 gen_flags = 0;
 	int ret;
 
 	if (tca[TCA_OPTIONS] == NULL)
@@ -504,11 +457,51 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 		goto errout;
 	prog->handle = handle;
 
-	ret = cls_bpf_set_parms(net, tp, prog, base, tb, tca[TCA_RATE], flags,
-				extack);
+	is_bpf = tb[TCA_BPF_OPS_LEN] && tb[TCA_BPF_OPS];
+	is_ebpf = tb[TCA_BPF_FD];
+	if ((!is_bpf && !is_ebpf) || (is_bpf && is_ebpf)) {
+		ret = -EINVAL;
+		goto errout_idr;
+	}
+
+	ret = tcf_exts_validate(net, tp, tb, tca[TCA_RATE], &prog->exts,
+				flags, extack);
+	if (ret < 0)
+		goto errout_idr;
+
+	if (tb[TCA_BPF_FLAGS]) {
+		u32 bpf_flags = nla_get_u32(tb[TCA_BPF_FLAGS]);
+
+		if (bpf_flags & ~TCA_BPF_FLAG_ACT_DIRECT) {
+			ret = -EINVAL;
+			goto errout_idr;
+		}
+
+		have_exts = bpf_flags & TCA_BPF_FLAG_ACT_DIRECT;
+	}
+	if (tb[TCA_BPF_FLAGS_GEN]) {
+		gen_flags = nla_get_u32(tb[TCA_BPF_FLAGS_GEN]);
+		if (gen_flags & ~CLS_BPF_SUPPORTED_GEN_FLAGS ||
+		    !tc_flags_valid(gen_flags)) {
+			ret = -EINVAL;
+			goto errout_idr;
+		}
+	}
+
+	prog->exts_integrated = have_exts;
+	prog->gen_flags = gen_flags;
+
+	ret = is_bpf ? cls_bpf_prog_from_ops(tb, prog) :
+		cls_bpf_prog_from_efd(tb, prog, gen_flags, tp);
 	if (ret < 0)
 		goto errout_idr;
 
+	if (tb[TCA_BPF_CLASSID]) {
+		prog->res.classid = nla_get_u32(tb[TCA_BPF_CLASSID]);
+		tcf_bind_filter(tp, &prog->res, base);
+		bound_to_filter = true;
+	}
+
 	ret = cls_bpf_offload(tp, prog, oldprog, extack);
 	if (ret)
 		goto errout_parms;
@@ -530,6 +523,8 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 	return 0;
 
 errout_parms:
+	if (bound_to_filter)
+		tcf_unbind_filter(tp, &prog->res);
 	cls_bpf_free_parms(prog);
 errout_idr:
 	if (!oldprog)
-- 
2.25.1


