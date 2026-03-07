Return-Path: <netdev+bounces-265108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKApHHvTq2mshAEAu9opvQ
	(envelope-from <netdev+bounces-265108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 08:27:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1332422A9B8
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 08:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 527CD3035D5A
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 07:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34315372B5E;
	Sat,  7 Mar 2026 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g9S+oxob";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c1lV+sfd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g9S+oxob";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c1lV+sfd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9436D4F0
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772868453; cv=none; b=pZzROKBFXtNm4o9E8g460dWisNzq2vGrUiiCwX8rdhcSncT0QWP/4HZ8IGRiZLnyEfoAJ1F5fObXzTtMDTxMumehrDwLdAOO3+ZhmknYh003ZJ88ZNua6rCMEAjzDu0usLOChTC8t3qjUPNIOzqaAyk1OkNnxQRku40Ix9zqfgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772868453; c=relaxed/simple;
	bh=yaJnNdWIBiiQlM/3NBeQUA6f9ZCPn33PYdxt7nXQrlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0lJ+VMDtmTp2QW28Ky1/CojOCqjhSGlVsguzXQD5BMoKOdeWSyz/mrHUfqLLDqsz+UlIB61WZkP8EJKBXWRdU94cvz19h8UVtD9BmlrHdCGA/HeXeFqnLbOG+MncemFVWMUtVzHmrpxjqsYMqTNcUGP07OkXalhBj3D3FPWBnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g9S+oxob; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c1lV+sfd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g9S+oxob; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c1lV+sfd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0D7F35BDEB;
	Sat,  7 Mar 2026 07:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772868449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAcBCoTYWQSQmnwUltm9shdu8DulQvP79VCTXPkDMBQ=;
	b=g9S+oxobMqr907rfZheqjA/fFsqDd2SaMbArqZdTFhSgRSl2GRPO2wBLZ9TDI7ex6cH7fy
	zc+ekPT/X3qfBQ5fFKqTO5aE2TwUahcRuxt8r8i6cnH0hmzACL+mAKABHZMEgTBJM2BrDd
	1biBe7FuwYarfvYrq0JC7Qb+l82GxHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772868449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAcBCoTYWQSQmnwUltm9shdu8DulQvP79VCTXPkDMBQ=;
	b=c1lV+sfdbbmCz8Msc2QNNb/IbPomRQwcVSqCvAJde73SZ3Iexqahc9U5YastUJmXY3WSsv
	9IacDlBqcyjaMgBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772868449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAcBCoTYWQSQmnwUltm9shdu8DulQvP79VCTXPkDMBQ=;
	b=g9S+oxobMqr907rfZheqjA/fFsqDd2SaMbArqZdTFhSgRSl2GRPO2wBLZ9TDI7ex6cH7fy
	zc+ekPT/X3qfBQ5fFKqTO5aE2TwUahcRuxt8r8i6cnH0hmzACL+mAKABHZMEgTBJM2BrDd
	1biBe7FuwYarfvYrq0JC7Qb+l82GxHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772868449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAcBCoTYWQSQmnwUltm9shdu8DulQvP79VCTXPkDMBQ=;
	b=c1lV+sfdbbmCz8Msc2QNNb/IbPomRQwcVSqCvAJde73SZ3Iexqahc9U5YastUJmXY3WSsv
	9IacDlBqcyjaMgBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 882AF3EA61;
	Sat,  7 Mar 2026 07:27:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0KNZHV/Tq2nfQgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 07 Mar 2026 07:27:27 +0000
Message-ID: <691d5589-46ea-4947-9510-bfd9d991ed02@suse.de>
Date: Sat, 7 Mar 2026 08:27:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] bpf: bpf_out_neigh_v6: Fix nd_tbl NULL
 dereference when IPv6 is disabled
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, David Ahern <dsahern@kernel.org>,
 Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Hangbin Liu <liuhangbin@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com>
 <20260305-net-nd_tbl_fixes-v3-2-fde28b30a744@suse.com>
 <20260305182521.0ca7313c@kernel.org>
 <b3477010-6fdd-4bec-8951-152b12bf56e6@suse.de>
 <20260306183914.4b13a03d@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260306183914.4b13a03d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1332422A9B8
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
	FREEMAIL_CC(0.00)[suse.com,linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-265108-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/7/26 3:39 AM, Jakub Kicinski wrote:
> On Fri, 6 Mar 2026 10:58:44 +0100 Fernando Fernandez Mancera wrote:
>>>> +	if (unlikely(!ipv6_stub->nd_tbl))
>>>> +		goto out_drop;
>>>
>>> So neither Fernando nor you checked whether this code can be built
>>> as a module? ipv6_mod_enabled() should work just fine
>>
>> I checked it. If IPV6=m this is not fine.
>>
>> ld: vmlinux.o: in function `bpf_out_neigh_v6':
>> filter.c:(.text+0x3231d60): undefined reference to `ipv6_mod_enabled'
> 
> Guess I got it backwards :/ Should we add this to the series?
> 

No worries.

> -->8--------
> Subject: ipv6: move the disable_ipv6_mod knob to core code
> 
> Make sure disable_ipv6_mod itself is not part of the IPv6 module,
> in case core code wants to refer to it. We will remove support
> for IPv6=m soon, this change helps make fixes we commit before
> that less messy.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Ricardo could you add it and check if it is fine? FWIW; I am sending 
today the series removing IPV6=m after some testing to net-next tree.

Thanks,
Fernando.

>   include/linux/ipv6.h | 7 ++++++-
>   net/ipv4/af_inet.c   | 6 ++++++
>   net/ipv6/af_inet6.c  | 8 --------
>   3 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
> index 443053a76dcf..e5b6853d517a 100644
> --- a/include/linux/ipv6.h
> +++ b/include/linux/ipv6.h
> @@ -333,7 +333,12 @@ struct tcp6_timewait_sock {
>   };
>   
>   #if IS_ENABLED(CONFIG_IPV6)
> -bool ipv6_mod_enabled(void);
> +extern int disable_ipv6_mod;
> +
> +static inline bool ipv6_mod_enabled(void)
> +{
> +        return disable_ipv6_mod == 0;
> +}
>   
>   static inline struct ipv6_pinfo *inet6_sk(const struct sock *__sk)
>   {
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index babcd75a08e2..f1944e8fd9d3 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -124,6 +124,12 @@
>   
>   #include <trace/events/sock.h>
>   
> +/* Keep the definition of IPv6 disable here for now, to avoid annoying linker
> + * issues in case IPv6=m
> + */
> +int disable_ipv6_mod;
> +EXPORT_SYMBOL(disable_ipv6_mod);
> +
>   /* The inetsw table contains everything that inet_create needs to
>    * build a new socket.
>    */
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index 0b995a961359..03c175cbbdb6 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -86,8 +86,6 @@ struct ipv6_params ipv6_defaults = {
>   	.autoconf = 1,
>   };
>   
> -static int disable_ipv6_mod;
> -
>   module_param_named(disable, disable_ipv6_mod, int, 0444);
>   MODULE_PARM_DESC(disable, "Disable IPv6 module such that it is non-functional");
>   
> @@ -97,12 +95,6 @@ MODULE_PARM_DESC(disable_ipv6, "Disable IPv6 on all interfaces");
>   module_param_named(autoconf, ipv6_defaults.autoconf, int, 0444);
>   MODULE_PARM_DESC(autoconf, "Enable IPv6 address autoconfiguration on all interfaces");
>   
> -bool ipv6_mod_enabled(void)
> -{
> -	return disable_ipv6_mod == 0;
> -}
> -EXPORT_SYMBOL_GPL(ipv6_mod_enabled);
> -
>   static struct ipv6_pinfo *inet6_sk_generic(struct sock *sk)
>   {
>   	const int offset = sk->sk_prot->ipv6_pinfo_offset;


