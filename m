Return-Path: <netdev+bounces-281145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKlnLEDr7WlwowAAu9opvQ
	(envelope-from <netdev+bounces-281145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 12:38:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CE146967D
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 12:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F952300FB68
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 10:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25CD34B697;
	Sun, 26 Apr 2026 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="MrYsT2EO"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03440358387
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777199923; cv=none; b=M560wje5Wj1bzdthbzy2SVKl/Dh2NHPlS3F2vx8uHpaz6Ih7Ka+nuGERDRsikxQvklNO2Jns+Hqhu3jEKtcky1Vvi1P5kX6c8PVTGbWrJ5XrLa0rhmT9skoPURNN3aq39OqgkE9cPMja6FGp6MnE/GS56aDZgEmwSi4zx0mcxWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777199923; c=relaxed/simple;
	bh=gP6iOPaQJvKlXR1aM1ZwDMlod+80Dnr70iLBR8CCnBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzUK4uztdZeiEwrJe7p2UulRXS9hXJ32kO8swmbuR+e0t6jNZdJXKYyYG/B+TqfEShGYPdKg4g4ZSOVCmV1bjWFm95c3sVECVA8pgMbyosUhONQJbxAJM7vaYuSDtSIFNIv/rCSLW4g8OJUJlQY/w06lrK5BIfrU4vwGWCD26g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=MrYsT2EO; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8zpp9oa0negtVIgXYfuhw4+DS1WCN+dGtwwakt1ttPE=; b=MrYsT2EO+xH2Pyv/70EZGHUBEo
	jYjm5df8XpXZAUNm+n2FJ/wqMIDYICp3d5vgNEP0DxglQkqb/tj5bXl/pv+Gsws4BlM6lQQWoWxkv
	MNmwtcaSCklg6eLfm+Loy8z1EfglpLvIJnUIFty8Gkp8ckOXV7yTCEGmb7ICJqMuPBwq3W41JQSWK
	ciYzRhSXdkbyi+KfoIvVezLF4WDtKBAaAvCjyeSZ2lmGICRC6AU+akbrKbpr523yj5alsWEQZqWe6
	I08TrDDThXdKJQDdg54U44bIJEV9il9pdCQNK3PrsIhiCefmdu4rFZvLjlvT+45Znnq9vxpqVOvoR
	LlPRSJog==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wGwsj-000G4I-05;
	Sun, 26 Apr 2026 12:38:33 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wGwsi-0007nu-0e;
	Sun, 26 Apr 2026 12:38:32 +0200
Message-ID: <90c7de29-2641-413d-9d5f-5eb323cf875c@iogearbox.net>
Date: Sun, 26 Apr 2026 12:38:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv6: Implement limits on extension header parsing
To: Justin Iurman <justin.iurman@gmail.com>, kuba@kernel.org
Cc: edumazet@google.com, dsahern@kernel.org, tom@herbertland.com,
 willemdebruijn.kernel@gmail.com, idosch@nvidia.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20260425075521.736328-1-daniel@iogearbox.net>
 <b50025ba-c59d-4575-a790-fdaf0a48961d@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <b50025ba-c59d-4575-a790-fdaf0a48961d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27983/Sun Apr 26 08:24:27 2026)
X-Rspamd-Queue-Id: 40CE146967D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-281145-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi Justin,

