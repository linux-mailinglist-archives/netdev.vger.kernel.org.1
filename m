Return-Path: <netdev+bounces-270092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFpmATLJvWkrBgMAu9opvQ
	(envelope-from <netdev+bounces-270092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:24:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 595F52E1C14
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E318E30F6B1F
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE6238AC78;
	Fri, 20 Mar 2026 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="H33uyC2Z"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E62237473B;
	Fri, 20 Mar 2026 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774045130; cv=none; b=G7x/kIT9QjCR7dc/j1q1bJclEGA9bIzs38iX9ihCNN2u155UQzTpSrkOpdvVePih1s6/dJXTWMB3Dv5wEdSMO9XEFtaIRsPOVT3754w+w5sid2EjcuyR49v3Q7w5LY1RRICM5wD2ePmCs4ENWdtCFeiGyCWwPU0WtpgftP1n1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774045130; c=relaxed/simple;
	bh=yLBaDIJRUb2S4fD4PBbr3ImUYiTYzCHBxoqyPRfRhbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2WJm33S5M6aVaUHSd9dB9uXIggQUuF9hQ9NK+XHSAZoLWkm5yw1K0lxQMq5/ptWf6zJJbLxvTEOrhoiVVjnPaGEGct86gdXYsUEwFOUyFKvhHraa4pZKzOky9aUc6kxukK6FPUMpz0ZJUyImQU0IG3Pig2lBWvoe+q6Dinx6Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=H33uyC2Z; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=OFv6uV5GTnwHWnoAMen2ABCUodHALHhDZDqyvabIvaU=; b=H33uyC2ZeHxTB5By2+pn391MlH
	gNBoZnxVViVxNAAgq698o7QY5qtbFYAABvXB4E4twlZSJ7RGdojN90vsEKhA7+sRfH7RWZC4Ya61U
	HyDesfE8U0VmhWipNx8aPYDaweexCFh9DRcCgsdiuUkyGUkcMIzMhW5yN+FBi4v2D1e4PuNEHvFdC
	qNCRnDOMC6CNJsPvVzfow/XhDvtxqWi/QNuFJKkLbUue/XZjQgjREJZJRD6ccxTl++T4l+2eA6jxx
	ZUze2UECpFVX7jz5ucJDkgD2uZKb3nYdl2Mr4ZBYOeFJlqWEyC7NzWEBMWTHgGtciABZxfMiSB96G
	ioblt2Nw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w3iAj-000GzZ-3A;
	Fri, 20 Mar 2026 23:18:26 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v9 08/14] xsk: Extend xsk_rcv_check validation
Date: Fri, 20 Mar 2026 23:18:08 +0100
Message-ID: <20260320221814.236775-9-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320221814.236775-1-daniel@iogearbox.net>
References: <20260320221814.236775-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27946/Fri Mar 20 07:24:31 2026)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270092-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,blackwall.org:email,davidwei.uk:email,fomichev.me:email]
X-Rspamd-Queue-Id: 595F52E1C14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xsk_rcv_check tests for inbound packets to see whether they match
the bound AF_XDP socket. Refactor the test into a small helper
xsk_dev_queue_valid and move the validation against xs->dev and
xs->queue_id there.

The fast-path case stays in place and allows for quick return in
xsk_dev_queue_valid. If it fails, the validation is extended to
check whether the AF_XDP socket is bound against a leased queue,
and if so, the test is redone.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/xdp/xsk.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 79f31705276f..3fab551eeaf7 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -330,14 +330,37 @@ static bool xsk_is_bound(struct xdp_sock *xs)
 	return false;
 }
 
+static bool xsk_dev_queue_valid(const struct xdp_sock *xs,
+				const struct xdp_rxq_info *info)
+{
+	struct net_device *dev = xs->dev;
+	u32 queue_index = xs->queue_id;
+	struct netdev_rx_queue *rxq;
+
+	if (info->dev == dev &&
+	    info->queue_index == queue_index)
+		return true;
+
+	if (queue_index < dev->real_num_rx_queues) {
+		rxq = READ_ONCE(__netif_get_rx_queue(dev, queue_index)->lease);
+		if (!rxq)
+			return false;
+
+		dev = rxq->dev;
+		queue_index = get_netdev_rx_queue_index(rxq);
+
+		return info->dev == dev &&
+		       info->queue_index == queue_index;
+	}
+	return false;
+}
+
 static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 {
 	if (!xsk_is_bound(xs))
 		return -ENXIO;
-
-	if (xs->dev != xdp->rxq->dev || xs->queue_id != xdp->rxq->queue_index)
+	if (!xsk_dev_queue_valid(xs, xdp->rxq))
 		return -EINVAL;
-
 	if (len > xsk_pool_get_rx_frame_size(xs->pool) && !xs->sg) {
 		xs->rx_dropped++;
 		return -ENOSPC;
-- 
2.43.0


