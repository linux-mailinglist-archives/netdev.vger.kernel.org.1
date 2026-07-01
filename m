Return-Path: <netdev+bounces-303639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LU5eDMEPRWr66AoAu9opvQ
	(envelope-from <netdev+bounces-303639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:01:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 298286EDC38
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:01:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="lx9DO/6X";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303639-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303639-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B65A30508FC
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 12:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92C3481FA2;
	Wed,  1 Jul 2026 12:45:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3993B48A2A8
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 12:45:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909946; cv=none; b=aRxy/w5DlZZVQGwoqc0afnEz/2shzZJeg0tW/GRhHeGnFrXXZO470HAH4bVgRV5zlu3KPMT3/vus6RAkMFIxgdGrQ/3TbcFg0rivU7piXPOGsdEiajiHj72x1EcsDLjc8+AyxYJK71crOsS6NEEvUim2ekpx1U+LAdqy/mL8NXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909946; c=relaxed/simple;
	bh=6DOTZZLMzhI/ndLqAd1UjHACb2Zu5h/9HaOuowLGsRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dJS34EzHSTbzNl+DRSdUKBIUnOr94YQ7wxH3/4vz0WYfSxrHnGfzfYMtNb7L4QP2Bxqo8GbvUMhdIr5H5Xd8g76oxiDKPMQgM9CLAtFtGZEIX1JcBMwkOejQVi7ylayL5Fr+zlCsZT4Xtaew7g8oLpswi6JQdOxCsk2nSqj8viY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lx9DO/6X; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782909945; x=1814445945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6DOTZZLMzhI/ndLqAd1UjHACb2Zu5h/9HaOuowLGsRs=;
  b=lx9DO/6XNHdx9hXUXDulkDOY7tvCcGCp9k5LfZ+Q5GGtQ+2YH/16+s+e
   TeVgpFHsITKF/lm43KmD1dBO5cqRGbiiuW0MnpY1WPkVXjeb9k9Z63/rX
   zPhs+FNvWpOmD9jXndt10Fgam/NfkE7+FNMLjA79ap+7HtAGDbHXMTdK8
   aUAbat7p0crU0bzfUjW21mMqdmzHAID9TwSyYuRgBoQs90TvSmeiZ+UDR
   QunTQF/L7eImhYfqtN18Goe6MsyGeaC4kUVw+rm3JhU1o8c9bqLjIJHsf
   Yg+kS7ovw5ucyMH1Qq0DTJEmTkCnBj9mRlKzQPIFKu355++iC1sr7rLfh
   A==;
X-CSE-ConnectionGUID: BnJAebY9Tr+9raHI/Pel+A==
X-CSE-MsgGUID: FChPBH5NRcibLCnnCA/6tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83839262"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="83839262"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 05:45:45 -0700
X-CSE-ConnectionGUID: uR70C+L6S1aR6XAgUC5DqQ==
X-CSE-MsgGUID: O7S0kl4sTTGoM9R8J1lOKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="276864956"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa001.fm.intel.com with ESMTP; 01 Jul 2026 05:45:43 -0700
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
Subject: [PATCH v5 net 7/7] i40e: keep q_vectors array in sync with channel count changes
Date: Wed,  1 Jul 2026 14:45:24 +0200
Message-Id: <20260701124524.13644-8-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
References: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303639-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:przemyslaw.kitszel@intel.com,m:jacob.e.keller@intel.com,m:maciej.fijalkowski@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,napi_threaded.py:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 298286EDC38

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
retains its full queue capacity. Also do not touch irq_pile when
rebuilding vectors.

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
 drivers/net/ethernet/intel/i40e/i40e_main.c | 69 +++++++++++++--------
 1 file changed, 44 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a9ec53cfd905..8a23bd99bd12 100644
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
@@ -11493,19 +11496,20 @@ static int i40e_vsi_alloc_arrays(struct i40e_vsi *vsi, bool alloc_qvectors)
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
+	vsi->rx_rings = NULL;
+	vsi->xdp_rings = NULL;
 	return ret;
 }
 
@@ -11578,7 +11582,7 @@ static int i40e_vsi_mem_alloc(struct i40e_pf *pf, enum i40e_vsi_type type)
 	if (ret)
 		goto err_rings;
 
-	ret = i40e_vsi_alloc_arrays(vsi, true);
+	ret = i40e_vsi_alloc_arrays(vsi);
 	if (ret)
 		goto err_rings;
 
@@ -11603,18 +11607,15 @@ static int i40e_vsi_mem_alloc(struct i40e_pf *pf, enum i40e_vsi_type type)
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
@@ -11674,7 +11675,7 @@ static int i40e_vsi_clear(struct i40e_vsi *vsi)
 	i40e_put_lump(pf->irq_pile, vsi->base_vector, vsi->idx);
 
 	bitmap_free(vsi->af_xdp_zc_qps);
-	i40e_vsi_free_arrays(vsi, true);
+	i40e_vsi_free_arrays(vsi);
 	i40e_clear_rss_config_user(vsi);
 
 	pf->vsi[vsi->idx] = NULL;
@@ -12048,7 +12049,8 @@ static int i40e_vsi_alloc_q_vector(struct i40e_vsi *vsi, int v_idx)
 	cpumask_copy(&q_vector->affinity_mask, cpu_possible_mask);
 
 	if (vsi->netdev)
-		netif_napi_add(vsi->netdev, &q_vector->napi, i40e_napi_poll);
+		netif_napi_add_config(vsi->netdev, &q_vector->napi,
+				      i40e_napi_poll, v_idx);
 
 	/* tie q_vector and vsi together */
 	vsi->q_vectors[v_idx] = q_vector;
@@ -14203,8 +14205,9 @@ int i40e_vsi_release(struct i40e_vsi *vsi)
  **/
 static int i40e_vsi_setup_vectors(struct i40e_vsi *vsi)
 {
-	int ret = -ENOENT;
 	struct i40e_pf *pf = vsi->back;
+	bool reuse_irq_lump = false;
+	int ret = -ENOENT;
 
 	if (vsi->q_vectors[0]) {
 		dev_info(&pf->pdev->dev, "VSI %d has existing q_vectors\n",
@@ -14212,7 +14215,10 @@ static int i40e_vsi_setup_vectors(struct i40e_vsi *vsi)
 		return -EEXIST;
 	}
 
-	if (vsi->base_vector) {
+	if (vsi->type == I40E_VSI_MAIN && vsi->base_vector)
+		reuse_irq_lump = true;
+
+	if (vsi->base_vector && !reuse_irq_lump) {
 		dev_info(&pf->pdev->dev, "VSI %d has non-zero base vector %d\n",
 			 vsi->seid, vsi->base_vector);
 		return -EEXIST;
@@ -14232,6 +14238,10 @@ static int i40e_vsi_setup_vectors(struct i40e_vsi *vsi)
 	*/
 	if (!test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
 		return ret;
+
+	if (reuse_irq_lump)
+		return ret;
+
 	if (vsi->num_q_vectors)
 		vsi->base_vector = i40e_get_lump(pf, pf->irq_pile,
 						 vsi->num_q_vectors, vsi->idx);
@@ -14271,11 +14281,20 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi,
 	pf = vsi->back;
 
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
 
@@ -14287,7 +14306,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi,
 		dev_info(&pf->pdev->dev,
 			 "failed to get tracking for %d queues for VSI %d err %d\n",
 			 alloc_queue_pairs, vsi->seid, ret);
-		goto err_netdev;
+		goto err_rings;
 	}
 	vsi->base_queue = ret;
 
-- 
2.43.0


