Return-Path: <netdev+bounces-260860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDqSJCDJnmm0XQQAu9opvQ
	(envelope-from <netdev+bounces-260860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:04:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C41D2195768
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B69023007A74
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DFA38E5F7;
	Wed, 25 Feb 2026 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bY9jJ7Cc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FIXe/zs/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kuto3dG5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8X6DC6sq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D692A38F25D
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013788; cv=none; b=tVfuOp6QJaDmlBr0+YaUKywsxqCAsbUYExGTC4DH9npP7eXxIXRZnSo03rQ2A16RV4Ct90pZVxXagntInSDyrY8ZIbpv4ttVsolBvlc69gv0Hm70AYIP9+4NSJXYoqM0mEmbPqWGHXarHIB9jOs56kMRaiQoYMlDQcL0CEb//Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013788; c=relaxed/simple;
	bh=m6B9jhZ+B0oMB2+Ycjj3lO7A0wNXCx7dGZotLgXREr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fpmja5CEkfgYSuAIKOd3fe5RpprmW2WL7J4oVeXYwmAn1FvYzfsS70vU/hwxrLZYhXnO4fB0NGDFNFUqLBs175RaYW8uXQ2Qf3QEqk50GzgUU9giKcLro+4/gRXCeYRN67Ucvkkv4hsFTRfg31rzxVGandHFae+smEiFhTgmWAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bY9jJ7Cc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FIXe/zs/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kuto3dG5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8X6DC6sq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 19AF75BD50;
	Wed, 25 Feb 2026 10:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772013785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhtVnzPxAUjTmMJ3BEWMtQwHsrUk9NlVIiFobRqyYuc=;
	b=bY9jJ7CcuUnWZcf8RSfO5rKHMDBkMTmsBCHpNa0Qvh5H3m5EHpKg1ooYDY1pzeZjYyUM3z
	FVMn+EXle0IB+3kt8IVySv0lYHEio9lFmIREHkrqr82ZKgdfDpwtv0x9UHEN1xmrUuOHjq
	vDc3MCywlLduEWJ9UGKUHtoOyHS01Z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772013785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhtVnzPxAUjTmMJ3BEWMtQwHsrUk9NlVIiFobRqyYuc=;
	b=FIXe/zs/EAIPY+8kNaiwGkZldVd/UwHB2dJOp//vfxBCeBpshTE+8mfem49XZdBcin1oUc
	ZUzZXWng/ipe4iDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772013784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhtVnzPxAUjTmMJ3BEWMtQwHsrUk9NlVIiFobRqyYuc=;
	b=Kuto3dG5+tzwpYw8k9/FszymJeXruy4E9DFXkgVanZaGMDn1mqBGuXkibCNGp53WBjSPvi
	Dd1QXgY517juOutvufuPAdKYrQimKSybxjRZRrN+bRkAi6UWamLWWh8lpHNL7Q0XjVGJuH
	77cck8bVEp6/2t93EWhkqCnvqDseg3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772013784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhtVnzPxAUjTmMJ3BEWMtQwHsrUk9NlVIiFobRqyYuc=;
	b=8X6DC6sqXflIr50LcsdzT9t8ROmNH+ZsKVqROZx8MedyKHZQaopo7nj91qXa14T82JqU1Z
	DsnN20yHjpn+rtCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E18CA3EA65;
	Wed, 25 Feb 2026 10:03:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oNySMtXInmn7PQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 25 Feb 2026 10:03:01 +0000
Message-ID: <0e4c862e-cde4-4fa6-b9fa-3667429abf29@suse.de>
Date: Wed, 25 Feb 2026 11:02:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] inet: add ip_local_port_step_width sysctl to
 improve port usage distribution
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ij@kernel.org,
 chia-yu.chang@nokia-bell-labs.com, idosch@nvidia.com, willemb@google.com,
 dsahern@kernel.org, ncardwell@google.com, corbet@lwn.net, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net
References: <20260224150537.3800-1-fmancera@suse.de>
 <CAAVpQUAiCu3dJ56Le3_SSR2qg-+kKP3-HC09BRuVwbswEH=5kw@mail.gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <CAAVpQUAiCu3dJ56Le3_SSR2qg-+kKP3-HC09BRuVwbswEH=5kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-260860-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0xffsoftware.com:url,suse.de:mid,suse.de:dkim,suse.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C41D2195768
X-Rspamd-Action: no action

