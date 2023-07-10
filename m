Return-Path: <netdev+bounces-16303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D60374CA29
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 05:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930F61C20949
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 03:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7504F17D8;
	Mon, 10 Jul 2023 03:04:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611F817D2
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 03:04:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0A9F1
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 20:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688958290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hxjOs7/F2ykf+m07k9EWu1+E7xvxWLp6lvjndYFVYtE=;
	b=iRKtejq/JU2cUNeu+NtFXh9SZMy8EozHdOyEhWw2XqgBApajMPziGCYysk/pblMVwDYA19
	u/VKp/gpGxM3czeXc/pcutEgqChrWavC7uEcFcxhuXinYpbrLd1koz7ixkXUOilzj9iRov
	NuLzpCkl0u3ND+1aE0wLn/6gmHDds+g=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-_yBeTvJnOg2OaVMz-LkBDg-1; Sun, 09 Jul 2023 23:04:48 -0400
X-MC-Unique: _yBeTvJnOg2OaVMz-LkBDg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b6ef65eaadso33430021fa.2
        for <netdev@vger.kernel.org>; Sun, 09 Jul 2023 20:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688958287; x=1691550287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxjOs7/F2ykf+m07k9EWu1+E7xvxWLp6lvjndYFVYtE=;
        b=iaSkkDDZXicYFFbBXtgQVVdSBzW1fmYSQtr9h8d4vewY3MUHwePoE2fcLZB9kEPjmr
         9wlq+qCkS/A0I1xGHS60e7VCoqlqODigvqRFH5/YWk28iNp4nSkZhJBzoqhnDO5mF7fh
         v9e75F4AFwPKKqOjypkplErJOXYhgH7mSP7/n0GSMI7j6PcEotCL7JiLNQduWFL8v19L
         j/xPK1rMdxPrd1Fw7/S1A61G7wxEUTbOX8d4BeozAUUX+xJJa+32YeIs6GUrL0Vct2b3
         is71FdX0OQEtpL1DpxVSfKH3CLhICM2TsYhocj5DfjTRblPM+m/j7eKtFSZBi90fJpFW
         5hcg==
X-Gm-Message-State: ABy/qLZIarLeU9vQf49ZiZmXVTPjs59Ramq6K7iz0hFl2lgqAevygTiE
	rLnFuHpiLFRP4oMI8vA8W1KFiQUfjc1NegpbV2FNmJQ0uqeDWKG0yTmTGTlh/b3obifn15P89BV
	fww1LS5rZquc0I2fqpFVDS/vcmhWenr4z
X-Received: by 2002:a2e:8611:0:b0:2b6:daa3:f0af with SMTP id a17-20020a2e8611000000b002b6daa3f0afmr8680400lji.25.1688958287192;
        Sun, 09 Jul 2023 20:04:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHEGVvoR8gVnhH73Hli5jfY/rNYMh3k0RWDca6Em62XjPIJAIwze5KX/2gY2cCAHHk0KtIToNvZe+bhl4Ac3v8=
X-Received: by 2002:a2e:8611:0:b0:2b6:daa3:f0af with SMTP id
 a17-20020a2e8611000000b002b6daa3f0afmr8680390lji.25.1688958286904; Sun, 09
 Jul 2023 20:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630003609.28527-1-shannon.nelson@amd.com>
 <20230630003609.28527-2-shannon.nelson@amd.com> <CACGkMEthwPRtawkpJMZ5o+H=pOxGszaxOsmKuRH4LkPXrfzRoA@mail.gmail.com>
 <92b6697b-4d33-457d-b9b5-ec16926cd9fa@amd.com>
In-Reply-To: <92b6697b-4d33-457d-b9b5-ec16926cd9fa@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Jul 2023 11:04:36 +0800
Message-ID: <CACGkMEtyJajf=xTmna66CbxxaYVXmeo5+dyw__wqrB=EwfdeqQ@mail.gmail.com>
Subject: Re: [PATCH virtio 1/4] pds_vdpa: reset to vdpa specified mac
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

