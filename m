Return-Path: <netdev+bounces-298523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KH9WHKrFK2r3EgQAu9opvQ
	(envelope-from <netdev+bounces-298523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:39:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C9B677DE4
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:39:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IHy2sOne;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298523-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298523-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84EF234039A6
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8604539099C;
	Fri, 12 Jun 2026 08:35:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A4374A05;
	Fri, 12 Jun 2026 08:35:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781253356; cv=none; b=E3VlPpziYyb50ll9FGD+HEprNM5pdhNLzKWrCUEGD/QQV9SUqAHQtsVvZcZDaR8HYQImiqylQ9Vrp0ztldJ28o+zZVyHOLOz79+NmVernMvBYI+AfKdPz+QJ9QIA3IbIj+oMToOb7DzIi7vybRdYnlRT+w9AnmFnWf15tu3j1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781253356; c=relaxed/simple;
	bh=1xmJb/jq3gGzt9sMAZ56gss79Ncx/L+Vk0WEndkIT3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmFcylNZiq4dKIvyg3cxbi1WED1VqWOO2gDQexZNHEAmWYi7r+4Nm4IY6KAwmcGGhq6rpY+buylFR7yK9tPLPNfyUDwkSTNqTKuEv9xxfp1UEC/O7bBnTL6Uxx7f0r++AZpbpzsHbONFqD1NRdKlNW/Zg6ER+rra7OaYkHS+Y4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHy2sOne; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84E41F00A3D;
	Fri, 12 Jun 2026 08:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781253354;
	bh=UoXt0U1m88jdqXV8t9Xr2ujtFXRWhT7GFB/bZ7U41gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IHy2sOneAcR3qdH5y4b7zV/TYR9gCBTLwWXhRc/GLslKfbhGz6Xorwmduh18Pvevb
	 2zcSgbJfD8/EDu2emn2cNOaycRaEeuQhBCdjUKGMglGxlR4pHK/67yZYFzO9EFnaEN
	 pAa330G7Dy9We7QmoQD/Km8YdjAil06DUSoeLwESzWGh4t038Hz5XlMga5UAxsctOR
	 y3lwcI1bZ4vpTaI5wkU58cdUZ70KU0l7P3k5YonladituMy4wA7DntEqqVrp0TGYGg
	 VEG6aSikyXaJUh8Na5wOAprRndwPOYRuc9yyhw3zXHowP4t8EsvJmsJ1E8fX1k4Ht4
	 wAY1iPLn4v8Ng==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	simon.schippers@tu-dortmund.de,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 4/5] net: sched: add timeout count to NETDEV WATCHDOG message
Date: Fri, 12 Jun 2026 10:35:27 +0200
Message-ID: <20260612083530.1650245-5-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612083530.1650245-1-hawk@kernel.org>
References: <20260612083530.1650245-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298523-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:simon.schippers@tu-dortmund.de,m:hawk@kernel.org,m:kuba@kernel.org,m:j.koeppeler@tu-berlin.de,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3C9B677DE4

From: Jesper Dangaard Brouer <hawk@kernel.org>

Add the per-queue timeout counter (trans_timeout) to the core NETDEV
WATCHDOG log message.  This makes it easy to determine how frequently
a particular queue is stalling from a single log line, without having
to search through and correlate spaced-out log entries.

Useful for production monitoring where timeouts are spaced by the
watchdog interval, making frequency hard to judge.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/all/20251107175445.58eba452@kernel.org/
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Tested-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
---
 net/sched/sch_generic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 237ee1cd0136..eb6066d1ed90 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -533,6 +533,7 @@ static void dev_watchdog(struct timer_list *t)
 		    netif_running(dev) &&
 		    netif_carrier_ok(dev)) {
 			unsigned int timedout_ms = 0;
+			unsigned long trans_timeout = 0;
 			unsigned int i;
 			unsigned long trans_start;
 			unsigned long oldest_start = jiffies;
@@ -553,6 +554,7 @@ static void dev_watchdog(struct timer_list *t)
 				if (time_after(jiffies, trans_start + dev->watchdog_timeo)) {
 					timedout_ms = jiffies_to_msecs(jiffies - trans_start);
 					atomic_long_inc(&txq->trans_timeout);
+					trans_timeout = atomic_long_read(&txq->trans_timeout);
 					break;
 				}
 				if (time_after(oldest_start, trans_start))
@@ -561,9 +563,9 @@ static void dev_watchdog(struct timer_list *t)
 
 			if (unlikely(timedout_ms)) {
 				trace_net_dev_xmit_timeout(dev, i);
-				netdev_crit(dev, "NETDEV WATCHDOG: CPU: %d: transmit queue %u timed out %u ms\n",
+				netdev_crit(dev, "NETDEV WATCHDOG: CPU: %d: transmit queue %u timed out %u ms (n:%ld)\n",
 					    raw_smp_processor_id(),
-					    i, timedout_ms);
+					    i, timedout_ms, trans_timeout);
 				netif_freeze_queues(dev);
 				dev->netdev_ops->ndo_tx_timeout(dev, i);
 				netif_unfreeze_queues(dev);
-- 
2.43.0


