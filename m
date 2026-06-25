Return-Path: <netdev+bounces-301997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tQVaEjdGPWqL0ggAu9opvQ
	(envelope-from <netdev+bounces-301997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:16:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 918F56C6FBD
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:16:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=SC5ZRruJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301997-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301997-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E15E1306B7A2
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB2D3E7BD9;
	Thu, 25 Jun 2026 15:14:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C6F3E8330
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 15:14:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400491; cv=none; b=q5CRmjhMpgQf/Rdxsm6RuJ8VEXaySPqAY2HbeHiWiaoYVjkTENNypK+Hzwzci8lzU33V1BWFF2tuTaoWZMmjDiEeYKEtw9Z97TGc7LFpshdxrUTnEOj/P30TQN5YkxIjlrcUM0tAZVQHiEIG+lbWPJKZDiT63T1D8j+g18roxzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400491; c=relaxed/simple;
	bh=XZQP0oD9FvnE4nAxoQ4Mo7tW1DOKxRSzciRO95qSmOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b0bsZgNMP30cjVNLHk9PFzdhVjwVM03CM4dicjBdYwtDw+zvrxiAvnHsW7eQbGKxbKaanRu99OKafXEdVd4PTzqdEzf9+KPh5Jw+mBhXJZG0vW16umTp9R95YgRo/z2S6EIcbBPC3ybRmFrJ3mvTA29hVvhMgjez0YWHNsBTGYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SC5ZRruJ; arc=none smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782400490; x=1813936490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XZQP0oD9FvnE4nAxoQ4Mo7tW1DOKxRSzciRO95qSmOo=;
  b=SC5ZRruJfpzAEZCR0/C1egT+sN8BFPvRW8LoOc9ZfuvYtYcL2DObkieu
   f/Ggr/Vg5RSKZ6S+ryVjfPcli8YhCABF8xGYQnHKUd2ZFh80GsCJmwC5F
   16tFz/intY5wj4TMtVEWJjW/hzFs9JpbjaTW0mN8ldTloLCj67Ca1gseM
   osX0NbU2/38t4qltTA/4kA7dETodrxPNjmgBLPqRXJR4LSdv42wvifjdN
   5ni6rH+pRnNjJRTaGRn58xPNajUIViPxNXkcVC0vcxC8QX7K4mu7BVYzG
   +9cOcdFeBLFi5q5YxV4nXCg26JzgnAMu+s0kpbCSHtJVfdrBekH7Kv6AZ
   A==;
X-CSE-ConnectionGUID: G9KFcf3aRSK3WDHnGGSfFw==
X-CSE-MsgGUID: Z3e9Y3wbQK+k8UPqXPnIKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83304551"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="83304551"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 08:14:49 -0700
X-CSE-ConnectionGUID: zmz+lG3CQN+FVaXD4d84wA==
X-CSE-MsgGUID: jQtoeOsyRXqV3FEIF/wjEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="254866987"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa004.jf.intel.com with ESMTP; 25 Jun 2026 08:14:47 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v4 net 3/3] i40e: keep q_vectors array in sync with channel count changes
Date: Thu, 25 Jun 2026 17:14:31 +0200
Message-Id: <20260625151431.1102838-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260625151431.1102838-1-maciej.fijalkowski@intel.com>
References: <20260625151431.1102838-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301997-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:przemyslaw.kitszel@intel.com,m:jacob.e.keller@intel.com,m:maciej.fijalkowski@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,napi_threaded.py:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 918F56C6FBD

For the main VSI, i40e_set_num_rings_in_vsi() always derives
num_q_vectors from pf->num_lan_msix. At the same time, ethtool -L stores
the user requested channel count in vsi->req_queue_pairs and the queue
setup path uses that value for the effective number of queue pairs.

This leaves queue and vector counts out of sync after shrinking channel
count via ethtool -L. The active queue configuration is reduced, but the
VSI still keeps the full PF-sized q_vector topology.

That mismatch breaks reconfiguration flows which rely on vector/NAPI
state matching the effective channel configuration. In particular,
toggling /sys/class/net/<dev>/threaded after reducing the channel count
can hang, and later channel-count changes can fail because VSI reinit
does not rebuild q_vectors to match the new vector count.

