Return-Path: <netdev+bounces-304672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VXjRNvIqSGr2nAAAu9opvQ
	(envelope-from <netdev+bounces-304672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 23:34:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF36705E2A
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 23:34:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="JZynY/Rx";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304672-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304672-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 876F1301700F
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 21:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8293C3264EF;
	Fri,  3 Jul 2026 21:34:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BEE27B35F;
	Fri,  3 Jul 2026 21:34:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783114478; cv=none; b=Oq2W3VxXj9Dd3MUhDGi3GxfuoO6ZrWLCmGhV5MBakw/DH5Au5RjBpFuZzrr6EdoAByxDTt2+ezb3GG+Wd+hLDTkw+YJSAsUin+7P3Iz2/xRbE8jlit08NcWmgku9Eyc9qFtc+fuNodBwxNfTZ3uXLYHvQmajbCrpwdF760dtVnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783114478; c=relaxed/simple;
	bh=x0bvJLKJaAc6rYVnc8di40rWewd25QyVRfeGTu6MwZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWmU0mOF5enKm45oT5KQbcsDaa7CIgKshYS5wm76e21+VtvZTtRSEm5ojB20m0HpT+D+YFRRgmIkpo8oDHnqPe68pj8tW2jNPqmYUO8ewTvfBIP2WIlLQVt7w/eWU0WuyguO4Qt4S101RntwUy5SS0q8prJ6FEDmjbNs88m80XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZynY/Rx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631141F000E9;
	Fri,  3 Jul 2026 21:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783114477;
	bh=0HjjJtel6gpE7V/w3HMWnHHVGlGEUs52zAzp1l+F7aU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JZynY/RxCUwX90FxlGkLCzwOgWllCnzx9VCS7KJjVIbDn7IXe2uT2ea+DrzvdkC10
	 KLuvk1POTRdkiLEuxqMI37FnMU5S1Ljduy2u/YP4sVFDB+QMj75/XisTY4W4+grzYe
	 xj8QwBuXj7lT/BX/Po8jhoUctHSBnZkYMpmDktPGjLwOeOcfiUuIzGfToadJAKzy/t
	 zCiJsuwUPnPGVu+Z03uYwMEUF8GRcuMsjm31XopoAP/lWS4Ckibqo8mXz6Iyl4/EoX
	 nSyb5IOrdLjXF4tPk7WADGlaHLjmXkpR6g9J+GliKpvIsT1grF1u03Y6GY5shz/C9w
	 cQubIvu8kAmhw==
Message-ID: <2d9312a5-0847-41db-bbea-54e66869d91e@kernel.org>
Date: Fri, 3 Jul 2026 15:34:34 -0600
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
 <916191fc-2e10-4449-b82b-c086d90283ae@kernel.org> <87y0fv0y79.fsf@toke.dk>
 <9d14ff4b-eadd-4ae2-ab68-5927d4f19eeb@kernel.org> <87ik6x1m9n.fsf@toke.dk>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <87ik6x1m9n.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:toke@redhat.com,m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,kernel.org,iogearbox.net];
	TAGGED_FROM(0.00)[bounces-304672-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DF36705E2A

On 7/2/26 8:47 AM, Toke Høiland-Jørgensen wrote:
> David Ahern <dsahern@kernel.org> writes:
> 
>> On 7/1/26 5:02 AM, Toke Høiland-Jørgensen wrote:
>>> David Ahern <dsahern@kernel.org> writes:
>>>> Seems to me the fib_lookup for xdp needs to return the bottom device,
>>>> not the vlan device, for forwarding to work. That's why I added the
>>>> fields to the struct. That allows the program to push the vlan header if
>>>> required. My preference (dream?) was that Tx path had support to tell
>>>> the redirect the vlan and h/w added it on send.
>>>
>>> Sure, returning the bottom device index with the VLAN tag makes sense,
>>> and that's basically what this series does (but bails out on stacked
>>> VLANs). However, that's not what the helper does today, which is why the
>>> flag is there, to opt-in to the new behaviour. I don't think we can just
>>> change the ifindex without breaking existing applications (as noted
>>> up-thread).
>>
>> I do not see it as breaking existing programs which is why I chimed in
>> on the thread.
>>
>>>
>>>> But really, once stacked devices come into play, I just wanted to make
>>>> sure thought is given to different use cases. As you know the lookup
>>>> struct if hard bound to 64B and it is trying to cover a lot of use cases.
>>>
>>> Agreed, I don't think we can handle stacked devices in this helper. But
>>> we could split it out into a new one. Something like:
>>>
>>> struct lower_device_info {
>>> 	enum device_type type;
>>> 	struct {
>>> 		__be16	h_vlan_proto;
>>> 		__be16	h_vlan_TCI;
>>> 	} vlan;
>>>         /* add other types here */
>>> };
>>>
>>> int xdp_get_lower_device(int ifindex, struct lower_device_info *info);
>>>
>>> called like:
>>>
>>> int xdp_program(struct xdp_md *ctx)
>>> {
>>>         struct lower_device_info dev_info = {};
>>> 	int ifindex, ret;
>>>
>>>         ifindex = find_destination(ctx); /* does fib lookup, or something else */
>>>
>>>         while ((ret = xdp_get_lower_device_info(ifindex, &dev_info)) > 0) {
>>>         	if (dev_info.type == VLAN) {
>>>                       	push_vlan_tag(ctx, &dev_info.vlan);
>>>                         ifindex = ret;
>>>                 } else {
>>>                 	return XDP_PASS; /* we only handle VLAN devices */
>>>                 }
>>>         }
>>>
>>>         return bpf_redirect(ifindex, 0);
>>> }
>>>
>>>
>>> With a helper like this, we obviously don't strictly speaking need to
>>> change the fib lookup helper at all. However, for the single-tagged VLAN
>>> case, I think supporting it directly in the fib lookup could still have
>>> value, as an optimisation: it saves an extra call for resolving the
>>> ifindex, and the fields are already there. So I think my preference
>>> would be to merge this series as-is, and then follow up with a new kfunc
>>> to handle the stacked case. But we could also just drop this series and
>>> go straight to the new kfunc.
>>>
>>> WDYT?
>>
>> no preference. I only chimed in because of the added flag to the uapi
>> which I do not see as needed. If the consensus is that it is in fact
>> needed, all good then.
> 
> Alright, cool - care to provide an ACK, then? :)
> 


Acked-by: David Ahern <dsahern@kernel.org>



