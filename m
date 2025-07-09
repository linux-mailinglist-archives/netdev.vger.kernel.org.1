Return-Path: <netdev+bounces-205323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27847AFE2EE
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0787C3B5EAF
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F88527C872;
	Wed,  9 Jul 2025 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB5WVXZf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEFA27BF7E
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050434; cv=none; b=B4Y+0Az+p9XwofskPAY6KWSeofaVW9pV7AFKZHoJFHTjqdQyUjUc/t6FaRcBI5pTy/2CTovxibCWqEzRsSvTk/Lz5yFUpS56O/2Kp2HP2fF2En5ETjPSPa6oJaF1JFHu83mtQJBuYvQAry/aBFjTniVYPxD9NDqwkkXv146h0ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050434; c=relaxed/simple;
	bh=S59xN26WAQeMijAoWuZmUBTqBfb0tIx5vCbzUeI3nC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWTde5g0VQAYN52CPUhg/SZVppnKv0mAvYmFfAtlo/vzUJiizDaaGo++fzkY9Pp5zMINNd/zhoVBmD/m+843ZqiIsEDKL7bw+mgh1eQWj9iuXpooGvVX1ORUnfa3ttNHSXaMfAjnbHh9/0MIEHFxJscipsNi/5SbLokH2ApijLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XB5WVXZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7789C4CEEF;
	Wed,  9 Jul 2025 08:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752050433;
	bh=S59xN26WAQeMijAoWuZmUBTqBfb0tIx5vCbzUeI3nC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XB5WVXZfO6fmnEiJ9Fp7AKIBclHVRg818av/BT7ZM9y7YSm7FRRefxDZnLswvnKfI
	 RU7bFrR5dUB4gm26W32j0ZZFzU4cPM/Fqeqao0vH/M6jFZksSiJDU1qIexWfUK8V4Z
	 Hk6BkP7chDz4fDX4oegNRozU/YetLGdAtORreCqAGGhsYMzctAH//ZIlgdfnY23qIu
	 Bjg+YcGPRF0nmvnUYQ0FqT0eEMsZFuXspkeknHeDQhlnkTiTmkujqb0g8VwIIzvtax
	 tqgR4VLFxSgBfyi+ngHTLsLN8ce/0hOHlMKUh1a+h7jf60vYtSF6SDFWVUTGiw/jEB
	 n5FUR9JdIeMwQ==
Date: Wed, 9 Jul 2025 09:40:29 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V6 10/13] net/mlx5: Implement devlink
 keep_link_up port parameter
Message-ID: <20250709084029.GL452973@horms.kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-11-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709030456.1290841-11-saeed@kernel.org>

On Tue, Jul 08, 2025 at 08:04:52PM -0700, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> When set, the NIC keeps the link up as long as the host is not in standby
> mode, even when the driver is not loaded.
> 
> When enabled, netdev carrier state won't affect the physical port link state.
> 
> This is useful for when the link is needed to access onboard management
> such as BMC, even if the host driver isn't loaded.
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


