Return-Path: <netdev+bounces-59427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4733881ACCA
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 03:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BC028448D
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 02:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1E62104;
	Thu, 21 Dec 2023 02:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpPWB6QM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979ABAD2C
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703127409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dy9GExM8H85FeptYc4aP4CuqEGh1LXnHJxON2C2sOE4=;
	b=NpPWB6QMFbmjeV+EhQX6zOWsz17H8lQsaUxKmbSRXpYsCK5wZUvBm9O4hfc0N8RewJ7GxO
	OX82x1IbfZmTMhCSaink7WApvDT56xYh/GWFzUxOouHxIrhLhuaRYZrX6l10rrJPljRKzu
	Wgxl4TQVXrD4RGaDQCuNMIHi7RSB0rY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-gwEqXRh6NXKh05Gf-T-ZLw-1; Wed, 20 Dec 2023 21:56:48 -0500
X-MC-Unique: gwEqXRh6NXKh05Gf-T-ZLw-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6d9dfab5b16so396423a34.0
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 18:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703127407; x=1703732207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dy9GExM8H85FeptYc4aP4CuqEGh1LXnHJxON2C2sOE4=;
        b=oc0bOX9zvBCD+9vNA3YxepTVheIYU1uXi4HUOORSp/OWD2V2lO7ISoC4EGubBUqZHQ
         uWpBEEWTLwOT62LbAQnxykwqMafMNSazvjprF50jIYVTjO/czlPMbEymPJhSM3vnvujU
         LvoBivOdc7Rog2QvMp0x9nTYysVvmuajUMajevr204BtF3wyawVYVvGqEVPWSJLrFCO9
         wmLOKBFVUY1bs+AzDLWTmCe9BmReAqflLSDpWADEo2z1ecTuf25jlWzQGl9qRekFqDL3
         iSFV8V1GHBqjBjLvChmYVUhXTlGFMjQMZUZKGLutfKdg3gN9ZPDght16Q970Og6GdEBY
         Z0IQ==
X-Gm-Message-State: AOJu0YyACDOXjQQhPCAnChssoHYBADclPfNtQFTmSNhXDTy+0n23yxWJ
	xWrseXrI7uT4Kvtu+RZcGIRURFWItpXDS+YWQLl2FbMp6TfW+/2GkZOH7/6Y+a/ivFBWqd04nfg
	M8jiqZPIGBnwZ+hHfOoNZJBzVF46FJ20t
X-Received: by 2002:a05:6808:6493:b0:3ba:d81:8408 with SMTP id fh19-20020a056808649300b003ba0d818408mr23393848oib.41.1703127407406;
        Wed, 20 Dec 2023 18:56:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyl65VFlMHa3cUJ5xXSrW3xmo3VJtJx7xqAR/g/kwK7zYwdc5eHGcz9muBKfu2b/AhN640Cu/VtJUrszNnCjY=
X-Received: by 2002:a05:6808:6493:b0:3ba:d81:8408 with SMTP id
 fh19-20020a056808649300b003ba0d818408mr23393843oib.41.1703127407171; Wed, 20
 Dec 2023 18:56:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205113444.63015-1-linyunsheng@huawei.com>
 <20231205113444.63015-7-linyunsheng@huawei.com> <CACGkMEvVezZnHK-gRWY+MUd_6awnprb024scqPNmMQ05P8rWTQ@mail.gmail.com>
 <424670ab-23d8-663b-10cb-d88906767956@huawei.com> <CACGkMEsMdP1B-9RaqibJYfFsd_qJpB+Kta5BnyD_WXH=W2w_OQ@mail.gmail.com>
 <c5b5d36c-d0ca-c943-5355-343214d92c26@huawei.com> <CACGkMEs8HWq_NFNk=Pp3qxuo7AWBsybXT78LPgC-nKaP_u3LqA@mail.gmail.com>
 <8401fefd-d0da-efb9-78ab-cc4974a35801@huawei.com>
