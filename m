Return-Path: <netdev+bounces-216779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B0BB351F0
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 04:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052FE686745
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1047D2765D6;
	Tue, 26 Aug 2025 02:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZPFXucw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07E71C8610
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 02:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756176886; cv=none; b=rEjHKiWRVP7RcYLf0mRZCh8a/1gbTU9HNcUOW1glWu2d/WJcn3QSlyER54oEt6S2ACO66orNt9OaoE7MQ2k22i3DRwiZinSb0P9YoHGiZ+w3xNq2oOmuFTdsJeocs84W4HO4YJQSW1c5lggFa9Ybpfx1hVsxy0lSEqeW98kyzP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756176886; c=relaxed/simple;
	bh=J7WbK8WqYdhxQSALeBfjS2F+jeikxYSQUfVfYKIufwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEmf8mal0/hIQQSARjTD/b18vNtlj5bYuT5n/RMQi77RkEPsm+c/x9oGxO2OqPlC7oepqjYvGwoI14fVxpvaT1eT+Y0UA91JFOUeg0HIkZllpwkxKwcHORTE1ODzmyx0gpomfkqNSP6nfC84+U2fQ6y1DsPgRESIEIJTHGwdyco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZPFXucw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA7BC4CEED;
	Tue, 26 Aug 2025 02:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756176885;
	bh=J7WbK8WqYdhxQSALeBfjS2F+jeikxYSQUfVfYKIufwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZPFXucwjdaZ8VIOiHtpzHNkwcptZjm5f5SuNmvMAB2SK00zNXPkgy0ooQyfrv5Nv
	 27wz55jXK4kUmir94L4czUaz+OlIMswthmQDLQJG6Ga9QoiXs5aIeVt2cUiERZ+RxW
	 Af0i9bipcp3RVzD22dEsRfU5/dLdh7nuXqus+AiHCgAeEiJeIVbL2KNe1gjzZYC+7I
	 /jOOvT0t1Y0NQC4aSg5lGhsGW15OnS/Sq0fI1pCiauUyrp2sqKUi1K7xyj4P37lGfh
	 vEGPND9rLSbaxyMAZXUkP9mtXuIr5rW+ye0IhUSxmppmJPakEX0/kQHJoBcXWSwFsM
	 GvB8ojTm5j4ew==
Date: Mon, 25 Aug 2025 19:54:44 -0700
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	dhowells@redhat.com, gustavoars@kernel.org,
	aleksander.lobakin@intel.com, tstruk@gigaio.com
Subject: Re: [PATCH net-next] stddef: don't include compiler_types.h in the
 uAPI header
Message-ID: <202508251953.F5194A2@keescook>
References: <20250818181848.799566-1-kuba@kernel.org>
 <202508182056.0D808624D8@keescook>
 <20250820101752.63be03da@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820101752.63be03da@kernel.org>

On Wed, Aug 20, 2025 at 10:17:52AM -0700, Jakub Kicinski wrote:
> I realized this include is to give kernel's __counted_by and friends
> precedence over the empty uAPI-facing defines.

Right.

> Not sure this is the most fortunate approach, personally I'd rather wrap
> our empty user-space-facing defines under ifndef __KERNEL__. I think
> it'd be better from "include what you need" perspective. Perhaps stddef
> pulling in compiler annotations is expected, dunno...

I'm trying to leave the door open for userspace to start using these, if
they defined them too.

> Would you be okay with:
> 
> diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
> index 6bbccb43f7e7..4c20c62c4faf 100755
> --- a/scripts/headers_install.sh
> +++ b/scripts/headers_install.sh
> @@ -32,7 +32,7 @@ fi
>  sed -E -e '
>         s/([[:space:](])(__user|__force|__iomem)[[:space:]]/\1/g
>         s/__attribute_const__([[:space:]]|$)/\1/g
> -       s@^#include <linux/compiler(|_types).h>@@
> +       s@^#include <linux/compiler.h>@@
>         s/(^|[^a-zA-Z0-9])__packed([^a-zA-Z0-9_]|$)/\1__attribute__((packed))\2/g
>         s/(^|[[:space:](])(inline|asm|volatile)([[:space:](]|$)/\1__\2__\3/g
>         s@#(ifndef|define|endif[[:space:]]*/[*])[[:space:]]*_UAPI@#\1 @
> diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
> index b87df1b485c2..9a28f7d9a334 100644
> --- a/include/uapi/linux/stddef.h
> +++ b/include/uapi/linux/stddef.h
> @@ -2,7 +2,9 @@
>  #ifndef _UAPI_LINUX_STDDEF_H
>  #define _UAPI_LINUX_STDDEF_H
>  
> +#ifdef __KERNEL__
>  #include <linux/compiler_types.h>
> +#endif
> 
> ? As you pointed out compiler_types.h is only included under stddef.h
> so the special handling in the installation script is easily avoided.

I think this should be fine, but something is itching at my mind that
doing __KERNEL__ checks in uAPI is fragile. I can't substantiate this
sensation, though. :P

-- 
Kees Cook

