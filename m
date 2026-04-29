Return-Path: <netdev+bounces-282228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N2aKAZ+8WkOhQEAu9opvQ
	(envelope-from <netdev+bounces-282228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 05:41:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A3948EB52
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 05:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EED26301150A
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32CB2C0260;
	Wed, 29 Apr 2026 03:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyUYd35E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D6024A067
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 03:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777434107; cv=pass; b=Lofe4GVed7OOwHu5C3mfzU30LElIntBGYqd1uPfXVptFgbPe4wX49suUF3Lw1fv3c5x/8vZbK8Rbcq3KG9WCcZDd8KzsrskYWyzoP3im+VQHW9YY4ho01MXDBu7QC9Lj9t6VBgPqaYSgt4O7ASxmum8M4tmFbaONYB69dh9C73g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777434107; c=relaxed/simple;
	bh=1AgJ/iZ+yxVyTBccrjIytFwrSGBWeASY4/uRssTvWak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzYuJTJPEA1NAbq9tHNhrlqrtA8BTz4wNwDS0tCq7m+FEqmNLY6FS9N547XBKOgKQYfs7HbYxEW/Eo+eIkUyD8qBI1T9q2CM+JP3ZN1Gw0XvI3w6/7Rp/aNYJ2Fz0+C87jRSFf5EJYOM+qXtej3UZFQauFI9l7TvUNbresetl2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyUYd35E; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3922b35e69cso30814851fa.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 20:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777434103; cv=none;
        d=google.com; s=arc-20240605;
        b=C1aMa70zXI0d+xEok/WLYtquuk1aNpb/ewTDzRTN51gxiZmZLMwDwU4LkSIwyOxh80
         AJmSFX7vP8cGnbk5X5d3iI1oue7DHeRFOWyiinuwVKWSdQWzk4ujECj7WXwCJ5xkDz/O
         /8hKtO+ZqYfxvuk+VrTVgR4plZAx1gAVrb/i0ULPvtk69PcWZ8araMhgpuWV8dh2XHOD
         sv8k46cnuDYtrjXkdaHE5JzEJVZiAZZEQMFmsXGVX4LcWcz8NxltCh8OmuC5e+ff+GDp
         IPON1b6sS30rzSJig8e+cCUVA8uSPKmM1+4mwadvQ7SOULChhYMadP7fy/eTqQfBKXNt
         na1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Ruk6MIfAq6RGeIbwYOky+24mFcxVrwW7kYRMU64s0I=;
        fh=tITMrJseNmhU/QD449NY7pxyireIbt0ufltgzqg/b5E=;
        b=iAHf0Xs/+NTf5nuN5tHeRwnFsTG5sW2+QukH4XVjpCCbpSQmKYkaMrmqsxqLsjpkTr
         0esskSKhqX44d9Ys7jefRYrkInTZE8pceyS86sMylBqi8t4LwsMGTgrq8Cmbw/avax6f
         jEU3weBqS1AoV8/aWWBrMR2XZd2T5rZoAKr15tDTyGJsY39SKnWhYmMI2oo9X7kDkM1B
         ABmF80SF95wgHdkCQntyBqrHrKffLnAnjVdH+ksFnOEhySUZ+HKcqldlM2UMGGp5qeMp
         c/wHJDwclXMjvdJUvwh3RyrJfeNhTgD+qCME/WXUzjYw6SbugQl3RHEXTafyBWmTsxEf
         CfNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777434103; x=1778038903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ruk6MIfAq6RGeIbwYOky+24mFcxVrwW7kYRMU64s0I=;
        b=QyUYd35ETYIrBF9kk0eq2RX5Q6bvETdL1xZ4UW+aC8xpNA9HGy4D3/Fta62a18Cbuk
         CM9W6CmEXaHF6R19a4oTk0EUy/ANSe1zsOJoRRWwOpryLenvYYd/jvbgZXiLqfAvPs2Q
         svAv+5PWyz8UA54cp9qLTkLjhsPKb41SGaT3coPvlULLuYHZu+f9h8Y6tO1IGlrdPXmp
         zCjpBQK9x7IgKEAtE8LQ4Elu9hbhHNGaDQymKQ9TQM8StG8TUsZl8dTP03sWNaSXluj7
         YGSzgagUnZIk19YQ6erjySVH0mqdn1OhscY9gUQV45J/ED0CjzwN4K/U4lg51MtDFtRd
         um4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777434103; x=1778038903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Ruk6MIfAq6RGeIbwYOky+24mFcxVrwW7kYRMU64s0I=;
        b=byRrRXbxlAh+l3ywSzwiO+uVKycvP3Wq8URvIbFf+p7jDeEyGHS38pkPrzZkaJcQcI
         CmEBWuN6xjXqJGs+b/LmLF6PwNNmo9aTF+RARSHnzCYBoFMf0v5CVzJifis0rKt1eoYS
         jhJ+D9M37XHy+Qm9XcrZUnvuhKl7vBLYvKVwNGKn6NTXBwDWcqtTaFvkzw494eWale34
         iIxxLbCEeaxQ5BCpGVhSLnRaWv0qDF8ehjbUiAvCJUFaIxp1xkYQdmgrNXCxMUCeTqq0
         1BmMwngRK36NtMjNvEYtavl7GygxetO94Nibc5FkSNP4WXvC5PbE59pq0qQMpj0yv2GC
         M6UQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Nre1M/oP/6uSSiRQCO46mrjODMCcwZii8m2VjQiA1dDMlPSlyx9cd1zZUPmjwC/9nv7I5cp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbuGV8eSUMrBHO7MxS+l2wbi72VpqvpzpDvTER8nnnhrjyusFE
	RSY6tTJJ8ca+SwmE1qlPsqOPX48hEBjG50L0w4cyDUU9+5G503RW284owV4PE/7nmGQhdHrU9OP
	yZM4ML2mxkeE9RXa4s5TShxM/k8ri1Fs=
X-Gm-Gg: AeBDiesg5mnUZZwQMsCmNlLWmxsliUzJ9UBYThw74W3C+Hc9R4olDj8KOSHouj6rb0A
	zurV6ZVA+ckZWktLbfpXaaXdxM/mfbgnbCkqC0r0WFgEbDW9H6+MEI/nh2SnPw62RKbqv57JkP7
	V2Rd2Eg+RvC7Urm5NfNBe/9PMEK97CW2edLb1+2l97Q8eDPkFdHygmhzg9WhZ0Gic/qh7FWBL2Y
	n+NjQXqiLBUYVTYvXR24usoIaf62dfad+RQgHxbqPHHio1W0wa5gRnxBCNoaA9t0qc5LXeVZXBh
	1aVLVMi7E2m/BYvqxPdrUktYZQxRAfCesq+xqJpDybkObd0=
X-Received: by 2002:a05:6512:114c:b0:5a3:ccae:c650 with SMTP id
 2adb3069b0e04-5a74660ed58mr2159980e87.26.1777434102764; Tue, 28 Apr 2026
 20:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
 <20260424053816.27965-9-kerneljasonxing@gmail.com> <afE7EFYdrNg1u_g2@devvm7509.cco0.facebook.com>
In-Reply-To: <afE7EFYdrNg1u_g2@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 29 Apr 2026 06:41:05 +0300
X-Gm-Features: AVHnY4KK9bx9x3EL_qgNLT4hjlw0wtoxviJnnLnGHp1l0EefBQZ5qSnKZ_YCOio
Message-ID: <CAL+tcoA0j+tHOPr-DLyW26_EF1JhwqV+no0Lcx335FtKRbwUAw@mail.gmail.com>
Subject: Re: [PATCH net v4 8/8] xsk: fix u64 descriptor address truncation on
 32-bit architectures
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, aleksander.lobakin@intel.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D2A3948EB52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282228-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,tencent.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,tencent.com:email]

