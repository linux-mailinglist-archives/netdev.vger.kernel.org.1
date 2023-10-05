Return-Path: <netdev+bounces-38295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A41B7BA0C3
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 8F8ED1C2098D
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 14:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81AC250E3;
	Thu,  5 Oct 2023 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LC1Y8UmZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF0C2E630
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 14:44:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF37D498
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696517050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UhsT5XkGXkGRLbCYhr0XYk0IXzGcyPT2/ifidPViMms=;
	b=LC1Y8UmZCtrUsxiarsZvPpecbBtOG7sXgJ4eypD1r10LWyy4fwrsS5qJhOUy0DKboyjHBi
	V0UJnXlk9TKZt2d84Uncd0DEJQ48CJ/LhJTDvXTHaKrphOVqchslgqGno1EgOMkaHGOWnT
	FVNloU2XDT30S16+FAj4PC/yDGu6sSo=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-H-cnMyxmNACDKA5Nfm-Jbg-1; Thu, 05 Oct 2023 05:42:59 -0400
X-MC-Unique: H-cnMyxmNACDKA5Nfm-Jbg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-59f2c7a4f24so11058737b3.0
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 02:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696498979; x=1697103779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhsT5XkGXkGRLbCYhr0XYk0IXzGcyPT2/ifidPViMms=;
        b=TERzuq4WA9F8Q8jdmkQAH6BPYfD5gaaf1AtQYlfAtzh+D+Knrsos7KvnZIA/087Ric
         2pLhkr0bJex2T0XP9qCt4kwoLpfCmRxYHthAIcPtOU0acxgAywlC81v/l4CKfmqGCGV5
         46qwnCNt4cszwvBz4JAUFnnDVVqZHI0pc7ygw5ohVLBN9IBP0OFnuZut8baymJFvakxw
         KHycEsg7UDs797aMN0S2alPbP9hQXqgoUEVgtWM65dVn2mUFeTaX/dwIaP6Ae+j4Fy+T
         IlMSg/Fb6vKOzHSvJl0lZQBkuE40ngJ4dobgjwKf/qqpFVT+0pCUjx42jWy2MlRRVWFk
         BDiA==
X-Gm-Message-State: AOJu0Yzn3LYLnO4iZvgdEL7EZDSjazYvcxxMM3QLwRDvTix/eIHnoirW
	oLUnQsbgzpxH7FRptj0o/0Pm5Wa/ouRWodWk/6WCZQQd91B2j3Zvi+RrEtPUZBBtFGmpk3DYjnQ
	hCNa07eqGyubIbLVNpGLx0zLZP7aRewoxkcvYoce1t9Y=
X-Received: by 2002:a0d:dd96:0:b0:570:28a9:fe40 with SMTP id g144-20020a0ddd96000000b0057028a9fe40mr4577531ywe.5.1696498979174;
        Thu, 05 Oct 2023 02:42:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp5Z4E5qYgA76zUuu87SQ+sKilV0yVrTm45uJW4TSvNm5KBZANPEY1fF3ZtdZv0RvDgnkvhfVDmedjX1JX4b4=
X-Received: by 2002:a0d:dd96:0:b0:570:28a9:fe40 with SMTP id
 g144-20020a0ddd96000000b0057028a9fe40mr4577521ywe.5.1696498978891; Thu, 05
 Oct 2023 02:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928164550.980832-2-dtatulea@nvidia.com> <20230928164550.980832-16-dtatulea@nvidia.com>
