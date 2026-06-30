Return-Path: <netdev+bounces-303308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yNlHAIj5Q2ojmgoAu9opvQ
	(envelope-from <netdev+bounces-303308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:14:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8946E6CF7
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:14:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bfT3adCg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303308-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303308-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C759300D9D8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00773DB338;
	Tue, 30 Jun 2026 17:13:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A333F5A2;
	Tue, 30 Jun 2026 17:13:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839612; cv=none; b=NdHx5yEsMZdsDJKkCWalscBDqisWfJITYI+PNlU21+gJm53ZRlfhnVyiGvobj/yHZmmgMuPogN8Y9r4oRoW88kpG/KWQ/ogqDABOteGZEwdnMumNL0AQD+mAp97VTpESH21QGqMscIRNNxg5PWpIaf3MgZXFkDVQIkCOuxavY0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839612; c=relaxed/simple;
	bh=maSROVvHwhT23x4mQIVE1Dg1TnQPMeYsWHJf9xXF/nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIqihWJHWH9AXvtKeLWzUc/YMH9qjWEcfi5HNNCpf1XF8FQteTOZLM68baBtA+igL7UHGixfaP0zcNTZMiLAKBslaMpo5LpqeQRGuZU5rpOqSgkHO+s9u3Yhy7GLGJsO4XOX4jVAa4Lb+kDjBipFMgXk0o8Ry4PYVDjI2Zk3hjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfT3adCg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9471F000E9;
	Tue, 30 Jun 2026 17:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782839611;
	bh=+ZgEUdCFZUTdRl6MEpNeqgPGG+C6npsAloU8d/7L74M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bfT3adCgYcdsxhBEaYSuU0/Mp/u5+XTWkNMTF6tWRDtxujGQoU48LtyEDE5Kbndec
	 BJBbd4JnL0YjQ27/v6bcJCmb8fnCVGRusjdjuKs1HbX5YHDeqteRvEtc/0vknB0O2F
	 dudA0orCmQqKdGpNSwMf5vXS6AN13Ta+6FHfzcnOGifPR9saBu/qrw8uiELOp3Dq2X
	 xf5RSrEabpbFEeUVfYRLoY/jfZFwyI/qi88EBqj7Zdz1mscQmP/yxINZQwZY6X9ZQl
	 e5a6nEtqXGHS+okEIW8BogO/EBzihZp/CPxUN8YIgpe+Dh9PSwRy7Fm/mit1Wgkv4w
	 b5iEIpaZFmaQg==
Message-ID: <916191fc-2e10-4449-b82b-c086d90283ae@kernel.org>
Date: Tue, 30 Jun 2026 11:13:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Avinash Duduskar <avinash.duduskar@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org,
 yatsenko@meta.com, leon.hwang@linux.dev, kpsingh@kernel.org,
 a.s.protopopov@gmail.com, ameryhung@gmail.com, rongtao@cestc.cn,
 eyal.birger@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260624030530.3342884-1-avinash.duduskar@gmail.com>
 <20260624030530.3342884-2-avinash.duduskar@gmail.com>
 <d820adf6-4a33-45e9-9cfa-17f11a37c9e8@kernel.org> <87se65bd04.fsf@toke.dk>
 <2ffa32dd-5c88-488a-aa23-deef13465eb9@kernel.org> <87echobb5h.fsf@toke.dk>
 <cf25f667-1095-4f84-98ff-bf4662d3faa8@kernel.org> <874iik2ew4.fsf@toke.dk>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <874iik2ew4.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:toke@redhat.com,m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,kernel.org,iogearbox.net];
	TAGGED_FROM(0.00)[bounces-303308-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB8946E6CF7

On 6/30/26 10:04 AM, Toke Høiland-Jørgensen wrote:
> David Ahern <dsahern@kernel.org> writes:
> 
>> On 6/30/26 4:00 AM, Toke Høiland-Jørgensen wrote:
>>>> It does not make sense to require a flag to get lookup output. vlan
>>>> proto of 0 is not valid, so it is a clear indication that the vlan
>>>> output parameters were not set during the lookup.
>>>
>>> Okay, so we could just unconditionally set the VLAN fields, but if we
>>> start rewriting the ifindex that would be a change of the existing
>>> behaviour that could break existing applications, no?
>>
>> Consistently dealing with upper devices is one of the reasons I never
>> sent patches for vlan support.
>>
>> xdp support is at the driver layer for real (physical) devices. The fib
>> lookup is going to return the vlan device index - a virtual device.
>> Support for xdp should not be propagated to virtual devices; it goes
>> against the intent of xdp. Any trip down this path will have to decide
>> how to handle vlan-in-vlan use cases. Where is the line drawn for fast
>> networking?
> 
> Right, which is why we need building blocks that makes it possible for
> XDP programs to do the right thing in the BPF code :)
> 
> A helper that resolves the parent could be used for stacked VLANs as
> well (just calling the helper multiple times).
> 
>>> Specifically, if an XDP application has a table of the interfaces it
>>> forwards between, today they'd get a VLAN interface ifindex, which would
>>> not be in that table, and the application would return XDP_PASS. Whereas
>>> if we change the ifindex and populate the VLAN tag, suddenly the
>>> interface would be in the table, but because the application doesn't
>>> read the returned VLAN tag, it will end up sending packets out without
>>> tagging them, leading to broken forwarding.
>>
>> I have not followed developments over the past few years. Does XDP have
>> support for vlan acceleration in the Tx path now? You really want that
>> to deal with vlans and not replicating s/w processing in ebpf.
> 
> It does not, no. There's TX metadata for AF_XDP, but VLAN support is not
> in there (see include/uapi/linux/if_xdp.h).
> 
> Doesn't mean software VLAN handling can't be useful, though; there are
> use cases other than the very high end where XDP can speed things up
> even if it has to write a VLAN tag or two...
> 
>>> So if we don't want the flag, we'd need some other mechanism to resolve
>>> the parent ifindex, AFAICT? Maybe a xdp_get_parent_ifindex() kfunc, say?
>>> That could also be made generic for other stacked interface types, I
>>> suppose.
>>>
>>> WDYT?
>>
>> dealing with stacked devices is hard :-)
>>
>> What is the return is a bond device or a vlan on a bond device?
> 
> Well, bond devices have XDP support, so you can just redirect to those :)
> 
> But yeah, each type of stacked device would need to pass different
> information through to the XDP program, and the program would need to
> support those. Building a single XDP program that supports all of them
> will require quite a bit of code, and would probably not perform super
> well. But most deployments have distinct subsets of features they need,
> so this does not have to be a blocker, IMO?
> 

Seems to me the fib_lookup for xdp needs to return the bottom device,
not the vlan device, for forwarding to work. That's why I added the
fields to the struct. That allows the program to push the vlan header if
required. My preference (dream?) was that Tx path had support to tell
the redirect the vlan and h/w added it on send.

But really, once stacked devices come into play, I just wanted to make
sure thought is given to different use cases. As you know the lookup
struct if hard bound to 64B and it is trying to cover a lot of use cases.


