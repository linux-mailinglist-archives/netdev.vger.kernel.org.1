Return-Path: <netdev+bounces-303145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vJ4fA9i1Q2pRfgoAu9opvQ
	(envelope-from <netdev+bounces-303145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:26:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3C96E424F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:25:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b=pzgRYbVD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303145-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303145-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC49830071FE
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C01440759D;
	Tue, 30 Jun 2026 12:20:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8463F0765;
	Tue, 30 Jun 2026 12:20:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822047; cv=none; b=XiiwdIHSvIB1KiFWyHL1AQS4DikdI0a5KLg4rb1C+ZcH7ewQKoUb87f11QCxC8QNd+JteWpUt1OqDbm5Bjpz8smrIBRfjnzrd/H9eiyriPlE2IxW89oqfA+qHRfXs7ZZGijz6z5UpPqtoe8hHMdkLEgjsqV+OpclC4jFjzxAGvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822047; c=relaxed/simple;
	bh=CU4g8BtSJYDlQo9V1m/2z1xHkFj4kao+4DeDUeM43Sg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=hY9YxA54MXGd+ODehupTK91Y/28NCEZ5T2pYzXQR/KBD4SbsSxhIhAqxDrsvkjSAKVWnv8RdYD6Br8UngOYtWgqv8KdZfRTxkgQQmo3e96cT3I6MckR+Qzi6+pAvdkqigHojtJjXdWD7EkSNtcbxYMGIfvyRYysm0p17fBhovUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pzgRYbVD; arc=none smtp.client-ip=68.232.154.123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782822045; x=1814358045;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=CU4g8BtSJYDlQo9V1m/2z1xHkFj4kao+4DeDUeM43Sg=;
  b=pzgRYbVD8QDo8RN/Q2yDehAr3XF6Wf/pGCNteI02+c4eVIZqfJPhjfXV
   /owl+TWY8ndjHvrN7V+z78/yafnJuK1CX3tzu6EgzUiW14RFrhq2S1Le1
   NBgfFcDijBdp8AgoXebfZ9rsaFSOfZQjz+ICjQiCzUqwCxAEXv1ET3c3t
   9/AGQ35bUHXaikD3IHHhHL21qq7IEeT7eOMSPXs4ejyn2wApEXkOwwUIM
   3zVt1JWVyA5Dw3qhzAWqh5N9tS1T6lJN5RUxE3I5wEE5ExDExdeaYNdA1
   RAYhNOLG4wEfwLgrMfapYEogQjUpUcBT7M/8vIUJ7rkiFeHMHnR6Udcv+
   Q==;
X-CSE-ConnectionGUID: PFUAYMnIQGS6qRf0Hswvpg==
X-CSE-MsgGUID: fL8J8qTIRCy7aekfLAHX8Q==
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="227059033"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 05:20:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Tue, 30 Jun 2026 05:20:38 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 30 Jun 2026 05:20:36 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Tue, 30 Jun 2026 14:20:13 +0200
Subject: [PATCH net] net: microchip: vcap: fix races on the shared Super
 VCAP block
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260630-microchip_fix_vcap_locking-v1-1-f60a4596734d@microchip.com>
X-B4-Tracking: v=1; b=H4sIAHy0Q2oC/x3MQQqAIBBA0avErBPUyqCrREhMUw2VikYE0d2Tl
 g8+/4FEkSlBVzwQ6eLE3mWosgBcR7eQ4CkbtNRGGl2LgzF6XDnYmW974Rjs7nFjt4hWomzaplK
 oDORBiJSbf96DoxOG9/0AnJoqdnEAAAA=
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>
CC: Steen Hegelund <steen.hegelund@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303145-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:horatiu.vultur@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Steen.Hegelund@microchip.com,m:daniel.machon@microchip.com,m:steen.hegelund@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:jensemil.schulzostergaard@microchip.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,microchip.com:dkim,microchip.com:email,microchip.com:mid,microchip.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F3C96E424F

The VCAP instances on a chip are not independent, yet they are locked
independently. On sparx5 and lan969x the IS0 and IS2 instances are
backed by the same Super VCAP hardware block and share its cache and
command registers: every access drives the shared VCAP_SUPER_CTRL
register and moves data through the shared cache registers.

Accessing one instance therefore races with accessing another. The
per-instance admin->lock cannot prevent this, as each instance takes a
different lock.

The locking issue is mostly disguised by the fact that the core usage of
the vcap api runs under rtnl. However, the full rule dump in debugfs
decodes rules straight from hardware (a READ command followed by a cache
read) and runs outside rtnl, so it races a concurrent tc-flower rule
write to another Super VCAP instance.

Besides corrupting the dump, the read repopulates the shared cache
between the writers cache fill and its write command, so the writer
commits the wrong data and corrupts the hardware entry.

Introduce vcap_lock() and vcap_unlock() helpers and route every rule
lock site in the VCAP API and its debugfs code through them. Replace the
per-instance admin->lock with a single mutex in struct vcap_control that
serializes access to all instances. The helpers reach it through a new
admin->vctrl back-pointer, and the clients initialise and destroy the
control lock instead of a per-instance one.

No path holds more than one instance lock, so collapsing them onto a
single mutex cannot self-deadlock.

Fixes: 71c9de995260 ("net: microchip: sparx5: Add VCAP locking to protect rules")
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
This was discovered by sashiko on a net-next series adding L3 unicast
routing to sparx5 and lan969x. That work introduces a new vcap instance
which is driven outside of rtnl. However, since the debugfs dump already
runs outside of rtnl the bug is reachable in mainline.

I have added this as a single patch to make it easier to cherry-pick. I
can split it into a patch refactoring all locking sites to use new
vcap_lock/vcap_unlock functions, and one which then swaps the
admin->lock to a global vcap lock, if that is preferred.
---
 .../ethernet/microchip/lan966x/lan966x_vcap_impl.c |  5 +-
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.c   |  5 +-
 drivers/net/ethernet/microchip/vcap/vcap_api.c     | 72 ++++++++++++----------
 drivers/net/ethernet/microchip/vcap/vcap_api.h     |  3 +-
 .../net/ethernet/microchip/vcap/vcap_api_debugfs.c |  8 +--
 .../microchip/vcap/vcap_api_debugfs_kunit.c        |  3 +-
 .../net/ethernet/microchip/vcap/vcap_api_kunit.c   |  3 +-
 .../net/ethernet/microchip/vcap/vcap_api_private.h |  3 +
 8 files changed, 60 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_vcap_impl.c b/drivers/net/ethernet/microchip/lan966x/lan966x_vcap_impl.c
index 72e3b189bac5..eb28df80b281 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_vcap_impl.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_vcap_impl.c
@@ -601,7 +601,6 @@ static void lan966x_vcap_admin_free(struct vcap_admin *admin)
 	kfree(admin->cache.keystream);
 	kfree(admin->cache.maskstream);
 	kfree(admin->cache.actionstream);
-	mutex_destroy(&admin->lock);
 	kfree(admin);
 }
 
