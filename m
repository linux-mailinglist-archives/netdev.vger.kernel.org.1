Return-Path: <netdev+bounces-263597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FXeDgDFp2mYjgAAu9opvQ
	(envelope-from <netdev+bounces-263597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 06:37:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF041FAE40
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 06:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 478B33008242
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 05:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1834D3559D3;
	Wed,  4 Mar 2026 05:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3YaSQoL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FB5378D7D
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 05:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772602613; cv=none; b=tcwqUq/mfYgEChs0M6nZkzogJ8TXWRjKcJ+Ci+maoVYP+kTnt1AIHmjLJp1c7ofEa8vCVQycCk2BXJ9kAxpGFckvmsUyPqoiUzJLnQh4MOeGeB17P+2MaiKpLzxdx2JYgHHsO7RLXmRtdyjCHSBYO4oFrKEuDaMVO74lOeXatjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772602613; c=relaxed/simple;
	bh=X6tX6MsfjpCCm5XWJnWLuYwr3D2OjljkcPDWiXIpOAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1piiqmOJaFIH9HI3N8iXvde98Wi+znyNN2htXzK0VaZwNxCd0PMwbX/n6NJAZAEli0WbXechCRiUw6QK08Sp6Mv7Xb0Rdv1rgS/VqITnjqo3gv3Z/VUURIZTKmcBY4dKYpcd+iuZsSAQrthicINGKVOXDo1eIp7jYpANT0PwS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3YaSQoL; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3598c1ad542so1837270a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 21:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772602611; x=1773207411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNcMxZGmsNob2hi70jSfSua0A2NVCjnuBqG6KRIu95c=;
        b=h3YaSQoLLhnhiYDWEJdepXjDHNhTxpaKciEnl6O54BufaVNAP+MfeBNGp9mJ2IK5SF
         AzPtDHD2R5F8hpjYseFHu/ilBGvktPrsOIp1MQub88eQN+vWnXMYpT5OAlLZGu49U3bW
         d008yrwHFqGvtwknzrJrbRtYdtMRNVqa5SkCNDZldxNmUp1dub8YCITTzfFOPcYjRE5V
         PEdxZ5cCW4D0dPfXmH3eP4pCwzA1l++3Ho7ofMTEeWNECvCY7qsifQvbrCZzDhTBqCX1
         8nTRTic/f91HvMr07VCOsOcPUea7SmgBsx4aa0D/Es1fllK5YX53ctY4Wfat8otBmvAw
         SGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772602611; x=1773207411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rNcMxZGmsNob2hi70jSfSua0A2NVCjnuBqG6KRIu95c=;
        b=U/xDn9CTLi0joUowX1MJgWYcTOmyQ25oXuQ2IYsooF2+/+u/PKnMV5bRS5Hsv0cxE9
         5EI1nyzfdkbmk2bV6fqxBWaDTFyh2WwHqTxzf9aV5KpKjghZk1wXP4gnmrQXoUrw8XdV
         2tUi8hztFF18999vIKdOo6bdkPLf2EVAjV3mIGnDFWxrGv/fDNVix6KbNMrtQByVh45Y
         fQo/KRUJ/jaxJs8yAKUAxQSubTBLCJqXfFIKPVX9wIsK/5nr4kpzTIlibJP1ZsyWYRE7
         92l7vEqxAQ972h1594SLLhFPaDFZj3YFpv+OwAbME3nGWXa07dOMpbdsb8FVARcxKMOo
         l2jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq3v61MO8vGNikSA8XQRGNQTkRQGKaNUy36WdZXYk2uKGeSIFJrUdsqTkWmI8hLEyEXyeHqgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYYYKv0q523zC1QTP1oejiG23lnSnZh+ID6X4PSKP+pY4R62F2
	zqdrDjiwi+GqHxpMtPueU3mJiYlvYxPrg1+JYfbb8kH6f+KBDBAF7VXdKWntdQ==
X-Gm-Gg: ATEYQzwrUzvVb1EJd+yXUBGoa2iJ68ZyrRZ/nReTnwWl3JtGj76UcV9xWg9fAls/RAo
	EUrsKU5LPnFxWPgiYr/aKGOz/anESzXKHL2FRAT4G3CTI5akUZ5aRCYqDnJl2MGkstrqklSUL0c
	gRYhBt1bFfXHRYzrqWYUyX/N5TKyfWEUCSbji8jbi105qWQprUMuFjLl0SkMW0MPyImYUSO6QgK
	WSJFG8TEzi/fEW2AGdzUUC+sYusTcNXogsSXzdARSuYvLOznnodpoG3JTKCMHqr9XTqDCXIdXYU
	lcRw2HiJmwFSPIC1kadbU9/1uvOD+vWRrwpvbGuZbUHzBKzSv7SyF0f/rT1qNQa9GUaG5heXoan
	Ay9v/FWwEhPVRWvZtbKLTdA7LQSgolvdR6oj6FpVRAlA7hpzN8FLgqmorNbxNF+0zEy1GbfAUVf
	pmyKJGhsPnbvodLFm7n4eA4BSz6TeKzaHAScUoQlAwhB9OPJJxlwg9
X-Received: by 2002:a17:90b:3d83:b0:354:c629:efb2 with SMTP id 98e67ed59e1d1-359a6a563ddmr1057766a91.24.1772602611058;
        Tue, 03 Mar 2026 21:36:51 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c090bfdsm4020057a91.8.2026.03.03.21.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 21:36:50 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v7 4/5] nvme-tcp: Support KeyUpdate
