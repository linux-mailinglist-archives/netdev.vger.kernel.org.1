Return-Path: <netdev+bounces-37863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C91637B76A9
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 04:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9F03B281442
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 02:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D262A57;
	Wed,  4 Oct 2023 02:41:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2795B7F1;
	Wed,  4 Oct 2023 02:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DDEC433C8;
	Wed,  4 Oct 2023 02:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696387268;
	bh=eVHXKXrgwrMb2F/BFyQ7m49d0FIN0HEfGgy1Zm1UBz0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qz26RcE1sZdQJLtl/NT6WLkkSGE7ajyPE/9yXbqemnV/aPcS5BXkao/r4wk1ithlc
	 kKmdvqMoGYuCkdvxAlAqbMkXJjVMdJD3Evz2RQkK64jKzj8a/H5ayHeA1AHrL+nUJ4
	 D4I/cbImn9QWsYcJCZYvtRZy3aWLIUThFdUETxZ9kI17bP9Hp3yRNLdJrXOUAQOuOR
	 ds7kW+HQJUyONNDshPPHTicQKvgbv51QTNi81mPwHVpAGDqQ7RACbVkwTn3W6xcdGV
	 f+id/zSpNbC+17Xm5KmIUluUpgbDn5TOfbU3DUaZaI6oZKshTWx9vALKm481QOGxct
	 kwh3UER7CcXLw==
Message-ID: <0b7640c4-e6ea-33f9-9477-78a6ddcb195c@kernel.org>
Date: Tue, 3 Oct 2023 20:41:07 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] nexthop: Annotate struct nh_group with __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
References: <20231004014445.work.587-kees@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231004014445.work.587-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/23 7:44 PM, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nh_group.
> 
> Cc: David Ahern <dsahern@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/net/nexthop.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


