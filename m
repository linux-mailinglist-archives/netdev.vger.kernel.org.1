Return-Path: <netdev+bounces-251827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOw9DYCgcGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:46:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0D654A1C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F9085C7D2F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED30C44B66B;
	Wed, 21 Jan 2026 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCNpCKQX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsEW//E2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1273F47DFA7
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988213; cv=none; b=j9Y+lYz71lI52BTjtVNPnwPMsBxaJzlB5IBz+DreAZtU5rz/H7Bk37EZqWLPFfbdI6mn2DIGpWc4KhjWAGKjpDy8DOjTZATWzM6NtlOmHcY9JR76kTqyYf1bI+9CKXG4OpCWHktV5hPf0NvPBBTNOjWr1ImRIMbPsyRlnvQ4Ohg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988213; c=relaxed/simple;
	bh=8FWDPO7w394Nl7XKsuUojlhzUFs0e7ivz29bXEwBdFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfLoS9FWwkKB4lkIoIXIAMjIPKtClJAQ+vBDLi6pa1cCgMjA0zXOmdlkpkd1JgnbHzNTu6jIXZcefulQt91Zd2FS8uxmEPviyamIOl4o+ac4t29m2+Tq7P7gJC++UoDIg9lwNKfFkzd7I8VAMjQaHVdxHqPPIJMX7ab7qEw/Fag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCNpCKQX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FsEW//E2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768988210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xGM0zHbdn0V12NgombpaBR+rEA6S/BsSNVQrMd4WoM4=;
	b=TCNpCKQXLnMOks5bMqZAJ4IcqtJ38t1OYTT/zmFHOzMsLVbAgJa8CrnksFobDbD40Bq4bU
	j77PBp5+UqWzgb7tyP6SMb/QWmQbPSAiKJ/NIc08FRyiO4PxFOhrjFWQ+RxgsqjdZSynbF
	p60xgQ+5IFRV8FpO4tV8Hlmusm88L9c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-PNhKyh2MNymVkoQAC2soMQ-1; Wed, 21 Jan 2026 04:36:49 -0500
X-MC-Unique: PNhKyh2MNymVkoQAC2soMQ-1
X-Mimecast-MFC-AGG-ID: PNhKyh2MNymVkoQAC2soMQ_1768988208
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430f4609e80so4307748f8f.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768988207; x=1769593007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGM0zHbdn0V12NgombpaBR+rEA6S/BsSNVQrMd4WoM4=;
        b=FsEW//E2u1CEsxjYG47z7hsFynDqounY7IdwZW24zQaclAiWtsfM5UcxlCFS1JphxT
         AtCTetfCd17QqNt29EWVx9OjGolE1MrPdIbp5O796bG1CSiJU7jSCjDWGnRQuBS5PesS
         oG68+iv8SH7RViyxR5hZC4LM5T81iTB8fZA7ae/rClGahaLTtbyRNDytRt18Wg3AYUbO
         1ytf8O77MIp5OieEl/V5A/TBRRMsVakO1zPFCFtyv2phuSICyfC4W0gA2YDcAJ4e19z+
         SmeDwu7/Tso7TAKQX5HUSKIjR4yjFbyVBVRgi8fi35EkdSyrtIzu29cNY30/wHZr0O3k
         SRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988207; x=1769593007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xGM0zHbdn0V12NgombpaBR+rEA6S/BsSNVQrMd4WoM4=;
        b=CxO5NUTC0dJ8jnLWhbgxLoZVKJbEi9ysLDANyLcRL9Kk0xMUXxUWMCvE5ayGfZZ5oS
         M5YNtRo2gD/fQm9yxotlFH247TgearA9rAi2R+1fzOPhqIp3xppZ4V1siPqQWOSWXyvO
         gReO4PjGrX1hNfw2At3Z/rFutkK8RI2ckEjQw5bnkrf1Y05wJ/RI8rRq2T/i9ux+roM7
         vs5LX25R01uOFjyY3Itm/xq3fm8CAJvdoJQM3D1sPJga4AOTCUQEOUsz77dVtIlv0OZG
         oVHNVXNVdK3TGlzxUzUpu/CNXZsVzFf2rEYHge1GDOvo2JLACYqyA3xKngDpGncAKD5F
         Fe4g==
X-Gm-Message-State: AOJu0Yx9NyMuoQgWB+qDywVDZbuIGQKoA6hoTJPsRvslMk2URR1lcf6S
	wTjubqxSUxKW7lTLsR70jd03RG/orhCTEK30K+Emao/pfTVTVwK101oSIYM2XQc6+KvcTwQ1KTE
	ovwWUHHXeKpX85A1PKquzdnsn1OinUCn/sl/jR5zgr2YnruHXenCyrHm2Z3U2pTIHhAVZ24llvY
	oCJ2TiwPt8sELoXgVDUxssn3ap/O4/W48wn4bfe1wxNA==
