Return-Path: <netdev+bounces-302681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iGLfLs1/QmqZ8gkAu9opvQ
	(envelope-from <netdev+bounces-302681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:23:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 660426DBFA4
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:23:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QUTYDiDp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302681-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302681-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D658302D36B
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CC63FF1D5;
	Mon, 29 Jun 2026 14:19:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33BB367F21;
	Mon, 29 Jun 2026 14:19:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742792; cv=none; b=SvEnqFuqJ5NtmuZhMKJDEWKaJ0aR5B8rTmoBVP/gF9/DFCZyRRG1otg0FXPdY0QAgdyMsGXFV0YR5hUTBS/Dja/l2LIHKB3tAIMXra4e78pCnMSuLkKkl/695MhQoa0FVd+6CCL/bZ9wb75eY3VR85SHweUZgeYW3tYeCui1Dgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742792; c=relaxed/simple;
	bh=iS99re75dY3V+PFIZ7qixxTmDNStP83Ea2LWPcXwUO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uir+QdOWV9hyz+N1Bri0DrXJqR/G0onHh77VCuETVtsLqMpT0go8ijNXlaWO/gIaVkzP+xobdrcaNoIxqQNs6zRNComSEWO49ejjbihj0/O1AfenZoBbW6xaHfEqtkAdMbAdKAOZ2B1oMbrB0tvIyIcW0QMlP+OZxlxyjWqvpAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUTYDiDp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CF51F000E9;
	Mon, 29 Jun 2026 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782742790;
	bh=9uP35ct9WDNsGoQMpEhrEgfY0h8qu+42154CsbT28V4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QUTYDiDpncZK1KhL546z/SGfIQMPTVsJm7s5oXih4yz57gBJVbhNOl0LAGujFiNoZ
	 fYHtDzfGYSSw3jGsqkjNFQaWYqZWa9MLogSX53L4f/3PLEboygLMU+HP1Reo6EEvU7
	 Bi0g1V0IRHMGmbAZEyEi09ftAX7dHCxexpXSVDFGWmzbmqPDUZaKmHQz4mbW6DSq0z
	 DFWNhKkIx+v72u0K+CYZvUt4ZjwL2vQ8SSBfBOVdvZUaP9+D4pDe6orHKmJn/rmyoU
	 88L/sx1efa6ros6lojSeSVcRqcGwjgPWFrULKppBlWzkWSKD/kB0ynSzAwUndIZTYb
	 L+KyhgI6u1OtA==
Message-ID: <b93b6a29-2ced-4a0e-82ba-1da8225f9308@kernel.org>
Date: Mon, 29 Jun 2026 08:19:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] devlink: support u32-array values in
 devlink param show/set
Content-Language: en-US
To: Ratheesh Kannoth <rkannoth@marvell.com>, pablo@netfilter.org
Cc: stephen@networkplumber.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 sgoutham@marvell.com, Jiri Pirko <jiri@resnulli.us>
References: <20260615041042.549715-1-rkannoth@marvell.com>
 <e907ee3e-df70-4e32-a69f-29a9baaf1993@kernel.org>
 <akHW1ZiovKdwUq6s@rkannoth-OptiPlex-7090>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <akHW1ZiovKdwUq6s@rkannoth-OptiPlex-7090>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302681-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:pablo@netfilter.org,m:stephen@networkplumber.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:jiri@resnulli.us,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 660426DBFA4

On 6/28/26 8:22 PM, Ratheesh Kannoth wrote:
> On 2026-06-28 at 22:49:48, David Ahern (dsahern@kernel.org) wrote:
>> On 6/14/26 10:10 PM, Ratheesh Kannoth wrote:
>>> @@ -3904,6 +3935,14 @@ static int cmd_dev_param_set(struct dl *dl)
>>>  		if (!strcmp(dl->opts.param_value, ctx.value.vstr))
>>>  			return 0;
>>>  		break;
>>> +	case 129:
>>
>> no magic numbers. What does 129 represent? Is there a named macro for
>> it? If not, why not if this is part of a UAPI?
> 
> The magic number 129 actually represents DEVLINK_PARAM_TYPE_U64_ARRAY from the kernel UAPI (include/uapi/linux/devlink.h).

The uapi is actually devlink_var_attr_type and in this case
DEVLINK_VAR_ATTR_TYPE_U64_ARRAY.

> 
> The other cases in this switch block utilize MNL_TYPE_* constants from libmnl. I previously tried to
> patch libmnl to add a matching MNL_TYPE_UARR = 129 macro, but the netfilter maintainers declined it,
> noting that the enum is internal to libmnl (thread: https://lore.kernel.org/netfilter-devel/20260623043755.2435685-1-rkannoth@marvell.com/).

I agree with them.

Looking at the use of devlink_var_attr_type it is duplicating MNL values
for the early entries, but it is not nla_type as part of the nla_attr
uapi. Seems to me the 'nla_type' reference in the code is misleading.

I think cmd_dev_param_set in iproute2 needs to be changed to reference
devlink_var_attr_type instead of MNL_TYPE_*. With that as a prep patch,
add in the new use of DEVLINK_VAR_ATTR_TYPE_U64_ARRAY for this patch.
@Jiri: agree?

And then your subject line and commit message need to be updated to
reference a u64 array, not u32, correct?

> 
> To resolve this without magic numbers, I can use the existing kernel macro directly in
> the case statement with an explanatory comment, like so:
> 
> 	/* DEVLINK_PARAM_TYPE_U64_ARRAY maps to 129 */
> 	case DEVLINK_PARAM_TYPE_U64_ARRAY:
> 
> Please let me know if this approach works for you, or if you prefer a different handling.
> 
>>


