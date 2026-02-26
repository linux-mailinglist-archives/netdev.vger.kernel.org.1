Return-Path: <netdev+bounces-261531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E0lASGSoGllkwQAu9opvQ
	(envelope-from <netdev+bounces-261531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:34:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 969571ADB9F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88A58301062E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6072438A2BE;
	Thu, 26 Feb 2026 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MIVm4WO8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60593ED11F
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130143; cv=none; b=fMOrJdUL8dpYCwkTuxOVKEW5FX3R3rMON+zlw+PjvtZpN7fAc+Xh62DMdW8LQBYCmhgB9NfmoXwc8LSnwqp/xuztdqW3SrExKRGb0B1J9hEpfl+Hn4y8jJY27dTT5GaFlW9FPUhHsqOqGoobe4SSriooeG/p6+fW558rXJ1Fgdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130143; c=relaxed/simple;
	bh=cV88O1HPdBJ1+6w3Gg07zJFGsOyrPaGcpk/m8VQovXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b489/zdvXCMxznOSq6jKdq0Zhm/cQcfe1gqNa/YhgRllR26Dvn3Lr4VKW9MWzRzT/Iae3Ieo7/y6KSzQtv4IzGpNKvwA3mPQ7OuHlR2/U28UTqVVUBIOa0rok792OJX0XbMS0bq+/9li+yFESBUQHxIiKN2cc2wkepzdOI/SQx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MIVm4WO8; arc=none smtp.client-ip=209.85.222.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-94dcf70af41so310853241.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772130141; x=1772734941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhhnux0nQTx2lyWd1Iv9Pc2Z2Kf52feY5K+/r+Rvr8I=;
        b=nEV3ymobQSM2Vj4o4uK88C5GFSVNSD5U9db+7s7P+sqkfT3fBvEs+dIgGhbKZRVIWW
         Qa329Vzw1zdTMKUhOZy/NHc7uO0CT0ha6Kidymsh4YIZMTcHElboTPAYLkE6/EPXzpGv
         gfJW1ebOpZ+tJh7SjqJ7HWsPmhQ+XsklRxSY66dzNbDnY7S6CgXNFefZTYxREJWkgVeY
         DnyDuOPbbRap+QxAWk1YWwIWTG9QDKhrXv8R5ZKMFknzw6Ia4mT6uLMahd5hJdp736vS
         ilEyzsLSrmEUEoLFf0j9GVKJ1C4XCnowNgRcS0DO1Yg7ra6V+StdZk4DnaZ+Mm27z4Y+
         WVNA==
X-Gm-Message-State: AOJu0YwvT1ss7Kz3LIIG/T6aYLJk7DEtUyIvAfM3jcKoTTyuQqnp1jCB
	uKXYEmR2RYDCFFODtyBzogqMHDenHDM+mAd6KSPMB5eJHXw3NOdvi/1oXtRy8ywv4riteHKDgcU
	0jgGG1fLfjAZWvYC7m/0j0IlrK9qsSK6TqgjgzD0fSeI/FigtHEhF16HTV4AjKMyyMWCBwVUy0m
	PrXtFl8H8QibVvjATpUVO4+9wvdecc9M45fDP62OXT46kwsA1coXJDCkP/TyY/++OG80rhkfZGz
	2midmQhNCC8e3cVng==
X-Gm-Gg: ATEYQzy3UL4ZcJSKaF4NbK9QY9vA1hePvsh1pPUyR1PwIb380thRXFh5WydTh4z4KMZ
	2OoYMFW6qT6f8nhJxXK2uexKchyMpUUmj8irX8RsI0NcOBjEzwzbfaHFfH9n1xm6masp4bNcJl5
	HOe2bIU9+CVGX7cgTSTYSEjiyivZ88j6nQj+B9V+X5i8iL+XEHRac2r8EWOO7sRLMLLv1635Nve
	atvaAobmbbclzb45tLRN2ywWykw7GKQpHbRO8iqj0aAIsDApVZKqprJhPI/c+XpNEmOo7etyMsD
	3zxAN89sjmPH+7jnI0MSGOxODs7oO3SKa/5vmbHU8WJvoBLsUuBRKOPA4+dmkG//eAJEMcyDgtJ
	lvbvmc5j3Y9OfBDiyLDYAymCcW+NGx9//W7wAFl5ZYCGaXMwJmhLvp1dOlsuB3aHWUFtYkdYJiI
	FqonVqgvpRCn+El0IwMbXtzdvgDUoOD6zFQ21Nui2DW5VnAvIDZ5fiP7P1R4BKI/EVfA==
X-Received: by 2002:a05:6102:2909:b0:5fd:eff4:825 with SMTP id ada2fe7eead31-5ff324d922amr113726137.26.1772130140487;
        Thu, 26 Feb 2026 10:22:20 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5ff1e99a28dsm270294137.3.2026.02.26.10.22.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2026 10:22:20 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35658758045so758420a91.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772130139; x=1772734939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhhnux0nQTx2lyWd1Iv9Pc2Z2Kf52feY5K+/r+Rvr8I=;
        b=MIVm4WO85HSV7rMu/0+QBxSNT2hHTXSkmVWWFtkZPP0VXBEGezOtkhnGoV3F50vaIV
         DyMDtkeugY7EXpxIMagdrWQfpRghiYT0icLEDNsQeo0RmW8V19bIQTjekrPCH+Ol7agu
         E2AVDdYzKW7oMdtvxiJlr4NC7khIJxMQiItok=
X-Received: by 2002:a17:90b:1b45:b0:352:f2a6:334 with SMTP id 98e67ed59e1d1-35965c9c9a0mr113138a91.16.1772130139221;
        Thu, 26 Feb 2026 10:22:19 -0800 (PST)
X-Received: by 2002:a17:90b:1b45:b0:352:f2a6:334 with SMTP id 98e67ed59e1d1-35965c9c9a0mr113102a91.16.1772130138632;
        Thu, 26 Feb 2026 10:22:18 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69ef1csm35941565ad.53.2026.02.26.10.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:22:18 -0800 (PST)
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
Subject: [PATCH net-next v2 1/8] bng_en: add per-PF workqueue, timer, and slow-path task
Date: Thu, 26 Feb 2026 23:51:26 +0530
Message-ID: <20260226182133.1566714-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226182133.1566714-1-bhargava.marreddy@broadcom.com>
References: <20260226182133.1566714-1-bhargava.marreddy@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261531-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 969571ADB9F
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
index b8e258842c6..a9dffebb8dc 100644
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
@@ -2517,6 +2556,9 @@ static int bnge_open_core(struct bnge_net *bn)
 	bnge_enable_int(bn);
 
 	bnge_tx_enable(bn);
+
+	mod_timer(&bn->timer, jiffies + bn->current_interval);
+
 	return 0;
 
 err_free_irq:
@@ -2552,6 +2594,12 @@ static void bnge_close_core(struct bnge_net *bn)
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
@@ -2700,6 +2748,23 @@ static void bnge_init_ring_params(struct bnge_net *bn)
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
@@ -2784,6 +2849,17 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
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
@@ -2799,11 +2875,13 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
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
@@ -2812,8 +2890,15 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
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


