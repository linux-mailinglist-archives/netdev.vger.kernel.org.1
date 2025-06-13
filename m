Return-Path: <netdev+bounces-197486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B35F3AD8C3F
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF06188E144
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B413FE5;
	Fri, 13 Jun 2025 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cftyeBIL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MlpCJ8f9"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9453D76
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818195; cv=none; b=sW1kHk+/J0zNoz8/XpesnDlsL334o0H6TR04rcTYeEMleqNNUtE4Ck4oNfgcC4hnqYtKA7hEQn5FnaoSHaLKqTxjOmTKgL2Pg/PGQvQVCcigEWGpO7i0CzCS4C4KAcawbtOg06yKw2JmI2DK0/HQ5quvU8CnmHP6noq1399nYK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818195; c=relaxed/simple;
	bh=8cQjBezLyUAJE8xuD4DVViCV0/FLRKfEO8sjx/RSStA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W5a5Q/+YDUc/gGIjRrhvlatvF0ySOGVPcx78yrw6dAg5+cVwIeiGr3Ku7Omp7BBzcgLAZgoXJF6u+ZctbYbDNX7uX8BbGb/F28OnHtntQOemq6FabNLIMepUvFEuYejsb2mRcvSngKGkW9gJkCn3zVPOqClW82u64jUFLDeF4qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cftyeBIL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MlpCJ8f9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 14:36:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749818190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=rBRrS7BQTShG7BpVbwIMBpD37K5b1onJfKfEeYVYqfo=;
	b=cftyeBILYRWHLHRSMCkZXt/VQjskCMUPiMcFqiZ08DEVnyHX+KNefoEh5MH0GADTEJeon9
	cgcOkuL4lco2286mJv8p9yo5AGrJy3+uAyPSQ089WiZe9ThATI41d3crIHr4SLru1fcizi
	E1sy3FB7x8wJt8LSJWOvrEv/A/oOJjOmWiW5xlZgNKhtDnS+8WNaRgAFGA+XM/zIggahkT
	xXY/eAbKggPTWmPUk6lLMoMLDav4BRl+/LMA1lVhw901m0ukN9BCKKlnwO/hzotLNWuPTG
	yhxDTLDVchIsrABy7DFUYQi53DxULHmfkjSrvHCTY4fAe1bXed/oEj0AqVsvfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749818190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=rBRrS7BQTShG7BpVbwIMBpD37K5b1onJfKfEeYVYqfo=;
	b=MlpCJ8f9Gf/cySOKvjCRTtp8c+JtSP2cr4mwFvffrBsBFnhOglK+UMsIHmVIdqF2lHoFk7
	B8JLEOS+f7zB5mBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org, dev@openvswitch.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Gal Pressman <gal@nvidia.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net] openvswitch: Allocate struct ovs_pcpu_storage dynamically
Message-ID: <20250613123629.-XSoQTCu@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

PERCPU_MODULE_RESERVE defines the maximum size that can by used for the
per-CPU data size used by modules. This is 8KiB.

