Return-Path: <netdev+bounces-265543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHeMIhvFrmn2IgIAu9opvQ
	(envelope-from <netdev+bounces-265543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:03:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF9F2395C5
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18724302529C
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 12:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBB53AA183;
	Mon,  9 Mar 2026 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="IEDK6tLK"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362363A7855;
	Mon,  9 Mar 2026 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773061114; cv=none; b=T52Rbw5IPN7x8QRXbpKZ8XW6ByQO0JRL2xSnjUoaSt1mKwpzbjxlUOoC6ctOcYgfyUMjfuWf8hdHnC6UveiLlFyxaLHbjC+T66xAr2VleZXtOA+dgzpRaBDDsgS1FtQ0JKbNpxugys71qkS5o5ZlzIcdEaAIGqpj2qGIoCBqT5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773061114; c=relaxed/simple;
	bh=vHbmHT5BUDUicNUn9LilG2dXU0h7Pmwnl/PnO2DOQKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJ39+IfRMXmHWLm5NghXzM0Ez4OCc49dpzu/r9ZxmvHup+ZbPaIi49gBU3t9cibG6ePi2+W/nufw0Z6mEAqtNleeJRnnURIAiUxikkU6HNPZmI1FNaNhESv20nmcX0tA8n9IcagTweLn4RqutQXqR2mCvKSpWROIrbO79BQGvbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=IEDK6tLK; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6YH2slMDHCV8exzefiGO8AstCpcN5x4HQn4xuVE6IkQ=; b=IEDK6tLKaZ3hqlbqmozeF2ddxf
	LnXOCU3w9EyQT53Ra3X4uQTtZjB35v/nVD78hoyaKjJhd/9zLD/iEoM2Qdj8uARNugglmakpDNVgB
	Xe5LNuVVxUCeNf+bJJAPgITgEG2C1zgD3c3wbF6gXsXNwDs0fwBKtReBcXIgV9cWsKD6ysH3PekAj
	pbzMWELkoPYZAs5XVEyHx2wpQ7n8Z3csgJduxXdCG7py0Ki7uCvCKc29rqiiJNouww79pC77lTN0g
	6z+3W73VZ5BnSvu+QNxxBU/F9fyipfpK1IOH5lXJKaBeh6F/Ajmr9sGgXKedPDhoDWf//BBJ4H71t
	C8Jq49+g==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vzaBY-000NgZ-2R;
	Mon, 09 Mar 2026 13:58:12 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1vzaBY-000CDE-0E;
	Mon, 09 Mar 2026 13:58:12 +0100
Message-ID: <51102620-fb8a-467e-9144-786d1fe27e31@iogearbox.net>
Date: Mon, 9 Mar 2026 13:58:11 +0100
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
 Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org
References: <20260309022013.5199-1-fmancera@suse.de>
 <48ccec3f-dbc8-45c8-afda-e4f7e8f150d6@kernel.org>
 <cd87ed46-b774-4896-b25e-4806eec9e0b3@suse.de>
 <6c005900-3461-4e3c-a396-b2984735af9b@kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <6c005900-3461-4e3c-a396-b2984735af9b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27935/Mon Mar  9 07:25:00 2026)
X-Rspamd-Queue-Id: 6DF9F2395C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TAGGED_FROM(0.00)[bounces-265543-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.991];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wikipedia.org:url,iogearbox.net:dkim,iogearbox.net:mid]
X-Rspamd-Action: no action

On 3/9/26 1:43 PM, Krzysztof Kozlowski wrote:
> On 09/03/2026 12:38, Fernando Fernandez Mancera wrote:
>> On 3/9/26 11:22 AM, Krzysztof Kozlowski wrote:
>>> On 09/03/2026 03:19, Fernando Fernandez Mancera wrote:
>>>> Historically, the Linux kernel has supported compiling the IPv6 stack as
>>>> a loadable module. While this made sense in the early days of IPv6
>>>> adoption, modern deployments and distributions overwhelmingly either
>>>> build IPv6 directly into the kernel (CONFIG_IPV6=y) or disable it
>>>> entirely (CONFIG_IPV6=n). The modular IPv6 use-case provides little to
>>>> no practical benefit today.
>>>
>>> It does. We all use generic kernels, thus it is one configuration for
>>> all boards and some setups have IPv6 and some not. The ones without IPv6
>>> just don't use that module.
>>
>> While I understand this, I would like to clarify that IMHO IPv6 isn't a
>> secondary protocol and it is fundamental to modern networking. This is
> 
> Not for end user devices. None of my devices - neither routers, nor
> embedded boards, nor mobile phone from 5G provider - receive IPv6
> address, thus for them it is not fundamental.

If that is the case for them, then they should just CONFIG_IPV6=n.

> I agree it is fundamental for your cloud machines and network backbone
> which you are targeting, but this patchset completely ignores other
> users calling their use-cases "little practical benefit"! Try running
> Amiga machine...

Are you talking about [0]? That's legacy hardware and in this case just
disable IPv6 altogether, why would you still prefer to have it as a module?

   [0] https://en.wikipedia.org/wiki/Amiga

> There is no even bloatometer stats for these defconfigs so we can see
> the impact.
> 
>> why I believe it should be built-in by default. Currently OpenWRT,
>> Debian ARM and others already ships the kernel with CONFIG_IPV6=y. I
>> know that Alpine and Yocto doesn't do that for arm64.
> 
> Maybe there are other reasons why distro should not choose it as module
> (like module load calls on ipv6 packets) but that was not explained here.
> 
> Arch Linux Rpi kernel on arm64 has IPV6=6 and the module itself is 650
> kB. That's noticeable for smaller arm64 boards.
> 
> For arm it would be even more noticeable as some have 256 MB RAM like
> first Rpi.

You are arguing that these will never be able to migrate to an IPv6 world
given their memory is too small?

>> I guess the most critical one here is Yocto but if the developer of the
>> embedded device is sure they won't use IPv6 at all, they should turn it off.
>>
>> At the same time, Alpine ships software that enable IPV6 and is
>> frequently loaded as a module. So the only remaining concern would be
>> the boot partition size. I don't really have a solution for that problem.
>>
>> I think that the infrastructure for allowing IPV6=m is bug-prone and it
>> impacts performance. Forcing the use of indirect function calls in core
>> networking, Netfilter or BPF datapaths seems like a heavy tax to me.
>>
>>> Also, with these generic kernels (so again all machines are using same
>>> ones, e.g. distro) users can easily blacklist the module.
>>
>> FWIW; users can still boot with kernel command line parameter
>> ipv6.disable=1 and then IPV6 will be administratively disabled.
> 
> It's not the same. You enabled it on amiga_defconfig and do you
> understand what sort of machine is that? The newest have 16 MB RAM, many
> much less like 2 MB, and ipv6 module on m68k is 400 kB, so pretty
> significant change.

If IPv6 is not relevant for amiga_defconfig presumably it should just be
set to CONFIG_IPV6=n?

Thanks,
Daniel

