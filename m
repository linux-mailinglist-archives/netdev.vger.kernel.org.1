Return-Path: <netdev+bounces-289137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPSvI9lJC2o7FQUAu9opvQ
	(envelope-from <netdev+bounces-289137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 19:18:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1FD571885
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 19:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 714523013B6C
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 17:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF85382368;
	Mon, 18 May 2026 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLdYX1aZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3869B38236E
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124694; cv=none; b=E1tWhbGrhYeNvZduP4ultkNv3N+Vxpi++nyLYiBv2MQZqI5ZOwd5HCIhptWDuMSKdmwNkVbxJs4hWlx5heKm8/3NVEqNEVFv317wxtsrqtM5dwhmg/IB6U8SgHYrj1a2qxxDKiErFSC6Czik45qt8f5TAZZruOH82yefZjtm028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124694; c=relaxed/simple;
	bh=3c0QS5xzL7i2Q75DhbTuhvaZhPUd9TNapdTzHhuKIbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L51DwWWULCmbBPU/FOtGLq6SJWTX2Nz9g+l6J1EokVzSq/sqoU8SM/aRQnHsFjjE9Q74PXwMMe4Sfw27r2KUqCC69VJjOUgt+Iw6AGGT+qsdAVbxc/58TjD1+EOgThHcVLM1sR6u31dIzovOs7/trgp0AwJo1dL/mmZjsKGodRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLdYX1aZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso29381225e9.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 10:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779124692; x=1779729492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HEqTTzF0Ghh6Rzlw5gbHSyUg5PTlw2WJ5Y6lPEAeK9k=;
        b=cLdYX1aZ0ntSFY8Sihinyxg938YGokYZ+iqz+Kt/pJFC3Z2hqsj7RjX4rCYaTDuRl9
         a6Sx246jNNF4y2nYq+hJsgXRJrh6yBBssPCJkEqAlnOfAPQjDjg1lZX4k6n57wsruo8a
         xREnrC3Yjql4t0F7EZdbxEILvkBNCLOjRnsOkYr/5a3nOtpPeoq6qxW5ty6Y+N975fW8
         UOryxL4q04xqLXw1nv6yfY2H0jVZe6px8IEAUUZ6WpBhobm/px9S7Y3Q1209e5OFRfHL
         LoUho/kudMbvukksqusvULxAl2cYTltIssH/VtlbHJlu6s/CwtB+EBnHCDdRI71YXP+3
         1YOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779124692; x=1779729492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEqTTzF0Ghh6Rzlw5gbHSyUg5PTlw2WJ5Y6lPEAeK9k=;
        b=nD0ujfY+Ve6Yp0h9Y6WNJ/gWhLTakNAVJWpJbVEE0V5gh+j6bQyUa7BQwoHyxN8Cyh
         7XPyjP7ZnMDiKPE71NQKK3xXCcAPwSDgTkZJWp08Bu/IH366hiaQZb2hi78ZMmjfpp37
         6rSc9+m5XqACD8hjxYf4AF/Eli0o6ixLmDQW9ZwwXl20vntLLuubNtwtDyRzJFdFkDkI
         1EQTWKjYT1vohK9gR7M7r+WxzVLqyjUyCxS6qgyHhPzsHUyXynr7wkHipslHRC58NINn
         MrfmMZqa0E3knfLh682313oD1uW0MIkLiEse3WKBp4mRUd/kI2GUomSk5FBNCRb8cmGZ
         LYJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+2tLvJ8W3DDNebv9B0vMwqbCAGRzDI0w3v3JVCv916mGM/FvUw1G6KouQ48cMSIpfSVocp/rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVYXhyrQ2rcO12aHdLAJpnpR00J8Rclu57tMgYok1I3vkeMNBp
	hJHNHS3SxYUOIuP6M6UH3P8tBXGjeLN7r7pEYnlNX+SHE1knLqd6vD4O
X-Gm-Gg: Acq92OGJo64fV7fUE6zOdnHZi8+K38k1IFuEIBcubAjaC4KVoIpIZnagj+DjED+HVaO
	xsZxQNQAGhkDOJGDkeeVO6CGe417hNIvXDam93uYhCaqyjOWFCpFa6Y8VV2mnzazRWhVlZ734rF
	bctr0oy2x+oY/TugkjUH6o0k1AcqcdgN94aTFtYZiYRMA0HZqVgHqdxP4jERCadx/YHc6epIFIh
	IDqjk6PfzbDs60/qsGjKDMYzGgdJnf4qQhpuCufqXWTfC8LyIOkEEWybqhbH24cY5pq7h56DCNN
	x7f6nsCXrO719LlQfw0HM6ypEK6CkXxhs0k+jshptIiAoJ6asM5d9ANvhPBp2K1idlLXcPn+ZJD
	3o1Uu4hBAakfDR9ehNmwj/vUCX2ZpWApU9CWqTYLIkUFDUBIqEBC22UhxzdzC/wYd/b01LkxZPJ
	1u9xo2f2vw4FMJLcFqqn5h5QePOWI3geFJteAYG796UNYVapYOrF/qhrY=
X-Received: by 2002:a05:600c:8905:b0:48e:5d91:cffb with SMTP id 5b1f17b1804b1-48fe60e7d6emr201978945e9.10.1779124691418;
        Mon, 18 May 2026 10:18:11 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8d39esm271445945e9.7.2026.05.18.10.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:18:11 -0700 (PDT)
Date: Mon, 18 May 2026 19:18:09 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
	yonghong.song@linux.dev, jordan@jrife.io, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH bpf-next v6 3/6] bpf: add bpf_icmp_send kfunc
