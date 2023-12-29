Return-Path: <netdev+bounces-60581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F15081FFAB
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 14:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9B21F21059
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 13:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBFF11715;
	Fri, 29 Dec 2023 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="jiO1YttB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1911710
	for <netdev@vger.kernel.org>; Fri, 29 Dec 2023 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bbd7d60729so943885b6e.0
        for <netdev@vger.kernel.org>; Fri, 29 Dec 2023 05:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703856470; x=1704461270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fh3pezYbjfpYDj7ZdlOThTOka6tLQZcq64jVX/r+NmU=;
        b=jiO1YttBX5hIfVJLLVGo0aOW+H7Ig5HxPHao2OeZ9lldBKhOK1/lAobkgq/hVZNgng
         wfPcpRdGdWHh2+que2TxkUNqWDfNjV64LIfY/1ANt7DHkSNxFTRQBHQEbSTZvos38tYp
         XDUWchQ7XjVMLwCKBMyVypt502UTc9l7utEwJJ2t9sHbK80dkvdtmPqB1lbDGqGRjIvA
         +34mY6NrKvrxGzHWYAhKDJ14TMRxZhOEwDfGgzq5KH5dSoeQ9WiDcJaaBfNZVFN49U+l
         oVaJmMxVzy2N0gOYU5BoJUMjaQkO5MiGGkG0PdoFZn/LbwPhEhi2RtuavVQz/8Eo7N9r
         L6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703856470; x=1704461270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fh3pezYbjfpYDj7ZdlOThTOka6tLQZcq64jVX/r+NmU=;
        b=v7QHInfxyHrU5suMMi1bURslhHMAsKiK95Q9H3TqW8jlRPaHdEYTvrt2JkaC01lwYl
         yU2PqgTyw7lghIxyN/Qg/Ppnn9W8euXF7MrD3RMS0NkYD2JPHePD2VzrEdMMjgcwQfHm
         jKcNAQzg/K6HOZbLkMSSh5aFVR9tk8cv8kA8NhJwxD+C2rFp9f2oPDOecHrYi8VIbUe4
         GJO6orDuvl3OgyQyemhJrmZ9JW0PesizEuKl3Bb0mZUDNDWy2pij9ogb+keTYpOL8JeW
         m9mFv35uNq8GdoUmVMVcyevAXGng96ilqdi84X0ba5BsJvDYFwsY95wmaSxTzu90wZKB
         Aa1w==
X-Gm-Message-State: AOJu0Ywc+vZVZkQIg8NWv1vXSD9s2ee0Q0/PXcPvTdvZtEMn02qqDhjM
	3LxwPUHpUG1VRKil1ZHEcDcCmfoAg3PzRVlwebggnWX/Yg==
X-Google-Smtp-Source: AGHT+IH8X67f7+Zi5up1yaft+3hp+77YPh0qR4LngrvPEU1eMOgB9rU/uysMvFjoiV7u6saKkZGHSQ==
X-Received: by 2002:a05:6359:4599:b0:175:2220:2e63 with SMTP id no25-20020a056359459900b0017522202e63mr208552rwb.42.1703856469683;
        Fri, 29 Dec 2023 05:27:49 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id dj15-20020a17090ad2cf00b0028bbf4c0264sm19863002pjb.10.2023.12.29.05.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 05:27:49 -0800 (PST)
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
Subject: [PATCH net-next] net/sched: sch_api: conditional netlink notifications
Date: Fri, 29 Dec 2023 10:26:42 -0300
Message-Id: <20231229132642.1489088-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231229132642.1489088-1-pctammela@mojatatu.com>
References: <20231229132642.1489088-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement conditional netlink notifications for Qdiscs and classes,
which were missing in the initial patches that targeted tc filters and
actions. Notifications will only be built after passing a check for
'rtnl_notify_needed()'.

For both Qdiscs and classes 'get' operations now call a dedicated
notification function as it was not possible to distinguish between
'create' and 'get' before. This distinction is necessary because 'get'
always send a notification.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/sch_api.c | 79 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 11 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 299086bb6205..2a2a48838eb9 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1003,6 +1003,32 @@ static bool tc_qdisc_dump_ignore(struct Qdisc *q, bool dump_invisible)
 	return false;
 }
 
