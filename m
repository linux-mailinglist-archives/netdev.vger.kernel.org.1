Return-Path: <netdev+bounces-37847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E847B7519
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B1C8E281623
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66199405E8;
	Tue,  3 Oct 2023 23:37:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4B0405CF;
	Tue,  3 Oct 2023 23:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDE4C433C8;
	Tue,  3 Oct 2023 23:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696376221;
	bh=2qFD7ci96RgiVJyZ7j0nx2Ffl5SbucWr9eaZ/kne1Ow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aKqhO7eSDVXXXlqD8/5/qPoZcBCuGRokmV2bbWsSI+02G8FNPPO8omhm/p39IISqF
	 k0WsZxgPnFGSUuQzjIm15UFLB9MHX+ANjeTGDl3ykrCIDc2BBHSBo6HnyOnmEHj3le
	 SXYfhRwyQzu9ZHC0m51sAAS2O/foh0C0/kyLhIhWFbnf96Wb4V+pX63YmrVUWsAtK0
	 mp34Ud/3aIW9Rg7GklL79aGwLqmmpzz2THkAVUUvTyDM1NdG7Bibd7YG3H3O3NsU9N
	 HiB6VXEQ0PW63FzBnDUbrBUFbT3pQD8KRf100jcZdOJUldHbDnOAbKvU75X6/EXwFW
	 CqyNQa34bbKIA==
Message-ID: <5af06f3c-bc84-b73d-d7f7-a1154a5a84e1@kernel.org>
Date: Tue, 3 Oct 2023 17:37:00 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] nexthop: Annotate struct nh_notifier_grp_info with
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
References: <20231003232146.work.248-kees@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231003232146.work.248-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/23 5:21 PM, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nh_notifier_grp_info.
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


