Return-Path: <netdev+bounces-271007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLiYK6Z0wmmncwQAu9opvQ
	(envelope-from <netdev+bounces-271007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:25:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50614307433
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E7293005AA7
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FF63E557B;
	Tue, 24 Mar 2026 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eSegUAEU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a9qfK3Ly";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eSegUAEU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a9qfK3Ly"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3123E1215
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774351524; cv=none; b=oZGd66pLnIUZXtQUzBWmzthPOmB1KXnsGabm6l+P9BnfNzgm4Ci+MXcUEP9ckWHyBtKZNPcsF3SXXfxBgfcGsOJ+JEabAb8ZTrLdeGUn8BIT6E+3+SL1DmDVo+TkJpDeN9LwYmTbv1a5ngjGi3r3foUT6eHFTJrxBZcouwvn344=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774351524; c=relaxed/simple;
	bh=pVSDz6DxsOdWN7qj5RNP8F0p0Ixbv3dvmRicMj7vfFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEmVi4949bJPs6FNxaPRYNT/bnC1Sku7VCuSF9SHcunh+rFu97dZPhVrWgoMvbJ9EX2uidEyCQHNODJZSa2hbTT5+SUgPd+6Q2BwGc+NG/OOtFl3K+lF5nvnxIw+wEK4gCoilZ1t7vNKvfjnnF6zGB5akmuCZw4OKFQ0A4oyQXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eSegUAEU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a9qfK3Ly; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eSegUAEU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a9qfK3Ly; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C2495BCEB;
	Tue, 24 Mar 2026 11:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774351521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XX6J1/Eby9nFmxdT584BJ7ZWUplo+F4aY4cqZSpkYg=;
	b=eSegUAEUB71MbXjkvL/UBbExptInVvBXSEXRNWP2CAxrV07kL69imJJnPTolcqC5bsxoJ1
	jW1LhB5wQEbbXN78f4itIxA14z2dj5bDi+/ymQJdNTFCqsq+p7yR7i2vUZBfgjzKatUJGy
	FHvzT+CfsFRUubAJ99mbCjkfSMP4EGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774351521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XX6J1/Eby9nFmxdT584BJ7ZWUplo+F4aY4cqZSpkYg=;
	b=a9qfK3LyJzAbT/+ahnGHyFqzYFmWIfpi7VcjZdWTBm2hm5Gg4IwvBG4kMEZkeSec90yHQc
	/W3v6Z25q+qnFODg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eSegUAEU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=a9qfK3Ly
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774351521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XX6J1/Eby9nFmxdT584BJ7ZWUplo+F4aY4cqZSpkYg=;
	b=eSegUAEUB71MbXjkvL/UBbExptInVvBXSEXRNWP2CAxrV07kL69imJJnPTolcqC5bsxoJ1
	jW1LhB5wQEbbXN78f4itIxA14z2dj5bDi+/ymQJdNTFCqsq+p7yR7i2vUZBfgjzKatUJGy
	FHvzT+CfsFRUubAJ99mbCjkfSMP4EGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774351521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XX6J1/Eby9nFmxdT584BJ7ZWUplo+F4aY4cqZSpkYg=;
	b=a9qfK3LyJzAbT/+ahnGHyFqzYFmWIfpi7VcjZdWTBm2hm5Gg4IwvBG4kMEZkeSec90yHQc
	/W3v6Z25q+qnFODg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D48A643DF2;
	Tue, 24 Mar 2026 11:25:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n+7iMKB0wmlRKAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 24 Mar 2026 11:25:20 +0000
Message-ID: <d2318105-4bfc-435f-af4b-d3e10d50e37c@suse.de>
Date: Tue, 24 Mar 2026 12:25:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11 net-next v4] ipv6: prepare headers for ipv6_stub
 removal
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?=
 <rbm@suse.com>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20260320185649.5411-1-fmancera@suse.de>
 <20260320185649.5411-6-fmancera@suse.de> <20260324082209.GA365237@shredder>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260324082209.GA365237@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271007-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50614307433
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/26 9:22 AM, Ido Schimmel wrote:
> On Fri, Mar 20, 2026 at 07:55:57PM +0100, Fernando Fernandez Mancera wrote:
>> +#if IS_ENABLED(CONFIG_IPV6)
>>   int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>>   		 int (*output)(struct net *, struct sock *, struct sk_buff *));
>> +#else
>> +static inline int ip6_fragment(struct net *net, struct sock *sk,
>> +			       struct sk_buff *skb,
>> +			       int (*output)(struct net *, struct sock *,
>> +					     struct sk_buff *))
>> +{
>> +	kfree_skb(skb);
>> +	return -EAFNOSUPPORT;
>> +}
>> +#endif
> 
> [...]
> 
>> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
>> index 8e2a6b28cea7..79f7ee93ceff 100644
>> --- a/net/ipv6/ip6_output.c
>> +++ b/net/ipv6/ip6_output.c
>> @@ -873,6 +873,8 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>>   	__be32 frag_id;
>>   	u8 *prevhdr, nexthdr = 0;
>>   
>> +	if (!ipv6_mod_enabled())
>> +		return -EAFNOSUPPORT;
> 
> Free the skb?
> 

Ah right. Makes sense, thanks!

>>   	err = ip6_find_1stfragopt(skb, &prevhdr);
>>   	if (err < 0)
>>   		goto fail;
>> @@ -1045,6 +1047,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>>   	kfree_skb(skb);
>>   	return err;
>>   }
>> +EXPORT_SYMBOL_GPL(ip6_fragment);
> 


