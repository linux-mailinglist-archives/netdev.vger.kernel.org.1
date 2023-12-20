Return-Path: <netdev+bounces-59256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7599681A16F
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252531F232D8
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 14:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF503D967;
	Wed, 20 Dec 2023 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EygpqKCI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB633D960
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 14:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A142FC433C7;
	Wed, 20 Dec 2023 14:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703083769;
	bh=S/HL8RIdJVP4DU4LUNcji7jWTiRR4KlkEh8DzP0D/gY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EygpqKCIia/BeL5AehtmuRW0zjfu5ZeGXmB003vrjyZAFKUs1qHXHvH7o1M1iDbs5
	 59RSOhdwQNyLsOI2cocnJDacLdS5TbMISRx4/QlulssycOgETE/MGfxcmLFB1IxJoz
	 pMi+iYTzl6XtJXpsd25mn0+rJwqQUbgRD1hQ9XedQlMb3ibwNsWEGqoc8xvO8gGHUr
	 UO1S0VwMFODiUINWU6+WA4op8/00YI+NpBngDs8OgvFVhcD/ouVfUDVwBf4tl2srP3
	 BWPaxBdSF4Iw6L0k00POVctpNhchMew0zVmRMece8eBT7ohtSHEIp9gxoiW6h2tCPO
	 ko1ZZOF4Hlwbg==
Date: Wed, 20 Dec 2023 15:49:22 +0100
From: Simon Horman <horms@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/8] dpaa2-switch: reorganize the
 [pre]changeupper events
Message-ID: <20231220144922.GK882741@kernel.org>
References: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
 <20231219115933.1480290-7-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219115933.1480290-7-ioana.ciornei@nxp.com>

On Tue, Dec 19, 2023 at 01:59:31PM +0200, Ioana Ciornei wrote:
> Create separate functions, dpaa2_switch_port_prechangeupper and
> dpaa2_switch_port_changeupper, to be called directly when a DPSW port
> changes its upper device.
> 
> This way we are not open-coding everything in the main event callback
> and we can easily extent, for example, with bond offload.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v3:
> - removed the initialization of the err variable
> Changes in v2:
> - none

Reviewed-by: Simon Horman <horms@kernel.org>


