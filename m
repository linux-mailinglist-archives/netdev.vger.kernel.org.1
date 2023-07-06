Return-Path: <netdev+bounces-15684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7218A749361
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 03:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CEF1C20C3C
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 01:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213D5A3D;
	Thu,  6 Jul 2023 01:59:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151537F
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 01:59:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C714C1BC5
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 18:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688608716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NsasqXB9dldWhzDq9CuN3y5r4mmR4a5/kKY+3ZImxK0=;
	b=VGYO4M4Xe4Nb46U/1BduwYGTv2CafJWeW0sUgEcWbnxi81aR3zzA1r/9iWp17VeWK7W92h
	QfAYeZFZXzRRjIrZbHnAL/1QmNSasjTrf+AC8Zws5K01CpHyxdQ7Fuu95RO1oOLsdhtOIU
	uoyA3KcBlZG/sjf3J785kQXOkvgbO5Y=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-KJ6kgFapMFmdQMcbrqV8rw-1; Wed, 05 Jul 2023 21:58:34 -0400
X-MC-Unique: KJ6kgFapMFmdQMcbrqV8rw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b620465d0eso1128261fa.0
        for <netdev@vger.kernel.org>; Wed, 05 Jul 2023 18:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688608713; x=1691200713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsasqXB9dldWhzDq9CuN3y5r4mmR4a5/kKY+3ZImxK0=;
        b=XA2agBMRSlyNnxNR7X/Swmj0cgXr2rXDSrrTnwJZX7N4Oe+whq8EQW6+5dhn4VxRKk
         qDlUN/YpgzN/QI+hzhDI7BYSmI7oze/iTf5aA30Ozh86sZqRL1N8ePYzZy+BvmUPdw5b
         4uUw/n0Iv0W95sgTKPAjtLLxgPcXa10BQUAeptnUimiUPcTDCFMpD0JVF+R63BGK8uBd
         1+JCIfAyyPitl5qOiCtrKjAR1fOwBnwo1I1p2bwUwHxiDNcSDI7f4Nk/UpD9Y8E9SkP9
         Fdt7jFFnAwe+Mtij9Ca1pH3iVzTUfwxlcuWQtAoSHmPZgy8ogkZyQZP40yZTWbOvHyw3
         XmFQ==
X-Gm-Message-State: ABy/qLbQU99FwQXLfcGDLRPcLOJQlX2aVtCz29Bdd1p7NvDoGT3Q94Vi
	IstV7suAnhcHQBpakkiORMCggF66bFAQ0/X7JkJCkgMHboLRyFs04DjiZ+59TgiGdsHPY4PvWM+
	Vtd6nHe43zEvXcZWtT/0aW1fztgm3uled
X-Received: by 2002:a2e:9b84:0:b0:2b6:9e83:73da with SMTP id z4-20020a2e9b84000000b002b69e8373damr283169lji.32.1688608713367;
        Wed, 05 Jul 2023 18:58:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE00soEfxOJ/QbJordnNOL8MCWk5yZ7zVg1rcWKrVsTwrOST2cDpf/yuu7m4ImfdJtC64rluVxV55WVfuh4yOE=
X-Received: by 2002:a2e:9b84:0:b0:2b6:9e83:73da with SMTP id
 z4-20020a2e9b84000000b002b69e8373damr283157lji.32.1688608713057; Wed, 05 Jul
 2023 18:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230705100430.61927-1-maxime.coquelin@redhat.com> <20230705100430.61927-4-maxime.coquelin@redhat.com>
In-Reply-To: <20230705100430.61927-4-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Jul 2023 09:58:22 +0800
Message-ID: <CACGkMEtBJx97caD=7s_cGfQxpYhnzb_LN8fsMq7V2CT=PnQKww@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] vduse: Temporarily disable control queue features
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: xieyongji@bytedance.com, mst@redhat.com, david.marchand@redhat.com, 
	lulu@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 5, 2023 at 6:04=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> Virtio-net driver control queue implementation is not safe
> when used with VDUSE. If the VDUSE application does not
> reply to control queue messages, it currently ends up
> hanging the kernel thread sending this command.
>
> Some work is on-going to make the control queue
> implementation robust with VDUSE. Until it is completed,
> let's filter out control virtqueue and features that depend
> on it by keeping only features known to be supported.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 36 ++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 1271c9796517..7345071db0a8 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -46,6 +46,30 @@
>
>  #define IRQ_UNBOUND -1
>
> +#define VDUSE_NET_VALID_FEATURES_MASK           \
> +       (BIT_ULL(VIRTIO_NET_F_CSUM) |           \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |     \
> +        BIT_ULL(VIRTIO_NET_F_MTU) |            \
> +        BIT_ULL(VIRTIO_NET_F_MAC) |            \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) |     \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_TSO6) |     \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_ECN) |      \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_UFO) |      \
> +        BIT_ULL(VIRTIO_NET_F_HOST_TSO4) |      \
> +        BIT_ULL(VIRTIO_NET_F_HOST_TSO6) |      \
> +        BIT_ULL(VIRTIO_NET_F_HOST_ECN) |       \
> +        BIT_ULL(VIRTIO_NET_F_HOST_UFO) |       \
> +        BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |      \
> +        BIT_ULL(VIRTIO_NET_F_STATUS) |         \
> +        BIT_ULL(VIRTIO_NET_F_HOST_USO) |       \
> +        BIT_ULL(VIRTIO_F_ANY_LAYOUT) |         \
> +        BIT_ULL(VIRTIO_RING_F_INDIRECT_DESC) | \
> +        BIT_ULL(VIRTIO_F_EVENT_IDX) |          \
> +        BIT_ULL(VIRTIO_F_VERSION_1) |          \
> +        BIT_ULL(VIRTIO_F_IOMMU_PLATFORM) |     \
> +        BIT_ULL(VIRTIO_F_RING_PACKED) |        \
> +        BIT_ULL(VIRTIO_F_IN_ORDER))
> +
>  struct vduse_virtqueue {
>         u16 index;
>         u16 num_max;
> @@ -1778,6 +1802,16 @@ static struct attribute *vduse_dev_attrs[] =3D {
>
>  ATTRIBUTE_GROUPS(vduse_dev);
>
> +static void vduse_dev_features_filter(struct vduse_dev_config *config)
> +{
> +       /*
> +        * Temporarily filter out virtio-net's control virtqueue and feat=
ures
> +        * that depend on it while CVQ is being made more robust for VDUS=
E.
> +        */
> +       if (config->device_id =3D=3D VIRTIO_ID_NET)
> +               config->features &=3D VDUSE_NET_VALID_FEATURES_MASK;
> +}
> +
>  static int vduse_create_dev(struct vduse_dev_config *config,
>                             void *config_buf, u64 api_version)
>  {
> @@ -1793,6 +1827,8 @@ static int vduse_create_dev(struct vduse_dev_config=
 *config,
>         if (!dev)
>                 goto err;
>
> +       vduse_dev_features_filter(config);
> +
>         dev->api_version =3D api_version;
>         dev->device_features =3D config->features;
>         dev->device_id =3D config->device_id;
> --
> 2.41.0
>