On Sat, Jul 8, 2023 at 4:12=E2=80=AFAM Shannon Nelson <shannon.nelson@amd.c=
om> wrote:
>
>
>
> On 7/7/23 12:33 AM, Jason Wang wrote:
> > Caution: This message originated from an External Source. Use proper ca=
ution when opening attachments, clicking links, or responding.
> >
> >
> > On Fri, Jun 30, 2023 at 8:36=E2=80=AFAM Shannon Nelson <shannon.nelson@=
amd.com> wrote:
> >>
> >> From: Allen Hubbe <allen.hubbe@amd.com>
> >>
> >> When the vdpa device is reset, also reinitialize it with the mac addre=
ss
> >> that was assigned when the device was added.
> >>
> >> Fixes: 151cc834f3dd ("pds_vdpa: add support for vdpa and vdpamgmt inte=
rfaces")
> >> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
> >> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> >> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> >> ---
> >>   drivers/vdpa/pds/vdpa_dev.c | 16 ++++++++--------
> >>   drivers/vdpa/pds/vdpa_dev.h |  1 +
> >>   2 files changed, 9 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
> >> index 5071a4d58f8d..e2e99bb0be2b 100644
> >> --- a/drivers/vdpa/pds/vdpa_dev.c
> >> +++ b/drivers/vdpa/pds/vdpa_dev.c
> >> @@ -409,6 +409,8 @@ static void pds_vdpa_set_status(struct vdpa_device=
 *vdpa_dev, u8 status)
> >>                          pdsv->vqs[i].avail_idx =3D 0;
> >>                          pdsv->vqs[i].used_idx =3D 0;
> >>                  }
> >> +
> >> +               pds_vdpa_cmd_set_mac(pdsv, pdsv->mac);
> >
> > So this is not necessarily called during reset. So I think we need to
> > move it to pds_vdpa_reset()?
>
> pds_vdpa_reset() calls pds_vdpa_set_status() with a status=3D0, so this i=
s
> already covered.

Yes, but pds_vdpa_set_status() will be called when status is not zero?

Thanks

>
> sln
>
> >
> > The rest looks good.
> >
> > Thanks
> >
> >>          }
> >>
> >>          if (status & ~old_status & VIRTIO_CONFIG_S_FEATURES_OK) {
> >> @@ -532,7 +534,6 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *=
mdev, const char *name,
> >>          struct device *dma_dev;
> >>          struct pci_dev *pdev;
> >>          struct device *dev;
> >> -       u8 mac[ETH_ALEN];
> >>          int err;
> >>          int i;
> >>
> >> @@ -617,19 +618,18 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev=
 *mdev, const char *name,
> >>           * or set a random mac if default is 00:..:00
> >>           */
> >>          if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)=
) {
> >> -               ether_addr_copy(mac, add_config->net.mac);
> >> -               pds_vdpa_cmd_set_mac(pdsv, mac);
> >> +               ether_addr_copy(pdsv->mac, add_config->net.mac);
> >>          } else {
> >>                  struct virtio_net_config __iomem *vc;
> >>
> >>                  vc =3D pdsv->vdpa_aux->vd_mdev.device;
> >> -               memcpy_fromio(mac, vc->mac, sizeof(mac));
> >> -               if (is_zero_ether_addr(mac)) {
> >> -                       eth_random_addr(mac);
> >> -                       dev_info(dev, "setting random mac %pM\n", mac)=
;
> >> -                       pds_vdpa_cmd_set_mac(pdsv, mac);
> >> +               memcpy_fromio(pdsv->mac, vc->mac, sizeof(pdsv->mac));
> >> +               if (is_zero_ether_addr(pdsv->mac)) {
> >> +                       eth_random_addr(pdsv->mac);
> >> +                       dev_info(dev, "setting random mac %pM\n", pdsv=
->mac);
> >>                  }
> >>          }
> >> +       pds_vdpa_cmd_set_mac(pdsv, pdsv->mac);
> >>
> >>          for (i =3D 0; i < pdsv->num_vqs; i++) {
> >>                  pdsv->vqs[i].qid =3D i;
> >> diff --git a/drivers/vdpa/pds/vdpa_dev.h b/drivers/vdpa/pds/vdpa_dev.h
> >> index a1bc37de9537..cf02df287fc4 100644
> >> --- a/drivers/vdpa/pds/vdpa_dev.h
> >> +++ b/drivers/vdpa/pds/vdpa_dev.h
> >> @@ -39,6 +39,7 @@ struct pds_vdpa_device {
> >>          u64 req_features;               /* features requested by vdpa=
 */
> >>          u8 vdpa_index;                  /* rsvd for future subdevice =
use */
> >>          u8 num_vqs;                     /* num vqs in use */
> >> +       u8 mac[ETH_ALEN];               /* mac selected when the devic=
e was added */
> >>          struct vdpa_callback config_cb;
> >>          struct notifier_block nb;
> >>   };
> >> --
> >> 2.17.1
> >>
> >
>


