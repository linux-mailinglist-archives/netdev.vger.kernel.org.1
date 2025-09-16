Return-Path: <netdev+bounces-223697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E88B5A13A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717EF1C02C93
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 19:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B298316905;
	Tue, 16 Sep 2025 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvVTxrqe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856A02F5A0D;
	Tue, 16 Sep 2025 19:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758050219; cv=none; b=MU9m6T1qBBcCqNpzgzi6mLf/6lZFkbyLWhIy+7P4ZCzDsjaUcKTcWljxBYTHzWf1LeaTXxZa7eHxaGG6NdbeOEU/dzQMAwvG3v6mfTH6dozWcxvWI4Rz+XFAHDoWr7Yh3QXs9dg0go3G8K9wS/jOxUlZyF7TC1LqmTosyiapGHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758050219; c=relaxed/simple;
	bh=UATtTNQzoabKuQM/6vY2vzTps6UhIUpgfFktUIIOqaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iDY7ITxpyGEhSO4BdYrtK42VkLPj7jQhRR04tkTWzWEyHSKcC46t9VxRxmT5cpKTklD21U8JJbHRtvpPR3lz4YcTXniEsmj/cK1lLGUFU4Dxpj5Bi9/I0N7+C17Q6nEqYs6yllLkS2A9Z0ZzHil9ZhhgDqU9NkDXovmFaqWCZM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KvVTxrqe; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758050217; x=1789586217;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=UATtTNQzoabKuQM/6vY2vzTps6UhIUpgfFktUIIOqaQ=;
  b=KvVTxrqe2htI1Trcm+RLke+nG8Zr1wdA2pHT673ZmRXSlERRzLwE8eeZ
   fxQHF7DCivQjTyxBkEmSE2yAshSauNkhmyym5ZAQlep17fZQ5mRtikgrs
   so7RgDpR5Ea/vt2fme+VkzdFdMhTZsMPK8UFQLynnEyasNQMWYNfgH07i
   1rICXsNBzb+DS4tYLGf0U4CMdo2jzMCxKh6mBcVs/3hDFYKsA96CshR4n
   pQT0+x0sPBLDDcZDGSP1d3l3V6Fa7R05VjCb3HjMyzW7y387Tvu9TGwDe
   QqPQIeXsocZxQgHNXEQSvuWbc4XG+w8i6xN0+M3czfs5k2kb2OdHuwWiO
   g==;
X-CSE-ConnectionGUID: uX7rLUjBQJ2tFCZpBq0lXw==
X-CSE-MsgGUID: n+8Q9DV9TkCZ7VxU3bt0rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60037604"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="60037604"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 12:16:55 -0700
X-CSE-ConnectionGUID: YyawpJIJQFWiFuOnXXwbiQ==
X-CSE-MsgGUID: ruwDdXVqQtiIgQwl+pbp5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174961773"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 12:16:55 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 16 Sep 2025 12:14:58 -0700
Subject: [PATCH iwl-next v4 5/5] ice: refactor to use helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-resend-jbrandeb-ice-standard-stats-v4-5-ec198614c738@intel.com>
References: <20250916-resend-jbrandeb-ice-standard-stats-v4-0-ec198614c738@intel.com>
In-Reply-To: <20250916-resend-jbrandeb-ice-standard-stats-v4-0-ec198614c738@intel.com>
To: Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Jakub Kicinski <kuba@kernel.org>, Hariprasad Kelam <hkelam@marvell.com>, 
 Simon Horman <horms@kernel.org>, 
 Marcin Szycik <marcin.szycik@linux.intel.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, netdev@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org, corbet@lwn.net, 
 Jacob Keller <jacob.e.keller@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 jbrandeburg@cloudflare.com
X-Mailer: b4 0.15-dev-cbe0e
X-Developer-Signature: v=1; a=openpgp-sha256; l=11409;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=A10gTwzw8UAmR4U3sxzOasO0Vo16YSPxlv82FPThXgc=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoyT25eozfzG7p97ZlVzQe+koElqIraGXcfuWDAc9LPVP
 Xa78ujljlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACbyIoPhnynP0ukdCdvXfVPg
 PbW185Xi/Ovv3Nf9i54hJ5p9XOGQzGFGhp/C/jM8U2c0G955zy0dvSPh8oR1RU5MRUkuqRtWTpp
 wnBkA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Use the ice_netdev_to_pf() helper in more places and remove a bunch of
