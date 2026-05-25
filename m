Return-Path: <netdev+bounces-291386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ATZNSaDFGrhNwcAu9opvQ
	(envelope-from <netdev+bounces-291386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 19:13:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 513285CD38F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 19:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7BF0301DEE0
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D753F788D;
	Mon, 25 May 2026 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zzgKiR2t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rsrX3CGJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zzgKiR2t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rsrX3CGJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318033F413B
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729180; cv=none; b=t1U4dAMD6t0vNhdzvuGqwOgHE0nswjwTo+Z3MIj7lNcBtNCoYSGREb0O4BptToqXCwYXNq9kIzNv7nTZwojdMAti0UmHwk0P69kwAEcqJv6pKXPTIXQOQW+64bLHilOWPL3mqNwXSYa6o0AKTnJcXkYxXy+RzPHJOMMz9M+qsME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729180; c=relaxed/simple;
	bh=qnN3kYIddcQPF9rrBfmUHPRHhI0WkKwDoF+8kRKYdxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Il2zQbZOAAwAKzA3LghQMXSFTYFcQiSCOKdhg39vV1/JDjQV0BH3dWTPgkeG1fk+aYx8AC0qGHTSzKL71zaBRssriNvHR9Zs6SQQRR4asSQlqSoChTeKGlaikgJ8x6SErYR4OW5IU0TCsHdG1Pqy956ZFfFL3LX9Vai8KGBzFVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zzgKiR2t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rsrX3CGJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zzgKiR2t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rsrX3CGJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5265967D67;
	Mon, 25 May 2026 17:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779729177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=npNzcK9F9mdlqJnPAobO2T7riqdNKDu0cA5W9ot1FTY=;
	b=zzgKiR2tX5YaMvcEPwWybo895ARZpJQGZG1ySkFIVI5SFxrorHX3nNGJyvCJoWxI5gQvm3
	ZO9bfU12sWigTcNjzHzAsONNN7//qJJfD5rsgUdf8OFR7d3dN8IcTsFr3El85yXQR0TTii
	65QJYoZAeVKFzxGEGQzxgiZyscR7AIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779729177;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=npNzcK9F9mdlqJnPAobO2T7riqdNKDu0cA5W9ot1FTY=;
	b=rsrX3CGJ096nt2HLJqMAiTR5aKptuMiC9RkioTS4jVGV4YpWCBxF9MbyzLxGZ2zCHSzBET
	K4/CaBVBz+5jeTBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zzgKiR2t;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rsrX3CGJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779729177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=npNzcK9F9mdlqJnPAobO2T7riqdNKDu0cA5W9ot1FTY=;
	b=zzgKiR2tX5YaMvcEPwWybo895ARZpJQGZG1ySkFIVI5SFxrorHX3nNGJyvCJoWxI5gQvm3
	ZO9bfU12sWigTcNjzHzAsONNN7//qJJfD5rsgUdf8OFR7d3dN8IcTsFr3El85yXQR0TTii
	65QJYoZAeVKFzxGEGQzxgiZyscR7AIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779729177;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=npNzcK9F9mdlqJnPAobO2T7riqdNKDu0cA5W9ot1FTY=;
	b=rsrX3CGJ096nt2HLJqMAiTR5aKptuMiC9RkioTS4jVGV4YpWCBxF9MbyzLxGZ2zCHSzBET
	K4/CaBVBz+5jeTBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF8C159D5C;
	Mon, 25 May 2026 17:12:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jh3mMxiDFGrTVQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 25 May 2026 17:12:56 +0000
Message-ID: <bc52d40c-53e0-48c3-9519-c6b9cc07b50c@suse.de>
Date: Mon, 25 May 2026 19:12:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3 net-next v4] selftests: net: add test for IPv4 devconf
 netlink notifications
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, horms@kernel.org, edumazet@google.com,
 dsahern@kernel.org, davem@davemloft.net
References: <20260510081528.5257-1-fmancera@suse.de>
 <20260510081528.5257-3-fmancera@suse.de> <20260513193544.47970cb8@kernel.org>
 <bd560c89-c71f-4ef5-a0fd-5ea096a0f767@suse.de>
 <20260514162429.366b94c9@kernel.org>
 <f528360c-18b3-46e5-8ba8-88f921203716@suse.de>
 <20260515181623.5a44140e@kernel.org>
 <f5cae72f-93c7-41d7-b7db-2b60281afb72@suse.de>
 <20260518142346.4c0903de@kernel.org>
 <54f7f213-9783-42c0-8ae8-51a6b65b7b5d@redhat.com>
 <6539e000-2bb5-4cda-a8b7-b09e5e0d66a9@suse.de>
 <7fb927ab-591c-4c07-9f85-31697b80a366@suse.de>
 <20260525090855.43cf453a@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260525090855.43cf453a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291386-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 513285CD38F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/25/26 6:08 PM, Jakub Kicinski wrote:
> On Mon, 25 May 2026 17:53:04 +0200 Fernando Fernandez Mancera wrote:
>> On 5/19/26 9:24 AM, Fernando Fernandez Mancera wrote:
>>> On 5/19/26 9:17 AM, Paolo Abeni wrote:
>>>> Ideally I think extending iproute2 would be the better solution.
>>>> @Fernando: perhaps you could update the self-test accordingly, adding an
>>>> explicit check for the iproute subcommand. If `ip netconf set` is not
>>>> available skip the test, so that iproute2 patches could land later.
>>>>
>>>> Does the above look feasible?
>>>>   
>>>
>>> Yep. I agree. Okay, let's do that :-)
>>
>> As discussed in the thread, Jakub can you pick the other patches or
>> should I repost the series without the selftest? I am now working on the
>> iproute extension FWIW.
> 
> How long will the iproute2 extension take? If it's matter of days maybe
> we should wait and base the selftest on it?
> 

I plan to send it likely tomorrow for review. But then it will need to 
be reviewed.. I hope it's matter of days. So, let's see how the review 
goes..

Thanks,
Fernando.

