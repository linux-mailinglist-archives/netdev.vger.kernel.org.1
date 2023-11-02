Return-Path: <netdev+bounces-45675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4099F7DEF5C
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 11:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2452819A7
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 10:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00151125BD;
	Thu,  2 Nov 2023 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPuluYLg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F7310977
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 10:02:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18835112
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 03:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698919329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HQZaCcbNvR/vRwvT++3FkZXUSfW2tFLkbmwPh6CE5mI=;
	b=TPuluYLg1B6RYighJ5sUG5s1TExDJ730Gfw/dKHyYhYM7SEqh/cVBJ5IodgJtCEx2iN91t
	0uk3XVbDao/xyHnxBk4gV7JbIqz6O9TNLvrZ7cMsxvxh+WGGl/gQyfHM1BiIO2QQwerFnV
	4qteCLo1P/VN1UE6Tv/P/08PliXmfT8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-acU4O9pzPsOaImFQfP7-Kw-1; Thu, 02 Nov 2023 06:02:07 -0400
X-MC-Unique: acU4O9pzPsOaImFQfP7-Kw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5079c865541so591671e87.3
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 03:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698919326; x=1699524126;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQZaCcbNvR/vRwvT++3FkZXUSfW2tFLkbmwPh6CE5mI=;
        b=Kw+g2obzOv3JiAyDWr/S8zDt3YH1EsKsabFDrefLmVIxl6xGGtJGTjXzdi9i2DCkxu
         VVsg86RjbD2ykO0N9IiCoVzoYy6eqWxmdtPDgFJMryfv41E9TeEq64Sxh6QeJC11zdqf
         p34b5eNk5EccPNyRRqHZrMkbkEIWVQo2NjhBO3bscWyt6+gmr+YrJ4LkCRGz57Yi1hYg
         LJYtB0mrmQF4Oix1buItOhyJmUA2wugjUgdt43AbnkoSaBraPXyliI2P3N6HkO6RdBf2
         8baMLEuuMF7S40a8CnOEpEexYFgZsTThoJbKwWcJRITGeu7a0DvOUdzp3UQe85/sl58J
         a5UQ==
X-Gm-Message-State: AOJu0Yw51RiZz+pfb62hleW1JxyETU8hbLPhsSSBmjOcwsOo8MP2Xo92
	dIp533Ot6U9q9QoBar5gnJuHC7QEWy36VGDnpTjGfZ9jXWteevqHDvL0bYfIGO+riGhv3oSXnxM
	p5r0VVNVJrJBEVsqV
X-Received: by 2002:ac2:47fa:0:b0:506:899d:1994 with SMTP id b26-20020ac247fa000000b00506899d1994mr12240663lfp.52.1698919326290;
        Thu, 02 Nov 2023 03:02:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgzRDP6IedPcxWzyU82zbL27uQuZvFZAmfFO8532rjHoXbxjyP/bbnF/jAQjaUjhe/+z5K+Q==
X-Received: by 2002:ac2:47fa:0:b0:506:899d:1994 with SMTP id b26-20020ac247fa000000b00506899d1994mr12240648lfp.52.1698919325964;
        Thu, 02 Nov 2023 03:02:05 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:efc3:a5be:5586:34a6:1108])
        by smtp.gmail.com with ESMTPSA id a16-20020adff7d0000000b0032dbf99bf4fsm1812242wrq.89.2023.11.02.03.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 03:02:05 -0700 (PDT)
Date: Thu, 2 Nov 2023 06:02:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC 0/7] vdpa: Add support for iommufd
Message-ID: <20231102060151-mutt-send-email-mst@kernel.org>
References: <20230923170540.1447301-1-lulu@redhat.com>
 <20231026024147-mutt-send-email-mst@kernel.org>
 <CACLfguXstNSC20x=acDx20CXU3UksURDY04Z89DM_sNbGeTELQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACLfguXstNSC20x=acDx20CXU3UksURDY04Z89DM_sNbGeTELQ@mail.gmail.com>

On Thu, Oct 26, 2023 at 02:48:07PM +0800, Cindy Lu wrote:
> On Thu, Oct 26, 2023 at 2:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Sun, Sep 24, 2023 at 01:05:33AM +0800, Cindy Lu wrote:
> > > Hi All
> > > Really apologize for the delay, this is the draft RFC for
> > > iommufd support for vdpa, This code provides the basic function
> > > for iommufd support
> > >
> > > The code was tested and passed in device vdpa_sim_net
> > > The qemu code is
> > > https://gitlab.com/lulu6/gitlabqemutmp/-/tree/iommufdRFC
> > > The kernel code is
> > > https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC
> > >
> > > ToDo
> > > 1. this code is out of date and needs to clean and rebase on the latest code
> > > 2. this code has some workaround, I Skip the check for
> > > iommu_group and CACHE_COHERENCY, also some misc issues like need to add
> > > mutex for iommfd operations
> > > 3. only test in emulated device, other modes not tested yet
> > >
> > > After addressed these problems I will send out a new version for RFC. I will
> > > provide the code in 3 weeks
> >
> > What's the status here?
> >
> Hi Michael
> The code is finished, but I found some bug after adding the support for ASID,
> will post the new version after this bug is fixed, should be next week
> Thanks
> Cindy

The week is almost gone, what's going on?


> > --
> > MST
> >


