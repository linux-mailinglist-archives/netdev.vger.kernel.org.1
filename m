Return-Path: <netdev+bounces-15977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4013E74AC25
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 09:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF69E2816AB
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 07:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EE56FCC;
	Fri,  7 Jul 2023 07:45:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012216FA3
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 07:45:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C50211D
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 00:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688715904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OvFopdVMX2fOx14kZcV5OzI3C0A2yd85C4HgqlgQUC4=;
	b=PwlSMmV/6cEnO+qum2ZczZC7arlqPrsghQv6seHEx/sAPxFjqmS6Gaz8IfL0P7YYqU9lBd
	P2It128J/xsgpMdZ14z0KF2TJbSXLAfJ5tzb/oHxcuu2YkxFvZrIx8i3Sj0za1omJBNHDf
	eXGckMdD0P3+qxtoG+j4FrzsA/VKq3g=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-bv8BRfrOMqiJMzlPApeqlg-1; Fri, 07 Jul 2023 03:44:58 -0400
X-MC-Unique: bv8BRfrOMqiJMzlPApeqlg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b707829eb9so15833151fa.3
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 00:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688715897; x=1691307897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvFopdVMX2fOx14kZcV5OzI3C0A2yd85C4HgqlgQUC4=;
        b=FrGHDyuI2PIiRXjVrLIiTSiy9FQVvN3vkaJNctT7HFJfQ61Thf18ni8Vvh7yYUC+kA
         MaN+sKFZpSWYXHWCfvV0lk8E/20v7Qj5/ed+M1gzTjZWPTycDZg213TvAO5JaQ6VeD9S
         Jk7oiRQmOaAJxwOkJZJryJdDPuJPRCFtAeufeLUcrYQsA3V2QWVuB4KhLrf06sXLhen0
         3tRL22YVWo0VF33MHnOPECCcRWEY+EM1L+mvOvrfsv50ZsJUajX/0m8a1kdrC/oNmp4r
         POYrpdXHlphcWnBCrorKUog8nzKI7t0JhnM0RTJJuU4vOle7pKIQ9dP1/DH7F75CMP/l
         lDHA==
X-Gm-Message-State: ABy/qLZTLJTQIPVm+xv9PlWiRUhWWjm7TqEO3hJaZhbU/atmmPvNrMZu
	BxfqX7WsJn+pOCSizr8Gao01pmSRxCstBa7VuTmd5JqIlaANq3LJUaHOidtGz9FU2zLnh8wj9Yv
	P2QoizW3VxQAXb5UaOqBT2vFyklE4Pt3X
X-Received: by 2002:a2e:83d5:0:b0:2b6:9f1e:12c1 with SMTP id s21-20020a2e83d5000000b002b69f1e12c1mr4035889ljh.3.1688715897296;
        Fri, 07 Jul 2023 00:44:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHU/nRDUHuYhFgse/jwYSAFRpY3tbiByilN09qGXhk1ws184RfXzxkxYMNviVf6GL/qykSZdeC91pKlPYfdWtk=
X-Received: by 2002:a2e:83d5:0:b0:2b6:9f1e:12c1 with SMTP id
 s21-20020a2e83d5000000b002b69f1e12c1mr4035877ljh.3.1688715896991; Fri, 07 Jul
 2023 00:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630003609.28527-1-shannon.nelson@amd.com> <20230630003609.28527-3-shannon.nelson@amd.com>
In-Reply-To: <20230630003609.28527-3-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Jul 2023 15:44:46 +0800
Message-ID: <CACGkMEvszXdPy9esfXLNsgjE8OQMX8UQ9HNQ2JVT87xwuOH+LQ@mail.gmail.com>
Subject: Re: [PATCH virtio 2/4] pds_vdpa: always allow offering VIRTIO_NET_F_MAC
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
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> ---
>  drivers/vdpa/pds/vdpa_dev.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
> index e2e99bb0be2b..5e761d625ef3 100644
> --- a/drivers/vdpa/pds/vdpa_dev.c
> +++ b/drivers/vdpa/pds/vdpa_dev.c
> @@ -316,6 +316,7 @@ static int pds_vdpa_set_driver_features(struct vdpa_d=
evice *vdpa_dev, u64 featur
>  {
>         struct pds_vdpa_device *pdsv =3D vdpa_to_pdsv(vdpa_dev);
>         struct device *dev =3D &pdsv->vdpa_dev.dev;
> +       u64 requested_features;
>         u64 driver_features;
>         u64 nego_features;
>         u64 missing;
> @@ -325,18 +326,24 @@ static int pds_vdpa_set_driver_features(struct vdpa=
_device *vdpa_dev, u64 featur
>                 return -EOPNOTSUPP;
>         }
>
> +       /* save original request for debugfs */
>         pdsv->req_features =3D features;
> +       requested_features =3D features;
> +
> +       /* if we're faking the F_MAC, strip it from features to be negoti=
ated */
> +       driver_features =3D pds_vdpa_get_driver_features(vdpa_dev);
> +       if (!(driver_features & BIT_ULL(VIRTIO_NET_F_MAC)))
> +               requested_features &=3D ~BIT_ULL(VIRTIO_NET_F_MAC);

I'm not sure I understand here, assuming we are doing feature
negotiation here. In this case driver_features we read should be zero?
Or did you actually mean device_features here?

Thanks

>
>         /* Check for valid feature bits */
> -       nego_features =3D features & le64_to_cpu(pdsv->vdpa_aux->ident.hw=
_features);
> -       missing =3D pdsv->req_features & ~nego_features;
> +       nego_features =3D requested_features & le64_to_cpu(pdsv->vdpa_aux=
->ident.hw_features);
> +       missing =3D requested_features & ~nego_features;
>         if (missing) {
>                 dev_err(dev, "Can't support all requested features in %#l=
lx, missing %#llx features\n",
>                         pdsv->req_features, missing);
>                 return -EOPNOTSUPP;
>         }
>
> -       driver_features =3D pds_vdpa_get_driver_features(vdpa_dev);
>         dev_dbg(dev, "%s: %#llx =3D> %#llx\n",
>                 __func__, driver_features, nego_features);
>
> @@ -564,7 +571,7 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mde=
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
> @@ -615,7 +622,8 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mde=
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
> @@ -624,7 +632,8 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mde=
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
> @@ -752,6 +761,10 @@ int pds_vdpa_get_mgmt_info(struct pds_vdpa_aux *vdpa=
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
> --
> 2.17.1
>


