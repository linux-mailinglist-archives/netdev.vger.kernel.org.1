Return-Path: <netdev+bounces-134847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1795499B50A
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 15:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2161128231F
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 13:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02817155A53;
	Sat, 12 Oct 2024 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLZbPWHg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3CC1F5FA;
	Sat, 12 Oct 2024 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728739302; cv=none; b=Tc5G8hxhnvUpjL5bIsbfclabZ36AL0MyH3V4bPiI3igtbjU9cztG22iZZCHPsXmtQMP3axwXX+TSBvXsbdH8Qt4VJL7sRuxdLbpg0gOBnqfH1n/hekX6tRC9fSKiSpxBpkPKQID8PuP/6KLXCoNlo8TfN2RIky1lK0wsXDa2c+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728739302; c=relaxed/simple;
	bh=Cwunnya8q8ws4MjlycWukeX3SEmIDdSpAsgx3d35aJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLzoA1y+19mSzSbS/5mbBNpLlG1JkcS/S3dagGliAdBrwhZgjACuF/icBGOVUxbN5XNKIfeDTAu39ogdX/9cF/PliAInx4yRYnC7Pm3dqnFOo6ZKlBAPWh77enmdc7TH9VDrgJwKiIBfoSffDOCg/xiDuvuGgbxlZ38klMPKGHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLZbPWHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7258C4CEC6;
	Sat, 12 Oct 2024 13:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728739302;
	bh=Cwunnya8q8ws4MjlycWukeX3SEmIDdSpAsgx3d35aJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vLZbPWHgfrapz2S5Nx8fqsRfJDAhWnx1B5Dk8wyiHR5qnxCC34AF1AJXKndOVENv/
	 AFNXCK8S2863jZdE2gl5T+yurpXRbIUm8z0cTPucnipAHCZ00WNpoUrihOLAY9ZA9m
	 kij8Fjud3YWAN/i1y9NhW+xPTPlJV+tilIOcYve2WT1NaTMO9HjOwkadQ+qtRe2OJe
	 jYMwKQwoW2pZtfAGRoxtsx0KcLPEXAmP0t2nxWMq8YY9OFbKepGdYZ2RpeomgyB0iu
	 VoDuw7oVaiiedpagKWCRPPnLptdcKxqZId97ngoW9KwKxvJbsC68Q0KfgP/0uCFKZr
	 u1yb8VWWuh4JQ==
Date: Sat, 12 Oct 2024 14:21:37 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv6 net-next 7/7] net: ibm: emac: use of_find_matching_node
Message-ID: <20241012132137.GF77519@kernel.org>
References: <20241011195622.6349-1-rosenp@gmail.com>
 <20241011195622.6349-8-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011195622.6349-8-rosenp@gmail.com>

On Fri, Oct 11, 2024 at 12:56:22PM -0700, Rosen Penev wrote:
> Cleaner than using of_find_all_nodes and then of_match_node.
> 
> Also modified EMAC_BOOT_LIST_SIZE check to run before of_node_get to
> avoid having to call of_node_put on failure.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/ibm/emac/core.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> index faa483790b29..5265616400c2 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c
> @@ -3253,21 +3253,17 @@ static void __init emac_make_bootlist(void)
>  	int cell_indices[EMAC_BOOT_LIST_SIZE];
>  
>  	/* Collect EMACs */
> -	while((np = of_find_all_nodes(np)) != NULL) {
> +	while((np = of_find_matching_node(np, emac_match))) {
>  		u32 idx;
>  
> -		if (of_match_node(emac_match, np) == NULL)
> -			continue;
>  		if (of_property_read_bool(np, "unused"))
>  			continue;
>  		if (of_property_read_u32(np, "cell-index", &idx))
>  			continue;
>  		cell_indices[i] = idx;
> -		emac_boot_list[i++] = of_node_get(np);
> -		if (i >= EMAC_BOOT_LIST_SIZE) {
> -			of_node_put(np);
> +		if (i >= EMAC_BOOT_LIST_SIZE)
>  			break;
> -		}
> +		emac_boot_list[i++] = of_node_get(np);

Reading the Kernel doc for of_find_matching_node() it seems
that of_node_put() needs to called each time it (and thus
of_find_matching_node() returns a np. But that doesn't seem
to be the case here. Am I mistaken?


>  	}
>  	max = i;
>  
> -- 
> 2.47.0
> 

