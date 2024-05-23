Return-Path: <netdev+bounces-97741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9BE8CCF97
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 11:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6791F2364E
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820F313CFB0;
	Thu, 23 May 2024 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwXv9cQy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E42513CABD
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716457634; cv=none; b=f36c60NV0V3cqG+0m/++5vsYCSo8E6LIlcILJKVcIo9QFpNKjgIYf2hvuaEvVZQ5ChpeQtDdxDwJHxLWPEpIn+OzSDfYcoodMYysfkvB8Uh7k8QwZprgXrEkRViFNPmxO596n3CmseUd+Jzs16cmEPT8Q+tV843qdcmiNqdAw5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716457634; c=relaxed/simple;
	bh=BFoT83hnn3nhKPh3nMd4w1v/+jglQ3PC8a0JS1QPl74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYkn/YZlItAV+Sh8ZqDObS005Zb2RpHC/9yQFwJhGcZVMd522Fy532ks6pwkf4ReE7XktTc+u7fEKp2OHRDU7VIG3afkrTaOO9GCHpxRGela61mqQwANu7BDHzjm/zXAbtmW/DbsZki4vaopabpafaVyVaaLHOiwpo9rpUJLqIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwXv9cQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C48C2BD10;
	Thu, 23 May 2024 09:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716457634;
	bh=BFoT83hnn3nhKPh3nMd4w1v/+jglQ3PC8a0JS1QPl74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwXv9cQydJEcKhfiHxf7TI08yqt9oVaqgIycAShCYFL5Hh9g+DT2V8HXsFWqVJzLp
	 p7fJHHqdqrDUpnrWWLX3fxjSHlZCu57Qg76PEPaHXVB6CKOZ0FPvMOryT0Sn4W//E6
	 vM+w9OD2btit3cgUBvzUyTMV1az4erp0HWbeeHblh9URYhHUlG0UFXft6wW7KBo7UW
	 2mati1dToQBTdF0FpmJl7b50VlubYWbjyU5x5Pck+nCTdEjykDJX+yuIWiFNpT0GvP
	 HTi/PvPZzS0Oiqm0f3+OlpLIF5PTlWEYAsCvJj5iZChUBGgIy/V1qtgKMNp4Y9lscD
	 N7aVkf8NJkMyg==
Date: Thu, 23 May 2024 10:47:09 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net 3/8] net/mlx5: Fix MTMP register capability offset in
 MCAM register
Message-ID: <20240523094709.GF883722@kernel.org>
References: <20240522192659.840796-1-tariqt@nvidia.com>
 <20240522192659.840796-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522192659.840796-4-tariqt@nvidia.com>

On Wed, May 22, 2024 at 10:26:54PM +0300, Tariq Toukan wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> The MTMP register (0x900a) capability offset is off-by-one, move it to
> the right place.
> 
> Fixes: 1f507e80c700 ("net/mlx5: Expose NIC temperature via hardware monitoring kernel API")
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


