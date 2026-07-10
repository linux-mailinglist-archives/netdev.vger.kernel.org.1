Return-Path: <netdev+bounces-306393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WI6gGlI5UGoYvQIAu9opvQ
	(envelope-from <netdev+bounces-306393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 02:14:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B48AD736525
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 02:14:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NaRXMUXK;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306393-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306393-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FE023032774
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 00:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8F611CA9;
	Fri, 10 Jul 2026 00:13:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205E1DFDE
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 00:13:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783642421; cv=none; b=Qb8YqTi+34bGiVdFYK7nH/5xtNo3TRID00COa9D/th4ijVnNjatOCk0x1OWIJeSqT0pgoDCfG4UaBLEQepTpyA5TOMRZpcY6rIlDArBIBApxGqcGOL/ybzXAVs2ZLkM0o5h5G+WiTjy42PS3xOJT2b25THu8aPTw9f8hcGzhgj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783642421; c=relaxed/simple;
	bh=Ugh/OpEP8n4AayGypRHKYHXqEemDcC9LJUjQgnKPGI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUYn5Bg2OS2sT+tvv4Qbh1nvKyQ275YUOICG+JDbJrqQ5Wn7Q6MmWs28ZgTWWv+HdL4zMLVMyVVURJ59i9m7xTx9tT9A/H/USKQtigG0ElXL8S86UMTkjFdA1T3NtqTfdBHMe47zNHfbYRWaM8UJH7T3zaVbY/XCHm0kTMYzZlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaRXMUXK; arc=none smtp.client-ip=74.125.228.0
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c888c19b85dso64718a12.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 17:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783642419; x=1784247219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wnhaarTkKMQdrEB7M6qZBuO7dhcx30S+q+s0SvQiViM=;
        b=NaRXMUXKMbiLIAQ2ZXaFYbPwk7eIzWJGx5XRn0c7cVIBCB3Oxs4s7pY9ZdTb1nU+No
         NiQVAqer4ujbMgpyf1zcwHzn1UWA9us6L0rSuHpgK3Rp0HXKYM/wm9XSB5sNvsnpSjt1
         OOjHFsamm1ZmKwVghCWGh4GQyjwwh+cKg0LTVbdvfQW0HG8g6BaLSRcsOls01KtGLzml
         c1hncM+EGUi882JbF3MpCtUzv15YHS1xR4j0BjrgfxA8N9v2tgmxWMeE9mz04wUcR/pP
         NthUwsylKovEbq5m5szuCTly5vgNsCU3lR7xiUUQvafVjEFrYXYSIJNrcfAbs7X0n8TJ
         VQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783642419; x=1784247219;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wnhaarTkKMQdrEB7M6qZBuO7dhcx30S+q+s0SvQiViM=;
        b=j9nRYgnJcEqmJKqpwP/ZjH3zuH44tE/CxD0ZCLqWPcTdKg0YtCiTih/48lCfQNezGL
         o0FnIdk3wf6houENZgnRMTvIX5TAAEA9ttsaWGjVypyFeXu3N9sHvJo+DB37/NG7wD1r
         4DcLE4Fja4Aj4rH3md33NnHW81tuyHXmKdLdJS6r0bu9QK0sLKDXRvzwnRViLIWV5lWf
         +ml2It+uu/Z3kKn9Qd9C3hxJvpksQBpsv/fXBteA7X3A0Fibj679eUOhLJFxstdOb3dc
         TScoT3dZSbMsEZ+jZBFoKjTWBBQLgPld2+6DC9WZdwptKkDqs1hBOGCgpdiGFS209zKp
         yOdw==
X-Forwarded-Encrypted: i=1; AHgh+RquUKZ2KQgNZbXyxAO387IA/+MS/btUQedYNH+la7oSEu3ygk+JVRMk9dOIqaxlGh4y2r26L44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrKZ3LY5ts2bj5Yx+257CRcNIZPCqomF13WcwTbCalw6JcGrBs
	vdSnMxd6IgYpvao6OHEoNUioSCRkA7z0vCn86w5ewPm08yPnq1SbxETI
X-Gm-Gg: AfdE7clL9p01snmzWz8ymGBAUJxPr24rFzj5jo4KubfMFA9nw69vkVmm0yizdbQAfA5
	/asL0vmP+KZvg16EE5OHseQ0heWWdHByP0ghWtw7xj90pkSV7XcNUFE+dwFf41UMX0HGQx+rhYH
	sVSN0sq1AR8zFyFYxklB6VegIjPXBEyd2yUAddHQSmPzZ/eDHTcJvsMq5yNUHZWEFW57s28rWrT
	zzBQJM4iUSqVlH9T+CsAFnEBoOKIYkGeqnfQeXmBoYTMk5GTkJIm/ZmiquU/6YkKJOd8h+8+jxq
	HupU6hF2rv8rfMCxH8h7saPzN2/09/WovRs08BS/Mtk7m9K/02+rPmNZLHZYWxAiuo9XG5dwNw0
	4RqMUkRpUwMOsoKdSSdrqHne8HzyNEO3MHqwa7cHECxs8my5z0A+ssLzELTfaPqLApwXgKqHaDT
	NXBozh
X-Received: by 2002:a05:6a00:451a:b0:842:6a3b:60d1 with SMTP id d2e1a72fcca58-84842f01e28mr9455961b3a.31.1783642419243;
        Thu, 09 Jul 2026 17:13:39 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8484123ce87sm3534608b3a.58.2026.07.09.17.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 17:13:38 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:12:21 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, jordan@jrife.io, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com, netdev@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	horms@kernel.org
Subject: Re: [PATCH bpf-next v11 1/5] bpf: add bpf_icmp_send kfunc
Message-ID: <alA4xtY1HGl4Fygf@devvm7509.cco0.facebook.com>
References: <20260709144900.245904-1-mahe.tardy@gmail.com>
 <20260709144900.245904-2-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709144900.245904-2-mahe.tardy@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306393-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mahe.tardy@gmail.com,m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:martin.lau@linux.dev,m:yonghong.song@linux.dev,m:emil@etsalapatis.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,m:mahetardy@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,jrife.io,linux.dev,etsalapatis.com,google.com,redhat.com,davemloft.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,devvm7509.cco0.facebook.com:mid,etsalapatis.com:email,jrife.io:email,fomichev.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B48AD736525

On 07/09, Mahe Tardy wrote:
> This is needed in the context of Tetragon to provide improved feedback
> (in contrast to just dropping packets) to east-west traffic when blocked
> by policies using cgroup_skb programs.
> 
> This reuses concepts from netfilter reject target codepath with the
> differences that:
> * Packets are cloned since the BPF user can still let the packet pass
>   (SK_PASS from the cgroup_skb progs for example) and the current skb
>   need to stay untouched (cgroup_skb hooks only allow read-only skb
>   payload).
> * We protect against recursion since the kfunc, by generating an ICMP
>   error message, could retrigger the BPF prog that invoked it.
> 
> Only ICMP_DEST_UNREACH and ICMPV6_DEST_UNREACH are currently supported.
> The interface accepts a type parameter to facilitate future extension to
> other ICMP control message types.
> 
> For normal cgroup_skb paths, the skb dst route should already be set.
> However, bpf_prog_test_run_skb can create synthetic IPv4/IPv6 skbs
> without an attached route. In that case, icmp_send returns early, and
> the kfunc would otherwise report success despite no ICMP reply being
> sent. This check also reject metadata dsts, which are not valid struct
> rtable instances. While IPv6 would stricly require only rejecting
> metadata dsts, same check is applied for API consistency.
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Reviewed-by: Jordan Rife <jordan@jrife.io>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  net/core/filter.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 4f5cbcac3e78..e4697036c67b 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -84,6 +84,9 @@
>  #include <linux/un.h>
>  #include <net/xdp_sock_drv.h>
>  #include <net/inet_dscp.h>
> +#include <linux/icmpv6.h>
> +#include <net/icmp.h>
> +#include <net/ip6_route.h>
> 
>  #include "dev.h"
> 
> @@ -12548,6 +12551,83 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
>  	return 0;
>  }
> 
> +/**
> + * bpf_icmp_send - Send an ICMP control message
> + * @skb_ctx: Packet that triggered the control message
> + * @type: ICMP type (only ICMP_DEST_UNREACH/ICMPV6_DEST_UNREACH supported)
> + * @code: ICMP code (0-15 except ICMP_FRAG_NEEDED for IPv4, 0-6 for IPv6)
> + *
> + * Sends an ICMP control message in response to the packet. The original packet
> + * is cloned before sending the ICMP message, so the BPF program can still let
> + * the packet pass if desired.
> + *
> + * Currently only ICMP_DEST_UNREACH (IPv4) and ICMPV6_DEST_UNREACH (IPv6) are
> + * supported.
> + *
> + * Return: 0 on success (send attempt), negative error code on failure:
> + *         -EBUSY: Recursion detected
> + *         -EPROTONOSUPPORT: Non-IP protocol
> + *         -EOPNOTSUPP: Unsupported ICMP type
> + *         -EINVAL: Invalid code parameter
> + *         -ENETUNREACH: No usable route/dst for the ICMP reply
> + *         -ENOMEM: Memory allocation failed
> + */
> +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
> +{
> +	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
> +	struct sk_buff *nskb;
> +	struct sock *sk;
> +
> +	sk = skb_to_full_sk(skb);
> +	if (sk && sk->sk_kern_sock &&
> +	    (sk->sk_protocol == IPPROTO_ICMP || sk->sk_protocol == IPPROTO_ICMPV6))
> +		return -EBUSY;
> +
> +	if (!skb_valid_dst(skb))
> +		return -ENETUNREACH;

This looks much better, thanks!

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

