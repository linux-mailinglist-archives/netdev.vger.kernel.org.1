Return-Path: <netdev+bounces-36074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DB77ACF09
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 06:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 2CBD3B20977
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 04:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E7D63CB;
	Mon, 25 Sep 2023 04:15:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACD553BA
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 04:15:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A13E1
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 21:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695615348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ruu6yd/F7PRRg3zU9933sMPG2y+61a3R2Ou0YGttbMk=;
	b=BzyL8BnvDMZM3MwXeVufFBXbkJPyO0gztoOXDezQbU6Ots6F6fULVGojr/8Zf+ESbo+8cp
	6vZiaRUmgNS0JetbRb3EBsehFp6PVRQDBCF8tIfY3ewXWXu9YRmkoFoW1FnTMXxbgkn4aQ
	2CuPqgv0qcGkXNYHu9XD10YSdShoyns=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-uYhrKEnBNxiuEyrMNFqaNw-1; Mon, 25 Sep 2023 00:15:47 -0400
X-MC-Unique: uYhrKEnBNxiuEyrMNFqaNw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31dc8f0733dso4516608f8f.3
        for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 21:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695615346; x=1696220146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruu6yd/F7PRRg3zU9933sMPG2y+61a3R2Ou0YGttbMk=;
        b=MNhuW3XuvxUemPjIRkwy3vSDeVcr5dRW9Y1SPGE/m2cDgwq8fAAhA+qfvYzGrxHeD5
         N/4Q7HzSI+CoU72ajK/V42yYHKk1sJ6lYh+sZKg++5+K1pft8Wzp3kyDc2mbdp6t16Ky
         sZgDJU/NDKm75IPKzXdcUuZTyWBgH92NYlmejCJYDBmH7BcLh3xSYobvbCbqDJJZirmV
         5yB7inUMqQBjkrOCt91AYSEBBwTlhNOT0WooVK/S+TC/W5PeQ7p2K1Tu1vISFC26fgkl
         7g3D3tjKmOn1M8+FDyCJbzRvhw/8FAalGJprhmJBzELwDKFHp19V2/cETfZep5/ZpoPS
         WTXQ==
X-Gm-Message-State: AOJu0YwwMfloGiQKFBFsCCyGOOYuw4CCk+sDmlUDz3SID/8jVGxK15WE
	5TtluhNZknKuD2+4voxcANO7dLwhsT5mSatnYn1h7FEuBz7PZ3s3c2FTCOCGrZjAT5rSaKBo554
	Ii3+Dz+49Iay5LbnK5Z1PvGAaoZ85NHw0
X-Received: by 2002:adf:e508:0:b0:321:64a6:e417 with SMTP id j8-20020adfe508000000b0032164a6e417mr5651729wrm.1.1695615345914;
        Sun, 24 Sep 2023 21:15:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnA4ZFQjTUBgTF/yRHLzrWbDlET+Op3hd/JEQz2wnKypNLgRCsF6S3FP3xbZGRGT0UII1pqjFKnSqeq1FS/AQ=
X-Received: by 2002:adf:e508:0:b0:321:64a6:e417 with SMTP id
 j8-20020adfe508000000b0032164a6e417mr5651717wrm.1.1695615345660; Sun, 24 Sep
 2023 21:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com> <20230912030008.3599514-4-lulu@redhat.com>
 <CACGkMEuKcgH0kdLPmWZ69fL6SYvoVPfeGv11QwhQDW2sr9DZ3Q@mail.gmail.com>
In-Reply-To: <CACGkMEuKcgH0kdLPmWZ69fL6SYvoVPfeGv11QwhQDW2sr9DZ3Q@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 25 Sep 2023 12:15:08 +0800
Message-ID: <CACLfguVRPV_8HOy3mQbKvpWRGpM_tnjmC=oQqrEbvEz6YkMi0w@mail.gmail.com>
Subject: Re: [RFC v2 3/4] vduse: update the vq_info in ioctl
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, maxime.coquelin@redhat.com, xieyongji@bytedance.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 12, 2023 at 3:39=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Sep 12, 2023 at 11:00=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote=
:
> >
> > In VDUSE_VQ_GET_INFO, the driver will sync the last_avail_idx
> > with reconnect info, After mapping the reconnect pages to userspace
> > The userspace App will update the reconnect_time in
> > struct vhost_reconnect_vring, If this is not 0 then it means this
> > vq is reconnected and will update the last_avail_idx
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 13 +++++++++++++
> >  include/uapi/linux/vduse.h         |  6 ++++++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 2c69f4004a6e..680b23dbdde2 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1221,6 +1221,8 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
> >                 struct vduse_vq_info vq_info;
> >                 struct vduse_virtqueue *vq;
> >                 u32 index;
> > +               struct vdpa_reconnect_info *area;
> > +               struct vhost_reconnect_vring *vq_reconnect;
> >
> >                 ret =3D -EFAULT;
> >                 if (copy_from_user(&vq_info, argp, sizeof(vq_info)))
> > @@ -1252,6 +1254,17 @@ static long vduse_dev_ioctl(struct file *file, u=
nsigned int cmd,
> >
> >                 vq_info.ready =3D vq->ready;
> >
> > +               area =3D &vq->reconnect_info;
> > +
> > +               vq_reconnect =3D (struct vhost_reconnect_vring *)area->=
vaddr;
> > +               /*check if the vq is reconnect, if yes then update the =
last_avail_idx*/
> > +               if ((vq_reconnect->last_avail_idx !=3D
> > +                    vq_info.split.avail_index) &&
> > +                   (vq_reconnect->reconnect_time !=3D 0)) {
> > +                       vq_info.split.avail_index =3D
> > +                               vq_reconnect->last_avail_idx;
> > +               }
> > +
> >                 ret =3D -EFAULT;
> >                 if (copy_to_user(argp, &vq_info, sizeof(vq_info)))
> >                         break;
> > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > index 11bd48c72c6c..d585425803fd 100644
> > --- a/include/uapi/linux/vduse.h
> > +++ b/include/uapi/linux/vduse.h
> > @@ -350,4 +350,10 @@ struct vduse_dev_response {
> >         };
> >  };
> >
> > +struct vhost_reconnect_vring {
> > +       __u16 reconnect_time;
> > +       __u16 last_avail_idx;
> > +       _Bool avail_wrap_counter;
>
> Please add a comment for each field.
>
Sure will do

> And I never saw _Bool is used in uapi before, maybe it's better to
> pack it with last_avail_idx into a __u32.
>
Thanks will fix this
> Btw, do we need to track inflight descriptors as well?
>
I will check this
Thanks

cindy
> Thanks
>
> > +};
> > +
> >  #endif /* _UAPI_VDUSE_H_ */
> > --
> > 2.34.3
> >
>


