Return-Path: <netdev+bounces-280562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFFKOtNe6WnJYAIAu9opvQ
	(envelope-from <netdev+bounces-280562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 01:50:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE2144BDD3
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 01:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80356300E5BB
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 23:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ECB3806C2;
	Wed, 22 Apr 2026 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6HkVjLm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB0D33B6E3
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776901839; cv=pass; b=cWa4fklyDf08HeNIJ5V+W8mhn6vuhnh2iQI1IiszpsLrSQGZdugE6k1q9xOaIacUZjPh0DVF63T44wxH5D+RzCKBe7cZXLwPO2IcSQ6NVrXuSkAURRvHLLFj2EScY+1FOjujxHy0fK0DFxvwnJOs2gIXpTBBnB3Wnq6HU27+BBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776901839; c=relaxed/simple;
	bh=no9t7n7xzjKEdEguICJKP5JU4MmYUMLOYVDPqJvefng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5GDMTAhE9TZF/svZYn+564tiwXVkJJ4fL6q11JbiWEAAvuDBxRFRqZWAV/tzOMwQkNKKABCf7JCCJzfZHsk3670KwnTUVC9knyjyRJZedlf4Pspj7sisatzOdExqxoRqkPtZaAzFuQeHs1F2RY50B4GO5N2KM44mouOEoNsPQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6HkVjLm; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59e4989dacdso6639337e87.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:50:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776901837; cv=none;
        d=google.com; s=arc-20240605;
        b=W/Mscr/jWxjNs619d8lWAUwQu9H1kK/MWNzGWjfC40bxS4XbEQtHJEMi76DpJxdSKm
         nmT0Tasl5cqmBPFXWQh7rusaD0gVBfeHACFFQxQQ7zrnc0Tonkkx5o5CjPCnlD0zPNP0
         KVAGPZDjscWtuT8bt6F6BbPVRcPYgIGDEZ7P9/50Clsascw1RgOPK6evQA0pp0+symON
         /ZzedAWABIvzKLYrUdsWEyxhAh7S2Se+buDb5ZuLlo9aVBWof2QhuA8TrtTD2TgdBU8g
         86fC9sCFqe4hwXVmbM4IEjDJfJj47VligF4DqvqkWcgB+fS+KL7IaRo/GHoYMku+Tswo
         2Utg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rWKgodUk2lqfpq4zWor/YRrwGhepF6DjxbmcnZlGs+o=;
        fh=p/QtOD2T3VNEaK5Df0E0oSDDbkvBhf3M6y/OdGYZ3SU=;
        b=a50x7jsoKplDpJ7ISi8ahxkRRWYMA9ezcqQQ6u+riSx3Elwncrru15fT3hQ9n8G2wm
         /WBtLoyScjfQDU0zyLan5XWR7gke5/vnA8juUxJgR6SE4XrxFwn2B1uUDhwgPuT0GpNC
         l8/Uug/tRxcxaovI5K07b9BXSTu7hUWDa6JyY8TmDMJgkTCduPCypcedru0fe78qMAi3
         JuOw4toXemnxIoEF8IKUGTa+CfcPnfLnmu6PPZZIKbk5gRW2cK+TDYUNRI9FM4aMr71g
         HF/CMa5V6ELDrwFQbiQh/dpUmlE60Dhc4cRSSf2habmAmpP/OUtlI0RKAzaFow6idSCJ
         fODw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776901837; x=1777506637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWKgodUk2lqfpq4zWor/YRrwGhepF6DjxbmcnZlGs+o=;
        b=g6HkVjLmOwBHp0HkoYLHuCWpWoEzGZxJ7CeeaKthWNW/qMUAWi7EeMJpZjz6BHnlkt
         uNL0+594dcuzrF4/JfmcxuLmtSQGR3o0MfQey5gnlzCoDbiIxAoEZkaq7PAfG0aIM1V9
         LN6KiqzcPauH4N3RMAfjKv3S/qB9DUz3RQBCNLkskQVay/1Zw9dcnAUkLi4vLJqEb2bv
         AO3EBn3ImHQDYvcA+ztCx5g+nGWaX85+4zL4HFyqoOVso5/3Spjy0w7OUu2lyRG3k9gQ
         LCCbWwP1SmiT08Ne8mY8sVlg93xfrmDwKMy6Uy+fGAI6mJK/+vXSrf/4lP3iOooWdNRH
         S7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776901837; x=1777506637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rWKgodUk2lqfpq4zWor/YRrwGhepF6DjxbmcnZlGs+o=;
        b=W9U0rLbh07qPoaDYSMKk85mIG3k2vbANjDpWA6F/4xbK2C19TtDwSis8mjYqMasQBj
         6iq21q2Pq52j85VYIrhPej2aV3TSlEUs2W5I/PK2IqyWlV8w++WSc1cwG9MgCs1bS2k8
         Gp/2drEpAvhfDhLysg3yoa2M9QQCtluz7EPSlrk2ZINsf2JusXKecurkdosPqVQu3kaH
         79dRgiJOpMWEN3c2kFMHDdK2s/wMzezoOtbXJk5P6PTc88cXVnL6kRUTjqsmd1iqXb68
         nbuh4nt0NURO8Pcnj/m3Jy8rGHyMtR2QCSUYe3tNvUl+cwTlbRHyzmQYdBUnGsWjcZ5/
         GiDA==
X-Forwarded-Encrypted: i=1; AFNElJ/BNNHySU4eelSaASYXVj1giVr1AI9Lx5lIIVNA72c2UEbkHAE2cvdXu5lq/076+YUvOSzOPsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+sypbWoPdi3m2LeOAleT5o5UgDgBsOpRt6z/4IZZXJymcvTeG
	XGinuXkEtITe/elc6rMzAG230puv39Wj7Qm7w5GGAKRX2QBCKAtGVtNPjXp/RS3POJK87OBEDq8
	G4sgIG85NYjie1K9zRMv92H6N0nLuIRg=
X-Gm-Gg: AeBDietGxHuM9Ly3oGNTQ0PESrM85rSkp+5FZWIkflGwMjx29uBV+W7ZL1nE9Qeyp6Q
	YmUOMp/RHIZhm2lznh/5u+G+E5t3hhe1e3xEJWymSak0fy/Z4ai9ZyDheH1Cgsk9mXMsxEVFS5i
	ZiLqxbXiAzTSS7s2ZDG9bFaifdj3I8e/yPu1s9GLbIyxkk42CAp4n/ggnypkA0h9sYOfraQ+VRZ
	IfmNpFt089Kjiz++hMj6gFflbcOq3aR/3VnX0m3EFcVlD2AIwMLuD2CxwtDbACSGZRLM++W4Hue
	XKcY1O+mN5u4yHSqNg==
X-Received: by 2002:ac2:4248:0:b0:5a5:25ae:da23 with SMTP id
 2adb3069b0e04-5a525aedc8amr2944807e87.40.1776901836214; Wed, 22 Apr 2026
 16:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
 <20260422033650.68457-9-kerneljasonxing@gmail.com> <2e0e0e18-cb75-4638-9a12-5906de6a8308@intel.com>
 <CAL+tcoDTXEsehprDHeO7P1pcqwu_US3Li-dm_YyGDAwu2aYZvw@mail.gmail.com> <aej+JZyYwUrRXD6e@boxer>
In-Reply-To: <aej+JZyYwUrRXD6e@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 23 Apr 2026 07:49:58 +0800
X-Gm-Features: AQROBzDMd_qNuudyMnQatwNO4VL0bbzV4lQVlEWMg5FLlJOSPACqvRq_xd0u3xQ
Message-ID: <CAL+tcoBH9qm0Ce=vBuCResVEbC_9a1D2VofTW73Uo+t519Ui0A@mail.gmail.com>
Subject: Re: [PATCH net v3 8/8] xsk: don't support AF_XDP on 32-bit architectures
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280562-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tencent.com:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CE2144BDD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 12:58=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Apr 23, 2026 at 12:37:07AM +0800, Jason Xing wrote:
> > On Thu, Apr 23, 2026 at 12:10=E2=80=AFAM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> > >
> > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > Date: Wed, 22 Apr 2026 11:36:50 +0800
> > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> > > > descriptor address into skb_shinfo(skb)->destructor_arg (void *) vi=
a a
> > > > uintptr_t cast:
> > > >
> > > >     skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | =
0x1UL);
> > > >
> > > > On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits =
of
> > > > the descriptor address are silently dropped. In XDP_ZEROCOPY unalig=
ned
> > > > mode the chunk offset is encoded in bits 48-63 of the descriptor
> > > > address (XSK_UNALIGNED_BUF_OFFSET_SHIFT =3D 48), meaning the offset=
 is
