Return-Path: <netdev+bounces-61180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58317822C7F
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 12:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB821F232BC
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 11:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6165318EBD;
	Wed,  3 Jan 2024 11:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8A016ia"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F661A710
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 11:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434BFC433C7;
	Wed,  3 Jan 2024 11:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704283013;
	bh=vJ5jyGBw1lO0kwYBWY53912OTBGP2INGrhz5BagMxiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8A016ia/ba7fHAmbI7hljeAouDs4TNUaI1BZKoHlUvWdr9iU/brK+xo/k90Asl0K
	 gDmeb3IELBONZfezK+NQaJMCJyRxnXq7zzoGtPwosjbMS4RgK9JRNXx4q4asgr+bP+
	 OVt7rl4/mhQLN6PjLhDIHkt1o1zEAAn6wZqx5trxZNvprVHb+OfGiGuqbcRkBiKkFK
	 7Q0DMkEvMM2gar9w5KrBMAB5kVnsfQenJA9gXKfX79tu94uAW6PvKax2H5MnxE6ip2
	 2uThi4GwRfYee2K0UTquO3Gqy9mssm7qOH628i6jfaOp1X7Kn5qNKBGy/v4a7A20jn
	 X00L+i5u3Uetg==
Date: Wed, 3 Jan 2024 13:56:49 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] rdma: shorten print_ lines
Message-ID: <20240103115649.GC10748@unreal>
References: <20240102164538.7527-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102164538.7527-1-stephen@networkplumber.org>

On Tue, Jan 02, 2024 at 08:45:24AM -0800, Stephen Hemminger wrote:
> With the shorter form of print_ function some of the lines can
> now be shortened. Max line length in iproute2 should be 100 characters
> or less.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  rdma/dev.c     |  6 ++----
>  rdma/link.c    | 16 ++++++----------
>  rdma/res-cq.c  |  3 +--
>  rdma/res-qp.c  |  9 +++------
>  rdma/res-srq.c |  3 +--
>  rdma/res.c     | 11 ++++-------
>  rdma/stat.c    | 20 +++++++-------------
>  rdma/sys.c     | 10 +++-------
>  rdma/utils.c   | 15 +++++----------
>  9 files changed, 32 insertions(+), 61 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

