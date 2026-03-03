Return-Path: <netdev+bounces-263137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOn+IcLCpmn3TQAAu9opvQ
	(envelope-from <netdev+bounces-263137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 12:15:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF521ED96A
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 12:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEF4331E36D2
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 11:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B933D1CAA;
	Tue,  3 Mar 2026 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gBTSvZGv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UHvMHjSv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gBTSvZGv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UHvMHjSv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50163750BC
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535993; cv=none; b=dCGV1IiPbXCTbomI/b5PmvwYrqH4PWYOKox4DDuiDe/oh61+WCwGykFDYj2JhTHU0qkOXdok35zVozMxiLNx0lgdl0YYgPmfLCVEmgJKmF45pWLqWEP/w/BJiixEisf8eg9I5W521IsEv0n+P03DFRAp+l7qlxCbED3AEfYM2k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535993; c=relaxed/simple;
	bh=KpTCOjDssCZ/4dHg37CwrSeQfRfhutJKRcx04RgfMjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5v05TbASQBErQBd0UJEp9MU6Ys4Tgp5FNnRaxUHXRSEPWFxX8WdxXo5rN13L/c54l2iUFyiFuFyxlCyNUkETo/y0pgg+whLfZRPh1w25nk6qTOl83b0BBHboHk1+R9pbMC+GkiWeLv5RbrTGwOtTEPrDqyRiRsA0YGGoMbxQ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gBTSvZGv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UHvMHjSv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gBTSvZGv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UHvMHjSv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 09BDA3F92A;
	Tue,  3 Mar 2026 11:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772535990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sY6ceKWAI+6eAYKBFeggCswgRtXBeUWMKcfC+rJ5nqE=;
	b=gBTSvZGvrAS5nvwhRKLEHqQ5j3SrzH09gywJyoFR4ClVyx8fDzQmja7NGbIqG4VOrAGuD0
	qd4PXclAVvGFAKOpTblmPL6Gbjx5aCyRuADAX7iZbjlV/JgTIbbREI8gvT18RKdAN7JIjl
	M4sLEN/xt9zghyJyt4c3zqH9F3HxzfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772535990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sY6ceKWAI+6eAYKBFeggCswgRtXBeUWMKcfC+rJ5nqE=;
	b=UHvMHjSvUyIts4ivqPYSBnAYrp5VuG0puFomtWhMKRNhBrOpXaP0K5Bl+w9LvdO93njuXp
	fIE1V7FQOxbrvdDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gBTSvZGv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UHvMHjSv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772535990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sY6ceKWAI+6eAYKBFeggCswgRtXBeUWMKcfC+rJ5nqE=;
	b=gBTSvZGvrAS5nvwhRKLEHqQ5j3SrzH09gywJyoFR4ClVyx8fDzQmja7NGbIqG4VOrAGuD0
	qd4PXclAVvGFAKOpTblmPL6Gbjx5aCyRuADAX7iZbjlV/JgTIbbREI8gvT18RKdAN7JIjl
	M4sLEN/xt9zghyJyt4c3zqH9F3HxzfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772535990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sY6ceKWAI+6eAYKBFeggCswgRtXBeUWMKcfC+rJ5nqE=;
	b=UHvMHjSvUyIts4ivqPYSBnAYrp5VuG0puFomtWhMKRNhBrOpXaP0K5Bl+w9LvdO93njuXp
	fIE1V7FQOxbrvdDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CA823EA69;
	Tue,  3 Mar 2026 11:06:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6X9sH7XApmn7NgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 03 Mar 2026 11:06:29 +0000
Message-ID: <29cb26c7-b0e6-4701-86bf-155feb70585b@suse.de>
Date: Tue, 3 Mar 2026 12:06:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net-next v2] ipv4: bump rt_genid when a relevant
 devconf value changes through netlink
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, tgraf@infradead.org, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 davem@davemloft.net
References: <20260226133949.17070-1-fmancera@suse.de>
 <20260226133949.17070-2-fmancera@suse.de>
 <20260228104547.56186b2d@kernel.org>
 <65e44884-2db7-4db0-8f48-138983314450@suse.de>
 <20260302161931.6cd91704@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260302161931.6cd91704@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: DBF521ED96A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263137-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Action: no action

On 3/3/26 1:19 AM, Jakub Kicinski wrote:
> On Mon, 2 Mar 2026 09:27:04 +0100 Fernando Fernandez Mancera wrote:
>> On 2/28/26 7:45 PM, Jakub Kicinski wrote:
>>> On Thu, 26 Feb 2026 14:39:49 +0100 Fernando Fernandez Mancera wrote:
>>>> When modifying IPv4 devconf values using netlink for some relevant
>>>> fields the rt_cache_flush() call was missing. In addition, if forwarding
>>>> is enabled on the interface then disable LRO.
>>>>
>>>> This is needed to avoid possible connectivity issues and ease the
>>>> responsabilities of user space tools.
>>>>
>>>> Fixes: 9f0f7272ac95 ("ipv4: AF_INET link address family")
>>>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>>>
>>> This OTOH probably deserves to be a real fix for net?
>>
>> Okay, makes sense. Let me re-send this to net.git without relying on the
>> previous patch. Then once is merged and net-next is synced I will
>> re-send the validation one.
> 
> I could be wrong, but FWIW in this case I think the changes won't
> conflict, so you could also post them at once against different trees.
> 

I already posted the change against net tree. Will post the one for 
net-next later after some testing.

Thank you Jakub for all the feedback,
Fernando.

