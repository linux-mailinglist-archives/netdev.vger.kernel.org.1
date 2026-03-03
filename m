Return-Path: <netdev+bounces-263139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMNUHOHCpmn3TQAAu9opvQ
	(envelope-from <netdev+bounces-263139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 12:15:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D63041ED98F
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 12:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6A873022936
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 11:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AFE38C2BB;
	Tue,  3 Mar 2026 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H8hL8+rM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4S+Tgb/I";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kLw0MJbO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+yWksISm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA2532143D
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772536528; cv=none; b=gnJT4xoXQ/Z7KTa9D/PoPlTmdghuIZL/BirrOnvQpNKxf/IsnY+nJeCxgru2A2cC5xx53Hy+3Cp1AtOlS2//OqpqwUVoTs41N0JuKXeaCCxkGcfpqQ8phPyw6GN/VzMP75rN11f0lHncluTpXH1ULo6g0NbaXZw3xnH16SihAvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772536528; c=relaxed/simple;
	bh=5vE8M1dbYKWF7k7fikSx4Ui4/vpuw9KlLc+R61FZqwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGfbEYeIdtsOc2cvIKtiXRT9pQXrHbVYGHnjepgpTuQ9KzJ7gjAPqaj2jhN82+eayVaZpUecBCPAVbtf0MFC0JurcbwXYayCB9Npc2QfGc7KFBX6nynOs5DoFUlxfEMiCXYkaMEXI28uLxOtVckBi/uOuyRPyw8/v90J8DP/75w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H8hL8+rM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4S+Tgb/I; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kLw0MJbO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+yWksISm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C27023F7A7;
	Tue,  3 Mar 2026 11:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772536525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTOPM5JVrkLBQv0U5x4Nb+Byop940gIykarVp2oKr6c=;
	b=H8hL8+rM4H0Lso7K2UjsoxN1tMevM29KUSW26blmIzum7gq1EcW93Dl8Nwda2uBI1/QRaJ
	Rj8J2fo+/zwGOVPXtFvAOnv7/l8UckYaCv+jwz2sq6WgfNLCy6kA6srEQK2T8tcnpTsalK
	F72s13G/3LJYyx02fwa5L4RoFVtWjto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772536525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTOPM5JVrkLBQv0U5x4Nb+Byop940gIykarVp2oKr6c=;
	b=4S+Tgb/IgJp6XCTx7ZskfVTSdoQ0Ex2u4QB4xxplhW2BVMnKhXfMAbyp5u7Gc4fDM6KlyB
	1rGWViM9DqufYuDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kLw0MJbO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+yWksISm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772536524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTOPM5JVrkLBQv0U5x4Nb+Byop940gIykarVp2oKr6c=;
	b=kLw0MJbOHIfj4QFeUQRtcekTj/WzDT918zlk7sd0CUhVS5bLFAuETyZPydSPpxjTwePxvG
	ql8wTrZOuPCm/ZWOc75KNdG+35I2G6wFfI5+9T54swUvfUzB43VQr6DHpehVvq3I9+akWK
	DeW04cVi+V0u9U+MlzZkSq0UUezmPnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772536524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTOPM5JVrkLBQv0U5x4Nb+Byop940gIykarVp2oKr6c=;
	b=+yWksISmPOF6cCIBZElnX8ox+mDPn4IR4bpVJXQ6DV1MQJ5na60miLew3Lo8iYvDE/vnIH
	Le3F85wMy5+fuyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0001F3EA69;
	Tue,  3 Mar 2026 11:15:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NUqTOMvCpmlKQAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 03 Mar 2026 11:15:23 +0000
Message-ID: <a3dd2b4f-28d6-43b8-a262-da98be9796c6@suse.de>
Date: Tue, 3 Mar 2026 12:15:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net v2] net: vxlan: fix nd_tbl NULL dereference when
 IPv6 is disabled
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux.dev, roopa@cumulusnetworks.com, sdf@fomichev.me,
 petrm@nvidia.com, horms@kernel.org, razor@blackwall.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
References: <20260302140847.5941-1-fmancera@suse.de>
 <20260302140847.5941-2-fmancera@suse.de> <aaWiH5KBf-n1NxAR@krikkit>
 <c2e08123-9338-4836-82e7-f47eb344f41f@suse.de>
 <20260302163643.GA971179@shredder>
 <fd8370d6-b163-45ac-9e6c-24046f46539e@suse.de>
 <853cf5a5-1c4e-43e5-b1fb-38c986488ba8@suse.de> <aaYXIkHH4xsP_YDx@krikkit>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <aaYXIkHH4xsP_YDx@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: D63041ED98F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263139-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:dkim,suse.de:mid]