Date: Wed,  4 Mar 2026 15:34:59 +1000
Message-ID: <20260304053500.590630-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304053500.590630-1-alistair.francis@wdc.com>
References: <20260304053500.590630-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EFF041FAE40
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263597-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,suse.de,gmail.com,wdc.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alistair23@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ietf.org:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,wdc.com:mid,wdc.com:email]
X-Rspamd-Action: no action

From: Alistair Francis <alistair.francis@wdc.com>

If the nvme_tcp_try_send() or nvme_tcp_try_recv() functions return
EKEYEXPIRED then the underlying TLS keys need to be updated. This occurs
on an KeyUpdate event as described in RFC8446
https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3.

If the NVMe Target (TLS server) initiates a KeyUpdate this patch will
allow the NVMe layer to process the KeyUpdate request and forward the
request to userspace. Userspace must then update the key to keep the
connection alive.

This patch allows us to handle the NVMe target sending a KeyUpdate
request without aborting the connection. At this time we don't support
initiating a KeyUpdate.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v7:
 - Use read_sock_cmsg instead of recvmsg() to handle KeyUpdate
v6:
 - Don't use `struct nvme_tcp_hdr` to determine TLS_HANDSHAKE_KEYUPDATE,
   instead look at the cmsg fields.
 - Don't flush async_event_work
v5:
 - Cleanup code flow
 - Check for MSG_CTRUNC in the msg_flags return from recvmsg
   and use that to determine if it's a control message
v4:
 - Remove all support for initiating KeyUpdate
 - Don't call cancel_work() when updating keys
v3:
 - Don't cancel existing handshake requests
v2:
 - Don't change the state
 - Use a helper function for KeyUpdates
 - Continue sending in nvme_tcp_send_all() after a KeyUpdate
 - Remove command message using recvmsg

 drivers/nvme/host/tcp.c | 59 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8b6172dd1c0f..ade11d2ac9ef 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -171,6 +171,7 @@ struct nvme_tcp_queue {
 	bool			tls_enabled;
 	u32			rcv_crc;
 	u32			snd_crc;
+	key_serial_t		handshake_session_id;
 	__le32			exp_ddgst;
 	__le32			recv_ddgst;
 	struct completion       tls_complete;
@@ -1361,6 +1362,59 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 	return ret;
 }
 
+static void update_tls_keys(struct nvme_tcp_queue *queue)
+{
+	int qid = nvme_tcp_queue_id(queue);
+	int ret;
+
+	dev_dbg(queue->ctrl->ctrl.device,
+		"updating key for queue %d\n", qid);
+
+	ret = nvme_tcp_start_tls(&(queue->ctrl->ctrl),
+				 queue, queue->ctrl->ctrl.tls_pskid,
+				 HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
+
+	if (ret < 0) {
+		dev_err(queue->ctrl->ctrl.device,
+			"failed to update the keys %d\n", ret);
+		nvme_tcp_fail_request(queue->request);
+	}
+}
+
+static int nvme_tcp_recv_cmsg(read_descriptor_t *desc,
+			      struct sk_buff *skb,
+			      unsigned int offset, size_t len,
+			      u8 content_type)
+{
+	struct nvme_tcp_queue *queue = desc->arg.data;
+	struct socket *sock = queue->sock;
+	struct sock *sk = sock->sk;
+
+	switch (content_type) {
+	case TLS_RECORD_TYPE_HANDSHAKE:
+		if (len == 5) {
+			u8 header[5];
+
+			if (!skb_copy_bits(skb, offset, header,
+					   sizeof(header))) {
+				if (header[0] == TLS_HANDSHAKE_KEYUPDATE) {
+					dev_err(queue->ctrl->ctrl.device, "KeyUpdate message\n");
+					release_sock(sk);
+					update_tls_keys(queue);
+					lock_sock(sk);
+					return 0;
+				}
+			}
+		}
+
+		break;
+	default:
+		break;
+	}
+
+	return -EAGAIN;
+}
+
 static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
@@ -1372,7 +1426,8 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 	rd_desc.count = 1;
 	lock_sock(sk);
 	queue->nr_cqe = 0;
-	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
+	consumed = sock->ops->read_sock_cmsg(sk, &rd_desc, nvme_tcp_recv_skb,
+					     nvme_tcp_recv_cmsg);
 	release_sock(sk);
 	return consumed == -EAGAIN ? 0 : consumed;
 }
@@ -1708,6 +1763,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 			ctrl->ctrl.tls_pskid = key_serial(tls_key);
 		key_put(tls_key);
 		queue->tls_err = 0;
+		queue->handshake_session_id = handshake_session_id;
 	}
 
 out_complete:
@@ -1737,6 +1793,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_keyring = keyring;
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.ta_handshake_session_id = queue->handshake_session_id;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
 	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
-- 
2.53.0

