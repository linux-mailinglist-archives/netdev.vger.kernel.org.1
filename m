Return-Path: <netdev+bounces-44673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCCF7D9159
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2770F281FAA
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9070114AB2;
	Fri, 27 Oct 2023 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPFJAgaQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1D31401D
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:25:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A841AA
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698395102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/sRPbObTy+hr2BTc4OunFroR638IOm6pKQx0eqZEmBc=;
	b=TPFJAgaQHAuCsv0HevVH7CRjqcA0NUhU/KP0HgRQNqMgb797qxJO9V+XG4a0Lhq6FNP4FE
	UPE1jg/dugDwXgMeibNmvDmP5WaYbfpPjdmyJ8PYoiZ69O4Ge6nSWv0KWxyK0m5n5+lFly
	9sHV5fqVYjtyooPHXCpfHbxaG7Zcmpc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-4bPt-x8WMh6XyDR4STV8-Q-1; Fri, 27 Oct 2023 04:25:01 -0400
X-MC-Unique: 4bPt-x8WMh6XyDR4STV8-Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-408f9e9e9b0so13955375e9.2
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698395100; x=1698999900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sRPbObTy+hr2BTc4OunFroR638IOm6pKQx0eqZEmBc=;
        b=Pa41SAjShkziaQUznrKUC5NMDOsVSSM1RLVGEI/+sjIz21DonU5UXJRXEK4uNcvvcR
         bQ2h4TC8+1UALNCFz5y3DhsAf0gZBtQij2DxXKWcFDTot5YWby9dU2V1snHZQaYAw7Nt
         L+Zogdh0bNnBtr2D287sWoyn59X1oLCKg9MsT9ieWKNKAoc+3L1cI3qnS0eEu6B5ztSa
         p2Kxv5LMMgCy9Ksen1fiVSgPS8d81kYrTImGfVkUHW7ZyU5a1itVQIUN3JtHXwurWWoH
         JujTvRD8WuJK8/fw5WlDNue/xL9oaU7vUttVpBfT8FaBiBCQI1COx3KiBdQmiwIiIUqf
         wEmA==
X-Gm-Message-State: AOJu0Yz1r1nxTJsVqIRiyTZDEPgzdmySJW2rO2MqSs5XPrAGv0kg4dqs
	kfU89THgil+ZuGummY8g+2m05YDZBwSC7LRvFJ3jrXNry0YsVLkfVOP3MctvcVwKDokDz/H1fZ3
	DPhXrcQeo+6WuVXSG
X-Received: by 2002:a05:600c:3b8f:b0:3f6:9634:c8d6 with SMTP id n15-20020a05600c3b8f00b003f69634c8d6mr1735088wms.18.1698395100031;
        Fri, 27 Oct 2023 01:25:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO1d9NiGLpMH9UwrjFO3nIKYTeiI3b8cMpfwR9v8L7e0iFdiDoeQvQOBZ/uEP3Wgl9+7lyBw==
X-Received: by 2002:a05:600c:3b8f:b0:3f6:9634:c8d6 with SMTP id n15-20020a05600c3b8f00b003f69634c8d6mr1735069wms.18.1698395099613;
        Fri, 27 Oct 2023 01:24:59 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it. [87.12.185.56])
        by smtp.gmail.com with ESMTPSA id l12-20020adfe9cc000000b0032dba85ea1bsm1221968wrn.75.2023.10.27.01.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:24:59 -0700 (PDT)
Date: Fri, 27 Oct 2023 10:24:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: syzbot <syzbot+0c8ce1da0ac31abbadcd@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefanha@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux-foundation.org, syoshida@redhat.com
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in virtio_transport_recv_pkt
Message-ID: <ooihytsfbk3brbwi2oj27ju3ff43ns36qhksfixrxdau2nieor@ervvukakvk4n>
References: <00000000000008b2940608ae3ce9@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <00000000000008b2940608ae3ce9@google.com>

On Fri, Oct 27, 2023 at 01:11:24AM -0700, syzbot wrote:
>Hello,
>
>syzbot found the following issue on:
>
>HEAD commit:    d90b0276af8f Merge tag 'hardening-v6.6-rc3' of git://git.k..
>git tree:       upstream
>console+strace: https://syzkaller.appspot.com/x/log.txt?x=102c8b22680000
>kernel config:  https://syzkaller.appspot.com/x/.config?x=6f1a4029b69273f3
>dashboard link: https://syzkaller.appspot.com/bug?extid=0c8ce1da0ac31abbadcd
>compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101e58ec680000
>C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f7adb6680000
>
>Downloadable assets:
>disk image: https://storage.googleapis.com/syzbot-assets/83ae10beee39/disk-d90b0276.raw.xz
>vmlinux: https://storage.googleapis.com/syzbot-assets/c231992300f6/vmlinux-d90b0276.xz
>kernel image: https://storage.googleapis.com/syzbot-assets/6377c9c2ea97/bzImage-d90b0276.xz
>
>IMPORTANT: if you fix the issue, please add the following tag to the commit:
>Reported-by: syzbot+0c8ce1da0ac31abbadcd@syzkaller.appspotmail.com
>
>=====================================================
>BUG: KMSAN: uninit-value in virtio_transport_recv_pkt+0x1c42/0x2580 net/vmw_vsock/virtio_transport_common.c:1421
> virtio_transport_recv_pkt+0x1c42/0x2580 net/vmw_vsock/virtio_transport_common.c:1421
> vsock_loopback_work+0x3e2/0x5d0 net/vmw_vsock/vsock_loopback.c:120
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2703
> worker_thread+0xf45/0x1490 kernel/workqueue.c:2784
> kthread+0x3e8/0x540 kernel/kthread.c:388
> ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
>Uninit was stored to memory at:
> virtio_transport_space_update net/vmw_vsock/virtio_transport_common.c:1274 [inline]
> virtio_transport_recv_pkt+0x1ea4/0x2580 net/vmw_vsock/virtio_transport_common.c:1415
> vsock_loopback_work+0x3e2/0x5d0 net/vmw_vsock/vsock_loopback.c:120
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2703
> worker_thread+0xf45/0x1490 kernel/workqueue.c:2784
> kthread+0x3e8/0x540 kernel/kthread.c:388
> ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
>Uninit was created at:
> slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
> slab_alloc_node mm/slub.c:3478 [inline]
> kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3523
> kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:559
> __alloc_skb+0x318/0x740 net/core/skbuff.c:650
> alloc_skb include/linux/skbuff.h:1286 [inline]
> virtio_vsock_alloc_skb include/linux/virtio_vsock.h:66 [inline]
> virtio_transport_alloc_skb+0x8b/0x1170 net/vmw_vsock/virtio_transport_common.c:58
> virtio_transport_reset_no_sock net/vmw_vsock/virtio_transport_common.c:957 [inline]
> virtio_transport_recv_pkt+0x1531/0x2580 net/vmw_vsock/virtio_transport_common.c:1387
> vsock_loopback_work+0x3e2/0x5d0 net/vmw_vsock/vsock_loopback.c:120
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2703
> worker_thread+0xf45/0x1490 kernel/workqueue.c:2784
> kthread+0x3e8/0x540 kernel/kthread.c:388
> ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
>CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.6.0-rc2-syzkaller-00337-gd90b0276af8f #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
>Workqueue: vsock-loopback vsock_loopback_work
>=====================================================
>

Shigeru Yoshida already posted a patch here:

https://lore.kernel.org/netdev/20231026150154.3536433-1-syoshida@redhat.com/


