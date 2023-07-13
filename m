Return-Path: <netdev+bounces-17407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135317517C4
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 06:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9FB02812C6
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 04:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5E27F8;
	Thu, 13 Jul 2023 04:57:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB2D629
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 04:57:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B2B2106
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 21:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689224224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7SVbq30Rq4Z2EWDTRaHNrJofzuhocgPZjljJ+sgEcs=;
	b=BpQ7BspH7fyVkh+zWfXlKUNaAjB3HJoRwz2Mkhbp5htwh9G5zQVINHk65c9taxGh7R9PjK
	GJzchbtFwyMEHrjSa6/Uw/F3YIQCE43Pu+Vwk156qvPzFmOJaYqt9RcArtm/sKvuf80xMU
	WzZwQtmcMUWwaY+BN3LEUnnXVtElJtk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-uDKCWBtINZiE5sEx6dZiTw-1; Thu, 13 Jul 2023 00:57:02 -0400
X-MC-Unique: uDKCWBtINZiE5sEx6dZiTw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b6ad424a46so2010491fa.3
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 21:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689224220; x=1691816220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7SVbq30Rq4Z2EWDTRaHNrJofzuhocgPZjljJ+sgEcs=;
        b=Ou3W/oWVHTbeSEbXd+ZxxwXCXGwqpnLfy/HNoLytiJuqHA7dpGGbaP1V4FN8Soyetg
         WuD9Rba3XAmyNJoxoKrUp3TNU8Z+0Zt2jjBnlOaVonroMtDRNOaE84d5s/i5pU/zjlpf
         Pbx1+sci+na7JQKVj3W9AdmrmYDBwP0P6E+BlFEAUp6Qaxv7bFAv2Oa3uSx9BtMdmnm+
         CQ5okgUWti+h6jkILNV/krAzfsr/nvIriC+iRGUaFdq8iliqAdtlNJlvtN0JYL4Y9nuC
         5waS0lgqMVkXkya52nE0YkP4wcBfhduOG0zsjoijFR9vRVIZm/pTdXpQbZwNVX4FVhqy
         MQzw==
X-Gm-Message-State: ABy/qLY29lEk7n8Uo1c5d0Bz57eI8HSUcY2zid5IPqTt1X2yXHOBqVWl
	9Aj4OAhf5t9bHFXTSP94wQ7Yb0GWClRKdcBL8O2xNNGa5IDLNoxdUc3QXU+rq0+notHo93TL5+N
	3VgSIK9J22K3VkmHqjEaIJMi2fxrmOfhA
X-Received: by 2002:a2e:9953:0:b0:2b4:94ec:e4 with SMTP id r19-20020a2e9953000000b002b494ec00e4mr341031ljj.22.1689224220602;
        Wed, 12 Jul 2023 21:57:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGIypabmIEdWpREVJFlLHTSD3PLjp2d5P942GzWJq5RfB8/egNbaTfoBXMp9i+V2xRC5DcfoYK+ycaDkV04YXI=
X-Received: by 2002:a2e:9953:0:b0:2b4:94ec:e4 with SMTP id r19-20020a2e9953000000b002b494ec00e4mr341016ljj.22.1689224220304;
 Wed, 12 Jul 2023 21:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230711042437.69381-1-shannon.nelson@amd.com> <20230711042437.69381-2-shannon.nelson@amd.com>
In-Reply-To: <20230711042437.69381-2-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Jul 2023 12:56:49 +0800
Message-ID: <CACGkMEtXGqePYsYLkTQarkn9=857kYFyq8TaVwTuWTRE9KS+Rg@mail.gmail.com>
Subject: Re: [PATCH v2 virtio 1/5] pds_vdpa: reset to vdpa specified mac
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, 
	brett.creeley@amd.com, netdev@vger.kernel.org, drivers@pensando.io, 
	Allen Hubbe <allen.hubbe@amd.com>
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
> From: Allen Hubbe <allen.hubbe@amd.com>
>
> When the vdpa device is reset, also reinitialize it with the mac address
> that was assigned when the device was added.
>
> Fixes: 151cc834f3dd ("pds_vdpa: add support for vdpa and vdpamgmt interfa=
ces")
> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/pds/vdpa_dev.c | 16 ++++++++--------
>  drivers/vdpa/pds/vdpa_dev.h |  1 +
>  2 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
> index 5071a4d58f8d..e2e99bb0be2b 100644
> --- a/drivers/vdpa/pds/vdpa_dev.c
> +++ b/drivers/vdpa/pds/vdpa_dev.c
> @@ -409,6 +409,8 @@ static void pds_vdpa_set_status(struct vdpa_device *v=
dpa_dev, u8 status)
>                         pdsv->vqs[i].avail_idx =3D 0;
>                         pdsv->vqs[i].used_idx =3D 0;
>                 }
> +
> +               pds_vdpa_cmd_set_mac(pdsv, pdsv->mac);
>         }
>
>         if (status & ~old_status & VIRTIO_CONFIG_S_FEATURES_OK) {
> @@ -532,7 +534,6 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
>         struct device *dma_dev;
>         struct pci_dev *pdev;
>         struct device *dev;
> -       u8 mac[ETH_ALEN];
>         int err;
>         int i;
>
> @@ -617,19 +618,18 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *m=
dev, const char *name,
>          * or set a random mac if default is 00:..:00
>          */
>         if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> -               ether_addr_copy(mac, add_config->net.mac);
> -               pds_vdpa_cmd_set_mac(pdsv, mac);
> +               ether_addr_copy(pdsv->mac, add_config->net.mac);
>         } else {
>                 struct virtio_net_config __iomem *vc;
>
>                 vc =3D pdsv->vdpa_aux->vd_mdev.device;
> -               memcpy_fromio(mac, vc->mac, sizeof(mac));
> -               if (is_zero_ether_addr(mac)) {
> -                       eth_random_addr(mac);
> -                       dev_info(dev, "setting random mac %pM\n", mac);
> -                       pds_vdpa_cmd_set_mac(pdsv, mac);
> +               memcpy_fromio(pdsv->mac, vc->mac, sizeof(pdsv->mac));
> +               if (is_zero_ether_addr(pdsv->mac)) {
> +                       eth_random_addr(pdsv->mac);
> +                       dev_info(dev, "setting random mac %pM\n", pdsv->m=
ac);
>                 }
>         }
> +       pds_vdpa_cmd_set_mac(pdsv, pdsv->mac);
>
>         for (i =3D 0; i < pdsv->num_vqs; i++) {
>                 pdsv->vqs[i].qid =3D i;
> diff --git a/drivers/vdpa/pds/vdpa_dev.h b/drivers/vdpa/pds/vdpa_dev.h
> index a1bc37de9537..cf02df287fc4 100644
> --- a/drivers/vdpa/pds/vdpa_dev.h
> +++ b/drivers/vdpa/pds/vdpa_dev.h
> @@ -39,6 +39,7 @@ struct pds_vdpa_device {
>         u64 req_features;               /* features requested by vdpa */
>         u8 vdpa_index;                  /* rsvd for future subdevice use =
*/
>         u8 num_vqs;                     /* num vqs in use */
> +       u8 mac[ETH_ALEN];               /* mac selected when the device w=
as added */
>         struct vdpa_callback config_cb;
>         struct notifier_block nb;
>  };
> --
> 2.17.1
>