On 2/25/26 7:28 AM, Kuniyuki Iwashima wrote:
> On Tue, Feb 24, 2026 at 7:05 AM Fernando Fernandez Mancera
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
>>   Documentation/networking/ip-sysctl.rst        |  9 ++++++++
>>   .../net_cachelines/netns_ipv4_sysctl.rst      |  1 +
>>   include/net/netns/ipv4.h                      |  1 +
>>   net/ipv4/inet_hashtables.c                    | 22 ++++++++++++++++---
>>   net/ipv4/sysctl_net_ipv4.c                    |  7 ++++++
>>   5 files changed, 37 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
>> index 6921d8594b84..9e2625ee778c 100644
>> --- a/Documentation/networking/ip-sysctl.rst
>> +++ b/Documentation/networking/ip-sysctl.rst
>> @@ -1612,6 +1612,15 @@ ip_local_reserved_ports - list of comma separated ranges
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
>> +        Default: 0 (disabled)
>> +
>>   ip_unprivileged_port_start - INTEGER
>>          This is a per-namespace sysctl.  It defines the first
>>          unprivileged port in the network namespace.  Privileged ports
>> diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
>> index beaf1880a19b..c0e194a6e4ee 100644
>> --- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
>> +++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
>> @@ -47,6 +47,7 @@ u8                              sysctl_tcp_ecn
>>   u8                              sysctl_tcp_ecn_fallback
>>   u8                              sysctl_ip_default_ttl                                                                ip4_dst_hoplimit/ip_select_ttl
>>   u8                              sysctl_ip_no_pmtu_disc
>> +u32                             sysctl_ip_local_port_step_width
>>   u8                              sysctl_ip_fwd_use_pmtu                       read_mostly                             ip_dst_mtu_maybe_forward/ip_skb_dst_mtu
>>   u8                              sysctl_ip_fwd_update_priority                                                        ip_forward
>>   u8                              sysctl_ip_nonlocal_bind
>> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
>> index 8e971c7bf164..fb7c2235af21 100644
>> --- a/include/net/netns/ipv4.h
>> +++ b/include/net/netns/ipv4.h
>> @@ -166,6 +166,7 @@ struct netns_ipv4 {
>>          u8 sysctl_ip_autobind_reuse;
>>          /* Shall we try to damage output packets if routing dev changes? */
>>          u8 sysctl_ip_dynaddr;
>> +       u32 sysctl_ip_local_port_step_width;
>>   #ifdef CONFIG_NET_L3_MASTER_DEV
>>          u8 sysctl_raw_l3mdev_accept;
>>   #endif
>> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
>> index f5826ec4bcaa..1992dc21818f 100644
>> --- a/net/ipv4/inet_hashtables.c
>> +++ b/net/ipv4/inet_hashtables.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/wait.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/memblock.h>
>> +#include <linux/gcd.h>
>>
>>   #include <net/addrconf.h>
>>   #include <net/inet_connection_sock.h>
>> @@ -1046,12 +1047,12 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
>>          struct net *net = sock_net(sk);
>>          struct inet_bind2_bucket *tb2;
>>          struct inet_bind_bucket *tb;
>> +       int step, scan_step, l3mdev;
>> +       u32 index, max_rand_step;
>>          bool tb_created = false;
>>          u32 remaining, offset;
>>          int ret, i, low, high;
>>          bool local_ports;
>> -       int step, l3mdev;
>> -       u32 index;
>>
>>          if (port) {
>>                  local_bh_disable();
>> @@ -1065,6 +1066,8 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
>>
>>          local_ports = inet_sk_get_local_port_range(sk, &low, &high);
>>          step = local_ports ? 1 : 2;
>> +       scan_step = step;
>> +       max_rand_step = READ_ONCE(net->ipv4.sysctl_ip_local_port_step_width);
>>
>>          high++; /* [32768, 60999] -> [32768, 61000[ */
>>          remaining = high - low;
>> @@ -1083,9 +1086,22 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
>>           */
>>          if (!local_ports)
>>                  offset &= ~1U;
>> +
>> +       if (max_rand_step && remaining > 1) {
>> +               u32 range = (step == 1) ? remaining : (remaining / 2);
>> +               u32 upper_bound = min(range, max_rand_step);
>> +
>> +               scan_step = get_random_u32_inclusive(1, upper_bound);
>> +               while (gcd(scan_step, range) != 1) {
>> +                       scan_step++;
> 
> If both scan_step and range are even, an extra
> increment here saves 1/2 calls of gcd().
> 

Ah right, thanks!

> 
>> +                       if (unlikely(scan_step > upper_bound))
>> +                               scan_step = 1;
>> +               }
>> +               scan_step *= step;
>> +       }
>>   other_parity_scan:
> 
> Doing "other_parity_scan" will be just redundant
> unless scan_step is 2 ?
> 

I have tried to preserve the parity behavior. Maybe I missed something, 
let me explain why it isn't redundant in my opinion.

In essence, when calculating the range we first look at "step". If step 
== 1 we use all the remaining ports as range, otherwise we use remaining/2.

If step == 1 we do not care about parity so let's look at step == 2.

If step == 2, we calculate a step_scan that is coprime with remaining/2. 
Once we have it, we multiply it by 2 so we make sure scan_step is even.

Then it works exactly like with the current algorithm, we look for the 
even ports first, everytime we reach the high we subtract the size of 
the range (remaining is actually a bad name IMHO) and continue. When i 
 >= remaining (keep on mind that i is incresed by step, that is by 2 on 
each iteration), we start again for the odd numbers.

They key piece is that step_scan/2 is coprime with remaining/2. As long 
as that holds, we should visit first all the even numbers and then the 
odd ones.

Thanks,
Fernando.

> 
>>          port = low + offset;
>> -       for (i = 0; i < remaining; i += step, port += step) {
>> +       for (i = 0; i < remaining; i += step, port += scan_step) {
>>                  if (unlikely(port >= high))
>>                          port -= remaining;
>>                  if (inet_is_local_reserved_port(net, port))
>> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
>> index 643763bc2142..c533374f656c 100644
>> --- a/net/ipv4/sysctl_net_ipv4.c
>> +++ b/net/ipv4/sysctl_net_ipv4.c
>> @@ -822,6 +822,13 @@ static struct ctl_table ipv4_net_table[] = {
>>                  .mode           = 0644,
>>                  .proc_handler   = ipv4_local_port_range,
>>          },
>> +       {
>> +               .procname       = "ip_local_port_step_width",
>> +               .maxlen         = sizeof(u32),
>> +               .data           = &init_net.ipv4.sysctl_ip_local_port_step_width,
>> +               .mode           = 0644,
>> +               .proc_handler   = proc_douintvec,
>> +       },
>>          {
>>                  .procname       = "ip_local_reserved_ports",
>>                  .data           = &init_net.ipv4.sysctl_local_reserved_ports,
>> --
>> 2.53.0
>>


