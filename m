Return-Path: <netdev+bounces-254436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hHjhA4Jyemme6gEAu9opvQ
	(envelope-from <netdev+bounces-254436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:33:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B75A6A899B
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F1823025E64
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 20:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C54374752;
	Wed, 28 Jan 2026 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUXXe7xE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwcBGGuw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12202374199
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632291; cv=none; b=dMkLNhlgljYAuDmMDwIaZcqiM29o1wYheX4b3XA6gGRJj2g2G7r7OJ475hIRPpTDRen+jbv+4xkZoOwqDsZ2ek0BhocxFEKphT9mlhqnCYlihhLl0rCEkTs5R5c3Pfil8c2ZrQuSmaZnvjUSSLkxclFpWtMDAllcISKCwVIrCHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632291; c=relaxed/simple;
	bh=2qvxf/62yttfNIZNAODh63qlXVSL99Ksrx5/ufwbejY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=spWucQeEZPdp7UK+KxSI6ZoQOBGAbRpIHGgcb9Gr0IgpplNp611/Jp+D3hgWRqtLoCArVjQsProuiI/E0Tngj2EQ2FJAwJCkr5uDVf2+7fpbQNJoxeEdaN1cpgCKuvxTsstz3T+alKPu9rcxbLvcL54eo2wUDb3Y5DaE7YevUUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUXXe7xE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwcBGGuw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769632288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=6AqTWTOgRm78zpGWundx5DPK3QN0XJ8tGQTS1p8e64k=;
	b=XUXXe7xETErab3wRuyukJ0+lVBhbKkaCcNv8QLKZwc4IIIOHcz3YCrmR6f3vNH/wlZJpjk
	RnC4h+hm/NmAXYcWToR0nweZcgFZTxuS7xUNA6G2dCk/ERzre7e1N9gkt+KnsEx7+IwE5O
	OR9QHTRzknUlppVd6rQJVsvP5dNvT5I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-KZUrWKFLOpui4XPNw7AHcw-1; Wed, 28 Jan 2026 15:31:26 -0500
X-MC-Unique: KZUrWKFLOpui4XPNw7AHcw-1
X-Mimecast-MFC-AGG-ID: KZUrWKFLOpui4XPNw7AHcw_1769632285
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47ee3dd7fc8so2289955e9.3
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 12:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769632285; x=1770237085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6AqTWTOgRm78zpGWundx5DPK3QN0XJ8tGQTS1p8e64k=;
        b=fwcBGGuw7IqQDPevelrNI5mPPr97koUxkOdPBeevIRXEdn2WQmQxRqzM4vbWV5CQ1K
         GzG9MFQtT4t1UxM8me4DW4lGDGZMEMK2FdX8SYol2akxmRNKL/MKMwIty3VtcOZAXl9Y
         wWS67ozLZW0GAsRqnPn39uwB0neig513SYS7rQ4feyTLBzJhhqABshCSXW7vNqJZmDFf
         A4TdMWerNpSOIlJWmzAwR31lzurm2R3U59p0qiXMV54wKq1LH3nxg60LZ94v/n0WM/10
         YOFMpQJ7sMCG/fIm2pvP57/YDw7JqNTudoYipg0ZAcyARnfbopdd6agIeA4ATotjkCEM
         Kigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769632285; x=1770237085;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AqTWTOgRm78zpGWundx5DPK3QN0XJ8tGQTS1p8e64k=;
        b=hLtNasnSSW6/K/QkeCAerXI6gxaRknt3TdB5A89DISMKFmazVLVqcdMnglaUGyGtzL
         xnvRAFY5F4FKcntH4zO2KGORVRzOqfDA3R/HBmCQmX1qiVzwm+0l4lHrF3SEHC9CKgsQ
         hKo9swshAlxmt/loXAjFHSTagu4Drtxd9EzqMlP0Rs/VhZ1/EShmNfb72MD1s9LKTd7j
         gnm8et3XKoa+y3kql7JMMhCMbxqdk9u911fFC0ZgvyNhm5/Oj15qEv7vZVvf/oukcA8x
         GN3AC+t/exI36q8EYHlN8pPMJZ8yxgNmXX9/W3Jpxw6w4rvn1sVL9nSXEUC5Lf/+MsAS
         t3PQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8vN65EgynP4qqCZQ2cBXTwEffwVsaQymqSCRzoDobCWnXctRv+pu19vAckcDXJXrpjQ1Slpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyexRUoOhWaVqnlfm5+Zqr1uECO4WAQ44RMUeZhsdsp/D9lJPyp
	Xz/6sks2sOAWrSM6oonpKzNiyucCz4NaIectjnOl7Ztl7aDoPOPF0QMGbczw+H6WC0BWrOUO4II
	NBDO7JgdGtZFizD0exO1RTiP2W/Fw+TyWpCxRH21d9mTO9gMWJNLWSVOyMA==
X-Gm-Gg: AZuq6aJd0ocKDCy+LYq5FYgxTfEfS2BLtFc2qWu/0DOZv9qUEh5+X4MirxpH1GOkDUr
	6BFeg/HqyvDP8HVDgEuos8wnVUFksqUFbR+YM3Z+oyx21ufqPSpV9itFRehOAqBbSOR9mKIFoJ8
	QwL8yWtxus3mXoMBXzoGqO773dcRcERoXtleTqkuOCJzM9QYcBUPqMJyMuWfU1+xXIqH0e2je/y
	IBHAsltH1Ceo7GnAQe6NKozaeWUEb7DlJGVk6zBZJ/bYrwPhXi1kSv6CLWE9Ty28i8Rw+SkrjHC
	Xpe5fLQpBAvtbVW2oDxzNm1cZT9lDOraI+ql/p9h5ldIXmpZjPZUq3iQgo86BI8VQL3N5unzjSq
	Xm7xw7+iQru2t31ZAE1ljL2CW3HOoBNwDSA==
X-Received: by 2002:a05:600c:6995:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-48069c92c03mr93433865e9.31.1769632285343;
        Wed, 28 Jan 2026 12:31:25 -0800 (PST)
X-Received: by 2002:a05:600c:6995:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-48069c92c03mr93433305e9.31.1769632284808;
        Wed, 28 Jan 2026 12:31:24 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066beeaf9sm161529595e9.6.2026.01.28.12.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 12:31:24 -0800 (PST)
Date: Wed, 28 Jan 2026 15:31:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v3 15/15] vsock/virtio: reorder fields to reduce padding
Message-ID: <ce44f61af415521e00ab7492aa16d3d19f00bd5e.1769632071.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1221bbc120df6adaba9006710a517f1e84a10b2.1767601130.git.mst@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lwn.net,selenic.com,gondor.apana.org.au,redhat.com,hansenpartnership.com,oracle.com,linux.alibaba.com,samsung.com,arm.com,davemloft.net,google.com,kernel.org,suse.com,ziepe.ca,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254436-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B75A6A899B
X-Rspamd-Action: no action

