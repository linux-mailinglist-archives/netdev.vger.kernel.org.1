Return-Path: <netdev+bounces-295125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R7PzBkxAIWrgBwEAu9opvQ
	(envelope-from <netdev+bounces-295125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:07:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7A463E584
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:07:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295125-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295125-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B20403129D2B
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8113F0AA4;
	Thu,  4 Jun 2026 08:57:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F08A3D6CAE
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 08:57:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563475; cv=none; b=NmS1JUHG5Is5x3zB5KEHnN1kXxu5zr82MNmtROZK/J6F/yCVqJIKFYJ6A5+wEcPL4noF8c54CFhK5fMxu3zD/JtOWdz5OAsp9I18GEJTUvEtDiYALmJbtlyPd6b2S6BG4ofxrbydWeBQYiMJBdxFshlYxPiU9F5lzUi/zhrtDRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563475; c=relaxed/simple;
	bh=PYr35FbpHPXKcZ2Eh4OIErQbovQVhDS4Fjg56y1ULmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FFAwS6T3fTFQT8Pj9Tijie0qi8zcRw7uF2+d3V+vKP0AwzjT1uzvgojjOf4XH1MRleZgkbrpZ93fxWbLbRR+wRJwVfrxP97nx38QVmpd6BObj7EgkRLVdkwXzUBNB7HGay3G9IoQ74CwJFltAnK9GJqoQ4PxHPvtaKx0wN/VsO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
X-QQ-mid: zesmtpsz9t1780563420t36d094ec
X-QQ-Originating-IP: u4uooeoUVi83SttJ5ApXM64QhEzJVZ6YUErMJb2lMY0=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.207.111])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Jun 2026 16:56:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2424792223360520790
EX-QQ-RecipientCnt: 22
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v5 5/5] net: wangxun: add pcie error handler
Date: Thu,  4 Jun 2026 16:56:31 +0800
Message-Id: <20260604085631.12720-6-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260604085631.12720-1-jiawenwu@trustnetic.com>
References: <20260604085631.12720-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OYYBGyz9w/VIPx5jJiO3zi2xW0ZrQ3ITUJ9xTtB3wQ9Isf1wRjST+4YB
	ZEP0x0JFaCyP9HDAB10p7KSrl8MZ3oFcn2Labm4T33y3mFPQ5pHKnZryA7AcJpTbWSdhW9M
	yZ5IecVv0W2EnUNnUmSMyMz3WhTIgWEOVyAt8BlrdiCNQD+I15PMql2A/fo1F2v7dioNxns
	eLfvIoG3AewmAmOim2N4KJXS99kzHYu3wYu57saFpUo6koMLdXE+0t0k8RTd3Bg1Nz//NaA
	Fv2Xr5ecSoJDdJXD9PRnU5U0rvdBQsX8rLoVP75s/XwqQieG+NodStvDpDNk3ViRmtMvhzN
	c7ExRJKnhIWKBF1eK4e/urw3dmYVh9ySJW7WXumlRzNf5UMuVGODgssFHeCfs+SAu3sTcoP
	TpW0ES0lOCgjjse4CeezLUR6YyveL9cIeHZZL8RvAg1YsCAIaIukz6InbkbD8boOIeuVBa8
	SJzdEw1upygsIX8X7UpnSqAA2sbQPBcLaN8JPvOM1DfscU/BFPsqCS4JCXs8cjyvCa0TKTa
	T5Q1iDV2aoLWVgpyfE6oY5G9GlsMZkBx/ascFOL8OnHTVOvGWrV7mbC/0J29vdSWsKXl3B2
	pI0DjFCXmpnAu3FUxEpHKOP1L4Vub0arlyihJRTwgMPZAboPjR6VTqGYHITDydpn4dP2VFN
	4p8HyHaPGUyLiN1IO6M6mi5B/apoIGhI4001aapJTrsv1/2o+/0cmt4XtWFLpYYbKxy6by2
	YViLDV/hKGvK5a9UIdeffQgg1cuh65vwHnbdYv+p4eXNmmEZd+y1+idOXgKdi7fM0otXAIX
	tCYd5J7TgvQc/vdFvzMXPqR0tfuiYfZO9DapVnqpX1Uqu0oAfGuvz2A09aomk6A4YYP3VVd
	J/JpBBuJxlWpmlx8HG0KYX2s7Xs6Z49gIa6YG5qFHu+wy8rC0fMOFa3Cc6DGli9xMYxaJlX
	fxTlrkGeJPxEdaFglCWchZR+2UCg/oFz8dDv2T3Z3uKQLT4DxtLEXf7/nTo9EjzA474OY7m
	rEEOJT6lVEjzxBZoulM5nogqifkPwheygS7WywG7pfO7zX7WdcXCjy5IXc1haZnS04pygE5
	nrW7QjeZl9JJ5oc5oIr1T/zeigjvrJheg==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295125-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:horms@kernel.org,m:kees@kernel.org,m:larysa.zaremba@intel.com,m:joe@dama.to,m:leitao@debian.org,m:aleksandr.loktionov@intel.com,m:u.kleine-koenig@baylibre.com,m:fabio.baltieri@gmail.com,m:tglx@kernel.org,m:gregkh@linuxfoundation.org,m:jiawenwu@trustnetic.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,linuxfoundation.org,trustnetic.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E7A463E584