@@ -615,7 +614,7 @@ lan966x_vcap_admin_alloc(struct lan966x *lan966x, struct vcap_control *ctrl,
 	if (!admin)
 		return ERR_PTR(-ENOMEM);
 
-	mutex_init(&admin->lock);
+	admin->vctrl = ctrl;
 	INIT_LIST_HEAD(&admin->list);
 	INIT_LIST_HEAD(&admin->rules);
 	INIT_LIST_HEAD(&admin->enabled);
@@ -721,6 +720,7 @@ int lan966x_vcap_init(struct lan966x *lan966x)
 	ctrl->ops = &lan966x_vcap_ops;
 
 	INIT_LIST_HEAD(&ctrl->list);
+	mutex_init(&ctrl->lock);
 	for (int i = 0; i < ARRAY_SIZE(lan966x_vcap_inst_cfg); ++i) {
 		cfg = &lan966x_vcap_inst_cfg[i];
 
@@ -780,5 +780,6 @@ void lan966x_vcap_deinit(struct lan966x *lan966x)
 		lan966x_vcap_admin_free(admin);
 	}
 
+	mutex_destroy(&ctrl->lock);
 	kfree(ctrl);
 }
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
index 95b93e46a41d..cf332de6bf73 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
@@ -1930,7 +1930,6 @@ static void sparx5_vcap_admin_free(struct vcap_admin *admin)
 {
 	if (!admin)
 		return;
-	mutex_destroy(&admin->lock);
 	kfree(admin->cache.keystream);
 	kfree(admin->cache.maskstream);
 	kfree(admin->cache.actionstream);
@@ -1950,7 +1949,7 @@ sparx5_vcap_admin_alloc(struct sparx5 *sparx5, struct vcap_control *ctrl,
 	INIT_LIST_HEAD(&admin->list);
 	INIT_LIST_HEAD(&admin->rules);
 	INIT_LIST_HEAD(&admin->enabled);
-	mutex_init(&admin->lock);
+	admin->vctrl = ctrl;
 	admin->vtype = cfg->vtype;
 	admin->vinst = cfg->vinst;
 	admin->ingress = cfg->ingress;
@@ -2059,6 +2058,7 @@ int sparx5_vcap_init(struct sparx5 *sparx5)
 	ctrl->ops = &sparx5_vcap_ops;
 
 	INIT_LIST_HEAD(&ctrl->list);
+	mutex_init(&ctrl->lock);
 	for (idx = 0; idx < ARRAY_SIZE(sparx5_vcap_inst_cfg); ++idx) {
 		cfg = &consts->vcaps_cfg[idx];
 		admin = sparx5_vcap_admin_alloc(sparx5, ctrl, cfg);
@@ -2097,5 +2097,6 @@ void sparx5_vcap_deinit(struct sparx5 *sparx5)
 		list_del(&admin->list);
 		sparx5_vcap_admin_free(admin);
 	}
+	mutex_destroy(&ctrl->lock);
 	kfree(ctrl);
 }
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
index 0fdb5e363bad..ff86cde11a32 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
@@ -934,6 +934,16 @@ static bool vcap_rule_exists(struct vcap_control *vctrl, u32 id)
 	return false;
 }
 
