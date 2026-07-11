Return-Path: <netdev+bounces-306867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YViAMJRcUmoyOwMAu9opvQ
	(envelope-from <netdev+bounces-306867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:09:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2D7741E5F
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:09:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YcZjIyUB;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306867-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306867-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2AE703007AC7
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 15:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF12A2EACF9;
	Sat, 11 Jul 2026 15:08:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4062DB78C
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 15:07:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782481; cv=none; b=Gzrogd+K1HizgzLTImoqIJYeXsZDXCRqSo0xz3MRwOArizMQZ6ewmiVj/Rh87MgKscPuFw+Ea3Q82/x/U86GYkrvcdABKoFdLtpL/hGiPHx4zHNFbOmuIPeUgrIAI8ozN6CBriuUS9sjv5Q8nPVRzqVbK2Odt1jVvE+ly65nrq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782481; c=relaxed/simple;
	bh=iVN6Oa7DczuGg2N9AQ8E0U8qy+G8dhvBhCAjVmI+XN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UfJBxJnf1VwWI7bxddiSsg1OOgLtLG3rdfXDZ3mJMgt8vUwh/V+3gp/ZNXNTeGtmKQQn6f0uoH1RBlQiTzbJjH+XzK3L4oYa+2F2HcQ7U7xOrKoP+dgegQ6p6Rqw5rsUQPvlaiTDbxUowHTBrWoVBLVoy3RdKv9kBK2XMpVck4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcZjIyUB; arc=none smtp.client-ip=209.85.219.48
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so15909526d6.1
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783782479; x=1784387279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=14qOd7NMSc5W1H4WG9ru/PizsjwiaHIwQhYh9VLIk/c=;
        b=YcZjIyUBAc8MaUivL5skDdhcMTY9UCR1eZy/ATu1JLQjHEvY0Uq/Fg14HNDHJRxbOz
         IRpjk1cKaDSF/7atBApp1HURmXckcjR4AcQciZa+xImb9uA33cz2iW3T5ZQiKNYHEmGu
         +uJRXcN4b1RNpK9WZCAaWgZ/+8WV9rsNrD3oFXmvXP7JeRd7Oph6aUiR0ILcgjXCb0nG
         wHH2w7npfsqLYG4bDXOhdRWlLO8uaGp309NVivuE4pZtcuI7DeudbO4NTFu1fxxAlpZp
         YMV0vMo7P0nOe3fsejSJzjFhVUKTOJk9bNxS9zTTpAZGCcj7dYaBCmo8bSbcRgwCk22J
         EznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782479; x=1784387279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=14qOd7NMSc5W1H4WG9ru/PizsjwiaHIwQhYh9VLIk/c=;
        b=Xur1rOacv+q1w1II5HxMemdT39nS6VCjVlxrbrS1ro4OREXfAKA61u3qpqEVsKqRaA
         I/292P75QaY35670SotNB0revPZG2VOnV5JX31XN8xtjd3RwWiPpSK+kfYTQtfVa/u06
         nvT0h/OUK0sl4Se6Cy96m1QJNqx+1a/v5AZOHgJyrN6axTlOVhkQcVDzVppsfI6QpcWc
         E6x2LPgsNR5RXbfJ6NtS/fkkl3WjPRPOZ5NKctUNN8q8gvl0TFVK6SaPvzvBCTP2Uy1I
         HIC+noJvg26Buq1oBAqnQuoGBwiS4KSBIEZJy0x1sKvkepNlUcb5HWrcyoX8kyTfEhkq
         Y/+g==
X-Forwarded-Encrypted: i=1; AHgh+RpX53X0mBAkfU0GhvEskjX2Le4wD7HZ8HoW+OeRZJAI9I0U9feKEMyLz0KaGV2U7r0kXmu765g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv17UmR+DR6ahX7nsSSQNBWS1kO0im3ihs8xJMT8rGpMCggYGW
	opDvuPGHI6k1jrXDny3PKb/S/2Bd3kxA4GgGQLae2Xjt53uqtbOkq74L
X-Gm-Gg: AfdE7ckFGtNukxroPfBFmN1C2HNECnvcW6POggfunbfI29oEuJRL3T49kTxyUd1SaUh
	RPy7e5z+j1SgAV0PinkHccWgNOcp0ZSJ38A/pcHPlCTNGMq6Xc3D3M9sIyCNoXvXHGeJlJK4Dk/
	0pq92kDKH1UI799pvxNCCJIVxB/akZzQrCsHIEYt04ud53E0Say84o20zcXxWES+JNeXRb2u6mR
	xdxX0gaQ8OspqWLVOrvG0CVOK7X+s+zJ6/K6a2vpbKL0NPsq3pEAcYzN2oQkFN2fOu5x/90TaEI
	GGaDSZf0j5V9qKF8zRGIcyrijnwwREK7KSinHGCRY9gd7GhXTAYnDz99GRSyZHFibtYX8/WLFbC
	tjKcInuTrW/5jvBCzIjYZ4jhfyvm3DNn5e2a9/3rnpmNaWwds9Uod2b5mCU0IzhbZ2ZnYxcjBSu
	2v296sxpjvni4MD9FM3d3hgpVJjt+hAO4wiSXem/7/5DeJWqs8nNn8lrQ/zQrG1MhY9qHs8h9J1
	BV/BOgH/Q==
X-Received: by 2002:a05:622a:14ca:b0:51a:8c9b:649c with SMTP id d75a77b69052e-51cbf38da9fmr29698741cf.64.1783782478863;
        Sat, 11 Jul 2026 08:07:58 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd57baf8dsm69025296d6.20.2026.07.11.08.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:07:58 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] virtio_net: validate device stats reply records before use