boilerplate code. Not every instance could be replaced due to use of the
netdev_priv() output or the vsi variable within a bunch of functions.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c   | 48 ++++++++------------------
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c |  8 ++---
 drivers/net/ethernet/intel/ice/ice_lag.c       |  3 +-
 drivers/net/ethernet/intel/ice/ice_main.c      | 10 ++----
 drivers/net/ethernet/intel/ice/ice_ptp.c       |  6 ++--
 drivers/net/ethernet/intel/ice/ice_sriov.c     |  3 +-
 6 files changed, 24 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index f8bb2d55b28c..0b99a7b863d8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -794,8 +794,7 @@ static int ice_get_extended_regs(struct net_device *netdev, void *p)
 static void
 ice_get_regs(struct net_device *netdev, struct ethtool_regs *regs, void *p)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_hw *hw = &pf->hw;
 	u32 *regs_buf = (u32 *)p;
 	unsigned int i;
@@ -810,8 +809,7 @@ ice_get_regs(struct net_device *netdev, struct ethtool_regs *regs, void *p)
 
 static u32 ice_get_msglevel(struct net_device *netdev)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
 #ifndef CONFIG_DYNAMIC_DEBUG
 	if (pf->hw.debug_mask)
@@ -824,8 +822,7 @@ static u32 ice_get_msglevel(struct net_device *netdev)
 
 static void ice_set_msglevel(struct net_device *netdev, u32 data)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
 #ifndef CONFIG_DYNAMIC_DEBUG
 	if (ICE_DBG_USER & data)
@@ -840,16 +837,14 @@ static void ice_set_msglevel(struct net_device *netdev, u32 data)
 static void ice_get_link_ext_stats(struct net_device *netdev,
 				   struct ethtool_link_ext_stats *stats)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
 	stats->link_down_events = pf->link_down_events;
 }
 
 static int ice_get_eeprom_len(struct net_device *netdev)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
 	return (int)pf->hw.flash.flash_size;
 }
@@ -858,9 +853,7 @@ static int
 ice_get_eeprom(struct net_device *netdev, struct ethtool_eeprom *eeprom,
 	       u8 *bytes)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_vsi *vsi = np->vsi;
-	struct ice_pf *pf = vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_hw *hw = &pf->hw;
 	struct device *dev;
 	int ret;
@@ -959,8 +952,7 @@ static u64 ice_link_test(struct net_device *netdev)
  */
 static u64 ice_eeprom_test(struct net_device *netdev)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
 	netdev_info(netdev, "EEPROM test\n");
 	return !!(ice_nvm_validate_checksum(&pf->hw));
@@ -1277,9 +1269,8 @@ static int ice_lbtest_receive_frames(struct ice_rx_ring *rx_ring)
  */
 static u64 ice_loopback_test(struct net_device *netdev)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_vsi *orig_vsi = np->vsi, *test_vsi;
-	struct ice_pf *pf = orig_vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
+	struct ice_vsi *test_vsi;
 	u8 *tx_frame __free(kfree) = NULL;
 	u8 broadcast[ETH_ALEN], ret = 0;
 	int num_frames, valid_frames;
@@ -1368,8 +1359,7 @@ static u64 ice_loopback_test(struct net_device *netdev)
  */
 static u64 ice_intr_test(struct net_device *netdev)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	u16 swic_old = pf->sw_int_count;
 
 	netdev_info(netdev, "interrupt test\n");
@@ -1397,9 +1387,8 @@ static void
 ice_self_test(struct net_device *netdev, struct ethtool_test *eth_test,
 	      u64 *data)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	bool if_running = netif_running(netdev);
-	struct ice_pf *pf = np->vsi->back;
 	struct device *dev;
 
 	dev = ice_pf_to_dev(pf);
@@ -1723,9 +1712,7 @@ static int ice_nway_reset(struct net_device *netdev)
  */
 static u32 ice_get_priv_flags(struct net_device *netdev)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_vsi *vsi = np->vsi;
