Return-Path: <netdev+bounces-289087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJDTKUciC2omDwUAu9opvQ
	(envelope-from <netdev+bounces-289087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:29:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C45C56ECA0
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97AA2301E202
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E4E3F58FF;
	Mon, 18 May 2026 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpNf0cNi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E514A49253E
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114088; cv=none; b=FnEq9THDR9P8x8lqBU2aNUAiDdNtH5FSHDwKC+drFy+e/IBUMXiY8E+PWBgcmrRRserlWaoiayc8HXvFdXMZoZ0rs7piMm75H/eVVVSfbQivCnlQemcCSZpJkaoKjqCpWAb6py8jJb7RGwyhDqWDAWb7tYU5kfWHj+7/S5Og19o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114088; c=relaxed/simple;
	bh=ViOooZ5q6HLjbn4PmRfwA6YbFDqGs3bxZJ7jJDAirp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPkFkkzf5+iH2QeL5cZNx8s+ziPJyxe72Ba63K0KQSk1XrhvKtFLbUaUvq380NTT0VTCGrChHs7yWWy6G65fiBOvEuTMbrlfu3jP6tXMQW6ZEQOkrENwtrB6d9+aLr9/NsP7qV58M1iLdyMdvqFkO0L3D7oclKfvgb1ZqEp3OJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpNf0cNi; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45d96d21e82so1362391f8f.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779114083; x=1779718883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EYFr7XXcKEsZj+Bv1UNXpfsZHaxqcET1cNdw3E5KQ6o=;
        b=hpNf0cNigPpXw9DykFa6IzN5idA/nkAFGlX77z4gmiktlupdS+NvYA293YJl/UyhX9
         QVJh0DLrqKNAxMZ1YqiW92drtZZcx8zCwaS4BIysSLKp0R2IshQAbpcLiVhNm6SSRB80
         tHjgNex6fZKg2y2caMDnNx5xlQqEOJLltG+/VHBUf8tHF5WVom4Qp5ORpdguND6ywqCS
         +DiPpp5DVDNRgP6iz+SFa4fwAduZDZKRSKMiOI7TYMYCRFd0xM3k8THTJBSem9u0Hau8
         1ZddxKq98msBx9Gf2+jXNHcxihO+uSH7vyUuKpauUBPl9Z9RosFCkWFuYbqbUfwco+dR
         BCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114083; x=1779718883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYFr7XXcKEsZj+Bv1UNXpfsZHaxqcET1cNdw3E5KQ6o=;
        b=Fg/xRUrqL3LJXZXAGAoe4Bqf615IHzn0uhb8CkjxqUs03wIz9+xxMZHP9Qza55/wEf
         lkpN2dlo4G1sbbXmiiBToHYPpRg9ylBkn9M+zAmliClRRGukPmqM0n4KIrlYe7qqFUs9
         HOsrLawGOktF18gb6q7jUyWlrMxbka+6aIfNnHDhoRaqDCYCeQEc0QceCPTOxjAExsF4
         xkU7mJTppR7dPatIDTaIf5siKIK3Ha5hmhjiQKgqQHwBZPe4un4CDys2Xku8gr3CAUqS
         b234uE4OjPGmI0Aaf+ex3h+j5FMPyfv0xwqcej0fsQPwjSwTDh1uJYHAk1jdbR+MkmKE
         eN+A==
X-Forwarded-Encrypted: i=1; AFNElJ9Ay7Y0nx8dJ8e4rHtH4nZ0up4GSZrViBm+0ZabbN7tb0ks1d81hEdtNVAmvYqXar42RcJhPbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFsoGhJiLXj8J8pR5su+QCT/nzGqGDmlo7BX5eJCg9iv13/stW
	yuRGpCtb7dZY5RaPSzbBy2l/MvbF4v8KFcXoJZ5Kj46/N3UL9X2WskD9
X-Gm-Gg: Acq92OFxB4qgYeC6SZYW0t8hPA2ixUGBm2SLnQ1mYfPI2hkcmbnLZwJucV/qEWFUiKm
	yT89QAVEtxkrsUMjAxTRKd+n4Te3JdoFjIrBM+Z99nO/bqLY7EWLSh4dzMYcRLrwsEv57foaen3
	rvuz3pWuH9AAMw5qDOSrbEpPBKjYGzcL6YqTj2dfXAaFMe5On1lPX7dCc9KfUWnThN5ynCb8QJK
	0U+e5tBt/Q+nHudnTdVqwodZgrQtA+VMFGa9SLecBUC7DX3eEZwBzNG8nrItTXpVtDw0hbYYtzR
	z33r00G6wzL6uApnIGS14Z+Oe4xVMx7U54quZhEesQqvHOUXE9kE3CFAEIDrFMGunrlu7eNyliS
	GE/0LXuAIGbJJrvh95TSG78qBlpBgji3WmxcmBfvR8ZghyIbJP6BTod7Q78IpQMs7OAZL2EcLnB
	3pEVh4Q6K9wvdUQYKDb27KIaZHIVQ93yCL99MnTHq0FrJeb6Yp8lEB1pXTs+4j9HbiUA==
X-Received: by 2002:a05:6000:2083:b0:43e:a9ba:b194 with SMTP id ffacd0b85a97d-45e5c5dd921mr25324601f8f.34.1779114082921;
        Mon, 18 May 2026 07:21:22 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1a22csm36715510f8f.19.2026.05.18.07.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:21:22 -0700 (PDT)
Date: Mon, 18 May 2026 16:21:20 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
	yonghong.song@linux.dev, jordan@jrife.io, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, martin.lau@kernel.org,
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v6 1/6] net: move netfilter
 nf_reject_fill_skb_dst to core ipv4
