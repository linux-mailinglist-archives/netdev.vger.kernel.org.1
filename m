Return-Path: <netdev+bounces-253996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOw8D4QWeWmyvAEAu9opvQ
	(envelope-from <netdev+bounces-253996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:48:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C2A9A1D0
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B5353017780
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66653326D50;
	Tue, 27 Jan 2026 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQVjoWrv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E29314B77
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769543297; cv=none; b=PKb9+4Olvnx9iX0bPnv6oKFW5EhZClRE/vyrQuiNZIm3MqluIu/D3FuNMWPmpZw54yCarIodlnlN6Gm54SN1sP7FJd5x6038ZhOLAdn/jL50C/84mvFnae9eZ0d1ZeBWkhz1Gi0ZzO/WBWKu/crndKStziE51+YhH4istCBRfA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769543297; c=relaxed/simple;
	bh=/l+yDVM3v+/aqF/tzqoU6kZFF4+ifgHr9NV71sDSZf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AY6C8sT02HUS+47t6D5MzS5GVHTO3wR3n+Qi0GTx+cGoRpZIma7QTA/Pw8yx1vlzsgY+04654dsILA490NWn4eN+lyzP3KeZ2Ri6+Q83DhQ42TZon5x1OngfHs4cfCB2DLsf0nws3QSN0+xOdiYXNoqg/2o9EDwVvKLgdwC3b2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQVjoWrv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48068127f00so9195915e9.3
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 11:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769543294; x=1770148094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9n/RhnYJRO7D39yfE0sXmw556kzAr9kHr6gPY8sY/Ic=;
        b=EQVjoWrv+6UzKmFs6iIlUAlQxjYW08Ad4DJWelKGw1wHLXsHzZqoQjiOljcNg9QPWl
         RSpyebvVMfAvo0WJp2BC6uVJr0zpENz0ewfPA1i6C6tR67HHhaiASwS2exXMe+s+DDpA
         z/nPpco3HEun0nyY2S+RaxCNFdgnrDhLIYekd4PdMDacZauH1UCykCJkNBGFXxrZMkwh
         6CdqoH2n2xa7sJ1MhB3sn2xAUay6EW5KmMnRy3NfQJPNeAKx1uiAi2/TjY2S5sgMhPc/
         L0NY4bnNYf9A0Xlu3n2NDnAQWThah12c28Ruxrzyl4UzZjFWwJeH8M8RFGG7ozaoJ0oy
         RRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769543294; x=1770148094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9n/RhnYJRO7D39yfE0sXmw556kzAr9kHr6gPY8sY/Ic=;
        b=wDs01F/CN/viKaDcSgXCVnUQbgEYXtQdH1TtBsKprghCh14Micl3Km03ZFXPRwqAQF
         02CjwjdOPA1nfMtr+4Ck88t7IUWcUG4B5+NUpyCeLznhhuKBZ/S953jybnEYkxB+brhU
         5BukiApn0SI7tuUyN0NN4m8uIBvT1L7twZjnFH2M7eIX1rxOiOKKm05wC6dqIxH/QmV2
         xmx8vmyhqcXXDatakdsUN3KcraCSip/FPOQ91ePCFb7IPrMv7T0WxOM/4MW75Iyt9t46
         Ajz3Uw9PkPriQhB9TjaABJUBkRtzNjT8t79V8eE4VTPIBPiv3ZpJTDyGkTDvRUn0hsMA
         xvSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Nxpxalni890mZShtVVUzKCIjPDEwW4jAHWm7LTwr4aakekKO3SMWe596ufzJSP1AyHkmDxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTON8dmpAc/Nv11q7rrugM2KB7zkt1ySdNbPE4aZI0KNIh/qe8
	86SZJVpWqPmiAp6g7cU52DaBqrAiseH8YsLbkLPVmwaszBNO+lPkhWCqK1mcOCIE
X-Gm-Gg: AZuq6aKXG7Qulk3KQgzWXekxpPKFpcmevL15Xzhaaq77+E3i5D5r3yUaRr/NVTgCyeR
	pnskfI/4Rvy+gl/8V/PMi69xoGF4+wyO0LuGBs6jAmBTzx2pAD5Dt5eTPtdnJu1m3ZS/woE3ZJj
	5ggLibQIo2i8wQaflNfm0q0Q5g6+I7QB9maSZ8ny1TQkimkesjDV3riTY1tuSQcIz+S5FdoD5K+
	pBM7qDteQ0QGdsTSdpo53LboPywDtJ3vnGQJoc6LW9vUM130zqFokO5lpAErjogrsUZl+hGQxFp
	TNDvFztRwziEAPvrq120dvqXXX/8narsMnnY5/UzBgF99kFBWSPDU+sTqq0eHLWSOHbwTQz6z24
	M8B2t8l8avrXsZKz2aJ48HLiDThGfQQgMTs15OD41YN9bvZbuCgl3+jNMtkKntv20g4zBIXU+WX
	zCV93OEsDzm0DzeZayi28Pj5fEa8jRVHEXtnyDwgvnPvMLAdAuIAMy6kHDcrV3aisFTA==
X-Received: by 2002:a05:600c:8117:b0:47f:b737:5ce0 with SMTP id 5b1f17b1804b1-48069c5a468mr36018325e9.23.1769543293604;
        Tue, 27 Jan 2026 11:48:13 -0800 (PST)
Received: from ?IPV6:2a02:a03f:a75e:9a00:7800:6d36:b552:d917? ([2a02:a03f:a75e:9a00:7800:6d36:b552:d917])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdebf86sm12074925e9.8.2026.01.27.11.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 11:48:13 -0800 (PST)
Message-ID: <6eddd484-f584-4e37-9ea5-1bb829ae1296@gmail.com>
Date: Tue, 27 Jan 2026 20:48:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 6/7] ipv6: Enforce Extension Header ordering
To: Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org
References: <20260126194826.236075-1-tom@herbertland.com>
 <20260126194826.236075-7-tom@herbertland.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260126194826.236075-7-tom@herbertland.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253996-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 87C2A9A1D0
