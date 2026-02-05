Return-Path: <netdev+bounces-257028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKBhHMhMhGm82QMAu9opvQ
	(envelope-from <netdev+bounces-257028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:54:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E3FEFA0C
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54A0E30041FA
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4787C35F8DE;
	Thu,  5 Feb 2026 07:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EqIPxl8N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D5m16N4j"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EAF2405EC;
	Thu,  5 Feb 2026 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278086; cv=none; b=s7vqQ4/JV5F5J8XmgAWk4jz/Wc1j02y0b5hdVzh7PCe+l3nvWhLJFKReKNSEALHsSIbFFIw+oIgQuO6zFbQtaZUVXFes2gCt/VQ0XNnYcGXB3MvbUXQsqKIG+hSxEoWyrp0dwVJBE7cz7ZvMdlqoNgK2sRX187GbPVfDdMo6s5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278086; c=relaxed/simple;
	bh=YqkYuVD6B8ingjypZapGuxYX1HIAg0y6MvAOvzuLs6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OUNpjWWqtmfodu+Ljv5oQTPFonvEgt/dd514+O/K7nSFiWiepjE/vD06Z6Q574YWqJs3RHwE1yv6sstUB8Kg2WutL3I6ShcvfeGF1/yIgJLuv2nHksnBbo1h71kSwK3mwUE+l5+cnap/uKh57wqxdxmhXHq9SQK2HJHYuviBLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EqIPxl8N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D5m16N4j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770278083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YI75SligFceTjZw1yfKwWA/UrX3Yc7oaVqN88ExO2XQ=;
	b=EqIPxl8NJcb5hBz/DrlS9vH/GYZnvDZ4UuLxFpgZmJXi78iJ5zTXXuP/N8LOB6IXh38Qem
	s5Y9jb70GBj5gVpIzGTfPg+jyVNNsLj8GDTx3u9SUeO2BcmHlzlu2CSTnUmIveV1c7T4i3
	LGBtGFply5RZr7HhM2NOSSUEaiRv9i+6rmhwgNgGe/pESLNFE8OOfqHehgvkwn2cLWbyjS
	HjjjXjzoxGIqLLNPiF1oVzOoiSRbB2H/ze1XvxHGgpVslBcu1DHqpJDHfpNxwa0LUcE81S
	5jqS3bWbPm4kr25462KHT57ZpkiH0m9sqZ7evn5jNKPn6AA3ZeVl7oRXL8sXfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770278083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YI75SligFceTjZw1yfKwWA/UrX3Yc7oaVqN88ExO2XQ=;
	b=D5m16N4jsfXnocitENkWPThOOadmmtN+AyrVSy44krWO7h37RMVVyhUV//WSMLwW2bVnkq
	BEpQN3NlKu5dZmCg==
Date: Thu, 05 Feb 2026 08:54:34 +0100
Subject: [PATCH iwl-next v3] igb: Retrieve Tx timestamp directly from
 interrupt for i210
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
X-B4-Tracking: v=1; b=H4sIALlMhGkC/12N0Q6CIBhGX8VxHQ1+NFxXvUdrDhH13xwWENmc7
 x5jXViXZ9/O+VbijUPjyblYiTMRPc42gTgURI/KDoZil5gAg4rVXFAc2gbdowmecqWk1Fq2pW5
 JEu7O9Ljk2JXga6LWLIHc0jKiD7N755fI8/4NVvtg5JTTWp96zUQlSoDLhPYZ3GxxOXYmpyLsd
 IAfHZLOlRaSyVpJVf7r27Z9AIW5aenxAAAA
X-Change-ID: 20250813-igb_irq_ts-1aa77cc7b4cb
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3568; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=YqkYuVD6B8ingjypZapGuxYX1HIAg0y6MvAOvzuLs6Q=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBphEzCiI2A689V5++B//pI9fgMWXXaArRkMXPVj
 3VH4/bTuOSJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCaYRMwgAKCRDBk9HyqkZz
 gv4NEACQ8pejkbuLsnYEsrckwAJrabuIvthZIhfNOAGJFgcxq2XB3D+WnwgSGtxtjbDFvop5FZ4
 aNrhHqoM7AkxSkFppXvtlsp1Z+RDC71rEp58uKSP0b5P+HHpfyC9Neo7VwJVoJAqC6pv/WJK9ra
 aKjpTFEZutyMuvWYKfPSPl5H4RB9vVjSdKE4cLUTONX9N5rB9VjqXIm4b+11+nvTp/wBJ9ehlI/
 tKLB25Mvw0DMt3lNzAa0wM3L+T7tm7iRPkyT6NmfMrNnFFJ+6A/+We8sO/22QzSCvLCoFKw37DS
 iBYOkCHzGrXDwrygPNwdut+mJXLr9tvVYmrrcxlfea2tblWIbNZbuzZXB+UkJ4wCAAidP8y8N19
 Gr5vbfWSls3j0d0Zg0tFsgAGlyC9gzGoLRSOkDRXkMt+ovFuUWu0Qdab1oDBF4FW7nP4zRkF3s1
 r6PuMNppUDp41oBlIc/DqjhO/IJcUNeG65oGnl9u9bnC7BlXz2fq7k88GDuiFsPOzLBEhMrk+ww
 ys+rmbPl8yk3JYI1F8o6Q7Ez1XJe7Wz/k04fmKf2cucxkZ+pAWmSaxkWUR+pDl3OCydwTrjXOry
 g/a7KtPYNBtW9Op/w6xzG0AvWgJsgvyjqpZP4S0Nf4+Uhagg/NyBw2a/5KZU989w20uT1VwEzdQ
 ArarhMmXOyR1OKA==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257028-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,intel.com,linutronix.de,molgen.mpg.de,linux.dev,lists.osuosl.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kurt@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16E3FEFA0C
X-Rspamd-Action: no action

Retrieve Tx timestamp directly from interrupt handler for i210.

The current implementation uses schedule_work() which is executed by the
system work queue to retrieve Tx timestamps. This increases latency and can
lead to timeouts in case of heavy system load. i210 is often used in
industrial systems, where timestamp timeouts can be fatal.

Therefore, fetch the timestamp directly from the interrupt handler.

The work queue code stays for all other NICs supported by igb.

Tested on Intel i210 and i350.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
Changes in v3:
- Switch back to IRQ, but for i210 only
- Keep kworker for all other NICs like i350 (Miroslav)
- Link to v2: https://lore.kernel.org/r/20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de

Changes in v2:
- Switch from IRQ to PTP aux worker due to NTP performance regression (Miroslav)
- Link to v1: https://lore.kernel.org/r/20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de
---
 drivers/net/ethernet/intel/igb/igb.h      |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c |  5 ++++-
 drivers/net/ethernet/intel/igb/igb_ptp.c  | 22 ++++++++++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 0fff1df81b7b..1de29670784e 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -776,6 +776,7 @@ int igb_ptp_hwtstamp_get(struct net_device *netdev,
 int igb_ptp_hwtstamp_set(struct net_device *netdev,
 			 struct kernel_hwtstamp_config *config,
 			 struct netlink_ext_ack *extack);
+void igb_ptp_tx_tstamp_event(struct igb_adapter *adapter);
 void igb_set_flag_queue_pairs(struct igb_adapter *, const u32);
 unsigned int igb_get_max_rss_queues(struct igb_adapter *);
 #ifdef CONFIG_IGB_HWMON
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index dbea37269d2c..d0d9245e6d72 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7078,7 +7078,10 @@ static void igb_tsync_interrupt(struct igb_adapter *adapter)
 
 	if (tsicr & E1000_TSICR_TXTS) {
 		/* retrieve hardware timestamp */
-		schedule_work(&adapter->ptp_tx_work);
+		if (hw->mac.type == e1000_i210)
+			igb_ptp_tx_tstamp_event(adapter);
+		else
+			schedule_work(&adapter->ptp_tx_work);
 	}
 
 	if (tsicr & TSINTR_TT0)
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index bd85d02ecadd..8c8f2b8615f7 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -796,6 +796,28 @@ static int igb_ptp_verify_pin(struct ptp_clock_info *ptp, unsigned int pin,
 	return 0;
 }
 
+/**
+ * igb_ptp_tx_tstamp_event
+ * @adapter: pointer to igb adapter
+ *
+ * This function checks the TSYNCTXCTL valid bit and stores the Tx hardware
+ * timestamp at the current skb.
+ **/
+void igb_ptp_tx_tstamp_event(struct igb_adapter *adapter)
+{
+	struct e1000_hw *hw = &adapter->hw;
+	u32 tsynctxctl;
+
+	if (!adapter->ptp_tx_skb)
+		return;
+
+	tsynctxctl = rd32(E1000_TSYNCTXCTL);
+	if (WARN_ON_ONCE(!(tsynctxctl & E1000_TSYNCTXCTL_VALID)))
+		return;
+
+	igb_ptp_tx_hwtstamp(adapter);
+}
+
 /**
  * igb_ptp_tx_work
  * @work: pointer to work struct

---
base-commit: e07d0d30939990da377672ef49ca09763b4fbc79
change-id: 20250813-igb_irq_ts-1aa77cc7b4cb

Best regards,
--  
Kurt Kanzenbach <kurt@linutronix.de>


