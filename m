Return-Path: <netdev+bounces-127172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC5397475B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 02:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509D71C217A6
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 00:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B708460;
	Wed, 11 Sep 2024 00:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjgjE7Q7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62016B644;
	Wed, 11 Sep 2024 00:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726014423; cv=none; b=s4djcOqkI9T0a++J5WEFG0HDmViCjE6Z9hOuCPBEMbnYOoQTxAkkHucEzh73Szg+BNfx4l1m9cUvu/3o/dudUXUcapDvS5Er/Ak/+b/EEMxtXdnWjfnP2iQ9UBlXyPO96kb+sx5z1QCkdw7rMnSjMYISTUt4hCGsDnl4H5t0WEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726014423; c=relaxed/simple;
	bh=5274iZ8DDuZ6UF/AYxJL9A8/JlsyvGh4kdepPcKklAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hr/AV/X1FhdXl9XpO26zed1JYpGdQrrTc1sBMSDjIObnNyVPVUR5NnbhCNT994MjTQc7THng+rsqixuqNrUgqebQluzh46uPnERCgY+ZPbeyBuZgNqmIu5dIv6yscmgar/rf9ln5Ld9dQ7wqqrm56wd4UKuK6MEuzjGregDMojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjgjE7Q7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8B9C4CEC3;
	Wed, 11 Sep 2024 00:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726014423;
	bh=5274iZ8DDuZ6UF/AYxJL9A8/JlsyvGh4kdepPcKklAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PjgjE7Q7t10O/pJr6d0VuPbXOKPmop1Tx9gJ3ubXdOpDGSlb0b008a9Xs67XYvihf
	 nJW6P/ITStMOrd9dOzpR5fyNF5N5bBTiepx7kqeEnUFBsUNzUAxAVj5qmFDb+YEPel
	 RzAD3ErA+10o0Yx96FInjiuJgbqAoZwFo73tjmxoJljFV5CUiXlQrSB6wVrduVipq/
	 WSv5pWL9s4pHLqQJ5mGN1SZ/pYrN22BRfhrXejfktkSlRg5gjTMxBplDkzUJRUXC0a
	 hlOKMPt/sK0KfVY31RPYXjo5X0hlLAdlgh1SUAHci8PG1cAtHW1AiZLdpGxhN+zmaL
	 MifOyJzXDjBWw==
Date: Tue, 10 Sep 2024 17:27:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: jane400 <jane400@postmarketos.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] uapi/if_arp.h: guard struct definition to not redefine
 libc's definitions
Message-ID: <20240910172701.74164f87@kernel.org>
In-Reply-To: <20240909092921.7377-2-jane400@postmarketos.org>
References: <20240909092921.7377-2-jane400@postmarketos.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Sep 2024 11:28:55 +0200 jane400 wrote:

Could you please update the From fields in the email / the author of
the patch to have your full name like the sign off? Right now it says:

 From: jane400 <jane400@postmarketos.org>

> musl libc defines the structs arpreq, arpreq_old and arphdr in

Could you add some reference to when the structs were added to musl?
Web link, or a version number, perhaps?

> diff --git a/include/uapi/linux/libc-compat.h b/include/uapi/linux/libc-compat.h
> index 8254c937c9f4..e722c213f18b 100644
> --- a/include/uapi/linux/libc-compat.h
> +++ b/include/uapi/linux/libc-compat.h
> @@ -194,6 +194,14 @@
>  #define __UAPI_DEF_IF_NET_DEVICE_FLAGS_LOWER_UP_DORMANT_ECHO 1
>  #endif
>  
> +/* Definitions for if_arp.h */
> +#ifndef __UAPI_DEF_IF_ARP_ARPREQ
> +#define __UAPI_DEF_IF_ARP_ARPREQ	1
> +#endif
> +#ifndef __UAPI_DEF_IF_ARP_ARPHDR
> +#define __UAPI_DEF_IF_ARP_ARPHDR	1
> +#endif
> +
>  /* Definitions for in.h */
>  #ifndef __UAPI_DEF_IN_ADDR
>  #define __UAPI_DEF_IN_ADDR		1
> 
> base-commit: 89f5e14d05b4852db5ecdf222dc6a13edc633658

The code change looks almost good, I think you're missing the code for
handling getting included after the user space, tho? look around how
existing definitions are handled.. 
-- 
pw-bot: cr

