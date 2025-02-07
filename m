Return-Path: <netdev+bounces-163977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC8AA2C372
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA2D37A553F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296871E98F4;
	Fri,  7 Feb 2025 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rw4kTpt1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F393E1448E0;
	Fri,  7 Feb 2025 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738934644; cv=none; b=dVxFSNMdvTGlbgI9g6QsZ642oruDIfj3bobl6xgh+wzLw1sfvuYA+v3SjjrmXVxyrV6PFAkQpdUF4jhH0ApohBTaQbH//FdYvrbiU6mvAOPR3IhZbyMZsvBH/Pa9d+uJU7UukkM1fXWftJLYm2I1cHMQQJxDqhC+KBi3y5hoHTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738934644; c=relaxed/simple;
	bh=pvBHIzpMFGVggBJELNXPy0i5kwkvMht4y9SKOGdc3BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nccBpfV4HSuu8HQgNgMhrvoMTUBi5fuLKfkfo9P3uZG10+RmayD4WQGnv5AP82hb/N71p6Ms8tr0/WLmnK9b8izBER2eAw7H3FJgrv7nW4ayxonqO+pyPCiIrBRB92VlVy4ouy9MHcGotHQuTQAjzZDsKGTGhg58Rg8xjSjTwpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rw4kTpt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B99C4CED1;
	Fri,  7 Feb 2025 13:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738934643;
	bh=pvBHIzpMFGVggBJELNXPy0i5kwkvMht4y9SKOGdc3BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rw4kTpt1tekZ8TNkYbm5HzowTm5bOJYiJ0g6UXjHkZCR94UL3do1qXYNe1Rz23Fz/
	 r6gxbcPsZuPa4yLfeNokkTviYfMH/prqGUtPwg0LHA8BZnyk4MbH/fB7zWw5oywapp
	 GkD5ulGtBi9IwQ+LJ3phxKT0aZfFWasBol1JKoCRLY2Fr5QAiYtSvkeNLrwkRYQRXr
	 Fl6YD22UMRgi8USCS/EOs7n5uJXLK+uuBuTlkQ0U8/pZkS0YaNkTusqouLa2l6DEDu
	 E5L0eM8IK+81T5dF++QnnJhITaIg0fztLDVREHsojOgcIcnyzknEeVo/Ezafz+Gm6h
	 PItmKql7Ec1yA==
Date: Fri, 7 Feb 2025 13:23:59 +0000
From: Simon Horman <horms@kernel.org>
To: alucerop@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Subject: Re: [PATCH v10 21/26] cxl: allow region creation by type2 drivers
Message-ID: <20250207132359.GT554665@kernel.org>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-22-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205151950.25268-22-alucerop@amd.com>

On Wed, Feb 05, 2025 at 03:19:45PM +0000, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Creating a CXL region requires userspace intervention through the cxl
> sysfs files. Type2 support should allow accelerator drivers to create
> such cxl region from kernel code.
> 
> Adding that functionality and integrating it with current support for
> memory expanders.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/region.c | 145 ++++++++++++++++++++++++++++++++++----
>  drivers/cxl/cxlmem.h      |   2 +
>  drivers/cxl/port.c        |   5 +-
>  include/cxl/cxl.h         |   4 ++
>  4 files changed, 141 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c

...

> +/**
> + * cxl_create_region - Establish a region given an endpoint decoder
> + * @cxlrd: root decoder to allocate HPA
> + * @cxled: endpoint decoder with reserved DPA capacity

nit: @ways: should be documented here too.

> + *
> + * Returns a fully formed region in the commit state and attached to the
> + * cxl_region driver.
> + */
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder *cxled, int ways)

...

