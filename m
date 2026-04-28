Return-Path: <netdev+bounces-281953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OvpCD7U8GkSZQEAu9opvQ
	(envelope-from <netdev+bounces-281953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:37:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5208488026
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8A6E30027EF
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34B638758F;
	Tue, 28 Apr 2026 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lef/ZpEv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6925386422
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777390415; cv=pass; b=D1p3AaRX9PAIU5IZgNGKfCtdXMymwCZiFxTFNg6z50UfNryWutG3CX3bbWWrHwBggk7YyDAU3RcSa5NGq0Zr4z8cz9JwJiu61tFXHS2mPLwWVLZuohUTzwS8hbG0u3r6XZsxffG1/mUyWeYGB5F4Zn45mh594I9noJtBZkU3Y38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777390415; c=relaxed/simple;
	bh=MdqJE/paQ+GYzGBWedFogSl27/iJu5Afpjz3TOknRvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/B6xjCzamNZnjpiUJqcg8SQ/w4pbfq3YNoP1WVDNiz4eT51dVaA/W1jdeja/JzXpLyqEBhsffMJKehlfdSQUuwy2jLkO/l603ME0xVJBcg3SeC8FoILRyUcopVGQmzQzg3C/BAAwsF5NcvZnUdjWfHi5HM6YJ4qudSaezo7ytE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lef/ZpEv; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506aa68065eso84057111cf.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 08:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777390412; cv=none;
        d=google.com; s=arc-20240605;
        b=gB8AgrWHwXWGDeeAMDxdLvArtstaHmoAFFN2bz6NisofXIzqoOZ0t+H/Z+8AJ1lfNf
         xQ/dL6Y615or5kjlXsnag/Pp5vlQr+vZh9MLJrWYTaDHJPNDADUL4QFf0DFT1YNcutUZ
         w2hSg9gIr5bKr2k7jyfiXYu4C4HUmekpYLv7+SuFkmxNV/VkVgmmUW3xdr7GcHwI6Hrs
         NMUjFfgTKJzK5jf0MoSZwOrDiFtgj4XQ5QODUMkbntvOiyb98JB38dTPAemoAveH9rIZ
         NIE6izc1i2zvGLROkI2iwMAQ2qfJLSucUo9yoL01OxJ1PGmuzGTy+dmUyQqwlj6FxO3F
         wL5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BqDK5u4Q6rxKPP3wwLMG4J/TFKsDJUQ1qgzCozPPlXQ=;
        fh=WpNXIWbyIJTW2QpXzvPVbHTG1oJrgCJrAejjEy93E1M=;
        b=Qoh8pG5h27hGx+EkLqOXVXeZLwvJB0K4HHTdYFK9fA+kHGlygvj43I75DZVxq+W3bj
         SxLyAUZdHBuu6n5HrvAqJTsmK95MKLKzvnmjMM9combGm95J7fn+v8UzG1tf4vSJckTY
         YQcyUfD1XPmXwqynGeywRjg9Se6uabqpcsQDEHLSiO0NeEcjhmutg8pGoUQ8bwflNpSm
         Pq56/ajGrXzyv+HU+nFp4qS6bGX68UQxjxzuKTY9TXVDDtPqMmuUjT4XLjLlYRmtoIjV
         ro5IK6P2yVFn1zZGWbOz11B7KsPF8zEt+GShhJx4Kd4365BEiEOxm/piXzjcZyECkRg2
         NwhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777390412; x=1777995212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqDK5u4Q6rxKPP3wwLMG4J/TFKsDJUQ1qgzCozPPlXQ=;
        b=Lef/ZpEv8cAB5Lh1Vhg2GJeWy9nPYm2Q3hm9WkChpoIkahM+y+rxyxiYqvIs5Rrupf
         G5EXupvMiAi1qPj0vBHIq0gZIXRRUEngSRZfySs0bupBfvC3UXhHfETafhZbcjLRULBw
         eUi1Q381bhsY7RujLXlkzzbh1Xp+FZCojeRPSIUn2T6eQJZ+YWaybfvOe156kN67F2nb
         OawNWz1VZrIqfeIDHOnYhNEsb4SHOR9bSWbXpMs79qVgXudZs4u0TzXUKtbV7eH7Hjkf
         yyBVN5GJkDHzJL6NmY9XqA0uLX65yK03aHCS8Un2kdxu2zYpVLVspn0Oe3C+q3fdQB4+
         TrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777390412; x=1777995212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BqDK5u4Q6rxKPP3wwLMG4J/TFKsDJUQ1qgzCozPPlXQ=;
        b=gTa9Jd7HoRDv5kkVIOruWk/uILKdSnW47Im7+m6xQR1shgtRIeCa/sU70q9Idfj2Kx
         KPC+LyofD1Cs6+qyes5uep4HggETio84FNgmrNWaPwUo9P3AZr48qzjNhU9r4UuidOlx
         pmBwfQWNdjwDn1wEgcerLuL9doMZ3CdV85m+hpK1Tbw0g6afitpk8AwEVdk54XvoWNHV
         GYemX76wbQq5nD9w61q5SqsMaHjgfBA+R0LAel/I4h9NP3A3j75G9kAFiXn+h5toeegB
         3lQUT+8XXwkBclKAyj/LdoS9+1UvbkapeEM6v99BW0553T/b1Fx35cz1XN4A2l4ssHYV
         rgnQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fbYZnLosMHVKJG0iOdKm1MQkfZzBEINdaZNmVptxBWadmBukS/Imol7YBjpzYTQEeJTQCgKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN39deNxthcKfLfL2sDU3lEXNK38klOLJMRLMn4bhO4oKHnwe6
	wKDWihJGd0Mswl6joNi3Sv47e8lISpVIRHXDudmzXN0/hmzCuCHYREc/5cP8OBrTHubnCQZP+v1
	xj1zSnkD1uiRiZsq13ET8n2/UQXIrxoXiEetQNzK0
X-Gm-Gg: AeBDievICxo4ZDPDZqBjW506sNiwrcribFK8FfUsl4XpaDIWs0Ky70QGI/V71saIUd/
	GwSsSabXLlKyPeAou58+VepNfLwt5jniNjbjHYGU/htAiT6C3ZeoTfmoEmMn8pv0EYQGHiZukDK
	5Gu8a8xPwz+GlDpjDT8AaV5z5rk8xcBFL1oVwlNCpr8EpCux9D6kX+5NQoa8T0mPi4F4b/0MfWq
	xJL0u1BgKyAEM752mwXQCI1iF1eV/bdEI6G/YOi1ubycjO71FUS5a2uO9cvsWwis5TgiKd4yFFN
	Obkpl1IoqQqnc1YVWS3RPPVU4VgYRbJiFXqUZxbBGV0jl3AFduVzqXX28m5QUU40jZvDBVyZmQg
	bgiiDsCAK
X-Received: by 2002:a05:622a:5147:b0:50f:de06:45e2 with SMTP id
 d75a77b69052e-51018a39d3dmr32231cf.31.1777390411344; Tue, 28 Apr 2026
 08:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427093633.979310-1-edumazet@google.com> <CANn89iKtmRcw2RsoofCnSf7kQhBWMYNhjkhSyqdaPcuQw3ZyyA@mail.gmail.com>
In-Reply-To: <CANn89iKtmRcw2RsoofCnSf7kQhBWMYNhjkhSyqdaPcuQw3ZyyA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Apr 2026 08:33:20 -0700
X-Gm-Features: AVHnY4KF71KNebvxU8Sb4Wi1IP_NA4lM8F7BfSJOdyWCY7loy7QMji-TZ7ie0KA
Message-ID: <CANn89iJfj-U58PKk7H7wR=ZLVBPS=a_CXxPFQx5Wct0fv+JPvA@mail.gmail.com>
Subject: Re: [PATCH net-next] ipvlan: use netif_receive_skb() in ipvlan_process_multicast()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A5208488026
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281953-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, Apr 28, 2026 at 8:23=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Apr 27, 2026 at 2:36=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > ipvlan_process_multicast() runs from process context, there is no
> > risk of stack overflow if we call netif_receive_skb() instead
> > of netif_rx().
> >
> > This avoids some overhead adding/removing skbs to/from a per-cpu
> > backlog and raising/processing NET_RX softirqs.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  drivers/net/ipvlan/ipvlan_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvl=
an_core.c
> > index 1be8620ad3971d281fb36fd0770efd67b566ae60..7ad12dc7845c836bdd04395=
f153b2b4b397797d6 100644
> > --- a/drivers/net/ipvlan/ipvlan_core.c
> > +++ b/drivers/net/ipvlan/ipvlan_core.c
> > @@ -286,7 +286,7 @@ void ipvlan_process_multicast(struct work_struct *w=
ork)
> >                                 if (tx_pkt)
> >                                         ret =3D dev_forward_skb(ipvlan-=
>dev, nskb);
> >                                 else
> > -                                       ret =3D netif_rx(nskb);
> > +                                       ret =3D netif_receive_skb(nskb)=
;
> >                         }
> >                         ipvlan_count_rx(ipvlan, len, ret =3D=3D NET_RX_=
SUCCESS, true);
> >                         local_bh_enable();
>
> I will send a V2, to limit the number of netif_receive_skb() in
> presence of large number of ipvlans.

Well, this was caused this sashiko report:

Because netif_receive_skb() traverses the networking stack synchronously, i=
t
bypasses the backlog and softirq processing budgets. In environments with m=
any
IPVLAN sub-interfaces, delivering a broadcast or multicast packet could
monopolize the CPU for an unbounded amount of time before reaching
rcu_read_unlock().

But using netif_rx(nskb) had the same problem.
Each packet was immediately processed at the local_bh_enable() time.

So I do not think a V2 is needed.

