Return-Path: <netdev+bounces-289088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HT3NrkiC2oxDwUAu9opvQ
	(envelope-from <netdev+bounces-289088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:31:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 421C556ED18
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3D0730EA9D6
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1BD369234;
	Mon, 18 May 2026 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8jIZ2II"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE48640757A
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114133; cv=none; b=COcFK71StZV8Ni6US4yPN/Rf8b/dx1vikaJZJFALPdP0OuUz0cpBjnQqT9cJDuVQja4JShSn9ZQ1g/zHcQctlcSB9dS+hhddYR5rAypGorNivrLCovb0qntbSHYnN+MHSCGGQC29O1VEb7MtvRfCYbHcJqt8AYfoAC2+GUeL2Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114133; c=relaxed/simple;
	bh=gSixFFclTUS7ckGyJ6STwjNMBKoWCtWW79rUv1GMZXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIA9EkgGRVXZ9W7VFJZ8eNPo+Ui7nAltmao5JA9oEaJnKSYay+SjWoqb0smdNk49NfXCezab1nBqVYDghvh9XX5Nb6AuDBvZdzh32JBMcVY+xqtdqKudgYGrEqwLUSWCD8tnZEU1h0r7dOfB37U1rIoUsNopz2me2XXDl8p/+sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8jIZ2II; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48e82c23840so17931505e9.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 07:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779114127; x=1779718927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Oumtl4pXAJKEcGCQwup2CrdSSym8HzjHOOsWboStNg=;
        b=j8jIZ2IIsuxpWQ870MzemgZoBPQSu+i0AsYHIMBek6XI8VfiwGpMeweG1s/U8Jeu/w
         bswnS4SxwRZ3/lbWH9xBJjHltNY9EkfI5DralRIibUZnRVZ/4WwV1QIZvzkwXD/kHxMt
         ioVikITIBBqL258ANDW7aVQoeDB66sftmIZafvjqz24jKTK/JYEQ6zZde8o2bRiyDCxT
         rtHsfOuGmP1XEgBVa+Sz5DJRUsgnGltCUSaPvIAludNRAsDpwRPtejaUSTIn15MgacFs
         cxss4wlpunyxk0AeZfM4jJqmc54spg3y3y/hw70xkQA1ZJwHrz5GnqNTVsl1ogcwx5yd
         g2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114127; x=1779718927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Oumtl4pXAJKEcGCQwup2CrdSSym8HzjHOOsWboStNg=;
        b=HKf0EXItRIZY7v8wyNjs7lkLskNW5a/rMBpc7/jkkYcCPdCUIvO73LLQ/sYDl5cpTR
         DjKt3TJg4el/8WlRIcvIoxmYxAmRmMwqNGBWEa/3Nfe+7EMROXgoWQkEZXLSGcntbu6d
         ofdgMniHkohNzWxGhdS+eDdIRT66H82RjYsVC0/obFpELtkEMHu0jYzL4Toz9NglD3/h
         VOuIm7ZptsdXPjlHXorJl6bRPNnTO5+Y7w0GWEWeqW7n40TyEMpsXw+LTTmMBQ79a1hS
         06YCQFJ04Pm6rKb8UOPOMC32tu8mrtycZHhMEvEdl41/y5lNbTfETImvMi4PO9Q/SrDa
         HZhQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4XhtrE82dgeMS+Us4lP2r62Q08x5S/t47wj8h9yke0js85mJHjhBVjtSo8k7ZfOIHDMcUtHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuZLYOGRD1/AeqcA6xwwJxfyT6EikIMY+JExOnVkPl4UIXpq76
	HiBoIHoxeQ6wsIPSheaLeQl/SFO+H9FzMH5VC9TVNpw8qFwsqwXZOOg7
X-Gm-Gg: Acq92OHU/lD7OEp2YO5yq+UVGuJZP8WfblqgumCuit1/Nak/lptg6xhGLOym1ehSzHA
	rT3AI/f6MzTeH57oa+FAW8W312KSaB2QbgYvrUCUOJPBLpqQEN/FODftOD6gFFPTUawfoxvk6ho
	vk4I5r+HABOdg9pzBcTONY2/FyxyRiBpbg3Ml3XnOinATpDavrx9jRKb9matZga1scm2VnrU76h
	QyllMSHsNTO1F+GxFPh2wzV/26TTmGRcWDRDyrroSwzRIp0QuAepUju+il1CtAiHHrW0ypkav6f
	uXE9AeTDWBBDC5rUIXM51AsGDh+4+eCywdBsk8swhbgzeRrKHptfSjeEaIhn6AbhGh1z3pZ3R03
	b9ESIYXmYSkCm30brKvnUxklQntd/a32kttLz6I5pHwHAiVDAfbZTnEqr82A25OHB+dyePTs0I1
	WTBwdeSMTb2jR6G7X7CbdBf4eh/Y9jGyu+iG2XdBUeRiwe625r/A5GtlU9IM3XvnEqUw==
X-Received: by 2002:a05:600c:6383:b0:489:1c1f:35f9 with SMTP id 5b1f17b1804b1-48fe60ea4ebmr233939685e9.9.1779114126375;
        Mon, 18 May 2026 07:22:06 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm37137502f8f.5.2026.05.18.07.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:22:05 -0700 (PDT)
Date: Mon, 18 May 2026 16:22:04 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
	yonghong.song@linux.dev, jordan@jrife.io, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, martin.lau@kernel.org,
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v6 2/6] net: move netfilter
 nf_reject6_fill_skb_dst to core ipv6
