Return-Path: <netdev+bounces-46150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C9D7E1B1A
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 08:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7CA11C209AB
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 07:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0DEC8CB;
	Mon,  6 Nov 2023 07:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C83C2EE
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 07:25:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EC7112
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 23:25:47 -0800 (PST)
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-wLeK05EAOiitw2fZooBMYg-1; Mon, 06 Nov 2023 02:25:45 -0500
X-MC-Unique: wLeK05EAOiitw2fZooBMYg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50948f24d14so4190203e87.1
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 23:25:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699255544; x=1699860344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnPjZZzSQXWY9ANNSnV7yHw6hBbYFuGXz/mnxSTQkCQ=;
        b=owszYmN8m+ku4C2L6Ff9M4eYY4X2YLQKIy6tPN7EVbNln1W71Lb/uVTC9dMhM7I8EZ
         m4+wioIxHa+pCOHfvNdGn9/dszgBiWSw0VHxfc9kgmiGd4qQnkC9+4ko5TxrALO+HfbX
         FP7b6/BeKTn0zOH9M1eALrl6GxxnnsvyzX1mdCNzLZjWULJVVPaF6DRpzeTSPRpRB8Vq
         B5D2bhCTUn6qzv6ig+I1b03maLOpkW8pNO0vWFPdEKcOW3Dshh0X4LZfhxmEM3LYLHmM
         ZvPRFu8dXgtkvCKTYd02H2suEB7ub6yelRzualswL9Bk26L8ONk9k4T/1w6f8Kz/dyCz
         hclw==
X-Gm-Message-State: AOJu0YySLklAqGs5+fOWsZKbFEUd6e5cfdlJ8M7gTO+P5uT2VIivI8yj
	ouIlbozM7g7Ph/axXCQ3k22nm7gC3C00wLBMFhdiIxgwan8ISvIByja7smJtnNNy6rLbKQS1yQY
	3l+VtbxzJzTkbrDGIwnyVtCsHLhp3LM1W
X-Received: by 2002:ac2:57c4:0:b0:4fd:c715:5667 with SMTP id k4-20020ac257c4000000b004fdc7155667mr18797008lfo.20.1699255543987;
        Sun, 05 Nov 2023 23:25:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGupcEpyFhjhM0FIOwp9UBm5oZuh57MUCs1hrDYjzMwG3NN6dklFvm80eN8mYejg9VfW1D3EymTIZw6vWamomw=
X-Received: by 2002:ac2:57c4:0:b0:4fd:c715:5667 with SMTP id
 k4-20020ac257c4000000b004fdc7155667mr18797001lfo.20.1699255543700; Sun, 05
 Nov 2023 23:25:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-8-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-8-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 Nov 2023 15:25:32 +0800
Message-ID: <CACGkMEuEpQinKo4zMVJ_MohPH8PkG9vx0MrhX4B_9d4UKkoV-w@mail.gmail.com>
Subject: Re: [RFC v1 7/8] vp_vdpa::Add support for iommufd
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 4, 2023 at 1:17=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add new vdpa_config_ops function to support iommufd
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/=
vp_vdpa.c
> index 281287fae89f..dd2c372d36a6 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -460,6 +460,10 @@ static const struct vdpa_config_ops vp_vdpa_ops =3D =
{
>         .set_config     =3D vp_vdpa_set_config,
>         .set_config_cb  =3D vp_vdpa_set_config_cb,
>         .get_vq_irq     =3D vp_vdpa_get_vq_irq,
> +       .bind_iommufd =3D vdpa_iommufd_physical_bind,
> +       .unbind_iommufd =3D vdpa_iommufd_physical_unbind,
> +       .attach_ioas =3D vdpa_iommufd_physical_attach_ioas,
> +       .detach_ioas =3D vdpa_iommufd_physical_detach_ioas,

For the device that depends on the platform IOMMU, any reason we still
bother a per device config ops here just as an indirection?

Thanks

>  };
>
>  static void vp_vdpa_free_irq_vectors(void *data)
> --
> 2.34.3
>


