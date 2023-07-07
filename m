Return-Path: <netdev+bounces-15975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A0574AC0D
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 09:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4271C20F69
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 07:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AF16FA3;
	Fri,  7 Jul 2023 07:38:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6838E15CE
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 07:38:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B710C1FE7
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 00:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688715494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGRLeBtarDWL4VnO/MvJCKYgCqtudNPaAnqBuzPjqOI=;
	b=bJK0GF4dARYHlzUeJPTswaIJxYXMqGiwgIMEyklH6FjasTtLAaJWi8g2WXmP/PjtL0JmkQ
	93ZPrCSYYcPn2sIZs6UQSy9tUT0YsqVhP2lEMHSMFXxcqQzJdBLlOX/WNpZd2HQhAO4Q56
	4qT2xYeGFXCx9y8JVCNdoWJXHxgStfY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-1uGLMiZuOruYYlrHXdbhAw-1; Fri, 07 Jul 2023 03:38:13 -0400
X-MC-Unique: 1uGLMiZuOruYYlrHXdbhAw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b6ff15946fso15341011fa.2
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 00:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688715492; x=1691307492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGRLeBtarDWL4VnO/MvJCKYgCqtudNPaAnqBuzPjqOI=;
        b=NUXzjvV77sGCJ+NfoVIh+m+WSOexItd/FWy8OkhIbuJBh+zImSsmu8bkIGV3sSEdI7
         bwSwHM3+T6ZvPE6Q0P8AVzu+3OH3iI0hX7Gc2/TwDhCO06wxlBM/6Wk63Es0kfQyz6JE
         6D4BAOGutGrg1xVYmR0QCJ9WiDQdOsswG3xoplivAu6MgNb59RjIh5gc9sZgMbFflHBG
         EwjxLDPgTzB6Uo3kjyfjDn0G9NL6g2nwp07hYHT+16ugq1GDuTrIAzXZ9YPBZt/d4r0k
         e92asX27pPC6ydykkfNYHqkq07b+GuSWfTOnt45N6QOXbPVhXACFXmy8C1yRKFQ/QabL
         YN/A==
X-Gm-Message-State: ABy/qLauMq+rB1q9anNy2mhPNYCkm9s2Gth2cr6woVqc8nj/HZ/YEQnf
	Uhc5PR6Btq/UNrHJUBWZw7GAUg/xbvZ/uKh6C6x1mVpEVBrpzx8DvkQUxMLfDKDUIbgPJOK3mlb
	pNl2o12em5WW1LEt1IXIdnGCRLksNiGQ/
X-Received: by 2002:a2e:978c:0:b0:2b2:90e:165d with SMTP id y12-20020a2e978c000000b002b2090e165dmr1892952lji.2.1688715492177;
        Fri, 07 Jul 2023 00:38:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFoEAu+NMnHPGVTTA6NGvrjzPfYU+5dkVci6zPL9bTh5BGojfYoDuGJh4sfSfOzqN1Vszf+v0l6gsODxtSx4Yo=
X-Received: by 2002:a2e:978c:0:b0:2b2:90e:165d with SMTP id
 y12-20020a2e978c000000b002b2090e165dmr1892935lji.2.1688715491857; Fri, 07 Jul
 2023 00:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630003609.28527-1-shannon.nelson@amd.com> <20230630003609.28527-5-shannon.nelson@amd.com>
In-Reply-To: <20230630003609.28527-5-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Jul 2023 15:38:00 +0800
Message-ID: <CACGkMEvVp7A9fn=5tGNJfqqAnZfHOE=UBcJ3n9Q58qWBAQmO_g@mail.gmail.com>
Subject: Re: [PATCH virtio 4/4] pds_vdpa: alloc irq vectors on DRIVER_OK
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, 
	brett.creeley@amd.com, netdev@vger.kernel.org, drivers@pensando.io, 
	Allen Hubbe <allen.hubbe@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 8:36=E2=80=AFAM Shannon Nelson <shannon.nelson@amd.=
