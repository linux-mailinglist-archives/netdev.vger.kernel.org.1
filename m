Return-Path: <netdev+bounces-290078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AICoGDkmDmpZ6gUAu9opvQ
	(envelope-from <netdev+bounces-290078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:23:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7307359AC57
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F33753053C83
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9FC345CA1;
	Wed, 20 May 2026 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDOQO2mY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7B9344D91
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305339; cv=pass; b=kStp0KF/3eqbt8LXb/R/MZ8F8FvUyVGGwRRPQIH/j6MXj94TA1ln9aRwiOdqJRLagcqzy6Fn0Qq491nB2WGQpSnsC+fUKkvUX8o5Q5D6vUmeJs8k2qxQG07WVwQFZ7XTblX+Drm6Q8PDSxBw/C35adr0589KGizNyEpyggK9WMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305339; c=relaxed/simple;
	bh=yG/p/yuvMmqBSrI24CIpddBCL6WpWYyfLyN4AvPjGIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHsEpazXUHd/NDPjphGYyJHQABn0HpfpVYZC4Bykkimr8aCuMU9qSburcqtC5Q9KbzD07qTDxlXzFltePC+/BpOnZ4d110cnZwcEu8+ECoCco3fOEjGOxtBnWal2Q9MVJwSo2GgD0KqLLRCvMhCsrwK4W/BWK2MkBWXTsQbMfEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDOQO2mY; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-47c7b282d73so3456502b6e.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 12:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779305337; cv=none;
        d=google.com; s=arc-20240605;
        b=OaXo5kp8RcMS+PcC4AVGR9JO/MjDOtzIYrJfLHX0UkRlcxrwm7/8K63t1Wrs9d1fkI
         vdRO3KTovwLK827Rp1zrQEoZ85WCq/RS4+cFGLOg61KEAY/rTn3zGCEMR1NbPsUQkTIr
         hp4LKIRM0vPIa0ggoz9o7ou+r4s+nPlPoRB5JVEjfIXRwAUExy0BykjrHrSvo72UdPmb
         xQRHKxJpl/hkEvm7edyROLgLUUHoLYMn6ryPnkfoENp6KBxinw1tq1ZLN1jHh6BGZIRd
         BXFQTOHErS/DH+jXJ5cq9yGh/gWmhQnnJTTQ/Qt0tOo+37Om2M2DgtFXljqGwpJNS/lk
         jJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A3UCWntrndamBVtc/z+S3mQBh/bx6v1SPMImgyyDyCA=;
        fh=rr39U6oV3pVQh0ICWYqrzBc2zypk4O8QuK+sIb37zhU=;
        b=BoFfoSy19vieEcIocx9zBbIe0sy81RkZQv2/u8cxFidV6xn0sTno6SGg/trmtjm5MK
         7h7gRTPOIEVjZBkDbFj72dHccdLn1TFgok4QZdQmNlN4hr9xCpg+IuuZ/jsXmb1EVoR2
         wePtgXQtmt3oscxdgqbK+/3HORTgEbEacw2qOqnfECctedbvzJl3JloYjMFG6mpfnr+6
         iSBcUeK6a+uf8MezWoxRHpMXwlYGAN2EBhWM1a/UC297Y4DVg74SULDBlg5pX1INiHkz
         l6z5RnRhWOGEIE/T6tXNrvxY3N9EaDvV/dl1uPUP3ApkyrF8tMgxlS/a+SApZYV3LFXf
         DzIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779305337; x=1779910137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3UCWntrndamBVtc/z+S3mQBh/bx6v1SPMImgyyDyCA=;
        b=XDOQO2mY2JxKrCvsz8pwXTrrYe0wLP1IvH3Zhz2heeJWT12MfrPNfl+TSIPeBvjefC
         08iw8IiZgA9dvRNqpg5Y6hQ7DeG6krpDWxo2IqUuDsG2NYhy4EmTVz/mR38n7UwCB69X
         iY4rY3YEr8luHm5JbAURtLqd9aZCoNKO+rN+9DLvVkQeZgxM2yopcs3emLl5kC/ZMhj5
         OBsw2l8h7z4wl4o10VweawaUGv4xhj75gyDhufSEk12IS5/fLhRjjL8NWl0/XQoKBjEH
         0dFnVzd695pGt8H7HJRXN1uj+nCcdplN/z4BLQLpLgSQSa2XmAPOOGvSeOqS3CTBGkIQ
         ivxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779305337; x=1779910137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A3UCWntrndamBVtc/z+S3mQBh/bx6v1SPMImgyyDyCA=;
        b=ZpMwkaM+HdoUvLbwY0gDBo3b9TLj/o5sZAuPwzvKfsGdmN4HQuxPd5qAsDzBMVhwIT
         Vr/w5yaltDMhEkUN6WkpK9pr3wKbPxQgEJ9HS6WF2bXOxktExOikDVFyCafe8X913Rud
         b3T53lsq+U+7jnsjICppkEfQAW8rrzMp2u2qAZBSlCUcdl8yccX+6DRQ5JA1A0455M36
         3UQ8TACNoXAVM3PykozUpsC6U8cOQU3FqBLgWpnqPo+aXYhNnKnEpN0kULneRRZBUsSV
         tZqmLaCQ+ILSZl42v1TlF/e/LSlbbxXrGrFUJhThN+x5g6535a1f795JDuumDghQKUbY
         SbaQ==
X-Gm-Message-State: AOJu0Yx50J5zEoYXAjdqoIXq/ohPE6DcCFAt5YwY2exBQlfVJP7DFleJ
	WO/Ai6UR0vIPj/9tLfEgnQ+cJgA/BbyI5DiAq+ZXmh1/iwnkXpemH6YCRsn6+cF7IEMMHiyoq7v
	9ectPSj2NpzvYSPU3tkWZx+qrpP4/EdjmPKhHtaUvVw==
X-Gm-Gg: Acq92OHJs6TvZvGsigGhn4I2yNwkg6PB9oSVlgapXdrVAOQCvvFu+AUh1Uv7ib1TVPF
	cFfAkpgxVNJ7X54OsiFISNpihZq7BjKf6mdCK+XGEstAU4i4eWZ3nkVW9GJNYqicM+HZFiwgtVs
	wcrvtgAmHZ6Jl63pXQKaEbdYt933Dysie346pl0DbR7vatMJxT1U7PRec8gm97Hk+c6uUCPjFgc
	Fs01wOMNR+WeFAdZivNm2R8HNBq2AU0dW1VlZMm8z62o0UVHv5A2TzOMeBynC9azwSCKzqNBPfb
	q1xZYN9wRNWkKVvZYp6Rnz32MOt9DjCDo6YN3A==
X-Received: by 2002:a05:6808:6714:b0:479:fb8d:dfb7 with SMTP id
 5614622812f47-482e596ca6fmr17496612b6e.33.1779305337045; Wed, 20 May 2026
 12:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519203530.66310-1-devnexen@gmail.com> <CAHS8izOL4yyPH4+ZUXxKB6JAj0EgbFK5UkG+SSb4rk_vG6EfhQ@mail.gmail.com>
In-Reply-To: <CAHS8izOL4yyPH4+ZUXxKB6JAj0EgbFK5UkG+SSb4rk_vG6EfhQ@mail.gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 20 May 2026 20:28:43 +0100
X-Gm-Features: AVHnY4KuWqXR53z8xCkPj3OfkuOQUnc1neGMFTH-z7PxOL90NyF34xVuL-9wu-0
Message-ID: <CA+XhMqxPNEBVey8xw_yisymwL2H_04hL48GOyPk08U8p0tYM2g@mail.gmail.com>
Subject: Re: [PATCH net v2] net: devmem: reject dma-buf bind with
 non-page-aligned size or SG length
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	sdf@fomichev.me, sdf.kernel@gmail.com, kaiyuanz@google.com, 
	bobbyeshleman@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290078-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7307359AC57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 at 19:55, Mina Almasry <almasrymina@google.com> wrote:
>
> On Tue, May 19, 2026 at 1:35=E2=80=AFPM David Carlier <devnexen@gmail.com=
> wrote:
> >
> > net_devmem_bind_dmabuf() trusts dmabuf->size and sg_dma_len() to be
> > PAGE_SIZE multiples without checking:
> >
> >   - tx_vec is sized dmabuf->size / PAGE_SIZE, and
> >     net_devmem_get_niov_at() only bounds-checks virt_addr < dmabuf->siz=
e
> >     before indexing tx_vec[virt_addr / PAGE_SIZE]. With size =3D
> >     N*PAGE_SIZE + r (1 <=3D r < PAGE_SIZE), sendmsg() at iov_base =3D
> >     N*PAGE_SIZE passes the bound check and reads tx_vec[N] -- one past.
> >
> >   - owner->area.num_niovs =3D len / PAGE_SIZE while gen_pool_add_owner(=
)
> >     covers the full byte len, so a non-page-multiple non-final sg
> >     desyncs num_niovs from the gen_pool region for every later sg, on
> >     both RX and TX.
> >
> > dma-buf does not require page-aligned sizes, so the bind path has to
> > enforce what its own indexing assumes. Reject both with -EINVAL.
> >
> > The size check is TX-only (only tx_vec is sized off dmabuf->size); the
> > SG-length check covers both directions.
> >
> > Fixes: bd61848900bf ("net: devmem: Implement TX path")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> > Changes in v2:
> >   - Reframe commit message around the kernel-side OOB instead of
> >     "real exporters already page-align", which read as the OOB being
> >     unreachable and undercut Cc: stable (Stanislav Fomichev).
> >   - Hoist the SG-length check out of the if (TX) branch so it covers
> >     RX too; RX has the same num_niovs / gen_pool desync on a
> >     contract-violating exporter, just without an OOB. Keep the
> >     size-multiple check TX-only (Stanislav Fomichev).
> >   - Drop bool todevice; compare direction =3D=3D DMA_TO_DEVICE inline t=
o
> >     match the existing call site at the tx_vec[] assignment
> >     (Bobby Eshleman).
> >
> >  net/core/devmem.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index 468344739db2..4f71de44c0fb 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> > @@ -241,6 +241,11 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> >         }
> >
> >         if (direction =3D=3D DMA_TO_DEVICE) {
> > +               if (!IS_ALIGNED(dmabuf->size, PAGE_SIZE)) {
> > +                       err =3D -EINVAL;
> > +                       NL_SET_ERR_MSG(extack, "TX dma-buf size must be=
 a multiple of PAGE_SIZE");
> > +                       goto err_unmap;
> > +               }
> >                 binding->tx_vec =3D kvmalloc_objs(struct net_iov *,
> >                                                 dmabuf->size / PAGE_SIZ=
E);
> >                 if (!binding->tx_vec) {
> > @@ -267,6 +272,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> >                 size_t len =3D sg_dma_len(sg);
> >                 struct net_iov *niov;
> >
> > +               if (!IS_ALIGNED(len, PAGE_SIZE)) {
> > +                       err =3D -EINVAL;
> > +                       NL_SET_ERR_MSG(extack, "dma-buf SG length must =
be PAGE_SIZE aligned");
> > +                       goto err_free_chunks;
> > +               }
> > +
> >                 owner =3D kzalloc_node(sizeof(*owner), GFP_KERNEL,
> >                                      dev_to_node(&dev->dev));
> >                 if (!owner) {
> > --
> > 2.53.0
> >
>
> No hold on, I don't think we actually have a bug here. AFAIR all
> you're describing is intionional . Yes the TX vectors and their niov
> arrays do implicitly 'pad' the dmabuf size to PAGE_SIZE.
>
> But net_devmem_get_niov_at has this check that prevents us from trying
> to send past the dma-buf size, even if it's not page_aligned:
>
> ```
> if (virt_addr >=3D binding->dmabuf->size)
> return NULL;
> ```
>
> IIRC the NULL should be bubbled up to the user as some error.
>
> Please double check that we actually have a bug here. If not, please
> don't merge this. This change could break existing users using devmem
> TX correctly with non-PAGE_SIZE aligned dmabufs, which is a valid use
> case.
>
> And if we have a bug, lets fix it in some way that doesn't deprecate
> support for non page-aligned TX dmabufs. You may be breaking users
> here.
>
> --
> Thanks,
> Mina

Hi, Mina, note that the guard you're quoting doesn't cover the case
I'm describing. It's in bytes against dmabuf->size, while tx_vec is
sized dmabuf->size / PAGE_SIZE
  (truncating) -- there's a sub-page window where the check passes and
the index doesn't.

  Concretely, PAGE_SIZE =3D 4096 and dmabuf->size =3D 4097:

  tx_vec allocated for 4097 / 4096 =3D 1 entry (valid index 0).
  sendmsg with iov_base =3D 4096:
    virt_addr >=3D dmabuf->size   ->  4096 >=3D 4097, passes.
    tx_vec[virt_addr / PAGE_SIZE] -> tx_vec[1], OOB by one.

  And the OOB pointer isn't just returned to the caller -- it flows
through get_netmem() -> __get_netmem(), which dereferences it
(net_is_devmem_iov() reads ->type) and
   on a matching byte refcounts the binding off of it. So this is a
controlled OOB deref, not just a stray read.

  On breaking users: the partial-page tail was never TX-usable to
begin with. The fill loop only populates num_niovs =3D len / PAGE_SIZE
entries while
  gen_pool_add_owner() covers the full byte len, so any sendmsg into
[num_niovs*PAGE_SIZE, dmabuf->size) was already heading for either
NULL or this OOB. It's not
  deprecating a working configuration -- it's rejecting one that wasn't wor=
king.

  Also worth flagging: the second hunk (sg_dma_len alignment) is the
RX path too. net_devmem_get_niov_at() is TX-only, so the guard you
quoted doesn't apply there, and
  the num_niovs vs gen_pool_add_owner(len) desync hits every non-final
SG with a sub-page length, both directions.

  If you'd prefer to keep non-aligned binds legal, an alternative
would be tightening the guard in net_devmem_get_niov_at() to virt_addr
>=3D num_niovs * PAGE_SIZE
  instead of >=3D dmabuf->size. Happy to spin that as v3 -- but it
doesn't help the SG-length leg, which still needs rejecting at bind
time.

Cheers.