In-Reply-To: <8401fefd-d0da-efb9-78ab-cc4974a35801@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Dec 2023 10:56:36 +0800
Message-ID: <CACGkMEvKOWpxpBR+YRuiJJ3aEsdxU2q+qVwmFw=L5gS3e7A35w@mail.gmail.com>
Subject: Re: [PATCH net-next 6/6] tools: virtio: introduce vhost_net_test
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 10:48=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.c=
om> wrote:
>
> On 2023/12/21 10:33, Jason Wang wrote:
> > On Wed, Dec 20, 2023 at 8:45=E2=80=AFPM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> On 2023/12/12 12:35, Jason Wang wrote:>>>> +done:
> >>>>>> +       backend.fd =3D tun_alloc();
> >>>>>> +       assert(backend.fd >=3D 0);
> >>>>>> +       vdev_info_init(&dev, features);
> >>>>>> +       vq_info_add(&dev, 256);
> >>>>>> +       run_test(&dev, &dev.vqs[0], delayed, batch, reset, nbufs);
> >>>>>
> >>>>> I'd expect we are testing some basic traffic here. E.g can we use a
> >>>>> packet socket then we can test both tx and rx?
> >>>>
> >>>> Yes, only rx for tun is tested.
> >>>> Do you have an idea how to test the tx too? As I am not familar enou=
gh
> >>>> with vhost_net and tun yet.
> >>>
> >>> Maybe you can have a packet socket to bind to the tun/tap. Then you c=
an test:
> >>>
> >>> 1) TAP RX: by write a packet via virtqueue through vhost_net and read
> >>> it from packet socket
> >>> 2) TAP TX:  by write via packet socket and read it from the virtqueue
> >>> through vhost_net
> >>
> >> When implementing the TAP TX by adding VHOST_NET_F_VIRTIO_NET_HDR,
> >> I found one possible use of uninitialized data in vhost_net_build_xdp(=
).
> >>
> >> And vhost_hlen is set to sizeof(struct virtio_net_hdr_mrg_rxbuf) and
> >> sock_hlen is set to zero in vhost_net_set_features() for both tx and r=
x
> >> queue.
> >>
> >> For vhost_net_build_xdp() called by handle_tx_copy():
> >>
> >> The (gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) checking below may caus=
e a
> >> read of uninitialized data if sock_hlen is zero.
> >
> > Which data is uninitialized here?
>
> The 'gso', as the sock_hlen is zero, there is no copying for:
>
>          copied =3D copy_page_from_iter(alloc_frag->page,
>                                       alloc_frag->offset +
>                                       offsetof(struct tun_xdp_hdr, gso),
>                                       sock_hlen, from);

I think you're right. This is something we need to fix.

Or we can drop VHOST_NET_F_VIRTIO_NET_HDR as we managed to survive for year=
s:

https://patchwork.ozlabs.org/project/netdev/patch/1528429842-22835-1-git-se=
nd-email-jasowang@redhat.com/#1930760

>
> >
> >>
> >> And it seems vhost_hdr is skipped in get_tx_bufs():
> >> https://elixir.bootlin.com/linux/latest/source/drivers/vhost/net.c#L61=
6
> >>
> >> static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
> >>                                struct iov_iter *from)
> >> {
> >> ...
> >>         buflen +=3D SKB_DATA_ALIGN(len + pad);
> >>         alloc_frag->offset =3D ALIGN((u64)alloc_frag->offset, SMP_CACH=
E_BYTES);
> >>         if (unlikely(!vhost_net_page_frag_refill(net, buflen,
> >>                                                  alloc_frag, GFP_KERNE=
L)))
> >>                 return -ENOMEM;
> >>
> >>         buf =3D (char *)page_address(alloc_frag->page) + alloc_frag->o=
ffset;
> >>         copied =3D copy_page_from_iter(alloc_frag->page,
> >>                                      alloc_frag->offset +
> >>                                      offsetof(struct tun_xdp_hdr, gso)=
,
> >>                                      sock_hlen, from);
> >>         if (copied !=3D sock_hlen)
> >>                 return -EFAULT;
> >>
> >>         hdr =3D buf;
> >>         gso =3D &hdr->gso;
> >>
> >>         if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
> >>             vhost16_to_cpu(vq, gso->csum_start) +
> >>             vhost16_to_cpu(vq, gso->csum_offset) + 2 >
> >>             vhost16_to_cpu(vq, gso->hdr_len)) {
> >> ...
> >> }
> >>
> >> I seems the handle_tx_copy() does not handle the VHOST_NET_F_VIRTIO_NE=
T_HDR
> >> case correctly, Or do I miss something obvious here?
> >
> > In get_tx_bufs() we did:
> >
> >         *len =3D init_iov_iter(vq, &msg->msg_iter, nvq->vhost_hlen, *ou=
t);
> >
> > Which covers this case?
>
> It does not seems to cover it, as the vhost_hdr is just skipped without a=
ny
> handling in get_tx_bufs():
> https://elixir.bootlin.com/linux/v6.7-rc6/source/drivers/vhost/net.c#L616

My understanding is that in this case vhost can't do more than this as
the socket doesn't know vnet_hdr.

Let's see if Michael is ok with this.

Thanks

>
> >
> > Thanks
>


