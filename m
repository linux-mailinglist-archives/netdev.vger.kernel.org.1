Return-Path: <netdev+bounces-271735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKqzC95FxGm1xwQAu9opvQ
	(envelope-from <netdev+bounces-271735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:30:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D54932BD95
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78BAE3027DA4
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60E2374178;
	Wed, 25 Mar 2026 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="den2DBAl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UVfUYkjL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="den2DBAl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UVfUYkjL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12855372EE4
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470619; cv=none; b=Y/t1uWJoIt4iIV1L4/LsyGxVgOd/qPpQvnYdHeage9pAQmHGIMsnRIaJvHgGPkvO+9K746kOQpAGz75Z7tqSwZzINTl+sonki84x798Wsxc18+a8jfn5zn3Q5ft7RCErBaoqaCNQdZfdn0yfzhOFKyMFjsmGvB332MOlVIfFdic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470619; c=relaxed/simple;
	bh=bLK+bZrGzerzT2y9ix2a41M84n3ZdNFH5Dcg0EpWSNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWrnyCgDaGn9Z5HGZ9kF8OQrpCLF2tPKh7SPY2T//nAP18Q9kTSU0caznUNxPtGj1WDmDHQA3mlnqWvXHDtXUVUTGxJ9/N8W8YfGqhVCFX6gRmF8LDGHoqRlflrI9jXy1s3+WUrAWi1lH+cW4KgHB0kFM/6E34+gt7KtUGRoxHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=den2DBAl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UVfUYkjL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=den2DBAl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UVfUYkjL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 246ED4D264;
	Wed, 25 Mar 2026 20:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774470615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4I0IoeQLAHGx9OlKsvVusSFa74seihJAfLxZEge8Tc=;
	b=den2DBAlMWeq/YF1KnRfJgcOB03dPFsggrNKaFWBC74RK+wZVcq65HNrNNsGShYzeaM2o3
	ItPKT3WPPF0PJ0g0G4IkVgbKQ3SQHJg5KqKQq8OxFXkM4L2UoGjVdkNxFTj4jbgUMEkjOK
	JGB6JmuMk9HvM7JY4/MTOcZzS8/L+Bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774470615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4I0IoeQLAHGx9OlKsvVusSFa74seihJAfLxZEge8Tc=;
	b=UVfUYkjLqRDHBgv6oHO+GjC4ZNEhLp9TjHna+4l10u2mTasFhVj7uJa5USqKsXPet70aMS
	LhANdzHrCwLVKwCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=den2DBAl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UVfUYkjL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774470615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4I0IoeQLAHGx9OlKsvVusSFa74seihJAfLxZEge8Tc=;
	b=den2DBAlMWeq/YF1KnRfJgcOB03dPFsggrNKaFWBC74RK+wZVcq65HNrNNsGShYzeaM2o3
	ItPKT3WPPF0PJ0g0G4IkVgbKQ3SQHJg5KqKQq8OxFXkM4L2UoGjVdkNxFTj4jbgUMEkjOK
	JGB6JmuMk9HvM7JY4/MTOcZzS8/L+Bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774470615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4I0IoeQLAHGx9OlKsvVusSFa74seihJAfLxZEge8Tc=;
	b=UVfUYkjLqRDHBgv6oHO+GjC4ZNEhLp9TjHna+4l10u2mTasFhVj7uJa5USqKsXPet70aMS
	LhANdzHrCwLVKwCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A11DD4A0A2;
	Wed, 25 Mar 2026 20:30:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bjldI9VFxGmNOQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 25 Mar 2026 20:30:13 +0000
Message-ID: <99c37135-a1cc-4eb9-a910-ca38e129b5b0@suse.de>
Date: Wed, 25 Mar 2026 21:29:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11 net-next v5] bpf: remove ipv6_bpf_stub completely
 and use direct function calls
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Guillaume Nault <gnault@redhat.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20260325120928.15848-1-fmancera@suse.de>
 <20260325120928.15848-10-fmancera@suse.de>
 <1ff47530-44ee-4012-a013-0202182de208@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <1ff47530-44ee-4012-a013-0202182de208@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,iogearbox.net,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,linux.dev,fomichev.me,nvidia.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-271735-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9D54932BD95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 8:11 PM, Martin KaFai Lau wrote:
