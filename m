Return-Path: <netdev+bounces-47224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2437E8F66
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 10:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF44280C7F
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 09:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4BC6FCE;
	Sun, 12 Nov 2023 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="If4zPhhZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA226FBF
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 09:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98116C433C7;
	Sun, 12 Nov 2023 09:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699783033;
	bh=fkIhcR40LqUkSjGzYwB0k7PmkGBn/kWV/u39dj8cii0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=If4zPhhZw93wsrHZjN7BqIdfELx3UscrjyAeO6YQfJjkTdYQyguxytzBJerO3Nsc9
	 cyucy+2uF0znJVwPEspI5ruAKwP6iFvvpEi5WjfjRskv26qV4k/jkKRs5xSKW7xtrL
	 AGoBjd5J8aeJ7PHtTHD6r6XXyeyAjrI0T4w4CRhcCGFlHqpQMiqpKbANegRsinUl44
	 kCbwZmrl1yVUlTC0T7oFkMzpR66oIQwyEIcUVJL0po70iegdN9b9j7yk+G8IUFxJR0
	 P+jvmuc+rbV0avU4+PShQo5/gA7AlduGtG844XxqmeF+Qn8GwqmSZjbxILlt2tdcCW
	 wvvUXiC8oKX9w==
Date: Sun, 12 Nov 2023 09:57:05 +0000
From: Simon Horman <horms@kernel.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [RFC ipsec-next 1/8] iptfs: config: add CONFIG_XFRM_IPTFS
Message-ID: <20231112095705.GG705326@kernel.org>
References: <20231110113719.3055788-1-chopps@chopps.org>
 <20231110113719.3055788-2-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110113719.3055788-2-chopps@chopps.org>

On Fri, Nov 10, 2023 at 06:37:12AM -0500, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>

Hi Christian,

thanks for your patchset.
Some feedback from my side, I hope it is useful.

> ---
>  net/xfrm/Kconfig  | 9 +++++++++
>  net/xfrm/Makefile | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
> index 3adf31a83a79..d07852069e68 100644
> --- a/net/xfrm/Kconfig
> +++ b/net/xfrm/Kconfig
> @@ -134,6 +134,15 @@ config NET_KEY_MIGRATE
>  
>  	  If unsure, say N.
>  
> +config XFRM_IPTFS
> +	bool "IPsec IPTFS (RFC 9347) encapsulation support"
> +	depends on XFRM
> +	help
> +	  Information on the IPTFS encapsulation can be found
> +          in RFC 9347.

nit: the indentation of the above seems inconsistent

> +
> +          If unsure, say N.
> +
>  config XFRM_ESPINTCP
>  	bool
>  
> diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
> index cd47f88921f5..9b870a3274a7 100644
> --- a/net/xfrm/Makefile
> +++ b/net/xfrm/Makefile
> @@ -20,4 +20,5 @@ obj-$(CONFIG_XFRM_USER) += xfrm_user.o
>  obj-$(CONFIG_XFRM_USER_COMPAT) += xfrm_compat.o
>  obj-$(CONFIG_XFRM_IPCOMP) += xfrm_ipcomp.o
>  obj-$(CONFIG_XFRM_INTERFACE) += xfrm_interface.o
> +obj-$(CONFIG_XFRM_IPTFS) += xfrm_iptfs.o
>  obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o

Unfortunately, this breaks allmodconfig builds.

Please ensure that each patch survives an allyesconfig and an allmodconfig
build with W=1 set without new warnings or failures. [1].

I also recommend checking that no new sparse warnings are introduced.

[1] https://docs.kernel.org/process/maintainer-netdev.html#expected-level-of-testing



