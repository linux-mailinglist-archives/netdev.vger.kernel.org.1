Return-Path: <netdev+bounces-269303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ITNOByPu2lmlgIAu9opvQ
	(envelope-from <netdev+bounces-269303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:52:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A287E2C6585
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E21EE3013A67
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1783E313551;
	Thu, 19 Mar 2026 05:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O2EZkfe6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62B92BE7AB
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773899545; cv=none; b=f+cYqHSw27ze3Kua4Ha9+axI4bpIxsZfu6QDCXnHaQRaDCVfmndcPi2WmvFee6ezV9OrYm4F8Qb3Ra8CfKx1CqLfqvCAhXrnddSKjjvHNkIxOTbnc3sCzCeSDHIR5OdJdTNxUjjlZmScuTEw+j32tdbbv5UrYYc7Hk5JXqhwYp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773899545; c=relaxed/simple;
	bh=GHj4gnVfqLy1HeDDSWCa+CadU5S47idNlQd8tGCXirA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMKlUZ5D1YGAjAGqf+SyTDh0dTdNPwEWUoccTwQIqpj3IsGo0xmbaGGj07o12ppEftE2yXZrOvaGSiRgmZzYaT9s+YxF++oF/iJj6gMu1oAgQsFTFZB3cb5fIcHlXyPI6WHgtlI+1oIrdCnzxInJZ/f/LpMUCY5X/SnCdrQGGsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O2EZkfe6; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-56adf76631cso228917e0c.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773899542; x=1774504342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnswXBu4PbkASqLN0BN/EfUVHnS5f3Y0TgpC6FNdc64=;
        b=YxCMvsulMWws2ni0Pi+3MBZmJOcvZUQ+sXbWcBLGAfOafCf4SJAXrz7FG0KDa+8TuJ
         at9aEIITnxROxSDF23Dz+7IKWQR8/cuHzhQAA9A6IWwrCBB5kHUuvSIrtUlO6Qb82ZTy
         WQFwWcqFkzjvfNfEkZEYlPUqFFFJRpZ1AXWzKU3mknNKjXyR8ibnpuwI3ojKQi3JsXsL
         i1NKB/S/iZxsAbK3tbKadT3oS9zMzV8+q3bkEksoo6JC3UbkSouGSYsvFsSaGT4rFyX9
         y9hQkN06SgwuhCzUHEA6caQEn++D/hMcC29dmL+n86tfxbwmFg1NhPMoX0trcApDAmTL
         gITw==
X-Gm-Message-State: AOJu0YyUyF/ilQuzzuvTqXm6Xf/hqv7EFd/eTnY4TiiyiwqfXy3lQaex
	bpkorNhoIV+XJsbgb+6u5tZMbOso3EHQ7Di59e3PlYetFISIwiJXjLbIDpjNtsdEJdM72fzxwJK
	n4uRdm7ZoYV6RWWvR9fZFdwTAgqleqaegkNV9MFQKEtPaybOOEExB0m041CYGJ1TWALXIzlf9v1
	7uR9h8M464qphliHzn+KOhlo1fvekm9zb70icJiOvVeAF9DfHCjr05APZDGIdZ499dyQgy5evMl
	jF+UI13xA==
X-Gm-Gg: ATEYQzyt3em2I88A4AYKbCnpl6jyrxkujLHH78MpW6XbphrFk4YXAKWXAiGFFkubnSD
	9bmeTtdGy5k8ET3tqR7HlyqWIKup7XCGdKMHYaVQfOmpGM2rDKnVfnuCuPjZez/54x0Kd2Saxdq
	ZEGuXf6gbk3HinzypLJUj+NHOwSrQ7xDv0RO3OYYm66dHtctuhOX1j1dkdFR8ZY3pAZWRXYRN5/
	36+b4Ang8EeYmGSHP3YoRVY8gc5iO5lbj6ZkD9rfrAnDcCL2ouCXl/PJ34oFi/w9E8ZuC56lzRF
	C6C/Nv+tgeqKEG0GMKK1jwkXsUso8ZvTCw45Lfy+23yXE9Dh6nhvQi/NNhSevD7IdmSr8H+BxGc
	T//NutfaKJKy03NHZGST0a0GnBJIfa/kUZuIsQNEyscRIGhIKNM3sBQsRPy7PeQqNNN/okFRNqI
	vRDj6uDnei4mzMMgDnhlJBD4oUhBQTnRJnp/3RXdOk8KkOHTLPurCfS9XG9A==
X-Received: by 2002:a05:6122:e1b1:b0:566:341b:4dde with SMTP id 71dfb90a1353d-56ba6e10351mr2893183e0c.0.1773899542229;
        Wed, 18 Mar 2026 22:52:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56ba6ff6390sm515022e0c.8.2026.03.18.22.52.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2026 22:52:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-799003e8a77so18767777b3.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773899542; x=1774504342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnswXBu4PbkASqLN0BN/EfUVHnS5f3Y0TgpC6FNdc64=;
        b=O2EZkfe6G3V3jWc9FBmTF1esjwY8ru9SD/DnPaRfq5yte0q08r31lCg2ChhuoCtS+B
         taDj8c6OTuc4e2BeTqDBCfvbCMkCtU4RMyvSvNXasccDFP8YARkbUN2VugA4973O+FfU
         AmU0TcCRdDGz26RVzs4bmtpKRASds1sk5aG4o=
X-Received: by 2002:a53:acd0:0:20b0:64c:ed48:dc84 with SMTP id 956f58d0204a3-64e915e1f9bmr5461709d50.63.1773899541683;
        Wed, 18 Mar 2026 22:52:21 -0700 (PDT)
X-Received: by 2002:a53:acd0:0:20b0:64c:ed48:dc84 with SMTP id 956f58d0204a3-64e915e1f9bmr5461693d50.63.1773899541207;
        Wed, 18 Mar 2026 22:52:21 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91a1cd32sm2918980d50.2.2026.03.18.22.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 22:52:20 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
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
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next v8 01/10] bng_en: add per-PF workqueue, timer, and slow-path task
Date: Thu, 19 Mar 2026 11:21:15 +0530
Message-ID: <20260319055124.1350670-2-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260319055124.1350670-1-vikas.gupta@broadcom.com>
References: <20260319055124.1350670-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269303-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.972];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A287E2C6585
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>

Add a dedicated single-thread workqueue and a timer for each PF
to drive deferred slow-path work such as link event handling and
stats collection. The timer is stopped via timer_delete_sync()
when interrupts are disabled and restarted on open. The open and
close paths now start and drain these resources.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
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
2.47.1