+void vcap_lock(struct vcap_admin *admin)
+{
+	mutex_lock(&admin->vctrl->lock);
+}
+
+void vcap_unlock(struct vcap_admin *admin)
+{
+	mutex_unlock(&admin->vctrl->lock);
+}
+
 /* Find a rule with a provided rule id return a locked vcap */
 static struct vcap_rule_internal *
 vcap_get_locked_rule(struct vcap_control *vctrl, u32 id)
@@ -943,11 +953,11 @@ vcap_get_locked_rule(struct vcap_control *vctrl, u32 id)
 
 	/* Look for the rule id in all vcaps */
 	list_for_each_entry(admin, &vctrl->list, list) {
-		mutex_lock(&admin->lock);
+		vcap_lock(admin);
 		list_for_each_entry(ri, &admin->rules, list)
 			if (ri->data.id == id)
 				return ri;
-		mutex_unlock(&admin->lock);
+		vcap_unlock(admin);
 	}
 	return NULL;
 }
@@ -961,14 +971,14 @@ int vcap_lookup_rule_by_cookie(struct vcap_control *vctrl, u64 cookie)
 
 	/* Look for the rule id in all vcaps */
 	list_for_each_entry(admin, &vctrl->list, list) {
-		mutex_lock(&admin->lock);
+		vcap_lock(admin);
 		list_for_each_entry(ri, &admin->rules, list) {
 			if (ri->data.cookie == cookie) {
 				id = ri->data.id;
 				break;
 			}
 		}
-		mutex_unlock(&admin->lock);
+		vcap_unlock(admin);
 		if (id)
 			return id;
 	}
@@ -985,11 +995,11 @@ int vcap_admin_rule_count(struct vcap_admin *admin, int cid)
 	int count = 0;
 
 	list_for_each_entry(elem, &admin->rules, list) {
-		mutex_lock(&admin->lock);
+		vcap_lock(admin);
 		if (elem->data.vcap_chain_id >= min_cid &&
 		    elem->data.vcap_chain_id < max_cid)
 			++count;
-		mutex_unlock(&admin->lock);
+		vcap_unlock(admin);
 	}
 	return count;
 }
