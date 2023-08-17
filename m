Return-Path: <netdev+bounces-28297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 071F477EF15
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 04:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76671C21185
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 02:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787A4397;
	Thu, 17 Aug 2023 02:29:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69167379
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 02:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A01C433C8;
	Thu, 17 Aug 2023 02:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692239356;
	bh=MU/nBpIEM5zOGcfZKwamin6GRaWleLDz+5CUYP7mSGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cdurCLhpKtLZoGwX5GMSknQNngnVJ4b4ptD7EFr1+Xgz7zMAOHe2YuDntOfSrC9KZ
	 1nn5pnmFHbo0avtQ11QOUmjdsSxcSOUcq+fuwx9ssjl3A7WguUaGDnorq72qgfsgHn
	 2aTge8LuuIB+MuFA7huLjIp42NWDSoNX0ti/P4YTuGhAUJoqYDiTU/DEwQb0Vs/BYx
	 fNr+iJVDDoVn9PojuQ5qwAdn1BtjoJjI8rurqM0DapRW53HY5mh5CPx00z+gEiB5P2
	 3hJbdZrVgyZe8gPQHIXXBdLIvMJ5lioto+WjgrUTR/2CAPkiU1a5dyhVJaZbwBKND4
	 BtEOaYNWycZlw==
Date: Wed, 16 Aug 2023 19:29:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, linux-rdma@vger.kernel.org, Maor Gottlieb
 <maorg@nvidia.com>, Mark Zhang <markzhang@nvidia.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: Re: [GIT PULL] Please pull mlx5 MACsec RoCEv2 support
Message-ID: <20230816192915.7286828c@kernel.org>
In-Reply-To: <ZN1N6WOpHUkhQspA@x130>
References: <20230813064703.574082-1-leon@kernel.org>
	<ZN1N6WOpHUkhQspA@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Aug 2023 15:30:01 -0700 Saeed Mahameed wrote:
> Are you planing to pull this into net-next? 
> 
> There's a very minor conflict as described below and I a would like to
> avoid this on merge window.

I'm not planning not to pull it.
It's just a matter of trying to work down the queue from the highest
priority stuff. I have to limit the time I spent on ML & patch mgmt,
because it can easily consume 24h a day. And then stuff that's not 
the highest priority gets stuck for a little longer than it would 
in an ideal world :(

