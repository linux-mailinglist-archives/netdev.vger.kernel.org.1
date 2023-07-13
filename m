Return-Path: <netdev+bounces-17408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E05317517DC
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 07:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD61281B30
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 05:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A756CA3C;
	Thu, 13 Jul 2023 05:08:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E37F8
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:08:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35ED12E
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 22:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689224890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FK3HAtjffnT8k5QoBBp6RD+0GMERT0znJ4i6l0wg/Vk=;
	b=Geu5OLxHT1YWTEJiHe0OGFBjeVbyq09L4iWymhH59FJ1YePDT+y+UnKa5O/9Ftw6egw9Nl
	7RNEDfQdk8lX4w4cHCtvP0PIE8GM7lbjp749oC/1klm2bkFSDbhqPRaX7Egzih25GE0ay5
	bQgKyleWnBdFlHZl+bBmyMjS8m4gZEA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-5fbbjF6ePtO3B6XNCfbKzw-1; Thu, 13 Jul 2023 01:08:08 -0400
X-MC-Unique: 5fbbjF6ePtO3B6XNCfbKzw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b698377ed7so2080071fa.3
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 22:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689224886; x=1691816886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FK3HAtjffnT8k5QoBBp6RD+0GMERT0znJ4i6l0wg/Vk=;
        b=Vgxu2QFeXa9aSd98FDLJPP5X9jlcsJIPOcVvUp8/Z/2Z2argk7OYteoY1siDNiUfd4
         ZS7BaYEwQHRKsiuIftb7tclJ4ddyry9iKEc5xhsgpxUGw3Qwn8WQkwuptO2oXjNtXRQ2
         P6tbZOs3npRz41PSziadbo25sulzKrQkY6FLnUgnqnZccMjLmhk5ceq5uZIMpw6hLTmT
         LNTFUKPzSm9RZ8OMVn9Md/EqoHGr99gVJ1EtZi8kX0+cJu+V2YhokzBa8a5buD24kkxn
         QtAi+RHpwT1oKm5ojiWEY4k1SXQLb2WkP0zoU3HcorrtaXguNSMfpOd4pKNXHroTKXM5
         ILEQ==
X-Gm-Message-State: ABy/qLYxOeeeS28LmBz5en40efz12ClS6f9FcS5Veno//aelE9paF46f
	QrItwDI7q3LXwM/gsHJa/EjIOrrw4z8LLyEI73rlQRZDqk0Ig8204WNSCSu1eVZDLIHg7xEslsk
	RwWS8j+XT+eVQEsJG/agsXcUozzo65KMH
X-Received: by 2002:a2e:88c9:0:b0:2b6:dc55:c3c7 with SMTP id a9-20020a2e88c9000000b002b6dc55c3c7mr406656ljk.20.1689224886509;
        Wed, 12 Jul 2023 22:08:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEQg0FoxlfqIxpBgqQRxlTpfm0y4Al1qIWdOtaD9ZdA1f+uzj+oAQfj0JJCUGJM7x881ry7KugxQLuoLXSIuWs=
X-Received: by 2002:a2e:88c9:0:b0:2b6:dc55:c3c7 with SMTP id
 a9-20020a2e88c9000000b002b6dc55c3c7mr406639ljk.20.1689224886093; Wed, 12 Jul
 2023 22:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230711042437.69381-1-shannon.nelson@amd.com> <20230711042437.69381-3-shannon.nelson@amd.com>
