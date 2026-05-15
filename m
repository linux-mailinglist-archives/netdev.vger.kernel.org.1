Return-Path: <netdev+bounces-288218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kApYISPUBmqKoAIAu9opvQ
	(envelope-from <netdev+bounces-288218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:06:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0879754B0BB
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AACE306E646
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340173DEFE2;
	Fri, 15 May 2026 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ApBhmjnO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RIVauBrQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ApBhmjnO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RIVauBrQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB233F0AA7
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778832185; cv=none; b=U03lRI9wLSa9LZnswEecJ9RKuqC5l6q2vTOnt9E05Klm6ndSh0PFAQxb7lgG2RKLAN0DdGKgvPtPUtT5+b2xc7rXlUJ52fsaS8qsEt9++MDhoAax5lnWETeSBWy+rQWQcQIK5zBCJh3H+U8IGC/k0ZH+fdy32UFpp53I/mU1tvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778832185; c=relaxed/simple;
	bh=qIiCN8vEjyZAp7L8IV8y2VfeK+HlqL4OHgav45SrQG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPPJGX5B8oGalsn3EdVe4Ym6a/+O9m7i5REWGfsd9TV7bAxKh+KTtbgnVBo7/485ht6YvFXCVQ5Eglo/SBE1mPYhj6/Mq4k2WMxdhlw6aMJRl2KPbFN6rhO9Y7W3I9i2SkbGfRoZaCCyWa465PXMgInbo1OxtZkrmiy/cxbUjCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ApBhmjnO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RIVauBrQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ApBhmjnO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RIVauBrQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D1B6E5C9DE;
	Fri, 15 May 2026 08:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778832181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjoiyNBk0dz89kN+bFiThzSsVUL+NTonuKDYYkUerP0=;
	b=ApBhmjnOqLJZndXN6Z+Q6lFm4jh/cgsORIy9MUxN5ZkJZ8+dwM7JAdFGLRcDFL2JJKpkBj
	GHDRp4hQZqSiG7c0+zx6KeoOz3CmVhbUy4Dh6yLZqeGZW/2zutKLZKppMRw6tcB9ix9ujA
	Ak1pHzr8L1UuaazHbGHPSq31KsbQZHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778832181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjoiyNBk0dz89kN+bFiThzSsVUL+NTonuKDYYkUerP0=;
	b=RIVauBrQj3BlaZCcdxL44zPl0nE8g3uL+z+dHtMFsLEUI+oof73L5oGDSmwgB9J5SXA1FI
	veUuw+tnagpMVmBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778832181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjoiyNBk0dz89kN+bFiThzSsVUL+NTonuKDYYkUerP0=;
	b=ApBhmjnOqLJZndXN6Z+Q6lFm4jh/cgsORIy9MUxN5ZkJZ8+dwM7JAdFGLRcDFL2JJKpkBj
	GHDRp4hQZqSiG7c0+zx6KeoOz3CmVhbUy4Dh6yLZqeGZW/2zutKLZKppMRw6tcB9ix9ujA
	Ak1pHzr8L1UuaazHbGHPSq31KsbQZHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778832181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjoiyNBk0dz89kN+bFiThzSsVUL+NTonuKDYYkUerP0=;
	b=RIVauBrQj3BlaZCcdxL44zPl0nE8g3uL+z+dHtMFsLEUI+oof73L5oGDSmwgB9J5SXA1FI
	veUuw+tnagpMVmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 649C7593A9;
	Fri, 15 May 2026 08:03:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GSvFFTXTBmpUFwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 15 May 2026 08:03:01 +0000
Message-ID: <f528360c-18b3-46e5-8ba8-88f921203716@suse.de>
Date: Fri, 15 May 2026 10:02:50 +0200
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
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dsahern@kernel.org, davem@davemloft.net
References: <20260510081528.5257-1-fmancera@suse.de>
 <20260510081528.5257-3-fmancera@suse.de> <20260513193544.47970cb8@kernel.org>
 <bd560c89-c71f-4ef5-a0fd-5ea096a0f767@suse.de>
 <20260514162429.366b94c9@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260514162429.366b94c9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 0879754B0BB
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
	TAGGED_FROM(0.00)[bounces-288218-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/15/26 1:24 AM, Jakub Kicinski wrote:
> On Thu, 14 May 2026 11:42:16 +0200 Fernando Fernandez Mancera wrote:
>> On 5/14/26 4:35 AM, Jakub Kicinski wrote:
>>> On Sun, 10 May 2026 10:15:28 +0200 Fernando Fernandez Mancera wrote:
>>>> Introduce a new test, `ipv4_devconf_notify`, to verify that the kernel
>>>> sends the appropriate netlink notifications when IPv4 devconf parameters
>>>> are modified.
>>>>
>>>> Since YNL currently has a bug where it declares an array of u32 values
>>>> instead of the nested attributes expected by the kernel for devconf set
>>>> operations, a temporary hack (`patched_add_attr`) is included to
>>>> pack the netlink attributes correctly.
>>>
>>> Right, YNL doesn't really support the level or weirdness that netconf
>>> requires. Why use YNL? Can't we test this with iproute2?
>>
>> No, AFAIU, iproute2 does not expose devconf settings. The main user of
>> IFLA_INET_CONF are netlink libraries and other userspace tools that
>> heavily rely on netlink operations like NetworkManager, nmstate, nispor,
>> rust-netlink..
> 
> Isn't this ip netconf ?
> 

Oh sorry, I should have clarified it. ip netconf only shows/query them 
but it cannot set them AFAICS.

Usage: ip netconf show [ dev STRING ]

>> FWIW, I plan to fix the YNL side of things so we have this fixed
>> properly.
> 
> If it adds any hacks or new concepts to YNL it's unlikely to
> be accepted :(
> 
>> But I would prefer if this isn't blocked. Another patchset
>> introducing IFLA_INET6_CONF support is also coming.. being able to avoid
>> sysctl usage is quite useful for these userspace tools.
> 


