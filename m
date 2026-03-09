Return-Path: <netdev+bounces-265420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKWGIP+Qrmk7GQIAu9opvQ
	(envelope-from <netdev+bounces-265420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:21:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A062360EB
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EEDB30071E0
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 09:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BAF378805;
	Mon,  9 Mar 2026 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xToV7xoJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3D9377EC6
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048061; cv=none; b=qVdDSPOHki77+vQUFTR4MAz+1NwWtGzbZyuG0hJxD0tLLgdLY+pyZ+QKxX8g8wi8m7EATwFKALyuWGbeUCY7g7R1mxdQrJvqOUDbkqdZR7CXoGvm0fCCq7lpgBPPN+phrcWBj7lpAB+vSZ6573yHm8c9emuPiIEAC7ZNgvS0Bo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048061; c=relaxed/simple;
	bh=k9nqtEUnD+Ki/qC4dN9ywETUDsDAQwSjaoAAHPgXt5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwYj3OPdfle+wkkmGYx9SAVnIpt3Gm7bu2Ma75MUqqVqdvWe3JZhknKOYiHXRVcjieRamQ2IaC19LZtyc2eeTAwHHAfEvn//JmwpIP3/j4bPzdAZc10PDN3S3yQ62ola92mT7RrhJYk4o3B6qT+rFeSfe8ByQ+LEzRDlcc5SLEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xToV7xoJ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 9 Mar 2026 17:20:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773048046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lzoMzJT3wD8V7gz73ke5OvICidefQs02jJDZPODB0DE=;
	b=xToV7xoJXFwNNXPgC87E7QiyXn72WmfSj4BI1HxYe3MzrZVml5ujWoh5NbXvyMZopV8A1j
	ksdqjVPz5ek1Kgo5Bji1RluuNGnGeIi2uxLDEPMY0wSOKSuXq55izAkb0pUhTBSUpd7ic9
	/lAZoeM38RL1HeVK12qs4aezIoHPijE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: syzbot <syzbot+f50072212ab792c86925@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 sock_def_readable (2)
Message-ID: <hsaps6s7nptbzfp2mdx3b7ah3u2e6ydxj4ww2hho3ou3l7la6m@b3fw343ncpja>
References: <69ad7ccb.a00a0220.b130.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69ad7ccb.a00a0220.b130.0003.GAE@google.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: D9A062360EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265420-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,f50072212ab792c86925];
	TO_DN_SOME(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

#syz test

diff --git a/net/atm/lec.c b/net/atm/lec.c
index 7e6fc2bd40ac..7d99ba8ba3b4 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -139,6 +139,7 @@ static void lec_handle_bridge(struct sk_buff *skb, struct net_device *dev)
 	 */
 	buff = skb->data + skb->dev->hard_header_len;
 	if (*buff++ == 0x42 && *buff++ == 0x42 && *buff++ == 0x03) {
+		struct atm_vcc *vcc;
 		struct sock *sk;
 		struct sk_buff *skb2;
 		struct atmlec_msg *mesg;
@@ -154,10 +155,18 @@ static void lec_handle_bridge(struct sk_buff *skb, struct net_device *dev)
 					/* 0x01 is topology change */

 		priv = netdev_priv(dev);
-		atm_force_charge(priv->lecd, skb2->truesize);
-		sk = sk_atm(priv->lecd);
-		skb_queue_tail(&sk->sk_receive_queue, skb2);
-		sk->sk_data_ready(sk);
+
+		rcu_read_lock();
+		vcc = rcu_dereference(priv->lecd);
+		if (vcc) {
+			atm_force_charge(vcc, skb2->truesize);
+			sk = sk_atm(vcc);
+			skb_queue_tail(&sk->sk_receive_queue, skb2);
+			sk->sk_data_ready(sk);
+		} else {
+			dev_kfree_skb(skb2);
+		}
+		rcu_read_unlock();
 	}
 }
 #endif /* IS_ENABLED(CONFIG_BRIDGE) */
