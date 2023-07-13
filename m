Return-Path: <netdev+bounces-17409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D2C7517E0
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 07:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23BC281B3C
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 05:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AC2443F;
	Thu, 13 Jul 2023 05:09:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFA37F8
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:09:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8294812E
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 22:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689224940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8kNRJ+zYS2lROi4P6cQEoQQ/hyKnPVPTaZqyOcniZQA=;
	b=gQkf2d5hXHCS7ruvf1Yx95Khgjcj1IFn+baV7AXLMtL6RDIrW2pcGNquUdqvKVEL6LlyJ7
	BP0+WpCilJfMlBmuK4OW3MerePendVRhngUBAnTJWXinNnRG3xZRu7CxxfFi6j7xgUAz0w
	s+c+z9DLKiXJXY95y3Nf3SAL16wSQZo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-hfl5UzMtMYmPymc4nJtpkQ-1; Thu, 13 Jul 2023 01:08:59 -0400
X-MC-Unique: hfl5UzMtMYmPymc4nJtpkQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b6ce2f2960so8473431fa.0
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 22:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689224938; x=1691816938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kNRJ+zYS2lROi4P6cQEoQQ/hyKnPVPTaZqyOcniZQA=;
        b=CAu2fMkbz3Mndl87FfSLyUTK3omhIp8N4UZDs0cyo9KRlJEB3FCDjISVEQnU4Faqfx
         gsThGxG61azudjYis1axdRq5zERWRjACgMxHHrxYAnGv7OWkZ7ANM7wYb1TKIBsO5ZKl
         S9o2A9xUsTdPpfhCKAFEj34hTHmse7ZniclJKQxKu8m53RRDA0vlCQuZMuI/2eyxCwTp
         5fwSry6Vi30Ib3XUYH2+y5s0dibZcN1mJEG3msZq+goKOxXOAQ8OdRAY6E0GieGmruG3
         mymabKu9zjBzwheoZjsHrLqa+GnIf/k6rD1Jm1CxT7zklmHvWrGK1dETpIKaH23sdUIf
         Hqaw==
X-Gm-Message-State: ABy/qLYh+fah/wiomqZoyC0WCGvGnuzmtMAbwSaEV7alBe+6k7b1nFsQ
	jbMa/VlxXNGfvMow0H0U3kdHji8uXJuU5NpkrMqOwaj8MzrqfsTU1lqho0qqCCaNpwAI9ncRsEE
	i9yqpPVeupOdETPpUAM4PelSgQdY/zWNm
X-Received: by 2002:a2e:a369:0:b0:2b6:e73c:67ea with SMTP id i9-20020a2ea369000000b002b6e73c67eamr1501201ljn.17.1689224937987;
        Wed, 12 Jul 2023 22:08:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGR5K26HpVvtrIofuGEY0Xvuu/Vym0st4XIV8w4e2l9Nmms7f9AaKoPEsyxxyx+QzhGhx+HX1njIyYIMffieRM=
X-Received: by 2002:a2e:a369:0:b0:2b6:e73c:67ea with SMTP id
 i9-20020a2ea369000000b002b6e73c67eamr1501198ljn.17.1689224937717; Wed, 12 Jul
 2023 22:08:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230711042437.69381-1-shannon.nelson@amd.com> <20230711042437.69381-4-shannon.nelson@amd.com>
In-Reply-To: <20230711042437.69381-4-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Jul 2023 13:08:46 +0800
Message-ID: <CACGkMEvhYViMrj1ctZ9EWj0bbPKUQw68tm85-qidQZR4TLP=vw@mail.gmail.com>
Subject: Re: [PATCH v2 virtio 3/5] pds_vdpa: clean and reset vqs entries
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
> Make sure that we initialize the vqs[] entries the same
> way both for initial setup and after a vq reset.
>
> Fixes: 151cc834f3dd ("pds_vdpa: add support for vdpa and vdpamgmt interfa=
ces")
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/pds/vdpa_dev.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
> index 5b566e0eef0a..04a362648b02 100644
> --- a/drivers/vdpa/pds/vdpa_dev.c
> +++ b/drivers/vdpa/pds/vdpa_dev.c
> @@ -428,6 +428,17 @@ static void pds_vdpa_set_status(struct vdpa_device *=
vdpa_dev, u8 status)
>         }
>  }
>
> +static void pds_vdpa_init_vqs_entry(struct pds_vdpa_device *pdsv, int qi=
d,
> +                                   void __iomem *notify)
> +{
> +       memset(&pdsv->vqs[qid], 0, sizeof(pdsv->vqs[0]));
> +       pdsv->vqs[qid].qid =3D qid;
> +       pdsv->vqs[qid].pdsv =3D pdsv;
> +       pdsv->vqs[qid].ready =3D false;
> +       pdsv->vqs[qid].irq =3D VIRTIO_MSI_NO_VECTOR;
> +       pdsv->vqs[qid].notify =3D notify;
> +}
> +
>  static int pds_vdpa_reset(struct vdpa_device *vdpa_dev)
>  {
>         struct pds_vdpa_device *pdsv =3D vdpa_to_pdsv(vdpa_dev);
> @@ -450,8 +461,7 @@ static int pds_vdpa_reset(struct vdpa_device *vdpa_de=
v)
>                                 dev_err(dev, "%s: reset_vq failed qid %d:=
 %pe\n",
>                                         __func__, i, ERR_PTR(err));
>                         pds_vdpa_release_irq(pdsv, i);
> -                       memset(&pdsv->vqs[i], 0, sizeof(pdsv->vqs[0]));
> -                       pdsv->vqs[i].ready =3D false;
> +                       pds_vdpa_init_vqs_entry(pdsv, i, pdsv->vqs[i].not=
ify);
>                 }
>         }
>
> @@ -640,11 +650,11 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *m=
dev, const char *name,
>         pds_vdpa_cmd_set_mac(pdsv, pdsv->mac);
>
>         for (i =3D 0; i < pdsv->num_vqs; i++) {
> -               pdsv->vqs[i].qid =3D i;
> -               pdsv->vqs[i].pdsv =3D pdsv;
> -               pdsv->vqs[i].irq =3D VIRTIO_MSI_NO_VECTOR;
> -               pdsv->vqs[i].notify =3D vp_modern_map_vq_notify(&pdsv->vd=
pa_aux->vd_mdev,
> -                                                             i, &pdsv->v=
qs[i].notify_pa);
> +               void __iomem *notify;
> +
> +               notify =3D vp_modern_map_vq_notify(&pdsv->vdpa_aux->vd_md=
ev,
> +                                                i, &pdsv->vqs[i].notify_=
pa);
> +               pds_vdpa_init_vqs_entry(pdsv, i, notify);
>         }
>
>         pdsv->vdpa_dev.mdev =3D &vdpa_aux->vdpa_mdev;
> --
> 2.17.1
>


