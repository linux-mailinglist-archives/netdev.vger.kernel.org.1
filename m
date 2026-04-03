Return-Path: <netdev+bounces-274920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDrFNYluz2kTwQYAu9opvQ
	(envelope-from <netdev+bounces-274920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:38:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59377391C7D
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 871023024A25
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 07:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E34837C10E;
	Fri,  3 Apr 2026 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="D+clhTJ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC3B37B011
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 07:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775201896; cv=none; b=QcfKcx803jBRaIUv6/nGWRVQKS/SoC2r8lS6GZjh2XSllYsMmaOkpVExJjU9wYcbxPn0JLSAzPLwj3gcj/CLVVYhPwPlWjWcx5VG7alDC8s52TXUzC2kpBhRweIFpl5hp8Py4om9K5jImjeZGbhJt2M9GFqPhLS3/F4Tj2kvaz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775201896; c=relaxed/simple;
	bh=EYofg1gpQ9rfOnBFkagL/sjEY+BAK75kZAJ+LOzBbnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNiifrSYC+yFKcRpW/CyCj1LjUUvTHdmJCVSz1iPAilFxVlISPyfz4Sanp2FW65HgVtxzAwNlTkMWsZNDAluu3imiV99gj1vF4frRT/fUTJQ5JILbfPeUHzm1KGwtc7sgL/ZP0ATPHjgomcPa26VkAZRZMcdOY9tUL4jL3QHryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=D+clhTJ8; arc=none smtp.client-ip=209.85.160.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-50bc115f206so18931781cf.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775201894; x=1775806694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFGH6qymgtvzYwWHNnXSxQD4gLAcLHVZRmJAUNjPk0M=;
        b=nboVxbrcDK3eSeN8mJoMvYiudK+BQB6T0DPSM5VDwneWT6lHSKV6P7PIPsseU9pwsg
         TP8gLgVPFFoSq7AcD29xuwMiP+Zi2xmLBaRPFN9u8POWXDisL2tb7lTJR0imWIgdTm3c
         4MnoPpXvAiQW8LezqpWnYnJWilvThsTVU+s7+Vs0rfvAWWnU0B64YlEH8l6h5um4DD7f
         4nLHYtN0nUMc2aZdRAyqIb3t1YsqMsqb4L4BM22auRQ1KspVS6DzRVm4CYteuiCUN1I7
         OZVjZ4rB8FRp2gs/UcRys9BVq+oM4/IgGAuma1O0EplkGAirl3Vdbcyz4QTR+BTMQrjy
         bxIA==
X-Gm-Message-State: AOJu0YwjmLQJvJpE5Id5nwJ4x4ANFPfFQZZkdbVeqoAFrVP4gCPZ4eRP
	zQvYipl9EzSB5XtIEq2lCuZFqi/iiqRA2x2//Xjg5SsObqyHIUSakyTziFe/XxOk5zzIO5K7vg6
	mqYZMdrvF56ycEf4NyJcNGbOjMU6xRENawlFwwjkZXtit9wqcbKQCuMArpSX4MB4XraRB/P5gwq
	kwiYDTZkHWjCS4g/d1an9jL57oRzpUfJuoWfqdaABDlzz67btuh7XzsK8mEEHggF/xmh6ussZf6
	bmNOSAv//fhugQzMQ==
X-Gm-Gg: ATEYQzxMqBhAVkaVlstlectRuStHVU4vtmkirKrtX7vKFk5kK5pqlAS80WwtyoHAUWP
	LsQV8y9BevIzpmrZy25i6db6WidPAksUEKVMjMBo57oMM/fwg3xys+iOBCblz/BS8f+LvSjYDux
	r42lS9Z/4vssUBmTkDcMj1EoOLXWy17PWANf8Ky0FLt+VHjfMIcMT757gfnJmHjH7RhphWg/6Bk
	HAFf9pdBnURC4ku5ZsxP/nXanfGteOIYKm73hoCza+DTpNqqbKurN5Fncc9rxWPqqVNknTwrOsA
	J5zU712C7prGrTmP/JPVTkMYTNu6VWT4/0zYWlys2HzjTwfHjgEjA9yArct0HUBfB5Hn/szyeL4
	KJh45eYjA/DI7WXRgurk5xCKmxiLfr85DisAoGLeBOiRYnnJUUI0sa+y9FBymln8x+l1tKNFLLL
	FqzUrZUmrUTyiYZB3nNAJtGBaapDDztzSO7XltVD5AdaHptj/Gh/ZH58b/o/sz6xs=
X-Received: by 2002:ac8:578b:0:b0:509:3f5d:4fb4 with SMTP id d75a77b69052e-50d62b4c0ebmr30634321cf.20.1775201893670;
        Fri, 03 Apr 2026 00:38:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8a5967182b3sm5024136d6.16.2026.04.03.00.38.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2026 00:38:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso1866884a91.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775201892; x=1775806692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFGH6qymgtvzYwWHNnXSxQD4gLAcLHVZRmJAUNjPk0M=;
        b=D+clhTJ8s2WM4A2jsD53Bbyi1T27F5+16KqF4IR9350LxjLejpo/+wPBD22CG9WxHA
         IwsySFvh8wLi58pI74nAjyQS0uo+QJHwsSs/a/l8PAx/YsimHgeBa2/c6rFIdw6Fzts0
         Bh0M025dKXZnoO30IAwp2PjVeEOlyJNAp8Q8w=
X-Received: by 2002:a17:90b:1d8b:b0:35d:a0b7:960f with SMTP id 98e67ed59e1d1-35de67d99damr2017647a91.5.1775201892412;
        Fri, 03 Apr 2026 00:38:12 -0700 (PDT)
X-Received: by 2002:a17:90b:1d8b:b0:35d:a0b7:960f with SMTP id 98e67ed59e1d1-35de67d99damr2017626a91.5.1775201891982;
        Fri, 03 Apr 2026 00:38:11 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9377b7sm13124901a91.10.2026.04.03.00.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 00:38:11 -0700 (PDT)
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
Subject: [PATCH net-next v11 01/10] bng_en: add per-PF workqueue, timer, and slow-path task
Date: Fri,  3 Apr 2026 13:07:15 +0530
Message-ID: <20260403073724.194360-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403073724.194360-1-bhargava.marreddy@broadcom.com>
References: <20260403073724.194360-1-bhargava.marreddy@broadcom.com>
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
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274920-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 59377391C7D
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


