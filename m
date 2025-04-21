Return-Path: <netdev+bounces-184359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 426CDA94FAB
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 12:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785A2170FDB
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 10:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF57225DAF6;
	Mon, 21 Apr 2025 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Am40bPKs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABC721D596
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745233114; cv=none; b=j5A+axfomV686NGm7thn9jSNtjVm2S9phTKi0hMOImLtXV9toB8KEBVUbstQeNrcxkk7fOQKIXrWmUA1WTodf2mbbcMNbtpcf+VNnMXtwepllEUHbkYGSQ+h/l82PyCrfoABvdcpGnqRi7c9pTIfbf9TScZloBe1XnnNvOyU7Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745233114; c=relaxed/simple;
	bh=o3qSXBKHoFNb19EBZyzvNZY5zIc0ddO/T2NkzS6psQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oq1/i5/y5x5TZl1itR8A3qZOqdKG+FxOsgD/Nsf8Fz2giDCU4RhUwZ63pcUNlYiVNdEtaFTMGisnzFSdy0skp7p2LWj4ZPolHXdl071V8Qn8ZuQ7806cX5hggnPh5ThLDuJE+B1wqsKCRkAa8654epMry0NNMiBlpltZSQKV3qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Am40bPKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583D8C4CEE4;
	Mon, 21 Apr 2025 10:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745233114;
	bh=o3qSXBKHoFNb19EBZyzvNZY5zIc0ddO/T2NkzS6psQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Am40bPKs8Tqzv0i9cmf3PdcA1uz/65iaEFe1vnpktfcuQQMdBcX2JN6rwNX9wA92a
	 jkSTSXGiAS2UnUKMFkCHRpamaQ7HTuaT2JrnZeyEqkCVtNRExVtAXhppS/XFSg0t0w
	 9uHIaggtILfAgzwqZAXi/8ntrq+VRodLMnEriXGiwmzozn/LZTaVPR2KsEUMNz+iJ7
	 NtSlm/VMUJxa60L/joZpL6utN8TovK4JPgOnXkWoyhCiByjUoUUHLMegVmlTuft8L5
	 rvYDOwzEF3QcdmBg09JuIynlRYM79Dphb+jZHUMfTJ4r3ivLJGlcf/65fMwtH2Ejui
	 W5+r4au10vf+g==
Date: Mon, 21 Apr 2025 11:58:30 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	aleksander.lobakin@intel.com, przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com, aleksandr.loktionov@intel.com,
	jedrzej.jagielski@intel.com, larysa.zaremba@intel.com,
	anthony.l.nguyen@intel.com
Subject: Re: [iwl-next v2 1/8] ice, libie: move generic adminq descriptors to
 lib
Message-ID: <20250421105830.GD2789685@horms.kernel.org>
References: <20250410100121.2353754-1-michal.swiatkowski@linux.intel.com>
 <20250410100121.2353754-2-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410100121.2353754-2-michal.swiatkowski@linux.intel.com>

On Thu, Apr 10, 2025 at 12:01:14PM +0200, Michal Swiatkowski wrote:
> The descriptor structure is the same in ice, ixgbe and i40e. Move it to
> common libie header to use it across different driver.
> 
> Leave device specific adminq commands in separate folders. This lead to
> a change that need to be done in filling/getting descriptor:
> - previous: struct specific_desc *cmd;
> 	    cmd = &desc.params.specific_desc;
> - now: struct specific_desc *cmd;
>        cmd = libie_aq_raw(&desc);
> 
> Do this changes across the driver to allow clean build. The casting only
> have to be done in case of specific descriptors, for generic one union
> can still be used.
> 
> Changes beside code moving:
> - change ICE_ prefix to LIBIE_ prefix (ice_ and libie_ too)
> - remove shift variables not otherwise needed (in libie_aq_flags)
> - fill/get descriptor data based on desc.params.raw whenever the
>   descriptor isn't defined in libie
> - move defines from the libie_aq_sth structure outside
> - add libie_aq_raw helper and use it instead of explicit casting
> 
> Reviewed by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

...

> diff --git a/include/linux/net/intel/libie/adminq.h b/include/linux/net/intel/libie/adminq.h
> new file mode 100644
> index 000000000000..568980ddf4c1
> --- /dev/null
> +++ b/include/linux/net/intel/libie/adminq.h
> @@ -0,0 +1,269 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#ifndef __LIBIE_ADMINQ_H
> +#define __LIBIE_ADMINQ_H
> +
> +#include <linux/build_bug.h>
> +#include <linux/types.h>
> +
> +#define LIBIE_CHECK_STRUCT_LEN(n, X)	\
> +	static_assert((n) == sizeof(struct X))
> +
> +/**
> + * struct libie_aqc_generic - Generic structure used in adminq communication
> + * @param: generic parameter
> + * @addr: generic address

nit: The struct members documented above do not match those present below.

> + */
> +struct libie_aqc_generic {
> +	__le32 param0;
> +	__le32 param1;
> +	__le32 addr_high;
> +	__le32 addr_low;
> +};
> +LIBIE_CHECK_STRUCT_LEN(16, libie_aqc_generic);

...

