Return-Path: <netdev+bounces-263707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA9BD18BqGkRnQAAu9opvQ
	(envelope-from <netdev+bounces-263707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:54:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D121FDF2F
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5B7E302DF7A
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 09:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EB839EF3A;
	Wed,  4 Mar 2026 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SUl099d2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RbhjeCEB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SUl099d2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RbhjeCEB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F9F390205
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772618073; cv=none; b=Bv6SOBM6ALXmkOw/iOZ5fYOKSILGo3VN8aqp0Wc8zqvNXC4wD8Hi+7TXARbVte2iW8a7YHbfEA8fPFbzvnkwDvkE1Z+XyDJuZUdYzANBxkqNIdXWc/4IG07jP2pUzkR/dF/B+BgMj2/G8wpb5X5JGWQEImn1uGXT2p8Xd+bLZ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772618073; c=relaxed/simple;
	bh=S728nk8EoQpjrgV3+URW9SI+FEJ0ST1wDQyMuDgLiJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKfXdACbjfeB0x1IkmoOu4uKVwG59ZR4xm2Q2wA0E3lrojJVtrqvqODzh1yCBHUiJr+vUAYku7eMejJvahcBBAKaPI+xlOJxm4hC9xGzxhD6np8HhztqWWw338o0zAqEhz2gzjzoTCDJXuaxtyciee2oUg921a0N155BsRiQhzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SUl099d2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RbhjeCEB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SUl099d2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RbhjeCEB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A2653F6E5;
	Wed,  4 Mar 2026 09:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772618068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmYsk7hbwyI2Xvo8xd+DQ0fufVinD5TP56A7Ol+PJzE=;
	b=SUl099d2NWRIyGaVMbe+kBt5kDJFK4wiXPEYHoD1q02SvcJAJNQsTRuiVA7BqTJOv5P4Ys
	8BoaLS+N2lBAjKsUfXn17JUjmg7FpX1cxiwMEz0lICMh0zqIR2t0mBcIioYBMw3ePagwrX
	olQ9aoI7I2vs0Fo3nZsy392kBalaiLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772618068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmYsk7hbwyI2Xvo8xd+DQ0fufVinD5TP56A7Ol+PJzE=;
	b=RbhjeCEB5FeNihbNkwlKBQLc/gm6h4E7vZgilhoI8e+ZvyiTvXeGPf2MK/itK/XBhvKpc8
	ZHjey5kIZ8RKIIDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SUl099d2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RbhjeCEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772618068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmYsk7hbwyI2Xvo8xd+DQ0fufVinD5TP56A7Ol+PJzE=;
	b=SUl099d2NWRIyGaVMbe+kBt5kDJFK4wiXPEYHoD1q02SvcJAJNQsTRuiVA7BqTJOv5P4Ys
	8BoaLS+N2lBAjKsUfXn17JUjmg7FpX1cxiwMEz0lICMh0zqIR2t0mBcIioYBMw3ePagwrX
	olQ9aoI7I2vs0Fo3nZsy392kBalaiLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772618068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmYsk7hbwyI2Xvo8xd+DQ0fufVinD5TP56A7Ol+PJzE=;
	b=RbhjeCEB5FeNihbNkwlKBQLc/gm6h4E7vZgilhoI8e+ZvyiTvXeGPf2MK/itK/XBhvKpc8
	ZHjey5kIZ8RKIIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B19CD3EA69;
	Wed,  4 Mar 2026 09:54:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X21zKFMBqGkbZwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 04 Mar 2026 09:54:27 +0000
Message-ID: <aa36b48c-6184-46f3-bf6e-4750c2266f35@suse.de>
Date: Wed, 4 Mar 2026 10:54:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] inet: add ip_local_port_step_width sysctl to
 improve port usage distribution
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, chia-yu.chang@nokia-bell-labs.com,
 idosch@nvidia.com, willemb@google.com, dsahern@kernel.org,
 kuniyu@google.com, ncardwell@google.com, skhan@linuxfoundation.org,
 corbet@lwn.net, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net
