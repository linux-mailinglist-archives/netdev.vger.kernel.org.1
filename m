Return-Path: <netdev+bounces-26506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7885777FA1
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBDD51C21488
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6570821511;
	Thu, 10 Aug 2023 17:54:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB4E20FBF
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:54:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD567E7E
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691690087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DEbgyFSwr4grpjj9Lb0jzqz1ORrnMasCGrg9RIsiNrc=;
	b=Su8CjY4vxcT7xYln+VwYdZ7Bl/DkFnaBTGiJXJnwj/eyI3UtUFxubRCMDpKtLQ9YYyfqos
	elWMo2u2P8yoi0ZGyOoWKFsgxgq6ls9KXBWc+yjHKdcvrGiaO9+GtUwnzEx9b4v5IffxaM
	1dqr1x9S+tT9edK/AC9fZYjVad+BCYs=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-vLv8gPHmP428lOllXzQFLg-1; Thu, 10 Aug 2023 13:54:46 -0400
X-MC-Unique: vLv8gPHmP428lOllXzQFLg-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-791984d0dcbso486739f.3
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691690086; x=1692294886;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEbgyFSwr4grpjj9Lb0jzqz1ORrnMasCGrg9RIsiNrc=;
        b=BeASlT9Uxmd3bQRSCctv/TP5fP+RyPyMQESCBMO0IJMeT8aVuq3ulUP2O+6lGEXfCw
         iuelDUkf0VSixUBUzw2j1d0St4mNXXhuaHUdrZpH7HelaTWZ08wltzFYho9J51OJOjaA
         TdZYoJt2ao9baLu79qAE1eLFKaVJ54FkemWxcth5JrRCNbCspjIMgThip0rSYPEs11Mc
         Yh+SLjcgWN8ICjVhlmrbhawdm3YvveV+taxN6Uj0jNDWzi+7FTuxelp/rWBWggVpV56p
         tpDcGQSPSMJB8Jg8fKiDeHtF+JX1+VPEUlHDoIe1tzbFP/jtdzkQ+oqp/NDckpaYD2pC
         UDpQ==
X-Gm-Message-State: AOJu0YwHb+EMGk6+SJLGMt2tKMsoAbggoGiDldWZyBA77OeNp6UrUEYO
	gStSMZtgo+Z5djthW4LLIaIaBx6f/h17E3LMGwnsIeDFRyCNIUE2lmaBnGdZhqb1oqxmIXdNR5K
	pHH63SzHeBfpMMHXC
X-Received: by 2002:a6b:d802:0:b0:783:5e93:1e7f with SMTP id y2-20020a6bd802000000b007835e931e7fmr4138467iob.18.1691690085949;
        Thu, 10 Aug 2023 10:54:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFsNk82Q3LSF2n67H8Eoj/Sz4yXPWAYYogZh6heK7ptILV9xcHGMCFUNzsZsZ7JEI4E/ZiCg==
X-Received: by 2002:a6b:d802:0:b0:783:5e93:1e7f with SMTP id y2-20020a6bd802000000b007835e931e7fmr4138459iob.18.1691690085736;
        Thu, 10 Aug 2023 10:54:45 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id g15-20020a02b70f000000b0043021113e09sm530909jam.75.2023.08.10.10.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 10:54:45 -0700 (PDT)
Date: Thu, 10 Aug 2023 11:54:44 -0600
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
Message-ID: <20230810115444.21364456.alex.williamson@redhat.com>
In-Reply-To: <ZNUhqEYeT7us5SV/@nvidia.com>
References: <20230807205755.29579-1-brett.creeley@amd.com>
	<20230807205755.29579-7-brett.creeley@amd.com>
	<20230808162718.2151e175.alex.williamson@redhat.com>
	<01a8ee12-7a95-7245-3a00-2745aa846fca@amd.com>
	<20230809113300.2c4b0888.alex.williamson@redhat.com>
	<ZNPVmaolrI0XJG7Q@nvidia.com>
	<BN9PR11MB5276F32CC5791B3D91C62A468C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20230810104734.74fbe148.alex.williamson@redhat.com>
	<ZNUcLM/oRaCd7Ig2@nvidia.com>
	<20230810114008.6b038d2a.alex.williamson@redhat.com>
	<ZNUhqEYeT7us5SV/@nvidia.com>
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
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 10 Aug 2023 14:43:04 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Aug 10, 2023 at 11:40:08AM -0600, Alex Williamson wrote:
>=20
> > PCI Express=C2=AE Base Specification Revision 6.0.1, pg 1461:
> >=20
> >   9.3.3.11 VF Device ID (Offset 1Ah)
> >=20
> >   This field contains the Device ID that should be presented for every =
VF to the SI.
> >=20
> >   VF Device ID may be different from the PF Device ID...
> >=20
> > That?  Thanks, =20
>=20
> NVMe matches using the class code, IIRC there is language requiring
> the class code to be the same.

Ok, yes:

  7.5.1.1.6 Class Code Register (Offset 09h)
  ...
  The field in a PF and its associated VFs must return the same value
  when read.

Seems limiting, but it's indeed there.  We've got a lot of cleanup to
do if we're going to start rejecting drivers for devices with PCI
spec violations though ;)  Thanks,

Alex