Message-ID: <agtJ0e_hlHS3Es_q@gmail.com>
References: <20260518122842.218522-1-mahe.tardy@gmail.com>
 <20260518122842.218522-4-mahe.tardy@gmail.com>
 <ags3HARTFYwKU8nR@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ags3HARTFYwKU8nR@devvm7509.cco0.facebook.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289137-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,iogearbox.net,gmail.com,kernel.org,jrife.io,google.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0B1FD571885
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 09:17:45AM -0700, Stanislav Fomichev wrote:
> On 05/18, Mahe Tardy wrote:
> > This is needed in the context of Tetragon to provide improved feedback
> > (in contrast to just dropping packets) to east-west traffic when blocked
> > by policies using cgroup_skb programs. We also extend this kfunc to tc
> > program as a convenience.
> > 
> > This reuses concepts from netfilter reject target codepath with the
> > differences that:
> > * Packets are cloned since the BPF user can still let the packet pass
> >   (SK_PASS from the cgroup_skb progs for example) and the current skb
> >   need to stay untouched (cgroup_skb hooks only allow read-only skb
> >   payload).
> > * We protect against recursion since the kfunc, by generating an ICMP
> >   error message, could retrigger the BPF prog that invoked it.
> > 
> > For now, we support cgroup_skb and tc program types. For cgroup_skb and
> > tc egress, almost everything should be good. However for tc ingress:
> > - packet will not be routed yet: need to set the net device for
> >   icmp_send, thus the call to ip[6]_route_reply_fill_dst.
> > - fragments could trigger hook: icmp_send will only reply to fragment 0.
> > - ensure the ip headers is linearized before processing, and zero out
> >   the SKB control block after cloning to prevent icmp_send()/icmpv6_send()
> >   from misinterpreting garbage data as IP options.
> > 
> > Only ICMP_DEST_UNREACH and ICMPV6_DEST_UNREACH are currently supported.
> > The interface accepts a type parameter to facilitate future extension to
> > other ICMP control message types.
> > 
> > Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> > ---
> >  net/core/filter.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 118 insertions(+)
> > 
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 9590877b0714..843fa775596b 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -84,6 +84,8 @@
> >  #include <linux/un.h>
> >  #include <net/xdp_sock_drv.h>
> >  #include <net/inet_dscp.h>
> > +#include <linux/icmpv6.h>
> > +#include <net/icmp.h>
> > 
> >  #include "dev.h"
> > 
> > @@ -12464,6 +12466,110 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
> >  	return 0;
> >  }
> > 
> > +static DEFINE_PER_CPU(bool, bpf_icmp_send_in_progress);
> > +
> > +/**
> > + * bpf_icmp_send - Send an ICMP control message
> > + * @skb_ctx: Packet that triggered the control message
> > + * @type: ICMP type (only ICMP_DEST_UNREACH/ICMPV6_DEST_UNREACH supported)
> > + * @code: ICMP code (0-15 for IPv4, 0-6 for IPv6)
> > + *
> > + * Sends an ICMP control message in response to the packet. The original packet
> > + * is cloned before sending the ICMP message, so the BPF program can still let
> > + * the packet pass if desired.
> > + *
> > + * Currently only ICMP_DEST_UNREACH (IPv4) and ICMPV6_DEST_UNREACH (IPv6) are
> > + * supported.
> > + *
> > + * Recursion protection: If called from a context that would trigger recursion
> > + * (e.g., root cgroup processing its own ICMP packets), returns -EBUSY on
> > + * re-entry.
> > + *
> > + * Return: 0 on success, negative error code on failure:
> > + *         -EINVAL: Invalid code parameter
> > + *         -EBADMSG: Packet too short or malformed
> > + *         -ENOMEM: Memory allocation failed
> > + *         -EBUSY: Recursion detected
> > + *         -EHOSTUNREACH: Routing failed
> > + *         -EPROTONOSUPPORT: Non-IP protocol
> > + *         -EOPNOTSUPP: Unsupported ICMP type
> > + */
> > +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
> > +{
> > +	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
> > +	struct sk_buff *nskb;
> > +	bool *in_progress;
> > +
> > +	in_progress = this_cpu_ptr(&bpf_icmp_send_in_progress);
> > +	if (*in_progress)
> > +		return -EBUSY;
> > +
> > +	switch (skb->protocol) {
> > +#if IS_ENABLED(CONFIG_INET)
> > +	case htons(ETH_P_IP):
> > +		if (type != ICMP_DEST_UNREACH)
> > +			return -EOPNOTSUPP;
> > +		if (code < 0 || code > NR_ICMP_UNREACH)
> > +			return -EINVAL;
> > +
> > +		nskb = skb_clone(skb, GFP_ATOMIC);
> > +		if (!nskb)
> > +			return -ENOMEM;
> > +
> > +		if (!pskb_network_may_pull(nskb, sizeof(struct iphdr))) {
> > +			kfree_skb(nskb);
> > +			return -EBADMSG;
> > +		}
> > +
> > +		if (!skb_dst(nskb) && ip_route_reply_fill_dst(nskb) < 0) {
> > +			kfree_skb(nskb);
> > +			return -EHOSTUNREACH;
> > +		}
> > +
> > +		memset(IPCB(nskb), 0, sizeof(struct inet_skb_parm));
> > +
> > +		*in_progress = true;
> > +		icmp_send(nskb, type, code, 0);
> > +		*in_progress = false;
> 
> [..]
> 
> > +		kfree_skb(nskb);
> 
> I was going to suggest to use consume_skb here, I think it is a better fit?

Yeah correct, I can replace it with consume_skb, didn't know about it,
thanks.

> But I'm not sure why you do the clone here, I don't see any requirement from
> the icmp_send side, can you clarify? Is it because of the pull?

From the icmp_send side I think it's fine, however, this part might
touch the original packet, especially ip_route_reply_fill_dst:


if (!pskb_network_may_pull(nskb, sizeof(struct iphdr))) {
	kfree_skb(nskb);
	return -EBADMSG;
}

if (!skb_dst(nskb) && ip_route_reply_fill_dst(nskb) < 0) {
	kfree_skb(nskb);
	return -EHOSTUNREACH;
}

memset(IPCB(nskb), 0, sizeof(struct inet_skb_parm));


All of this is mostly there because we allow this kfunc for tc and
especially tc ingress. At this stage, the skb might not have a routing
entry yet and icmp_send needs to know the dev from this or fail
silently. This is the original reason why I added the the net patches
(patch 1 and 2) and it was also spotted by Sashiko when I tried to
remove them[^1].

[^1]: https://lore.kernel.org/bpf/20260515202358.20252C2BCB0@smtp.kernel.org/

