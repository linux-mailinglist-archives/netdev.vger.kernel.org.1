Return-Path: <netdev+bounces-265550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKJtBcvHrmlwIwIAu9opvQ
	(envelope-from <netdev+bounces-265550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:14:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8275F23987A
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E35D3006F25
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 13:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEFE3AE1B6;
	Mon,  9 Mar 2026 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pEBtoVwF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SiXLuzUE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pEBtoVwF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SiXLuzUE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417B43ACA6C
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062088; cv=none; b=BvS7i4b821Ty13MgQ/HwwJ6VtiI5P7KnW2xKVlYcXTewq3jeM/NGZ3+TWgXOKHduiyDblBAlGTL5t4KoXlCpaAjfsTGiUNC2JQAXN0QhsksuJ1BsTvsBFSjl2b6f7qpLOMNFLFrj+kXxsPmjvKXZpk7jG559kx1zfy+IKdSHoLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062088; c=relaxed/simple;
	bh=hWw3x7UqO+jIneJOqVDoivBKTmYi7t7hHZuCLqwMAmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVvHim693trkcJRdRK+S3HDcCrQq05TGwcqm5HaYe/o6NEWPCKWxs7KQaArSMNcznwbLkadt5OhQax8Hsdzjkpg5bW57Ghgx/xZBf6L0Yh9z2Imy7G/HQnl1WbFIt1yE+bpvznUiyQRmYzVv5pjR90zZ3pyZ8C57WSNVP1dcA7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pEBtoVwF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SiXLuzUE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pEBtoVwF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SiXLuzUE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 37AA55BD8F;
	Mon,  9 Mar 2026 13:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773062085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARDPBUG8WPWh4s0Z3N+hxM7eR2FvtaBgAhV3Hpkw09Q=;
	b=pEBtoVwFIVcbmPfGc+YMXS+DWlI9/LNaiHB4acilwBkoxg/LFrPnOuL5q8kNgRPeEkywao
	WhF6IMUoGsb1Q29oq7aaOduN9rt7FpKKX0aCEGLJJIerDudoKgqOu8AADHYClcGWhS2pvz
	btDBKW9fOs8I8AIaCaZN4xX8BqiJmVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773062085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARDPBUG8WPWh4s0Z3N+hxM7eR2FvtaBgAhV3Hpkw09Q=;
	b=SiXLuzUEL5e6LY4yzR92EpeqQHS1m3HRux3YfjwP/6P4xefsCypGW4l8u238jCU25AYPZ6
	lP0bFmTuq5bLwiBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773062085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARDPBUG8WPWh4s0Z3N+hxM7eR2FvtaBgAhV3Hpkw09Q=;
	b=pEBtoVwFIVcbmPfGc+YMXS+DWlI9/LNaiHB4acilwBkoxg/LFrPnOuL5q8kNgRPeEkywao
	WhF6IMUoGsb1Q29oq7aaOduN9rt7FpKKX0aCEGLJJIerDudoKgqOu8AADHYClcGWhS2pvz
	btDBKW9fOs8I8AIaCaZN4xX8BqiJmVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773062085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARDPBUG8WPWh4s0Z3N+hxM7eR2FvtaBgAhV3Hpkw09Q=;
	b=SiXLuzUEL5e6LY4yzR92EpeqQHS1m3HRux3YfjwP/6P4xefsCypGW4l8u238jCU25AYPZ6
	lP0bFmTuq5bLwiBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A9CB3EEFB;
	Mon,  9 Mar 2026 13:14:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4lGwIsTHrmlmeAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 09 Mar 2026 13:14:44 +0000
Message-ID: <40011f00-b294-4832-b546-e3c40db8b59d@suse.de>
Date: Mon, 9 Mar 2026 14:14:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10 net-next] Convert CONFIG_IPV6 to built-in and remove
 stubs
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org
References: <20260309022013.5199-1-fmancera@suse.de>
 <48ccec3f-dbc8-45c8-afda-e4f7e8f150d6@kernel.org>
 <cd87ed46-b774-4896-b25e-4806eec9e0b3@suse.de>
 <6c005900-3461-4e3c-a396-b2984735af9b@kernel.org>
 <51102620-fb8a-467e-9144-786d1fe27e31@iogearbox.net>
 <4e3cd289-2b7a-4f64-99f6-05eb9d67c0fc@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <4e3cd289-2b7a-4f64-99f6-05eb9d67c0fc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 8275F23987A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265550-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.939];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:dkim,suse.de:mid,wikipedia.org:url]
X-Rspamd-Action: no action

