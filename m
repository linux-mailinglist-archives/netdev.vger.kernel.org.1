Return-Path: <netdev+bounces-271273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFssF0nvwmkdnQQAu9opvQ
	(envelope-from <netdev+bounces-271273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:08:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F093A31C216
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC5763039B89
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B153290BD;
	Tue, 24 Mar 2026 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Jv61+659"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f100.google.com (mail-dl1-f100.google.com [74.125.82.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEEA31F9AC
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382904; cv=none; b=LByUXvwiJMBm7KC6dI1ypNvl/tqOQ8MZR5g8JHr69fgyx24MkZb5v95e6qO3pT8RbY9fEB0gqHp+cFj+8oDrOqxPtSmXMLQP3yuHcSskMRH3g2HkAlRtdABcLRY4Oy6CrZgccH2vNjqNJoyd/79CGrkRsmuSWFERWtkCpPX/g9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382904; c=relaxed/simple;
	bh=ySQy8CSrm4/UQYQ/rVVTsVt3TBD7/hFBFDy3F0p9YuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyusWfu/0KGJ1Wdi2G4V0QaiWKeFzg1Oo4E7O2LiAj6mv7Gix0x1dsekijOlK/ZAcFlJfAfmIDKsDOWuR2wRfQHwL/CuIF7VWekBbdGQTlBZJ+htSyF41it4IBvEEun7TAtOsnjFKpbNwqxdOd/hNWmKONRHhhw7YotNbbMpfLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Jv61+659; arc=none smtp.client-ip=74.125.82.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f100.google.com with SMTP id a92af1059eb24-1274204434bso154018c88.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774382898; x=1774987698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRikypN/LpT75/NMboweiLacdsHYIINoiM+NXjDT2RA=;
        b=Xv3CSBxUd91x1xdRzf4xwSS7hG9SrFjeApUcBchHWnChWMhc3K2BsH8R6UmOIE25+8
         8mJfa6iPTCXxA1uhivk4wFVF25C27eDzuTHXpST7vUnWXXmwtEsuZaAQzQy1Px1R4H+X
         DDUBxtUnDnc4Zb8OO3+2dMokRo7k4dnYnEUOsTkEVFGOLNQO4TsCL8+GMmngk4jM0m/B
         u4IIHgo4nUuqKFjunPcJDJw7G8jRZKYaCEADXHDWU3DiKcP8hcTzMapyKwPKMgKhHZ8r
         s1+iEfbyxPjMU807/GzX0tnALd1SRXop+TT0Di8BfnIZBbmudUomN46hN0/gduF2VFYa
         bQkQ==
X-Gm-Message-State: AOJu0YzK0P+vY9+meOIswEj2lQNq8MNkDRvF7+8tq66+HDVAW+mpApop
	XIWGu3b5oxFev4ikr2z0X/M/G2ICOEmpdhzY4CBuIxddksiFicDuJxBO9mc6pBMbtn57ZhL8LlO
	pNxKcjaglCly1hq0gyt7D6acpeFICTKV2+b1ZRaIckRev8dHRMTGVX8NHFTnuAEVAVPjIKebiJ/
	DPe0ZVh+87rGkO4nJ0NwpgoSWWFHgmgxs6mWJiLCmRet4tyQ9T0dMfBknvDsA9+ktbsR1DqOu/9
	Y5FkTmufedkwodbzA==
X-Gm-Gg: ATEYQzy3ZKmojrZmu8al9iJvdVvlOR3HRXlYQX9YDgV6VamoJduGm4gwd6LvU4uoYDA
	KzIsxj5PgC0KTbi5tvYS1gp1Owd1hiFoYn0qQ44p1dFR4Vms3oEEymh4CksoItJLxnaDOAXHwiK
	UQc89DEuz+DWnEDcUtSacss6+W+wqJ/XDYR/gAui6iW4Pram6exhdc+xOqbMaR8CtTGt9w9ixcw
	Jv0jgMcWuiYgsQ87AfTbNBWZQyMO2ca68GZMeSOmtB+Pn4jAASlAL0iVC3Ci7ZNDhHzXtuKlZgu
	66k82rMU2SnEqoygVCNVVt1KoV1VO7WCuw49O1p/YDCGJIalpY+S9X7wHyKbtdmapAtlgVun77U
	2fCZ/EE+cX1VKiTTCE1RdixcTNuE8uLYhuMzQDkW7fwetTM6eEK8IVU0tLe3CDyJ685O/Z7ceOh
	TTaUnImxaG1ACcss4h8dv2RiyP7nyo65cFjc/+LowsKg7M9ecKttgzBt/L7pXwzf8vCw==
X-Received: by 2002:a05:7022:3885:b0:129:ea8:9cc2 with SMTP id a92af1059eb24-12a8e0d61a7mr1908119c88.9.1774382897513;
        Tue, 24 Mar 2026 13:08:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-12a948fcfd0sm183582c88.2.2026.03.24.13.08.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2026 13:08:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-359812e4fefso202368a91.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774382896; x=1774987696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRikypN/LpT75/NMboweiLacdsHYIINoiM+NXjDT2RA=;
        b=Jv61+659dbPvq8dbLSx5f19Xpi8To3unjoT4OyTFgEC0R2wnv148Dvl9fB1iP2B2DE
         ZYrrlBDabnRtXzi0X7fHBkVG3Y/7HiWynFOr9qenfYUOKXZ0P0xoooBHFtR8w1sGILhD
         r9PU8kzs4gehMrsmUHVmqfP3DS/ElwNqbYlKU=
X-Received: by 2002:a17:90b:28cf:b0:35b:9e53:e2df with SMTP id 98e67ed59e1d1-35c007b3678mr3911498a91.2.1774382895637;
        Tue, 24 Mar 2026 13:08:15 -0700 (PDT)
X-Received: by 2002:a17:90b:28cf:b0:35b:9e53:e2df with SMTP id 98e67ed59e1d1-35c007b3678mr3911470a91.2.1774382895142;
        Tue, 24 Mar 2026 13:08:15 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a80163bsm9930057a12.1.2026.03.24.13.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:08:14 -0700 (PDT)
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
Subject: [PATCH net-next v9 01/10] bng_en: add per-PF workqueue, timer, and slow-path task
Date: Wed, 25 Mar 2026 01:37:31 +0530
Message-ID: <20260324200740.346029-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324200740.346029-1-bhargava.marreddy@broadcom.com>
References: <20260324200740.346029-1-bhargava.marreddy@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271273-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F093A31C216
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


