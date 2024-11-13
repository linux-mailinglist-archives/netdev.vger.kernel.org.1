Return-Path: <netdev+bounces-144344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93D89C6BAD
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73205B2287B
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 09:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509441F80B4;
	Wed, 13 Nov 2024 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4Jm4hXL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B28178CC8;
	Wed, 13 Nov 2024 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491079; cv=none; b=ggViguZsW8LpK+MazAJ5rSfW/EzsrnYcvDMhOmoWe0Rbmk1dIvtjyP/hiaJqqM6FHhQ1EMk+achHji0wow0wTFdprklkyb2uJZzm4eT4y7q88s4zXxr2THcdnLsbJ08z4VPYe13jwI8hTqAevNnPpWAnHYc0SJXKJR1XOkraDxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491079; c=relaxed/simple;
	bh=G60SOJCRCee6VpKMWDHKShG2kyMomKULAjFj4Z0HY5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVAvXK+rnydlOkSH/eaBsdc2+K2J/u2VfhmfjT8GNpEBGKZP5FZ3k+4HHQAEa+uvJk6cuZFIeuiPBQJQ+cJgE7sMZYPxoqs+8yKltKk7eISsP2D+nlx7zhTgUfhUq3E7S9jmL2zPpjEzIN9ADdAuSfZ595d1HrDqlZ8jvxDhhLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4Jm4hXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692CDC4CECD;
	Wed, 13 Nov 2024 09:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731491078;
	bh=G60SOJCRCee6VpKMWDHKShG2kyMomKULAjFj4Z0HY5E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M4Jm4hXLo+c4whd2dCrDaM4pZncZ9lPC18qo/U30v0jCa1owQ9JRzhd5SW+TkpR46
	 tgSYr4tnk6QKnK5zn5kTqvrcYaWQL8WbZDy1Zi2+F+D4RtSzPmH8tqzFBpdwx0uS38
	 t/yTolTMWzkQ1XDjeaj7bX6JnyQFzEq+/z0ZNS4ZyphTqPGk9AvOxUjezL4N8K9XYf
	 Gbe2egurnLrshqUS40KKOsjhZYBpB7RgloJoWn1MPrigH8BeOYS5OhT5pSl7rUYcyp
	 l5+9Ud7n1NwT5cV5FkZuc/NCFD6KZBMibDx2eYR2Xcepl+X9BIdmIFmfKrEe67dEVf
	 OqzY8/nIyJ5vw==
Message-ID: <0cde0236-c539-487d-a212-b660331d3683@kernel.org>
Date: Wed, 13 Nov 2024 10:44:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] samples: pktgen: correct dev to DEV
To: Wei Fang <wei.fang@nxp.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, lorenzo@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
References: <20241112030347.1849335-1-wei.fang@nxp.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20241112030347.1849335-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/11/2024 04.03, Wei Fang wrote:
> In the pktgen_sample01_simple.sh script, the device variable is uppercase
> 'DEV' instead of lowercase 'dev'. Because of this typo, the script cannot
> enable UDP tx checksum.
> 
> Fixes: 460a9aa23de6 ("samples: pktgen: add UDP tx checksum support")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>   samples/pktgen/pktgen_sample01_simple.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/pktgen/pktgen_sample01_simple.sh b/samples/pktgen/pktgen_sample01_simple.sh
> index cdb9f497f87d..66cb707479e6 100755
> --- a/samples/pktgen/pktgen_sample01_simple.sh
> +++ b/samples/pktgen/pktgen_sample01_simple.sh

Why are you only fixing one script?

The fixes commit 460a9aa23de6 changes many files, introducing this bug.

> @@ -76,7 +76,7 @@ if [ -n "$DST_PORT" ]; then
>       pg_set $DEV "udp_dst_max $UDP_DST_MAX"
>   fi
>   
> -[ ! -z "$UDP_CSUM" ] && pg_set $dev "flag UDPCSUM"
> +[ ! -z "$UDP_CSUM" ] && pg_set $DEV "flag UDPCSUM"
>   

This fix looks correct, but we also need to fix other scripts

>   # Setup random UDP port src range
>   pg_set $DEV "flag UDPSRC_RND"


$ git whatchanged -1 460a9aa23de6 | grep 'M     samples'| awk -FM 
'{print $2}'
	samples/pktgen/parameters.sh
	samples/pktgen/pktgen_sample01_simple.sh
	samples/pktgen/pktgen_sample02_multiqueue.sh
	samples/pktgen/pktgen_sample03_burst_single_flow.sh
	samples/pktgen/pktgen_sample04_many_flows.sh
	samples/pktgen/pktgen_sample05_flow_per_thread.sh
	samples/pktgen/pktgen_sample06_numa_awared_queue_irq_affinity.sh

Thanks for spotting this, but please also fix the other scripts :-)

--Jesper

