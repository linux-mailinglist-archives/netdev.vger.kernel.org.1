Return-Path: <netdev+bounces-305941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /5SDN3STTmoMPwIAu9opvQ
	(envelope-from <netdev+bounces-305941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:14:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B943B72974F
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:14:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=PA0jfaLp;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305941-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305941-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD0A3301E033
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB5F3BBA1A;
	Wed,  8 Jul 2026 18:13:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A0748A2B5
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 18:13:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783534434; cv=pass; b=CNETVdKvOw+h/gOgkgOivMCwQZmfuVW/booNsUsb3tjRo5qUoU4TR16IIXE8ePzjgn1FgKjuF5D4eE+dfA+o8B3LevZiLSwbRC7pnr3lryHqHAul3v5stIYvXPoOhHxDABTRLkAiWBfaf1HodPdOguHIlwsqngmPP4PcRjEINXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783534434; c=relaxed/simple;
	bh=Ef1jX5C1Tf/JqtPxDR2IveLskH1395Bpc8jsazmgvWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrSR6BDM3LC2Eq3PL1ItvDJr8FgUlkjt8RZIPGrudCMHY4WoAnMG0dLgV0KhXAHiNZac4lrNswtd+CW4XnfoTs5KUqCyort8+FoSRyn2+zOPAtywwmUuPQDF63g6lnTlC6Ns22gGE2pc52FCMX3HtQZXPt90KqZM9fOe2RBfqtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=PA0jfaLp; arc=pass smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so13625655ad.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 11:13:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783534430; cv=none;
        d=google.com; s=arc-20260327;
        b=Owy0cGaF+Lb8DEM0TlgB+Q1J/H8TgC698czp+yDUtdIw48NxiY1X1WIj49DXV4JBS+
         OhbBOD9Xg/ZWlK6vTV7OI6UXr+JbGiByqY3QRBiCElQKEARCQeWGUQKyTg0frag0M4X5
         4EW2ONG+wOsNK04JUqxVQyJ9dT1aIZUlvqgdV0ktqdRpIsbcwcvx/C1GLnC0EXJI1gGJ
         Obw44aHq5+6C4l4oWRiM0+9h9bdF/xFNpH5KejqB88dZVXKPQdWOdnQGKnjReFXaWQba
         fky+7vkV9XdWnoRTWoxRKjvjXD9hjVjtjbXaNznAFy0UIhPV0XkQ2BcABF3pefC8PE2o
         gS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KPmG3iDrDem82BUtmSEHHGtoKTFS1QWeIgwx+sqCnqc=;
        fh=7LzjGf9bymF79ME4Dtg7V9FazZKQFpU4mSNsgqDZu+s=;
        b=row3hRN/e7UKE29lb7oU0dSpD88mMb05L1XTE90gG6Zsdlfd1SOrC6qOjJjt3ud1Q5
         Qf/4n2GkNO4d4iUNL7oLGHP3PKKByCKw9Z5uE7ZnI2OHa1mrG5pH6RbLNt+4kwim3OWH
         NyXoFI3zGLAOJx/xqoiAXLNapSHTfOY19OFv2RywzbkYq0EZ8CEmXivCoWhU5dRfseEt
         Xc/SodimZQvLwkW2wI61fZLWtaoSKfU65PJGZxVwFtKvHv8xbsFC5KYLoRdgoR6qe3Gf
         q0Piu1hum/y9pzEtwdC2kikvneMI5dhs0dTUDD6CvhWDAuqPjp4I//1vgj+jdgNIHIAs
         qOaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783534430; x=1784139230; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KPmG3iDrDem82BUtmSEHHGtoKTFS1QWeIgwx+sqCnqc=;
        b=PA0jfaLpG1XzkHkh/jmwcpzir1Vm8W8vYMcyRpwsit5qieadzZOx+VCm9tJESN60Qi
         lQwxre5rMtTOGPuYrXkoK0HclmlG5etVQf3nvJFmu/cpPhCa7qE6NnYhg0ngto/kbLBe
         rWyUrFLLOdCCPcnKj4tRmEFYCQS80Yd7vrHagNCqNeOyLTG4e3gward1T4V6nv0S3cgG
         OLYqI0lezgA+V3Ko2AGoM7P6NX0WNmwUiXWhHpVnBrynuKJ+iGN87oN9cdJjeh5Z0gR+
         ujw56I5ekhQH2yoH+MIRSs+NrbdLz13LwHjhXE3Js1rMxfutbYD7e/pGvhsH0RoVVq2q
         FXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783534430; x=1784139230;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KPmG3iDrDem82BUtmSEHHGtoKTFS1QWeIgwx+sqCnqc=;
        b=GUIjbdZnQLdSoU35jbwVwyFuCrg0YUXz+mOsztUckWQ/17wwz3eqif0daOkFTAeyM7
         qHaVx3RCdajJkhgDVJyHgVnHDol0lbpR4rdDnmYjOpCyiPlglEBKGallkrUEhCK5stE8
         o3S7LXgZUx7WXEebAnqiCEDH5uWqTHqF7Xw7oqqG3x2Q1N1nyCOASIOgDSh9rRlouec4
         yakm+PBO/L2opiXjlWTTQg+FVaQr5BAeyxAycmwF1kIXP1u5AL5OkRDusIS+r3JXuawx
         0sOfJJ2JMzIMk2s+W3Uwghuoig/PTDaR1LseQVVn9uFnaBN18PUhC5Rpv1zmraaBlpoj
         xSFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrfgs3+mQJMSkVUbpK6lxZo2fYZQ4Gc5jjkwCCiQlAiVwFBvElTny1lHSBmeZEDSlkMCrROkMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgPFFomDRZFlMyPKuhM91vLDsGKTMhuMAi8wMqkJJWOy8a1tOu
	3nav95Y4DWvjzQA+uWOVjXPUC9vGqWYsSNVmwK6YVgqfiWlDtypKp4HiHk7ETGYz3mg/9yD91wE
	lOlgi7ISma+MSYln/09U5zlE1+9ZPcLW3IBv4kS+g
X-Gm-Gg: AfdE7clzpd8a3d0kysqroXMecLuJekvJRotrkq8TwIOVXoy+ajAZvj2VS7KI5oicfbs
	RaFEm/1wC+2XDzD+uETdL1cPvQbvjvEdGHYvMQ9GeGj6UjQXQkRChhfmZHQmMflWFNIwhlBbeNw
	SpERZIygsgMmoG5OtPfTelIcolY1/o+Pluut6bGJ85U68D2xKZPnQSJsAhZrk6NHfYr7n4pwx8W
	LN5OPPCvbhmnkxRSlGhffQdQLM+wnWA4/plTcEBGFRZW52FYX+FyWJWD0XZD0Q/4ZlM+BpblC7o
	FRnc2kxkEA62ZLphwEH9z9FuDPje
X-Received: by 2002:a17:902:f60a:b0:2c9:cf5d:d9b8 with SMTP id
 d9443c01a7336-2ccea45e5damr36563195ad.33.1783534430021; Wed, 08 Jul 2026
 11:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706232850.3333016-1-xmei5@asu.edu> <ak44aLdDrMZXb6fC@strlen.de>
In-Reply-To: <ak44aLdDrMZXb6fC@strlen.de>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 8 Jul 2026 11:13:37 -0700
X-Gm-Features: AVVi8Ccu6snYjdggb6FSCQxgs0Bqzpz8sfbT4KG_8j_8JgBoMUD0oIr2n4336iA
Message-ID: <CAPpSM+RV+94_tvtX0EF=beC0AeNL0H2kTjtLt1c4fv3ddy4H3Q@mail.gmail.com>
Subject: Re: [PATCH net] netfilter: bridge: fix stale prevhdr pointer in br_ip6_fragment()
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, 
	kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:pablo@netfilter.org,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-305941-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:from_mime,asu.edu:email,asu.edu:dkim,mail.gmail.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B943B72974F

On Wed, Jul 8, 2026 at 4:46=E2=80=AFAM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Xiang Mei (Microsoft) <xmei5@asu.edu> wrote:
> > br_ip6_fragment() gets prevhdr, a pointer into the skb head, from
> > ip6_find_1stfragopt(), then calls skb_checksum_help().  For a cloned sk=
b
> > skb_checksum_help() reallocates the head via pskb_expand_head(), leavin=
g
> > prevhdr dangling.  It is later dereferenced in ip6_frag_next(), causing=
 a
> > use-after-free write.
> >
> > Re-find prevhdr after skb_checksum_help() so it points into the current
> > head.
> >
> >   BUG: KASAN: slab-use-after-free in ip6_frag_next (net/ipv6/ip6_output=
.c:857)
> >   Write of size 1 at addr ffff888013ff5016 by task exploit/141
> >   Call Trace:
> >    ...
> >    kasan_report (mm/kasan/report.c:595)
> >    ip6_frag_next (net/ipv6/ip6_output.c:857)
> >    br_ip6_fragment (net/ipv6/netfilter.c:212)
> >    nf_ct_bridge_post (net/bridge/netfilter/nf_conntrack_bridge.c:407)
> >    nf_hook_slow (net/netfilter/core.c:619)
> >    br_forward_finish (net/bridge/br_forward.c:66)
> >    __br_forward (net/bridge/br_forward.c:115)
> >    maybe_deliver (net/bridge/br_forward.c:191)
> >    br_flood (net/bridge/br_forward.c:245)
> >    br_handle_frame_finish (net/bridge/br_input.c:229)
> >    br_handle_frame (net/bridge/br_input.c:442)
> >    ...
> >    packet_sendmsg (net/packet/af_packet.c:3114)
> >    ...
> >    do_syscall_64 (arch/x86/entry/syscall_64.c:94)
> >    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> >   Kernel panic - not syncing: Fatal exception in interrupt
> >
> > Fixes: 764dd163ac92 ("netfilter: nf_conntrack_bridge: add support for I=
Pv6")
> > Reported-by: AutonomousCodeSecurity@microsoft.com
> > Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> > ---
> >  net/ipv6/netfilter.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
> > index 6d80f85e55fa..547879da9532 100644
> > --- a/net/ipv6/netfilter.c
> > +++ b/net/ipv6/netfilter.c
> > @@ -147,6 +147,10 @@ int br_ip6_fragment(struct net *net, struct sock *=
sk, struct sk_buff *skb,
> >           (err =3D skb_checksum_help(skb)))
> >               goto blackhole;
> >
> > +     err =3D ip6_find_1stfragopt(skb, &prevhdr);
> > +     if (err < 0)
> > +             goto blackhole;
>
> Would you mind sending a v2 that solves this the same way that it was
> fixed in ipv6 output engine?
>

Thanks for pointing me to the better fix. We have tested v2 on the poc
and sent v2.

Xiang
> See
> ef0efcd3bd3f ("ipv6: Fix dangling pointer when ipv6 fragment")
>
> Thanks!