@@ -2266,7 +2276,7 @@ int vcap_add_rule(struct vcap_rule *rule)
 	if (ret)
 		return ret;
 	/* Insert the new rule in the list of vcap rules */
-	mutex_lock(&ri->admin->lock);
+	vcap_lock(ri->admin);
 
 	vcap_rule_set_state(ri);
 	ret = vcap_insert_rule(ri, &move);
@@ -2302,7 +2312,7 @@ int vcap_add_rule(struct vcap_rule *rule)
 		goto out;
 	}
 out:
-	mutex_unlock(&ri->admin->lock);
+	vcap_unlock(ri->admin);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(vcap_add_rule);
@@ -2330,7 +2340,7 @@ struct vcap_rule *vcap_alloc_rule(struct vcap_control *vctrl,
 	if (vctrl->vcaps[admin->vtype].rows == 0)
 		return ERR_PTR(-EINVAL);
 
-	mutex_lock(&admin->lock);
+	vcap_lock(admin);
 	/* Check if a rule with this id already exists */
 	if (vcap_rule_exists(vctrl, id)) {
 		err = -EINVAL;
@@ -2369,13 +2379,13 @@ struct vcap_rule *vcap_alloc_rule(struct vcap_control *vctrl,
 		goto out_free;
 	}
 
-	mutex_unlock(&admin->lock);
+	vcap_unlock(admin);
 	return (struct vcap_rule *)ri;
 
 out_free:
 	kfree(ri);
 out_unlock:
-	mutex_unlock(&admin->lock);
+	vcap_unlock(admin);
 	return ERR_PTR(err);
 
 }
@@ -2446,7 +2456,7 @@ struct vcap_rule *vcap_get_rule(struct vcap_control *vctrl, u32 id)
 		return ERR_PTR(-ENOENT);
 
 	rule = vcap_decode_rule(elem);
-	mutex_unlock(&elem->admin->lock);
+	vcap_unlock(elem->admin);
 	return rule;
 }
 EXPORT_SYMBOL_GPL(vcap_get_rule);
@@ -2483,7 +2493,7 @@ int vcap_mod_rule(struct vcap_rule *rule)
 	err =  vcap_write_counter(ri, &ctr);
 
 out:
-	mutex_unlock(&ri->admin->lock);
+	vcap_unlock(ri->admin);
 	return err;
 }
 EXPORT_SYMBOL_GPL(vcap_mod_rule);
@@ -2570,7 +2580,7 @@ int vcap_del_rule(struct vcap_control *vctrl, struct net_device *ndev, u32 id)
 		admin->last_used_addr = elem->addr;
 	}
 
-	mutex_unlock(&admin->lock);
+	vcap_unlock(admin);
 	return err;
 }
 EXPORT_SYMBOL_GPL(vcap_del_rule);
@@ -2585,7 +2595,7 @@ int vcap_del_rules(struct vcap_control *vctrl, struct vcap_admin *admin)
 	if (ret)
 		return ret;
 
-	mutex_lock(&admin->lock);
+	vcap_lock(admin);
 	list_for_each_entry_safe(ri, next_ri, &admin->rules, list) {
 		vctrl->ops->init(ri->ndev, admin, ri->addr, ri->size);
 		list_del(&ri->list);
@@ -2598,7 +2608,7 @@ int vcap_del_rules(struct vcap_control *vctrl, struct vcap_admin *admin)
 		list_del(&eport->list);
 		kfree(eport);
 	}
-	mutex_unlock(&admin->lock);
+	vcap_unlock(admin);
 
 	return 0;
 }
