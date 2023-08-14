Return-Path: <netdev+bounces-27205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5798477AF2F
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 03:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024FD280F1C
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 01:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D795A10FB;
	Mon, 14 Aug 2023 01:22:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F5F39D
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 01:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34ADC433C7;
	Mon, 14 Aug 2023 01:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691976154;
	bh=8IRDzHuQtCSxqyOpcrFz5KOiePNi5Mft11GirqWtXQ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nYLxjradP/d4nb0k6SAwiTw/aM261rC4WOmyW7l+CFkoHA9t8/wHUKBv54AEDuCBa
	 xpT25AJsQ7I1cAFuUY/OC6M33+0E+Ty0AgtJbIXXgB9PMq9w26eiWG3cG5MDZDosFB
	 t8RZam5bXvjy4121wXPebsVVV+Jg5AHwNg6eEdlXiARFdmAufkcG05dbEp4Od8VmtQ
	 LnEZKMHEY1zidzxgrAbDcWWztcf3Z/pXUIMfuBez5egk8q0wFirLQw6DIbycxh+d6A
	 cDYSNPlaNYemUBKk6+6XUxzcFdTUCeMK7jVJnwtfhcX/XZKbqh9fXW7HfHOZjZo2XD
	 3kBura/uK3PjQ==
Message-ID: <e8af35a8-00c6-2fb4-1f25-2efb2d3cb00c@kernel.org>
Date: Sun, 13 Aug 2023 19:22:33 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 2/2] nexthop: Do not increment dump sentinel at
 the end of the dump
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com, mlxsw@nvidia.com
References: <20230813164856.2379822-1-idosch@nvidia.com>
 <20230813164856.2379822-3-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230813164856.2379822-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/23 10:48 AM, Ido Schimmel wrote:
> The nexthop and nexthop bucket dump callbacks previously returned a
> positive return code even when the dump was complete, prompting the core
> netlink code to invoke the callback again, until returning zero.
> 
> Zero was only returned by these callbacks when no information was filled
> in the provided skb, which was achieved by incrementing the dump
> sentinel at the end of the dump beyond the ID of the last nexthop.
> 
> This is no longer necessary as when the dump is complete these callbacks
> return zero.
> 
> Remove the unnecessary increment.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>  net/ipv4/nexthop.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



