Return-Path: <netdev+bounces-199709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36523AE1892
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A4C67AB949
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113B0285411;
	Fri, 20 Jun 2025 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VhuKr3vl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33234285412;
	Fri, 20 Jun 2025 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750413815; cv=none; b=BSTf+kr7Vzccg+Wmy8rumh1F1R7UwX2fGSvdVwbcXZmSD983YAsBMQpNy4TC8QDFip1ZY54X01bspm2kqv8ZLv8b8dicNm0QvZVlN/gKztt5LgVHaiohmr+wwInBVC/UbPmuJ8hr2JwnVm4FCCRJfBL8dcv3TeRzVVueLMTktuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750413815; c=relaxed/simple;
	bh=dYyBprBnixwR53Tfm/dKtWJm68UzW+gDxVTIxJUHFZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SDm899w2b+PVMj/llohRrri6S55bfPWp4e8mzkYEFdZnbumGL2Xu8CqIO1UD1Dh83mLPhkES75b6fQqe5Ax7PhMKkxsaOD+1SVecpfFxTbBWheoHQqkDmZit8PplVpXgyT8Nz5Lpf5tZop1PMS/o/aT16vM1isu4oSM/PHnJljU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VhuKr3vl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750413813; x=1781949813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dYyBprBnixwR53Tfm/dKtWJm68UzW+gDxVTIxJUHFZQ=;
  b=VhuKr3vlo4Y3gWngIg4OuD7KddlZDssiFGu5S9h/jOiq+YVYVUg7b3tl
   llv+myC9emrM2t0l9EWIr8iPUT/WhKpA51cht0NII1YgC08v4Bmey+n63
   IO0kytr09HXlqt6YxEa7VlcKCr0bx18e3WHtUtKCktMf2P6tMIhkd6zb+
   BfJWb+7ck/y3s7E41b98V9N0IhYmXKTNtVSs23EVLD/xi0lIovBbtYn7Z
   9EdXM/Svygi1zDLd2vOWJTlX6TlephTSbwnUGamDB2L6Yv16uytBtKss5
   2lbdA6/Xre8uFnRKt7Wq9tH7a4SddKSo+SGyo7JQ59pUn6itG5AvnbhNc
   g==;
X-CSE-ConnectionGUID: i5xz8RcNRSS7NIaCXVPDYw==
X-CSE-MsgGUID: oOPLMc1PRlaU8ea5TtxysA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52817128"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="52817128"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 03:03:33 -0700
X-CSE-ConnectionGUID: yTN32KeyTZGyDUAArqSApA==
X-CSE-MsgGUID: IpfS2IKxSlSThBWGDenFgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="181744802"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by fmviesa001.fm.intel.com with ESMTP; 20 Jun 2025 03:03:27 -0700
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Brett Creeley <bcreeley@amd.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next,v3 2/2] igc: Add wildcard rule support to ethtool NFC using Default Queue
Date: Fri, 20 Jun 2025 18:02:51 +0800
Message-Id: <20250620100251.2791202-3-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620100251.2791202-1-yoong.siang.song@intel.com>
References: <20250620100251.2791202-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for a lowest priority wildcard (catch-all) rule in
ethtool's Network Flow Classification (NFC) for the igc driver. The
wildcard rule directs all unmatched network traffic, including traffic not
captured by Receive Side Scaling (RSS), to a specified queue. This
functionality utilizes the Default Queue feature available in I225/I226
hardware.

The implementation has been validated on Intel ADL-S systems with two
back-to-back connected I226 network interfaces.

Testing Procedure:
1. On the Device Under Test (DUT), verify the initial statistic:
   $ ethtool -S enp1s0 | grep rx_q.*packets
        rx_queue_0_packets: 0
        rx_queue_1_packets: 0
        rx_queue_2_packets: 0
        rx_queue_3_packets: 0

2. From the Link Partner, send 10 ARP packets:
   $ arping -c 10 -I enp170s0 169.254.1.2

3. On the DUT, verify the packet reception on Queue 0:
   $ ethtool -S enp1s0 | grep rx_q.*packets
        rx_queue_0_packets: 10
        rx_queue_1_packets: 0
        rx_queue_2_packets: 0
        rx_queue_3_packets: 0

4. On the DUT, add a wildcard rule to route all packets to Queue 3:
   $ sudo ethtool -N enp1s0 flow-type ether queue 3

5. From the Link Partner, send another 10 ARP packets:
   $ arping -c 10 -I enp170s0 169.254.1.2

6. Now, packets are routed to Queue 3 by the wildcard (Default Queue) rule:
   $ ethtool -S enp1s0 | grep rx_q.*packets
        rx_queue_0_packets: 10
        rx_queue_1_packets: 0
        rx_queue_2_packets: 0
        rx_queue_3_packets: 10

7. On the DUT, add a EtherType rule to route ARP packet to Queue 1:
   $ sudo ethtool -N enp1s0 flow-type ether proto 0x0806 queue 1

8. From the Link Partner, send another 10 ARP packets:
   $ arping -c 10 -I enp170s0 169.254.1.2

9. Now, packets are routed to Queue 1 by the EtherType rule because it is
   higher priority than the wildcard (Default Queue) rule:
   $ ethtool -S enp1s0 | grep rx_q.*packets
        rx_queue_0_packets: 10
        rx_queue_1_packets: 10
        rx_queue_2_packets: 0
        rx_queue_3_packets: 10

10. On the DUT, delete all the NFC rules:
    $ sudo ethtool -N enp1s0 delete 63
    $ sudo ethtool -N enp1s0 delete 64

11. From the Link Partner, send another 10 ARP packets:
    $ arping -c 10 -I enp170s0 169.254.1.2

