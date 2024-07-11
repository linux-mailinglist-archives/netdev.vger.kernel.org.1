Return-Path: <netdev+bounces-110846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C906792E98B
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 15:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E54AB25313
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 13:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D301915ECD6;
	Thu, 11 Jul 2024 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJviZV2h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB76155740
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720704645; cv=none; b=ANT7O3VV7tK+FCdTJ8t8xz5d0/HE3Lc+KJ0yuRtsds9mKXPBGPD4vBmkGwnz+s8KjEyBvOPJAC30qF1obHJN+bHdbtfVbTUSNReTwIRXApNI0aXCWij1XlO480Yl47OaE1lyDgKCgEWRk8BjnaeyPbP3vJFDAP+5oSy69d4CJ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720704645; c=relaxed/simple;
	bh=RrGUXRLs1eEaQjIVmcrt4/Eq6vdaQf2V0yjUR/IiFAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZD72aiAZGtPiTE/xJUkI9SxWgBHgNBfNzi9nZmcnBzLDB3JHn+AfbSnEeOy/1raPgZs/WzsfWBLcmEOEuup8IOyko0/Ypq6OzuvHmOBpj9UAhSLagJqQmTOVDzYT+W5Rc+gPiciCQRpZaQYKWlpyVv995USFDoTNK5KUR5GTtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJviZV2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B046C116B1;
	Thu, 11 Jul 2024 13:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720704645;
	bh=RrGUXRLs1eEaQjIVmcrt4/Eq6vdaQf2V0yjUR/IiFAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJviZV2hLiGZbJKYQqUZ/7MTOaqjOtkKvxJoG+mNcPb3bLXxTJXHiLkexgsfWD5js
	 z0Vn/T+P63lbMdNoLBtK+0j0Uvy2/iiHsg0VNLYlzdr7beJJRBRhRniazw5eaw5gFP
	 fvwjU9Nhc8p6HvEezM1Xsbc9+uliNCje7VT/5Epp1BG2KevyDU3PvwknnKOhE8jV/1
	 0ofFLcatRqUwopPJneJTgabxrD+qgmj75fiD85rPQm0Hj3Gk3qiMjh6i7TOWft0z4l
	 yskb5IiFHGRs+GORQAbhYXKVi4jOgsitFKkPOrUEYWqpwyY4j1J1TZ2MBZaAkpt4qX
	 NMIMmoI77j+jg==
Date: Thu, 11 Jul 2024 14:30:40 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, tariqt@nvidia.com, rrameshbabu@nvidia.com,
	saeedm@nvidia.com, yuehaibing@huawei.com, jacob.e.keller@intel.com,
	afaris@nvidia.com
Subject: Re: [PATCH net-next] eth: mlx5: let NETIF_F_NTUPLE float when ARFS
 is not enabled
Message-ID: <20240711133040.GD8788@kernel.org>
References: <20240710175502.760194-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710175502.760194-1-kuba@kernel.org>

On Wed, Jul 10, 2024 at 10:55:02AM -0700, Jakub Kicinski wrote:
> ARFS depends on NTUPLE filters, but the inverse is not true.
> Drivers which don't support ARFS commonly still support NTUPLE
> filtering. mlx5 has a Kconfig option to disable ARFS (MLX5_EN_ARFS)
> and does not advertise NTUPLE filters as a feature at all when ARFS
> is compiled out. That's not correct, ntuple filters indeed still work
> just fine (as long as MLX5_EN_RXNFC is enabled).
> 
> This is needed to make the RSS test not skip all RSS context
> related testing.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


