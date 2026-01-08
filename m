Return-Path: <netdev+bounces-248027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D323CD022F0
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 11:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B16C3053325
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 10:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EE043B80B;
	Thu,  8 Jan 2026 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Q45wSUUn"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857254383B6;
	Thu,  8 Jan 2026 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866153; cv=none; b=LCGhtrRwOBNcLZohLwl1Y/ZnPbILinzg3f4Tp8Xz+53wecbq6aDJHsa8Z2pGiOgDwsjnCktAyYC44tgWs2aygBI+wLIB7gXEpguABtd2k+DaRcP/N8+PctbTMXX/w5JSsVG9TKLoBsZvbzG1VbJVbHLd3JcLI6uYQmb9U8dbxmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866153; c=relaxed/simple;
	bh=iJfRlKeMUO7hZk716maG+9Rh9rC1sx9th/OS3Y5rewY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q3KvweVr+wvaM4ARlE0wh8SEM5sRkhr8lqrIuQHlE2mXPWXTSI1nt63DkGYAZM1pPlDu9m2a2+g42HX1DwIcaLFCDB19tB5fFheleOBEAdEh/AQIs/b0Kr43mOsSaTf07OaUG/IqhMYcb0TkACDkCjxlCrcu0uPHKvxqCvo9nks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Q45wSUUn; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vdmjp-0000fG-Bo; Thu, 08 Jan 2026 10:55:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=gzlvfrpy1K4hTAKMoW8f2yDrhOt+qjbv/u9I1nI7fRQ=; b=Q45wSUUnWNiVYCZbUUNhSTyRcY
	mRH+IgOIKbTp1Ap6wKfOnOuvNUEW5qCalkNl5ctk77fCu2OhYW2Mp6PyO3fXPGkB9FcePhWfqw2S1
	Bql2Z3+dFKRv+pMpmglg0dmf1+UO1RJRRZlsQftFG7Jk4Ho5apkLHxTzYfdmDSqd3gc2Ej8yeach/
	1lRK1aRXJr9LwNTfIEw2CLyaGona4xXfWoD+R6IzlkqlpK/9u7OJhFcaasYpmqCdyQrZ6fyEdjpk9
	9+/xjosh4NFC0TN96qc0CJx07Mdxmf7p3IalQLMZS0CrKdergnizPbfjWBU+lTeEYbEuGTYmw6H+5
	ECtXQCqw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vdmjm-0000eJ-Sx; Thu, 08 Jan 2026 10:55:27 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vdmjZ-00AchK-PX; Thu, 08 Jan 2026 10:55:13 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 08 Jan 2026 10:54:54 +0100
Subject: [PATCH 1/2] vsock/virtio: Coalesce only linear skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-vsock-recv-coalescence-v1-1-26f97bb9a99b@rbox.co>
References: <20260108-vsock-recv-coalescence-v1-0-26f97bb9a99b@rbox.co>
In-Reply-To: <20260108-vsock-recv-coalescence-v1-0-26f97bb9a99b@rbox.co>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3

Vsock/virtio common tries to coalesce buffers in rx queue: if a linear skb
(with a spare tail room) is followed by a small skb (length limited by
GOOD_COPY_LEN = 128), an attempt is made to join them.

Since the introduction of MSG_ZEROCOPY support, assumption that a small skb
will always be linear is incorrect (see loopback transport). In the
zerocopy case, data is lost and the linear skb is appended with
uninitialized kernel memory.

Ensure only linear skbs are coalesced. Note that skb_tailroom(last_skb) > 0
guarantees last_skb is linear.

Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/virtio_transport_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d5851e..cf35eb7190cc 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1375,7 +1375,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 		 * of a new message.
 		 */
 		if (skb->len < skb_tailroom(last_skb) &&
-		    !(le32_to_cpu(last_hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)) {
+		    !(le32_to_cpu(last_hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) &&
+		    !skb_is_nonlinear(skb)) {
 			memcpy(skb_put(last_skb, skb->len), skb->data, skb->len);
 			free_pkt = true;
 			last_hdr->flags |= hdr->flags;

-- 
2.52.0


