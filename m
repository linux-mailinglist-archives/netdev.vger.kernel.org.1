Return-Path: <netdev+bounces-305581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xvTwOaRUTWrryQEAu9opvQ
	(envelope-from <netdev+bounces-305581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 21:33:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B5271F41F
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 21:33:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qELOPEiT;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305581-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305581-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0D2E30205C9
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 19:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047373AC0E4;
	Tue,  7 Jul 2026 19:33:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AD03ABD82
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 19:33:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452784; cv=none; b=ZkgCN2zcSX0N7vMDmNXT8CkHE70ePjnCMzDa/IRXXFntW5pmNUHksRC3TZuYtGNJKrwr7FKI8Ki6Kh4ac6+s7yLRtKBw13oV/fQGrsp966qKEwdlz1jBxSB3rJE/XQv15l1g07pATWKQ+bh3z19IjZ3KqW6khe/NVf6gxm8vGXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452784; c=relaxed/simple;
	bh=jfuRm9axfvFRHa8eLup5RrTWzAj6xhi7U0cKMcSWtUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpOzuMZPk+OQUj9Ra7PpkFOM/1NlcE3daRkr6kxsiME7N2/H5jNWbHbQU/nSfKLb2pGg2rQ5QGoH1GbzaKSHxxow6VXXnkrvrUh9/jfW5A6h+Ck5cMFrOC2HX8AS+EY05Mt0jEqa310o16VSiwKIoELtcy0x48DWUre/9q4JcJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qELOPEiT; arc=none smtp.client-ip=209.85.160.175
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c0c45c580so431721cf.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 12:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783452782; x=1784057582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NadL5Px5GnzZW4a/yL4rViunizIq8ecr563IZSPeW7Y=;
        b=qELOPEiTrFdz4+R/IncriAwpKYSNTt+5HAJNs37ykNplgqeLXSKB6nRXg7OzuSbk/l
         vn6jdwtlGTZVqkAnnsqSNcQEE0Za3cWjdQbpu8zVcyCIj1Bn1yRWfU4vd9OvExqe1tnk
         vSzehDtw532+oNBVXGdkp1Z+AI/EJZj4vQQ1g7ORjK11K99oeu04yeX/I0hHXmjYMBeq
         ZmbFTwaZuUgbhxya8yAqNlcA5UzXm3JHqTzVRRyhOutL5b0w0v7Mk7uHxt9MBem0a/Vi
         jAXyCRj224Ir+vc7PJVfr4T7Az6AMEFb9v9Q3xlBH4Q0GrRM2DAg3RIrYANFgkTGSHoK
         oN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783452782; x=1784057582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NadL5Px5GnzZW4a/yL4rViunizIq8ecr563IZSPeW7Y=;
        b=UL/v76SYLlyYKVG9flu3+HLq7fW3gc6KEEYMTxxOOScCwueWPnqgflqaU8vELC0lzH
         EBQJMeiwEBAXirTA6rqIXtCPKpY50FI+RYeL4gUP/uFAZYHGjRA0CFvsfBqWT0NF6WFw
         6u3hLwdIZ2S7hWo6tJbawghBtu13hs3wd/ZmdNTr1BQT1Zr1int8vssdZMPEF9OKNpmO
         PybXSXn+N4Z5MW5Hr0Q0Q+Djnbr90V6aAs8fA5aaaOD8FeXNkpGsvzO8X84h2/fb0Jae
         M4AxJWcAJQGYoBUavod0B9fzISywjepdP4zYCeq8qockan6MdSfiIfvnStB3uH3MRdiJ
         nO9g==
X-Gm-Message-State: AOJu0YyQqL8uz9Yb483DqBBvrfvCMzo8zILRGbLL6X2broKUn6MCJfC3
	hFQbwYfVHHMxT7YD6to6KkgAR92NuMFFZIlW4Vvkupz5lxqnnQaHoW1G
X-Gm-Gg: AfdE7cnPplHgf/5O6IXhzKOYbSsF54wRPhQxQHJleS8rqBIeMbQjXXB0dbqlDLjiNwP
	f83GhS2ISrr7L1jnVO1ll3IhjZWRWvhG96q8FPlrrQmO4PqmEgDaWyU7pvHDYbBtf60V6hjpfpQ
	h8mdoRS4I+7vI5sdRLJxrQuedh2hFQgg75bE2ya8Ar0U7WgZHwqXluXtSYsN/G3dccTURDcOzaU
	K5kAX1knJtxbLI9/OMy09zTIhSDj/ausbKiKtMgC57qzyb+thgNGyY39cUFfzyHDbyDHSiNnkAT
	R7qJ3oDU9b9cPxVvDEphOaSLH/VQAZJkfD7g9bc551gMOFvS2jiU1G7qwfmfjLOimO7oyrTPvk6
	OIPf3R4COJitf2JVs5idm4QoTiQUY8OwP3eSrN1Aj97vv+xtKDmm0L8cDTtybwI6qAtUX9PcMwx
	68IRGmYHVcuhoXHBmq+N/bMyjnd/sEuAtZwefjAL10fu3a78YtY+Xg5KdCtyMRqdnN9UpO0LRd2
	uS6WNsHsAs5Ouk4+kXMxyyLE2TtjFi0
X-Received: by 2002:a05:622a:1107:b0:51c:7b13:62f7 with SMTP id d75a77b69052e-51c7b136974mr42021801cf.77.1783452777162;
        Tue, 07 Jul 2026 12:32:57 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4724bab15sm167767906d6.43.2026.07.07.12.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 12:32:56 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 1/2] amt: re-read skb header pointers after every pull
