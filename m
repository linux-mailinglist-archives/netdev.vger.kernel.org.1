Return-Path: <netdev+bounces-15974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9A874AC05
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 09:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1632811BA
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 07:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01CF6D39;
	Fri,  7 Jul 2023 07:37:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26A263D4
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 07:37:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E08A1FEC
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 00:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688715418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2LhsxiuZY4mBvEt1012syKMHY5Dt4ra0a21/EbMyrws=;
	b=VsNneTa29c91qJMA4eKh4zCHbkc1FT0Gtyk8m9B0ZidtzoKSdWsCTgyCfb3m34htJ8Dfwi
	5tXPdZZXiR9UZ2qMDGXHEHOt76QEXx6rtRmxlF7kTX8rK8ly+JZMOEDUCbQD/SMoVohuSE
	qVaqdnWQswn/hW9Kz66aQ8FwGNOt6pU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-HvIxRP06NIyiRbHzFQnZVg-1; Fri, 07 Jul 2023 03:36:57 -0400
X-MC-Unique: HvIxRP06NIyiRbHzFQnZVg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b703a04ab5so9615381fa.0
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 00:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688715415; x=1691307415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LhsxiuZY4mBvEt1012syKMHY5Dt4ra0a21/EbMyrws=;
        b=QN2Dupb177eHmJxXzdYrAHntI/qdwGZeuMT1ERZphDrFM0e8/vReh6tN9VvdA00hYD
         hhX6BUZIV9WauNZWIqZ74aqXOrzIMsiHjNCRJdqJJhUYvPRylom1T3zDmmFBBieP3mxP
         UyVbd/RQxsiGbIhImxVJgs0xcXZcDRafSNcUD6CIbtbxgE9+YazCAOGqdZQXN9lGtqJb
         QEpoveK9AOzw64die2FsBbyEYFCqVReNxyOz9L3ot5oM6qw6ZhdHG84H57zHBWJvyiJ5
         DyUgjMEkpXS2KQYC77NGJI3jLfQHtO9AcaSaeVaSw00CQW8H8qQn/BrQpAu6Z+Ble3dw
         hTbw==
X-Gm-Message-State: ABy/qLb7aOlo95u12wRyeOPBhL0xBE7MOgV7WZoYsKsqIg7q9SOrv9Wk
	8a0zekK6dU3zCnLItToVe/Sxn+NG+RBDYfSUC2Nx+1/jqP6JR2ncQxDSAuZbXzokggWYXy+gp+m
	ud6R9y+rr+pM3IrNnw8m9/fqa49cnceyg/LupmWngh4g=
X-Received: by 2002:a2e:9086:0:b0:2b6:eceb:9b8 with SMTP id l6-20020a2e9086000000b002b6eceb09b8mr1791319ljg.10.1688715415501;
        Fri, 07 Jul 2023 00:36:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGch0OzOrg3eapBwg2rXxr+g9gfz+3Lo4R5GccWTgAA+2qIGrSMQw2CRc6bxPEpItDq+boOOoGkVEirshqFzKw=
X-Received: by 2002:a2e:9086:0:b0:2b6:eceb:9b8 with SMTP id
 l6-20020a2e9086000000b002b6eceb09b8mr1791312ljg.10.1688715415219; Fri, 07 Jul
 2023 00:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630003609.28527-1-shannon.nelson@amd.com> <20230630003609.28527-4-shannon.nelson@amd.com>
In-Reply-To: <20230630003609.28527-4-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Jul 2023 15:36:44 +0800
Message-ID: <CACGkMEtH3u9bKD-49q1HuOaqnOkZc3=t+oirKZC6RZ622nUouQ@mail.gmail.com>
Subject: Re: [PATCH virtio 3/4] pds_vdpa: clean and reset vqs entries
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, 
	brett.creeley@amd.com, netdev@vger.kernel.org, drivers@pensando.io
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
> Make sure that we initialize the vqs[] entries the same
> way both for initial setup and after a vq reset.
>
> Fixes: 151cc834f3dd ("pds_vdpa: add support for vdpa and vdpamgmt interfa=
ces")
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> ---
>  drivers/vdpa/pds/vdpa_dev.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
> index 5e761d625ef3..5e1046c9af3d 100644
> --- a/drivers/vdpa/pds/vdpa_dev.c
> +++ b/drivers/vdpa/pds/vdpa_dev.c
> @@ -429,6 +429,18 @@ static void pds_vdpa_set_status(struct vdpa_device *=
vdpa_dev, u8 status)
>         }
>  }
>
> +static void pds_vdpa_init_vqs_entry(struct pds_vdpa_device *pdsv, int qi=
d)
> +{
> +       memset(&pdsv->vqs[qid], 0, sizeof(pdsv->vqs[0]));
> +       pdsv->vqs[qid].qid =3D qid;
> +       pdsv->vqs[qid].pdsv =3D pdsv;
> +       pdsv->vqs[qid].ready =3D false;
> +       pdsv->vqs[qid].irq =3D VIRTIO_MSI_NO_VECTOR;
> +       pdsv->vqs[qid].notify =3D
> +               vp_modern_map_vq_notify(&pdsv->vdpa_aux->vd_mdev,
> +                                       qid, &pdsv->vqs[qid].notify_pa);

Nit: It looks to me this would not change. So we probably don't need
this during reset?

Thanks

> +}
> +
>  static int pds_vdpa_reset(struct vdpa_device *vdpa_dev)
>  {
>         struct pds_vdpa_device *pdsv =3D vdpa_to_pdsv(vdpa_dev);
> @@ -451,8 +463,7 @@ static int pds_vdpa_reset(struct vdpa_device *vdpa_de=
v)
>                                 dev_err(dev, "%s: reset_vq failed qid %d:=
 %pe\n",
>                                         __func__, i, ERR_PTR(err));
>                         pds_vdpa_release_irq(pdsv, i);
> -                       memset(&pdsv->vqs[i], 0, sizeof(pdsv->vqs[0]));
> -                       pdsv->vqs[i].ready =3D false;
> +                       pds_vdpa_init_vqs_entry(pdsv, i);
>                 }
>         }
>
> @@ -640,13 +651,8 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *md=
ev, const char *name,
>         }
>         pds_vdpa_cmd_set_mac(pdsv, pdsv->mac);
>
> -       for (i =3D 0; i < pdsv->num_vqs; i++) {
> -               pdsv->vqs[i].qid =3D i;
> -               pdsv->vqs[i].pdsv =3D pdsv;
> -               pdsv->vqs[i].irq =3D VIRTIO_MSI_NO_VECTOR;
> -               pdsv->vqs[i].notify =3D vp_modern_map_vq_notify(&pdsv->vd=
pa_aux->vd_mdev,
> -                                                             i, &pdsv->v=
qs[i].notify_pa);
> -       }
> +       for (i =3D 0; i < pdsv->num_vqs; i++)
> +               pds_vdpa_init_vqs_entry(pdsv, i);
>
>         pdsv->vdpa_dev.mdev =3D &vdpa_aux->vdpa_mdev;
>
> --
> 2.17.1
>


