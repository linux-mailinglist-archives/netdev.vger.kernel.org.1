Return-Path: <netdev+bounces-264527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Aw0DTThqWnDGwEAu9opvQ
	(envelope-from <netdev+bounces-264527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:01:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C5248217EAA
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4DC63023683
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 20:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F893EF0A0;
	Thu,  5 Mar 2026 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LC89655v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007793ED5AD
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740871; cv=none; b=ciun3yXYd4Mq8bgQUjjhFqJiMnHK3LSKrgh7Ht/iCgzwlhskMLpT1H0iviib71Z6VtU3GYvOOYjejMZ7765qZ706NOpWvswWn25U0pa7Rzcae5IE2CFklAthME5tVBlD/YPJC3WC3rgHv0iV2767e9eRvXUjTXbVJakITIb+zGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740871; c=relaxed/simple;
	bh=JxO81/weFyc459OMqAugvZdWK5EbJ/Ld7je/eSdGL+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2oF9r7SDpcXgbJ2+yk/O9XE1u8PPbnmETGGgXkaREwM21M74il+G4xOUAvDcfEHIoDQb7uja5nh6Jv54Qhx+E3L+1X0Zt56eWheFxKWGwuVJme5ou8Ao+W2FjfoCjBv6JKpTJYP0XKmWuSFC9XRpO+75eq4aYn+moJ0uFIoCDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LC89655v; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-82976220e97so1265211b3a.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 12:01:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772740869; x=1773345669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLbZWpd5u/NFnfx5DlhA19ecuXsYw/JuQ0/iZQbB610=;
        b=NoalTHI8xAGxjuIX2Ml4HOHNSAgYRMKjjUoJeQBXIEIgmgjk+O0GhVUCipZ4Ii9NIo
         uAtEMqi3qsVLIiDSUzZq/G8za+39FPUui750pVtYKUdHaolWCtjdmAYtkVtchIF1RA2p
         H/YBmuflQksiSYwNtdqns2iPFzE3nNbTbufZ9/waiwsvBmpc+fjPnUVh0rlg0R6nKZkh
         vFmTbIEfpiYL/bxx3lc7AX6gsepDSNuN1UyieNpzgdvot6qpCLd2XeoEzikwGs/W+ipQ
         kFpvNnrDfIUFG69oajN7rKZ8/OquQLeKlOzLLHLLNdIQpJ93N4Gh2vDXEp/OLSI8rDUO
         gFKg==
X-Gm-Message-State: AOJu0YzHC43/9/+00ZLBR4G2gGgM7WDuH10GdHgrtYHDcc1NDUynCNbd
	NhyAvrrYQvIFVO95b+uuw5ZoQaW7epABxZNc21HPQZWdWmtUI75AIMZinEEQ/gQILLDc5nGTfGU
	hajtfE5znWcsQGyb5Au2X5B5cL7YfVdAFQQK5TFRa2NNcDtEz7QO+WeVFFSRfMhdZOk3aYwZEQc
	cHcUGJrtfD5UmQU0sd+nxCnDaQ2lWuYA37rzKhqaEgpGz6nJAFu/rMJSdyIOFvX/JhAwOHE5Mj1
	zvnHTsZit4ik+A0WQ==
X-Gm-Gg: ATEYQzy2cRekCugHvpeICZwkHLQufKsoWVCvSw3iEkRhbTKpCGEdGJT372Mo0KPpxeJ
	1b1uu4q/ZK5h/PJ6H5ZSD1Jg4CSpF76Ja2KFqmIXmRrt9phhgxPf3MpIKhTmLXBQCd0UQ9VJRQN
	wJNzh3O7cGMusXUhmgUV3jjFVUop/wbTkWTEoDMlEJVOAPZY0h4STxsuyc5nECk0JW8RJQtBPft
	UxIwt58wDrM8xqYLbxRzDXMzsZoMRosHZcan91NCtzORcK5Y5/plDFXzwnf/qvTwy2WbAhh92yc
	pRtb+42fuE55jS1IvvECfMtZrTU9jUgZQDp1gajj4YOpRDtDDnZ73OfxR0pKM0ezWVpD0CxqECI
	KklNHYwGyY1l/JNqHsK3EiBL3fURSc6pw68HGKPDHnaXSVjM9sXoIDTvpwmdvTo2DaYW8Ac9hs7
	HnRq4/jq9hm834IQOkRevbKanDRg8pKgHLC6VEPKRvEOAhKTc+dyY2O6rDHKvkH25lLg==
X-Received: by 2002:a05:6a00:340b:b0:824:9451:c1f5 with SMTP id d2e1a72fcca58-8299ae5f2a1mr754056b3a.58.1772740868229;
        Thu, 05 Mar 2026 12:01:08 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8297b30a4e4sm449983b3a.5.2026.03.05.12.01.07
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2026 12:01:08 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ae4cdfc468so48853205ad.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 12:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772740866; x=1773345666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLbZWpd5u/NFnfx5DlhA19ecuXsYw/JuQ0/iZQbB610=;
        b=LC89655vjTQZjjFlY0/7YKbnaRN3poZ2piZFBvG5UazduHLUL3z+UQ7gNDG0T5D18Y
         9TK/mANt+D6psOUNr6Z10u0QdcMroMGcJX+5LYynLOa2+mljbmgPwax1fckAhCbrh2nH
         RI/H/XyEK2pLNaAzlzNxDGOVHW4uATOOjqBnQ=
X-Received: by 2002:a17:902:e788:b0:2ae:5aed:1f51 with SMTP id d9443c01a7336-2ae80257d16mr6542295ad.43.1772740866316;
        Thu, 05 Mar 2026 12:01:06 -0800 (PST)
X-Received: by 2002:a17:902:e788:b0:2ae:5aed:1f51 with SMTP id d9443c01a7336-2ae80257d16mr6541735ad.43.1772740865573;
        Thu, 05 Mar 2026 12:01:05 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69ef1csm247398505ad.53.2026.03.05.12.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 12:01:05 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v4 01/10] bng_en: add per-PF workqueue, timer, and slow-path task
