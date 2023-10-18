Return-Path: <netdev+bounces-42287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDDF7CE0D6
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AAA51C20D1C
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C193D38BAF;
	Wed, 18 Oct 2023 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VF7+jTy+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DC638BA7
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:12:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29A0EA
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697641922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oknl0tzZjYgfj+FvCflwMFT5Qcpl1UdpPsHz4BEcfKI=;
	b=VF7+jTy+JTrojjd+3cjQgfh24EwLxUHnasG0LpnY+1sQTn3KK+ndDD9tytlwR+XGqqHyTL
	D3YtATemFTsT17lor1dmyyYzohV+0oVcybJZVtqMBmzsO1outuMwpZP16dPgLYIZi7xeRH
	q6KgPPiK5aSxEQD/YWxmBq7oJvU5KQg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-7GDRGhkYNFOQ8QIKHLJSvQ-1; Wed, 18 Oct 2023 11:12:00 -0400
X-MC-Unique: 7GDRGhkYNFOQ8QIKHLJSvQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-53dfe3af1b9so5411392a12.1
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697641919; x=1698246719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oknl0tzZjYgfj+FvCflwMFT5Qcpl1UdpPsHz4BEcfKI=;
        b=BtHbdj5Ax1ltePvAXQsGKL+1/5js9RSD/qA62sV4zzhvZayobE6apaj6ZOr+qbvhPR
         Rn/Hy3MoqF7Vt5S9tGKx9PcTiUw+8XwnLkesLCjGGDwmMEKjQS2zb0QFYpr3sQBZSfjc
         cCTV5RfaWbOiHghaveXV6yktwt5GBLQDLBBC6DFUl1bv7f5j8bilvvy5BmdsS0tqSEoU
         1NO0PxxZUWTf5Mett4QFetCYZ8s5sM5hsMgIreKjEQvUNtIK+lMyKumoJkgp5gVGeVJv
         5bOAWbrjhItCB5pWneyYHsb2D86npPM9iZ+ew80N9B1sXPMYMuqn/+G3F2U3UGemIxKw
         0lug==
X-Gm-Message-State: AOJu0YwIrWvqhZPOr6aAs6BtgRKl8hXn9WelPb3YW0agoOrsIn34Xmgm
	9f23QP0yjPcdbQWH3ajgQyf5oDNUV3KfDliqc7U1cHFH1K000CMpl93IeoxbqDvxuUcyx90Rh+x
	pfe52z/HXLKkNv/pSiCV/is51rw7k/KuDSRjpUFkI
X-Received: by 2002:aa7:de06:0:b0:53e:1434:25db with SMTP id h6-20020aa7de06000000b0053e143425dbmr4141080edv.23.1697641919610;
        Wed, 18 Oct 2023 08:11:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZY6bEkCfGGr8PoYsNO6ytD3QdjUKfnwYetqLuukET8Qug2EOJRm0Krk6PXfhzRDqnXCuFmuaQQeo5xsqVTwI=
X-Received: by 2002:aa7:de06:0:b0:53e:1434:25db with SMTP id
 h6-20020aa7de06000000b0053e143425dbmr4141060edv.23.1697641919225; Wed, 18 Oct
 2023 08:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018111527.78194-1-mschmidt@redhat.com> <MW4PR11MB577642AB058202687D511502FDD5A@MW4PR11MB5776.namprd11.prod.outlook.com>
In-Reply-To: <MW4PR11MB577642AB058202687D511502FDD5A@MW4PR11MB5776.namprd11.prod.outlook.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Wed, 18 Oct 2023 17:11:48 +0200
Message-ID: <CADEbmW34Xu9Hq+LN0WfiYZyjnJ244K970wjn-0p-e1tpBkmsDw@mail.gmail.com>
Subject: Re: [PATCH net-next] iavf: delete unused iavf_mac_info fields
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>, Ivan Vecera <ivecera@redhat.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 1:26=E2=80=AFPM Drewek, Wojciech
<wojciech.drewek@intel.com> wrote:
> > -----Original Message-----
> > From: Michal Schmidt <mschmidt@redhat.com>
> > Sent: Wednesday, October 18, 2023 1:15 PM
> > To: intel-wired-lan@lists.osuosl.org
> > Cc: Keller, Jacob E <jacob.e.keller@intel.com>; Drewek, Wojciech
> > <wojciech.drewek@intel.com>; Brandeburg, Jesse
> > <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org
> > Subject: [PATCH net-next] iavf: delete unused iavf_mac_info fields
> >
> > 'san_addr' and 'mac_fcoeq' members of struct iavf_mac_info are unused.
> > 'type' is write-only. Delete all three.
> >
> > The function iavf_set_mac_type that sets 'type' also checks if the PCI
> > vendor ID is Intel. This is unnecessary. Delete the whole function.
> >
> > If in the future there's a need for the MAC type (or other PCI
> > ID-dependent data), I would prefer to use .driver_data in iavf_pci_tbl[=
]
> > for this purpose.
> >
> > Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>
> Nice cleanup, I've seen similar unused fields in i40e as well.
> Any plans for i40e cleanup?

No, I am not planning to look into i40e cleanups in the near future.
Ivan might want to do that though. [Adding him to the thread]
Michal

