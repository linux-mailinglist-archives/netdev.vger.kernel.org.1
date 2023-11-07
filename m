Return-Path: <netdev+bounces-46444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C92C7E4012
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 14:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31FEDB20B8F
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 13:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8796730CE8;
	Tue,  7 Nov 2023 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Du1cAgkx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032682D796
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 13:28:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FF592
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 05:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699363720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vfimE53Fve5aGuDWfThDIn9D2hKcZVuah28LMBgDfqs=;
	b=Du1cAgkx8o0qrdFCK8+flLbPBe7aIPLuzxWegqe05nCBzIJ1S6w1amwb1Y+WJSXtf8K4TX
	2Hl18/I5JPzCBly3VbrWpjtP1cb/9mSuAuZNfgLXdsTDTz4XGypRz5p4NZI5bfR4f7OjKF
	FEMHN/ITLc/qUo3HHjbFa5+YlFitM3o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-HHjEY4_JO3-71qqKNZBnYA-1; Tue, 07 Nov 2023 08:28:39 -0500
X-MC-Unique: HHjEY4_JO3-71qqKNZBnYA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4092164eceeso36046155e9.2
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 05:28:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699363717; x=1699968517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfimE53Fve5aGuDWfThDIn9D2hKcZVuah28LMBgDfqs=;
        b=e9SuqpIxtpBLWOU5O2ilpoubrQU6BxF9bYU9SsWWvDyAuHB2Le/qAVVO8T/v7rXL7O
         nF4Qb221dHbhtKPsEJMOSoCzmoX1fQfQvMut+gs376zTYPadSBNI94sn7djWYDCmWv1W
         H5ry3f4gF2M86LsVxrrL8bprelMQO9rMu663lo6gk4Y021apu/NnSBRFG++WnQC1M9Sv
         8TvhfRB+S7/oSCg/qGnfdjJq+OXGO9i5mELtxZte3uzkTJcRkgFh5vJfYqz/nzM3byMo
         NanjIf1A5zseKgk2wD9BwoZVSwipqcr2EbDpToFPoB4JFCcnc1k/21KYAXRVTf02iJQz
         C8ig==
X-Gm-Message-State: AOJu0Yx0+KRCpnewbvMJ2DYTGDsaf783fxoKNP+5q0xp9IZRthgPeENy
	ef8NDJUgv00QLD24YAcNFBxyaxjoxx0EhqKRzY6hwOHxK+rVLIBXOfbONo4btkkv6S0U2TzL8dP
	dmBBGReaXkt7O26bTbC33nb18
X-Received: by 2002:a05:600c:45cc:b0:405:75f0:fd31 with SMTP id s12-20020a05600c45cc00b0040575f0fd31mr2326525wmo.31.1699363717317;
        Tue, 07 Nov 2023 05:28:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtC5KDdpuy2FXN8TvtT5NUe+9K52kc66AxdSuH43yqMhhnPmYpxrxy7CAZjiRPuu1mZVAilg==
X-Received: by 2002:a05:600c:45cc:b0:405:75f0:fd31 with SMTP id s12-20020a05600c45cc00b0040575f0fd31mr2326504wmo.31.1699363716906;
        Tue, 07 Nov 2023 05:28:36 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f1:373a:140:63a8:a31c:ab2a])
        by smtp.gmail.com with ESMTPSA id g23-20020a7bc4d7000000b004063cd8105csm15206763wmk.22.2023.11.07.05.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:28:36 -0800 (PST)
Date: Tue, 7 Nov 2023 08:28:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, yi.l.liu@intel.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107082343-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231107022847-mutt-send-email-mst@kernel.org>
 <20231107124902.GJ4488@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107124902.GJ4488@nvidia.com>

On Tue, Nov 07, 2023 at 08:49:02AM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 07, 2023 at 02:30:34AM -0500, Michael S. Tsirkin wrote:
> > On Sat, Nov 04, 2023 at 01:16:33AM +0800, Cindy Lu wrote:
> > > 
> > > Hi All
> > > This code provides the iommufd support for vdpa device
> > > This code fixes the bugs from the last version and also add the asid support. rebase on kernel
> > > v6,6-rc3
> > > Test passed in the physical device (vp_vdpa), but  there are still some problems in the emulated device (vdpa_sim_net), 
> > 
> > What kind of problems? Understanding that will make it easier
> > to figure out whether this is worth reviewing.
> 
> IMHO, this patch series needs to spend more time internally to Red Hat
> before it is presented to the community. It is too far away from
> something worth reviewing at this point.
> 
> Jason

I am always trying to convince people to post RFCs early
instead of working for months behind closed doors only
to be told to rewrite everything in Rust.

Why does it have to be internal to a specific company?
I see Yi Liu from Intel is helping Cindy get it into shape
and that's classic open source ethos.

I know some subsystems ignore the RFC tag but I didn't realize
iommu is one of these. Is that really true?

-- 
MST