Date: Tue,  7 Jul 2026 15:32:42 -0400
Message-ID: <20260707193243.3448201-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707193243.3448201-1-michael.bommarito@gmail.com>
References: <20260707193243.3448201-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305581-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ap420073@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94B5271F41F

Several AMT receive and transmit paths cache a pointer into the skb
header (ip_hdr(), ipv6_hdr(), eth_hdr() or the AMT message header) and
then call a helper that can reallocate the skb head before the cached
pointer is used again.  pskb_may_pull(), ip_mc_may_pull(),
ipv6_mc_may_pull(), iptunnel_pull_header(), ip_mc_check_igmp() and
ipv6_mc_check_mld() can all free the old head and move the data, so a
pointer taken before the call dangles afterwards and the later access
is a use-after-free of the freed head.

The affected sites are:

  amt_rcv() caches ip_hdr() before amt_parse_type() pulls, then reads
  iph->saddr.

  amt_dev_xmit() caches ip_hdr()/ipv6_hdr() before ip_mc_check_igmp()/
  ipv6_mc_check_mld() and pskb_may_pull(), then reads the group
  address.

  amt_multicast_data_handler() caches eth_hdr() before pskb_may_pull(),
  then writes the L2 header.

  amt_membership_query_handler() caches the AMT header, the outer and
  inner eth_hdr() and ip_hdr() before several pulls, then reads and
  writes them.

  amt_igmpv3_report_handler() and amt_mldv2_report_handler() cache
  ip_hdr()/ipv6_hdr() and the current group record and read the record
  count from the report header inside the record loop, across the
  *_mc_may_pull() calls.

  amt_update_handler() caches ip_hdr() before pskb_may_pull(),
  iptunnel_pull_header(), ip_mc_check_igmp() and the report handler,
  then reads iph->daddr.

Fix each site by either snapshotting the scalar that is used after the
pull before the first pull runs, or re-deriving the header pointer from
the skb after the last pull that can move the head.  Values that are
stable across the pull (source and group address, the response MAC, the
record count, the outer source MAC) are snapshotted; pointers that are
written through or read repeatedly are re-derived.

An earlier fix snapshotted only the source address in a subset of the
handlers and described amt_membership_query_handler() and
amt_multicast_data_handler() as unaffected.  That was wrong: both
re-derive ip_hdr() once but keep stale eth_hdr() and AMT-header
pointers across later pulls, so they are covered here as well.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/net/amt.c | 100 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 21 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index f2f3139e38a59..1d6b2de4b73cc 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -1211,7 +1211,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 			data = true;
 		}
 		v6 = false;
-		group.ip4 = iph->daddr;
+		group.ip4 = ip_hdr(skb)->daddr;
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (iph->version == 6) {
 		ip6h = ipv6_hdr(skb);
@@ -1235,7 +1235,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 			data = true;
 		}
 		v6 = true;
