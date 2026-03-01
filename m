Return-Path: <netdev+bounces-262443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SVYpBSOEpGmPjAUAu9opvQ
	(envelope-from <netdev+bounces-262443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:23:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6F01D1143
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A4AC300C015
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 18:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055F5319617;
	Sun,  1 Mar 2026 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hklKgyIh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZPJRKuWT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wfpuvibu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vVUu3bd4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FAF2E7F11
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772389407; cv=none; b=RDzkYfNwo7OLT9YysGs9AE9PuxE2KflswgmvmrLTctC3HcR3WygYm68n764jvB0tPf486q/M7aQX261uixNUQYne0HKZa73/BvkACwvz5YwXl7yV71Gy8fEWlR5Uf91ffPzPT2UhBrkBo8Swy1B5enSCyW1NUAH+H3xOFRxNxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772389407; c=relaxed/simple;
	bh=SJLmODRBuXtoqmC0c0aGk3zlW+zcHFU252D5vYDdjnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrWP+LLWTVRXUXSz4igAJscWDG2gnEO6vXUUT9d11sMlOx5EViaUbpGl1GLkr3saAl810jMddYzZXapxE9EiM1Rt9qlgImvIMYf98sQyehfqOrEdnzYqCBquCq8fhFGEtdO2cUF7ezGuU1M3ig6TdSf71sX4pPrjPsbGKeLDjWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hklKgyIh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZPJRKuWT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Wfpuvibu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vVUu3bd4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 470B83E73D;
	Sun,  1 Mar 2026 18:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772389399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNF7FEVlUiSAlsg2kgHVCO34P8c+Kwe9BmlggOVSPig=;
	b=hklKgyIhRQ5QDRJJA1ZxOnRXJ4apzdAQHtyHbluL4AtmyX1kYty6kMiUaELkpn40QvAP42
	dhYmRzaKzg8MoeX2LbyAlUhugw/hVfdrgxp4gwnfbpkfRes1ZHDqxRRn4yoyJWseQgPIKu
	sMTpJiGpHAmj3xGy5s5n1bez6Y/tEJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772389399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNF7FEVlUiSAlsg2kgHVCO34P8c+Kwe9BmlggOVSPig=;
	b=ZPJRKuWTjRkgDhTHx+7/bD1d/XbQ2SN4GVcV0DEU/toCrLysCEJit+3LLyR/ASzlEi2/vg
	+mY4qXKkQiiU0bDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772389398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNF7FEVlUiSAlsg2kgHVCO34P8c+Kwe9BmlggOVSPig=;
	b=WfpuvibuMB3wq5br3158hU2TCfx9yh+6LdlXvB94k/k0WY2lYNrnlHCJ3a2GrWZ/N4J1gN
	tOFzjhpOeVCrIofQs0+mc19MAeVZrdL862GQtfK/hWmL7G+Vf8xGF6sk4FYpHTdEHUpJrA
	GlDigOg5ETkchRQe2iBsmCdQfm7mPcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772389398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNF7FEVlUiSAlsg2kgHVCO34P8c+Kwe9BmlggOVSPig=;
	b=vVUu3bd4poBxJRk5+P/uzsjx7O8MfHLSJLU0WAlYOWhO6pAeljt4O32O6sOjGBLH+6UwJF
	vtTCVcaC5tzsCOBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 990393EA69;
	Sun,  1 Mar 2026 18:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kS/aIRWEpGlWDAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 01 Mar 2026 18:23:17 +0000
Message-ID: <10579575-24a1-4c59-8d2c-5184762fa1ac@suse.de>
Date: Sun, 1 Mar 2026 19:23:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: vxlan: fix nd_tbl NULL dereference when IPv6 is
 disabled
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, amwang@redhat.com, sdf@fomichev.me,
 petrm@nvidia.com, razor@blackwall.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch
References: <20260227112701.3990-1-fmancera@suse.de>
 <20260301155413.GA755501@shredder>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260301155413.GA755501@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262443-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D6F01D1143
X-Rspamd-Action: no action

On 3/1/26 4:54 PM, Ido Schimmel wrote:
> On Fri, Feb 27, 2026 at 12:27:01PM +0100, Fernando Fernandez Mancera wrote:
>> When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
>> initialized because inet6_init() exits before ndisc_init() is called
>> which initializes it. If an IPv6 packet is injected into the interface,
>> route_shortcircuit() is called and a NULL pointer dereference happens on
>> neigh_lookup().
> 
> [...]
> 
>>
>> Fix this by adding an early check on route_shortcircuit() when protocol
>> is IPv6. If ipv6_stub->nd_tbl is NULL, return false.
>>
>> Fixes: e15a00aafa4b ("vxlan: add ipv6 route short circuit support")
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> ---
>>   drivers/net/vxlan/vxlan_core.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
>> index 05558b6afecd..cbb9d1a2d8f9 100644
>> --- a/drivers/net/vxlan/vxlan_core.c
>> +++ b/drivers/net/vxlan/vxlan_core.c
>> @@ -2130,6 +2130,8 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
>>   	{
>>   		struct ipv6hdr *pip6;
>>   
>> +		if (!ipv6_stub->nd_tbl)
> 
> I was wondering why neigh_reduce() doesn't need a similar fix, but then
> I realized that's probably because of the __in6_dev_get() check earlier
> in the function. Maybe do the same here for consistency and mention that
> it relies on commit 804b09be09f8 ("vxlan: Add RCU read-side critical
> sections in the Tx path")?
> 

I didn't know ipv6_mod_enabled() exist and I indeed prefer it. IMHO, it 
is better than the __in6_dev_get() check because here it isn't needed 
and it would be a better arbitrary.

Thanks!

> If you still prefer the current approach, then I would use
> ipv6_mod_enabled() instead of the NULL check.
> 
>> +			return false;
>>   		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
>>   			return false;
>>   		pip6 = ipv6_hdr(skb);
>> -- 
>> 2.53.0
>>


