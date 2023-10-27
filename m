Return-Path: <netdev+bounces-44712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9DD7D94F3
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C9F282357
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B5E1799B;
	Fri, 27 Oct 2023 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQ2cWcnb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE0B168CF
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:15:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3866D7
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698401733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3RUe/42QKtvFOMbEd083sCtycO90wm6iZz1XgOvH0k=;
	b=CQ2cWcnb4RRtqcAvgjETRzgp9BX6TAs94TmhTIOykcaQa3u8whvFFo2qiDrtr/RMq1Up76
	NCbIjiFYj4itn+ogdX5mOWS8I19uokIlaorGWvGGvkg0cjlC9myNNya76BzrEYPGtealSD
	NZ1MgMq3+HqRLQy0AmAk5t1ChX3bjSQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-mM99Roe_MneRR4q9jXgKCw-1; Fri, 27 Oct 2023 06:15:32 -0400
X-MC-Unique: mM99Roe_MneRR4q9jXgKCw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41e1d05a5d7so23299901cf.2
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698401732; x=1699006532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3RUe/42QKtvFOMbEd083sCtycO90wm6iZz1XgOvH0k=;
        b=fxVBMK1DSZbgnOc4keXbvTVwGX31P2ADxENonMKVuMxzQaKTvaNNaQfMq8KCC3JBQQ
         fNzA9PKx3RRGmC7Ot7jO4lfjiwVW9X+T+02L6pvFv6Fv+CHdDRovrUcyrNcqosxg98Q0
         xKtOaeWCMMpTPkA6IY1liBvWDfjsKCMM6KD2NveInZBJTih6XuUZRBnV9PvkfQ62Hhrm
         amMROskZoHIf6vjlKDTNq6WhWt+hYoGbMRJnIJMuRF3ZoKm/k/m++YOn5o/F406bqbRy
         ibisaqGNMOjLN/5NJ0FnST9u5pAL9wXztaWNhlv0GOv1cbfo6OmjdUJZVUCSxeBEurrs
         RWag==
X-Gm-Message-State: AOJu0Yy+iFvp2DZc94c7GWi9Ehi0oXSA7jmYrHHDAL6cOGl5+q8PqF5v
	okEhNNQxC0kb9v+2KFBrJkI+kU5PNHXaSvmVL+fFjIGoevpZ7ViXXYRRZrpkbg3xz8w8HXL3EKp
	GnvdHXkttLiEAT0+hlHGQk9uV
X-Received: by 2002:ac8:5d07:0:b0:418:1235:5c86 with SMTP id f7-20020ac85d07000000b0041812355c86mr2910756qtx.43.1698401731792;
        Fri, 27 Oct 2023 03:15:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTEePNVAmHZb/864E4GdsNkiYTWojqEFJErvbBvnJDxMpu5e0tdtlubNMMIbyRvGLZJkKphA==
X-Received: by 2002:ac8:5d07:0:b0:418:1235:5c86 with SMTP id f7-20020ac85d07000000b0041812355c86mr2910723qtx.43.1698401731427;
        Fri, 27 Oct 2023 03:15:31 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it. [87.12.185.56])
        by smtp.gmail.com with ESMTPSA id g21-20020ac85815000000b00418122186ccsm460002qtg.12.2023.10.27.03.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 03:15:31 -0700 (PDT)
Date: Fri, 27 Oct 2023 12:15:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: syzbot <syzbot+0c8ce1da0ac31abbadcd@syzkaller.appspotmail.com>, 
	davem@davemloft.net, kuba@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, stefanha@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux-foundation.org, syoshida@redhat.com
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in virtio_transport_recv_pkt
Message-ID: <6pljp7toxsxk4ljnggvn44djqzbi2g3bfou5snhugdrbabu7wv@fpueaouu26ly>
References: <00000000000008b2940608ae3ce9@google.com>
 <ooihytsfbk3brbwi2oj27ju3ff43ns36qhksfixrxdau2nieor@ervvukakvk4n>
 <CANn89i+kKiSL6KJ6cEW_J5BmV3vSswbNPMNVm8ysKjDynF9d5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+kKiSL6KJ6cEW_J5BmV3vSswbNPMNVm8ysKjDynF9d5w@mail.gmail.com>

