Return-Path: <netdev+bounces-37846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6907B7516
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id B9A281C20441
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06631405E2;
	Tue,  3 Oct 2023 23:36:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A9C405CF;
	Tue,  3 Oct 2023 23:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB364C433C7;
	Tue,  3 Oct 2023 23:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696376208;
	bh=JlZKAr1MFKBroi3aiHBMj5smlSqGSHEUMHgaW1Fzld8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DiN7HWwAoSs3mW7jauE9BquMRpLtWxVfnh3UZ1Gmq/bSNNiaADXEwsx9ISXyApOJq
	 755IQVY6QgI/evjKL0Erfk3cgxFNDXFgudhzlY2Rw0+tza8UVdHvnnjMtJe7bdqYQ/
	 nfSye/GQRDLY1E76J/Ww/DPrFFu6SyS9jqEmvM0UYZB3+QEpUYD3N0N7oAkjbJL5GC
	 /epq5QcS5FagvTZ6n9AyM25N0EPt3FYeYmIjAkmuKa4W5k40qgzqTSjJHDEcUMksOK
	 i/MfI0/aqH8oTp4/3oD3t1bUxq4lLp6GkZapoFRsGZkHsAEN/x9t/yULq7gy+cx06f
	 e/Tc5dvZRC7xg==
Message-ID: <164ebd58-2ee3-bff1-48e7-fe430fb27e6b@kernel.org>
Date: Tue, 3 Oct 2023 17:36:47 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] nexthop: Annotate struct nh_notifier_res_table_info with
 __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 netdev@vger.kernel.org, llvm@lists.linux.dev,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20231003231818.work.883-kees@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231003231818.work.883-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/23 5:18 PM, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct
> nh_notifier_res_table_info.
> 
> Cc: David Ahern <dsahern@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Tom Rix <trix@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/net/nexthop.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



