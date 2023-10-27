Return-Path: <netdev+bounces-44680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F597D92A4
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45DA28230A
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226CA14A9C;
	Fri, 27 Oct 2023 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aecwCwC7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0C717E3
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:51:05 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F5DC4
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:51:03 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53f98cbcd76so7073a12.1
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698396662; x=1699001462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeqtBdHG7bcobHfiIzbFtER/jGjT7rW2oiFAlRzp+Fo=;
        b=aecwCwC7wf/tavm+WylLt3U8VkiIEbpWvvGDxdWAp0CbGBAB4PzKDneD/+wKYDMcmf
         c3PnY149u4AEiGXwjeyGFFjwwZ+opC5bGfdtzokdBHOJlRkNGNBwsJS06zMylomoB2Dh
         0tYzpzhHLNd7m4CPrvPZkqJi+qIQpQOqO0U/TRa9sxDxQUE9R8S/oY7sCgyJ+TDf6afl
         jaJiX+GcZQpXbnS576AcAY4/iA8YbUWd8kjU0AsBM0eya4PndPjDbFO1eEHGdHGOgo8x
         pdCPGcRo8DVn9o8W4+qaX34h5CbjsZVWsmNC9fGZNzD50AW5vdqWRskhCy/UnBzykCEy
         Sm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698396662; x=1699001462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeqtBdHG7bcobHfiIzbFtER/jGjT7rW2oiFAlRzp+Fo=;
        b=R+1Rcw0eD9bKZJIZ9pU5c28WswtL6hF8+w4Tqa1Y3cNO3l4dnD9NroiHdjo3AG1Wkl
         M8sFe+4HMx2IRl27ZYA5mJ3/zKGnECbvuI2N2Duf5FmtkRjoA3KlWF7zuJpiUylOD3yt
         QZ6nUN4dfdCq5X0vDN2Fi5qkFoWVYNdAQ1Pqp+oVEjnHs7Z8NEGs4nMD3aKMfCJvyCfV
         Es0mNT8V/ePXc3XH00lyaO/fgR33P2kanOS0/mXIXu080YLc/kjIZligGhzcS92slxhC
         EZwnqgmNGTt/PTV43AboJIVoVcMPMjJd8tde/9CcMswo+0RGr9emJyZcGmbAzYIfHISv
         mxhg==
X-Gm-Message-State: AOJu0YzWyIms152ncDqsVs8uYupe8oYfB70rrPYEIs84AoQfbP8WBLO+
	rfUQFNLkymhGRBsoB+uTaWvcOxrydAf1IWdhrEWayQ==
X-Google-Smtp-Source: AGHT+IFvUCi8G9mJodwaUlpN52nvS3mxM+qvmz88O1RwQ5Ycz5R9sMlyRakPCmCG9bOH2sGbrwHeNmqH0tVfiIAg3Ks=
X-Received: by 2002:a50:9ead:0:b0:53f:91cb:6904 with SMTP id
 a42-20020a509ead000000b0053f91cb6904mr105371edf.4.1698396661879; Fri, 27 Oct
 2023 01:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026150154.3536433-1-syoshida@redhat.com> <waodmdtiiq6qcdj4pwys5pod7eyveqkfq6fwqy5hqptzembcxf@siitwagevn2f>
 <CAGxU2F6VAzdi4-Qs6DmabpPx+JKVHtCP1FJ2sSZ9730Kq-KLuQ@mail.gmail.com>
In-Reply-To: <CAGxU2F6VAzdi4-Qs6DmabpPx+JKVHtCP1FJ2sSZ9730Kq-KLuQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 27 Oct 2023 10:50:50 +0200
Message-ID: <CANn89i+Y1_GesZ+Afh3SXkYR_Bux-HUALkoh6WJ47YkGHgZaRg@mail.gmail.com>
Subject: Re: [PATCH net] virtio/vsock: Fix uninit-value in virtio_transport_recv_pkt()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shigeru Yoshida <syoshida@redhat.com>, stefanha@redhat.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bobby.eshleman@bytedance.com, 
	bobbyeshleman@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 10:18=E2=80=AFAM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> On Fri, Oct 27, 2023 at 10:01=E2=80=AFAM Stefano Garzarella <sgarzare@red=
