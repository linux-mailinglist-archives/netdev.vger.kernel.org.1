Return-Path: <netdev+bounces-38891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7FF7BCE5F
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 14:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666D5280E48
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 12:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F89BE48;
	Sun,  8 Oct 2023 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1EEC6Vk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14568C1D
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 12:55:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FB3D6
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 05:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696769756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0nF39BML0PfnEg8EYtnUaYzCy2YCCsILfREV9RebgY=;
	b=P1EEC6Vkid/7JdWEj+7ifmuR5Sn4lv9bLPZxS6ku/qEKNkHaVeEuAEDKA3EVz49WWpz2J+
	MZSVoiyoLvt3BezM53DRTO6NhDDNzVd2O/Utee5F+luqTUFY7pKBv+GFrg7i56OGn2qE1j
	0+x7H+FBA8TdbVD0t7uGBFMOTZRasGw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-ih7ZmMvDMvOMhW_gUfVlAw-1; Sun, 08 Oct 2023 08:55:54 -0400
X-MC-Unique: ih7ZmMvDMvOMhW_gUfVlAw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-537a183caa3so390290a12.1
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 05:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696769753; x=1697374553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0nF39BML0PfnEg8EYtnUaYzCy2YCCsILfREV9RebgY=;
        b=KzSYxBCTfRBm6LpruRDb+N5HFLk6pz8QMUM+rqNesoPtwoXqC8+6IKCTpPcx43dPWI
         4UPDeGLpIa2bQlYtJ+nJeLbIFPhyTfcMF6rD4EPHY344osu+1god9MhquACSB0OG9Wt5
         iE0x356OJrqq0VB0wC5QUfnjWzy5HZo7e8xnjzt+P2mVZrYHYXadNJZ7svKhTGotYENv
         bhFuxy/IEiqrykn6rQZmECWNH6EW78G1og9LPItW4EYN2h/552FEICuirc9uhXInl97d
         7ZRl3lJRtu1UaPltnComjdiJ0SyYLUrWs20SGQX91I9HkTm7sUTMuK0pU11eViOkhD9V
         8Byg==
X-Gm-Message-State: AOJu0YyYvHd2iVXmiExsniB5TUXChYjBl8aLg+ePLoEpv2pTYK0b4UW5
	UNyQQlcwCfVwJZ4mw1znvfmQ516d49kaQUrS73S9KuW+YTAdumioRAsv4wdjif73mQPYXQ5o8wl
	9dH9NMF9LlPfCZUddMEjzn6ZDX6/r2Woa
X-Received: by 2002:a05:6402:1219:b0:530:77e6:849f with SMTP id c25-20020a056402121900b0053077e6849fmr11262459edw.27.1696769753713;
        Sun, 08 Oct 2023 05:55:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwuP5OldwI2lirgcFqdgqLuiwfXybdqWPqtq7WHhBAHTyaUl0LsDbO3SeDWNbNgLhU8D5uYo8GQPksNhx7/pw=
X-Received: by 2002:a05:6402:1219:b0:530:77e6:849f with SMTP id
 c25-20020a056402121900b0053077e6849fmr11262452edw.27.1696769753309; Sun, 08
 Oct 2023 05:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com> <20230912030008.3599514-4-lulu@redhat.com>
 <CACGkMEuKcgH0kdLPmWZ69fL6SYvoVPfeGv11QwhQDW2sr9DZ3Q@mail.gmail.com>
 <db93d5aa-64c4-42a4-73dc-ae25e9e3833e@redhat.com> <CACGkMEsNfLOQkmnWUH53iTptAmhELs_U8B4D-CfO49rs=+HfLw@mail.gmail.com>
