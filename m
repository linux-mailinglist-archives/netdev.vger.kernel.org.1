Return-Path: <netdev+bounces-291792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGDcHl3GFWqxawcAu9opvQ
	(envelope-from <netdev+bounces-291792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:12:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 358795D96A0
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D471306AD0F
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15823AEF21;
	Tue, 26 May 2026 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsUPkfQd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B00E3A874B;
	Tue, 26 May 2026 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811330; cv=none; b=u+BAH2qhpfRnokPiaq3jJ2hy59Z+y1EA4f6PvVw7MHi2FbQwlcER92/gcWPYqvlxTl8T+OVgzJ1J14bXE0ylt5dag40CAMcN3g7o+kxw65PjV4E0Lbb/2pLIaR6z4z060zbHvOoEQEsSrMf+ZHl9BnfvTEmU5jGZYUPAg4qg6Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811330; c=relaxed/simple;
	bh=dfocf/7YY+vx6PB/5ppnIyZPdpOxQSSNhjc1amOUYL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9xxGWQzgZye9f+ZX3g2O5BbdStvBaE74aBzh6nAv780TreQxHrkcV23GllVikFn92ylIvExEBgMff/wKlJ13aIqBMpRrKW9qeROGlANd5ArgGTudVIu2+bNib2uS3VHveXaJsusT4UqsZIOo7kwSb7eT562wiflpPl4svTbDfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsUPkfQd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BE11F00A3C;
	Tue, 26 May 2026 16:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811328;
	bh=qdjnTqZwtbqbv5h3KK2KtId/sKi/ztpUaVOLvfmSSq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bsUPkfQdQvqVvMqBdt+r5cUXqHAa7DY9AmPS46dHkG8JFZCauZXJM6rzSYQkqkqAg
	 wYrqrCAEgKncUWambwQ5gtAZFDKXiAj2AekxFlh6aZXwxh/al8AIGZNvPTBQrEFeoM
	 8NOuPSBj9Aooph192d+62KgDq8qB/r2ZqVqlC8GBJPhIlTvzVogxh54v13YOWrTy1V
	 fdJ8O/kkXm2iZFAAYXhtwLB0r9FgDp11gYVLo5+zYySU2wvhs2aEHldiXWlhLGK7bv
	 Sg+oaj9X6vChg2hbvnPiCfzylicShQEsIF/1GzDpJW29D4mvHBHb1RSlaqHWw27nD4
	 dpWLUS4Qz1piA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	vladimir.oltean@nxp.com,
	willemb@google.com,
	sdf.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	jesse.brandeburg@intel.com,
	linux-doc@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 04/10] docs: net: update devmem code examples
Date: Tue, 26 May 2026 09:01:45 -0700
Message-ID: <20260526160151.2793354-5-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526160151.2793354-1-kuba@kernel.org>
References: <20260526160151.2793354-1-kuba@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291792-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 358795D96A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update the code examples
 - update the YNL sample with the latest(?) APIs
 - struct dmabuf_tx_cmsg does not exist, use __u32 directly

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/devmem.rst | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
index a6cd7236bfbd..6a3f3c2ac19c 100644
--- a/Documentation/networking/devmem.rst
+++ b/Documentation/networking/devmem.rst
@@ -103,24 +103,22 @@ The user must bind a dmabuf to any number of RX queues on a given NIC using
 the netlink API::
 
 	/* Bind dmabuf to NIC RX queue 15 */
-	struct netdev_queue *queues;
-	queues = malloc(sizeof(*queues) * 1);
+	struct netdev_queue_id *queues;
 
-	queues[0]._present.type = 1;
-	queues[0]._present.idx = 1;
-	queues[0].type = NETDEV_RX_QUEUE_TYPE_RX;
-	queues[0].idx = 15;
+	queues = netdev_queue_id_alloc(1);
+	netdev_queue_id_set_type(&queues[0], NETDEV_QUEUE_TYPE_RX);
+	netdev_queue_id_set_id(&queues[0], 15);
 
 	*ys = ynl_sock_create(&ynl_netdev_family, &yerr);
 
 	req = netdev_bind_rx_req_alloc();
 	netdev_bind_rx_req_set_ifindex(req, 1 /* ifindex */);
-	netdev_bind_rx_req_set_dmabuf_fd(req, dmabuf_fd);
-	__netdev_bind_rx_req_set_queues(req, queues, n_queue_index);
+	netdev_bind_rx_req_set_fd(req, dmabuf_fd);
+	__netdev_bind_rx_req_set_queues(req, queues, 1);
 
 	rsp = netdev_bind_rx(*ys, req);
 
-	dmabuf_id = rsp->dmabuf_id;
+	dmabuf_id = rsp->id;
 
 
 The netlink API returns a dmabuf_id: a unique ID that refers to this dmabuf
@@ -302,13 +300,12 @@ The user should create a msghdr where,
 * iov_base is set to the offset into the dmabuf to start sending from
 * iov_len is set to the number of bytes to be sent from the dmabuf
 
-The user passes the dma-buf id to send from via the dmabuf_tx_cmsg.dmabuf_id.
+The user passes the dma-buf id to send from as a u32 cmsg payload.
 
 The example below sends 1024 bytes from offset 100 into the dmabuf, and 2048
 from offset 2000 into the dmabuf. The dmabuf to send from is tx_dmabuf_id::
 
-       char ctrl_data[CMSG_SPACE(sizeof(struct dmabuf_tx_cmsg))];
-       struct dmabuf_tx_cmsg ddmabuf;
+       char ctrl_data[CMSG_SPACE(sizeof(__u32))];
        struct msghdr msg = {};
        struct cmsghdr *cmsg;
        struct iovec iov[2];
@@ -327,11 +324,9 @@ The example below sends 1024 bytes from offset 100 into the dmabuf, and 2048
        cmsg = CMSG_FIRSTHDR(&msg);
        cmsg->cmsg_level = SOL_SOCKET;
        cmsg->cmsg_type = SCM_DEVMEM_DMABUF;
-       cmsg->cmsg_len = CMSG_LEN(sizeof(struct dmabuf_tx_cmsg));
+       cmsg->cmsg_len = CMSG_LEN(sizeof(__u32));
 
-       ddmabuf.dmabuf_id = tx_dmabuf_id;
-
-       *((struct dmabuf_tx_cmsg *)CMSG_DATA(cmsg)) = ddmabuf;
+       *((__u32 *)CMSG_DATA(cmsg)) = tx_dmabuf_id;
 
        sendmsg(socket_fd, &msg, MSG_ZEROCOPY);
 
-- 
2.54.0


