Return-Path: <netdev+bounces-266168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PVONPs3sGkKhQIAu9opvQ
	(envelope-from <netdev+bounces-266168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:25:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D73825356E
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 852273121AA6
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28A038D6B6;
	Tue, 10 Mar 2026 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fVhfhchi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C5C38D6B2
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773151302; cv=none; b=NRCzauOBGwn52OS2ANSeP8/WyLDZ32O/JFY4bMRu8nu/XXIBhIr5xSzAyKa9CnsnuKVZCNJn529IfK5YiIp5S5NduBTqdWKbphv+MrXHbSG/zKdRbsNcnHQWrvlX63PdlkYUc6WE1yLdIJQp01VLSiyM/lUZjrOYmCRL7hU55U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773151302; c=relaxed/simple;
	bh=ySQy8CSrm4/UQYQ/rVVTsVt3TBD7/hFBFDy3F0p9YuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiBDhgJIT2ByCTnNCfLx1XC3RUJ4GBPHtBwrenGZllR6Lrz1azTaQWLXTIf0uTyJ2vWY/Ntc6Yb16/08mkdmjFzdVe9Z6G2E0ifU37aZK3lcc6WUljzecshMmUwwAB+g6iihD9x1VUZSASyo9ySsJOQzN/vNWE6Mw7+a0ZSbF6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fVhfhchi; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3598c1ad542so5828061a91.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773151301; x=1773756101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRikypN/LpT75/NMboweiLacdsHYIINoiM+NXjDT2RA=;
        b=Oo/EkHnchA3lUJQ5xTFPp88+2vAX2QWnOv2B8Wj4sR051RhW1TEsytVRbNEak6hKsS
         T4DeBbByals3NiIPCfE/JwjlnGuD7a8I4PxX58Dp/wIoIKjaCWP4T5wWcNi5PmcGrlOz
         mY6sm8n+RVXSc75z5uv7soAA4UymnlX/I9zXfJCpmNWvyM4OdTvUleszl0AFp4YhhCSO
         uqRO6Y9n5zRjw2Los6JQeYpdW9RV55XF8cCGo1jNkXuw6o9Q7Gpi7Z00pkeGvd4DbWGf
         QMeIne7K6zjjsF/MPqcs3Ir7q68ZCaOWGZt+KvEc+7PTl35eF/9Y1AmCbl93eCUhvt4Y
         qyYw==
X-Gm-Message-State: AOJu0Yx2GHUQn8HrNeboyKUcUAfZZqVykmj37aMXrwl0Hoslpe4/C8hm
	5/lNuZAZP2TJ4s0njDrfUHAtLQIXwBgiVbHs37W9gPzHKo2cM2WH4tGAumBriblrT9FkQb01Oke
	WoV4pXfibZlCkQift+8cglDJoQWQAkQ5ljsCZ1MnqxxiW+kn6HGEWI2iSW8vr/LVFt9ISuxxAb2
	2TGxmXsTSnXEFLIKtgC7q95HW7LwN2bbTQZbNS1m7oPGySmsU0wILSb4k7fNnqGX6sZ4vnPWQ+Z
	HdSQlYkFhHfY0dvUA==
X-Gm-Gg: ATEYQzzsbrpkMlUY/S+RN7hO9aHnD69ArZixGwT0FaOrJt+FIbXhQrFKfX+VtK/mPmV
	PJpvtfhBnCW4TIV3CqUtFwvRWtkb9rmvknl4YqBMxoFyq/7VvmmC8s5LqKcCGqILSsvOuPn+hy4
	hSVmCdD3HIrC9EbNHZBB3q5XGbZzoRpIa5pmq2WFxbrimIFG36HAfOBz5rCyKzLesbcIqD0Ll8L
	iS6cIDas2c6da+t7hOQy4FVFU9c3hkbxssFoND5k9m4vjMpztGCvwEqWyJiQEYYNzErfGan2WIC
	CwXeTLQ8x/vosyqmkg9qVDTfTqlbDEDvLfURvIRASIJ8A2igjmtvpLKMyW7puNFz7VBj28t1Jea
	Jg3EpTk4mI7scxWMUJKy0nUg6p5KSb0HYfM/FmHgLHlSnr5RM9RPVztVk7sHLuuqT5QO53mO6rM
	+mz+Z59DlTc9qGAyJCJs2fXiCR3VVXvm/YLY+kF/vRPux4lwRpavkeEypMngB1Z2w=
X-Received: by 2002:a17:90b:3f8f:b0:359:f8c3:dada with SMTP id 98e67ed59e1d1-359f8c3e121mr1397962a91.13.1773151297529;
        Tue, 10 Mar 2026 07:01:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-359f05f00a1sm307151a91.1.2026.03.10.07.01.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2026 07:01:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c6e7f45e2ddso45778178a12.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773151293; x=1773756093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRikypN/LpT75/NMboweiLacdsHYIINoiM+NXjDT2RA=;
        b=fVhfhchiEfm1FepgdjtqVX85bqOr9CPZ5hqSx2trhfa/Ox+mLz/YHMolosukaALiof
         Jxnd+F/8L+2X5qbdieowoKk0oh9vRKs/eu1C2Zf7/fI4FsJpbdyNEvGaRgbbooiDQQjm
         iHpnvnnMaBAUh5h2YvZgGIJXKrLRIN0qHd4ME=
X-Received: by 2002:a05:6a00:7581:b0:827:34c2:87f5 with SMTP id d2e1a72fcca58-829a2de1a15mr10171656b3a.8.1773151293167;
        Tue, 10 Mar 2026 07:01:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:7581:b0:827:34c2:87f5 with SMTP id d2e1a72fcca58-829a2de1a15mr10171555b3a.8.1773151291883;
        Tue, 10 Mar 2026 07:01:31 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a465b6f7sm16885202b3a.23.2026.03.10.07.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:01:31 -0700 (PDT)
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
Subject: [PATCH net-next v5 01/10] bng_en: add per-PF workqueue, timer, and slow-path task
Date: Tue, 10 Mar 2026 19:30:23 +0530
Message-ID: <20260310140032.20893-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310140032.20893-1-bhargava.marreddy@broadcom.com>
References: <20260310140032.20893-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 0D73825356E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266168-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 74 ++++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  | 12 ++-
 2 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index a20dc3ca640c..edbb42efb70b 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -101,6 +101,36 @@ static int bnge_alloc_ring_stats(struct bnge_net *bn)
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
+	netdev_lock(bn->netdev);
+	if (!test_bit(BNGE_STATE_OPEN, &bd->state)) {
+		netdev_unlock(bn->netdev);
+		return;
+	}
+
+	/* Event handling work added by later patches */
+
+	netdev_unlock(bn->netdev);
+}
+
 static void bnge_free_nq_desc_arr(struct bnge_nq_ring_info *nqr)
 {
 	struct bnge_ring_struct *ring = &nqr->ring_struct;
@@ -2507,6 +2537,9 @@ static int bnge_open_core(struct bnge_net *bn)
 	bnge_enable_int(bn);
 
 	bnge_tx_enable(bn);
+
+	mod_timer(&bn->timer, jiffies + bn->current_interval);
+
 	return 0;
 
 err_free_irq:
@@ -2542,6 +2575,8 @@ static void bnge_close_core(struct bnge_net *bn)
 	bnge_tx_disable(bn);
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
+
+	timer_delete_sync(&bn->timer);
 	bnge_shutdown_nic(bn);
 	bnge_disable_napi(bn);
 	bnge_free_all_rings_bufs(bn);
@@ -2690,6 +2725,23 @@ static void bnge_init_ring_params(struct bnge_net *bn)
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
@@ -2774,6 +2826,17 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
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
@@ -2789,11 +2852,13 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
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
@@ -2802,8 +2867,15 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
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
index 70f1a7c24814..d2ccee725454 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -224,6 +224,12 @@ struct bnge_tpa_info {
 #define BNGE_NQ_HDL_TYPE(hdl)	(((hdl) & BNGE_NQ_HDL_TYPE_MASK) >>	\
 				 BNGE_NQ_HDL_TYPE_SHIFT)
 
+enum bnge_net_state {
+	BNGE_STATE_NAPI_DISABLED,
+};
+
+#define BNGE_TIMER_INTERVAL	HZ
+
 struct bnge_net {
 	struct bnge_dev		*bd;
 	struct net_device	*netdev;
@@ -281,13 +287,17 @@ struct bnge_net {
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


