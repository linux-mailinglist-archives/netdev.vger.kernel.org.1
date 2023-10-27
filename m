Return-Path: <netdev+bounces-44667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 982E97D9086
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9972821AA
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF2F1171D;
	Fri, 27 Oct 2023 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="here8N/x"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82313FC04
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:02:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC9E1B1
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698393734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qahb/LE7va9Q1Iif0xKr62EhnyUP1QxSWkvvxRc0UUw=;
	b=here8N/xKMNdJ6RFPvGCi9KF+uOPjUamXZsq5Pb/MkMV27DTFOGrAZl97h73y4RVzCTnvq
	ZekxcQM1zic9KgDtgtAYxbIANa5YGWCq8vrZxmU2tP9ncNUdDLQJkk51vGsx41v8b9MQV3
	0ChwIQNPIivPl+HER4/hJ20uhwyc4kM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-jMwozr0TMQCDAkNiyzAsCg-1; Fri, 27 Oct 2023 04:02:00 -0400
X-MC-Unique: jMwozr0TMQCDAkNiyzAsCg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40853e14f16so14436715e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698393719; x=1698998519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qahb/LE7va9Q1Iif0xKr62EhnyUP1QxSWkvvxRc0UUw=;
        b=nJKj3fUtEje6CWyKe/w1JMTZOpjgmhebjrhoshHwM2TL7iZ30PdyKwfR2dhz2h1xfR
         WV5cS/7VahKmmW2igHt98n2HT9XKb5OWq7fb0VR4HOXb8AJ6x+9OrmlpoSbey1C2GogE
         CDlN7OcqhYAWcCiPZDA2vfOd7oipErGM0OAo+rmMDqotYeuFRCbkr8KpKMaV55WKt9i0
         5mr0v3sVY7Nv5SESbGLVthqCRokCjKhhhLUmtv0c/h8fCx91W9Voz38ZZthcrU7aNWUs
         dYPk3KgFtZ7oCpdSC/Uq+1gNMIorcvLlGsHs+wkBgVCCZMLlmvDFqrgjngUeQpF7quDR
         TsFw==
X-Gm-Message-State: AOJu0Yy3uJxqSYcelQTDTSik5TJni/zKxkJmeOTjTN97JVIgnmEeK74z
	cy73JLhI4x1Tge5my1T2Miagou9+fVzWuYaujRvUTJpdNiu8d4vbHYTIJDOEXk2/4b6CzEPvSew
	D35Y/avab6RoTi57k
X-Received: by 2002:a7b:cb19:0:b0:403:b86:f624 with SMTP id u25-20020a7bcb19000000b004030b86f624mr1470991wmj.23.1698393719510;
        Fri, 27 Oct 2023 01:01:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsWq4ysIXWhOeaSY7ybDArSvHomlUP94STda82wQjfGaQQaqu+1TEC/2s6C4J8Uij9mn2YWA==
X-Received: by 2002:a7b:cb19:0:b0:403:b86:f624 with SMTP id u25-20020a7bcb19000000b004030b86f624mr1470972wmj.23.1698393719078;
        Fri, 27 Oct 2023 01:01:59 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it. [87.12.185.56])
        by smtp.gmail.com with ESMTPSA id ay32-20020a05600c1e2000b004065daba6casm4464276wmb.46.2023.10.27.01.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:01:58 -0700 (PDT)
Date: Fri, 27 Oct 2023 10:01:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: stefanha@redhat.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bobby.eshleman@bytedance.com, bobbyeshleman@gmail.com
Subject: Re: [PATCH net] virtio/vsock: Fix uninit-value in
 virtio_transport_recv_pkt()
Message-ID: <waodmdtiiq6qcdj4pwys5pod7eyveqkfq6fwqy5hqptzembcxf@siitwagevn2f>
References: <20231026150154.3536433-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231026150154.3536433-1-syoshida@redhat.com>