> > ---
> >  drivers/net/ethernet/intel/iavf/iavf_common.c | 32 -------------------
> >  drivers/net/ethernet/intel/iavf/iavf_main.c   |  5 ---
> >  .../net/ethernet/intel/iavf/iavf_prototype.h  |  2 --
> >  drivers/net/ethernet/intel/iavf/iavf_type.h   | 12 -------
> >  4 files changed, 51 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_common.c
> > b/drivers/net/ethernet/intel/iavf/iavf_common.c
> > index 1afd761d8052..8091e6feca01 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf_common.c
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_common.c
> > @@ -6,38 +6,6 @@
> >  #include "iavf_prototype.h"
> >  #include <linux/avf/virtchnl.h>
> >
> > -/**
> > - * iavf_set_mac_type - Sets MAC type
> > - * @hw: pointer to the HW structure
> > - *
> > - * This function sets the mac type of the adapter based on the
> > - * vendor ID and device ID stored in the hw structure.
> > - **/
> > -enum iavf_status iavf_set_mac_type(struct iavf_hw *hw)
> > -{
> > -     enum iavf_status status =3D 0;
> > -
> > -     if (hw->vendor_id =3D=3D PCI_VENDOR_ID_INTEL) {
> > -             switch (hw->device_id) {
> > -             case IAVF_DEV_ID_X722_VF:
> > -                     hw->mac.type =3D IAVF_MAC_X722_VF;
> > -                     break;
> > -             case IAVF_DEV_ID_VF:
> > -             case IAVF_DEV_ID_VF_HV:
> > -             case IAVF_DEV_ID_ADAPTIVE_VF:
> > -                     hw->mac.type =3D IAVF_MAC_VF;
> > -                     break;
> > -             default:
> > -                     hw->mac.type =3D IAVF_MAC_GENERIC;
> > -                     break;
> > -             }
> > -     } else {
> > -             status =3D IAVF_ERR_DEVICE_NOT_SUPPORTED;
> > -     }
> > -
> > -     return status;
> > -}
> > -
> >  /**
> >   * iavf_aq_str - convert AQ err code to a string
> >   * @hw: pointer to the HW structure
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> > b/drivers/net/ethernet/intel/iavf/iavf_main.c
> > index 768bec67825a..c862ebcd2e39 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> > @@ -2363,11 +2363,6 @@ static void iavf_startup(struct iavf_adapter
> > *adapter)
> >       /* driver loaded, probe complete */
> >       adapter->flags &=3D ~IAVF_FLAG_PF_COMMS_FAILED;
> >       adapter->flags &=3D ~IAVF_FLAG_RESET_PENDING;
> > -     status =3D iavf_set_mac_type(hw);
> > -     if (status) {
> > -             dev_err(&pdev->dev, "Failed to set MAC type (%d)\n",
> > status);
> > -             goto err;
> > -     }
> >
> >       ret =3D iavf_check_reset_complete(hw);
> >       if (ret) {
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_prototype.h
> > b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
> > index 940cb4203fbe..4a48e6171405 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf_prototype.h
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
> > @@ -45,8 +45,6 @@ enum iavf_status iavf_aq_set_rss_lut(struct iavf_hw
> > *hw, u16 seid,
> >  enum iavf_status iavf_aq_set_rss_key(struct iavf_hw *hw, u16 seid,
> >                                    struct iavf_aqc_get_set_rss_key_data=
 *key);
> >
> > -enum iavf_status iavf_set_mac_type(struct iavf_hw *hw);
> > -
> >  extern struct iavf_rx_ptype_decoded iavf_ptype_lookup[];
> >
> >  static inline struct iavf_rx_ptype_decoded decode_rx_desc_ptype(u8 pty=
pe)
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_type.h
> > b/drivers/net/ethernet/intel/iavf/iavf_type.h
> > index 9f1f523807c4..2b6a207fa441 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf_type.h
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_type.h
> > @@ -69,15 +69,6 @@ enum iavf_debug_mask {
> >   * the Firmware and AdminQ are intended to insulate the driver from mo=
st of
> > the
> >   * future changes, but these structures will also do part of the job.
> >   */
> > -enum iavf_mac_type {
> > -     IAVF_MAC_UNKNOWN =3D 0,
> > -     IAVF_MAC_XL710,
> > -     IAVF_MAC_VF,
> > -     IAVF_MAC_X722,
> > -     IAVF_MAC_X722_VF,
> > -     IAVF_MAC_GENERIC,
> > -};
> > -
> >  enum iavf_vsi_type {
> >       IAVF_VSI_MAIN   =3D 0,
> >       IAVF_VSI_VMDQ1  =3D 1,
> > @@ -110,11 +101,8 @@ struct iavf_hw_capabilities {
> >  };
> >
> >  struct iavf_mac_info {
> > -     enum iavf_mac_type type;
> >       u8 addr[ETH_ALEN];
> >       u8 perm_addr[ETH_ALEN];
> > -     u8 san_addr[ETH_ALEN];
> > -     u16 max_fcoeq;
> >  };
> >
> >  /* PCI bus types */
> > --
> > 2.41.0
>


