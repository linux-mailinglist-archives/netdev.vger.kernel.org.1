Return-Path: <netdev+bounces-176529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B2CA6AAE5
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595DB7A66BA
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87E01E2853;
	Thu, 20 Mar 2025 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXIRXZBC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD1017B402;
	Thu, 20 Mar 2025 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487532; cv=none; b=TRJdAHOKyVszYna9ZUyLbqAwphV14BsWcTJIszvBMpspYxdB7inudAIhAok/HjiRm5HRP2DL4izbOx+DHHWygJBI3OwvEBHEBmMS/yza5WEAWtiEDAkHvlOskqzwl37plam4uHuKgH9uVl/L3VRaO68I+SxYXsxbtvVDZWCAnJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487532; c=relaxed/simple;
	bh=43aNJV5MNYzkazpkxcqLf53/KEplAMSqtRgL10jyR/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf8Uz9z6zn6jJT4JPvyTF80czGabfSY/WtrN5W7wVHGiEx5CPXIf2z68QUchoAUOnssSW3XAl0Hae+eX9jh30tLRHxWjpL04948SfiJuwnIYa33DWHSlhaRMs7M6nTJeKNKvU8t/338HuROkQ7ax8Ey+hv8eSrRcRoK4ZvoyOTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXIRXZBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC33C4CEDD;
	Thu, 20 Mar 2025 16:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742487532;
	bh=43aNJV5MNYzkazpkxcqLf53/KEplAMSqtRgL10jyR/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LXIRXZBCbBuGyYIxC94ZF/bs+SebcH+9vtYa/MoyGQi+oKCff8fNOeFxO7u9aRHQF
	 /7Lva1Z2iOA2pRk5ZE77emUC03Lsg9fwN8nuUT8/vCB43AztdX7q8ruoYoOTC3wuxO
	 ZrPhCA6t/i+32O2NDSSSZJLVN6kcfmVQmFmu7q40HWCo0BYVg9nIA7eyB3hdOwh3tr
	 pXboDyyUK4UKe1mx2yDH2OBJCPp4nqqPmPVOQr3UHbogeB9Kv1rCuixxVa/GN5+rbz
	 r2XJB8Ky3Luwrsca/AEfwY3LSi4XxQnyUEx31QhFn/kFK1C/PMm/abBHX6sPC9EuY9
	 VJLrYgrbyq0/A==
Date: Thu, 20 Mar 2025 16:18:47 +0000
From: Simon Horman <horms@kernel.org>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v11 13/23] cxl: define a driver interface for DPA
 allocation
Message-ID: <20250320161847.GA892515@horms.kernel.org>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-14-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310210340.3234884-14-alejandro.lucero-palau@amd.com>

On Mon, Mar 10, 2025 at 09:03:30PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation involves finding available DPA (device-physical-address)
> capacity to map into HPA (host-physical-address) space. Define an API,
> cxl_request_dpa(), that tries to allocate the DPA memory the driver
> requires to operate. The memory requested should not be bigger than the
> max available HPA obtained previously with cxl_get_hpa_freespace.
> 
> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Hi Alejandro,

As reported by the Kernel Test Robot, in some circumstances this
patch fails to build.

I did not see this with x86_64 or arm64 allmodconfig.
But I did see the problem on ARM and was able to reproduce it (quickly)
like this using the toolchain here [*].

$ PATH=.../gcc-12.3.0-nolibc/arm-linux-gnueabi/bin:$PATH

$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make allmodconfig
$ echo CONFIG_GCC_PLUGINS=n >> .config
$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make oldconfig

$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make drivers/cxl/core/hdm.o
...
  CC [M]  drivers/cxl/core/hdm.o
In file included from drivers/cxl/core/hdm.c:6:
./include/cxl/cxl.h:150:22: error: field 'dpa_range' has incomplete type
  150 |         struct range dpa_range;
      |                      ^~~~~~~~~
./include/cxl/cxl.h:221:30: error: field 'range' has incomplete type
  221 |                 struct range range;
      | 

[*] https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/14.2.0/

...

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c

...

> +/**
> + * cxl_request_dpa - search and reserve DPA given input constraints
> + * @cxlmd: memdev with an endpoint port with available decoders
> + * @is_ram: DPA operation mode (ram vs pmem)
> + * @min: the minimum amount of capacity the call needs

nit: @alloc should be documented instead of @min

> + *
> + * Given that a region needs to allocate from limited HPA capacity it
> + * may be the case that a device has more mappable DPA capacity than
> + * available HPA. So, the expectation is that @min is a driver known
> + * value for how much capacity is needed, and @max is the limit of
> + * how much HPA space is available for a new region.
> + *
> + * Returns a pinned cxl_decoder with at least @min bytes of capacity
> + * reserved, or an error pointer. The caller is also expected to own the
> + * lifetime of the memdev registration associated with the endpoint to
> + * pin the decoder registered as well.
> + */
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
> +					     bool is_ram,
> +					     resource_size_t alloc)

...

