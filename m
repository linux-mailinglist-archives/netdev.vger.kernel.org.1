Return-Path: <netdev+bounces-16290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8169E74C661
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 18:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8F8281064
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 16:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A35AD38;
	Sun,  9 Jul 2023 16:14:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B394C8D8
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 16:14:05 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ED6FD
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 09:14:04 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b91ad1f9c1so1618497a34.3
        for <netdev@vger.kernel.org>; Sun, 09 Jul 2023 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688919242; x=1691511242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrmcrsB6GdmBQ8Bxdcvf/nYXxvLLKAGYW3qevw4D/g8=;
        b=Eht/zodhJqnkk8On3R3wmlwt66UdnkEpCQLVphf05QXaVRKaVKjFrgO61Q0N5D6dMG
         uW96lBwbWw4DDhiEb6lF+BkDrviOemIOfUSY9Znghha4PJ6CbVgPYzARaGkMXmCDQKqv
         QUsenOeuzakzGVlp2/034UY/OlFL/00uTo6csr7Mr6M/mbl7/1Jq4KebZD9icjYJHZRL
         95mqWy6/7ZxWnmrctRLWHXJkoXtxv3f0awc1q5I1vMWxxCGN5kg/6cdp30K3tT402ylo
         fPZehkWmGvyndoAHcLTVXUZZ6VUNvYT5h27zCA84p+aIx7QPr/+VSP3IhmxXxMv0t1XH
         d51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688919242; x=1691511242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrmcrsB6GdmBQ8Bxdcvf/nYXxvLLKAGYW3qevw4D/g8=;
        b=d8Wki+QYgwsz1sMQqeBsz9Vqy7j/31x0HFycCPAuvpWAhVm+BlPSQkRSFiSgv53tOz
         aBoz04gTqp0ibP/HlDKwmZL5tKIu02GlSM7IvnBjZ3yzEG0duMs4G0C0WNSqxH5iwZk4
         oVIFyO9fBYeZkBrPniNPWgtHicfLHP3Oz1d0SV6GaqZWdi0BQOlrO2LP7InuOJi4b53z
         4lpaIkSdaNnBFldG9PeczC5gWirWyOLcIj2sFDKTjHBXNCyHUP4tYbRAiER4UOQE4T+h
         QsWnqRbMGF0l+qAbJldbkuk5A0fp+F9zoh++PencjkL0Wz3rUh5ayLPchWoXMS2VOgbT
         Hi+g==
X-Gm-Message-State: ABy/qLaNdRN3gYl1SozRMRRWhTgejKNSc64ugddGbg8eZ4pKM66Q/KS2
	KqA/MY/R54RcayLF0nqwFXcYfALWQIo8rXHU+Z8=
X-Google-Smtp-Source: APBJJlG4wgxUoLd+K314RpmxPGrOmy1LevsdZUQlotH6nelIlu9GsIbOlnw7X8tcy0/oECdbr1wvFg==
X-Received: by 2002:a05:6808:130c:b0:3a3:65a8:c12f with SMTP id y12-20020a056808130c00b003a365a8c12fmr10085463oiv.16.1688919242609;
        Sun, 09 Jul 2023 09:14:02 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c1:1622:34af:d3bb:8e9a:95c5])
        by smtp.gmail.com with ESMTPSA id w14-20020a056808140e00b003a1efec1a6esm3391617oiv.46.2023.07.09.09.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 09:14:02 -0700 (PDT)
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
Subject: [PATCH net v3 1/2] net: sched: cls_bpf: Undo tcf_bind_filter in case of an error
Date: Sun,  9 Jul 2023 13:13:49 -0300
Message-Id: <20230709161350.347064-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230709161350.347064-1-victor@mojatatu.com>
References: <20230709161350.347064-1-victor@mojatatu.com>
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


