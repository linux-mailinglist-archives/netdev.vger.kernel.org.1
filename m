Return-Path: <netdev+bounces-163967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2051CA2C330
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B154188BCD5
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC221E0DE5;
	Fri,  7 Feb 2025 13:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcFEnB42"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329BB1D63D6;
	Fri,  7 Feb 2025 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738933427; cv=none; b=ni2bp1mqf4VqM7uksLGCSsoNNYhP0pB2yTTmKfJMX9gJEmIIxi8iuGfVfsP9MUvsha4BwqauzyWMW3g3GfR188pxjXJvsNTC+Gg8MT+dVSL+BFpftFW3VXH+QjFfqmYooNwCLD083V5YqbOMPi2snrfE9f3eXqQblveue4EcFvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738933427; c=relaxed/simple;
	bh=Ge71FYL2GxX0fWNuNn/Fft2bQdnWJ71P5qdP6gV5SYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJ5CePNa+/vyjC0+40e/gCQPgAzHK9c7EGG8AiZDafHWQ0K5BBIWn9hVtZjoTHnq+fGdXg6K6Hk7eDKsh6pD4obyhZBjGzUIKpSheOvhCjW65PB6d0aK8qacZ6guOjYKxILG8dm79uNl5jhC0ZAEhY8uIaJ9pG7ttMk3KcFKKQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcFEnB42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F49BC4CED1;
	Fri,  7 Feb 2025 13:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738933426;
	bh=Ge71FYL2GxX0fWNuNn/Fft2bQdnWJ71P5qdP6gV5SYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CcFEnB42ximi0lRosDYVFzLu1WwYULG5V0ke7KdfA2vjf1QBIlf1s1AaelQCjVrwg
	 Vcb4LXUPEa8bR+lZNv/HCjtvxH9fSkBepF/UmRGWiWC2Acnn7S4rJPqCazUD5PkSnF
	 ybqeRT8ruM7Ej5QWEv2P3Bzb9m/2bzvwcfoQe7BRgsia4WWGM2NWMlMHw8nK4nQavu
	 ki1W3UDbFs+waHdWGJAGbhbCtWo6xCuSIMCsBdm1DctbKQzdL1fXE5U82w5t9oEXw/
	 rLzEhPgPPjCVvHb44AXydjwcQHa2zsh9zqH4CSxbwEPZfkZKsANGbXPiiM40+uX4ne
	 2U0HKR46BJvQg==
Date: Fri, 7 Feb 2025 13:03:42 +0000
From: Simon Horman <horms@kernel.org>
To: alucerop@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Subject: Re: [PATCH v10 02/26] sfc: add basic cxl initialization
Message-ID: <20250207130342.GS554665@kernel.org>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-3-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205151950.25268-3-alucerop@amd.com>

On Wed, Feb 05, 2025 at 03:19:26PM +0000, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create a cxl_memdev_state with CXL_DEVTYPE_DEVMEM, aka CXL Type2 memory
> device.
> 
> Make sfc CXL initialization dependent on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/Kconfig      |  5 +++
>  drivers/net/ethernet/sfc/Makefile     |  1 +
>  drivers/net/ethernet/sfc/efx.c        | 16 ++++++-
>  drivers/net/ethernet/sfc/efx_cxl.c    | 60 +++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    | 40 ++++++++++++++++++
>  drivers/net/ethernet/sfc/net_driver.h | 10 +++++
>  6 files changed, 131 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
> 
> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
> index 3eb55dcfa8a6..0ce4a9cd5590 100644
> --- a/drivers/net/ethernet/sfc/Kconfig
> +++ b/drivers/net/ethernet/sfc/Kconfig
> @@ -65,6 +65,11 @@ config SFC_MCDI_LOGGING
>  	  Driver-Interface) commands and responses, allowing debugging of
>  	  driver/firmware interaction.  The tracing is actually enabled by
>  	  a sysfs file 'mcdi_logging' under the PCI device.
> +config SFC_CXL
> +	bool "Solarflare SFC9100-family CXL support"
> +	depends on SFC && CXL_BUS && !(SFC=y && CXL_BUS=m)
> +	depends on CXL_BUS >= CXL_BUS

Hi Alejandro,

I'm confused by the intent of the line above.
Could you clarify?

> +	default SFC
>  
>  source "drivers/net/ethernet/sfc/falcon/Kconfig"
>  source "drivers/net/ethernet/sfc/siena/Kconfig"

...

