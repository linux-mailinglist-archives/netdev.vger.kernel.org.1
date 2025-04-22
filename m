Return-Path: <netdev+bounces-184814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D3DA97489
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 20:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C754E3BCEF9
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7369327C875;
	Tue, 22 Apr 2025 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ6dqDvd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A3D8467;
	Tue, 22 Apr 2025 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745346761; cv=none; b=pJED5sNn0GsTcRcUBmmr+KCeVjqOd6C2vzgGj8GrMGtoiA9Z1VYfeIxGqWiN+2ruMap0zDOOM09v2TbpRtxFcXxloJkT9v5oo4SVtchYQxEzUj0O/vbi5zKy+B5Sp5QPz+z/SgM8S/4UpdsPLwsUZYH52w38LsCUk/QkIJ10ePI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745346761; c=relaxed/simple;
	bh=LNQzXF9lRMqT79pfXjmkGZBA25a1BLuxMWcydwq1mq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSA4ZpaiR32LGCXB8KQ2VvaBa7YbtFYTxqzaux9OrF/iUW6OKp5kBOfEYCR85uj6cUsSlW79/071UWWVOr/uLn8vX7mmxFcvbjDDQUwS25b3je854AgMVhixDtA951tIHhA2Fe9BP9p4bSvRBqCTbpQr4lj+ifa/5tdTixf/fRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZ6dqDvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03ED2C4CEE9;
	Tue, 22 Apr 2025 18:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745346761;
	bh=LNQzXF9lRMqT79pfXjmkGZBA25a1BLuxMWcydwq1mq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KZ6dqDvdfc5xCIsgz5+KHYB+bK16fTKeaAoHjccqfUmaIH5W6VPv9vX4YqJCu8oP2
	 sMLZEcxbfn+8kgwL88D9cacXoI6lMzTmQjcZBKU7llfnPh0Su7cCFqE3Pcao3iU+RA
	 peeD/FVDX4tU9vF8W15S4zKSDGwYptHlgmPj0jiNFP6P4qGXjB+C2tqiRpZ6nsoY26
	 4VUjSLpmF8FejOk5uYxh3x6vEujzVQMGxgFFLiQy1DZr2XOJny8niT3rkJtegXXVwW
	 PLi8gta1MdgIdiDr7TOL6MV48Unu90wEN5hpVtbp64PTgEDW6if18ozp4azNXCwdq2
	 PIfO8l81xI0Zw==
Date: Tue, 22 Apr 2025 19:32:35 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, rafal@milecki.pl,
	linux@armlinux.org.uk, hkallweit1@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next 3/5] net: bcmasp: Remove support for asp-v2.0
Message-ID: <20250422183235.GN2843373@horms.kernel.org>
References: <20250416224815.2863862-1-justin.chen@broadcom.com>
 <20250416224815.2863862-4-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416224815.2863862-4-justin.chen@broadcom.com>

On Wed, Apr 16, 2025 at 03:48:13PM -0700, Justin Chen wrote:
> The SoC that supported asp-v2.0 never saw the light of day. asp-v2.0 has
> quirks that makes the logic overly complicated. For example, asp-v2.0 is
> the only revision that has a different wake up IRQ hook up. Remove asp-v2.0
> support to make supporting future HW revisions cleaner.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp.c   | 98 ++-----------------
>  drivers/net/ethernet/broadcom/asp2/bcmasp.h   | 45 ++-------
>  .../ethernet/broadcom/asp2/bcmasp_ethtool.c   | 21 +---
>  .../net/ethernet/broadcom/asp2/bcmasp_intf.c  |  2 +-
>  .../ethernet/broadcom/asp2/bcmasp_intf_defs.h |  3 +-
>  5 files changed, 23 insertions(+), 146 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c

...

>  static const struct bcmasp_plat_data v21_plat_data = {
> -	.init_wol = bcmasp_init_wol_shared,
> -	.enable_wol = bcmasp_enable_wol_shared,
> -	.destroy_wol = bcmasp_wol_irq_destroy_shared,
>  	.core_clock_select = bcmasp_core_clock_select_one,
> -	.hw_info = &v21_hw_info,
> +	.eee_fixup = NULL;

	.eee_fixup = NULL,

>  };

...

