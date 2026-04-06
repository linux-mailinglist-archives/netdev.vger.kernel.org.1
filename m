Return-Path: <netdev+bounces-275684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAELA+/102k4ogcAu9opvQ
	(envelope-from <netdev+bounces-275684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:05:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B65B3A5FCA
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73AA6301F7BA
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5892392C40;
	Mon,  6 Apr 2026 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y8DPPwyP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com [74.125.82.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7430639183A
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498705; cv=none; b=U9O6R08SFZweN7UFpAOoddy4fiPqfCgypg06SQcJw3ynpmpRHMhpfuZGHEb1XNvGhPopQRI6/I2OL1d3eaUVWVArt6SghRgydgl4ZN7Ojg1wGZm4trufoDFLUXanE/Xl0+Ego2VylZKTMbgEo/ssLfKOIQYvykVE3S7w7DD8ZWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498705; c=relaxed/simple;
	bh=EYofg1gpQ9rfOnBFkagL/sjEY+BAK75kZAJ+LOzBbnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mj8dP4D0/cC5CGS8NOBcAIWCq8/BhMbGU+Z7TmXcUw3hgrEMhZxphW+zvaUhW2/xWs7JleF6YPsy5lEZLzZ4DOEiOhzHYTa7GsWNr8CShbs3uYKQaTnOIneKvAbb/iO3mz+gYwJ58GDZbyN9rAVjT38LMroos802lAWRTvwTwUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y8DPPwyP; arc=none smtp.client-ip=74.125.82.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f228.google.com with SMTP id 5a478bee46e88-2c7d8bbad06so9470011eec.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498704; x=1776103504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFGH6qymgtvzYwWHNnXSxQD4gLAcLHVZRmJAUNjPk0M=;
        b=qqpGejw6Lh4QRDa3t5jvn50qlzehjpffsK/cv0rOeFBJiE+QoERAdZa6DAlEhue/Er
         TAuPK/j5IBrY/gsE4jofw8RacCrOUhxhYPGz8bEyph0GlH4BQljbEEdoqrrWr8g2lOxE
         RAdZI1oQFE23RaahSipkjhVdN6HZqJZRlzyrS3uQMmSgZ2MtHaSrPEKv6wERKxKGek32
         zj0nm6wEps6JwPGWXimIaQUYnbvKWRg9Qi8FJIYowLBJ+7uphP6/Nvx/78PGCg0bMu+c
         1Pa8gl44Ey7u0ChEzXdGkXLRroZOXsPtjbnuVxpF+vbViUdFz3INVK+f8C9NhWOcsu0F
         /xZg==
X-Gm-Message-State: AOJu0YwVSKvn3nseXoid5orIbIlxzylsnTK/Mg+THF87e59/I3Dr8Zod
	EP/qSVwgtqqGm74Zx/AIpMgLLIHPVK20enx8yQzILmbyjEjVkHl+RV9t4pP3OibImRZs+78PiCB
	1kdzBQYgDBVLB72eHZ9tFWGMxX9DE5NbI/Ejfu4oUtosu+OdP2rdtlTrqXYxXtpps7QelIqJ7PO
	RleMG1mPMWzHCTptEjs1DSyXYjTLUkwpdpmjqbUoszVx+fPvCg/35ScAUhAJEYuKZZQqOp+GtwJ
	3F+8E00OTwhV0QQdw==
X-Gm-Gg: AeBDieuFQgM/f3BGWHV8v6jnkkAIas34/+cxYltsMXUVpIWZE5LfjOh/YDpaJxxJgVa
	98emQTgDs/P0O5Z94yL8qV50yuZdqL6Qv3eGkRMJDKlsUX2iIHod3p4JbL7F14X9uYZyXRrUJ1y
	q6egoe57nM0gnldTT+1QMibzXLij3thHwKH+gT4m2b7t5sw/8amRiwRsvgwUyd5dyY78RxhgDSm
	9Ur7IgqRZR3Vc9hSkmI6waplPLiOJWAHGOGbvVz/F1+S/yvL52kDOu6z0l4rbXxZC6/bFmyCacv
	F3WWwZizWJVeUN46LGbMm7sN1sSXFos83fG74T+8sdj3yNe9CUzPoGR6I9a0ndwy/SQhDXKXjXi
	Ws58YH1shWi3uA3+SGNOZqPWac36smOxzHXoo6ZdqbWlCDF+P58qJ7Pn99kEK/X5Dq6duXgbeaN
	hVtQSAiqTAR9tlT0GuUl+dGlrfY2AaYS3x3FPCaXYSdwPsy5wwm1w5DOzZb3AoCFg=
X-Received: by 2002:a05:7300:e8a7:b0:2c6:31f0:a025 with SMTP id 5a478bee46e88-2cbfc4623eemr6738807eec.27.1775498703401;
        Mon, 06 Apr 2026 11:05:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2ca78dfe619sm992966eec.5.2026.04.06.11.05.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 11:05:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b24cd2e2b3so45096115ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775498701; x=1776103501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFGH6qymgtvzYwWHNnXSxQD4gLAcLHVZRmJAUNjPk0M=;
        b=Y8DPPwyPBXgXCRcswyXZhBPbM2Sc8+KbbBDMK0w3auduQKiEpgT13BR+R2YPhpLryT
         yAVj9MT9nlEdR/ztCUksrWbGYNeb0J1t0NQXXxj+6SOy7FRzhpYeKoo1Weh9kGhGPVFo
         He7JTmG6CesmLTokYcjk9mtpz0lqAxtijQZNg=
X-Received: by 2002:a17:902:e78b:b0:2b2:4d36:7ba with SMTP id d9443c01a7336-2b2815b522dmr145873945ad.0.1775498701466;
        Mon, 06 Apr 2026 11:05:01 -0700 (PDT)
X-Received: by 2002:a17:902:e78b:b0:2b2:4d36:7ba with SMTP id d9443c01a7336-2b2815b522dmr145873655ad.0.1775498701005;
        Mon, 06 Apr 2026 11:05:01 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a475fsm140625145ad.61.2026.04.06.11.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:05:00 -0700 (PDT)
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
Subject: [PATCH net-next v12 01/10] bng_en: add per-PF workqueue, timer, and slow-path task
Date: Mon,  6 Apr 2026 23:34:11 +0530
Message-ID: <20260406180420.279470-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406180420.279470-1-bhargava.marreddy@broadcom.com>
References: <20260406180420.279470-1-bhargava.marreddy@broadcom.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275684-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8B65B3A5FCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a dedicated single-thread workqueue and a timer for each PF
to drive deferred slow-path work such as link event handling and
stats collection. The timer is stopped via timer_delete_sync()
when interrupts are disabled and restarted on open.

While the close path stops the timer to prevent new tasks from
being scheduled, the sp_task and workqueue are preserved to
maintain state continuity. Final draining and destruction of
the workqueue are handled during PCI remove.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 59 ++++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  | 12 +++-
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index a20dc3ca640c..8d5d828e19a3 100644
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
@@ -2774,6 +2809,18 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	if (bd->tso_max_segs)
 		netif_set_tso_max_segs(netdev, bd->tso_max_segs);
 
+	INIT_WORK(&bn->sp_task, bnge_sp_task);
+	timer_setup(&bn->timer, bnge_timer, 0);
+	bn->current_interval = BNGE_TIMER_INTERVAL;
+
+	bn->bnge_pf_wq = alloc_ordered_workqueue("bnge_pf_wq-%s", 0,
+						 dev_name(bd->dev));
+	if (!bn->bnge_pf_wq) {
+		netdev_err(netdev, "Unable to create workqueue.\n");
+		rc = -ENOMEM;
+		goto err_netdev;
+	}
+
 	bn->rx_ring_size = BNGE_DEFAULT_RX_RING_SIZE;
 	bn->tx_ring_size = BNGE_DEFAULT_TX_RING_SIZE;
 	bn->rx_dir = DMA_FROM_DEVICE;
@@ -2789,11 +2836,13 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
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
@@ -2802,8 +2851,16 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 void bnge_netdev_free(struct bnge_dev *bd)
 {
 	struct net_device *netdev = bd->netdev;
+	struct bnge_net *bn;
+
+	bn = netdev_priv(netdev);
 
 	unregister_netdev(netdev);
+
+	timer_shutdown_sync(&bn->timer);
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


