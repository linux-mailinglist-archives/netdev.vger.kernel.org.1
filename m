Return-Path: <netdev+bounces-272670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGxnMxzoxmloQAUAu9opvQ
	(envelope-from <netdev+bounces-272670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:27:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3594D34AEFC
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF0F7314814F
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89723BA246;
	Fri, 27 Mar 2026 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W5InJlgb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f100.google.com (mail-ua1-f100.google.com [209.85.222.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31033B8BC7
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642485; cv=none; b=UxcPZ8l1eslPrwpOS/5IE3LsiKJJr+mMPdktRxhRvMsCZgZyKF2/uK2cLnJsL9dMorVx5HMl7QDVWWCn5KzIPRJmeakB5j055gpVI1fmKkW7SKhVOSp/pFK2bpHbx9ngGI67GDOn7KTr5PcobNLr/kFAZInrRBAgLiGEHjmy2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642485; c=relaxed/simple;
	bh=9BEpjmp9nOY5DRU+Jtpsc0UKBcTVnqB8P6BDC8FesrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acP9HjpJgyr7knkeixtcPOyYUU6sjg4AOUZf5IFMxIQm3pvbw9Y6QUlyGMKVP73mqoxDf2dwVLtJfucGH9S0DrKWEq9FWE3ZFP6Ahk7N9kt2kKIccAv1cAUgeP4JYBUgqjCX/+E3bvzqpV9o39ahyC5BAAysjtPYooc5s0Eiu7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=W5InJlgb; arc=none smtp.client-ip=209.85.222.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f100.google.com with SMTP id a1e0cc1a2514c-94aaa5d3bfcso1475289241.3
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642483; x=1775247283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3dsqbgzmgrM2syDH55uS3n72DeAQsAumcT48/HQSyA=;
        b=eVxeYwdZ9Horoccg6EQFwXYzjxUXJoIYSOb9TLhHAzE9SnaLKH+07RH1GEGIjEfzo+
         lq2WE4MS0Zmtl6vQMxENOSOiIYrol/F5jLtyI2s8HlCppFFM+Ng1JRPOwr/7IIA4krNg
         gfb1rFcH/ul6hVTq+sxdySfuQrLIesP7my7GPpJS8ijJWSE9pMVElVIpR4P65oI4mzh5
         Ybu0Sndleg0iS1piBdbFW3mO4mpuJoWo8t6EZjgh4rMdlH3237VOqyE2ZGXvdnxXc+Vx
         mKo7815XIkiEBILiRPmXy3/p0caHu8lKLnLXQe9qp/SK63fLVJxHlE4XHjwQU50hQtvv
         dspA==
X-Gm-Message-State: AOJu0Yw/Ux0wUHh+C9Dafu2DunsiDDcPJeTh805Ovwl9NGauMjBwM+n9
	0+AWDyv5HFxJrFemw1Ezi8pw9KjMkmnNUgbdYUhNnGUwFIQLZ4yNI6OG6yK01t2NqUrk/toqju8
	db1f2rx4PYKFRnesOiiAukKZcGGZnUeCfiHs9HHqOGfeideloFCXeTYLjLw+h2qFpjY8KEobin4
	+bVdJAVomzMJzWVgLN72XMfeg7zLycMDadEI/13iiIHk16uYMamEy89w7nHC/atz2fR7LGGpfr8
	VTNMqZgtgQ5t5sXEjP3
X-Gm-Gg: ATEYQzxv+hcy1VwvhM29C3AOFhnzGJhmkHtJk0SF1U178pLn0sxeZecbjduwe84v+CU
	xpEOm2ovOTi0xR+M34SN83LjNm5n2YPCGdU/NJqtLlKZgw08JJGzKTJ0RFCZDwETFB23Rovjhde
	BupKDMwUcawVXPCRUQlJXM41eIxtgmq2qOMCO9xXsu39qnbSfffaGJpCmH3J/4Xp5E4h/428e/j
	c72JtKX00pjqa/aMwEa3soBcwYjy/J3QBHGdRdP+yqC4aqLpsUsa7/2/xKZY2TnVR4fKwKmp3lK
	Ab6JBMUec6gmnM7S1XLJiT1BXaerVjb3tWrGSSanG3G+STc8tlEUQ5yyHRatKP4FepFWTgr3pPu
	QpFnIdTrtwWYvQoXI8Kqq7RH6ckErFFCt1sFgNPdJK8JzKx+Ahq1mdIjgaukTK1FNxZ6QtV4pq4
	HdxIcL8b7Fha/bTkY4vGkIbxDmJKkMR0phkxXzwrAL3QoVw2kXwqUqwTreBa5whhQ=
X-Received: by 2002:a05:6102:6883:b0:604:f092:4eb with SMTP id ada2fe7eead31-604f90f7220mr2184664137.16.1774642482713;
        Fri, 27 Mar 2026 13:14:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-9539e3b204fsm4555241.3.2026.03.27.13.14.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2026 13:14:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-79895ffb315so55339587b3.2
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774642482; x=1775247282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3dsqbgzmgrM2syDH55uS3n72DeAQsAumcT48/HQSyA=;
        b=W5InJlgbtlZz4/ijIQGgtGZhCtJ84CsU0Rfj4ecsyAItR3Qwt86yj1kTslYuS18tDA
         4XqkZqshpsAN6VqtHVpCm0hX0bb2v3cPL8E8w52hKkS7gMF/7SaqEQr1ZAJFdqpgoHV3
         271S1LWpccpAUmlpopbpR4o18lXXc2jlVBwjM=
X-Received: by 2002:a05:690c:e3cb:b0:79b:d2ea:8311 with SMTP id 00721157ae682-79bddcbaaf2mr41247287b3.1.1774642482093;
        Fri, 27 Mar 2026 13:14:42 -0700 (PDT)
X-Received: by 2002:a05:690c:e3cb:b0:79b:d2ea:8311 with SMTP id 00721157ae682-79bddcbaaf2mr41247037b3.1.1774642481614;
        Fri, 27 Mar 2026 13:14:41 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb9a8f324sm119057b3.28.2026.03.27.13.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:14:41 -0700 (PDT)
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
Subject: [PATCH net-next v10 01/10] bng_en: add per-PF workqueue, timer, and slow-path task
Date: Sat, 28 Mar 2026 01:43:34 +0530
Message-ID: <20260327201343.16146-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327201343.16146-1-bhargava.marreddy@broadcom.com>
References: <20260327201343.16146-1-bhargava.marreddy@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272670-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3594D34AEFC
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


