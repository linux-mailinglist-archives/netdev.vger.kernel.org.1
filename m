Return-Path: <netdev+bounces-44587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6C37D8BD3
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 00:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3421C209A6
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 22:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75216273D1;
	Thu, 26 Oct 2023 22:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6esuD2B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584218BFD
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 22:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D820C433C7;
	Thu, 26 Oct 2023 22:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698360494;
	bh=ZUUtoMOmeBlBhtXVE8Cuph61LHIPCHr9OivK6H+jN9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T6esuD2BlPH6biLwr8jtZD5TxnvxuRsQMbLxkLknEWrLkjcKo7pi10Llnxe5PNx1E
	 qMtV4YcuRGU8Pypz7aHC8Vr8VAO1mQ9b9lOaSxAqC2nULonFyS/n78aNKyf4l81OuE
	 v3PfRZswkASw0xXVCAYJuyY+qgsUXhIuHazSoffByqiDcxLTfT2tfq1Dr6A8JChVLw
	 dkz3wcO24zWVR7KGPNGMOatGh/1ediUsPcUMyWvrz7mo2RzNCl3vHwDtQYdzLUf6jO
	 iWGHC/2YR7YwWsrUW+bw/idR/c3KdU06o8E4AgAKnXljKctm7rGZrBwAp9n6MfJ85E
	 ysr1S+h7YtyQQ==
Date: Thu, 26 Oct 2023 15:48:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Danielle Ratson <danieller@nvidia.com>, Ido
 Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Moshe
 Shemesh <moshe@nvidia.com>, Eran Ben Elisha <eranbe@nvidia.com>, Aya Levin
 <ayal@mellanox.com>, Simon Horman <horms@kernel.org>, Dan Carpenter
 <dan.carpenter@linaro.org>
Subject: Re: [PATCH net-next] net/mlx5: fix uninit value use
Message-ID: <20231026154813.4682f7b8@kernel.org>
In-Reply-To: <ZTrkzRi1g3TknBdj@x130>
References: <20231025145050.36114-1-przemyslaw.kitszel@intel.com>
	<ZTrkzRi1g3TknBdj@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 15:14:37 -0700 Saeed Mahameed wrote:
> >Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> >Link: https://lore.kernel.org/netdev/8bd30131-c9f2-4075-a575-7fa2793a1760@moroto.mountain
> >Fixes: d17f98bf7cc9 ("net/mlx5: devlink health: use retained error fmsg API")
> >Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>  
> 
> Applied to net-next-mlx5

Given the hold up with your PR I prefer to take this directly, thanks.

