Return-Path: <netdev+bounces-288032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFV+Iw3yBWq3dgIAu9opvQ
	(envelope-from <netdev+bounces-288032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:02:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0940544685
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFDC13011849
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32F231E853;
	Thu, 14 May 2026 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XAisUViV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hqjT0A6w";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XAisUViV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hqjT0A6w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4107B31AA92
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778774427; cv=none; b=UeXJgSS/JX4e8fo/FAcUplk8uJ/iqZ6WOHmj9v5kyfxu6jAJ0Inz5a0XgHcUr/owj+ME/skMb7Xfc9fdmDC3ENFfGpzJfWd20FUhvWPDBVztF/6GNjUcQdkrvl9BTfPoUuSOl+Ibz9uvsFxrKhdoVXXgRruClSpNwgf/fcuLVlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778774427; c=relaxed/simple;
	bh=9bz7ArJby5v7jeQA8ymGKl9RNGJQiBSe3pmorWJoSPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fU874wuMPP3R6MHo4SCEbNYXQfeMnt/rAGKfJ6EZUTycpIYRDa2K8qO0d3cXQcZ5pFlMF0fV0oA8X9emSHV7mXXV0Dmtc2ftqEUfojTPkMfo+YvpYJdKISIfwaIon/N6kUvLuRFsY+Pe6bLJ6J4RIRPOYqe3cfqy1p2BFbe2sJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XAisUViV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hqjT0A6w; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XAisUViV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hqjT0A6w; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7485A67CE3;
	Thu, 14 May 2026 16:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778774424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4EMS4p/wehXnBfvVDcG/5oQUtGRphLSbPMyRiQ5TBM=;
	b=XAisUViVDjXvFFo43tlEnUaOeUu39L4yqTve7eH4kUoLeAhAcuWoxuymdWGEfxTXFh0Q1i
	tfxBWzfV8CE/SD8XKNI7rKxwQ0Y7u3b2PZQLGcNYKvHdAHM8QBHwEUpl+6XFEFNzKnveVz
	/yPhU2g5IfReHsNf3Gcz5PYwfU6hJlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778774424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4EMS4p/wehXnBfvVDcG/5oQUtGRphLSbPMyRiQ5TBM=;
	b=hqjT0A6wHji0DF/4gW54QQh1Qnl9b11XGe5FHcg4/IYnLbsPsROH1hS6q9R1eGEX9bP8OU
	MI/C/evGOKJ9j8AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778774424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4EMS4p/wehXnBfvVDcG/5oQUtGRphLSbPMyRiQ5TBM=;
	b=XAisUViVDjXvFFo43tlEnUaOeUu39L4yqTve7eH4kUoLeAhAcuWoxuymdWGEfxTXFh0Q1i
	tfxBWzfV8CE/SD8XKNI7rKxwQ0Y7u3b2PZQLGcNYKvHdAHM8QBHwEUpl+6XFEFNzKnveVz
	/yPhU2g5IfReHsNf3Gcz5PYwfU6hJlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778774424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4EMS4p/wehXnBfvVDcG/5oQUtGRphLSbPMyRiQ5TBM=;
	b=hqjT0A6wHji0DF/4gW54QQh1Qnl9b11XGe5FHcg4/IYnLbsPsROH1hS6q9R1eGEX9bP8OU
	MI/C/evGOKJ9j8AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2468593A9;
	Thu, 14 May 2026 16:00:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wJfuL5fxBWplBQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 14 May 2026 16:00:23 +0000
Message-ID: <2e046948-aa98-4159-b1c1-46368f034027@suse.de>
Date: Thu, 14 May 2026 18:00:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 net v4] ipv6: addrconf: fix temp address generation
 after prefix deprecation
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 dsahern@kernel.org, davem@davemloft.net, =?UTF-8?Q?=C5=81ukasz_Stelmach?=
 <steelman@post.pl>