@@ -3016,7 +3026,7 @@ static int vcap_enable_rules(struct vcap_control *vctrl,
 			continue;
 
 		/* Found the admin, now find the offloadable rules */
-		mutex_lock(&admin->lock);
+		vcap_lock(admin);
 		list_for_each_entry(ri, &admin->rules, list) {
 			/* Is the rule in the lookup defined by the chain */
 			if (!(ri->data.vcap_chain_id >= chain &&
@@ -3034,7 +3044,7 @@ static int vcap_enable_rules(struct vcap_control *vctrl,
 			if (err)
 				break;
 		}
-		mutex_unlock(&admin->lock);
+		vcap_unlock(admin);
 		if (err)
 			break;
 	}
@@ -3074,7 +3084,7 @@ static int vcap_disable_rules(struct vcap_control *vctrl,
 			continue;
 
 		/* Found the admin, now find the rules on the chain */
-		mutex_lock(&admin->lock);
+		vcap_lock(admin);
 		list_for_each_entry(ri, &admin->rules, list) {
 			if (ri->data.vcap_chain_id != chain)
 				continue;
@@ -3089,7 +3099,7 @@ static int vcap_disable_rules(struct vcap_control *vctrl,
 			if (err)
 				break;
 		}
-		mutex_unlock(&admin->lock);
+		vcap_unlock(admin);
 		if (err)
 			break;
 	}
@@ -3133,9 +3143,9 @@ static int vcap_enable(struct vcap_control *vctrl, struct net_device *ndev,
 	eport->cookie = cookie;
 	eport->src_cid = src_cid;
 	eport->dst_cid = dst_cid;
-	mutex_lock(&admin->lock);
+	vcap_lock(admin);
 	list_add_tail(&eport->list, &admin->enabled);
-	mutex_unlock(&admin->lock);
+	vcap_unlock(admin);
 
 	if (vcap_path_exist(vctrl, ndev, src_cid)) {
 		/* Enable chained lookups */
@@ -3185,9 +3195,9 @@ static int vcap_disable(struct vcap_control *vctrl, struct net_device *ndev,
 		dst_cid = vcap_get_next_chain(vctrl, ndev, dst_cid);
 	}
 
-	mutex_lock(&found->lock);
+	vcap_lock(found);
 	list_del(&eport->list);
-	mutex_unlock(&found->lock);
+	vcap_unlock(found);
 	kfree(eport);
 	return 0;
 }
@@ -3270,9 +3280,9 @@ int vcap_rule_set_counter(struct vcap_rule *rule, struct vcap_counter *ctr)
 		return -EINVAL;
 	}
 
-	mutex_lock(&ri->admin->lock);
+	vcap_lock(ri->admin);
 	err = vcap_write_counter(ri, ctr);
-	mutex_unlock(&ri->admin->lock);
+	vcap_unlock(ri->admin);
 
 	return err;
 }
@@ -3291,9 +3301,9 @@ int vcap_rule_get_counter(struct vcap_rule *rule, struct vcap_counter *ctr)
 		return -EINVAL;
 	}
 
-	mutex_lock(&ri->admin->lock);
+	vcap_lock(ri->admin);
 	err = vcap_read_counter(ri, ctr);
-	mutex_unlock(&ri->admin->lock);
+	vcap_unlock(ri->admin);
 
 	return err;
 }
@@ -3395,7 +3405,7 @@ int vcap_get_rule_count_by_cookie(struct vcap_control *vctrl,
 
 	/* Iterate all rules in each VCAP instance */
 	list_for_each_entry(admin, &vctrl->list, list) {
-		mutex_lock(&admin->lock);
+		vcap_lock(admin);
 		list_for_each_entry(ri, &admin->rules, list) {
 			if (ri->data.cookie != cookie)
 				continue;
@@ -3412,12 +3422,12 @@ int vcap_get_rule_count_by_cookie(struct vcap_control *vctrl,
 			if (err)
 				goto unlock;
 		}
-		mutex_unlock(&admin->lock);
+		vcap_unlock(admin);
 	}
 	return err;
 
 unlock:
-	mutex_unlock(&admin->lock);
+	vcap_unlock(admin);
 	return err;
 }
 EXPORT_SYMBOL_GPL(vcap_get_rule_count_by_cookie);
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.h b/drivers/net/ethernet/microchip/vcap/vcap_api.h
index 6069ad95c27e..05b4b02e59ef 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.h
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.h
@@ -164,7 +164,7 @@ struct vcap_admin {
 	struct list_head list; /* for insertion in vcap_control */
 	struct list_head rules; /* list of rules */
 	struct list_head enabled; /* list of enabled ports */
-	struct mutex lock; /* control access to rules */
+	struct vcap_control *vctrl; /* the control instance owning this vcap */
 	enum vcap_type vtype;  /* type of vcap */
 	int vinst; /* instance number within the same type */
 	int first_cid; /* first chain id in this vcap */
@@ -275,6 +275,7 @@ struct vcap_control {
 	const struct vcap_info *vcaps; /* client supplied vcap models */
 	const struct vcap_statistics *stats; /* client supplied vcap stats */
 	struct list_head list; /* list of vcap instances */
+	struct mutex lock; /* serialize access to all vcap instances */
 };
 
 #endif /* __VCAP_API__ */
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
index 59bfbda29bb3..e0c65c7ab23e 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
@@ -410,9 +410,9 @@ static int vcap_debugfs_show(struct seq_file *m, void *unused)
 	};
 	int ret;
 
-	mutex_lock(&info->admin->lock);
+	vcap_lock(info->admin);
 	ret = vcap_show_admin(info->vctrl, info->admin, &out);
-	mutex_unlock(&info->admin->lock);
+	vcap_unlock(info->admin);
 	return ret;
 }
 DEFINE_SHOW_ATTRIBUTE(vcap_debugfs);
@@ -427,9 +427,9 @@ static int vcap_raw_debugfs_show(struct seq_file *m, void *unused)
 	};
 	int ret;
 
