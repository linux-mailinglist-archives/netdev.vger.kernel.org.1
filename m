Return-Path: <netdev+bounces-81175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6509A886695
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 07:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978BE1C229F9
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 06:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBB6BE4C;
	Fri, 22 Mar 2024 06:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MUXS1Hdi"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56023C127
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 06:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711087486; cv=none; b=n8DrjCNvgzRuUtm3Yngc3bPPxcjs2HYEnlIMvSSeCeU4V9+Bg4puKZZvYkiL70Tipf/scjs/QrumHkqjFgO3X2Cb7EFSEATpEuN3UVIe/smWipVfkVXCe4286ehKm07vKKuVR0T5cGpKW5jL82SiMGteagSZHCCBAfl1toKFgE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711087486; c=relaxed/simple;
	bh=454572vmYgK7qe8auMubjdFKIVg5/0Fz1LEWsUV7Krc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=FPq4KbViMOtQQg7TskMtezd8ipo+l4hk0oqy5YggLN20jfK8bdRaiKJvhdbv9jLb8KWH2VfWSH1/L2q/uq0c9rddqXaC1rxzHbw/N9yPBBNx9GSenYGUdQkehccN9nQ7y1dEG260kAwSZTn/iy5pwm8Ih1wQqLSptgTlmL1H+Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MUXS1Hdi; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711087476; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=eb4KMo0Pf/8SqKLxf77zotoNMMhspnpHYcPyHWh1TOc=;
	b=MUXS1HdiLxrokbcOJNojh1BRsWxsl6xqzpI75o80uyck+gC1GIa9Kh0vlGoW1T2wRSf7qWuFuDvuFc//Nr4zoHYZSD4GyLWiernIV9hJJSno7CiVz/7zmEUVIZgqeRbKSyfjd0NyrZ7kwuOe5yLbOFAVNiHdk/hbzABDcYN7WtA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W3154W2_1711087475;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3154W2_1711087475)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 14:04:36 +0800
Message-ID: <1711087439.5923152-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v4 10/10] virtio_ring: virtqueue_set_dma_premapped support disable
Date: Fri, 22 Mar 2024 14:03:59 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
 <20240312033557.6351-11-xuanzhuo@linux.alibaba.com>
 <CACGkMEuM35+jDY3kQXtKNBFJi32+hVSnqDuOc2GVqX6L2hcafw@mail.gmail.com>
 <1711009281.7778504-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEs+x8bObJ0Fr0LbkPzWqYSoU8Y8504=bqZtjux2T5-_Vg@mail.gmail.com>
In-Reply-To: <CACGkMEs+x8bObJ0Fr0LbkPzWqYSoU8Y8504=bqZtjux2T5-_Vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 22 Mar 2024 13:13:36 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Mar 21, 2024 at 4:22=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Thu, 21 Mar 2024 14:02:14 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Tue, Mar 12, 2024 at 11:36=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.al=
ibaba.com> wrote:
> > > >
> > > > Now, the API virtqueue_set_dma_premapped just support to
> > > > enable premapped mode.
> > > >
> > > > If we allow enabling the premapped dynamically, we should
> > > > make this API to support disable the premapped mode.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 34 ++++++++++++++++++++++++++------=
--
> > > >  include/linux/virtio.h       |  2 +-
> > > >  2 files changed, 27 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_r=
ing.c
> > > > index 34f4b2c0c31e..3bf69cae4965 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -2801,6 +2801,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
> > > >  /**
> > > >   * virtqueue_set_dma_premapped - set the vring premapped mode
> > > >   * @_vq: the struct virtqueue we're talking about.
> > > > + * @premapped: enable/disable the premapped mode.
> > > >   *
> > > >   * Enable the premapped mode of the vq.
> > > >   *
> > > > @@ -2819,9 +2820,10 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
> > > >   * 0: success.
> > > >   * -EINVAL: vring does not use the dma api, so we can not enable p=
remapped mode.
> > > >   */
> > > > -int virtqueue_set_dma_premapped(struct virtqueue *_vq)
> > > > +int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool premap=
ped)
> > >
> > > I think we need to document the requirement for calling this.
> > >
> > > Looking at the code, it seems it requires to stop the datapath and
> > > detach all the used buffers?
> >
> >
> > YES. The complete document is:
> >
> > /**
> >  * virtqueue_set_dma_premapped - set the vring premapped mode
> >  * @_vq: the struct virtqueue we're talking about.
> >  *
> >  * Enable the premapped mode of the vq.
> >  *
> >  * The vring in premapped mode does not do dma internally, so the drive=
r must
> >  * do dma mapping in advance. The driver must pass the dma_address thro=
ugh
> >  * dma_address of scatterlist. When the driver got a used buffer from
> >  * the vring, it has to unmap the dma address.
> >  *
> >  * This function must be called immediately after creating the vq, or a=
fter vq
> >  * reset, and before adding any buffers to it.
>
> I'm not sure this is a good design but we need at least some guard for
> this, probably WARN for num_added or others.


int virtqueue_set_dma_premapped(struct virtqueue *_vq)
{
	struct vring_virtqueue *vq =3D to_vvq(_vq);
	u32 num;

	START_USE(vq);

	num =3D vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num;

	if (num !=3D vq->vq.num_free) {
		END_USE(vq);
		return -EINVAL;
	}


Now, we have checked the num_free.

Thanks.


>
> Thanks
>
> >  *
> >  * Caller must ensure we don't call this with other virtqueue operations
> >  * at the same time (except where noted).
> >  *
> >  * Returns zero or a negative error.
> >  * 0: success.
> >  * -EINVAL: vring does not use the dma api, so we can not enable premap=
ped mode.
> >  */
> >
> > Thanks
> >
> >
> > >
> > > Thanks
> > >
> >
>

