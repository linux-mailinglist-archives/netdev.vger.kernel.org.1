Return-Path: <netdev+bounces-36244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB967AE96D
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 11:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E9F482810A6
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 09:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E41134D0;
	Tue, 26 Sep 2023 09:39:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70FE12B70
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 09:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FBDC433C7;
	Tue, 26 Sep 2023 09:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695721155;
	bh=AnTJXPiJiPV4M7FfzIw4U1feaoScrcoS51aixAIgF3w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DP4/3ICboAtuex0rLt47pvfLL3/RpYL6P55AKFzcXmVGZnH0i6TjpWMJrlhHiYn9k
	 MhAXJZRWAp9kThHiH/VTOGUh5AskLNX4OMUIOUStCAqYAJ/tQuLHukGzMdqgpbayHR
	 zmReRYdRUWY18/wvTO9lm8rsdEzMPn6Feb4r06u9zm7pmBgPHy4Ax7zrlY7GDPiV03
	 IMDkQMwDydoyY33amfyXPO9eMuD3bxS9UxxZl1cfLcK6FNpKmuZ1lB7UShYo5P725S
	 ZO1IfpRmkWfsLGQREkgTfxuiqzUkJys4aG4nec+fY6NHcDv/52mBXOZbGdimMUETzh
	 LBUzEWnj+nhkA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
 Or Har-Toov <ohartoov@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
 Patrisious Haddad <phaddad@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>
In-Reply-To: <cover.1695204156.git.leon@kernel.org>
References: <cover.1695204156.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next 0/6] Add 800Gb (XDR) speed support
Message-Id: <169572115099.2612409.2085687465811625783.b4-ty@kernel.org>
Date: Tue, 26 Sep 2023 12:39:10 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Wed, 20 Sep 2023 13:07:39 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This series extends RDMA subsystem and mlx5_ib driver to support 800Gb
> (XDR) speed which was added to IBTA v1.7 specification.
> 
> [...]

Applied, thanks!

[1/6] IB/core: Add support for XDR link speed
      https://git.kernel.org/rdma/rdma/c/703289ce43f740
[2/6] IB/mlx5: Expose XDR speed through MAD
      https://git.kernel.org/rdma/rdma/c/561b4a3ac65597
[3/6] IB/mlx5: Add support for 800G_8X lane speed
      https://git.kernel.org/rdma/rdma/c/948f0bf5ad6ac1
[4/6] IB/mlx5: Rename 400G_8X speed to comply to naming convention
      https://git.kernel.org/rdma/rdma/c/b28ad32442bec2
[5/6] IB/mlx5: Adjust mlx5 rate mapping to support 800Gb
      https://git.kernel.org/rdma/rdma/c/4f4db190893fb8
[6/6] RDMA/ipoib: Add support for XDR speed in ethtool
      https://git.kernel.org/rdma/rdma/c/8dc0fd2f5693ab

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