On 4/25/26 12:19 PM, Justin Iurman wrote:
> On 4/25/26 09:55, Daniel Borkmann wrote:
>> ipv6_{skip_exthdr,find_hdr}() and ip6_{tnl_parse_tlv_enc_lim,
>> protocol_deliver_rcu}() iterate over IPv6 extension headers until they
>> find a non-extension-header protocol or run out of packet data. The
>> loops have no iteration counter, relying solely on the packet length
>> to bound them. For a crafted packet with 8-byte extension headers
>> filling a 64KB jumbogram, this means a worst case of up to ~8k
>> iterations with a skb_header_pointer call each. ipv6_skip_exthdr(),
>> for example, is used where it parses the inner quoted packet inside
>> an incoming ICMPv6 error:
>>
>>    - icmpv6_rcv
>>      - checksum validation
>>      - case ICMPV6_DEST_UNREACH
>>        - icmpv6_notify
>>          - pskb_may_pull()       <- pull inner IPv6 header
>>          - ipv6_skip_exthdr()    <- iterates here
>>          - pskb_may_pull()
>>          - ipprot->err_handler() <- sk lookup
>>
>> The per-iteration cost of ipv6_skip_exthdr itself is generally
>> light, but skb_header_pointer becomes more costly on reassembled
>> packets: the first ~1232 bytes of the inner packet are in the skb's
>> linear area, but the remaining ~63KB are in the frag_list where
>> skb_copy_bits is needed to read data.
>>
>> Add a configurable limit via a new sysctl net.ipv6.max_ext_hdrs_number
>> (default 8, minimum 1). All four extension header walking functions
>> are bound by this limit. The sysctl is in line with commit 47d3d7ac656a
>> ("ipv6: Implement limits on Hop-by-Hop and Destination options").
>> As documented, init_net is used to derive max_ext_hdrs_number to
>> be consistent given a net cannot always reliably be retrieved.
>>
>> Note that the check in ip6_protocol_deliver_rcu() happens right
>> before the goto resubmit, such that we don't have to have a test
>> for ipv6_ext_hdr() in the fast-path.
>>
>> There's an ongoing IETF draft-iurman-6man-eh-occurrences to enforce
>> IPv6 extension headers ordering and occurrence. The latter also
>> discusses security implications. As per RFC8200 section 4.1, the
>> occurrence rules for extension headers provide a practical upper
>> bound, thus 8 was used as the default.
>>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>   v1->v2:
>>     - Set the default to 8 (Justin)
>>     - Update IETF references (Justin)
>>     - Add core path coverage as well (Justin)
>>
>>   Documentation/networking/ip-sysctl.rst |  7 +++++++
>>   include/net/dropreason-core.h          |  6 ++++++
>>   include/net/ipv6.h                     |  2 ++
>>   include/net/netns/ipv6.h               |  1 +
>>   net/ipv6/af_inet6.c                    |  1 +
>>   net/ipv6/exthdrs_core.c                | 11 +++++++++++
>>   net/ipv6/ip6_input.c                   |  6 ++++++
>>   net/ipv6/ip6_tunnel.c                  |  5 +++++
>>   net/ipv6/sysctl_net_ipv6.c             |  8 ++++++++
>>   9 files changed, 47 insertions(+)
>>
> 
> [snip]
> 
>> diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
>> index 967b07aeb683..a5bbbc16e8d7 100644
>> --- a/net/ipv6/ip6_input.c
>> +++ b/net/ipv6/ip6_input.c
>> @@ -403,8 +403,10 @@ INDIRECT_CALLABLE_DECLARE(int tcp_v6_rcv(struct sk_buff *));
>>   void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
>>                     bool have_final)
>>   {
>> +    int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
>>       const struct inet6_protocol *ipprot;
>>       struct inet6_dev *idev;
>> +    int exthdr_cnt = 0;
>>       unsigned int nhoff;
>>       SKB_DR(reason);
>>       bool raw;
>> @@ -487,6 +489,10 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
>>                   nexthdr = ret;
>>                   goto resubmit_final;
>>               } else {
>> +                if (unlikely(exthdr_cnt++ >= exthdr_max)) {
>> +                    SKB_DR_SET(reason, IPV6_TOO_MANY_EXTHDRS);
>> +                    goto discard;
>> +                }
>>                   goto resubmit;
>>               }
>>           } else if (ret == 0) {
> 
> The hop-by-hop options header (if present) is not taken into account based on the above. However, the max number of extension headers (implicitly 7***, as per RFC 8200 Section 4.1) must include it. I suggest adding this at the beginning of ip6_protocol_deliver_rcu():
> 
> struct inet6_skb_parm *opt = IP6CB(skb);
> 
> if (opt->flags & IP6SKB_HOPBYHOP)
>      exthdr_cnt++;
> 
> *** FYI, rounding to 8 is fine for this fix

Ok, ack, I'll look into adding that in a v3.

>> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
>> index d2cd33e2698d..93f865545a7c 100644
>> --- a/net/ipv6/sysctl_net_ipv6.c
>> +++ b/net/ipv6/sysctl_net_ipv6.c
>> @@ -135,6 +135,14 @@ static struct ctl_table ipv6_table_template[] = {
>>           .extra1        = SYSCTL_ZERO,
>>           .extra2        = &flowlabel_reflect_max,
>>       },
>> +    {
>> +        .procname    = "max_ext_hdrs_number",
>> +        .data        = &init_net.ipv6.sysctl.max_ext_hdrs_cnt,
>> +        .maxlen        = sizeof(int),
>> +        .mode        = 0644,
>> +        .proc_handler    = proc_dointvec_minmax,
>> +        .extra1        = SYSCTL_ONE,
>> +    },
>>       {
>>           .procname    = "max_dst_opts_number",
>>           .data        = &init_net.ipv6.sysctl.max_dst_opts_cnt,
> 
> I've given it a lot of thought. I came to the conclusion that we should use a hard-coded value here as well (just like we did for 076b8cad77aa, with the same logic), not a sysctl. IMO, the main reason is that it provides as is a suitable security fix to be backported, i.e., the max value is the max number of EHs allowed by RFC 8200, Section 4.1. Also, we remain consistent with draft-iurman-6man-eh-occurrences (I think Tom is about to send a revision of the series soon for net-next). What this series does is not only enforcing ordering, but also verifying the specific number of occurrences for each type of Extension Header. Which is totally compatible with what this patch does, i.e., limiting the total number of Extension Headers (regardless of their types) to 8. I guess what I'm trying to say is that it seems like a good plan/compromise and that the aforementioned series would build perfectly on top of this fix.


Initially, I had a hard-coded constant (when it was still 32), but Eric's comment
was to rather go with a sysctl, such that if someone unexpectedly complains, then
there is still a chance for that person to fix it up via sysctl without having to
rebuild the kernel. I'm okay either way, but presumably given we're now being more
"aggressive" into lowering the default to 8 rather than 32 then having such a fall-
back is probably better.

Thanks,
Daniel

