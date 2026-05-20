Return-Path: <netdev+bounces-289949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L8AN9q7DWqn2wUAu9opvQ
	(envelope-from <netdev+bounces-289949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:49:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B1158F0F6
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FDE3302A19F
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068133A0E8B;
	Wed, 20 May 2026 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QcSJHfK+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C832E348477
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284916; cv=pass; b=lRDbyozzKm0y8ml5a9A0vF0/sVdfUKR0UsHy2bLMj2niU5vpUCGytupkI4RhVf5j9Sk0xtXCn/S9h6N8jlqISR2BX9Gbb2NGSAaslEDBpmkOvK9ei1Ij5oXKUgZUw4Z+N//Du12o3RONsc3Vmfc/jlrIUYH8ysZW46f9R2Yd6i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284916; c=relaxed/simple;
	bh=Ux4DsBH/b+Hxghz4BUeS5WLTOtBGR43EC7jTFpvlaU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRjL6xvxlOFyoFjzHbjKVZSsknBCC472nEpIEcAVlAK428wrKfhS43wsOf7XiVBpO9RKuhpulhzuUBZoCijq3L3LnP+aktIUwIS8CBHUZ6zY2A6GLcPBu5pDvOX6f3gdy7j/1OsfpakR3h0LF7jI1ioUvesmmTGPE+6eqeMab8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QcSJHfK+; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50e5ad864a6so57720161cf.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 06:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779284914; cv=none;
        d=google.com; s=arc-20240605;
        b=d5EMQc5z8KLXRTHbj4Av7QnsZRJdhaWzA27gRY2WNtxgptfwVA0niAlhwRShdj0leI
         pMWMwRyMtAu+OYMD1UEYWTLmXLW+2xwzYojFHxW9rcpqxGjda6+US+CveeXGRdjiVlJZ
         hr0zxEBBHpC1+xNHYFrOHRO0WWLf61XdfWazGnioZ0jGKNmTWt6oumOruRHslZWQhiYd
         u5dWO2PvWEQBsX1QZWJuCIr/+Yd9do0qkMp6YtSDuvHIFEaehrMPT86DAcvmPIXpueMP
         cWSKqDJsdAvE4K3SfAO3jFGXXs+TYVTUbnq17AQyrOdCGoaVm1aPyuTlgrsBAad2qyYy
         mFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1cDlDwz3hMGqwA/Q8tdCQU22JoDf/l7QLUPLiALNk5o=;
        fh=AP07VpQdA1+nRqKAtxQFBNqw9sIN0YDy6bZvpqNz0rg=;
        b=aVZh4C97WlucJe8y72AxNZQf19BpjEgaIc1ZMtBj9NH6qnLVo6hOr7a/zM8FCf9psJ
         OpcnNFNXuu6TPtkcVhhozJOBBJf7PhvuZPp8UyHZYb3im3WJuF2Bma909GhQC/8t5PMO
         egtrdrjLSLDiW0Do+BJhoH4alIn09EuPQUIUBcHB5ZSX6l7qUppOxqngeiFKmsoRD0bU
         B/1yW6pJGm/NOhtH/E71/nlZjZ2LYARyy5E+iP/sqthGChLRLEzlLJN+N7rthpSmsTLM
         930A9BeZw7xU7kw4pixGhL8NKRP/5g/wYomjXDVkcknVNxgfZMwoO0w1LCGvSMwjpUpc
         4gCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779284914; x=1779889714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cDlDwz3hMGqwA/Q8tdCQU22JoDf/l7QLUPLiALNk5o=;
        b=QcSJHfK+rzABe8aOKmyPao+xrndA/F3g68EBf41o3MWqnF/hXuyGtMqfYsMc96xpAl
         Av93s+gBb8Nw9AtUSbC2iBfOxMpG3t9JHJ1ZPkJLGYz7veu6m2sUsl/kuUo2W15Jlvgm
         GpaVjVZ1qFOlAQd9d0rQD/cku9z87UO2wM3q6pqNENKw+vs0dlkwKp3T63lRfxM0xvBj
         3jJARN+7HkAQk0hhhkEZDpt3xcZhur6o7lR3pT5RdK6fIDx0znwY9SuWWvmess8ogUsf
         KgZKcbMpMU6LaxCvRYhLOq+irndB3rKZNhCW/0fRXHaUJMwtqTbnDtKCL1QkJWnHeuH+
         dRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779284914; x=1779889714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1cDlDwz3hMGqwA/Q8tdCQU22JoDf/l7QLUPLiALNk5o=;
        b=Z1YQO/vdOfqXSRaB4eI1qwMIOEPb30em4Kgcxvxp1Ybg0G/7JtPfPbaY9NbMONgdAy
         aR379mlyVZjcrx/hvmaPJktzzJeVqVCUk8dlf6xMIEsRA7wdOfCLeiReSj2ywt80vE+E
         KNrm/3y0Rwx7N2heooDA5skjjnA+rtR63oh+n9TYRir8xRrOl9N3630w+n0qLxWtGSuQ
         ouLljjQSZFldEx5MHIwDll6ruiTJ8FJyDozAzSHZZFtJxbdCSszSq77R+rehwC0Zds2m
         igFa4x/IVoP5rd8kS++7u8GcOIb4wKslyZhN34jfFnPJ/OU6DxIKJaZdi4rWHpl31QB1
         OPCA==
X-Forwarded-Encrypted: i=1; AFNElJ/GKNqcqs0ruzhTZOJv2pXCKD/4r7u9TXhUSTUxqxgfxhinOSR+UuMLOIkUtd1o/s5uGD3r13A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjRhX0c7rgZhVJ+BLt12svpc5gCO5uYogVj1E4+fqxNbdCk3kt
	3c5lr7Du0dYqQ9Vl8da+rNZHSuLl44RAs4cTYU4pSUAJV4gYcEDRWlzFyqDUlad4yJTg6qBgmcl
	yrtsXpeQJLkPpTmi+flKYSpai3p6k+QxV3o6i+21g
X-Gm-Gg: Acq92OF7U+u3NnT4tRjRlPxa/uKth78/aNARcC79IyFoRzm5cvARKi67gvkaLMYwE/e
	yRxDXs0vp2HNc2/eN5Vx/7vF7jM5AshhxYHvFbZcFucxyGA/oS9/TTriFSxSB+h0x54V4v/upTG
	sqg6EnHnXvD3E3u0ALBiMNODqkH/AlTwJ46QvxFsh7vuhi1QIfMdwT7f2lLszdV3uydXXyODpg8
	xlDy35vuE1RngU70uwhtVAUICdANXrf+kbcbs9q7RqmsRzgJFN5VWlgLg1C+BlWWM+06Czo3VP9
	JDnukgTB3a+h6hu51KwKgU5fEuNR6F5WnJPZbxxdbtEWXdP+mytS5Fs6RILAJSXMCoMK2sUrs63
	6j4R47E705Qw/LXhHydmhigjq6g7nq6b3e7RuA6JB9xiLahf6gd7gQ5ubDSJbom3x
X-Received: by 2002:a05:622a:1e89:b0:509:30b0:8323 with SMTP id
 d75a77b69052e-5165a0a4269mr339397951cf.31.1779284913096; Wed, 20 May 2026
 06:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519172635.86304-1-yzjaurora@gmail.com> <4172DA29-330F-42FE-91FE-C247D67F852A@remlab.net>
In-Reply-To: <4172DA29-330F-42FE-91FE-C247D67F852A@remlab.net>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 May 2026 06:48:20 -0700
X-Gm-Features: AVHnY4I1HxtwYRIMQmpaAedNn2XzP1Myd4LGPNWE-JvWR-mVw8CYeoBpVMex7PQ
Message-ID: <CANn89iLrG5axgET0_gsTKM0mM1v8aMUzGBLcPgo0icDJB2VuZw@mail.gmail.com>
Subject: Re: [PATCH net] phonet/pep: disable BH around forwarded sk_receive_skb()
To: =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi@remlab.net>
Cc: Zijing Yin <yzjaurora@gmail.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-289949-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,syzkaller.appspot.com:url,remlab.net:email,appspotmail.com:email,pastebin.com:url]
X-Rspamd-Queue-Id: 16B1158F0F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 5:03=E2=80=AFAM R=C3=A9mi Denis-Courmont <remi@reml=
ab.net> wrote:
>
>
>
> Le 19 mai 2026 20:26:33 GMT+03:00, Zijing Yin <yzjaurora@gmail.com> a =C3=
=A9crit :
> >The networking receive path is usually run from softirq context, but
> >protocols that take the socket lock may have packets stored in the
> >backlog and processed later from process context. In that case
> >release_sock() -> __release_sock() drops the slock with spin_unlock_bh()
> >and then calls sk->sk_backlog_rcv() with bottom halves enabled.
> >
> >Typical sk_backlog_rcv handlers process the socket whose backlog is
> >being drained, so the BH state at entry is irrelevant for the slocks
> >they touch. pep_do_rcv() is different: when the inbound skb targets an
> >existing PEP pipe, it forwards the skb to a different *child* socket
> >via sk_receive_skb(). That helper takes the child slock with
> >bh_lock_sock_nested(), which is just spin_lock_nested() and assumes BH
> >is already off. The same child slock therefore ends up acquired with
> >BH on (process path) and with BH off (softirq path):
> >
> >  process context                   softirq context
> >  ---------------                   ---------------
> >  release_sock(listener)            __netif_receive_skb()
> >   __release_sock()                  phonet_rcv()
> >    spin_unlock_bh()                  __sk_receive_skb(listener)
> >    [BH now ENABLED]                  [BH already disabled]
> >    sk_backlog_rcv:                   sk_backlog_rcv:
> >     pep_do_rcv()                      pep_do_rcv()
> >      sk_receive_skb(child)             sk_receive_skb(child)
> >       bh_lock_sock_nested(child)        bh_lock_sock_nested(child)
> >       =3D> SOFTIRQ-ON-W                   =3D> IN-SOFTIRQ-W
> >
> >Lockdep flags this as inconsistent lock state, and it can become a real
> >self-deadlock if a softirq on the same CPU tries to receive to the same
> >child socket while its slock is held in the BH-enabled path:
> >
> >  WARNING: inconsistent lock state
> >  inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> >   (slock-AF_PHONET/1){+.?.}-{3:3}, at: __sk_receive_skb+0x1cf/0x900
> >    __sk_receive_skb              net/core/sock.c:563
> >    sk_receive_skb                include/net/sock.h:2022 [inline]
> >    pep_do_rcv                    net/phonet/pep.c:675
> >    sk_backlog_rcv                include/net/sock.h:1190
> >    __release_sock                net/core/sock.c:3216
> >    release_sock                  net/core/sock.c:3815
> >    pep_sock_accept               net/phonet/pep.c:879
> >
> >Wrap the forwarded sk_receive_skb() in local_bh_disable() /
> >local_bh_enable() so the child slock is always acquired with BH off.
> >local_bh_disable() nests safely on the softirq path.
> >
> >Discovered via in-house syzkaller fuzzing; the same root cause also
> >on the linux-6.1.y syzbot dashboard as extid 44f0626dd6284f02663c.
> >Reproduced under KASAN + LOCKDEP + PROVE_LOCKING, reproducer:
> >https://pastebin.com/A3t8xzCR
> >
> >Fixes: 9641458d3ec4 ("Phonet: Pipe End Point for Phonet Pipes protocol")
> >Link: https://syzkaller.appspot.com/bug?extid=3D44f0626dd6284f02663c
> >Cc: stable@vger.kernel.org
> >Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
>
> Acked-by: R=C3=A9mi Denis-Courmont <remi@remlab.net>

Reported-by: syzbot+9f4a135646b66c509935@syzkaller.appspotmail.com
Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!

