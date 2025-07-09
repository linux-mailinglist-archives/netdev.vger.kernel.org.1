Return-Path: <netdev+bounces-205322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4242AFE2EA
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70CD48364E
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8340277032;
	Wed,  9 Jul 2025 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0J4pr+a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B252027B51A
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050419; cv=none; b=lvM3pjaSbEpySJGY+zFzSizqqStU8fwpCR3k5JgLy25rU8CMNpHBX4Rrs1gLOIi0xEV/TNtmn/6vUp1tcqBtgdVhCwsjj+Aoz+Xr4xiq5uEg+fpwAom5gHoZuOx966CMM2+vvzzEwFl18jC+lPPUHFBUwH4Yaf5fZ29Wrdsu5rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050419; c=relaxed/simple;
	bh=SSiAmNMWgt14g0mQGHUrcEbVVlkbgniskfL10DWUzhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEqkuFBbK5FcejrQ3yf1U0MA7P8zu0b16izBapDI4MECLpu324qAhmI/Y2dH2WIXqYwnzMLRMkZ63pDa7HW/FmqXsPUS22WqS19aEiad6HzK6wjM8BZ3wm3wds7DdgQZS5lRmCqCcNdXcUsrz7SWkfaizVdGSBcx1eWxXfkph6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0J4pr+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AB4C4CEEF;
	Wed,  9 Jul 2025 08:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752050419;
	bh=SSiAmNMWgt14g0mQGHUrcEbVVlkbgniskfL10DWUzhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X0J4pr+a9oNDdPHlOAK3OgqZp9gGwk4xUIPtS+vCbsO8HER/lDbrJg2HjEzqkHxQ0
	 1ZP47fc1nxeHkTSf/kGXY2I6dTadk0NaFrihbTnP5j1r35KvWcdTgCb45JiLsbYItg
	 q4eQ36OQa0wDj6/kfWm3RQVYeIpkrjOoMrLSe4PDBF2rwOn+fJgR9UsGzix2I/aIZD
	 bpyLju+7c5Yne+AMwMjCOtJppveFM+2vDEJHx8vpMeZJXwe33ScJqbvB/2U2BqZ3qg
	 tXGakA+r1CY0MKWtdnunjLPnqsZBZRzh0QvrCAMIlfLOH6r811qcYeZA1SB3T4mrDZ
	 W+q9+gbSnwoZg==
Date: Wed, 9 Jul 2025 09:40:14 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V6 09/13] devlink: Add 'keep_link_up' generic
 devlink device param
Message-ID: <20250709084014.GK452973@horms.kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-10-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709030456.1290841-10-saeed@kernel.org>

On Tue, Jul 08, 2025 at 08:04:51PM -0700, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Devices that support this in permanent mode will be requested to keep the
> port link up even when driver is not loaded, netdev carrier state won't
> affect the physical port link state.
> 
> This is useful for when the link is needed to access onboard management
> such as BMC, even if the host driver isn't loaded.
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