Commit 035fcdc4d240c ("openvswitch: Merge three per-CPU structures into
one") restructured the per-CPU memory allocation for the module and
moved the separate alloc_percpu() invocations at module init time to a
static per-CPU variable which is allocated by the module loader.

The size of the per-CPU data section for openvswitch is 6488 bytes which
is ~80% of the available per-CPU memory. Together with a few other
modules it is easy to exhaust the available 8KiB of memory.

Allocate ovs_pcpu_storage dynamically at module init time.

Reported-by: Gal Pressman <gal@nvidia.com>
Closes: https://lore.kernel.org/all/c401e017-f8db-4f57-a1cd-89beb979a277@nvidia.com
Fixes: 035fcdc4d240c ("openvswitch: Merge three per-CPU structures into one")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

Gal, would you please be so kind and check if this works for you?

 net/openvswitch/actions.c  | 23 +++++++++------------
 net/openvswitch/datapath.c | 42 +++++++++++++++++++++++++++++++-------
 net/openvswitch/datapath.h |  3 ++-
 3 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index e7269a3eec79e..3add108340bfd 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -39,16 +39,14 @@
 #include "flow_netlink.h"
 #include "openvswitch_trace.h"
 
-DEFINE_PER_CPU(struct ovs_pcpu_storage, ovs_pcpu_storage) = {
-	.bh_lock = INIT_LOCAL_LOCK(bh_lock),
-};
+struct ovs_pcpu_storage __percpu *ovs_pcpu_storage;
 
 /* Make a clone of the 'key', using the pre-allocated percpu 'flow_keys'
  * space. Return NULL if out of key spaces.
  */
 static struct sw_flow_key *clone_key(const struct sw_flow_key *key_)
 {
-	struct ovs_pcpu_storage *ovs_pcpu = this_cpu_ptr(&ovs_pcpu_storage);
+	struct ovs_pcpu_storage *ovs_pcpu = this_cpu_ptr(ovs_pcpu_storage);
 	struct action_flow_keys *keys = &ovs_pcpu->flow_keys;
 	int level = ovs_pcpu->exec_level;
 	struct sw_flow_key *key = NULL;
@@ -94,7 +92,7 @@ static struct deferred_action *add_deferred_actions(struct sk_buff *skb,
 				    const struct nlattr *actions,
 				    const int actions_len)
 {
-	struct action_fifo *fifo = this_cpu_ptr(&ovs_pcpu_storage.action_fifos);
+	struct action_fifo *fifo = this_cpu_ptr(&ovs_pcpu_storage->action_fifos);
 	struct deferred_action *da;
 
 	da = action_fifo_put(fifo);
@@ -755,7 +753,7 @@ static int set_sctp(struct sk_buff *skb, struct sw_flow_key *flow_key,
 static int ovs_vport_output(struct net *net, struct sock *sk,
 			    struct sk_buff *skb)
 {
-	struct ovs_frag_data *data = this_cpu_ptr(&ovs_pcpu_storage.frag_data);
+	struct ovs_frag_data *data = this_cpu_ptr(&ovs_pcpu_storage->frag_data);
 	struct vport *vport = data->vport;
 
 	if (skb_cow_head(skb, data->l2_len) < 0) {
@@ -807,7 +805,7 @@ static void prepare_frag(struct vport *vport, struct sk_buff *skb,
 	unsigned int hlen = skb_network_offset(skb);
 	struct ovs_frag_data *data;
 
-	data = this_cpu_ptr(&ovs_pcpu_storage.frag_data);
+	data = this_cpu_ptr(&ovs_pcpu_storage->frag_data);
 	data->dst = skb->_skb_refdst;
 	data->vport = vport;
 	data->cb = *OVS_CB(skb);
@@ -1566,16 +1564,15 @@ static int clone_execute(struct datapath *dp, struct sk_buff *skb,
 	clone = clone_flow_key ? clone_key(key) : key;
 	if (clone) {
 		int err = 0;
-
 		if (actions) { /* Sample action */
 			if (clone_flow_key)
-				__this_cpu_inc(ovs_pcpu_storage.exec_level);
+				__this_cpu_inc(ovs_pcpu_storage->exec_level);
 
 			err = do_execute_actions(dp, skb, clone,
 						 actions, len);
 
 			if (clone_flow_key)
-				__this_cpu_dec(ovs_pcpu_storage.exec_level);
+				__this_cpu_dec(ovs_pcpu_storage->exec_level);
 		} else { /* Recirc action */
 			clone->recirc_id = recirc_id;
 			ovs_dp_process_packet(skb, clone);
@@ -1611,7 +1608,7 @@ static int clone_execute(struct datapath *dp, struct sk_buff *skb,
 
 static void process_deferred_actions(struct datapath *dp)
 {
-	struct action_fifo *fifo = this_cpu_ptr(&ovs_pcpu_storage.action_fifos);
+	struct action_fifo *fifo = this_cpu_ptr(&ovs_pcpu_storage->action_fifos);
 
 	/* Do not touch the FIFO in case there is no deferred actions. */
 	if (action_fifo_is_empty(fifo))
@@ -1642,7 +1639,7 @@ int ovs_execute_actions(struct datapath *dp, struct sk_buff *skb,
 {
 	int err, level;
 
-	level = __this_cpu_inc_return(ovs_pcpu_storage.exec_level);
+	level = __this_cpu_inc_return(ovs_pcpu_storage->exec_level);
 	if (unlikely(level > OVS_RECURSION_LIMIT)) {
 		net_crit_ratelimited("ovs: recursion limit reached on datapath %s, probable configuration error\n",
 				     ovs_dp_name(dp));
@@ -1659,6 +1656,6 @@ int ovs_execute_actions(struct datapath *dp, struct sk_buff *skb,
 		process_deferred_actions(dp);
 
 out:
-	__this_cpu_dec(ovs_pcpu_storage.exec_level);
+	__this_cpu_dec(ovs_pcpu_storage->exec_level);
 	return err;
 }
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 6a304ae2d959c..b990dc83504f4 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -244,7 +244,7 @@ void ovs_dp_detach_port(struct vport *p)
 /* Must be called with rcu_read_lock. */
 void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 {
-	struct ovs_pcpu_storage *ovs_pcpu = this_cpu_ptr(&ovs_pcpu_storage);
+	struct ovs_pcpu_storage *ovs_pcpu = this_cpu_ptr(ovs_pcpu_storage);
 	const struct vport *p = OVS_CB(skb)->input_vport;
 	struct datapath *dp = p->dp;
 	struct sw_flow *flow;
@@ -299,7 +299,7 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 	 * avoided.
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && ovs_pcpu->owner != current) {
-		local_lock_nested_bh(&ovs_pcpu_storage.bh_lock);
+		local_lock_nested_bh(&ovs_pcpu_storage->bh_lock);
 		ovs_pcpu->owner = current;
 		ovs_pcpu_locked = true;
 	}
@@ -310,7 +310,7 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 				    ovs_dp_name(dp), error);
 	if (ovs_pcpu_locked) {
 		ovs_pcpu->owner = NULL;
-		local_unlock_nested_bh(&ovs_pcpu_storage.bh_lock);
+		local_unlock_nested_bh(&ovs_pcpu_storage->bh_lock);
 	}
 
 	stats_counter = &stats->n_hit;
@@ -689,13 +689,13 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb, struct genl_info *info)
 	sf_acts = rcu_dereference(flow->sf_acts);
 
 	local_bh_disable();
-	local_lock_nested_bh(&ovs_pcpu_storage.bh_lock);
+	local_lock_nested_bh(&ovs_pcpu_storage->bh_lock);
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		this_cpu_write(ovs_pcpu_storage.owner, current);
+		this_cpu_write(ovs_pcpu_storage->owner, current);
 	err = ovs_execute_actions(dp, packet, sf_acts, &flow->key);
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		this_cpu_write(ovs_pcpu_storage.owner, NULL);
-	local_unlock_nested_bh(&ovs_pcpu_storage.bh_lock);
+		this_cpu_write(ovs_pcpu_storage->owner, NULL);
+	local_unlock_nested_bh(&ovs_pcpu_storage->bh_lock);
 	local_bh_enable();
 	rcu_read_unlock();
 
@@ -2744,6 +2744,28 @@ static struct drop_reason_list drop_reason_list_ovs = {
 	.n_reasons = ARRAY_SIZE(ovs_drop_reasons),
 };
 
+static int __init ovs_alloc_percpu_storage(void)
+{
+	unsigned int cpu;
+
+	ovs_pcpu_storage = alloc_percpu(*ovs_pcpu_storage);
+	if (!ovs_pcpu_storage)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		struct ovs_pcpu_storage *ovs_pcpu;
+
+		ovs_pcpu = per_cpu_ptr(ovs_pcpu_storage, cpu);
+		local_lock_init(&ovs_pcpu->bh_lock);
+	}
+	return 0;
+}
+
+static void ovs_free_percpu_storage(void)
+{
+	free_percpu(ovs_pcpu_storage);
+}
+
 static int __init dp_init(void)
 {
 	int err;
@@ -2753,6 +2775,10 @@ static int __init dp_init(void)
 
 	pr_info("Open vSwitch switching datapath\n");
 
+	err = ovs_alloc_percpu_storage();
+	if (err)
+		goto error;
+
 	err = ovs_internal_dev_rtnl_link_register();
 	if (err)
 		goto error;
@@ -2799,6 +2825,7 @@ static int __init dp_init(void)
 error_unreg_rtnl_link:
 	ovs_internal_dev_rtnl_link_unregister();
 error:
+	ovs_free_percpu_storage();
 	return err;
 }
 
@@ -2813,6 +2840,7 @@ static void dp_cleanup(void)
 	ovs_vport_exit();
 	ovs_flow_exit();
 	ovs_internal_dev_rtnl_link_unregister();
+	ovs_free_percpu_storage();
 }
 
 module_init(dp_init);
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 1b5348b0f5594..cfeb817a18894 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -220,7 +220,8 @@ struct ovs_pcpu_storage {
 	struct task_struct *owner;
 	local_lock_t bh_lock;
 };
-DECLARE_PER_CPU(struct ovs_pcpu_storage, ovs_pcpu_storage);
+
+extern struct ovs_pcpu_storage __percpu *ovs_pcpu_storage;
 
 /**
  * enum ovs_pkt_hash_types - hash info to include with a packet
-- 
2.49.0


