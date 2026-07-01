Return-Path: <netdev+bounces-303704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JbaMHTwoRWrd7woAu9opvQ
	(envelope-from <netdev+bounces-303704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:46:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8006EEEBE
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:46:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mVHKbcZS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303704-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303704-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90BF3307B0B4
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 14:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D4D349CFA;
	Wed,  1 Jul 2026 14:34:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F391F349CEE;
	Wed,  1 Jul 2026 14:34:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916498; cv=none; b=e6AEN5hpqMQ8Y/uPBW2h3OVUDcLQkGAVvZUvru1+VeEfDOXKxF62aFq4SeSo8LKu6D8w4JuezH9Ow2z1JUjzBocWXf/He+XdMn/5V/jxaZgBfCC6Puqj+29NCLtJTdiK6Mo+Ue+1otKGUaZdcfF10rXE+sa96yAVfhuTW2jaI0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916498; c=relaxed/simple;
	bh=bkwbGFNybYY3vquajow6u+y93gwVLQLiUx9HgiHPLjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfDH/aFGIG78OYQJqMbuWmVUNPk2Qs3FpC3RHGvjCE//44AaubYgFC7uqfWr3zn1Ad9a5CHt0Of/uxM6FTdSSB9qJJGoMpkdBmEzvg3fJfXwyogAWEikQT00CM43rxeGwyVMbsdK5KmNNZjNM2kN2S1sm7sm+EUsZCbVKSjrAYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVHKbcZS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0031F000E9;
	Wed,  1 Jul 2026 14:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782916497;
	bh=9Bgu8o2kcltAnH46Ki7THxDtoAr4zQOLwKw0IV3Qi3o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mVHKbcZSH6z9WCSafl7KGYnaavRCt6cmCgYrlP0HbEj83Ay8mpSjRcnlRvCn9kQaV
	 NSajCIxv0MSHey5VP62+5zHEOk5ec+ujph/kW9ISBvkjwExEBp3BOmlI78PJzcWrjt
	 hBbMjcRW9GSMSVtCFCrKCJbkbCvSz0qEtzhMvc5rxSauPTtnpNAjgKms9kZFrdJUlE
	 quXeOD61aJE6nDBkrQwq8vfTvZ3wxofhnFhqdJe6q91t/1C14sJ/WdKtbsHwwnlyTd
	 ZgRgdbzWZU6vM5cZ5hghMxu26SqefBXbsZf0sAbDsZuT0Ad6tKK/G0OQsh7jS6Nhsz
	 KbMEYlErFiw0A==
Message-ID: <87f24e1e-4167-432b-b73c-0fc0c4b7d532@kernel.org>
Date: Wed, 1 Jul 2026 08:34:56 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 2/2] devlink: support u64-array values in
 devlink param show/set
Content-Language: en-US
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: stephen@networkplumber.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us
References: <20260630015012.3728870-1-rkannoth@marvell.com>
 <20260630015012.3728870-3-rkannoth@marvell.com>
 <9d9cceae-3934-4dd6-ae8e-af995ae6b0ab@kernel.org>
 <akR7g8aWfws3h2jx@rkannoth-OptiPlex-7090>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <akR7g8aWfws3h2jx@rkannoth-OptiPlex-7090>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303704-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:stephen@networkplumber.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD8006EEEBE

On 6/30/26 8:29 PM, Ratheesh Kannoth wrote:
> On 2026-06-30 at 20:06:17, David Ahern (dsahern@kernel.org) wrote:
>> On 6/29/26 7:50 PM, Ratheesh Kannoth wrote:
>>> diff --git a/devlink/devlink.c b/devlink/devlink.c
>>> index 9372e92f..3c29601d 100644
>>> --- a/devlink/devlink.c
>>> +++ b/devlink/devlink.c
>>> @@ -3496,13 +3496,115 @@ static const struct param_val_conv param_val_conv[] = {
>>>  };
>>>
>>>  #define PARAM_VAL_CONV_LEN ARRAY_SIZE(param_val_conv)
>>> +#define DEVLINK_PARAM_MAX_ARRAY_SIZE 32
>>
>> Why 32? Is that based on current code?
> Yes, this aligns with the current kernel-side limits. See:
> https://lore.kernel.org/all/20260609040453.711932-5-rkannoth@marvell.com/
> 
>> How does the kernel side handle
>> the number of parameters? What happens if the kernel sends more than 32
>> parameters - from a user's perspective, not this code and processing the
>> output?
> The kernel strictly validates and restricts the number of parameters. To be safe, this patch
> adds an explicit bounds check to prevent userspace issues if that threshold is ever crossed.
> 
> Ideally, since "union devlink_param_value" is omitted from the UAPI, we have to define
> DEVLINK_PARAM_MAX_ARRAY_SIZE here. Moving the underlying structures to the UAPI in the
> future would allow us to share a single definition and avoid this hardcoded value in userspace.

iproute2 needs to be backward and forward compatible. As it stands, a
new kernel can allow more than 32 entries and an older iproute2 will not
display all of them. That is wrong.

Let's make the limit part of the uapi. If you do not want to do that
now, then iproute2 code needs to handle a larger size.


