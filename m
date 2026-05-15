Return-Path: <netdev+bounces-288201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAsFJ2rIBmrynwIAu9opvQ
	(envelope-from <netdev+bounces-288201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:16:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF72E54A6E6
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD694300A8E6
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 07:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3CF3E3C70;
	Fri, 15 May 2026 07:10:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D4A3E025D;
	Fri, 15 May 2026 07:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829013; cv=none; b=h6kfjWXaI/sRRh8IaylX0krpPkJHx7MDuppcCzgs9c+49niUGG5Z8t+J9iUq3D01wxV56WEu52+tBaQBNOrKb/+sJPXDaxkDA92Y6mwHfTA5tBALebipPhPy8/VVn745dUMZKhjlf4SyfEwOzsYqyYkPd9FBuU2WAbSjWDKifoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829013; c=relaxed/simple;
	bh=kSP/SUJ5LBziWutiKWUS3bXXv/X1IWJe0XDl86nr6ik=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=PPyD7CWoHUZ4r2eD7XLRJwqkNisIh3eh4WbGZnVqeY8qUepz4y0D0ussgjxj7sUfp3xJNnZXleSdTnQ6tU3VmK/o6xiQTQlYULGAD42jZFNS9a5NJk02+T0bI/cWyNE9e/go5lg6c6HEnG0zYlPjn7+zwn18mH7niiwmeO9Q4Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gGyy207T4z7QYS1;
	Fri, 15 May 2026 15:10:02 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 64F79tt8085431;
	Fri, 15 May 2026 15:09:55 +0800 (+08)
	(envelope-from qiu.yutan@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 15 May 2026 15:09:57 +0800 (CST)
X-Zmail-TransId: 2af96a06c6c5689-9844d
X-Mailer: Zmail v1.0
Message-ID: <20260515150957697xaYiRGPGH0ylFETfsr80O@zte.com.cn>
Date: Fri, 15 May 2026 15:09:57 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <qiu.yutan@zte.com.cn>
To: <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <kuba@kernel.org>
Cc: <dsahern@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
        <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yang.chuan1@zte.com.cn>,
        <huang.jian@zte.com.cn>, <zhou.shizhen@zte.com.cn>,
        <zhang.dongyu1@zte.com.cn>, <ye.guojin@zte.com.cn>,
        <yang.wei20@zte.com.cn>, <zhang.lin16@zte.com.cn>,
        <li.hao40@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHYyXSBuZXQ6IG5laWdoOiBSZW5hbWUgTkVJR0hfVkFSX0lOVEVSVkFMX1BST0JFX1RJTUVfTVMgdG8KIE5FSUdIX1ZBUl9JTlRFUlZBTF9QUk9CRV9USU1F?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 64F79tt8085431
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: qiu.yutan@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Fri, 15 May 2026 15:10:02 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A06C6CA.000/4gGyy207T4z7QYS1
X-Rspamd-Queue-Id: EF72E54A6E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	SUBJ_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[zte.com.cn : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288201-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[qiu.yutan@zte.com.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zte.com.cn:email,zte.com.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Qiu Yutan <qiu.yutan@zte.com.cn>
During the initialization of arp_tbl, the enumeration constant name
NEIGH_VAR_INTERVAL_PROBE_TIME_MS in the statement
arp_tbl.parms.data[NEIGH_VAR_INTERVAL_PROBE_TIME_MS] = 5*HZ does not
align with its actual meaning (jiffies).

Using NEIGH_VAR_INTERVAL_PROBE_TIME is a better naming choice.

Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
---
v2:
- remove the Fixes tag

 include/net/neighbour.h | 2 +-
 net/core/neighbour.c    | 8 ++++----
 net/ipv4/arp.c          | 2 +-
 net/ipv6/ndisc.c        | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 2dfee6d4258a..f317e910ec3c 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -49,7 +49,7 @@ enum {
 	NEIGH_VAR_RETRANS_TIME,
 	NEIGH_VAR_BASE_REACHABLE_TIME,
 	NEIGH_VAR_DELAY_PROBE_TIME,
-	NEIGH_VAR_INTERVAL_PROBE_TIME_MS,
+	NEIGH_VAR_INTERVAL_PROBE_TIME,
 	NEIGH_VAR_GC_STALETIME,
 	NEIGH_VAR_QUEUE_LEN_BYTES,
 	NEIGH_VAR_PROXY_QLEN,
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 9e12524b67fa..912e6ca3b26e 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1670,7 +1670,7 @@ static void neigh_managed_work(struct work_struct *work)
 	list_for_each_entry(neigh, &tbl->managed_list, managed_list)
 		neigh_event_send_probe(neigh, NULL, false);
 	queue_delayed_work(system_power_efficient_wq, &tbl->managed_work,
-			   NEIGH_VAR(&tbl->parms, INTERVAL_PROBE_TIME_MS));
+			   NEIGH_VAR(&tbl->parms, INTERVAL_PROBE_TIME));
 	spin_unlock_bh(&tbl->lock);
 }

@@ -2235,7 +2235,7 @@ static int neightbl_fill_parms(struct sk_buff *skb, struct neigh_parms *parms)
 	    nla_put_msecs(skb, NDTPA_LOCKTIME,
 			  NEIGH_VAR(parms, LOCKTIME), NDTPA_PAD) ||
 	    nla_put_msecs(skb, NDTPA_INTERVAL_PROBE_TIME_MS,
-			  NEIGH_VAR(parms, INTERVAL_PROBE_TIME_MS), NDTPA_PAD))
+			  NEIGH_VAR(parms, INTERVAL_PROBE_TIME), NDTPA_PAD))
 		goto nla_put_failure;
 	return nla_nest_end(skb, nest);

