Return-Path: <netdev+bounces-299029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6l4HBE65LWpejAQAu9opvQ
	(envelope-from <netdev+bounces-299029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:10:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A0967F94F
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:10:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HHmmuftg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299029-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299029-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BBB43003D33
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36793955FF;
	Sat, 13 Jun 2026 20:10:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D3034B1A3
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:10:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781381444; cv=none; b=rXqe7aKA+1VRa9GsgdVnNqnehor0AEnnIBRJsiAwOs97fKq+C3SF1K2LrsW+2D65jkWpP2z/KTK7MgnYlEhSSfYAmAMwhdwA9EvqY90O4x02tM5OkVFnMRAmfeRim9F6L8WO+6dLsf2aVvMP5Va+cSJZsCgfcY/tnEGc+qXBaIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781381444; c=relaxed/simple;
	bh=PDEWNmhQWCvGdMCu7E6cEINtfqKVBANG6PfpYYhSj40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHC5rTkFh9m7pKnNkvUL2qLKSeUdYhFNmewvGU7ZnNx3IHgstX2gbbwoQ22uotTQPw4VAZXZkgkUF2e8q2sxAv00px0/6dVI/3HDriRDgZ6pWbs1OeTX0Fb6z84iq8uKWILV5QHoY2C4y3ubxksbWCQ7N5sEwSf2UfV438P7M30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHmmuftg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112331F00A3A;
	Sat, 13 Jun 2026 20:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781381443;
	bh=4i1sj49Uq/9paJvXs5fVbG9vgxXdAKmcH+RVsk+ldfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HHmmuftgzia7nHa+F0E1rkxVCc+2RK3oUJev+N8PRkvXY03xgvwHeR0wqfA+jy651
	 m3gNjUXhYr2bOmET0TqwRaAMaL6F5a6NsLCqINt2RjT0ylN7f/uPwTIiImiEDZxo7y
	 6LaMOjbyK/v7pROUMzQeIp1XJkjw53qXx/RuKWTK+hbcJrt2Bq0FN8my1dWmRNJom9
	 3Eb77fMGJL5KCAWU01O3YNMTzbwtfD/xdoKXRCz2jSXtmBNQio+xXng19WAJAAXzIu
	 TlFTTgiBynQdwfI5b4Lr9by372DM45xgZcX1DUl8rih8kN++68gj1sMex0k+kY/6qT
	 YPIxW1HlHx8Mw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	3chas3@gmail.com,
	mitch@sfgoth.com,
	linux-atm-general@lists.sourceforge.net,
	dwmw2@infradead.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/9] atm: remove the unused send_oam / push_oam callbacks
Date: Sat, 13 Jun 2026 13:10:25 -0700
Message-ID: <20260613201032.77274-3-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613201032.77274-1-kuba@kernel.org>
References: <20260613201032.77274-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,sfgoth.com,lists.sourceforge.net,infradead.org];
	TAGGED_FROM(0.00)[bounces-299029-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:3chas3@gmail.com,m:mitch@sfgoth.com,m:linux-atm-general@lists.sourceforge.net,m:dwmw2@infradead.org,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5A0967F94F

The atmdev_ops::send_oam device operation and the atm_vcc::push_oam
callback were the kernel's interface for raw F4/F5 OAM cell exchange.
Nothing assigns them a non-NULL value and nothing ever invokes them:
the core only ever initialises push_oam to NULL (in vcc_create() and the
AAL init helpers) and the Solos driver only lists send_oam = NULL for
documentation. The drivers that actually drove OAM through these hooks
were removed along with the legacy ATM adapters.

Drop both callbacks and the NULL initialisers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/atmdev.h  | 8 --------
 drivers/atm/solos-pci.c | 1 -
 net/atm/common.c        | 1 -
 net/atm/raw.c           | 2 --
 4 files changed, 12 deletions(-)

diff --git a/include/linux/atmdev.h b/include/linux/atmdev.h
index 82a32526df64..71c5bf6950e3 100644
--- a/include/linux/atmdev.h
+++ b/include/linux/atmdev.h
@@ -104,7 +104,6 @@ struct atm_vcc {
 	void (*release_cb)(struct atm_vcc *vcc); /* release_sock callback */
 	void (*push)(struct atm_vcc *vcc,struct sk_buff *skb);
 	void (*pop)(struct atm_vcc *vcc,struct sk_buff *skb); /* optional */
-	int (*push_oam)(struct atm_vcc *vcc,void *cell);
 	int (*send)(struct atm_vcc *vcc,struct sk_buff *skb);
 	void		*dev_data;	/* per-device data */
 	void		*proto_data;	/* per-protocol data */
@@ -170,12 +169,6 @@ struct atm_dev {
 	struct list_head dev_list;	/* linkage */
 };
 
- 
-/* OF: send_Oam Flags */
-
-#define ATM_OF_IMMED  1		/* Attempt immediate delivery */
-#define ATM_OF_INRATE 2		/* Attempt in-rate delivery */
-
 struct atmdev_ops { /* only send is required */
 	void (*dev_close)(struct atm_dev *dev);
 	int (*open)(struct atm_vcc *vcc);
@@ -188,7 +181,6 @@ struct atmdev_ops { /* only send is required */
 	int (*pre_send)(struct atm_vcc *vcc, struct sk_buff *skb);
 	int (*send)(struct atm_vcc *vcc,struct sk_buff *skb);
 	int (*send_bh)(struct atm_vcc *vcc, struct sk_buff *skb);
-	int (*send_oam)(struct atm_vcc *vcc,void *cell,int flags);
 	void (*phy_put)(struct atm_dev *dev,unsigned char value,
 	    unsigned long addr);
 	unsigned char (*phy_get)(struct atm_dev *dev,unsigned long addr);
diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index bcb1353877e4..4ad170a858ee 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -1180,7 +1180,6 @@ static const struct atmdev_ops fpga_ops = {
 	.close =	pclose,
 	.ioctl =	NULL,
 	.send =		psend,
-	.send_oam =	NULL,
 	.phy_put =	NULL,
 	.phy_get =	NULL,
 	.change_qos =	NULL,
diff --git a/net/atm/common.c b/net/atm/common.c
index 913f7e32ce41..c6e87fc9bbfc 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -163,7 +163,6 @@ int vcc_create(struct net *net, struct socket *sock, int protocol, int family, i
 	vcc->push = NULL;
 	vcc->pop = NULL;
 	vcc->owner = NULL;
-	vcc->push_oam = NULL;
 	vcc->release_cb = NULL;
 	vcc->vpi = vcc->vci = 0; /* no VCI/VPI yet */
 	vcc->atm_options = vcc->aal_options = 0;
diff --git a/net/atm/raw.c b/net/atm/raw.c
index 0d36aeb3671b..1d6ac7b0c4e5 100644
--- a/net/atm/raw.c
+++ b/net/atm/raw.c
@@ -63,7 +63,6 @@ int atm_init_aal0(struct atm_vcc *vcc)
 {
 	vcc->push = atm_push_raw;
 	vcc->pop = atm_pop_raw;
-	vcc->push_oam = NULL;
 	vcc->send = atm_send_aal0;
 	return 0;
 }
@@ -72,7 +71,6 @@ int atm_init_aal5(struct atm_vcc *vcc)
 {
 	vcc->push = atm_push_raw;
 	vcc->pop = atm_pop_raw;
-	vcc->push_oam = NULL;
 	if (vcc->dev->ops->send_bh)
 		vcc->send = vcc->dev->ops->send_bh;
 	else
-- 
2.54.0


