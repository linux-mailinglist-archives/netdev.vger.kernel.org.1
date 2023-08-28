Return-Path: <netdev+bounces-31101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 654A978B79C
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 20:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565251C2095A
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 18:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0A913FED;
	Mon, 28 Aug 2023 18:56:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F14125D5
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 18:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E436BC433C7;
	Mon, 28 Aug 2023 18:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693248958;
	bh=OVwE6mzVIELEbJ5swUj8Zkbx9K7l1rxzi4K+JUditgk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NnVctViIJx1hQTOd+NrDASUW/R2JNf3xPruN08IQFrxs/f1P+TOSNluKLcVNW9fAG
	 wkv0zq6UrkizmO+AUB6JYBjCvSm4fZB7bvUr3QJGlXWft5rBhoOdWSEZ/k/KY2heas
	 qYI2vcCUbB17gdPLlU2ng7oRmZvF8y/ujTKchRx17j2L/55RepAsypqUsPiCQt9OGc
	 gVeXsRvcFx9sYQYiJgcx9p2fwXjUc40XQ1ZkzjhPyprlfiwy3cldh8enD+RIgCQ3jN
	 LVGs2pzx8rpFbU5xKsX+KNnUO8MjTGTqFZDsh/2+QuG3YOiWaLgJlR36C9zbhI57U2
	 qYbOK/6Srronw==
Message-ID: <ecba2119-2182-16b5-9ad5-25a9b497b0d6@kernel.org>
Date: Mon, 28 Aug 2023 12:55:57 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net v3 1/3] ipv4: ignore dst hint for multipath routes
Content-Language: en-US
To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>
References: <20230828113221.20123-1-sriram.yagnaraman@est.tech>
 <20230828113221.20123-2-sriram.yagnaraman@est.tech>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230828113221.20123-2-sriram.yagnaraman@est.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/23 5:32 AM, Sriram Yagnaraman wrote:
> Route hints when the nexthop is part of a multipath group causes packets
> in the same receive batch to be sent to the same nexthop irrespective of
> the multipath hash of the packet. So, do not extract route hint for
> packets whose destination is part of a multipath group.
> 
> A new SKB flag IPSKB_MULTIPATH is introduced for this purpose, set the
> flag when route is looked up in ip_mkroute_input() and use it in
> ip_extract_route_hint() to check for the existence of the flag.
> 
> Fixes: 02b24941619f ("ipv4: use dst hint for ipv4 list receive")
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> ---
>  include/net/ip.h    | 1 +
>  net/ipv4/ip_input.c | 3 ++-
>  net/ipv4/route.c    | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


