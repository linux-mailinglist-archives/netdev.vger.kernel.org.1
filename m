Return-Path: <netdev+bounces-82825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A5A88FDF1
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2351F25758
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9607D3E7;
	Thu, 28 Mar 2024 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2GGGrQO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A3C7C6D5
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624861; cv=none; b=p7TYGMjGhCt7enqZ2zCA4V9P6eSKJomKhNrWI43/NbWRLJmUZcgRaOj4rhIj2vu3d+HA71bS/4AbCZcJIOBcemb/iZmO4qGrDJ1zxZhJHTxvZuRY1ft2x1n6seeEDAFOfw8whsPHDIO3TLMM1vvjDVUuf1zvfftIPf08xx/q5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624861; c=relaxed/simple;
	bh=YekLr/MImJoKwkcciNha0biOsBqdylXQb6a9AbYnhho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oh+JXNteoByQvmg/Lk/1KaBGnp9F5hoZSMChdwmwuTJmv7fgRHQFZ5be994RisVtQKIIgoNLaPi2VuDseJkk0ffOXF3UjJ/rb4Q7ixuJthw1gSyr+a2J8HJN3lSICiS93i1Aj5oo3pp412zNNgMFg6Wwyj2XzqwJfmmkLHpEojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2GGGrQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F88C433C7;
	Thu, 28 Mar 2024 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711624860;
	bh=YekLr/MImJoKwkcciNha0biOsBqdylXQb6a9AbYnhho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U2GGGrQOfqB0WD3BOxFCBCkXRtV6HfMMJXyWiq8NZVlsKByKlATynMzQyCASPWmdN
	 a4+aarFqaxZOoixs/ATmbILy1di1dytE4VXCHTpRd8yzc7MkFst+n2JHlx9irLgLs1
	 0XdgoaEAEOj7oZ0+5a8s8Iw7tkmrG0gd7+AJmixpmzmSyUIBn4xIxNplBoSZaldhMV
	 bR34qHOW7YjHUMBmxm9JICVXAbbXu5fuS/SlWt21V2RTxAu2V3xUKF+qgwURye+IKV
	 bJGr3ZzWNZRZxydQtUnMJsR6urksFTBxANdVo7Hq8sa1IkkU/oSMR7mseJhcngviUI
	 q5teREHo97XjA==
Date: Thu, 28 Mar 2024 11:20:56 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next 8/8] net/mlx5: Convert uintX_t to uX
Message-ID: <20240328112056.GG403975@kernel.org>
References: <20240326222022.27926-1-tariqt@nvidia.com>
 <20240326222022.27926-9-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326222022.27926-9-tariqt@nvidia.com>

On Wed, Mar 27, 2024 at 12:20:22AM +0200, Tariq Toukan wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> In the kernel, the preferred types are uX.
> 
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


