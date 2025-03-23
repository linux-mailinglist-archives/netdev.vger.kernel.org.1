Return-Path: <netdev+bounces-176972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0430A6D064
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 18:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9803E188A326
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 17:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F321624CA;
	Sun, 23 Mar 2025 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6XJt1ai"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D63815666B
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742752049; cv=none; b=HT8A4yaq1N0txfpGfOi6ODiCNlxKWKUxjl/v7WH3MFi4sg2FSbBliHXYUXwQYZBh3yqwBxTYxalE8Z65WxjWulOkVvKw3x7eEbw77Lr9IDZugqXeCy1HS9iIABGtVxmzWQR45q5UyCBIFQ0mTBPfkkyZUWyfSY0MPD7PtaF4Bqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742752049; c=relaxed/simple;
	bh=6RsfD2c0SoS5pxE4ZvPFB4MF28u4KgyeEYe9kkwU1nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9qavZN5ljXTY2+sH4hSVOOi4V9SK3rLMsudeVD3aS/uRMalVc0BfKvA4USQ6EnGz6rlrs8OaogGjqENh8syb3Nht4FN8ch7qSURsCoVDK4aNHF+DnC0MU+3qMqlEUD0yqTJZPC6FBIMQGwT77JT7fSQtChzu/I+ObmpYxRLomE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6XJt1ai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234A6C4CEED;
	Sun, 23 Mar 2025 17:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742752049;
	bh=6RsfD2c0SoS5pxE4ZvPFB4MF28u4KgyeEYe9kkwU1nE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6XJt1aijHhg8YnZSqf4Cl0UZMPFUjmTL7u8Mqoe0GraA0QWvlbn+U7d848KcWVBS
	 LniTvKxGSPvOBN9PVYLURdFNN5EwjWRi7A5DvrNE2Kymgc967fqWkq73QGmkfkHuka
	 +gfcjz6bfLvFaoaJXgNgsbz/3riNdATFWyl8gIhaHeVUI9TtfZ2cAubuw6bUid5gG5
	 Ms3oKsoiSKBesTMf2uF3Tl5sXDcraAznMA4FwZ8LpCLJiuGFwodPmxrocb//Jtr+kv
	 JZASOxZGdS9LkjKI2xxPlEH7qLg6O0Za86/BEv1xpYI9F4znWcUjJDR/TK6+CoQ3g7
	 uzGXiYKawO12g==
Date: Sun, 23 Mar 2025 17:47:23 +0000
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch,
	donald.hunter@gmail.com, parav@nvidia.com
Subject: Re: [PATCH net-next v2 2/4] net/mlx5: Expose serial numbers in
 devlink info
Message-ID: <20250323174723.GA892515@horms.kernel.org>
References: <20250320085947.103419-1-jiri@resnulli.us>
 <20250320085947.103419-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320085947.103419-3-jiri@resnulli.us>

On Thu, Mar 20, 2025 at 09:59:45AM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Devlink info allows to expose serial number and board serial number
> Get the values from PCI VPD and expose it.
> 
> $ devlink dev info
> pci/0000:08:00.0:
>   driver mlx5_core
>   serial_number e4397f872caeed218000846daa7d2f49
>   board.serial_number MT2314XZ00YA
>   versions:
>       fixed:
>         fw.psid MT_0000000894
>       running:
>         fw.version 28.41.1000
>         fw 28.41.1000
>       stored:
>         fw.version 28.41.1000
>         fw 28.41.1000
> auxiliary/mlx5_core.eth.0:
>   driver mlx5_core.eth
> pci/0000:08:00.1:
>   driver mlx5_core
>   serial_number e4397f872caeed218000846daa7d2f49
>   board.serial_number MT2314XZ00YA
>   versions:
>       fixed:
>         fw.psid MT_0000000894
>       running:
>         fw.version 28.41.1000
>         fw 28.41.1000
>       stored:
>         fw.version 28.41.1000
>         fw 28.41.1000
> auxiliary/mlx5_core.eth.1:
>   driver mlx5_core.eth
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


