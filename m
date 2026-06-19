Return-Path: <netdev+bounces-300619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id queCKizpNGqfjwYAu9opvQ
	(envelope-from <netdev+bounces-300619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:01:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 248626A430C
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:01:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=Xo4awvyM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300619-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300619-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D23AD30053EB
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 07:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A67230BF66;
	Fri, 19 Jun 2026 07:00:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FED40D59A
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 07:00:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781852458; cv=none; b=X4j4TDYJJfQaqaQF7Un/KYfqcR19Bi6uKPLGeguzbA+tKKKhcu4jtaGqAWDXBNCgU2Ft64qf0IIgnsDdWvAsPb9Hm5mIr3H0M0poToSm2e4xCqWAT9yZVWooGg6uOcNHdMzqqJCrG1QaROoldJqi5BbjUMXvcGELVHObU2LtB64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781852458; c=relaxed/simple;
	bh=CAefpSvvnYNWW8ETWr/q3lSMNrR+IMo3pNludyMat0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdZknE39gvqC5yaC4WroOAaXL4+pg1EE2sttq+Q/Xd6he+JG/kIcXydRwu3yaixmLKNRkcuwlrH/15NfGHCWsdWF1BVx8vFqpD2bhMLtWj1pTKKCM3jmz5BTpX11S2k3TPQCUBc/qQA4LDriZXbQFuXC3kGCmVQ0GqpNZpWW3Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=Xo4awvyM; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1781852451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuA1MAFUn/UG5BjiMRIG4JPFQHZyADK8pcBQ8VRiPsM=;
	b=Xo4awvyMX0rGla0NA0uui5TQegMjLQsCyDiDVgqYBCl0FQFDJzRsZ4xh7B+RpAwE3Tai+e
	jsgaShac/FcvsEcTmqN6g33SgLr64bfAVybiS61rZE2EvqXcGN3LwkqKA/5UIOqARfXFVm
	BeExKIXhBzK/JDQOFFtFW4/MP8TzfT5p8lNt/RW3PcPuqsMTy9tFoWB5Wbl0dsLQE+zHYF
	YADPXdOactoQoBPWC359GOEftNg/QiqCd/sN25e0OPXoJlIQNdjQxuLZg8KUUOHrQdGjnQ
	JZoqZqX1LVZR+DwfXEs3Y+RjO9fAtYicxaqZdhMD/d/U8W39KoccVYfXupuJsA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 06/15] batman-adv: v: prevent OGM aggregation on disabled hardif
Date: Fri, 19 Jun 2026 09:00:36 +0200
Message-ID: <20260619070045.438101-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619070045.438101-1-sw@simonwunderlich.de>
References: <20260619070045.438101-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300619-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:stable@kernel.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 248626A430C

From: Sven Eckelmann <sven@narfation.org>

When an interface gets disabled, the worker is correctly disabled by
batadv_hardif_disable_interface() -> ... -> batadv_v_ogm_iface_disable().
In this process, the skb aggr_list is also freed.

But batadv_v_ogm_send_meshif() can still queue new skbs (via
batadv_v_ogm_queue_on_if()) to the aggr_list. This will only stop after all
cores can no longer find the RCU protected list of hard interfaces. These
queued skbs will never be freed or consumed by batadv_v_ogm_aggr_work.

The batadv_v_ogm_iface_disable() function must block
batadv_v_ogm_queue_on_if() to avoid leak of skbs.

Cc: stable@kernel.org
Fixes: f89255a02f1d ("batman-adv: BATMAN_V: introduce per hard-iface OGMv2 queues")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v.c     |  1 +
 net/batman-adv/bat_v_ogm.c | 12 ++++++++++++
 net/batman-adv/types.h     |  6 ++++++
 3 files changed, 19 insertions(+)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index fe7c0113d0df3..db6f5bdcaa985 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -817,6 +817,7 @@ void batadv_v_hardif_init(struct batadv_hard_iface *hard_iface)
 
 	hard_iface->bat_v.aggr_len = 0;
 	skb_queue_head_init(&hard_iface->bat_v.aggr_list);
+	hard_iface->bat_v.aggr_list_enabled = false;
 	INIT_DELAYED_WORK(&hard_iface->bat_v.aggr_wq,
 			  batadv_v_ogm_aggr_work);
 	/* make sure it doesn't run until interface gets enabled */
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 81926ef9c02c9..95efd8a43c79d 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -254,11 +254,18 @@ static void batadv_v_ogm_queue_on_if(struct batadv_priv *bat_priv,
 	}
 
 	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
+	if (!hard_iface->bat_v.aggr_list_enabled) {
+		kfree_skb(skb);
+		goto unlock;
+	}
+
 	if (!batadv_v_ogm_queue_left(skb, hard_iface))
 		batadv_v_ogm_aggr_send(bat_priv, hard_iface);
 
 	hard_iface->bat_v.aggr_len += batadv_v_ogm_len(skb);
 	__skb_queue_tail(&hard_iface->bat_v.aggr_list, skb);
+
+unlock:
 	spin_unlock_bh(&hard_iface->bat_v.aggr_list.lock);
 }
 
@@ -415,6 +422,10 @@ int batadv_v_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 
+	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
+	hard_iface->bat_v.aggr_list_enabled = true;
+	spin_unlock_bh(&hard_iface->bat_v.aggr_list.lock);
+
 	enable_delayed_work(&hard_iface->bat_v.aggr_wq);
 
 	batadv_v_ogm_start_queue_timer(hard_iface);
@@ -432,6 +443,7 @@ void batadv_v_ogm_iface_disable(struct batadv_hard_iface *hard_iface)
 	disable_delayed_work_sync(&hard_iface->bat_v.aggr_wq);
 
 	spin_lock_bh(&hard_iface->bat_v.aggr_list.lock);
+	hard_iface->bat_v.aggr_list_enabled = false;
 	batadv_v_ogm_aggr_list_free(hard_iface);
 	spin_unlock_bh(&hard_iface->bat_v.aggr_list.lock);
 }
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 5fd5bd358a249..5e81c93b8217d 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -145,6 +145,12 @@ struct batadv_hard_iface_bat_v {
 	/** @aggr_list: queue for to be aggregated OGM packets */
 	struct sk_buff_head aggr_list;
 
+	/**
+	 * @aggr_list_enabled: aggr_list is active and new skbs can be
+	 * enqueued. Protected by aggr_list.lock after initialization
+	 */
+	bool aggr_list_enabled:1;
+
 	/** @aggr_len: size of the OGM aggregate (excluding ethernet header) */
 	unsigned int aggr_len;
 
-- 
2.47.3


