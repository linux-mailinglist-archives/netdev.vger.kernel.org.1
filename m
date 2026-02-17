Return-Path: <netdev+bounces-259141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ08Bz7PlGlGIAIAu9opvQ
	(envelope-from <netdev+bounces-259141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 21:27:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7620214FF65
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 21:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A69F30086D8
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 20:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8985C330311;
	Tue, 17 Feb 2026 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0Nm6HDb1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PtyNL1Yc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0Nm6HDb1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PtyNL1Yc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5131A9F91
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 20:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771359997; cv=none; b=tvmJEFmPhimG/IU+9YB5xktlmngl/R2xZsGqXgVVpMv/uMfbRlL8yA9tHyWorMBYTFToNVvCsnLJuckOOtXzHE6iI4SEstV2FmjHBTCig1cekKzZHlgrtibvttPY0FavvmeEkzJsn1MuSESoYQvJnJNFxH5QychQnu+JHr/+87Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771359997; c=relaxed/simple;
	bh=srD6WOkQ94BgQVVeWT2K5qwtvkHAjtjmwb7CIVhlWdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5IjZwZkk3WL4DADQU1MtcoTIApU7cyQ1AdstrAQ8N/5OXg2N2tAzube4jOYepavA6EAcbUZfxtojnUmffF2WmY7gJR63wbRBV91G0nTkUVIfTkMagkNZgu3i+ZUMlklt1Lr6YzGHtA/22caGq4eBWS+gdVcWgsi1EnK0YYgHlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0Nm6HDb1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PtyNL1Yc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0Nm6HDb1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PtyNL1Yc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4A7655BCEB;
	Tue, 17 Feb 2026 20:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771359994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vK1h5Svw5aq5idzigSDQxU4eMvbeIsemOIltmqDzv7o=;
	b=0Nm6HDb1yZCpd34QKJKvlF7wIxNafD22n+4xRp0iSSvCwZie09i47NiMRxZxURhdRPIiHz
	lzRYnB5z6Co5XzWDsRadn7ijQWe/zy/pOuHAF67zGZxEauYlUIQ3ClSPaUU1rL3YXfjbco
	TsRHdmAq2/aIOuJxeQtkfv+vRzb3+TU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771359994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vK1h5Svw5aq5idzigSDQxU4eMvbeIsemOIltmqDzv7o=;
	b=PtyNL1YcwQaHnCbs2C2FpvEDVG+px34x43BQBvMhQS/xqQ+D+ne8RAT99WarW6mjW9oXAj
	0AJX7hGqHOXuHpAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771359994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vK1h5Svw5aq5idzigSDQxU4eMvbeIsemOIltmqDzv7o=;
	b=0Nm6HDb1yZCpd34QKJKvlF7wIxNafD22n+4xRp0iSSvCwZie09i47NiMRxZxURhdRPIiHz
	lzRYnB5z6Co5XzWDsRadn7ijQWe/zy/pOuHAF67zGZxEauYlUIQ3ClSPaUU1rL3YXfjbco
	TsRHdmAq2/aIOuJxeQtkfv+vRzb3+TU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771359994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vK1h5Svw5aq5idzigSDQxU4eMvbeIsemOIltmqDzv7o=;
	b=PtyNL1YcwQaHnCbs2C2FpvEDVG+px34x43BQBvMhQS/xqQ+D+ne8RAT99WarW6mjW9oXAj
	0AJX7hGqHOXuHpAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AD233EA65;
	Tue, 17 Feb 2026 20:26:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0YytGvnOlGmNUAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 17 Feb 2026 20:26:33 +0000
Message-ID: <da88f34d-8bfc-4517-aaf1-bfd0eca9c639@suse.de>
Date: Tue, 17 Feb 2026 21:26:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] possible deadlock in inet6_getname
To: Gerd Rausch <gerd.rausch@oracle.com>, Eric Dumazet <edumazet@google.com>,
 syzbot <syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com>,
 Allison Henderson <allison.henderson@oracle.com>
