Return-Path: <netdev+bounces-298638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LG4LKGf+K2rCJAQAu9opvQ
	(envelope-from <netdev+bounces-298638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:41:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 775F767969C
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:41:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b=dWmy9FAH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298638-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298638-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BE3B300FABD
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E707A3EB0FA;
	Fri, 12 Jun 2026 12:39:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453C93E51DE;
	Fri, 12 Jun 2026 12:39:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267945; cv=none; b=fQVsLv3m1nBteexpbnf1ST9mCowq7KaT+1eF51m8yZyxqRvFH1DaWXUAo2nKNJWH5XqbyDRwnCGGrgsXzR0/8UyaIyk3Dzh0BU8jluZbJB9mhraOLuImEyxr3H0qWZvHw7qHLhC1p2A7VIaBqu/LTfB6tI7AZ/uDmWMZRwwwi0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267945; c=relaxed/simple;
	bh=kEeUsqRoDht0JsLNg8VqZNek9FXwge3FrFv+uF0ARqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Zi1ex5kt+kMQCf8J5UDjrdNlOrzrpFFxu7rS/mHwQEHrmjIc+FsLG84/sMVwFExIC3IYOtpIs8Ow6vCUtXw54Pd2OwJfWK7o/arT/H9j4qh1HzZJMFSdEZTj7Ohz7grSS39J7VjPx1rLs/Kuyr41aLM96GDUNVgN4/y2aQFpwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dWmy9FAH; arc=none smtp.client-ip=68.232.153.233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781267944; x=1812803944;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=kEeUsqRoDht0JsLNg8VqZNek9FXwge3FrFv+uF0ARqg=;
  b=dWmy9FAHWkVNSjnoN4ctrtBT9rpgCSbDTyuH/mOdaHXM409OrXfe1Nex
   N6uXLcetKr5YPgxLJUJ5anml8t90yxaPtJ7XueNMsWSGIM06iIkvkK9KU
   Ngxj8FkFaEfTjuMQL4R9ssKXMAa6Iti8k5cnh/lR1GcB4rOAKqL6bxJ6c
   WjWCTfEM86nwyMz8kZG1Amr7z080JDv0N3oB78xsbNk1NmtIDkNFIcopP
   bM1Hm83X/EN+wodZ7Ld1KsM/aMbaDD5RTbY24w6rYzweLF41yBHHynoix
   OFmm2hVpchtekAKKtPZipguotNgNrR3WLNEU0/VNVY/AV+eVDKnyrh4bI
   A==;
X-CSE-ConnectionGUID: fXak9KnAQbCITrswHQFl3w==
X-CSE-MsgGUID: 9nckSlZ2Q3y/Py4seiqz2g==
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="68073266"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 05:39:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Fri, 12 Jun 2026 05:39:02 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Jun 2026 05:39:00 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Fri, 12 Jun 2026 14:37:18 +0200
Subject: [PATCH net-next 9/9] net: sparx5: add neighbour event handling for
 L3 routing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260612-sparx5_l3_routing-v1-9-fc3c10160f49@microchip.com>
References: <20260612-sparx5_l3_routing-v1-0-fc3c10160f49@microchip.com>
In-Reply-To: <20260612-sparx5_l3_routing-v1-0-fc3c10160f49@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Machon
	<daniel.machon@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-hardening@vger.kernel.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298638-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:horatiu.vultur@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:daniel.machon@microchip.com,m:Steen.Hegelund@microchip.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-hardening@vger.kernel.org,m:jensemil.schulzostergaard@microchip.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,microchip.com:mid,microchip.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 775F767969C

Register a netevent notifier to handle NETEVENT_NEIGH_UPDATE events,
completing the L3 unicast forwarding data path:

- When ARP/NDP resolves a neighbour, update the hardware ARP table entry
  with the resolved MAC address and notify all linked nexthops to
  refresh their ECMP forwarding state.

- When a neighbour becomes unreachable, tear down the hardware ARP entry
  and mark linked nexthops as unresolved so traffic traps to the CPU.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_router.c  | 108 ++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
index 5f6b4288755e..4e8950d6535f 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
@@ -2525,6 +2525,104 @@ static int sparx5_rr_fib_event(struct notifier_block *nb, unsigned long event,
 	return NOTIFY_BAD;
 }
 
+static void sparx5_rr_neigh_event_work(struct work_struct *work)
+{
+	struct sparx5_rr_netevent_work *net_work =
+		container_of(work, struct sparx5_rr_netevent_work, work);
+	unsigned char hwaddr[ETH_ALEN] __aligned(2);
+	struct sparx5 *sparx5 = net_work->sparx5;
+	struct neighbour *n = net_work->neigh;
+	struct sparx5_rr_neigh_key key = { };
+	struct sparx5_rr_neigh_entry *entry;
+	bool entry_connected;
+	u8 nud_state, dead;
+
+	sparx5_rr_nb2neigh_key(n, &key);
+
+	/* Frames with link-local dip are trapped, so ignore the neighbour. */
+	if (key.iaddr.version == SPARX5_IPV6 &&
+	    ipv6_addr_type(&key.iaddr.ipv6) & IPV6_ADDR_LINKLOCAL)
+		goto out;
+
+	/* If n changes after this read section, we will get another neigh
+	 * event, which is processed after the current one.
+	 */
+	read_lock_bh(&n->lock);
+	ether_addr_copy(hwaddr, n->ha);
+	nud_state = n->nud_state;
+	dead = n->dead;
+	read_unlock_bh(&n->lock);
+
+	mutex_lock(&sparx5->router->lock);
+
+	entry_connected = nud_state & NUD_VALID && !dead;
+	entry = sparx5_rr_neigh_entry_lookup(sparx5, &key);
+	if (!entry_connected && !entry)
+		goto out_mutex;
+
+	if (!entry) {
+		entry = sparx5_rr_neigh_entry_create(sparx5, &key);
+		if (IS_ERR(entry))
+			goto out_mutex;
+	}
+
+	if (entry->connected && entry_connected &&
+	    ether_addr_equal(entry->hwaddr, hwaddr))
+		goto out_mutex;
+
+	ether_addr_copy(entry->hwaddr, hwaddr);
+	sparx5_rr_neigh_entry_update(sparx5, entry, entry_connected);
+	sparx5_rr_nexthops_update_notify(sparx5, entry, entry_connected);
+	if (!entry_connected)
+		sparx5_rr_neigh_entry_put(sparx5, entry);
+
+out_mutex:
+	mutex_unlock(&sparx5->router->lock);
+out:
+	neigh_release(n);
+	kfree(net_work);
+}
+
+/* Handle neighbour update events. Used to manage neigh_entries. Called in
+ * atomic context, with rcu_read_lock().
+ */
+static int sparx5_rr_netevent_event(struct notifier_block *nb,
+				    unsigned long event, void *ptr)
+{
+	struct sparx5_rr_netevent_work *net_work;
+	struct sparx5_router *router;
+	struct sparx5_port *port;
+	struct neighbour *n;
+
+	router = container_of(nb, struct sparx5_router, netevent_nb);
+
+	switch (event) {
+	case NETEVENT_NEIGH_UPDATE:
+		n = ptr;
+
+		if (n->tbl->family != AF_INET && n->tbl->family != AF_INET6)
+			return NOTIFY_DONE;
+
+		port = sparx5_port_dev_lower_find(n->dev);
+		if (!port)
+			return NOTIFY_DONE;
+
+		net_work = kzalloc_obj(*net_work, GFP_ATOMIC);
+		if (!net_work)
+			return NOTIFY_BAD;
+
+		INIT_WORK(&net_work->work, sparx5_rr_neigh_event_work);
+		net_work->sparx5 = router->sparx5;
+		net_work->neigh = neigh_clone(n);
+		net_work->event = event;
+		sparx5_rr_schedule_work(router->sparx5, &net_work->work);
+
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_DONE;
+};
+
 static void sparx5_rr_leg_base_mac_set(struct sparx5 *sparx5,
 				       unsigned char mac[ETH_ALEN])
 {
@@ -2903,10 +3001,15 @@ int sparx5_rr_router_init(struct sparx5 *sparx5)
 		 ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL, sparx5,
 		 ANA_ACL_VCAP_S2_MISC_CTRL);
 
+	r->netevent_nb.notifier_call = sparx5_rr_netevent_event;
+	err = register_netevent_notifier(&r->netevent_nb);
+	if (err)
+		goto err_workqueue_destroy;
+
 	r->fib_nb.notifier_call = sparx5_rr_fib_event;
 	err = register_fib_notifier(&init_net, &r->fib_nb, NULL, NULL);
 	if (err)
-		goto err_workqueue_destroy;
+		goto err_unreg_netevent_notifier;
 
 	r->inetaddr_nb.notifier_call = sparx5_rr_inetaddr_event;
 	err = register_inetaddr_notifier(&r->inetaddr_nb);
@@ -2945,6 +3048,8 @@ int sparx5_rr_router_init(struct sparx5 *sparx5)
 	unregister_inetaddr_notifier(&r->inetaddr_nb);
 err_unreg_fib_notifier:
 	unregister_fib_notifier(&init_net, &r->fib_nb);
+err_unreg_netevent_notifier:
+	unregister_netevent_notifier(&r->netevent_nb);
 err_workqueue_destroy:
 	destroy_workqueue(r->sparx5_router_owq);
 err_fib_ht_destroy:
@@ -2979,6 +3084,7 @@ void sparx5_rr_router_deinit(struct sparx5 *sparx5)
 	unregister_inetaddr_validator_notifier(&router->inetaddr_valid_nb);
 	unregister_inetaddr_notifier(&router->inetaddr_nb);
 	unregister_fib_notifier(&init_net, &router->fib_nb);
+	unregister_netevent_notifier(&router->netevent_nb);
 	destroy_workqueue(router->sparx5_router_owq);
 	sparx5_rr_fib_flush(sparx5);
 	rhashtable_destroy(&router->fib_ht);

-- 
2.52.0


