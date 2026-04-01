Return-Path: <netdev+bounces-274137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBupJzIxzWn0agYAu9opvQ
	(envelope-from <netdev+bounces-274137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:52:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4135B37C75F
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2068C300D763
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 14:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9CF317144;
	Wed,  1 Apr 2026 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vu/wm++2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LCg+kR6x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="saGQBAIq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fW+H5sRe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29000227B94
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055047; cv=none; b=cmK1HJwOhG4wUgCpPpkNLl0UKjBnAVSgZppthC5YQhs3PbPmGYsxHIDom4PU65HpNVePDC2CWQYJoBW/JnB4TjO8fDEIKtQYS92SpCaRpkfrh/KFsvnBneqPM6kTSWzkYLDjMK4w8ZEn7RuoLKr2fG16VfJUhObnuJdC7vJDCFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055047; c=relaxed/simple;
	bh=NR79chiDTTUvbAAnB8eHo7GKrLd/SQFM0qUTs6t4WBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RiXLdTB306JXQYxNscZgP61RyQhaFTuS/g1052hU+vINxCg9ZVS9gPWD77Kksmce87tZD+T5gje+RyQc8N8LktLgvmFmlU/QQB415UDl8q3p7jZ+5t9+AyEY3L/prNa/xQya7bmhcqVQSPIome3AqD8ry0zyswOpY7tALQ4c+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vu/wm++2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LCg+kR6x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=saGQBAIq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fW+H5sRe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D55605BD8A;
	Wed,  1 Apr 2026 14:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775055042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUjZYblrcVCpcCkO/Mc57Hxu3KBAf8QIzvbIFndnm9k=;
	b=Vu/wm++2LqrNSvgj2m+yXMhKF9y9zW+aV2EZHm5tdm13bsYLc0VXcelPHmgNjFvkNAIlnK
	Im9jgPjlINIoQ9Cz9lQ0SUEKngTyXiGekooPxDY3GBGa798arQBW1gz60lpMr6U7b3x51j
	0oVktXI6bRmsj/vbYRqfCrG+yIson1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775055042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUjZYblrcVCpcCkO/Mc57Hxu3KBAf8QIzvbIFndnm9k=;
	b=LCg+kR6xDJJ1vkWs6shKIME2kwzuQ0EUShvMnLWSXWifhfcWJTVD1W/g4xboMMWDDTOaaj
	Mb9tmD0dJDV403Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=saGQBAIq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fW+H5sRe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775055041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUjZYblrcVCpcCkO/Mc57Hxu3KBAf8QIzvbIFndnm9k=;
	b=saGQBAIqu/Y219uzqKvoGDn9pXOOU0JsiHr1zGKUyV4RbNZVAXfRZ36wKO71biTL48DC5g
	HgC3ESK2BuZYbUXQBP8RspkhaxOgk4IUrrQSdE48XrwrdlyMcK26wGgHVHfNirSxRWCoZd
	5LhdLBqw8vbWx1Fqs70nhDu3gSo+65I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775055041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUjZYblrcVCpcCkO/Mc57Hxu3KBAf8QIzvbIFndnm9k=;
	b=fW+H5sReHMsLNQlK2y3rT3QZGkvKbw1Mb+iwTO3Pjlkn8SqdCO+FKIbHG+oVORnz8jhV5E
	xttJT3L6Fj5grTBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F0F74A0B0;
	Wed,  1 Apr 2026 14:50:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VHSADMEwzWnSGwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 01 Apr 2026 14:50:41 +0000
Message-ID: <17d4d7e2-3b55-4eac-926c-e1355fbc1cd3@suse.de>
Date: Wed, 1 Apr 2026 16:50:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net v2] ipv4: nexthop: allocate skb dynamically in
 rtm_get_nexthop()
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com, petrm@nvidia.com, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 dsahern@kernel.org, kees@kernel.org, Yiming Qian <yimingqian591@gmail.com>
References: <20260401081741.4273-1-fmancera@suse.de>
 <20260401081741.4273-2-fmancera@suse.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260401081741.4273-2-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-274137-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4135B37C75F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/1/26 10:17 AM, Fernando Fernandez Mancera wrote:
> When querying a nexthop object via RTM_GETNEXTHOP, the kernel currently
> allocates a fixed-size skb using NLMSG_GOODSIZE. While sufficient for
> single nexthops and small Equal-Cost Multi-Path groups, this fixed
> allocation fails for large nexthop groups like 512 nexthops.
> 
> This results in the following warning splat:
> 
>   WARNING: net/ipv4/nexthop.c:3395 at rtm_get_nexthop+0x176/0x1c0, CPU#20: rep/4608
>   [...]
>   RIP: 0010:rtm_get_nexthop (net/ipv4/nexthop.c:3395)
>   [...]
>   Call Trace:
>    <TASK>
>    rtnetlink_rcv_msg (net/core/rtnetlink.c:6989)
>    netlink_rcv_skb (net/netlink/af_netlink.c:2550)
>    netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1344)
>    netlink_sendmsg (net/netlink/af_netlink.c:1894)
>    ____sys_sendmsg (net/socket.c:721 net/socket.c:736 net/socket.c:2585)
>    ___sys_sendmsg (net/socket.c:2641)
>    __sys_sendmsg (net/socket.c:2671)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>    </TASK>
> 
> Fix this by allocating the size dynamically using nh_nlmsg_size() and
> using nlmsg_new(), this is consistent with nexthop_notify() behavior. In
> addition, adjust nh_nlmsg_size_grp() so it calculates the size needed
> based on flags passed.
> 
> This cannot be reproduced via iproute2 as the group size is currently
> limited and the command fails as follows:
> 
> addattr_l ERROR: message exceeded bound of 1048
> 
> Fixes: 430a049190de ("nexthop: Add support for nexthop groups")
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Closes: https://lore.kernel.org/netdev/CAL_bE8Li2h4KO+AQFXW4S6Yb_u5X4oSKnkywW+LPFjuErhqELA@mail.gmail.com/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

As Ido requested some changes, update the status in patchwork.

-- 
pw-bot: cr

