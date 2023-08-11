Return-Path: <netdev+bounces-26851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A07977938A
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 17:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF07D282230
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C093D2AB44;
	Fri, 11 Aug 2023 15:53:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59D05692
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:53:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF4419F
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691769203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhl/FHlWCyjB0V5qX6lHJBm+v9HOUeOeFTkRbcFqCOM=;
	b=JUZUAkWUGZXOiHk147jLEXY075ioVx88nTscPV/gOL4IHxleXxgGnuJHEp16AGTUu9sZQB
	X1W4EzQBHTJrcq0+PX6x1NNDX5X/CQIRnd9srHbwYgW8IIjUD+teG4Mnq7ckz9jHkYwKoa
	hn8ceS2egX1w9Se6PsBIwu90Ffs7CnY=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-vNvUVGNkPiepB7D3QhjIkA-1; Fri, 11 Aug 2023 11:53:22 -0400
X-MC-Unique: vNvUVGNkPiepB7D3QhjIkA-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-349a1cf0d69so4906625ab.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769201; x=1692374001;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhl/FHlWCyjB0V5qX6lHJBm+v9HOUeOeFTkRbcFqCOM=;
        b=k7Mgjhxe3ma5GrGl4udvvj2fFvrbMPsP9GI7HXwslA0Gt31mGgbO8BBBsryKXRg2di
         vP8fA1mZeodX5vaTK+sQrrDx26mEjnv2gvnAni/CURBq69jA9ll1McmXzQoiMlxFZZtA
         0fkpY8tTSmdJPd82bfu5QaupBANe9VuCZ+6IylTxa6g/sxumBLHr8+twG/U/2cgTxjL4
         egaHBNd98JNTdhLNYj5UXWwkTEu5wCWT9y1JgwAyZN4w27rxeHFFMmqRpME3aObWcgPI
         vuW7LDa3nmFxTIaEw4zKgpvgRIHEVIV96vtiwNrIzy0Ek6SKD9VrHYsbyOvlLp9c55cu
         ZPaA==
X-Gm-Message-State: AOJu0YyKqQuDKGICUBCrlCGNf87kw5yRNz+GW414H0KgcrKuNNVDYvGK
	Ae1reGaSKPOmqZ1Gi/CA2zJoIk+i329osMbCsb4TTnPeTS/kRaH0gli2TpYOoPIiEqAONX53ldv
	DC1c/Thb+Y7ZVRmYNWsosYsxg
X-Received: by 2002:a05:6e02:1a2a:b0:349:88c3:a698 with SMTP id g10-20020a056e021a2a00b0034988c3a698mr3233033ile.16.1691769201485;
        Fri, 11 Aug 2023 08:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8qxeBsF1Aj4GJsQyhj3+QlBAxzTEujZbcwjsWHsX6C7N9m058bSgD4UGQTVBXYvu4QSq/4w==
X-Received: by 2002:a05:6e02:1a2a:b0:349:88c3:a698 with SMTP id g10-20020a056e021a2a00b0034988c3a698mr3233001ile.16.1691769201249;
        Fri, 11 Aug 2023 08:53:21 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id q7-20020a02c8c7000000b0042b326ed1ebsm1177465jao.48.2023.08.11.08.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:53:20 -0700 (PDT)
Date: Fri, 11 Aug 2023 09:53:18 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, "Tian, Kevin" <kevin.tian@intel.com>,
 Brett Creeley <bcreeley@amd.com>, Brett Creeley <brett.creeley@amd.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "yishaih@nvidia.com" <yishaih@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "horms@kernel.org"
 <horms@kernel.org>, "shannon.nelson@amd.com" <shannon.nelson@amd.com>
Subject: Re: [PATCH v14 vfio 6/8] vfio/pds: Add support for dirty page
 tracking
Message-ID: <20230811095318.5ebcaa05.alex.williamson@redhat.com>
In-Reply-To: <ZNUoX77mXBTHJHVJ@nvidia.com>
References: <20230808162718.2151e175.alex.williamson@redhat.com>
	<01a8ee12-7a95-7245-3a00-2745aa846fca@amd.com>
	<20230809113300.2c4b0888.alex.williamson@redhat.com>
	<ZNPVmaolrI0XJG7Q@nvidia.com>
	<BN9PR11MB5276F32CC5791B3D91C62A468C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20230810104734.74fbe148.alex.williamson@redhat.com>
	<ZNUcLM/oRaCd7Ig2@nvidia.com>
	<20230810114008.6b038d2a.alex.williamson@redhat.com>
	<ZNUhqEYeT7us5SV/@nvidia.com>
	<20230810115444.21364456.alex.williamson@redhat.com>
	<ZNUoX77mXBTHJHVJ@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 10 Aug 2023 15:11:43 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Aug 10, 2023 at 11:54:44AM -0600, Alex Williamson wrote:
> > On Thu, 10 Aug 2023 14:43:04 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >  =20
> > > On Thu, Aug 10, 2023 at 11:40:08AM -0600, Alex Williamson wrote:
> > >  =20
> > > > PCI Express=C2=AE Base Specification Revision 6.0.1, pg 1461:
> > > >=20
> > > >   9.3.3.11 VF Device ID (Offset 1Ah)
> > > >=20
> > > >   This field contains the Device ID that should be presented for ev=
ery VF to the SI.
> > > >=20
> > > >   VF Device ID may be different from the PF Device ID...
> > > >=20
> > > > That?  Thanks,   =20
> > >=20
> > > NVMe matches using the class code, IIRC there is language requiring
> > > the class code to be the same. =20
> >=20
> > Ok, yes:
> >=20
> >   7.5.1.1.6 Class Code Register (Offset 09h)
> >   ...
> >   The field in a PF and its associated VFs must return the same value
> >   when read.
> >=20
> > Seems limiting, but it's indeed there.  We've got a lot of cleanup to
> > do if we're going to start rejecting drivers for devices with PCI
> > spec violations though ;)  Thanks, =20
>=20
> Well.. If we defacto say that Linux is endorsing ignoring this part of
> the spec then I predict we will see more vendors follow this approach.

The NVMe driver will claim PCI_CLASS_STORAGE_EXPRESS devices, but there
are also various vendor/device IDs in the table, some for the purpose
of setting driver data with quirks, some not.  So I think the spec
compliant behavior here would be that the VF replicates the PF class
code and we'd simply need to add the vendor/device explicitly to the id
table.

TBH, I can see why this spec requirement might get overlooked, it's a
rather arbitrary restriction of the VF device.  Thanks,

Alex


