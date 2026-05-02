Return-Path: <netdev+bounces-283483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAzXDGJa9mn2UAIAu9opvQ
	(envelope-from <netdev+bounces-283483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:11:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F67C4B3697
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4281B300405C
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 20:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A23238643B;
	Sat,  2 May 2026 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wdmpil0s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6588A2F6910
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752657; cv=pass; b=gRC4Rg8L5XCdjS+0A5Be0WYW5JYeGGtdIcqJ8hkxOtwGgav+BqqCEYE8oUhWUCkMKjkoARPlmIDg+yJzOgJHINb3OXdC+5laNZ+2WOlTn/a1ldhc1x/0fF45grPgxiq9C4fSc7+0LNMSOjWWOWpglrRf00PS53Kn6RMxlT58mj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752657; c=relaxed/simple;
	bh=BmEnXgg8tPmIxiFsOcmAbWfmmt0C7J2crnmvAJpu9+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrxt0tn6pnxCa0QBFBgBtIzcgWRwmFZZReWpVk23F3bHTdFIOpvxqzT4e0g/pRR7EiOySfLJhg+slsS5J5R0Xw15+Tw757gZ/KuzpYBgTvfRyTAiBTY9iDGq6qyxGYYDZxQAbNQ+PdDXbfwtYQ7aJkS8jbWX509WNFIrh9Vmi6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wdmpil0s; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a41099fa86so3190853e87.2
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 13:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777752652; cv=none;
        d=google.com; s=arc-20240605;
        b=k1FNtnXu3eRneqhJTb/VqXnHToEs2vfJgMnKVV79iqVxO+W/Mw9sJgseSiCAWOlwsp
         wxwPh0nExDBd96dAAiqiFRQVP6N8axGyp8cVs5o3sB4J8ehlcGaWgKRCq/JnpPRarBqp
         /2h/Ge00UELV7MeTrj1M2wzR1aDiaFrkMcum13/4r7hD1Lt60BwPuUo8ilW2TEfwktRc
         WYyNqSRQZ2Ue89bMZhb+Mv/3/Yj9aboNW1hU6Nj/TuN437VaL1ljsvRyirjz1S+XU5Dx
         laXUioHkltVeoczdTnPb0Coe4dXaygkWPkfBOA423AVls4RumhiDun98bKtGtD+82TpF
         JDzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jW8dBReU46ZQAD/dWYei/c27fmURyLmNJvMDiBp4D0g=;
        fh=bVimzyjf7Z26YOC+DhPuzYcYIjFITHj+t8jUQ+mkIvw=;
        b=QXBbBOCTW8QDdMznqDb8h2Q2UljNgXIG795gHYvcHLXHBCmg4MVV4e+aGqFQjxzhZr
         9uimsK3Qbmoi7RQQE2YOMVskDAMK3WzRvsenFMR+GLzmA7OFbrRaEuG0mUKJFuFAYP+Z
         3LatXr95x+dyr6G4XQkX5aZ3xRWnVQNUzdd9apEzSRjt2A7qZQQ8dNsxAz2Okq7wEdnp
         EE7t7pxf5eViZ8i8O8YWf/a4CjjAQeSGPeMgEm0uEw+UC47aGI8rNupfNkVYPFN29kKm
         McOgrL1efXB9CepppRX9MY9+q/s7lTve2SJJZ2YT2Yv4+BMD1jETNgUmI4LDO9+RPLFE
         LvSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777752652; x=1778357452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jW8dBReU46ZQAD/dWYei/c27fmURyLmNJvMDiBp4D0g=;
        b=Wdmpil0swa6R91ryCKVrIxLw1aJs57it2jWYC+uayqAim3pMevx/+8RYtHwsT2h6GX
         alMoRt9UcqD9Es8rZWlvo1hKnrqYnOmge/fx8mfBC2Ub6T5OcSrdnRkFT91S6oGqilIk
         IF2p2KOu81rOvrvLZ01HjGX5Vehr2GaCJRmUkZIMIIlJfq6AURBG64eavvor9dkbM8o9
         CNxyJTBZuSThphePgE2oYi7lpN56VSGAevIR0pCbUkLnEokffCWSKRBOyd1Rl8djcaxo
         NiUdvIK3UpZAVm8RCigA0E9COS0Ap+jmpx7MEe+YQ/3NlOxWrNT9FdJBUx4H75VpyjKG
         JyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777752652; x=1778357452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jW8dBReU46ZQAD/dWYei/c27fmURyLmNJvMDiBp4D0g=;
        b=LwWcZUXFIf/OwZkaLGp38KPccmbcXPcEKCHcPPs+S265s3ZgalO0gJH0RMYoi4zJeM
         0nHBgJcf4Fr07d6FzXHXn0NjT8ruk+Cgh9Z60se7TX+kY9Vm48OyqrVaakL4Rhk9zINk
         wy0vn+iwfbwcpwP7Qn3UjgwPi82JAVxDZWShLxsavaCDYYkFmsoQl3odfC7UzksA5gmS
         1eQjTiz1aixq+zIbXGH7FxU7plOKdNXWetO6OMm6uCQw5nMfuotEV04o37RrFBLECtjQ
         ciyLTRDnw/rI217r/m2aGDdz4kfAipO2GQ9QvYR0Ol2jmjCVSuzGdUtIcWPl4N2ESEuI
         MNAg==
X-Forwarded-Encrypted: i=1; AFNElJ+2b3uUT9Wdwqib7TwNEUCqror6FDwQ8qW5YrlvgHeiirFwy5QJWDqooCqLeQZlT/3AnMXLrXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj9SlBVj/eHUC4zWGy64abyUyCPLpbQ/SVzF1RYdIRtUoLaXxd
	pzsnInEnFF6GEwYJyx29gj+jttmtpqChrPVdaM3irHcVyELbcQCkKrkWa3qnIm158UeX7wBS0q8
	bIA6aF2BJxJtinltvDea94FPfGCelhzw=
X-Gm-Gg: AeBDieuu8FSA0qga/z3zXNAEhsjUETB6uQzdmMOaBUKvKgKsG6rF5DlmUmwaQ8089bm
	dtQgxzUPZ+ZviSTNTBK2uPo43QST7e+V7h3zRunmiUSnqzX2n4fVqGyi4/punY3iZE5h06m53n+
	U3OH7ywuHbxMN2TBCyLxpnla+2KjHYH5mwXRF6ljcT3GzYaqOWZw7J3Js+WtKNZbktgCmGwNd1K
	LikjZ7D6wTnJMnQ8hFtGtsHyEFUqiplLgaIN5Jmonpnr0P2tVP1RC310G6WHCWqrmEbeD/zFoWD
	lMpAbxSzlaIYGKuMUdjXC6IfQ3XMJsDmRZ5fdsaxNIdKpODH
X-Received: by 2002:a05:6512:3b84:b0:5a2:a3dc:51e3 with SMTP id
 2adb3069b0e04-5a862ec11b8mr1072024e87.12.1777752652108; Sat, 02 May 2026
 13:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
 <20260424053816.27965-9-kerneljasonxing@gmail.com> <afE7EFYdrNg1u_g2@devvm7509.cco0.facebook.com>
 <CAL+tcoA0j+tHOPr-DLyW26_EF1JhwqV+no0Lcx335FtKRbwUAw@mail.gmail.com>
 <afIeuwJNfwVmk9Pn@devvm7509.cco0.facebook.com> <CAL+tcoBTO9QGM220EO=m1TdiXwod7QzG59j7vQL3qoVSrb2QEw@mail.gmail.com>
 <afQdzWlMzjgpAUq7@devvm7509.cco0.facebook.com>
In-Reply-To: <afQdzWlMzjgpAUq7@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 2 May 2026 23:10:14 +0300
X-Gm-Features: AVHnY4Jgcbb21Gilb1zdl9-vTL4PgXfvRBz0aENbiyrkhBnNys-4k2fvK1e251M
Message-ID: <CAL+tcoDWQG-QaixC_WDsGJemZHN0AffCqCMtdeaqad8ecF-EnA@mail.gmail.com>
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
X-Rspamd-Queue-Id: 1F67C4B3697
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283483-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,tencent.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tencent.com:email,mail.gmail.com:mid]