X-Rspamd-Action: no action

On 1/26/26 20:48, Tom Herbert wrote:
> RFC8200 highly recommends that different Extension Headers be send in
> a prescibed order and all Extension Header types occur at most once
> in a packet with the exception of Destination Options that may
> occur twice. This patch enforces the ordering be folowed in received
> packets.
> 
> The allowed order of Extension Headers is:
> 
>      IPv6 header
>      Hop-by-Hop Options header
>      Destination Options before the Routing Header
>      Routing header
>      Fragment header
>      Authentication header
>      Encapsulating Security Payload header
>      Destination Options header
>      Upper-Layer header
> 
> Each Extension Header may be present only once in a packet.
> 
> net.ipv6.enforce_ext_hdr_order is a sysctl to enable or disable
> enforcement of xtension Header order. If it is set to zero then
> Extension Header order and number of occurences is not checked
> in receive processeing (except for Hop-by-Hop Options that
> must be the first Extension Header and can only occur once in
> a packet.
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>   include/net/netns/ipv6.h   |  1 +
>   include/net/protocol.h     | 14 +++++++++++++
>   net/ipv6/af_inet6.c        |  1 +
>   net/ipv6/exthdrs.c         |  2 ++
>   net/ipv6/ip6_input.c       | 42 ++++++++++++++++++++++++++++++++++++++
>   net/ipv6/reassembly.c      |  1 +
>   net/ipv6/sysctl_net_ipv6.c |  7 +++++++
>   net/ipv6/xfrm6_protocol.c  |  2 ++
>   8 files changed, 70 insertions(+)
> 
> diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
> index 34bdb1308e8f..2db56718ea60 100644
> --- a/include/net/netns/ipv6.h
> +++ b/include/net/netns/ipv6.h
> @@ -61,6 +61,7 @@ struct netns_sysctl_ipv6 {
>   	u8 fib_notify_on_flag_change;
>   	u8 icmpv6_error_anycast_as_unicast;
>   	u8 icmpv6_errors_extension_mask;
> +	u8 enforce_ext_hdr_order;
>   };
>   
>   struct netns_ipv6 {
> diff --git a/include/net/protocol.h b/include/net/protocol.h
> index b2499f88f8f8..0f1676625570 100644
> --- a/include/net/protocol.h
> +++ b/include/net/protocol.h
> @@ -50,6 +50,19 @@ struct net_protocol {
>   };
>   
>   #if IS_ENABLED(CONFIG_IPV6)
> +
> +/* Order of extension headers as prescribed in RFC8200. The ordering and
> + * number of extension headers in a packet can be enforced in IPv6 receive
> + * processing.
> + */
> +#define IPV6_EXT_HDR_ORDER_HOP			BIT(0)
> +#define IPV6_EXT_HDR_ORDER_DEST_BEFORE_RH	BIT(1)
> +#define IPV6_EXT_HDR_ORDER_ROUTING		BIT(2)
> +#define IPV6_EXT_HDR_ORDER_FRAGMENT		BIT(3)
> +#define IPV6_EXT_HDR_ORDER_AUTH			BIT(4)
> +#define IPV6_EXT_HDR_ORDER_ESP			BIT(5)
> +#define IPV6_EXT_HDR_ORDER_DEST			BIT(6)
> +
>   struct inet6_protocol {
>   	int	(*handler)(struct sk_buff *skb);
>   
> @@ -61,6 +74,7 @@ struct inet6_protocol {
>   
>   	unsigned int	flags;	/* INET6_PROTO_xxx */
>   	u32		secret;
> +	u32		ext_hdr_order;
>   };
>   
>   #define INET6_PROTO_NOPOLICY	0x1
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index bd29840659f3..43097360ce64 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -980,6 +980,7 @@ static int __net_init inet6_net_init(struct net *net)
>   	net->ipv6.sysctl.max_dst_opts_len = IP6_DEFAULT_MAX_DST_OPTS_LEN;
>   	net->ipv6.sysctl.max_hbh_opts_len = IP6_DEFAULT_MAX_HBH_OPTS_LEN;
>   	net->ipv6.sysctl.fib_notify_on_flag_change = 0;
> +	net->ipv6.sysctl.enforce_ext_hdr_order = 1;
>   	atomic_set(&net->ipv6.fib6_sernum, 1);
>   
>   	net->ipv6.sysctl.ioam6_id = IOAM6_DEFAULT_ID;
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 6925cfad94d2..4ab94c8cddb9 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -845,11 +845,13 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
>   static const struct inet6_protocol rthdr_protocol = {
>   	.handler	=	ipv6_rthdr_rcv,
>   	.flags		=	INET6_PROTO_NOPOLICY,
> +	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_ROUTING,
>   };
>   
>   static const struct inet6_protocol destopt_protocol = {
>   	.handler	=	ipv6_destopt_rcv,
>   	.flags		=	INET6_PROTO_NOPOLICY,
> +	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_DEST,
>   };
>   
>   static const struct inet6_protocol nodata_protocol = {
> diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
> index 168ec07e31cc..ab921c0a94af 100644
> --- a/net/ipv6/ip6_input.c
> +++ b/net/ipv6/ip6_input.c
> @@ -355,6 +355,27 @@ void ipv6_list_rcv(struct list_head *head, struct packet_type *pt,
>   		ip6_sublist_rcv(&sublist, curr_dev, curr_net);
>   }
>   
> +static u32 check_dst_opts_before_rh(const struct inet6_protocol *ipprot,
> +				    u32 ext_hdrs)
> +{
> +	/* Check if Destination Options before the Routing Header are
> +	 * present.
> +	 */
> +	if (ipprot->ext_hdr_order != IPV6_EXT_HDR_ORDER_ROUTING ||
> +	    !(ext_hdrs | IPV6_EXT_HDR_ORDER_DEST))

Just curious, did you test it? Seems weird, not sure about this code. By 
the way, how about adding a selftest (python+scapy) to test all EH 
combinations? Should be straightforward. Could be added later, not 
necessarily in this series.

I think you inverted IPV6_EXT_HDR_ORDER_ROUTING and 
IPV6_EXT_HDR_ORDER_DEST. Also, (ext_hdrs | IPV6_EXT_HDR_ORDER_DEST) 
should probably be (ext_hdrs & IPV6_EXT_HDR_ORDER_DEST) instead. See my 
proposal below.

> +		return ext_hdrs;
> +
> +	/* We have Destination Options before the Routing Header. Set
> +	 * the mask of recived extension headers to reflect that. We promote

Reported by AI:
s/recived/received

(in case you keep this part)

> +	 * the bit from indicating just Destination Options present to
> +	 * Destination Options before the Routing Header being present
> +	 */
> +	ext_hdrs = (ext_hdrs & ~IPV6_EXT_HDR_ORDER_DEST) |
> +		IPV6_EXT_HDR_ORDER_DEST_BEFORE_RH;
> +
> +	return ext_hdrs;
> +}
> +
>   INDIRECT_CALLABLE_DECLARE(int tcp_v6_rcv(struct sk_buff *));
>   
>   /*
> @@ -366,6 +387,7 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
>   	const struct inet6_protocol *ipprot;
>   	struct inet6_dev *idev;
>   	unsigned int nhoff;
> +	u32 ext_hdrs = 0;
>   	SKB_DR(reason);
>   	bool raw;
>   
> @@ -427,6 +449,26 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
>   				goto discard;
>   			}
>   		}
> +
> +		if (ipprot->ext_hdr_order &&
> +		    READ_ONCE(net->ipv6.sysctl.enforce_ext_hdr_order)) {
> +			/* The protocol is an extension header and EH ordering
> +			 * is being enforced. Discard packet if we've already
> +			 * seen this EH or one that is lower in the order list
> +			 */
> +			if (ipprot->ext_hdr_order <= ext_hdrs) {
> +				/* Check if there's Destination Options
> +				 * before the Routing Header
> +				 */
> +				ext_hdrs = check_dst_opts_before_rh(ipprot,
> +								    ext_hdrs);
> +				if (ipprot->ext_hdr_order <= ext_hdrs)
> +					goto discard;
> +			}
> +
> +			ext_hdrs |= ipprot->ext_hdr_order;
> +		}
> +

Didn't test your version, neither did I with this attempt, feedback welcome:

#define IPV6_EXT_HDR_ORDER_HOP			BIT(0)
#define IPV6_EXT_HDR_ORDER_DEST			BIT(1)
#define IPV6_EXT_HDR_ORDER_ROUTING		BIT(2)
#define IPV6_EXT_HDR_ORDER_FRAGMENT		BIT(3)
#define IPV6_EXT_HDR_ORDER_AUTH			BIT(4)
#define IPV6_EXT_HDR_ORDER_ESP			BIT(5)
#define IPV6_EXT_HDR_ORDER_DEST2		BIT(6)

[...]

static const struct inet6_protocol destopt_protocol = {
  	.handler	=	ipv6_destopt_rcv,
  	.flags		=	INET6_PROTO_NOPOLICY,
	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_DEST,
};

[...]

u32 ext_hdrs;
if (ipprot->ext_hdr_order) {
	if (ipprot->ext_hdr_order <= ext_hdrs) {
		if ((ext_hdrs & IPV6_EXT_HDR_ORDER_DEST2) ||
		    ipprot->ext_hdr_order != IPV6_EXT_HDR_ORDER_DEST ||
		    !(ext_hdrs & IPV6_EXT_HDR_ORDER_ROUTING)) {
			goto discard;
		}

		if  (ipprot->ext_hdr_order == IPV6_EXT_HDR_ORDER_DEST)
			ext_hdrs |= IPV6_EXT_HDR_ORDER_DEST2;
	}

	ext_hdrs |= ipprot->ext_hdr_order;
}

... which looks quite similar to yours without the error mentioned above.

>   		if (!(ipprot->flags & INET6_PROTO_NOPOLICY)) {
>   			if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb)) {
>   				SKB_DR_SET(reason, XFRM_POLICY);
> diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
> index 25ec8001898d..91dba72c5a3c 100644
> --- a/net/ipv6/reassembly.c
> +++ b/net/ipv6/reassembly.c
> @@ -414,6 +414,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
>   static const struct inet6_protocol frag_protocol = {
>   	.handler	=	ipv6_frag_rcv,
>   	.flags		=	INET6_PROTO_NOPOLICY,
> +	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_FRAGMENT,
>   };
>   
>   #ifdef CONFIG_SYSCTL
> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
> index d2cd33e2698d..543b6acdb11d 100644
> --- a/net/ipv6/sysctl_net_ipv6.c
> +++ b/net/ipv6/sysctl_net_ipv6.c
> @@ -213,6 +213,13 @@ static struct ctl_table ipv6_table_template[] = {
>   		.proc_handler	= proc_doulongvec_minmax,
>   		.extra2		= &ioam6_id_wide_max,
>   	},
> +	{
> +		.procname	= "enforce_ext_hdr_order",
> +		.data		= &init_net.ipv6.sysctl.enforce_ext_hdr_order,
> +		.maxlen		= sizeof(u8),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dou8vec_minmax,
> +	},
>   };
>   
>   static struct ctl_table ipv6_rotable[] = {
> diff --git a/net/ipv6/xfrm6_protocol.c b/net/ipv6/xfrm6_protocol.c
> index ea2f805d3b01..5826edf67f64 100644
> --- a/net/ipv6/xfrm6_protocol.c
> +++ b/net/ipv6/xfrm6_protocol.c
> @@ -197,12 +197,14 @@ static const struct inet6_protocol esp6_protocol = {
>   	.handler	=	xfrm6_esp_rcv,
>   	.err_handler	=	xfrm6_esp_err,
>   	.flags		=	INET6_PROTO_NOPOLICY,
> +	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_ESP,
>   };
>   
>   static const struct inet6_protocol ah6_protocol = {
>   	.handler	=	xfrm6_ah_rcv,
>   	.err_handler	=	xfrm6_ah_err,
>   	.flags		=	INET6_PROTO_NOPOLICY,
> +	.ext_hdr_order	=	IPV6_EXT_HDR_ORDER_AUTH
>   };
>   
>   static const struct inet6_protocol ipcomp6_protocol = {


