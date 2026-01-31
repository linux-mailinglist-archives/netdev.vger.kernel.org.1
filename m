Return-Path: <netdev+bounces-255458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIQyGUoufmlLWQIAu9opvQ
	(envelope-from <netdev+bounces-255458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:31:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAF6C301E
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DF4630091CC
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 16:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7CE33C19A;
	Sat, 31 Jan 2026 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="tswXrpId"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F17328B56
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769877058; cv=none; b=qwKjHQ8N3kSe0TgAoAJjf5GBL7eIG8zAQsu6PogaV5ZbesP/kwV9zVZzi95ag3R5qMxnY9euoluFxb0YWpLotn7HiGp9JwBKm49SsDMaXmMN9H51mQeN0jC5lxYhBMgsMzizlEUdHf1XACgWsgBFKhMOFhJ3/6o7xfEXlTc0k7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769877058; c=relaxed/simple;
	bh=bsF4MWdS/mvtf8kkXk66PIdcw+5uB+VYsChcAgHVyvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxU/fT0z5NtqPAeXOzgIqHN+PNpMoYHn/9V9tEqDfPdo+C1SvqXBGZGepi9RHZuJmSvDNm3wISvU0/z61LEOsUUkT0eefST+I8f59X8Frc7LulTRflj+bEWY0gibKBovM84ues3dxpjHw2Zkdx+dyyPYzUi1iCI7Wj0b+esI8UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=tswXrpId; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (248.212.13.160.dy.iij4u.or.jp [160.13.212.248])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60VGUsmQ039327
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 1 Feb 2026 01:30:54 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=WYHECLqIowuumL8zjbgitFuB0m6Aqj/Lu6CHXxY5A6k=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1769877054; v=1;
        b=tswXrpIdKGoR5Oynz75znwQLqbFYzIefazHttza7Q9yI7dDxITO18a03ODDo/WFX
         2r1KKtUoHCmzKN5b8VJfNHF+X1jGPm5C4uClkDPZ5vpHkEBQkbe8zVUiJ/biEv/9
         8kn5lYOTfZCjsXENCqBwrlxVuBYaZMnKph0TXyCkKHwcedLWwEsUfqzh3BZLnzdr
         TQOT4f8L9wGUSYt8xvzlNVRIa9w+YIS2cA+8cxjiQ5ZdCDRvvVg+PK2EgKcg80yd
         wNyAz4w/uvj2ojHP8CB+6VokNVPtiEnViUX55gJJ+uyNLUE23iphFx/9Pdu30adz
         aI8HWyQOzoaMV3zJPqcQaA==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vitaly Lifshits <vitaly.lifshits@intel.com>,
        Simon Horman <horms@kernel.org>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH v2 iwl-next 1/3] igc: prepare for RSS key get/set support
Date: Sat, 31 Jan 2026 16:29:36 +0000
Message-ID: <20260131163037.88108-2-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131163037.88108-1-kohei@enjuk.jp>
References: <20260131163037.88108-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,enjuk.jp];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-255458-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,enjuk.jp:email,enjuk.jp:dkim,enjuk.jp:mid]
X-Rspamd-Queue-Id: 7EAF6C301E
X-Rspamd-Action: no action

Store the RSS key inside struct igc_adapter and introduce the
igc_write_rss_key() helper function. This allows the driver to program
the RSSRK registers using a persistent RSS key, instead of using a
stack-local buffer in igc_setup_mrqc().

This is a preparation patch for adding RSS key get/set support in
subsequent changes, and no functional change is intended in this patch.

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/igc/igc.h         |  3 +++
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 20 ++++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_main.c    |  8 ++++----
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index a427f05814c1..dd159397d191 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -30,6 +30,7 @@ void igc_ethtool_set_ops(struct net_device *);
 
 #define MAX_ETYPE_FILTER		8
 #define IGC_RETA_SIZE			128
+#define IGC_RSS_KEY_SIZE		40
 
 /* SDP support */
 #define IGC_N_EXTTS	2
@@ -302,6 +303,7 @@ struct igc_adapter {
 	unsigned int nfc_rule_count;
 
 	u8 rss_indir_tbl[IGC_RETA_SIZE];
+	u8 rss_key[IGC_RSS_KEY_SIZE];
 
 	unsigned long link_check_timeout;
 	struct igc_info ei;
@@ -360,6 +362,7 @@ unsigned int igc_get_max_rss_queues(struct igc_adapter *adapter);
 void igc_set_flag_queue_pairs(struct igc_adapter *adapter,
 			      const u32 max_rss_queues);
 int igc_reinit_queues(struct igc_adapter *adapter);
+void igc_write_rss_key(struct igc_adapter *adapter);
 void igc_write_rss_indir_tbl(struct igc_adapter *adapter);
 bool igc_has_link(struct igc_adapter *adapter);
 void igc_reset(struct igc_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 3172cdbca9cc..1b4075e7e8e6 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1460,6 +1460,26 @@ static int igc_ethtool_set_rxnfc(struct net_device *dev,
 	}
 }
 
+/**
+ * igc_write_rss_key - Program the RSS key into device registers
+ * @adapter: board private structure
+ *
+ * Write the RSS key stored in adapter->rss_key to the IGC_RSSRK registers.
+ * Each 32-bit chunk of the key is read using get_unaligned_le32() and written
+ * to the appropriate register.
+ */
+void igc_write_rss_key(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 val;
+	int i;
+
+	for (i = 0; i < IGC_RSS_KEY_SIZE / 4; i++) {
+		val = get_unaligned_le32(&adapter->rss_key[i * 4]);
+		wr32(IGC_RSSRK(i), val);
+	}
+}
+
 void igc_write_rss_indir_tbl(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 89a321a344d2..98410f9d7828 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -778,11 +778,8 @@ static void igc_setup_mrqc(struct igc_adapter *adapter)
 	struct igc_hw *hw = &adapter->hw;
 	u32 j, num_rx_queues;
 	u32 mrqc, rxcsum;
-	u32 rss_key[10];
 
-	netdev_rss_key_fill(rss_key, sizeof(rss_key));
-	for (j = 0; j < 10; j++)
-		wr32(IGC_RSSRK(j), rss_key[j]);
+	igc_write_rss_key(adapter);
 
 	num_rx_queues = adapter->rss_queues;
 
@@ -5046,6 +5043,9 @@ static int igc_sw_init(struct igc_adapter *adapter)
 
 	pci_read_config_word(pdev, PCI_COMMAND, &hw->bus.pci_cmd_word);
 
+	/* init RSS key */
+	netdev_rss_key_fill(adapter->rss_key, sizeof(adapter->rss_key));
+
 	/* set default ring sizes */
 	adapter->tx_ring_count = IGC_DEFAULT_TXD;
 	adapter->rx_ring_count = IGC_DEFAULT_RXD;
-- 
2.51.0


