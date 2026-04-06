Return-Path: <netdev+bounces-275725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB7yEDQZ1GlorAcAu9opvQ
	(envelope-from <netdev+bounces-275725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:36:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BC13A73E1
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 22:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FF65300D55C
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 20:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA03D2FAC0E;
	Mon,  6 Apr 2026 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="PuXdArmy"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115F22D1303;
	Mon,  6 Apr 2026 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775507063; cv=none; b=Bvxmsrbpocis+prz2xaj5GVM/cs8mQAbTKAIQwJd9FIm87VMrmEEZ7CxhDMJJsVH1cl97ypyPIrHIHce4Q343AzuBwn+j32K6M79hOshPyW8tUg0W4urc6H/qrJMNMUKnSb+3r+ogVnk4J5cTMBzbp5aSPjD9BdufZVjBuInnNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775507063; c=relaxed/simple;
	bh=kD3qMn/QwOra99S1JShD4jJdRKCWREFKFC0iP6yhfSY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Ytao9d/mRWbY31Y1vJ2P3dyV9fSY7hgw2bpRFkEysdxS3jwE/IPc1dmnw0Iu795G4iRJ13Yf+5h32Nfuo1iAefmfaWoyjF+0nxNhbM+JHM67A4Bbg0E6ZvQ4FaSoKPhH8VbjTkeXPLxbrsOcsP3kCjwQ4f3uCYa3jvNQiQ+XmPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=PuXdArmy; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9FCBAA26FD;
	Mon,  6 Apr 2026 22:24:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775507056; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/Mg0y47EK3uAoeIaCfzd7gz2Sros7bHOlKo7jG+JGdM=;
	b=PuXdArmynN1L+WpiPkX5NRT04lKuj2cPUJxDUHfkHq1zZLyAAGnHPAObjvJ55h7+EJzXvU
	62TDxA0e5I8Dl4uj/G5ToZKUz1/uVS31hummP9QpiDKJGPARD0WHZMdd6P+fhfDcRJiDPY
	GY4OsGVSPtf/WODEA6s+VzM86NyyTYbu23YoFA+0V2TZ8GFnQ4Q4uoa5URA6Ufi1yZpvhk
	BXbbcxujidUD3TKjP4WPZ3flOtjYNvwl3EbaapU7y1mVbkUUn+fAL6XaFoBzvA8gQthEry
	NLI1AXQl7VXillu6QSbTT2uyMyQFmFdW9MbdmgX8j4xgGog9NxW/XXe0lTweNA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 06 Apr 2026 22:24:14 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 netdev@vger.kernel.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mbloch@nvidia.com
Subject: Re: [PATCH net-next] docs: netdev: document AI-assisted review
 tooling
In-Reply-To: <345722f0-21b1-4970-8c45-ef85edf9d45b@suse.de>
References: <20260406-nb-docs-ai-review-v1-1-b58943762ca9@tipi-net.de>
 <345722f0-21b1-4970-8c45-ef85edf9d45b@suse.de>
Message-ID: <56c5bdfe2e37738e47b3b4d22e21697c@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	TAGGED_FROM(0.00)[bounces-275725-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,linux.dev:url,tipi-net.de:dkim,tipi-net.de:mid]
X-Rspamd-Queue-Id: 52BC13A73E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 6.4.2026 21:58, Fernando Fernandez Mancera wrote:
> [...]

> 
> Hi Nicolai,
> maybe I am missing something but [2] isn't from sashiko.dev but from 
> netdev AI CI instead. See: 
> https://netdev-ai.bots.linux.dev/ai-review.html?id=0b114a22-9aab-4265-8bfc-ea1b5bca5514

You're right, I mixed up the two systems - the example I linked was
from the netdev AI bot, not Sashiko. My mistake on the link.

I stumbled over Sashiko when I noticed the name appearing more often
in other reviews and then found Jonathan's LWN article about it [1].

Both tools are actively reviewing patches on the list today. I think
it makes sense to document both rather than just one:

The netdev AI bot at netdev-ai.bots.linux.dev
Sashiko at sashiko.dev, which posts reviews publicly on its website
Both use the same review prompts by Chris Mason [2], so there is
common ground - though results will vary between them due to the
different AI models (Claude Opus for netdev-ai, Gemini for Sashiko)
on top of the usual AI uncertainty.

I think it would be useful to document that AI reviews are happening
but mixing AI bots might confuse people.

Agreed, I'll rework the patch to distinguish the two systems once
the discussion has been settled.

> 
> The documentation mentioned for running the AI locally is correctly 
> related to netdev AI bot.
> 
> I think it would be useful to document that AI reviews are happening 
> but mixing AI bots might confuse people.
> 
>> Check for findings on your submissions and address
>> +valid ones before a maintainer has to relay the same questions.
>> +
> 
> I wonder what would be the consequences for this. If less experienced 
> submitters are expected to address issues pointed out by AI bots they 
> might work on something that isn't valid. AFAIU, the AI output is only 
> forwarded to the submitter after a maintainer reviewed it and believes 
> it makes sense.

Fair point. The wording should make clear that the local tooling is
an optional aid, not an obligation. I'll soften the language around
addressing findings.

Would appreciate input on how much detail is appropriate here -
should the doc just acknowledge that AI review exists and point to
the tooling, or go into more detail about the workflow?

[1] https://lwn.net/Articles/1063292/
[2] 
https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/networking.md

> 
> Thanks,
> Fernando.
> 
>> +You can also run AI reviews locally before submitting. Instructions
>> +and tooling are available at:
>> +
>> +  https://netdev-ai.bots.linux.dev/ai-local.html
>> +
>>   Testimonials / feedback
>>   -----------------------
>> 

Thanks for your input

Nicolai