Cc: davem@davemloft.net, dsahern@kernel.org, horms@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com
References: <698f15e6.a70a0220.2c38d7.00c1.GAE@google.com>
 <CANn89i+mVCLW2g1+tnbK8k9E0AkEuX7AZ+2LbO1_s2L=Gxaaeg@mail.gmail.com>
 <50e88063-14fb-4912-a65d-172a85def1ee@oracle.com>
 <c57f2565-a6b2-45dd-8307-871a02ae1a7a@suse.de>
 <db06aa20-ca31-4b66-9a53-e4305974d1f5@oracle.com>
 <1c5ce96c-3b01-44e0-8dc9-5c54e504cb95@suse.de>
 <4cd4099b-328d-45eb-990d-793df79cd639@oracle.com>
 <2677c7cb-efb7-4f19-8000-4ed127f33847@suse.de>
 <4acdfdf8-a69c-4020-8a8c-2edccd482a6b@oracle.com>
 <6d46a465-0f1f-48a3-8b4d-da063f6c45f3@oracle.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <6d46a465-0f1f-48a3-8b4d-da063f6c45f3@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259141-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,5efae91f60932839f0a5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 7620214FF65
X-Rspamd-Action: no action

On 2/17/26 7:58 PM, Gerd Rausch wrote:
> Hi,
> 
> +Allison
> 
> On 2026-02-17 09:28, Gerd Rausch wrote:
>> On 2026-02-17 09:19, Fernando Fernandez Mancera wrote:
>>> On 2/17/26 6:13 PM, Gerd Rausch wrote:
>>>> If someone were to change the code to pass in "fan_out == true"
>>>> from a context not already holding a socket lock,
>>>> would they remember to change rds_tcp_conn_slots_available()
>>>> to acquire that lock?
>>>>
>>>
>>> Usually kernel requires the developer to understand when do they need 
>>> to acquire a lock or not.
>>> Anyway, what would you suggest? To check whether we have acquired the 
>>> lock or not and do it conditionally?> 
>>
>> Something along those lines.
>>
>> Either a "_locked" version of "conn_slots_available" function pointer,
>> a parameter, or a check.
>>
>> What you suggested is fine though for the immediate syzbot need.
>>
> 
> FWIW, in UEK (the modified Linux kernel that Oracle uses),
> this issue reported by syzbot was addressed differently:
> 
> https://github.com/oracle/linux-uek/commit/a94abc444c487
> 
> The commit under discussion here originally came from:
> https://github.com/oracle/linux-uek/commit/ebf71f5b6c29c
> 
> and pre-dates:
> 9dfc685e0262 ("inet: remove races in inet{6}_getname()")
> 
> which is why UEK didn't have this deadlock issue reported by syszbot.
> 
> If the objective is to keep divergence of UEK and Upstream to a minimum,
> it may be worthwhile to consider adopting the same fix we carry in UEK.
>

I see, I don't really have a strong opinion here. Although, the solution 
at UEK seems a bit overkill to me. As RDS do not really need all the 
information that inet_getname() provides. It just needs the source port 
and it can be used without acquiring the lock (because it was already done).

The ideal solution to me would be the patch proposed here [1] + a 
comment on the shutdown path to remember the developer that acquiring a 
lock is needed to enable fan-out. Having said that, I cannot tell if it 
would be better to keep divergence of UEK and Upstream or be more 
efficient. I am leaving this dilemma to you and Allison and any other 
maintainer that would like to chime in.

Just let me know so I can a send a v2 of my proposed patch with a more 
detailed commit message and also a comment on the mentioned path.

[1] https://lore.kernel.org/netdev/20260216120804.14840-1-fmancera@suse.de/

Thanks,
Fernando.

> Thanks,
> 
>    Gerd
> 
> 


