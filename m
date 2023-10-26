Return-Path: <netdev+bounces-44399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275A77D7D0B
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 08:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D17D281D43
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 06:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52651749E;
	Thu, 26 Oct 2023 06:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmyCdkbu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A645F256C
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 06:49:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA691AC
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698302991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A819CxVjTt/0YD6znIYJAdPMk1RTWMLfMeumCnGtsqE=;
	b=OmyCdkbua8y30jIgexEf0BuNogXrHH3aUOIEwM2AIkr5t/a9W5ZnG1r8m9/yDsw2JPbh8W
	feBCc1dlRVRWblGguG7sv7UWEfe2RXz2cQglKwLZodzdvy9kgfQ8yo1FQ3NcVqLUAfqSX4
	F7meOy7LjAuESoDO6KKNtaNf7cDz8oU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-XUT67nOfOfKUJwQvLhnZKQ-1; Thu, 26 Oct 2023 02:49:49 -0400
X-MC-Unique: XUT67nOfOfKUJwQvLhnZKQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32da7983d20so349682f8f.1
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698302988; x=1698907788;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A819CxVjTt/0YD6znIYJAdPMk1RTWMLfMeumCnGtsqE=;
        b=PGF3C7WxeD4l1JRdJ4TKYYoMsOhXcLfdX7dOg2uGKb9V0tRThdbXWAH4FGslfCc+jv
         47kMaSbkCFr1CzHQJ+fYULC52S+HIxzKu+5ZdE4xrJN1SY1VWXtGmIVoCwBj6fETZyZF
         H6hLWra0LIwH4qrPcZsu8oH1sS+yUQ+RSqIBrnB80YgxO+kFAqPOh9yu2xVe+HZME1aY
         6a9DW6j+t5lRnUBex4NiiNNpV4yS2EPggS7WFXZ4GEQkhLAibOWj3AttbpKsjqTbMRWi
         KXKG3BwKBrjl6Cragtj86mKX9wBYq3WNv4haSa5H3nS5N4svJkjKUYH0OXeTDTg6pzyB
         EXEg==
X-Gm-Message-State: AOJu0YzBdaF2MUGxLgVNbOsfw1ct849DuOn5aP4yt9JO3NTqwipwCVwu
	1fYXo/5cK7SK8Exx+uncd0q3GDc4oykPW4CNqHcHxpujvGFp20k2NKAj4NkqsP72Aonhg2MvQFn
	PSeIkKMo1/T0DYjf7
X-Received: by 2002:a05:6000:984:b0:32d:bf1c:ce65 with SMTP id by4-20020a056000098400b0032dbf1cce65mr2167129wrb.22.1698302988582;
        Wed, 25 Oct 2023 23:49:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOBG562yOR6ZE/N4d6D22qdUaQb1WQ+r+ZpRNQxlAYrJb19NbalLrCC21XyEwKRApTNcdacA==
X-Received: by 2002:a05:6000:984:b0:32d:bf1c:ce65 with SMTP id by4-20020a056000098400b0032dbf1cce65mr2167108wrb.22.1698302988230;
        Wed, 25 Oct 2023 23:49:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:3c98:7fa5:a31:81ed:a5e2])
        by smtp.gmail.com with ESMTPSA id r4-20020adff704000000b0032d88e370basm13582521wrp.34.2023.10.25.23.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 23:49:47 -0700 (PDT)
Date: Thu, 26 Oct 2023 02:49:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC 0/7] vdpa: Add support for iommufd
Message-ID: <20231026024931-mutt-send-email-mst@kernel.org>
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


We'll miss this merge window then.

> > --
> > MST
> >