Reorder struct virtio_vsock fields to place the DMA buffer (event_list)
last. This eliminates the padding from aligning the struct size on
ARCH_DMA_MINALIGN.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

changes from v2:
	move event_lock and event_run too, to keep
	event things logically together, as suggested by
	Stefano Garzarella.

Note: this is the only change in v3 and it's cosmetic, so I am
not reposting the whole patchset.


 net/vmw_vsock/virtio_transport.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 999a0839726a..b333a7591b26 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -55,15 +55,6 @@ struct virtio_vsock {
 	int rx_buf_nr;
 	int rx_buf_max_nr;
 
-	/* The following fields are protected by event_lock.
-	 * vqs[VSOCK_VQ_EVENT] must be accessed with event_lock held.
-	 */
-	struct mutex event_lock;
-	bool event_run;
-	__dma_from_device_group_begin();
-	struct virtio_vsock_event event_list[8];
-	__dma_from_device_group_end();
-
 	u32 guest_cid;
 	bool seqpacket_allow;
 
@@ -77,6 +68,15 @@ struct virtio_vsock {
 	 */
 	struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
 	struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
+
+	/* The following fields are protected by event_lock.
+	 * vqs[VSOCK_VQ_EVENT] must be accessed with event_lock held.
+	 */
+	struct mutex event_lock;
+	bool event_run;
+	__dma_from_device_group_begin();
+	struct virtio_vsock_event event_list[8];
+	__dma_from_device_group_end();
 };
 
 static u32 virtio_transport_get_local_cid(void)
-- 
MST