Message-ID: <agsgYJsHZzA_0L97@gmail.com>
References: <20260518122842.218522-2-mahe.tardy@gmail.com>
 <af01ada15e1b76da2dfb6cfa749727e0337787f117ddf5724a3cb702513e81dc@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af01ada15e1b76da2dfb6cfa749727e0337787f117ddf5724a3cb702513e81dc@mail.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,iogearbox.net,gmail.com,kernel.org,jrife.io,google.com,redhat.com,meta.com];
	TAGGED_FROM(0.00)[bounces-289087-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3C45C56ECA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 01:07:54PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> > index bc1296f0ea69..1f031c5ef554 100644
> > --- a/net/ipv4/route.c
> > +++ b/net/ipv4/route.c
> > @@ -2945,6 +2945,21 @@ struct rtable *ip_route_output_flow(struct net *net, struct flowi4 *flp4,
> >  }
> >  EXPORT_SYMBOL_GPL(ip_route_output_flow);
> >
> > +int ip_route_reply_fill_dst(struct sk_buff *skb)
> > +{
> > +	struct rtable *rt;
> > +	struct flowi4 fl4 = {
> > +		.daddr = ip_hdr(skb)->saddr
> > +	};
> 
> Can this lead to an out-of-bounds read?
> 
> Now that this is exported for BPF kfuncs, it can be reached from early
> hooks like TC ingress where the IPv4 header might not be linearized yet.
> 
> If a malformed packet contains less than sizeof(struct iphdr) bytes of
> linear data, does accessing ->saddr require validation via pskb_may_pull()
> or similar?
> 
> This concern was raised by sashiko-bot@kernel.org in v4 review:
> https://lore.kernel.org/bpf/20260421111320.D97D9C2BCB0@smtp.kernel.org/

Yes but it should be fine since it's the caller responsability to make
sure the header has been linearized, and we are calling
pskb_network_may_pull.

> > +
> > +	rt = ip_route_output_key(dev_net(skb->dev), &fl4);
> 
> Can skb->dev be NULL here?
> 
> While safe in its original netfilter context, a BPF_PROG_TYPE_NETFILTER
> program attached to the NF_INET_LOCAL_OUT hook will receive locally
> generated SKBs before skb->dev is assigned (e.g., in __ip_local_out before
> ip_output).
> 
> Does dev_net(skb->dev) need a check to prevent a kernel panic when called
> from such contexts?
> 
> This concern was raised by sashiko-bot@kernel.org in v4 review:
> https://lore.kernel.org/bpf/20260421111320.D97D9C2BCB0@smtp.kernel.org/

We can't attach such program as now it's only cgroup_skb and tc,
outdated.

> > +	if (IS_ERR(rt))
> > +		return PTR_ERR(rt);
> > +	skb_dst_set(skb, &rt->dst);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(ip_route_reply_fill_dst);
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26034287312


