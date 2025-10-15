Return-Path: <netdev+bounces-229748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A83BE07B3
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D075545E63
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27993376B4;
	Wed, 15 Oct 2025 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nThxSG8Z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A273312809;
	Wed, 15 Oct 2025 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556811; cv=none; b=AK4H3wKzgpyPlwf34wg/mTd5g1525pYqIhVDOojq76Vb8+i7hiZlek0UJJzThbj57vAnXfeT16p694z8cnvWtrVSa8V7WAB1jVZ/S1ywV3oynSusd6l8oI8CayoycC1AnnDaEuIutaJ42ufUiMwBZVe398eGiW6Y738XcO20Q6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556811; c=relaxed/simple;
	bh=zSroYSUnwMmJ2WxRuOZRTYq2z9Ldx+vfAWWCN8ZmOeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a5k+AhJzJEqEYJAV2YRGvABYRsjFqKVHR8UksH/JMCylvzAekyQbvQwUD8wHWMhN/UwFJMcx2LgpTuK2HQGHx3hhu3I/KXFw2amtDCwMl0gxEme5GYqxOaO5Oz93HtOM2s4p7M5A/JR65Jruex09GcKA1r8cFZYuEoekv8tARZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nThxSG8Z; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760556809; x=1792092809;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=zSroYSUnwMmJ2WxRuOZRTYq2z9Ldx+vfAWWCN8ZmOeU=;
  b=nThxSG8Z4+2tVE1wg/qd6DVZbd73ag5x7HiK+Wfb2FppQS+ht+Vk+M31
   qWcubO64Hcw+nGKekZDSsPDkbtBR6JACEUy5y0gLQbJAMPH8q8E9QL8/A
   WcQWbDC4XJke3mYQ3J4j/jRSoq1iDhtOW7uy7RY4+B0EYmyK9O0kP/SsZ
   KSee4Jv9tXFjWEKZH7oLQ5EUGq/Jlzii1Dk78VNxIbfMEx6W2crCMMRRu
   mhTIPA21Dnex42DkEU97u2L955XNu7WZIHB0gM01Rma5CWAmPbCf0tWf+
   krcmQG8Ido7Y/MAsw1lLwQIsVz3oOhMctHw3L6JPe6bErJ6WdkbN/lHJy
   A==;
X-CSE-ConnectionGUID: oK4oBQrnRgmCdz3EIaWvrQ==
X-CSE-MsgGUID: 3z4FiIDHQr+7wAWHhFUxwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="74083578"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="74083578"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:33:16 -0700
X-CSE-ConnectionGUID: V4VNng4wT1iR1g+MXbf9Pw==
X-CSE-MsgGUID: xkgYXqkqRLqVn/zoJARwJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="182044911"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:33:15 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 15 Oct 2025 12:32:09 -0700
Subject: [PATCH net-next 13/14] ixgbe: preserve RSS indirection table
 across admin down/up
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-jk-iwl-next-2025-10-15-v1-13-79c70b9ddab8@intel.com>
References: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
In-Reply-To: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Kohei Enju <enjuk@amazon.com>, Rinitha S <sx.rinitha@intel.com>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=5694;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=8F2To28QstNuyAlt+B7GRD08I9GLaGQUGAXTdXn2irk=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoz3336I38xJ67jC77vXr/DlqtLOaqmFOl9t5dU+vU1yq
 Cpbk/Wuo5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIl41DEyPD95/67uHgY5hq7l
 5rMeLpzKPvli+OuUP8s897isThVT3MTIMP93BaPajKq5/DzRElt+LpPT2Lyjp0bxsKeq1dL1a/P
 E2AA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Kohei Enju <enjuk@amazon.com>

