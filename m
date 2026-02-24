Return-Path: <netdev+bounces-260658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMVvM/YUnml+TQQAu9opvQ
	(envelope-from <netdev+bounces-260658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 22:15:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3685618CA51
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 22:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C904302E925
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 21:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E703321C1;
	Tue, 24 Feb 2026 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vh4DuBjB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w9cc62wn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GQQVNZ4I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="APPPmjcB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4877D331A66
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771967725; cv=none; b=g3cMfjhsyHWZjy+Njcx8EZij1W0BzMNXuYE9MU7JM95CeexCktIExZ4GQwZCXgOjLnyCSRjAQkN1YnBPtjpGn1XFd+IB5FYk2w/p0UccvGNM5IRebJDTePzmDOHkY9jYK7WI9045aSPmhoCjjux5k6XwDLnqheKKtwoPPxrBYVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771967725; c=relaxed/simple;
	bh=P+AWeJJqjcCZXnUjSjwh+yFUZduo4FNKGJ28vpDkEVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufXEB9Pv9W38IF7/d+xctlLhiihye6FybGxI1emSAoDRNZJ7M1gqDIGP7YqOHuVVEm2qomA7EPxr0SoDxgBfnhZlHynHSCQhO+2j2+qnCr7yukowwPDytAXj2krlOf5CMIlGojXYkWHNL46zUjm+hKxqxISPuU4LpJ4NRmhMG3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vh4DuBjB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w9cc62wn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GQQVNZ4I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=APPPmjcB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D31E13F431;
	Tue, 24 Feb 2026 21:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771967721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QTVwABmLp7YcazNjUmUhynsY4icV5iGPSsBjSxT6sf8=;
	b=vh4DuBjBWEc4CeW2i5iSRIJe0BR5arl/Rq8T21HMB4eUtzLb4rxO7ZgVwqNdjP2fKqvcSI
	zfcBekBpM/s5Nphp9moY0zl4EgzdJKUw3iwRRiiXV8NSkTJlh68/QlvCdBSGGxfcKklTC1
	32pZhhg3N2sdP0fXyZeASnsn43NSq/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771967721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QTVwABmLp7YcazNjUmUhynsY4icV5iGPSsBjSxT6sf8=;
	b=w9cc62wnUJmCVQ9GlbWiqVDtF7sAUpCNJxZ5/q7gyOeF0YijYwyMI7JPavpaxkCQVbQHyW
	qrikZKhnWlBeheCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GQQVNZ4I;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=APPPmjcB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771967720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QTVwABmLp7YcazNjUmUhynsY4icV5iGPSsBjSxT6sf8=;
	b=GQQVNZ4Iryk2GO541Rtp3Bl92fByBBgJpjRM3Rs4tHUYb4GFEzIFcyzdVgbVcd8xXwCYcN
	ZP/NYrwhcNwihtd6jmMd9xKgZHLpkAMpRGIBrotTdBmKji4UvfQ559zeSAh0psTS4tiJNg
	SZ0PoXuYxvHX8Ob6oSHtBNXi2iyjnqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771967720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QTVwABmLp7YcazNjUmUhynsY4icV5iGPSsBjSxT6sf8=;
	b=APPPmjcBWrdDEeJuXOkXQ9+5JI9Hk0tSMml8UmItkON3TGx/PvznpOwhtTnPYqQKjlDuDy
	n14l3po3qUHNFKCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C6E23EA68;
	Tue, 24 Feb 2026 21:15:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sMp2D+gUnmlScwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 24 Feb 2026 21:15:20 +0000
Message-ID: <35ec7753-febc-49ac-ad00-f423122ccc44@suse.de>
Date: Tue, 24 Feb 2026 22:15:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net-next] ipv4: bump rt_genid when a relevant devconf
 value changes through netlink
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, tgraf@infradead.org
References: <20260223153045.32044-1-fmancera@suse.de>
 <20260223153045.32044-2-fmancera@suse.de> <aZ3dhDV6Fai9zbgV@horms.kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <aZ3dhDV6Fai9zbgV@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260658-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Queue-Id: 3685618CA51
X-Rspamd-Action: no action

On 2/24/26 6:19 PM, Simon Horman wrote:
> On Mon, Feb 23, 2026 at 04:30:45PM +0100, Fernando Fernandez Mancera wrote:
>> When modifying IPv4 devconf values using netlink for some relevant
>> fields the rt_cache_flush() call was missing. In addition, if forwarding
>> is enabled on the interface then disable LRO.
>>
>> This is needed to avoid possible connectivity issues and ease the
>> responsabilities of user space tools.
>>
>> Fixes: 9f0f7272ac95 ("ipv4: AF_INET link address family")
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> ---
>>   net/ipv4/devinet.c | 23 ++++++++++++++++++++++-
>>   1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
>> index 590c68e979f5..9f55c13a9c1f 100644
>> --- a/net/ipv4/devinet.c
>> +++ b/net/ipv4/devinet.c
>> @@ -2159,6 +2159,8 @@ static int inet_set_link_af(struct net_device *dev, const struct nlattr *nla,
>>   {
>>   	struct in_device *in_dev = __in_dev_get_rtnl(dev);
>>   	struct nlattr *a, *tb[IFLA_INET_MAX+1];
>> +	struct net *net = dev_net(in_dev->dev);
>> +	bool flush_cache = false;
>>   	int rem;
>>   
>>   	if (!in_dev)
> 
> Hi Fernando,
> 
> Here it is assumed that in_dev may be NULL.
> But a few lines above it is now dereferenced unconditionally.
> 
> Flagged by Smatch.
> 

Whoops. My bad. Thank you Simon.

