Return-Path: <netdev+bounces-44402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF997D7D46
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 09:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CA3C1C20DC4
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 07:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFBD11C84;
	Thu, 26 Oct 2023 07:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XB2MbzWw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4554B8BFD
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 07:04:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207D1D44
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 00:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698303848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4bmkXJMJqFq2y2BT9JWWBJPo9uIKV40dEB2MqEeCLgk=;
	b=XB2MbzWwrM96Qbx/tGevMFIot/OXsECSamjDvlIy/Sg1h7XWpnvkTytGCJC9npASLliMeG
	81sudTIKTSRdGTH3zP/kBNv/id2TvFPe7PyIDw/iwFnuo+qSBQeqvuapYBEqH2sJ5XKzbv
	F7t0Q4m+K54MFblHbIPsI2Rif7PZeNY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-vjkXqgsJMSOmabObRl2m6g-1; Thu, 26 Oct 2023 03:04:05 -0400
X-MC-Unique: vjkXqgsJMSOmabObRl2m6g-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-521da4c99d4so398364a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 00:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698303844; x=1698908644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bmkXJMJqFq2y2BT9JWWBJPo9uIKV40dEB2MqEeCLgk=;
        b=HIC17LeN2XIWkfbwk/iGcxsrhn/+McPii6fTFJ2u4dcXBcUCCPiHX9dgszgRgeiPjO
         ssv2uusVVqYFsJ8CIYptGKUw2lW4T923JVEHOINzlb9J0ax1d5hqRxTC+AG42OAtu85M
         U/uL5UKzFhb1Jd9HG77t++aS2VEt1daaNGGOTd6X0v4O7l+bvY/27LuWWyz9kfSswZr3
         l3Xx5XUucaaqC1+vIR8yxWKfmyOy4D+DyyQinqSuOw3AM1oQ2oJjjRybT7/eQJ9QDGyb
         eaMvviXC5u2hfJxDLmMyHhCkpOFdblg5R3dhJIl63i51hs1m8AKCcv6hmCYC1B/QgbLU
         3/SQ==
X-Gm-Message-State: AOJu0YyRV/XaANAGdm0ZuS4kXCRoa8peLpzuGlqvmYvheRnsO1R3DBXr
	syJdR9Ct/7MXKrnQI7Hp7TDE9YGtqtc25o+8SimHwbkiQjtyEYrUW6tIPtPaov+rABzoU3eKNc9
	pvv0/avFWCefmJM5olLzLkwNQw1POKzj2
X-Received: by 2002:a50:f616:0:b0:53e:bb41:7506 with SMTP id c22-20020a50f616000000b0053ebb417506mr1055717edn.33.1698303844622;
        Thu, 26 Oct 2023 00:04:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/hIUnsMuQLJWc0lCUDVWC3du0OmX4Ephe8O1KYUpUHk8vCjeZyT+gihr9WwOm7WNgtppvDgI7lbQpKLePO4s=
X-Received: by 2002:a50:f616:0:b0:53e:bb41:7506 with SMTP id
 c22-20020a50f616000000b0053ebb417506mr1055699edn.33.1698303844262; Thu, 26
 Oct 2023 00:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230923170540.1447301-1-lulu@redhat.com> <20231026024147-mutt-send-email-mst@kernel.org>
 <CACLfguXstNSC20x=acDx20CXU3UksURDY04Z89DM_sNbGeTELQ@mail.gmail.com> <20231026024931-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231026024931-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 26 Oct 2023 15:03:25 +0800
Message-ID: <CACLfguXkhyNc-idDSsE9jEAySVO0xBqaaq7bPDQras+CCPhdgw@mail.gmail.com>
Subject: Re: [RFC 0/7] vdpa: Add support for iommufd
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 2:49=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
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
>
> We'll miss this merge window then.
>
thanks Micheal=EF=BC=8C I will try my best. will post the new version as so=
on as I can
Thanks
Cindy
> > > --
> > > MST
> > >
>


