Return-Path: <netdev+bounces-14945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47354744829
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 11:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8690281242
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 09:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CE3525C;
	Sat,  1 Jul 2023 09:15:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190B3C1E
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 09:15:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75ACB9
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 02:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688202941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfITF5Nr6pfDtbVnEECtEIPAa7wQ6lj7+UWe+mAgDnM=;
	b=a3DsB2jHdJqDvovN7Gke7WbgRAJxJJnSe6CxVbps6O9UxTczeb7Smduv2juv9zSJkGfImI
	Lcy115Js4H2Szm+RpMTNuvHUjCLapz+BxoiBed8n2zfe+geIDZkWz55PDujWPakFXv+hSw
	AO1LGt0k/zXjcfdgdPOIIGO/5DZKzVs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-2_hrKKOVPAarWYtHyE4TMA-1; Sat, 01 Jul 2023 05:15:40 -0400
X-MC-Unique: 2_hrKKOVPAarWYtHyE4TMA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3112808cd0cso1466409f8f.0
        for <netdev@vger.kernel.org>; Sat, 01 Jul 2023 02:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688202939; x=1690794939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfITF5Nr6pfDtbVnEECtEIPAa7wQ6lj7+UWe+mAgDnM=;
        b=VH69YtcReIu4jSXc5F88X0xPWGxURtYdGUnNbRBPoFJIMR5xCqdURK07xCnzDOEwzG
         BaoYfoyMfHTxhIUZlvllSIWD7cMi3LscxnmzqYA7sNlmvYBGQkmlxLg9ycTGO0vb8Zb5
         D1mHGit3tesdW31cPxQ2XudxqzHzIdWyAfn9jr1R3nh2QS8f+4l3PQmBUjA54TwWXXDW
         vDLq4rpZh0cyDhIOaQmPV+FxeFUiNk0afknY6G0ykHFG3iPbFaRVclioa0dZ+nD4D59f
         xpsPF6twr/kj98qT/uJmywxjNc52qeOVLkmBZggBVlrsYdiMqTCjTB2CscvmbTGK6wyD
         zFtw==
X-Gm-Message-State: ABy/qLas/81QPTt2URndMW678P77u8BHLydd0JLyFg/kzVUhOWFbcprV
	qPMIDopYaGIyVVxafDEBsFiKrJ4SGExsVtBPy0GA+iidQF7A8e0U5OFjw3FMjcIsLgZ7il1Hrcg
	WRAsKLQuEhNpI/joEVgrwCiQd+1DYwUmH
X-Received: by 2002:a5d:694a:0:b0:314:23b:dc56 with SMTP id r10-20020a5d694a000000b00314023bdc56mr3505218wrw.71.1688202939204;
        Sat, 01 Jul 2023 02:15:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEGrNYok3BYAD44hlBqMA6GsZ4KoVuajbLDpOjK3Z46B5D8ua2rbfifRAqAiXpimAzGEQ+tG2Cn3Y3orabRcxE=
X-Received: by 2002:a5d:694a:0:b0:314:23b:dc56 with SMTP id
 r10-20020a5d694a000000b00314023bdc56mr3505207wrw.71.1688202938703; Sat, 01
 Jul 2023 02:15:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628065919.54042-1-lulu@redhat.com> <20230628065919.54042-5-lulu@redhat.com>
 <CACGkMEtN7pE4FK2-504JC3A1tcfPjy9QejJiTyvXD7nt49KLvA@mail.gmail.com>
In-Reply-To: <CACGkMEtN7pE4FK2-504JC3A1tcfPjy9QejJiTyvXD7nt49KLvA@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Sat, 1 Jul 2023 17:14:57 +0800
Message-ID: <CACLfguV4PYpxJEtodWqnYwQ1WJrpjTx1XMqJOsDYsvNrfUKr1A@mail.gmail.com>
Subject: Re: [RFC 4/4] vduse: update the vq_info in ioctl
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, maxime.coquelin@redhat.com, xieyongji@bytedance.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 4:13=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Jun 28, 2023 at 3:00=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > From: Your Name <you@example.com>
> >
> > in VDUSE_VQ_GET_INFO, driver will sync the last_avail_idx
> > with reconnect info, I have olny test the split mode, so
>
> Typo, should be "only".
>
sure will change this
> > only use this here, will add more information later
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 3df1256eccb4..b8e453eac0ce 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -141,6 +141,11 @@ static u32 allowed_device_id[] =3D {
> >         VIRTIO_ID_NET,
> >  };
> >
> > +struct vhost_reconnect_vring {
> > +       uint16_t last_avail_idx;
> > +       bool avail_wrap_counter;
> > +};
>
> Should this belong to uAPI?
>
will change this
> > +
> >  static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa=
)
> >  {
> >         struct vduse_vdpa *vdev =3D container_of(vdpa, struct vduse_vdp=
a, vdpa);
> > @@ -1176,6 +1181,17 @@ static long vduse_dev_ioctl(struct file *file, u=
nsigned int cmd,
> >                                 vq->state.split.avail_index;
> >
> >                 vq_info.ready =3D vq->ready;
> > +               struct vdpa_reconnect_info *area;
> > +
> > +               area =3D &dev->reconnect_info[index];
> > +               struct vhost_reconnect_vring *log_reconnect;
> > +
> > +               log_reconnect =3D (struct vhost_reconnect_vring *)area-=
>vaddr;
>
> What if userspace doesn't do mmap()?
>
> Thanks
>
sure will add the check for this
Thanks
Cindy
> > +               if (log_reconnect->last_avail_idx !=3D
> > +                   vq_info.split.avail_index) {
> > +                       vq_info.split.avail_index =3D
> > +                               log_reconnect->last_avail_idx;
> > +               }
> >
> >                 ret =3D -EFAULT;
> >                 if (copy_to_user(argp, &vq_info, sizeof(vq_info)))
> > --
> > 2.34.3
> >
>


