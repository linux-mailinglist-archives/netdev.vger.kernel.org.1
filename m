Return-Path: <netdev+bounces-293101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEkkM/d9GWp9xAgAu9opvQ
	(envelope-from <netdev+bounces-293101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:52:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED15601E38
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCE7131644DE
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2793DD50F;
	Fri, 29 May 2026 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sXNu7bPV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hYP3klbv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sXNu7bPV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hYP3klbv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550033CE096
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780055144; cv=none; b=Hv8VYz3UyrxGxnCSoBP6ncEfEvBhbA9x9lwuRVogkA3fJuZBVbwQOWQw2brxgfx7hzrJAjC2fe1bDOY4F+YIObI5ZOuf+5/+lv8rQt4n66GGgEw2eKIn4FOevtAMblS6TW14a5gy6beZTE08++37taH/6gxT2PZbSU+IkToNGpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780055144; c=relaxed/simple;
	bh=55p2NOScR63jb8x7ROOh1ZB29m/lLlGGUpgtuMgF96g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UrXujvebfh8DhrJFdx987WoMcnuuhPdfRIsnTgqzglkget3n2FgQC+cGY6fi7IHbFjiA76Ff7BspGKf64flxrlf3D/IXUOr/qT6DWP3XuD/RO85a/KdFFnzQQCSHERVmzUoC/q9yYTat9x8tXC2LkEgC6ouoqwMaemjQOq4AeZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sXNu7bPV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hYP3klbv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sXNu7bPV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hYP3klbv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 943A46AAF5;
	Fri, 29 May 2026 11:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780055141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=te6JpYL3eWT5RiGJaEYK0N28AXew4lTCaLYA94r6D10=;
	b=sXNu7bPV6NWR5AsJz5GZMeB2sT0XaVZoZIggH7OzOah2/eK4O/yyZjLL23LJg4yOI/NIov
	j0cyuXcWLRLZ/0IaHqbeC4XZB8xlrzl5TYH3Cxf7vbzJ9iUGuSqdjTRFGp5bvcybt/ndc1
	5546/mQWvHk2J9JwZob0hDhDhJ3kmGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780055141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=te6JpYL3eWT5RiGJaEYK0N28AXew4lTCaLYA94r6D10=;
	b=hYP3klbvZQM5ZNJc5FI9JrbOcUEOKJLYeN37ONmqTg9KZU8bB6QHGE5V8UBLWvoVSbbjTn
	on+lVCAoq18QdMDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780055141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=te6JpYL3eWT5RiGJaEYK0N28AXew4lTCaLYA94r6D10=;
	b=sXNu7bPV6NWR5AsJz5GZMeB2sT0XaVZoZIggH7OzOah2/eK4O/yyZjLL23LJg4yOI/NIov
	j0cyuXcWLRLZ/0IaHqbeC4XZB8xlrzl5TYH3Cxf7vbzJ9iUGuSqdjTRFGp5bvcybt/ndc1
	5546/mQWvHk2J9JwZob0hDhDhJ3kmGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780055141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=te6JpYL3eWT5RiGJaEYK0N28AXew4lTCaLYA94r6D10=;
	b=hYP3klbvZQM5ZNJc5FI9JrbOcUEOKJLYeN37ONmqTg9KZU8bB6QHGE5V8UBLWvoVSbbjTn
	on+lVCAoq18QdMDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94B92779A7;
	Fri, 29 May 2026 11:45:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id apNGIWR8GWqLXQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 29 May 2026 11:45:40 +0000
Message-ID: <98ff3f56-ab50-4676-937e-93d75ff1b3eb@suse.de>
Date: Fri, 29 May 2026 13:45:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] Revert "ipv6: preserve insertion order for
 same-scope addresses"
To: Stefano Brivio <sbrivio@redhat.com>
Cc: netdev@vger.kernel.org, yuhuang@redhat.com, justin.iurman@gmail.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org,
 Chris Adams <linux@cmadams.net>, David Gibson <david@gibson.dropbear.id.au>,
 Beniamino Galvani <bgalvani@redhat.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>, Andrew Lunn <andrew@lunn.ch>,
 ihuguet@redhat.com, regressions@lists.linux.dev
