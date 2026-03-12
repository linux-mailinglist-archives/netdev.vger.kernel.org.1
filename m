Return-Path: <netdev+bounces-267055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ml4M4+6smmvPAAAu9opvQ
	(envelope-from <netdev+bounces-267055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:07:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22306272483
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33E8730142B8
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B203C5558;
	Thu, 12 Mar 2026 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="JaiPru6m"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3B13C3436;
	Thu, 12 Mar 2026 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320824; cv=none; b=OHtnZydBR/+TfQpGi+wF7aGC5TWCxPbGIiii8HxpoY/cRWCMlmCp/79ZDE3J1AEW/BaahD2jcEoslF7jiVrKN8DG1wrgDUH66u+mxZ9seHFQRX26UgIm/T7nMjxY9b2rM1DClYJySEieXT5oWwUESjiQK2yOAOiNZ/QfzkQTgCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320824; c=relaxed/simple;
	bh=ZL6w4Nml5BRk4h5VWdpCH4AYdVCznstv0Nwlmc4aX4s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHcii32dvyRv+GQ5eDXbuFBK8Oeu8vEaYb+61nw1CWrvJqdD26HJwJr5l1r8ha/AaAU26LYQz7zPdSy7P4lCdNluyP/P5YJTLxhsNnkfMgjf4z5cp5f9e7z2kPoYh2H3QOvKuSbp2NyLhMj5q72gcjhZ0RAmkI5iZQcgqMrFPTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=JaiPru6m; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1773320811;
	bh=ZL6w4Nml5BRk4h5VWdpCH4AYdVCznstv0Nwlmc4aX4s=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=JaiPru6mKPbKf7+xG36DOlgz8I7/zw/maYpDmPFTbCDa8j2XQbCwqL/dGUd/49TNU
	 J3BYEMCJZfYzOnSFDRdru0iRfHxWzW2oBZMPDlRANUkGnl+fLHab+r00CBF86FRYWa
	 xamnvh83BvnDIj5Ye2Ts2vRHSHcVdxiyn0t4FrCo=
Received: from simon-Latitude-5450.fritz.box ([129.217.186.105])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.2/8.18.2) with ESMTPSA id 62CD6mqh014094
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 14:06:50 +0100 (CET)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
Subject: [PATCH net-next v8 1/4] tun/tap: add ptr_ring consume helper with netdev queue wakeup
Date: Thu, 12 Mar 2026 14:06:36 +0100
Message-ID: <20260312130639.138988-2-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-267055-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tu-dortmund.de:dkim,tu-dortmund.de:email,tu-dortmund.de:mid]
X-Rspamd-Queue-Id: 22306272483
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce tun_ring_consume() that wraps ptr_ring_consume() and calls
__tun_wake_queue(). The latter wakes the stopped netdev subqueue once
half of the ring capacity has been consumed, tracked via the new
cons_cnt field in tun_file. When the ring is empty the queue is also
woken to handle potential races.

Without the corresponding queue stopping (introduced in a subsequent
commit), this patch alone causes no regression for a tap setup sending
to a qemu VM: 1.151 Mpps to 1.153 Mpps.

Details: AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU
threads, pktgen sender; Avg over 20 runs @ 100,000,000 packets;
SRSO and spectre v2 mitigations disabled.

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/tun.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index c492fda6fc15..a82d665dab5f 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -145,6 +145,7 @@ struct tun_file {
 	struct list_head next;
 	struct tun_struct *detached;
 	struct ptr_ring tx_ring;
+	int cons_cnt;
 	struct xdp_rxq_info xdp_rxq;
 };
 
@@ -564,6 +565,7 @@ static void tun_queue_purge(struct tun_file *tfile)
 	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
 		tun_ptr_free(ptr);
 
+	tfile->cons_cnt = 0;
 	skb_queue_purge(&tfile->sk.sk_write_queue);
 	skb_queue_purge(&tfile->sk.sk_error_queue);
 }
@@ -730,6 +732,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 		goto out;
 	}
 
+	tfile->cons_cnt = 0;
 	tfile->queue_index = tun->numqueues;
 	tfile->socket.sk->sk_shutdown &= ~RCV_SHUTDOWN;
 
@@ -2113,13 +2116,39 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	return total;
 }
 
-static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
+static void __tun_wake_queue(struct tun_struct *tun, struct tun_file *tfile)
+{
+	if (ptr_ring_empty(&tfile->tx_ring))
+		goto wake;
+
+	if (!__netif_subqueue_stopped(tun->dev, tfile->queue_index) ||
+	    ++tfile->cons_cnt < tfile->tx_ring.size / 2)
+		return;
+
+wake:
+	netif_wake_subqueue(tun->dev, tfile->queue_index);
+	tfile->cons_cnt = 0;
+}
+
+static void *tun_ring_consume(struct tun_struct *tun, struct tun_file *tfile)
+{
+	void *ptr;
+
+	ptr = ptr_ring_consume(&tfile->tx_ring);
+	if (ptr)
+		__tun_wake_queue(tun, tfile);
+
+	return ptr;
+}
+
+static void *tun_ring_recv(struct tun_struct *tun, struct tun_file *tfile,
+			   int noblock, int *err)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	void *ptr = NULL;
 	int error = 0;
 
-	ptr = ptr_ring_consume(&tfile->tx_ring);
+	ptr = tun_ring_consume(tun, tfile);
 	if (ptr)
 		goto out;
 	if (noblock) {
@@ -2131,7 +2160,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
 
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		ptr = ptr_ring_consume(&tfile->tx_ring);
+		ptr = tun_ring_consume(tun, tfile);
 		if (ptr)
 			break;
 		if (signal_pending(current)) {
@@ -2168,7 +2197,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
 
 	if (!ptr) {
 		/* Read frames from ring */
-		ptr = tun_ring_recv(tfile, noblock, &err);
+		ptr = tun_ring_recv(tun, tfile, noblock, &err);
 		if (!ptr)
 			return err;
 	}
@@ -3404,6 +3433,8 @@ static int tun_chr_open(struct inode *inode, struct file * file)
 		return -ENOMEM;
 	}
 
+	tfile->cons_cnt = 0;
+
 	mutex_init(&tfile->napi_mutex);
 	RCU_INIT_POINTER(tfile->tun, NULL);
 	tfile->flags = 0;
@@ -3612,6 +3643,7 @@ static int tun_queue_resize(struct tun_struct *tun)
 	for (i = 0; i < tun->numqueues; i++) {
 		tfile = rtnl_dereference(tun->tfiles[i]);
 		rings[i] = &tfile->tx_ring;
+		tfile->cons_cnt = 0;
 	}
 	list_for_each_entry(tfile, &tun->disabled, next)
 		rings[i++] = &tfile->tx_ring;
-- 
2.43.0


