Return-Path: <netdev+bounces-267513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPJ9LvYrtGkEigAAu9opvQ
	(envelope-from <netdev+bounces-267513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:23:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E98285DF9
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D79C306501F
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF71398914;
	Fri, 13 Mar 2026 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KyLlUqAO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1p9IyNE6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KyLlUqAO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1p9IyNE6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BA0324B27
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414823; cv=none; b=YUUh0j0/tKr2/+bv44rvrFqedYfeXzL6+LTVUG6nB+mUA8IebWEiiow4PK4sHenMYmLolCODCF1b0Uu1jDJTns4EE8M2dUKTdc8iLw87GaDhRa8PJxzYUdAesibWIxQO1YRQwfE99ozgJWGIN7JMJxGdBaTuCLBMJeu9m7dCkdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414823; c=relaxed/simple;
	bh=C/7Dijteix+L9WyvuljLZR14ATx3CnuaS+0bH42iOfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4IVdpuoSlsMHuemXBRmCVdYvUYgYXyCxejmCrFMq1O9N7T9UUSS+hsh2FSt92kZmWtiBie9PaFVy0fMKz2iOJRpbqi+NSdJTqEH5WgRcRbVJ4F5a22RNcxpUWe5vZvcBmv7+xAjV3iVOJStIMgyP4fwrVKqdlQcM2nsIq+SjOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KyLlUqAO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1p9IyNE6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KyLlUqAO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1p9IyNE6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52E6E4D1C3;
	Fri, 13 Mar 2026 15:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773414817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xg69dOgBw4/gh98QFcZRnYWmet0e9dLx+0xc+pY8yzs=;
	b=KyLlUqAOkk/l4fP+3Hk0E6FLAhl5Kjz1dBJJlQ4W0x7VpWzMmnRkRO/CyiUY6i3aNaWeVF
	fzH+2NwTHel1XIjWHzg+gE4UIhPhxr7j2+u+jTs9MKkzDCqsTXTJ6Rw3/uhPA/72R+fTa8
	hepzmpte/1JXN65BYvtwM54YAiuFSo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773414817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xg69dOgBw4/gh98QFcZRnYWmet0e9dLx+0xc+pY8yzs=;
	b=1p9IyNE6F7UlZ9ioG1L7T0F1thi0m9Hjq/RbTG2jpwr8fviDg2p9plilylF1SCuFLwc6sx
	dfZXYttVnqZRomAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KyLlUqAO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1p9IyNE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773414817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xg69dOgBw4/gh98QFcZRnYWmet0e9dLx+0xc+pY8yzs=;
	b=KyLlUqAOkk/l4fP+3Hk0E6FLAhl5Kjz1dBJJlQ4W0x7VpWzMmnRkRO/CyiUY6i3aNaWeVF
	fzH+2NwTHel1XIjWHzg+gE4UIhPhxr7j2+u+jTs9MKkzDCqsTXTJ6Rw3/uhPA/72R+fTa8
	hepzmpte/1JXN65BYvtwM54YAiuFSo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773414817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xg69dOgBw4/gh98QFcZRnYWmet0e9dLx+0xc+pY8yzs=;
	b=1p9IyNE6F7UlZ9ioG1L7T0F1thi0m9Hjq/RbTG2jpwr8fviDg2p9plilylF1SCuFLwc6sx
	dfZXYttVnqZRomAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFDEA405B3;
	Fri, 13 Mar 2026 15:13:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VSnOL6AptGmxcQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 13 Mar 2026 15:13:36 +0000
Message-ID: <633f5de1-daeb-48ac-aba1-92b3c3ccf5c8@suse.de>
Date: Fri, 13 Mar 2026 16:13:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] ipv4: bump rt_genid when a relevant devconf value
 changes through netlink
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: tgraf@infradead.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net
References: <20260313144555.4956-1-fmancera@suse.de>
 <1644761b-4960-431f-bf3d-5593007212fc@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <1644761b-4960-431f-bf3d-5593007212fc@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-267513-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 76E98285DF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 3:56 PM, David Ahern wrote:
> On 3/13/26 8:45 AM, Fernando Fernandez Mancera wrote:
>> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
>> index 537bb6c315d2..6dd8fd0a1323 100644
>> --- a/net/ipv4/devinet.c
>> +++ b/net/ipv4/devinet.c
>> @@ -2107,8 +2109,33 @@ static int inet_set_link_af(struct net_device *dev, const struct nlattr *nla,
>>   		return -EINVAL;
>>   
>>   	if (tb[IFLA_INET_CONF]) {
>> -		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem)
>> -			ipv4_devconf_set(in_dev, nla_type(a), nla_get_u32(a));
>> +		nla_for_each_nested(a, tb[IFLA_INET_CONF], rem) {
>> +			int new_value = (int)nla_get_u32(a);
>> +
>> +			if (ipv4_devconf_get(in_dev, nla_type(a)) == new_value)
>> +				continue;
>> +
>> +			ipv4_devconf_set(in_dev, nla_type(a), new_value);
>> +			switch (nla_type(a)) {
>> +			case IPV4_DEVCONF_FORWARDING:
>> +				if (new_value)
>> +					netif_disable_lro(dev);
>> +				fallthrough;
>> +			case IPV4_DEVCONF_NOXFRM:
>> +			case IPV4_DEVCONF_NOPOLICY:
>> +			case IPV4_DEVCONF_PROMOTE_SECONDARIES:
>> +			case IPV4_DEVCONF_ROUTE_LOCALNET:
>> +			case IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST:
>> +			case IPV4_DEVCONF_BC_FORWARDING:
>> +			case IPV4_DEVCONF_ACCEPT_LOCAL:
>> +				flush_cache = true;
>> +				break;
>> +			default:
>> +				break;
>> +			}
>> +		}
>> +		if (flush_cache)
>> +			rt_cache_flush(net);
>>   	}
>>   
>>   	return 0;
> 

Hi David,

> This replicates logic in devinet_conf_proc for example. Why not refactor
> devinet.c to handle changes to values in 1 place only.

I have been looking into it but seems like too much to do it on the net 
tree. I am preparing a patch for IPv4 unifying the logic as much as 
possible so we can get rid of this mess.

> Also, you are flushing the cache for more values than sysfs does.

I don't think so. The problem is that the handling of sysctl is 
scattered in several places.

IPV4_DEVCONF_FORWARDING is flushed at devinet_sysctl_forward().

IPV4_DEVCONF_NOXFRM, IPV4_DEVCONF_NOPOLICY, 
IPV4_DEVCONF_PROMOTE_SECONDARIES, IPV4_DEVCONF_ROUTE_LOCALNET, and 
IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST are flushed at 
ipv4_doint_and_flush() used by macro DEVINET_SYSCTL_FLUSHING_ENTRY.

Finally, IPV4_DEVCONF_BC_FORWARDING and IPV4_DEVCONF_ACCEPT_LOCAL are 
flushed at devinet_conf_proc().

Yes, I know, the fact that they are scattered around is quite confusing. 
This could be all unified in a single place but that would be too much 
for net tree IMHO.

Please let me know if I am missing something.

Thanks,
Fernando.

