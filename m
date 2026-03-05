Return-Path: <netdev+bounces-264326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGUwFGNsqWnH7AAAu9opvQ
	(envelope-from <netdev+bounces-264326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:43:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A60210BBE
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FC8B3039314
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 11:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CB93914F0;
	Thu,  5 Mar 2026 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sD5PLWoS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P0qwovsl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sD5PLWoS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P0qwovsl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5468E382F31
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710892; cv=none; b=tEYwvk2+vWBMKt00Eqb+CQhLxW+JpEs3yoNm8lLnoKDc6T4HQz+mkhq5A2ixkCrblYlLBctFdEtOq6bSo+OZ0i32HHEN5U9McsJKJXzsN7BstTBCRed8bj47QPkemMhGSzMuMm9AOYL3zcoly9RQj6bkMR8EsPAwQeT36uVdNBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710892; c=relaxed/simple;
	bh=H917Ln2/Z2AntsJKtyWBTGmKLzPhqrA1KM2ItKBP3OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnyBvZv4pFvM3WzVh1YQ9ltaXypZMN41QQtPYCSf5XSuY6ygiLpZpfKP9yMk1bY/KnouGDhRNOpojJOkdDjiIWj6EpDm4vQj2CR1NKUnEfkdV04qohVkaOk8X/72kHA3FqIkt35OK9TnnhO7yP99fm//KI+QGA/dtwYDSMfwpnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sD5PLWoS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P0qwovsl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sD5PLWoS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P0qwovsl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 965F25BCD5;
	Thu,  5 Mar 2026 11:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772710889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i8L5dGkLgpO3MaNXIU/7TIGLbWA0jgYkuqaOa6a7ctI=;
	b=sD5PLWoSjRCGyOxH41c34lsCZMHMaIAzQcXKNhgMBfMa3u/aP1VcbslcLe7nCsEfZiGfPB
	e8db6bwQivMFcBCUR/Il8ZsBEFMsPP7/+Iy+ZvrvHyOx/nlkleXNX6rPYhRoAv7J8kuBHQ
	vAFiza+Xdr29ai7IjR2qPqpk1E5L+FE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772710889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i8L5dGkLgpO3MaNXIU/7TIGLbWA0jgYkuqaOa6a7ctI=;
	b=P0qwovslMUwy5C1JoeHKi53jznx/7Ef5kDwp2qwgKBCSPOR9d4Dp1T2gSS9oqaRC4SHfga
	Uar2lBAJmQ//pFAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sD5PLWoS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=P0qwovsl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772710889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i8L5dGkLgpO3MaNXIU/7TIGLbWA0jgYkuqaOa6a7ctI=;
	b=sD5PLWoSjRCGyOxH41c34lsCZMHMaIAzQcXKNhgMBfMa3u/aP1VcbslcLe7nCsEfZiGfPB
	e8db6bwQivMFcBCUR/Il8ZsBEFMsPP7/+Iy+ZvrvHyOx/nlkleXNX6rPYhRoAv7J8kuBHQ
	vAFiza+Xdr29ai7IjR2qPqpk1E5L+FE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772710889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i8L5dGkLgpO3MaNXIU/7TIGLbWA0jgYkuqaOa6a7ctI=;
	b=P0qwovslMUwy5C1JoeHKi53jznx/7Ef5kDwp2qwgKBCSPOR9d4Dp1T2gSS9oqaRC4SHfga
	Uar2lBAJmQ//pFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEEFB3EA68;
	Thu,  5 Mar 2026 11:41:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id udJuK+hrqWmRPgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 05 Mar 2026 11:41:28 +0000
Message-ID: <777685c9-1fa9-4a47-a88c-12779214df71@suse.de>
Date: Thu, 5 Mar 2026 12:41:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 net v3] net: bridge: fix nd_tbl NULL dereference when
 IPv6 is disabled
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
 roopa@cumulusnetworks.com, sdf@fomichev.me, petrm@nvidia.com,
 horms@kernel.org, razor@blackwall.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 Guruprasad C P <gurucp2005@gmail.com>
References: <20260304120357.9778-1-fmancera@suse.de>
 <20260305113940.GA1359245@shredder>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260305113940.GA1359245@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: B9A60210BBE
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
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,cumulusnetworks.com,fomichev.me,nvidia.com,kernel.org,blackwall.org,redhat.com,google.com,davemloft.net,lunn.ch,gmail.com];
	TAGGED_FROM(0.00)[bounces-264326-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Action: no action

On 3/5/26 12:39 PM, Ido Schimmel wrote:
> On Wed, Mar 04, 2026 at 01:03:56PM +0100, Fernando Fernandez Mancera wrote:
>> When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
>> initialized because inet6_init() exits before ndisc_init() is called
>> which initializes it. Then, if neigh_suppress is enabled and an ICMPv6
>> Neighbor Discovery packet reaches the bridge, br_do_suppress_nd() will
>> dereference ipv6_stub->nd_tbl which is NULL, passing it to
>> neigh_lookup(). This causes a kernel NULL pointer dereference.
>>
>>   BUG: kernel NULL pointer dereference, address: 0000000000000268
>>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>>   [...]
>>   RIP: 0010:neigh_lookup+0x16/0xe0
>>   [...]
>>   Call Trace:
>>    <IRQ>
>>    ? neigh_lookup+0x16/0xe0
>>    br_do_suppress_nd+0x160/0x290 [bridge]
>>    br_handle_frame_finish+0x500/0x620 [bridge]
>>    br_handle_frame+0x353/0x440 [bridge]
>>    __netif_receive_skb_core.constprop.0+0x298/0x1110
>>    __netif_receive_skb_one_core+0x3d/0xa0
>>    process_backlog+0xa0/0x140
>>    __napi_poll+0x2c/0x170
>>    net_rx_action+0x2c4/0x3a0
>>    handle_softirqs+0xd0/0x270
>>    do_softirq+0x3f/0x60
>>
>> Fix this by replacing IS_ENABLED(IPV6) call with ipv6_mod_enabled() in
>> the callers. This is in essence disabling NS/NA suppression when IPv6 is
>> disabled.
>>
>> Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
>> Reported-by: Guruprasad C P <gurucp2005@gmail.com>
>> Closes: https://lore.kernel.org/netdev/CAHXs0ORzd62QOG-Fttqa2Cx_A_VFp=utE2H2VTX5nqfgs7LDxQ@mail.gmail.com/
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 
> I assume you will remove ipv6_stub from the bridge in net-next

Yes, a patch series dropping ipv6_stub is cooking.

