Return-Path: <netdev+bounces-61563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392BC82443D
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEBC11C21533
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924FE22EEE;
	Thu,  4 Jan 2024 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lGSz2XKJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD9C23756
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55692ad81e3so695297a12.1
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 06:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704380271; x=1704985071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ctPCmDJoqP8ty+hdgy8J3so/dz8h/iVv20WyeYY6U4=;
        b=lGSz2XKJvbuQU38Q+ugX+51+6Mm4BlLz916GYpPWAXgyFkFCx5pNRABssVwoNkzhSq
         QZs15zgHW+txFCtEjN0OSFYWcrOKCMrVIeFllPmiQauctSwVBRcol0YrdCOO0eiLPOkB
         hkx/ip9Mz5Jy2PvkjlmqRFsPtsz3kfKf8qxA3AaoUoMrzxuOaXnW/D2qlDZE7g4mSbho
         Iu36sjhcklTY5iqrzm2eFs2frDaU28a/ebajgkTprcCUPJ+LQVKWHlTt+MB4OzAbjALL
         kqUK1fHwcjWaRQQooCW96qc/VLj9kPhlR5SAFnMtzA/CCbJpFNNkTDp+75YbF3dS7O7k
         CDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704380271; x=1704985071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ctPCmDJoqP8ty+hdgy8J3so/dz8h/iVv20WyeYY6U4=;
        b=SBcwVhCnSNHBhgY4uroYyxDjo6eDj6doldHPV8VjSV8MSGm/5n3ES21iGCzvyUuHtm
         S+ACGaMbXifEnrPGbp+S1IiePqizdb8NSkLfKiHL5Iu6YyiT39Do/chrg95nGvL6eoKc
         MNHNSkVpryFip0QbAFDGKei7OGw4fXkbg1oW4fu+MiIRSKDFPHbV3h4qBqzAzP9W4+8u
         fRYpJzFao5/4ksk/F0ar3lWIyBC3umQYSzrON9BfJbHieLhfi19wasKD1BUM924CS64Y
         sqNvO9QFEe5j/93p3ZWIVAb6Ccj7oEOXkcbP2C1pE9WTZcK/HiWVmfD97G48PA1hgilH
         I/ZA==
X-Gm-Message-State: AOJu0YzuP1EC2Qbe19Hi5GSmuae3N1xyXrMr8VbPsAay/hAyShTVc+1t
	tQbVi/RFL6YjfYeNiErs6Wd4vAlkPnEETQ==
X-Google-Smtp-Source: AGHT+IE+6pxN6n8veLEzuUBfsZDbKRAdYT2aRS1bqEUIw+63lMefmsby9HzW3dmk219/1L9IHKTClA==
X-Received: by 2002:a50:aa9a:0:b0:556:db12:af4b with SMTP id q26-20020a50aa9a000000b00556db12af4bmr417519edc.54.1704380271544;
        Thu, 04 Jan 2024 06:57:51 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id y11-20020aa7c24b000000b00553754bd636sm18960244edo.35.2024.01.04.06.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 06:57:51 -0800 (PST)
Date: Thu, 4 Jan 2024 15:57:49 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com
Subject: Re: [PATCH net-next] net/sched: simplify tc_action_load_ops
 parameters
Message-ID: <ZZbHbUsTVo7oJL2P@nanopsycho>
References: <20240104141113.1995416-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104141113.1995416-1-pctammela@mojatatu.com>

Thu, Jan 04, 2024 at 03:11:13PM CET, pctammela@mojatatu.com wrote:
>Instead of using two bools derived from a flags passed as arguments to
>the parent function of tc_action_load_ops, just pass the flags itself
>to tc_action_load_ops to simplify its parameters.
>
>Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>---
> include/net/act_api.h | 3 +--
> net/sched/act_api.c   | 9 ++++-----
> net/sched/cls_api.c   | 5 ++---
> 3 files changed, 7 insertions(+), 10 deletions(-)
>
>diff --git a/include/net/act_api.h b/include/net/act_api.h
>index 447985a45ef6..e1e5e72b901e 100644
>--- a/include/net/act_api.h
>+++ b/include/net/act_api.h
>@@ -208,8 +208,7 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
> 		    struct nlattr *est,
> 		    struct tc_action *actions[], int init_res[], size_t *attr_size,
> 		    u32 flags, u32 fl_flags, struct netlink_ext_ack *extack);
>-struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
>-					 bool rtnl_held,
>+struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
> 					 struct netlink_ext_ack *extack);
> struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
> 				    struct nlattr *nla, struct nlattr *est,
>diff --git a/net/sched/act_api.c b/net/sched/act_api.c
>index ef70d4771811..dd3b893802db 100644
>--- a/net/sched/act_api.c
>+++ b/net/sched/act_api.c
>@@ -1324,10 +1324,10 @@ void tcf_idr_insert_many(struct tc_action *actions[], int init_res[])
> 	}
> }
> 
>-struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
>-					 bool rtnl_held,
>+struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
> 					 struct netlink_ext_ack *extack)
> {
>+	bool police = flags & TCA_ACT_FLAGS_POLICE;
> 	struct nlattr *tb[TCA_ACT_MAX + 1];
> 	struct tc_action_ops *a_o;
> 	char act_name[IFNAMSIZ];
>@@ -1359,6 +1359,7 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
> 	a_o = tc_lookup_action_n(act_name);
> 	if (a_o == NULL) {
> #ifdef CONFIG_MODULES
>+		bool rtnl_held = !(flags & TCA_ACT_FLAGS_NO_RTNL);

Empty line here please.

Otherwise this looks fine to me.
Reviewed-by: Jiri Pirko <jiri@nvidia.com>




> 		if (rtnl_held)
> 			rtnl_unlock();
> 		request_module("act_%s", act_name);
>@@ -1475,9 +1476,7 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
> 	for (i = 1; i <= TCA_ACT_MAX_PRIO && tb[i]; i++) {
> 		struct tc_action_ops *a_o;
> 
>-		a_o = tc_action_load_ops(tb[i], flags & TCA_ACT_FLAGS_POLICE,
>-					 !(flags & TCA_ACT_FLAGS_NO_RTNL),
>-					 extack);
>+		a_o = tc_action_load_ops(tb[i], flags, extack);
> 		if (IS_ERR(a_o)) {
> 			err = PTR_ERR(a_o);
> 			goto err_mod;
>diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
>index 46c98367d205..8d25e6b561dd 100644
>--- a/net/sched/cls_api.c
>+++ b/net/sched/cls_api.c
>@@ -3297,12 +3297,11 @@ int tcf_exts_validate_ex(struct net *net, struct tcf_proto *tp, struct nlattr **
> 		if (exts->police && tb[exts->police]) {
> 			struct tc_action_ops *a_o;
> 
>-			a_o = tc_action_load_ops(tb[exts->police], true,
>-						 !(flags & TCA_ACT_FLAGS_NO_RTNL),
>+			flags |= TCA_ACT_FLAGS_POLICE | TCA_ACT_FLAGS_BIND;
>+			a_o = tc_action_load_ops(tb[exts->police], flags,
> 						 extack);
> 			if (IS_ERR(a_o))
> 				return PTR_ERR(a_o);
>-			flags |= TCA_ACT_FLAGS_POLICE | TCA_ACT_FLAGS_BIND;
> 			act = tcf_action_init_1(net, tp, tb[exts->police],
> 						rate_tlv, a_o, init_res, flags,
> 						extack);
>-- 
>2.40.1
>

