Return-Path: <netdev+bounces-289299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGQSNpoRDGoZVQUAu9opvQ
	(envelope-from <netdev+bounces-289299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:30:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 408235791C8
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71891303180E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 07:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4883D3338;
	Tue, 19 May 2026 07:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JIr3DL/o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s5YB0rRy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JIr3DL/o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s5YB0rRy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3073D3488
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 07:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175487; cv=none; b=bUIB97tO1VTgSimyXGoLiulY/GeX9s2OePlZOdvsRMERzzgztTB/sFf2p1Q2ETu2zpOJ5I6UwWhdCRxN8szUhNGIhQ88IZnx0k+DjQUfXcKctlUpNuxDjE9U3xAfNmNl0vogwzif7OTeCdmRpU4fGXDLq/L953x/+wfdrFLTmUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175487; c=relaxed/simple;
	bh=566wJyoQNaZppcgHsn0XB16I7fjmZC3Gy2nMiD9Q2YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6OOOgeFlKps6v9vWooyyJZJQQISjpFSXBDnBdqHutKQon4rObiVqQxYpBwr6Bh6Ik8EKP6ySKYkFxEFvNMezm0wiqZc5iZr3WA7yqFrpQCow0C0/a1RHJae6XvJKLTGqUKi+lqQqJyyxuvnV2khYQ367AWNlV3r5d4jg2rC98A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JIr3DL/o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s5YB0rRy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JIr3DL/o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s5YB0rRy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F31DE5D9A3;
	Tue, 19 May 2026 07:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779175459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=867OvcOyeRotwEwrhB4wKBsZTy+9UT/N4Yew+an6ItQ=;
	b=JIr3DL/ozA7IttpQDlrztsls1d6KULVZmtJ+FW6sVa2m84XrHdVcdFzhosmmvB4eZvit9I
	mPazrBl4d+MZWsVwLkitoDfkheKEJYSFrJsn/BS/MRr1Geghb6G8Phq7FsJXSjdE1e3YkW
	fDoxrf28LAo8sz1qtdvoOTEO6Fy6Qf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779175459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=867OvcOyeRotwEwrhB4wKBsZTy+9UT/N4Yew+an6ItQ=;
	b=s5YB0rRyDyt1ZfncccSF8CYZVrFdaY/UbovX3NX4S8dXOehwNTzO5i22F0zZ3nkcc4WR5S
	z8/TOkFX2i6a8gDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779175459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=867OvcOyeRotwEwrhB4wKBsZTy+9UT/N4Yew+an6ItQ=;
	b=JIr3DL/ozA7IttpQDlrztsls1d6KULVZmtJ+FW6sVa2m84XrHdVcdFzhosmmvB4eZvit9I
	mPazrBl4d+MZWsVwLkitoDfkheKEJYSFrJsn/BS/MRr1Geghb6G8Phq7FsJXSjdE1e3YkW
	fDoxrf28LAo8sz1qtdvoOTEO6Fy6Qf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779175459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=867OvcOyeRotwEwrhB4wKBsZTy+9UT/N4Yew+an6ItQ=;
	b=s5YB0rRyDyt1ZfncccSF8CYZVrFdaY/UbovX3NX4S8dXOehwNTzO5i22F0zZ3nkcc4WR5S
	z8/TOkFX2i6a8gDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D24A6593A8;
	Tue, 19 May 2026 07:24:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qjKvMiIQDGq2SwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 19 May 2026 07:24:18 +0000
Message-ID: <6539e000-2bb5-4cda-a8b7-b09e5e0d66a9@suse.de>
Date: Tue, 19 May 2026 09:24:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3 net-next v4] selftests: net: add test for IPv4 devconf
 netlink notifications
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org, edumazet@google.com, dsahern@kernel.org,
 davem@davemloft.net
References: <20260510081528.5257-1-fmancera@suse.de>
 <20260510081528.5257-3-fmancera@suse.de> <20260513193544.47970cb8@kernel.org>
 <bd560c89-c71f-4ef5-a0fd-5ea096a0f767@suse.de>
 <20260514162429.366b94c9@kernel.org>
 <f528360c-18b3-46e5-8ba8-88f921203716@suse.de>
 <20260515181623.5a44140e@kernel.org>
 <f5cae72f-93c7-41d7-b7db-2b60281afb72@suse.de>
 <20260518142346.4c0903de@kernel.org>
 <54f7f213-9783-42c0-8ae8-51a6b65b7b5d@redhat.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <54f7f213-9783-42c0-8ae8-51a6b65b7b5d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,suse.de:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289299-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 408235791C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/26 9:17 AM, Paolo Abeni wrote:
> On 5/18/26 11:23 PM, Jakub Kicinski wrote:
>> On Sat, 16 May 2026 09:02:27 +0200 Fernando Fernandez Mancera wrote:
>>>>> Oh sorry, I should have clarified it. ip netconf only shows/query them
>>>>> but it cannot set them AFAICS.
>>>>>
>>>>> Usage: ip netconf show [ dev STRING ]
>>>>
>>>> Oh, fun. anyway, you gotta find a better way. Or just give up on the
>>>> selftest, the YNL hack is too ugly to live
>>>>    
>>>
>>> Fair, let me see what I can do. Otherwise, Paolo as you requested the
>>> selftest, would it be acceptable for you to drop it given the situation?
>>> I looking for alternatives anyway :-)
>>
>> Maybe extend iproute2 ?
> 
> Ideally I think extending iproute2 would be the better solution.
> @Fernando: perhaps you could update the self-test accordingly, adding an
> explicit check for the iproute subcommand. If `ip netconf set` is not
> available skip the test, so that iproute2 patches could land later.
> 
> Does the above look feasible?
> 

Yep. I agree. Okay, let's do that :-)

Thanks a lot!