Message-ID: <agsgjAvP3atsziMx@gmail.com>
References: <20260518122842.218522-3-mahe.tardy@gmail.com>
 <1637d7e04ac3c65239ef77709175697bff287250913d1da68e8d4072e0ff34e1@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637d7e04ac3c65239ef77709175697bff287250913d1da68e8d4072e0ff34e1@mail.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,iogearbox.net,gmail.com,kernel.org,jrife.io,google.com,redhat.com,meta.com];
	TAGGED_FROM(0.00)[bounces-289088-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 421C556ED18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 01:07:57PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
> > index 09ffe0f13ce7..eb5a60d3babe 100644
> > --- a/include/net/ip6_route.h
> > +++ b/include/net/ip6_route.h
> > @@ -100,6 +100,8 @@ static inline struct dst_entry *ip6_route_output(struct net *net,
> >  	return ip6_route_output_flags(net, sk, fl6, 0);
> >  }
> >
> > +int ip6_route_reply_fill_dst(struct sk_buff *skb);
> > +
> 
> [ ... ]
> 
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index e3d355d1fbd6..37a7627a94de 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -2725,6 +2725,24 @@ struct dst_entry *ip6_route_output_flags(struct net *net,
> >  }
> >  EXPORT_SYMBOL_GPL(ip6_route_output_flags);
> >
> > +int ip6_route_reply_fill_dst(struct sk_buff *skb)
> > +{
> > +	struct dst_entry *result;
> > +	struct flowi6 fl = {
> > +		.daddr = ipv6_hdr(skb)->saddr
>                          ^^^^^^^^^^^^^^^^^^^^
> 
> Is it possible for the IPv6 header to span paged fragments here?
> 
> If the packet header isn't guaranteed to be in the linear data area, and
> there are no linearization checks like pskb_may_pull() before accessing
> ipv6_hdr(), could this read out-of-bounds memory or cause a page fault
> when processing undersized or fragmented packets supplied by BPF programs?
> 
> While v6 cover letter mentions "call pskb_network_may_pull on the cloned
> pkt", this linearization check is not present in this function.

Same answer, caller is calling pskb_may_pull, outdated.

> 
> > +	};
> > +	int err;
> > +
> > +	result = ip6_route_output(dev_net(skb->dev), NULL, &fl);
>                                   ^^^^^^^^^^^^
> 
> Could skb->dev be NULL in contexts where this function will be used?
> 
> Since this is being exported for use by BPF kfuncs, it might be called
> from program types where the device reference is not retained, such as
> socket filters.
> 
> If skb->dev is NULL in these contexts, won't dev_net(skb->dev) cause a
> NULL pointer dereference?
> 
> While the netfilter caller (nf_send_unreach6) checks and sets skb->dev to
> loopback_dev if NULL, the exported function itself does not have this
> protection. When called from BPF kfuncs, especially in contexts like socket
> filters or tc ingress before device assignment, skb->dev could be NULL.

Ditto, outdated.

> 
> > +	err = result->error;
> > +	if (err)
> > +		dst_release(result);
> > +	else
> > +		skb_dst_set(skb, result);
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(ip6_route_reply_fill_dst);
> > +
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26034287312


