Return-Path: <netdev+bounces-31102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DD278B7A4
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 20:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689B21C2095F
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 18:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AAF13FEE;
	Mon, 28 Aug 2023 18:56:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AFB13FED
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 18:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44D8C433C7;
	Mon, 28 Aug 2023 18:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693248974;
	bh=JwnLAkbhxcncGRnCHwKRB/NFxSy61OM35yNq0/gtTq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eAfVMhl1yaJIMzTZyoyw5uIEji7gz6SNMm6rtc8RFfNMAku2WhZ1+S8atkZ9JzlcO
	 Owe4Ql58KjLQUSyQUa94Un6n43Lkrz0kx6xPZuj2bJOZLulg5KF8HkcO8iKK1//d/w
	 9JDd97DPV0vFnwQCFeUyy6y116rJP/kQMcjbpmHeU21AWp95m/G1gwLf5eS4x85yUz
	 KEz/ZtXhebZdmWV/FyhH1VSVw1oHAhsvZKENrOO7sLdfcTUtiF2BKmw60tt5g7dMln
	 YRy2+L/OigoEUVYwajHltuNMmzyN0tWX33a7EjF6fFLgRrPsbdn4OluNhAzV1I5to4
	 yi+w62tJQxn8A==
Message-ID: <bf01b809-b4ee-9d8c-711e-9b7324662e67@kernel.org>
Date: Mon, 28 Aug 2023 12:56:13 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net v3 2/3] ipv6: ignore dst hint for multipath routes
Content-Language: en-US
To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>
References: <20230828113221.20123-1-sriram.yagnaraman@est.tech>
 <20230828113221.20123-3-sriram.yagnaraman@est.tech>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230828113221.20123-3-sriram.yagnaraman@est.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/23 5:32 AM, Sriram Yagnaraman wrote:
> Route hints when the nexthop is part of a multipath group causes packets
> in the same receive batch to be sent to the same nexthop irrespective of
> the multipath hash of the packet. So, do not extract route hint for
> packets whose destination is part of a multipath group.
> 
> A new SKB flag IP6SKB_MULTIPATH is introduced for this purpose, set the
> flag when route is looked up in fib6_select_path() and use it in
> ip6_can_use_hint() to check for the existence of the flag.
> 
> Fixes: 197dbf24e360 ("ipv6: introduce and uses route look hints for list input.")
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> ---
>  include/linux/ipv6.h | 1 +
>  net/ipv6/ip6_input.c | 3 ++-
>  net/ipv6/route.c     | 3 +++
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