> On 3/25/26 5:08 AM, Fernando Fernandez Mancera wrote:
>> As IPv6 is built-in only, the ipv6_bpf_stub can be removed completely.
>>
>> Convert all ipv6_bpf_stub usage to direct function calls instead. The
>> fallback functions introduced previously will prevent linkage errors
>> when CONFIG_IPV6 is disabled.
> 
> Thanks for working on this.
> 
>> @@ -6221,8 +6215,8 @@ static int bpf_ipv4_fib_lookup(struct net *net, 
>> struct bpf_fib_lookup *params,
>>       if (likely(nhc->nhc_gw_family != AF_INET6))
>>           neigh = __ipv4_neigh_lookup_noref(dev,
>>                             (__force u32)params->ipv4_dst);
>> -    else
>> -        neigh = __ipv6_neigh_lookup_noref_stub(dev, params->ipv6_dst);
>> +    else if (IS_ENABLED(CONFIG_IPV6))
>> +        neigh = __ipv6_neigh_lookup_noref(dev, params->ipv6_dst);
> 
> Should it be ipv6_mod_enabled() instead of IS_ENABLED(CONFIG_IPV6)?
> Is nd_tbl always initialized?
> 

Hi Martin,

I don't think so. The IS_ENABLED(CONFIG_IPV6) check here is just to 
prevent an undefined reference when compiling with CONFIG_IPV6=n. Note 
that this code isn't reachable when ipv6.disable=1 is set during 
booting, as it would have crashed even before this change because 
ipv6_stub->nd_tbl is NULL if the IPV6 is disabled since booting.

We addressed the vulnerable paths already during this series:

https://lore.kernel.org/netdev/20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com/#

>>       if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
>>           return BPF_FIB_LKUP_RET_NO_NEIGH;
>> @@ -6290,12 +6284,11 @@ static int bpf_ipv6_fib_lookup(struct net 
>> *net, struct bpf_fib_lookup *params,
>>               params->tbid = 0;
>>           }
>> -        tb = ipv6_stub->fib6_get_table(net, tbid);
>> +        tb = fib6_get_table(net, tbid);
>>           if (unlikely(!tb))
>>               return BPF_FIB_LKUP_RET_NOT_FWDED;
>> -        err = ipv6_stub->fib6_table_lookup(net, tb, oif, &fl6, &res,
>> -                           strict);
>> +        err = fib6_table_lookup(net, tb, oif, &fl6, &res, strict);
> 
> A similar question here and other changes in the patch.
> 
> I think bpf_ipv6_fib_lookup() is fine because the earlier
> "!idev" check should fail when ipv6 is disabled at boot time?

Yes, the !idev check prevents us to reach this path so it is safe to 
call fib6_table_lookup().

While working on the series I have been trying to exploit these paths 
(this one and other changes in the series), so far I didn't find anything.

Thanks for the review!
Fernando.

> 
>>       } else {
>>           if (flags & BPF_FIB_LOOKUP_MARK)
>>               fl6.flowi6_mark = params->mark;
>> @@ -6305,7 +6298,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, 
>> struct bpf_fib_lookup *params,
>>           fl6.flowi6_tun_key.tun_id = 0;
>>           fl6.flowi6_uid = sock_net_uid(net, NULL);
>> -        err = ipv6_stub->fib6_lookup(net, oif, &fl6, &res, strict);
>> +        err = fib6_lookup(net, oif, &fl6, &res, strict);
>>       }
>>       if (unlikely(err || IS_ERR_OR_NULL(res.f6i) ||
>> @@ -6326,11 +6319,11 @@ static int bpf_ipv6_fib_lookup(struct net 
>> *net, struct bpf_fib_lookup *params,
>>           return BPF_FIB_LKUP_RET_NOT_FWDED;
>>       }
>> -    ipv6_stub->fib6_select_path(net, &res, &fl6, fl6.flowi6_oif,
>> -                    fl6.flowi6_oif != 0, NULL, strict);
>> +    fib6_select_path(net, &res, &fl6, fl6.flowi6_oif,
>> +             fl6.flowi6_oif != 0, NULL, strict);
>>       if (check_mtu) {
>> -        mtu = ipv6_stub->ip6_mtu_from_fib6(&res, dst, src);
>> +        mtu = ip6_mtu_from_fib6(&res, dst, src);
>>           if (params->tot_len > mtu) {
>>               params->mtu_result = mtu; /* union with tot_len */
>>               return BPF_FIB_LKUP_RET_FRAG_NEEDED;
>> @@ -6351,9 +6344,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, 
>> struct bpf_fib_lookup *params,
>>           if (res.f6i->fib6_prefsrc.plen) {
>>               *src = res.f6i->fib6_prefsrc.addr;
>>           } else {
>> -            err = ipv6_bpf_stub->ipv6_dev_get_saddr(net, dev,
>> -                                &fl6.daddr, 0,
>> -                                src);
>> +            err = ipv6_dev_get_saddr(net, dev, &fl6.daddr, 0, src);
>>               if (err)
>>                   return BPF_FIB_LKUP_RET_NO_SRC_ADDR;
>>           }
>> @@ -6365,7 +6356,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, 
>> struct bpf_fib_lookup *params,
>>       /* xdp and cls_bpf programs are run in RCU-bh so 
>> rcu_read_lock_bh is
>>        * not needed here.
>>        */
>> -    neigh = __ipv6_neigh_lookup_noref_stub(dev, dst);
>> +    neigh = __ipv6_neigh_lookup_noref(dev, dst);
>>       if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
>>           return BPF_FIB_LKUP_RET_NO_NEIGH;
>>       memcpy(params->dmac, neigh->ha, ETH_ALEN);
>> @@ -6900,11 +6891,10 @@ static struct sock *sk_lookup(struct net *net, 
>> struct bpf_sock_tuple *tuple,
>>                           src6, tuple->ipv6.sport,
>>                           dst6, ntohs(tuple->ipv6.dport),
>>                           dif, sdif, &refcounted);
>> -        else if (likely(ipv6_bpf_stub))
>> -            sk = ipv6_bpf_stub->udp6_lib_lookup(net,
>> -                                src6, tuple->ipv6.sport,
>> -                                dst6, tuple->ipv6.dport,
>> -                                dif, sdif, NULL);
>> +        else if (likely(ipv6_mod_enabled()))
>> +            sk = __udp6_lib_lookup(net, src6, tuple->ipv6.sport,
>> +                           dst6, tuple->ipv6.dport,
>> +                           dif, sdif, NULL);
>>   #endif
>>       }
>> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
>> index 9f40be0c3e71..f71ef82a5f3d 100644
>> --- a/net/core/lwt_bpf.c
>> +++ b/net/core/lwt_bpf.c
>> @@ -13,7 +13,6 @@
>>   #include <net/gre.h>
>>   #include <net/ip.h>
>>   #include <net/ip6_route.h>
>> -#include <net/ipv6_stubs.h>
>>   struct bpf_lwt_prog {
>>       struct bpf_prog *prog;
>> @@ -103,7 +102,12 @@ static int bpf_lwt_input_reroute(struct sk_buff 
>> *skb)
>>           dev_put(dev);
>>       } else if (skb->protocol == htons(ETH_P_IPV6)) {
>>           skb_dst_drop(skb);
>> -        err = ipv6_stub->ipv6_route_input(skb);
>> +        if (IS_ENABLED(CONFIG_IPV6)) {
>> +            ip6_route_input(skb);
>> +            err = skb_dst(skb)->error;
>> +        } else {
>> +            err = -EAFNOSUPPORT;
>> +        }
>>       } else {
>>           err = -EAFNOSUPPORT;
>>       }
>> @@ -233,7 +237,7 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
>>           fl6.daddr = iph6->daddr;
>>           fl6.saddr = iph6->saddr;
>> -        dst = ipv6_stub->ipv6_dst_lookup_flow(net, skb->sk, &fl6, NULL);
>> +        dst = ip6_dst_lookup_flow(net, skb->sk, &fl6, NULL);
>>           if (IS_ERR(dst)) {
>>               err = PTR_ERR(dst);
>>               goto err;
>> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
>> index bb29b29fdcfb..07ae6ea7743a 100644
>> --- a/net/ipv6/af_inet6.c
>> +++ b/net/ipv6/af_inet6.c
>> @@ -264,8 +264,8 @@ static int inet6_create(struct net *net, struct 
>> socket *sock, int protocol,
>>       goto out;
>>   }
>> -static int __inet6_bind(struct sock *sk, struct sockaddr_unsized 
>> *uaddr, int addr_len,
>> -            u32 flags)
>> +int __inet6_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int 
>> addr_len,
>> +         u32 flags)
>>   {
>>       struct sockaddr_in6 *addr = (struct sockaddr_in6 *)uaddr;
>>       struct inet_sock *inet = inet_sk(sk);
>> @@ -1032,14 +1032,6 @@ static const struct ipv6_stub ipv6_stub_impl = {
>>       .ip6_xmit = ip6_xmit,
>>   };
>> -static const struct ipv6_bpf_stub ipv6_bpf_stub_impl = {
>> -    .inet6_bind = __inet6_bind,
>> -    .udp6_lib_lookup = __udp6_lib_lookup,
>> -    .ipv6_setsockopt = do_ipv6_setsockopt,
>> -    .ipv6_getsockopt = do_ipv6_getsockopt,
>> -    .ipv6_dev_get_saddr = ipv6_dev_get_saddr,
>> -};
>> -
>>   static int __init inet6_init(void)
>>   {
>>       struct list_head *r;
>> @@ -1199,7 +1191,6 @@ static int __init inet6_init(void)
>>       /* ensure that ipv6 stubs are visible only after ipv6 is ready */
>>       wmb();
>>       ipv6_stub = &ipv6_stub_impl;
>> -    ipv6_bpf_stub = &ipv6_bpf_stub_impl;
>>   out:
>>       return err;
> 


