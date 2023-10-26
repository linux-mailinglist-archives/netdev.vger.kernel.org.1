Return-Path: <netdev+bounces-44512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B057D8572
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 17:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE90AB20D8D
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 15:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE802EB1B;
	Thu, 26 Oct 2023 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITmJvQry"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ECF1D52B
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 15:02:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5047018A
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698332524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Le7r1qZdjn6tilkqUR5AFBSjzkY/HKzRQy2FXtGZ7Zs=;
	b=ITmJvQryvmvVW4ZjbahwbbLW5rlyVy4ZEa0ALC1geggUbPMWu+tVRVLm4DkDO0Sb8Kd1kA
	XZwsWx7Am1jaNBUOPep0ykjUDUiJEv5qYikp66ixMHoR+l5NMjNmGo86cOberSRpHZt/wk
	wW9sjdZczihRECRbl47QWkr8XfMaTfM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-CJUDbzJaOVmOKJFEhovj-w-1; Thu, 26 Oct 2023 11:02:03 -0400
X-MC-Unique: CJUDbzJaOVmOKJFEhovj-w-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1c9fc94b182so9509445ad.1
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 08:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698332522; x=1698937322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Le7r1qZdjn6tilkqUR5AFBSjzkY/HKzRQy2FXtGZ7Zs=;
        b=UyQn37iy6ihEpMr3XuTE5f15zjlqL/y1jAlw85YpF2e0n9sOLnQwBm2rapPqT4NRHF
         u1CbOJMyZNaEek6mmEYDILNa/YP8q2rNpOSW7PwowzWlfWHeq+BhNJQWcdO/Jp0haTCs
         YuCGpT50a8M1+AwiYMR/bGHDjz75ARDw06U1bs57E7SZHkboDZXJra5ql9vuwIBIVZlg
         QxHjjGd/etIIGsfNnfyDUZwTLTD4fMFxuhsg///eFAhEloUSu1uKhYQzvd8nhfzoUgBg
         5yNazwhS3WA2r51eHySYKM9V8Bqkk3RqQwV2THmrqAxBmEXIsDocL3hZQMeqeRxr6SjJ
         fvMg==
X-Gm-Message-State: AOJu0YzlI7HWFFf2wdCDUV3bB2JMNa2DMZ5nhSBf8z8rSs1EjD7kLgn6
	+SuiWJ4ZTN5/fMIa7Gji9YA21Qwen3ijJ1yoJbvejndJSupfB+e3+PqBbSyhsaL+HqawRSMl7AO
	TdmgZvOQyGj4DVpP4jMd/JyIFeug=
X-Received: by 2002:a17:902:d48b:b0:1cc:c0f:c163 with SMTP id c11-20020a170902d48b00b001cc0c0fc163mr2030460plg.17.1698332521979;
        Thu, 26 Oct 2023 08:02:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkMkNFGl6pf3X2t9+qgnZ2jJ6k9tsZamwMF9GCo+CggK6U8NBQgmvo80UyqhXw/fy4mQy7ew==
X-Received: by 2002:a17:902:d48b:b0:1cc:c0f:c163 with SMTP id c11-20020a170902d48b00b001cc0c0fc163mr2030417plg.17.1698332521352;
        Thu, 26 Oct 2023 08:02:01 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id g11-20020a170902740b00b001c60e7bf5besm11032572pll.281.2023.10.26.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:02:00 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net] virtio/vsock: Fix uninit-value in virtio_transport_recv_pkt()
Date: Fri, 27 Oct 2023 00:01:54 +0900
Message-ID: <20231026150154.3536433-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported the following uninit-value access issue:

=====================================================
BUG: KMSAN: uninit-value in virtio_transport_recv_pkt+0x1dfb/0x26a0 net/vmw_vsock/virtio_transport_common.c:1421
 virtio_transport_recv_pkt+0x1dfb/0x26a0 net/vmw_vsock/virtio_transport_common.c:1421
 vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
 worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
 kthread+0x3cc/0x520 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Uninit was stored to memory at:
 virtio_transport_space_update net/vmw_vsock/virtio_transport_common.c:1274 [inline]
 virtio_transport_recv_pkt+0x1ee8/0x26a0 net/vmw_vsock/virtio_transport_common.c:1415
 vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
 worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
 kthread+0x3cc/0x520 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Uninit was created at:
 slab_post_alloc_hook+0x105/0xad0 mm/slab.h:767
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x5a2/0xaf0 mm/slub.c:3523
 kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:559
 __alloc_skb+0x2fd/0x770 net/core/skbuff.c:650
 alloc_skb include/linux/skbuff.h:1286 [inline]
 virtio_vsock_alloc_skb include/linux/virtio_vsock.h:66 [inline]
 virtio_transport_alloc_skb+0x90/0x11e0 net/vmw_vsock/virtio_transport_common.c:58
 virtio_transport_reset_no_sock net/vmw_vsock/virtio_transport_common.c:957 [inline]
 virtio_transport_recv_pkt+0x1279/0x26a0 net/vmw_vsock/virtio_transport_common.c:1387
 vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
 worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
 kthread+0x3cc/0x520 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

CPU: 1 PID: 10664 Comm: kworker/1:5 Not tainted 6.6.0-rc3-00146-g9f3ebbef746f #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
Workqueue: vsock-loopback vsock_loopback_work
=====================================================

The following simple reproducer can cause the issue described above:

int main(void)
{
  int sock;
  struct sockaddr_vm addr = {
    .svm_family = AF_VSOCK,
    .svm_cid = VMADDR_CID_ANY,
    .svm_port = 1234,
  };

  sock = socket(AF_VSOCK, SOCK_STREAM, 0);
  connect(sock, (struct sockaddr *)&addr, sizeof(addr));
  return 0;
}

This issue occurs because the `buf_alloc` and `fwd_cnt` fields of the
`struct virtio_vsock_hdr` are not initialized when a new skb is allocated
in `virtio_transport_alloc_skb()`. This patch resolves the issue by
initializing these fields during allocation.

Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 352d042b130b..102673bef189 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -68,6 +68,8 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
 	hdr->dst_port	= cpu_to_le32(dst_port);
 	hdr->flags	= cpu_to_le32(info->flags);
 	hdr->len	= cpu_to_le32(len);
+	hdr->buf_alloc	= cpu_to_le32(0);
+	hdr->fwd_cnt	= cpu_to_le32(0);
 
 	if (info->msg && len > 0) {
 		payload = skb_put(skb, len);
-- 
2.41.0