On Fri, May 1, 2026 at 6:29=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmail=
.com> wrote:
>
> On 04/29, Jason Xing wrote:
> > On Wed, Apr 29, 2026 at 6:14=E2=80=AFPM Stanislav Fomichev <sdf.kernel@=
gmail.com> wrote:
> > >
> > > On 04/29, Jason Xing wrote:
> > > > On Wed, Apr 29, 2026 at 2:11=E2=80=AFAM Stanislav Fomichev <sdf.ker=
nel@gmail.com> wrote:
> > > > >
> > > > > On 04/24, Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bi=
t
> > > > > > descriptor address into skb_shinfo(skb)->destructor_arg (void *=
) via a
> > > > > > uintptr_t cast:
> > > > > >
> > > > > >     skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)add=
r | 0x1UL);
> > > > > >
> > > > > > On 32-bit architectures uintptr_t is 32 bits, so the upper 32 b=
its of
> > > > > > the descriptor address are silently dropped. In unaligned mode =
the chunk
> > > > > > offset is encoded in bits 48-63 of the descriptor address
> > > > > > (XSK_UNALIGNED_BUF_OFFSET_SHIFT =3D 48), meaning the offset is =
lost
> > > > > > entirely. The completion queue then returns a truncated address=
 to
> > > > > > userspace, making buffer recycling impossible.
> > > > > >
> > > > > > Fix this by handling the 32-bit case in the destructor_arg help=
ers:
> > > > > >
> > > > > > - xsk_skb_destructor_set_addr(): on !CONFIG_64BIT, allocate an
> > > > > >   xsk_addrs struct via kmem_cache_zalloc() to store the full u6=
4
> > > > > >   address. Leave num_descs as 0 (zalloc) so that the subsequent
> > > > > >   xsk_inc_num_desc() brings it to the correct count of 1.
> > > > > >
> > > > > > - xsk_skb_destructor_is_addr(): on !CONFIG_64BIT, return true o=
nly
> > > > > >   when destructor_arg is NULL (not yet set), false when it poin=
ts to
> > > > > >   an xsk_addrs struct.
> > > > > >
> > > > > > - xsk_skb_init_misc(): call xsk_skb_destructor_set_addr() first
> > > > > >   before touching any other skb fields; on failure return early=
 so