-	mutex_lock(&info->admin->lock);
+	vcap_lock(info->admin);
 	ret = vcap_show_admin_raw(info->vctrl, info->admin, &out);
-	mutex_unlock(&info->admin->lock);
+	vcap_unlock(info->admin);
 	return ret;
 }
 DEFINE_SHOW_ATTRIBUTE(vcap_raw_debugfs);
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs_kunit.c b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs_kunit.c
index 9c9d38042125..ac2a3b8c4f32 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs_kunit.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs_kunit.c
@@ -243,10 +243,11 @@ static void vcap_test_api_init(struct vcap_admin *admin)
 {
 	/* Initialize the shared objects */
 	INIT_LIST_HEAD(&test_vctrl.list);
+	mutex_init(&test_vctrl.lock);
 	INIT_LIST_HEAD(&admin->list);
 	INIT_LIST_HEAD(&admin->rules);
 	INIT_LIST_HEAD(&admin->enabled);
-	mutex_init(&admin->lock);
+	admin->vctrl = &test_vctrl;
 	list_add_tail(&admin->list, &test_vctrl.list);
 	memset(test_updateaddr, 0, sizeof(test_updateaddr));
 	test_updateaddridx = 0;
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
index ce26ccbdccdf..83de384d3e3b 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
@@ -233,10 +233,11 @@ static void vcap_test_api_init(struct vcap_admin *admin)
 {
 	/* Initialize the shared objects */
 	INIT_LIST_HEAD(&test_vctrl.list);
+	mutex_init(&test_vctrl.lock);
 	INIT_LIST_HEAD(&admin->list);
 	INIT_LIST_HEAD(&admin->rules);
 	INIT_LIST_HEAD(&admin->enabled);
-	mutex_init(&admin->lock);
+	admin->vctrl = &test_vctrl;
 	list_add_tail(&admin->list, &test_vctrl.list);
 	memset(test_updateaddr, 0, sizeof(test_updateaddr));
 	test_updateaddridx = 0;
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_private.h b/drivers/net/ethernet/microchip/vcap/vcap_api_private.h
index 844bdf6b5f45..b4057fbe3d18 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_private.h
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_private.h
@@ -50,6 +50,9 @@ struct vcap_stream_iter {
 
 /* Check that the control has a valid set of callbacks */
 int vcap_api_check(struct vcap_control *ctrl);
+/* Serialize access to the vcap instances of a control */
+void vcap_lock(struct vcap_admin *admin);
+void vcap_unlock(struct vcap_admin *admin);
 /* Erase the VCAP cache area used or encoding and decoding */
 void vcap_erase_cache(struct vcap_rule_internal *ri);
 

---
base-commit: d87363b0edfc7504ff2b144fe4cdd8154f90f42e
change-id: 20260624-microchip_fix_vcap_locking-70c057531c16

Best regards,
-- 
Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>


