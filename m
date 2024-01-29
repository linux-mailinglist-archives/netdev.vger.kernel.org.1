Return-Path: <netdev+bounces-66873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A6A8414B7
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 21:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4944B23453
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 20:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324BA7605F;
	Mon, 29 Jan 2024 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ern0Cf2O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5BD2E3EB
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561735; cv=none; b=jCGEXsdSoB67la7OicHNL8CT2EQtEGdZE5bxfzGvDxIs/eNEiWmgGQkW/6Gjh+5uR3dIhkq0ozk7gskA1FfEqVLESne8DQ+KRJ4K4OYzGScmWkW7aS0sEQVk16v0C1v+niBbHYHXWYnugtAQAGD9e1dpWFKA0lP4ZuItG2t+14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561735; c=relaxed/simple;
	bh=rrGAc97E3C2Zcg3A98S9vDGaNehjTs2T7FUMhUO5E/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LP9MsdbzcRRs1xIHp7Jfjrk6+MM1SzfMGkAQSAOHT+hmlVPWs/nmGGCn0pjqx70PmxSYOf46kUj00x4u0OVsvkxD0Z+sjhEquUYzKbl8Y7vmCcvBrZBJyqBCSQDSLxRtfDrhiecypUGeNa+zeEZUs5cX6cx+OFldcXCCYWUlyS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ern0Cf2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27515C433C7;
	Mon, 29 Jan 2024 20:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706561734;
	bh=rrGAc97E3C2Zcg3A98S9vDGaNehjTs2T7FUMhUO5E/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ern0Cf2OX/mYnzkhkTmC2h+4kHEaJoRGTASJ2BUnEzP9LnLkEj/YVE8op2MQ2d1G6
	 QcRoVijk4AyN0Aq6v2vkZt5tT0rU0GSl0XULhk9Fh2/FgVL9zvYzI59C7X8hIZvaLY
	 tY1944wCAXlrLUMBhjtIx/1PoN1kZAdGUvU6TUxbVt2Acp9BrgvyJZzJKi3am+WFb6
	 FIyWt9xPIjXo0qZoQNjj8ALjT+vU8sq3rc2/LhTeZUQNliiMVUFu146vy2/bAOJolj
	 GwLug/kseMx7Mqcd/Q1HLorvg2d+/B1Df0lWJ8gs5nW+/5cdCVb6ylNSU9icfSCT2E
	 lJ4RcAe61JNDw==
Date: Mon, 29 Jan 2024 20:55:29 +0000
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Hamdan Igbaria <hamdani@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [net-next 13/15] net/mlx5: DR, Change SWS usage to debug fs
 seq_file interface
Message-ID: <20240129205529.GS401354@kernel.org>
References: <20240126223616.98696-1-saeed@kernel.org>
 <20240126223616.98696-14-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126223616.98696-14-saeed@kernel.org>

On Fri, Jan 26, 2024 at 02:36:14PM -0800, Saeed Mahameed wrote:
> From: Hamdan Igbaria <hamdani@nvidia.com>
> 
> In current SWS debug dump mechanism we implement the seq_file interface,
> but we only implement the 'show' callback to dump the whole steering DB
> with a single call to this callback.
> 
> However, for large data size the seq_printf function will fail to
> allocate a buffer with the adequate capacity to hold such data.
> 
> This patch solves this problem by utilizing the seq_file interface
> mechanism in the following way:
>  - when the user triggers a dump procedure, we will allocate a list of
>    buffers that hold the whole data dump (in the start callback)
>  - using the start, next, show and stop callbacks of the seq_file
>    API we iterate through the list and dump the whole data
> 
> Signed-off-by: Hamdan Igbaria <hamdani@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
>  .../mellanox/mlx5/core/steering/dr_dbg.c      | 726 ++++++++++++++----
>  .../mellanox/mlx5/core/steering/dr_dbg.h      |  20 +
>  2 files changed, 615 insertions(+), 131 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c

...

> @@ -568,24 +927,41 @@ static int
>  dr_dump_domain_info_caps(struct seq_file *file, struct mlx5dr_cmd_caps *caps,
>  			 const u64 domain_id)
>  {
> +	char buff[MLX5DR_DEBUG_DUMP_BUFF_LENGTH];

...

Hi Saeed and Hamdan,

I am seeing some warnings which I think relate to stack usage like the above,
combined with inlining.

clang-17 W=1 build on x86_64 says:

 .../dr_dbg.c:1071:1: warning: stack frame size (2552) exceeds limit (2048) in 'dr_dump_start' [-Wframe-larger-than]
  1071 | dr_dump_start(struct seq_file *file, loff_t *pos)
       | ^
 .../dr_dbg.c:703:1: warning: stack frame size (2136) exceeds limit (2048) in 'dr_dump_matcher_rx_tx' [-Wframe-larger-than]
   703 | dr_dump_matcher_rx_tx(struct seq_file *file, bool is_rx,
       | ^

gcc-13 W=1 build on x86_64 says:

 .../dr_dbg.c: In function 'dr_dump_domain':
 .../dr_dbg.c:1044:1: warning: the frame size of 2096 bytes is larger than 2048 bytes [-Wframe-larger-than=]
  1044 | }
       | ^

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.h
> index def6cf853eea..13511716cdbc 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.h
> @@ -1,10 +1,30 @@
>  /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>  /* Copyright (c) 2021, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
>  
> +#define MLX5DR_DEBUG_DUMP_BUFF_SIZE (64 * 1024 * 1024)
> +#define MLX5DR_DEBUG_DUMP_BUFF_LENGTH 1024

...