On Fri, Oct 27, 2023 at 12:01:54AM +0900, Shigeru Yoshida wrote:
>KMSAN reported the following uninit-value access issue:
>
>=====================================================
>BUG: KMSAN: uninit-value in virtio_transport_recv_pkt+0x1dfb/0x26a0 net/vmw_vsock/virtio_transport_common.c:1421
> virtio_transport_recv_pkt+0x1dfb/0x26a0 net/vmw_vsock/virtio_transport_common.c:1421
> vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
> worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
> kthread+0x3cc/0x520 kernel/kthread.c:388
> ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
>Uninit was stored to memory at:
> virtio_transport_space_update net/vmw_vsock/virtio_transport_common.c:1274 [inline]
> virtio_transport_recv_pkt+0x1ee8/0x26a0 net/vmw_vsock/virtio_transport_common.c:1415
> vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
> worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
> kthread+0x3cc/0x520 kernel/kthread.c:388
> ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
>Uninit was created at:
> slab_post_alloc_hook+0x105/0xad0 mm/slab.h:767
> slab_alloc_node mm/slub.c:3478 [inline]
> kmem_cache_alloc_node+0x5a2/0xaf0 mm/slub.c:3523
> kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:559
> __alloc_skb+0x2fd/0x770 net/core/skbuff.c:650
> alloc_skb include/linux/skbuff.h:1286 [inline]
> virtio_vsock_alloc_skb include/linux/virtio_vsock.h:66 [inline]
> virtio_transport_alloc_skb+0x90/0x11e0 net/vmw_vsock/virtio_transport_common.c:58
> virtio_transport_reset_no_sock net/vmw_vsock/virtio_transport_common.c:957 [inline]
> virtio_transport_recv_pkt+0x1279/0x26a0 net/vmw_vsock/virtio_transport_common.c:1387
> vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
> worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
> kthread+0x3cc/0x520 kernel/kthread.c:388
> ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
>CPU: 1 PID: 10664 Comm: kworker/1:5 Not tainted 6.6.0-rc3-00146-g9f3ebbef746f #3
>Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
>Workqueue: vsock-loopback vsock_loopback_work
>=====================================================
>
>The following simple reproducer can cause the issue described above:
>
>int main(void)
>{
>  int sock;
>  struct sockaddr_vm addr = {
>    .svm_family = AF_VSOCK,
>    .svm_cid = VMADDR_CID_ANY,
>    .svm_port = 1234,
>  };
>
>  sock = socket(AF_VSOCK, SOCK_STREAM, 0);
>  connect(sock, (struct sockaddr *)&addr, sizeof(addr));
>  return 0;
>}
>
>This issue occurs because the `buf_alloc` and `fwd_cnt` fields of the
>`struct virtio_vsock_hdr` are not initialized when a new skb is allocated
>in `virtio_transport_alloc_skb()`. This patch resolves the issue by
>initializing these fields during allocation.
>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")

CCin Bobby, the original author, for any additional comments/checks.

Yeah, I see, before that commit we used kzalloc() to allocate the
header so we forgot to reset these 2 fields, and checking they are
the only 2 missing.

I was thinking of putting a memset(hdr, 0, sizeof(*hdr)) in
virtio_vsock_alloc_skb() but I think it's just extra unnecessary work,
since here we set all the fields (thanks to this fix), in vhost/vsock.c
we copy all the header we receive from the guest and in
virtio_transport.c we already set it all to 0 because we are
preallocating the receive buffers.

So I'm fine with this fix!

>Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 352d042b130b..102673bef189 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -68,6 +68,8 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
> 	hdr->dst_port	= cpu_to_le32(dst_port);
> 	hdr->flags	= cpu_to_le32(info->flags);
> 	hdr->len	= cpu_to_le32(len);
>+	hdr->buf_alloc	= cpu_to_le32(0);
>+	hdr->fwd_cnt	= cpu_to_le32(0);
>
> 	if (info->msg && len > 0) {
> 		payload = skb_put(skb, len);
>-- 
>2.41.0
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano


