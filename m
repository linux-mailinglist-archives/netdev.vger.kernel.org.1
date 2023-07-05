Return-Path: <netdev+bounces-15544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC4B748545
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 15:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD41E1C20B26
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 13:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D3AC8FD;
	Wed,  5 Jul 2023 13:43:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BBDD30E
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 13:43:44 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACE6BA
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 06:43:43 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b883e1e9d5so4036154a34.1
        for <netdev@vger.kernel.org>; Wed, 05 Jul 2023 06:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688564623; x=1691156623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YH/+HHBZpaYq82Xv1Y/dmkD7CI2WEhzUomatclhV1OY=;
        b=0salLUuZUjgpspp2LveFMPCWZbzT+J6P6GMN3/cbZQ7zoQkikAcNDBnHxviQ/2SqhS
         BhI3v11iFf2C2PwYnSVrzPLSXoGng4r7UT19o8Gi39qbN1PQ5c+Aanw7sISETwP5PkJ4
         rdBFqkGV/4dPRRuHJjgogt5r5ZEZ7rccAEUaNvc+L4YjNNF61iTarQNDH4dZTsLXh9VP
         3jUigK+2L6M6XwfIeb12lLlXITsfwo1CRbqDFks+BIU3A7X2V8Gc9jELuqiusOIajDzU
         IXsMPOpxu9igIwG0tgOAU6tGGTT8W1tViAkOC0wiZWTS01OorfMWS8vpxyZICwN28KSL
         RElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688564623; x=1691156623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YH/+HHBZpaYq82Xv1Y/dmkD7CI2WEhzUomatclhV1OY=;
        b=HATgWG5bSPrY0kLzBRDJfnS8Jv0ZrT8U4xFediZ3JvjO8bXPaN7Pm2Dr5XyRV+Vf8q
         hOi4Hu01ZorxOLrnnF2DBLa/6jCwuaGxC36ZDCk5SvyGFaZYtv91hP6s6J74kyS0J5W6
         Mqgz35NOtHTDU0DPB4UxbRwVmsw4sg8OuIcBiNeD4VT8N9B9mIIGLw2nU2uzSjRCZ0It
         1X5p8J4gohZvhi3pU6D+a1jp0luaR4KUqaHvTeBZxTycEbQBbUR15Le8QPUpEPu3pM4F
         j0cLrGrTRWoY48/L4XrxQghoah51FgmB6oDcZjMFCINPrQ3LXAHv1zGaWMUXKqIxWdsW
         7eUQ==
X-Gm-Message-State: AC+VfDxNkDwg1UV61aXPlDF2MkV/orm8WROO436AaspKRn2yZpTb4WWD
	MlcIXxS7cn3iR+VNRxtAqGlNsU7XvxAvE+Tpnks=
X-Google-Smtp-Source: ACHHUZ6Rg5H9Yadi/fUPhQm2dmrhi18NpncaB51ACMWKhhPPBYM593dSfYTUkM2/FI0n9oUk/MH2UQ==
X-Received: by 2002:a05:6830:1d62:b0:6b8:80f6:5f49 with SMTP id l2-20020a0568301d6200b006b880f65f49mr12435350oti.14.1688564622818;
        Wed, 05 Jul 2023 06:43:42 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c0:f126:5457:8acf:73e7:5bf2])
        by smtp.gmail.com with ESMTPSA id n11-20020a9d740b000000b006b73b6b738esm4516450otk.36.2023.07.05.06.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 06:43:42 -0700 (PDT)
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
Subject: [PATCH net v2 1/5] net: sched: cls_bpf: Undo tcf_bind_filter in case of an error
Date: Wed,  5 Jul 2023 10:43:25 -0300
Message-Id: <20230705134329.102345-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230705134329.102345-1-victor@mojatatu.com>
References: <20230705134329.102345-1-victor@mojatatu.com>
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
---
 net/sched/cls_bpf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 466c26df853a..c45321fb3a5e 100644
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
@@ -465,6 +466,7 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 	struct cls_bpf_head *head = rtnl_dereference(tp->root);
 	struct cls_bpf_prog *oldprog = *arg;
 	struct nlattr *tb[TCA_BPF_MAX + 1];
+	bool bound_to_filter = false;
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