References: <20260511122645.6233-2-fmancera@suse.de>
 <3f371efe-1b1b-464c-af21-ccd66b6c5df6@suse.de>
 <20260513143533.GA415119@shredder>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260513143533.GA415119@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Rspamd-Queue-Id: E0940544685
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
	TAGGED_FROM(0.00)[bounces-288032-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/13/26 4:35 PM, Ido Schimmel wrote:
> On Tue, May 12, 2026 at 08:24:27PM +0200, Fernando Fernandez Mancera wrote:
>> Sashiko feedback [1] is right about the DoS, that is a router that sends
>> multiple 0-lft RA until it exhausts all spawn attempts, leaving temporary
>> addresses disabled on the system.
>>
>> About the leaked address, I do not think the feedback is right. If an ifp
>> does not have any ift, it means something went wrong most likely. Either
>> this address was removed manually (any RA would restore it, even with
>> previous implementation) or for some reason that prefix didn't get an RA but
>> we didn't try to generate one and we MUST do it.
>>
>> I think we can cover it by avoiding to attempt create a new temporary
>> address for a 0-lft RA, it makes sense to me. Something like this:
>>
>> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
>> index 18a6f2de30ce..6c511e9c1bf5 100644
>> --- a/net/ipv6/addrconf.c
>> +++ b/net/ipv6/addrconf.c
>> @@ -2654,7 +2654,7 @@ static void manage_tempaddrs(struct inet6_dev *idev,
>>   	 * We don't want that to result in creating a new temporary ip address.
>>   	 */
>>   	if ((list_empty(&idev->tempaddr_list) || all_regen) &&
>> -	    (valid_lft || prefered_lft))
>> +	    (valid_lft && prefered_lft))
>>   		create = true;
>>
>>   	if (create && READ_ONCE(idev->cnf.use_tempaddr) > 0) {
>>
>> Any thoughts?
> 
> This still leaves the case of RAs that alternate between prefered_lft >
> 0 and prefered_lft == 0. It will cause the kernel to create an unbounded
> amount of temporary addresses.
> 
> I think that a better fix would be to reset the regeneration counter of
> the newest temporary address whenever the associated public address
> becomes preferred. Something like [1].
> 
> If the newest temporary address has yet to spawn a new address, then its
> regeneration counter is 0 and nothing changes. However, if it was
> incremented and no new address was created, then this patch will reset
> its regeneration counter to reflect that. Before expiring,
> addrconf_verify_rtnl() will notice that this address has yet to spawn a
> new address and call ipv6_create_tempaddr().
> 
> The case of constant RAs with prefered_lft == 0 is not an issue because
> we only reset the regeneration counter when prefered_lft > 0.
> 
> Alternating RAs are also not an issue because we don't call
> ipv6_create_tempaddr() immediately and instead let
> addrconf_verify_rtnl() handle it when the address is about to expire.
> 

Hi Ido, yes this looks good but I am afraid of using time_after(). Sure, 
a temporary address should never be older than 2 ~ 7 days. Yet, we allow 
configuring it up to 2147483647 (68~ years). And that might cause 
problems in 32-bit systems.

I think we either limit this configuration on sysctl directly or we need 
to support this nonsense.. another option would be to move inet6_ifaddr 
out of jiffies which is something that I recently added to my TODO list. 
But that is a bigger change I do not want to bundle with this one.

I noticed that ipv6_add_addr() do:

list_add(&ifa->tmp_list, &idev->tempaddr_list);

Doesn't it mean the first address that matches the base prefix is indeed 
the most recent one? I tried a bit and it seems we can use just the 
first match :)

In addition, I didn't check with Sashiko but it is likely going to 
complain about a race condition for a RA arriving right after we have 
spawned an address but it has not been added to the tempaddr list. 
Therefore we would have two addresses.. anyway, that race is quite 
unlikely. I also have planned work on that are to reduce the multiple 
race windows, currently there are plenty. I suggest to acknowledge such 
race condition for now and improve the code base for the reported scenario.

I propose this small change to your proposed diff, I acknowledge that it 
is a bit fragile tho (maybe a comment at ipv6_add_addr() is worth to 
avoid breaking this accidentally):

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d550524f4266..af0d3fcbef98 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2607,7 +2607,7 @@ static void manage_tempaddrs(struct inet6_dev *idev,
  		if (ifp != ift->ifpub)
  			continue;

-		if (!newest_ift || time_after(ift->cstamp, newest_ift->cstamp))
+		if (!newest_ift)
  			newest_ift = ift;

  		/* RFC 4941 section 3.3:


Thanks!
Fernando.


> [1]
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 5476b6536eb7..d550524f4266 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -2595,8 +2595,9 @@ static void manage_tempaddrs(struct inet6_dev *idev,
>                               __u32 valid_lft, __u32 prefered_lft,
>                               bool create, unsigned long now)
>   {
> +       struct inet6_ifaddr *ift, *newest_ift = NULL;
> +       u32 orig_prefered_lft = prefered_lft;
>          u32 flags;
> -       struct inet6_ifaddr *ift;
>   
>          read_lock_bh(&idev->lock);
>          /* update all temporary addresses in the list */
> @@ -2606,6 +2607,9 @@ static void manage_tempaddrs(struct inet6_dev *idev,
>                  if (ifp != ift->ifpub)
>                          continue;
>   
> +               if (!newest_ift || time_after(ift->cstamp, newest_ift->cstamp))
> +                       newest_ift = ift;
> +
>                  /* RFC 4941 section 3.3:
>                   * If a received option will extend the lifetime of a public
>                   * address, the lifetimes of temporary addresses should
> @@ -2643,6 +2647,12 @@ static void manage_tempaddrs(struct inet6_dev *idev,
>                          ipv6_ifa_notify(0, ift);
>          }
>   
> +       if (newest_ift && orig_prefered_lft > 0) {
> +               spin_lock(&newest_ift->lock);
> +               newest_ift->regen_count = 0;
> +               spin_unlock(&newest_ift->lock);
> +       }
> +
>          /* Also create a temporary address if it's enabled but no temporary
>           * address currently exists.
>           * However, we get called with valid_lft == 0, prefered_lft == 0, create == false


