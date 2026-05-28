Return-Path: <netdev+bounces-292654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNWeHygdGGq+dQgAu9opvQ
	(envelope-from <netdev+bounces-292654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:47:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC1B5F0D8F
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96F293009579
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583113C4B73;
	Thu, 28 May 2026 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nPQvrFzu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oxbDanOX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nPQvrFzu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oxbDanOX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5D3C4545
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779965183; cv=none; b=NEzjuiupTVa9NDYs/aG9YUc4sUFnmuZdekQCsoOVVbiEpequWeCHP8fji9H8XlM/IrrF0/95SXVM9y2gMe+ShUPGGQXiQ6JuCK43rIRjUCzK2+tb+522Kds8Jsjm3eEWDaF2dHRpgV0mMpx2tF/2lsVvql5iKUt8QglkCSbEeTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779965183; c=relaxed/simple;
	bh=2/JyH7hqgi0/W7n9Oee47eVVhPHxJ9SNl36JempN2a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDYakGZhZ1bHpOuFm/GWbkepmsiIRRA30FeXNmdzz6nLtX3OCnMqxJV1S1ztpIDdGtnxsIpa413cPJuzRhesG0dn6JN1Kzwf104phNkbE+/z4RhM3wY7iPLQWzNW4HxwiGDZfYjqwA1ya21NxJRQ2mChdUs8d0H/r5ruBnti4Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nPQvrFzu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oxbDanOX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nPQvrFzu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oxbDanOX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B70E06A88A;
	Thu, 28 May 2026 10:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779965179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVHtvN9YYBiVjpKwMQ762EafG5nAsVUAL+CmLmCIQmk=;
	b=nPQvrFzucccJVQ5ck0qzJjt5+bMX6E2BkAgVlWIW9L9G6jmB7z52g1Cs+pdOGbrjnxnxkQ
	Dw29x7CTaYAdkIUbfkwWeqdxNle2B6kUetADc7aZ8umq6+58/XszJ0y5lNTX+Klal0v+v6
	eMoJC87aCNFb0W6Feg5og4tH0cWLoJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779965179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVHtvN9YYBiVjpKwMQ762EafG5nAsVUAL+CmLmCIQmk=;
	b=oxbDanOXyaC+I+8zhuLwXuMALixv47D7v+LMSneRq3j7PfDXkRqMPJaOjJ4RBjro229Xhr
	YYu/+mfIK+B+PbAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779965179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVHtvN9YYBiVjpKwMQ762EafG5nAsVUAL+CmLmCIQmk=;
	b=nPQvrFzucccJVQ5ck0qzJjt5+bMX6E2BkAgVlWIW9L9G6jmB7z52g1Cs+pdOGbrjnxnxkQ
	Dw29x7CTaYAdkIUbfkwWeqdxNle2B6kUetADc7aZ8umq6+58/XszJ0y5lNTX+Klal0v+v6
	eMoJC87aCNFb0W6Feg5og4tH0cWLoJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779965179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVHtvN9YYBiVjpKwMQ762EafG5nAsVUAL+CmLmCIQmk=;
	b=oxbDanOXyaC+I+8zhuLwXuMALixv47D7v+LMSneRq3j7PfDXkRqMPJaOjJ4RBjro229Xhr
	YYu/+mfIK+B+PbAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C6995AD45;
	Thu, 28 May 2026 10:46:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8FXVC/scGGrjFgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 28 May 2026 10:46:19 +0000
Message-ID: <baba855a-7cc9-409e-9c20-6e50f35d255a@suse.de>
Date: Thu, 28 May 2026 12:46:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with IPv6 privacy addresses in 7.0
To: Stefano Brivio <sbrivio@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Yumei Huang <yuhuang@redhat.com>,
 Ido Schimmel <idosch@idosch.org>, Justin Iurman <justin.iurman@gmail.com>,
 David Ahern <dsahern@kernel.org>, David Gibson
 <david@gibson.dropbear.id.au>, ihuguet@redhat.com
References: <20260521135310.GC977@cmadams.net>
 <20260526175743.1f2c3761@kernel.org> <20260527010641.GA21073@cmadams.net>
 <20260526183122.348e44e7@kernel.org> <20260527215135.GB16443@cmadams.net>
 <675083b4-e015-4ff3-836c-798e0a971194@suse.de>
 <20260528073849.759da84a@elisabeth>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260528073849.759da84a@elisabeth>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,idosch.org,gmail.com,kernel.org,gibson.dropbear.id.au];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-292654-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: EDC1B5F0D8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 7:38 AM, Stefano Brivio wrote:
