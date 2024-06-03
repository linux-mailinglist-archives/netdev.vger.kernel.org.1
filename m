Return-Path: <netdev+bounces-100236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8D48D847C
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A745B215FC
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ECD12DDAE;
	Mon,  3 Jun 2024 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lz+HCOA3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812E512D761;
	Mon,  3 Jun 2024 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423031; cv=none; b=nPSANCEDlFItgcrwVENhafwxOHdMtUgYcXs2AAd4+gLmd7dkDuEVGbRDub9jVGwR/XNvEIfOLQIIYZBbgD/H3tmWYEu1TSQrOvPJDNw2fX4dlNkpMCpG+gyWskQw7eJAUezhqIUyb4qkr6ysJyuCrpdRNusg0hbi7OFmSCRrH9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423031; c=relaxed/simple;
	bh=p14yftRLnM+mRJOXE2YBReDdKdHQCCNeSFzGG5BRGBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+onzXvTJPhkJe4agqfUWsfTDBrXBV76mSSGjcjZW5iXc3RHwAlAtj3kUy0Yx24UBHcejHuIuh0fLrsBS1T/tCVL7iXdHtCEt97G+xK+AI3c7BNlSYDKvMOcVsdsRX7/4NrP4rJl9wVCAGeHEuiSu9l2mym+zUfk2QWfIc1GMCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lz+HCOA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06652C2BD10;
	Mon,  3 Jun 2024 13:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717423031;
	bh=p14yftRLnM+mRJOXE2YBReDdKdHQCCNeSFzGG5BRGBo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lz+HCOA3So8UNPr9orQ4pXpCLpRsN+AzIlDFAvdg60JGrC+YMD+6ezmeCba831ai9
	 1OJ2cjutzk2omB8/bxhCU2e4NkwJLNZrTkGy6oeqz/idOMxgvvZRGNYi2HzJbYU6ej
	 cspVX0ntv0MFaI03WQYv+/iEkY/t9VAUdg3gPZgIPtdFM+hwjmnBvfPfjbAgFaAF9r
	 4pdkfTLgiPiRFaAeWck/FeWLo+NKe0+Nak0IyOGS6EPZHmMUTplLomijQKpFGaOs3N
	 p0/6FrAoi0VNylzfEC9HgCCdMasTomiLAnn9mNAkb0zpIiX8AA7x3Dv/RVHWStCqjT
	 DDvx5xIhN7SlA==
Message-ID: <80acd903-3cde-4232-8a78-ce20a3e746fa@kernel.org>
Date: Mon, 3 Jun 2024 15:57:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v4 2/2] mptcp: count CLOSE-WAIT sockets for
 MPTCP_MIB_CURRESTAB
Content-Language: en-GB
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, dsahern@kernel.org, martineau@kernel.org,
 geliang@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 Jason Xing <kernelxing@tencent.com>
References: <20240531091753.75930-1-kerneljasonxing@gmail.com>
 <20240531091753.75930-3-kerneljasonxing@gmail.com>
 <df99fb97-74ca-4b5c-9d5f-86466025a531@kernel.org>
 <CAL+tcoAa+8pEcW5C3jjU4cieHBm8PUWMKUR=hP8sqQbh1gmVug@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAL+tcoAa+8pEcW5C3jjU4cieHBm8PUWMKUR=hP8sqQbh1gmVug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jason,

On 03/06/2024 15:26, Jason Xing wrote:
> Hello Matthieu,
> 
> On Mon, Jun 3, 2024 at 8:47 PM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Jason,
>>
>> On 31/05/2024 11:17, Jason Xing wrote:
>>> From: Jason Xing <kernelxing@tencent.com>
>>>
>>> Like previous patch does in TCP, we need to adhere to RFC 1213:
>>>
>>>   "tcpCurrEstab OBJECT-TYPE
>>>    ...
>>>    The number of TCP connections for which the current state
>>>    is either ESTABLISHED or CLOSE- WAIT."
>>>
>>> So let's consider CLOSE-WAIT sockets.
>>>
>>> The logic of counting
>>> When we increment the counter?
>>> a) Only if we change the state to ESTABLISHED.
>>>
>>> When we decrement the counter?
>>> a) if the socket leaves ESTABLISHED and will never go into CLOSE-WAIT,
>>> say, on the client side, changing from ESTABLISHED to FIN-WAIT-1.
>>> b) if the socket leaves CLOSE-WAIT, say, on the server side, changing
>>> from CLOSE-WAIT to LAST-ACK.
>>
>> Thank you for this modification, and for having updated the Fixes tag.
>>
>>> Fixes: d9cd27b8cd19 ("mptcp: add CurrEstab MIB counter support")
>>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
>>> ---
>>>  net/mptcp/protocol.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 7d44196ec5b6..6d59c1c4baba 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -2916,9 +2916,10 @@ void mptcp_set_state(struct sock *sk, int state)
>>>               if (oldstate != TCP_ESTABLISHED)
>>>                       MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
>>>               break;
>>> -
>>> +     case TCP_CLOSE_WAIT:
>>> +             break;
>>
>> The modification is correct: currently, and compared to TCP, the MPTCP
>> "accepted" socket will not go through the TCP_SYN_RECV state because it
>> will be created later on.
>>
>> Still, I wonder if it would not be clearer to explicitly mention this
>> here, and (or) in the commit message, to be able to understand why the
>> logic is different here, compared to TCP. I don't think the SYN_RECV
>> state will be used in the future with MPTCP sockets, but just in case,
>> it might help to mention TCP_SYN_RECV state here. Could add a small
>> comment here above please?
> 
> Sure, but what comments do you suggest?
> For example, the comment above the case statement is:
> "Unlike TCP, MPTCP would not have TCP_SYN_RECV state, so we can skip
> it directly"
> ?
Yes, thank you, it looks good to me. But while at it, you can also add
the reason:

  case TCP_CLOSE_WAIT:
          /* Unlike TCP, MPTCP sk would not have the TCP_SYN_RECV state:
           * MPTCP "accepted" sockets will be created later on. So no
           * transition from TCP_SYN_RECV to TCP_CLOSE_WAIT.
           */

WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


