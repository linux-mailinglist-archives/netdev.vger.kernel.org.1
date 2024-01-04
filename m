Return-Path: <netdev+bounces-61542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB33382435B
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA7E1F2243A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6FF2136C;
	Thu,  4 Jan 2024 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="dB6Akq+Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C9E224D1
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9bba6d773so359732b3a.1
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 06:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704377490; x=1704982290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6xhHgAAMOGQBTBKaCdDA63SXE6gwiGBv6Ii/8JGebUA=;
        b=dB6Akq+YSK4eBUYHxsASWlbD3uUSMTJ6FsrFNFM/i7t65+1yGxjyONRFNF9fc3IN4O
         Wt09cnjmtadEvlDZ1UGVmzxTkTTL0mq0HC4eBCro57nu/rMXrSjvFdE2xIinuT7AwKar
         zru/taLhZMi0tjgwK6A66z7x0XFGHSS4HrMzzzo6lMosTkk7h+fYDreSrZByMHT58fA5
         UQxHJdvjOxbUW28VJz1QWgb2Dctz0wYu+i7Cp4Aaj5q9b40tccqM0CxOubcLBcmQ3y+R
         I7DAMEXf4VKow+2VSzzzg0/0kHEq79kZvtF/EfZEpFD2FwNrrsWY0hDwiFFjJvP9b44J
         DPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704377490; x=1704982290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xhHgAAMOGQBTBKaCdDA63SXE6gwiGBv6Ii/8JGebUA=;
        b=adeAnFJ/qfbVhxkOFIVram0WHBR1hXFUwKhHNfo4+GYg/YY5MK36ezvG/Ry5PoKYfy
         t6XYJdhrNhNoOtiLN06QhwX15yg2REOMz2dKaRzKT/57VvUw1KfSVZeXK0/uK3dBKhiL
         bzz+zaPRek3FRcE7Wvfk3BUbgzQzcsF1FWUGwHRE0zdmsbycjo8FI50W8CzHrgMMWhRd
         ByDRgM30yPvCSJ38KwXDl5benNn8VE3xMtBcSjWP3sA3jHZ4ut1XHCV+Gz6CbsxLx3ky
         tertY5+HHKJZSQftc08A2dJKWHCMpS6/DqMjBN1dcz2muDUOoDe3pa28EE5WhJH7Vpnz
         odEA==
X-Gm-Message-State: AOJu0YxpyXU5oaDapSg2mQtPuvLNCmGw5D+5aAmW3pwTwMt9EhGQ25Fk
	+d9+fShdD0X6CyNraSO28xyqvKnbrjRl4UQ4NAMZ32DOVQ==
X-Google-Smtp-Source: AGHT+IExKnXdX7kUXJQVLco5d+3RLZAr67uCluzTviqPFpt/8qWDQl0jW1A9bf7yiz03H2zJ31JZhQ==
X-Received: by 2002:a05:6a00:e0b:b0:6d9:aab8:a5bd with SMTP id bq11-20020a056a000e0b00b006d9aab8a5bdmr706233pfb.19.1704377489775;
        Thu, 04 Jan 2024 06:11:29 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id f26-20020aa78b1a000000b006d97f80c4absm23218609pfd.41.2024.01.04.06.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 06:11:29 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next] net/sched: simplify tc_action_load_ops parameters
Date: Thu,  4 Jan 2024 11:11:13 -0300
Message-Id: <20240104141113.1995416-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using two bools derived from a flags passed as arguments to
the parent function of tc_action_load_ops, just pass the flags itself
to tc_action_load_ops to simplify its parameters.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 include/net/act_api.h | 3 +--
 net/sched/act_api.c   | 9 ++++-----
 net/sched/cls_api.c   | 5 ++---
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 447985a45ef6..e1e5e72b901e 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -208,8 +208,7 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 		    struct nlattr *est,
 		    struct tc_action *actions[], int init_res[], size_t *attr_size,
 		    u32 flags, u32 fl_flags, struct netlink_ext_ack *extack);
-struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
-					 bool rtnl_held,
+struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
 					 struct netlink_ext_ack *extack);
 struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
 				    struct nlattr *nla, struct nlattr *est,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index ef70d4771811..dd3b893802db 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1324,10 +1324,10 @@ void tcf_idr_insert_many(struct tc_action *actions[], int init_res[])
 	}
 }
 
-struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
-					 bool rtnl_held,
+struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
 					 struct netlink_ext_ack *extack)
 {
+	bool police = flags & TCA_ACT_FLAGS_POLICE;
 	struct nlattr *tb[TCA_ACT_MAX + 1];
 	struct tc_action_ops *a_o;
 	char act_name[IFNAMSIZ];
@@ -1359,6 +1359,7 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
 	a_o = tc_lookup_action_n(act_name);
 	if (a_o == NULL) {
 #ifdef CONFIG_MODULES
+		bool rtnl_held = !(flags & TCA_ACT_FLAGS_NO_RTNL);
 		if (rtnl_held)
 			rtnl_unlock();
 		request_module("act_%s", act_name);
@@ -1475,9 +1476,7 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 	for (i = 1; i <= TCA_ACT_MAX_PRIO && tb[i]; i++) {
 		struct tc_action_ops *a_o;
 
-		a_o = tc_action_load_ops(tb[i], flags & TCA_ACT_FLAGS_POLICE,
-					 !(flags & TCA_ACT_FLAGS_NO_RTNL),
-					 extack);
+		a_o = tc_action_load_ops(tb[i], flags, extack);
 		if (IS_ERR(a_o)) {
 			err = PTR_ERR(a_o);
 			goto err_mod;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 46c98367d205..8d25e6b561dd 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -3297,12 +3297,11 @@ int tcf_exts_validate_ex(struct net *net, struct tcf_proto *tp, struct nlattr **
 		if (exts->police && tb[exts->police]) {
 			struct tc_action_ops *a_o;
 
-			a_o = tc_action_load_ops(tb[exts->police], true,
-						 !(flags & TCA_ACT_FLAGS_NO_RTNL),
+			flags |= TCA_ACT_FLAGS_POLICE | TCA_ACT_FLAGS_BIND;
+			a_o = tc_action_load_ops(tb[exts->police], flags,
 						 extack);
 			if (IS_ERR(a_o))
 				return PTR_ERR(a_o);
-			flags |= TCA_ACT_FLAGS_POLICE | TCA_ACT_FLAGS_BIND;
 			act = tcf_action_init_1(net, tp, tb[exts->police],
 						rate_tlv, a_o, init_res, flags,
 						extack);
-- 
2.40.1


