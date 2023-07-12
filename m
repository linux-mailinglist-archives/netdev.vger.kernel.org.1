Return-Path: <netdev+bounces-17175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F8A750B73
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD1A28175D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 14:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7756C34CE8;
	Wed, 12 Jul 2023 14:55:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316AC27726
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EA3C433D9;
	Wed, 12 Jul 2023 14:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689173700;
	bh=aWXZ168MF3/GE/VIa8RqS5mzwhZWllmcBrl2Dw1kmJY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=F3o5hbNBHjzOyKI2Zb+VAnfjStTlMBd8I9tl2otWFJJrT8M3yvSngnBQU4DMprCty
	 wuvJRxia2uZXeLBEB9Dy7ATFrAP9pozpYNgIzc8tqeKGbUK2Fv7EG5icPwV5KpOU9U
	 /YJBgVX8/jtWmDca/EwHndYKJgAqvDZVvZGAeqVEr5r1/xnviYUUGUwjqGg8EJKuJz
	 tD3wj2SdG1zgyMqpodrTQgZ/isVk0pcWouaWsar1wShUZaqDBXcVRDFVkBk9XzeuAH
	 ZeBzQpHwBrq/1KRmdFZviGF+UA1u3ls2hS0jN+Nx+pnYlEsrDAbHGzjUsQXC04/loq
	 clC9NyBXo0VxQ==
Message-ID: <0db45681-dd13-21e9-1be6-861fd9588ca9@kernel.org>
Date: Wed, 12 Jul 2023 08:54:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v1 net-next] ipv6: rpl: Remove redundant skb_dst_drop().
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
To: Simon Horman <simon.horman@corigine.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20230710213511.5364-1-kuniyu@amazon.com>
 <ZK6Q5bp7cYhfl6iN@corigine.com>
 <2fda9e96-cefc-fcee-063c-cdf652a64992@kernel.org>
In-Reply-To: <2fda9e96-cefc-fcee-063c-cdf652a64992@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/12/23 8:42 AM, David Ahern wrote:
> On 7/12/23 5:39 AM, Simon Horman wrote:
>> On Mon, Jul 10, 2023 at 02:35:11PM -0700, Kuniyuki Iwashima wrote:
>>> RPL code has a pattern where skb_dst_drop() is called before
>>> ip6_route_input().
>>>
>>> However, ip6_route_input() calls skb_dst_drop() internally,
>>> so we need not call skb_dst_drop() before ip6_route_input().
>>>
>>> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>>
>> Reviewed-by: Simon Horman <simon.horman@corigine.com>
>>
> 
> I have been ignoring net-next patches since net-next status still shows
> as closed.

I was shown the error of my ways (i.e., pointed to the new URL for
net-next status)

Reviewed-by: David Ahern <dsahern@kernel.org>


