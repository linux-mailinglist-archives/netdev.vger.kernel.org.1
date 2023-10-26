Return-Path: <netdev+bounces-44576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3DF7D8B87
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 00:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA840282166
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 22:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE433E48E;
	Thu, 26 Oct 2023 22:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOGBtMjl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F043D99D
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 22:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3ECC433C7;
	Thu, 26 Oct 2023 22:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698358479;
	bh=wdtxi9YB4Q7u6/Z/exalHB5taKXwpbqqYgnzOSqDJYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sOGBtMjlzkNafi0qHI+8/5DxxHZt/kBWocDwsMQVNApHs83eTyswpD4Mv5Nm18CdN
	 fNDKPHzW8d1okDP91OssQumyw2cRR7mzn/515BMAAqAvuL4JAijQGs3Tqj3z4u3GjS
	 /kJQOZpYNRFN2hIJ+AT6HqYVUdqTQV9NviN0J0tHl4Bw2cFozzVWVU0Q14CNh484io
	 keq7sWuLvUpC2bAu+HHNFBfSDQexzWPWaRqQ3iRBwSbvMVRdaJa80xeUrpzeZvTD8P
	 Prgs0SW1PfK+20KLMgnoCrMeSNPMjLdr751Hn36oVfpN//apZsjmt8CPWu0OtuiUFD
	 b5FC/ZIUgZ4dg==
Date: Thu, 26 Oct 2023 15:14:37 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Eran Ben Elisha <eranbe@nvidia.com>, Aya Levin <ayal@mellanox.com>,
	Simon Horman <horms@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH net-next] net/mlx5: fix uninit value use
Message-ID: <ZTrkzRi1g3TknBdj@x130>
References: <20231025145050.36114-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231025145050.36114-1-przemyslaw.kitszel@intel.com>

On 25 Oct 16:50, Przemek Kitszel wrote:
>Avoid use of uninitialized state variable.
>
>In case of mlx5e_tx_reporter_build_diagnose_output_sq_common() it's better
>to still collect other data than bail out entirely.
>
>Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>Link: https://lore.kernel.org/netdev/8bd30131-c9f2-4075-a575-7fa2793a1760@moroto.mountain
>Fixes: d17f98bf7cc9 ("net/mlx5: devlink health: use retained error fmsg API")
>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>


Applied to net-next-mlx5