X-Rspamd-Action: no action

On 3/3/26 12:02 AM, Sabrina Dubroca wrote:
> 2026-03-02, 19:04:14 +0100, Fernando Fernandez Mancera wrote:
>> On 3/2/26 6:44 PM, Fernando Fernandez Mancera wrote:
>>> On 3/2/26 5:36 PM, Ido Schimmel wrote:
>>>> On Mon, Mar 02, 2026 at 04:13:14PM +0100, Fernando Fernandez Mancera
>>>> wrote:
>>>>> On 3/2/26 3:43 PM, Sabrina Dubroca wrote:
>>>>>> 2026-03-02, 15:08:47 +0100, Fernando Fernandez Mancera wrote:
>>>>>>> When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
>>>>>>> initialized because inet6_init() exits before ndisc_init() is called
>>>>>>> which initializes it. If an IPv6 packet is injected into
>>>>>>> the interface,
>>>>>>> route_shortcircuit() is called and a NULL pointer
>>>>>>> dereference happens on
>>>>>>> neigh_lookup().
>>>>>>
>>>>>> VXLAN can be built-in even when IPv6 is built as a module, and then
>>>>>> ipv6_mod_enabled can't be used in VXLAN:
>>>>>>
>>>>>> ld: drivers/net/vxlan/vxlan_core.o: in function `route_shortcircuit':
>>>>>> drivers/net/vxlan/vxlan_core.c:2133:(.text+0x116e0):
>>>>>> undefined reference to `ipv6_mod_enabled'
>>>>>>
>>>>>>
>>>>>> GENEVE has a Kconfig tweak to prevent this since 094be0927ff3
>>>>>> ("geneve: fix build with modular IPV6"):
>>>>>>
>>>>>>        depends on IPV6 || !IPV6
>>>>>>
>>>>>> but VXLAN doesn't.
>>>>>>
>>>>>
>>>>> Ugh, good catch. Thanks Sabrina.
>>>>>
>>>>>> But then I think we don't need to use ipv6_stub at all.
>>>>>
>>>>> If we enforce "depends on IPV6 || IPV6=n" on VXLAN we could get rid of
>>>>> ipv6_stub completely and use direct calls instead.
>>>>
>>>> I just noticed that this is already enforced for the bridge, so maybe
>>>> you can just remove ipv6_stub in patch #1?
>>>>
>>>
>>> Yes, after Sabrina mentioned it that was what I planned to do. But on
>>> VXLAN I want to avoid such patch for net tree as a fix. Instead I
>>> propose to use the __in6_dev_get() check as neigh_reduce() does.
> 
> I'm not convinced __in6_dev_get() makes more sense. It's also pretty
> much a random NULL check to me, and at least with checking nd_tbl
> directly it's clearly related to the code that follows.
> 
> In neigh_reduce(), __in6_dev_get() seems to have been present from the
> start, and back then in6_dev was used in the function. Now, it might
> easily be removed by a clean-up patch that doesn't notice it's useful.
> 

Fair enough, let's just stick to the nd_tbl NULL check for now on VXLAN. 
I will send a patch on net-next tree once this is merged to enforce 
"depends on IPV6 || IPV6=n" and remove ipv6_stub from there.

I hope that sounds good to you all.

> 
> Should there be a helper ipv6_mod_available() (or a better name) in
> net/ipv6/addrconf_core.c (so always available) to wrap those checks in
> a way that doesn't rely on Kconfig magic nor non-obvious NULL checks?
> (maybe even replacing ipv6_mod_enabled()?)
> 

Maybe yes, but not sure if it is worth it. As discussed here [1] 
dropping IPv6 as a module seems like a good idea. Anyway, let's discuss 
that topic there!

[1] https://lore.kernel.org/netdev/20260302171131.28373ccb@kernel.org/

Thanks,
Fernando.

>>> Later,
>>> do a follow-up patch on net-next tree removing ipv6_stub and enforcing
>>> "depends on IPV6 || IPV6=n".
>>>
>>
>> FWIW; removing the ipv6_stub won't keep us from checking ipv6_mod_enabled()
>> as ipv6.disable=1 can still be set at booting time and therefore nd_tbl will
>> still be non-initialized because ndisc_init() and neigh_table_init() are
>> never called.
> 
> Ok.
> 


