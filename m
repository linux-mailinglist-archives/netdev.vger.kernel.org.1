Return-Path: <netdev+bounces-278345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG65GiYB3mkRmAkAu9opvQ
	(envelope-from <netdev+bounces-278345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:56:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 913593F78F9
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E75B302F59B
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D823B7744;
	Tue, 14 Apr 2026 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKKyqhqO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8045Z7D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68EC1A23A4
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776156838; cv=none; b=X4LOTgDPObLFAC5V1yHnkM3DA3wFJ/UJlV7UlZPTzuWLAwWT7jx4sEAmy79ffInxUTSpT64yZO6eLC1g2iVuZK8BYngiCYKMneBhZhQZmIadh+bBeyZvyYiQ9Rb8l0oDqb8K6EOFep+5LzbyLjdNBnjrLiqxLjJJkSwNtQQkoR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776156838; c=relaxed/simple;
	bh=OVu9KdSJZseM7Nt2ItB4OpCFv/h6niQO/sezNN27FOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMqQfvkFoqycBXzgFP0wqQH6fsdfx0mPEkGrmQF6dxGiqh6B+yPzHlnI+joUcykntmkIfJrzpEQjs04kNF5K8Xu3PCNZy1nfLn/dudDdu5HIgHCIlxwpc262KxQPlQB+C50I6Mt+utk5y4PRthU6ElkdYraOmhmtL+9zddjY/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CKKyqhqO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8045Z7D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776156835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oxmBacf55etftW8UnPkV/EpOImxHgh4CswOaaLPDOw4=;
	b=CKKyqhqO2So0XpOB4Uh/L9Kq3rF8sqLrwta2N8pLYMrogylHIgUicCxeMU9HRexeSicwts
	ryvVpSAg5otUrSF0cqmkD9nQCFSiYE3zghYUchT/hVf9rw6DZrTGxATC6+6sYtVBi0gObC
	PLlgM6rO4wcefbgrdtsUTaDEAgeerAw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-hMkS07mgP9OVxFPAgcG5_Q-1; Tue, 14 Apr 2026 04:53:54 -0400
X-MC-Unique: hMkS07mgP9OVxFPAgcG5_Q-1
X-Mimecast-MFC-AGG-ID: hMkS07mgP9OVxFPAgcG5_Q_1776156833
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488c74405ecso32623585e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 01:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776156833; x=1776761633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oxmBacf55etftW8UnPkV/EpOImxHgh4CswOaaLPDOw4=;
        b=D8045Z7DM4W6TRMmcU3o9sEfc1br3fLGCCWbiZy6gZ036NAzT2SNL1ZO0JRVW9NAv7
         +/L+RVVPNigrXF2DTqzeIkotIPNfokQwJlrQj5oUABBwTuD4dKek5A2WdNiDzYj3S+uZ
         L+V/TSILikmX0dFpylurwkW4cfw8vTYf0J50Xl3K60H7BGw56Kxx5bCe3AtsBCQJqyE4
         ZP6Z+02zx609KNdcioUQv61v9vxZ085+TxmI0XxZ8uYCRh5+ukpYnv4RnljYl7uJXE7o
         2QmZ2mQTdTw91jnJEA4CyPcHyrNgZyJ2USNACTRucftITeH+uT4Xp798U2m5zXwONzmQ
         d8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776156833; x=1776761633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxmBacf55etftW8UnPkV/EpOImxHgh4CswOaaLPDOw4=;
        b=k4ukqTjJqq+nKIwoWeWD5EGQVCXAUY4QrBS70f5JGLc5Yk4uZValTN/sJC81PBANor
         kKBJCTErynQQEUqBWhsQvcrrZGC0rl/f9zR1NMLgBDuXByrYnwvB4ggGYSb2Cwnz2M4D
         5oudtrWi9XUt686uOlX4vzb9adIBT4JFSYcZN7UmHsRtnPcZPo1BSfpEMIwcgTTHeul9
         S3BOWrm4zBDBb6pMYiQnW8uIODXz48D6T2jwtL5XjMELp6uKapDMhqGKtGm4nmy1AdT6
         qOXe8VS2na9atkVSvAMVaJG08Wszb0UoYdbjJCYbHIjoHwxt2o77mdQ6hspZYgbZ8Dit
         xULg==
X-Forwarded-Encrypted: i=1; AFNElJ9Dpu9k8DMExBCmOHiIrKc6cKv38/DwYBSz5ruHbJZ069gLrY5j/EYgNsPas+ebrANQj2Nn58M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLwSkrkj8u2Qz7inoK6qsDGlL0kDzReZquq5swn1oAQ6S/QRDO
	21TzpU7yb0ujg7Cw8x1fdNPPon7pfgHVOyt4o/dhtu/pJqDjEqYUXvaH2aM/HCLmDz25h0COKGN
	sXm+KLhmY6lDJnN33yDZtyJQUn67KcVXQC9jV3dpXAsoUKtBGyx1lJZmOHg==
X-Gm-Gg: AeBDievCQiLHuQ6z3jKoiBF8eL+meAhVqStRMaYCoea74zOUCd/38SRSKWHiAHDszVe
	jRBZP6Ne9F8cQ/UtWzGtHlnnsijVL4TIEIlxNzXHHEMlp8Uzcb5VF78mmGKzc40yqFk9+CtAbmf
	ewi6cw+F2EbZIBFTskqBFYJN3M2kJTKQ3+53VmAYgYe519IP6gElpWdrAcy+RMxuuDUc0fRUpxp
	t/9MzyBLJVGDQPR6zeWqvj0W/doIt4sbVcBG/S4PCFLf1gqes8J67KgKkEFzWpaV+kW0guLOo1p
	0e1ntjyGbvCLyS1NQe0aRg4rG2ooXo/+P20Fd2Uoyhb3ZA8htyEFELWF7KAKobpcwzPMpbSTtUF
	MZneoivUdFWIrOrAVJlpfvObm+JS77NZCKXbzeGK9J28Khk+OBNv/pU5l
X-Received: by 2002:a05:600c:3150:b0:486:fcc7:d6a with SMTP id 5b1f17b1804b1-488d67f4c4dmr251372685e9.13.1776156833164;
        Tue, 14 Apr 2026 01:53:53 -0700 (PDT)
X-Received: by 2002:a05:600c:3150:b0:486:fcc7:d6a with SMTP id 5b1f17b1804b1-488d67f4c4dmr251372295e9.13.1776156832656;
        Tue, 14 Apr 2026 01:53:52 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d6f4bf2b4sm23579778f8f.20.2026.04.14.01.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 01:53:52 -0700 (PDT)
Message-ID: <c79bdb62-eab2-4bf3-af8b-3875730adc53@redhat.com>
Date: Tue, 14 Apr 2026 10:53:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v7 1/2] net, bpf: fix null-ptr-deref in
 xdp_master_redirect() for down master
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
 Martin KaFai Lau <martin.lau@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Jussi Maki <joamaki@gmail.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260411005524.201200-1-jiayuan.chen@linux.dev>
 <20260411005524.201200-2-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260411005524.201200-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,linux.dev,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-278345-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,linux.dev:email]
