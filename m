Return-Path: <netdev+bounces-205366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1822BAFE53E
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 12:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901F9188EE30
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445FE28B50A;
	Wed,  9 Jul 2025 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNCtfE1Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C55E28B507;
	Wed,  9 Jul 2025 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055711; cv=none; b=tASiUg+MhoRlIKClnPBiSJaN6rBexyEsBBtEXmIh3WQvxsUi0zbEzobc1Leo5UCmrfQW2fAz+351oZsGD4yDj77e5GjUjZADz8pOOiFmo9cRFRKo1PR60J++4lAsChdkXzR9Zc74EDyXNPoUw9hZZ2x1ndHKFVOS1YiwIwyiWsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055711; c=relaxed/simple;
	bh=7s0iUf/zVAXVdlRZKllsduSnRK48iQZQiABy4eBpO/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhquNVGaAQfvMvJmzBVqiafEBMcq40a/0Yt3kxg1B6+RlxaiiQYJmR/sMhsl4K/k4xjX/r+hKNfaHlHilDArvZ64hbA/lIuOmMa7Ax0LGS+zaOe+p/sCojzujE8sG3MwXbcRGoUbYVdOBlK+NRKxxq0m77Fe4//SKFMMpjRkefw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNCtfE1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D38C4CEF5;
	Wed,  9 Jul 2025 10:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752055710;
	bh=7s0iUf/zVAXVdlRZKllsduSnRK48iQZQiABy4eBpO/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jNCtfE1ZQF+nrMLJ47vu5+q2KzZDiM+HPAYnmlcTkf7bTWI8bAV23b9BWED9PiMGJ
	 0/ujVRENMFPP0tEJ5YNwiK4Q7Qfx1MzX6Ub+px+EwN+NH2zhC56EJxRKmCSbQ9E68y
	 Ux+0Ap5Kjk/gJBUT+YcdOecMPeHUQbqfcKRq5M0IRATpMeiPxV7EJlBWvt0q9C1e9v
	 eVKM9q0ltWo7itHx2PWrEOSL7/fDs3CVIH4VBfMe0A+kVrAC7pmKqloiIalhYOJeCK
	 u8KPuZaw4G6r6Q0V4PZhgtEnDks39Cyk+jSYg5m4VKUJU2KltVrhUf+Lh6W0feNpak
	 sNNEfk2MNSGwg==
Date: Wed, 9 Jul 2025 11:08:26 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	darren.kenny@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: thunderx: Fix format-truncation warning
 in bgx_acpi_match_id()
Message-ID: <20250709100826.GT452973@horms.kernel.org>
References: <20250708175250.2090112-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250708175250.2090112-1-alok.a.tiwari@oracle.com>

On Tue, Jul 08, 2025 at 10:52:43AM -0700, Alok Tiwari wrote:
> The buffer bgx_sel used in snprintf() was too small to safely hold
> the formatted string "BGX%d" for all valid bgx_id values. This caused
> a -Wformat-truncation warning with Werror enabled during build.
> 
> Increase the buffer size from 5 to 8 and use sizeof(bgx_sel) in
> snprintf() to ensure safety and suppress the warning.
> 
> Build warning:
>   CC      drivers/net/ethernet/cavium/thunder/thunder_bgx.o
>   drivers/net/ethernet/cavium/thunder/thunder_bgx.c: In function
> ‘bgx_acpi_match_id’:
>   drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:27: error: ‘%d’
> directive output may be truncated writing between 1 and 3 bytes into a
> region of size 2 [-Werror=format-truncation=]
>     snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
>                              ^~
>   drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:23: note:
> directive argument in the range [0, 255]
>     snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
>                          ^~~~~~~
>   drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:2: note:
> ‘snprintf’ output between 5 and 7 bytes into a destination of size 5
>     snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
> 
> compiler warning due to insufficient snprintf buffer size.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
> v1->v2
> No changes. Targeting for net-next.
> https://lore.kernel.org/all/20250708160957.GQ452973@horms.kernel.org/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

