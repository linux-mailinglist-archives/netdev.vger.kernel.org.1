Return-Path: <netdev+bounces-205324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8066BAFE2F1
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFC34E7992
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F0127CCCD;
	Wed,  9 Jul 2025 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2B9W//p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDCE27C872
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050449; cv=none; b=jrmEZP5iGJYPLmVEu4FyV+CsTqgIv2reTcjdKcqDm/rzXyYLkXqbXHPPJpnzyKLEIbkaZt3RsIex2Giv99FNTMnhkJAzXBZiO3p+GAsUtsq8gpCTYjUNQu7jbJKTzGYRKsm/CroT8Gw3n3ZjcJpbDO8mtqepJR015+s550y7l30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050449; c=relaxed/simple;
	bh=fXoBlQGjo8GvTrJFBO9gTXuoAtwQrbJNJjHLWJ4Ah7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEJR7f+qY1vJwjug8CkN4Hu0lvOQbIeyj8hH9+DavNxBjSzD8KRSXbJN/6EhPeYNb6vkrlHGQ1lXEwFLzLnihlxQG7C3WXNkz82ofdahKN73k9b8z+2e+IcGv0bL9ilrEkIb2vfX9NvWN/z4rlB43T/DjZTrgTV52cdpSN5Vylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2B9W//p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B493EC4CEF5;
	Wed,  9 Jul 2025 08:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752050448;
	bh=fXoBlQGjo8GvTrJFBO9gTXuoAtwQrbJNJjHLWJ4Ah7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2B9W//pwWR5ebbcpAfgG1YC/9bo7nm3WYh8cNTiDPiYRFxyIRmptb5pDPbX4i31p
	 L/x9+XhnOrzxo0q/NEa4TJlW2BD5vBYFvf8reirrzMPcNlbQZkzLMdwhkgNWNHqlPz
	 5z6qY9j7zU3NxliL2oopPrFvxL6StyozrEYF5mUcNQ0xINKyfFeXwAcf+37vEEQI9o
	 ea0fF3Qcv7y9WwCHcRAxi4QlSlJfHa20PqxyS3ui/Ce3n2hTO1vHyWu/7T3Nrbu8JV
	 pgMy77PS5CJ77YKuepwZYuDYigInJg/crFsYBMDRm+z9Wmi9xU+MKop2PrKPK7meKc
	 bZJy2JnV9ZjMQ==
Date: Wed, 9 Jul 2025 09:40:44 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V6 11/13] devlink: Throw extack messages on
 param value validation error
Message-ID: <20250709084044.GM452973@horms.kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-12-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709030456.1290841-12-saeed@kernel.org>

On Tue, Jul 08, 2025 at 08:04:53PM -0700, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Centralize devlink param value data validation in one function and
> fill corresponding extack error messages on validation error.
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


