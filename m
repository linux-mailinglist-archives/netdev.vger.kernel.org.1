Return-Path: <netdev+bounces-301520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uvdsB2sgO2oURQgAu9opvQ
	(envelope-from <netdev+bounces-301520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 02:10:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4D36BAABF
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 02:10:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b="yPdDeSi/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301520-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301520-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96974306A8A6
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 00:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEE75695;
	Wed, 24 Jun 2026 00:09:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E44A3B18A
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 00:09:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782259799; cv=none; b=Ynm9sL5aoK9enyID38NT8UmqK728ycW3JDkJD5Sfd9p77BikCMnEtTysNx0THmLakuoNOnX9+zNXopf7gyZCZAPOaGMioPjfw6hKBypp5/YMmbv1cFfM3hxj9pt4fi/fvR0/5deivBRkn0hDEb1Rbalud++/iBKZleVVZpGGrts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782259799; c=relaxed/simple;
	bh=0XYbSaKDOoQduMhTFPk0faWObl2M7CF+88yrRNTkwwc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ORX7rDo8wsOcHcQegy6Tui+8tWZNtKvqrrOkEr38kmrcEE2zIpMvGhiaCXHQbF+2FXiGq2lQkduxwChxRjQCUzNr2bcMhzhPfjpQan4vC457lJq8c6TdK+nMIBqWcl0rMG3sLGatM72qu9LmzoTTdmsnRgk1vV8gP2G6vOT+sDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=yPdDeSi/; arc=none smtp.client-ip=74.125.82.173
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30c6c8d7503so294964eec.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782259797; x=1782864597; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8oF7gaI866b4fh2rX0QoDVma7OKpRu/EkO3XgX53kE=;
        b=yPdDeSi/Tr2gqG/UpLxRu4RJ50CYw3+LqV6ACLBjLE1IOtJtXqrpVP3/DdMdC+B94H
         kD7KHfaSURNiYzFNnGLcmk8gNKTJj/LInMItHkrFVqwxKijDy5UIRubGoh4l8so+C93o
         LfXAQrquRhj8tu/uTtxh2IrFOKVSPbexuHKP/ZZI2JnT0kdGhYeKmDpV23JvOBFud9QH
         gifvsRKPxhCum00TvuENKCiPO5fkPeSu6wce/9EagyD6A8a0Ol3tRc0szeTJ/8fL4Qgb
         KNvBfkoQQ7B3o8fX+PFSDuxif6j6tKUwApS1Io2XmWxzrY4Teh/EabxvXppwXEUjPJAx
         87SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782259797; x=1782864597;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G8oF7gaI866b4fh2rX0QoDVma7OKpRu/EkO3XgX53kE=;
        b=mmAZ91PWIcdm6mDLj3QlazGncmFi80BuLkoju2hZlF/zr6kxMXq8Pys+L502YDlWif
         xRaJKtr1JbeDFpqyBjSM288xJgoOHl/EMBDh7lwKagFjN+cEvIGdqgCM45onQgt08IfW
         aqNY4g9vYMwDsR5UnfrFsCXwv9EK6XBrMC8DbUJTrxWbLSv/jd/y0xTnoHTiegZlzcfF
         0cfq/9hl/nK+0uM1n4S6bMk3TnCV6dt0wLscw5ILcmT+KEfOT2bgBHeG3DXvEkbhKN9J
         mV9pSWD/AHHFVQMOovIiqVMCFn1QqXKk7RYvrMZEZvlMkGHo07qQLwnAGKZ8eihlAfFA
         JJtg==
X-Forwarded-Encrypted: i=1; AHgh+RpQ0sDePaNcxCM5g3L6CNSP1kQvX2QpdAVStiYH7acx5JtItlfDn0JQHyRkhLRqd+W97OdBok8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoLP5S3/8E7u0RJo2cyxYsZ3rrDpIVlLC5+/zfzFbObXqL5Q1h
	5GTPZ39SmfvUcfRjfxYaWxPNSXgHOIWDJeDpc2uafhMWDPq1VtHyWhC8z84sfKIU2Zk=
X-Gm-Gg: AfdE7cmw7x9HDXE1CI6bce82Qgv1ymb0fmg8Mg339fC0OH4eZz9lmPjc/B3Mg3W5SXH
	tr4rBaX7cB4cV+ZXniubTxY/x1Vzh+p8mKdunrloKNV9hXCxjaIk3WNDKtquAobOK2ds5OMEO1T
	Wi4wZaGEHfMD02/fHBQAR85dcBnr65KVy32i6VCB7E8M5z8Z0kb8PTqvlghWs5d2WSO5BLKERJ+
	n0XDK8UbVLIYrRNRgw6TmQmWtrx4P+W6ynMofiHT7XqiEqZicN0jXTAeBWBmkW1A3jxp//319nv
	kse6lNJaxlofNA43T3qustiILBuQiB6jBlX5LWZjOYVXhDHJPZb7UIS8PpnIU108vYbI9vHfAsI
	SZD28iIn2RtJNPZgzKh5jhjH71vHgIZCRrihR9AhzLvR2L3anfo7UgmWRYna3qi+bCvvMpG6ZSa
	lwEVgZ
X-Received: by 2002:a05:7300:4304:b0:304:d14b:b706 with SMTP id 5a478bee46e88-30c6937271bmr1341249eec.27.1782259797305;
        Tue, 23 Jun 2026 17:09:57 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::2526])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c52daf89dsm9570073eec.31.2026.06.23.17.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 17:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 20:09:54 -0400