References: <20260529112357.5079-1-fmancera@suse.de>
 <20260529134045.56330243@elisabeth>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260529134045.56330243@elisabeth>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,gmail.com,kernel.org,google.com,davemloft.net,nvidia.com,cmadams.net,gibson.dropbear.id.au,leemhuis.info,lunn.ch,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-293101-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2ED15601E38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/29/26 1:41 PM, Stefano Brivio wrote:
> On Fri, 29 May 2026 13:23:57 +0200
> Fernando Fernandez Mancera <fmancera@suse.de> wrote:
> 
>> Chris Adams reported that preserving insertion order for same-scope
>> addresses is causing SSH connections to be dropped after stopping a VM
>> while running NetworkManager.
>>
>> NetworkManager caches the IPv6 address configuration, when a RA arrives,
>> it determines the list of addresses to configure and checks if the
>> addresses are already in the right order in the kernel. If they aren't,
>> NetworkManager removes and re-adds them to achieve the desired order.
>>
>> As the order changes, NetworkManager is confused and reconfigures the
>> addresses on every update. In addition, this would also affect to cloud
>> tooling that relies on IPv6 addresses order to identify primary and
>> secondaries addresses.
> 
> By the way, I'm still looking into this part, trying to find
> "problematic" examples.
> 
> And I couldn't find any, yet, because it looks like there's always a
> _single_ IPv6 address being used as a secondary for a primary IPv4
> address.
> 

IIRC, Azure cloud should be one of them. I do not have an account there 
to test it.. but some years ago I did some work supporting configuring 
IPV6 primary and secondary addresses via IMDSv2.

If someone with an account could test it I would appreciate it.

>>
>> This reverts commit cb3de96eea66f5e4a580086c6a1be46e765f97f4.
>>
>> Fixes: cb3de96eea66 ("ipv6: preserve insertion order for same-scope addresses")
>> Reported-by: Chris Adams <linux@cmadams.net>
>> Closes: https://lore.kernel.org/netdev/20260521135310.GC977@cmadams.net/
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> ---
>> v2: updated commit description to make it more accurate
>> ---
>>   net/ipv6/addrconf.c                  | 2 +-
>>   tools/testing/selftests/net/ioam6.sh | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
>> index 5476b6536eb7..bb84a78b80f6 100644
>> --- a/net/ipv6/addrconf.c
>> +++ b/net/ipv6/addrconf.c
>> @@ -1013,7 +1013,7 @@ ipv6_link_dev_addr(struct inet6_dev *idev, struct inet6_ifaddr *ifp)
>>   	list_for_each(p, &idev->addr_list) {
>>   		struct inet6_ifaddr *ifa
>>   			= list_entry(p, struct inet6_ifaddr, if_list);
>> -		if (ifp_scope > ipv6_addr_src_scope(&ifa->addr))
>> +		if (ifp_scope >= ipv6_addr_src_scope(&ifa->addr))
>>   			break;
>>   	}
>>   
>> diff --git a/tools/testing/selftests/net/ioam6.sh b/tools/testing/selftests/net/ioam6.sh
>> index b2b99889942f..845c26dd01a9 100755
>> --- a/tools/testing/selftests/net/ioam6.sh
>> +++ b/tools/testing/selftests/net/ioam6.sh
>> @@ -273,8 +273,8 @@ setup()
>>     ip -netns $ioam_node_beta link set ioam-veth-betaR name veth1 &>/dev/null
>>     ip -netns $ioam_node_gamma link set ioam-veth-gamma name veth0 &>/dev/null
>>   
>> -  ip -netns $ioam_node_alpha addr add 2001:db8:1::2/64 dev veth0 &>/dev/null
>>     ip -netns $ioam_node_alpha addr add 2001:db8:1::50/64 dev veth0 &>/dev/null
>> +  ip -netns $ioam_node_alpha addr add 2001:db8:1::2/64 dev veth0 &>/dev/null
>>     ip -netns $ioam_node_alpha link set veth0 up &>/dev/null
>>     ip -netns $ioam_node_alpha link set lo up &>/dev/null
>>     ip -netns $ioam_node_alpha route add 2001:db8:2::/64 \
> 


