Return-Path: <netdev+bounces-280638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOU+IXrK6WnAkAIAu9opvQ
	(envelope-from <netdev+bounces-280638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:30:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 783DC44DFA2
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 620723004063
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FC43019D8;
	Thu, 23 Apr 2026 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j4jGPTaC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918222F6596
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776929396; cv=pass; b=LW9QvGPLgKd4ZhwfdjHcj9ZqRzwJoh63DjyxB0q1cG7URZjoow7jAeWgI64MZNrvsj2f3ob2GpUqDt8vQacHV32mBbunWEyz5DP7qiuIwEOEY9c7H0EVvuxZCF0miWks7dlF5tRfMopTzL/THCCVPxa9eUY9FEt79X2NZJvhxoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776929396; c=relaxed/simple;
	bh=VaDUsQKV38C45wmrL7PiZd9GpWCcs1l+OT1jLLAPiTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4wqEsqr9vxHNmSn1QCDc1zvIeCGFcGNtt4/X5wgZeIjJQkDm3njSlUFJe0YZq8Vhb37JRUj5OpDkYNh/NRFbSQ41/ojzvi8DxEmzYoodnKcQY8oTWdsxd3ZLDkAIExLjgpQ+qkHqNkuOA/3m/MFCkSoPZa6u7lh7YNhAMfAOMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j4jGPTaC; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d75bfb259so47045841cf.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 00:29:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776929393; cv=none;
        d=google.com; s=arc-20240605;
        b=XoTCJwa9JWhWQb/9MFPlwTIU6eM3CapSeBpE/qItHyoyvuySUX59kpAcsVq+DPV4IV
         34+BHfO9zU4TpOwjYz+ep4WW0cP+wBgy3HZdmjkB+92QobPkG4f/ElDC9NdfNOzAv/VV
         mic5uBDpxmsf27obrupUIWgUgbA9wRzxb2tMCOfONOQLGXM1Q41d6jGLPfCBtpWpaWYA
         VDEmQ+7oJsoKN8BDlOraIJ/P1GUmBWMfqpceG/BrWO8eXDCbtMVQJpolmXUAsPE4MG5E
         qLv/Rxag/GtuxAui5G9ytiwsHzjKJLrumyvGYBc0OMEFm1WvahykrKqV+aL8+K9Q8BSa
         7eaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jLerY7DcJMoLq+ZZtWqlDzEo51W2UmhOWIB77RZJ9cA=;
        fh=oUSa4gDjxn/8GsSdHf9ukA/IYlZiz2yTa4dlYgznNes=;
        b=MKFwY2HKelvews5C2Rs/USflKMEAPQivch2NsdunpjKEd/CT0EgTie42+QlXQqY6Di
         0TYB60CHciWWjAU3AJdp8d76geYTcUvrgV7lP5Lf7gjzutWtAXAGaXG2vbDy4v7OBzwa
         SCmfXikFOC+wtOKoSXuC4lYZKIMp50s8dILj3ng0Yd++KMJcxcbedNVxuNJ1J6zSZRxY
         G8k2rZglPdlYUi2iKxvb3e9Z/4QEvqY79NE+2opXCHKWtKkhxqEnbvYdP08ThqxB+4fk
         DU6XL/SScn3bGsHw/ovyPPRl3Ca1jfMYfPFYO7qBb8OZsAqi8KJTyJ8bRMBq0srgOPpc
         Ka5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776929393; x=1777534193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLerY7DcJMoLq+ZZtWqlDzEo51W2UmhOWIB77RZJ9cA=;
        b=j4jGPTaCI4bVEd9ULKEI1kAUJMVJso+wb9MKawFtCl6OKw2zLgnklLxKFOOnQj0x+f
         3LN42WualrmdP5g8VVIIpHWsKq5UlkwmwdiByrSqwBF+bTMZCbeSaZf1qoFWsHgQh4v6
         ObyW5DhT/8DfPzmKBrzgnctJKDO3czg+HNLnnRFJWyG4f/CN3fn2WIP1Dpnfs2UEiG+Q
         kXk+v4eSr0bLZ7jfiSQETvMvwdkw1mETDywteppC+9WIrPy4s3Gw9Y+CNf9eVHYXxcnn
         oFrQsBFCXnBIjbpz1UQesIUdmze2GtqmJPNT8/WYrcxbHUSEjqYb1s10ejyVQ5u31Ikq
         F5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776929393; x=1777534193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jLerY7DcJMoLq+ZZtWqlDzEo51W2UmhOWIB77RZJ9cA=;
        b=dX26yf8MtAAsjvYkWKkFPaaChyknk9gVMa/4T0D2FlfxWlcQCHqsDy2xaZzkcFn/qd
         6Vlp0RJ0kJ2RA0Odl+9FEW66I0dMfQbruaI2k0f7T33yM2xL/9tCkQGKPWUPhpod4ogb
         62yInRQVuPkb3REdq9H79GhRkLFaoEds73t4M3Ez++7dkgmAAcP1IXIB5b0eBmisFWx5
         WagNn4UptBa33Qu7hn3ngbutKgRMA4s6NjgGqXsUOo2XqzlLavhkrzNGjprPBfhMck4N
         NR6/0ayhgdz7OLW5uTkackHc9S5n915L305RpxQBmY+PVjYH8+YtGaD+u6f6wdjj4Ykj
         fFjg==
X-Forwarded-Encrypted: i=1; AFNElJ+M4shQd3YPRwyVUBbEHSZlI4oDu6N2SE99gr3BGG3FnunfyGE0UJG7f0SS9gtuzPRiFJDfWzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRpJFMdmd5PsxPdP6MMJuYj58a08ZdYVhuw63DPyenhuGkYhva
	pLmZdVtGxXdPic+YpYszMbp4zPW3vaHUndUlTGoqicw9b0fua9r0zVw0WRJ/UMocJk8MpCZ3pXh
	aNrUX/ra3hsjqA6VD+RhiP+8Qq+3FPmlzVgv6v8/h
X-Gm-Gg: AeBDiev8l7svx6Uvmav2uDLqYPex7EIrt0JKVN5Yo2dagBUBcvi9BvNUVi20BIJ5cN2
	ZrAU59Ro5+bqHUyjb7uzMQNLQiFe/FLQV4qZyrkdoyhS5MZy4+prPSAhgSXnUc5/A/plHKXP9WH
	aE7V1xVwD5TlSPqoT4V6PDPpBRLivEZqAqKL3mg6pDChCiBlz6xWgjRmccXApHNEIpjNuEKCPE9
	kMCJv43Kr+jkI5UQjgFD8Z9dRlaeFopYM5OEXs5KxpKYiRdLWlUPB3S1+TzW55RpF2j6ZiC6ezE
	mPAs8zc409CVmJPwp2X12qa9iqh+NFvzOzHJ2y9L3d/8JAlIl4h84xzBdDJoDlRQgOn+uRnLd7Y
	1T7R935+JuwT1PSO0luM=
X-Received: by 2002:a05:622a:59c6:b0:50f:c54f:cc42 with SMTP id
 d75a77b69052e-50fc54fd65fmr79267461cf.14.1776929393013; Thu, 23 Apr 2026
 00:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423010933.3899132-1-kuniyu@google.com>
In-Reply-To: <20260423010933.3899132-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Apr 2026 00:29:41 -0700
X-Gm-Features: AQROBzALElDcbS3X4-wky_SDD92inr2sB1fQOaUUc_5WBt20g9tpjWHM7KNJDVY
Message-ID: <CANn89iKwALD=b-FqwQe=GjB23u5ksdepOZG+3PCjMESBqSw1bg@mail.gmail.com>
Subject: Re: [PATCH v1 net] udp: Use READ_ONCE()/WRITE_ONCE() for hslot->count.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	David Held <drheld@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+04905b8b3523856476c0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-280638-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,04905b8b3523856476c0];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 783DC44DFA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 6:09=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> __udp4_lib_mcast_demux_lookup() and __udp4_lib_mcast_deliver()
> reads the number of sockets in the 1-tuple hash table chain
> locklessly. [0]
>
> Let's use READ_ONCE() and WRITE_ONCE() for hslot->count.
>
> [0]:
> BUG: KCSAN: data-race in __udp4_lib_mcast_deliver / udp_lib_unhash