In-Reply-To: <20230928164550.980832-16-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 5 Oct 2023 11:42:22 +0200
Message-ID: <CAJaqyWeRhJNZ8wbpEFARwBBNbE07n4xQdd-RvUoZooCeB4piPA@mail.gmail.com>
Subject: Re: [PATCH vhost 14/16] vdpa/mlx5: Enable hw support for vq
 descriptor mapping
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: gal@nvidia.com, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Leon Romanovsky <leon@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 6:50=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Vq descriptor mappings are supported in hardware by filling in an
> additional mkey which contains the descriptor mappings to the hw vq.
>
> A previous patch in this series added support for hw mkey (mr) creation
> for ASID 1.
>
> This patch fills in both the vq data and vq descriptor mkeys based on
> group ASID mapping.
>
> The feature is signaled to the vdpa core through the presence of the
> .get_vq_desc_group op.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 26 ++++++++++++++++++++++++--
>  include/linux/mlx5/mlx5_ifc_vdpa.h |  7 ++++++-
>  2 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 25bd2c324f5b..46441e41892c 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -823,6 +823,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *nde=
v, struct mlx5_vdpa_virtque
>         u32 out[MLX5_ST_SZ_DW(create_virtio_net_q_out)] =3D {};
>         struct mlx5_vdpa_dev *mvdev =3D &ndev->mvdev;
>         struct mlx5_vdpa_mr *vq_mr;
> +       struct mlx5_vdpa_mr *vq_desc_mr;
>         void *obj_context;
>         u16 mlx_features;
>         void *cmd_hdr;
> @@ -878,6 +879,11 @@ static int create_virtqueue(struct mlx5_vdpa_net *nd=
ev, struct mlx5_vdpa_virtque
>         vq_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]];
>         if (vq_mr)
>                 MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, vq_mr->mkey);
> +
> +       vq_desc_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_DESC_=
GROUP]];
> +       if (vq_desc_mr)
> +               MLX5_SET(virtio_q, vq_ctx, desc_group_mkey, vq_desc_mr->m=
key);
> +
>         MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
>         MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
>         MLX5_SET(virtio_q, vq_ctx, umem_2_id, mvq->umem2.id);
> @@ -2265,6 +2271,16 @@ static u32 mlx5_vdpa_get_vq_group(struct vdpa_devi=
ce *vdev, u16 idx)
>         return MLX5_VDPA_DATAVQ_GROUP;
>  }
>
> +static u32 mlx5_vdpa_get_vq_desc_group(struct vdpa_device *vdev, u16 idx=
)
> +{
> +       struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> +
> +       if (is_ctrl_vq_idx(mvdev, idx))
> +               return MLX5_VDPA_CVQ_GROUP;
> +
> +       return MLX5_VDPA_DATAVQ_DESC_GROUP;
> +}
> +
>  static u64 mlx_to_vritio_features(u16 dev_features)
>  {
>         u64 result =3D 0;
> @@ -3139,7 +3155,7 @@ static int mlx5_set_group_asid(struct vdpa_device *=
vdev, u32 group,
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>
> -       if (group >=3D MLX5_VDPA_NUMVQ_GROUPS)
> +       if (group >=3D MLX5_VDPA_NUMVQ_GROUPS || asid >=3D MLX5_VDPA_NUM_=
AS)

Nit: the check for asid >=3D MLX5_VDPA_NUM_AS is redundant, as it will
be already checked by VHOST_VDPA_SET_GROUP_ASID handler in
drivers/vhost/vdpa.c:vhost_vdpa_vring_ioctl. Not a big deal.

>                 return -EINVAL;
>
>         mvdev->group2asid[group] =3D asid;
> @@ -3160,6 +3176,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops =
=3D {
>         .get_vq_irq =3D mlx5_get_vq_irq,
>         .get_vq_align =3D mlx5_vdpa_get_vq_align,
>         .get_vq_group =3D mlx5_vdpa_get_vq_group,
> +       .get_vq_desc_group =3D mlx5_vdpa_get_vq_desc_group, /* Op disable=
d if not supported. */
>         .get_device_features =3D mlx5_vdpa_get_device_features,
>         .set_driver_features =3D mlx5_vdpa_set_driver_features,
>         .get_driver_features =3D mlx5_vdpa_get_driver_features,
> @@ -3258,6 +3275,7 @@ struct mlx5_vdpa_mgmtdev {
>         struct vdpa_mgmt_dev mgtdev;
>         struct mlx5_adev *madev;
>         struct mlx5_vdpa_net *ndev;
> +       struct vdpa_config_ops vdpa_ops;
>  };
>
>  static int config_func_mtu(struct mlx5_core_dev *mdev, u16 mtu)
> @@ -3371,7 +3389,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>                 max_vqs =3D 2;
>         }
>
> -       ndev =3D vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev=
->device, &mlx5_vdpa_ops,
> +       ndev =3D vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev=
->device, &mgtdev->vdpa_ops,
>                                  MLX5_VDPA_NUMVQ_GROUPS, MLX5_VDPA_NUM_AS=
, name, false);
>         if (IS_ERR(ndev))
>                 return PTR_ERR(ndev);
> @@ -3546,6 +3564,10 @@ static int mlx5v_probe(struct auxiliary_device *ad=
ev,
>                 MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues) =
+ 1;
>         mgtdev->mgtdev.supported_features =3D get_supported_features(mdev=
);
>         mgtdev->madev =3D madev;
> +       mgtdev->vdpa_ops =3D mlx5_vdpa_ops;
> +
> +       if (!MLX5_CAP_DEV_VDPA_EMULATION(mdev, desc_group_mkey_supported)=
)
> +               mgtdev->vdpa_ops.get_vq_desc_group =3D NULL;

I think this is better handled by splitting mlx5_vdpa_ops in two: One
with get_vq_desc_group and other without it. You can see an example of
this in the simulator, where one version supports .dma_map incremental
updating with .dma_map and the other supports .set_map. Otherwise,
this can get messy if more members opt-out or opt-in.

But I'm ok with this too, so whatever version you choose:

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

>
>         err =3D vdpa_mgmtdev_register(&mgtdev->mgtdev);
>         if (err)
> diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5=
_ifc_vdpa.h
> index 9becdc3fa503..b86d51a855f6 100644
> --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
> +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
> @@ -74,7 +74,11 @@ struct mlx5_ifc_virtio_q_bits {
>         u8    reserved_at_320[0x8];
>         u8    pd[0x18];
>
> -       u8    reserved_at_340[0xc0];
> +       u8    reserved_at_340[0x20];
> +
> +       u8    desc_group_mkey[0x20];
> +
> +       u8    reserved_at_380[0x80];
>  };
>
>  struct mlx5_ifc_virtio_net_q_object_bits {
> @@ -141,6 +145,7 @@ enum {
>         MLX5_VIRTQ_MODIFY_MASK_STATE                    =3D (u64)1 << 0,
>         MLX5_VIRTQ_MODIFY_MASK_DIRTY_BITMAP_PARAMS      =3D (u64)1 << 3,
>         MLX5_VIRTQ_MODIFY_MASK_DIRTY_BITMAP_DUMP_ENABLE =3D (u64)1 << 4,
> +       MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY          =3D (u64)1 << 14,
>  };
>
>  enum {
> --
> 2.41.0
>