Date: Sat, 11 Jul 2026 11:07:54 -0400
Message-ID: <20260711150754.2918392-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306867-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:kuba@kernel.org,m:pabeni@redhat.com,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC2D7741E5F

__virtnet_get_hw_stats() walks the device statistics reply buffer with
"for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size))",
using each record's device-supplied hdr->size as the stride without
checking that a full struct virtio_net_stats_reply_hdr remains, that
hdr->size is nonzero and matches the expected size for hdr->type, or that
the record fits within res_size. A backend that returns hdr->size == 0
spins the loop forever; a short or oversized size drives out-of-bounds
reads in virtnet_fill_stats().

Impact: a malicious or compromised virtio-net backend hangs the CPU
running the guest's device-statistics query in an infinite loop
(hdr->size == 0), or drives an out-of-bounds read of the reply buffer.
This matters most for a confidential guest, where the host is outside the
trust boundary.

Validate each record before use: require a full header in the remaining
bytes, a nonzero hdr->size that is at least the header size and matches the
size expected for hdr->type, and that the record fits within res_size; stop
the walk otherwise. Add virtnet_stats_reply_size() for the per-type size.

Fixes: 941168f8b40e ("virtio_net: support device stats")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/net/virtio_net.c | 42 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3e2a5876c6c8c..9cbe40d218cc4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3532,6 +3532,7 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 	return err;
 }
 
+
 /*
  * Send command via the control virtqueue and check status.  Commands
  * supported by the hypervisor, as indicated by feature bits, should
@@ -3546,6 +3547,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 	bool ok;
 	int ret;
 
+
 	/* Caller should know better */
 	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
 
@@ -4927,6 +4929,32 @@ static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
 	}
 }
 
+static int virtnet_stats_reply_size(u8 type)
+{
+	switch (type) {
+	case VIRTIO_NET_STATS_TYPE_REPLY_CVQ:
+		return sizeof(struct virtio_net_stats_cvq);
+	case VIRTIO_NET_STATS_TYPE_REPLY_RX_BASIC:
+		return sizeof(struct virtio_net_stats_rx_basic);
+	case VIRTIO_NET_STATS_TYPE_REPLY_RX_CSUM:
+		return sizeof(struct virtio_net_stats_rx_csum);
+	case VIRTIO_NET_STATS_TYPE_REPLY_RX_GSO:
+		return sizeof(struct virtio_net_stats_rx_gso);
+	case VIRTIO_NET_STATS_TYPE_REPLY_RX_SPEED:
+		return sizeof(struct virtio_net_stats_rx_speed);
+	case VIRTIO_NET_STATS_TYPE_REPLY_TX_BASIC:
+		return sizeof(struct virtio_net_stats_tx_basic);
+	case VIRTIO_NET_STATS_TYPE_REPLY_TX_CSUM:
+		return sizeof(struct virtio_net_stats_tx_csum);
+	case VIRTIO_NET_STATS_TYPE_REPLY_TX_GSO:
+		return sizeof(struct virtio_net_stats_tx_gso);
+	case VIRTIO_NET_STATS_TYPE_REPLY_TX_SPEED:
+		return sizeof(struct virtio_net_stats_tx_speed);
+	default:
+		return sizeof(struct virtio_net_stats_reply_hdr);
+	}
+}
+
 static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 				  struct virtnet_stats_ctx *ctx,
 				  struct virtio_net_ctrl_queue_stats *req,
@@ -4936,7 +4964,7 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 	struct scatterlist sgs_in, sgs_out;
 	void *p;
 	u32 qid;
-	int ok;
+	int hdr_size, ok, remaining;
 
 	sg_init_one(&sgs_out, req, req_size);
 	sg_init_one(&sgs_in, reply, res_size);
@@ -4948,8 +4976,17 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 	if (!ok)
 		return ok;
 
-	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
+	for (p = reply; p - reply < res_size; p += hdr_size) {
+		remaining = res_size - (p - reply);
+		if (remaining < sizeof(*hdr))
+			return -EINVAL;
+
 		hdr = p;
+		hdr_size = le16_to_cpu(hdr->size);
+		if (hdr_size < virtnet_stats_reply_size(hdr->type) ||
+		    hdr_size > remaining)
+			return -EINVAL;
+
 		qid = le16_to_cpu(hdr->vq_index);
 		virtnet_fill_stats(vi, qid, ctx, p, false, hdr->type);
 	}
@@ -7305,3 +7342,4 @@ module_exit(virtio_net_driver_exit);
 MODULE_DEVICE_TABLE(virtio, id_table);
 MODULE_DESCRIPTION("Virtio network driver");
 MODULE_LICENSE("GPL");
+
-- 
2.53.0


