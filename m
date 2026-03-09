Return-Path: <netdev+bounces-265544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C+BGv/Ermn2IgIAu9opvQ
	(envelope-from <netdev+bounces-265544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:02:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FF42395BC
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E0AB3001F9A
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 13:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43283502A6;
	Mon,  9 Mar 2026 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCjAa/qx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF981B4F09;
	Mon,  9 Mar 2026 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773061369; cv=none; b=rF1KTz6B1672gNqGJVdGQzVEwFrbVczSsXvdylteUvM+EMknaNqhT3kcYSqwJQcRJMUZt+hSLnbZyzVxD8GvCRBmln1Tz0yA9OK8zrTJbV8Y4/8qB+e6rK1aAMoG6pWfJsq+9yI4m+V5BHdsaK3RJLzoSxsTgezYwAMSorbD3cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773061369; c=relaxed/simple;
	bh=8DNFqs9BqyWbsZij3jgAnNR3Kg6pkLFQFJhfdOuSUtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1KguEeWGQxtIaJC5EgZeBUHfARz/5yAZjXy7qf2jY4erv+0W/QdQes92JAkGuAQWAr3J3eHw8BMd6pgBx7Lv0HLw67mUq/7wdUgfZcmDjHKKjeX1Cj5H6hN+kUVtW9f4LapGuhU1tyLftF+lWzMP0WxEOmGf+824zTSOPHuugM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCjAa/qx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433E6C4CEF7;
	Mon,  9 Mar 2026 13:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773061369;
	bh=8DNFqs9BqyWbsZij3jgAnNR3Kg6pkLFQFJhfdOuSUtA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BCjAa/qxra1Sa1Hn2PhEc7IljzEUxXbuDPwi7EdNmLZr1ctd7lO8oep6GHv7aL592
	 co3fi/w8tqJlw0H0c0w57HGLcAPT0j2RBnkW/cVDUuF7RMu8XYb3Yb31CcRqnDdpAZ
	 LxM9IKzmY5nzU9Zog8E8xHzrFKOtKoVn3YcIMj3quOHGDMfzUEvQKSn9OvQnPK/ewV
	 hYqVO5sXG1NV7FUfxrsdMOEEd5xjKem59lcH3arzAR1I0Bg7qhVU9WAMzwSQZbIzsY
	 jkGlUHzHeMlSOVhn/PlUQjjqOAw6HKCIZqIGt0qpgLZFjOWZvLzu8VcO4sp0BWXtOI
	 kEZanN/flpcNA==
Message-ID: <4e3cd289-2b7a-4f64-99f6-05eb9d67c0fc@kernel.org>
Date: Mon, 9 Mar 2026 14:02:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10 net-next] Convert CONFIG_IPV6 to built-in and remove
 stubs
To: Daniel Borkmann <daniel@iogearbox.net>,
 Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org
References: <20260309022013.5199-1-fmancera@suse.de>
 <48ccec3f-dbc8-45c8-afda-e4f7e8f150d6@kernel.org>
 <cd87ed46-b774-4896-b25e-4806eec9e0b3@suse.de>
 <6c005900-3461-4e3c-a396-b2984735af9b@kernel.org>
 <51102620-fb8a-467e-9144-786d1fe27e31@iogearbox.net>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <51102620-fb8a-467e-9144-786d1fe27e31@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 06FF42395BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265544-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.941];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,wikipedia.org:url]
X-Rspamd-Action: no action

