Return-Path: <netdev+bounces-36196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF477AE3BE
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 04:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id DAA5E1C20444
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 02:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8947F;
	Tue, 26 Sep 2023 02:47:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587AB1100
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 02:47:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E545F10A
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 19:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695696443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItET0pMqX+FXEFMhJ+U3a+Ugm6kdUA0QYgdt+0g1epA=;
	b=NsEThshGwCV3AzOIpbSqRUaw3bFthILlH6V/sAe+DKtASA5khBNq0TmVoQic9C3nRBksW0
	rj/qmOFawdoQ2glJ7DuncKA6i0fyX220ePM8m6kC8DW0upqnvWmzkY5aLtgeKyoPfLEJz6
	jIhDpmkShYFMDK/Ot4oiYxBFhbtOCXw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645--pITxQ3gPsWjJ5olCYPGHQ-1; Mon, 25 Sep 2023 22:47:21 -0400
X-MC-Unique: -pITxQ3gPsWjJ5olCYPGHQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5030ed95acdso11579849e87.2
        for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 19:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695696440; x=1696301240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItET0pMqX+FXEFMhJ+U3a+Ugm6kdUA0QYgdt+0g1epA=;
        b=NxjERWAAy4yXAdDUloDlYH0uZz8CxD14PHEUurC4ybS+jau7KNTnzENLHlYS/NKC8I
         XFUJz+rFPMlnu6SnF6ZKPdx+LcAFYEJsyJb0HVMT6mnyv5HRC7gvBKfzkA27mTh61bww
         1Wg8l8rXkUpd/rJ4dfRLDIAt305JTb/1nlSVdaInH5isGplpwA/ZgW7JLn31QzfqrrTc
         KoXeQgnW42jvJPQStyO377Kw/TXfnPcwYw6mNUMMsQ41WM7qy87E/PZE92FUV2My1TtE
         ezeXqH7T2ersg6zuhsbrbC2Ri+rC6k2WFW9hf74WhDVLXElvj0h8SysFSifRMJMhhTaG
         V+4A==
X-Gm-Message-State: AOJu0YxODdfecjdLS8vJXrmz0baIKzwJ7BWNonncZtdJUj3HFSsH3RrS
	AzexSmVax0K48S3bBqWvlLX9J+dE88EWtLCRZ59rsaIEnXYQJ4IDOqayJt0ldVvZT0eQ8/IAEGn
	TUoQL2s5Wk7EGFHM5oKcrzPlr0NFe89Xf
X-Received: by 2002:a05:6512:29a:b0:503:303:9e2d with SMTP id j26-20020a056512029a00b0050303039e2dmr6664863lfp.5.1695696439800;
        Mon, 25 Sep 2023 19:47:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVfoDQ70MvGrrFuSM5F4u5jc1N+fSkvSpE6P8ei76cf78SA8yD0wv/BtCLlpJJLc55YsUP/ur6WGFsVmTMMm4=
X-Received: by 2002:a05:6512:29a:b0:503:303:9e2d with SMTP id
 j26-20020a056512029a00b0050303039e2dmr6664849lfp.5.1695696439422; Mon, 25 Sep
 2023 19:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230923170540.1447301-1-lulu@redhat.com> <20230923170540.1447301-6-lulu@redhat.com>
In-Reply-To: <20230923170540.1447301-6-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Sep 2023 10:47:08 +0800
Message-ID: <CACGkMEtWhYPy==_OEEEO=cV7A5Wv-UGMt7FvPeMW4goNtO51FA@mail.gmail.com>
Subject: Re: [RFC 5/7] vdpa: Add new vdpa_config_ops
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 24, 2023 at 1:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add new vdpa_config_ops to support iommufd
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  include/linux/vdpa.h | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 6d0f5e4e82c2..4ada5bd6f90e 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -5,6 +5,7 @@
>  #include <linux/kernel.h>
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
> +#include <linux/iommufd.h>
>  #include <linux/vhost_iotlb.h>
>  #include <linux/virtio_net.h>
>  #include <linux/if_ether.h>
> @@ -91,6 +92,12 @@ struct vdpa_device {
>         struct vdpa_mgmt_dev *mdev;
>         unsigned int ngroups;
>         unsigned int nas;
> +       struct iommufd_access *iommufd_access;
> +       struct iommufd_device *iommufd_device;
> +       struct iommufd_ctx *iommufd_ictx;
> +       unsigned long *vq_bitmap;
> +       atomic_t iommufd_users;
> +       bool iommufd_attached;
>  };
>
>  /**
> @@ -282,6 +289,15 @@ struct vdpa_map_file {
>   *                             @iova: iova to be unmapped
>   *                             @size: size of the area
>   *                             Returns integer: success (0) or error (< =
0)
> + * @bind_iommufd:              use vdpa_iommufd_physical_bind for an IOM=
MU
> + *                             backed device.
> + *                             otherwise use vdpa_iommufd_emulated_bind
> + * @unbind_iommufd:            use vdpa_iommufd_physical_unbind for an I=
OMMU
> + *                             backed device.
> + *                             otherwise, use vdpa_iommufd_emulated_unbi=
nd
> + * @attach_ioas:               use vdpa_iommufd_physical_attach_ioas for=
 an
> + *                             IOMMU backed device.
> + * @detach_ioas:               Opposite of attach_ioas

Those should be marked as mandatory only for parents with specific
translations (e.g simulator and mlx5_vdpa).

Or anything I missed?

Thanks


>   * @free:                      Free resources that belongs to vDPA (opti=
onal)
>   *                             @vdev: vdpa device
>   */
> @@ -341,6 +357,12 @@ struct vdpa_config_ops {
>                          u64 iova, u64 size);
>         int (*set_group_asid)(struct vdpa_device *vdev, unsigned int grou=
p,
>                               unsigned int asid);
> +       /* IOMMUFD ops */
> +       int (*bind_iommufd)(struct vdpa_device *vdev, struct iommufd_ctx =
*ictx,
> +                           u32 *out_device_id);
> +       void (*unbind_iommufd)(struct vdpa_device *vdev);
> +       int (*attach_ioas)(struct vdpa_device *vdev, u32 *pt_id);
> +       int (*detach_ioas)(struct vdpa_device *vdev);
>
>         /* Free device resources */
>         void (*free)(struct vdpa_device *vdev);
> @@ -510,4 +532,14 @@ struct vdpa_mgmt_dev {
>  int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
>  void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
>
> -#endif /* _LINUX_VDPA_H */
> +int vdpa_iommufd_physical_bind(struct vdpa_device *vdpa,
> +                              struct iommufd_ctx *ictx, u32 *out_device_=
id);
> +void vdpa_iommufd_physical_unbind(struct vdpa_device *vdpa);
> +int vdpa_iommufd_physical_attach_ioas(struct vdpa_device *vdpa, u32 *pt_=
id);
> +int vdpa_iommufd_emulated_bind(struct vdpa_device *vdpa,
> +                              struct iommufd_ctx *ictx, u32 *out_device_=
id);
> +void vdpa_iommufd_emulated_unbind(struct vdpa_device *vdpa);
> +int vdpa_iommufd_emulated_attach_ioas(struct vdpa_device *vdpa, u32 *pt_=
id);
> +int vdpa_iommufd_emulated_detach_ioas(struct vdpa_device *vdpa);
> +
> +#endif
> --
> 2.34.3
>


