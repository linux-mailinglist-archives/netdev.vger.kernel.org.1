Return-Path: <netdev+bounces-290039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LyjHRwoDmpq6gUAu9opvQ
	(envelope-from <netdev+bounces-290039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:31:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC38959AF59
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24A89398BBC1
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60623F23A4;
	Wed, 20 May 2026 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTBsi6GR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6B372B31
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301329; cv=pass; b=MMYsyU83FUIuFI/hyrOOXnuzWHZ2pql1VWkTK/ohpqP4h2Dnkm3R6sVlBsboKp74802dYZs/bYL6lylbP9ANASWq3vorYmZUg2DxyFHPMSwgho3C81IOmxOO5Odgadru/sVUUAXQu9f+uEqVsc7rEgxGu12Ta8LBEjCIZLQhsBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301329; c=relaxed/simple;
	bh=rcS2pVh/E4mmAOLCS+6UlIacSefA69VxHBqQrxF8Fz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdQ0Cf9bNBU4lEqhvqi2CcXQlZKX7S5w2obxb0o0FUEun2d16s56o+6zOIHBigxaYS0Zj375dGm+Vt8igqX12k8oLdiO+hdTWndS2CR+1rm1o2D6RSKAT60h6pnkzBCZcm8zIObj2fHb+0vHqHawFyCMoW1UWVadgTArwMoERSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oTBsi6GR; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-133466cf955so17287742c88.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779301327; cv=none;
        d=google.com; s=arc-20240605;
        b=KFLCDu7WbqjadOSPy6FVMB+Bo609ZbbFxIF+Ih5PD7rtzAMxKkGxkl8o16c+gMIBiJ
         tcCeVF6OK+xwsL2R7RYBlqiW/PT4dovx7HWyHAtPVp0Y8kRxjJmRBgLWzhJmg3N6NEjb
         489FGb5IawVSdr5la5I34bRkgAiY6xUYFz5Zp80dw7FuhQUBGYmNYZEZCD0WWb2P2w7U
         3vQqaKu4EOdME6EklO/M2RXes+k3TaB4DohQpfT7NCMPv+HUIm2MLRxKyZihpDn13jRY
         uMOH1k5QeuTwCcuztLJ9UlN/5JAUSRZM8d90IT5nm8QFGBiWMN0k4sqIPzmtlzWtXMq2
         2qqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZZZbrwvDP8nHiBeDtzwHkdXWDATvNQxssl+C+cIvFzs=;
        fh=+5V+7CUfhv/L0lOX/BCGsZRD21fEeHtcUtEQpi7dz34=;
        b=cA5/2lC2HG18ptgRGwpiZySQghiLKcHdAPjO+infIL/5zs7QqMwOHI9QTMykGgnkpJ
         EPhFQ7UtrT8+LGtDX375nEmOQdSu45uhD1/kNRSPHh1Tf+Xmguhk2dQGVW+uM8/PjR9G
         4cl0sdBDkM/Rui3mKssq8Rnmi8ozCZQBhOgSX613BaU5fWAJvzFpDbgDt29hpbeCb5Qx
         i+8eMqsjSVetvmmMPSVjPUGU1k/2ABzoEGxn9ty73ABLxelq7ydzZGzSlDlDE2BrHjD3
         pBjqtUc9H2b4U5cxdwyEpCA1ndb86oGH9iO4vWQG7ik1Nkl2uaBU92d/HCDcwsRrYUZE
         EG9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779301327; x=1779906127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZZbrwvDP8nHiBeDtzwHkdXWDATvNQxssl+C+cIvFzs=;
        b=oTBsi6GRWoyKpbJ04ZFRWMFMyY93x57iuP0mKo2DGgM937PwaMjFiCkpRlNSdacrQ1
         5ttyv3M5r+91u/goc3SP/5e6aiX5Ezer2E9hZdfE2yvmYXdGfUTWIw7175RAoP+LgdcI
         NwsL30smnY4col57zqbqoQGBQBJfHY81uLEt0oP/DX0a11M8gL9hsR5ZI1G5GjG3XkfY
         cZfHxmfXWEal5xVBNAC1eKR7qGEWGEUyFs2ZB9tpKwS5VllhGTlE9cmPx/QLAbr/3Xi9
         k82k9LEHpBCYdWOrYv+nbU976Mu1Dlhd596pMO/PtuRVsf/9fgbVDQ0H4CANYLy8XfCz
         zymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779301327; x=1779906127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZZZbrwvDP8nHiBeDtzwHkdXWDATvNQxssl+C+cIvFzs=;
        b=a+KTTjpP+jt2XZ9BmME0qC6qOVqiceO/5+29cKJLU7h2OSOsALIfhw242nwygpUgwJ
         eLMJOy2YlhlsEPdAivE7QjmAz0IZkBF8+SZs2u/GoAQa2bw9Apm6CZuw3PpdHzIt+e+h
         f9sQNIli4TPPCN6tDCj8zwGfQ76EfEFxOW337kxM/hazRWeaSnBflWo7W1w63NiQoR+u
         y5MhQEXqa/5PM2WH2r0U2URyGAITs4IMDfNkeNgI6RTjk7wEXQe6xY7Qhhf7/tdNiiSP
         b8ddYA+7gZEdmWIQLRcxc2v+ZDunbi8OMjyYS/4w/62skMlKOUv6iwi9ZtoU5qRDTxR5
         ZTXA==
X-Forwarded-Encrypted: i=1; AFNElJ/8PWGO56o6MMlk283Aitp7gGZc9NbAp+YMmlmXzrp8Go8d0dOtsP+wTgUUInWud5TyysZugTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0C3YZhczWB+X3kmBNiOWBq4cE+YzlWcJySBT31eQVCnCYfI9J
	TjL7ZJjKHCq8Ls0dkqgtiVabnYDdQnvRG1nI/UEK+9d/5nm5PaE+o8I1MsDjHx9K44VLlIVlM5k
	mUe4HC6COmySXkySCuADq1PPjjgKHUgVBmpxCujzE
X-Gm-Gg: Acq92OEZahS2DoBZu8l3wS2nfi+ERwhwsdrQY/hbXiAPX5Be7oG1TUoK7ZPa47CSGuZ
	JBPMC9VB7vj7OW0WDt5JIyteOFBeIfcuccEFEqr5bTvLn7tP7k/ltLcgW+/gu+vBKrohHtSut/N
	FQH77A5FOhjS7QB8GK5FDsLrbkZGUc3oxRVkDLBeBEaq9RPJQgV1q2ip4BzYPh2IUuX4iqFE/O2
	KybTWcKAdFtCImCDrpxgI4Cl5dWjTtGy3eu7MMjMMdtQ59TPUSHMHB2n7kI7tZPs7r34Y1rcYIv
	Xs1odePaDc2Hh3ifj4S4SbkvRtV52yOV2FlYbsu08yTPcFDV+NOCau369g41ZJbjuCvFjrKn0+B
	rITjY0s6t9D/mwjy+tnSyLFCkc7U1aVDLwNfqyp46NdLaX9O9gTWnSq8wSi2Vj0lNk9T1v8gcRA
	==
X-Received: by 2002:a05:7022:f9d:b0:119:e56b:958a with SMTP id
 a92af1059eb24-1350451e343mr11402542c88.15.1779301326702; Wed, 20 May 2026
 11:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518050726.318824-1-kuniyu@google.com> <20260518050726.318824-3-kuniyu@google.com>
 <CAAVpQUDeQ4p5fDOXuWy6fqFA=y58UfB3h7F5V1jvMYg9_p_TmA@mail.gmail.com>
In-Reply-To: <CAAVpQUDeQ4p5fDOXuWy6fqFA=y58UfB3h7F5V1jvMYg9_p_TmA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 20 May 2026 11:21:54 -0700
X-Gm-Features: AVHnY4LjiRCylggTpYXqTolh1IPfA_j-97r1PDtqzGl_Z69gwgj93ECnkBoiyEQ
Message-ID: <CAAVpQUCq10wFaOtTy3V8RgzW+SLW_e8etNUzUtRkMZ=iuWTZJQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 2/5] geneve: Remove synchronize_net() in geneve_sock_release().
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290039-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BC38959AF59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 7:30=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> For Sashiko review:
>
> On Sun, May 17, 2026 at 10:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> >
> > vxlan previously had an issue where the fast path could access
> > stale pointers, which was fixed by commit c6fcc4fc5f8b ("vxlan:
> > avoid using stale vxlan socket.").
> >
> > geneve later followed the same pattern, and commit fceb9c3e3825
> > ("geneve: avoid using stale geneve socket.") copied synchronize_net()
> > from vxlan_sock_release() into geneve_sock_release().
> >
> > However, that change occurred after commit ca065d0cf80f ("udp: no
> > longer use SLAB_DESTROY_BY_RCU"), and geneve had already been
> > using kfree_rcu() to free geneve_sock.
> >
> > Therefore, the synchronize_net() was never actually needed there.
> >
> > Let's remove the redundant synchronize_net() in geneve_sock_release().
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  drivers/net/geneve.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> > index b36fad833724..4e5d0a09a82d 100644
> > --- a/drivers/net/geneve.c
> > +++ b/drivers/net/geneve.c
> > @@ -1032,7 +1032,6 @@ static void geneve_sock_release(struct geneve_dev=
 *geneve)
> >  #endif
> >
> >         rcu_assign_pointer(geneve->sock4, NULL);
> > -       synchronize_net();
> >
> >         __geneve_sock_release(gs4);
>
> ---8<---
> Does this function leave the device's hlist node linked in the socket's
> vni_list?
> In geneve_open(), if the IPv6 socket setup succeeds, the device's hlist6
> node is linked into the IPv6 socket's vni_list via hlist_add_head_rcu().
> If the subsequent IPv4 socket setup fails, it calls geneve_sock_release()
> and returns an error.
> While geneve_sock_release() drops the socket refcount, it doesn't remove
> the hlist node. Because geneve_open() failed, the interface never gets th=
e
> IFF_UP flag. When the interface is subsequently deleted, dev_close()
> bypasses ndo_stop (geneve_stop()), which is where the hlist removal is
> normally handled.
> If the IPv6 socket is shared and remains active, can concurrent RX traffi=
c
> trigger a use-after-free when geneve6_lookup() iterates the vni_list and
> accesses the freed geneve_dev?
> ---8<---
>
> pre-existing issue in geneve_open(), so orthogonal to
> this patch.  I'll follow up on net.git separately.

This was a false positive since geneve creates both IPv4/IPv6
sockets only for collect-metadata mode, but it does not allow
sharing sockets.

