Return-Path: <netdev+bounces-275720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id j/b0EnAQ1GmCqgcAu9opvQ
	(envelope-from <netdev+bounces-275720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 21:58:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A69753A6D21
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 21:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF6713006B61
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 19:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7C4398910;
	Mon,  6 Apr 2026 19:58:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E16D397E6C
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775505514; cv=none; b=s25XFEqx812oCHidZsa7kOUJV54GicLgNjQwYjOmjSWVHbGBDUPtMI60GKDWxDEof2CeFc3UlIB8njFvSUMvaWaulLUY2R9Vuw7pC8/6R42CtNIUrb7omSdnoOJLzyBLOWF2fSEWy4EyWWiYo+gMtlSC0na+o0AF7+nYsyKFDw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775505514; c=relaxed/simple;
	bh=I78/UicW+3hCmr69SW5qwZkWf3Gw6hcPflvcdDFYlrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2ODc7ten0Hnfqgj2PAavbrhGqiam/yRJNShA+NC4JgoltoFD59z8DV1ytALiU8hCIm7oKGebfmt41naxARa7Vb5R87FVZSdGFJrP5PwOd4Z/lOnzOqE+UFtGvkThKjm00hHm+l5jC/MEo17Cq3QZxtk7SR704GmsqfFLqjlYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7C0DA4E082;
	Mon,  6 Apr 2026 19:58:30 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C62B34A0B0;
	Mon,  6 Apr 2026 19:58:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pbLvLGUQ1GmcMwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 06 Apr 2026 19:58:29 +0000
Message-ID: <345722f0-21b1-4970-8c45-ef85edf9d45b@suse.de>
Date: Mon, 6 Apr 2026 21:58:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] docs: netdev: document AI-assisted review
 tooling
To: Nicolai Buchwitz <nb@tipi-net.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260406-nb-docs-ai-review-v1-1-b58943762ca9@tipi-net.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260406-nb-docs-ai-review-v1-1-b58943762ca9@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275720-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.949];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,linux.dev:url,tipi-net.de:email]
X-Rspamd-Queue-Id: A69753A6D21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 9:40 PM, Nicolai Buchwitz wrote:
> Add a section about Sashiko, the Linux Foundation's open-source
> AI review system for kernel patches. Contributors can check review
> feedback on the Sashiko website and address findings proactively,
> reducing the need for maintainers to relay the same questions.
> 
> Also point to the local review tooling at netdev-ai.bots.linux.dev
> for contributors who want to run AI reviews before submitting.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
> Sashiko [1] reviews are already being used on the list (e.g. [2])
> but there's no mention of them in the netdev docs. Add a section
> so contributors know they can check and respond to AI review
> feedback directly.
> 
> Based on Jakub's reviewer guidance patch [3].
> 
> [1] https://sashiko.dev/
> [2] https://lore.kernel.org/all/20260324024235.929875-1-kuba@kernel.org/
> [3] https://lore.kernel.org/all/20260406175334.3153451-1-kuba@kernel.org/
> ---
>   Documentation/process/maintainer-netdev.rst | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index bda93b459a0533fa1adfd11b756a4f47d1dbaa22..27296afb05d3828a350b4ed5c16907672db9785d 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -559,6 +559,19 @@ Reviewers are highly encouraged to do more in-depth review of submissions
>   and not focus exclusively on process issues, trivial or subjective
>   matters like code formatting, tags etc.
>   
> +AI-assisted review
> +~~~~~~~~~~~~~~~~~~
> +
> +Patches posted to netdev are automatically reviewed by the Sashiko
> +AI review system (https://sashiko.dev/). Results are posted publicly
> +on the website. 

Hi Nicolai,

maybe I am missing something but [2] isn't from sashiko.dev but from 
netdev AI CI instead. See: 
https://netdev-ai.bots.linux.dev/ai-review.html?id=0b114a22-9aab-4265-8bfc-ea1b5bca5514

The documentation mentioned for running the AI locally is correctly 
related to netdev AI bot.

I think it would be useful to document that AI reviews are happening but 
mixing AI bots might confuse people.

> Check for findings on your submissions and address
> +valid ones before a maintainer has to relay the same questions.
> +

I wonder what would be the consequences for this. If less experienced 
submitters are expected to address issues pointed out by AI bots they 
might work on something that isn't valid. AFAIU, the AI output is only 
forwarded to the submitter after a maintainer reviewed it and believes 
it makes sense.

Thanks,
Fernando.

> +You can also run AI reviews locally before submitting. Instructions
> +and tooling are available at:
> +
> +  https://netdev-ai.bots.linux.dev/ai-local.html
> +
>   Testimonials / feedback
>   -----------------------
>   

