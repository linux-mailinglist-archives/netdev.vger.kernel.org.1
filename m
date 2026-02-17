Return-Path: <netdev+bounces-259107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAc2NH6flGknGAIAu9opvQ
	(envelope-from <netdev+bounces-259107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:03:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A29BA14E7B6
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9EA53013241
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016BD36EA9A;
	Tue, 17 Feb 2026 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="axUI0CJi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gC+HWe5M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="axUI0CJi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gC+HWe5M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D6732C317
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771347833; cv=none; b=E4JBAIOfVhgol9uwMCB/y/RWZSt/ZifKgdv4eNmA3XVv1Wy8Zp8Z/HkHaTmcSmr2REOItpXXtnmq8WNUD4Reaqhk3Di2BkfwlI/oeYcp2sPvRh9Q1wkeQQpDZ+l9NMudlGrtd6PGd/61VXiyfPnQlVrMeZkq8Ft66jU8i8fnFgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771347833; c=relaxed/simple;
	bh=pRkfR+MtwUPXUF+P7bP+yiOS109cZPL3NtXRCXjfOJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFKAQGy1kZB1Q67oaDJAEL9jlqUdzx543PLWLlGzx4EHezEvTXl5wLb+XUZU6Tc0FSlavmzms+oKVV9NVHLq75WFtmloqov5WnEtLdStD4hP4RvbBWSjqgzHaSUsbaOuYsjbLNCLB5kocwLnbft4NNbFSYIYLkG7jPbt/749T80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=axUI0CJi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gC+HWe5M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=axUI0CJi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gC+HWe5M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DBE375BCC5;
	Tue, 17 Feb 2026 17:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771347829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KhEC8g0X3bDk/XhzszdS+f6qFyDl/+jysNx5df0oMy0=;
	b=axUI0CJiojv1DF1arfiJZ28FdaDRHQBygm0sjN6Zst/aLcr6p0Sskq8Ud2bLvBCiqp8ePd
	0PrCe8mKB5RoOkjEgq0PreAsnfApWmwjgCgaSqYOyNmgMC4y5o22KoCqnN9Q4nbm7k+i/c
	a507cExlHuon96tBH9E2mRl1FOXc6Ic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771347829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KhEC8g0X3bDk/XhzszdS+f6qFyDl/+jysNx5df0oMy0=;
	b=gC+HWe5MHCxo1vBI5ZHu5JGDnXEht2Jxkmgd/SAs2ZiZsFYBfr1sQ9nk89oBAm+J4Jdg5z
	TBwxDuod8WymOlAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771347829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KhEC8g0X3bDk/XhzszdS+f6qFyDl/+jysNx5df0oMy0=;
	b=axUI0CJiojv1DF1arfiJZ28FdaDRHQBygm0sjN6Zst/aLcr6p0Sskq8Ud2bLvBCiqp8ePd
	0PrCe8mKB5RoOkjEgq0PreAsnfApWmwjgCgaSqYOyNmgMC4y5o22KoCqnN9Q4nbm7k+i/c
	a507cExlHuon96tBH9E2mRl1FOXc6Ic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771347829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KhEC8g0X3bDk/XhzszdS+f6qFyDl/+jysNx5df0oMy0=;
	b=gC+HWe5MHCxo1vBI5ZHu5JGDnXEht2Jxkmgd/SAs2ZiZsFYBfr1sQ9nk89oBAm+J4Jdg5z
	TBwxDuod8WymOlAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 399413EA65;
	Tue, 17 Feb 2026 17:03:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9FMGC3WflGlkfwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 17 Feb 2026 17:03:49 +0000
Message-ID: <1c5ce96c-3b01-44e0-8dc9-5c54e504cb95@suse.de>
Date: Tue, 17 Feb 2026 18:03:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] possible deadlock in inet6_getname
To: Gerd Rausch <gerd.rausch@oracle.com>, Eric Dumazet <edumazet@google.com>,
 syzbot <syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, horms@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com
References: <698f15e6.a70a0220.2c38d7.00c1.GAE@google.com>
 <CANn89i+mVCLW2g1+tnbK8k9E0AkEuX7AZ+2LbO1_s2L=Gxaaeg@mail.gmail.com>
 <50e88063-14fb-4912-a65d-172a85def1ee@oracle.com>
 <c57f2565-a6b2-45dd-8307-871a02ae1a7a@suse.de>
 <db06aa20-ca31-4b66-9a53-e4305974d1f5@oracle.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <db06aa20-ca31-4b66-9a53-e4305974d1f5@oracle.com>
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
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259107-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,5efae91f60932839f0a5];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: A29BA14E7B6
X-Rspamd-Action: no action



On 2/17/26 5:59 PM, Gerd Rausch wrote:
> Hi,
> 
> On 2026-02-14 10:25, Fernando Fernandez Mancera wrote:
>> --- a/net/rds/tcp_listen.c
>> +++ b/net/rds/tcp_listen.c
>> @@ -59,30 +59,12 @@ void rds_tcp_keepalive(struct socket *sock)
>>   static int
>>   rds_tcp_get_peer_sport(struct socket *sock)
>>   {
>> -    union {
> [...]
>> -    } else {
>> -        sport = -1;
>> -    }
>> +    struct sock *sk = sock->sk;
>> +
>> +    if (!sk)
>> +        return -1;
>>
>> -    return sport;
>> +    return ntohs(inet_sk(sk)->inet_dport);
>>   }
>>
>> It would be safe from rds_tcp_accept_one() path as the new_sock has a 
>> reference count of 1 and no other component should be to release it.
>>
>> In rds_tcp_conn_slots_available() path, fan-out can be only performed 
>> from receive path, AFAIU if data is being processed from the socket we 
>> should always be holding a lock.
>>
>> If these premises are not correct, we can always make this 
>> conditional. But getting rid of the kernel_getpeername() call is 
>> performance-wise too.
>>
> 
> rds_tcp_conn_slots_available() can also be called from rds_conn_shutdown(),
> where no "rds_tcp.ko" backend specific lock is held.
> 


AFAICS, from rds_conn_shutdown() path rds_tcp_conn_slots_available() is 
called with fan-out argument as false. Therefore, no need to get the 
peer source port.

I think that should be fine.

> This is very solvable though.
> 
> Worst case, we can distinguish between the paths where a lock_sock()
> is already held from those that don't.
>
>> I am testing this against the syzbot report/reproducer.
>>
> 
> Thanks,
> 
>    Gerd
> 


