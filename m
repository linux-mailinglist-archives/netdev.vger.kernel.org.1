Return-Path: <netdev+bounces-267812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OH5gNLOhtWk02wAAu9opvQ
	(envelope-from <netdev+bounces-267812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:58:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E0C28E521
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 552B2304F5F5
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8573264C5;
	Sat, 14 Mar 2026 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N1WCBJc3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xpq1NMNc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mbeSQ/eU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="miCoIsaP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079E912D1F1
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510739; cv=none; b=IIpSyCSdCEKFiL4flqiH0ny16/PE9wIXeb/p+gjSzK+vLYaMVZKHqCJ+JZb6Lf5ApAEIM5NCc7HaDHRXlMqZz/2mec/ub7NP7MgX43EtT273Jd2Bl1GjAu4nxrFyxQIF5Xu+dMxt1IBvBJawWz6ukKbcSmq2gsoOYvbYM0QykFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510739; c=relaxed/simple;
	bh=//UWKM5jaT6jgXKFCZpBMZ4bI6qvcYXtswSo/v0thZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqRd7lWZV+Y2BycFNEChOvRtIpEZ9lXLGXhKFtiNfXnIzq98D14137lR8H+3fLTMLMrremRkb7itJwYZlfbOmUXhIcxfXCBH+RikA+FEWmBl+/dd3zRu4gILIJZg9YMLynInJk07sW04BaroPDASNOmHn2/xCF12UzKON/RE3G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N1WCBJc3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xpq1NMNc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mbeSQ/eU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=miCoIsaP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EEC185BCEF;
	Sat, 14 Mar 2026 17:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773510736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ojej/sUCpOz+E4rO877kHndCUA16+Ful5u0xuu3gjw=;
	b=N1WCBJc3dKZX1feQ0bqGUPxRfbTAv0NVYRHcJk7xRoByETNSI4H1TlfFJ2p86ThxxX52yp
	UsUsbw1aq4AqqkCUZUFP+OrAGW5JoBud6vDD7D9k3FWI6F+Zf+DJkTGzoJ0OlVl7gZMmAC
	9ToL70P/DONFpXr9gmqQ+jHvhdIEdc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773510736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ojej/sUCpOz+E4rO877kHndCUA16+Ful5u0xuu3gjw=;
	b=Xpq1NMNckX3r9K48TuuYITg7udfxA5Z2A3ug31glcT1qfg5apdFQ1GLDhUWWIPek038Goo
	Aowr7xNT+xj74nAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="mbeSQ/eU";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=miCoIsaP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773510735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ojej/sUCpOz+E4rO877kHndCUA16+Ful5u0xuu3gjw=;
	b=mbeSQ/eUME/EmcP3F/viuyOR9lKW7vSAq9vU9d19OxF1QnnExkwfehAsLvRgFVdgYkN5rF
	lPv4f2akG9TI83uYtPnOY4ls3+TgdWPvoRXLsmkby0HP6E2txWzK6a0CO5Z/mBWKVoWV07
	VOQnfOxoGqVeXXgfXmDie7TCrUDXafM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773510735;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ojej/sUCpOz+E4rO877kHndCUA16+Ful5u0xuu3gjw=;
	b=miCoIsaP3Fvg/G+7aKaVQk9NR74KYnhyMv+sHmdj0C2B0ACViiuF9BAKBbcsW9dnkOwqZi
	ALbHDrzqoKxWgKBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7409542724;
	Sat, 14 Mar 2026 17:52:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4NDMGE+gtWlfCQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 14 Mar 2026 17:52:15 +0000
Message-ID: <40ccd028-af31-4e8d-9c83-209fab888cdd@suse.de>
Date: Sat, 14 Mar 2026 18:52:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] ipv4: bump rt_genid when a relevant devconf value
 changes through netlink
To: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, tgraf@infradead.org, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net
References: <20260313144555.4956-1-fmancera@suse.de>
 <1644761b-4960-431f-bf3d-5593007212fc@kernel.org>
 <633f5de1-daeb-48ac-aba1-92b3c3ccf5c8@suse.de>
 <20260314090614.116f38cc@kernel.org>
 <41885d77-2509-445c-af01-0b1e556703ec@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <41885d77-2509-445c-af01-0b1e556703ec@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267812-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52E0C28E521
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/14/26 5:16 PM, David Ahern wrote:
> On 3/14/26 10:06 AM, Jakub Kicinski wrote:
>> On Fri, 13 Mar 2026 16:13:20 +0100 Fernando Fernandez Mancera wrote:
>>>> Also, you are flushing the cache for more values than sysfs does.
>>>
>>> I don't think so. The problem is that the handling of sysctl is
>>> scattered in several places.
>>>
>>> IPV4_DEVCONF_FORWARDING is flushed at devinet_sysctl_forward().
>>>
>>> IPV4_DEVCONF_NOXFRM, IPV4_DEVCONF_NOPOLICY,
>>> IPV4_DEVCONF_PROMOTE_SECONDARIES, IPV4_DEVCONF_ROUTE_LOCALNET, and
>>> IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST are flushed at
>>> ipv4_doint_and_flush() used by macro DEVINET_SYSCTL_FLUSHING_ENTRY.
>>>
>>> Finally, IPV4_DEVCONF_BC_FORWARDING and IPV4_DEVCONF_ACCEPT_LOCAL are
>>> flushed at devinet_conf_proc().
>>>
>>> Yes, I know, the fact that they are scattered around is quite confusing.
>>> This could be all unified in a single place but that would be too much
>>> for net tree IMHO.
>>>
>>> Please let me know if I am missing something.
>>
>> I think David means that for some knobs procfs only flushes when value
>> changes "in one direct", eg
>>
>>                  if (i == IPV4_DEVCONF_ACCEPT_LOCAL - 1 ||
>>                      i == IPV4_DEVCONF_ROUTE_LOCALNET - 1)
>>                          if ((new_value == 0) && (old_value != 0))
>>                                  rt_cache_flush(net);
>>
>> which means only flush on the 1 -> 0 transition.
> 
> logic subtleties like this example is why I was asking about a proper
> refactor.
> 
> since this bug has been around for years, why worry about a patch for
> -net and the back propagation to stable releases that will follow?
> 

I don't mind re-routing this net-next and put it together with a 
re-work. I will drop the fixes tag in such case. Is that fine for you Jakub?

Thanks,
Fernando.

