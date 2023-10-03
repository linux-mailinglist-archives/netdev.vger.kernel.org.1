Return-Path: <netdev+bounces-37845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CEA7B750A
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9EBF11C204FC
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94FA405E1;
	Tue,  3 Oct 2023 23:36:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8980B3FB09;
	Tue,  3 Oct 2023 23:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DD1C433C7;
	Tue,  3 Oct 2023 23:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696376184;
	bh=fI3/kyfV7jlL4X9PoxBOPNL9WBh1qBNy9eYiQsgGgSQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bfCgu8UOFEbSxlRRSBcr6Mo/IaVwxwXRv3F6KcN3YXgtqFctyCt8UPAnhgJi1CbnP
	 f9RSK5kVCxsirJsJZ78u+sU1E9d6gOgm5EFsw23N6C1rJ3dF8JDoyMXiTFbZOVlRqC
	 uS/SdSy5xvVbDAWyjv02/5ugtze9VRcerFiVvPB+6LGus4GabR/miD+S/72wC0eCqj
	 eStOVGxKzXbVhuT+S40ihgC7vPWe6WADyRQkpt8uPXbQ6vVANpViX6qAs49dAAKoV3
	 WKdyTrP7kKwAh55Phml/AgN9hBa9RPCCQ0ra1CzxH8aDE7eXk0nEAfClfrcOrsT374
	 VzxhT4m1C6tSQ==
Message-ID: <e1292bf3-678d-3ea8-c8dd-fcb106caa9d3@kernel.org>
Date: Tue, 3 Oct 2023 17:36:22 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] nexthop: Annotate struct nh_res_table with __counted_by
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
References: <20231003231813.work.042-kees@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231003231813.work.042-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/23 5:18 PM, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nh_res_table.
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



