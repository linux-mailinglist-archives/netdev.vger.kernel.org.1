Return-Path: <netdev+bounces-289115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA0wDVU+C2oJFAUAu9opvQ
	(envelope-from <netdev+bounces-289115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:29:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF68570EA1
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C26F3004D12
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1711F2BE65F;
	Mon, 18 May 2026 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngFbfKCk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18903246BD5
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121073; cv=none; b=SWL1RQ2SilZXSFuqhFRE9q6W31ei2jexdq9pv5RtWN3dKviNJgSAFtGx8SiC936RHVxFPS6YsUALu+c2zuXM/4m4RmYkpnabhIxSMu756B8L92aapEiLOMyCXcgFHc0a86EWOp7XMvfNZ5Zb58bT5ELu01s8QJVSQjmxasrr1lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121073; c=relaxed/simple;
	bh=y/Ck4btyjHM5/jVnV3S2iDN9W4wWxh7IWDvICNTmyaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbVj/DHXLimDXPPxpM25R4StA4kPm90Op7aosox7ePSXbZidxUPeX6GiNVvrkCvacuSMn+XoHoi4xvf3qXg1NhLe10cLZg4+vnETfOXZWAjGJ7+lovjajZyDzaSNvtq+603ATyW/9zKibeonW9qiKqH5QW+v4u1BpX7BtAg8h78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngFbfKCk; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7bf0b1a47b1so19884357b3.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 09:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779121066; x=1779725866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v/OH0BRtpRw1M3FuVaNDUvm/zDHm0O0pCgI7eSycbdU=;
        b=ngFbfKCk9AamwXrwmjkloy4KkRyDt8vU26A8zbxwX25PXzlhBnnoexsPWhU5XIyRwd
         +Shr1i5M7HF9IkbXvJXFJGi1nHgQ6elnZDKac4qxmTm8ybZr2qE+eSx0G5gpRc68vhYb
         eqfejstQUzh3lsbWHA/Ohv8/OlRSgI21omEHTxG91tNzvyZXGq1qLwYBRIiK/z2TN3Ji
         Xmn40RX8QOz3FXTGJDR/El404Syn0h3D5x5NaJ5OUfLweWJGhpLdIGHH3hmXfVzx4Dix
         7DC/U8DIcMdGuQ30Edn10IbyK7/6Q9WXqR4gkevoXJtf7ejJe1ryEEO83ie+zOrkUmua
         YmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779121066; x=1779725866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/OH0BRtpRw1M3FuVaNDUvm/zDHm0O0pCgI7eSycbdU=;
        b=XxbNgDWWz6Xfmy5j7wlgJG48mcM0V0nBaNDTYBLXiSylPRlZzEpBd5ffLfI6s0NuAf
         tOvjiEZykFZAsDNk/WFGuw1eKg5W9SEt9X/vDpSMB6n+c0I1+NPSCTya6vdoC1L6QYWM
         ktqDGRBDXeG25o3ao2XOAj3a4XHiQhk+CzYbEzGXL1N0jHXbGrIVCYubXsQLsb436oaL
         AUqNDhwdAXKgoXt9Tt4QByQfa8ztGZmSWljQFApDlLqNMK0vBOI5vc6qnmfxq3Dol+tI
         FYTeCOkhhHVo9sJvzkQ1ktSwskS4KmlwQ+50JUXiwpd5RVK2fr/hMeGwLQqhXJdrQ3mI
         LYEg==
X-Forwarded-Encrypted: i=1; AFNElJ+Qym+PDE4JDEofDcS+Fywx92eoMDY4rU2Fn1n2gkOvqTiPlkrD+m7EpLW+nSQmDOcsmBISdNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPId5bM33zfs1ILBPjwqsyrFth9YoLa/1I0DgWuP9Aob4Wy8TN
	lNGtK4sahUG+CLgiiyhu8cQ2bq6d2YPxCzyMiGVrhRStcKgqrISvwkTO+Kir9bUk
X-Gm-Gg: Acq92OH4pH51orrlpOusmccV1XPmu//wCkuS1BsGTkVxpLyKjqr7wGVZDU7LapfD60Z
	RX0HqaF0y3FzT/IGje13JN5t9o0ojytp1uc8P5Z556tsM+d5+HpdZ3XbjhmuMY4KaZVJKaiZV0/
	w0Cqu7KQBI1glF6baINi3+hvVpKe1PbS7Hwp8Q6cGC5epCfVJj89jgy4qlD55wGokfGxFPejLG2
	ws3AjH1+g2yt337HlnSNLumRBbhE2u9BI2ElaiSRQxcAm9yEmRv0dLXQHk80yyQnCnF5zsJ4JqE
	knFDeqh1GmoUZZEa80pmPQlMARd0StfpRLlxcZ+U/OGyB/0dV/YL3EHz9Ucc0acZSaxnGJ0oTFh
	7e9vkg5G1uvhT4gsRZn2J5n1qaYj28EvdFsRb2vy8ePP45VOiTDInc5zM/iznNGnt5PJZg4bS4S
	oZViBJwarxJbiD
X-Received: by 2002:a05:690c:6d84:b0:79a:d2ba:3c24 with SMTP id 00721157ae682-7c95cbe8677mr175819657b3.41.1779121066147;
        Mon, 18 May 2026 09:17:46 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9c6cd4f5sm23720227b3.35.2026.05.18.09.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:17:45 -0700 (PDT)
Date: Mon, 18 May 2026 09:17:45 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net, 
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org, yonghong.song@linux.dev, 
	jordan@jrife.io, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH bpf-next v6 3/6] bpf: add bpf_icmp_send kfunc