12. Now, packets are routed to Queue 0 because the value of Default Queue
    is reset back to 0:
    $ ethtool -S enp1s0 | grep rx_q.*packets
         rx_queue_0_packets: 20
         rx_queue_1_packets: 10
         rx_queue_2_packets: 0
         rx_queue_3_packets: 10

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Co-developed-by: Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>
Signed-off-by: Blanco Alcaine Hector <hector.blanco.alcaine@intel.com>
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         | 11 +++++++---
 drivers/net/ethernet/intel/igc/igc_defines.h |  1 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 18 ++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_main.c    | 22 ++++++++++++++++++++
 4 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 0b35e593d5ee..c580ecc954be 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -631,6 +631,7 @@ enum igc_filter_match_flags {
 	IGC_FILTER_FLAG_DST_MAC_ADDR =	BIT(3),
 	IGC_FILTER_FLAG_USER_DATA =	BIT(4),
 	IGC_FILTER_FLAG_VLAN_ETYPE =	BIT(5),
+	IGC_FILTER_FLAG_DEFAULT_QUEUE = BIT(6),
 };
 
 struct igc_nfc_filter {
@@ -658,10 +659,14 @@ struct igc_nfc_rule {
 	bool flex;
 };
 
-/* IGC supports a total of 32 NFC rules: 16 MAC address based, 8 VLAN priority
- * based, 8 ethertype based and 32 Flex filter based rules.
+/* IGC supports a total of 65 NFC rules, listed below in order of priority:
+ *  - 16 MAC address based filtering rules (highest priority)
+ *  - 8 ethertype based filtering rules
+ *  - 32 Flex filter based filtering rules
+ *  - 8 VLAN priority based filtering rules
+ *  - 1 default queue rule (lowest priority)
  */
-#define IGC_MAX_RXNFC_RULES		64
+#define IGC_MAX_RXNFC_RULES		65
 
 struct igc_flex_filter {
 	u8 index;
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index d80254f2a278..498ba1522ca4 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -391,6 +391,7 @@
 #define IGC_MRQC_RSS_FIELD_IPV6_TCP	0x00200000
 #define IGC_MRQC_RSS_FIELD_IPV4_UDP	0x00400000
 #define IGC_MRQC_RSS_FIELD_IPV6_UDP	0x00800000
+#define IGC_MRQC_DEFAULT_QUEUE_MASK	GENMASK(5, 3)
 
 /* Header split receive */
 #define IGC_RFCTL_IPV6_EX_DIS	0x00010000
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index a7f397b58cd6..ecb35b693ce5 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1283,6 +1283,24 @@ static void igc_ethtool_init_nfc_rule(struct igc_nfc_rule *rule,
 		rule->flex = true;
 	else
 		rule->flex = false;
+
+	/* The wildcard rule is only applied if:
+	 *  a) None of the other filtering rules match (match_flags is zero)
+	 *  b) The flow type is ETHER_FLOW only (no additional fields set)
+	 *  c) Mask for Source MAC address is not specified (all zeros)
+	 *  d) Mask for Destination MAC address is not specified (all zeros)
+	 *  e) Mask for L2 EtherType is not specified (zero)
+	 *
+	 * If all these conditions are met, the rule is treated as a wildcard
+	 * rule. Default queue feature will be used, so that all packets that do
+	 * not match any other rule will be routed to the default queue.
+	 */
+	if (!rule->filter.match_flags &&
+	    fsp->flow_type == ETHER_FLOW &&
+	    is_zero_ether_addr(fsp->m_u.ether_spec.h_source) &&
+	    is_zero_ether_addr(fsp->m_u.ether_spec.h_dest) &&
+	    !fsp->m_u.ether_spec.h_proto)
+		rule->filter.match_flags = IGC_FILTER_FLAG_DEFAULT_QUEUE;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2e12915b42a9..87311ea47018 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3874,6 +3874,22 @@ static void igc_del_flex_filter(struct igc_adapter *adapter,
 	wr32(IGC_WUFC, wufc);
 }
 
+static void igc_set_default_queue_filter(struct igc_adapter *adapter, u32 queue)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 mrqc = rd32(IGC_MRQC);
+
+	mrqc &= ~IGC_MRQC_DEFAULT_QUEUE_MASK;
+	mrqc |= FIELD_PREP(IGC_MRQC_DEFAULT_QUEUE_MASK, queue);
+	wr32(IGC_MRQC, mrqc);
+}
+
+static void igc_reset_default_queue_filter(struct igc_adapter *adapter)
+{
+	/* Reset the default queue to its default value which is Queue 0 */
+	igc_set_default_queue_filter(adapter, 0);
+}
+
 static int igc_enable_nfc_rule(struct igc_adapter *adapter,
 			       struct igc_nfc_rule *rule)
 {
@@ -3912,6 +3928,9 @@ static int igc_enable_nfc_rule(struct igc_adapter *adapter,
 			return err;
 	}
 
+	if (rule->filter.match_flags & IGC_FILTER_FLAG_DEFAULT_QUEUE)
+		igc_set_default_queue_filter(adapter, rule->action);
+
 	return 0;
 }
 
@@ -3939,6 +3958,9 @@ static void igc_disable_nfc_rule(struct igc_adapter *adapter,
 	if (rule->filter.match_flags & IGC_FILTER_FLAG_DST_MAC_ADDR)
 		igc_del_mac_filter(adapter, IGC_MAC_FILTER_TYPE_DST,
 				   rule->filter.dst_addr);
+
+	if (rule->filter.match_flags & IGC_FILTER_FLAG_DEFAULT_QUEUE)
+		igc_reset_default_queue_filter(adapter);
 }
 
 /**
-- 
2.34.1


