Return-Path: <netdev+bounces-38847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614867BCC3B
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 07:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3F0281B41
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 05:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E191517E2;
	Sun,  8 Oct 2023 05:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMjz4lpw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3BE15C1
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 05:17:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445E8BD
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 22:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696742258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIBFYES1oNSbgdg44IpiRY5MDLveYfd/44xts2VnIss=;
	b=CMjz4lpwKF/c7fC6lVHIQXQCl5ClGlo/bQ//fIF6XpVJcSMjPWv+SmfwMW0orp1kKyXaFW
	4xZNhGSdb5Hiw1yCYkyb339Ocfj3Qk7Wo4v5r3qibpAjObk11n1E7rJgSZqOEtTUC1ES6/
	sjkzT6aOsnfbv5gA2l974dQy4Bs9fwE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-aWQpnvdPNSObJJet78OlGQ-1; Sun, 08 Oct 2023 01:17:36 -0400
X-MC-Unique: aWQpnvdPNSObJJet78OlGQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5043307ec0bso3112085e87.2
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 22:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696742254; x=1697347054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIBFYES1oNSbgdg44IpiRY5MDLveYfd/44xts2VnIss=;
        b=hezFNILjjlBEKgDO2a+hYzmsUdm1z/ZYxfT6he/N7jdcEQ7iIs0PxmgfoKeLKqjQpu
         0sXgqNy+XtQfdMbqsPZOCQL0kadd92ySQhUFkJITpf4draCTj26RPl40/6NcQnoBV0Pe
         fRK7WMRMqgu9bVWbwlCLe6c3K/D+LIkPr3ymkOrZHYD+272pOmmqKcMlirN32tt45BK6
         ZMBjnY6wjto0x2GMv5YhQK3hnwFfU796Qu7zkM0yU103IdyqDpOD2SE6/1sI3xnCwb0P
         Ezm09UJcSjCNWXG7B3ObVY9A3qCQsEEDR6Rt1OM5fGXYcXU4h7fC/rnDE+EiSG9wGA5J
         rqLw==
X-Gm-Message-State: AOJu0Yzqf64l+tkcNfpPgjpdMllAtwlTAI65Qx0EV6AIWO/F7QYvWwBY
	Bk9nW4xeUgQeTrWGabGaNjQAfRu0JJ73AzVbFxsqVs9HslIJsRqmmzbV+Rm0d7ikg0dNu9lVC5G
	KWmKhubwRll+IKUvHkZigJBKKogZ9pUXo
X-Received: by 2002:a05:6512:31d2:b0:500:acf1:b432 with SMTP id j18-20020a05651231d200b00500acf1b432mr12100669lfe.63.1696742254619;
        Sat, 07 Oct 2023 22:17:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHih9jNBj+mm3gln1ZCsXonlccj1/oAiZNJ1d8VXWVWaywkwRq06DB7RjMZgwJPLinVPauKckcWGYfUL6bhA9o=
X-Received: by 2002:a05:6512:31d2:b0:500:acf1:b432 with SMTP id
 j18-20020a05651231d200b00500acf1b432mr12100655lfe.63.1696742254306; Sat, 07
 Oct 2023 22:17:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com> <20230912030008.3599514-4-lulu@redhat.com>
 <CACGkMEuKcgH0kdLPmWZ69fL6SYvoVPfeGv11QwhQDW2sr9DZ3Q@mail.gmail.com> <db93d5aa-64c4-42a4-73dc-ae25e9e3833e@redhat.com>
In-Reply-To: <db93d5aa-64c4-42a4-73dc-ae25e9e3833e@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 8 Oct 2023 13:17:23 +0800
Message-ID: <CACGkMEsNfLOQkmnWUH53iTptAmhELs_U8B4D-CfO49rs=+HfLw@mail.gmail.com>
Subject: Re: [RFC v2 3/4] vduse: update the vq_info in ioctl
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, mst@redhat.com, xieyongji@bytedance.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 5:12=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
>
> On 9/12/23 09:39, Jason Wang wrote:
> > On Tue, Sep 12, 2023 at 11:00=E2=80=AFAM Cindy Lu <lulu@redhat.com> wro=
te:
> >>
> >> In VDUSE_VQ_GET_INFO, the driver will sync the last_avail_idx
> >> with reconnect info, After mapping the reconnect pages to userspace
> >> The userspace App will update the reconnect_time in
> >> struct vhost_reconnect_vring, If this is not 0 then it means this
> >> vq is reconnected and will update the last_avail_idx
> >>
> >> Signed-off-by: Cindy Lu <lulu@redhat.com>
> >> ---
> >>   drivers/vdpa/vdpa_user/vduse_dev.c | 13 +++++++++++++
> >>   include/uapi/linux/vduse.h         |  6 ++++++
> >>   2 files changed, 19 insertions(+)
> >>
> >> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_us=
er/vduse_dev.c
> >> index 2c69f4004a6e..680b23dbdde2 100644
> >> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> >> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> >> @@ -1221,6 +1221,8 @@ static long vduse_dev_ioctl(struct file *file, u=
nsigned int cmd,
> >>                  struct vduse_vq_info vq_info;
> >>                  struct vduse_virtqueue *vq;
> >>                  u32 index;
> >> +               struct vdpa_reconnect_info *area;
> >> +               struct vhost_reconnect_vring *vq_reconnect;
> >>
> >>                  ret =3D -EFAULT;
> >>                  if (copy_from_user(&vq_info, argp, sizeof(vq_info)))
> >> @@ -1252,6 +1254,17 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >>
> >>                  vq_info.ready =3D vq->ready;
> >>
> >> +               area =3D &vq->reconnect_info;
> >> +
> >> +               vq_reconnect =3D (struct vhost_reconnect_vring *)area-=
>vaddr;
> >> +               /*check if the vq is reconnect, if yes then update the=
 last_avail_idx*/
> >> +               if ((vq_reconnect->last_avail_idx !=3D
> >> +                    vq_info.split.avail_index) &&
> >> +                   (vq_reconnect->reconnect_time !=3D 0)) {
> >> +                       vq_info.split.avail_index =3D
> >> +                               vq_reconnect->last_avail_idx;
> >> +               }
> >> +
> >>                  ret =3D -EFAULT;
> >>                  if (copy_to_user(argp, &vq_info, sizeof(vq_info)))
> >>                          break;
> >> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> >> index 11bd48c72c6c..d585425803fd 100644
> >> --- a/include/uapi/linux/vduse.h
> >> +++ b/include/uapi/linux/vduse.h
> >> @@ -350,4 +350,10 @@ struct vduse_dev_response {
> >>          };
> >>   };
> >>
> >> +struct vhost_reconnect_vring {
> >> +       __u16 reconnect_time;
> >> +       __u16 last_avail_idx;
> >> +       _Bool avail_wrap_counter;
> >
> > Please add a comment for each field.
> >
> > And I never saw _Bool is used in uapi before, maybe it's better to
> > pack it with last_avail_idx into a __u32.
>
> Better as two distincts __u16 IMHO.

Fine with me.

Thanks

>
> Thanks,
> Maxime
>
> >
> > Btw, do we need to track inflight descriptors as well?
> >
> > Thanks
> >
> >> +};
> >> +
> >>   #endif /* _UAPI_VDUSE_H_ */
> >> --
> >> 2.34.3
> >>
> >
>


