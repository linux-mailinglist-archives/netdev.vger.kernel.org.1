Return-Path: <netdev+bounces-233551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA57C15529
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F239188891C
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2195267B01;
	Tue, 28 Oct 2025 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzVMbkK/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5A264A86
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663791; cv=none; b=PsAOAKdWmWd52yJqaZrB9K+wsVtcOm8KdlG5L4qBaDNu4BpjL5cVOilmnyCcTT37yskqOC+QLNGxLD6l3ppnEofqjG+vW71PfIIWzVDXcG43cKpZDy/J6Lp3DjaglC5i4yxYM56gyqKEzqifmwRRMkRYeOY8oZXDFo4tvm04uBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663791; c=relaxed/simple;
	bh=Z36D+6ZhfHgGmJy7pQ7Lwnpln/Jx0aH9L4PEgSkS4cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+3EdvP88jL6C1cbaZD/Vy9H3l0qAh9zRq0A/nJtmbDw2638s2Q2zSAs8PXDJmtOzWWyDXLxVxVfW2xUMOBizCGlw3zTPIHomcGF/UYd2db3t9t9PuynEHMLtdVt6QpC7+nWPxzhWUrDQAbd+n3xYQvwDUK+8LHUNbK54F0tBF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzVMbkK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A04DC4CEE7;
	Tue, 28 Oct 2025 15:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761663790;
	bh=Z36D+6ZhfHgGmJy7pQ7Lwnpln/Jx0aH9L4PEgSkS4cM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HzVMbkK/3Fgb9ijFlyUS4iB1uC23xI0ZWZkIdfJ6RogXnWbv2lzNYqJ5EZfVySMc1
	 SB0DKWP4a80haIV3+eNxvAxMxegcgSl0pH0ouiVYimn7wLLo4q6cG1hg/MJLijGkLn
	 J/keK8Jax3TsCJTpUdStSyMwztf2rGgq0UV3SFX22tlrT0wwT6SssPtzFnN7TjgRm/
	 f99Wn7XzOr3SyxQrGBtScpV+ELzWNeWby/ogLFK9rqL5dN9qSPQUNE+lq8DpjDf0Pz
	 RANtYBei63HupbcZg6lFxV1k15YxeDwEsuPfsutaROIVrcLbDZhBNSXtbGCHw5ZOlB
	 t3v+G2BLEbK8A==
Date: Tue, 28 Oct 2025 15:03:05 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 net-next] net: stmmac: mdio: fix incorrect phy address
 check
Message-ID: <aQDbKYMtgiQaGgHX@horms.kernel.org>
References: <e869999b-2d4b-4dc1-9890-c2d3d1e8d0f8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e869999b-2d4b-4dc1-9890-c2d3d1e8d0f8@gmail.com>

On Sat, Oct 25, 2025 at 08:35:47PM +0200, Heiner Kallweit wrote:
> max_addr is the max number of addresses, not the highest possible address,
> therefore check phydev->mdio.addr > max_addr isn't correct.
> To fix this change the semantics of max_addr, so that it represents
> the highest possible address. IMO this is also a little bit more intuitive
> wrt name max_addr.
> 
> Fixes: 4a107a0e8361 ("net: stmmac: mdio: use phy_find_first to simplify stmmac_mdio_register")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reported-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - improve subject

Thanks, this versions looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

