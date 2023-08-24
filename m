Return-Path: <netdev+bounces-30203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 357CD7865CE
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 05:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F101C20D61
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 03:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930E224521;
	Thu, 24 Aug 2023 03:24:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8476617F6
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 03:24:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294DC10EC
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 20:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692847446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPglN9jWCOWkDHiaVESzd3fbifjjVGG3Y2tLlmCAqyw=;
	b=VxK3WDYbTykeW3YuyAts0vGA7HmODQhnNmzV8yauMtAgjaTW30n5bfxkrhidypQXvMW2/B
	+NAIEBWyK4/WCBz5seGelMR1IF2BNPdzaynd2qK3mTwzv7Gn1/NbM+nSKtpBdcWY6lykqo
	JpM85qjPreGIEUzG2erR0i49dZ8Duik=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-1wuLYiIwPM-om1Z1Sw35Mg-1; Wed, 23 Aug 2023 23:24:04 -0400
X-MC-Unique: 1wuLYiIwPM-om1Z1Sw35Mg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2bbc1d8011dso54068721fa.1
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 20:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692847443; x=1693452243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPglN9jWCOWkDHiaVESzd3fbifjjVGG3Y2tLlmCAqyw=;
        b=Do4XietITfhh3Ji+REc2s9b9nj7VJsynSuA0MUmMROw/ayqr0x1rNVr4T/yWZyy8Og
         ECro63Vg8VNcK/fst7yE9z2esRlm7Ygf2Nfo8+WJ+YVNjybEfS6SsccOSUsvlAK+jjD2
         Z6eiMTlH39ILa0I8jXL6jk01yCIyz5vez4xY6PVc4puzW2ECo6nZy4+5S4rWmIKnjFn2
         daRWSkMqqlrxPqQtRPZiMQ/4+kP9IvsM+eB83PD2s9sX7qjc9Wq52IF15mObr5hjj7RH
         b/wDTA2apDL5uBB9vxY2u0A2wx5ttnA8e9pjis8f0hJvCw+ItCHVxTc75+pucAq/Qp9j
         ps2Q==
X-Gm-Message-State: AOJu0Yyh3I13jY8/8qw5VjLrMLZfqZtUMevKOk3jAJ2YzB0ju4sCjpeU
	Ui3bGa62XB7dATyMK7lfaX8hMlm+B9zwQcVYmcgD3NRMqVd0ZR5Bh7ogQFBK/zcCRV6JIETSnCu
	GhWcv/8OldzRj66+pw7KcG0ka4R6r0K+w
X-Received: by 2002:a2e:b710:0:b0:2b5:80e0:f18e with SMTP id j16-20020a2eb710000000b002b580e0f18emr11256984ljo.3.1692847443057;
        Wed, 23 Aug 2023 20:24:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjkeGqdviCPH5wTUExjQLr+CqEbEiWt/ba0nY6S4lLgHFwDlCy0ER84ojf2Z39Sci9dtg33fDr0zJFePv+spQ=
X-Received: by 2002:a2e:b710:0:b0:2b5:80e0:f18e with SMTP id
 j16-20020a2eb710000000b002b580e0f18emr11256978ljo.3.1692847442724; Wed, 23
 Aug 2023 20:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230823153032.239304-1-eric.auger@redhat.com>
In-Reply-To: <20230823153032.239304-1-eric.auger@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 24 Aug 2023 11:23:51 +0800
Message-ID: <CACGkMEseBgbQx1ESA+QV_Y+BDdmwYPVg1UjUu2G0S2B6ksDeyQ@mail.gmail.com>
Subject: Re: [PATCH] vhost: Allow null msg.size on VHOST_IOTLB_INVALIDATE
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, elic@nvidia.com, mail@anirudhrb.com, 
	mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvmarm@lists.cs.columbia.edu, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 11:30=E2=80=AFPM Eric Auger <eric.auger@redhat.com>=
 wrote:
>
> Commit e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb
> entries") Forbade vhost iotlb msg with null size to prevent entries
> with size =3D start =3D 0 and last =3D ULONG_MAX to end up in the iotlb.
>
> Then commit 95932ab2ea07 ("vhost: allow batching hint without size")
> only applied the check for VHOST_IOTLB_UPDATE and VHOST_IOTLB_INVALIDATE
> message types to fix a regression observed with batching hit.
>
> Still, the introduction of that check introduced a regression for
> some users attempting to invalidate the whole ULONG_MAX range by
> setting the size to 0. This is the case with qemu/smmuv3/vhost
> integration which does not work anymore. It Looks safe to partially
> revert the original commit and allow VHOST_IOTLB_INVALIDATE messages
> with null size. vhost_iotlb_del_range() will compute a correct end
> iova. Same for vhost_vdpa_iotlb_unmap().
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Cc: stable@vger.kernel.org

I think we need to document the usage of 0 as msg.size for
IOTLB_INVALIDATE in uapi.

Other than this:

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> Fixes: e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb entri=
es")
> ---
>  drivers/vhost/vhost.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index c71d573f1c94..e0c181ad17e3 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1458,9 +1458,7 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
>                 goto done;
>         }
>
> -       if ((msg.type =3D=3D VHOST_IOTLB_UPDATE ||
> -            msg.type =3D=3D VHOST_IOTLB_INVALIDATE) &&
> -            msg.size =3D=3D 0) {
> +       if (msg.type =3D=3D VHOST_IOTLB_UPDATE && msg.size =3D=3D 0) {
>                 ret =3D -EINVAL;
>                 goto done;
>         }
> --
> 2.41.0
>


