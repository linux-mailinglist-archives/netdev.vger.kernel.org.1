Return-Path: <netdev+bounces-15972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1BD74ABF7
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 09:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A5328168A
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 07:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113636D1B;
	Fri,  7 Jul 2023 07:33:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F003263D4
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 07:33:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0E81FCE
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 00:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688715201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBBSIXu/59mCKHbbL4NSJH2aQXfaKqVLtFEbdlv5kp4=;
	b=LW5BV6vyqsd62xu1x44wcpc1dR6ZYAu7vDu+wcKpr9+xC/cV5f9oSb8cSXE200Gp8L7qd5
	WZ47AZb6bJ7cB1yPP2/De/CpE4YSoCP6afiACsFwO/FY0nbDY0SbZpo8ZAmnxJFLqqHdoe
	oumZLUoxSOU3hToJBDuVSa3lug+6kQI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-phzkopgaM_uORkqwpKfazA-1; Fri, 07 Jul 2023 03:33:19 -0400
X-MC-Unique: phzkopgaM_uORkqwpKfazA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b6ef65eaadso15899321fa.2
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 00:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688715198; x=1691307198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBBSIXu/59mCKHbbL4NSJH2aQXfaKqVLtFEbdlv5kp4=;
        b=JzZ+JhnrvFmPrmSeWWjOgJyQ3vtvtd7iVnBxmn1zRuT0RzVrF9dgvda/xK67Jd/8QX
         ckIgqStCian1cNe2W30p8/GgAyHBs4eVepc4vdDC5vQDnRAqIFQrlkCxztnfst82HmdA
         6yetOqmok85b2k6qg1Y+lQVv3gG9iA5fFfdTWEby2Sa6yLHdVhs0dElC4AcRKsVSgHKi
         kMvp0Kf28BHnSEO1bWPppsxpNf1cs/Rd7SIsFqad23CdzDp8XTK+JUTOAVzLXtWKX4RS
         X+Z584BLyVfO+w/mC/0575dq5zUjZ1aIAv+D1+xYRCvUF5/oHu3wWaSEOu21YX2V1dIM
         pvuQ==
X-Gm-Message-State: ABy/qLZwWHs6ZhD/WdNZMonUpgIUxs9daO4fz9nsmp577e3j/1PsUojR
	gd0Gr83Y8Tf+0491G6zS373Rxh2wuS+t/hv646Z85auJpT3xEmmNCwhfsCZUHv8BhEoBYpXH8kO
	C5zWhjMkMAhnQFjv7XfxlZ7xBrepIKGw/
X-Received: by 2002:a2e:9dd5:0:b0:2b6:f8d0:7d3d with SMTP id x21-20020a2e9dd5000000b002b6f8d07d3dmr2923024ljj.49.1688715198287;
        Fri, 07 Jul 2023 00:33:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFc7+bDcK9CkHA3vwuGskq3KTXhAS0ZYBULb6dWTJWaOzgypugPYLY4/k0fkoqOomqoBd5x0bMGXnSIa4BDfiY=
X-Received: by 2002:a2e:9dd5:0:b0:2b6:f8d0:7d3d with SMTP id
 x21-20020a2e9dd5000000b002b6f8d07d3dmr2923012ljj.49.1688715197962; Fri, 07
 Jul 2023 00:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630003609.28527-1-shannon.nelson@amd.com> <20230630003609.28527-2-shannon.nelson@amd.com>
In-Reply-To: <20230630003609.28527-2-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Jul 2023 15:33:07 +0800
Message-ID: <CACGkMEthwPRtawkpJMZ5o+H=pOxGszaxOsmKuRH4LkPXrfzRoA@mail.gmail.com>
Subject: Re: [PATCH virtio 1/4] pds_vdpa: reset to vdpa specified mac
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
> When the vdpa device is reset, also reinitialize it with the mac address
> that was assigned when the device was added.
>
> Fixes: 151cc834f3dd ("pds_vdpa: add support for vdpa and vdpamgmt interfa=
ces")
> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
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

So this is not necessarily called during reset. So I think we need to
move it to pds_vdpa_reset()?

The rest looks good.

Thanks

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


