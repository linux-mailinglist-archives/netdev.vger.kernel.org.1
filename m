Return-Path: <netdev+bounces-38944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4978D7BD246
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 05:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658361C20828
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 03:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526674411;
	Mon,  9 Oct 2023 03:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvVk5FLI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7859CA5D
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 03:01:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3825AB3
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 20:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696820511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HfPpj/NYnLhR9rt7gcQcCsZvzAr7nC8MCFto+fdVExs=;
	b=gvVk5FLIplp7wyvvjjtdbv1OcSgJcw/77pYIfnk5uyLQXThEdmyKukWjYkWsjyVqIXb69d
	dJ5xUuZnnldq99kGygefmaG7oWrmWdUvcNP43pDeWvumHHznU3JSE4WVau0pT6mjXpHhA2
	hP+J/c7QobzJXY7s8ROZsRKmhBG5tuI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-xgWDd0gvML6sP49Y4S3PnQ-1; Sun, 08 Oct 2023 23:01:40 -0400
X-MC-Unique: xgWDd0gvML6sP49Y4S3PnQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-533ca50404bso3102648a12.2
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 20:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696820499; x=1697425299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfPpj/NYnLhR9rt7gcQcCsZvzAr7nC8MCFto+fdVExs=;
        b=VUJYuu6m1OJ+FNlK5OYQ9jvbXQqvlTXyLQxSuRA7pMCMriUTWpYKooy3ns0cZTAwhA
         InwQF+Wvh6GYs6XszibJ9XbwCExePAOmtlMGY2ltyFXAqYy28CcNDhn1e4+yItIH2mJb
         Uq0gFxsPWIsW7RUode1kevApBNigKSHJimmdoNQ3BAzS83e9c+Ijvw+ZpnHxHbU5IBme
         J0UueY8B5uKC+mosGvdqX+2qHmh6qr6Jb+EEA3djYWMoke/AkoxyT74Q905nTbxnwrB2
         IUXx2PfTUm2YbyXOMVtV8Jy9HLcwSdEpbSpR71fSbVKRRynETBMQJkPFIV40b4PINKe/
         ASpQ==
X-Gm-Message-State: AOJu0YwzYPmRF7XnxZWD9VKZ0yqShy2qMSCBQF4ji6NDTVNtMVVOtOU2
	8fmF/CaR/BG93WRcslefsxjzeYn3yp2BbCklAWiypAEhTKRldxfowY1hetYw3YcuTZ4WWe9SfA7
	JYkVOC7j9N8ibJ8hKCNK5S2EDQppkij+I
X-Received: by 2002:aa7:da83:0:b0:533:d81b:36d5 with SMTP id q3-20020aa7da83000000b00533d81b36d5mr11984918eds.15.1696820498954;
        Sun, 08 Oct 2023 20:01:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg4sPgUHGxpJD5KhVuPwe4H/WIDtwx1mSl/00KPjO0l64EypHEQ5kVl/x8SOlNYipG4eXQiG5yboehI1B3TtU=
X-Received: by 2002:aa7:da83:0:b0:533:d81b:36d5 with SMTP id
 q3-20020aa7da83000000b00533d81b36d5mr11984907eds.15.1696820498625; Sun, 08
 Oct 2023 20:01:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com> <20230912030008.3599514-5-lulu@redhat.com>
 <CACGkMEtCYG8-Pt+V-OOwUV7fYFp_cnxU68Moisfxju9veJ-=qw@mail.gmail.com>
 <CACLfguW3NS_4+YhqTtGqvQb70mVazGVfheryHx4aCBn+=Skf9w@mail.gmail.com>
 <CACGkMEt-m9bOh9YnqLw0So5wqbZ69D0XRVBbfG73Oh7Q8qTJsQ@mail.gmail.com> <6c4cd924-0d44-582e-13a4-791f38d10fe8@redhat.com>