Message-Id: <DJGUDAI4O70K.38X2CYVLBBLI7@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <edumazet@google.com>, <john.fastabend@gmail.com>, <jordan@jrife.io>,
 <kuba@kernel.org>, <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
 <netfilter-devel@vger.kernel.org>, <pabeni@redhat.com>,
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v8 1/7] net: move netfilter
 nf_reject_fill_skb_dst to core ipv4
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mahe Tardy" <mahe.tardy@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260622120515.137082-1-mahe.tardy@gmail.com>
 <20260622120515.137082-2-mahe.tardy@gmail.com>
In-Reply-To: <20260622120515.137082-2-mahe.tardy@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:kuba@kernel.org,m:martin.lau@linux.dev,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:pabeni@redhat.com,m:yonghong.song@linux.dev,m:mahe.tardy@gmail.com,m:bpf@vger.kernel.org,m:johnfastabend@gmail.com,m:mahetardy@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301520-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,google.com,gmail.com,jrife.io,linux.dev,vger.kernel.org,redhat.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,etsalapatis-com.20251104.gappssmtp.com:dkim,etsalapatis.com:email,etsalapatis.com:mid,etsalapatis.com:from_mime,jrife.io:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E4D36BAABF

On Mon Jun 22, 2026 at 8:05 AM EDT, Mahe Tardy wrote:
> Move and rename nf_reject_fill_skb_dst from
> ipv4/netfilter/nf_reject_ipv4 to ip_route_reply_fill_dst in ipv4/route.c
> so that it can be reused in the following patches by BPF kfuncs.
>
> Netfilter uses nf_ip_route that is almost a transparent wrapper around
> ip_route_output_key so this patch inlines it.
>
> Reviewed-by: Jordan Rife <jordan@jrife.io>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/net/route.h                 |  1 +
>  net/ipv4/netfilter/nf_reject_ipv4.c | 19 ++-----------------
>  net/ipv4/route.c                    | 15 +++++++++++++++
>  3 files changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/include/net/route.h b/include/net/route.h
> index f90106f383c5..300d292cd9a1 100644
> --- a/include/net/route.h
> +++ b/include/net/route.h
> @@ -173,6 +173,7 @@ struct rtable *ip_route_output_flow(struct net *, str=
uct flowi4 *flp,
>  				    const struct sock *sk);
>  struct dst_entry *ipv4_blackhole_route(struct net *net,
>  				       struct dst_entry *dst_orig);
> +int ip_route_reply_fill_dst(struct sk_buff *skb);
>
>  static inline struct rtable *ip_route_output_key(struct net *net, struct=
 flowi4 *flp)
>  {
> diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_=
reject_ipv4.c
> index fecf6621f679..c1c0724e4d4d 100644
> --- a/net/ipv4/netfilter/nf_reject_ipv4.c
> +++ b/net/ipv4/netfilter/nf_reject_ipv4.c
> @@ -252,21 +252,6 @@ static void nf_reject_ip_tcphdr_put(struct sk_buff *=
nskb, const struct sk_buff *
>  	nskb->csum_offset =3D offsetof(struct tcphdr, check);
>  }
>
> -static int nf_reject_fill_skb_dst(struct sk_buff *skb_in)
> -{
> -	struct dst_entry *dst =3D NULL;
> -	struct flowi fl;
> -
> -	memset(&fl, 0, sizeof(struct flowi));
> -	fl.u.ip4.daddr =3D ip_hdr(skb_in)->saddr;
> -	nf_ip_route(dev_net(skb_in->dev), &dst, &fl, false);
> -	if (!dst)
> -		return -1;
> -
> -	skb_dst_set(skb_in, dst);
> -	return 0;
> -}
> -
>  /* Send RST reply */
>  void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *old=
skb,
>  		   int hook)
> @@ -279,7 +264,7 @@ void nf_send_reset(struct net *net, struct sock *sk, =
struct sk_buff *oldskb,
>  	if (!oth)
>  		return;
>
> -	if (!skb_dst(oldskb) && nf_reject_fill_skb_dst(oldskb) < 0)
> +	if (!skb_dst(oldskb) && ip_route_reply_fill_dst(oldskb) < 0)
>  		return;
>
>  	if (skb_rtable(oldskb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
> @@ -352,7 +337,7 @@ void nf_send_unreach(struct sk_buff *skb_in, int code=
, int hook)
>  	if (iph->frag_off & htons(IP_OFFSET))
>  		return;
>
> -	if (!skb_dst(skb_in) && nf_reject_fill_skb_dst(skb_in) < 0)
> +	if (!skb_dst(skb_in) && ip_route_reply_fill_dst(skb_in) < 0)
>  		return;
>
>  	if (skb_csum_unnecessary(skb_in) ||
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 3f3de5164d6e..f24609933fbe 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -2942,6 +2942,21 @@ struct rtable *ip_route_output_flow(struct net *ne=
t, struct flowi4 *flp4,
>  }
>  EXPORT_SYMBOL_GPL(ip_route_output_flow);
>
> +int ip_route_reply_fill_dst(struct sk_buff *skb)
> +{
> +	struct rtable *rt;
> +	struct flowi4 fl4 =3D {
> +		.daddr =3D ip_hdr(skb)->saddr
> +	};
> +
> +	rt =3D ip_route_output_key(dev_net(skb->dev), &fl4);
> +	if (IS_ERR(rt))
> +		return PTR_ERR(rt);
> +	skb_dst_set(skb, &rt->dst);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ip_route_reply_fill_dst);
> +
>  /* called with rcu_read_lock held */
>  static int rt_fill_info(struct net *net, __be32 dst, __be32 src,
>  			struct rtable *rt, u32 table_id, dscp_t dscp,
> --
> 2.34.1