-		group.ip6 = ip6h->daddr;
+		group.ip6 = ipv6_hdr(skb)->daddr;
 #endif
 	} else {
 		dev->stats.tx_errors++;
@@ -1278,12 +1278,12 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 			hlist_for_each_entry_rcu(gnode, &tunnel->groups[hash],
 						 node) {
 				if (!v6) {
-					if (gnode->group_addr.ip4 == iph->daddr)
+					if (gnode->group_addr.ip4 == group.ip4)
 						goto found;
 #if IS_ENABLED(CONFIG_IPV6)
 				} else {
 					if (ipv6_addr_equal(&gnode->group_addr.ip6,
-							    &ip6h->daddr))
+							    &group.ip6))
 						goto found;
 #endif
 				}
@@ -2000,14 +2000,22 @@ static void amt_igmpv3_report_handler(struct amt_dev *amt, struct sk_buff *skb,
 	struct igmpv3_report *ihrv3 = igmpv3_report_hdr(skb);
 	int len = skb_transport_offset(skb) + sizeof(*ihrv3);
 	void *zero_grec = (void *)&igmpv3_zero_grec;
-	struct iphdr *iph = ip_hdr(skb);
 	struct amt_group_node *gnode;
 	union amt_addr group, host;
 	struct igmpv3_grec *grec;
+	__be32 saddr;
 	u16 nsrcs;
+	u16 ngrec;
 	int i;
 
-	for (i = 0; i < ntohs(ihrv3->ngrec); i++) {
+	/* ihrv3 and ip_hdr() point into the skb head, which the
+	 * ip_mc_may_pull() calls below can reallocate.  Read every field
+	 * that is used after a pull before the first one runs.
+	 */
+	saddr = ip_hdr(skb)->saddr;
+	ngrec = ntohs(ihrv3->ngrec);
+
+	for (i = 0; i < ngrec; i++) {
 		len += sizeof(*grec);
 		if (!ip_mc_may_pull(skb, len))
 			break;
@@ -2019,10 +2027,14 @@ static void amt_igmpv3_report_handler(struct amt_dev *amt, struct sk_buff *skb,
 		if (!ip_mc_may_pull(skb, len))
 			break;
 
+		/* ip_mc_may_pull() may have reallocated the head. */
+		grec = (void *)(skb->data + len - sizeof(*grec) -
+				nsrcs * sizeof(__be32));
+
 		memset(&group, 0, sizeof(union amt_addr));
 		group.ip4 = grec->grec_mca;
 		memset(&host, 0, sizeof(union amt_addr));
-		host.ip4 = iph->saddr;
+		host.ip4 = saddr;
 		gnode = amt_lookup_group(tunnel, &group, &host, false);
 		if (!gnode) {
 			gnode = amt_add_group(amt, tunnel, &group, &host,
@@ -2162,14 +2174,22 @@ static void amt_mldv2_report_handler(struct amt_dev *amt, struct sk_buff *skb,
 	struct mld2_report *mld2r = (struct mld2_report *)icmp6_hdr(skb);
 	int len = skb_transport_offset(skb) + sizeof(*mld2r);
 	void *zero_grec = (void *)&mldv2_zero_grec;
-	struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	struct amt_group_node *gnode;
 	union amt_addr group, host;
 	struct mld2_grec *grec;
+	struct in6_addr saddr;
 	u16 nsrcs;
+	u16 ngrec;
 	int i;
 
-	for (i = 0; i < ntohs(mld2r->mld2r_ngrec); i++) {
+	/* mld2r and ipv6_hdr() point into the skb head, which the
+	 * ipv6_mc_may_pull() calls below can reallocate.  Read every field
+	 * that is used after a pull before the first one runs.
+	 */
+	saddr = ipv6_hdr(skb)->saddr;
+	ngrec = ntohs(mld2r->mld2r_ngrec);
+
+	for (i = 0; i < ngrec; i++) {
 		len += sizeof(*grec);
 		if (!ipv6_mc_may_pull(skb, len))
 			break;
@@ -2181,10 +2201,14 @@ static void amt_mldv2_report_handler(struct amt_dev *amt, struct sk_buff *skb,
 		if (!ipv6_mc_may_pull(skb, len))
 			break;
 
+		/* ipv6_mc_may_pull() may have reallocated the head. */
+		grec = (void *)(skb->data + len - sizeof(*grec) -
+				nsrcs * sizeof(struct in6_addr));
+
 		memset(&group, 0, sizeof(union amt_addr));
 		group.ip6 = grec->grec_mca;
 		memset(&host, 0, sizeof(union amt_addr));
-		host.ip6 = ip6h->saddr;
+		host.ip6 = saddr;
 		gnode = amt_lookup_group(tunnel, &group, &host, true);
 		if (!gnode) {
 			gnode = amt_add_group(amt, tunnel, &group, &host,
@@ -2305,7 +2329,6 @@ static bool amt_multicast_data_handler(struct amt_dev *amt, struct sk_buff *skb)
 	skb_push(skb, sizeof(*eth));
 	skb_reset_mac_header(skb);
 	skb_pull(skb, sizeof(*eth));
-	eth = eth_hdr(skb);
 
 	if (!pskb_may_pull(skb, sizeof(*iph)))
 		return true;
@@ -2315,6 +2338,8 @@ static bool amt_multicast_data_handler(struct amt_dev *amt, struct sk_buff *skb)
 		if (!ipv4_is_multicast(iph->daddr))
 			return true;
 		skb->protocol = htons(ETH_P_IP);
+		/* pskb_may_pull() above may have reallocated the head. */
+		eth = eth_hdr(skb);
 		eth->h_proto = htons(ETH_P_IP);
 		ip_eth_mc_map(iph->daddr, eth->h_dest);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2328,6 +2353,8 @@ static bool amt_multicast_data_handler(struct amt_dev *amt, struct sk_buff *skb)
 		if (!ipv6_addr_is_multicast(&ip6h->daddr))
 			return true;
 		skb->protocol = htons(ETH_P_IPV6);
+		/* pskb_may_pull() above may have reallocated the head. */
+		eth = eth_hdr(skb);
 		eth->h_proto = htons(ETH_P_IPV6);
 		ipv6_eth_mc_map(&ip6h->daddr, eth->h_dest);
 #endif
@@ -2353,8 +2380,10 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 	struct amt_header_membership_query *amtmq;
 	struct igmpv3_query *ihv3;
 	struct ethhdr *eth, *oeth;
+	u8 h_source[ETH_ALEN];
 	struct iphdr *iph;
 	int hdr_size, len;
+	u64 response_mac;
 
 	hdr_size = sizeof(*amtmq) + sizeof(struct udphdr);
 	if (!pskb_may_pull(skb, hdr_size))
@@ -2367,6 +2396,12 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 	if (amtmq->nonce != amt->nonce)
 		return true;
 
+	/* iptunnel_pull_header() and the pskb_may_pull() calls below can
+	 * reallocate the skb head, so amtmq would dangle.  Snapshot the only
+	 * field used afterwards.
+	 */
+	response_mac = amtmq->response_mac;
+
 	hdr_size -= sizeof(*eth);
 	if (iptunnel_pull_header(skb, hdr_size, htons(ETH_P_TEB), false))
 		return true;
@@ -2376,6 +2411,8 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 	skb_pull(skb, sizeof(*eth));
 	skb_reset_network_header(skb);
 	eth = eth_hdr(skb);
+	/* Snapshot the outer source MAC before a later pull can free it. */
+	ether_addr_copy(h_source, oeth->h_source);
 	if (!pskb_may_pull(skb, sizeof(*iph)))
 		return true;
 
@@ -2388,6 +2425,8 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 				   sizeof(*ihv3)))
 			return true;
 
+		/* pskb_may_pull() above may have reallocated the head. */
+		iph = ip_hdr(skb);
 		if (!ipv4_is_multicast(iph->daddr))
 			return true;
 
@@ -2395,10 +2434,11 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 		skb_reset_transport_header(skb);
 		skb_push(skb, sizeof(*iph) + AMT_IPHDR_OPTS);
 		WRITE_ONCE(amt->ready4, true);
-		amt->mac = amtmq->response_mac;
+		amt->mac = response_mac;
 		amt->req_cnt = 0;
 		amt->qi = ihv3->qqic;
 		skb->protocol = htons(ETH_P_IP);
+		eth = eth_hdr(skb);
 		eth->h_proto = htons(ETH_P_IP);
 		ip_eth_mc_map(iph->daddr, eth->h_dest);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2421,10 +2461,11 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 		skb_reset_transport_header(skb);
 		skb_push(skb, sizeof(*ip6h) + AMT_IP6HDR_OPTS);
 		WRITE_ONCE(amt->ready6, true);
-		amt->mac = amtmq->response_mac;
+		amt->mac = response_mac;
 		amt->req_cnt = 0;
 		amt->qi = mld2q->mld2q_qqic;
 		skb->protocol = htons(ETH_P_IPV6);
+		eth = eth_hdr(skb);
 		eth->h_proto = htons(ETH_P_IPV6);
 		ipv6_eth_mc_map(&ip6h->daddr, eth->h_dest);
 #endif
@@ -2432,7 +2473,7 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 		return true;
 	}
 
-	ether_addr_copy(eth->h_source, oeth->h_source);
+	ether_addr_copy(eth->h_source, h_source);
 	skb->pkt_type = PACKET_MULTICAST;
 	skb->ip_summed = CHECKSUM_NONE;
 	len = skb->len;
@@ -2455,8 +2496,13 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 	struct ethhdr *eth;
 	struct iphdr *iph;
 	int len, hdr_size;
+	__be32 saddr;
 
-	iph = ip_hdr(skb);
+	/* ip_hdr() points into the skb head, which the pskb_may_pull() /
+	 * iptunnel_pull_header() calls below can reallocate.  Snapshot the
+	 * source address used for the tunnel lookup before the first pull.
+	 */
+	saddr = ip_hdr(skb)->saddr;
 
 	hdr_size = sizeof(*amtmu) + sizeof(struct udphdr);
 	if (!pskb_may_pull(skb, hdr_size))
@@ -2472,7 +2518,7 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 	skb_reset_network_header(skb);
 
 	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
-		if (tunnel->ip4 == iph->saddr) {
+		if (tunnel->ip4 == saddr) {
 			if ((amtmu->nonce == tunnel->nonce &&
 			     amtmu->response_mac == tunnel->mac)) {
 				mod_delayed_work(amt_wq, &tunnel->gc_wq,
@@ -2508,6 +2554,10 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 		eth = eth_hdr(skb);
 		skb->protocol = htons(ETH_P_IP);
 		eth->h_proto = htons(ETH_P_IP);
+		/* ip_mc_check_igmp() and the report handler may have
+		 * reallocated the head; re-derive iph.
+		 */
+		iph = ip_hdr(skb);
 		ip_eth_mc_map(iph->daddr, eth->h_dest);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (iph->version == 6) {
@@ -2527,6 +2577,10 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 		eth = eth_hdr(skb);
 		skb->protocol = htons(ETH_P_IPV6);
 		eth->h_proto = htons(ETH_P_IPV6);
+		/* ipv6_mc_check_mld() and the report handler may have
+		 * reallocated the head; re-derive ip6h.
+		 */
+		ip6h = ipv6_hdr(skb);
 		ipv6_eth_mc_map(&ip6h->daddr, eth->h_dest);
 #endif
 	} else {
@@ -2772,7 +2826,7 @@ static void amt_gw_rcv(struct amt_dev *amt, struct sk_buff *skb)
 static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	struct amt_dev *amt;
-	struct iphdr *iph;
+	__be32 saddr;
 	int type;
 	bool err;
 
@@ -2785,7 +2839,11 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 
 	skb->dev = amt->dev;
-	iph = ip_hdr(skb);
+	/* amt_parse_type() calls pskb_may_pull(), which can reallocate the
+	 * skb head and leave a cached ip_hdr() dangling.  Snapshot the source
+	 * address used below before the pull.
+	 */
+	saddr = ip_hdr(skb)->saddr;
 	type = amt_parse_type(skb);
 	if (type == -1) {
 		err = true;
@@ -2795,7 +2853,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 	if (amt->mode == AMT_MODE_GATEWAY) {
 		switch (type) {
 		case AMT_MSG_ADVERTISEMENT:
-			if (iph->saddr != amt->discovery_ip) {
+			if (saddr != amt->discovery_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
@@ -2807,7 +2865,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			}
 			goto out;
 		case AMT_MSG_MULTICAST_DATA:
-			if (iph->saddr != amt->remote_ip) {
+			if (saddr != amt->remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
@@ -2818,7 +2876,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			else
 				goto out;
 		case AMT_MSG_MEMBERSHIP_QUERY:
-			if (iph->saddr != amt->remote_ip) {
+			if (saddr != amt->remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
-- 
2.53.0


