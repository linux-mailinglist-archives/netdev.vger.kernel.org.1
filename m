Return-Path: <netdev+bounces-260115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LMmI++FnGm7IwQAu9opvQ
	(envelope-from <netdev+bounces-260115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:53:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD5E17A2C3
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A2D432182BC
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3D9319875;
	Mon, 23 Feb 2026 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LvgS8d72"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345283148CD
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864654; cv=none; b=sOjm+pw6e4JSux0g+NOsLDIfnjN6SiQEVFw6XxUo7vyZjqhWpup9JCts6xA1WOi2FgcSrg7qVMY95fAa1Im2Z56z5jz/meKuVWQoG9ia0P550/+DbX4W0mTqoPQDmQtlLxeJ0VOH1Wwvh1feR20/bNpqtfbVjrG3psc8YUegrIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864654; c=relaxed/simple;
	bh=1PI8WR/QfyYhgdDskRti90NGiPXxK286+GwVSfvHDnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9RqriqQ5V6aivGphhzJfOO7iJFjey8923MnMUv/i6tkrpSDATS2MRm50hVHgqXTFSYmz4YF3kyMMcGVrCO90xRmE2Ng3adsNtIAM8R8HmniYGyJVEq5PuVc7mQx9WpVzuWbW8MTQ9JWcRMM/jClH+Li7HIvcSPfbtocsX6KTIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LvgS8d72; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a91215c158so30185235ad.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 08:37:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771864651; x=1772469451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuYgrfs/Q0g/vVNofvxW+PM6Q1g2Ph6NmJqvydo7chw=;
        b=BjPM+PZFqAZ+wM2X3acEAdoAQLYtnnNfx919lbhKTgtDi+nASn7i4sHQN/waHNuKSc
         vGthjHXJkivdMf/9aLVkEn0DcmGwazHyvSqy0+GeG+lpouKjiSGT1KGraAqg1sUOimhD
         HGFGn3P6NGg8/rFGCqURnjsytagTPIPsGO/cZd8F3PhP+90Jd4+aj03AyFeBSq3nejDC
         77+Kbauoh9xVBT+qp15Rjk5jXvdczl3gPqk5rpyN8gHksuFPzXl0GbHk/SsFbqlnuz5Y
         eHQV+Jh/+iQ9rGIOb4HrITm6cUo42Ov45pb1ISSSlVMXThufwXoN4KKUfVEU7ewReaLG
         9u4w==
X-Gm-Message-State: AOJu0YzKpfQ0p7odcLTpUnHt6E4P9AxY6KdMyEHC46FlxuHOlcC5028q
	nvTVAqMaSQt1lBk7ZLClGWPZyUzIjtVzQww0kLTgPm+feTXrOW/nZ8sLrV69o138c1dkBlmHess
	M2pJNRKdMBwsrcQPdDOA0HZXmB1P8cYqF4duke0drrONG04riTZCL3wT2Y2Bta8rpy1ca2TV4bW
	j/ivkr5SzylqekYnpPEk5NmcuNMcUGzhNYIUknEn/iQWdHFAR1QXu2kfjpZ9/S8u4LIpwafr8tt
	5AfgZ8WOuj/XmyhzA==
X-Gm-Gg: ATEYQzwHDIQa4lhPry/GmxM2k7LbZyHBIKT5Gwk/jjGFt4VQitgsl+M4CvSKZTtLUAv
	I2HGDd3nY5NIdDtZgJPiSZFyQwsUt6ah+TWieRYtbY71MvqnOQO94go8t/stdv5LlFCE37ck6+n
	UNCUEpBIbelPJEqZ2q/7tSZ54hrUxCFwiS7NbrBN2ggnXWMv6V1ViGDjNIX+HotFp58fdhK/gzO
	7bNhJn3uGUnBK/9iQvuIYb2ANAAyXlIws8XtbvuEDdAqBpl8tZBcJ6JErMMrkKZof48kbp+zA3K
	Fxr/xQzcYLvb2omZWRsGq8ayggezqvrLdoMfPDbeZLMudhLsctWGMPr4pXfO4zdETz8nbMJzMzD
	dD426GUWrVWdS5GQ1sn6ohAalI1hpGeAvFIrCHfTM0LSoIjUaORzWq473crQBPHC8Ly3WMR4UT3
	Rd7d5DzVN1vmMAve5fxAHbpvX20T5h5VSGw4BcRyRpcUsRwF799EnVMsHUUHWYXnxBAA==
X-Received: by 2002:a17:90b:570e:b0:32e:6fae:ba52 with SMTP id 98e67ed59e1d1-358ae7ba878mr7987588a91.6.1771864651248;
        Mon, 23 Feb 2026 08:37:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-358af6fa9d7sm1074505a91.2.2026.02.23.08.37.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2026 08:37:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a76f2d7744so49699435ad.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 08:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771864649; x=1772469449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuYgrfs/Q0g/vVNofvxW+PM6Q1g2Ph6NmJqvydo7chw=;
        b=LvgS8d72Vg05ok04ye/+CMCv3Cz2ZcYPaY2z6RvxtitHH7w833/zOeKebq0G59uqoy
         v4YTO7uVnqHfsS1Le+Vmv5+vosHU7YOYh1bSGnH+FmMcptNTIC2p9U9aILCtzzuE5NEU
         HUmeFOo0lHGI67tDr8AiI3gBGWPDuJA0iyBvI=
X-Received: by 2002:a17:903:3d0e:b0:2aa:f0ec:36f3 with SMTP id d9443c01a7336-2ad7457e700mr74915125ad.57.1771864649405;
        Mon, 23 Feb 2026 08:37:29 -0800 (PST)
X-Received: by 2002:a17:903:3d0e:b0:2aa:f0ec:36f3 with SMTP id d9443c01a7336-2ad7457e700mr74914765ad.57.1771864648921;
        Mon, 23 Feb 2026 08:37:28 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e3445fsm96763825ad.13.2026.02.23.08.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:37:28 -0800 (PST)
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
Subject: [PATCH net-next 1/7] bng_en: add per-PF workqueue, timer, and slow-path task
Date: Mon, 23 Feb 2026 22:06:35 +0530
Message-ID: <20260223163641.755200-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223163641.755200-1-bhargava.marreddy@broadcom.com>
References: <20260223163641.755200-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260115-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DCD5E17A2C3
X-Rspamd-Action: no action

Add a dedicated single-thread workqueue and a timer for each PF
to drive deferred slow-path work such as link event handling and
stats collection. An interrupt semaphore guards timer re-entry.
The open and close paths now start and drain these resources.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 88 ++++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  | 19 +++-
 2 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index b8e258842c6..a1bb1f01246 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -101,6 +101,44 @@ static int bnge_alloc_ring_stats(struct bnge_net *bn)
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
+	if (atomic_read(&bn->intr_sem) != 0)
+		goto bnge_restart_timer;
+
+	/* Periodic work added by later patches */
+
+bnge_restart_timer:
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
 static void bnge_free_nq_desc_arr(struct bnge_nq_ring_info *nqr)
 {
 	struct bnge_ring_struct *ring = &nqr->ring_struct;
@@ -1960,6 +1998,7 @@ static void bnge_disable_int_sync(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
+	atomic_inc(&bn->intr_sem);
 	bnge_disable_int(bn);
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		int map_idx = bnge_cp_num_to_irq_num(bn, i);
@@ -1973,6 +2012,7 @@ static void bnge_enable_int(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
+	atomic_set(&bn->intr_sem, 0);
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 		struct bnge_nq_ring_info *nqr;
@@ -2517,6 +2557,9 @@ static int bnge_open_core(struct bnge_net *bn)
 	bnge_enable_int(bn);
 
 	bnge_tx_enable(bn);
+
+	mod_timer(&bn->timer, jiffies + bn->current_interval);
+
 	return 0;
 
 err_free_irq:
@@ -2552,8 +2595,14 @@ static void bnge_close_core(struct bnge_net *bn)
 	bnge_tx_disable(bn);
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
+	/* Ensure BNGE_STATE_OPEN is cleared before checking drv_busy */
+	smp_mb__after_atomic();
+	while (bnge_drv_busy(bn))
+		msleep(20);
+
 	bnge_shutdown_nic(bn);
 	bnge_disable_napi(bn);
+	timer_delete_sync(&bn->timer);
 	bnge_free_all_rings_bufs(bn);
 	bnge_free_irq(bn);
 	bnge_del_napi(bn);
@@ -2700,6 +2749,23 @@ static void bnge_init_ring_params(struct bnge_net *bn)
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
@@ -2784,6 +2850,17 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
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
@@ -2799,11 +2876,13 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
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
@@ -2812,8 +2891,15 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
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
index 70f1a7c2481..f7446b7c4ba 100644
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
@@ -281,13 +288,18 @@ struct bnge_net {
 	u32			stats_coal_ticks;
 
 	unsigned long		state;
-#define BNGE_STATE_NAPI_DISABLED	0
 
 	u32			msg_enable;
 	u16			max_tpa;
 	__be16			vxlan_port;
 	__be16			nge_port;
 	__be16			vxlan_gpe_port;
+
+	atomic_t		intr_sem;
+	unsigned int		current_interval;
+	struct timer_list	timer;
+	struct workqueue_struct *bnge_pf_wq;
+	struct work_struct	sp_task;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -556,6 +568,11 @@ struct bnge_l2_filter {
 	refcount_t		refcnt;
 };
 
+static inline bool bnge_drv_busy(struct bnge_net *bn)
+{
+	return test_bit(BNGE_STATE_IN_SP_TASK, &bn->state);
+}
+
 u16 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr);
 u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr);
 void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic);
-- 
2.47.3