In-Reply-To: <6c4cd924-0d44-582e-13a4-791f38d10fe8@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 9 Oct 2023 11:00:30 +0800
Message-ID: <CACLfguVTxZR2U-CFhkFWYFcgvB-6TLcQjUaEvtm+oka2XstVqw@mail.gmail.com>
Subject: Re: [RFC v2 4/4] vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, xieyongji@bytedance.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 5:08=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
>
> On 9/25/23 04:57, Jason Wang wrote:
> > On Thu, Sep 21, 2023 at 10:07=E2=80=AFPM Cindy Lu <lulu@redhat.com> wro=
te:
> >>
> >> On Mon, Sep 18, 2023 at 4:49=E2=80=AFPM Jason Wang <jasowang@redhat.co=
m> wrote:
> >>>
> >>> On Tue, Sep 12, 2023 at 11:01=E2=80=AFAM Cindy Lu <lulu@redhat.com> w=
rote:
> >>>>
> >>>> In VDUSE_GET_RECONNECT_INFO, the Userspace App can get the map size
> >>>> and The number of mapping memory pages from the kernel. The userspac=
e
> >>>> App can use this information to map the pages.
> >>>>
> >>>> Signed-off-by: Cindy Lu <lulu@redhat.com>
> >>>> ---
> >>>>   drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++++++
> >>>>   include/uapi/linux/vduse.h         | 15 +++++++++++++++
> >>>>   2 files changed, 30 insertions(+)
> >>>>
> >>>> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_=
user/vduse_dev.c
> >>>> index 680b23dbdde2..c99f99892b5c 100644
> >>>> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> >>>> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> >>>> @@ -1368,6 +1368,21 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> >>>>                  ret =3D 0;
> >>>>                  break;
> >>>>          }
> >>>> +       case VDUSE_GET_RECONNECT_INFO: {
> >>>> +               struct vduse_reconnect_mmap_info info;
> >>>> +
> >>>> +               ret =3D -EFAULT;
> >>>> +               if (copy_from_user(&info, argp, sizeof(info)))
> >>>> +                       break;
> >>>> +
> >>>> +               info.size =3D PAGE_SIZE;
> >>>> +               info.max_index =3D dev->vq_num + 1;
> >>>> +
> >>>> +               if (copy_to_user(argp, &info, sizeof(info)))
> >>>> +                       break;
> >>>> +               ret =3D 0;
> >>>> +               break;
> >>>> +       }
> >>>>          default:
> >>>>                  ret =3D -ENOIOCTLCMD;
> >>>>                  break;
> >>>> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> >>>> index d585425803fd..ce55e34f63d7 100644
> >>>> --- a/include/uapi/linux/vduse.h
> >>>> +++ b/include/uapi/linux/vduse.h
> >>>> @@ -356,4 +356,19 @@ struct vhost_reconnect_vring {
> >>>>          _Bool avail_wrap_counter;
> >>>>   };
> >>>>
> >>>> +/**
> >>>> + * struct vduse_reconnect_mmap_info
> >>>> + * @size: mapping memory size, always page_size here
> >>>> + * @max_index: the number of pages allocated in kernel,just
> >>>> + * use for check
> >>>> + */
> >>>> +
> >>>> +struct vduse_reconnect_mmap_info {
> >>>> +       __u32 size;
> >>>> +       __u32 max_index;
> >>>> +};
> >>>
> >>> One thing I didn't understand is that, aren't the things we used to
> >>> store connection info belong to uAPI? If not, how can we make sure th=
e
> >>> connections work across different vendors/implementations. If yes,
> >>> where?
> >>>
> >>> Thanks
> >>>
> >> The process for this reconnecttion  is
> >> A.The first-time connection
> >> 1> The userland app checks if the device exists
> >> 2>  use the ioctl to create the vduse device
> >> 3> Mapping the kernel page to userland and save the
> >> App-version/features/other information to this page
> >> 4>  if the Userland app needs to exit, then the Userland app will only
> >> unmap the page and then exit
> >>
> >> B, the re-connection
> >> 1> the userland app finds the device is existing
> >> 2> Mapping the kernel page to userland
> >> 3> check if the information in shared memory is satisfied to
> >> reconnect,if ok then continue to reconnect
> >> 4> continue working
> >>
> >>   For now these information are all from userland,So here the page wil=
l
> >> be maintained by the userland App
> >> in the previous code we only saved the api-version by uAPI .  if  we
> >> need to support reconnection maybe we need to add 2 new uAPI for this,
> >> one of the uAPI is to save the reconnect  information and another is
> >> to get the information
> >>
> >> maybe something like
> >>
> >> struct vhost_reconnect_data {
> >> uint32_t version;
> >> uint64_t features;
> >> uint8_t status;
> >> struct virtio_net_config config;
> >> uint32_t nr_vrings;
> >> };
> >
> > Probably, then we can make sure the re-connection works across
> > different vduse-daemon implementations.
>
> +1, we need to have this defined in the uAPI to support interoperability
> across different VDUSE userspace implementations.
>
> >
> >>
> >> #define VDUSE_GET_RECONNECT_INFO _IOR (VDUSE_BASE, 0x1c, struct
> >> vhost_reconnect_data)
> >>
> >> #define VDUSE_SET_RECONNECT_INFO  _IOWR(VDUSE_BASE, 0x1d, struct
> >> vhost_reconnect_data)
> >
> > Not sure I get this, but the idea is to map those pages to user space,
> > any reason we need this uAPI?
>
> It should not be necessary if the mmapped layout is properly defined.
>
> Thanks,
> Maxime
>
Sure , I will use mmap to sync the reconnect status
Thanks
cindy
> > Thanks
> >
> >>
> >> Thanks
> >> Cindy
> >>
> >>
> >>
> >>
> >>>> +
> >>>> +#define VDUSE_GET_RECONNECT_INFO \
> >>>> +       _IOWR(VDUSE_BASE, 0x1b, struct vduse_reconnect_mmap_info)
> >>>> +
> >>>>   #endif /* _UAPI_VDUSE_H_ */
> >>>> --
> >>>> 2.34.3
> >>>>
> >>>
> >>
> >
>


