Return-Path: <netdev+bounces-300615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Emb5KIDjNGqTjQYAu9opvQ
	(envelope-from <netdev+bounces-300615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:36:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2786A424E
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:36:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=J4eR327p;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300615-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300615-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A124304D757
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 06:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F97A3563F6;
	Fri, 19 Jun 2026 06:35:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C659D35202C
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 06:35:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781850934; cv=none; b=fty6PUQpKhfda58VCUkLLKfmjJjkbEHPO8iVHZY7KbY2t7ysxl7p0m6296BcRHcZI/cmKF5SX7qEiOMg8Sp4+351A5GpBThxMI0Ed/qEL0OsmXHxNBzyLKt0qWQWQPfSZE3q0EPgUEcoR/syi+H0W8T4raG49pkZjaZFChPENfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781850934; c=relaxed/simple;
	bh=RNjabRwXK1Z7FZ9lk2kM6y2NStALK3Vm+iaCUMQeBWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgfTTfh9Gg4wDtgg10dcCkkggNyj4YQvxAXJinTkRjkvD/aUpkVuckBCn59G1QUqeWum2JFToSlGwMaLBM710dGmD0WuCuWVnLyDqWIbwYQwmKioe2YA4mQnGseYN28P9QnTN/uS0qEa/EgtsXQ53cdPQQvG0NxSSjl//RDnKyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J4eR327p; arc=none smtp.client-ip=95.215.58.186
Message-ID: <28f794e5-2fe8-4594-a19c-d4c936350cb5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781850930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vw5G3TGXS5qxXLkjU6JHXsllZyv22COyQsCV1sVQgss=;
	b=J4eR327paA+7AvoqSL7vpQ3TXaGM0kVFEpRCU5gyUrEK1Ytj+yBIAM5KhgKBdNXh1jBH4g
	zI1Gf7J23TZFCy5ir2QTywJ1WW895bSEuNw4GI+1iGnSiUhmY1vixlSBgntAyJRXFUr7IX
	X+8uKsRA3MyoZOA/8qzCT6reRSLBIJQ=
Date: Fri, 19 Jun 2026 14:35:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 2/3] bpf, sockmap: reject a packet-modifying SK_SKB
 stream parser
To: Sechang Lim <rhkrqnwk98@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, Shuah Khan <shuah@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260619062959.3277612-1-rhkrqnwk98@gmail.com>
 <20260619062959.3277612-3-rhkrqnwk98@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260619062959.3277612-3-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300615-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net,cloudflare.com,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:ast@kernel.org,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:kuniyu@google.com,m:willemb@google.com,m:shuah@kernel.org,m:jolsa@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:horms@kernel.org,m:bobbyeshleman@gmail.com,m:jiayuan.chen@linux.dev,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C2786A424E


On 6/19/26 2:29 PM, Sechang Lim wrote:
> sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program
> to find the length of the next message. strparser assembles a message out
> of several received skbs by chaining them onto the head's frag_list and
> recording where to append the next one in strp->skb_nextp:
>
> 	*strp->skb_nextp = skb;
> 	strp->skb_nextp = &skb->next;
>
> and then calls the parser on the head:
>
> 	len = (*strp->cb.parse_msg)(strp, head);
>
> The parser is only meant to inspect the skb, but the program may call
> bpf_skb_change_tail() -- or the sibling bpf_skb_pull_data(),
> bpf_skb_change_head(), bpf_skb_adjust_room(), all allowed for SK_SKB.
> Once the head carries a frag_list these go
>
> 	... -> skb_ensure_writable -> pskb_may_pull -> __pskb_pull_tail
>
> and __pskb_pull_tail() frees the frag_list skbs that strparser still
> tracks through skb_nextp:
>
> 	while ((list = skb_shinfo(skb)->frag_list) != insp) {
> 		skb_shinfo(skb)->frag_list = list->next;
> 		consume_skb(list);
> 	}
>
> strp->skb_nextp now points into a freed sk_buff. The next segment of
> the same message arrives in __strp_recv(), which links it with
> *strp->skb_nextp = skb, an 8-byte write into the freed skb. The free
> and the write happen in different __strp_recv() calls, so the message
> has to span at least three segments before it triggers.
>
>    BUG: KASAN: slab-use-after-free in __strp_recv+0x447/0xda0
>    Write of size 8 at addr ffff88810db86140 by task repro/349
>
>    Call Trace:
>     <IRQ>
>     __strp_recv+0x447/0xda0
>     __tcp_read_sock+0x13d/0x590
>     tcp_bpf_strp_read_sock+0x195/0x320
>     strp_data_ready+0x267/0x340
>     sk_psock_strp_data_ready+0x1ce/0x350
>     tcp_data_queue+0x1364/0x2fd0
>     tcp_rcv_established+0xe07/0x1640
>     [...]
>
>    Allocated by task 349:
>     skb_clone+0x17b/0x210
>     __strp_recv+0x2c3/0xda0
>     __tcp_read_sock+0x13d/0x590
>     [...]
>
>    Freed by task 349:
>     kmem_cache_free+0x150/0x570
>     __pskb_pull_tail+0x57b/0xc20
>     skb_ensure_writable+0x236/0x260
>     __bpf_skb_change_tail+0x1d4/0x590
>     sk_skb_change_tail+0x2a/0x40
>     bpf_prog_1b285dcd6c41373e+0x27/0x30
>     bpf_prog_run_pin_on_cpu+0xf3/0x260
>     sk_psock_strp_parse+0x118/0x1e0
>     __strp_recv+0x4f6/0xda0
>     [...]
>
> The same resize also leaves the head's length inconsistent with its
> frags, so a later __pskb_pull_tail() can instead hit the
> BUG_ON(skb_copy_bits(...)) in net/core/skbuff.c.
>
> A stream parser is only meant to measure the next message, not to modify
> the packet. Reject a parser whose program can change packet data
> (prog->aux->changes_pkt_data) at attach time. The check is shared by
> sock_map_prog_update() and sock_map_link_update_prog(), which between them
> cover prog attach, link create and link update. Verdict programs are
> unaffected and may still modify the skb.
>
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


