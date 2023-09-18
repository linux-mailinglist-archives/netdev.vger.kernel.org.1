Return-Path: <netdev+bounces-34471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8317A4522
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C72281E24
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 08:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCA314AA6;
	Mon, 18 Sep 2023 08:49:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A859033EA
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:49:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D50129
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 01:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695026945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjrLFNKkiROohp1YQUFUAWvCAJRc18i6LWfUqVeHSNg=;
	b=bDdp5CEZbVauUXjOX1O7JtjLZlU71hvHnnIGiPPqn0l4V/wmsNWY2AtSV9MACqZloGF3J0
	Pr0GxwphfyKLnL8wDpUYA/Bfib+9skyD+2QlmnEHaPPnnbpXUxytw8GYnzj09anw9FST1r
	x0aXAby2yrHzg5pDRXFCaDnK4ZxQMeQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-tafOG3ksNVCI0KHJZGpcVQ-1; Mon, 18 Sep 2023 04:49:01 -0400
X-MC-Unique: tafOG3ksNVCI0KHJZGpcVQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-503177646d2so773880e87.2
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 01:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695026940; x=1695631740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjrLFNKkiROohp1YQUFUAWvCAJRc18i6LWfUqVeHSNg=;
        b=ctYWoa9jrevPdk6Pia+zEklR/ayv/UmSv3ohTALBLYaw2LJLA8vqLECtQaS6JElmiI
         5I5pvloBQ0zQRu7neuGSGNpEOlXNSuxI198Smzi7opJsIKBYFtBXLTiKCmwb/FujDn6z
         POzljfn0do/+65C7xED5TWeAlmnCsnf4cbbmwIpzJsQg643Rjgcn/wiP/z6KBIhfHY9Y
         veSa2CL3jZSjcnfaEiRGo1kYOaVInEZaSukWPkCZ1fVciSPZGxtN8BNU8RyedzAYLfeK
         HGV++I6QpYycUVvTcXcqlt9v1CZVaOI+JRodQt2zuS9LSMbDvIz6UVye5V+oPZlzyfoC
         kAtQ==
X-Gm-Message-State: AOJu0Yzg+zLum/sRExmmrLACQ9ISbu6oogpEzVdtFpPqlFh2dgcgy7PV
	paiG+el17+HRF+NDgCATGv6DSrkCTx1hZCRa51IG3AkcvAjd3l15wel5E9+VYiYw2A1kesaUSDT
	dEnMybSbDm5Wt+N9cEB3N6uV1h1aTYT7+
X-Received: by 2002:a05:6512:454:b0:500:9a45:63b with SMTP id y20-20020a056512045400b005009a45063bmr6257563lfk.13.1695026940422;
        Mon, 18 Sep 2023 01:49:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcNhH5iIOphVoYXcP9ThVDZ+q8P4m1obQ5qx04ejzkKLACIx/Lt0O6PKx0zAhN2vKlafazLnuEdoCmJbrjonc=
X-Received: by 2002:a05:6512:454:b0:500:9a45:63b with SMTP id
 y20-20020a056512045400b005009a45063bmr6257546lfk.13.1695026940132; Mon, 18
 Sep 2023 01:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com> <20230912030008.3599514-5-lulu@redhat.com>
In-Reply-To: <20230912030008.3599514-5-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Sep 2023 16:48:49 +0800
Message-ID: <CACGkMEtCYG8-Pt+V-OOwUV7fYFp_cnxU68Moisfxju9veJ-=qw@mail.gmail.com>
Subject: Re: [RFC v2 4/4] vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, maxime.coquelin@redhat.com, xieyongji@bytedance.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 12, 2023 at 11:01=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> In VDUSE_GET_RECONNECT_INFO, the Userspace App can get the map size
> and The number of mapping memory pages from the kernel. The userspace
> App can use this information to map the pages.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++++++
>  include/uapi/linux/vduse.h         | 15 +++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 680b23dbdde2..c99f99892b5c 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1368,6 +1368,21 @@ static long vduse_dev_ioctl(struct file *file, uns=
igned int cmd,
>                 ret =3D 0;
>                 break;
>         }
> +       case VDUSE_GET_RECONNECT_INFO: {
> +               struct vduse_reconnect_mmap_info info;
> +
> +               ret =3D -EFAULT;
> +               if (copy_from_user(&info, argp, sizeof(info)))
> +                       break;
> +
> +               info.size =3D PAGE_SIZE;
> +               info.max_index =3D dev->vq_num + 1;
> +
> +               if (copy_to_user(argp, &info, sizeof(info)))
> +                       break;
> +               ret =3D 0;
> +               break;
> +       }
>         default:
>                 ret =3D -ENOIOCTLCMD;
>                 break;
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index d585425803fd..ce55e34f63d7 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -356,4 +356,19 @@ struct vhost_reconnect_vring {
>         _Bool avail_wrap_counter;
>  };
>
> +/**
> + * struct vduse_reconnect_mmap_info
> + * @size: mapping memory size, always page_size here
> + * @max_index: the number of pages allocated in kernel,just
> + * use for check
> + */
> +
> +struct vduse_reconnect_mmap_info {
> +       __u32 size;
> +       __u32 max_index;
> +};

One thing I didn't understand is that, aren't the things we used to
store connection info belong to uAPI? If not, how can we make sure the
connections work across different vendors/implementations. If yes,
where?

Thanks

> +
> +#define VDUSE_GET_RECONNECT_INFO \
> +       _IOWR(VDUSE_BASE, 0x1b, struct vduse_reconnect_mmap_info)
> +
>  #endif /* _UAPI_VDUSE_H_ */
> --
> 2.34.3
>