X-Rspamd-Queue-Id: 913593F78F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/11/26 2:55 AM, Jiayuan Chen wrote:
> syzkaller reported a kernel panic in bond_rr_gen_slave_id() reached via
> xdp_master_redirect(). Full decoded trace:
> 
>   https://syzkaller.appspot.com/bug?extid=80e046b8da2820b6ba73
> 
> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter, a per-CPU
> counter that bonding only allocates in bond_open() when the mode is
> round-robin. If the bond device was never brought up, rr_tx_counter
> stays NULL.
> 
> The XDP redirect path can still reach that code on a bond that was
> never opened: bpf_master_redirect_enabled_key is a global static key,
> so as soon as any bond device has native XDP attached, the
> XDP_TX -> xdp_master_redirect() interception is enabled for every
> slave system-wide. The path xdp_master_redirect() ->
> bond_xdp_get_xmit_slave() -> bond_xdp_xmit_roundrobin_slave_get() ->
> bond_rr_gen_slave_id() then runs against a bond that has no
> rr_tx_counter and crashes.
> 
> Fix this in the generic xdp_master_redirect() by refusing to call into
> the master's ->ndo_xdp_get_xmit_slave() when the master device is not
> up. IFF_UP is only set after ->ndo_open() has successfully returned,
> so this reliably excludes masters whose XDP state has not been fully
> initialized. Drop the frame with XDP_ABORTED so the exception is
> visible via trace_xdp_exception() rather than silently falling through.
> This is not specific to bonding: any current or future master that
> defers XDP state allocation to ->ndo_open() is protected.
> 
> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
> Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/core/filter.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index cf2113af4bc9..9ec70c4b7723 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4398,6 +4398,8 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
>  	struct net_device *master, *slave;
>  
>  	master = netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
> +	if (unlikely(!(master->flags & IFF_UP)))
> +		return XDP_ABORTED;
>  	slave = master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp);

The AI review noted that the master could be (theoretically) NULL here.
Since that event is not a regression (unconditional `master` dereference
already present) and syzkaller failed to trigger it (despite being the
sort of thing syzkaller is very good to find) make me thing it's better
to eventually follow-up instead requesting another revision here, but
please have a look.

Thanks,

Paolo

>  	if (slave && slave != xdp->rxq->dev) {
>  		/* The target device is different from the receiving device, so