Support AER driver to handle the PCIe errors. Sometimes netdev watchdog
Tx timeout happens before the AER error report when a PCIe error occurs,
CPU blocking would be caused by MMIO during the reset process. To
prevent it, error return is added in reset path. The current function of
ngbe is not yet fully developed, it will be completed in the future.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 114 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  23 +++-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   6 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  53 ++++++--
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   2 +-
 7 files changed, 189 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
index ee27f96735dc..9a4dbb3427d9 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
@@ -4,11 +4,125 @@
 
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <linux/aer.h>
 
 #include "wx_type.h"
 #include "wx_lib.h"
 #include "wx_err.h"
 
+/**
+ * wx_io_error_detected - called when PCI error is detected
+ * @pdev: Pointer to PCI device
+ * @state: The current pci connection state
+ *
+ * Return: pci_ers_result_t.
+ *
+ * This function is called after a PCI bus error affecting
+ * this device has been detected.
+ */
+static pci_ers_result_t wx_io_error_detected(struct pci_dev *pdev,
+					     pci_channel_state_t state)
+{
+	struct wx *wx = pci_get_drvdata(pdev);
+	struct net_device *netdev;
+
+	if (!wx)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	netdev = wx->netdev;
+	if (!netif_device_present(netdev))
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	if (state == pci_channel_io_perm_failure)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	rtnl_lock();
+	netif_device_detach(netdev);
+
+	if (netif_running(netdev) &&
+	    !test_and_set_bit(WX_STATE_DOWN, wx->state))
+		wx_soft_quiesce(wx);
+
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
+	rtnl_unlock();
+
+	/* Request a slot reset. */
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+/**
+ * wx_io_slot_reset - called after the pci bus has been reset.
+ * @pdev: Pointer to PCI device
+ *
+ * Return: pci_ers_result_t.
+ *
+ * Restart the card from scratch, as if from a cold-boot.
+ */
+static pci_ers_result_t wx_io_slot_reset(struct pci_dev *pdev)
+{
+	struct wx *wx = pci_get_drvdata(pdev);
+	pci_ers_result_t result;
+
+	if (pci_enable_device_mem(pdev)) {
+		wx_err(wx, "Cannot re-enable PCI device after reset.\n");
+		result = PCI_ERS_RESULT_DISCONNECT;
+	} else {
+		/* make all memory operations done before clearing the flag */
+		smp_mb__before_atomic();
+		clear_bit(WX_STATE_DISABLED, wx->state);
+		pci_set_master(pdev);
+		pci_restore_state(pdev);
+		pci_wake_from_d3(pdev, false);
+
+		rtnl_lock();
+		if (netif_running(wx->netdev) && wx->down_suspend)
+			wx->down_suspend(wx);
+		if (wx->do_reset)
+			wx->do_reset(wx->netdev, false);
+		rtnl_unlock();
+		result = PCI_ERS_RESULT_RECOVERED;
+	}
+
+	pci_aer_clear_nonfatal_status(pdev);
+
+	return result;
+}
+
+/**
+ * wx_io_resume - called when traffic can start flowing again.
+ * @pdev: Pointer to PCI device
+ *
+ * This callback is called when the error recovery driver tells us that
+ * its OK to resume normal operation.
+ */
+static void wx_io_resume(struct pci_dev *pdev)
+{
+	struct wx *wx = pci_get_drvdata(pdev);
+	struct net_device *netdev;
+	int err;
+
+	netdev = wx->netdev;
+	rtnl_lock();
+	if (netif_running(netdev)) {
+		err = netdev->netdev_ops->ndo_open(netdev);
+		if (err) {
+			wx_err(wx, "Failed to open netdev after reset\n");
+			goto out;
+		}
+	}
+	netif_device_attach(netdev);
+out:
+	rtnl_unlock();
+}
+
+const struct pci_error_handlers wx_err_handler = {
+	.error_detected = wx_io_error_detected,
+	.slot_reset = wx_io_slot_reset,
+	.resume = wx_io_resume,
+};
+EXPORT_SYMBOL(wx_err_handler);
+
 static void wx_pf_reset_subtask(struct wx *wx)
 {
 	if (!test_and_clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.h b/drivers/net/ethernet/wangxun/libwx/wx_err.h
index 1eed13e48095..a6a82a263528 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_err.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_err.h
@@ -7,6 +7,8 @@
 #ifndef _WX_ERR_H_
 #define _WX_ERR_H_
 
+extern const struct pci_error_handlers wx_err_handler;
+
 void wx_check_err_subtask(struct wx *wx);
 int wx_init_err_task(struct wx *wx);
 void wx_check_hang_subtask(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index a8b4e84787f4..ec66a34b272d 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1221,6 +1221,7 @@ enum wx_state {
 	WX_STATE_PTP_RUNNING,
 	WX_STATE_PTP_TX_IN_PROGRESS,
 	WX_STATE_SERVICE_SCHED,
+	WX_STATE_DISABLED,
 	WX_STATE_NBITS		/* must be last */
 };
 
@@ -1409,6 +1410,7 @@ struct wx {
 	void (*configure_fdir)(struct wx *wx);
 	int (*setup_tc)(struct net_device *netdev, u8 tc);
 	void (*do_reset)(struct net_device *netdev, bool reinit);
+	void (*down_suspend)(struct wx *wx);
 	int (*ptp_setup_sdp)(struct wx *wx);
 	void (*set_num_queues)(struct wx *wx);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 7dd3e12d48aa..effe9311a57a 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -47,6 +47,19 @@ static const struct pci_device_id ngbe_pci_tbl[] = {
 	{ }
 };
 
+static void ngbe_down_suspend(struct wx *wx)
+{
+	phylink_stop(wx->phylink);
+	phylink_disconnect_phy(wx->phylink);
+
+	wx_clean_all_tx_rings(wx);
+	wx_clean_all_rx_rings(wx);
+
+	wx_free_irq(wx);
+	wx_free_isb_resources(wx);
+	wx_free_resources(wx);
+}
+
 /**
  *  ngbe_init_type_code - Initialize the shared code
  *  @wx: pointer to hardware structure
@@ -135,6 +148,7 @@ static int ngbe_sw_init(struct wx *wx)
 	wx->mbx.size = WX_VXMAILBOX_SIZE;
 	wx->setup_tc = ngbe_setup_tc;
 	wx->do_reset = ngbe_do_reset;
+	wx->down_suspend = ngbe_down_suspend;
 	set_bit(0, &wx->fwd_bitmask);
 
 	return 0;
@@ -566,7 +580,8 @@ static void ngbe_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	*enable_wake = !!wufc;
 	wx_control_hw(wx, false);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static void ngbe_shutdown(struct pci_dev *pdev)
@@ -856,6 +871,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 		goto err_register;
 
 	pci_set_drvdata(pdev, wx);
+	pci_save_state(pdev);
 
 	return 0;
 
@@ -911,7 +927,8 @@ static void ngbe_remove(struct pci_dev *pdev)
 	kfree(wx->mac_table);
 	wx_clear_interrupt_scheme(wx);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static int ngbe_suspend(struct pci_dev *pdev, pm_message_t state)
@@ -938,6 +955,7 @@ static int ngbe_resume(struct pci_dev *pdev)
 		wx_err(wx, "Cannot enable PCI device from suspend\n");
 		return err;
 	}
+	clear_bit(WX_STATE_DISABLED, wx->state);
 	pci_set_master(pdev);
 	device_wakeup_disable(&pdev->dev);
 
@@ -962,6 +980,7 @@ static struct pci_driver ngbe_driver = {
 	.resume   = ngbe_resume,
 	.shutdown = ngbe_shutdown,
 	.sriov_configure = wx_pci_sriov_configure,
+	.err_handler = &wx_err_handler,
 };
 
 module_pci_driver(ngbe_driver);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index 3e32aca72806..80811947d5ac 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -78,13 +78,17 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 		goto clear_reset;
 	}
 
-	txgbe_down(wx);
+	err = txgbe_down(wx);
+	if (err)
+		goto free_temp;
 
 	wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
 	kvfree(temp_ring);
 
 	txgbe_up(wx);
 
+free_temp:
+	kvfree(temp_ring);
 clear_reset:
 	clear_bit(WX_STATE_RESETTING, wx->state);
 	mutex_unlock(&wx->reset_lock);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index f6e596eb9217..98786efbe871 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -212,15 +212,21 @@ static void txgbe_reset(struct wx *wx)
 		wx_ptp_reset(wx);
 }
 
-static void txgbe_disable_device(struct wx *wx)
+static int txgbe_disable_device(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
+	int ret = 0;
 	u32 i;
 
 	if (test_and_set_bit(WX_STATE_DOWN, wx->state))
-		return;
+		return 0;
+
+	ret = wx_disable_pcie_master(wx);
+	if (ret) {
+		wx_soft_quiesce(wx);
+		return ret;
+	}
 
-	wx_disable_pcie_master(wx);
 	/* disable receives */
 	wx_disable_rx(wx);
 
@@ -270,11 +276,18 @@ static void txgbe_disable_device(struct wx *wx)
 
 	/* Disable the Tx DMA engine */
 	wr32m(wx, WX_TDM_CTL, WX_TDM_CTL_TE, 0);
+
+	return 0;
 }
 
-void txgbe_down(struct wx *wx)
+int txgbe_down(struct wx *wx)
 {
-	txgbe_disable_device(wx);
+	int ret = 0;
+
+	ret = txgbe_disable_device(wx);
+	if (ret)
+		return ret;
+
 	txgbe_reset(wx);
 
 	switch (wx->mac.type) {
@@ -295,6 +308,8 @@ void txgbe_down(struct wx *wx)
 
 	wx_clean_all_tx_rings(wx);
 	wx_clean_all_rx_rings(wx);
+
+	return 0;
 }
 
 void txgbe_up(struct wx *wx)
@@ -304,6 +319,18 @@ void txgbe_up(struct wx *wx)
 	txgbe_up_complete(wx);
 }
 
+static void txgbe_down_suspend(struct wx *wx)
+{
+	phylink_stop(wx->phylink);
+
+	wx_clean_all_tx_rings(wx);
+	wx_clean_all_rx_rings(wx);
+
+	wx_free_irq(wx);
+	txgbe_free_misc_irq(wx->priv);
+	wx_free_resources(wx);
+}
+
 /**
  *  txgbe_init_type_code - Initialize the shared code
  *  @wx: pointer to hardware structure
@@ -420,6 +447,7 @@ static int txgbe_sw_init(struct wx *wx)
 
 	wx->setup_tc = txgbe_setup_tc;
 	wx->do_reset = txgbe_do_reset;
+	wx->down_suspend = txgbe_down_suspend;
 	set_bit(0, &wx->fwd_bitmask);
 
 	switch (wx->mac.type) {
@@ -556,7 +584,8 @@ static void txgbe_dev_shutdown(struct pci_dev *pdev)
 
 	wx_control_hw(wx, false);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static void txgbe_shutdown(struct pci_dev *pdev)
@@ -606,13 +635,16 @@ int txgbe_setup_tc(struct net_device *dev, u8 tc)
 
 static void txgbe_reinit_locked(struct wx *wx)
 {
+	int ret;
+
 	netif_trans_update(wx->netdev);
 
 	mutex_lock(&wx->reset_lock);
 	set_bit(WX_STATE_RESETTING, wx->state);
 
-	txgbe_down(wx);
-	txgbe_up(wx);
+	ret = txgbe_down(wx);
+	if (!ret)
+		txgbe_up(wx);
 
 	clear_bit(WX_STATE_RESETTING, wx->state);
 	mutex_unlock(&wx->reset_lock);
@@ -908,6 +940,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 		goto err_remove_phy;
 
 	pci_set_drvdata(pdev, wx);
+	pci_save_state(pdev);
 
 	netif_tx_stop_all_queues(netdev);
 
@@ -982,7 +1015,8 @@ static void txgbe_remove(struct pci_dev *pdev)
 	kfree(wx->mac_table);
 	wx_clear_interrupt_scheme(wx);
 
-	pci_disable_device(pdev);
+	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
+		pci_disable_device(pdev);
 }
 
 static struct pci_driver txgbe_driver = {
@@ -992,6 +1026,7 @@ static struct pci_driver txgbe_driver = {
 	.remove   = txgbe_remove,
 	.shutdown = txgbe_shutdown,
 	.sriov_configure = wx_pci_sriov_configure,
+	.err_handler = &wx_err_handler,
 };
 
 module_pci_driver(txgbe_driver);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 1e373f7fd9b5..daef87274678 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -310,7 +310,7 @@ struct txgbe_fdir_filter {
 
 extern char txgbe_driver_name[];
 
-void txgbe_down(struct wx *wx);
+int txgbe_down(struct wx *wx);
 void txgbe_up(struct wx *wx);
 int txgbe_setup_tc(struct net_device *dev, u8 tc);
 void txgbe_do_reset(struct net_device *netdev, bool reinit);
-- 
2.51.0