> > > > lost entirely. The completion queue then returns a truncated addres=
s to
> > > > userspace, making buffer recycling impossible.
> > >
> > > What if we relax the restriction a bit? For example, refuse to config=
ure
> >
> > As to the bug itself, yes, It only affects the unaligned mode.
> >
> > I wonder if we can support this after someone requires us to support
> > 32-bit arch and use it in the real world, then we can use the previous
> > patch to complete the full support (which doesn't harm the path on
> > 64-bit arch).
> >
> > The code looks like this based on your suggestion. Just for the record.
> > diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> > index 58da2f4f4397..03417b04592f 100644
> > --- a/net/xdp/xdp_umem.c
> > +++ b/net/xdp/xdp_umem.c
> > @@ -177,6 +177,9 @@ static int xdp_umem_reg(struct xdp_umem *umem,
> > struct xdp_umem_reg *mr)
> > if (mr->flags & ~XDP_UMEM_FLAGS_VALID)
> > return -EINVAL;
> > + if (!IS_ENABLED(CONFIG_64BIT) && unaligned_chunks)
> > + return -EOPNOTSUPP;
> > +
> > if (!unaligned_chunks && !is_power_of_2(chunk_size))
> > return -EINVAL;
> >
> > Actually I'm fine with either of them. Right now I'm not so sure which
> > direction this patch should take :)
>
> Abstracting from discussion, that is not a patch we would want against
> -net. We should not forbid 32bit on stable kernels, maybe there is someon=
e
> in the 'basement' using 32bit xsk on stable kernel. Plus the fixes tag vs
> patch's content looks weird ;)

