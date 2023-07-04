Return-Path: <netdev+bounces-15391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779E5747514
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 17:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72C71C20A4D
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 15:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108276AA6;
	Tue,  4 Jul 2023 15:15:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057F46AA4
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 15:15:10 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9611E6D
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 08:15:09 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b71cdb47e1so4738303a34.2
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688483709; x=1691075709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKmtpqIhXSx8wadQszqTZuxelRNDNDAGxDUQa+qcRfw=;
        b=faB8ugSv8pnCSpjfun6cKQvb2sYUIBVyF+wq3C3iAUMwIWbQs6d4f6jlLlyrtcyDa3
         I+4IwmxxBjqmF5xUmPO2pCbxFiRlhMJ5FqJ2Dob3aUbSarUpbr0q/YpRzUCAcRbcBR25
         DqnZqv5KNG27IlvRLPRyGGLl3UZd78q/hFVDtMleliKivd+SyRPdgdHAZyQU32uJX6YF
         UgkvVixLbMN8JsIshCsocx7bPZWInv9Ct2mYsutWSz0zJYB5sEVQR7Tp24CE6c20zbo8
         rgb0xZPyn1JQbO60cYghvcx17AUxSQQSALPbqx5PyagMjlmqgelIOsMIiErhvuybph+f
         +1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688483709; x=1691075709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKmtpqIhXSx8wadQszqTZuxelRNDNDAGxDUQa+qcRfw=;
        b=OmDXTWFJaW8dVoAYx8c9zrMCNUrV7b7+Vo3P/waU0oc4W+5ZxRePKl8Sq1Rp4NVifR
         SQY97sx5NobNHvAqsrVmnaRSSmrM3AuLNu7y01QMffHIPsoTxqVYDl9bo/7oWlf0pY7X
         sWn6+FaqxepEVGxOv5FF15Lw9vfI7FqbdToL4H00QA923BjiCArfFO5OSKRRrcmE3tiJ
         /Pd8ojLnWFTT1DQPPh3fG9tnWsN3i9otduFIxE5DjZK3dWvUnhiqZCLjJgtAw8ZIpBCZ
         fuDGTOmJzx41inGdb5vwMJ7ck+jU8Um+u4+67TuLCkwdS3jvxeQX3CyZAreiSne5vsEy
         zXDA==
X-Gm-Message-State: AC+VfDzCTSKaTcuWG4QGw7w308nJG8Owv6PaCvjZ68ySzwHApWzkkSqQ
	RJ/lTcKBBlxiuUd1FC6MkRje4LjdST3k8Jf8oh4=
X-Google-Smtp-Source: ACHHUZ4656Sl9Hgy32VhaMfx5/2vR86xKfZdIYwrCZqCPihBuZACNxQFvIO5JGBqYtKXJId2o6jGlw==
X-Received: by 2002:a05:6830:1ce:b0:6b8:9547:a64 with SMTP id r14-20020a05683001ce00b006b895470a64mr14682672ota.3.1688483709006;
        Tue, 04 Jul 2023 08:15:09 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c0:f126:5457:8acf:73e7:5bf2])
        by smtp.gmail.com with ESMTPSA id s1-20020a9d7581000000b006b8abc7a738sm3946146otk.69.2023.07.04.08.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:15:08 -0700 (PDT)
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
	kernel@mojatatu.com
Subject: [PATCH net 1/5] net: sched: cls_bpf: Undo tcf_bind_filter in case of an error
Date: Tue,  4 Jul 2023 12:14:52 -0300
Message-Id: <20230704151456.52334-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230704151456.52334-1-victor@mojatatu.com>
References: <20230704151456.52334-1-victor@mojatatu.com>
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

If cls_bpf_offload errors out, we must also undo tcf_bind_filter that
was done in cls_bpf_set_parms.

Fix that by calling tcf_unbind_filter in errout_parms.

Fixes: eadb41489fd2 ("net: cls_bpf: add support for marking filters as hardware-only")

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/cls_bpf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 466c26df853a..4d9974b1b29d 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -409,7 +409,7 @@ static int cls_bpf_prog_from_efd(struct nlattr **tb, struct cls_bpf_prog *prog,
 static int cls_bpf_set_parms(struct net *net, struct tcf_proto *tp,
 			     struct cls_bpf_prog *prog, unsigned long base,
 			     struct nlattr **tb, struct nlattr *est, u32 flags,
-			     struct netlink_ext_ack *extack)
+			     bool *bound_to_filter, struct netlink_ext_ack *extack)
 {
 	bool is_bpf, is_ebpf, have_exts = false;
 	u32 gen_flags = 0;
@@ -451,6 +451,7 @@ static int cls_bpf_set_parms(struct net *net, struct tcf_proto *tp,
 	if (tb[TCA_BPF_CLASSID]) {
 		prog->res.classid = nla_get_u32(tb[TCA_BPF_CLASSID]);
 		tcf_bind_filter(tp, &prog->res, base);
+		*bound_to_filter = true;
 	}
 
 	return 0;
@@ -464,6 +465,7 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 {
 	struct cls_bpf_head *head = rtnl_dereference(tp->root);
 	struct cls_bpf_prog *oldprog = *arg;
+	bool bound_to_filter = false;
 	struct nlattr *tb[TCA_BPF_MAX + 1];
 	struct cls_bpf_prog *prog;
 	int ret;
@@ -505,7 +507,7 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 	prog->handle = handle;
 
 	ret = cls_bpf_set_parms(net, tp, prog, base, tb, tca[TCA_RATE], flags,
-				extack);
+				&bound_to_filter, extack);
 	if (ret < 0)
 		goto errout_idr;
 
@@ -530,6 +532,8 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 	return 0;
 
 errout_parms:
+	if (bound_to_filter)
+		tcf_unbind_filter(tp, &prog->res);
 	cls_bpf_free_parms(prog);
 errout_idr:
 	if (!oldprog)
-- 
2.25.1


