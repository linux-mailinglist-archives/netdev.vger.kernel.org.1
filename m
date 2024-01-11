Return-Path: <netdev+bounces-62990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4F782AA5C
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 10:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A165BB2465A
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 09:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E772BFC01;
	Thu, 11 Jan 2024 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2/SKDGA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781A1168AC
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704963789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fiVGhyMQqpemmt2172xI1+ogtFZA6yGakCsHppFUzcE=;
	b=b2/SKDGA6xPEdQiosC5UBe1Azh2hBQURDvtzGDPszeOgqtIrHkcp8z/Uu0Kyj1F4iEetOO
	xe+pRhUfjAugCNQ279ijqF8VC/2Av7rP914tr1RO3AuaqwEihlb+MPXGrHjPzwZe5PyeRY
	HHPXNZOW/iGCseVBluEWELqb0KherNE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-C5dnWat8PtWKjuRCuk0nPg-1; Thu, 11 Jan 2024 04:03:07 -0500
X-MC-Unique: C5dnWat8PtWKjuRCuk0nPg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a2b699cadb7so127151066b.2
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 01:03:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704963786; x=1705568586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiVGhyMQqpemmt2172xI1+ogtFZA6yGakCsHppFUzcE=;
        b=J+3ewMIc8tpJKU5E9vj2uG0iO4frtVjy4nTGU98b8Q7SugSB93xBK6bibyIM0/i1p1
         wsxwylgWuV7IBR5aEpgn6IRCLhygJon+n/+d9Nx6kNsgrzqBlW6sp3n7MWSvVTLmKORQ
         oGP4OmQMA5PKihG84ii0huYMoYEO46flgq8bB/w6EM3Nl+/NakUwk4RRqOk1FTBHwNn0
         0mM17GwmrCVE0Kf5h8movLHxO7Q92EUvZh1eZNAFh6F3ecnmmM5BKWO4fUQ2Dbs8xhzR
         sW9/nqVedLTgDzvb19VJVxevvQ106czybupEf7NckehQKR0IyvgGliCbTVkeyhaC811z
         TVzw==
X-Gm-Message-State: AOJu0YxRQeOtvZ0pefggZRWAX1Dng2FGPzWO9K5vWkTcv5t0ahS6/g4U
	SjJ3VjRDofMimjdaRztXHaC0lK3zW3RcU7jg0UKr7XmCKj3RaM4t5BgjY6o5AlPR1OifC+4aBh2
	Nvj9ncUti8sZJj/GD+zEVxDZNVSmW7mSooMvNeHbP
X-Received: by 2002:a17:906:3542:b0:a29:40fe:254d with SMTP id s2-20020a170906354200b00a2940fe254dmr364317eja.69.1704963786583;
        Thu, 11 Jan 2024 01:03:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK7Ui4uGInFgVXo+NZqkjdPTK8VVW9Bqv6J5hojrs+GmhQPMTzNaI+7+HiAGH04fzV7CRFN3n0SvAxRkyMRTk=
X-Received: by 2002:a17:906:3542:b0:a29:40fe:254d with SMTP id
 s2-20020a170906354200b00a2940fe254dmr364310eja.69.1704963786312; Thu, 11 Jan
 2024 01:03:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20240110172459-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240110172459-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 11 Jan 2024 17:02:27 +0800
Message-ID: <CACLfguVpiJY2h9MXEfJBEtaEeqaRnScp3X-SoAn7anPjqi9WiQ@mail.gmail.com>
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 6:25=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sat, Nov 04, 2023 at 01:16:33AM +0800, Cindy Lu wrote:
> >
> > Hi All
> > This code provides the iommufd support for vdpa device
> > This code fixes the bugs from the last version and also add the asid su=
pport. rebase on kernel
> > v6,6-rc3
> > Test passed in the physical device (vp_vdpa), but  there are still some=
 problems in the emulated device (vdpa_sim_net),
> > I will continue working on it
> >
> > The kernel code is
> > https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC_v1
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> Was this abandoned?
>
Thanks Micheal. I'm really sorry for the delay. I will continue working on =
this
Thanks
Cindy
> >
> > Cindy Lu (8):
> >   vhost/iommufd: Add the functions support iommufd
> >   Kconfig: Add the new file vhost/iommufd
> >   vhost: Add 3 new uapi to support iommufd
> >   vdpa: Add new vdpa_config_ops to support iommufd
> >   vdpa_sim :Add support for iommufd
> >   vdpa: change the map/unmap process to support iommufd
> >   vp_vdpa::Add support for iommufd
> >   iommu: expose the function iommu_device_use_default_domain
> >
> >  drivers/iommu/iommu.c             |   2 +
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c  |   8 ++
> >  drivers/vdpa/virtio_pci/vp_vdpa.c |   4 +
> >  drivers/vhost/Kconfig             |   1 +
> >  drivers/vhost/Makefile            |   1 +
> >  drivers/vhost/iommufd.c           | 178 +++++++++++++++++++++++++
> >  drivers/vhost/vdpa.c              | 210 +++++++++++++++++++++++++++++-
> >  drivers/vhost/vhost.h             |  21 +++
> >  include/linux/vdpa.h              |  38 +++++-
> >  include/uapi/linux/vhost.h        |  66 ++++++++++
> >  10 files changed, 525 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/vhost/iommufd.c
> >
> > --
> > 2.34.3
>