> Hi Fernando, Jakub,
> 
> On Wed, 27 May 2026 23:59:47 +0200
> Fernando Fernandez Mancera <fmancera@suse.de> wrote:
> 
>> On 5/27/26 11:51 PM, Chris Adams wrote:
>>> Once upon a time, Jakub Kicinski <kuba@kernel.org> said:
>>>> On Tue, 26 May 2026 20:06:41 -0500 Chris Adams wrote:
>>>>>> Hi! Adding more people to CC. Do you know if you upgraded from 6.18
>>>>>> or 6.19?
>>>>>
>>>>> It was 6.19 to 7.0.
>>>>>   
>>>>>> Would you be able to try testing with some commits reverted?
>>>>>> On a quick look the candidates would be:
>>>>>>
>>>>>> cb3de96eea66 ("ipv6: preserve insertion order for same-scope addresses")
>>>>>
>>>>> It's this one.
>>>>
>>>> Phew, the second one was mine :)
>>>>   
>>>>> I figured out that it happens after stopping a VM (and I usually
>>>>> start/stop a VM for a bit in the morning, which is why it happened more
>>>>> than once).  So I set up a VM with a nested VM, running up-to-date
>>>>> Fedora 44, and then was able to bisect pretty easily, and it landed on
>>>>> this commit.
>>>>>
>>>>> Fedora is using NetworkManager, and IIRC NM does some part of privacy
>>>>> address management (right?).  NM didn't change, so maybe this commit is
>>>>> confusing something in NM?
>>>>
>>>> Sounds plausible, pretty sure we knew this commit was risky to begin
>>>> with, but we had no direct proof that it'd break real life users.
>>>>
>>>> Revert is the right course of action here. Would you be willing/able
>>>> to send the revert with your problem description and a Fixes tag
>>>> pointing to the reverted commit?
>>>
>>> I did want to add a little more test note:
>>>
>>> It's definitely an interaction with NetworkManager.  If I stop NM and
>>> run my VM start/stop test, nothing unexpected happens after.  If NM is
>>> running and I do my VM test, when the next router advertisement is
>>> received, NM replaces the privacy addresses.
>>>    
>>
>> As someone that is experienced in NetworkManager, I can confirm it is
>> related. NetworkManager is querying the IPv6 address and when the
>> connection is configured with ipv6.ip6-privacy=2 (prefer-temp-addr),
>> NetworkManager creates a route to make the system use the temporary
>> address for outgoing connections by default.
>>
>> If the order is messed up, the address picked will likely be too. One
>> could argue that this is partially fault of NetworkManager and that it
>> should check the timestamps or preferred times rather than order.. but
>> well, the rule is "do not break userspace".
>>
>> I hope this clarifies things.
> 
> Not entirely. I'm looking into this right now, but note that the purpose
> of that commit is to *preserve* the order of addresses as they were
> inserted, not to mess it up.
> 
> Before that, addresses were stored and returned via netlink *reversed*
> compared to the insertion, which is rather surprising, also because
> it's the opposite of what we do for IPv4 addresses, and caused issues
> with pasta(1) as it copies addresses into containers in the same order
> as reported via netlink.
> 

Right, to make it clear. I agree with you here. The current order is the 
*right* or rather intuitive order.

> Do you happen to know exactly in which way the order happens to be wrong
> now?
> 

It is not wrong, but userspace applications were parsing addresses and 
expecting them in the previous order whether it was correct or not. Now, 
that parsing is broken because they are coming in an unexpected (maybe 
more intuitive) order.

FWIW; Iñigo Huguet (CC'ed) pointed out that this is breaking a 
NetworkManager test and they were going to report it.

> Also note that userspace was broken and fixed a couple of times:
> 
>    https://bugs.passt.top/show_bug.cgi?id=175#c10
> 
> so I would look into fixing that properly if doable. If it takes too
> long and this is causing issues for a lot of people meanwhile of course
> it might make sense to revert, but I'd give it a quick try at least.
> 

I think the solution shouldn't modify the order of the list by default. 
Maybe we can introduce a flag for the dump operation?