On 3/9/26 2:02 PM, Krzysztof Kozlowski wrote:
> On 09/03/2026 13:58, Daniel Borkmann wrote:
>> On 3/9/26 1:43 PM, Krzysztof Kozlowski wrote:
>>> On 09/03/2026 12:38, Fernando Fernandez Mancera wrote:
>>>> On 3/9/26 11:22 AM, Krzysztof Kozlowski wrote:
>>>>> On 09/03/2026 03:19, Fernando Fernandez Mancera wrote:
>>>>>> Historically, the Linux kernel has supported compiling the IPv6 stack as
>>>>>> a loadable module. While this made sense in the early days of IPv6
>>>>>> adoption, modern deployments and distributions overwhelmingly either
>>>>>> build IPv6 directly into the kernel (CONFIG_IPV6=y) or disable it
>>>>>> entirely (CONFIG_IPV6=n). The modular IPv6 use-case provides little to
>>>>>> no practical benefit today.
>>>>>
>>>>> It does. We all use generic kernels, thus it is one configuration for
>>>>> all boards and some setups have IPv6 and some not. The ones without IPv6
>>>>> just don't use that module.
>>>>
>>>> While I understand this, I would like to clarify that IMHO IPv6 isn't a
>>>> secondary protocol and it is fundamental to modern networking. This is
>>>
>>> Not for end user devices. None of my devices - neither routers, nor
>>> embedded boards, nor mobile phone from 5G provider - receive IPv6
>>> address, thus for them it is not fundamental.
>>
>> If that is the case for them, then they should just CONFIG_IPV6=n.
> 
> That's not a question to me. Look what I wrote: "We all use generic
> kernels" - in a meaning of generic kernel, with generic defconfig built
> once serving every machine.
> 
>>
>>> I agree it is fundamental for your cloud machines and network backbone
>>> which you are targeting, but this patchset completely ignores other
>>> users calling their use-cases "little practical benefit"! Try running
>>> Amiga machine...
>>
>> Are you talking about [0]? That's legacy hardware and in this case just
> 
> Dunno what is legacy there...
> 
>> disable IPv6 altogether, why would you still prefer to have it as a module?
> 
> That's not a question to me - someone added it as a module now. The
> author here changes it to built-in.
> 
> 
>>
>>     [0] https://en.wikipedia.org/wiki/Amiga
>>
>>> There is no even bloatometer stats for these defconfigs so we can see
>>> the impact.
>>>
>>>> why I believe it should be built-in by default. Currently OpenWRT,
>>>> Debian ARM and others already ships the kernel with CONFIG_IPV6=y. I
>>>> know that Alpine and Yocto doesn't do that for arm64.
>>>
>>> Maybe there are other reasons why distro should not choose it as module
>>> (like module load calls on ipv6 packets) but that was not explained here.
>>>
>>> Arch Linux Rpi kernel on arm64 has IPV6=6 and the module itself is 650
>>> kB. That's noticeable for smaller arm64 boards.
>>>
>>> For arm it would be even more noticeable as some have 256 MB RAM like
>>> first Rpi.
>>
>> You are arguing that these will never be able to migrate to an IPv6 world
>> given their memory is too small?
> 
> No. I argue that they do not need IPv6 in many cases, thus use-case of
> IPV6=m is perfectly valid.
> 
> The entire discussion here started with "The modular IPv6 use-case
> provides little to no practical benefit today."
> 
> and this is clearly false. I brought you already few arguments of valid
> use case today.
> 
>>
>>>> I guess the most critical one here is Yocto but if the developer of the
>>>> embedded device is sure they won't use IPv6 at all, they should turn it off.
>>>>
>>>> At the same time, Alpine ships software that enable IPV6 and is
>>>> frequently loaded as a module. So the only remaining concern would be
>>>> the boot partition size. I don't really have a solution for that problem.
>>>>
>>>> I think that the infrastructure for allowing IPV6=m is bug-prone and it
>>>> impacts performance. Forcing the use of indirect function calls in core
>>>> networking, Netfilter or BPF datapaths seems like a heavy tax to me.
>>>>
>>>>> Also, with these generic kernels (so again all machines are using same
>>>>> ones, e.g. distro) users can easily blacklist the module.
>>>>
>>>> FWIW; users can still boot with kernel command line parameter
>>>> ipv6.disable=1 and then IPV6 will be administratively disabled.
>>>
>>> It's not the same. You enabled it on amiga_defconfig and do you
>>> understand what sort of machine is that? The newest have 16 MB RAM, many
>>> much less like 2 MB, and ipv6 module on m68k is 400 kB, so pretty
>>> significant change.
>>
>> If IPv6 is not relevant for amiga_defconfig presumably it should just be
>> set to CONFIG_IPV6=n?
> 
> It might be relevant to some, but this makes it relevant to everyone on
> Amiga.
> 
> There is a reason why kernel supports modules or do you suggest "modules
> provide little to no practical benefit today" and let's just have
> everything built-in or disabled.
> 

Right, maybe that is a too bold statement. Probably it could be 
rephrased to:

"While maintaining a modular IPv6 stack still offers footprint savings 
for specific setups, this benefit is outweighed by the architectural 
burden it imposes on the rest of the kernel."

I believe that having modules is useful. I just do not think it pays off 
here.