hat.com> wrote:
> >
> > On Fri, Oct 27, 2023 at 12:01:54AM +0900, Shigeru Yoshida wrote:
> > >KMSAN reported the following uninit-value access issue:
> > >
> > >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > >BUG: KMSAN: uninit-value in virtio_transport_recv_pkt+0x1dfb/0x26a0 ne=
t/vmw_vsock/virtio_transport_common.c:1421
> > > virtio_transport_recv_pkt+0x1dfb/0x26a0 net/vmw_vsock/virtio_transpor=
t_common.c:1421
> > > vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
> > > process_one_work kernel/workqueue.c:2630 [inline]
> > > process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
> > > worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
> > > kthread+0x3cc/0x520 kernel/kthread.c:388
> > > ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> > > ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> > >
> > >Uninit was stored to memory at:
> > > virtio_transport_space_update net/vmw_vsock/virtio_transport_common.c=
:1274 [inline]
> > > virtio_transport_recv_pkt+0x1ee8/0x26a0 net/vmw_vsock/virtio_transpor=
t_common.c:1415
> > > vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
> > > process_one_work kernel/workqueue.c:2630 [inline]
> > > process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
> > > worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
> > > kthread+0x3cc/0x520 kernel/kthread.c:388
> > > ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> > > ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> > >
> > >Uninit was created at:
> > > slab_post_alloc_hook+0x105/0xad0 mm/slab.h:767
> > > slab_alloc_node mm/slub.c:3478 [inline]
> > > kmem_cache_alloc_node+0x5a2/0xaf0 mm/slub.c:3523
> > > kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:559
> > > __alloc_skb+0x2fd/0x770 net/core/skbuff.c:650
> > > alloc_skb include/linux/skbuff.h:1286 [inline]
> > > virtio_vsock_alloc_skb include/linux/virtio_vsock.h:66 [inline]
> > > virtio_transport_alloc_skb+0x90/0x11e0 net/vmw_vsock/virtio_transport=
_common.c:58
> > > virtio_transport_reset_no_sock net/vmw_vsock/virtio_transport_common.=
c:957 [inline]
> > > virtio_transport_recv_pkt+0x1279/0x26a0 net/vmw_vsock/virtio_transpor=
t_common.c:1387
> > > vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
> > > process_one_work kernel/workqueue.c:2630 [inline]
> > > process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
> > > worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
> > > kthread+0x3cc/0x520 kernel/kthread.c:388
> > > ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> > > ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> > >
> > >CPU: 1 PID: 10664 Comm: kworker/1:5 Not tainted 6.6.0-rc3-00146-g9f3eb=
bef746f #3
> > >Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.f=
c38 04/01/2014
> > >Workqueue: vsock-loopback vsock_loopback_work
> > >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > >
> > >The following simple reproducer can cause the issue described above:
> > >
> > >int main(void)
> > >{
> > >  int sock;
> > >  struct sockaddr_vm addr =3D {
> > >    .svm_family =3D AF_VSOCK,
> > >    .svm_cid =3D VMADDR_CID_ANY,
> > >    .svm_port =3D 1234,
> > >  };
> > >
> > >  sock =3D socket(AF_VSOCK, SOCK_STREAM, 0);
> > >  connect(sock, (struct sockaddr *)&addr, sizeof(addr));
> > >  return 0;
> > >}
> > >
> > >This issue occurs because the `buf_alloc` and `fwd_cnt` fields of the
> > >`struct virtio_vsock_hdr` are not initialized when a new skb is alloca=
ted
> > >in `virtio_transport_alloc_skb()`. This patch resolves the issue by
> > >initializing these fields during allocation.
> > >
> > >Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_b=
uff")
> >
> > CCin Bobby, the original author, for any additional comments/checks.
> >
> > Yeah, I see, before that commit we used kzalloc() to allocate the
> > header so we forgot to reset these 2 fields, and checking they are
> > the only 2 missing.
> >
> > I was thinking of putting a memset(hdr, 0, sizeof(*hdr)) in
> > virtio_vsock_alloc_skb() but I think it's just extra unnecessary work,
> > since here we set all the fields (thanks to this fix), in vhost/vsock.c
> > we copy all the header we receive from the guest and in
> > virtio_transport.c we already set it all to 0 because we are
> > preallocating the receive buffers.
> >
> > So I'm fine with this fix!
> >
> > >Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> > >---
> > > net/vmw_vsock/virtio_transport_common.c | 2 ++
> > > 1 file changed, 2 insertions(+)
> > >
> > >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/v=
irtio_transport_common.c
> > >index 352d042b130b..102673bef189 100644
> > >--- a/net/vmw_vsock/virtio_transport_common.c
> > >+++ b/net/vmw_vsock/virtio_transport_common.c
> > >@@ -68,6 +68,8 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_i=
nfo *info,
> > >       hdr->dst_port   =3D cpu_to_le32(dst_port);
> > >       hdr->flags      =3D cpu_to_le32(info->flags);
> > >       hdr->len        =3D cpu_to_le32(len);
> > >+      hdr->buf_alloc  =3D cpu_to_le32(0);
> > >+      hdr->fwd_cnt    =3D cpu_to_le32(0);
> > >
> > >       if (info->msg && len > 0) {
> > >               payload =3D skb_put(skb, len);
> > >--
> > >2.41.0
> > >
> >
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
> syzbot just reported the same [1], should we add the following tag?
>
> Reported-by: syzbot+0c8ce1da0ac31abbadcd@syzkaller.appspotmail.com
>
> [1] https://lore.kernel.org/netdev/00000000000008b2940608ae3ce9@google.co=
m/

Yes, I was about to add this tag as well, but you were fast ;)

Reviewed-by: Eric Dumazet <edumazet@google.com>

