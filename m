Return-Path: <netdev+bounces-28589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1EE77FEB3
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECAAF1C214B4
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF0A1AA7E;
	Thu, 17 Aug 2023 19:49:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F49A1643A
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 19:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62927C433C7;
	Thu, 17 Aug 2023 19:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692301766;
	bh=sfWy2xe0trvQZPe56oZ7Qsbb5xv1XLUgd+G/dNoLBp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HkSb2D2M/9wlbqkMgMHFXTvMmSSVQ/X+8MWkBoPQSlmFUSK40Rrso0dLMktXKcIR/
	 KTf9x+GjTo5bm7Qe0kgxFwqEFhuQEKuNi173sDCKcvk4BDskuEu9Eu4hoPdYgGYJWW
	 4/LGQfFN+p3thLAuiBjYIurbY579qUYTe3uVKJTAFq01FjZbKiZGPy8kk1R604GTRM
	 doOTg1bjYjwSSdljwuO6PFvTq+bUg26esW3y9j7iPj2Gyg4C/Z1Keuz4fbrcZYwnXt
	 REIhhF+Bn+zVkQtOOHMr0eybZyzksc5iUewMcYRd48faQXgBxdWdAWUYh1PwtLhu5C
	 0miXZy8HHjK5A==
Date: Thu, 17 Aug 2023 21:49:21 +0200
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net 0/4] mlxsw: Fixes for Spectrum-4
Message-ID: <ZN55wV60Hu16R3Qs@vergenet.net>
References: <cover.1692268427.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692268427.git.petrm@nvidia.com>

On Thu, Aug 17, 2023 at 03:58:21PM +0200, Petr Machata wrote:
> This patchset contains an assortment of fixes for mlxsw Spectrum-4 support.
> 
> Amit Cohen (1):
>   mlxsw: Fix the size of 'VIRT_ROUTER_MSB'
> 
> Danielle Ratson (1):
>   mlxsw: pci: Set time stamp fields also when its type is MIRROR_UTC
> 
> Ido Schimmel (2):
>   mlxsw: reg: Fix SSPR register layout
>   selftests: mlxsw: Fix test failure on Spectrum-4

For series,

Reviewed-by: Simon Horman <horms@kernel.org>


