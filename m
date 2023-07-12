Return-Path: <netdev+bounces-17169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F37E4750B31
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD6C1C20FFF
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31432771A;
	Wed, 12 Jul 2023 14:42:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA4EACB
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB02C433C8;
	Wed, 12 Jul 2023 14:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689172949;
	bh=hY4HA0fygEPfW4GSOUtqjJ6/r7bNS3BnMXF4YVuiHKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MPPAfKBfXxCywXcI/1EbAU3GAMye0qYvTH6zqHqG7Pk3EtHb/zw9V3PB5y5plURIX
	 Iv0RPHex6GWw1aQtG5rPbaaKVpla45Kcg2TQXtK9wuG3aQAcrC5FZaOLlFuAFuAdxc
	 BbJ4hvhTa032C2gICClQ4e0gZbVfWaOAp+tGEzEqN5GLBb5T3L0tQPVW5Wu0I6E+zA
	 OPexfQXn8+NZLkPri7ZaMWXbxFH0k4Dgq3rboKGhTpcFOcVwP+ZQJn+maPMKi+ECK1
	 9SyrFQI/g8opzD0xQ8s8LVOQaxS1FMFK1We+g7jSM+OCITgBTJPlXZQusMjPR1n6Aq
	 NUi2F2zEH9f2Q==
Message-ID: <2fda9e96-cefc-fcee-063c-cdf652a64992@kernel.org>
Date: Wed, 12 Jul 2023 08:42:27 -0600
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
To: Simon Horman <simon.horman@corigine.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20230710213511.5364-1-kuniyu@amazon.com>
 <ZK6Q5bp7cYhfl6iN@corigine.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZK6Q5bp7cYhfl6iN@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/12/23 5:39 AM, Simon Horman wrote:
> On Mon, Jul 10, 2023 at 02:35:11PM -0700, Kuniyuki Iwashima wrote:
>> RPL code has a pattern where skb_dst_drop() is called before
>> ip6_route_input().
>>
>> However, ip6_route_input() calls skb_dst_drop() internally,
>> so we need not call skb_dst_drop() before ip6_route_input().
>>
>> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> 

I have been ignoring net-next patches since net-next status still shows
as closed.

