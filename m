Return-Path: <netdev+bounces-163994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73CAA2C40E
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19A7188DF28
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BCF1A9B48;
	Fri,  7 Feb 2025 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snWNcL0D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D52713BAE4;
	Fri,  7 Feb 2025 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935969; cv=none; b=HJoZKKcQJcKS7gTXM07xg5blb1an6/xmS7gkN6tYGp3I2A8IFD+8rgfon9wKQLsRfcAyR83y3cewWz+mK1FicZ6fJAXxqu3K9LK4X2JbtLC22UmpEtcjWe9mWxFCnHiUDVrJ5TzwPcptsYtmC/ZYAO7FdwfBQPMgQ4bjtY6mX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935969; c=relaxed/simple;
	bh=vki1oqGmK5esFUBsTHOMw5oPUVHzvomX1JXIFhNDcbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyMm3DyubFVapZ3+x+Y1NkSF1znwI2VTRBXn1l6w7jf96gp9mhR4a7Ccdq2f1iKYWhLZCcC56ku2gZWuERFBtjJFT7+s5l98Srm4u3Qe/XLrLzvAksO8P2TBQI9Gp3O5BH9oKXdp27HvPa+511pYFJ1bZnRCIamwYIR7T0gdkkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snWNcL0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9A8C4CED1;
	Fri,  7 Feb 2025 13:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738935969;
	bh=vki1oqGmK5esFUBsTHOMw5oPUVHzvomX1JXIFhNDcbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snWNcL0D+tAmQV/54UGHrSp8PE9Tw+wgdxa3XaofbaPPY8rkN/Af6Y+JJY6H0kGrB
	 sk6DLSLCs6I+hiU9czTS8zImRaoYSkHFarALZplo90j1BXSKXnB5OPdieV4iSRlrpQ
	 /1XL58Kyz+c8Czj3QGXAJCGRWV1OacnmxLoFhw73pJN/pbokDtAtY2CmTAkkO/ubGq
	 mTRcZj6lLdDknwQaQOkuKrpvNFpSIDDWK8vJ0hkdvmrMmCIfujJBlZEtGgqq5L4MrJ
	 8LlxIqPZLwuFQrwtEk3PVXoVg2lonHZjO8Xdlx46FgGBUMbdjkrewflSEuOfZvks/x
	 AM/w7loLFWglA==
Date: Fri, 7 Feb 2025 13:46:05 +0000
From: Simon Horman <horms@kernel.org>
To: alucerop@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Subject: Re: [PATCH v10 16/26] cxl: define a driver interface for DPA
 allocation
Message-ID: <20250207134605.GV554665@kernel.org>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-17-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205151950.25268-17-alucerop@amd.com>

On Wed, Feb 05, 2025 at 03:19:40PM +0000, alucerop@amd.com wrote:
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
> ---
>  drivers/cxl/core/hdm.c | 83 ++++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      |  4 ++
>  2 files changed, 87 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index af025da81fa2..cec2c7dcaf3a 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -3,6 +3,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> +#include <cxl/cxl.h>

Hi Alejandro,

I think that linux/range.h should be included in cxl.h, or if not here.
This is because on allmodconfigs for both arm and arm64 I see:

In file included from drivers/cxl/core/hdm.c:6:
./include/cxl/cxl.h:67:16: error: field has incomplete type 'struct range'
   67 |                 struct range range;
      |                              ^
./include/linux/memory_hotplug.h:247:8: note: forward declaration of 'struct range'
  247 | struct range arch_get_mappable_range(void);
      |        ^
1 error generated.

...

