Return-Path: <netdev+bounces-123488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 737E09650C5
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255EE1F22DFC
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DFB1BA88F;
	Thu, 29 Aug 2024 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdV/Xjc/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69281B5ECB;
	Thu, 29 Aug 2024 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724963299; cv=none; b=elZKVU39QHT5oz05A/gV1uo4qQACXhUZtBauc0t9Qa0KGmNXyynpl4fiVyEDm1zp/bVoGN3v1eHU5qbjgXVXuX+b8IeuczkdtZ96JIkpHIV3I4VAoPjvTKRuNrevrk2a9q+oNPO/qdErX0bi4zDTcTErHoSRqHxQ53jtMo/MFLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724963299; c=relaxed/simple;
	bh=i0qdHcJ/dupKKN3tC9rUG8mz/Zxg0d3R3FkWVUHIBPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJqw15uvQoUQ2/xUIAKfUwbzachhchbk00hhRwGL6AZuj794/LuZvTfjv5BZDDpIy+giFF5PfBzyfX6bl9HrnB8hclbcU7UlgxevI5uZsVvInntdplZ2RiIErZTFUwrw6Oz0iTUwLb7wqDm1FrUtoPPBVCA00ylAXCPoKWzl0Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdV/Xjc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC191C4CEC1;
	Thu, 29 Aug 2024 20:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724963299;
	bh=i0qdHcJ/dupKKN3tC9rUG8mz/Zxg0d3R3FkWVUHIBPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kdV/Xjc/m8JAQWfr8ckr/TNUgFJz6m31x2nB0w/w2gp7qlMPP8MS12FBSaJQAfhAz
	 6J7bTA7isS21fsr7XOoeX0OMQRISZ58bAy8anhQshKanZgFt8Shxa9XTwHETbKITBV
	 GLoHOGnIFYr+06nuiF6S6ZLuAt0l2u0fTvGan6low3gxvzwIjrsVSlba6T/l8P8Y8G
	 2ea79t8rdCM93gvsuHV3tCm6wKlmI2WpX/Y1M6KQ9DVjXn26DeDnCZ7Ctbq8H8H35F
	 H9IZlJoL2Fr90QFN4vsmRaK3Fetg2Un4iMNCAPk9PtqKcDkRDz0GllA+ynne4n0ZS/
	 E3GRpHQ10PK3g==
Date: Thu, 29 Aug 2024 21:28:15 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew@lunn.ch, corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: document guidance on cleanup.h
Message-ID: <20240829202815.GA1368797@kernel.org>
References: <20240829152025.3203577-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829152025.3203577-1-kuba@kernel.org>

On Thu, Aug 29, 2024 at 08:20:25AM -0700, Jakub Kicinski wrote:
> Document what was discussed multiple times on list and various
> virtual / in-person conversations. guard() being okay in functions
> <= 20 LoC is my own invention. If the function is trivial it should
> be fine, but feel free to disagree :)
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: andrew@lunn.ch
> CC: corbet@lwn.net
> CC: linux-doc@vger.kernel.org
> ---
>  Documentation/process/maintainer-netdev.rst | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index fe8616397d63..ccd6c96a169b 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -392,6 +392,22 @@ When working in existing code which uses nonstandard formatting make
>  your code follow the most recent guidelines, so that eventually all code
>  in the domain of netdev is in the preferred format.
>  
> +Using device-managed and cleanup.h constructs
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Netdev remains skeptical about promises of all "auto-cleanup" APIs,
> +including even ``devm_`` helpers, historically. They are not the preferred
> +style of implementation, merely an acceptable one.
> +
> +Use of ``guard()`` is discouraged within any function longer than 20 lines,
> +``scoped_guard()`` is considered more readable. Using normal lock/unlock is
> +still (weakly) preferred.
> +
> +Low level cleanup constructs (such as ``__free()``) can be used when building
> +APIs and helpers, especially scoped interators. However, direct use of

Sorry to nit-pick: iterators

> +``__free()`` within networking core and drivers is discouraged.
> +Similar guidance applies to declaring variables mid-function.
> +
>  Resending after review
>  ~~~~~~~~~~~~~~~~~~~~~~
>  
> -- 
> 2.46.0
> 
> 