Message-ID: <ags3HARTFYwKU8nR@devvm7509.cco0.facebook.com>
References: <20260518122842.218522-1-mahe.tardy@gmail.com>
 <20260518122842.218522-4-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260518122842.218522-4-mahe.tardy@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289115-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,iogearbox.net,gmail.com,kernel.org,jrife.io,google.com,redhat.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: CBF68570EA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/18, Mahe Tardy wrote:
> This is needed in the context of Tetragon to provide improved feedback
> (in contrast to just dropping packets) to east-west traffic when blocked
> by policies using cgroup_skb programs. We also extend this kfunc to tc
> program as a convenience.
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
> For now, we support cgroup_skb and tc program types. For cgroup_skb and
> tc egress, almost everything should be good. However for tc ingress:
> - packet will not be routed yet: need to set the net device for
>   icmp_send, thus the call to ip[6]_route_reply_fill_dst.
> - fragments could trigger hook: icmp_send will only reply to fragment 0.
> - ensure the ip headers is linearized before processing, and zero out
>   the SKB control block after cloning to prevent icmp_send()/icmpv6_send()
>   from misinterpreting garbage data as IP options.
> 
> Only ICMP_DEST_UNREACH and ICMPV6_DEST_UNREACH are currently supported.
> The interface accepts a type parameter to facilitate future extension to
> other ICMP control message types.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  net/core/filter.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714..843fa775596b 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -84,6 +84,8 @@
>  #include <linux/un.h>
>  #include <net/xdp_sock_drv.h>
>  #include <net/inet_dscp.h>
> +#include <linux/icmpv6.h>
> +#include <net/icmp.h>
> 
>  #include "dev.h"
> 
> @@ -12464,6 +12466,110 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
>  	return 0;
>  }
> 
> +static DEFINE_PER_CPU(bool, bpf_icmp_send_in_progress);
> +
> +/**
> + * bpf_icmp_send - Send an ICMP control message
> + * @skb_ctx: Packet that triggered the control message
> + * @type: ICMP type (only ICMP_DEST_UNREACH/ICMPV6_DEST_UNREACH supported)
> + * @code: ICMP code (0-15 for IPv4, 0-6 for IPv6)
> + *
> + * Sends an ICMP control message in response to the packet. The original packet
> + * is cloned before sending the ICMP message, so the BPF program can still let
> + * the packet pass if desired.
> + *
> + * Currently only ICMP_DEST_UNREACH (IPv4) and ICMPV6_DEST_UNREACH (IPv6) are
> + * supported.
> + *
> + * Recursion protection: If called from a context that would trigger recursion
> + * (e.g., root cgroup processing its own ICMP packets), returns -EBUSY on
> + * re-entry.
> + *
> + * Return: 0 on success, negative error code on failure:
> + *         -EINVAL: Invalid code parameter
> + *         -EBADMSG: Packet too short or malformed
> + *         -ENOMEM: Memory allocation failed
> + *         -EBUSY: Recursion detected
> + *         -EHOSTUNREACH: Routing failed
> + *         -EPROTONOSUPPORT: Non-IP protocol
> + *         -EOPNOTSUPP: Unsupported ICMP type
> + */
> +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
> +{
> +	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
> +	struct sk_buff *nskb;
> +	bool *in_progress;
> +
> +	in_progress = this_cpu_ptr(&bpf_icmp_send_in_progress);
> +	if (*in_progress)
> +		return -EBUSY;
> +
> +	switch (skb->protocol) {
> +#if IS_ENABLED(CONFIG_INET)
> +	case htons(ETH_P_IP):
> +		if (type != ICMP_DEST_UNREACH)
> +			return -EOPNOTSUPP;
> +		if (code < 0 || code > NR_ICMP_UNREACH)
> +			return -EINVAL;
> +
> +		nskb = skb_clone(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		if (!pskb_network_may_pull(nskb, sizeof(struct iphdr))) {
> +			kfree_skb(nskb);
> +			return -EBADMSG;
> +		}
> +
> +		if (!skb_dst(nskb) && ip_route_reply_fill_dst(nskb) < 0) {
> +			kfree_skb(nskb);
> +			return -EHOSTUNREACH;
> +		}
> +
> +		memset(IPCB(nskb), 0, sizeof(struct inet_skb_parm));
> +
> +		*in_progress = true;
> +		icmp_send(nskb, type, code, 0);
> +		*in_progress = false;

[..]

> +		kfree_skb(nskb);

I was going to suggest to use consume_skb here, I think it is a better fit?

But I'm not sure why you do the clone here, I don't see any requirement from
the icmp_send side, can you clarify? Is it because of the pull?

