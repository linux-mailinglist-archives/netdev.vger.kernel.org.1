Return-Path: <netdev+bounces-46361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CA57E3602
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 08:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27D7FB20B51
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 07:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D91F947A;
	Tue,  7 Nov 2023 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVUuW580"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC97CA56
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 07:41:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA64FC
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 23:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699342872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/lx1rypKszE80C3svlF1BPeyS2bMagooOeOTmeIu3k=;
	b=IVUuW5804zR2ByxGjv/zRqZrUm5Vys9I3jS7wCzXcueRtfE1IjhSAHV6vAvANho5uUqYTU
	bHW8EaJ1kM0AGj3OwR2n8IXGIn0Dn0oH1m5UWGhgOGiEwcFDUdgBv6657gZuEJHebKtxoO
	iucUhfP8V6OnVamlw3liL8SdPYG6obs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-2vMTbDIIOKCm6ODqJLb7DA-1; Tue, 07 Nov 2023 02:30:40 -0500
X-MC-Unique: 2vMTbDIIOKCm6ODqJLb7DA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40837aa4a58so34922675e9.0
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 23:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699342239; x=1699947039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/lx1rypKszE80C3svlF1BPeyS2bMagooOeOTmeIu3k=;
        b=GCDYAt2ZeHPa1DAQ9gzjB4w/2vHM41NT9TrHNxe2KiNRypN/fVdXsuq/9QWKWTKjCK
         aUHuvbgErbm4r1FLa4gru4LqO97MhLBjXw+xmzIiim6/IoFqKFHXhvYvTjDGZUXMmg3d
         6vhYANpg0LUBgfBCPVkNMccgiRnk2lS+/sWZy0w3Ha9UYC+flTreU6BgiIcTAXdFhWcj
         IkC8Nc4KKLs87bwsg6UFHdUExtbONMyQmj2Ocgs6gu1Kqg5zonJMA8+5HYqPEvMMwXpp
         qqtsPc5hg+KUOXQdcTxDZZFE5NLGVBwxuWR0WCvVPKuY7dzVMr8uAledBaJitHWUA0bE
         Kh9A==
X-Gm-Message-State: AOJu0Yz5Su15xZG45FlfVJEzMMWB9fmwjAow630wPwN4mqU490crJkqi
	7G4VellXP8DUj25JZpybj1jHrwTcSxaujlLEOw7t7jftnMr402alp2B2CbX5iaiFQqgEejBP2c/
	uop+Ry45UJFrZ7EMz
X-Received: by 2002:a05:600c:1c06:b0:405:3ab3:e640 with SMTP id j6-20020a05600c1c0600b004053ab3e640mr1563991wms.20.1699342239044;
        Mon, 06 Nov 2023 23:30:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKOvrGmXKbiJ4vIeoxB/aU3PS4p7CWdE7g1MzeenXV0fuHrqF0EyczH4kRYvPFqPW5dbKFQg==
X-Received: by 2002:a05:600c:1c06:b0:405:3ab3:e640 with SMTP id j6-20020a05600c1c0600b004053ab3e640mr1563976wms.20.1699342238687;
        Mon, 06 Nov 2023 23:30:38 -0800 (PST)
Received: from redhat.com ([2.55.5.143])
        by smtp.gmail.com with ESMTPSA id e12-20020adffd0c000000b0032d893d8dc8sm1555331wrr.2.2023.11.06.23.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 23:30:38 -0800 (PST)
Date: Tue, 7 Nov 2023 02:30:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107022847-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103171641.1703146-1-lulu@redhat.com>

On Sat, Nov 04, 2023 at 01:16:33AM +0800, Cindy Lu wrote:
> 
> Hi All
> This code provides the iommufd support for vdpa device
> This code fixes the bugs from the last version and also add the asid support. rebase on kernel
> v6,6-rc3
> Test passed in the physical device (vp_vdpa), but  there are still some problems in the emulated device (vdpa_sim_net), 

What kind of problems? Understanding that will make it easier
to figure out whether this is worth reviewing.

> I will continue working on it
> 
> The kernel code is
> https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC_v1
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Please also Cc iommufd maintainers:

Jason Gunthorpe <jgg@ziepe.ca> (maintainer:IOMMUFD)
Kevin Tian <kevin.tian@intel.com> (maintainer:IOMMUFD)
Joerg Roedel <joro@8bytes.org> (maintainer:IOMMU SUBSYSTEM)
Will Deacon <will@kernel.org> (maintainer:IOMMU SUBSYSTEM)
Robin Murphy <robin.murphy@arm.com> (reviewer:IOMMU SUBSYSTEM)
iommu@lists.linux.dev (open list:IOMMUFD)
linux-kernel@vger.kernel.org (open list)

-- 
MST


