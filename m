Return-Path: <netdev+bounces-307344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +4UUMtGhVWqkrAAAu9opvQ
	(envelope-from <netdev+bounces-307344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:41:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 199717506B4
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:41:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=CJmS5e3b;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307344-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307344-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 038CA301841E
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61F437D123;
	Tue, 14 Jul 2026 02:41:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA337A847
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 02:41:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996877; cv=none; b=JUzupWjKODSi4XOD6E9ezPeZgzOTeA+bZQg1pmZFxNgqn+RNYYJ+NbANTKPUV+FqDiwNsdM4FxVkXCa2vcgsQhOVC9+sPSkKkXPpTCWdLJBzkMgh4AUltt9/gAELw2NAk7fIV+eqQQD5DhZye1aKSSo061Js638Q5B4OR7/XVPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996877; c=relaxed/simple;
	bh=xKPEW6AchvNv/x4LMiHOziyGKpV+Hj0p2OP83HlUF1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uB0/vA8lPinC9Q6C5777tVkjqQ8CgQCoL/pKQyItJ+YMLrN4BuxDjTsZPKYaV7FUlZ3goo96nlCnGNiHiA6kQY14SxUnlDD3PLhcnnO1S4PuIt1ifbfgHMgkl5tX1p4f0iH1NYrx3a4klnHcpl3mYot03OXb890kaNESSXdfrxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CJmS5e3b; arc=none smtp.client-ip=117.135.210.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Tw
	WIFxfUs9S/uyj7vyCnE0UomkAQzXHUdY6cYZyxCRs=; b=CJmS5e3b8rYw8/d0SV
	gEOPSugKtOO7p/5nD8AsdIPkghfLxR0IsOeJY2GSenCx/JCrdHdvd0UVFRdLehvH
	o7OBBMgSaMR48IY6I/Z+j2NjFxr2bRcJ+kumfrpEsX/IIWUeIJuRkusj/E9vvGvX
	cvfNZaJiqGELKTR52lXTtQTn4=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBnghqloVVqqbA+IQ--.54906S2;
	Tue, 14 Jul 2026 10:40:41 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: netdev@vger.kernel.org
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] virtio_net: fix spelling of aggressively in comments
Date: Tue, 14 Jul 2026 10:40:37 +0800
Message-ID: <20260714024037.186799-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnghqloVVqqbA+IQ--.54906S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy3tFyDtrWUCF4UKFyxuFg_yoWkCrb_J3
	40qr90gr45W3WY9w4UCay3ArW2kan0qay8WaySvrZxW3ykArW7GrZ2gr9rC3Zruw40yFnx
	GwsFyF1UA3sxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8LiSJUUUUU==
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC9AmCC2pVoam1LQAA3b
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307344-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[15927021679@163.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mst@redhat.com,m:jasowangio@gmail.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:virtualization@lists.linux.dev,m:xiongweimin@kylinos.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,linux.alibaba.com,lists.linux.dev,kylinos.cn];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[15927021679@163.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[163.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 199717506B4

From: xiongweimin <xiongweimin@kylinos.cn>

Two receive-path comments misspell "aggressively" as "agressively".

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3e2a5876c..f3c7b28ce 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3190,7 +3190,7 @@ static int virtnet_open(struct net_device *dev)
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
-			/* Pre-fill rq agressively, to make sure we are ready to
+			/* Pre-fill rq aggressively, to make sure we are ready to
 			 * get packets immediately.
 			 */
 			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
@@ -3419,7 +3419,7 @@ static void virtnet_rx_resume(struct virtnet_info *vi,
 			      bool refill)
 {
 	if (netif_running(vi->dev)) {
-		/* Pre-fill rq agressively, to make sure we are ready to get
+		/* Pre-fill rq aggressively, to make sure we are ready to get
 		 * packets immediately.
 		 */
 		if (refill)
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus


