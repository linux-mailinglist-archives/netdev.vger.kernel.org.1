Return-Path: <netdev+bounces-17410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B857517E5
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 07:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CDF5281BAC
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 05:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B720453A4;
	Thu, 13 Jul 2023 05:09:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC6539F
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:09:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3571A198A
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 22:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689224962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u9UnSZw2zINFM+43O4S+VDOdiqFk5UjfU6ueUWZWUo8=;
	b=SzB1GFtxCvZikaMnQrbv2vLRrW+Zz53Ng4se82rmt1lZOi1qrWvj/7NJvXCVnPQheGyObE
	vW7hudWqKNYjmJBf9yOvPPglEzo3YwCXqvWndyuXEwBTDPP1YoAqZM3bwJxQxxoqK3S70q
	7eQ0Q8+pPmmk+HXN7eCmFzUDwjxOnZ8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-UEQbHlISOFyzy7hRhP9ciA-1; Thu, 13 Jul 2023 01:09:20 -0400
X-MC-Unique: UEQbHlISOFyzy7hRhP9ciA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b708d79112so2139171fa.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 22:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689224959; x=1691816959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9UnSZw2zINFM+43O4S+VDOdiqFk5UjfU6ueUWZWUo8=;
        b=CRUJu7Rjgcz0yyhfYmycCzYP0WY1yzQ0ZquzE4e79eFH2KpnoaWMTemnHLN7jbmQgJ
         hfQ+9UAoKLkQbMv7jdY5IwCGP1iY3bWzDnhcwLDeDJJROw4AWXXQ37iE8nnGlhK44OPk
         AW2Oqi+s/eTwr4QRun320uyenoPlVjHipxBuhDehNs7TzhoWlDjUaT1QGvDQrOsK6C0v
         I6aJB/VIRUuGgn5SgClBMjDdFk2A0MIzYu5Zq2g4P5kiwu3I5jtl+f6pd2rNFFi0pjq5
         Ge1+YafTAI5YPQ4kKIGevM9PMrWZjFrYL73r3yeUpM6MxSxvRZaLovpilMiF0EPH1pl6
         YrCA==
X-Gm-Message-State: ABy/qLags5t6jToW7G+kvzOV1GJ0PGfgWnpdi5PjvY9JbCU8i2q5Fwok
	NCeSvseZtRDNYUyFvpRD4X0uK27cVXuNFdSCBYvbKcqj6HkakOTexweR5evnyTshlrczdxezuX5
	uDlsXkZ6biDpr+iDvGId0oPRcgn8mtd6L
X-Received: by 2002:a2e:a30d:0:b0:2b6:dd9a:e1d3 with SMTP id l13-20020a2ea30d000000b002b6dd9ae1d3mr375447lje.44.1689224959457;
        Wed, 12 Jul 2023 22:09:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFqWN1kH3hGXbUkWA8u/d4/dLXMnmETubLrnJkH8ITTqVyyJQgTmmYctpj3Refn0mum/wcEiLq0bfp6CjePFSo=
X-Received: by 2002:a2e:a30d:0:b0:2b6:dd9a:e1d3 with SMTP id
 l13-20020a2ea30d000000b002b6dd9ae1d3mr375440lje.44.1689224959182; Wed, 12 Jul
 2023 22:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230711042437.69381-1-shannon.nelson@amd.com> <20230711042437.69381-6-shannon.nelson@amd.com>
In-Reply-To: <20230711042437.69381-6-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Jul 2023 13:09:08 +0800
Message-ID: <CACGkMEvXCb0C0TdYc6CYa_shS_MFbVNegciiwxhqrVKAHkVKnw@mail.gmail.com>
Subject: Re: [PATCH v2 virtio 5/5] pds_vdpa: fix up debugfs feature bit printing
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, 
	brett.creeley@amd.com, netdev@vger.kernel.org, drivers@pensando.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 12:25=E2=80=AFPM Shannon Nelson <shannon.nelson@amd=
.com> wrote:
>
> Make clearer in debugfs output the difference between the hw
> feature bits, the features supported through the driver, and
> the features that have been negotiated.
>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/pds/debugfs.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vdpa/pds/debugfs.c b/drivers/vdpa/pds/debugfs.c
> index 754ccb7a6666..9b04aad6ec35 100644
> --- a/drivers/vdpa/pds/debugfs.c
> +++ b/drivers/vdpa/pds/debugfs.c
> @@ -176,6 +176,7 @@ static int identity_show(struct seq_file *seq, void *=
v)
>  {
>         struct pds_vdpa_aux *vdpa_aux =3D seq->private;
>         struct vdpa_mgmt_dev *mgmt;
> +       u64 hw_features;
>
>         seq_printf(seq, "aux_dev:            %s\n",
>                    dev_name(&vdpa_aux->padev->aux_dev.dev));
> @@ -183,8 +184,9 @@ static int identity_show(struct seq_file *seq, void *=
v)
>         mgmt =3D &vdpa_aux->vdpa_mdev;
>         seq_printf(seq, "max_vqs:            %d\n", mgmt->max_supported_v=
qs);
>         seq_printf(seq, "config_attr_mask:   %#llx\n", mgmt->config_attr_=
mask);
> -       seq_printf(seq, "supported_features: %#llx\n", mgmt->supported_fe=
atures);
> -       print_feature_bits_all(seq, mgmt->supported_features);
> +       hw_features =3D le64_to_cpu(vdpa_aux->ident.hw_features);
> +       seq_printf(seq, "hw_features:        %#llx\n", hw_features);
> +       print_feature_bits_all(seq, hw_features);
>
>         return 0;
>  }
> @@ -200,7 +202,6 @@ static int config_show(struct seq_file *seq, void *v)
>  {
>         struct pds_vdpa_device *pdsv =3D seq->private;
>         struct virtio_net_config vc;
> -       u64 driver_features;
>         u8 status;
>
>         memcpy_fromio(&vc, pdsv->vdpa_aux->vd_mdev.device,
> @@ -223,10 +224,8 @@ static int config_show(struct seq_file *seq, void *v=
)
>         status =3D vp_modern_get_status(&pdsv->vdpa_aux->vd_mdev);
>         seq_printf(seq, "dev_status:           %#x\n", status);
>         print_status_bits(seq, status);
> -
> -       driver_features =3D vp_modern_get_driver_features(&pdsv->vdpa_aux=
->vd_mdev);
> -       seq_printf(seq, "driver_features:      %#llx\n", driver_features)=
;
> -       print_feature_bits_all(seq, driver_features);
> +       seq_printf(seq, "negotiated_features:  %#llx\n", pdsv->negotiated=
_features);
> +       print_feature_bits_all(seq, pdsv->negotiated_features);
>         seq_printf(seq, "vdpa_index:           %d\n", pdsv->vdpa_index);
>         seq_printf(seq, "num_vqs:              %d\n", pdsv->num_vqs);
>
> --
> 2.17.1
>


