Return-Path: <netdev+bounces-169952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7716EA469D0
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49ECB161F3F
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9E222F163;
	Wed, 26 Feb 2025 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0n1N1IR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9124D224896;
	Wed, 26 Feb 2025 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594711; cv=none; b=ibRJI4l9H5uIIb0L1Jk+eHRSeyEaOJJ7JT3WW6vPB75rvpgSaskQAjce/zYfCPcdL0W5XVNdT/IeltpOLGvzSVawE2LRHDz5bSXwJI/XTXjm8p0XirRVX7lfS2Jt1iQYK2asWhuexDk0xA5L/sL7MHEW+Xclh+0prLzvedckbY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594711; c=relaxed/simple;
	bh=BKPXQQ8CjbFDeVNuxprUfazQt1oytQiSgaOL5OrKMwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggtr8gExZP1VBalpIhAAPJr6PDkyzOcI7WwUgqLtbQ3/eszXdy5RCK0P45xg0XxUoB3Ooc40t+Vzlx9a32GMPbrnZoVdzxC484UY/gxYKOEcyU6uvbSCQEg3oTKImbQaX8LYYiB0A5/XsysExqax4GmSM7MTR4tDBzstqyTFz7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0n1N1IR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65964C4CEE8;
	Wed, 26 Feb 2025 18:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740594711;
	bh=BKPXQQ8CjbFDeVNuxprUfazQt1oytQiSgaOL5OrKMwA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r0n1N1IRjZ2zCWZoNYM/PCUvE0GC3ncpxvzxh6u/vY2Bh7XkzusJ1c40fHWv9Fxeq
	 +CC6/PxKl++lCVb4uPxtV3rAMkaYzx5ZOCl4jpu3Ziff4aHMe58dKEUt/g9NN4HjHb
	 gxF24oBCFLcZXAZSp1/aeawh4ADlAwwHKl4usKiQPc5Za7W+iX89P6f1Hib41f45Dk
	 4O58yJwXYICHEBmPe2jPthNgeLcQkCN9FOnKJsVj1voqLYtKUhf7ret52wAR2xKPQz
	 gvDaB3O3AUY079xs5h1XpLzHAFp3Sq68oSldmj3oSsKpJNqpuLFHd1HpvIspyjBjI6
	 O1SWHos81FlIw==
Message-ID: <70168c8f-bf52-4279-b4c4-be64527aa1ac@kernel.org>
Date: Wed, 26 Feb 2025 11:31:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Breno Leitao <leitao@debian.org>
Cc: Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
 yonghong.song@linux.dev
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
 <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
 <559f3da9-4b3d-41c2-bf44-18329f76e937@kernel.org>
 <20250226-cunning-innocent-degu-d6c2fe@leitao>
 <7e148fd2-b4b7-49a1-958f-4b0838571245@kernel.org>
 <20250226-daft-inchworm-of-love-3a98c2@leitao>
 <CANn89iKwO6yiBS_AtcR-ymBaA83uLh8sCh6znWE__+a-tC=qhQ@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89iKwO6yiBS_AtcR-ymBaA83uLh8sCh6znWE__+a-tC=qhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/26/25 11:27 AM, Eric Dumazet wrote:
> On Wed, Feb 26, 2025 at 7:18 PM Breno Leitao <leitao@debian.org> wrote:
>>
>> Hello David,
>>
>> On Wed, Feb 26, 2025 at 10:12:08AM -0700, David Ahern wrote:
>>> On 2/26/25 9:10 AM, Breno Leitao wrote:
>>>>> Also, if a tracepoint is added, inside of tcp_sendmsg_locked would cover
>>>>> more use cases (see kernel references to it).
>>>>
>>>> Agree, this seems to provide more useful information
>>>>
>>>>> We have a patch for a couple years now with a tracepoint inside the
>>>>
>>>> Sorry, where do you have this patch? is it downstream?
>>>
>>> company tree. Attached. Where to put tracepoints and what arguments to
>>> supply so that it is beneficial to multiple users is always a touchy
>>> subject :-)
>>
>> Thanks. I would like to state that this would be useful for Meta as
>> well.
>>
>> Right now, we (Meta) are using nasty `noinline` attribute in
>> tcp_sendmsg() in order to make the API stable, and this tracepoint would
>> solve this problem avoiding the `noinline` hack. So, at least two type
>> of users would benefit from it.
>>
>>> so I have not tried to push the patch out. sock arg should
>>> be added to it for example.
>>
>> True, if it becomes a tracepoint instead of a rawtracepoint, the sock
>> arg might be useful.
>>
>> How would you recommend me proceeding in this case?
> 
> In 2022, Menglong Dong added __fix_address
> 
> Then later , Yafang Shao  added noinline_for_tracing .
> 
> Would one of them be sufficient ?

tcp_sendmsg_locked should not be getting inlined; it is the
sendmsg_locked handler and directly called by several subsystems.

ie., moving the tracepoint to tcp_sendmsg_locked should solve the inline
problem. From there, the question is inside the loop or at entry to the
function. Inside the loop has been very helpful for me.

