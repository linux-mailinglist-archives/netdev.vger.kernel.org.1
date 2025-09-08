Return-Path: <netdev+bounces-220902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3893B496BA
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 19:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6CB4437DD
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 17:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A40E221FDC;
	Mon,  8 Sep 2025 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW3qbeNr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF623126C5;
	Mon,  8 Sep 2025 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351598; cv=none; b=RG3iUYSLPTbvrfTqhF8hGc3HoKq43ax0wkvXoSbowIR/gEdztrbuLKTQDSXxkOqnJd0iev88AKFS8ZTPAhzKtRuQ/MpWkMaA/KaOVwDfXI/H6M81+KnWOdZUD7I3yp1J1lnOh5i6xY0tKByRn6ESOMy3U7bHiHVtPk4Y9VId0RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351598; c=relaxed/simple;
	bh=Vlw2PodGlpH6M6DPQXMu0NrJCErZpds2VD2me/d72cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rfw0Kftuo3XnbU3OyiU2ivmeNTPqljkuhSuEYj+2jcmkvW7oaCA1Zk82Uytijh5tnAPqyPNghYo+gtibNfgcm85e39LqwA9E/zQ/1YB3QI8Dr79AzVbiBtF3ny+aQx9FSwuY0aASeJVL77TYAlBEAL5k3ogJqoY0kVuwySFdTmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oW3qbeNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFFFC4CEF1;
	Mon,  8 Sep 2025 17:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757351597;
	bh=Vlw2PodGlpH6M6DPQXMu0NrJCErZpds2VD2me/d72cY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oW3qbeNrlpu8ppgXT95Ck44viN5TsYegZgq8XIwZwWZnDOKV44i1sCeK2QsgFLj0r
	 1u3NMyU/RCl3GBOuY2UT0SOBCzd9a1OE0W4I86J+CoZDlIPKxXN+HfdTg5roVmdKLO
	 O384f6851628Gs+xQpMTDOiJ56kjHbuM3f3v+pO2Yxs0JYO7CbAo1B4azsBhrrCEEb
	 0QTT+npqO5YC2xvWPHH4mQ+Ha3mYGzeHH8jTO4gehYL8vdhtnugeBWNcX8fvqIKbpe
	 DdRS7giCEC5BDdLEy8diIMP5em+gh7JH7Fd9A+GytemIQokIUjK4pOLe/Sc5QzCBDc
	 2HBVDVjzKGysA==
Message-ID: <78d4a7b8-8025-493a-805c-a4c5d26836a8@kernel.org>
Date: Mon, 8 Sep 2025 19:13:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp] mptcp: sockopt: make sync_socket_options propagate
 SOCK_KEEPOPEN
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>,
 Krister Johansen <kjlx@templeofstupid.com>,
 Mat Martineau <martineau@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 David Reaver <me@davidreaver.com>
References: <aLuDmBsgC7wVNV1J@templeofstupid.com>
 <ab6ff5d8-2ef1-44de-b6db-8174795028a1@kernel.org>
 <83191d507b7bc9b0693568c2848319932e6b974e.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <83191d507b7bc9b0693568c2848319932e6b974e.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 07/09/2025 02:51, Geliang Tang wrote:
> Hi Matt,
> 
> On Sat, 2025-09-06 at 15:26 +0200, Matthieu Baerts wrote:
>> Hi Krister,
>>
>> On 06/09/2025 02:43, Krister Johansen wrote:
>>> Users reported a scenario where MPTCP connections that were
>>> configured
>>> with SO_KEEPALIVE prior to connect would fail to enable their
>>> keepalives
>>> if MTPCP fell back to TCP mode.
>>>
>>> After investigating, this affects keepalives for any connection
>>> where
>>> sync_socket_options is called on a socket that is in the closed or
>>> listening state.  Joins are handled properly. For connects,
>>> sync_socket_options is called when the socket is still in the
>>> closed
>>> state.  The tcp_set_keepalive() function does not act on sockets
>>> that
>>> are closed or listening, hence keepalive is not immediately
>>> enabled.
>>> Since the SO_KEEPOPEN flag is absent, it is not enabled later in
>>> the
>>> connect sequence via tcp_finish_connect.  Setting the keepalive via
>>> sockopt after connect does work, but would not address any
>>> subsequently
>>> created flows.
>>>
>>> Fortunately, the fix here is straight-forward: set SOCK_KEEPOPEN on
>>> the
>>> subflow when calling sync_socket_options.
>>>
>>> The fix was valdidated both by using tcpdump to observe keeplaive
>>> packets not being sent before the fix, and being sent after the
>>> fix.  It
>>> was also possible to observe via ss that the keepalive timer was
>>> not
>>> enabled on these sockets before the fix, but was enabled
>>> afterwards.
>>
>>
>> Thank you for the fix! Indeed, the SOCK_KEEPOPEN flag was missing!
>> This
>> patch looks good to me as well:
>>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>
>>
>> @Netdev Maintainers: please apply this patch in 'net' directly. But I
>> can always re-send it later if preferred.
> 
> nit:
> 
> I just noticed his patch breaks 'Reverse X-Mas Tree' order in
> sync_socket_options(). If you think any changes are needed, please
> update this when you re-send it.

Sure, I can do the modification and send it with other fixes we have.

pw-bot: cr

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