On Fri, Oct 27, 2023 at 10:48:39AM +0200, Eric Dumazet wrote:
>On Fri, Oct 27, 2023 at 10:25 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Fri, Oct 27, 2023 at 01:11:24AM -0700, syzbot wrote:
>> >Hello,
>> >
>> >syzbot found the following issue on:
>> >
>> >HEAD commit:    d90b0276af8f Merge tag 'hardening-v6.6-rc3' of git://git.k..
>> >git tree:       upstream
>> >console+strace: https://syzkaller.appspot.com/x/log.txt?x=102c8b22680000
>> >kernel config:  https://syzkaller.appspot.com/x/.config?x=6f1a4029b69273f3
>> >dashboard link: https://syzkaller.appspot.com/bug?extid=0c8ce1da0ac31abbadcd
>> >compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> >syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101e58ec680000
>> >C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f7adb6680000
>> >
>> >Downloadable assets:
>> >disk image: https://storage.googleapis.com/syzbot-assets/83ae10beee39/disk-d90b0276.raw.xz
>> >vmlinux: https://storage.googleapis.com/syzbot-assets/c231992300f6/vmlinux-d90b0276.xz
>> >kernel image: https://storage.googleapis.com/syzbot-assets/6377c9c2ea97/bzImage-d90b0276.xz
>> >
>> >IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> >Reported-by: syzbot+0c8ce1da0ac31abbadcd@syzkaller.appspotmail.com
>> >
>> >=====================================================
>> >BUG: KMSAN: uninit-value in virtio_transport_recv_pkt+0x1c42/0x2580 net/vmw_vsock/virtio_transport_common.c:1421
>> > virtio_transport_recv_pkt+0x1c42/0x2580 net/vmw_vsock/virtio_transport_common.c:1421
>> > vsock_loopback_work+0x3e2/0x5d0 net/vmw_vsock/vsock_loopback.c:120
>> > process_one_work kernel/workqueue.c:2630 [inline]
>> > process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2703
>> > worker_thread+0xf45/0x1490 kernel/workqueue.c:2784
>> > kthread+0x3e8/0x540 kernel/kthread.c:388
>> > ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
>> > ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>> >
>> >Uninit was stored to memory at:
>> > virtio_transport_space_update net/vmw_vsock/virtio_transport_common.c:1274 [inline]
>> > virtio_transport_recv_pkt+0x1ea4/0x2580 net/vmw_vsock/virtio_transport_common.c:1415
>> > vsock_loopback_work+0x3e2/0x5d0 net/vmw_vsock/vsock_loopback.c:120
>> > process_one_work kernel/workqueue.c:2630 [inline]
>> > process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2703
>> > worker_thread+0xf45/0x1490 kernel/workqueue.c:2784
>> > kthread+0x3e8/0x540 kernel/kthread.c:388
>> > ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
>> > ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>> >
>> >Uninit was created at:
>> > slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
>> > slab_alloc_node mm/slub.c:3478 [inline]
>> > kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3523
>> > kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:559
>> > __alloc_skb+0x318/0x740 net/core/skbuff.c:650
>> > alloc_skb include/linux/skbuff.h:1286 [inline]
>> > virtio_vsock_alloc_skb include/linux/virtio_vsock.h:66 [inline]
>> > virtio_transport_alloc_skb+0x8b/0x1170 net/vmw_vsock/virtio_transport_common.c:58
>> > virtio_transport_reset_no_sock net/vmw_vsock/virtio_transport_common.c:957 [inline]
>> > virtio_transport_recv_pkt+0x1531/0x2580 net/vmw_vsock/virtio_transport_common.c:1387
>> > vsock_loopback_work+0x3e2/0x5d0 net/vmw_vsock/vsock_loopback.c:120
>> > process_one_work kernel/workqueue.c:2630 [inline]
>> > process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2703
>> > worker_thread+0xf45/0x1490 kernel/workqueue.c:2784
>> > kthread+0x3e8/0x540 kernel/kthread.c:388
>> > ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
>> > ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>> >
>> >CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.6.0-rc2-syzkaller-00337-gd90b0276af8f #0
>> >Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
>> >Workqueue: vsock-loopback vsock_loopback_work
>> >=====================================================
>> >
>>
>> Shigeru Yoshida already posted a patch here:
>>
>> https://lore.kernel.org/netdev/20231026150154.3536433-1-syoshida@redhat.com/
>
>Sure thing, this is why I released this syzbot report from my queue.
>

Thanks for that ;-)

Stefano


