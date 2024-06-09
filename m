Return-Path: <netdev+bounces-102058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5618D9014D7
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 09:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E051D1F2118F
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 07:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416E317588;
	Sun,  9 Jun 2024 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8YhK78u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBEABE4F
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717918266; cv=none; b=VYpd2QitdyLF4HLbadzSmbWXvkZzGTCw+4rmImhaTWT7asVq3kr973i6kS5tpeZR9nHprqSekNetJtPkO49xsKtJPWXGRiOUajFiw8O67wEbvCVFhrFCCjiIeNjurbwvOVOkGUWXmPkg9epjBfz51ZtzNyspb8qAbHsMe7djb5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717918266; c=relaxed/simple;
	bh=6pygsVGDBKbf2rxPasmAKkyUKIloUm6hbM0n8yhlSgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btI/XyBM/ugrOjWYqgf1+WNyJF+7nct9sky0aSN9tfzHZViz9B5c/f7Y5NYJVSD5IGHe3l5QgGZl34VANaEck/MQb/PJSRqnaO8lVhj8I7gdfifbwprKEJIf0IFvpiIv8A+pyRzfyPNLp3c+BzEZ1xYnvERPUdFgNfql76V3IYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8YhK78u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8367C2BD10;
	Sun,  9 Jun 2024 07:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717918265;
	bh=6pygsVGDBKbf2rxPasmAKkyUKIloUm6hbM0n8yhlSgA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k8YhK78umc0JKylTc1w3hATAZjeRDdxcnq/KhfmN6vtPXFxqzGXiugE5KwlmrgqSR
	 UPs4XQ9oQdNRUoGsCblOZLrpwJ6wuUS6WsHMIAJtOrXU1esFMfAuDnHr8Z+/yfmzES
	 krFXZENDKE/BCgnu+CzW0C/m3C+X25m9aFcWXpR2Afiw/UuJbgV1NiwBEC8KOIvRUu
	 pBLxDKGqx7FX30iFBt8EH/uTbM4Qxf/7bSk6a+Dgh89snUi+uUhHEOHYg/Yo0aDmFb
	 ruV9xoODzPHyaWnJiGfkV6MoQ+oJyQHCndW/qkIBPb9LmR3OYoh4n1jZL4l9jhQaiD
	 Ab1iTwGYYvrXg==
Message-ID: <6a17c309-65bd-45a2-a3b2-b1cee9fb5c3d@kernel.org>
Date: Sun, 9 Jun 2024 09:31:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] page_pool: remove WARN_ON() with OR
To: Somnath Kotur <somnath.kotur@broadcom.com>,
 Mina Almasry <almasrymina@google.com>
Cc: David Wei <dw@davidwei.uk>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240605161924.3162588-1-dw@davidwei.uk>
 <CAHS8izMWBDm5VDYOeJDy5J-pbLtsiBnP801PC17XAbzCb2oe-g@mail.gmail.com>
 <CAOBf=mu=4TE3qd-p5J+fMPNud1cgqxrkAjYEw7JOpRycru6BHA@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAOBf=mu=4TE3qd-p5J+fMPNud1cgqxrkAjYEw7JOpRycru6BHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 06/06/2024 10.58, Somnath Kotur wrote:
> On Wed, Jun 5, 2024 at 10:01 PM Mina Almasry <almasrymina@google.com> wrote:
>>
>> On Wed, Jun 5, 2024 at 9:20 AM David Wei <dw@davidwei.uk> wrote:
>>>
>>> Having an OR in WARN_ON() makes me sad because it's impossible to tell
>>> which condition is true when triggered.
>>>
>>> Split a WARN_ON() with an OR in page_pool_disable_direct_recycling().
>>>
>>> Signed-off-by: David Wei <dw@davidwei.uk>
>>
>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>


LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

>>> ---
>>>   net/core/page_pool.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>>> index f4444b4e39e6..3927a0a7fa9a 100644
>>> --- a/net/core/page_pool.c
>>> +++ b/net/core/page_pool.c
>>> @@ -1027,8 +1027,8 @@ static void page_pool_disable_direct_recycling(struct page_pool *pool)
>>>          /* To avoid races with recycling and additional barriers make sure
>>>           * pool and NAPI are unlinked when NAPI is disabled.
>>>           */
>>> -       WARN_ON(!test_bit(NAPI_STATE_SCHED, &pool->p.napi->state) ||
>>> -               READ_ONCE(pool->p.napi->list_owner) != -1);
>>> +       WARN_ON(!test_bit(NAPI_STATE_SCHED, &pool->p.napi->state));
>>> +       WARN_ON(READ_ONCE(pool->p.napi->list_owner) != -1);
>>>
>>>          WRITE_ONCE(pool->p.napi, NULL);
>>>   }
>>> --