In-Reply-To: <CACGkMEsNfLOQkmnWUH53iTptAmhELs_U8B4D-CfO49rs=+HfLw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Sun, 8 Oct 2023 20:55:12 +0800
Message-ID: <CACLfguU5_8u-n5UopwzDKEEtFJ1GJ9NezEU7LGG=BY3BrZdhrg@mail.gmail.com>
Subject: Re: [RFC v2 3/4] vduse: update the vq_info in ioctl
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, mst@redhat.com, xieyongji@bytedance.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 8, 2023 at 1:17=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Fri, Sep 29, 2023 at 5:12=E2=80=AFPM Maxime Coquelin
> <maxime.coquelin@redhat.com> wrote:
> >
> >
> >
> > On 9/12/23 09:39, Jason Wang wrote:
> > > On Tue, Sep 12, 2023 at 11:00=E2=80=AFAM Cindy Lu <lulu@redhat.com> w=
rote:
> > >>
> > >> In VDUSE_VQ_GET_INFO, the driver will sync the last_avail_idx
> > >> with reconnect info, After mapping the reconnect pages to userspace
> > >> The userspace App will update the reconnect_time in
> > >> struct vhost_reconnect_vring, If this is not 0 then it means this
> > >> vq is reconnected and will update the last_avail_idx
> > >>
> > >> Signed-off-by: Cindy Lu <lulu@redhat.com>
> > >> ---
> > >>   drivers/vdpa/vdpa_user/vduse_dev.c | 13 +++++++++++++
> > >>   include/uapi/linux/vduse.h         |  6 ++++++
> > >>   2 files changed, 19 insertions(+)
> > >>
> > >> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_=
user/vduse_dev.c
> > >> index 2c69f4004a6e..680b23dbdde2 100644
> > >> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > >> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > >> @@ -1221,6 +1221,8 @@ static long vduse_dev_ioctl(struct file *file,=
 unsigned int cmd,
> > >>                  struct vduse_vq_info vq_info;
> > >>                  struct vduse_virtqueue *vq;
> > >>                  u32 index;
> > >> +               struct vdpa_reconnect_info *area;
> > >> +               struct vhost_reconnect_vring *vq_reconnect;
> > >>
> > >>                  ret =3D -EFAULT;
> > >>                  if (copy_from_user(&vq_info, argp, sizeof(vq_info))=
)
> > >> @@ -1252,6 +1254,17 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> > >>
> > >>                  vq_info.ready =3D vq->ready;
> > >>
> > >> +               area =3D &vq->reconnect_info;
> > >> +
> > >> +               vq_reconnect =3D (struct vhost_reconnect_vring *)are=
a->vaddr;
> > >> +               /*check if the vq is reconnect, if yes then update t=
he last_avail_idx*/
> > >> +               if ((vq_reconnect->last_avail_idx !=3D
> > >> +                    vq_info.split.avail_index) &&
> > >> +                   (vq_reconnect->reconnect_time !=3D 0)) {
> > >> +                       vq_info.split.avail_index =3D
> > >> +                               vq_reconnect->last_avail_idx;
> > >> +               }
> > >> +
> > >>                  ret =3D -EFAULT;
> > >>                  if (copy_to_user(argp, &vq_info, sizeof(vq_info)))
> > >>                          break;
> > >> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > >> index 11bd48c72c6c..d585425803fd 100644
> > >> --- a/include/uapi/linux/vduse.h
> > >> +++ b/include/uapi/linux/vduse.h
> > >> @@ -350,4 +350,10 @@ struct vduse_dev_response {
> > >>          };
> > >>   };
> > >>
> > >> +struct vhost_reconnect_vring {
> > >> +       __u16 reconnect_time;
> > >> +       __u16 last_avail_idx;
> > >> +       _Bool avail_wrap_counter;
> > >
> > > Please add a comment for each field.
> > >
> > > And I never saw _Bool is used in uapi before, maybe it's better to
> > > pack it with last_avail_idx into a __u32.
> >
> > Better as two distincts __u16 IMHO.
>
> Fine with me.
>
> Thanks
>

sure will fix  this
Thanks
Cindy
> >
> > Thanks,
> > Maxime
> >
> > >
> > > Btw, do we need to track inflight descriptors as well?
> > >
> > > Thanks
> > >
> > >> +};
> > >> +
> > >>   #endif /* _UAPI_VDUSE_H_ */
> > >> --
> > >> 2.34.3
> > >>
> > >
> >
>


