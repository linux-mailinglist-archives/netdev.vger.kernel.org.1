Return-Path: <netdev+bounces-276368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAzFOUgY1mkxBAgAu9opvQ
	(envelope-from <netdev+bounces-276368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:56:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 640F03B965B
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB12F306BAA8
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8168035DA67;
	Wed,  8 Apr 2026 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jxPAHND3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09194345CBF
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775638490; cv=pass; b=YffA4dqGmNDyzMgZACC5mrS1HSvEt6p9TKNo3vU+aWYRxuVD8bMYsDU1Dv3ORGstW2tTIZXCqpJf+xfWvj5/pu5eZpflSI/XgihyN2BjnzmdRvhbSqLsVMsoZQlj2FThSZYmMiM7ZO4/0kVY1F4BTNomV3Ru9ewAq1/tQBQicko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775638490; c=relaxed/simple;
	bh=hskgxdX2n23amC0zuFFnFQTjDdoG3lRSty6ngjOL8n0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvRC2nSJyEZSaUYCnhe6dIZV9rbqdDiW7StQoZK4k0wWpGwGwAgxgFilIIrld7rjpG4Kur/Q+Ycz2+G0qDx+Blxqm+CmsSmKFRPjqvKFmk2nmRO+c3T2Yrwdvchq2yfugwF87HFyW+izyMQzMeI12nymsh4xKH1rRPBE0O74woA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jxPAHND3; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50d876329bbso38691021cf.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 01:54:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775638488; cv=none;
        d=google.com; s=arc-20240605;
        b=gK+eDUkfoIKJ7oExQSQZTWVcB2YYw28yLASdxs+XKZj4M4D18RdzWBH2u/TIdId1+B
         HT99N+r8lo6wAnb6SBu8UA1H41pydFST0N7x1UEeYKMa46xTUR5XJnUXQqO+jKPPRDOt
         8apfi1VdHpBjz2g/l3NTso0GKzePxqfgNwkdI41QpW1LhyB08ORDKRSR6/yp3JW5AaC+
         E/E8U9oY37oAJGi+bKPl+MW44n46UmxAlk8I4lnRlK/cYrFyeoTPvZhVgmUROEEuW/KF
         8BAyzm2LanO3y6ZlDj2Vnuz2dT5/1to/y7hauOSlPfpuB5bBkoeKjqosZpARG8IUDI6H
         JaKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BaO6I+bBFz7VAi11EvmYzFnX6W1OHJcCDmbNWxz+4VQ=;
        fh=Hu20O8JJR57SGHtxYv9B3NgSiV5rHKRzGYPLSd7KKj0=;
        b=duaJooz/6V8NyC6u2kPCf+e53CO8lbn4KNSCqqS9gnM2pArO74lFoC4EQjv3zSQMsU
         ThSAMn3e7tRPuXy/SmUKOrNhgOfkFZksjjI7pP/AGZtp1wTjfx7lcjqoHjcYDWtQhJTk
         ksWeXUu4V065HY9wRyAb0QDZc6Jx2dTxHRbKM+EqtxNDFukg5X7eJuR2jjRlB3YCwg40
         x9KZ2x9RVcOXkFjjnn/jakAIdO9CoSBwdutnn/MB1JtXYM0hk9NkhrBzeFOG4fAtqNH4
         idvy65i4if5uDBSg7doLCAUK1U0mKNCL+GugkqhtAdzc54bHUC/+877ABchb1QSQOtly
         /Fpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775638488; x=1776243288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaO6I+bBFz7VAi11EvmYzFnX6W1OHJcCDmbNWxz+4VQ=;
        b=jxPAHND3JlYeCjQLDkbfZNk3I55+FmJTvtFABn8K6W49hvEE53Sh6bIKEduQpPqAir
         D9LAiIA4z5k56VEApbVlnOBgMCCdy5VbiEFxea0gdtR2LOWNw6xCSo48MkLtKMq7yKX2
         PBs630URk7Td48k35zsxoRWygtPvxFwt79zmmTXOcoaPZv/6y2gIDh1/oIz/Yq5HgD0V
         T5vXlo5BjqNtaTyEjCQf4TGBpnIKBri/USmM2SdHattlwP1Z/DaOZPxwzvdQplS3RiO+
         hVufz6azh7c1duYaGasRu8nzNtA/aYQYMy6HJHdtf7NXq3WzvQRT430pbaUwz+7gxuEC
         Ha3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775638488; x=1776243288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BaO6I+bBFz7VAi11EvmYzFnX6W1OHJcCDmbNWxz+4VQ=;
        b=JOikrcpsfeF0BXacTrTHYbQ4vefVwt9uAwR8eHp1UbZDxfp/dHENMxSawT2k4TLBUc
         ao1+VWV9CpOfKQhScHf7o0QOImmL39zNODmr/Fg8Lnzp0ydraug9LdSCC1C5LEK+FKjh
         ta5OQYp8En/nXUTwXsKStgk0mdM5ky9/F7VgkXwol7MeeIDEh+dApTPUTTdRH1l7x8eG
         otyqI+kTewktTTAsnpT9YrXAyBkL/0Zq2mpsRz9QOGJx0TmwAqNjivqL7X0dw8Ij+/NM
         kGbQrwlJ+VxHYNjfkYvxaTePrT2toQkU8AZxrdqWljuMZSnK0tTGNjm8KXQTKTntONAq
         Dq4Q==
X-Gm-Message-State: AOJu0Ywtp49G09Q/trQ38yecBIcnFxqo+M0TSGTjTkeJnrAl+oFvv/Mt
	46UC9CLE58YnO8WLA4EFCerbmKAMTIO8C6pwg/prz5EuW0f0KJxqNMpcbvsbjWQ7PlDXwWsTucP
	xYidgAUCZNWztgofZjzmPfTm5q6QjMrVVuUnWlvlj
X-Gm-Gg: AeBDievZaTnrHlZylmTzjC2y1wg8spb966DaWN7+e7B5XdHu1XYljiI5vaI+Nk7WOSv
	iThCuxnW9nuEPAMp4lq/Z/jC6bX4+W8e85AR6poC7zAt80dji1t3BOAROgYV+05D8MTEziqVAJK
	myAD8K4Dxs8D6z1MI8gf2xa2KaXB/4iC4XhCyyjX9w4UhIXW2VtrlWwXGxE0LD+uLM5uno3y3Vb
	K/IsgeLQ38OTBPBEsfRS7VpYQ4fRarWPLAubgQhR7cHvQK8r/04jQsg1n2fUbRsd0nv6J4MqmwO
	dPx3+Q==
X-Received: by 2002:a05:622a:188f:b0:50d:9174:cf27 with SMTP id
 d75a77b69052e-50d9174d1c1mr158478751cf.20.1775638487431; Wed, 08 Apr 2026
 01:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407170214.4157-2-fmancera@suse.de> <80b74501-5c15-4b69-a825-b747ac509855@suse.de>
In-Reply-To: <80b74501-5c15-4b69-a825-b747ac509855@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 Apr 2026 01:54:35 -0700
X-Gm-Features: AQROBzA2GKHsCiyFMtLvurCgMJVlULoX2g8BNeMYmHt4bixVbPH1KS3sApNek_A
Message-ID: <CANn89iJFgC-ba-166q+TKeMuYbrcY0tk6OZMQVvYfD0gufrgZw@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: fix skb memory leak in deferred qdisc drops
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, davem@davemloft.net, Damilola Bello <damilola@aterlo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276368-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 640F03B965B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 10:14=E2=80=AFAM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
>
>
> On 4/7/26 7:02 PM, Fernando Fernandez Mancera wrote:
> > When the network stack cleans up the deferred list via qdisc_run_end(),
> > it operates on the root qdisc. If the root qdisc do not implement the
> > TCQ_F_DEQUEUE_DROPS flag the packets queue to free are never freed and
> > gets stranded on the child's local to_free list.
> >
> > Fix this by making qdisc_dequeue_drop() aware of the root qdisc. It
> > fetches the root qdisc and check for the TCQ_F_DEQUEUE_DROPS flag. If
> > the flag is present, the packet is appended directly to the root's
> > to_free list. Otherwise, drop it directly as it was done before the
> > optimization was implemented.
> >
> > Fixes: a6efc273ab82 ("net_sched: use qdisc_dequeue_drop() in cake, code=
l, fq_codel")
> > Reported-by: Damilola Bello <damilola@aterlo.com>
> > Closes: https://lore.kernel.org/netdev/CAPgFtOLaedBMU0f_BxV2bXftTJSmJr0=
18Q5uozOo5vVo6b9tjw@mail.gmail.com/
> > Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> > ---
> >   include/net/sch_generic.h | 12 +++++++++---
> >   1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > index c3d657359a3d..61ba54e909f2 100644
> > --- a/include/net/sch_generic.h
> > +++ b/include/net/sch_generic.h
> > @@ -1170,12 +1170,18 @@ static inline void tcf_kfree_skb_list(struct sk=
_buff *skb)
> >   static inline void qdisc_dequeue_drop(struct Qdisc *q, struct sk_buff=
 *skb,
> >                                     enum skb_drop_reason reason)
> >   {
> > +     struct Qdisc *root =3D qdisc_root_sleeping(q);
> > +
> >       DEBUG_NET_WARN_ON_ONCE(!(q->flags & TCQ_F_DEQUEUE_DROPS));
> >       DEBUG_NET_WARN_ON_ONCE(q->flags & TCQ_F_NOLOCK);
> >
> > -     tcf_set_drop_reason(skb, reason);
> > -     skb->next =3D q->to_free;
> > -     q->to_free =3D skb;
> > +     if (root->flags & TCQ_F_DEQUEUE_DROPS) {
> > +             tcf_set_drop_reason(skb, reason);
> > +             skb->next =3D q->to_free;
> > +             q->to_free =3D skb;
> > +     } else {
> > +             kfree_skb_reason(skb, reason);
> > +     }
> >   }
> >
>
> *sigh* this is missing the following diff - tested it but forgot to
> amend it. Anyway, Eric let me know what do you think, if you like this
> solution I can send the v2 appending the skb to the root's to_free list
> properly.
>
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 61ba54e909f2..0e4166319c02 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -1177,8 +1177,8 @@ static inline void qdisc_dequeue_drop(struct Qdisc
> *q, struct sk_buff *skb,
>
>          if (root->flags & TCQ_F_DEQUEUE_DROPS) {
>                  tcf_set_drop_reason(skb, reason);
> -               skb->next =3D q->to_free;
> -               q->to_free =3D skb;
> +               skb->next =3D root->to_free;
> +               root->to_free =3D skb;
>          } else {
>                  kfree_skb_reason(skb, reason);
>          }
>

Sure, please also use rcu_read_lock() before calling qdisc_root_sleeping()

