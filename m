Return-Path: <netdev+bounces-139099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4033F9B033C
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4961F21F3F
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 12:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4092064FF;
	Fri, 25 Oct 2024 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMJA3zcc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D651F2064F2;
	Fri, 25 Oct 2024 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861029; cv=none; b=q0QEr27u01xz8sB2apYJDqh9HTaePX8pqf1j1NV4bmDlcUKCu5t0Kr6gsxAjSCCStwfvpj1pRxZ13yiMm8KedirrGStuyNB0BQwxIjlsLZhT0XN/O/nZDjzK/dCQMiR/43e3Uty5rrLquxKx/ZF09UGVv5n+a4+BpGl8D/7ehXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861029; c=relaxed/simple;
	bh=qQ9BGIBuydVEIbP3xQoTLisLWtMFfzR966v2FW0Zv48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5qnO+z26uUKfCmfJ60Kht2fpUcC7MZH/3gArGv8lPs+v344gutKERaS2g9b85nOQh3+hbXsXBko1Zcrt93sciHF500f6wRHCDiy3EafeIKVsoLL3Gpu6nhsssZBRmuPYPKa0dFwKiwil6gig/RieSSTC6FbfgOXlNcZ3t6/dyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMJA3zcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E13C4CEC3;
	Fri, 25 Oct 2024 12:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729861029;
	bh=qQ9BGIBuydVEIbP3xQoTLisLWtMFfzR966v2FW0Zv48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMJA3zcceJ88lqN4DKbs7ZO4fBlHQyrFjCypZWJ9iWhNhkzeZSYxFOy7QzYtxMy+1
	 uw1n3p/aXsdzMMm4LzGfRgNxqIw+lj0Yb442PsUxMRYlzAwMbBV0mktdYvgfkfmSgJ
	 XkGQce4MGcTDn39Pa0jN01LQjjeKr7WiYoQTtM+io+TLErvVCE3q0tpRxh4TbA2Is7
	 pkHMFSIeruqUghKMZ7K7iHUzyLHnlenuVG7ITayAsjWs8yjE+FwjUUA2FlCcyj/l4O
	 4ObkMB1N/TiaHBzElKq5XTyir8nR7MqHedKXRjCMQXuZX97uKpuhBxWjYA5yMJxdrj
	 nK12D93ImIECA==
Date: Fri, 25 Oct 2024 13:57:04 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH net-next] net: freescale: use ethtool string helpers
Message-ID: <20241025125704.GT1202098@kernel.org>
References: <20241024205257.574836-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024205257.574836-1-rosenp@gmail.com>

On Thu, Oct 24, 2024 at 01:52:57PM -0700, Rosen Penev wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer. Cleans up the code quite well.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

...

> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
> index b0060cf96090..10c5fa4d23d2 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
> @@ -243,38 +243,24 @@ static void dpaa_get_ethtool_stats(struct net_device *net_dev,
>  static void dpaa_get_strings(struct net_device *net_dev, u32 stringset,
>  			     u8 *data)
>  {
> -	unsigned int i, j, num_cpus, size;
> -	char string_cpu[ETH_GSTRING_LEN];
> -	u8 *strings;
> +	unsigned int i, j, num_cpus;
>  
> -	memset(string_cpu, 0, sizeof(string_cpu));
> -	strings   = data;
> -	num_cpus  = num_online_cpus();
> -	size      = DPAA_STATS_GLOBAL_LEN * ETH_GSTRING_LEN;
> +	num_cpus = num_online_cpus();
>  
>  	for (i = 0; i < DPAA_STATS_PERCPU_LEN; i++) {
> -		for (j = 0; j < num_cpus; j++) {
> -			snprintf(string_cpu, ETH_GSTRING_LEN, "%s [CPU %d]",
> -				 dpaa_stats_percpu[i], j);
> -			memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> -			strings += ETH_GSTRING_LEN;
> -		}
> -		snprintf(string_cpu, ETH_GSTRING_LEN, "%s [TOTAL]",
> -			 dpaa_stats_percpu[i]);
> -		memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> -		strings += ETH_GSTRING_LEN;
> -	}
> -	for (j = 0; j < num_cpus; j++) {
> -		snprintf(string_cpu, ETH_GSTRING_LEN,
> -			 "bpool [CPU %d]", j);
> -		memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> -		strings += ETH_GSTRING_LEN;
> +		for (j = 0; j < num_cpus; j++)
> +			ethtool_sprintf(&data, "%s [CPU %d]",
> +					dpaa_stats_percpu[i], j);
> +
> +		ethtool_sprintf(&data, "%s [TOTAL]", dpaa_stats_percpu[i]);
>  	}
> -	snprintf(string_cpu, ETH_GSTRING_LEN, "bpool [TOTAL]");
> -	memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> -	strings += ETH_GSTRING_LEN;
> +	for (i = 0; j < num_cpus; i++)

Perhaps this should consistently use i, rather than i and j:

	for (i = 0; i < num_cpus; i++)

Flagged by W=1 builds with clang-18.

> +		ethtool_sprintf(&data, "bpool [CPU %d]", i);
> +
> +	ethtool_puts(&data, "bpool [TOTAL]");
>  
> -	memcpy(strings, dpaa_stats_global, size);
> +	for (i = 0; i < DPAA_STATS_GLOBAL_LEN; i++)
> +		ethtool_puts(&data, dpaa_stats_global[i]);
>  }
>  
>  static int dpaa_get_hash_opts(struct net_device *dev,

...

