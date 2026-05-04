Return-Path: <netdev+bounces-284034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGYeA+74+GkE3wIAu9opvQ
	(envelope-from <netdev+bounces-284034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:52:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5524C35C7
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66FDE301876D
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 19:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAB13F2100;
	Mon,  4 May 2026 19:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lSooANlW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sgv4ZHVc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lSooANlW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sgv4ZHVc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA43E6395
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 19:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777924331; cv=none; b=mwgS0iaJsleZ9ixndUR4IzIGx3D2arS+NSbkwc/6YdSlbLukPxfoOnGj/b72laQC/13Bxmfq9iHZt+MHtAYhtupU6rvp2ZXa7cCQM0JMjDwJJqh+Yrv92Pqt88orhSpbic0yftObD5s526ZX0/kdpy+Tka/aPWVURi8KNG9mZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777924331; c=relaxed/simple;
	bh=ZOkI2KoY1aZFxo8wYQRFJdO9vey2IEblCOWAdWz7b0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOxK9zS5KquLseO0+4m5zBKHxoBk7Mip4ezyYzecVNSM4LptPPPr7AwUPMe/9NRdvSfqO3NG5uAfUmCxro3bOhds/qQIqKEPAXANpq4YQDHCpx/5K/6Tjv+XfSeFUGby4WiWO0/aZ4/q8+FutpJabqKL884wBeJS7mPvUWoTp6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lSooANlW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sgv4ZHVc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lSooANlW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sgv4ZHVc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 57CF56B51F;
	Mon,  4 May 2026 19:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777924327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zgM5u8YCb5xoXS+CbpDrP3b/ehGc0c5IHa/dg5esmE=;
	b=lSooANlWpXFSQQFXZiYIEZMDQvZtWWw79uDD/tsYab5EQWjEQXDZDqAXOCilxy4M3cs623
	wRn18YDFn4tQAMU7L6UGBkkoDYQXZ3z/UI526Dy3y27hgD3ufOMAhquJN34tcFIAJO9k88
	1+FYv3EPGMHOCpKiIzniJysLMIFh3DY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777924327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zgM5u8YCb5xoXS+CbpDrP3b/ehGc0c5IHa/dg5esmE=;
	b=sgv4ZHVcMz4K/w7PGBn0Vgm5M8GaH4R5D9oa6/zTSChwWJ7XlCOcGLRmUwAvQyMeGj9uHp
	u5i1a4hTreyw76CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lSooANlW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sgv4ZHVc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777924327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zgM5u8YCb5xoXS+CbpDrP3b/ehGc0c5IHa/dg5esmE=;
	b=lSooANlWpXFSQQFXZiYIEZMDQvZtWWw79uDD/tsYab5EQWjEQXDZDqAXOCilxy4M3cs623
	wRn18YDFn4tQAMU7L6UGBkkoDYQXZ3z/UI526Dy3y27hgD3ufOMAhquJN34tcFIAJO9k88
	1+FYv3EPGMHOCpKiIzniJysLMIFh3DY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777924327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zgM5u8YCb5xoXS+CbpDrP3b/ehGc0c5IHa/dg5esmE=;
	b=sgv4ZHVcMz4K/w7PGBn0Vgm5M8GaH4R5D9oa6/zTSChwWJ7XlCOcGLRmUwAvQyMeGj9uHp
	u5i1a4hTreyw76CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEC67593A3;
	Mon,  4 May 2026 19:52:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eiinK+b4+GnxHAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 04 May 2026 19:52:06 +0000
Message-ID: <2532adc0-262e-433a-9b69-df6d49f662c4@suse.de>
Date: Mon, 4 May 2026 21:51:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 net] ipv6: addrconf: fix temp address generation after
 prefix deprecation
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, dsahern@kernel.org, =?UTF-8?Q?=C5=81ukasz_Stelmach?=
 <steelman@post.pl>
References: <20260503221139.3742-3-fmancera@suse.de>
 <20260504163549.GA385401@shredder>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260504163549.GA385401@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 6C5524C35C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284034-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid,post.pl:email]

On 5/4/26 6:35 PM, Ido Schimmel wrote:
> On Mon, May 04, 2026 at 12:11:40AM +0200, Fernando Fernandez Mancera wrote:
>> When a router temporarily deprecates an IPv6 prefix (either by sending a
>> Router Advertisement with Preferred Lifetime = 0 or by letting the
>> lifetime expire) and later restores it, the kernel permanently loses its
>> ability to generate temporary privacy addresses (RFC 8981) for that
>> prefix.
>>
>> This happens because the address worker attempts to generate a
>> replacement temporary address when the current one nears expiration. As
>> the base prefix is deprecated already, the generation fails, burning the
>> retry counter for temporary address generation of that prefix.
>>
>> When the router eventually restores the prefix, the temporary address
>> becomes active again. However, once it naturally expires, the kernel
>> sees the exhausted retry limit and permanently stops generating new
>> privacy addresses.
> 
> It's not clear to me to which "retry counter" you are referring to. Are
> you referring to the counter of the temporary address or to that of the
> "public address" from which it was generated?
> 
> AFAICT, in the case of temporary addresses (those w/o "mngtmpaddr") this
> isn't really a counter, but a boolean that tells you if an address was
> already spawned from this address.
> 
>>
>> Fix this by verifying that the base prefix has sufficient preferred
>> lifetime remaining before attempting to generate a new temporary
>> address. This prevents the worker from burning through its retry counter
>> during temporary network deprecation events like a router reboot.
> 
> Again, I think that "retry counter" here is confusing. IIUC, what
> happens is that the kernel marks the temporary address as having spawned
> an address ('ifp->regen_count++'), then tries to spawn an address by
> calling ipv6_create_tempaddr(), which fails because the preferred
> lifetime of the public address is 0.
> 

Yes, you are right. I used the word counter as the variable was 
ifp->regen_count although for temporary addresses it is just a boolean. 
Let me modify the commit message to make it clear.

Thanks Ido for reviewing!

>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Reported-by: Łukasz Stelmach <steelman@post.pl>
>> Closes: https://lore.kernel.org/netdev/87340td30q.fsf%25steelman@post.pl/
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> ---
>>   net/ipv6/addrconf.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
>> index 5476b6536eb7..f6a3d9da3cb1 100644
>> --- a/net/ipv6/addrconf.c
>> +++ b/net/ipv6/addrconf.c
>> @@ -4654,9 +4654,11 @@ static void addrconf_verify_rtnl(struct net *net)
>>   			    !ifp->regen_count && ifp->ifpub) {
>>   				/* This is a non-regenerated temporary addr. */
>>   
>> +				unsigned long pub_age = (now - READ_ONCE(ifp->ifpub->tstamp)) / HZ;
>>   				unsigned long regen_advance = ipv6_get_regen_advance(ifp->idev);
>>   
>> -				if (age + regen_advance >= ifp->prefered_lft) {
>> +				if (age + regen_advance >= ifp->prefered_lft &&
>> +				    pub_age + regen_advance < READ_ONCE(ifp->ifpub->prefered_lft)) {
>>   					struct inet6_ifaddr *ifpub = ifp->ifpub;
>>   					if (time_before(ifp->tstamp + ifp->prefered_lft * HZ, next))
>>   						next = ifp->tstamp + ifp->prefered_lft * HZ;
>> -- 
>> 2.53.0
>>


