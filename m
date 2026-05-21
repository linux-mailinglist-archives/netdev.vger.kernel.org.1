Return-Path: <netdev+bounces-290418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNSONdAFD2qFEQYAu9opvQ
	(envelope-from <netdev+bounces-290418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:17:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 113565A58A6
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E34CD311E339
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F553D8117;
	Thu, 21 May 2026 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2/0osJ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8293C366541
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368297; cv=pass; b=CPhxQiZpIcXBM7twNYc+9FKni2FxASEU2XApU+a+X2E4Wb2Ixif75Zx/j7/pimP6idUwUrmMPSnedN5ekzGlhFnb63aZE2/JnHXnQ+8bpOxrttHBYDorbJA8Sp44RjqLpkP8Bk3oeb4WJ8IWwHuQaLBs7V+XUJ/W8GQ4SNWMhro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368297; c=relaxed/simple;
	bh=8AFtc2rk4bePNoYXeigGiNXKbn88p89XeJbYTwvofZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlygXI5JOlly57ZtxskCyBRufhHjMqLl37FVvS94bQBH/CAT5r2r4LUhgp9hQi72Y/CPPP2mUtEslehZueYPR4EVNk6Tg17nOs2/VoI4oVEaFQ5964CFPVJTXVSsRde4/SH1In9WFem212qbp7sX3joEW68dVJ1gSlmCj0e4x1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2/0osJ7; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso2787045e9.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 05:58:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779368294; cv=none;
        d=google.com; s=arc-20240605;
        b=Vjx7m1vcaKPokxrJrz3783T2rdoXXM4ZJzxtCpHYAtU0SseK77dZVqhgalkt4L7Mtl
         zpT7ANoHRdJLj75xl7bfouIkBAOtCmcqwPjHZZXK/AGDzXTuz2VPyczBgfZxAzPfspqW
         kzouHCgTYkKOsmBCS+KGsqxxtafKeyYinWidWPlNuBHyYrZ5e+PVepC2qOVuiV5qimtu
         dz4E/y/rWubhSgB+Ucce9Wz5/HIUyXBHXhcTtpH4E2w1PzXBHXsjlezrygyS7dCgztcM
         LKzETpJKfe2ZPHMB7oKIdGAVe4j6Ra/KA2v1izPf9njUtdHykprmjbdnfZFbxv/axSWk
         bg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8AFtc2rk4bePNoYXeigGiNXKbn88p89XeJbYTwvofZs=;
        fh=Kg8krdyDYLcEyrzjrAFh0wlHllm88Inojh6YlyojmjM=;
        b=eTHN3347/ORyrgSRML4Rq87MvrbIJiy/C02WT3ypDOIRmC+DuGqN7wvp/mbUF31Ly2
         G7Udw1RtVv9uphZ57YGFUngsJyEovFXLwo1UVPrGcXg+IO3csSJV7iYYXil5shq5y/s+
         HWXSqbR2DeWLHjuFXuKPK3p0uvTfgdIVkmMX6ZhuW5rTiN1XiJKeA/d2FeNl5jXIBTgG
         owr1YSmDn3m1gXrbmWw/b5I0lupVKu7IlVOPfLLjz19ntyTGGLO8fwzdkLtcLAuNtPvf
         bOBW8uzys26nlDbBYmuwIOusnqANDdPOy8WU+8hh6eGDELMBYth/g/+4H0RB76qaWKSB
         gAuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368294; x=1779973094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8AFtc2rk4bePNoYXeigGiNXKbn88p89XeJbYTwvofZs=;
        b=p2/0osJ7hu/UPGgScWRDe7eoKpMT+V3oi+j6a4CO1+7JM8Y2FC/iff+d0C6ukDUErX
         tx3AM9+e2vJLlIHzPLYsD17mEEdStB1rjpKOgdGtujH/7YV5oMA5t6EOl/vxIE2Qn7F4
         Gl/oOxnNoHeonz8p+wx2Pc03tUFHaSFXfFwlYEG7jGwx2l1D8VAfMVyEM37jARvl/Bro
         e0yMfKI8rdmYORFyznw706aCc7uF04pGP86dWb2+MjLQ47BJk4vQxOUL16UwJj//Y3nS
         N14bmYaVEqfUI6KQbYx3Ep9ZFYAHRaM7BUmeSrThR+YaMeAVpGwsa4uSlQ3msYlGB9Hn
         iBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368294; x=1779973094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AFtc2rk4bePNoYXeigGiNXKbn88p89XeJbYTwvofZs=;
        b=gz3KAB/ZlVKRZ5U/wL1kqlkADyG7QU8TLvFMXVCEJwHZMWnM35oxlfM5cofiCkNWOg
         PbVRLARe6DtTZheGpJabjq9O+y2XloLGAUjChvWPlErWTTMG/l1JImjSF1jK9hXDD9ku
         Fq+2WRpl+tLUM+3sOcv0tlF/vvCkAu09eO5pMhg0IelK37TPKkkSmNjEj6VFrP271tDa
         zef/ZfSXBpw6auFAUnv/EapOq983DCYZ5HLUNdmG8lsb+qXSa3f0sQI2Iw/prvzSO11M
         V+/EvjWb5q7fcmOZD+d4mo8T7at4HA98VS3etn/M3QpLLaw8wg0ntcxyd1rP2bbFD8Bm
         FfDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8JJvO5v6rylGK+y3AueEe1cDnaFZhu6gZ5iRwLiWbc6ze8gyClCna3TyXU5RjIGOk4lyoax1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaAo2KfQuKspSiSTT/TTIvbfoN5htv6tOURJP7noVJxr7QtGPg
	cCTWHZ3ZmYrpsLOisRcW+locRmjimvDy85aAE1gWC2hmo2QTQyQCdaoLAIaUI77DSX79/Qj62tU
	hsWYeABK1QTanbZpVOmqR2r1q/YukNrc=
X-Gm-Gg: Acq92OFLKpHQq4yDAMmyiS/kunNsUtxV75a1G6Ntzl0a4YjQc5qCrOt8kfQZNixKDnc
	XOFr3iqUppNZBsS+s46rCBK267+fyZksfaI8ktwiMFk9LQbg4OpxLfshxDg+Y1iQSOMznfnx8Wp
	aO471LCO8upJx1FjibVpDFynQ274YslXBoaRjZ2dzP+R9S/llue0BsSOKoLUMjqnBwVI4o/BoaG
	Sl1uuPuCBY8TzcyjIRGxdcfTTeD/aidFONngbeM6l/L2Z75B9KxYgsRaxudRDp9ebU8RlTEihK1
	+uLqy+C0QO1certTrg==
X-Received: by 2002:a05:600c:a108:b0:488:9bf8:7f17 with SMTP id
 5b1f17b1804b1-4903607c446mr32825335e9.14.1779368293415; Thu, 21 May 2026
 05:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519123547.2055911-1-maoyixie.tju@gmail.com>
 <20260519123547.2055911-3-maoyixie.tju@gmail.com> <CABAhCOSEP1voA-g16sHK+C+84rcQZvX9CWJs1hNaSk-ygbbD1A@mail.gmail.com>
In-Reply-To: <CABAhCOSEP1voA-g16sHK+C+84rcQZvX9CWJs1hNaSk-ygbbD1A@mail.gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Thu, 21 May 2026 20:58:02 +0800
X-Gm-Features: AVHnY4IpVxDaUliQ4Mq2HwumVwDbGy0Z-Ii1rpU0I9GF6hF4hsW13wwbNRndpSM
Message-ID: <CAHPEe=GX7wsLetw7rnOpeSkc05Jgi3h5y56e0RGYa4dszK1E4Q@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().
To: Xiao Liang <shaw.leon@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290418-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 113565A58A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Xiao,

Thanks for the review, and sorry about the wrong Fixes tag.
5e72ce3e3980 is not where the bug starts. The dev_net(dev)
vs t->net divergence first became reachable in commit
61220ab34948 ("vti6: Enable namespace changing"), which
dropped NETIF_F_NETNS_LOCAL and let vti6 devices move through
IFLA_NET_NS_FD. v4 will use that on both 1/2 and 2/2. Same
shape Jakub took for the sibling fix 1d324c2f43f7.

Thanks also for the ns_capable suggestion. The top of the
switch case only checks dev_net(dev)->user_ns. After migration
that is the attacker's netns. With the v3 patch the lookup
uses self->net. The else branch still sets t = self, and
vti6_update() inserts the device into the creation netns
hash. I reproduced this on a v3 kernel. An unprivileged
caller in the migrated netns picked params absent from
init_net. The SIOCCHGTUNNEL returned 0. SIOCGETTUNNEL in
init_net for those params returned the migrated device.
v4 adds ns_capable(self->net->user_ns, CAP_NET_ADMIN) before
the lookup. With that check the call returns -EPERM.

I will send v4 shortly.

Thanks,
Maoyi