Currently, the RSS indirection table configured by user via ethtool is
reinitialized to default values during interface resets (e.g., admin
down/up, MTU change). As for RSS hash key, commit 3dfbfc7ebb95 ("ixgbe:
Check for RSS key before setting value") made it persistent across
interface resets.

Adopt the same approach used in igc and igb drivers which reinitializes
the RSS indirection table only when the queue count changes. Since the
number of RETA entries can also change in ixgbe, let's make user
configuration persistent as long as both queue count and the number of
RETA entries remain unchanged.

Tested on Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network
Connection.

Test:
Set custom indirection table and check the value after interface down/up

  # ethtool --set-rxfh-indir ens5 equal 2
  # ethtool --show-rxfh-indir ens5 | head -5

  RX flow hash indirection table for ens5 with 12 RX ring(s):
      0:      0     1     0     1     0     1     0     1
      8:      0     1     0     1     0     1     0     1
     16:      0     1     0     1     0     1     0     1
  # ip link set dev ens5 down && ip link set dev ens5 up

Without patch:
  # ethtool --show-rxfh-indir ens5 | head -5

  RX flow hash indirection table for ens5 with 12 RX ring(s):
      0:      0     1     2     3     4     5     6     7
      8:      8     9    10    11     0     1     2     3
     16:      4     5     6     7     8     9    10    11

With patch:
  # ethtool --show-rxfh-indir ens5 | head -5

  RX flow hash indirection table for ens5 with 12 RX ring(s):
      0:      0     1     0     1     0     1     0     1
      8:      0     1     0     1     0     1     0     1
     16:      0     1     0     1     0     1     0     1

Signed-off-by: Kohei Enju <enjuk@amazon.com>
Tested-by: Rinitha S <sx.rinitha@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 45 ++++++++++++++++++---------
 2 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 14d275270123..3553bf659d42 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -838,6 +838,8 @@ struct ixgbe_adapter {
  */
 #define IXGBE_MAX_RETA_ENTRIES 512
 	u8 rss_indir_tbl[IXGBE_MAX_RETA_ENTRIES];
+	u32 last_reta_entries;
+	u16 last_rss_indices;
 
 #define IXGBE_RSS_KEY_SIZE     40  /* size of RSS Hash Key in bytes */
 	u32 *rss_key;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 90d4e57b1c93..00810fc22ba9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4309,9 +4309,9 @@ static void ixgbe_store_vfreta(struct ixgbe_adapter *adapter)
 
 static void ixgbe_setup_reta(struct ixgbe_adapter *adapter)
 {
-	u32 i, j;
 	u32 reta_entries = ixgbe_rss_indir_tbl_entries(adapter);
 	u16 rss_i = adapter->ring_feature[RING_F_RSS].indices;
+	u32 i;
 
 	/* Program table for at least 4 queues w/ SR-IOV so that VFs can
 	 * make full use of any rings they may have.  We will use the
@@ -4323,14 +4323,21 @@ static void ixgbe_setup_reta(struct ixgbe_adapter *adapter)
 	/* Fill out hash function seeds */
 	ixgbe_store_key(adapter);
 
-	/* Fill out redirection table */
-	memset(adapter->rss_indir_tbl, 0, sizeof(adapter->rss_indir_tbl));
+	/* Ensure rss_i is non-zero to avoid division by zero */
+	if (!rss_i)
+		rss_i = 1;
 
-	for (i = 0, j = 0; i < reta_entries; i++, j++) {
-		if (j == rss_i)
-			j = 0;
+	/* Update redirection table in memory on first init, queue count change,
+	 * or reta entries change, otherwise preserve user configurations. Then
+	 * always write to hardware.
+	 */
+	if (adapter->last_rss_indices != rss_i ||
+	    adapter->last_reta_entries != reta_entries) {
+		for (i = 0; i < reta_entries; i++)
+			adapter->rss_indir_tbl[i] = i % rss_i;
 
-		adapter->rss_indir_tbl[i] = j;
+		adapter->last_rss_indices = rss_i;
+		adapter->last_reta_entries = reta_entries;
 	}
 
 	ixgbe_store_reta(adapter);
@@ -4338,9 +4345,10 @@ static void ixgbe_setup_reta(struct ixgbe_adapter *adapter)
 
 static void ixgbe_setup_vfreta(struct ixgbe_adapter *adapter)
 {
-	struct ixgbe_hw *hw = &adapter->hw;
+	u32 reta_entries = ixgbe_rss_indir_tbl_entries(adapter);
 	u16 rss_i = adapter->ring_feature[RING_F_RSS].indices;
-	int i, j;
+	struct ixgbe_hw *hw = &adapter->hw;
+	int i;
 
 	/* Fill out hash function seeds */
 	for (i = 0; i < 10; i++) {
@@ -4352,12 +4360,21 @@ static void ixgbe_setup_vfreta(struct ixgbe_adapter *adapter)
 					*(adapter->rss_key + i));
 	}
 
-	/* Fill out the redirection table */
-	for (i = 0, j = 0; i < 64; i++, j++) {
-		if (j == rss_i)
-			j = 0;
+	/* Ensure rss_i is non-zero to avoid division by zero */
+	if (!rss_i)
+		rss_i = 1;
 
-		adapter->rss_indir_tbl[i] = j;
+	/* Update redirection table in memory on first init, queue count change,
+	 * or reta entries change, otherwise preserve user configurations. Then
+	 * always write to hardware.
+	 */
+	if (adapter->last_rss_indices != rss_i ||
+	    adapter->last_reta_entries != reta_entries) {
+		for (i = 0; i < reta_entries; i++)
+			adapter->rss_indir_tbl[i] = i % rss_i;
+
+		adapter->last_rss_indices = rss_i;
+		adapter->last_reta_entries = reta_entries;
 	}
 
 	ixgbe_store_vfreta(adapter);

-- 
2.51.0.rc1.197.g6d975e95c9d7


