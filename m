Return-Path: <netdev+bounces-26832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C41D77928E
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 17:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BB21C20AC0
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1880829E19;
	Fri, 11 Aug 2023 15:11:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE0263B6
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD21C433C7;
	Fri, 11 Aug 2023 15:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691766660;
	bh=prW7kshO4XrJKtsXg3NPLgLVcKUKvt0iZEu10mzotog=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qoLKW0U6r0X/uEw2SFu8oWyHEjDZhMnNslgbztgiFtT7MBCMM5R2SEhtyv4rwHy50
	 ctmFASnn3qqyoJHMeO8UCftrVfcYevTGY5pW/1/LYjZD7YcHQHJZRUOhYW43iJqvs1
	 l/h0HPM4/WtFjBpcN/JqfBZhCMTaCAgJ3m0+VL53DIGJINQ/qdLMhpA22cJKIEesRG
	 TPDN6aAKwr8vgI6NtHrq7WI5HQUIY0ecaPuGhFqpFw5Oq/rMe61SMjSr6Lx40llH4C
	 BOjXrkUMY/W3tzaLwWR0s4QUPJC/I7MQDtVR5WY2QPrBkQ4B8XsEdoLZmM9WBiNYR7
	 mIARDGMc3FHpQ==
Message-ID: <94192621-53c9-7f2c-ba99-306f9eb8533c@kernel.org>
Date: Fri, 11 Aug 2023 09:10:58 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v6 2/2] selftests: fib_tests: Add a test case for
 IPv6 garbage collection
Content-Language: en-US
To: thinker.li@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 martin.lau@linux.dev, kernel-team@meta.com, yhs@meta.com
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20230808180309.542341-1-thinker.li@gmail.com>
 <20230808180309.542341-3-thinker.li@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230808180309.542341-3-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/23 12:03 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Add 1000 IPv6 routes with expiration time (w/ and w/o additional 5000
> permanet routes in the background.)  Wait for a few seconds to make sure
> they are removed correctly.
> 
> The expected output of the test looks like the following example.
> 
>> Fib6 garbage collection test
>>     TEST: ipv6 route garbage collection [ OK ]
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/testing/selftests/net/fib_tests.sh | 72 +++++++++++++++++++++++-
>  1 file changed, 69 insertions(+), 3 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


