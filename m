Return-Path: <netdev+bounces-266183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAOLCDZAsGkehgIAu9opvQ
	(envelope-from <netdev+bounces-266183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:00:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BDF254315
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 426B9325FB85
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0802F3C07;
	Tue, 10 Mar 2026 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I/iJSqm6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7665264A86
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153712; cv=none; b=CQ1Zw2T1r5No0YDNCkbHiTbynpBBR4nrCPvW7eOU4mVWKh5PmfHMhLGsbBFG5AGPC41ajOyQ8SpLhhYTV0JPqhnxJM5BALg9Hmy1a1CKluWdfM9Lu5PYdTFo4RPklSveyya1V4tz887hE444MSttRPYU5EpSw3sa0DuCZFnFFd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153712; c=relaxed/simple;
	bh=ySQy8CSrm4/UQYQ/rVVTsVt3TBD7/hFBFDy3F0p9YuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvCVqyOZz6Lsp3tp2NUyNYDq/twuFjAt1cwK+ZUIMWRmuL+Gs0KmSehGy4IA69zfTfB/IdrX7y8SBMiywD3ID6rJm0zR8b2KfLhXk7jIKVa/ZJBGSmVm6A3BbpY/Q4Zc+YC9A9I+3B5tjslVFhD0ZFk4BJqPe3zjImgz7RQKSt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=I/iJSqm6; arc=none smtp.client-ip=74.125.82.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-2be27fa54feso10991397eec.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153710; x=1773758510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRikypN/LpT75/NMboweiLacdsHYIINoiM+NXjDT2RA=;
        b=ql5cSdt1vfD8c7GUvnt8C7djz1gOEwL92eILsVSxWG7hLCU44VxAfNcyw+X17dKKZ/
         p4JD9TQ5sut8eUwsZFV3qMjZq4NrCD23XIhfY/9R7Mv4wRqXcQWNtycASTiZ++xzowOb
         CUqhSjm4Qs8c0OpDJ9K1O7rpOH879mYy4dctU6g1r17vPcuoiGPxwfLXwDxw4iOH8hqp
         PbmJH2lnO5s5Ecq6v+xdwnJ+QyKtBEmQIQ7m0dIRZmRNZxCzomp3sUh6PkcItLze88e5
         1flONWtFbMUPK9eHBry2FNtHX58a32l4fhbDa06WGmfcwSKpu8mX3UzJvbu5vu74EMq0
         p1fw==
X-Gm-Message-State: AOJu0YzB7/2plvGDbzx2y9f4TIG6DswJDMGCgqlCBYFY0VjRrSbHr/0z
	66nK/zU5LGLCuNZb2LbAKDTRjxcF5p2zyEzWkrqdwjiAlnKhT8IMoNTZ65OtjfhXwoLTkXo0A72
	X3x/h/0ixQCKk9XL1eCxsGdNwha2G7QQ83liSRqC/pCLU3vURVEQ8ktTxIKXKCsxSzEuP7TB64Z
	gaQPHW0mL6Fl0TD41iSI9+zkgNFWw389daZuj+Joi0kl+8mwCOC57VQuu3Mmm/FPfue4mrF2irh
	M0aY9zSAeo/LDefJw==
X-Gm-Gg: ATEYQzx2AzN87e8xEa9e9fjPW9n12RnFsUhEW+YKtfehiNs/FwuwaqtQxMl/RqLeI5s
	2xzLFqMSrPlaIylExW/wpe94ml9cuha2wr0R30/wVyJNQTzP6JrIJgcPC3DC92iHH82vtYtALhY
	XXxI58NNn8+O52cX5vbFWHcqT11wk0J7AVeV1ZvPK24gHblL+1W/9pE6M6jALhaHlGiMP5hnr7p
	X0T+SO6HaBfgEkdASwDTEPeagpaONnsXATICcXs5Mw8MHvWBCXlbyOv21+gZ6uXsR93JVodjBom
	FzOH+YfshULiwHqlKkAxZ27jd7XQSr7fikLxseozB7l6NReLUV3VUW+216+9PhtHBufqUOydLZQ
	HleOJ+gpGogM27nT9pOpdXvN0tiESEm7CcrXgUz5En1GxaHUfAtQB8bvdmA9eWkBD8tQ3EmZEnA
	8pPhMNlKC4+tsQwUR1PUa5rbwBcMSP0mnx0j29CBA4ufNx74PBuUtXQxOZc+3w3dgaTg==
X-Received: by 2002:a05:7300:a985:b0:2be:10a6:647e with SMTP id 5a478bee46e88-2be4e055786mr5881281eec.19.1773153709654;
        Tue, 10 Mar 2026 07:41:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2be4f8f0728sm1212961eec.7.2026.03.10.07.41.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2026 07:41:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae49120e74so88707275ad.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773153708; x=1773758508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRikypN/LpT75/NMboweiLacdsHYIINoiM+NXjDT2RA=;
        b=I/iJSqm6HgJT5X6rRRcffcpeWsCpQX5VaVHXQLW+yVsyX61HzZvWbPpzkxG2bFsiNL
         ThAKzJ3AcfcKrNm5cJng2z/pVdE6ZZ6TQSfAppeeyhenLXslRjxBeSuSp9+fmcX9hdaY
         WaZWWc1C1b6jMoQHTQq5QKddyqVEPwV8egP1Q=
X-Received: by 2002:a17:903:1cd:b0:2ae:62c8:771a with SMTP id d9443c01a7336-2ae8241e451mr158896265ad.5.1773153707944;
        Tue, 10 Mar 2026 07:41:47 -0700 (PDT)
X-Received: by 2002:a17:903:1cd:b0:2ae:62c8:771a with SMTP id d9443c01a7336-2ae8241e451mr158895975ad.5.1773153707496;
        Tue, 10 Mar 2026 07:41:47 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f783cfsm157096515ad.56.2026.03.10.07.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:41:47 -0700 (PDT)
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
Subject: [PATCH net-next v6 01/10] bng_en: add per-PF workqueue, timer, and slow-path task
Date: Tue, 10 Mar 2026 20:10:35 +0530
Message-ID: <20260310144044.21672-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310144044.21672-1-bhargava.marreddy@broadcom.com>
References: <20260310144044.21672-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 23BDF254315
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
	TAGGED_FROM(0.00)[bounces-266183-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
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