com> wrote:
>
> From: Allen Hubbe <allen.hubbe@amd.com>
>
> We were allocating irq vectors at the time the aux dev was probed,
> but that is before the PCI VF is assigned to a separate iommu domain
> by vhost_vdpa.  Because vhost_vdpa later changes the iommu domain the
> interrupts do not work.
>
> Instead, we can allocate the irq vectors later when we see DRIVER_OK and
> know that the reassignment of the PCI VF to an iommu domain has already
> happened.
>
> Fixes: 151cc834f3dd ("pds_vdpa: add support for vdpa and vdpamgmt interfa=
ces")
> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/pds/vdpa_dev.c | 110 ++++++++++++++++++++++++++----------
>  1 file changed, 81 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
> index 5e1046c9af3d..6c337f7a0f06 100644
> --- a/drivers/vdpa/pds/vdpa_dev.c
> +++ b/drivers/vdpa/pds/vdpa_dev.c
> @@ -126,11 +126,9 @@ static void pds_vdpa_release_irq(struct pds_vdpa_dev=
ice *pdsv, int qid)
>  static void pds_vdpa_set_vq_ready(struct vdpa_device *vdpa_dev, u16 qid,=
 bool ready)
>  {
>         struct pds_vdpa_device *pdsv =3D vdpa_to_pdsv(vdpa_dev);
> -       struct pci_dev *pdev =3D pdsv->vdpa_aux->padev->vf_pdev;
>         struct device *dev =3D &pdsv->vdpa_dev.dev;
>         u64 driver_features;
>         u16 invert_idx =3D 0;
> -       int irq;
>         int err;
>
>         dev_dbg(dev, "%s: qid %d ready %d =3D> %d\n",
> @@ -143,19 +141,6 @@ static void pds_vdpa_set_vq_ready(struct vdpa_device=
 *vdpa_dev, u16 qid, bool re
>                 invert_idx =3D PDS_VDPA_PACKED_INVERT_IDX;
>
>         if (ready) {
> -               irq =3D pci_irq_vector(pdev, qid);
> -               snprintf(pdsv->vqs[qid].irq_name, sizeof(pdsv->vqs[qid].i=
rq_name),
> -                        "vdpa-%s-%d", dev_name(dev), qid);
> -
> -               err =3D request_irq(irq, pds_vdpa_isr, 0,
> -                                 pdsv->vqs[qid].irq_name, &pdsv->vqs[qid=
]);
> -               if (err) {
> -                       dev_err(dev, "%s: no irq for qid %d: %pe\n",
> -                               __func__, qid, ERR_PTR(err));
> -                       return;
> -               }
> -               pdsv->vqs[qid].irq =3D irq;
> -
>                 /* Pass vq setup info to DSC using adminq to gather up an=
d
>                  * send all info at once so FW can do its full set up in
>                  * one easy operation
> @@ -164,7 +149,6 @@ static void pds_vdpa_set_vq_ready(struct vdpa_device =
*vdpa_dev, u16 qid, bool re
>                 if (err) {
>                         dev_err(dev, "Failed to init vq %d: %pe\n",
>                                 qid, ERR_PTR(err));
> -                       pds_vdpa_release_irq(pdsv, qid);
>                         ready =3D false;
>                 }
>         } else {
> @@ -172,7 +156,6 @@ static void pds_vdpa_set_vq_ready(struct vdpa_device =
*vdpa_dev, u16 qid, bool re
>                 if (err)
>                         dev_err(dev, "%s: reset_vq failed qid %d: %pe\n",
>                                 __func__, qid, ERR_PTR(err));
> -               pds_vdpa_release_irq(pdsv, qid);
>         }
>
>         pdsv->vqs[qid].ready =3D ready;
> @@ -396,6 +379,72 @@ static u8 pds_vdpa_get_status(struct vdpa_device *vd=
pa_dev)
>         return vp_modern_get_status(&pdsv->vdpa_aux->vd_mdev);
>  }
>
> +static int pds_vdpa_request_irqs(struct pds_vdpa_device *pdsv)
> +{
> +       struct pci_dev *pdev =3D pdsv->vdpa_aux->padev->vf_pdev;
> +       struct pds_vdpa_aux *vdpa_aux =3D pdsv->vdpa_aux;
> +       struct device *dev =3D &pdsv->vdpa_dev.dev;
> +       int max_vq, nintrs, qid, err;
> +
> +       max_vq =3D vdpa_aux->vdpa_mdev.max_supported_vqs;
> +
> +       nintrs =3D pci_alloc_irq_vectors(pdev, max_vq, max_vq, PCI_IRQ_MS=
IX);
> +       if (nintrs < 0) {
> +               dev_err(dev, "Couldn't get %d msix vectors: %pe\n",
> +                       max_vq, ERR_PTR(nintrs));
> +               return nintrs;
> +       }
> +
> +       for (qid =3D 0; qid < pdsv->num_vqs; ++qid) {
> +               int irq =3D pci_irq_vector(pdev, qid);
> +
> +               snprintf(pdsv->vqs[qid].irq_name, sizeof(pdsv->vqs[qid].i=
rq_name),
> +                        "vdpa-%s-%d", dev_name(dev), qid);
> +
> +               err =3D request_irq(irq, pds_vdpa_isr, 0,
> +                                 pdsv->vqs[qid].irq_name,
> +                                 &pdsv->vqs[qid]);
> +               if (err) {
> +                       dev_err(dev, "%s: no irq for qid %d: %pe\n",
> +                               __func__, qid, ERR_PTR(err));
> +                       goto err_release;
> +               }
> +
> +               pdsv->vqs[qid].irq =3D irq;
> +       }
> +
> +       vdpa_aux->nintrs =3D nintrs;
> +
> +       return 0;
> +
> +err_release:
> +       while (qid--)
> +               pds_vdpa_release_irq(pdsv, qid);
> +
> +       pci_free_irq_vectors(pdev);
> +
> +       vdpa_aux->nintrs =3D 0;
> +
> +       return err;
> +}
> +
> +static void pds_vdpa_release_irqs(struct pds_vdpa_device *pdsv)
> +{
> +       struct pci_dev *pdev =3D pdsv->vdpa_aux->padev->vf_pdev;
> +       struct pds_vdpa_aux *vdpa_aux =3D pdsv->vdpa_aux;
> +       int qid;
> +
> +       if (!vdpa_aux->nintrs)
> +               return;
> +
> +       for (qid =3D 0; qid < pdsv->num_vqs; qid++)
> +               pds_vdpa_release_irq(pdsv, qid);
> +
> +       pci_free_irq_vectors(pdev);
> +
> +       vdpa_aux->nintrs =3D 0;
> +}
> +
>  static void pds_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
>  {
>         struct pds_vdpa_device *pdsv =3D vdpa_to_pdsv(vdpa_dev);
> @@ -406,6 +455,11 @@ static void pds_vdpa_set_status(struct vdpa_device *=
vdpa_dev, u8 status)
>         old_status =3D pds_vdpa_get_status(vdpa_dev);
>         dev_dbg(dev, "%s: old %#x new %#x\n", __func__, old_status, statu=
s);
>
> +       if (status & ~old_status & VIRTIO_CONFIG_S_DRIVER_OK) {
> +               if (pds_vdpa_request_irqs(pdsv))
> +                       status =3D old_status | VIRTIO_CONFIG_S_FAILED;
> +       }
> +
>         pds_vdpa_cmd_set_status(pdsv, status);
>
>         /* Note: still working with FW on the need for this reset cmd */
> @@ -427,6 +481,9 @@ static void pds_vdpa_set_status(struct vdpa_device *v=
dpa_dev, u8 status)
>                                                         i, &pdsv->vqs[i].=
notify_pa);
>                 }
>         }
> +
> +       if (old_status & ~status & VIRTIO_CONFIG_S_DRIVER_OK)
> +               pds_vdpa_release_irqs(pdsv);
>  }
>
>  static void pds_vdpa_init_vqs_entry(struct pds_vdpa_device *pdsv, int qi=
d)
> @@ -462,13 +519,17 @@ static int pds_vdpa_reset(struct vdpa_device *vdpa_=
dev)
>                         if (err)
>                                 dev_err(dev, "%s: reset_vq failed qid %d:=
 %pe\n",
>                                         __func__, i, ERR_PTR(err));
> -                       pds_vdpa_release_irq(pdsv, i);
> -                       pds_vdpa_init_vqs_entry(pdsv, i);
>                 }
>         }
>
>         pds_vdpa_set_status(vdpa_dev, 0);
>
> +       if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
> +               /* Reset the vq info */
> +               for (i =3D 0; i < pdsv->num_vqs && !err; i++)
> +                       pds_vdpa_init_vqs_entry(pdsv, i);
> +       }
> +
>         return 0;
>  }
>
> @@ -761,7 +822,7 @@ int pds_vdpa_get_mgmt_info(struct pds_vdpa_aux *vdpa_=
aux)
>
>         max_vqs =3D min_t(u16, dev_intrs, max_vqs);
>         mgmt->max_supported_vqs =3D min_t(u16, PDS_VDPA_MAX_QUEUES, max_v=
qs);
> -       vdpa_aux->nintrs =3D mgmt->max_supported_vqs;
> +       vdpa_aux->nintrs =3D 0;
>
>         mgmt->ops =3D &pds_vdpa_mgmt_dev_ops;
>         mgmt->id_table =3D pds_vdpa_id_table;
> @@ -775,14 +836,5 @@ int pds_vdpa_get_mgmt_info(struct pds_vdpa_aux *vdpa=
_aux)
>         mgmt->config_attr_mask |=3D BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP=
);
>         mgmt->config_attr_mask |=3D BIT_ULL(VDPA_ATTR_DEV_FEATURES);
>
> -       err =3D pci_alloc_irq_vectors(pdev, vdpa_aux->nintrs, vdpa_aux->n=
intrs,
> -                                   PCI_IRQ_MSIX);
> -       if (err < 0) {
> -               dev_err(dev, "Couldn't get %d msix vectors: %pe\n",
> -                       vdpa_aux->nintrs, ERR_PTR(err));
> -               return err;
> -       }
> -       vdpa_aux->nintrs =3D err;
> -
>         return 0;
>  }
> --
> 2.17.1
>


