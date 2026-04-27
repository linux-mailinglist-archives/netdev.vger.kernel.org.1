Return-Path: <netdev+bounces-281476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEuHGbHE72lsFwEAu9opvQ
	(envelope-from <netdev+bounces-281476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:18:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B5C479E83
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC17530125A8
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599123806D4;
	Mon, 27 Apr 2026 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="t4jAgBnY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ABE364E96
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320873; cv=none; b=JSfXzBrSceWp6CIbVW6sVPR2KDEX3qSsHUe6KLpdXr3fHV+lEpF3w4KBIDnHo7abZHMd9oIH7gbvW29vpTgTT+OMk0uqE5SIdhc5Hdn2GjrbRsI7iIHtQMoIK8pg/P/zNLAlFq6BAAaewF6XRTYiBIVuOi8q+Yb67Z5VCs4n6nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320873; c=relaxed/simple;
	bh=0eSwGvLPvKNKZdcCBScgXn/b5rNFnHLzAqnOQ9r89d8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2pPW+RTBCusu0GENiqR2U0hU88vHDSrUmWQpuWNU4VzNBNdDtyhj+RVovv8ueAWo1BGTqCLYTmJkpCt+LILfU5gblV3HMG3plNK7QFjFbdd5Tb0su4QU1HX1Zv/itqZ7aUOP89gODqBfVzJF1iTR7ta4RGiI01CHX1qijTjZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=t4jAgBnY; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2eadb000b8cso1040097eec.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777320870; x=1777925670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hZxvHyJNT4nysVkWmWgQJrVxQTcxaWKHnQdHVdMwxcs=;
        b=t4jAgBnYTJjDOu01WmKv7hTA7r9s/YHIMAwXyJAH1PoqsTwl710gssl+bO6y1OEprh
         o7Ss5FDe0pVjLcbE2UVgiSHLmlr4FPk/HC3OVOa1lN/cMJOvk7dpT9Y6sApZBNz3T00e
         AfE1tN5SrT0HdzWFczGmHYrkrUM8PbNfi9yquVKC0W7Drq5CwKKJDM7+syJXOKJxbnPG
         Ig4jmkOm5lfyzK4lP/nbfl7oWBFrA6zvChfzbnRclMYeujL1OrYoANk5QlAKpR33z2Z+
         ayXbAFGIMmsj38sBpLsLW7naI/+oH3nGWW+R4/r8S20KqwWWqnpuy0zvbpOJXhWpkHLR
         hhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777320870; x=1777925670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZxvHyJNT4nysVkWmWgQJrVxQTcxaWKHnQdHVdMwxcs=;
        b=R8hxrlbDnwDAvjwfBcsNqAxXsmUzou54rUqCDDPIPWcxMpWekFPnj/83RJqq6bipRk
         3g3OI/wXnBYtjUNUwE9yEqfCfdCqQcln7/1b72u/A/10L0UB495gZnAUe1Mp0hrcj/4n
         ulADPG7+NIv/kULVRtLWzXHTopbwjcxCkxNU4bogyj6UTdcS7PExRvwc8RTF2UyQHWzN
         1BA/teakVgpA9bxONLq0vqqe6Minx+E88lnumnDV48CzDFvKOHXuYO++bpZSC9FdUQiz
         b+1SEh4GNTShZTWPQyxuaRzYhgG8lCLKPofwNH5U2EMzUYQ7Soocgd5x4z8bdOsNdt69
         VnxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+G5Kyi20tH9zAkIStIumyyUnZcz1FpNfN5o/uty+rOuLciOGmOcNVf052ft3+S+PCaxA85EaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1BQ5AQYHBFqK5WBxCF8t/Rx8vlcvlsqGtbXllvvjkAd1+bgwn
	ZBUh1xQ25TsjzDiwrd+YrN0h/zA6jSUqcK2udex3g/g1cimrcfuoeDZY9XhkKnXl1g==
X-Gm-Gg: AeBDieuNctz2s3sGeC6SzeR7WLVHmlpuFEoWQeYVeqTn5mmqwF2L02TXsZjmljL/rKo
	vJC78l7Z4GNBuyTex5OmiRs44G65qSx6bQY57HYKCcbkuR1375FVn+7ZeLEOp36LDXFQP0S/7fA
	hs9rbavMsz7BgfHuQjsWZzj4q7rwXl/z4kUbpFLJ+2HHDKrOyddwcx6ys0ubADaCBjKb41AyUgd
	qZzDKpMokAtEEOYiCIFC/CaQNVJeje4slehMBsKdCD7dHbxJm6K8jVgHK99s0upesLJP7Vacnh4
	oApuPv7NlMC0Q7NYQMEtM0r6XM6tVaj11q52ijlDhv5f99N+WrYsXMtT9DtqV23GAs2v6J7gf8G
	so2mxehr3ViHvcdANwQXsyrPVsTvKsdMIIEJ+1oOzJCoHZtYLzGRn4Quda+bY1/q8S7xn0C/h7k
	EqF8ZczEIJPf5X9NH0iobJmtIS6KunbHkoxbmjdUnqrE66
X-Received: by 2002:a05:7300:5724:b0:2df:919f:ce59 with SMTP id 5a478bee46e88-2ed0a0ce786mr227702eec.19.1777320869990;
        Mon, 27 Apr 2026 13:14:29 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c54:4d67::2000? ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed09fb5a99sm451704eec.7.2026.04.27.13.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 13:14:29 -0700 (PDT)
Message-ID: <ba5ff0fe-862e-44bf-b931-d136faa341b3@mojatatu.com>
Date: Mon, 27 Apr 2026 17:14:24 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] ipv6: Implement limits on extension header parsing
To: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org
Cc: edumazet@google.com, dsahern@kernel.org, tom@herbertland.com,
 willemdebruijn.kernel@gmail.com, idosch@nvidia.com, justin.iurman@gmail.com,
 pabeni@redhat.com, netdev@vger.kernel.org
