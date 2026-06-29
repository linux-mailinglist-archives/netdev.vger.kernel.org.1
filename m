Return-Path: <netdev+bounces-302638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Zd6ED810Qmp57gkAu9opvQ
	(envelope-from <netdev+bounces-302638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:36:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBA76DB4C4
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:36:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=npc-ksb.ru (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302638-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302638-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5388330D1FB7
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FB7406803;
	Mon, 29 Jun 2026 13:08:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.ksb-soft.ru (mail.ksb-soft.ru [5.167.76.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A67406272;
	Mon, 29 Jun 2026 13:08:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738526; cv=none; b=SGkcpwdj7OGAc+7nBXWcOBvovsrsu61n0Y2HVyTZGtNf+d2Hhl1dKRzn62jAG+9ryK179Crod6tRVsQ+xV3xehaKMWpJPTdRHYMfttK6yc8vce9u1vo9Aw7ZcpSiHBhxBJGn0OsRvdYAV8yWx3Vt5QNDjqyBDm2FKf13p0tW1QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738526; c=relaxed/simple;
	bh=WzgO0CN0sSldEHVPRG/k7xAVxRJ34DNgsDLMdNmiXeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dEt6xxlFEODGnGLAfIOzsOf3LaCj+wb8dTXaVhE2YU9bhrWLqzIo+vvpqDDNH2lI8XycLu9N/gywqGC0dVcLcNIAgZwKt6HXPygQJQgJaCqmE6KExrEwZ//pfra6umvuA+uFOGBHnrvg6Rtf8xGUdT3VV9swoL5ON9ikutWlW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=npc-ksb.ru; spf=pass smtp.mailfrom=npc-ksb.ru; arc=none smtp.client-ip=5.167.76.63
Received: from ksb-289.ksb.ksb-soft.ru (unknown [10.38.22.14])
	by mail.ksb-soft.ru (Postfix) with ESMTPA id 4gpmn41RMdz4LJTy;
	Mon, 29 Jun 2026 16:08:40 +0300 (MSK)
From: Markov Gleb <markov.gi@npc-ksb.ru>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Gleb Markov <markov.gi@npc-ksb.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net-next] chelsio: delete the line with the pidx initialization
Date: Mon, 29 Jun 2026 16:08:35 +0300
Message-ID: <20260629130839.218-1-markov.gi@npc-ksb.ru>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 197590 [Oct 29 2025]
X-KLMS-AntiSpam-Version: 6.1.1.11
X-KLMS-AntiSpam-Envelope-From: markov.gi@npc-ksb.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 72 0.3.72 80ff96170b649fb7ebd1aa4cb544c36c109810bd, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean
X-KLMS-LinksScanning: Clean
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 10.0.0.7427, bases: 2025/10/29 20:57:00 #27800623
X-KLMS-AntiVirus-Status: Clean, skipped
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[npc-ksb.ru : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302638-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[markov.gi@npc-ksb.ru,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:markov.gi@npc-ksb.ru,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markov.gi@npc-ksb.ru,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxtesting.org:url,npc-ksb.ru:email,npc-ksb.ru:mid,npc-ksb.ru:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EBA76DB4C4

From: Gleb Markov <markov.gi@npc-ksb.ru>

The value of pidx is overwritten immediately after exiting the "if" block.

Remove pidx ptr initialization string from conditional block.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Gleb Markov <markov.gi@npc-ksb.ru>
---
 drivers/net/ethernet/chelsio/cxgb/sge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb/sge.c b/drivers/net/ethernet/chelsio/cxgb/sge.c
index 861edff5ed89..4e93d82d5892 100644
--- a/drivers/net/ethernet/chelsio/cxgb/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb/sge.c
@@ -1743,7 +1743,6 @@ static int t1_sge_tx(struct sk_buff *skb, struct adapter *adapter,
 			spin_unlock(&q->lock);
 			return NETDEV_TX_OK;
 		}
-		pidx = q->pidx;
 		count = 1 + skb_shinfo(skb)->nr_frags;
 		count += compute_large_page_tx_descs(skb);
 	}
-- 
2.43.0


