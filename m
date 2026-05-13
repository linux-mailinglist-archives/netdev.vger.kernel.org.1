Return-Path: <netdev+bounces-287711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD55JovFBGqbNwIAu9opvQ
	(envelope-from <netdev+bounces-287711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:40:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 37589539207
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3042F300CB0A
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301083B7763;
	Wed, 13 May 2026 18:36:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429BE3B38A9
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697390; cv=none; b=T/y65SIYIXr3xsxtFqEaWQAs+HQnhWRH3w7gd4t9IirpzzC0H1rdQAUwzqHvtnbIiQ6ZglbBhVvtzSmYaS8p252euP8wSLtO0NyisXe/N/fksjAL1x+5C7mLTlWEwy/HX/pOTjw1+ei8Vl3EdPizeBp4vdLJfhDyQVA64feXqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697390; c=relaxed/simple;
	bh=+5u5jJ60v1xjveGW2ChiPGnJYtxZ0kG5T3OCYSA6QtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldvQrFFb/oAZ3k29AbYPTwvd094X20pULrcDs/l7HtHVR1blgd7JEIY4kjtBDnBiSZ+6GQet4BmaiOJj0s1qAPdZYlKUw+zGL2pYMuOXRpbfYuV8zuxpa3wVlgfmYh3DPysGhX4+sFonyRLCppRfHgXgPGXNWeJMXnS5dpNxSiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so63610265e9.2
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 11:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697385; x=1779302185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lFrGXmGkGqSJhTRhqyzlGScwr6w06YpxqqRUHTQ9L1A=;
        b=oU2oLXoWh9pG0FNdIxZF2nalvn+Rh1CaNkEEBbBNf1tnNU26r3sFwfLXtYzy0Mfn5M
         B8PxRhaIBn4Hl4QROr2motEJxNL9gAdzbdaoMMxulvSZHI7UR+9En+1hCPF2utp3ORNI
         WDRSfeQ1NCGF9+ZYRUjYFB3oB5vKwKxsKxClTzyYAyELvMm9sGxFiAilb6Mx6uDmj380
         RDw+Mh2n1IYCVinhL4NA7bcBVOpYt5iGtQExwk0xyxXokC66BtBp9TZF5pmhOeX6fDo0
         a/wJMaNLqrbqCjpdGhnRJIlMLVOGxjwerWm7KadrE+MEcHsqOldfFZ77t3DaKKc9GnEI
         nZ3A==
X-Gm-Message-State: AOJu0YyTFf2XcgC/z/XIH7mPyOhPBXbymuSB7zIaQdJpd3vKcj4JitwC
	MWnuHawZz+r1in48n0W9D/EW9mv/TI/YicB/gepjRhgpXOBtGRvrB/6y1bYGoqH4
X-Gm-Gg: Acq92OHYWXSphrX6bhDcEhpUyJUkEi3mM2yWlzMzYtGLnMpfg30gUZgyJX4gVneP+jT
	nG6KxULc1acuFd9YE8RzDMKQBv/IB1LjH59qizrKl5NrmcCNBbKYgexDLGhkm80OKBr/b2e2W3V
	mItS1nfNAW8ZkxCaHuuxq6Bl3STytB+2IC5P5pVTcPDcVpJJdilQiy5hrC3u2Gj25SWWcYbleF1
	375QpJkPxzeTFR8pvjUNFD8+UyPS96IZatQQEgjzYcsdBEAl2Z2C+OQ3JBzFMVARehdNThpJvTN
	myQRPSQDcpt4rVOq+/vvMOWNL+dJ1/85c9e1obGQk6pJQ2VmAzub7em2pytbWSxAB+TiChH8lOS
	6d40LUJMV1AZHKxjHLQriY7Y2xW8aY6xeSy+ZkschPrqsXIx6UKgDKR9EtTm10QH05ywIWzyKB8
	TZ9vDoVTBbPWfna6qpOJjJ+VONtitXP/sN4aRWfNMUxuI/aPaIATsWiIGnVHI=
X-Received: by 2002:a05:600d:18:b0:48a:5574:3a5d with SMTP id 5b1f17b1804b1-48fce9bd5d1mr49631725e9.7.1778697384382;
        Wed, 13 May 2026 11:36:24 -0700 (PDT)
Received: from im-t490s.redhat.com (37-48-40-237.nat.epc.tmcz.cz. [37.48.40.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm720609f8f.34.2026.05.13.11.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:24 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Petr Machata <petrm@nvidia.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Antoine Tenart <atenart@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [RFC net-next 3/6] openvswitch: vport: remove infrastructure for separate modules
Date: Wed, 13 May 2026 20:35:23 +0200
Message-ID: <20260513183559.2141010-4-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513183559.2141010-1-i.maximets@ovn.org>
References: <20260513183559.2141010-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 37589539207
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287711-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.934];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ovn.org:email,ovn.org:mid]
X-Rspamd-Action: no action

Since removal of legacy tunnel vport types only the built-in ones
remain.  So, there is no need for the extra infrastructure for dynamic
module loading.  Can be reinstated in the future if we need a new
vport type.

Note: It is technically possible that someone has an out-of-tree
module named vport-type-N that implements a different vport type.
At this time we're not aware of anyone doing that.  People running
out-of-tree modules normally just have an out-of-tree openvswitch
module as a whole.  And there are actually no supported out-of-tree
implementations of the openvswitch module known to the community.
Alternative to immediate removal would be printing out a deprecation
warning whenever a vport module is loaded, but I'm not sure if we
need it at this time.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/vport.c | 22 ++--------------------
 net/openvswitch/vport.h |  9 +--------
 2 files changed, 3 insertions(+), 28 deletions(-)

diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 7a9caacfd6ac2..ef2fff4353c0a 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -57,7 +57,7 @@ static struct hlist_head *hash_bucket(const struct net *net, const char *name)
 	return &dev_table[hash & (VPORT_HASH_BUCKETS - 1)];
 }
 