References: <20260427101318.750730-1-daniel@iogearbox.net>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260427101318.750730-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 63B5C479E83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281476-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iogearbox.net:email,mojatatu.com:mid]

On 27/04/2026 07:13, Daniel Borkmann wrote:
> ipv6_{skip_exthdr,find_hdr}() and ip6_{tnl_parse_tlv_enc_lim,
> protocol_deliver_rcu}() iterate over IPv6 extension headers until they
> find a non-extension-header protocol or run out of packet data. The
> loops have no iteration counter, relying solely on the packet length
> to bound them. For a crafted packet with 8-byte extension headers
> filling a 64KB jumbogram, this means a worst case of up to ~8k
> iterations with a skb_header_pointer call each. ipv6_skip_exthdr(),
> for example, is used where it parses the inner quoted packet inside
> an incoming ICMPv6 error:
> 
>    - icmpv6_rcv
>      - checksum validation
>      - case ICMPV6_DEST_UNREACH
>        - icmpv6_notify
>          - pskb_may_pull()       <- pull inner IPv6 header
>          - ipv6_skip_exthdr()    <- iterates here
>          - pskb_may_pull()
>          - ipprot->err_handler() <- sk lookup
> 
> The per-iteration cost of ipv6_skip_exthdr itself is generally
> light, but skb_header_pointer becomes more costly on reassembled
> packets: the first ~1232 bytes of the inner packet are in the skb's
> linear area, but the remaining ~63KB are in the frag_list where
> skb_copy_bits is needed to read data.
> 
> Add a configurable limit via a new sysctl net.ipv6.max_ext_hdrs_number
> (default 8, minimum 1). All four extension header walking functions
> are bound by this limit. The sysctl is in line with commit 47d3d7ac656a
> ("ipv6: Implement limits on Hop-by-Hop and Destination options").
> As documented, init_net is used to derive max_ext_hdrs_number to
> be consistent given a net cannot always reliably be retrieved.
> 
> Note that the check in ip6_protocol_deliver_rcu() happens right
> before the goto resubmit, such that we don't have to have a test
> for ipv6_ext_hdr() in the fast-path.
> 
> There's an ongoing IETF draft-iurman-6man-eh-occurrences to enforce
> IPv6 extension headers ordering and occurrence. The latter also
> discusses security implications. As per RFC8200 section 4.1, the
> occurrence rules for extension headers provide a practical upper
> bound, thus 8 was used as the default.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> [...]
> diff --git a/net/ipv6/exthdrs_core.c b/net/ipv6/exthdrs_core.c
> index 49e31e4ae7b7..9df892e7f7fb 100644
> --- a/net/ipv6/exthdrs_core.c
> +++ b/net/ipv6/exthdrs_core.c
> [...]
> @@ -72,7 +74,9 @@ EXPORT_SYMBOL(ipv6_ext_hdr);
>   int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
>   		     __be16 *frag_offp)
>   {
> +	int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);

This seems to be breaking the build when CONFIG_IPV6 is disabled:

net/ipv6/exthdrs_core.c: In function ‘ipv6_skip_exthdr’:
net/ipv6/exthdrs_core.c:77:45: error: ‘struct net’ has no member named 
‘ipv6’; did you mean ‘ipv4’?
    77 |         int exthdr_max = 
READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);

> [...]
> @@ -188,8 +194,10 @@ EXPORT_SYMBOL_GPL(ipv6_find_tlv);
>   int ipv6_find_hdr(const struct sk_buff *skb, unsigned int *offset,
>   		  int target, unsigned short *fragoff, int *flags)
>   {
> +	int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);

Here as well:

net/ipv6/exthdrs_core.c: In function ‘ipv6_find_hdr’:
net/ipv6/exthdrs_core.c:197:45: error: ‘struct net’ has no member named 
‘ipv6’; did you mean ‘ipv4’?
   197 |         int exthdr_max = 
READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);


cheers,
Victor