Sorry, I don't follow this. Any specific suggestions on how to move forward=
?

Now we have three approaches w/o the fixes tag:
1. completely forbid 32-bit arch
2. only forbid unaligned mode on 32-bit arch
3. completely fix/modify the allocation logic of the first frag on
32-bit (see the v2-0008 patch)

I'm wondering how to proceed with that?

Thanks,
Jason

>
> >
> > Thanks,
> > Jason
> >
> > > an XSk socket in unaligned mode if on a 32-bit arch? Or add a check
> > > under CONFIG_32_BIT like it was done in Page Pool:
> > >
> > > skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | 0x1UL)=
;
> > >
> > > #ifdef CONFIG_32BIT
> > > if (((uintptr_t)skb_shinfo(skb)->destructor_arg) & ~0x1UL) !=3D addr)
> > >         // WARN_ONCE or whatever + error path
> > > #endif
> > >
> > > I never used XSk on a 32-bit arch, but back when I was working on 32-=
bit
> > > MIPS 1G routers, I wanted to add native XSk support to the Eth driver=
.
> > > Sure, just for fun, now that we have cheap AArch64 and other 64-bit
> > > embedded chips, 32-bit embedded networking SoCs are almost dead, but
> > > OTOH, as you can see, other subsystems like PP still try to support 3=
2 bit.
> > > Especially given that this issue applies to only to the skb XSk path,
> > > not native in-driver implementations.
> > >
> > > >
> > > > Since we hear no one is using AF_XDP on 32-bit arch, we decided to
> > > > strictly stop supporting it at compile time.
> > > >
> > > > Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp=
.kernel.org/
> > > > Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor n=
umber")
> > > > Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  net/xdp/Kconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/xdp/Kconfig b/net/xdp/Kconfig
> > > > index 71af2febe72a..819aa5795f50 100644
> > > > --- a/net/xdp/Kconfig
> > > > +++ b/net/xdp/Kconfig
> > > > @@ -1,7 +1,7 @@
> > > >  # SPDX-License-Identifier: GPL-2.0-only
> > > >  config XDP_SOCKETS
> > > >       bool "XDP sockets"
> > > > -     depends on BPF_SYSCALL
> > > > +     depends on BPF_SYSCALL && 64BIT
> > > >       default n
> > > >       help
> > > >         XDP sockets allows a channel between XDP programs and
> > >
> > > Thanks,
> > > Olek