+static int qdisc_get_notify(struct net *net, struct sk_buff *oskb,
+			    struct nlmsghdr *n, u32 clid, struct Qdisc *q,
+			    struct netlink_ext_ack *extack)
+{
+	struct sk_buff *skb;
+	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
+
+	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!skb)
+		return -ENOBUFS;
+
+	if (!tc_qdisc_dump_ignore(q, false)) {
+		if (tc_fill_qdisc(skb, q, clid, portid, n->nlmsg_seq, 0,
+				  RTM_NEWQDISC, extack) < 0)
+			goto err_out;
+	}
+
+	if (skb->len)
+		return rtnetlink_send(skb, net, portid, RTNLGRP_TC,
+				      n->nlmsg_flags & NLM_F_ECHO);
+
+err_out:
+	kfree_skb(skb);
+	return -EINVAL;
+}
+
 static int qdisc_notify(struct net *net, struct sk_buff *oskb,
 			struct nlmsghdr *n, u32 clid,
 			struct Qdisc *old, struct Qdisc *new,
@@ -1011,6 +1037,9 @@ static int qdisc_notify(struct net *net, struct sk_buff *oskb,
 	struct sk_buff *skb;
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
 
+	if (!rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
+		return 0;
+
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
@@ -1583,7 +1612,7 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 		if (err != 0)
 			return err;
 	} else {
-		qdisc_notify(net, skb, n, clid, NULL, q, NULL);
+		qdisc_get_notify(net, skb, n, clid, q, NULL);
 	}
 	return 0;
 }
@@ -1977,6 +2006,9 @@ static int tclass_notify(struct net *net, struct sk_buff *oskb,
 	struct sk_buff *skb;
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
 
+	if (!rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
+		return 0;
+
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
@@ -1990,6 +2022,27 @@ static int tclass_notify(struct net *net, struct sk_buff *oskb,
 			      n->nlmsg_flags & NLM_F_ECHO);
 }
 
+static int tclass_get_notify(struct net *net, struct sk_buff *oskb,
+			     struct nlmsghdr *n, struct Qdisc *q,
+			     unsigned long cl, struct netlink_ext_ack *extack)
+{
+	struct sk_buff *skb;
+	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
+
+	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!skb)
+		return -ENOBUFS;
+
+	if (tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0, RTM_NEWTCLASS,
+			   extack) < 0) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	return rtnetlink_send(skb, net, portid, RTNLGRP_TC,
+			      n->nlmsg_flags & NLM_F_ECHO);
+}
+
 static int tclass_del_notify(struct net *net,
 			     const struct Qdisc_class_ops *cops,
 			     struct sk_buff *oskb, struct nlmsghdr *n,
@@ -2003,14 +2056,18 @@ static int tclass_del_notify(struct net *net,
 	if (!cops->delete)
 		return -EOPNOTSUPP;
 
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
-	if (!skb)
-		return -ENOBUFS;
+	if (rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC)) {
+		skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
+		if (!skb)
+			return -ENOBUFS;
 
-	if (tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0,
-			   RTM_DELTCLASS, extack) < 0) {
-		kfree_skb(skb);
-		return -EINVAL;
+		if (tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0,
+				   RTM_DELTCLASS, extack) < 0) {
+			kfree_skb(skb);
+			return -EINVAL;
+		}
+	} else {
+		skb = NULL;
 	}
 
 	err = cops->delete(q, cl, extack);
@@ -2019,8 +2076,8 @@ static int tclass_del_notify(struct net *net,
 		return err;
 	}
 
-	err = rtnetlink_send(skb, net, portid, RTNLGRP_TC,
-			     n->nlmsg_flags & NLM_F_ECHO);
+	err = rtnetlink_maybe_send(skb, net, portid, RTNLGRP_TC,
+				   n->nlmsg_flags & NLM_F_ECHO);
 	return err;
 }
 
@@ -2215,7 +2272,7 @@ static int tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
 			tc_bind_tclass(q, portid, clid, 0);
 			goto out;
 		case RTM_GETTCLASS:
-			err = tclass_notify(net, skb, n, q, cl, RTM_NEWTCLASS, extack);
+			err = tclass_get_notify(net, skb, n, q, cl, extack);
 			goto out;
 		default:
 			err = -EINVAL;
-- 
2.40.1


