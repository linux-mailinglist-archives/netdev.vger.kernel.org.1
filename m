Return-Path: <netdev+bounces-267909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DU5A7K/tmkWHwEAu9opvQ
	(envelope-from <netdev+bounces-267909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 15:18:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA93290F6D
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 15:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A25B3004D30
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 14:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D16E3659E8;
	Sun, 15 Mar 2026 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xj4IYUpy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407EA30BF4F
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773584285; cv=none; b=ptSaXoVy3PgqXKA+4V1TlKsMuOSt4AgiW0Zh+lMoMcJErcjvJ7dU+1ZzgUNMzanJ01mKMR+Jz7/6L02Jfgzo5lYwHDEZji+gG0KrlTgjQgqt6JHVWzGs9r/ungxZkPyedQfXC96PiHPLD43clsYyrM865hAmC2hlmLE282Z3jms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773584285; c=relaxed/simple;
	bh=GHj4gnVfqLy1HeDDSWCa+CadU5S47idNlQd8tGCXirA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcXCr11HcignjxvBtHSxcF8mfCB+sAfsmV7NiHMgaC9S8Er28PlQwZJjSC8sqsYm+WNfIjwZVHXVx4baH0B1bbiImbw7+aZRglJpx0Z2eXdjMp2qIaHo2QUlADV7tFE+b9zIHhEChmzc+uU6W1HLjKCKdVd4XFV/xtachjjLadk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Xj4IYUpy; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-c736261ee8dso1223171a12.1
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 07:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773584283; x=1774189083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnswXBu4PbkASqLN0BN/EfUVHnS5f3Y0TgpC6FNdc64=;
        b=XznV9UPKN3goorIZg99BOqUVhw6NO6v68XB+Gx1HSVKWYKPMgaY4xrFNaeTzQUTG6P
         n18tjiiTD/2XrEUQjdJfJ7EnG+inqHOczdwKbZzE1Dk2AT1W0RZck2dpgqThmY4C656f
         KblPZth3S2a0q6uTMfs3O/9odP5PPPBMBc3MWL9eBu7H8RWwKqMcnYvDTRyUQN41n0wq
         3v1fBsxq8UkAQcYCM9uwoKwhDeV2T2wnXfK7I2blyI57G9ZpwrPsEzzdIVbReAO9y9rm
         PMeutyBezg1ozMoIAdorM4l/7lLydi8xX3oa5bgtmqtKGSdjr0cLw3gUa4XqJ2ashJkX
         VZMg==
X-Gm-Message-State: AOJu0Yz8RiV4kQDkDeQT1jXw2C+9/Y7pXsM4fVROC65V5JTRU5iuwmaq
	oUNqRa25v95Rfs1+vuXdA1IHsp9x5Isz/Q93BKQWTN7gzFi8P01d0nvx7FDzNtH7iPIppBx6jhs
	j2RtosWmrp2hATuDzkVivC0ixkeurMMWb8oL0HxXjPUukVlMWuZH+ngwro04XDOY5QnnwL8zqZd
	69IxJzntrwCNworoWaBgq+ksC5rOAOVuiHqN9wdrfZJG03OKcdVu3dNjc+bYvzlVTJ4IEERYzXn
	NYwtplWdQ==
X-Gm-Gg: ATEYQzypgQvz7uuVkRgnyBNaVNSo7UzEmbPafl+eoiRa20uBnxzbOi0PpPIk9mQuqex
	cd8pTL1uEAvKOT5kXUzvTygd2c/3C8Lvd7ip0DzF1j3syFzJ+6RqIIXJpaA6l9iubzMklbzZKtD
	NukvYHwl1QS/PsomA0MCKSXJIESBw2M1CkbSxzIQUVZZXz7ViiblcbXuy55vE+iJIC4gUSVb6yx
	qm4w+qbukIv3vPnH1TaqQt4Oj+y22zrFmw+5dATXaQtzgsnNfRUbWTulNzt/yaQkScMTW4ZMogV
	VkohkzpwjurLR4+CITHEaHxfl5OcxfLDRCXSDzozLHlSjaEf4hUKjgMyGO8TYPqY7X5qGsypbEE
	VHQtk9qnBsLh19mfur/b0s5FNKxnuMkVQy7DcyfkEmT3QeiPh01LWzvo0V9ajBtBlYHQrvK9tLf
	wkCd/r/E//oMEdrWt9Ps0MNSvfTMaRKZ5vZQo+M3YcbSPeF4Kv6wnGnXs=
X-Received: by 2002:a05:6a21:6da1:b0:398:7d6e:27f1 with SMTP id adf61e73a8af0-398ec9fe3e6mr9163412637.9.1773584283499;
        Sun, 15 Mar 2026 07:18:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c73eb990d24sm628480a12.4.2026.03.15.07.18.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2026 07:18:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aecd4f7c37so29605975ad.1
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 07:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773584282; x=1774189082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnswXBu4PbkASqLN0BN/EfUVHnS5f3Y0TgpC6FNdc64=;
        b=Xj4IYUpyRAIDgFSVReNWDXUMvDN4Jo//bWEL6CYJzFXYobGwnux8StUs70f/h3IjFy
         GS7MDnQgExPTmrqilHXiZdIbgcaRh9QXlgbEmrgK0PWuT+Krst5Spa0J5qTI1vd3rSWQ
         XSrugW++qAst9nhSQYgrHWpcGs7C92l81UjpQ=
X-Received: by 2002:a17:902:d48b:b0:2ae:4d23:3364 with SMTP id d9443c01a7336-2aecaca2054mr95737955ad.52.1773584281664;
        Sun, 15 Mar 2026 07:18:01 -0700 (PDT)
X-Received: by 2002:a17:902:d48b:b0:2ae:4d23:3364 with SMTP id d9443c01a7336-2aecaca2054mr95737645ad.52.1773584281196;
        Sun, 15 Mar 2026 07:18:01 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56c393sm76185395ad.17.2026.03.15.07.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 07:18:00 -0700 (PDT)
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
Subject: [PATCH net-next v7 01/10] bng_en: add per-PF workqueue, timer, and slow-path task
Date: Sun, 15 Mar 2026 19:45:56 +0530
Message-ID: <20260315141605.410878-2-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260315141605.410878-1-vikas.gupta@broadcom.com>
References: <20260315141605.410878-1-vikas.gupta@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267909-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0FA93290F6D
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