References: <20260303172949.4741-1-fmancera@suse.de>
 <CANn89i+ntGv0gGYvRq8yziGTE01ozBJ_Mn_RDPXLgs+yU5whrg@mail.gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <CANn89i+ntGv0gGYvRq8yziGTE01ozBJ_Mn_RDPXLgs+yU5whrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: A2D121FDF2F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-263707-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/4/26 8:05 AM, Eric Dumazet wrote:
> On Tue, Mar 3, 2026 at 6:30 PM Fernando Fernandez Mancera
> <fmancera@suse.de> wrote:
>>
>> With the current port selection algorithm, ports after a reserved port
>> range or long time used port are used more often than others [1]. This
>> causes an uneven port usage distribution. This combines with cloud
>> environments blocking connections between the application server and the
>> database server if there was a previous connection with the same source
>> port, leading to connectivity problems between applications on cloud
>> environments.
>>
>> The real issue here is that these firewalls cannot cope with
>> standards-compliant port reuse. This is a workaround for such situations
>> and an improvement on the distribution of ports selected.
>>
>> The proposed solution is to implement a variant of RFC 6056 Algorithm 5.
>> The step size is selected randomly on every connect() call ensuring it
>> is a coprime with respect to the size of the range of ports we want to
>> scan. This way, we can ensure that all ports within the range are
>> scanned before returning an error. To enable this algorithm, the user
>> must configure the new sysctl option "net.ipv4.ip_local_port_step_width".
>>
>> In addition, on graphs generated we can observe that the distribution of
>> source ports is more even with the proposed approach. [2]
>>
>> [1] https://0xffsoftware.com/port_graph_current_alg.html
>>
>> [2] https://0xffsoftware.com/port_graph_random_step_alg.html
>>
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> ---
>> v2: used step to calculate remaining as (remaining / step) and avoid
>> calculating gcd when scan_step and range are both even
>> v3: xmas tree formatting and break the gdc() loop once scan_step is 1
>> ---
>>   Documentation/networking/ip-sysctl.rst        |  9 ++++++
>>   .../net_cachelines/netns_ipv4_sysctl.rst      |  1 +
>>   include/net/netns/ipv4.h                      |  1 +
>>   net/ipv4/inet_hashtables.c                    | 28 +++++++++++++++++--
>>   net/ipv4/sysctl_net_ipv4.c                    |  7 +++++
>>   5 files changed, 43 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
>> index 265158534cda..da29806700e9 100644
>> --- a/Documentation/networking/ip-sysctl.rst
>> +++ b/Documentation/networking/ip-sysctl.rst
>> @@ -1630,6 +1630,15 @@ ip_local_reserved_ports - list of comma separated ranges
>>
>>          Default: Empty
>>
>> +ip_local_port_step_width - INTEGER
>> +        Defines the numerical maximum increment between successive port
>> +        allocations within the ephemeral port range when an unavailable port is
>> +        reached. This can be used to mitigate accumulated nodes in port
>> +        distribution when reserved ports have been configured. Please note that
>> +        port collisions may be more frequent in a system with a very high load.
>> +
> 
> Patch SGTM, but I find this documentation obscure.
> 
> Some guidance would be nice. What values have you tested/tried ?
> 

As I am working on a patch series with improvements to ip-sysctl.rst 
documentation I will handle that there.

FTR; I tested multiple scenarios and numbers. If the value is >= the 
whole range, the issue is always mitigated but of course this will have 
a hit on performance under port exhaustion situation. The value that 
works better in my experience is 2x 3x or even 4x the size of the 
largest reserved block. If only a couple of ports are marked as 
reserved, 128 is usually enough to avoid clustering..

Thank you all for the reviews!

> Reviewed-by: Eric Dumazet <edumazet@google.com>


