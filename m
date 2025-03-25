Return-Path: <netdev+bounces-177485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31336A704FA
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618351885CB8
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0083149C41;
	Tue, 25 Mar 2025 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9xjUrfY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A790581749;
	Tue, 25 Mar 2025 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916236; cv=none; b=ldnRvWQWd1yM2k4QGn88b7tXkcTo+u7m1ju2HU7Jyb9BWgxs3p69icJRiukCNIV4dkZ0s2z9IyHZgB2MKKBO9m/ukE3maPTO9KgYmJ9EfBZKEfNXPlNxH7m0MxtFDOkc7MPPusNLEE29p4/TcnqoZCosf4DPG7zHFKswV3rA/M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916236; c=relaxed/simple;
	bh=/exxyeix3TXgoxDMiFUprsNekll1tQICKKyQseLBw60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXRtLQElo/ghq9kdhFb52Ln0G4Dh66BaZ0LcvUgZEHpaE9rFbcb298/1Il2DsJQnsQ7Ci5j+XJEU2M70l/7upX0gVjruDsR4ENZVI+CRThPCkrxFfI0UbjlFctd5HOrStjQaPEXz8WLw3o+GehgjtH8PMP/wbgdFaYDx7DfKSmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9xjUrfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A78C4CEED;
	Tue, 25 Mar 2025 15:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742916236;
	bh=/exxyeix3TXgoxDMiFUprsNekll1tQICKKyQseLBw60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9xjUrfYpCJVEDuc6UqP+9nRxapQq4WXzi+6ATNwvT7zMa+aU3S9bHM9A+hWmOFz4
	 0dfpAYKNxz+kngK3PyNHVUJVysZmeVJHmlx+usRSa6Eui4BErhwvmkNpF2o4M/YFU/
	 bIT2qAf/35163FzT8Z18rkNY0B4aoLM/c8/ws/rPCgfruZrKQegvxja70bCHgDZOxA
	 O+/Smvh6SVHzPsHKtvay0iahBagbo85ukwd/36iN7741Na5y1Uh0kiogXNG1g2+bWD
	 9I000wcr1u44r2Eyi0xnhkNUKNz0/5awXlLf82rvWQbWtuS+zV6r0kkjCrvpd7IwEs
	 QPBaSs/G02DlQ==
Date: Tue, 25 Mar 2025 15:23:52 +0000
From: Simon Horman <horms@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Subject: Re: [PATCH v11 13/23] cxl: define a driver interface for DPA
 allocation
Message-ID: <20250325152352.GT892515@horms.kernel.org>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-14-alejandro.lucero-palau@amd.com>
 <20250320161847.GA892515@horms.kernel.org>
 <3af51327-7745-4b18-a478-f47c57683576@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3af51327-7745-4b18-a478-f47c57683576@amd.com>

On Mon, Mar 24, 2025 at 04:16:05PM +0000, Alejandro Lucero Palau wrote:
> 
> On 3/20/25 16:18, Simon Horman wrote:
> > On Mon, Mar 10, 2025 at 09:03:30PM +0000, alejandro.lucero-palau@amd.com wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > > 
> > > Region creation involves finding available DPA (device-physical-address)
> > > capacity to map into HPA (host-physical-address) space. Define an API,
> > > cxl_request_dpa(), that tries to allocate the DPA memory the driver
> > > requires to operate. The memory requested should not be bigger than the
> > > max available HPA obtained previously with cxl_get_hpa_freespace.
> > > 
> > > Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
> > > 
> > > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > Hi Alejandro,
> 
> 
> Hi Simon,
> 
> 
> > 
> > As reported by the Kernel Test Robot, in some circumstances this
> > patch fails to build.
> > 
> > I did not see this with x86_64 or arm64 allmodconfig.
> > But I did see the problem on ARM and was able to reproduce it (quickly)
> > like this using the toolchain here [*].
> > 
> > $ PATH=.../gcc-12.3.0-nolibc/arm-linux-gnueabi/bin:$PATH
> > 
> > $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make allmodconfig
> > $ echo CONFIG_GCC_PLUGINS=n >> .config
> > $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make oldconfig
> > 
> > $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make drivers/cxl/core/hdm.o
> > ...
> >    CC [M]  drivers/cxl/core/hdm.o
> > In file included from drivers/cxl/core/hdm.c:6:
> > ./include/cxl/cxl.h:150:22: error: field 'dpa_range' has incomplete type
> >    150 |         struct range dpa_range;
> >        |                      ^~~~~~~~~
> > ./include/cxl/cxl.h:221:30: error: field 'range' has incomplete type
> >    221 |                 struct range range;
> >        |
> > 
> > [*] https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/14.2.0/
> > 
> > ...
> 
> 
> Thanks for the references. I'll try it and figure out what is required.

Thanks,

I realised after posting that PATH above uses gcc-12.3 while the link
above is for gcc-14.2.0. Which is inconsistent. But in practice I tried both :)

...

