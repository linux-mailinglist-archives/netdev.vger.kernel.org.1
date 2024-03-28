Return-Path: <netdev+bounces-82820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2EF88FDEB
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC61C1C21BF3
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E84657A9;
	Thu, 28 Mar 2024 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7Xe7oac"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DCC59B73
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624792; cv=none; b=YeJSjsWNhgPU58TCFQozkxzEHrkrlKZp7jBfproLCwhq8cxARiTZuW2BFs57lmCY5gd4s79m/rpGHfNfynrqevGJaxa9ZBpL5PwEI9EEzzP1vmRkwGt6OTxl/iNCO6ycpU2p2MEXHmpNNZRqtjmQtz5XCxR4dhqEe0IHiteYbC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624792; c=relaxed/simple;
	bh=UDvbCzEyVGe8LX8kupLDuvrK9glI2bL2XqHEe3LtnbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFbsiKDPQNwJFnfLIhRXWD11CjTJdP0Gz1Vwd41jWFD6nYrb+WxBoKVqYTkVVzYqtEx1ioxKa0v0D9tjYmGoV5e3pdMtcopOLJ2BFtxNM4o4ocY8nJXjwYnHLQegM632kCS+vth75Cbvwo4FTRymNgL6zShvTp9CoHFrFJ0Jr0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7Xe7oac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F29C433F1;
	Thu, 28 Mar 2024 11:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711624792;
	bh=UDvbCzEyVGe8LX8kupLDuvrK9glI2bL2XqHEe3LtnbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k7Xe7oacQ0s0ZDScffV+KHkmRrdJEYZuzdKo4KRiQ50AYPiSbqXNa+1MpfRDCF2aI
	 SbMI7jckYM8I6Roa9URS9qlLvh7KVfOjrgbCgwvVQnsOzKtj32l7e3j/d6HFFjCUgU
	 D5i0lYzq5bckBthn7qdSmbkF5+Y8iwH9omKPWzElj/aYb3RbNHdPCTfNybDHMPn/Q7
	 uCEpAF5mPhb4IZ7+kYWc3z/DlXqk5wDZGN+0cOSx7wv5h5FOetMj/GKACBRZOYZ8RJ
	 tkIY6C69kpryVVrYha6CUEA4sTYXgUNoFAWRskerJ0SPZ0YhBOWG/So6vysOdB9I+S
	 jGybqluMNORNw==
Date: Thu, 28 Mar 2024 11:19:48 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next 1/8] net/mlx5e: Use ethtool_sprintf/puts() to
 fill priv flags strings
Message-ID: <20240328111948.GC403975@kernel.org>
References: <20240326222022.27926-1-tariqt@nvidia.com>
 <20240326222022.27926-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326222022.27926-2-tariqt@nvidia.com>

On Wed, Mar 27, 2024 at 12:20:15AM +0200, Tariq Toukan wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> Use ethtool_sprintf/puts() helper functions which handle the common
> pattern of printing a string into the ethtool strings interface and
> incrementing the string pointer by ETH_GSTRING_LEN.
> 
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


