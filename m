Return-Path: <netdev+bounces-95759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482EC8C35B9
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 10:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791831C20A46
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 08:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD55EEB3;
	Sun, 12 May 2024 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCxVXXfl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D693D6A;
	Sun, 12 May 2024 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715502924; cv=none; b=d8aHPB5v+XxEXsRJH+3z+t0/VXm+d4sJ64kl9044V59UGUT6I+OpTIhg5qHNQG189Vue2BGsK/EAVg/OJhHIHq/60dYHulw6Q4dfYMGku/p/y6St6JCIZJE5Yt0qSzQVYpy/gpZqR7LHOTajMfJ8BmzElnj8vsXyd3324394MBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715502924; c=relaxed/simple;
	bh=kXs5Vk2uM7TF2KGpm3iKNAHLpYpFzJyyIakxcjC+ewE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/qH47mefK4k7qxblvRLSqt/523OxZcGtTCyUy5Kwg0Ut0e/SvaSsz6a7L5kRejHsMkTjdRdtZzdPrKoYVDS1ph5jlfNFk6FKKS58MXjDmtRu64sDFOtJ+XBUEyVRzFPFUuHlHp64edH4jZ10kywke/+6iGIrSmnSSRJZtmfDms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCxVXXfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A72C116B1;
	Sun, 12 May 2024 08:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715502924;
	bh=kXs5Vk2uM7TF2KGpm3iKNAHLpYpFzJyyIakxcjC+ewE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCxVXXfliol5EzkqZ307uFnJDXrNPhRi9Ta4wEvxHKbAbzOorKrUoMmuTSZyYW5Ca
	 C0hS53eqzqve6hpg8aqbJ+jKAZ+5y1G6Vy6XzA243VIDssTBanTYI/ZLr0TcrQLoB3
	 7iDjbQQbZhmR9KHDYVBCJeuiz/Ubp/lI+FEjXyyONc88CfYv1mwq3FotWwZlXQxc8t
	 l+SZzLppHWo9iM5FHxcRJVpaUAfg+VfmsuUghi3DovDLyLS5sIAy0UKDegBoNLhvxp
	 vuX92yWw2YsOno/k5qpE+XW1A4iq7dgGOt+FT5IaDnPbVzHLTxdNR/j9hRrGHkJ6pD
	 mL0u2Vz12TPLQ==
Date: Sun, 12 May 2024 09:35:18 +0100
From: Simon Horman <horms@kernel.org>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	bcm-kernel-feedback-list@broadcom.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2, net-next, 2/2] net: stmmac: PCI driver for BCM8958X
 SoC
Message-ID: <20240512083518.GX2347895@kernel.org>
References: <20240510000331.154486-3-jitendra.vegiraju@broadcom.com>
 <20240511015924.41457-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511015924.41457-1-jitendra.vegiraju@broadcom.com>

On Fri, May 10, 2024 at 06:59:24PM -0700, Jitendra Vegiraju wrote:
> Broadcom BCM8958X SoCs use Synopsys XGMAC design, which is similar to
> dwxgmac2 core implementation in stmmac driver. The existing dwxgmac2 dma
> operation functions have some conflicting differences with BCM8958X.
> This glue driver attempts to reuse dwxgmac2 implementation wherever
> possible, adding alternative implementations where necessary.
> 
> v2: code cleanup to address patchwork reports.
> 
> Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c

...

> +static struct mac_device_info *dwxgmac_brcm_setup(void *ppriv)
> +{
> +	struct mac_device_info *mac;
> +	struct stmmac_priv *priv = ppriv;

Hi, Jitendra,

A minor nit from my side.

Please consider using reverse xmas tree order - longest line to shortest -
for new Networking code.

This tool can be of assistance: https://github.com/ecree-solarflare/xmastree

...