On Wed, Apr 29, 2026 at 2:11=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 04/24, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> > descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> > uintptr_t cast:
> >
> >     skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | 0x1U=
L);
> >
> > On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> > the descriptor address are silently dropped. In unaligned mode the chun=
k
> > offset is encoded in bits 48-63 of the descriptor address
> > (XSK_UNALIGNED_BUF_OFFSET_SHIFT =3D 48), meaning the offset is lost
> > entirely. The completion queue then returns a truncated address to
> > userspace, making buffer recycling impossible.
> >
> > Fix this by handling the 32-bit case in the destructor_arg helpers:
> >
> > - xsk_skb_destructor_set_addr(): on !CONFIG_64BIT, allocate an
> >   xsk_addrs struct via kmem_cache_zalloc() to store the full u64
> >   address. Leave num_descs as 0 (zalloc) so that the subsequent
> >   xsk_inc_num_desc() brings it to the correct count of 1.
> >
> > - xsk_skb_destructor_is_addr(): on !CONFIG_64BIT, return true only
> >   when destructor_arg is NULL (not yet set), false when it points to
> >   an xsk_addrs struct.
> >
> > - xsk_skb_init_misc(): call xsk_skb_destructor_set_addr() first
> >   before touching any other skb fields; on failure return early so
> >   the skb destructor is never changed from sock_wfree.
> >
> > The existing xsk_consume_skb() already handles 32-bit correctly after
> > these changes: xsk_skb_destructor_is_addr() returns false for any
> > allocated xsk_addrs, so the kmem_cache_free path is always taken.
> >
> > The overhead is one extra kmem_cache_zalloc per first descriptor on
> > 32-bit only; 64-bit builds are completely unchanged.
> >
> > Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.ker=
nel.org/
> > Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor numbe=
r")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/xdp/xsk.c | 38 +++++++++++++++++++++++++++++++-------
> >  1 file changed, 31 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index ed96f6ec8ff2..fe88f47741b5 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -558,7 +558,10 @@ static int xsk_cq_reserve_locked(struct xsk_buff_p=
ool *pool)
> >
> >  static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
> >  {
> > -     return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
> > +     if (IS_ENABLED(CONFIG_64BIT))
> > +             return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL=
;
> > +     else
> > +             return !skb_shinfo(skb)->destructor_arg;
>
> Don't understand why we need to special case CONFIG_64BIT here?
> Shouldn't the same existing condition work on 32bit?

Because 0x1UL is the particular semantic applied on a 64-bit arch.
xsk_skb_destructor_set_addr() sets it while
xsk_skb_destructor_is_addr() recognizes it. They are a pair.

As you noticed, one liner works but is not that appropriate: on a
32-bit arch, this member should be either a NULL point or a valid
pointer pointing to a memory region. Testing if it's NULL can be
helpful as to the long term maintenance because of its readability and
robustness/safety.

The error path in allocation of skb is really complex, which is why
I'm so cautious to take care of it :)

I've noticed the status has been changed to 'changes requested'. Does
that mean one way or another I have to post a new version?

Thanks,
Jason


>
> >  }
> >
> >  static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
> > @@ -566,9 +569,21 @@ static u64 xsk_skb_destructor_get_addr(struct sk_b=
uff *skb)
> >       return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1UL)=
;
> >  }
> >
> > -static void xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
> > +static int xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
> >  {
>
> [..]
>
> > +     if (!IS_ENABLED(CONFIG_64BIT)) {
> > +             struct xsk_addrs *xsk_addr;
> > +
> > +             xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_cache, GFP_=
KERNEL);
> > +             if (!xsk_addr)
> > +                     return -ENOMEM;
> > +             xsk_addr->addrs[0] =3D addr;
> > +             skb_shinfo(skb)->destructor_arg =3D (void *)xsk_addr;
> > +             return 0;
> > +     }
> > +
> >       skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | 0x=
1UL);
> > +     return 0;
>
> I think this is gonna be a 3rd copy paste of the same logic? Let's
> move to a new helper and replace existing kmem_cache_zalloc places?
>
> xsk_skb_destructor_alloc_list(prev_addr) ?

