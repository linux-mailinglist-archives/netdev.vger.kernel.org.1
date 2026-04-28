Return-Path: <netdev+bounces-281959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE57BbjV8GkSZQEAu9opvQ
	(envelope-from <netdev+bounces-281959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:43:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A290D488200
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A1C83076C18
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158D338A715;
	Tue, 28 Apr 2026 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BR5G4XjJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AD23195FC
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777390868; cv=pass; b=nAk3S0XmqJ2QJw8FbaJWRBaLBSukOMbqwDd75ZPYG71NRN7hdkUma+N0/S8xwCI17LvFuT7X58PRFl6SkWul4/JG4ZiMi/Jf8ZCmhywZcRRSIf1msCpIgEjKJ0/dKJde0qLMvNIh9Agfzpo+/QJ4nUmAfDE2eEqC8hEUfUobsn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777390868; c=relaxed/simple;
	bh=4xINcVFO5kfd+yJCD7P8J82g4wFU5ot30bONGvNNDzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cy5gJBNrM9nPkVC7BkYRsyMw6xNfdBHkZJnwwIbmXKpz+yT6u0TPOHL3hmjnnT9XTAw1cL2et2fDYJ0+dH53LdCg744OMbn82N+9RVyB/iN8Ou4lBLfvjcoqH0TnfrTqcAGVTA/6/RLGzY7WYihrhjALDdFm7mknMDgl+U56nWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BR5G4XjJ; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50fae4d1f85so123383131cf.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 08:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777390866; cv=none;
        d=google.com; s=arc-20240605;
        b=PxlFJet9RHA9WGkwjTtekFo2gWI19owIKyN4hApeBi8ahnawPe57wLtKebTIQYN/p4
         4y9mylIYmaZ9N8nibHx4P+mddSpBFk6Ob9OmMPv7utYsijPtaDIxviD/8tTxLE0LDbHG
         bLc/x2RdMokguOlN0TyiXyjyJq12Yk+r+9Ze7cUkQGXYJIwZI75M5Tv36kmoAbFX+evR
         Bj6iHCWcEVT5qreI56twEMH23E5ic5UgWPN2snFBDBwn3DM9fs79510Eh15IC7qgwm5K
         0KnjS0uBgmUW3AILE8krfacYRtf2412bZkBAQgjmYmyr4oQ30n0x1X5Kjl5g2SWdLxGw
         ymSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=caq2mpo+mPm1PnFQBexgS5xqZ7EOsplHY9fJx1jIehA=;
        fh=MrK+yXwWwhommiPajtwaCi6QVdB5MgAty39zUxyAkxQ=;
        b=VQQIR64wOi6v2hq5hWA7ctJ1pRvMzKZnSAa6JNtn1XeNjMxWtMRpyEpXh8aT/p4YSC
         AJziXm/gFJ0z59axzCMQrq5IxbB6rZHkZDKk2uwx5Vn79JL0Y5bcI9HW46EgySdPa5oV
         p19YnB9PT/hVxZkDI8eGF8ndW1DtgL2fQqxSS1271HHdWPfhDbZc08nxjpRbzybOooK3
         rYiLOfoceIvZK2oXTfyyH3rj+4sH3ptPsvTfg7h1F05Sm8HLt5ZrRn/DkeVKuhp3oYxC
         f1eVxprbTkHl3N8EfHrNcjh4Ygknopt7EC2zJ67AzWjXNvgo++dyNYH5Gd9Jo/7/Q6m0
         /4Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777390866; x=1777995666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caq2mpo+mPm1PnFQBexgS5xqZ7EOsplHY9fJx1jIehA=;
        b=BR5G4XjJFyJASvpQCUUiTc/d1lU/q2DLtOp/79ib96lPQKVID8A9WCAot8yUFKtr1w
         tQASIvUGCTMdqK/miVSS0T4156wi+GbNP3+CQLRdHrna9u+a+sBxhkuBexCBS7n7qP9x
         5pRBK5q6SOKxdxPM7uEJvojNAwfgbrT9USSwh/FNH+aetyBEiujNYcQEuGmQFRvMGGzA
         Rtf6wG/7Pe4KYycb+2TWPnlVClDYNFrLnM6eZG9VDGs454IJ++CkzqXIARzqPIIco/Wc
         wqcDe5tAuSFFEs4zVaXbeRiiDQfh1vcLvua+DTrlVQBJ1deNoiquZCzDfw7WFeg2MQVs
         5xXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777390866; x=1777995666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=caq2mpo+mPm1PnFQBexgS5xqZ7EOsplHY9fJx1jIehA=;
        b=f33i7q43ipy07+yibgjEzFb6BuN8bNZZrBh3k1H5aljj2B2a5QnHqXngDvsZc6HsKp
         IY+Rip9RhgGKn/bcR74zZxtSFSAEx73wG55wuNdLcaJaO5icsX97ZCBY1iuCRdjbhUSd
         yKNU1BRRpBep6ga+O5P3GVSWU1x0ojtxIlieFTwSWu291S+QpzTe4YF7KzAE7PGqG6hn
         hX2LNxo7Ga6cYl7PrTyzmQbUIGjl1+XTS+MOCMi9P5EhtGl85SEvrY6qsPNSfeu6F5/Y
         IrZk8WJ1YpD7oyVQaeCDyUf5MrIslaWJKNAf1H7QVPgccfwjswqA52RYLiyiWcxTW20x
         Y/Mw==
X-Forwarded-Encrypted: i=1; AFNElJ84nwbjotuXGj9k9pcThltqsmSAfW/HnEAP3zrduD/Wuq+t+PBRblXPWgmi7cGS5ezsjiFXHrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3rPOIAcWc+cmAYuBqMCNazKI5/ofpAVeb3Qiz7dCNZIuITTG8
	RAyOP54YqBRSvhxQe/lierkaMOMl5ktVjG3bhT0jTB9MY8eWRbT9STJhRXOA0Kw4QmkXvuDo5Je
	fcV3Vr0IyZJgoty9pW+DqoXEiRCn1+PvNVoByVpfY
X-Gm-Gg: AeBDietRutQ6YXBbb8f6craeJv6mv7KB+1B2nqnEYLzYcno0JYg7v3oKTIQcrFn0pOV
	LX+EGFJxQAuI8LE8kgkCBPD66BKycYAKiJ2Rt3VpDxxXAmaj7KOH7ywqhycuWPml85IHPX1keuq
	CiKFeh2ALao6tZWA1xdaIDWLNc6+Hhf7F3YNIVmC/DKj3zJCbKSaVX4lRdSSu+nVzgVnIH3WxaK
	Eqs8fxzbSDpoBFmW0fDPrruoi95/gTXKn3XUTK56pDyiKMMfmPuGqr7pEzwWouTH2UqG0qdhS6V
	qhF/cZVgy+z0FqUVMgqzxyYCyYKe2M9PkcCV/xSJrvVQvlXjGbb7gH1oaP+WNYtibhrS30FJwqK
	eT/Ydg9PX
X-Received: by 2002:ac8:5d4f:0:b0:50d:3e1e:7998 with SMTP id
 d75a77b69052e-5100e1aee2fmr49354951cf.37.1777390864260; Tue, 28 Apr 2026
 08:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427132555.1791636-1-edumazet@google.com> <20260427132555.1791636-5-edumazet@google.com>
 <20260427161830.78193ed9@kernel.org>
In-Reply-To: <20260427161830.78193ed9@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Apr 2026 08:40:52 -0700
X-Gm-Features: AVHnY4LJiGO-Q10yC4CnsdUQWbhksL3bb-sHuId5EUKrjrO_y86sVPelD-Hiluo
Message-ID: <CANn89iJ4MjaQP047jWFBquLd+ed-QfEOx3fUMUTdw328NOHc9Q@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] net/sched: speedup tc_dump_qdisc() when
 tcm_ifindex is provided
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A290D488200
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
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-281959-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 4:18=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 27 Apr 2026 13:25:55 +0000 Eric Dumazet wrote:
> >  static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback =
*cb)
> >  {
> >       const struct nlmsghdr *nlh =3D cb->nlh;
> > +     const struct tcmsg *tcm =3D nlmsg_data(nlh);
>
> nit: breaks reverse xmas tree
>
> I added this tcm assignment after parsing:
>
>         err =3D nlmsg_parse_deprecated(nlh, sizeof(struct tcmsg), tca, TC=
A_MAX,
>                                      rtm_tca_policy, cb->extack);
>         if (err < 0)
>                 return err;
> +       tcm =3D nlmsg_data(nlh);
>
> because nlmsg_parse validates the struct is in range of skb->len

Note tc_get_qdisc() and tc_ctl_tclass() use tcm =3D nlmsg_data(n) before
validation.

Do they need to be changed?

>
> >       struct net *net =3D sock_net(skb->sk);
> >       struct nlattr *tca[TCA_MAX + 1];
> >       struct {
> > @@ -1892,6 +1893,9 @@ static int tc_dump_qdisc(struct sk_buff *skb, str=
uct netlink_callback *cb)
> >       if (err < 0)
> >               return err;
> >
> > +     if (!ctx->ifindex)
> > +             ctx->ifindex =3D tcm->tcm_ifindex;
> > +
> >       s_ifindex =3D ctx->ifindex;
> >       s_q_idx =3D ctx->q_idx;
> >
> > @@ -1899,8 +1903,13 @@ static int tc_dump_qdisc(struct sk_buff *skb, st=
ruct netlink_callback *cb)
> >               struct netdev_queue *dev_queue;
> >               struct Qdisc *q;
> >
> > -             if (ctx->ifindex > s_ifindex)
> > +             if (ctx->ifindex > s_ifindex) {
> > +                     if (tcm->tcm_ifindex) {
> > +                             ctx->ifindex =3D ULONG_MAX;
> > +                             break;
> > +                     }
> >                       s_q_idx =3D 0;
> > +             }
>
> nit2: personal preference but I had before the loop:
>
>         if (tcm->tcm_ifindex && !ctx->ifindex)
>                 ctx->ifindex =3D tcm->tcm_ifindex;
>
> in the loop:
>
>         if (tcm->tcm_ifindex && ctx->ifindex !=3D tcm->tcm_ifindex)
>                 break;

