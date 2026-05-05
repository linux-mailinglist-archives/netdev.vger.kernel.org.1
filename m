Return-Path: <netdev+bounces-284338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OSyMwPN+WlHEQMAu9opvQ
	(envelope-from <netdev+bounces-284338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 12:57:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EDB4CBFB7
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 12:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10FA730FA014
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 10:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B235421EE5;
	Tue,  5 May 2026 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbZdqdan"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E041C2E4
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977754; cv=none; b=sFOFG5FnCRwTUdD4YYObMWLmb3bUWFDfFzEX/KEi6LxfS0lHL0jpYWjldyhV8pQ5FoZDPbgZ8CnD7kTE3UyN1QywOdqioyzOh3o3szzjJeTy0d5SaWJal2PWu5x5A5hFxlJ+kACI585RDPmgg2/YQZ8Z+LiFFrtU/rqODx9n1M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977754; c=relaxed/simple;
	bh=o/fdDuj13DezIE/QZ1qrUVLrHNJZmXLCTspiSJLqqFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XxbhJ6YEHkKfhDkIbg6pkE6FLxrVJ4bEZGdeJJFeNAlsWa4KVscE6Me/EF+nZ1CmWT6+vIhFhUSs+sfxO0tcNWu8rE9PUl9VcQp1LSFjlqtK7Sm4ULxvh8zvL977I4X8w469bambIN0YGoNicvTx6eLJIL51PGYZV85X0UNCp1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbZdqdan; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dcdd1b492eso5183535a34.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 03:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777977752; x=1778582552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/rnAy8c7VOZeC96peJUKWIb1u1SKIdNjE6+t94e9qE=;
        b=QbZdqdanrawcY2xhujlHBakyrhrFk9auUZezF250fydcTDDxeT7vALrUuWxwoPTrgM
         QHEeSWjX0IlX028eSem3jyd+OR5ow2ggxTBltkKZbm2277Gg/Kw2IyI278+Z1F3SUQem
         /5E+qOPQ8ezy1BO9pOMt2RPVTSRQpUUdo5ccUp24Tr/5F+2nB66oOpGmR4hok/E3ww7n
         4lJ2OK98k0cAX0QrsqqlW/vON26s1hmnj9ZqsI55RDskwNgdwtDLVDki0sNj/LeExuDz
         Joo3gYJx6qLng3i4fkLkrDyAKdL1Q4kU2MIdTSI1G4mh1vSw0vxTeMFUEvl+pJEtHE0t
         C3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777977752; x=1778582552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9/rnAy8c7VOZeC96peJUKWIb1u1SKIdNjE6+t94e9qE=;
        b=h0/K7BQZSj4fqY5HZYsXB7/O4Q+qmTPn/HpmyRUqqYzCOYAanzLEji4gtPZvBL6Ruu
         h9/ya10OZzAIxkSE/Z01OuzWFm/U3Ad2Bhm5NcWU5fVs9ACzcaTF1Q8Uq4FMIyR8lC94
         JBToFpeNbjVtK1RJjWEQA6uLTV2fZ9gDCxTiUQBL9Hn3DLAVd1/Ak9TE5S5IH6h0yGfK
         YKa1QawuXJwhrib/FxmIhvtLOMutqtD1qAwp3jtJONqC/f93KJ5Js94dyHrIG2TGVlhK
         lVKGj9ny3BHc/z8/w0ssACPUmwESL/7iED7calIkRes21SBf1qJurQaR1sLhJgsOEvnc
         p1rQ==
X-Gm-Message-State: AOJu0YyImMguCmm4shINZAHnN9sxjnJB88PskjH8J3mKCaJ1F87up58M
	AiREX+SCF/M4GvvNr1abpPBzu4vO1JslSQ4xQzo7i1HC8Da6GfkIyXDE
X-Gm-Gg: AeBDieuXz1eQ+byGP/LzMZRTjHsQgPt07GDiHdAEC7HBKLVHH/+AhZuNTN25kp1fBXA
	5vOYIDK1bBLStUVIzBpEBT+r4gAFYLmAdF2NI9P8F4Px/PY2WkBv2O5iErgKxW/Ca2NduTfNfeY
	JFdC2AhFF6WH716yIfMy7uik2XFbAI3rl4Xh+MkJzPEp7Gq+UDQawJcuTspGP0bracl1gu1N58P
	1nao97k9LGTTDhMef/5TqKBNL7ey9D8Vo6+3NRUB0AY0bM0nfUxmo/NgvZ0DYhvJMgXOhyuhM1M
	BehagvDurGDM96kwdFhWsAtMwdRN/1Y7e2tYC+F/fXqwYCONG9uBrDKB2ALtW3EaDSznpc6hN+C
	kAFv/Wy1m7cmW8bJaMP+Rc4w7sPlaR7oFSVr5TrRa4b1G3kH19l8TjXtfo+7e6aPpbOwIdfCrbx
	QhbXzuyV3XWY3zDrwbeQD1CpK+FBauDYrTYTVHppkfh5qDlWKahLoigQoRSyhI/SU=
X-Received: by 2002:a05:6830:4128:b0:7dc:1bcd:43be with SMTP id 46e09a7af769-7e0bfce59fbmr1833181a34.5.1777977751857;
        Tue, 05 May 2026 03:42:31 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deca7a902asm9925444a34.5.2026.05.05.03.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 03:42:31 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Tue, 05 May 2026 03:42:25 -0700
Subject: [PATCH net 3/3] netdevsim: psp: rcu protect psp_dev reference
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-psd-rcu-v1-3-a8f69ec1ab96@gmail.com>
References: <20260505-psd-rcu-v1-0-a8f69ec1ab96@gmail.com>
In-Reply-To: <20260505-psd-rcu-v1-0-a8f69ec1ab96@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 55EDB4CBFB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284338-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

There are two issues with the way psp_dev is used in nsim_do_psp():

1. There is no check for IS_ERR() on the peers psp_dev, before
   dereferencing.
2. The refcount on this psp_dev can be dropped by
   nsim_psp_rereg_write()

To fix this, we can make netdevsim's reference to its psp_dev an rcu
reference, and then nsim_do_psp() can read the fields it needs from an
rcu critical section.

Fixes: f857478d6206 ("netdevsim: a basic test PSP implementation")
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/netdevsim/netdevsim.h |  2 +-
 drivers/net/netdevsim/psp.c       | 54 +++++++++++++++++++++++++--------------
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index e373ffc26b0c..d909c4160ea1 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -120,7 +120,7 @@ struct netdevsim {
 		u64_stats_t tx_packets;
 		u64_stats_t tx_bytes;
 		struct u64_stats_sync syncp;
-		struct psp_dev *dev;
+		struct psp_dev __rcu *dev;
 		struct dentry *rereg;
 		struct mutex rereg_lock;
 		u32 spi;
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 86d84b7e566b..6936ecb8173e 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -19,6 +19,7 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 	    struct netdevsim *peer_ns, struct skb_ext **psp_ext)
 {
 	enum skb_drop_reason rc = 0;
+	struct psp_dev *peer_psd;
 	struct psp_assoc *pas;
 	struct net *net;
 	void **ptr;
@@ -48,7 +49,8 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 	}
 
 	/* Now pretend we just received this frame */
-	if (peer_ns->psp.dev->config.versions & (1 << pas->version)) {
+	peer_psd = rcu_dereference(peer_ns->psp.dev);
+	if (peer_psd && peer_psd->config.versions & (1 << pas->version)) {
 		bool strip_icv = false;
 		u8 generation;
 
@@ -61,8 +63,7 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 
 		skb_ext_reset(skb);
 		skb->mac_len = ETH_HLEN;
-		if (psp_dev_rcv(skb, peer_ns->psp.dev->id, generation,
-				strip_icv)) {
+		if (psp_dev_rcv(skb, peer_psd->id, generation, strip_icv)) {
 			rc = SKB_DROP_REASON_PSP_OUTPUT;
 			goto out_unlock;
 		}
@@ -209,10 +210,18 @@ static struct psp_dev_caps nsim_psp_caps = {
 	.assoc_drv_spc = sizeof(void *),
 };
 
-static void __nsim_psp_uninit(struct netdevsim *ns)
+static void __nsim_psp_uninit(struct netdevsim *ns, bool teardown)
 {
-	if (!IS_ERR(ns->psp.dev))
-		psp_dev_unregister(ns->psp.dev);
+	struct psp_dev *psd;
+
+	psd = rcu_dereference_protected(ns->psp.dev,
+					teardown ||
+					lockdep_is_held(&ns->psp.rereg_lock));
+	if (psd) {
+		rcu_assign_pointer(ns->psp.dev, NULL);
+		synchronize_rcu();
+		psp_dev_unregister(psd);
+	}
 	WARN_ON(ns->psp.assoc_cnt);
 }
 
@@ -220,7 +229,7 @@ void nsim_psp_uninit(struct netdevsim *ns)
 {
 	debugfs_remove(ns->psp.rereg);
 	mutex_destroy(&ns->psp.rereg_lock);
-	__nsim_psp_uninit(ns);
+	__nsim_psp_uninit(ns, true);
 }
 
 static ssize_t
@@ -228,16 +237,23 @@ nsim_psp_rereg_write(struct file *file, const char __user *data, size_t count,
 		     loff_t *ppos)
 {
 	struct netdevsim *ns = file->private_data;
-	int err;
+	struct psp_dev *psd;
+	ssize_t ret;
 
 	mutex_lock(&ns->psp.rereg_lock);
-	__nsim_psp_uninit(ns);
+	__nsim_psp_uninit(ns, false);
+
+	psd = psp_dev_create(ns->netdev, &nsim_psp_ops, &nsim_psp_caps, ns);
+	if (IS_ERR(psd)) {
+		ret = PTR_ERR(psd);
+		goto out;
+	}
 
-	ns->psp.dev = psp_dev_create(ns->netdev, &nsim_psp_ops,
-				     &nsim_psp_caps, ns);
-	err = PTR_ERR_OR_ZERO(ns->psp.dev);
+	rcu_assign_pointer(ns->psp.dev, psd);
+	ret = count;
+out:
 	mutex_unlock(&ns->psp.rereg_lock);
-	return err ?: count;
+	return ret;
 }
 
 static const struct file_operations nsim_psp_rereg_fops = {
@@ -250,13 +266,13 @@ static const struct file_operations nsim_psp_rereg_fops = {
 int nsim_psp_init(struct netdevsim *ns)
 {
 	struct dentry *ddir = ns->nsim_dev_port->ddir;
-	int err;
+	struct psp_dev *psd;
+
+	psd = psp_dev_create(ns->netdev, &nsim_psp_ops, &nsim_psp_caps, ns);
+	if (IS_ERR(psd))
+		return PTR_ERR(psd);
 
-	ns->psp.dev = psp_dev_create(ns->netdev, &nsim_psp_ops,
-				     &nsim_psp_caps, ns);
-	err = PTR_ERR_OR_ZERO(ns->psp.dev);
-	if (err)
-		return err;
+	rcu_assign_pointer(ns->psp.dev, psd);
 
 	mutex_init(&ns->psp.rereg_lock);
 	ns->psp.rereg = debugfs_create_file("psp_rereg", 0200, ddir, ns,

-- 
2.52.0