Date: Fri,  6 Mar 2026 01:30:08 +0530
Message-ID: <20260305200018.111728-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305200018.111728-1-bhargava.marreddy@broadcom.com>
References: <20260305200018.111728-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: C5248217EAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264527-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add a dedicated single-thread workqueue and a timer for each PF
to drive deferred slow-path work such as link event handling and
stats collection. The timer is stopped via timer_delete_sync()
when interrupts are disabled and restarted on open. The open and
close paths now start and drain these resources.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 87 ++++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  | 13 ++-
 2 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index a20dc3ca640..ee77b29f5b9 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -101,6 +101,45 @@ static int bnge_alloc_ring_stats(struct bnge_net *bn)
 	return rc;
 }
 
+static void bnge_timer(struct timer_list *t)
+{
+	struct bnge_net *bn = timer_container_of(bn, t, timer);
+	struct bnge_dev *bd = bn->bd;
+
+	if (!netif_running(bn->netdev) ||
+	    !test_bit(BNGE_STATE_OPEN, &bd->state))
+		return;
+
+	/* Periodic work added by later patches */
+
+	mod_timer(&bn->timer, jiffies + bn->current_interval);
+}
+
+static void bnge_sp_task(struct work_struct *work)
+{
+	struct bnge_net *bn = container_of(work, struct bnge_net, sp_task);
+	struct bnge_dev *bd = bn->bd;
+
+	set_bit(BNGE_STATE_IN_SP_TASK, &bn->state);
+	/* Ensure sp_task state is visible before checking BNGE_STATE_OPEN */
+	smp_mb__after_atomic();
+	if (!test_bit(BNGE_STATE_OPEN, &bd->state)) {
+		clear_bit(BNGE_STATE_IN_SP_TASK, &bn->state);
+		return;
+	}
+
+	/* Event handling work added by later patches */
+
+	/* Ensure all sp_task work is done before clearing the state */
+	smp_mb__before_atomic();
+	clear_bit(BNGE_STATE_IN_SP_TASK, &bn->state);
+}
+
+static bool bnge_drv_busy(struct bnge_net *bn)
+{
+	return test_bit(BNGE_STATE_IN_SP_TASK, &bn->state);
+}
+
 static void bnge_free_nq_desc_arr(struct bnge_nq_ring_info *nqr)
 {
 	struct bnge_ring_struct *ring = &nqr->ring_struct;
@@ -2507,6 +2546,9 @@ static int bnge_open_core(struct bnge_net *bn)
 	bnge_enable_int(bn);
 
 	bnge_tx_enable(bn);
+
+	mod_timer(&bn->timer, jiffies + bn->current_interval);
+
 	return 0;
 
 err_free_irq:
@@ -2542,6 +2584,12 @@ static void bnge_close_core(struct bnge_net *bn)
 	bnge_tx_disable(bn);
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
+	/* Ensure BNGE_STATE_OPEN is cleared before checking drv_busy */
+	smp_mb__after_atomic();
+	while (bnge_drv_busy(bn))
+		msleep(20);
+
+	timer_delete_sync(&bn->timer);
 	bnge_shutdown_nic(bn);
 	bnge_disable_napi(bn);
 	bnge_free_all_rings_bufs(bn);
@@ -2690,6 +2738,23 @@ static void bnge_init_ring_params(struct bnge_net *bn)
 	bn->netdev->cfg->hds_thresh = max(BNGE_DEFAULT_RX_COPYBREAK, rx_size);
 }
 