> > > > > >   the skb destructor is never changed from sock_wfree.
> > > > > >
> > > > > > The existing xsk_consume_skb() already handles 32-bit correctly=
 after
> > > > > > these changes: xsk_skb_destructor_is_addr() returns false for a=
ny
> > > > > > allocated xsk_addrs, so the kmem_cache_free path is always take=
n.
> > > > > >
> > > > > > The overhead is one extra kmem_cache_zalloc per first descripto=
r on
> > > > > > 32-bit only; 64-bit builds are completely unchanged.
> > > > > >
> > > > > > Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@=
smtp.kernel.org/
> > > > > > Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descript=
or number")
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > ---
> > > > > >  net/xdp/xsk.c | 38 +++++++++++++++++++++++++++++++-------
> > > > > >  1 file changed, 31 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > > > index ed96f6ec8ff2..fe88f47741b5 100644
> > > > > > --- a/net/xdp/xsk.c
> > > > > > +++ b/net/xdp/xsk.c
> > > > > > @@ -558,7 +558,10 @@ static int xsk_cq_reserve_locked(struct xs=
k_buff_pool *pool)
> > > > > >
> > > > > >  static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
> > > > > >  {
> > > > > > -     return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL=
;
> > > > > > +     if (IS_ENABLED(CONFIG_64BIT))
> > > > > > +             return (uintptr_t)skb_shinfo(skb)->destructor_arg=
 & 0x1UL;
> > > > > > +     else
> > > > > > +             return !skb_shinfo(skb)->destructor_arg;
> > > > >
> > > > > Don't understand why we need to special case CONFIG_64BIT here?
> > > > > Shouldn't the same existing condition work on 32bit?
> > > >
> > > > Because 0x1UL is the particular semantic applied on a 64-bit arch.
> > > > xsk_skb_destructor_set_addr() sets it while
> > > > xsk_skb_destructor_is_addr() recognizes it. They are a pair.
> > > >
> > > > As you noticed, one liner works but is not that appropriate: on a
> > > > 32-bit arch, this member should be either a NULL point or a valid
> > > > pointer pointing to a memory region. Testing if it's NULL can be
> > > > helpful as to the long term maintenance because of its readability =
and
> > > > robustness/safety.
> > > >
> > > > The error path in allocation of skb is really complex, which is why
> > > > I'm so cautious to take care of it :)
> > >
> > > Let's cleanup the error path instead of adding more complexity? Simil=
ar to what
> > > you do with your "xsk: fix xsk_addrs slab leak on multi-buffer error =
path",
> > > but maybe add a few NULL checks?
> >
> > Good suggestion. I think I can cook a follow up patch to do such a
> > thing targetting net-next tree. This patch 8 belongs to net material
> > which means it will be backported to the older stable kernel as soon
> > as it gets merged. IIUC, the better way is to make it as simple as
> > possible?
> >
> > >
> > > Instead of 32 vs 64, I'd like to reason about whether destructor_arg
> > > is an address or an allocated array (not whether we have 1 or >1
> > > descriptors). And we special case 32 bit by always allocating it.
> > >
> > > Haven't checked, but maybe this is all you need (besides your _set_ad=
dr
> > > changes)?
> > >
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 6149f6a79897..03f217e85d31 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -589,6 +589,8 @@ static u32 xsk_get_num_desc(struct sk_buff *skb)
> > >                 return 1;
> > >
> > >         xsk_addr =3D (struct xsk_addrs *)skb_shinfo(skb)->destructor_=
arg;
> > > +       if (!xsk_addr)
> > > +               return 0;
> > >
> > >         return xsk_addr->num_descs;
> > >  }
> >
> > Right, as I mentioned, how about posting a new cleanup patch with your
> > suggested-by tag?
> >
> > >
> > > > I've noticed the status has been changed to 'changes requested'. Do=
es
> > > > that mean one way or another I have to post a new version?
> > >
> > > That wasn't me :-) From my POW, patches 1-7 are good to go..
> >
> > Great! Thanks for the review. My hope is to get this series merged
> > soon in the net tree.
> >
> > >
> > > > >
> > > > > >  }
> > > > > >
> > > > > >  static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
> > > > > > @@ -566,9 +569,21 @@ static u64 xsk_skb_destructor_get_addr(str=
uct sk_buff *skb)
> > > > > >       return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg &=
 ~0x1UL);
