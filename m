Return-Path: <netdev+bounces-243913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A41A8CAA8F0
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 16:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8761307CA1D
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 15:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7499E284693;
	Sat,  6 Dec 2025 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVfI4zv2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4FB25B1DA;
	Sat,  6 Dec 2025 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765033651; cv=none; b=k9184d9UcvAhmejTKYAjMCVRtIHP1hkbPlqFfk5c0SsH0NtJS7PYWoBTCbt3sYU/Rf3zZ849YwuWT6gDFXPqo5W8DPJLLFtx2Muq9I2GKypxmEnU0ggwwHVK/YT2+k1n+Fi4mN1ZaSfGXHhZ3zVwZykPnTbTZhRgHwzu9jkNI5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765033651; c=relaxed/simple;
	bh=efblxE7xjpWtBxnjSUVxVtm7YsEPsH4q6kw9ZHyIPm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8uSZjhot/HAE8irnR3e5cjpQ80gGDbG6xQUC0kpxhp8JDuKtz02CA1wqfGjYaUE4wmjEwDXieTRSP2e/H8TTtxEYxww0AEureg6F4Xw8NSpYBtq2AZhG+7/vmd3j9iI4wqx88KNcDc8RMY00UwYFHFGpq8UBqt/WFYnqnvLQFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVfI4zv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB36C116B1;
	Sat,  6 Dec 2025 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765033650;
	bh=efblxE7xjpWtBxnjSUVxVtm7YsEPsH4q6kw9ZHyIPm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVfI4zv2LUSWWATf9cPjCXQUrO1amIgvEpw9IDEjj3KOhVuvozGyRNPLayKxyH+/l
	 C7NOuwKG7QQRg+232M2rFh4H4PdFuKxmbtMu2LiDpapvscmwttUsbkBQDK4nkyOb1V
	 cDWpCRAq89KoPYyzQNuYFIYMOGXSlz5LA7kluYVNoSkLqpmCSwjpuRLzU6+LmG49zx
	 N4GKHjgze4pwC8gFuSRPG7TkDJiJzBY6JpI8xXUKg3J1B1FzEwVXfKZ1yPOhOoC9zt
	 E1V+lG7SchqoyRSR+QZB19977bsBdAyxYj6r5am2T6VuGhqMhLeP/gHcfmiMPsRb3D
	 +a49+MqVi08Xg==
Date: Sat, 6 Dec 2025 15:07:26 +0000
From: Simon Horman <horms@kernel.org>
To: Vimlesh Kumar <vimleshk@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sedara@marvell.com, srasheed@marvell.com, hgani@marvell.com,
	Veerasenareddy Burru <vburru@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] octeon_ep: reset firmware ready status
Message-ID: <aTRGrorVdpRfmWtd@horms.kernel.org>
References: <20251205091045.1655157-1-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205091045.1655157-1-vimleshk@marvell.com>

On Fri, Dec 05, 2025 at 09:10:44AM +0000, Vimlesh Kumar wrote:
> Add support to reset firmware ready status
> when the driver is removed(either in unload
> or unbind)
> 
> Signed-off-by: Sathesh Edara <sedara@marvell.com>
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
> ---
> V2: Use recommended bit manipulation macros.

...

> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
> index ca473502d7a0..284959d97ad1 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
> @@ -383,6 +383,22 @@
>  /* bit 1 for firmware heartbeat interrupt */
>  #define CN93_SDP_EPF_OEI_RINT_DATA_BIT_HBEAT	BIT_ULL(1)
>  
> +#define FW_STATUS_DOWNING      0ULL
> +#define FW_STATUS_RUNNING      2ULL
> +
> +#define CN9K_PEM_GENMASK BIT_ULL(36)
> +#define CN9K_PF_GENMASK GENMASK_ULL(21, 18)
> +#define PFX_CSX_PFCFGX_SHADOW_BIT BIT_ULL(16)
> +#define CN9K_PEMX_PFX_CSX_PFCFGX(pem, pf, offset)   ((0x8e0000008000 | (uint64_t)\
> +						      FIELD_PREP(CN9K_PEM_GENMASK, pem)\
> +						      | FIELD_PREP(CN9K_PF_GENMASK, pf)\
> +						      | (PFX_CSX_PFCFGX_SHADOW_BIT & (offset))\
> +						      | (rounddown((offset), 8)))\
> +						      + ((offset) & BIT_ULL(2)))

Hi Vimlesh,

Please use a #defines so that 0x8e0000008000 and for BIT_ULL(2) have names.

And please reformat so this is less than 80 columns wide.
I'd do something like this:

define CN9K_PEMX_PFX_CSX_PFCFGX(pem, pf, offset) \
	... \
	...

> +
> +/* Register defines for use with CN9K_PEMX_PFX_CSX_PFCFGX */
> +#define CN9K_PCIEEP_VSECST_CTL  0x4D0
> +
>  #define CN93_PEM_BAR4_INDEX            7
>  #define CN93_PEM_BAR4_INDEX_SIZE       0x400000ULL
>  #define CN93_PEM_BAR4_INDEX_OFFSET     (CN93_PEM_BAR4_INDEX * CN93_PEM_BAR4_INDEX_SIZE)

## Form letter - net-next-closed

The merge window for v6.19 has begun and therefore net-next has closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens.

Due to a combination of the merge-window, travel commitments of the
maintainers, and the holiday season, net-next will re-open after
2nd January.

RFC patches sent for review only are welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

-- 
pw-bot: changes-requested