+static struct workqueue_struct *
+bnge_create_workqueue_thread(struct bnge_dev *bd, const char *thread_name)
+{
+	struct workqueue_struct *wq;
+	char *wq_name;
+
+	wq_name = kasprintf(GFP_KERNEL, "%s-%s", thread_name,
+			    dev_name(bd->dev));
+	if (!wq_name)
+		return NULL;
+
+	wq = create_singlethread_workqueue(wq_name);
+	kfree(wq_name);
+
+	return wq;
+}
+
 int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 {
 	struct net_device *netdev;
@@ -2774,6 +2839,17 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	if (bd->tso_max_segs)
 		netif_set_tso_max_segs(netdev, bd->tso_max_segs);
 
+	INIT_WORK(&bn->sp_task, bnge_sp_task);
+	timer_setup(&bn->timer, bnge_timer, 0);
+	bn->current_interval = BNGE_TIMER_INTERVAL;
+
+	bn->bnge_pf_wq = bnge_create_workqueue_thread(bd, "bnge_pf_wq");
+	if (!bn->bnge_pf_wq) {
+		netdev_err(netdev, "Unable to create workqueue.\n");
+		rc = -ENOMEM;
+		goto err_netdev;
+	}
+
 	bn->rx_ring_size = BNGE_DEFAULT_RX_RING_SIZE;
 	bn->tx_ring_size = BNGE_DEFAULT_TX_RING_SIZE;
 	bn->rx_dir = DMA_FROM_DEVICE;
@@ -2789,11 +2865,13 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	rc = register_netdev(netdev);
 	if (rc) {
 		dev_err(bd->dev, "Register netdev failed rc: %d\n", rc);
-		goto err_netdev;
+		goto err_free_workq;
 	}
 
 	return 0;
 
+err_free_workq:
+	destroy_workqueue(bn->bnge_pf_wq);
 err_netdev:
 	free_netdev(netdev);
 	return rc;
@@ -2802,8 +2880,15 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 void bnge_netdev_free(struct bnge_dev *bd)
 {
 	struct net_device *netdev = bd->netdev;
+	struct bnge_net *bn;
+
+	bn = netdev_priv(netdev);
 
 	unregister_netdev(netdev);
+
+	cancel_work_sync(&bn->sp_task);
+	destroy_workqueue(bn->bnge_pf_wq);
+
 	free_netdev(netdev);
 	bd->netdev = NULL;
 }
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 70f1a7c2481..b00d2e3922d 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -224,6 +224,13 @@ struct bnge_tpa_info {
 #define BNGE_NQ_HDL_TYPE(hdl)	(((hdl) & BNGE_NQ_HDL_TYPE_MASK) >>	\
 				 BNGE_NQ_HDL_TYPE_SHIFT)
 
+enum bnge_net_state {
+	BNGE_STATE_NAPI_DISABLED,
+	BNGE_STATE_IN_SP_TASK,
+};
+
+#define BNGE_TIMER_INTERVAL	HZ
+
 struct bnge_net {
 	struct bnge_dev		*bd;
 	struct net_device	*netdev;
@@ -281,13 +288,17 @@ struct bnge_net {
 	u32			stats_coal_ticks;
 
 	unsigned long		state;
-#define BNGE_STATE_NAPI_DISABLED	0
 
 	u32			msg_enable;
 	u16			max_tpa;
 	__be16			vxlan_port;
 	__be16			nge_port;
 	__be16			vxlan_gpe_port;
+
+	unsigned int		current_interval;
+	struct timer_list	timer;
+	struct workqueue_struct *bnge_pf_wq;
+	struct work_struct	sp_task;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
-- 
2.47.3


