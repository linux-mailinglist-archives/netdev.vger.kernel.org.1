Return-Path: <netdev+bounces-271108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MAtByulwmkyggQAu9opvQ
	(envelope-from <netdev+bounces-271108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:52:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7934330A809
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C13CF30D7303
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41C03FFAA2;
	Tue, 24 Mar 2026 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pi3dpMEX"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03B13FE641;
	Tue, 24 Mar 2026 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363620; cv=none; b=kUKUOsMpv93AjPCrnyFaVTA3mi6fyZOin1yx03i9QkjDojUfT5R/UA81yHpFQmCzccGs8l/Gf1wSbe8s22KoEoDaByc1VzZzmnB0ZaSB9PO/e/Rughyc3P2lNPPrXKpUmv+65Fn2/DVf1kHeZivzC/3sOMIvgtygugsK4Gk7Jrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363620; c=relaxed/simple;
	bh=/D0cfQ1mzSWmV2F+6UuVKYRFikwA13VAmraAgE++9NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WB56bO3x8CaCIQ7/02Xg8ywqGuiOAYU7k0vPklGnk9NHGq9xuZ85/OXgWUsdPbmDc+Frn5Jad1h7IBchAibCRhqySnj1kae6x1RuQ2O5wrk+wIjtBNxNd2JOfoh6KJkgcHyanIU/p5H/bbjR01ALqWhDJvADrRB36a08uyDmPOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pi3dpMEX; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774363615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/MqktP6Uup7dDGTg1J03eE+dsXyf5ZAXMqFkJo79oQ=;
	b=Pi3dpMEXxvyUD9eAbn3HQ1xwMWUy0hImy9Surjg8iyPWBbXNg9ToQzss0fjR14GSpts3+g
	hH7Y1xWK3Sy6RQlfk/aUJ9Ox/5hGslR0UTldEjxyWoT70de4z18ZQ6BZc4+cV+FKVyIwNZ
	eZ+5Bbr+4jAE2sz5oVoa0SsjzeR5CzM=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	linux-kernel@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH net-next v1 2/7] net: hsr: replace fallthrough comments with fallthrough macro
Date: Tue, 24 Mar 2026 15:46:25 +0100
Message-ID: <20260324144630.189094-3-luka.gejak@linux.dev>
In-Reply-To: <20260324144630.189094-1-luka.gejak@linux.dev>
References: <20260324144630.189094-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,vger.kernel.org,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271108-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 7934330A809
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

Replace two instances of the legacy '/* Fall through */' comment with the
standardized 'fallthrough;' macro in hsr_get_node_status() and
hsr_get_node_list(). The kernel has standardized on the fallthrough macro
since the migration from comment-based annotations, which provides
compiler-level verification of intentional case fall-throughs.

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 net/hsr/hsr_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index db0b0af7a692..32c1b77cf84b 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -433,7 +433,7 @@ static int hsr_get_node_status(struct sk_buff *skb_in, struct genl_info *info)
 
 nla_put_failure:
 	kfree_skb(skb_out);
-	/* Fall through */
+	fallthrough;
 
 fail:
 	rcu_read_unlock();
@@ -524,7 +524,7 @@ static int hsr_get_node_list(struct sk_buff *skb_in, struct genl_info *info)
 
 nla_put_failure:
 	nlmsg_free(skb_out);
-	/* Fall through */
+	fallthrough;
 
 fail:
 	rcu_read_unlock();
-- 
2.53.0