X-Gm-Gg: AZuq6aJXyE5CEbFC21/Aol80dO4iAC+hALN++wXlpW7/RoScWzMmHOdm1VfCQZMAZR8
	kYZ0ZDRymXid4k2niiZLUedopxJN5E93CmY7/8LULxEI2RMK1ghE2N+MZ3hhcNnjTMUtYLAi7+V
	+dJNXAqJRBbijK+OReOb9xu2OnXrhjbnyVqjg+S1AkkssDy9JqOpwCzIGdBVCClbHt4AQY9TAmc
	KJqF0V8Lkb32gahC6k8mWbe8IVKTSbx0LRLAJfsz/9ji7uIcfJ2MTaTYY9ZV3zROFn+fb1ZrYJB
	YzwhQzwfLscckZok+7W+yAEYw9Z5Sma6LacTlUUmYSobRZxxzyMDxW8nFhKojDGqRg6cAq1a8vK
	vhy2cd8QafBgTj7UxyjZN9In1nqb+EZGIsSOLxb8Am7W37myQAJ49aV9gWyL6
X-Received: by 2002:a05:6000:18b:b0:435:94c4:649c with SMTP id ffacd0b85a97d-43594c4658bmr4628428f8f.30.1768988207242;
        Wed, 21 Jan 2026 01:36:47 -0800 (PST)
X-Received: by 2002:a05:6000:18b:b0:435:94c4:649c with SMTP id ffacd0b85a97d-43594c4658bmr4628374f8f.30.1768988206674;
        Wed, 21 Jan 2026 01:36:46 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921da2sm35389534f8f.1.2026.01.21.01.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:36:45 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Asias He <asias@redhat.com>,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH net v6 3/4] vsock/virtio: cap TX credit to local buffer size
Date: Wed, 21 Jan 2026 10:36:27 +0100
Message-ID: <20260121093628.9941-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121093628.9941-1-sgarzare@redhat.com>
References: <20260121093628.9941-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251827-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,redhat.com,sberdevices.ru,davemloft.net,lists.linux.dev,vger.kernel.org,linux.vnet.ibm.com,linux.alibaba.com,gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: EC0D654A1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Melbin K Mathew <mlbnkm1@gmail.com>

The virtio transports derives its TX credit directly from peer_buf_alloc,
which is set from the remote endpoint's SO_VM_SOCKETS_BUFFER_SIZE value.

On the host side this means that the amount of data we are willing to
queue for a connection is scaled by a guest-chosen buffer size, rather
than the host's own vsock configuration. A malicious guest can advertise
a large buffer and read slowly, causing the host to allocate a
correspondingly large amount of sk_buff memory.
The same thing would happen in the guest with a malicious host, since
virtio transports share the same code base.

Introduce a small helper, virtio_transport_tx_buf_size(), that
returns min(peer_buf_alloc, buf_alloc), and use it wherever we consume
peer_buf_alloc.

This ensures the effective TX window is bounded by both the peer's
advertised buffer and our own buf_alloc (already clamped to
buffer_max_size via SO_VM_SOCKETS_BUFFER_MAX_SIZE), so a remote peer
cannot force the other to queue more data than allowed by its own
vsock settings.

On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
32 guest vsock connections advertising 2 GiB each and reading slowly
drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB; the system only
recovered after killing the QEMU process. That said, if QEMU memory is
limited with cgroups, the maximum memory used will be limited.

With this patch applied:

  Before:
    MemFree:        ~61.6 GiB
    Slab:           ~142 MiB
    SUnreclaim:     ~117 MiB

  After 32 high-credit connections:
    MemFree:        ~61.5 GiB
    Slab:           ~178 MiB
    SUnreclaim:     ~152 MiB

Only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the guest
remains responsive.

Compatibility with non-virtio transports:

  - VMCI uses the AF_VSOCK buffer knobs to size its queue pairs per
    socket based on the local vsk->buffer_* values; the remote side
    cannot enlarge those queues beyond what the local endpoint
    configured.

  - Hyper-V's vsock transport uses fixed-size VMBus ring buffers and
    an MTU bound; there is no peer-controlled credit field comparable
    to peer_buf_alloc, and the remote endpoint cannot drive in-flight
    kernel memory above those ring sizes.

  - The loopback path reuses virtio_transport_common.c, so it
    naturally follows the same semantics as the virtio transport.

This change is limited to virtio_transport_common.c and thus affects
virtio-vsock, vhost-vsock, and loopback, bringing them in line with the
"remote window intersected with local policy" behaviour that VMCI and
Hyper-V already effectively have.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
[Stefano: small adjustments after changing the previous patch]
[Stefano: tweak the commit message]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 6175124d63d3..d3e26025ef58 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -821,6 +821,15 @@ virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
 }
 EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_dequeue);
 
+static u32 virtio_transport_tx_buf_size(struct virtio_vsock_sock *vvs)
+{
+	/* The peer advertises its receive buffer via peer_buf_alloc, but we
+	 * cap it to our local buf_alloc so a remote peer cannot force us to
+	 * queue more data than our own buffer configuration allows.
+	 */
+	return min(vvs->peer_buf_alloc, vvs->buf_alloc);
+}
+
 int
 virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
 				   struct msghdr *msg,
@@ -830,7 +839,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
 
 	spin_lock_bh(&vvs->tx_lock);
 
-	if (len > vvs->peer_buf_alloc) {
+	if (len > virtio_transport_tx_buf_size(vvs)) {
 		spin_unlock_bh(&vvs->tx_lock);
 		return -EMSGSIZE;
 	}
@@ -884,7 +893,8 @@ static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs)
 	 * we have bytes in flight (tx_cnt - peer_fwd_cnt), the subtraction
 	 * does not underflow.
 	 */
-	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+	bytes = (s64)virtio_transport_tx_buf_size(vvs) -
+		(vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (bytes < 0)
 		bytes = 0;
 
-- 
2.52.0


