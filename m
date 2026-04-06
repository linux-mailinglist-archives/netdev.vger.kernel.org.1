Return-Path: <netdev+bounces-275740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNKYNooi1GlxrgcAu9opvQ
	(envelope-from <netdev+bounces-275740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:15:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 471B83A777A
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 293D530641D7
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 21:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A31A38D014;
	Mon,  6 Apr 2026 21:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EAm+McgM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HYuA/k3/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EAm+McgM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HYuA/k3/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7930536DA1A
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775510059; cv=none; b=Ryn7JACMKMVO2biwd9g7ocBCkktoKmoKCe3/HX2prxReF77GI/9y6JS5RgmXB9oHxoKPWlzqvEpr9GzPTvy7MBvSxkvUPxAuO2k27tadD7E7E7TMV/+MMVNeRPaDOxPmWZOKp5eNPBU4gB5vEGw71dJUbBds59k3UnUqhKfoMwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775510059; c=relaxed/simple;
	bh=yQI2hucAupVyRTWavsrdMoHVdq2ezUeT7+RpkygVu2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQESbuqs7U4Ic7wnJqImc/ZAUJIiiExV83bNs6OOQ5cglttvlmdpGkhvPX4jCpEXdrrtzuQOqN5YzD2j3xtVU24LlUVwX0JfZBhPaHQjAT9ySsFaeD8GD/bPfEmOxeYFAX0Yl5QWOkQnJOaNP4+sl/orSx7cI+A2VnGm5DScJzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EAm+McgM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HYuA/k3/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EAm+McgM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HYuA/k3/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 67A4E5BD48;
	Mon,  6 Apr 2026 21:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775510056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1AWo8CavFFDUlQFTl1sblytoQrwi8RwdUfstHMGxg+Y=;
	b=EAm+McgMWvEAMWzObHTx5Axb3fmCwBU0rGxqEVoiZoOOvxyqcPUI8Nlrf50XsECTNtS5Zu
	sKWHMdRNG30Wg0rYlRUpr4pPQU2rTdSJcp5kn6xf5lJ+jDpQakCwBaQ68R0lkaKp1h5y0H
	4xQflKCvnaXGPdRDkI1Kt4WLkPwsU8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775510056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1AWo8CavFFDUlQFTl1sblytoQrwi8RwdUfstHMGxg+Y=;
	b=HYuA/k3/GZPXBvbMfFl+BEq/hGp+lC9TNAEl3vG4WHvxayJBKVY2kV+4G6cmjj+CZisXcL
	xblREPEQazCPAdCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EAm+McgM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="HYuA/k3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775510056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1AWo8CavFFDUlQFTl1sblytoQrwi8RwdUfstHMGxg+Y=;
	b=EAm+McgMWvEAMWzObHTx5Axb3fmCwBU0rGxqEVoiZoOOvxyqcPUI8Nlrf50XsECTNtS5Zu
	sKWHMdRNG30Wg0rYlRUpr4pPQU2rTdSJcp5kn6xf5lJ+jDpQakCwBaQ68R0lkaKp1h5y0H
	4xQflKCvnaXGPdRDkI1Kt4WLkPwsU8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775510056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1AWo8CavFFDUlQFTl1sblytoQrwi8RwdUfstHMGxg+Y=;
	b=HYuA/k3/GZPXBvbMfFl+BEq/hGp+lC9TNAEl3vG4WHvxayJBKVY2kV+4G6cmjj+CZisXcL
	xblREPEQazCPAdCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F3BB4A0B0;
	Mon,  6 Apr 2026 21:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bNdzIyci1GnQewAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 06 Apr 2026 21:14:15 +0000
Message-ID: <7b3c4791-674a-4420-879a-98b243827b63@suse.de>
Date: Mon, 6 Apr 2026 23:14:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] docs: netdev: document AI-assisted review
 tooling
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 netdev@vger.kernel.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mbloch@nvidia.com
References: <20260406-nb-docs-ai-review-v1-1-b58943762ca9@tipi-net.de>
 <345722f0-21b1-4970-8c45-ef85edf9d45b@suse.de>
 <56c5bdfe2e37738e47b3b4d22e21697c@tipi-net.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <56c5bdfe2e37738e47b3b4d22e21697c@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-275740-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lwn.net:url,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 471B83A777A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 10:24 PM, Nicolai Buchwitz wrote:
> On 6.4.2026 21:58, Fernando Fernandez Mancera wrote:
>> [...]
> 
>>
>> Hi Nicolai,
>> maybe I am missing something but [2] isn't from sashiko.dev but from 
>> netdev AI CI instead. See: https://netdev-ai.bots.linux.dev/ai- 
>> review.html?id=0b114a22-9aab-4265-8bfc-ea1b5bca5514
> 
> You're right, I mixed up the two systems - the example I linked was
> from the netdev AI bot, not Sashiko. My mistake on the link.
> 
> I stumbled over Sashiko when I noticed the name appearing more often
> in other reviews and then found Jonathan's LWN article about it [1].
> 
> Both tools are actively reviewing patches on the list today. I think
> it makes sense to document both rather than just one:
> 
> The netdev AI bot at netdev-ai.bots.linux.dev
> Sashiko at sashiko.dev, which posts reviews publicly on its website
> Both use the same review prompts by Chris Mason [2], so there is
> common ground - though results will vary between them due to the
> different AI models (Claude Opus for netdev-ai, Gemini for Sashiko)
> on top of the usual AI uncertainty.
> 
> I think it would be useful to document that AI reviews are happening
> but mixing AI bots might confuse people.
> 
> Agreed, I'll rework the patch to distinguish the two systems once
> the discussion has been settled.
> 
>>
>> The documentation mentioned for running the AI locally is correctly 
>> related to netdev AI bot.
>>
>> I think it would be useful to document that AI reviews are happening 
>> but mixing AI bots might confuse people.
>>
>>> Check for findings on your submissions and address
>>> +valid ones before a maintainer has to relay the same questions.
>>> +
>>
>> I wonder what would be the consequences for this. If less experienced 
>> submitters are expected to address issues pointed out by AI bots they 
>> might work on something that isn't valid. AFAIU, the AI output is only 
>> forwarded to the submitter after a maintainer reviewed it and believes 
>> it makes sense.
> 
> Fair point. The wording should make clear that the local tooling is
> an optional aid, not an obligation. I'll soften the language around
> addressing findings.
> 

Thank you! Regarding this topic it seems people have been already 
discussing this around other subsystems [1]. It might be useful to check 
out similar discussions and outcomes.

[1] https://lwn.net/Articles/1064830/

> Would appreciate input on how much detail is appropriate here -
> should the doc just acknowledge that AI review exists and point to
> the tooling, or go into more detail about the workflow?
> 

To be honest that is hard for me to tell, I am not a maintainer and not 
the one doing the forwarding currently. I think there isn't an official 
workflow regarding this. Maybe a good starter would be to just mention 
that they exist. Or maybe this is a good opportunity to define an 
official workflow!

Thanks,
Fernando.

