Return-Path: <netdev+bounces-298637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3EnUKGH+K2rBJAQAu9opvQ
	(envelope-from <netdev+bounces-298637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:41:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34252679697
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:41:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b="qkkgmv/p";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298637-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298637-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00EDD303E26C
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373C03E51EC;
	Fri, 12 Jun 2026 12:39:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378913E9C2B;
	Fri, 12 Jun 2026 12:39:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267945; cv=none; b=lZ+J7J/BcGC8YmW2ekxPPcvz8OiIQzIorQYRGVkpr3zxbxm6J7QXIjnyu1p4jp/ATYZ6IQbrR3zSAiprZE1aQ/CQXhoF8A+gXcZMFjZ/Ncuq1xJW25Dyn98O8sLYcQug4SS6pwkNRdE3x5ywAaHiBbJpPcbDCeISbYhpVwMr0f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267945; c=relaxed/simple;
	bh=DzBNI2vsIjN1KIHl3jqipT/tsyHKQQQHVPGjYlzi00o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XW0jRxr+WH501V8K1+wRVN4QvM93wdNySPdcD3KGFnqHZK2qtPQD3cG22p3Y5sHOY0SNBu8VoUIYMppeSoMlzZNbCtk95Wz/Hlvuk0Ws/vqiQ9jsPa8iGccppvXWZw9EKXjzy80TNBVqzFD89xOA+1zi7b0EFspDei1oAAK+hRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qkkgmv/p; arc=none smtp.client-ip=68.232.154.123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781267941; x=1812803941;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=DzBNI2vsIjN1KIHl3jqipT/tsyHKQQQHVPGjYlzi00o=;
  b=qkkgmv/pxCaZPO/5J48oyB1+1/D8sS4jPDSMowrO7FA+H1RTZvhhIfUe
   6tX4kAUAkcTLf2zBXhfWah4zD8I6a52mOy+3wYCwKZIuz/Td3HrkIzViM
   rutEnL8pvpCEgknwGQQxD8pRpHl/NoSmRmIchBLZHtrIZzS9RwUcbZ5zW
   LC26XHjc/lbxezX/i/1JxNEJwZTnLKPIpa8StIL8MwjBBampVV6xj9wC9
   SbF3exg6SkB6k5xmIRL7fVxnmKjiEGp1DO+a4lnMlkrri/MRmoJEsrul4
   eBptVkB26NR2/zIE7AhVv5r8/nD6ItuTykSRK7WF/6vWld93XR/QNBCBK
   g==;
X-CSE-ConnectionGUID: u8vidsDZQTu/cyxLZ1BuoA==
X-CSE-MsgGUID: q5cUwB9qTBKFlGYzeQMw2A==
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="226230763"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 05:39:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Fri, 12 Jun 2026 05:38:59 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Jun 2026 05:38:57 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Fri, 12 Jun 2026 14:37:17 +0200
Subject: [PATCH net-next 8/9] net: sparx5: add L3 FIB, nexthop and
 neighbour entry management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260612-sparx5_l3_routing-v1-8-fc3c10160f49@microchip.com>
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
	TAGGED_FROM(0.00)[bounces-298637-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,microchip.com:dkim,microchip.com:email,microchip.com:mid,microchip.com:from_mime,fri.fi:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34252679697

Add the data path for L3 unicast route offloading for IPv4 and IPv6 FIB
and nexthop groups.

* FIB entry lifecycle management. FIB entries are mapped to hardware
  using LPM VCAP rules.

* Nexthop group and nexthop lifecycle management. These are mapped to
  hardware using an ARP table for ECMP, and inline vcap actions for
  single nexthops. Each FIB entry has exactly one nexthop group. As a
  simplification each FIB has a copy of its nexthop group, and we do
  not support nexthop objects.

* Neighbour (ARP/NDP) lifecycle management. These are referenced by
  both nexthops and FIB entries, and are shared amongst them. When a
  neighbour referenced by a nexthop is removed we set the HW mac to
  zero which makes sure traffic for the nexthop is trapped. A
  neighbour will also have an associated /32 or /128 route in the LPM
  VCAP for traffic destined directly to the neighbour.

Neighbour entries are created as a side effect of nexthop resolution
but are not yet updated from ARP/NDP events. Neighbour event handling
to activate MAC resolution is added in the next patch.

The three lifecycles are handled in a single patch because they are
mutually entangled. In particular, sparx5_rr_fib_entry_destroy()
walks fib_entry->neigh_list and calls sparx5_rr_neigh_entry_update(),
sparx5_rr_nexthops_update_notify() and sparx5_rr_neigh_entry_put() on
each entry.

The same neigh_entry and nexthop helpers invoked by the
NETEVENT_NEIGH_UPDATE handler added in the following patch. A FIB
teardown must therefore call into the neighbour path, and a neighbour
update must call into the nexthop path, so the three CRUD layers have to
land together for the patch to compile and for the destroy paths to be
consistent.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |    3 +
 .../net/ethernet/microchip/sparx5/sparx5_router.c  | 1942 +++++++++++++++++++-
 2 files changed, 1943 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 5dc18b8dbed0..662d5e013047 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -529,11 +529,14 @@ struct sparx5_router {
 	struct notifier_block netdevice_nb;
 	struct notifier_block inet6addr_nb;
 	struct notifier_block inet6addr_valid_nb;
+	struct rhashtable neigh_ht;
+	struct rhashtable fib_ht;
 	struct sparx5_rr_hw_route link_local; /* Trap all link-local traffic. */
 	struct net_device *port_dev; /* For VCAP API. */
 
 	struct list_head fib_lpm4_list;
 	struct list_head fib_lpm6_list;
+	struct list_head fib_list; /* All fib entries, for teardown */
 	struct mutex lock; /* Global router lock for all shared data. */
 
 	struct workqueue_struct *sparx5_router_owq;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
index 03923d91fdfb..5f6b4288755e 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
@@ -225,6 +225,7 @@ struct sparx5_rr_neigh_entry {
 		struct net_device *dev;
 		struct sparx5_iaddr iaddr;
 	} key;
+	netdevice_tracker dev_tracker;
 	struct rhash_head ht_node;
 	struct sparx5_rr_fib_entry *fib_entry;
 	struct list_head fib_list_node; /* Fib route for this neighbour */
@@ -282,6 +283,7 @@ struct sparx5_rr_fib_entry {
 	enum sparx5_rr_fib_type type;
 	struct rhash_head ht_node; /* Router member */
 	struct list_head fib_lpm_node; /* Router member */
+	struct list_head fib_node; /* Router member, all fib entries */
 	struct list_head neigh_list; /* Neighbours under this route */
 	struct sparx5_rr_hw_route hw_route;
 	struct sparx5_rr_nexthop_group *nh_grp;
@@ -305,6 +307,133 @@ static void sparx5_rr_schedule_work(struct sparx5 *sparx5,
 	queue_work(sparx5->router->sparx5_router_owq, work);
 }
 
+static void sparx5_rr_fib_info_init(struct sparx5_rr_fib_info *fi,
+				    enum sparx5_rr_l3_version version)
+{
+	fi->version = version;
+
+	switch (version) {
+	case SPARX5_IPV4:
+		fi->fen4_info.fi = NULL;
+		return;
+	case SPARX5_IPV6:
+		fi->fe6_info.nrt6 = 0;
+		fi->fe6_info.rt_arr = NULL;
+		return;
+	}
+}
+
+/* Return number of nexthops. */
+static int sparx5_rr_fib_info_nhs(struct sparx5_rr_fib_info *fi)
+{
+	switch (fi->version) {
+	case SPARX5_IPV4:
+		return fib_info_num_path(fi->fen4_info.fi);
+	case SPARX5_IPV6:
+		return fi->fe6_info.nrt6;
+	default:
+		WARN_ON(1);
+		return 0;
+	}
+}
+
+static struct fib_nh_common *
+sparx5_rr_fib_info_nhc(struct sparx5_rr_fib_info *fi, int nhsel)
+{
+	switch (fi->version) {
+	case SPARX5_IPV4:
+		return fib_info_nhc(fi->fen4_info.fi, nhsel);
+	case SPARX5_IPV6:
+		return &fi->fe6_info.rt_arr[nhsel]->fib6_nh->nh_common;
+	default:
+		WARN_ON(1);
+		return NULL;
+	}
+}
+
+static bool sparx5_rr_fib_info_is_nh_obj(struct sparx5_rr_fib_info *fi)
+{
+	switch (fi->version) {
+	case SPARX5_IPV4:
+		return !!fi->fen4_info.fi->nh;
+	case SPARX5_IPV6:
+		return !!fi->fe6_info.rt_arr[0]->nh;
+	default:
+		WARN_ON(1);
+		return false;
+	}
+}
+
+static u8 sparx5_rr_fib_info_type(struct sparx5_rr_fib_info *fi)
+{
+	switch (fi->version) {
+	case SPARX5_IPV4:
+		return fi->fen4_info.type;
+	case SPARX5_IPV6:
+		return fi->fe6_info.rt_arr[0]->fib6_type;
+	default:
+		WARN_ON(1);
+		return RTN_UNSPEC;
+	}
+}
+
+static u32 sparx5_rr_fib_info_tb_id(struct sparx5_rr_fib_info *fi)
+{
+	switch (fi->version) {
+	case SPARX5_IPV4:
+		return fi->fen4_info.tb_id;
+	case SPARX5_IPV6:
+		return fi->fe6_info.rt_arr[0]->fib6_table->tb6_id;
+	default:
+		WARN_ON(1);
+		return RT_TABLE_UNSPEC;
+	}
+}
+
+static bool sparx5_rr_fib_info_should_ignore(struct sparx5_rr_fib_info *fi)
+{
+	return fi->version == SPARX5_IPV6 &&
+	       ipv6_addr_type(&fi->fe6_info.rt_arr[0]->fib6_dst.addr) &
+		       (IPV6_ADDR_MULTICAST | IPV6_ADDR_LINKLOCAL);
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static void sparx5_rr_rt6_release(struct fib6_info *rt)
+{
+	if (!rt->nh)
+		rt->fib6_nh->fib_nh_flags &= ~RTNH_F_OFFLOAD;
+
+	fib6_info_release(rt);
+}
+#else
+static void sparx5_rr_rt6_release(struct fib6_info *rt)
+{
+}
+#endif
+
+static void sparx5_rr_fib6_info_put(struct sparx5_rr_fib6_entry_info *fi)
+{
+	for (int i = 0; i < fi->nrt6; i++)
+		sparx5_rr_rt6_release(fi->rt_arr[i]);
+
+	kfree(fi->rt_arr);
+	fi->nrt6 = 0;
+	fi->rt_arr = NULL;
+}
+
+static void sparx5_rr_fib_info_put(struct sparx5_rr_fib_info *fi)
+{
+	if (fi->version == SPARX5_IPV4) {
+		if (fi->fen4_info.fi) {
+			fib_info_put(fi->fen4_info.fi);
+			fi->fen4_info.fi = NULL;
+		}
+		return;
+	}
+
+	sparx5_rr_fib6_info_put(&fi->fe6_info);
+}
+
 static void sparx5_rr_split_mac(unsigned char mac[ETH_ALEN], u32 split,
 				u32 *msb, u32 *lsb)
 {
@@ -315,6 +444,28 @@ static void sparx5_rr_split_mac(unsigned char mac[ETH_ALEN], u32 split,
 	*msb = m >> split;
 }
 
+static int sparx5_rr_arp_tbl_grp_alloc(struct sparx5 *sparx5,
+				       unsigned int nh_grp_size)
+{
+	int offset;
+
+	offset = bitmap_find_next_zero_area(sparx5->router->arp_tbl_mask,
+					    sparx5->data->consts->arp_tbl_cnt,
+					    0, nh_grp_size, 0);
+	if (offset >= sparx5->data->consts->arp_tbl_cnt)
+		return -ENOMEM;
+
+	bitmap_set(sparx5->router->arp_tbl_mask, offset, nh_grp_size);
+
+	return offset;
+}
+
+static void sparx5_rr_arp_tbl_grp_free(struct sparx5 *sparx5,
+				       unsigned int nh_grp_size, int offset)
+{
+	bitmap_clear(sparx5->router->arp_tbl_mask, offset, nh_grp_size);
+}
+
 static int sparx5_vmid_alloc(struct sparx5 *sparx5)
 {
 	int vmid;
@@ -334,6 +485,104 @@ static void sparx5_vmid_free(struct sparx5 *sparx5, u16 vmid)
 	clear_bit(vmid, sparx5->router->vmid_mask);
 }
 
+static void sparx5_rr_nb2neigh_key(struct neighbour *n,
+				   struct sparx5_rr_neigh_key *key)
+{
+	memset(key, 0, sizeof(*key));
+
+	/* The primary_key, tbl->family and dev are constant for the lifetime of
+	 * the neighbour, so we can read them without n->lock.
+	 */
+	if (n->tbl->family == AF_INET) {
+		key->iaddr.version = SPARX5_IPV4;
+		key->iaddr.ipv4 = *(__be32 *)n->primary_key;
+	} else {
+		key->iaddr.version = SPARX5_IPV6;
+		key->iaddr.ipv6 = *(struct in6_addr *)n->primary_key;
+	}
+
+	key->dev = n->dev;
+}
+
+static void
+sparx5_rr_neigh_entry_offload_mark(struct sparx5_rr_neigh_entry *entry,
+				   bool offloaded)
+{
+	struct neighbour *n;
+
+	if (!entry->neigh_tbl)
+		return;
+
+	n = neigh_lookup(entry->neigh_tbl, &entry->key.iaddr,
+			 entry->key.dev);
+	if (!n)
+		return;
+
+	write_lock_bh(&n->lock);
+	if (offloaded)
+		n->flags |= NTF_OFFLOADED;
+	else
+		n->flags &= ~NTF_OFFLOADED;
+	write_unlock_bh(&n->lock);
+
+	neigh_release(n);
+}
+
+static const struct rhashtable_params sparx5_neigh_ht_params = {
+	.key_offset = offsetof(struct sparx5_rr_neigh_entry, key),
+	.head_offset = offsetof(struct sparx5_rr_neigh_entry, ht_node),
+	.key_len = sizeof(struct sparx5_rr_neigh_key),
+	.automatic_shrinking = true,
+};
+
+static const struct rhashtable_params sparx5_rr_fib_entry_ht_params = {
+	.key_offset = offsetof(struct sparx5_rr_fib_entry, key),
+	.head_offset = offsetof(struct sparx5_rr_fib_entry, ht_node),
+	.key_len = sizeof(struct sparx5_rr_fib_key),
+	.automatic_shrinking = true,
+};
+
+static void sparx5_rr_to_fib4_key(u32 dst, int dst_len, u32 tb_id,
+				  struct sparx5_rr_fib_key *key)
+{
+	memset(key, 0, sizeof(*key));
+	key->addr.version = SPARX5_IPV4;
+	key->addr.ipv4 = cpu_to_be32(dst);
+	key->prefix_len = dst_len;
+	key->tb_id = tb_id;
+}
+
+static void sparx5_rr_to_fib6_key(struct in6_addr *addr, int prefix_len,
+				  u32 tb_id, struct sparx5_rr_fib_key *key)
+{
+	memset(key, 0, sizeof(*key));
+	key->addr.version = SPARX5_IPV6;
+	memcpy(&key->addr.ipv6, addr, sizeof(*addr));
+	key->prefix_len = prefix_len;
+	key->tb_id = tb_id;
+}
+
+static void sparx5_rr_fib_info_to_fib_key(struct sparx5_rr_fib_info *fi,
+					  struct sparx5_rr_fib_key *key)
+{
+	struct fib_entry_notifier_info *fen_info;
+	struct fib6_info *rt;
+
+	switch (fi->version) {
+	case SPARX5_IPV4:
+		fen_info = &fi->fen4_info;
+		sparx5_rr_to_fib4_key(fen_info->dst, fen_info->dst_len,
+				      fen_info->tb_id, key);
+		return;
+	case SPARX5_IPV6:
+		rt = fi->fe6_info.rt_arr[0];
+
+		sparx5_rr_to_fib6_key(&rt->fib6_dst.addr, rt->fib6_dst.plen,
+				      rt->fib6_table->tb6_id, key);
+		return;
+	}
+}
+
 static void sparx5_rr_inet6_make_mask_le(int logmask, u8 *mask)
 {
 	/* Caller must ensure 0 <= logmask <= 128 */
@@ -350,6 +599,81 @@ static void sparx5_rr_inet6_make_mask_le(int logmask, u8 *mask)
 		mask[15 - byte_prefix] = GENMASK(7, 7 - rem + 1);
 }
 
+static bool sparx5_rr_fib_entry_lpm_match(struct sparx5_iaddr *addr,
+					  struct sparx5_rr_fib_entry *fib_entry)
+{
+	__be32 mask;
+
+	switch (addr->version) {
+	case SPARX5_IPV4:
+		mask = inet_make_mask(fib_entry->key.prefix_len);
+		return !((addr->ipv4 ^ fib_entry->key.addr.ipv4) & mask);
+	case SPARX5_IPV6:
+		return ipv6_prefix_equal(&addr->ipv6,
+					 &fib_entry->key.addr.ipv6,
+					 fib_entry->key.prefix_len);
+	default:
+		WARN_ON(1);
+		return false;
+	}
+}
+
+static struct list_head *sparx5_rr_fib_lpm_get(struct sparx5 *sparx5,
+					       struct sparx5_iaddr *addr)
+{
+	return addr->version == SPARX5_IPV6
+		? &sparx5->router->fib_lpm6_list
+		: &sparx5->router->fib_lpm4_list;
+}
+
+static struct sparx5_rr_fib_entry *
+sparx5_rr_fib_lpm_lookup(struct sparx5 *sparx5, struct sparx5_iaddr *addr)
+{
+	struct list_head *lpm_backend = sparx5_rr_fib_lpm_get(sparx5, addr);
+	struct sparx5_rr_fib_entry *iter;
+
+	list_for_each_entry(iter, lpm_backend, fib_lpm_node)
+		if (sparx5_rr_fib_entry_lpm_match(addr, iter))
+			return iter;
+
+	return NULL;
+}
+
+static void sparx5_rr_fib_lpm_insert(struct sparx5 *sparx5,
+				     struct sparx5_rr_fib_entry *fib_entry)
+{
+	struct list_head *lpm_backend =
+		sparx5_rr_fib_lpm_get(sparx5, &fib_entry->key.addr);
+	struct sparx5_rr_fib_entry *iter, *next = NULL;
+
+	/* No need to search through local FIB entries */
+	if (fib_entry->type != SPARX5_RR_FIB_TYPE_UNICAST)
+		return;
+
+	list_for_each_entry(iter, lpm_backend, fib_lpm_node) {
+		if (fib_entry->sort_key < iter->sort_key) {
+			next = iter;
+			break;
+		}
+	}
+
+	if (!next) {
+		list_add_tail(&fib_entry->fib_lpm_node, lpm_backend);
+		return;
+	}
+
+	/* Add before next entry */
+	list_add_tail(&fib_entry->fib_lpm_node, &next->fib_lpm_node);
+}
+
+static void sparx5_rr_fib_lpm_remove(struct sparx5_rr_fib_entry *fib_entry)
+{
+	if (fib_entry->type != SPARX5_RR_FIB_TYPE_UNICAST)
+		return;
+
+	list_del(&fib_entry->fib_lpm_node);
+}
+
 static int sparx5_rr_lpm_rule_xip_add(struct vcap_rule *rule,
 				      struct sparx5_iaddr *addr, u32 prefix_len)
 {
@@ -387,6 +711,668 @@ sparx5_rr_leg_find_by_dev(struct sparx5 *sparx5, struct net_device *dev)
 	return NULL;
 }
 
+static struct sparx5_rr_fib_entry *
+sparx5_rr_fib_entry_lookup(struct sparx5 *sparx5, struct sparx5_rr_fib_key *key)
+{
+	return rhashtable_lookup_fast(&sparx5->router->fib_ht, key,
+				      sparx5_rr_fib_entry_ht_params);
+}
+
+static int sparx5_rr_fib_entry_insert(struct sparx5 *sparx5,
+				      struct sparx5_rr_fib_entry *fib_entry)
+{
+	return rhashtable_insert_fast(&sparx5->router->fib_ht,
+				      &fib_entry->ht_node,
+				      sparx5_rr_fib_entry_ht_params);
+}
+
+static void sparx5_rr_fib_entry_remove(struct sparx5 *sparx5,
+				       struct sparx5_rr_fib_entry *fib_entry)
+{
+	rhashtable_remove_fast(&sparx5->router->fib_ht, &fib_entry->ht_node,
+			       sparx5_rr_fib_entry_ht_params);
+}
+
+static struct sparx5_rr_neigh_entry *
+sparx5_rr_neigh_entry_lookup(struct sparx5 *sparx5,
+			     struct sparx5_rr_neigh_key *key)
+{
+	return rhashtable_lookup_fast(&sparx5->router->neigh_ht, key,
+				      sparx5_neigh_ht_params);
+}
+
+static int sparx5_rr_neigh_entry_insert(struct sparx5 *sparx5,
+					struct sparx5_rr_neigh_entry *entry)
+{
+	return rhashtable_insert_fast(&sparx5->router->neigh_ht,
+				      &entry->ht_node, sparx5_neigh_ht_params);
+}
+
+static void sparx5_rr_neigh_entry_remove(struct sparx5 *sparx5,
+					 struct sparx5_rr_neigh_entry *entry)
+{
+	rhashtable_remove_fast(&sparx5->router->neigh_ht, &entry->ht_node,
+			       sparx5_neigh_ht_params);
+}
+
+static int sparx5_lower_dev_walk(struct net_device *lower_dev,
+				 struct netdev_nested_priv *priv)
+{
+	int ret = 0;
+
+	if (sparx5_netdevice_check(lower_dev)) {
+		priv->data = (void *)netdev_priv(lower_dev);
+		ret = 1;
+	}
+
+	return ret;
+}
+
+static struct sparx5_port *
+sparx5_port_dev_lower_find_rcu(struct net_device *dev)
+{
+	struct netdev_nested_priv priv = {
+		.data = NULL,
+	};
+
+	if (sparx5_netdevice_check(dev))
+		return netdev_priv(dev);
+
+	netdev_walk_all_lower_dev_rcu(dev, sparx5_lower_dev_walk, &priv);
+
+	return priv.data;
+}
+
+static struct sparx5_port *sparx5_port_dev_lower_find(struct net_device *dev)
+{
+	struct sparx5_port *port;
+
+	rcu_read_lock();
+	port = sparx5_port_dev_lower_find_rcu(dev);
+	rcu_read_unlock();
+
+	return port;
+}
+
+static struct sparx5_rr_neigh_entry *
+sparx5_rr_neigh_entry_alloc(struct sparx5 *sparx5,
+			    struct sparx5_rr_neigh_key *key,
+			    struct sparx5_rr_router_leg *leg)
+{
+	struct sparx5_rr_neigh_entry *entry;
+
+	entry = kzalloc_obj(*entry);
+	if (!entry)
+		return NULL;
+
+	memcpy(&entry->key, key, sizeof(*key));
+	entry->vmid = leg->vmid;
+
+	switch (key->iaddr.version) {
+	case SPARX5_IPV4:
+		entry->neigh_tbl = &arp_tbl;
+		break;
+	case SPARX5_IPV6:
+#if IS_ENABLED(CONFIG_IPV6)
+		entry->neigh_tbl = &nd_tbl;
+		break;
+#else
+		kfree(entry);
+		return NULL;
+#endif
+	}
+
+	INIT_LIST_HEAD(&entry->nexthop_list);
+	INIT_LIST_HEAD(&entry->fib_list_node);
+
+	return entry;
+}
+
+static int sparx5_rr_neigh_entry_fib_link(struct sparx5 *sparx5,
+					  struct sparx5_rr_neigh_entry *entry)
+{
+	struct sparx5_rr_fib_entry *fib_entry;
+
+	fib_entry = sparx5_rr_fib_lpm_lookup(sparx5, &entry->key.iaddr);
+	if (!fib_entry)
+		return -ENOENT;
+
+	list_add(&entry->fib_list_node, &fib_entry->neigh_list);
+	entry->fib_entry = fib_entry;
+
+	return 0;
+}
+
+static struct sparx5_rr_neigh_entry *
+sparx5_rr_neigh_entry_create(struct sparx5 *sparx5,
+			     struct sparx5_rr_neigh_key *key)
+{
+	struct sparx5_rr_neigh_entry *entry;
+	struct sparx5_rr_router_leg *leg;
+	struct sparx5_port *port_below;
+	int err;
+
+	port_below = sparx5_port_dev_lower_find(key->dev);
+	if (!port_below)
+		return ERR_PTR(-EINVAL);
+
+	leg = sparx5_rr_leg_find_by_dev(sparx5, key->dev);
+	if (!leg)
+		return ERR_PTR(-EINVAL);
+
+	entry = sparx5_rr_neigh_entry_alloc(sparx5, key, leg);
+	if (!entry)
+		return ERR_PTR(-ENOMEM);
+
+	err = sparx5_rr_neigh_entry_insert(sparx5, entry);
+	if (err)
+		goto err_insert;
+
+	/* Link neigh to the fib which owns the subnet. */
+	err = sparx5_rr_neigh_entry_fib_link(sparx5, entry);
+	if (err)
+		goto err_fib_link;
+
+	netdev_hold(entry->key.dev, &entry->dev_tracker, GFP_KERNEL);
+
+	return entry;
+
+err_fib_link:
+	sparx5_rr_neigh_entry_remove(sparx5, entry);
+err_insert:
+	kfree(entry);
+	return ERR_PTR(err);
+}
+
+static int sparx5_rr_nexthop_neigh_init(struct sparx5 *sparx5,
+					struct sparx5_rr_router_leg *leg,
+					struct sparx5_rr_nexthop *nh)
+{
+	struct sparx5_rr_neigh_entry *neigh_entry;
+	struct net_device *dev = leg->dev;
+	struct sparx5_rr_neigh_key key;
+	struct neighbour *n;
+	int err = 0;
+
+	if (!nh->gateway || nh->neigh_entry || !nh->neigh_tbl)
+		return 0;
+
+	/* Look up neighbor in the global neighbor table. Takes ref to n. */
+	n = neigh_lookup(nh->neigh_tbl, &nh->gw_addr, dev);
+	if (!n) {
+		n = neigh_create(nh->neigh_tbl, &nh->gw_addr, dev);
+		if (IS_ERR(n))
+			return PTR_ERR(n);
+		/* Start arp process */
+		neigh_event_send(n, NULL);
+	}
+
+	sparx5_rr_nb2neigh_key(n, &key);
+
+	neigh_entry = sparx5_rr_neigh_entry_lookup(sparx5, &key);
+	if (!neigh_entry) {
+		neigh_entry = sparx5_rr_neigh_entry_create(sparx5, &key);
+		if (IS_ERR(neigh_entry)) {
+			err = PTR_ERR(neigh_entry);
+			goto out;
+		}
+	}
+
+	nh->neigh_entry = neigh_entry;
+	list_add_tail(&nh->neigh_list_node, &neigh_entry->nexthop_list);
+
+out:
+	neigh_release(n);
+	return err;
+}
+
+static void sparx5_rr_neigh_entry_destroy(struct sparx5 *sparx5,
+					  struct sparx5_rr_neigh_entry *entry)
+{
+	WARN_ON(entry->hw_route.vrule_id_valid);
+
+	if (entry->fib_entry)
+		list_del(&entry->fib_list_node);
+
+	sparx5_rr_neigh_entry_offload_mark(entry, false);
+	sparx5_rr_neigh_entry_remove(sparx5, entry);
+	netdev_put(entry->key.dev, &entry->dev_tracker);
+
+	kfree(entry);
+}
+
+static void sparx5_rr_neigh_entry_put(struct sparx5 *sparx5,
+				      struct sparx5_rr_neigh_entry *neigh_entry)
+{
+	if (neigh_entry && list_empty(&neigh_entry->nexthop_list) &&
+	    !neigh_entry->hw_route.vrule_id_valid)
+		sparx5_rr_neigh_entry_destroy(sparx5, neigh_entry);
+}
+
+static void sparx5_rr_nexthop_deinit(struct sparx5 *sparx5,
+				     struct sparx5_rr_nexthop *nh)
+{
+	struct sparx5_rr_neigh_entry *neigh_entry = nh->neigh_entry;
+
+	if (neigh_entry) {
+		list_del(&nh->neigh_list_node);
+		sparx5_rr_neigh_entry_put(sparx5, neigh_entry);
+	}
+
+	nh->neigh_entry = NULL;
+}
+
+static int sparx5_rr_nexthop_init(struct sparx5 *sparx5,
+				  struct sparx5_rr_nexthop_group *nh_grp,
+				  struct sparx5_rr_nexthop *nh,
+				  struct fib_nh_common *fnhc)
+{
+	struct sparx5_rr_router_leg *leg;
+
+	nh->ifindex = -1;
+	nh->grp = nh_grp;
+	nh->gateway = fnhc->nhc_gw_family != 0;
+	nh->trapped = false;
+	nh->neigh_entry = NULL;
+	nh->neigh_tbl = NULL;
+
+	memset(&nh->gw_addr, 0, sizeof(nh->gw_addr));
+
+	if (!nh->gateway)
+		return 0;
+
+	switch (fnhc->nhc_gw_family) {
+	case AF_INET:
+		nh->gw_addr.version = SPARX5_IPV4;
+		nh->gw_addr.ipv4 = fnhc->nhc_gw.ipv4;
+		nh->neigh_tbl = &arp_tbl;
+		break;
+	case AF_INET6:
+		nh->gw_addr.version = SPARX5_IPV6;
+		nh->gw_addr.ipv6 = fnhc->nhc_gw.ipv6;
+#if IS_ENABLED(CONFIG_IPV6)
+		nh->neigh_tbl = &nd_tbl;
+		break;
+#else
+		return -EINVAL;
+#endif
+	default:
+		WARN_ON_ONCE(1); /* BUG */
+		return 0;
+	}
+
+	/* Blackhole route nexthops have no egress device. */
+	if (!fnhc->nhc_dev)
+		return 0;
+
+	nh->ifindex = fnhc->nhc_dev->ifindex;
+
+	/* When a router leg is removed, all the nexthops with gateway IPs in a
+	 * subnet governed by the leg will receive fib delete events. However,
+	 * these delete events are received one by one. Therefore, this nexthop
+	 * init could have been triggered by a group resize action for such an
+	 * event, where the underlying leg is already removed.
+	 *
+	 * This is not an error. We handle this during offloading by
+	 * trapping nexthops which do not have a neigh_entry. As fib deletion
+	 * events are processed, we converge to the proper state.
+	 */
+	leg = sparx5_rr_leg_find_by_dev(sparx5, fnhc->nhc_dev);
+	if (!leg)
+		return 0;
+
+	return sparx5_rr_nexthop_neigh_init(sparx5, leg, nh);
+}
+
+static int
+sparx5_rr_nexthop_group_info_init(struct sparx5 *sparx5,
+				  struct sparx5_rr_nexthop_group *nh_grp,
+				  struct sparx5_rr_fib_info *fi)
+{
+	unsigned int nhs = sparx5_rr_fib_info_nhs(fi);
+	struct sparx5_rr_nexthop_group_info *nhgi;
+	struct sparx5_rr_nexthop *nh;
+	int err, i;
+
+	nhgi = kzalloc_flex(*nhgi, nexthops, nhs);
+	if (!nhgi)
+		return -ENOMEM;
+
+	nh_grp->nhgi = nhgi;
+	nhgi->grp = nh_grp;
+	nhgi->atbl_offset_valid = false;
+	nhgi->atbl_offset = 0;
+	nhgi->count = nhs;
+
+	for (i = 0; i < nhgi->count; i++) {
+		struct fib_nh_common *fnhc;
+
+		nh = &nhgi->nexthops[i];
+		fnhc = sparx5_rr_fib_info_nhc(fi, i);
+		err = sparx5_rr_nexthop_init(sparx5, nh_grp, nh, fnhc);
+		if (err)
+			goto err_nexthop_init;
+	}
+
+	return 0;
+
+err_nexthop_init:
+	for (i--; i >= 0; i--) {
+		nh = &nhgi->nexthops[i];
+		sparx5_rr_nexthop_deinit(sparx5, nh);
+	}
+	kfree(nhgi);
+	return err;
+}
+
+static void
+sparx5_rr_nexthop_group_info_deinit(struct sparx5 *sparx5,
+				    struct sparx5_rr_nexthop_group *nh_grp)
+{
+	struct sparx5_rr_nexthop_group_info *nhgi = nh_grp->nhgi;
+	struct sparx5_rr_nexthop *nh;
+	int i;
+
+	WARN_ON(!nhgi->count);
+	WARN_ON_ONCE(nhgi->atbl_offset_valid);
+
+	for (i = nhgi->count - 1; i >= 0; i--) {
+		nh = &nhgi->nexthops[i];
+
+		sparx5_rr_nexthop_deinit(sparx5, nh);
+	}
+
+	kfree(nhgi);
+}
+
+static void sparx5_rr_arp_tbl_hw_addr_apply(struct sparx5 *sparx5,
+					    unsigned char mac[ETH_ALEN],
+					    u16 evmid, int offset)
+{
+	u32 mac_msb, mac_lsb;
+
+	sparx5_rr_split_mac(mac, 32, &mac_msb, &mac_lsb);
+
+	spx5_rmw(ANA_L3_ARP_CFG_0_MAC_MSB_SET(mac_msb) |
+		 ANA_L3_ARP_CFG_0_ARP_VMID_SET(evmid) |
+		 ANA_L3_ARP_CFG_0_ARP_ENA_SET(1),
+		 ANA_L3_ARP_CFG_0_ARP_ENA |
+		 ANA_L3_ARP_CFG_0_ARP_VMID |
+		 ANA_L3_ARP_CFG_0_MAC_MSB,
+		 sparx5, ANA_L3_ARP_CFG_0(offset));
+
+	spx5_wr(mac_lsb, sparx5, ANA_L3_ARP_CFG_1(offset));
+}
+
+static void sparx5_rr_arp_tbl_hw_addr_clear(struct sparx5 *sparx5, int offset)
+{
+	spx5_rmw(ANA_L3_ARP_CFG_0_ARP_ENA_SET(0), ANA_L3_ARP_CFG_0_ARP_ENA,
+		 sparx5, ANA_L3_ARP_CFG_0(offset));
+}
+
+static void
+sparx5_rr_nh_grp_arp_tbl_grp_clear(struct sparx5 *sparx5,
+				   struct sparx5_rr_nexthop_group *nh_grp)
+{
+	int offset = nh_grp->nhgi->atbl_offset;
+
+	if (nh_grp->nhgi->atbl_offset_valid) {
+		for (u8 i = 0; i < nh_grp->nhgi->count; i++)
+			sparx5_rr_arp_tbl_hw_addr_clear(sparx5, offset + i);
+		sparx5_rr_arp_tbl_grp_free(sparx5, nh_grp->nhgi->count,
+					   offset);
+	}
+	nh_grp->nhgi->atbl_offset_valid = false;
+}
+
+static void sparx5_rr_nexthop_group_put(struct sparx5 *sparx5,
+					struct sparx5_rr_nexthop_group *nh_grp)
+{
+	sparx5_rr_nh_grp_arp_tbl_grp_clear(sparx5, nh_grp);
+	sparx5_rr_nexthop_group_info_deinit(sparx5, nh_grp);
+	kfree(nh_grp);
+}
+
+static struct sparx5_rr_nexthop_group *
+sparx5_rr_nexthop_group_create(struct sparx5 *sparx5,
+			       struct sparx5_rr_fib_entry *fib_entry)
+{
+	struct sparx5_rr_nexthop_group *nh_grp;
+	int err;
+
+	nh_grp = kzalloc_obj(*nh_grp);
+	if (!nh_grp)
+		return ERR_PTR(-ENOMEM);
+
+	err = sparx5_rr_nexthop_group_info_init(sparx5, nh_grp, &fib_entry->fi);
+	if (err)
+		goto err_group_info_init;
+
+	return nh_grp;
+
+err_group_info_init:
+	kfree(nh_grp);
+	return ERR_PTR(err);
+}
+
+static enum sparx5_rr_fib_type sparx5_rr_rtm_type2fib_type(u8 type)
+{
+	switch (type) {
+	case RTN_UNICAST:
+		return SPARX5_RR_FIB_TYPE_UNICAST;
+	case RTN_LOCAL:
+		return SPARX5_RR_FIB_TYPE_LOCAL;
+	case RTN_MULTICAST:
+		return SPARX5_RR_FIB_TYPE_MULTICAST;
+	case RTN_BLACKHOLE:
+		return SPARX5_RR_FIB_TYPE_BLACKHOLE;
+	case RTN_PROHIBIT:
+		return SPARX5_RR_FIB_TYPE_PROHIBIT;
+	case RTN_UNREACHABLE:
+		return SPARX5_RR_FIB_TYPE_UNREACHABLE;
+	default:
+		return SPARX5_RR_FIB_TYPE_INVALID;
+	}
+}
+
+static void
+sparx5_rr_fib_entry_fib4_info_set(struct sparx5_rr_fib_entry *fib_entry,
+				  struct fib_entry_notifier_info *fen4_info)
+{
+	/* Prevent the fib_info from being deleted while we store the
+	 * fen_info
+	 */
+	fib_info_hold(fen4_info->fi);
+	memcpy(&fib_entry->fi.fen4_info, fen4_info, sizeof(*fen4_info));
+}
+
+static int
+sparx5_rr_fib_entry_fib6_info_add(struct sparx5_rr_fib_entry *fib_entry,
+				  struct sparx5_rr_fib6_entry_info *fib6_info)
+{
+	struct sparx5_rr_fib6_entry_info *f6i = &fib_entry->fi.fe6_info;
+	unsigned int old_ntr6, new_ntr6;
+	struct fib6_info **rt_arr;
+
+	old_ntr6 = f6i->nrt6;
+	new_ntr6 = old_ntr6 + fib6_info->nrt6;
+
+	rt_arr = kzalloc_objs(struct fib6_info *, new_ntr6);
+	if (!rt_arr)
+		return -ENOMEM;
+
+	/* Copy existing */
+	for (int i = 0; i < old_ntr6; i++)
+		rt_arr[i] = f6i->rt_arr[i];
+
+	/* Copy new and hold fib6_info */
+	for (int i = 0; i < fib6_info->nrt6; i++) {
+		struct fib6_info *rt = fib6_info->rt_arr[i];
+
+		rt_arr[old_ntr6 + i] = rt;
+		fib6_info_hold(rt);
+	}
+
+	/* Free old fib6_info */
+	kfree(f6i->rt_arr);
+	f6i->rt_arr = rt_arr;
+	f6i->nrt6 = new_ntr6;
+
+	WARN_ON(!fib_entry->fi.fe6_info.rt_arr);
+	WARN_ON(!fib_entry->fi.fe6_info.nrt6);
+
+	return 0;
+}
+
+static int
+sparx5_rr_fib_entry_fib_info_add(struct sparx5_rr_fib_entry *fib_entry,
+				 struct sparx5_rr_fib_info *fi)
+{
+	switch (fi->version) {
+	case SPARX5_IPV4:
+		/* IPv4 nexthops can not be added/removed piecemeal similar to
+		 * IPv6, so this is a replace in practice.
+		 */
+		sparx5_rr_fib_entry_fib4_info_set(fib_entry, &fi->fen4_info);
+		return 0;
+	case SPARX5_IPV6:
+		return sparx5_rr_fib_entry_fib6_info_add(fib_entry,
+							 &fi->fe6_info);
+	default:
+		WARN_ON(1);
+		return 0;
+	}
+}
+
+static struct sparx5_rr_fib_entry *
+sparx5_rr_fib_entry_create(struct sparx5 *sparx5, struct sparx5_rr_fib_key *key,
+			   struct sparx5_rr_fib_info *fi)
+{
+	struct sparx5_rr_nexthop_group *nh_grp;
+	u8 type = sparx5_rr_fib_info_type(fi);
+	struct sparx5_rr_fib_entry *fib_entry;
+	int err;
+
+	fib_entry = kzalloc_obj(*fib_entry);
+	if (!fib_entry)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(&fib_entry->key, key, sizeof(*key));
+	sparx5_rr_fib_info_init(&fib_entry->fi, fi->version);
+	fib_entry->type = sparx5_rr_rtm_type2fib_type(type);
+	fib_entry->sort_key = LPM_SORT_KEY(key->prefix_len);
+
+	err = sparx5_rr_fib_entry_fib_info_add(fib_entry, fi);
+	if (err)
+		goto err_fib_info_set;
+
+	err = sparx5_rr_fib_entry_insert(sparx5, fib_entry);
+	if (err)
+		goto err_fib_entry_insert;
+
+	nh_grp = sparx5_rr_nexthop_group_create(sparx5, fib_entry);
+	if (IS_ERR(nh_grp)) {
+		err = PTR_ERR(nh_grp);
+		goto err_nexthop_group_create;
+	}
+
+	fib_entry->nh_grp = nh_grp;
+	nh_grp->fib_entry = fib_entry;
+	INIT_LIST_HEAD(&fib_entry->neigh_list);
+
+	list_add(&fib_entry->fib_node, &sparx5->router->fib_list);
+	sparx5_rr_fib_lpm_insert(sparx5, fib_entry);
+
+	return fib_entry;
+
+err_nexthop_group_create:
+	sparx5_rr_fib_entry_remove(sparx5, fib_entry);
+err_fib_entry_insert:
+	sparx5_rr_fib_info_put(&fib_entry->fi);
+err_fib_info_set:
+	kfree(fib_entry);
+
+	return ERR_PTR(err);
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static void
+sparx5_rr_fib6_entry_offload_mark(struct sparx5 *sparx5,
+				  struct sparx5_rr_fib6_entry_info *fen6_info,
+				  bool offload,
+				  bool trap,
+				  bool offload_failed)
+{
+	for (int i = 0; i < fen6_info->nrt6; i++)
+		fib6_info_hw_flags_set(&init_net, fen6_info->rt_arr[i], offload,
+				       trap, offload_failed);
+}
+#else
+static void
+sparx5_rr_fib6_entry_offload_mark(struct sparx5 *sparx5,
+				  struct sparx5_rr_fib6_entry_info *fen6_info,
+				  bool offload,
+				  bool trap,
+				  bool offload_failed)
+{
+}
+#endif
+
+static void
+sparx5_rr_fib4_entry_offload_mark(struct sparx5 *sparx5,
+				  struct fib_entry_notifier_info *fen4_info,
+				  bool offload,
+				  bool trap,
+				  bool offload_failed)
+{
+	struct fib_rt_info fri;
+
+	fri.fi = fen4_info->fi;
+	fri.tb_id = fen4_info->tb_id;
+	fri.dst = cpu_to_be32(fen4_info->dst);
+	fri.dst_len = fen4_info->dst_len;
+	fri.dscp = fen4_info->dscp;
+	fri.type = fen4_info->type;
+	fri.offload = offload;
+	fri.trap = trap;
+	fri.offload_failed = offload_failed;
+
+	fib_alias_hw_flags_set(&init_net, &fri);
+}
+
+static void sparx5_rr_fib_info_offload_mark(struct sparx5 *sparx5,
+					    struct sparx5_rr_fib_info *fi,
+					    bool offload, bool trap,
+					    bool offload_failed)
+{
+	switch (fi->version) {
+	case SPARX5_IPV4:
+		return sparx5_rr_fib4_entry_offload_mark(sparx5,
+							 &fi->fen4_info,
+							 offload, trap,
+							 offload_failed);
+	case SPARX5_IPV6:
+		return sparx5_rr_fib6_entry_offload_mark(sparx5,
+							 &fi->fe6_info,
+							 offload, trap,
+							 offload_failed);
+	}
+}
+
+static void
+sparx5_rr_fib_entry_offload_mark(struct sparx5 *sparx5,
+				 struct sparx5_rr_fib_entry *fib_entry)
+{
+	bool offload, trap, offload_failed;
+
+	offload_failed = fib_entry->offload_fail;
+	offload = !fib_entry->offload_fail;
+	trap = !fib_entry->offload_fail && fib_entry->trap;
+
+	sparx5_rr_fib_info_offload_mark(sparx5, &fib_entry->fi, offload, trap,
+					offload_failed);
+}
+
 static int
 sparx5_rr_lpm_arp_entry_create(struct sparx5 *sparx5,
 			       struct sparx5_iaddr *addr,
@@ -424,6 +1410,472 @@ sparx5_rr_lpm_arp_entry_create(struct sparx5 *sparx5,
 	return err;
 }
 
+static int sparx5_rr_lpm_arp_entry_mod(struct sparx5 *sparx5,
+				       unsigned char mac[ETH_ALEN], u16 evmid,
+				       u32 vrule_id)
+{
+	struct vcap_control *vctrl = sparx5->vcap_ctrl;
+	struct vcap_rule *vrule;
+	u32 mac_msb, mac_lsb;
+	int err;
+
+	sparx5_rr_split_mac(mac, 32, &mac_msb, &mac_lsb);
+
+	vrule = vcap_get_rule(vctrl, vrule_id);
+	if (IS_ERR(vrule))
+		return -EINVAL;
+
+	err = vcap_rule_mod_action_u32(vrule, VCAP_AF_MAC_MSB, mac_msb);
+	err |= vcap_rule_mod_action_u32(vrule, VCAP_AF_MAC_LSB, mac_lsb);
+	err |= vcap_rule_mod_action_u32(vrule, VCAP_AF_ARP_VMID, evmid);
+	err |= vcap_rule_mod_action_bit(vrule, VCAP_AF_ARP_ENA, VCAP_BIT_1);
+
+	err = err ? -EINVAL : vcap_mod_rule(vrule);
+
+	vcap_free_rule(vrule);
+	return err;
+}
+
+static int
+sparx5_rr_fib_entry_update_arp_entry(struct sparx5 *sparx5,
+				     struct sparx5_rr_fib_entry *fib_entry,
+				     unsigned char mac[ETH_ALEN], u16 evmid)
+{
+	struct net_device *pdev = sparx5->router->port_dev;
+	struct vcap_control *vctrl = sparx5->vcap_ctrl;
+	u32 vrule_id = fib_entry->hw_route.vrule_id;
+	struct vcap_rule *vrule;
+	u32 mac_msb, mac_lsb;
+	int err;
+
+	sparx5_rr_split_mac(mac, 32, &mac_msb, &mac_lsb);
+
+	vrule = vcap_get_rule(vctrl, vrule_id);
+	if (IS_ERR(vrule)) {
+		fib_entry->hw_route.vrule_id_valid = false;
+		return PTR_ERR(vrule);
+	}
+
+	switch (vrule->actionset) {
+	case VCAP_AFS_ARP_ENTRY:
+		err = vcap_rule_mod_action_u32(vrule, VCAP_AF_MAC_MSB,
+					       mac_msb);
+		err |= vcap_rule_mod_action_u32(vrule, VCAP_AF_MAC_LSB,
+						mac_lsb);
+
+		err = err ? -EINVAL : vcap_mod_rule(vrule);
+		goto free_rule;
+	case VCAP_AFS_ARP_PTR:
+		/* Convert arp_ptr to arp_entry */
+		err = sparx5_rr_lpm_arp_entry_create(sparx5,
+						     &fib_entry->key.addr,
+						     fib_entry->key.prefix_len,
+						     mac, evmid,
+						     &fib_entry->hw_route);
+		if (err)
+			goto free_rule;
+
+		sparx5_rr_nh_grp_arp_tbl_grp_clear(sparx5, fib_entry->nh_grp);
+		err = vcap_del_rule(vctrl, pdev, vrule_id);
+		goto free_rule;
+	default:
+		err = -EINVAL;
+		WARN_ON(1); /* BUG */
+	}
+
+free_rule:
+	vcap_free_rule(vrule);
+
+	return err;
+}
+
+static int sparx5_rr_lpm_arp_ptr_create(struct sparx5 *sparx5,
+					struct sparx5_iaddr *addr,
+					u32 prefix_len, u32 arp_offset_addr,
+					u8 ecmp_size,
+					struct sparx5_rr_hw_route *hw_route)
+{
+	struct net_device *pdev = sparx5->router->port_dev;
+	struct vcap_control *vctrl = sparx5->vcap_ctrl;
+	u32 priority = LPM_SORT_KEY(prefix_len);
+	struct vcap_rule *rule;
+	int err;
+
+	rule = vcap_alloc_rule(vctrl, pdev, VCAP_CID_PREROUTING_L0,
+			       VCAP_USER_L3, priority, 0);
+	if (IS_ERR(rule))
+		return PTR_ERR(rule);
+
+	err = sparx5_rr_lpm_rule_xip_add(rule, addr, prefix_len);
+	err |= vcap_rule_add_key_u32(rule, VCAP_KF_AFFIX, 0, 0);
+	err |= vcap_rule_add_key_bit(rule, VCAP_KF_DST_FLAG, VCAP_BIT_1);
+	err |= vcap_rule_add_action_u32(rule, VCAP_AF_ARP_PTR, arp_offset_addr);
+	err |= vcap_rule_add_action_bit(rule, VCAP_AF_ARP_PTR_REMAP_ENA,
+				       VCAP_BIT_0);
+	err |= vcap_rule_add_action_u32(rule, VCAP_AF_ECMP_CNT, ecmp_size - 1);
+	err |= vcap_rule_add_action_u32(rule, VCAP_AF_RGID, 0);
+
+	err = err ? -EINVAL : vcap_val_add_rule(rule, LPM_PROTO(addr));
+	if (!err) {
+		hw_route->vrule_id_valid = true;
+		hw_route->vrule_id = rule->id;
+	}
+
+	vcap_free_rule(rule);
+	return err;
+}
+
+/* Get egress mac and vmid for nexthop. */
+static void sparx5_rr_nexthop_egress_derive(struct sparx5_rr_nexthop *nh,
+					    u8 *mac, u16 *vmid)
+{
+	struct sparx5_rr_neigh_entry *nh_neigh = nh->neigh_entry;
+
+	nh->trapped = !nh_neigh || is_zero_ether_addr(nh_neigh->hwaddr);
+
+	if (nh_neigh) {
+		memcpy(mac, nh_neigh->hwaddr, ETH_ALEN);
+		*vmid = nh_neigh->vmid;
+		return;
+	}
+
+	eth_zero_addr(mac);
+	*vmid = 0;
+}
+
+static int
+sparx5_rr_fib_entry_ecmp_hw_apply(struct sparx5 *sparx5,
+				  struct sparx5_rr_fib_entry *fib_entry)
+{
+	struct sparx5_rr_nexthop_group_info *nhgi = fib_entry->nh_grp->nhgi;
+	unsigned char mac[ETH_ALEN] __aligned(2);
+	struct sparx5_rr_nexthop *nh;
+	int err, i, offset;
+	u16 vmid;
+
+	offset = sparx5_rr_arp_tbl_grp_alloc(sparx5, nhgi->count);
+
+	if (offset < 0) {
+		fib_entry->offload_fail = true;
+		return offset;
+	}
+
+	for (i = 0; i < nhgi->count; i++) {
+		nh = &nhgi->nexthops[i];
+
+		sparx5_rr_nexthop_egress_derive(nh, mac, &vmid);
+
+		sparx5_rr_arp_tbl_hw_addr_apply(sparx5, mac, vmid, offset + i);
+	}
+
+	err = sparx5_rr_lpm_arp_ptr_create(sparx5,
+					   &fib_entry->key.addr,
+					   fib_entry->key.prefix_len, offset,
+					   nhgi->count, &fib_entry->hw_route);
+	if (err)
+		goto err_arp_ptr_create;
+
+	nhgi->atbl_offset = offset;
+	nhgi->atbl_offset_valid = true;
+	fib_entry->offload_fail = false;
+
+	return 0;
+
+err_arp_ptr_create:
+	for (i--; i >= 0; i--)
+		sparx5_rr_arp_tbl_hw_addr_clear(sparx5, offset + i);
+	sparx5_rr_arp_tbl_grp_free(sparx5, nhgi->count, offset);
+	fib_entry->offload_fail = true;
+	nhgi->atbl_offset_valid = false;
+
+	return err;
+}
+
+static int
+sparx5_rr_fib_blackhole_hw_apply(struct sparx5 *sparx5,
+				 struct sparx5_rr_fib_entry *fib_entry)
+{
+	unsigned char mac[ETH_ALEN];
+
+	/* Hardware blackholes are implemented by:
+	 *
+	 * 1) Making sure traffic is not trapped with non-zero dmac.
+	 * 2) Using reserved router leg vmid for egress.
+	 * 3) This router leg is attached to a VLAN id > 4095.
+	 * 4) The port-mask for this VLAN is all zero.
+	 *
+	 * The hardware VLAN table has more than 4096 entries. The specific
+	 * size depends on the chip. LAN969x has 4608 and Sparx5 has 5120
+	 * entries. These additional VLAN entries can be used for internal
+	 * logic.
+	 *
+	 * The port-mask for the blackhole VLAN is zero. Therefore, frames
+	 * routed to the blackhole leg will not egress on any ports.
+	 */
+	eth_zero_addr(mac);
+	mac[5] = 0xff;
+
+	return sparx5_rr_lpm_arp_entry_create(sparx5, &fib_entry->key.addr,
+					      fib_entry->key.prefix_len, mac,
+					      SPARX5_BLACKHOLE_VMID(sparx5),
+					      &fib_entry->hw_route);
+}
+
+static int sparx5_rr_fib_entry_hw_apply(struct sparx5 *sparx5,
+					struct sparx5_rr_fib_entry *fib_entry)
+{
+	struct sparx5_rr_nexthop_group_info *nhgi = fib_entry->nh_grp->nhgi;
+	unsigned char mac[ETH_ALEN] __aligned(2);
+	struct sparx5_rr_nexthop *nh;
+	int err = 0;
+	u16 vmid;
+
+	switch (fib_entry->type) {
+	case SPARX5_RR_FIB_TYPE_UNREACHABLE:
+		fallthrough;
+	case SPARX5_RR_FIB_TYPE_PROHIBIT:
+		/* Ensure kernel can respond with correct ICMP packets. */
+		fallthrough;
+	case SPARX5_RR_FIB_TYPE_LOCAL:
+		/* Trap traffic destined for device itself, to ensure
+		 * device can receive traffic even when default gateways are
+		 * configured.
+		 */
+		fib_entry->trap = true;
+
+		/* Trap frames with zero mac, VMID does not matter */
+		eth_zero_addr(mac);
+		err = sparx5_rr_lpm_arp_entry_create(sparx5,
+						     &fib_entry->key.addr,
+						     fib_entry->key.prefix_len,
+						     mac, 0,
+						     &fib_entry->hw_route);
+		goto out;
+
+	case SPARX5_RR_FIB_TYPE_UNICAST:
+		fib_entry->trap = false;
+
+		if (!nhgi->nexthops->gateway) {
+			/* Directly connected subnet. Trap traffic so kernel
+			 * can perform ARP/NDP on our behalf.
+			 */
+			eth_zero_addr(mac);
+			err = sparx5_rr_lpm_arp_entry_create(sparx5,
+							     &fib_entry->key.addr,
+							     fib_entry->key.prefix_len,
+							     mac, 0,
+							     &fib_entry->hw_route);
+			goto out;
+		}
+
+		if (nhgi->count == 1) { /* Use arp_entry */
+			nh = &nhgi->nexthops[0];
+			sparx5_rr_nexthop_egress_derive(nh, mac, &vmid);
+			err = sparx5_rr_lpm_arp_entry_create(sparx5,
+							     &fib_entry->key.addr,
+							     fib_entry->key.prefix_len,
+							     mac, vmid,
+							     &fib_entry->hw_route);
+			goto out;
+		}
+
+		/* Multiple nexthops so we use the HW arp table. */
+		err = sparx5_rr_fib_entry_ecmp_hw_apply(sparx5,
+							fib_entry);
+		goto out;
+
+	case SPARX5_RR_FIB_TYPE_BLACKHOLE:
+		fib_entry->trap = false;
+		err = sparx5_rr_fib_blackhole_hw_apply(sparx5, fib_entry);
+		goto out;
+
+	default:
+		dev_warn(sparx5->dev, "Fib entry offload, unhandled type=%d\n",
+			 fib_entry->type);
+		return -EINVAL;
+	}
+
+out:
+	fib_entry->offload_fail = !!err;
+
+	return err;
+}
+
+static void sparx5_rr_nexthop_neigh_update(struct sparx5 *sparx5,
+					   struct sparx5_rr_nexthop *nh,
+					   bool entry_connected)
+{
+	unsigned char mac[ETH_ALEN] __aligned(2);
+	int err, nh_offset, grp_idx;
+	u16 vmid;
+
+	if (!nh->gateway)
+		return;
+
+	vmid = nh->neigh_entry->vmid;
+
+	/* Trap traffic with zero mac */
+	eth_zero_addr(mac);
+
+	if (entry_connected)
+		ether_addr_copy(mac, nh->neigh_entry->hwaddr);
+
+	if (nh->trapped && !entry_connected)
+		return;
+
+	nh->trapped = !entry_connected;
+
+	if (nh->grp->nhgi->count == 1) {
+		err = sparx5_rr_fib_entry_update_arp_entry(sparx5,
+							   nh->grp->fib_entry,
+							   mac, vmid);
+		if (err)
+			dev_err(sparx5->dev,
+				"Nexthop fib entry update failed\n");
+
+		return;
+	}
+
+	if (!nh->grp->nhgi->atbl_offset_valid)
+		return;
+
+	nh_offset = (int)(ptrdiff_t)(nh - nh->grp->nhgi->nexthops);
+	grp_idx = nh->grp->nhgi->atbl_offset;
+
+	sparx5_rr_arp_tbl_hw_addr_apply(sparx5, mac, vmid, grp_idx + nh_offset);
+}
+
+static void
+sparx5_rr_nexthops_update_notify(struct sparx5 *sparx5,
+				 struct sparx5_rr_neigh_entry *neigh_entry,
+				 bool entry_connected)
+{
+	struct sparx5_rr_nexthop *nh;
+
+	list_for_each_entry(nh, &neigh_entry->nexthop_list, neigh_list_node)
+		sparx5_rr_nexthop_neigh_update(sparx5, nh, entry_connected);
+}
+
+static int sparx5_rr_neigh_entry_hw_apply(struct sparx5 *sparx5,
+					  struct sparx5_rr_neigh_entry *entry)
+{
+	u32 prefix_len = SPARX5_IADDR_LEN(entry->key.iaddr.version);
+
+	if (!entry->hw_route.vrule_id_valid)
+		return sparx5_rr_lpm_arp_entry_create(sparx5,
+						      &entry->key.iaddr,
+						      prefix_len,
+						      entry->hwaddr,
+						      entry->vmid,
+						      &entry->hw_route);
+
+	return sparx5_rr_lpm_arp_entry_mod(sparx5, entry->hwaddr, entry->vmid,
+					    entry->hw_route.vrule_id);
+}
+
+static void sparx5_rr_neigh_entry_update(struct sparx5 *sparx5,
+					 struct sparx5_rr_neigh_entry *entry,
+					 bool adding)
+{
+	struct net_device *pdev = sparx5->router->port_dev;
+	bool offloaded = adding;
+	int err;
+
+	if (!adding && !entry->connected && !entry->hw_route.vrule_id_valid)
+		return;
+
+	entry->connected = adding;
+
+	if (adding) {
+		err = sparx5_rr_neigh_entry_hw_apply(sparx5, entry);
+		if (err)
+			offloaded = false;
+	} else if (entry->hw_route.vrule_id_valid) {
+		vcap_del_rule(sparx5->vcap_ctrl, pdev,
+			      entry->hw_route.vrule_id);
+		entry->hw_route.vrule_id_valid = false;
+	}
+
+	return sparx5_rr_neigh_entry_offload_mark(entry, offloaded);
+}
+
+static void sparx5_rr_fib_entry_destroy(struct sparx5 *sparx5,
+					struct sparx5_rr_fib_entry *fib_entry)
+{
+	struct net_device *pdev = sparx5->router->port_dev;
+	struct sparx5_rr_neigh_entry *neigh_entry, *tmp;
+	struct vcap_control *vctrl = sparx5->vcap_ctrl;
+
+	list_del(&fib_entry->fib_node);
+	sparx5_rr_fib_lpm_remove(fib_entry);
+
+	list_for_each_entry_safe(neigh_entry, tmp, &fib_entry->neigh_list,
+				 fib_list_node) {
+		list_del(&neigh_entry->fib_list_node);
+		neigh_entry->fib_entry = NULL;
+
+		/* Remove LPM VCAP entry for neighbour, if used */
+		sparx5_rr_neigh_entry_update(sparx5, neigh_entry, false);
+		sparx5_rr_nexthops_update_notify(sparx5, neigh_entry, false);
+		sparx5_rr_neigh_entry_put(sparx5, neigh_entry);
+	}
+
+	sparx5_rr_fib_entry_remove(sparx5, fib_entry);
+	sparx5_rr_nexthop_group_put(sparx5, fib_entry->nh_grp);
+	if (fib_entry->hw_route.vrule_id_valid)
+		vcap_del_rule(vctrl, pdev, fib_entry->hw_route.vrule_id);
+	sparx5_rr_fib_info_put(&fib_entry->fi);
+	kfree(fib_entry);
+}
+
+/* Update nexthop group based on current fib_info state. */
+static int
+sparx5_rr_entry_nexthop_group_update(struct sparx5 *sparx5,
+				     struct sparx5_rr_fib_entry *fib_entry)
+{
+	struct net_device *pdev = sparx5->router->port_dev;
+	struct vcap_control *vctrl = sparx5->vcap_ctrl;
+	struct sparx5_rr_nexthop_group *new_nh_grp;
+	struct sparx5_rr_nexthop_group *old_nh_grp;
+	bool old_vrule_id_valid;
+	u32 old_vrule_id;
+	int err;
+
+	old_nh_grp = fib_entry->nh_grp;
+	old_vrule_id = fib_entry->hw_route.vrule_id;
+	old_vrule_id_valid = fib_entry->hw_route.vrule_id_valid;
+
+	/* Prepare new group in SW representation */
+	new_nh_grp = sparx5_rr_nexthop_group_create(sparx5, fib_entry);
+	if (IS_ERR(new_nh_grp)) {
+		dev_warn(sparx5->dev, "Failed to create nexthop group\n");
+		return PTR_ERR(new_nh_grp);
+	}
+
+	fib_entry->nh_grp = new_nh_grp;
+	new_nh_grp->fib_entry = fib_entry;
+
+	/* Write new rule to HW */
+	err = sparx5_rr_fib_entry_hw_apply(sparx5, fib_entry);
+	if (err)
+		goto hw_apply_err;
+
+	/* Clean up old rule and start routing traffic according to new rule */
+	if (old_vrule_id_valid && fib_entry->hw_route.vrule_id != old_vrule_id)
+		vcap_del_rule(vctrl, pdev, old_vrule_id);
+
+	/* Remove old unused group */
+	sparx5_rr_nexthop_group_put(sparx5, old_nh_grp);
+
+	return 0;
+
+hw_apply_err:
+	fib_entry->nh_grp = old_nh_grp;
+	new_nh_grp->fib_entry = NULL;
+	sparx5_rr_nexthop_group_put(sparx5, new_nh_grp);
+	return err;
+}
+
 static void sparx5_rr_leg_hw_init(struct sparx5 *sparx5,
 				  struct sparx5_rr_router_leg *leg)
 {
@@ -599,6 +2051,21 @@ sparx5_rr_router_leg_create(struct sparx5 *sparx5, struct net_device *dev,
 	return leg;
 }
 
+static void sparx5_rr_fib4_del(struct sparx5 *sparx5,
+			       struct sparx5_rr_fib_info *fi)
+{
+	struct sparx5_rr_fib_entry *fib_entry;
+	struct sparx5_rr_fib_key key;
+
+	sparx5_rr_fib_info_to_fib_key(fi, &key);
+
+	fib_entry = sparx5_rr_fib_entry_lookup(sparx5, &key);
+	if (!fib_entry)
+		return;
+
+	sparx5_rr_fib_entry_destroy(sparx5, fib_entry);
+}
+
 static bool sparx5_rr_dev_real_is_vlan_aware(struct net_device *dev)
 {
 	struct net_device *vlan_rdev;
@@ -620,6 +2087,444 @@ static bool sparx5_rr_dev_real_is_vlan_aware(struct net_device *dev)
 	return false;
 }
 
+static bool sparx5_rr_fib_info_should_offload(struct sparx5 *sparx5,
+					      struct sparx5_rr_fib_info *fi)
+{
+	u32 tb_id = sparx5_rr_fib_info_tb_id(fi);
+	u8 type = sparx5_rr_fib_info_type(fi);
+	int nhs = sparx5_rr_fib_info_nhs(fi);
+
+	if (!(type == RTN_UNICAST ||
+	      type == RTN_LOCAL ||
+	      type == RTN_BLACKHOLE ||
+	      type == RTN_PROHIBIT ||
+	      type == RTN_UNREACHABLE))
+		return false;
+
+	if (!(tb_id == RT_TABLE_MAIN ||
+	      tb_id == RT_TABLE_LOCAL))
+		return false;
+
+	/* No support for nexthop objects (optimization for larger scale
+	 * routing). Instead each route has a copy of it's nexthops.
+	 */
+	if (sparx5_rr_fib_info_is_nh_obj(fi))
+		return false;
+
+	/* For IPv4 the nexthops of these route types have NULL egress device.
+	 * However, for IPv6 the nexthops use the loopback interface, so accept
+	 * early.
+	 */
+	if (type == RTN_BLACKHOLE ||
+	    type == RTN_PROHIBIT ||
+	    type == RTN_UNREACHABLE)
+		return true;
+
+	if (nhs > SPARX5_MAX_ECMP_SIZE)
+		return false;
+
+	for (int i = 0; i < nhs; i++) {
+		struct fib_nh_common *nhc = sparx5_rr_fib_info_nhc(fi, i);
+
+		if (nhc->nhc_dev &&
+		    !sparx5_rr_dev_real_is_vlan_aware(nhc->nhc_dev))
+			return false;
+
+		/* HW only supports equal weight nexthops */
+		if (nhc->nhc_weight != 1)
+			return false;
+	}
+
+	return true;
+}
+
+static int sparx5_rr_fib_replace(struct sparx5 *sparx5,
+				 struct sparx5_rr_fib_info *fi)
+{
+	u8 fi_type = sparx5_rr_fib_info_type(fi);
+	struct sparx5_rr_fib_entry *fib_entry;
+	struct sparx5_rr_fib_info old_fi;
+	struct sparx5_rr_fib_key key;
+	int err = 0;
+
+	if (sparx5_rr_fib_info_should_ignore(fi))
+		return 0;
+
+	sparx5_rr_fib_info_to_fib_key(fi, &key);
+
+	fib_entry = sparx5_rr_fib_entry_lookup(sparx5, &key);
+
+	if (!sparx5_rr_fib_info_should_offload(sparx5, fi)) {
+		/* A previously offloadable fib, is modified to unoffloadable
+		 * state, so we must remove it.
+		 */
+		if (fib_entry)
+			sparx5_rr_fib_entry_destroy(sparx5, fib_entry);
+		return 0;
+	}
+
+	if (!fib_entry) {
+		/* Holds refs to kernel fib_info */
+		fib_entry = sparx5_rr_fib_entry_create(sparx5, &key, fi);
+		if (IS_ERR(fib_entry)) {
+			dev_warn(sparx5->dev, "Failed to create fib entry\n");
+			sparx5_rr_fib_info_offload_mark(sparx5, fi, false,
+							false, true);
+			return PTR_ERR(fib_entry);
+		}
+
+		err = sparx5_rr_fib_entry_hw_apply(sparx5, fib_entry);
+		goto out_fib_mark_offload;
+	}
+
+	/* Save old fib_info, add new one, then release old. This ordering
+	 * ensures fib_entry retains valid fi on allocation failure.
+	 */
+	old_fi = fib_entry->fi;
+
+	/* Clear fib_entry fi */
+	sparx5_rr_fib_info_init(&fib_entry->fi, fi->version);
+
+	/* Hold and replace with new fib_info */
+	err = sparx5_rr_fib_entry_fib_info_add(fib_entry, fi);
+	if (err) {
+		fib_entry->fi = old_fi;
+		dev_err(sparx5->dev, "Failed to replace fib info\n");
+		sparx5_rr_fib_info_offload_mark(sparx5, fi, false, false, true);
+		sparx5_rr_fib_entry_destroy(sparx5, fib_entry);
+		return err;
+	}
+
+	/* Release and allow any previous fib_info to be deleted */
+	sparx5_rr_fib_info_put(&old_fi);
+
+	fib_entry->type = sparx5_rr_rtm_type2fib_type(fi_type);
+
+	err = sparx5_rr_entry_nexthop_group_update(sparx5, fib_entry);
+
+out_fib_mark_offload:
+	fib_entry->offload_fail = !!err;
+	sparx5_rr_fib_entry_offload_mark(sparx5, fib_entry);
+	if (err)
+		sparx5_rr_fib_entry_destroy(sparx5, fib_entry);
+	return err;
+}
+
+static void sparx5_rr_fib4_event_work(struct work_struct *work)
+{
+	struct sparx5_fib_event_work *fib_work =
+		container_of(work, struct sparx5_fib_event_work, work);
+	struct sparx5 *sparx5 = fib_work->sparx5;
+	int err;
+
+	mutex_lock(&sparx5->router->lock);
+
+	switch (fib_work->event) {
+	case FIB_EVENT_ENTRY_REPLACE:
+		err = sparx5_rr_fib_replace(sparx5, &fib_work->fi);
+		if (err)
+			dev_warn(sparx5->dev, "FIB replace failed, ip=%pI4l\n",
+				 &fib_work->fi.fen4_info.dst);
+
+		break;
+	case FIB_EVENT_ENTRY_DEL:
+		sparx5_rr_fib4_del(sparx5, &fib_work->fi);
+		break;
+	default:
+		/* FIB_EVENT_ENTRY_APPEND only occurs for IPv6. */
+		WARN_ON_ONCE(1); /* BUG */
+		break;
+	}
+
+	/* Release fib_info hold for workqueue. */
+	sparx5_rr_fib_info_put(&fib_work->fi);
+	mutex_unlock(&sparx5->router->lock);
+	kfree(fib_work);
+}
+
+static int sparx5_rr_fib6_append(struct sparx5 *sparx5,
+				 struct sparx5_rr_fib_info *fi)
+{
+	struct sparx5_rr_fib_entry *fib_entry;
+	struct sparx5_rr_fib_key key;
+	int err = 0;
+
+	if (sparx5_rr_fib_info_should_ignore(fi))
+		return 0;
+
+	sparx5_rr_fib_info_to_fib_key(fi, &key);
+
+	fib_entry = sparx5_rr_fib_entry_lookup(sparx5, &key);
+	if (!fib_entry)
+		return 0;
+
+	/* Are we adding new nexthops which can not be offloaded */
+	if (!sparx5_rr_fib_info_should_offload(sparx5, fi)) {
+		err = -EINVAL;
+		goto out_fib_mark_offload;
+	}
+
+	/* Append new rt_arr data to fen6_info rt data */
+	err = sparx5_rr_fib_entry_fib_info_add(fib_entry, fi);
+	if (err)
+		goto out_fib_mark_offload;
+
+	/* Realloc nexthop group and apply to hw. */
+	err = sparx5_rr_entry_nexthop_group_update(sparx5, fib_entry);
+
+out_fib_mark_offload:
+	fib_entry->offload_fail = !!err;
+	sparx5_rr_fib_entry_offload_mark(sparx5, fib_entry);
+	if (err)
+		sparx5_rr_fib_entry_destroy(sparx5, fib_entry);
+
+	return err;
+}
+
+static bool sparx5_rr_fib6_rt_exists(struct sparx5_rr_fib6_entry_info *f6i,
+				     struct fib6_info *rt)
+{
+	for (int i = 0; i < f6i->nrt6; i++)
+		if (f6i->rt_arr[i] == rt)
+			return true;
+
+	return false;
+}
+
+static int sparx5_rr_fib6_nexthop_prune(struct sparx5 *sparx5,
+					struct sparx5_rr_fib_entry *fib_entry,
+					struct sparx5_rr_fib6_entry_info *f6i)
+{
+	struct fib6_info **old_rt_arr = fib_entry->fi.fe6_info.rt_arr;
+	unsigned int old_nrt6, new_nrt6;
+	struct fib6_info **rt_arr;
+	int j = 0;
+
+	old_nrt6 = fib_entry->fi.fe6_info.nrt6;
+	new_nrt6 = old_nrt6 >= f6i->nrt6 ? old_nrt6 - f6i->nrt6 : 0;
+
+	rt_arr = kzalloc_objs(struct fib6_info *, new_nrt6);
+	if (!rt_arr)
+		return -ENOMEM;
+
+	for (int i = 0; i < old_nrt6; i++) {
+		struct fib6_info *fi = old_rt_arr[i];
+
+		if (sparx5_rr_fib6_rt_exists(f6i, fi)) {
+			sparx5_rr_rt6_release(fi);
+			continue;
+		}
+
+		rt_arr[j++] = fi;
+	}
+
+	/* Assume incoming f6i only contain live nexthops, and no duplicates. */
+	WARN_ON_ONCE(j != new_nrt6);
+
+	kfree(fib_entry->fi.fe6_info.rt_arr);
+	fib_entry->fi.fe6_info.nrt6 = new_nrt6;
+	fib_entry->fi.fe6_info.rt_arr = rt_arr;
+	return 0;
+}
+
+static int sparx5_rr_fib6_del(struct sparx5 *sparx5,
+			      struct sparx5_rr_fib_info *fi)
+{
+	struct sparx5_rr_fib_entry *fib_entry;
+	int nhs = sparx5_rr_fib_info_nhs(fi);
+	struct sparx5_rr_fib_key key;
+	int err;
+
+	sparx5_rr_fib_info_to_fib_key(fi, &key);
+
+	fib_entry = sparx5_rr_fib_entry_lookup(sparx5, &key);
+	if (!fib_entry)
+		return 0;
+
+	/* Full delete. */
+	if (nhs == sparx5_rr_fib_info_nhs(&fib_entry->fi)) {
+		sparx5_rr_fib_entry_destroy(sparx5, fib_entry);
+		return 0;
+	}
+
+	/* Partial delete. Remove fi nexthops from fib_entry. */
+	err = sparx5_rr_fib6_nexthop_prune(sparx5, fib_entry, &fi->fe6_info);
+	if (err)
+		goto err_nexthop_prune;
+
+	/* Realloc nexthop group and apply to hw. */
+	err = sparx5_rr_entry_nexthop_group_update(sparx5, fib_entry);
+
+err_nexthop_prune:
+	fib_entry->offload_fail = !!err;
+	sparx5_rr_fib_entry_offload_mark(sparx5, fib_entry);
+	if (err)
+		sparx5_rr_fib_entry_destroy(sparx5, fib_entry);
+
+	return err;
+}
+
+static void sparx5_rr_fib6_event_work(struct work_struct *work)
+{
+	struct sparx5_fib_event_work *fib_work =
+		container_of(work, struct sparx5_fib_event_work, work);
+	struct sparx5_rr_fib_info *fi = &fib_work->fi;
+	struct sparx5 *sparx5 = fib_work->sparx5;
+	int err;
+
+	mutex_lock(&sparx5->router->lock);
+
+	switch (fib_work->event) {
+	case FIB_EVENT_ENTRY_REPLACE:
+		err = sparx5_rr_fib_replace(sparx5, fi);
+		if (err)
+			dev_warn(sparx5->dev, "FIB 6 replace failed.\n");
+
+		break;
+
+	case FIB_EVENT_ENTRY_APPEND:
+		/* Netlink API for IPv6 is different from IPV4. It is
+		 * possible to do partial update/deletes of nexthops on a
+		 * route. In this case fi only contains the nexthops to
+		 * add/remove, and must be merged with the existing nexthops
+		 * on the route. Therefore, we only share fib_replace between
+		 * IPv6 and IPv4 logic.
+		 */
+		err = sparx5_rr_fib6_append(sparx5, fi);
+		if (err)
+			dev_warn(sparx5->dev, "FIB 6 append failed.\n");
+
+		break;
+
+	case FIB_EVENT_ENTRY_DEL:
+		err = sparx5_rr_fib6_del(sparx5, fi);
+		if (err)
+			dev_warn(sparx5->dev, "FIB 6 delete failed.\n");
+
+		break;
+
+	default:
+		WARN_ON_ONCE(1); /* BUG */
+		break;
+	}
+
+	/* Release fib6_info holds for workqueue. */
+	sparx5_rr_fib_info_put(fi);
+	mutex_unlock(&sparx5->router->lock);
+	kfree(fib_work);
+}
+
+static int sparx5_rr_fib6_work_init(struct sparx5_fib_event_work *fib_work,
+				    struct fib6_entry_notifier_info *fen6_info)
+{
+	struct sparx5_rr_fib6_entry_info *fib6_info = &fib_work->fi.fe6_info;
+	struct fib6_info *rt = fen6_info->rt;
+	struct fib6_info **rt_arr;
+	struct fib6_info *iter;
+	unsigned int nrt6;
+	int i = 0;
+
+	nrt6 = fen6_info->nsiblings + 1;
+
+	rt_arr = kzalloc_objs(struct fib6_info *, nrt6, GFP_ATOMIC);
+	if (!rt_arr)
+		return -ENOMEM;
+
+	fib6_info->rt_arr = rt_arr;
+	fib6_info->nrt6 = nrt6;
+
+	rt_arr[0] = rt;
+	fib6_info_hold(rt);
+
+	if (!fen6_info->nsiblings)
+		return 0;
+
+	list_for_each_entry(iter, &rt->fib6_siblings, fib6_siblings) {
+		if (i == fen6_info->nsiblings)
+			break;
+
+		rt_arr[i + 1] = iter;
+		fib6_info_hold(iter);
+		i++;
+	}
+
+	return 0;
+}
+
+/* Handle fib events, which manage fib_entries. Called in atomic context, with
+ * rcu_read_lock().
+ */
+static int sparx5_rr_fib_event(struct notifier_block *nb, unsigned long event,
+			       void *ptr)
+{
+	struct fib6_entry_notifier_info *fen6_info;
+	struct fib_entry_notifier_info *fen_info;
+	struct sparx5_fib_event_work *fib_work;
+	struct fib_notifier_info *info = ptr;
+	struct sparx5_router *router;
+	int err;
+
+	/* Handle IPv4 and IPv6  */
+	if (info->family != AF_INET && info->family != AF_INET6)
+		return NOTIFY_DONE;
+
+	if (event != FIB_EVENT_ENTRY_REPLACE &&
+	    event != FIB_EVENT_ENTRY_DEL &&
+	    event != FIB_EVENT_ENTRY_APPEND)
+		return NOTIFY_DONE;
+
+	router = container_of(nb, struct sparx5_router, fib_nb);
+
+	fib_work = kzalloc_obj(*fib_work, GFP_ATOMIC);
+	if (!fib_work)
+		return NOTIFY_BAD;
+
+	fib_work->sparx5 = router->sparx5;
+	fib_work->event = event;
+
+	switch (info->family) {
+	case AF_INET:
+		INIT_WORK(&fib_work->work, sparx5_rr_fib4_event_work);
+
+		fen_info = container_of(info, struct fib_entry_notifier_info,
+					info);
+		fib_work->fi.fen4_info = *fen_info;
+		fib_work->fi.version = SPARX5_IPV4;
+
+		/* Hold fib_info while item is queued */
+		fib_info_hold(fib_work->fi.fen4_info.fi);
+
+		sparx5_rr_schedule_work(router->sparx5, &fib_work->work);
+		break;
+	case AF_INET6:
+		INIT_WORK(&fib_work->work, sparx5_rr_fib6_event_work);
+
+		/* Copy and hold fib6_info for route and all nhs while item is
+		 * queued.
+		 */
+		fen6_info = container_of(info, struct fib6_entry_notifier_info,
+					 info);
+		err = sparx5_rr_fib6_work_init(fib_work, fen6_info);
+		if (err)
+			goto err_fib6;
+
+		fib_work->fi.version = SPARX5_IPV6;
+
+		sparx5_rr_schedule_work(router->sparx5, &fib_work->work);
+		break;
+	default:
+		goto err_fam_unhandled;
+	}
+
+	return NOTIFY_DONE;
+
+err_fam_unhandled:
+	WARN_ON_ONCE(1); /* BUG */
+err_fib6:
+	kfree(fib_work);
+	return NOTIFY_BAD;
+}
+
 static void sparx5_rr_leg_base_mac_set(struct sparx5 *sparx5,
 				       unsigned char mac[ETH_ALEN])
 {
@@ -922,16 +2827,25 @@ int sparx5_rr_router_init(struct sparx5 *sparx5)
 	INIT_LIST_HEAD(&r->leg_list);
 	INIT_LIST_HEAD(&r->fib_lpm4_list);
 	INIT_LIST_HEAD(&r->fib_lpm6_list);
+	INIT_LIST_HEAD(&r->fib_list);
 
 	/* Add reserved leg for blackhole routes. */
 	err = sparx5_rr_blackhole_leg_create(sparx5);
 	if (err)
 		goto err_free_router;
 
+	err = rhashtable_init(&r->neigh_ht, &sparx5_neigh_ht_params);
+	if (err)
+		goto err_blackhole_destroy;
+
+	err = rhashtable_init(&r->fib_ht, &sparx5_rr_fib_entry_ht_params);
+	if (err)
+		goto err_neigh_ht_destroy;
+
 	r->sparx5_router_owq = alloc_ordered_workqueue("sparx5_router_owq", 0);
 	if (!r->sparx5_router_owq) {
 		err = -ENOMEM;
-		goto err_blackhole_destroy;
+		goto err_fib_ht_destroy;
 	}
 
 	atomic_set(&r->legs_count, 0);
@@ -989,10 +2903,15 @@ int sparx5_rr_router_init(struct sparx5 *sparx5)
 		 ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL, sparx5,
 		 ANA_ACL_VCAP_S2_MISC_CTRL);
 
+	r->fib_nb.notifier_call = sparx5_rr_fib_event;
+	err = register_fib_notifier(&init_net, &r->fib_nb, NULL, NULL);
+	if (err)
+		goto err_workqueue_destroy;
+
 	r->inetaddr_nb.notifier_call = sparx5_rr_inetaddr_event;
 	err = register_inetaddr_notifier(&r->inetaddr_nb);
 	if (err)
-		goto err_workqueue_destroy;
+		goto err_unreg_fib_notifier;
 
 	r->inetaddr_valid_nb.notifier_call = sparx5_rr_inetaddr_valid_event;
 	err = register_inetaddr_validator_notifier(&r->inetaddr_valid_nb);
@@ -1024,8 +2943,14 @@ int sparx5_rr_router_init(struct sparx5 *sparx5)
 	unregister_inetaddr_validator_notifier(&r->inetaddr_valid_nb);
 err_unreg_inet_notifier:
 	unregister_inetaddr_notifier(&r->inetaddr_nb);
+err_unreg_fib_notifier:
+	unregister_fib_notifier(&init_net, &r->fib_nb);
 err_workqueue_destroy:
 	destroy_workqueue(r->sparx5_router_owq);
+err_fib_ht_destroy:
+	rhashtable_destroy(&r->fib_ht);
+err_neigh_ht_destroy:
+	rhashtable_destroy(&r->neigh_ht);
 err_blackhole_destroy:
 	sparx5_rr_router_legs_flush(sparx5);
 err_free_router:
@@ -1035,6 +2960,15 @@ int sparx5_rr_router_init(struct sparx5 *sparx5)
 	return err;
 }
 
+static void sparx5_rr_fib_flush(struct sparx5 *sparx5)
+{
+	struct sparx5_rr_fib_entry *fib_entry, *tmp;
+
+	list_for_each_entry_safe(fib_entry, tmp, &sparx5->router->fib_list,
+				 fib_node)
+		sparx5_rr_fib_entry_destroy(sparx5, fib_entry);
+}
+
 void sparx5_rr_router_deinit(struct sparx5 *sparx5)
 {
 	struct sparx5_router *router = sparx5->router;
@@ -1044,7 +2978,11 @@ void sparx5_rr_router_deinit(struct sparx5 *sparx5)
 	unregister_netdevice_notifier(&router->netdevice_nb);
 	unregister_inetaddr_validator_notifier(&router->inetaddr_valid_nb);
 	unregister_inetaddr_notifier(&router->inetaddr_nb);
+	unregister_fib_notifier(&init_net, &router->fib_nb);
 	destroy_workqueue(router->sparx5_router_owq);
+	sparx5_rr_fib_flush(sparx5);
+	rhashtable_destroy(&router->fib_ht);
+	rhashtable_destroy(&router->neigh_ht);
 	sparx5_rr_router_legs_flush(sparx5);
 	mutex_destroy(&router->lock);
 	kfree(router);

-- 
2.52.0


