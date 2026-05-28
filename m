Return-Path: <netdev+bounces-292705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBS3GkFPGGpMiwgAu9opvQ
	(envelope-from <netdev+bounces-292705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:20:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 022435F3995
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3643930E9F66
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7489229B8CF;
	Thu, 28 May 2026 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FsBfb7e5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QPSw/uUv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FsBfb7e5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QPSw/uUv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F160C2D8795
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977507; cv=none; b=MpLkg/mjAiUNvujBIxZpqt+KCZX5y8txWy7IBl2I4J3ZM2ENJmR/VGowKyffYVVw734R+isleygTMEYxtyREoibhNV6wK6qPc4V4NoMBgF0J4W5UqKDdXu4gofVLKtb2xONsbNOEs/wFLNAOcoOuSDRgIjMsvOgd3ONoj8HhcA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977507; c=relaxed/simple;
	bh=LBWCl1BantiDKJsW270IrKv8RPokJXf21rhBGk/bHus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XG7iahs5dzi0vWtQG5mvuHui4bdSU/jep5enAC+rSsaAf97SxP3kI/vxfGOLUI5B41M2pQi8g8mVg4J02B3HsVR+V8yCaV9Snq6GgUPtWAK2Q/QMpOT+DT4FAa7frubBjCzmW9h2WLMV0x+D38X8x/5t6JcIFHsKeIiT9fN2loU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FsBfb7e5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QPSw/uUv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FsBfb7e5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QPSw/uUv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 219C36A935;
	Thu, 28 May 2026 14:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779977504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDh/OYLNpsk8L7zu3TLrHmfyrdlPNDan14EYQCjWQwI=;
	b=FsBfb7e5omcoYDmpu+kcF8iwJcwIlimbH7XGOkd4CBRfPqiU5lEiFqBbTezE/1Kn4RLb1R
	N/AZbRm79peD1JrgBEBWW6zzdx8BibHNdbwUzFnIkY17kPvn4TYTj7//2mBGM1gOPpSK1F
	r0YJkJe7nc7ePCFE4k0ilH/jBF63cEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779977504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDh/OYLNpsk8L7zu3TLrHmfyrdlPNDan14EYQCjWQwI=;
	b=QPSw/uUvtpQKggqIra7vgLZzUNwkEUjN3voVcRYWpFs/Uu98SDHshBDVe0IJEWC7/QTDgm
	o1vcH7WqLxSgybAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779977504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDh/OYLNpsk8L7zu3TLrHmfyrdlPNDan14EYQCjWQwI=;
	b=FsBfb7e5omcoYDmpu+kcF8iwJcwIlimbH7XGOkd4CBRfPqiU5lEiFqBbTezE/1Kn4RLb1R
	N/AZbRm79peD1JrgBEBWW6zzdx8BibHNdbwUzFnIkY17kPvn4TYTj7//2mBGM1gOPpSK1F
	r0YJkJe7nc7ePCFE4k0ilH/jBF63cEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779977504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDh/OYLNpsk8L7zu3TLrHmfyrdlPNDan14EYQCjWQwI=;
	b=QPSw/uUvtpQKggqIra7vgLZzUNwkEUjN3voVcRYWpFs/Uu98SDHshBDVe0IJEWC7/QTDgm
	o1vcH7WqLxSgybAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 620595AE13;
	Thu, 28 May 2026 14:11:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NV33FB9NGGqJawAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 28 May 2026 14:11:43 +0000
Message-ID: <9b7e7ab0-04e4-411f-a0cd-05589fd4c98e@suse.de>
Date: Thu, 28 May 2026 16:11:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "ipv6: preserve insertion order for same-scope
 addresses"
To: Stefano Brivio <sbrivio@redhat.com>
Cc: netdev@vger.kernel.org, yuhuang@redhat.com, justin.iurman@gmail.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org,
 Chris Adams <linux@cmadams.net>, david@gibson.dropbear.id.au
References: <20260528111123.4667-1-fmancera@suse.de>
 <20260528133524.28d531e6@elisabeth>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260528133524.28d531e6@elisabeth>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,gmail.com,kernel.org,google.com,davemloft.net,nvidia.com,cmadams.net,gibson.dropbear.id.au];
	TAGGED_FROM(0.00)[bounces-292705-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 022435F3995
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 1:35 PM, Stefano Brivio wrote:
> On Thu, 28 May 2026 13:11:23 +0200
> Fernando Fernandez Mancera <fmancera@suse.de> wrote:
> 
>> Chris Adams reported that preserving insertion order for same-scope
>> addresses is causing SSH connections to be dropped after stopping a VM
>> while running NetworkManager.
>>
>> NetworkManager is caching the networking information from the system and
>> later operating with it. It relies on the order of IPv6 addresses to
>> configure routes for outgoing traffic.
> 
> I think this paragraph should make it clear that NetworkManager relies
> on a _reversed_ order (first inserted is returned last), and that it's
> the opposite compared to IPv4.
> 

FWIW; I still think that NetworkManager relies on the ordering but not 
for the route.. AFAIU, the route should be for the prefix and should not 
change at all.

So I need to figure out what is changing and document it properly on the 
commit.

>> Revert to the previous ordering.
> 
> See my concern from:
> 
>    https://lore.kernel.org/all/20260528131250.1352ab48@elisabeth/
> 
> (sorry, I sent that email moments after you sent this patch it seems). It
> fixes the issue for NetworkManager assuming it's the only issue, but it
> causes a regression for others.
> 
> If this revert is the only practical solution, so be it. I'm just wondering
> if it really is.
> 
>> This reverts commit cb3de96eea66f5e4a580086c6a1be46e765f97f4.
>>
>> Fixes: cb3de96eea66 ("ipv6: preserve insertion order for same-scope addresses")
>> Reported-by: Chris Adams <linux@cmadams.net>
>> Closes: https://lore.kernel.org/netdev/20260521135310.GC977@cmadams.net/
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
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