Fix this by making the main VSI num_q_vectors follow the effective
requested channel count, capped by the available MSI-X vectors. Update
i40e_vsi_reinit_setup() to rebuild q_vectors during VSI reinit so the
vector topology is refreshed together with the ring arrays when channel
count changes.

Keep alloc_queue_pairs unchanged and based on pf->num_lan_qps so the VSI
retains its full queue capacity.

Selftest napi_threaded.py was originally used when Jakub reported hang
on /sys/class/net/<dev>/threaded toggle. In order to make it pass on
i40e, use persistent NAPI configuration for q_vector NAPIs so NAPI
identity and threaded settings survive q_vector reallocation across
channel-count changes. This is achieved by using netif_napi_add_config()
when configuring q_vectors.

$ export NETIF=ens259f1np1
$ sudo -E env PATH="$PATH" ./tools/testing/selftests/drivers/net/napi_threaded.py
TAP version 13
1..3
ok 1 napi_threaded.napi_init
ok 2 napi_threaded.change_num_queues
ok 3 napi_threaded.enable_dev_threaded_disable_napi_threaded
Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/intel-wired-lan/20260316133100.6054a11f@kernel.org/
Fixes: d2a69fefd756 ("i40e: Fix changing previously set num_queue_pairs for PFs")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 60 +++++++++++++--------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4adc7b0fb2f4..c017217a1bc3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11406,10 +11406,14 @@ static void i40e_service_timer(struct timer_list *t)
 static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
 {
 	struct i40e_pf *pf = vsi->back;
+	u16 qps;
 
 	switch (vsi->type) {
 	case I40E_VSI_MAIN:
 		vsi->alloc_queue_pairs = pf->num_lan_qps;
+		qps = vsi->req_queue_pairs ?
+		      min(vsi->req_queue_pairs, pf->num_lan_qps) :
+		      pf->num_lan_qps;
 		if (!vsi->num_tx_desc)
 			vsi->num_tx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
 						 I40E_REQ_DESCRIPTOR_MULTIPLE);
@@ -11417,7 +11421,7 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
 			vsi->num_rx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
 						 I40E_REQ_DESCRIPTOR_MULTIPLE);
 		if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
-			vsi->num_q_vectors = pf->num_lan_msix;
+			vsi->num_q_vectors = clamp(qps, 1, pf->num_lan_msix);
 		else
 			vsi->num_q_vectors = 1;
 
@@ -11469,12 +11473,11 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
 /**
  * i40e_vsi_alloc_arrays - Allocate queue and vector pointer arrays for the vsi
  * @vsi: VSI pointer
- * @alloc_qvectors: a bool to specify if q_vectors need to be allocated.
  *
  * On error: returns error code (negative)
  * On success: returns 0
  **/
-static int i40e_vsi_alloc_arrays(struct i40e_vsi *vsi, bool alloc_qvectors)
+static int i40e_vsi_alloc_arrays(struct i40e_vsi *vsi)
 {
 	struct i40e_ring **next_rings;
 	int size;
@@ -11493,19 +11496,18 @@ static int i40e_vsi_alloc_arrays(struct i40e_vsi *vsi, bool alloc_qvectors)
 	}
 	vsi->rx_rings = next_rings;
 
-	if (alloc_qvectors) {
-		/* allocate memory for q_vector pointers */
-		size = sizeof(struct i40e_q_vector *) * vsi->num_q_vectors;
-		vsi->q_vectors = kzalloc(size, GFP_KERNEL);
-		if (!vsi->q_vectors) {
-			ret = -ENOMEM;
-			goto err_vectors;
-		}
+	/* allocate memory for q_vector pointers */
+	size = sizeof(struct i40e_q_vector *) * vsi->num_q_vectors;
+	vsi->q_vectors = kzalloc(size, GFP_KERNEL);
+	if (!vsi->q_vectors) {
+		ret = -ENOMEM;
+		goto err_vectors;
 	}
 	return ret;
 
 err_vectors:
 	kfree(vsi->tx_rings);
+	vsi->tx_rings = NULL;
 	return ret;
 }
 
