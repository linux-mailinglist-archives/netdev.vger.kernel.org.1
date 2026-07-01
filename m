Return-Path: <netdev+bounces-303830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L2qaHKCARWomBQsAu9opvQ
	(envelope-from <netdev+bounces-303830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:03:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DF46F1B9C
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:03:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=nGu8F0MA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303830-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303830-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 343D5300B829
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D003A962E;
	Wed,  1 Jul 2026 21:03:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73653A9DA5
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:03:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939794; cv=none; b=EGcZxz0OlN7Q14olk4IGcV5XE+GJHA1BechSoDRig6tCD31NdOyJff9WWghCGoH16IGrE7O2bfViZdVlqojeayb4GNLIAx6pf4rjIovSQJ1ndQ1jnXzKyAbUmwIexafvUNAE6T8ocM8diLfVWOwMQMO/gEJTrD+r9zkLT3ESHVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939794; c=relaxed/simple;
	bh=ZCHUw7eA0/hN+izxg+UPyFqjIwfFSkdH8DFw6AwKMlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEGNglXMFLfOpPws6wWvhtS6zSPUoNPv6+U3ejwFb+eEfL5PBcD7itSCNaHV+/1LLJhhbQOeCgs6961SotQMW56VH4ZubYHlN2fl4AZJpcKwIZg2UTKbcL93VsE2WcAyzGkYpae5WAel02lLBOYDBneGqh1JYveZIqz1k3zCZKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGu8F0MA; arc=none smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782939792; x=1814475792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZCHUw7eA0/hN+izxg+UPyFqjIwfFSkdH8DFw6AwKMlI=;
  b=nGu8F0MARLovW6Rk4Vha6Elz4ov1xN71vsppjXYK/Wud7AzXpu5EuPai
   5Ov2e1xs/zlgdaRlA4d/4dPXXryO9unHW51gT7ElNRKFnrJBcR83aWxmu
   6cL3ocxsjxTbapJwwyj79q2pNXQhqEHA+Httu0hN4rOeqvJPpHC5pVaAU
   WH9vVikRsiE1/lezfBwvRCK/dpdO7fA/le9mEmnRJcNyIHuBMNj2Khnku
   NVr5Hxf6o0pymBAIX2zfDj8WaCGBf4WA4ZA6GNYV2ke22xBdMAyROMaJJ
   LG1OiNjb6RXUb7XhS46k/e6xHnF2S43J+lEhdlSiM4nehSEypAdK+/NWy
   w==;
X-CSE-ConnectionGUID: +Nfty/sfRU69/0GGMWDAeg==
X-CSE-MsgGUID: kQDKTUIEQt6E5NP36gkE+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="95069104"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="95069104"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 14:03:11 -0700
X-CSE-ConnectionGUID: wxMGdvDKSOOIQslEyLeQww==
X-CSE-MsgGUID: wnVRMWuwQUKr973Bv5/K1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="257561410"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 01 Jul 2026 14:03:10 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Takashi Kozu <takkozu@amazon.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	enjuk@amazon.com,
	kohei.enju@gmail.com,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 04/11] igb: prepare for RSS key get/set support
Date: Wed,  1 Jul 2026 14:02:53 -0700
Message-ID: <20260701210303.1745310-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
References: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303830-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:takkozu@amazon.com,m:anthony.l.nguyen@intel.com,m:horms@kernel.org,m:enjuk@amazon.com,m:kohei.enju@gmail.com,m:piotr.kwapulinski@intel.com,m:aleksandr.loktionov@intel.com,m:sx.rinitha@intel.com,m:andrew@lunn.ch,m:koheienju@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[amazon.com,intel.com,kernel.org,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64DF46F1B9C

From: Takashi Kozu <takkozu@amazon.com>

Store the RSS key inside struct igb_adapter and introduce the
igb_write_rss_key() helper function. This allows the driver to program
the E1000 registers using a persistent RSS key, instead of using a
stack-local buffer in igb_setup_mrqc().

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Takashi Kozu <takkozu@amazon.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h         |  3 +++
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 21 ++++++++++++++++++++
 drivers/net/ethernet/intel/igb/igb_main.c    |  8 ++++----
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 0fff1df81b7b..8c9b02058cec 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -495,6 +495,7 @@ struct hwmon_buff {
 #define IGB_N_PEROUT	2
 #define IGB_N_SDP	4
 #define IGB_RETA_SIZE	128
+#define IGB_RSS_KEY_SIZE	40
 
 enum igb_filter_match_flags {
 	IGB_FILTER_FLAG_ETHER_TYPE = 0x1,
@@ -655,6 +656,7 @@ struct igb_adapter {
 	struct i2c_client *i2c_client;
 	u32 rss_indir_tbl_init;
 	u8 rss_indir_tbl[IGB_RETA_SIZE];
+	u8 rss_key[IGB_RSS_KEY_SIZE];
 
 	unsigned long link_check_timeout;
 	int copper_tries;
@@ -735,6 +737,7 @@ void igb_down(struct igb_adapter *);
 void igb_reinit_locked(struct igb_adapter *);
 void igb_reset(struct igb_adapter *);
 int igb_reinit_queues(struct igb_adapter *);
+void igb_write_rss_key(struct igb_adapter *adapter);
 void igb_write_rss_indir_tbl(struct igb_adapter *);
 int igb_set_spd_dplx(struct igb_adapter *, u32, u8);
 int igb_setup_tx_resources(struct igb_ring *);
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index f7938c1da835..9a105e59f432 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3019,6 +3019,27 @@ static int igb_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	return ret;
 }
 
+/**
+ * igb_write_rss_key - Program the RSS key into device registers
+ * @adapter: board private structure
+ *
+ * Write the RSS key stored in adapter->rss_key to the E1000 hardware registers.
+ * Each 32-bit chunk of the key is read using get_unaligned_le32() and written
+ * to the appropriate register.
+ */
+void igb_write_rss_key(struct igb_adapter *adapter)
+{
+	struct e1000_hw *hw = &adapter->hw;
+
+	ASSERT_RTNL();
+
+	for (int i = 0; i < IGB_RSS_KEY_SIZE / 4; i++) {
+		u32 val = get_unaligned_le32(&adapter->rss_key[i * 4]);
+
+		wr32(E1000_RSSRK(i), val);
+	}
+}
+
 static int igb_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a1e89a375744..b7d36dd0b8e4 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4048,6 +4048,9 @@ static int igb_sw_init(struct igb_adapter *adapter)
 
 	pci_read_config_word(pdev, PCI_COMMAND, &hw->bus.pci_cmd_word);
 
+	/* init RSS key */
+	netdev_rss_key_fill(adapter->rss_key, sizeof(adapter->rss_key));
+
 	/* set default ring sizes */
 	adapter->tx_ring_count = IGB_DEFAULT_TXD;
 	adapter->rx_ring_count = IGB_DEFAULT_RXD;
@@ -4522,11 +4525,8 @@ static void igb_setup_mrqc(struct igb_adapter *adapter)
 	struct e1000_hw *hw = &adapter->hw;
 	u32 mrqc, rxcsum;
 	u32 j, num_rx_queues;
-	u32 rss_key[10];
 
-	netdev_rss_key_fill(rss_key, sizeof(rss_key));
-	for (j = 0; j < 10; j++)
-		wr32(E1000_RSSRK(j), rss_key[j]);
+	igb_write_rss_key(adapter);
 
 	num_rx_queues = adapter->rss_queues;
 
-- 
2.47.1


