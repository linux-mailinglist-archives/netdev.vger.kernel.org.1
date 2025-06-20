Return-Path: <netdev+bounces-199717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EFFAE18C4
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8654A5795
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC45280328;
	Fri, 20 Jun 2025 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzrLYvSV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D052199947;
	Fri, 20 Jun 2025 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415107; cv=none; b=VbT9jQAuDdH81KX2wzuVVVd3beWeHexfPXwLXCHSNh/K7ZsGh8nZTK9kYUzH4ooofHD4Zx2U6TMy2EB87Nc8LrViQNV3G5w8S+ZfjFSp9EALEfzEIPsQtvGrJRlftBZvYjnXI/hBNtOqqrYqhHiDwzXFH04l2PbTKya1FWj9dwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415107; c=relaxed/simple;
	bh=AM7DVcQLLEVCySf0Dm2EF4P8th0PDvSwnYa8gtMQNbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mW7qThAXNmvIkXvdINJqShOavepjfpJd9dkApooCktgRi+tHewXikXNJ6FehLNnK22kIjmzF6HXU+QjkeodCKv4LTWs/P7h11Xb9pnAdcEiLsEcV7I7WmzUdBtu97xr4lxFlNsw+AU9gFAgs9H2e02DZlDaIFp2Md2legWSwsvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzrLYvSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F4DC4CEEE;
	Fri, 20 Jun 2025 10:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750415106;
	bh=AM7DVcQLLEVCySf0Dm2EF4P8th0PDvSwnYa8gtMQNbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uzrLYvSVfmYRwzYPrxkixlOGWyI5b9wQDA7R/NT5k9jDgG8fpIONX+anIhKq2cEXV
	 /UBEUHa0wnoGZoyGr239oYiF1x7yOZ3goHGly+fq389YY30O/2xlqKiNk/4IYHJ+ha
	 01MG/9/s5WuvUja1VVDHUwrEM5FtP5JsQnEGJ8YFNMZ8rRN+j0dspjOoRV7jhkmpMI
	 jQLT6TlZ/hhH11vK3jtvxsIx7ygFI1jo9fd3GRyaHMfA6h8ePzMcETylLtOK8Uxy47
	 OKEBLq+XU48e8jyQYskY0VpDIO4n4SRIAznUlFSXaL/rfPnyyqHpUBhvFhSnL6kINu
	 ZqvkBkye2i/wg==
Date: Fri, 20 Jun 2025 11:25:01 +0100
From: Simon Horman <horms@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] net: cadence: macb: Expose REFCLK as a device tree
 property
Message-ID: <20250620102501.GF194429@horms.kernel.org>
References: <cover.1750346271.git.Ryan.Wanner@microchip.com>
 <c5de54b31ed4a206827dfaf359b0bb9042aaca74.1750346271.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5de54b31ed4a206827dfaf359b0bb9042aaca74.1750346271.git.Ryan.Wanner@microchip.com>

On Thu, Jun 19, 2025 at 10:04:14AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> The RMII and RGMII can both support internal or external provided
> REFCLKs 50MHz and 125MHz respectively. Since this is dependent on
> the board that the SoC is on this needs to be set via the device tree.
> 
> This property flag is checked in the MACB DT node so the REFCLK cap is
> configured the correct way for the RMII or RGMII is configured on the
> board.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index d1f1ae5ea161..146e532543a1 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4109,6 +4109,8 @@ static const struct net_device_ops macb_netdev_ops = {
>  static void macb_configure_caps(struct macb *bp,
>  				const struct macb_config *dt_conf)
>  {
> +	struct device_node *np = bp->pdev->dev.of_node;
> +	bool refclk_ext = of_property_present(np, "cdns,refclk-ext");
>  	u32 dcfg;

Hi Ryan,

Some minor feedback from my side.

1. of_property_read_bool() seems slightly more appropriate here
2. Please consider arranging local variables in Networking code
   in reverse xmas tree order - longest line to shortest.

   This tool can be helpful for this
   https://github.com/ecree-solarflare/xmastree

	struct device_node *np = bp->pdev->dev.of_node;
	bool refclk_ext;
	u32 dcfg;

	refclk_ext = of_property_read_bool(np, "cdns,refclk-ext");

...

