Return-Path: <netdev+bounces-290106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KwWF6g+Dmqr9AUAu9opvQ
	(envelope-from <netdev+bounces-290106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:07:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B83D259C8E8
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 813F9332069A
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B53F379EE0;
	Wed, 20 May 2026 21:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/o9VH2T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEBA379998
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 21:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310987; cv=pass; b=Cxo5RjQdKm4Ax1VX9vP0IwbkSrqBMCPNNBcXjzz5FnMmTfmkX+4gZ8So/3k4GlomX/BnE6x9BNZiMZQ9dU/FmRQzbgOzmX5AmXj8fn/qntGJsl7amP8xDVHH0jukpqJsm+svXuuwwn8e5NeM1TQLyUFcZ7nuRYs4TjGN1oIX3Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310987; c=relaxed/simple;
	bh=stpRi+PiiMy0l41q+2r76uTwBzr3MWreHkAxryAQ1EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wi4z1IrKFx28PfeEBNrMHw7ngXmerhFhc1QPCt9MmNBTtBJm4fAjHAo0vxlfuyDVW2VWmUE8yNNCU0VjtPiHdLAsqZpMW4KNJRKcCbpk8UGHSd17wwyMLwbXjRkZnib+nJiK/EgYnJtB25vp7aAUC3ObjvRDVcDG/OlyJiC6Th8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/o9VH2T; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-47c918c62b4so3580908b6e.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 14:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779310984; cv=none;
        d=google.com; s=arc-20240605;
        b=JQ8KzfmDd32uZ8ymLCuM5h3QOqpnh0n91pPJAOGPWYQeHX+0KqaASlZecAM4cESWQr
         tsudLbOppDwr9M41RlS3LtRB9pw6F2+vZHJCXvsQzTqi0bpXQ95Tdk1U3VTIs/jtK1JR
         wl5TG0ATPl2RQC5oOYyRnFkwuVDZ7ZhfSpQd9TpyFw/2vzYMol4WMXPp7FVyjvE3nSem
         aHOSHmfBd+PnItfzc0TgKaHCv+W0aZ32QgxsAyMNGbATd+TdCUg0ZuC9+Oq3PSy7s40f
         nMrgqT6g58UECAjvAFZOsFIH91JojAyEJBZzUFutl9tzMpEWWKDhH1adKNitynZHp/Ij
         HGhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IQTvCYBr9Cz3MOTTexPKRQiIGmQvkY0YRAS3I+gG8tY=;
        fh=rr39U6oV3pVQh0ICWYqrzBc2zypk4O8QuK+sIb37zhU=;
        b=Xm2xZzx4g/1cF4a3uwgg5sb5xpmLJIWfIV32P8WeeGefH2DMbbJ53m0N53oM3KXw4I
         9VeeyjuzTnINwjzIZAD0UDoLePmwgMAjdoY6KS/07aAyc4UxE7+cXyjQI2flHl8R1jHZ
         pWKyJBEOWZRQlFOWbOnUYgzYMvzPrTWa14+T57NdoZWZ4JMB+7odEHeeMtB+YLl6fsZh
         HYTfH4ju0CRaues0ICozFmNrIZqpc8/SV0ZcvsCCLDJp2u/kHZ5nq33j3oFtpk2Zc+vI
         7ZeUGn51X9zive5fa7DWxxWP3q2YtgpSpfd0AsDFh3eVRPkV4GSQgXEiTN1+KIopfpQg
         GJkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779310984; x=1779915784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQTvCYBr9Cz3MOTTexPKRQiIGmQvkY0YRAS3I+gG8tY=;
        b=K/o9VH2TA0MvmoLnPyUM3aHNcLeqAPIIdTw2EVF7pSxtOFMg2UmyKi1rY4pEtDSL1Z
         oGzuosXbdery23p6PqLO8eFAwVGZyjO+ajnTvcvC3dTfHfMnb+bV7STJRBzB7muJpPLy
         8vKD/V1IXPjBCmTIqP1C5PmfaR8G8zDKeIxECdjrARA2TSpK+nXu9HmFDpliK+ms8uPG
         p1Vd6hKEn/RXTpYJPHED1Xegk6IN1Kemv8QL5VoJ+yLxdDEV9q4BH41ffQf5ntK1+RwJ
         bqfQJr4d0IBGc5nC1AJIK6M5lwI7a8apl/ndiNiqjwWS4JmecEEF9TvsQomqd1ck646R
         QD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310984; x=1779915784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQTvCYBr9Cz3MOTTexPKRQiIGmQvkY0YRAS3I+gG8tY=;
        b=cFJnSgRsraJHSsH2KfByeioaL9mDMuFu/lRyitJQXZbzDtYJKYtJHi+qc/KThtaxro
         pq7hb3Tnef1PIeVBFJ5eWs0D6EQ+Iki+tC+cj38z5gGICi8YF0xEeuGB9rWObVIAwdbZ
         /UOhum91U9tEPmfqOE4YYBLPi3HogN4xqYa1Mn2mmnlstJ9gNsblyKh+BOD9gatzVGgN
         /YIOJ1Xw4hZ/hsDi92NcdudacEqFqrxMEtpl1zfV/Bx1AUPakMi15Qug+F22TlvOznbL
         IeQMimBMMRR2gvrt2Mc/EO/hpQeru9ntQPSdsua0141uGffO/EeENAjh7AjcA+98tNK+
         2buw==
X-Gm-Message-State: AOJu0YwsAZBT9Mn7hWTNX0usHzkfjLMrBw+uXX4m2+dt8zdqqDkH394T
	EztOeRhH9TPsJtXBLfN5vRRGJJgtntyBmQTmGYkmTuhpSyKP4uU76ztunx1dZbwLA5f7Ihwg6xO
	XTzrw4pvuD8uphPl79X6XlOzX8iIUWSA=
X-Gm-Gg: Acq92OFQxnuaGc6TC68dVdHffhce8LwqQXy5TYZ9Cq+SK+uRCuhMyD759yeCzvi2dqe
	jNDSDJ1bs2l1eGf6d8/GMPyA+sKCR1dqcmQ1wJ9gYIkbpTZp/J15XGyicJlKQajqf1Qu59aOeO7
	LPgIuRfhC5tQCpcbm7V3gh6hu8l/DXyA/Wpn0BUYL9xZ6NznX0QVALK//TlMTqzAVqGdx69P2Lr
	PZRxKxmaYCA1y5Mk5qQAGqOxyrkUL+/PFGdXFz5w4nZWK7ol4l4XI1g4GBV/GGWtc/Lv6Q/yhTz
	6cBC7rnTab/ZYnH8wIynEbU/VvQBtXdUOPCLJg==
X-Received: by 2002:a05:6808:2382:b0:467:1458:2a8f with SMTP id
 5614622812f47-482e592d399mr16600671b6e.37.1779310984145; Wed, 20 May 2026
 14:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519203530.66310-1-devnexen@gmail.com> <CAHS8izOL4yyPH4+ZUXxKB6JAj0EgbFK5UkG+SSb4rk_vG6EfhQ@mail.gmail.com>
 <CA+XhMqxPNEBVey8xw_yisymwL2H_04hL48GOyPk08U8p0tYM2g@mail.gmail.com> <CAHS8izMTxrywNPEeYsuyeJ9ETfdwt0qYdHFh5=v8pohboT86AQ@mail.gmail.com>
In-Reply-To: <CAHS8izMTxrywNPEeYsuyeJ9ETfdwt0qYdHFh5=v8pohboT86AQ@mail.gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 20 May 2026 22:02:53 +0100
X-Gm-Features: AVHnY4Jpi7LniJLzlTb__HITTRBbXOaJ145PrJMHGg4oFhdjOskSHMzBvOrZi18
Message-ID: <CA+XhMqx0F5Ujfo2BrgmjzYG030rsu271nppL4DPLEetfMcr-0g@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290106-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B83D259C8E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 at 21:42, Mina Almasry <almasrymina@google.com> wrote:
>
> On Wed, May 20, 2026 at 12:28=E2=80=AFPM David CARLIER <devnexen@gmail.co=
m> wrote:
> >
> > On Wed, 20 May 2026 at 19:55, Mina Almasry <almasrymina@google.com> wro=
te:
> > >
> > > On Tue, May 19, 2026 at 1:35=E2=80=AFPM David Carlier <devnexen@gmail=
.com> wrote:
> > > >
> > > > net_devmem_bind_dmabuf() trusts dmabuf->size and sg_dma_len() to be
> > > > PAGE_SIZE multiples without checking:
> > > >
> > > >   - tx_vec is sized dmabuf->size / PAGE_SIZE, and
> > > >     net_devmem_get_niov_at() only bounds-checks virt_addr < dmabuf-=
>size
> > > >     before indexing tx_vec[virt_addr / PAGE_SIZE]. With size =3D
> > > >     N*PAGE_SIZE + r (1 <=3D r < PAGE_SIZE), sendmsg() at iov_base =
=3D
> > > >     N*PAGE_SIZE passes the bound check and reads tx_vec[N] -- one p=
ast.
> > > >
> > > >   - owner->area.num_niovs =3D len / PAGE_SIZE while gen_pool_add_ow=
ner()
> > > >     covers the full byte len, so a non-page-multiple non-final sg
> > > >     desyncs num_niovs from the gen_pool region for every later sg, =
on
> > > >     both RX and TX.
> > > >
> > > > dma-buf does not require page-aligned sizes, so the bind path has t=
o
> > > > enforce what its own indexing assumes. Reject both with -EINVAL.
> > > >
> > > > The size check is TX-only (only tx_vec is sized off dmabuf->size); =
the
> > > > SG-length check covers both directions.
> > > >
> > > > Fixes: bd61848900bf ("net: devmem: Implement TX path")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: David Carlier <devnexen@gmail.com>
> > > > ---
> > > > Changes in v2:
> > > >   - Reframe commit message around the kernel-side OOB instead of
> > > >     "real exporters already page-align", which read as the OOB bein=
g
> > > >     unreachable and undercut Cc: stable (Stanislav Fomichev).
> > > >   - Hoist the SG-length check out of the if (TX) branch so it cover=
s
> > > >     RX too; RX has the same num_niovs / gen_pool desync on a
> > > >     contract-violating exporter, just without an OOB. Keep the
> > > >     size-multiple check TX-only (Stanislav Fomichev).
> > > >   - Drop bool todevice; compare direction =3D=3D DMA_TO_DEVICE inli=
ne to
> > > >     match the existing call site at the tx_vec[] assignment
> > > >     (Bobby Eshleman).
> > > >
> > > >  net/core/devmem.c | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > >
> > > > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > > > index 468344739db2..4f71de44c0fb 100644
> > > > --- a/net/core/devmem.c
> > > > +++ b/net/core/devmem.c
> > > > @@ -241,6 +241,11 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> > > >         }
> > > >
> > > >         if (direction =3D=3D DMA_TO_DEVICE) {
> > > > +               if (!IS_ALIGNED(dmabuf->size, PAGE_SIZE)) {
> > > > +                       err =3D -EINVAL;
> > > > +                       NL_SET_ERR_MSG(extack, "TX dma-buf size mus=
t be a multiple of PAGE_SIZE");
> > > > +                       goto err_unmap;
> > > > +               }
> > > >                 binding->tx_vec =3D kvmalloc_objs(struct net_iov *,
> > > >                                                 dmabuf->size / PAGE=
_SIZE);
> > > >                 if (!binding->tx_vec) {
> > > > @@ -267,6 +272,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> > > >                 size_t len =3D sg_dma_len(sg);
> > > >                 struct net_iov *niov;
> > > >
> > > > +               if (!IS_ALIGNED(len, PAGE_SIZE)) {
> > > > +                       err =3D -EINVAL;
> > > > +                       NL_SET_ERR_MSG(extack, "dma-buf SG length m=
ust be PAGE_SIZE aligned");
> > > > +                       goto err_free_chunks;
> > > > +               }
> > > > +
> > > >                 owner =3D kzalloc_node(sizeof(*owner), GFP_KERNEL,
> > > >                                      dev_to_node(&dev->dev));
> > > >                 if (!owner) {
> > > > --
> > > > 2.53.0
> > > >
> > >
> > > No hold on, I don't think we actually have a bug here. AFAIR all
> > > you're describing is intionional . Yes the TX vectors and their niov
> > > arrays do implicitly 'pad' the dmabuf size to PAGE_SIZE.
> > >
> > > But net_devmem_get_niov_at has this check that prevents us from tryin=
g
> > > to send past the dma-buf size, even if it's not page_aligned:
> > >
> > > ```
> > > if (virt_addr >=3D binding->dmabuf->size)
> > > return NULL;
> > > ```
> > >
> > > IIRC the NULL should be bubbled up to the user as some error.
> > >
> > > Please double check that we actually have a bug here. If not, please
> > > don't merge this. This change could break existing users using devmem
> > > TX correctly with non-PAGE_SIZE aligned dmabufs, which is a valid use
> > > case.
> > >
> > > And if we have a bug, lets fix it in some way that doesn't deprecate
> > > support for non page-aligned TX dmabufs. You may be breaking users
> > > here.
> > >
> > > --
> > > Thanks,
> > > Mina
> >
> > Hi, Mina, note that the guard you're quoting doesn't cover the case
> > I'm describing. It's in bytes against dmabuf->size, while tx_vec is
> > sized dmabuf->size / PAGE_SIZE
> >   (truncating) -- there's a sub-page window where the check passes and
> > the index doesn't.
> >
> >   Concretely, PAGE_SIZE =3D 4096 and dmabuf->size =3D 4097:
> >
> >   tx_vec allocated for 4097 / 4096 =3D 1 entry (valid index 0).
> >   sendmsg with iov_base =3D 4096:
> >     virt_addr >=3D dmabuf->size   ->  4096 >=3D 4097, passes.
> >     tx_vec[virt_addr / PAGE_SIZE] -> tx_vec[1], OOB by one.
> >
> >   And the OOB pointer isn't just returned to the caller -- it flows
> > through get_netmem() -> __get_netmem(), which dereferences it
> > (net_is_devmem_iov() reads ->type) and
> >    on a matching byte refcounts the binding off of it. So this is a
> > controlled OOB deref, not just a stray read.
> >
>
> Ah, I see. I think that is indeed the bug. In the case PAGE_SIZE=3D4096
> and dmabuf->size is 4097, the intention in the code was to have tx_vec
> be an array of 2, where tx_vec[0] is [1->4096] and tx_vec[1] is
> [4097]. I have an off-by-one error in the tx_vec allocation :(
>
> tx_vec[1] would contain an niov and as is stands we assume nvios are
> PAGE_SIZE, but IIRC net_devmem_get_niov_at() would make sure that the
> callers trying to use tx_vec[1] would only use it for a range that's
> valid, so using [4097] and not a range like [4097->8192].
>
> However when I dug deeper on proper pruning of page alignment
> assumptions in net_devmem_bind_dmabuf, the problems are deeper than
> this patch suggests. We don't properly handle the (probably
> non-existent?) edge case where the dma-buf itself is page aligned but
> for_each_sgtable_dma_sg itself gives us un-page_aligned sg entries :(
>
> I think probably all of this is very theoretical. In practice probably
> the dmabuf implementations in the wild seem to be page-aligned.
> udmabuf doesn't support non-page-aligned dmabufs even so we can't add
> tests for these things. So I guess fine, lets merge this.
>
> >   On breaking users: the partial-page tail was never TX-usable to
> > begin with. The fill loop only populates num_niovs =3D len / PAGE_SIZE
> > entries while
> >   gen_pool_add_owner() covers the full byte len, so any sendmsg into
> > [num_niovs*PAGE_SIZE, dmabuf->size) was already heading for either
> > NULL or this OOB. It's not
> >   deprecating a working configuration -- it's rejecting one that wasn't=
 working.
> >
>
> Yes, but still, today binding a non-PAGE_SIZE TX dmabuf but only using
> actually sendmsging up to the last PAGE_SIZE boundary is working,
> andthat would break entirely. I guess lets merge this and on the
> offchance someone is hitting this edge case we can revisit.
>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
>
> I don't know if you're interested in also fixing the edge case where
> the sg table entries themselves are not not page-aligned. I think that
> also doesn't work properly?
>
> --
> Thanks,
> Mina

Thanks Mina, appreciate the review.

  On the SG side -- the second hunk in this patch already rejects any
SG with !IS_ALIGNED(sg_dma_len(sg), PAGE_SIZE) at bind time, so the
num_niovs vs
  gen_pool_add_owner(len) desync I described in the changelog is
covered for both RX and TX.

  What's not checked is the sg_dma_address() alignment itself -- an SG
with a page-multiple length but a sub-page start offset would still
slip through and produce
  niovs whose dma addresses straddle pages. Like you said, it's
theoretical (in-tree exporters and udmabuf all hand back page-aligned
addresses), but happy to send a
  follow-up as a separate fix if you'd like.

Cheers.