@@ -11578,7 +11580,7 @@ static int i40e_vsi_mem_alloc(struct i40e_pf *pf, enum i40e_vsi_type type)
 	if (ret)
 		goto err_rings;
 
-	ret = i40e_vsi_alloc_arrays(vsi, true);
+	ret = i40e_vsi_alloc_arrays(vsi);
 	if (ret)
 		goto err_rings;
 
@@ -11603,18 +11605,15 @@ static int i40e_vsi_mem_alloc(struct i40e_pf *pf, enum i40e_vsi_type type)
 /**
  * i40e_vsi_free_arrays - Free queue and vector pointer arrays for the VSI
  * @vsi: VSI pointer
- * @free_qvectors: a bool to specify if q_vectors need to be freed.
  *
  * On error: returns error code (negative)
  * On success: returns 0
  **/
-static void i40e_vsi_free_arrays(struct i40e_vsi *vsi, bool free_qvectors)
+static void i40e_vsi_free_arrays(struct i40e_vsi *vsi)
 {
 	/* free the ring and vector containers */
-	if (free_qvectors) {
-		kfree(vsi->q_vectors);
-		vsi->q_vectors = NULL;
-	}
+	kfree(vsi->q_vectors);
+	vsi->q_vectors = NULL;
 	kfree(vsi->tx_rings);
 	vsi->tx_rings = NULL;
 	vsi->rx_rings = NULL;
@@ -11674,7 +11673,7 @@ static int i40e_vsi_clear(struct i40e_vsi *vsi)
 	i40e_put_lump(pf->irq_pile, vsi->base_vector, vsi->idx);
 
 	bitmap_free(vsi->af_xdp_zc_qps);
-	i40e_vsi_free_arrays(vsi, true);
+	i40e_vsi_free_arrays(vsi);
 	i40e_clear_rss_config_user(vsi);
 
 	pf->vsi[vsi->idx] = NULL;
@@ -12046,7 +12045,8 @@ static int i40e_vsi_alloc_q_vector(struct i40e_vsi *vsi, int v_idx)
 	cpumask_copy(&q_vector->affinity_mask, cpu_possible_mask);
 
 	if (vsi->netdev)
-		netif_napi_add(vsi->netdev, &q_vector->napi, i40e_napi_poll);
+		netif_napi_add_config(vsi->netdev, &q_vector->napi,
+				      i40e_napi_poll, v_idx);
 
 	/* tie q_vector and vsi together */
 	vsi->q_vectors[v_idx] = q_vector;
@@ -14267,12 +14267,26 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 
 	pf = vsi->back;
 
+	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
+		i40e_put_lump(pf->irq_pile, vsi->base_vector, vsi->idx);
+		vsi->base_vector = 0;
+	}
+
 	i40e_put_lump(pf->qp_pile, vsi->base_queue, vsi->idx);
+	i40e_vsi_free_q_vectors(vsi);
 	i40e_vsi_clear_rings(vsi);
+	i40e_vsi_free_arrays(vsi);
 
-	i40e_vsi_free_arrays(vsi, false);
 	i40e_set_num_rings_in_vsi(vsi);
-	ret = i40e_vsi_alloc_arrays(vsi, false);
+	ret = i40e_vsi_alloc_arrays(vsi);
+	if (ret)
+		goto err_netdev;
+
+	/* Rebuild q_vectors during VSI reinit because the effective channel
+	 * count may change num_q_vectors. Keep vector topology aligned with the
+	 * queue configuration after ethtool's .set_channels() callback.
+	 */
+	ret = i40e_vsi_setup_vectors(vsi);
 	if (ret)
 		goto err_netdev;
 
@@ -14284,7 +14298,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 		dev_info(&pf->pdev->dev,
 			 "failed to get tracking for %d queues for VSI %d err %d\n",
 			 alloc_queue_pairs, vsi->seid, ret);
-		goto err_netdev;
+		goto err_rings;
 	}
 	vsi->base_queue = ret;
 
-- 
2.43.0


