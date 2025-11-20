Return-Path: <netdev+bounces-240417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6A7C74A02
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4FF0354A8F
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 14:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06482D192B;
	Thu, 20 Nov 2025 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Di0dthyT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B7D2C0298;
	Thu, 20 Nov 2025 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763649701; cv=none; b=TN9slsbt4EIrWNKwEtPpc9hFVOvnz1SZJ/5DgnEL1Q9xACEIpweWVl5G8xOHqMxdkrCGhQSGwD4dvPKQUfCH0hlKSsmNA9ZYBJvDkm9cQ8nd9gMAjB2i4CkeruXM5UUhopASHZkWqZdj76M/Fsq7djoL0dtc6J2GeGCgDi4f70Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763649701; c=relaxed/simple;
	bh=4KBGMo3C6i48k6qVDasQfbAFyklZEFkG73wMxhmGYmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsf+E8XY59kb4Y5Fu16fgVdnHrHWB3WWH7hGi6Tm5Un3koQyZ94V60T0+e4lgFclYgYht90v/A+Uv7+yyScux5dqrs8Nig6Wqa1EY+bNmgGTWy/qTbN1b+/MGGCwrCC6XH162ZWlUpwK5khKItT/3VviCfOx5F4oiy5I/nYtC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Di0dthyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1F9C116D0;
	Thu, 20 Nov 2025 14:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763649701;
	bh=4KBGMo3C6i48k6qVDasQfbAFyklZEFkG73wMxhmGYmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Di0dthyT+WGn1Ki3fIv1gCIkeixYyk7K7xoX5jfGNWHbB7ZG0m6s6Xz0U+WR3ENkc
	 D48nQsneMj5VAQgTrwUCsgVhUelQ3wr/GI9YbeGxxXkuszU7drB9wEoJsr7VmZf3G3
	 irRuiKl+c12hYk+I/qZLMgAGWEJFqYbPa3VM0XQTcjw1zSrcqzlOPSGcbpiEkRn77G
	 bxgcw+XWPtHSS1UDCOhc7ye9hreb6scNP2PgRxA8UZY0KkMxa8YDPQZKvAtRgt9HPE
	 zs3yWs9gxHEzM5nx2h0BY599zUBg3vB48mx2QrqAdfuiuG469/11P9Ud6gDKESdrIp
	 YL6XMLZtA5xsw==
Date: Thu, 20 Nov 2025 14:41:36 +0000
From: Lee Jones <lee@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/15] mfd: core: add ability for cells to probe
 on a custom parent OF node
Message-ID: <20251120144136.GF661940@google.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-8-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251118190530.580267-8-vladimir.oltean@nxp.com>

On Tue, 18 Nov 2025, Vladimir Oltean wrote:

> I would like the "nxp,sja1110a" driver, in the configuration below, to
> be able to probe the drivers for "nxp,sja1110-base-t1-mdio" and for
> "nxp,sja1110-base-tx-mdio" via mfd_add_devices():
> 
> 	ethernet-switch@0 {
> 		compatible = "nxp,sja1110a";
> 
> 		mdios {
> 			mdio@0 {
> 				compatible = "nxp,sja1110-base-t1-mdio";
> 			};
> 
> 			mdio@1 {
> 				compatible = "nxp,sja1110-base-tx-mdio";
> 			};
> 		};
> 	};

This device is not an MFD.

Please find a different way to instantiate these network drivers.

> This isn't currently possible, because mfd assumes that the parent
> OF node ("mdios") == OF node of the parent ("ethernet-switch@0"), which
> in this case isn't true, and as it searches through the children of
> "ethernet-switch@0", it finds no MDIO bus to probe.
> 
> Cc: Lee Jones <lee@kernel.org>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/mfd/mfd-core.c   | 11 +++++++++--
>  include/linux/mfd/core.h |  7 +++++++
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 7d14a1e7631e..e0b7f93a2654 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -181,8 +181,14 @@ static int mfd_add_device(struct device *parent, int id,
>  	if (ret < 0)
>  		goto fail_res;
>  
> -	if (IS_ENABLED(CONFIG_OF) && parent->of_node && cell->of_compatible) {
> -		for_each_child_of_node(parent->of_node, np) {
> +	if (IS_ENABLED(CONFIG_OF)) {
> +		const struct device_node *parent_of_node;
> +
> +		parent_of_node = cell->parent_of_node ?: parent->of_node;
> +		if (!parent_of_node || !cell->of_compatible)
> +			goto skip_of;
> +
> +		for_each_child_of_node(parent_of_node, np) {
>  			if (of_device_is_compatible(np, cell->of_compatible)) {
>  				/* Skip 'disabled' devices */
>  				if (!of_device_is_available(np)) {
> @@ -213,6 +219,7 @@ static int mfd_add_device(struct device *parent, int id,
>  				cell->name, platform_id);
>  	}
>  
> +skip_of:
>  	mfd_acpi_add_device(cell, pdev);
>  
>  	if (cell->pdata_size) {
> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index faeea7abd688..2e94ea376125 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -81,6 +81,13 @@ struct mfd_cell {
>  	/* Software node for the device. */
>  	const struct software_node *swnode;
>  
> +	/*
> +	 * Parent OF node of the device, if different from the OF node
> +	 * of the MFD parent (e.g. there is at least one more hierarchical
> +	 * level between them)
> +	 */
> +	const struct device_node *parent_of_node;
> +
>  	/*
>  	 * Device Tree compatible string
>  	 * See: Documentation/devicetree/usage-model.rst Chapter 2.2 for details
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]