-	struct ice_pf *pf = vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	u32 i, ret_flags = 0;
 
 	for (i = 0; i < ICE_PRIV_FLAG_ARRAY_SIZE; i++) {
@@ -4413,9 +4400,7 @@ static int
 ice_get_module_info(struct net_device *netdev,
 		    struct ethtool_modinfo *modinfo)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_vsi *vsi = np->vsi;
-	struct ice_pf *pf = vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_hw *hw = &pf->hw;
 	u8 sff8472_comp = 0;
 	u8 sff8472_swap = 0;
@@ -4487,12 +4472,10 @@ static int
 ice_get_module_eeprom(struct net_device *netdev,
 		      struct ethtool_eeprom *ee, u8 *data)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 #define SFF_READ_BLOCK_SIZE 8
 	u8 value[SFF_READ_BLOCK_SIZE] = { 0 };
 	u8 addr = ICE_I2C_EEPROM_DEV_ADDR;
-	struct ice_vsi *vsi = np->vsi;
-	struct ice_pf *pf = vsi->back;
 	struct ice_hw *hw = &pf->hw;
 	bool is_sfp = false;
 	unsigned int i, j;
@@ -4768,8 +4751,7 @@ static void ice_get_ts_stats(struct net_device *netdev,
  */
 static int ice_ethtool_reset(struct net_device *dev, u32 *flags)
 {
-	struct ice_netdev_priv *np = netdev_priv(dev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(dev);
 	enum ice_reset_req reset;
 
 	switch (*flags) {
diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index fc94e189e52e..c2caee083ca7 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -574,9 +574,7 @@ ice_destroy_tunnel(struct ice_hw *hw, u16 index, enum ice_tunnel_type type,
 int ice_udp_tunnel_set_port(struct net_device *netdev, unsigned int table,
 			    unsigned int idx, struct udp_tunnel_info *ti)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_vsi *vsi = np->vsi;
-	struct ice_pf *pf = vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	enum ice_tunnel_type tnl_type;
 	int status;
 	u16 index;
@@ -598,9 +596,7 @@ int ice_udp_tunnel_set_port(struct net_device *netdev, unsigned int table,
 int ice_udp_tunnel_unset_port(struct net_device *netdev, unsigned int table,
 			      unsigned int idx, struct udp_tunnel_info *ti)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_vsi *vsi = np->vsi;
-	struct ice_pf *pf = vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	enum ice_tunnel_type tnl_type;
 	int status;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index aebf8e08a297..d2576d606e10 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -2177,8 +2177,7 @@ static void ice_lag_chk_disabled_bond(struct ice_lag *lag, void *ptr)
  */
 static void ice_lag_disable_sriov_bond(struct ice_lag *lag)
 {
-	struct ice_netdev_priv *np = netdev_priv(lag->netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(lag->netdev);
 
 	ice_clear_feature_support(pf, ICE_F_SRIOV_LAG);
 	ice_clear_feature_support(pf, ICE_F_SRIOV_AA_LAG);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 249fd3c050eb..9994a9479082 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8043,9 +8043,7 @@ static int
 ice_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 		   struct net_device *dev, u32 filter_mask, int nlflags)
 {
-	struct ice_netdev_priv *np = netdev_priv(dev);
-	struct ice_vsi *vsi = np->vsi;
-	struct ice_pf *pf = vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(dev);
 	u16 bmode;
 
 	bmode = pf->first_sw->bridge_mode;
@@ -8115,8 +8113,7 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 		   u16 __always_unused flags,
 		   struct netlink_ext_ack __always_unused *extack)
 {
-	struct ice_netdev_priv *np = netdev_priv(dev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(dev);
 	struct nlattr *attr, *br_spec;
 	struct ice_hw *hw = &pf->hw;
 	struct ice_sw *pf_sw;
@@ -9550,8 +9547,7 @@ ice_indr_setup_tc_cb(struct net_device *netdev, struct Qdisc *sch,
  */
 int ice_open(struct net_device *netdev)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
 	if (ice_is_reset_in_progress(pf->state)) {
 		netdev_err(netdev, "can't open net device while reset is in progress");
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index d2ca9d7bcfc1..9b9b408c0adb 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2244,8 +2244,7 @@ static int ice_ptp_getcrosststamp(struct ptp_clock_info *info,
 int ice_ptp_hwtstamp_get(struct net_device *netdev,
 			 struct kernel_hwtstamp_config *config)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
 	if (pf->ptp.state != ICE_PTP_READY)
 		return -EIO;
@@ -2316,8 +2315,7 @@ int ice_ptp_hwtstamp_set(struct net_device *netdev,
 			 struct kernel_hwtstamp_config *config,
 			 struct netlink_ext_ack *extack)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	int err;
 
 	if (pf->ptp.state != ICE_PTP_READY)
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 843e82fd3bf9..6b1126ddb561 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1190,8 +1190,7 @@ ice_vf_lan_overflow_event(struct ice_pf *pf, struct ice_rq_event_info *event)
  */
 int ice_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool ena)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_vsi *vf_vsi;
 	struct device *dev;
 	struct ice_vf *vf;

-- 
2.51.0.rc1.197.g6d975e95c9d7


