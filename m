Return-Path: <netdev+bounces-116137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 774AD9493E4
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EBE1F2822A
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECB51D54C1;
	Tue,  6 Aug 2024 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDZXQJSI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3FC41C72
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722956135; cv=none; b=KUh1xk3IvvGuuwQeoeL8eTITDH1dgrvAZ1UhS+NlUxuLWwwqIZAXvmOwDbWeJR9PX7f40SD2koc2710yajyyr1Av/4e5l1GgD4gzuE62+MOdrgjXpDQHNpjFkufCT3Y6YNn84ZufDEwWuvEsSWmJrKPLgxyvLWFwLhtcNqHYc5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722956135; c=relaxed/simple;
	bh=cfLjLzytKWxZNDBT4m7gnseD/sS6bz7gYmCdZFohyLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWf3BOBM81RM53SpHMTdw4LncHukDccCNuLRdIarbpU4Dx+B80FYa7VH/QDngVdStZwwhTaM55Gc57h9DbLByFOHVi8fJ+L4JewT/inG98ksdw6xE1SkejoWpOMxjT5QGT+jziSydGKY6fh6GDCosFQp8Tv/oD+gmKSCvZvaJdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDZXQJSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFD0C32786;
	Tue,  6 Aug 2024 14:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722956135;
	bh=cfLjLzytKWxZNDBT4m7gnseD/sS6bz7gYmCdZFohyLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDZXQJSIGYVVpwQTZ6eVZDsGpKSOMYlMv8/2gUBTk+A7FVbFNoXJI5a4ZMaIW+HzQ
	 8Q3yZ/NxSuzxPma+I52OsJgvGn1qveWUa5rhMoPWyOOKCgMckGlYKNBl9cDCPy6UCS
	 4/K/dxOXj/yf4EMSNhfQa6mcVUI1UqVdfyOvr+dGoIED7XNPvHJUmeZvLg+PKTJyAx
	 VmMDNPW1+bfXm5z1BLFkgefSYhh54Sj2/I0H4qnMSgxoMQhcSyHQnBqLYNvO4oXXAq
	 xDDasvEzggZxCf0f6WhXYhY+vUzDXgONZnL/6va4jhQ2BIN3wQwNA4GxPHFIJOF7er
	 HGXlfNEkCDOTg==
Date: Tue, 6 Aug 2024 15:55:31 +0100
From: Simon Horman <horms@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-next v2] ice: Implement ethtool reset support
Message-ID: <20240806145531.GW2636630@kernel.org>
References: <20240805124651.125761-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805124651.125761-1-wojciech.drewek@intel.com>

On Mon, Aug 05, 2024 at 02:46:51PM +0200, Wojciech Drewek wrote:
> Enable ethtool reset support. Ethtool reset flags are mapped to the
> E810 reset type:
> PF reset:
>   $ ethtool --reset <ethX> irq dma filter offload
> CORE reset:
>   $ ethtool --reset <ethX> irq-shared dma-shared filter-shared \
>     offload-shared ram-shared
> GLOBAL reset:
>   $ ethtool --reset <ethX> irq-shared dma-shared filter-shared \
>     offload-shared mac-shared phy-shared ram-shared
> 
> Calling the same set of flags as in PF reset case on port representor
> triggers VF reset.
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
>  .../device_drivers/ethernet/intel/ice.rst     | 28 +++++++
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 77 +++++++++++++++++++
>  2 files changed, 105 insertions(+)
> 
> diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice.rst b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
> index 934752f675ba..c043164bfacc 100644
> --- a/Documentation/networking/device_drivers/ethernet/intel/ice.rst
> +++ b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
> @@ -102,6 +102,34 @@ rx_bytes as "X", then ethtool (hardware statistics) will display rx_bytes as
>  "X+40" (4 bytes CRC x 10 packets).
>  
>  
> +ethtool reset
> +-------------
> +The driver supports 3 types of resets:
> +- PF reset - resets only components associated with the given PF, does not
> +  impact other PFs
> +- CORE reset - whole adapter is affected, reset all PFs
> +- GLOBAL reset - same as CORE but mac and phy components are also reinitialized

Hi Wojciech,

I'm not sure, but I think that Sphinx wants blank likes between these list
items.

Flagged by make: htmldocs SPHINXDIRS=networking

...