On 09/03/2026 13:58, Daniel Borkmann wrote:
> On 3/9/26 1:43 PM, Krzysztof Kozlowski wrote:
>> On 09/03/2026 12:38, Fernando Fernandez Mancera wrote:
>>> On 3/9/26 11:22 AM, Krzysztof Kozlowski wrote:
>>>> On 09/03/2026 03:19, Fernando Fernandez Mancera wrote:
>>>>> Historically, the Linux kernel has supported compiling the IPv6 stack as
>>>>> a loadable module. While this made sense in the early days of IPv6
>>>>> adoption, modern deployments and distributions overwhelmingly either
>>>>> build IPv6 directly into the kernel (CONFIG_IPV6=y) or disable it
>>>>> entirely (CONFIG_IPV6=n). The modular IPv6 use-case provides little to
>>>>> no practical benefit today.
>>>>
>>>> It does. We all use generic kernels, thus it is one configuration for
>>>> all boards and some setups have IPv6 and some not. The ones without IPv6
>>>> just don't use that module.
>>>
>>> While I understand this, I would like to clarify that IMHO IPv6 isn't a
>>> secondary protocol and it is fundamental to modern networking. This is
>>
>> Not for end user devices. None of my devices - neither routers, nor
>> embedded boards, nor mobile phone from 5G provider - receive IPv6
>> address, thus for them it is not fundamental.
> 
> If that is the case for them, then they should just CONFIG_IPV6=n.

That's not a question to me. Look what I wrote: "We all use generic
kernels" - in a meaning of generic kernel, with generic defconfig built
once serving every machine.

> 
>> I agree it is fundamental for your cloud machines and network backbone
>> which you are targeting, but this patchset completely ignores other
>> users calling their use-cases "little practical benefit"! Try running
>> Amiga machine...
> 
> Are you talking about [0]? That's legacy hardware and in this case just

Dunno what is legacy there...

> disable IPv6 altogether, why would you still prefer to have it as a module?

That's not a question to me - someone added it as a module now. The
author here changes it to built-in.


> 
>    [0] https://en.wikipedia.org/wiki/Amiga
> 
>> There is no even bloatometer stats for these defconfigs so we can see
>> the impact.
>>
>>> why I believe it should be built-in by default. Currently OpenWRT,
>>> Debian ARM and others already ships the kernel with CONFIG_IPV6=y. I
>>> know that Alpine and Yocto doesn't do that for arm64.
>>
>> Maybe there are other reasons why distro should not choose it as module
>> (like module load calls on ipv6 packets) but that was not explained here.
>>
>> Arch Linux Rpi kernel on arm64 has IPV6=6 and the module itself is 650
>> kB. That's noticeable for smaller arm64 boards.
>>
>> For arm it would be even more noticeable as some have 256 MB RAM like
>> first Rpi.
> 
> You are arguing that these will never be able to migrate to an IPv6 world
> given their memory is too small?

No. I argue that they do not need IPv6 in many cases, thus use-case of
IPV6=m is perfectly valid.

The entire discussion here started with "The modular IPv6 use-case
provides little to no practical benefit today."

and this is clearly false. I brought you already few arguments of valid
use case today.

> 
>>> I guess the most critical one here is Yocto but if the developer of the
>>> embedded device is sure they won't use IPv6 at all, they should turn it off.
>>>
>>> At the same time, Alpine ships software that enable IPV6 and is
>>> frequently loaded as a module. So the only remaining concern would be
>>> the boot partition size. I don't really have a solution for that problem.
>>>
>>> I think that the infrastructure for allowing IPV6=m is bug-prone and it
>>> impacts performance. Forcing the use of indirect function calls in core
>>> networking, Netfilter or BPF datapaths seems like a heavy tax to me.
>>>
>>>> Also, with these generic kernels (so again all machines are using same
>>>> ones, e.g. distro) users can easily blacklist the module.
>>>
>>> FWIW; users can still boot with kernel command line parameter
>>> ipv6.disable=1 and then IPV6 will be administratively disabled.
>>
>> It's not the same. You enabled it on amiga_defconfig and do you
>> understand what sort of machine is that? The newest have 16 MB RAM, many
>> much less like 2 MB, and ipv6 module on m68k is 400 kB, so pretty
>> significant change.
> 
> If IPv6 is not relevant for amiga_defconfig presumably it should just be
> set to CONFIG_IPV6=n?

It might be relevant to some, but this makes it relevant to everyone on
Amiga.

There is a reason why kernel supports modules or do you suggest "modules
provide little to no practical benefit today" and let's just have
everything built-in or disabled.

Best regards,
Krzysztof

