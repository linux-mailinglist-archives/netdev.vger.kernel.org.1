Return-Path: <netdev+bounces-45709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C90BC7DF20E
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 13:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2561F2269F
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 12:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2355615EA3;
	Thu,  2 Nov 2023 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLmFbG7n"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7C413FED
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 12:10:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C556128
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698927031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4d3LBwofHPDGIVxzOtEyFdF9IVCLxopngLk7uHzb1Y=;
	b=iLmFbG7n55SpnIa1Cl8bQR2s51UkbFM7HCa6dwrAdsPDtpptyQsqaLOR8kUBQYNULKrP0U
	juUE4G7lv9e5szFoWxvRm/3jNXlA58iXKDVgysXRmgO18GbYQ5zd5P2F+2+0t3r8nE/zpP
	1S6x2MxUHvFrYYc2fUJp88PMEnVUD3k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-5IYFPB1DMxil2T4b_lB01A-1; Thu, 02 Nov 2023 08:10:30 -0400
X-MC-Unique: 5IYFPB1DMxil2T4b_lB01A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9c983b42c3bso218645766b.1
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 05:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698927029; x=1699531829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4d3LBwofHPDGIVxzOtEyFdF9IVCLxopngLk7uHzb1Y=;
        b=tBPOy1HBCJlrZajS4lLL9wfe38IWZoEwxAGA91BTcoVBmi6NqrOIhXXFx1OvZ/L28L
         01Ab20uW+GA+AwRzfTRILO2lOWJAMGO+nZ8GL6se6/V0i+WcmB9CqEzw7gRG6q+HfRJ6
         uwuG9yX2SehBCN/CKMMBx7c/P+2Z7LTHY5tARQWJe6qaih22vZaIg7gTtba4goHz2ldO
         u3laywUebUSXn2ln70yf9RFfjTHG0OWsEBK+jkOTI6kWsS+FhnrtmATjcLJDCULpjiap
         lA1FWGgo9Ma0Sw87CT0Nj/zvnlfm+Kdpm5eaoNIBb7fR7R0Qp71D+rwyZvg7qbZ05DYr
         Lxvw==
X-Gm-Message-State: AOJu0YxmV9GNl/j3/1BlrKv88A8XkLG4ckcmGq71Fj0mvsHzgkaRcbvF
	iCrCYo+W/f/YGrBvVaGyQ33mTQ8Tx9YPUrEZkb+AQqOAEqaKzqDVMdQSlkrka+M9PNGJ+uhPARq
	lTgmu3tveolxOoJPKJU2s8tShKKpPARoz
X-Received: by 2002:a17:907:88e:b0:9b2:b80d:da87 with SMTP id zt14-20020a170907088e00b009b2b80dda87mr4601104ejb.16.1698927029407;
        Thu, 02 Nov 2023 05:10:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEATtQiOlFzTOGhzy0swhCJpUIb/sUTEQBiEwaeEXPgC9LXCBs5EA6nfN6r2vIDmzVyu5JcVFzKjJ+d05SCuG4=
X-Received: by 2002:a17:907:88e:b0:9b2:b80d:da87 with SMTP id
 zt14-20020a170907088e00b009b2b80dda87mr4601085ejb.16.1698927029119; Thu, 02
 Nov 2023 05:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230923170540.1447301-1-lulu@redhat.com> <20231026024147-mutt-send-email-mst@kernel.org>
 <CACLfguXstNSC20x=acDx20CXU3UksURDY04Z89DM_sNbGeTELQ@mail.gmail.com> <20231102060151-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231102060151-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 2 Nov 2023 20:09:50 +0800
Message-ID: <CACLfguVDx8B1t0K6vOZ8JchGwVrSUGJ1P-ZLzxG0KK5S63OuHg@mail.gmail.com>
Subject: Re: [RFC 0/7] vdpa: Add support for iommufd
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 6:02=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Oct 26, 2023 at 02:48:07PM +0800, Cindy Lu wrote:
> > On Thu, Oct 26, 2023 at 2:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Sun, Sep 24, 2023 at 01:05:33AM +0800, Cindy Lu wrote:
> > > > Hi All
> > > > Really apologize for the delay, this is the draft RFC for
> > > > iommufd support for vdpa, This code provides the basic function
> > > > for iommufd support
> > > >
> > > > The code was tested and passed in device vdpa_sim_net
> > > > The qemu code is
> > > > https://gitlab.com/lulu6/gitlabqemutmp/-/tree/iommufdRFC
> > > > The kernel code is
> > > > https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC
> > > >
> > > > ToDo
> > > > 1. this code is out of date and needs to clean and rebase on the la=
test code
> > > > 2. this code has some workaround, I Skip the check for
> > > > iommu_group and CACHE_COHERENCY, also some misc issues like need to=
 add
> > > > mutex for iommfd operations
> > > > 3. only test in emulated device, other modes not tested yet
> > > >
> > > > After addressed these problems I will send out a new version for RF=
C. I will
> > > > provide the code in 3 weeks
> > >
> > > What's the status here?
> > >
> > Hi Michael
> > The code is finished, but I found some bug after adding the support for=
 ASID,
> > will post the new version after this bug is fixed, should be next week
> > Thanks
> > Cindy
>
> The week is almost gone, what's going on?
>
thanks, Micheal, I will send it out tomorrow
Thanks
Cindy
>
> > > --
> > > MST
> > >
>