-int __ovs_vport_ops_register(struct vport_ops *ops)
+int ovs_vport_ops_register(struct vport_ops *ops)
 {
 	int err = -EEXIST;
 	struct vport_ops *o;
@@ -73,7 +73,6 @@ int __ovs_vport_ops_register(struct vport_ops *ops)
 	ovs_unlock();
 	return err;
 }
-EXPORT_SYMBOL_GPL(__ovs_vport_ops_register);
 
 void ovs_vport_ops_unregister(struct vport_ops *ops)
 {
@@ -81,7 +80,6 @@ void ovs_vport_ops_unregister(struct vport_ops *ops)
 	list_del(&ops->list);
 	ovs_unlock();
 }
-EXPORT_SYMBOL_GPL(ovs_vport_ops_unregister);
 
 /**
  *	ovs_vport_locate - find a port that has already been created
@@ -210,12 +208,8 @@ struct vport *ovs_vport_add(const struct vport_parms *parms)
 	if (ops) {
 		struct hlist_head *bucket;
 
-		if (!try_module_get(ops->owner))
-			return ERR_PTR(-EAFNOSUPPORT);
-
 		vport = ops->create(parms);
 		if (IS_ERR(vport)) {
-			module_put(ops->owner);
 			return vport;
 		}
 
@@ -225,18 +219,7 @@ struct vport *ovs_vport_add(const struct vport_parms *parms)
 		return vport;
 	}
 
-	/* Unlock to attempt module load and return -EAGAIN if load
-	 * was successful as we need to restart the port addition
-	 * workflow.
-	 */
-	ovs_unlock();
-	request_module("vport-type-%d", parms->type);
-	ovs_lock();
-
-	if (!ovs_vport_lookup(parms))
-		return ERR_PTR(-EAFNOSUPPORT);
-	else
-		return ERR_PTR(-EAGAIN);
+	return ERR_PTR(-EAFNOSUPPORT);
 }
 
 /**
@@ -250,7 +233,6 @@ struct vport *ovs_vport_add(const struct vport_parms *parms)
 void ovs_vport_del(struct vport *vport)
 {
 	hlist_del_rcu(&vport->hash_node);
-	module_put(vport->ops->owner);
 	vport->ops->destroy(vport);
 }
 
diff --git a/net/openvswitch/vport.h b/net/openvswitch/vport.h
index 636788b59907c..930f1ccc85581 100644
--- a/net/openvswitch/vport.h
+++ b/net/openvswitch/vport.h
@@ -116,7 +116,6 @@ struct vport_parms {
  * before an RCU grace period has elapsed.
  * @send: Send a packet on the device.
  * zero for dropped packets or negative for error.
- * @owner: Module that implements this vport type.
  * @list: List entry in the global list of vport types.
  */
 struct vport_ops {
@@ -127,7 +126,6 @@ struct vport_ops {
 	void (*destroy)(struct vport *);
 
 	int (*send)(struct sk_buff *skb);
-	struct module *owner;
 	struct list_head list;
 };
 
@@ -191,12 +189,7 @@ static inline const char *ovs_vport_name(struct vport *vport)
 	return vport->dev->name;
 }
 
-int __ovs_vport_ops_register(struct vport_ops *ops);
-#define ovs_vport_ops_register(ops)		\
-	({					\
-		(ops)->owner = THIS_MODULE;	\
-		__ovs_vport_ops_register(ops);	\
-	})
+int ovs_vport_ops_register(struct vport_ops *ops);
 
 void ovs_vport_ops_unregister(struct vport_ops *ops);
 void ovs_vport_send(struct vport *vport, struct sk_buff *skb, u8 mac_proto);
-- 
2.53.0