...

>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 UID: 0 PID: 15111 Comm: syz.6.4060 Not tainted syzkaller #0 PREEMP=
T(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 02/12/2026
>
> Fixes: 2dc41cff7545 ("udp: Use hash2 for long hash1 chains in __udp*_lib_=
mcast_deliver.")
> Fixes: 63c6f81cdde5 ("udp: ipv4: do not waste time in __udp4_lib_mcast_de=
mux_lookup")
> Reported-by: syzbot+04905b8b3523856476c0@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69e97093.050a0220.24bfd3.0048.GAE@=
google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

You forgot to change net/ipv6/udp.c

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 15e032194eccc3c29b3e5f3a09214cad60623329..1f4dabe4c350118441f61c1cf03=
98e698581542c
100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -953,7 +953,7 @@ static int __udp6_lib_mcast_deliver(struct net
*net, struct sk_buff *skb,
        hash2_any =3D 0;
        hash2 =3D 0;
        hslot =3D udp_hashslot(udptable, net, hnum);
-       use_hash2 =3D hslot->count > 10;
+       use_hash2 =3D READ_ONCE(hslot->count) > 10;
        offset =3D offsetof(typeof(*sk), sk_node);

        if (use_hash2) {


Also one part is missing in udp_lib_get_port()

@@ -289,7 +289,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short sn=
um,
                        hash2_nulladdr &=3D udptable->mask;

                        hslot2 =3D udp_hashslot2(udptable, slot2);
-                       if (hslot->count < hslot2->count)
+                       if (hslot->count < READ_ONCE(hslot2->count))
                                goto scan_primary_hash;

                        exist =3D udp_lib_lport_inuse2(net, snum, hslot2, s=
k);