@@ -216,7 +225,7 @@ static netdev_tx_t lec_start_xmit(struct sk_buff *skb,
 	int is_rdesc;

 	pr_debug("called\n");
-	if (!priv->lecd) {
+	if (!rcu_access_pointer(priv->lecd)) {
 		pr_info("%s:No lecd attached\n", dev->name);
 		dev->stats.tx_errors++;
 		netif_stop_queue(dev);
@@ -440,6 +449,7 @@ static int lec_atm_send(struct atm_vcc *vcc, struct sk_buff *skb)
 		if (br_fdb_test_addr_hook(dev, mesg->content.proxy.mac_addr)) {
 			/* hit from bridge table, send LE_ARP_RESPONSE */
 			struct sk_buff *skb2;
+			struct atm_vcc *lecd;
 			struct sock *sk;

 			pr_debug("%s: entry found, responding to zeppelin\n",
@@ -449,10 +459,18 @@ static int lec_atm_send(struct atm_vcc *vcc, struct sk_buff *skb)
 				break;
 			skb2->len = sizeof(struct atmlec_msg);
 			skb_copy_to_linear_data(skb2, mesg, sizeof(*mesg));
-			atm_force_charge(priv->lecd, skb2->truesize);
-			sk = sk_atm(priv->lecd);
-			skb_queue_tail(&sk->sk_receive_queue, skb2);
-			sk->sk_data_ready(sk);
+
+			rcu_read_lock();
+			lecd = rcu_dereference(priv->lecd);
+			if (lecd) {
+				atm_force_charge(lecd, skb2->truesize);
+				sk = sk_atm(lecd);
+				skb_queue_tail(&sk->sk_receive_queue, skb2);
+				sk->sk_data_ready(sk);
+			} else {
+				dev_kfree_skb(skb2);
+			}
+			rcu_read_unlock();
 		}
 	}
 #endif /* IS_ENABLED(CONFIG_BRIDGE) */
@@ -472,7 +490,8 @@ static void lec_atm_close(struct atm_vcc *vcc)
 	struct net_device *dev = (struct net_device *)vcc->proto_data;
 	struct lec_priv *priv = netdev_priv(dev);

-	priv->lecd = NULL;
+	rcu_assign_pointer(priv->lecd, NULL);
+	synchronize_rcu();
 	/* Do something needful? */

 	netif_stop_queue(dev);
@@ -510,15 +529,25 @@ send_to_lecd(struct lec_priv *priv, atmlec_msg_type type,
 	     const unsigned char *mac_addr, const unsigned char *atm_addr,
 	     struct sk_buff *data)
 {
+	struct atm_vcc *vcc;
 	struct sock *sk;
 	struct sk_buff *skb;
 	struct atmlec_msg *mesg;

-	if (!priv || !priv->lecd)
+	if (!priv)
+		return -1;
+
+	rcu_read_lock();
+	vcc = rcu_dereference(priv->lecd);
+	if (!vcc) {
+		rcu_read_unlock();
 		return -1;
+	}
 	skb = alloc_skb(sizeof(struct atmlec_msg), GFP_ATOMIC);
-	if (!skb)
+	if (!skb) {
+		rcu_read_unlock();
 		return -1;
+	}
 	skb->len = sizeof(struct atmlec_msg);
 	mesg = (struct atmlec_msg *)skb->data;
 	memset(mesg, 0, sizeof(struct atmlec_msg));
@@ -532,18 +561,19 @@ send_to_lecd(struct lec_priv *priv, atmlec_msg_type type,
 	if (atm_addr)
 		memcpy(&mesg->content.normal.atm_addr, atm_addr, ATM_ESA_LEN);

-	atm_force_charge(priv->lecd, skb->truesize);
-	sk = sk_atm(priv->lecd);
+	atm_force_charge(vcc, skb->truesize);
+	sk = sk_atm(vcc);
 	skb_queue_tail(&sk->sk_receive_queue, skb);
 	sk->sk_data_ready(sk);

 	if (data != NULL) {
 		pr_debug("about to send %d bytes of data\n", data->len);
-		atm_force_charge(priv->lecd, data->truesize);
+		atm_force_charge(vcc, data->truesize);
 		skb_queue_tail(&sk->sk_receive_queue, data);
 		sk->sk_data_ready(sk);
 	}

+	rcu_read_unlock();
 	return 0;
 }

@@ -618,7 +648,8 @@ static void lec_push(struct atm_vcc *vcc, struct sk_buff *skb)

 		atm_return(vcc, skb->truesize);
 		if (*(__be16 *) skb->data == htons(priv->lecid) ||
-		    !priv->lecd || !(dev->flags & IFF_UP)) {
+		    !rcu_access_pointer(priv->lecd) ||
+		    !(dev->flags & IFF_UP)) {
 			/*
 			 * Probably looping back, or if lecd is missing,
 			 * lecd has gone down
@@ -753,12 +784,12 @@ static int lecd_attach(struct atm_vcc *vcc, int arg)
 		priv = netdev_priv(dev_lec[i]);
 	} else {
 		priv = netdev_priv(dev_lec[i]);
-		if (priv->lecd)
+		if (rcu_access_pointer(priv->lecd))
 			return -EADDRINUSE;
 	}
 	lec_arp_init(priv);
 	priv->itfnum = i;	/* LANE2 addition */
-	priv->lecd = vcc;
+	rcu_assign_pointer(priv->lecd, vcc);
 	vcc->dev = &lecatm_dev;
 	vcc_insert_socket(sk_atm(vcc));

diff --git a/net/atm/lec.h b/net/atm/lec.h
index be0e2667bd8c..ec85709bf818 100644
--- a/net/atm/lec.h
+++ b/net/atm/lec.h
@@ -91,7 +91,7 @@ struct lec_priv {
 						 */
 	spinlock_t lec_arp_lock;
 	struct atm_vcc *mcast_vcc;		/* Default Multicast Send VCC */
-	struct atm_vcc *lecd;
+	struct atm_vcc __rcu *lecd;
 	struct delayed_work lec_arp_work;	/* C10 */
 	unsigned int maximum_unknown_frame_count;
 						/*

