Return-Path: <netdev+bounces-282154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIjXJN1P8WmGfwEAu9opvQ
	(envelope-from <netdev+bounces-282154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:25:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F6F48DBE3
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF7C530A2DC2
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E561DD9AC;
	Wed, 29 Apr 2026 00:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m95jD2En"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4C318A6A8
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777422261; cv=pass; b=PrPYBCPMnnnWxMhf5GqGLSfbpTbMws0+T2ouboTYjb7PZyIqIf/8M132gnC4YGf5lQVr90ZeA4hpTy0ElxJINxfWPAghEHjJkfMJWWJtF3n0dB8M0nJF9pD7An0x1nbUbQGFtYCLnMChTRp7KRuaD/icKfdK7geD6KJqpNYESr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777422261; c=relaxed/simple;
	bh=UJXPcwA89OjMeIoeEEHrLC4GWyoAx5SCk8QvmlDPxwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDYG0O/zoXZEaLZazPxK5zCXQ2gH+oP+GxyiZX1/fj72IMwTbG3bB+1FA9m86ychISUOi5l9GKUDU3QXdVFLwnSCJHJ8ayBXL0+XDMGSKww4TxiyhVEs+X3x1EgIKAmB77qv9uyEPjTUzMRwj3QM+JZej6wd2i+qLIs6+KX0ap4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m95jD2En; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506a747448dso86353001cf.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:24:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777422257; cv=none;
        d=google.com; s=arc-20240605;
        b=Qr9NKo1iPnN1gLmoiQB51ugNWUTd9EjGHTkfiAvYZO+ZhMe5bo3oaiqakJbgA/noDM
         GajTuLB8kkY3A+jU6in/8Aw/t3oKSwuu0KbHqtxJgsc03BI2K+VnI3SI/UyS90UFg5rz
         iNVZ+jyxeKNo44umR8XXpdISG0q0IudPMxMv+KoJgDbj/0rABuSoygh8X5j/xtKGk+5y
         6aQnFqt60Zjy3UnUG2GFPJcAB6EeVvUxnEtTMtnAeHUi8WmgNjnnAIL+8w6OQYgODKk5
         KRtD4Ykf8EKo3H2zCdUPBCT/fbyy3/mp3G37N0LF45DpdaQFRc3Siiy3415LK6OVdkEn
         FHgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5EekIEEAn9zcWSyRffp42SDp9Ty9BQf71SkpBOEt/1k=;
        fh=pFmB8AQxtTuwqmvy5pBHZt8wAG/rofCm8CEXdJQlLLc=;
        b=LaqurieLRfOQjIWDSjOa/8IBGeXBV+jtgu0WzkhvTgzdI02dPaNckNVyevad3E/OeI
         nlXQQq90K47uYdsOxEJhlU0jHB2E0vQXqcsorvbXBEKWVLfg7TQMILNTPpdDgjkdi9dp
         lk5+4r7uFcOs17Xdq4qRHO35j1J8ZokzJglBgMUk576PM9YqsZYPXob3h8cA9I4brccp
         J8UkytW4E57XZ3CxH2cnd5Rj6KYTsHwsNXzJyKuX28QVVpvoyo7ZWdkI2pKwTIL1Kui8
         03D0Mh+98Pwbs7hfDl7Lg0fM7vq8LaKKBhsMKFMUwgdomtUSiX9kXopeyJegFVYMpiiS
         ir8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777422257; x=1778027057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EekIEEAn9zcWSyRffp42SDp9Ty9BQf71SkpBOEt/1k=;
        b=m95jD2EnKtKcSXmhejLDIhMzOrmHv6giH1hUWQT84l5ILnJ+8pEI0I/0rkjESwx6Fm
         5aJwcVXbPBs6GybIKBp/Py12uF3y9zl61KqiZhi5eokNb1Alg9y7kOXfjfTLxbC4tzkt
         QtXbUEc31G6bKjJwaN/As1HP8F6I7nWN+DdiNHB69dG2awdDFmRARzpAGzMeLCuM6S2k
         5ffwgtKNsDLZS4K2SSCz65nQIvwTrVR/76xAPVd8OEzzCqVz5l3vFRTjwmLNhgih9lrM
         s9GmaqRP3ktkb63Y4raqsh9HC8DI6KvcOgPeM7NKENB52Zij8CHi3UZio1NI+FUsGS4L
         8m/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777422257; x=1778027057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5EekIEEAn9zcWSyRffp42SDp9Ty9BQf71SkpBOEt/1k=;
        b=q4dJhRwB/4CJnxpvIrYHUVPzVcGMp2OGBXiwSaUEMaabJ+Rw3wOb8O13sXzNQkSDq9
         tD2pXR5krLnKykIr0Cpd1sssVOpEjy5F1O20kKd8GFN55Q3Cnp2QuDr9/I39VlACGHG9
         Eb0rQD6XkbTEqQO1ZPMm5sbq8UEklu7Py3hBB4k0vP9XeZZq5OnIrx7EcLvoTpw8a5ft
         vaTYVUiE0Rr7ugFcSPkpBhDOnyoQh4neu7LIssGz1JZZirqT52FWuaJKnO+mc8N3/bwV
         wIXYrBWrzmLmWFBtsHezbvccNZ8w0tVW0EC41KOGXzSeauqZVkv/NUtcAO9MlFHniy0q
         J97Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Cn68mg/VAR+SDKfEWR/49ssVgzMHVyOqzDMjVrTtnctTglEZ2OFVcHASVend3oY26Xa6bJb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzesY30Izy7rnJCWxPiLGScguUdNlK+RvYwukzaaDemb0CMn9sk
	kYl/CQZZigVRqY4ehUqYmIT7WPzBzQ2ULE8940sH+daZla1AvARvxHXWnbxMUL+NgjNhsV0pj58
	JBcpWwoqcvmxyjYPusTwr+kvDWYefdlys2rj29u68
X-Gm-Gg: AeBDieszyCfJDeEqhT38hG5Te51NU1MpDfdkSugrpXy7mo7ykHJ8QPlMdxQrTjHH90Y
	jUbmaEu0jJrmxK1suKQ2t5ZX0v3oO4zdKylGRsCT8oalFvSD5UPL8UCrtfwfyeitEZtJCon64hY
	nlf9kU6cHRBL5i2mS2asnCZhTrAeUZww2h+g8o3Xx8pwhyTeyimj6KM/vGM+7WFmAJMr/Kpilte
	wjLHOTZY7Z9gHpmD3GR5kLMwyxufupB0BHPhTLNYK9Pl0IqnHZb+iryBLXRbat0DWn5sDmq6+lL
	eUNi9jg5vvtz9TolPtMQyVC5QTG7tM2W4fQXDVwThLuqMcs3hWczIOsuqh7JhMHN8r2HJ0+4nuo
	LnRY1bWXHeprI1S7iJ9ll
X-Received: by 2002:ac8:5d90:0:b0:50d:7384:a660 with SMTP id
 d75a77b69052e-5100e0f4cb1mr71639201cf.6.1777422256877; Tue, 28 Apr 2026
 17:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428224816.11223-1-andrea.mayer@uniroma2.it>
In-Reply-To: <20260428224816.11223-1-andrea.mayer@uniroma2.it>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Apr 2026 17:24:05 -0700
X-Gm-Features: AVHnY4Lxx2_566jaJobQy5M9DdHNmCDtFn90_njALOpDxBSMh5sD-BAbouWm3xg
Message-ID: <CANn89i+dSEkqgbvsonrC5V=e-vnMPVNdVnD+0KdkkAxM_kxEQw@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: rpl: add NULL check for idev in ipv6_rpl_srh_rcv()
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Justin Iurman <justin.iurman@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	stefano.salsano@uniroma2.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E9F6F48DBE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282154-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org,uniroma2.it];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,uniroma2.it:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 3:48=E2=80=AFPM Andrea Mayer <andrea.mayer@uniroma2=
.it> wrote:
>
> ipv6_rpl_srh_rcv() dereferences idev from __in6_dev_get() without
> a NULL check when reading idev->cnf.rpl_seg_enabled.
> When the device's MTU drops below IPV6_MIN_MTU, addrconf_ifdown()
> clears dev->ip6_ptr through RCU_INIT_POINTER(), which is immediately
> visible to concurrent readers. A packet that already passed the idev
> check in ip6_rcv_core() can race with this and hit a NULL pointer
> dereference.
>
> Reproduced by flooding traffic through a route with RPL source routing
> while rapidly flapping the receiving interface's MTU between 1500 and
> 1200:
>
>  BUG: KASAN: null-ptr-deref in ipv6_rpl_srh_rcv+0xae/0x1050
>  Read of size 4 at addr 00000000000006b4 by task ping6/318
>
>  CPU: 0 UID: 0 PID: 318 Comm: ping6 Not tainted 7.1.0-rc1-micro-vm-dev-g4=
6f74a3f7d57 #82 PREEMPT(full)
>  Call Trace:
>   <IRQ>
>   kasan_report+0xc6/0x100
>   ipv6_rpl_srh_rcv+0xae/0x1050
>   ip6_protocol_deliver_rcu+0x717/0x960
>   ip6_input_finish+0xa3/0x1b0
>   ip6_input+0xdc/0x490
>   ipv6_rcv+0x338/0x460
>   __netif_receive_skb_one_core+0xd1/0x130
>   process_backlog+0x2c7/0x9f0
>   __napi_poll.constprop.0+0x51/0x270
>   net_rx_action+0x322/0x730
>   handle_softirqs+0x119/0x640
>   do_softirq+0xae/0xe0
>   </IRQ>
>
> Add a NULL check for idev after __in6_dev_get() and drop the skb if
> idev is NULL, consistent with the SRv6 fix in commit 064137935262
> ("ipv6: add NULL checks for idev in SRv6 paths").
>
> Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>  net/ipv6/exthdrs.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 03cbce842c1a..e398a8851031 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -499,6 +499,10 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>         u32 r;
>
>         idev =3D __in6_dev_get(skb->dev);
> +       if (!idev) {
> +               kfree_skb(skb);

I suggest:

kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED)

