Return-Path: <netdev+bounces-40464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CECFC7C773C
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079001C20FA5
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5DA3B78D;
	Thu, 12 Oct 2023 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQ2sVY7r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFED28E16;
	Thu, 12 Oct 2023 19:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDAFC433C7;
	Thu, 12 Oct 2023 19:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697140135;
	bh=JX7ZU2XiXw++bn1D18ecdFGhzCKpId5/KU2GQQr0DK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQ2sVY7rwTATyZWtaVainC2Bi+Ou4hsHYEsc7mupLgOr+D2qk2qc3Xyn+hIKdeRSH
	 uuNWJ0zxxbPNCe8LcIseklrUXJxmQ9XxrbKU48N8IStxCCNKohuqcHpCz3el+wQ3Kc
	 W7w51TyVK4XYmvm7fymS4fpCVsiAkI2ajl4cp8higGFiC/E5tYpTn6HXWLbmgFFajA
	 wvNY7Er4QIiDVFT+qUJFtt6ljilipKRUK8fN32NnqJZAz6QAkp83gJ0cVPsaF0T1B8
	 PMQfo/vL6tCfoQnOuGRsYc6eZn/br6naXFoQbH0a2huyGYC4OzNqMAXUaP9+pVi+b1
	 EiWc1593XwgaQ==
Date: Thu, 12 Oct 2023 12:48:54 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
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
Message-ID: <ZShNpk6mPNDYiFSj@x130>
References: <20231003231730.work.166-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231003231730.work.166-kees@kernel.org>

On 03 Oct 16:17, Kees Cook wrote:
>Prepare for the coming implementation by GCC and Clang of the __counted_by
>attribute. Flexible array members annotated with __counted_by can have
>their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
>array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
>functions).
>
>As found with Coccinelle[1], add __counted_by for struct mlx5_flow_handle.
>
>Cc: Saeed Mahameed <saeedm@nvidia.com>
>Cc: Leon Romanovsky <leon@kernel.org>
>Cc: "David S. Miller" <davem@davemloft.net>
>Cc: Eric Dumazet <edumazet@google.com>
>Cc: Jakub Kicinski <kuba@kernel.org>
>Cc: Paolo Abeni <pabeni@redhat.com>
>Cc: netdev@vger.kernel.org
>Cc: linux-rdma@vger.kernel.org
>Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
>Signed-off-by: Kees Cook <keescook@chromium.org>

applied to net-next-mlx5.



