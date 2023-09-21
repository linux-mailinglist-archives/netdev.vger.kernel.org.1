Return-Path: <netdev+bounces-35571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173977A9C16
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE87B1C213B6
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CF29CA71;
	Thu, 21 Sep 2023 19:03:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EDC9CA60
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F758C433CB;
	Thu, 21 Sep 2023 19:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695322985;
	bh=Hd2WPNUNJ1mm/XOIpK9uz4AGhYfUfP+uP3teRSPMK8o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vba9m+DFPH8OpSL6NoZVa2NBnwbeosHg+03bAH8yVVuJeSmpsSXGQcsigRVqnJ+5P
	 /VzGYR9W4DeDAvI4PvClBNPGCeoGWbqYMuxewhX/L1l07GQbvsrufdl1h+NRPrCAfJ
	 1HA/UgoUFY7DHsk4PXnzuPEBSXyDk06p5LhWd+DXEJxfXC5J45duJVf1BI4fGTIyUt
	 WmqfJx0DxCtHvTi4NNDgVQMcfkiKPGRnR+GAFoiCX4iY6qUCJh6ICCQS1ANaAXp2Bx
	 RMLEBNyK05ABxNXYhaFelfZ+j79h9VAXSXHZHgtkIHR/utyFucuBI+HGNeF+VBmfI3
	 283FtUyCJXZIA==
Message-ID: <dd0ec329-b9f9-05b2-0e3e-238290519f5b@kernel.org>
Date: Thu, 21 Sep 2023 13:03:04 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 1/8] inet: implement lockless IP_MULTICAST_TTL
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230921133021.1995349-1-edumazet@google.com>
 <20230921133021.1995349-2-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230921133021.1995349-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/23 7:30 AM, Eric Dumazet wrote:
> inet->mc_ttl can be read locklessly.
> 
> Implement proper lockless reads and writes to inet->mc_ttl
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/ip_output.c            |  2 +-
>  net/ipv4/ip_sockglue.c          | 31 ++++++++++++++++---------------
>  net/netfilter/ipvs/ip_vs_sync.c |  2 +-
>  3 files changed, 18 insertions(+), 17 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



