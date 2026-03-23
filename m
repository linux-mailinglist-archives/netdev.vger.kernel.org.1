Return-Path: <netdev+bounces-270591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBfZKBtbwWlKSgQAu9opvQ
	(envelope-from <netdev+bounces-270591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:24:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C43B2F6387
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C43D304F325
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FA727FD54;
	Mon, 23 Mar 2026 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gqLuhK11";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tud2Xaty";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gqLuhK11";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tud2Xaty"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E356227EFEE
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278413; cv=none; b=Gr86qkhZrVSlnzpRP9IxFD7/R5XERBPMyZ5awXr9lEplWDOHPnmDrmYsn0URoTv8ad0uS9jWJ7miQej+fphc/HhASHLCfqBgg1lzEXPtxGa1KBATBhvrst1UzclVJN+XaTrSkHupMgxKlW6vNcs/+CaJibfxYWKmkmbBNZcCQw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278413; c=relaxed/simple;
	bh=s3HNE16BHwfZ82yprcqouG789f7AHLkXIQAmavAI+pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgq7+HBO7ovD702b17z+IHpGE93PZApZS0Zl0bmtVO1GN4RHXcF98nAtXcS5lyC/hjlp5NR+cPfhLPQ1ynMhs909z/5H4uA/N6yYNMY/c8yAV/7oHYHQ1UDvrQQOXRA4BPa978DYDY+mHc35ehHXbZMh3vAru88q39X5Rcpxl2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gqLuhK11; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tud2Xaty; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gqLuhK11; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tud2Xaty; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 36B475BE07;
	Mon, 23 Mar 2026 15:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774278410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47T2XPj13w/pwUTEt2LhKrGRcOq83dmZ219Cyt3IsYo=;
	b=gqLuhK11tny35NolrBhwl0aTNImPJrUtugBGVS8I0tN3BFCi8HVYKDOTAc6KMOcdFDlqaP
	kraJVfHzM5q/O3SJ96LwG5qvLz0p5+lywJ/DoNUqbmW05yVA0wXWB1hLzEgNkokQvtup4R
	ub+Izf6p8wDLLseOTyETCNvYe6Kgxy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774278410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47T2XPj13w/pwUTEt2LhKrGRcOq83dmZ219Cyt3IsYo=;
	b=Tud2XatylVVEzZ4+vskAq61LttcRdQ7WGDxMYyCP///nWOKSVnh29itQ2XvYr4lH/TyGmr
	bSJlroC3olhIOJBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774278410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47T2XPj13w/pwUTEt2LhKrGRcOq83dmZ219Cyt3IsYo=;
	b=gqLuhK11tny35NolrBhwl0aTNImPJrUtugBGVS8I0tN3BFCi8HVYKDOTAc6KMOcdFDlqaP
	kraJVfHzM5q/O3SJ96LwG5qvLz0p5+lywJ/DoNUqbmW05yVA0wXWB1hLzEgNkokQvtup4R
	ub+Izf6p8wDLLseOTyETCNvYe6Kgxy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774278410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47T2XPj13w/pwUTEt2LhKrGRcOq83dmZ219Cyt3IsYo=;
	b=Tud2XatylVVEzZ4+vskAq61LttcRdQ7WGDxMYyCP///nWOKSVnh29itQ2XvYr4lH/TyGmr
	bSJlroC3olhIOJBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94DB04392F;
	Mon, 23 Mar 2026 15:06:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Dt4nIQlXwWk6RwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 23 Mar 2026 15:06:49 +0000
Message-ID: <a0b73cb6-2e57-4c2a-b990-f72000a849b2@suse.de>
Date: Mon, 23 Mar 2026 16:06:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11 net-next v4] Convert CONFIG_IPV6 to built-in and
 remove stubs
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, rbm@suse.com,
 linux-kernel@vger.kernel.org
References: <20260320185649.5411-1-fmancera@suse.de>
 <20260322172702.GA121169@shredder>
 <8c136575-e23e-4cc2-a455-f1ba1abde2d5@suse.de>
 <2f1d55ee-440c-49a6-97a8-4354c57f9fe9@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <2f1d55ee-440c-49a6-97a8-4354c57f9fe9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270591-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3C43B2F6387
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 3:38 PM, David Ahern wrote:
> On 3/23/26 6:19 AM, Fernando Fernandez Mancera wrote:
>> On 3/22/26 6:27 PM, Ido Schimmel wrote:
>>> On Fri, Mar 20, 2026 at 07:55:52PM +0100, Fernando Fernandez Mancera
>>> wrote:
>>>> Changes:
>>>>     v4:
>>>>       Patch 2: new patch introduced on this revision
>>>>       Patch 3: drop some IS_BUILTIN(IPV6) on files compiled only when
>>>> IPV6=y
>>>>       Patch 5: introduce ipv6_mod_enabled() checks on fib6_nh_init(),
>>>> ip6_dst_lookup_flow() and ip6_fragment() to avoid crash when
>>>> ipv6.disable=1 during boot
>>>>       Patch 6: use &nd_tbl on code guarded by IS_ENABLED(CONFIG_IPV6)
>>>
>>> The IPv6 code is still using ipv6_get_nd_tbl() for some reason. If you
>>> remove it from there (it's not needed), then we are only left with
>>> handful of users that can be converted to use '&nd_tbl' when IPv6 is
>>> enabled. Something like the patch below.
>>>
>> Hi Ido, the main reason why ipv6_get_nd_tbl() is used on IPv6 code is
>> due to inlined functions. __ipv6_neigh_lookup_noref() is used in several
>> places not guarded by IS_ENABLED(CONFIG_IPV6) preprocessor directive.
>> That leads to undefined references when compiling with CONFIG_IPV6=n.
>>
>> ld: vmlinux.o: in function `bpf_ipv4_fib_lookup':
>> filter.c:(.text+0x322b9dc): undefined reference to `nd_tbl'
>> ld: filter.c:(.text+0x322b9fb): undefined reference to `nd_tbl'
>> ld: filter.c:(.text+0x322ce1a): undefined reference to `nd_tbl'
>> ld: vmlinux.o: in function `ipv4_confirm_neigh':
>> route.c:(.text+0x345ade7): undefined reference to `nd_tbl'
>> ld: route.c:(.text+0x345ae06): undefined reference to `nd_tbl'
>> ld: vmlinux.o:route.c:(.text+0x345b74f): more undefined references to
>> `nd_tbl' follow
> 
> are these errors with Ido's suggested additional change?

Actually no. I missed the Dead-code elimination optimization. Never mind 
my reply, it makes sense to follow Ido's suggestion.

Thanks and sorry for the back-and-forth. *facepalm*
Fernando.

