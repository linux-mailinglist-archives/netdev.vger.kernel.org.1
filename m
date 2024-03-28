Return-Path: <netdev+bounces-82824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897C288FDF0
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C8BB21897
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2BE7E0F3;
	Thu, 28 Mar 2024 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktJIh5LF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D3F7D410
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624850; cv=none; b=iQj/r3tDn40kcbSuPackySiwVyKP9ehJls0j08OyjPNxiZBLjMNVPbSYsHQbInX27vG9zcCFItsOWopUZ+QOQreGQLWWVhes4ROeIkFuWfP/IpjOvZ/a7pIZLlxTmO9OZ4Bcb4xujKS5uau+7FInKbrBrlJIlcplTPyOuf1wKwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624850; c=relaxed/simple;
	bh=sM7of8qT9/y29zjVKUiH59iW0dHi08xSC6fvrsB4t98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3/i+gGs7cWNbmYdJ4F+z4VPKqKXJ2VXPNzV5xB479RU/LnIALhDrC/VkYCza+q7At1qixGvUX1SV5frbOJuqXdMqdlOR2uDX+Xp+fRWEkFyjQKxP6sz3k0B/awTq3qnKODujVgdLOB59BLhIdGiSI6ds9+dUeyQ9YBSHbg7S4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktJIh5LF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB49CC433C7;
	Thu, 28 Mar 2024 11:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711624849;
	bh=sM7of8qT9/y29zjVKUiH59iW0dHi08xSC6fvrsB4t98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ktJIh5LFWlNufkLbAD4geDw5siPaO6jftw97xpqf4kSxCjfXSaxoz6ThqLeVn0yjV
	 1zt8OoHczkHypiEXvoEcTgLFsUSKogwv7YjYj93eDCNTrH/3ri/P4mmUvGunnHGhN9
	 O1cKPfHe3PtCEbBa+f/NbMtDdd6BWMU6n/ZrQ+06KWzehCO+Y2GnwNyWP3g2JxB+aX
	 +GFyrAuGglYclJOmWYQscaJC8dfHGrcYT3LWylBMAYah53lJZnk0cTCetcX8JDVC6p
	 aC8VcjVWioVS0nRR8HrhUP+OiiIOkmQvXVpzyvGQzlErEce8UgFbALqQw1Oyl1GrKu
	 SEYg/sM9qFywg==
Date: Thu, 28 Mar 2024 11:20:45 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next 6/8] net/mlx5e: debugfs, Add reset option for
 command interface stats
Message-ID: <20240328112045.GF403975@kernel.org>
References: <20240326222022.27926-1-tariqt@nvidia.com>
 <20240326222022.27926-7-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326222022.27926-7-tariqt@nvidia.com>

On Wed, Mar 27, 2024 at 12:20:20AM +0200, Tariq Toukan wrote:
> Resetting stats just before some test/debug case allows us to eliminate
> out the impact of previous commands. Useful in particular for the
> average latency calculation.
> 
> The average_write() callback was unreachable, as "average" is a
> read-only file. Extend, rename,  and use it for a newly exposed
> write-only "reset" file.
> 
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Gal Pressman <gal@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