In-Reply-To: <20230711042437.69381-3-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Jul 2023 13:07:55 +0800
Message-ID: <CACGkMEsOK24Hi-qEkTHzM55tye12cp3Xu2i9fyz--L=kYZCE-g@mail.gmail.com>
Subject: Re: [PATCH v2 virtio 2/5] pds_vdpa: always allow offering VIRTIO_NET_F_MAC
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
> Our driver sets a mac if the HW is 00:..:00 so we need to be sure to
> advertise VIRTIO_NET_F_MAC even if the HW doesn't.  We also need to be
> sure that virtio_net sees the VIRTIO_NET_F_MAC and doesn't rewrite the
> mac address that a user may have set with the vdpa utility.
>
> After reading the hw_feature bits, add the VIRTIO_NET_F_MAC to the driver=
's
> supported_features and use that for reporting what is available.  If the
> HW is not advertising it, be sure to strip the VIRTIO_NET_F_MAC before
> finishing the feature negotiation.  If the user specifies a device_featur=
es
> bitpattern in the vdpa utility without the VIRTIO_NET_F_MAC set, then
> don't set the mac.
>
> Fixes: 151cc834f3dd ("pds_vdpa: add support for vdpa and vdpamgmt interfa=
ces")
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/pds/debugfs.c  |  2 --
>  drivers/vdpa/pds/vdpa_dev.c | 30 +++++++++++++++++++++---------
>  drivers/vdpa/pds/vdpa_dev.h |  4 ++--
>  3 files changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/vdpa/pds/debugfs.c b/drivers/vdpa/pds/debugfs.c
> index 21a0dc0cb607..754ccb7a6666 100644
> --- a/drivers/vdpa/pds/debugfs.c
> +++ b/drivers/vdpa/pds/debugfs.c
> @@ -224,8 +224,6 @@ static int config_show(struct seq_file *seq, void *v)
>         seq_printf(seq, "dev_status:           %#x\n", status);
>         print_status_bits(seq, status);
>
> -       seq_printf(seq, "req_features:         %#llx\n", pdsv->req_featur=
es);
> -       print_feature_bits_all(seq, pdsv->req_features);
>         driver_features =3D vp_modern_get_driver_features(&pdsv->vdpa_aux=
->vd_mdev);
>         seq_printf(seq, "driver_features:      %#llx\n", driver_features)=
;
>         print_feature_bits_all(seq, driver_features);
> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
> index e2e99bb0be2b..5b566e0eef0a 100644
> --- a/drivers/vdpa/pds/vdpa_dev.c
> +++ b/drivers/vdpa/pds/vdpa_dev.c
> @@ -318,6 +318,7 @@ static int pds_vdpa_set_driver_features(struct vdpa_d=
evice *vdpa_dev, u64 featur
>         struct device *dev =3D &pdsv->vdpa_dev.dev;
>         u64 driver_features;
>         u64 nego_features;
> +       u64 hw_features;
>         u64 missing;
>
>         if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)) && features) =
{
> @@ -325,21 +326,26 @@ static int pds_vdpa_set_driver_features(struct vdpa=
_device *vdpa_dev, u64 featur
>                 return -EOPNOTSUPP;
>         }
>
> -       pdsv->req_features =3D features;
> -
>         /* Check for valid feature bits */
> -       nego_features =3D features & le64_to_cpu(pdsv->vdpa_aux->ident.hw=
_features);
> -       missing =3D pdsv->req_features & ~nego_features;
> +       nego_features =3D features & pdsv->supported_features;
> +       missing =3D features & ~nego_features;
>         if (missing) {
>                 dev_err(dev, "Can't support all requested features in %#l=
lx, missing %#llx features\n",
> -                       pdsv->req_features, missing);
> +                       features, missing);
>                 return -EOPNOTSUPP;
>         }
>
> +       pdsv->negotiated_features =3D nego_features;
> +
>         driver_features =3D pds_vdpa_get_driver_features(vdpa_dev);
>         dev_dbg(dev, "%s: %#llx =3D> %#llx\n",
>                 __func__, driver_features, nego_features);
>
> +       /* if we're faking the F_MAC, strip it before writing to device *=
/
> +       hw_features =3D le64_to_cpu(pdsv->vdpa_aux->ident.hw_features);
> +       if (!(hw_features & BIT_ULL(VIRTIO_NET_F_MAC)))
> +               nego_features &=3D ~BIT_ULL(VIRTIO_NET_F_MAC);
> +
>         if (driver_features =3D=3D nego_features)
>                 return 0;
>
> @@ -352,7 +358,7 @@ static u64 pds_vdpa_get_driver_features(struct vdpa_d=
evice *vdpa_dev)
>  {
>         struct pds_vdpa_device *pdsv =3D vdpa_to_pdsv(vdpa_dev);
>
> -       return vp_modern_get_driver_features(&pdsv->vdpa_aux->vd_mdev);
> +       return pdsv->negotiated_features;
>  }
>
>  static void pds_vdpa_set_config_cb(struct vdpa_device *vdpa_dev,
> @@ -564,7 +570,7 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
>
>         if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
>                 u64 unsupp_features =3D
> -                       add_config->device_features & ~mgmt->supported_fe=
atures;
> +                       add_config->device_features & ~pdsv->supported_fe=
atures;
>
>                 if (unsupp_features) {
>                         dev_err(dev, "Unsupported features: %#llx\n", uns=
upp_features);
> @@ -615,7 +621,8 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
>         }
>
>         /* Set a mac, either from the user config if provided
> -        * or set a random mac if default is 00:..:00
> +        * or use the device's mac if not 00:..:00
> +        * or set a random mac
>          */
>         if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
>                 ether_addr_copy(pdsv->mac, add_config->net.mac);
> @@ -624,7 +631,8 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
>
>                 vc =3D pdsv->vdpa_aux->vd_mdev.device;
>                 memcpy_fromio(pdsv->mac, vc->mac, sizeof(pdsv->mac));
> -               if (is_zero_ether_addr(pdsv->mac)) {
> +               if (is_zero_ether_addr(pdsv->mac) &&
> +                   (pdsv->supported_features & BIT_ULL(VIRTIO_NET_F_MAC)=
)) {
>                         eth_random_addr(pdsv->mac);
>                         dev_info(dev, "setting random mac %pM\n", pdsv->m=
ac);
>                 }
> @@ -752,6 +760,10 @@ int pds_vdpa_get_mgmt_info(struct pds_vdpa_aux *vdpa=
_aux)
>         mgmt->id_table =3D pds_vdpa_id_table;
>         mgmt->device =3D dev;
>         mgmt->supported_features =3D le64_to_cpu(vdpa_aux->ident.hw_featu=
res);
> +
> +       /* advertise F_MAC even if the device doesn't */
> +       mgmt->supported_features |=3D BIT_ULL(VIRTIO_NET_F_MAC);
> +
>         mgmt->config_attr_mask =3D BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)=
;
>         mgmt->config_attr_mask |=3D BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP=
);
>         mgmt->config_attr_mask |=3D BIT_ULL(VDPA_ATTR_DEV_FEATURES);
> diff --git a/drivers/vdpa/pds/vdpa_dev.h b/drivers/vdpa/pds/vdpa_dev.h
> index cf02df287fc4..d984ba24a7da 100644
> --- a/drivers/vdpa/pds/vdpa_dev.h
> +++ b/drivers/vdpa/pds/vdpa_dev.h
> @@ -35,8 +35,8 @@ struct pds_vdpa_device {
>         struct pds_vdpa_aux *vdpa_aux;
>
>         struct pds_vdpa_vq_info vqs[PDS_VDPA_MAX_QUEUES];
> -       u64 supported_features;         /* specified device features */
> -       u64 req_features;               /* features requested by vdpa */
> +       u64 supported_features;         /* supported device features */
> +       u64 negotiated_features;        /* negotiated features */
>         u8 vdpa_index;                  /* rsvd for future subdevice use =
*/
>         u8 num_vqs;                     /* num vqs in use */
>         u8 mac[ETH_ALEN];               /* mac selected when the device w=
as added */
> --
> 2.17.1
>


