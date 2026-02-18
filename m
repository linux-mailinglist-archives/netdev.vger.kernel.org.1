Return-Path: <netdev+bounces-259339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHzNGBL9lWm/XwIAu9opvQ
	(envelope-from <netdev+bounces-259339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 18:55:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6688158713
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 18:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 701A43018BEC
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 17:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E423446AB;
	Wed, 18 Feb 2026 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdgQgaNi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C170238C29
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771437318; cv=none; b=QNNEfh737kWMxG/E65Wqr/Hnmov63F12JXakuYHqBXnTOcNxmefGWMQDfvVqlOo8d/gU+zOpa4KWFxGuNevSD8x0sjDOet9Wrz15uFaR9Hp1jLt87CFPmGZIRocxsanvZacW7h7C1a7yNS3rT6FSkDsKopB+yc5oB2jiMdNuQeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771437318; c=relaxed/simple;
	bh=1qN6+A28/pt88lO3FJpQg+a31lpcoYR5RTGDzaMoak4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhP6Xur0aBqL2wdvc38yXMpqeS17+ztQKkLbyjdHi4S7XUAVQIz9L4P1tB4mCU4eBPW4C9LVf6CZx9pclRYKMrdFupz23aSfvr6qIbSoRrfhOeJxdP+NoAQbNEz+WKe/x8MRxCT4xrUm3QFaz+EbZCcjvJFhuHaSjVH95GXo37I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdgQgaNi; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506c02ec1b3so1859821cf.0
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 09:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771437316; x=1772042116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSK4YnOKTUFeSTgqI6iNtHiqzJw/Xmlr9/hUIirpfpE=;
        b=MdgQgaNi0lYNRhyb7r++4Yl9c3UpaX5q5lV0iOZN7SAA7jMwq9fkR5GV8MSPTKjqJE
         umzEI5LhdxwDnRM17TqCoxJUdnNKkruCfSg0d8addHXD1mYDQ24Nx66steqyuTugvG2l
         O4hwsShCrz+J2p1jXZGrN8ExqcenYPCV45gZN7YeFPFWLe1FrvrCUd7oMuwEOG9ORE3a
         YjMROg73OFJo4+F3davdDuTFSDnmbOge1caeuTGx/KJe6bMiIO+d0pOAAc5SoTcyqzBT
         Hf911R02rF6F4D9MAmYE/CiFIvXVOhYdt6jvOswcZsD+EakoN0poW1LmraaosHEsf1Wi
         ePsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771437316; x=1772042116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSK4YnOKTUFeSTgqI6iNtHiqzJw/Xmlr9/hUIirpfpE=;
        b=r3dAvMsUivL/an1iiTodBT1rKMhtcHe5afmOevikqYaHWWVjz16RzoCPM58pHVTylg
         qbaWUqdstufq3+6PRBGO2SpAVU6aHIegAMLNvlGefYaxH+66Y2ifttFHvkyER0gYz4HA
         UYPSyPSYCgap78q90NDGrKkxvfJOVa/aY3XOvbPlPk3xVDMX8qMye47xitPjFUX0E8Kx
         jDbqi83nt85IoTlTqEY6dcaaGS3PVZ3FgGBmmyICb7nRPU1QGUZtMBctYrlre/X/adTR
         Rp+XhdpxjWD4psRe4sMm7310kQdiOIR6880grV0ON99qXl5s3TluXSWlZYh9dg9Pe1uA
         1XMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaOSoXlk+M6qyY1gNc+9KSswJVE2dlW/5SmJLTUwRPEMyEQirZtMlRwaVBaorl54DH/IuDhuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJX/y1q5CSIs/2Yq+sr4KyduMNWJc4WeYGXZQfGTp34QWC1tzc
	rAdJjCW7fSubNV2MZGsCxDsw5GVjufuOZi+ZvUtHQxOHcpmmKOhhWnqx
X-Gm-Gg: AZuq6aL6tIjVkcbqmwOtC/6hR44b/5n3SqOMQ6Bvk1gjYuKcLUheX8bxbiv3fGl3QP2
	oC4XcFQ/GCSZs2XUpA1jPZL5YhqCZSN+i+SORgaH3QQTlRKdg8VXjA1N/M0rpQMALvnwueXz6jA
	ImGEKnoGh0r8vEC0193r43elqCK0PyZCCLXCmcsYMY+uaxlLMiAvhLBrMKhRaWq35JR/lD9c0FN
	wF4WHSUjP1UfCllztEBtnUcIi5dy2+Kx2+m4h9T/zo3rmI5cEU6uZJd19CFhFTdf4HIzxmvRqF/
	XmAeZu5OH2MT3JmalZsKmVRM+qRjXoLVD4QfplQ4yJ2f5Y9VTvk9kxrrUmnQb/lkziFw96MUN4w
	+nSYNjSiTtddxJayOswPX7g3+fhDsZp+qBLRGHrFR9vrsIVDJINYrOr2P9c6kYNH3bZAFrePDps
	uMxISK3Qrn7Q83NiUUjxg9zZBxWOMz7JA7qxkXQj6n6HN1KssavHjpsg==
X-Received: by 2002:a05:622a:5c7:b0:4ee:1dd0:5a50 with SMTP id d75a77b69052e-506e913132bmr32877541cf.17.1771437316193;
        Wed, 18 Feb 2026 09:55:16 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1145:4:70a9:dacc:ec4e:a432? ([2620:10d:c091:500::2:eb8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506bc1c3bfasm107289721cf.14.2026.02.18.09.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 09:55:15 -0800 (PST)
Message-ID: <24fb96ca-042c-46ce-93cd-a6c2ce710795@gmail.com>
Date: Wed, 18 Feb 2026 12:55:09 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] psp: use sk->sk_hash in psp_write_headers()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Raed Salem <raeds@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>
References: <20260218141337.999945-1-edumazet@google.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260218141337.999945-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,nvidia.com,google.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259339-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: B6688158713
X-Rspamd-Action: no action



On 2/18/26 9:13 AM, Eric Dumazet wrote:
> udp_flow_src_port() is indirectly using sk->sk_txhash as a base,
> because __tcp_transmit_skb() uses skb_set_hash_from_sk().
>
> This is problematic because this field can change over the
> lifetime of a TCP flow, thanks to calls to sk_rethink_txhash().
>
> Problem is that some NIC might (ab)use the PSP UDP source port in their
> RSS computation, and PSP packets for a given flow could jump
> from one queue to another.
>
> In order to avoid surprises, it is safer to let Protective Load
> Balancing (PLB) get its entropy from the IPv6 flowlabel,
> and change psp_write_headers() to use sk->sk_hash which
> does not change for the duration of the flow.
>
> We might add a sysctl to select the behavior, if there
> is a need for it.
>
> Fixes: fc724515741a ("psp: provide encapsulation helper for drivers")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: Raed Salem <raeds@nvidia.com>
> Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Cc: Cosmin Ratiu <cratiu@nvidia.com>
> Cc: Daniel Zahka <daniel.zahka@gmail.com>
> Cc: Willem de Bruijn <willemb@google.com>
> ---
>   net/psp/psp_main.c | 39 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> index a8534124f62669cf8b3611d5352e3827982d871d..066222eb56c4af187791445f30a70443aef8a6d8 100644
> --- a/net/psp/psp_main.c
> +++ b/net/psp/psp_main.c
> @@ -166,9 +166,46 @@ static void psp_write_headers(struct net *net, struct sk_buff *skb, __be32 spi,
>   {
>   	struct udphdr *uh = udp_hdr(skb);
>   	struct psphdr *psph = (struct psphdr *)(uh + 1);
> +	const struct sock *sk = skb->sk;
>   
>   	uh->dest = htons(PSP_DEFAULT_UDP_PORT);
> -	uh->source = udp_flow_src_port(net, skb, 0, 0, false);
> +
> +	/* A bit of theory: Selection of the source port.
> +	 *
> +	 * We need some entropy, so that multiple flows use different
> +	 * source ports for better RSS spreading at the receiver.
> +	 *
> +	 * We also need that all packets belonging to one TCP flow
> +	 * use the same source port through their duration,
> +	 * so that all these packets land in the same receive queue.
> +	 *
> +	 * udp_flow_src_port() is using sk_txhash, inherited from
> +	 * skb_set_hash_from_sk() call in __tcp_transmit_skb().
> +	 * This field is subject to reshuffling, thanks to
> +	 * sk_rethink_txhash() calls in various TCP functions.
> +	 *
> +	 * Instead, use sk->sk_hash which is constant through
> +	 * the whole flow duration.
> +	 */
> +	if (likely(sk)) {
> +		u32 hash = sk->sk_hash;
> +		int min, max;
> +
> +		/* These operations are cheap, no need to cache the result
> +		 * in another socket field.
> +		 */
> +		inet_get_local_port_range(net, &min, &max);
> +		/* Since this is being sent on the wire obfuscate hash a bit
> +		 * to minimize possibility that any useful information to an
> +		 * attacker is leaked. Only upper 16 bits are relevant in the
> +		 * computation for 16 bit port value because we use a
> +		 * reciprocal divide.
> +		 */
> +		hash ^= hash << 16;
> +		uh->source = htons((((u64)hash * (max - min)) >> 32) + min);
> +	} else {
> +		uh->source = udp_flow_src_port(net, skb, 0, 0, false);
> +	}
>   	uh->check = 0;
>   	uh->len = htons(udp_len);
>   

Thanks. The PSP spec suggests in multiple places the that udp sport be a 
hash derived from "inner header fields", so sk->sk_hash fits that 
description better than sk->sk_txhash regardless of RSS use/abuse 
categorization.

It occurs to me now that fc724515741a ("psp: provide encapsulation 
helper for drivers") also has a bug of unused udp sport parameter. I can 
send a fix for that later, unless you want to remove that as well.

Reviewed-By: Daniel Zahka <daniel.zahka@gmail.com>

