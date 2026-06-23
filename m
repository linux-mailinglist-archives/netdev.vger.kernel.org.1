Return-Path: <netdev+bounces-301305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TjpcFC9LOmrk5QcAu9opvQ
	(envelope-from <netdev+bounces-301305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:00:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6AC6B5817
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:00:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301305-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301305-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 605423058102
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 08:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8763B3CF97F;
	Tue, 23 Jun 2026 08:56:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B133CF686
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 08:56:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204979; cv=none; b=KVe+NzxnJfddxGEFEIoFdZpTBtbwYVZo+A2dmVe3UF3c5gbgve0KWyCC8QBzdjiF2wnnzrOHrTDosjfYUdXsW1l4g+aqB9Uuq8sPacFmnoeDmhZwB5lOb+A9be9W/iU4CpP6k/PR9yCNyaWBum5DZD68bZXmwdJztyt9ww1dZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204979; c=relaxed/simple;
	bh=EBoBkuSJnoWSd22TWrjpA5sflSa9YOtp5LFJr5tzAns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xohxd8DcZQS4rhc49Uit0FIM1xy3cI1U1/q6CpcwPd81BJwZuaiKMHXeRCvTbRZG9fLc/1oAzFZFh+iIojhz6IdZkncMQYVu3P9WP+if7jnHhdiSjwDE/ihZ0E6Q17Psr9pOT630zgoQkttpclWmkB4+iZZIvNAXBxNStQFM3lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 61692c3e6ee111f1aa26b74ffac11d73-20260623
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:2e34d9c8-045a-4129-809b-a02bbe9fab5b,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:2e34d9c8-045a-4129-809b-a02bbe9fab5b,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:15f20c51246a63c6e90d2d4d3618873e,BulkI
	D:2606231656116KGNI82O,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 61692c3e6ee111f1aa26b74ffac11d73-20260623
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1730773452; Tue, 23 Jun 2026 16:56:10 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [net] ipv6: honor per-interface proxy_ndp in forward and NA paths
Date: Tue, 23 Jun 2026 16:56:00 +0800
Message-Id: <20260623085600.396401-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301305-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[zhaochenguang@kylinos.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:zhaochenguang@kylinos.cn,m:horms@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaochenguang@kylinos.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,kylinos.cn:email,kylinos.cn:mid,kylinos.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E6AC6B5817

ndisc_recv_ns() has always checked both devconf_all and idev->cnf for
proxy_ndp, but ip6_forward() and ndisc_recv_na() only looked at the
global setting.

Honor per-interface proxy_ndp in both places to match the NS path and
allow setups that only enable proxy_ndp on specific interfaces.

Fixes: fbea49e1e240 ("[IPV6] NDISC: Add proxy_ndp sysctl.")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 net/ipv6/ip6_output.c | 4 ++--
 net/ipv6/ndisc.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 368e4fa3b43c..c4ca4a813479 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -579,8 +579,8 @@ int ip6_forward(struct sk_buff *skb)
 		return -ETIMEDOUT;
 	}
 
-	/* XXX: idev->cnf.proxy_ndp? */
-	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
+	if ((READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
+	     (idev && READ_ONCE(idev->cnf.proxy_ndp))) &&
 	    pneigh_lookup(&nd_tbl, net, &hdr->daddr, skb->dev)) {
 		int proxied = ip6_forward_proxy_check(skb);
 
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index f867ec8d3d90..e03e94681738 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1096,9 +1096,9 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 		 */
 		if (lladdr && !memcmp(lladdr, dev->dev_addr, dev->addr_len) &&
 		    READ_ONCE(net->ipv6.devconf_all->forwarding) &&
-		    READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
+		    (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
+		     (idev && READ_ONCE(idev->cnf.proxy_ndp))) &&
 		    pneigh_lookup(&nd_tbl, net, &msg->target, dev)) {
-			/* XXX: idev->cnf.proxy_ndp */
 			goto out;
 		}
 
-- 
2.25.1