> > > > > >  }
> > > > > >
> > > > > > -static void xsk_skb_destructor_set_addr(struct sk_buff *skb, u=
64 addr)
> > > > > > +static int xsk_skb_destructor_set_addr(struct sk_buff *skb, u6=
4 addr)
> > > > > >  {
> > > > >
> > > > > [..]
> > > > >
> > > > > > +     if (!IS_ENABLED(CONFIG_64BIT)) {
> > > > > > +             struct xsk_addrs *xsk_addr;
> > > > > > +
> > > > > > +             xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_cac=
he, GFP_KERNEL);
> > > > > > +             if (!xsk_addr)
> > > > > > +                     return -ENOMEM;
> > > > > > +             xsk_addr->addrs[0] =3D addr;
> > > > > > +             skb_shinfo(skb)->destructor_arg =3D (void *)xsk_a=
ddr;
> > > > > > +             return 0;
> > > > > > +     }
> > > > > > +
> > > > > >       skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)a=
ddr | 0x1UL);
> > > > > > +     return 0;
> > > > >
> > > > > I think this is gonna be a 3rd copy paste of the same logic? Let'=
s
> > > > > move to a new helper and replace existing kmem_cache_zalloc place=
s?
> > > > >
> > > > > xsk_skb_destructor_alloc_list(prev_addr) ?
> > >
> > > Any comments on this?
> >
> > I didn't comment on this because I thought I was not that sure if we
> > needed to wrap it up in the stable kernels :)
> >
> > Of course, it would be easier for me to work on the net-next tree to
> > make the code look
> > more neat and elegant.
>
> Are you concerned that you're gonna break something in the net tree? Why =
not

My primary concern is this patch would be a little bit more
complicated (more insertions/deletions). IIUC, the fix should be as
simple as possible to easily get backported while we can do some
cleanup work on the next branch.

Please see this new version (v5) with your advice applied. Does it look goo=
d?
https://lore.kernel.org/all/20260502200722.53960-9-kerneljasonxing@gmail.co=
m/

Thanks,
Jason