@@ -2508,7 +2508,7 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 				call_netevent_notifiers(NETEVENT_DELAY_PROBE_TIME_UPDATE, p);
 				break;
 			case NDTPA_INTERVAL_PROBE_TIME_MS:
-				NEIGH_VAR_SET(p, INTERVAL_PROBE_TIME_MS,
+				NEIGH_VAR_SET(p, INTERVAL_PROBE_TIME,
 					      nla_get_msecs(tbp[i]));
 				break;
 			case NDTPA_RETRANS_TIME:
@@ -3804,7 +3804,7 @@ static struct neigh_sysctl_table {
 		NEIGH_SYSCTL_USERHZ_JIFFIES_ENTRY(RETRANS_TIME, "retrans_time"),
 		NEIGH_SYSCTL_JIFFIES_ENTRY(BASE_REACHABLE_TIME, "base_reachable_time"),
 		NEIGH_SYSCTL_JIFFIES_ENTRY(DELAY_PROBE_TIME, "delay_first_probe_time"),
-		NEIGH_SYSCTL_MS_JIFFIES_POSITIVE_ENTRY(INTERVAL_PROBE_TIME_MS,
+		NEIGH_SYSCTL_MS_JIFFIES_POSITIVE_ENTRY(INTERVAL_PROBE_TIME,
 						       "interval_probe_time_ms"),
 		NEIGH_SYSCTL_JIFFIES_ENTRY(GC_STALETIME, "gc_stale_time"),
 		NEIGH_SYSCTL_ZERO_INTMAX_ENTRY(QUEUE_LEN_BYTES, "unres_qlen_bytes"),
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 51d70180e1cc..601b98185cf5 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -169,7 +169,7 @@ struct neigh_table arp_tbl = {
 			[NEIGH_VAR_RETRANS_TIME] = 1 * HZ,
 			[NEIGH_VAR_BASE_REACHABLE_TIME] = 30 * HZ,
 			[NEIGH_VAR_DELAY_PROBE_TIME] = 5 * HZ,
-			[NEIGH_VAR_INTERVAL_PROBE_TIME_MS] = 5 * HZ,
+			[NEIGH_VAR_INTERVAL_PROBE_TIME] = 5 * HZ,
 			[NEIGH_VAR_GC_STALETIME] = 60 * HZ,
 			[NEIGH_VAR_QUEUE_LEN_BYTES] = SK_WMEM_DEFAULT,
 			[NEIGH_VAR_PROXY_QLEN] = 64,
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index e7ad13c5bd26..ca7df107e3bf 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -128,7 +128,7 @@ struct neigh_table nd_tbl = {
 			[NEIGH_VAR_RETRANS_TIME] = ND_RETRANS_TIMER,
 			[NEIGH_VAR_BASE_REACHABLE_TIME] = ND_REACHABLE_TIME,
 			[NEIGH_VAR_DELAY_PROBE_TIME] = 5 * HZ,
-			[NEIGH_VAR_INTERVAL_PROBE_TIME_MS] = 5 * HZ,
+			[NEIGH_VAR_INTERVAL_PROBE_TIME] = 5 * HZ,
 			[NEIGH_VAR_GC_STALETIME] = 60 * HZ,
 			[NEIGH_VAR_QUEUE_LEN_BYTES] = SK_WMEM_DEFAULT,
 			[NEIGH_VAR_PROXY_QLEN] = 64,
-- 
2.25.1

