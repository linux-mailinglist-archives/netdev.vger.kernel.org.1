Return-Path: <netdev+bounces-38036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D60147B8B0B
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 922881F22D29
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 18:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38621EA7C;
	Wed,  4 Oct 2023 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCz6fPWJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809441D6A9;
	Wed,  4 Oct 2023 18:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC99AC433C7;
	Wed,  4 Oct 2023 18:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696445131;
	bh=2imu9D3Z8TAnL2w/VZP/VIqsJlXJpUNbul4OIe8I16A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MCz6fPWJcorTD75aqEQSmwSmhDZufZ0eg12ZpmbultXKSI7554NgQ4mCitq3MiJA2
	 CampcKPjQwgI900hdL2SDQwM0P5xsuvug/Qc56rDAmOKqXNU7Ll5K6zaV7W+sJDqxX
	 6bFWjtn64KzEwOhwE7pEdVuRe72/bXFmSptgLPfIjUgBcMtCtFaq8ZL/JzVBNZRb2H
	 BipAKufOsbSh2wKzuOIMyP+HB5iXo7oyWoQtUplFXcEmn/MIc9OvyvzXrqKqgZ+yRb
	 ZrdmjM2/5QuvWv7zFGJbNtVV65iCdamrCgx/Yly9Wg5qwCt3OKKLZxhhsS9v+7NM4n
	 uKp3HYdhmcYkA==
Date: Wed, 4 Oct 2023 21:45:27 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] net/mlx5: Annotate struct mlx5_flow_handle with
 __counted_by
Message-ID: <20231004184527.GG51282@unreal>
References: <20231003231730.work.166-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003231730.work.166-kees@kernel.org>

On Tue, Oct 03, 2023 at 04:17:30PM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mlx5_flow_handle.
> 
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-rdma@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/fs_core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

