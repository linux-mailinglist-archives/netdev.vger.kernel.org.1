Return-Path: <netdev+bounces-17311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35537751276
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 23:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E624F281A7C
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 21:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0414AF9E4;
	Wed, 12 Jul 2023 21:14:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75B8F9C7
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 21:14:10 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872C32D44
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:13:45 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1b055511f8bso798544fac.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689196420; x=1691788420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrmcrsB6GdmBQ8Bxdcvf/nYXxvLLKAGYW3qevw4D/g8=;
        b=iKfK9U9QVVdf4xOt7WdAmZNA6yNTTXWLcBihDiiz+139vLaIni2APyTyScGNMC6Fym
         Ua+P+NaKoW6knbiLd0O2XF+ZQrz8zg8LOw6T9PRRNloBWk9k1k+5HNPjWw4Bg/gLoW89
         2fNpERuhKvm98y3PlDOnaF41aihXcKFMgfjE7H4WwrePFR1KZhNDY7dKqmYc094WtKa5
         RaG8MHUspbS81p7gVSGhxeOEAmMsBJDIjQD3ij0NxnAONzvdsrIJNuagbdIvJmJ1u3eO
         HB4i+V3N3qIvU3/j2xpZ+TATAp6JvR45dEhWEbXLuB7skJ+ifwfme6H/cy6QFg/0mQoh
         ymJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689196420; x=1691788420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrmcrsB6GdmBQ8Bxdcvf/nYXxvLLKAGYW3qevw4D/g8=;
        b=bhwh2UpycBu3oBtjnbA9LGEut0RtGTR+fFUu4Ner4HSRQjw46mA0UWYRKxWlFQ8TAV
         HaS8NQ+IaNYbjREzfRiacuS9StTi7rZVNafN/AB2xd8glInkOwnVjpfZyDDAhK+m1PIw
         CL2Xzot/e89burRlac3JB3nduSs27yrDic9LDwli/v4lOWrE4tJhPtvma7VNK3CPgGCe
         2bEO8oo63TBeTx/AroLEgk03pF8jmyIQWQ0Q2ItyzWyPR+qfjaLpbdfWQWu/Sal1IE0k
         Kd06VPBFdeelda41+4a4ojUZeojozIOTZmhbQVb6+HcgpR+d9G6eYtlAQND0rcG3hLlV
         43pg==
X-Gm-Message-State: ABy/qLa6nrMGm3FiNQdbr0E4HYAxDhG5lK4CxXJJBEuG4OGaYChb3tQw
	NXo7McPhpW2TZPYlqSzMWYVC8yHQ3AIQ9kXxZzc=
X-Google-Smtp-Source: APBJJlGENWZB8GU+SD2PU9LTzkBS4gVZfjYlwX1rZ9UDRp7qc2PlsnI2R8Ek0MNbMUDvTXIvz7iynQ==
X-Received: by 2002:a05:6870:5611:b0:1b0:35a6:5ac6 with SMTP id m17-20020a056870561100b001b035a65ac6mr2179394oao.17.1689196420419;
        Wed, 12 Jul 2023 14:13:40 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c1:1622:34af:d3bb:8e9a:95c5])
        by smtp.gmail.com with ESMTPSA id zh27-20020a0568716b9b00b001a663e49523sm2387213oab.36.2023.07.12.14.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 14:13:40 -0700 (PDT)
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
Subject: [PATCH net-next v4 4/5] net: sched: cls_bpf: Undo tcf_bind_filter in case of an error
Date: Wed, 12 Jul 2023 18:13:12 -0300
Message-Id: <20230712211313.545268-5-victor@mojatatu.com>
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

If cls_bpf_offload errors out, we must also undo tcf_bind_filter that
was done before the error.

Fix that by calling tcf_unbind_filter in errout_parms.

Fixes: eadb41489fd2 ("net: cls_bpf: add support for marking filters as hardware-only")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
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


