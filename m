Return-Path: <netdev+bounces-137119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A536D9A46AB
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 21:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8FA1F21859
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E94A204F80;
	Fri, 18 Oct 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnmaPa9z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F403F204F6C;
	Fri, 18 Oct 2024 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729278899; cv=none; b=R5Tcqw1ObtjqioC8vAqvzm6Kroal0iwWkhs6vbfhCkzF47yQ8IX+2AYdj4ctfzEdRWMFilS7AOsXFYYIGlZ906L0EehOwKWG/A0xZ8JKXjYCjRiMzuIv5CwUAXtrRbU4CCbg7nmTZw3I8M35EsSgmg3G6HAi69L324IvR46IWv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729278899; c=relaxed/simple;
	bh=3kyFW5CsF4mTpYfjD2GHgDqBA+P1Plio99jsPISkx68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1AgrUJ7YNv+olWFcBJ7zPkafkkGHhe8Qa8d9zyQ0SQ8wzguZBVKrvHgOD4Z+l+iRP1J97gLTSqlzZH2xR8B3OeowEBEM2Aafvsy/JcEaOsqHglZiBGdU/ocC6QnoiZHH8FlPU1XTcthY86nBmSvZfIO6expuLylIcJgdIFyCo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnmaPa9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98417C4CEC3;
	Fri, 18 Oct 2024 19:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729278898;
	bh=3kyFW5CsF4mTpYfjD2GHgDqBA+P1Plio99jsPISkx68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HnmaPa9zKzb7CY3EntHARh7+ql+w8y18kdxAfY9VjP/Zaa5ewExf/G4EupLGWxzpE
	 RskU7eK6se0Q99zJRFdutu0QvSVcLMZxy9aXET7MYmkSDUTmB7OJBUfOvFXSLAQ3g0
	 K5XP9EaGhD6h5BH4U407VQKHtLt55ItBOBRe1Cvg/IYVNMrrjKJS2h4BA2RaUZJ0T8
	 mgbVWDrqwDbQbSPnOl4PGHlezFGMH+6ClA8Et3gEEX2eDUVo8d+HXrRLuR9kSMX0E0
	 DENCXqgOsp8pR7Q06V1SsgvwtVZngzz1mbShytZI52H9C8WykKvtWHNV/YhSwX/UBc
	 4osUsa3PlKsaQ==
Date: Fri, 18 Oct 2024 20:14:54 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kevin Hao <haokexin@gmail.com>,
	Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	linux-kernel@vger.kernel.org, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCHv2 net] MAINTAINERS: add samples/pktgen to NETWORKING
 [GENERAL]
Message-ID: <20241018191454.GZ1697@kernel.org>
References: <20241018005301.10052-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018005301.10052-1-liuhangbin@gmail.com>

On Fri, Oct 18, 2024 at 12:53:01AM +0000, Hangbin Liu wrote:
> samples/pktgen is missing in the MAINTAINERS file.
> 
> Suggested-by: Antoine Tenart <atenart@kernel.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v2: fix alphabetical order, make patch target to net (Simon Horman)

Thanks, looks good.

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 44d599651690..e5dff2a7b868 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16200,6 +16200,7 @@ F:	include/uapi/linux/rtnetlink.h
>  F:	lib/net_utils.c
>  F:	lib/random32.c
>  F:	net/
> +F:	samples/pktgen/
>  F:	tools/net/
>  F:	tools/testing/selftests/net/
>  X:	Documentation/networking/mac80211-injection.rst
> -- 
> 2.46.0
> 

