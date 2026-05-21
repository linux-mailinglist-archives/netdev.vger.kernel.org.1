Return-Path: <netdev+bounces-290350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL7MIGrnDmopDAYAu9opvQ
	(envelope-from <netdev+bounces-290350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:07:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 787405A3BE9
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27C163006213
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BDD3B8D75;
	Thu, 21 May 2026 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgZLu4tq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FDB3A4F59
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361362; cv=pass; b=sPOdtqIpoy0W1pYVrvwvPAoarqNztRs/8R6dXelhzgsECdZe8rRCqe0UcYDFXqg7vysESpoRjIx5sEyYRydXy1CHeRn6c+bpZF+TAOg0t/81mjoU0+Y2BKOVUoX5wvTdraMM5nwXbM0wN5C33T/KjJVcG6BkLWBz/GFok1unlMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361362; c=relaxed/simple;
	bh=+mV66YvZbb5NdjQvxcvg7e4oIyLdDigzx7aEnWvt6Pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHVBCfcY5yRQ9l8KKcF3Ww+/xdK4ADPNDA35c/aLhkUjELS4o6kGvKA2RLizAkfAFyffAGT4EZzrWh6Si7qHibW4JDLwo9A06XskxppV1sACthmZNcquCTN+MO85OEFr1NrRqmAeliJD4daO0vpvoJG0RpSwu8foDR21ZGsf234=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgZLu4tq; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3937014be0cso4858411fa.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 04:02:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779361358; cv=none;
        d=google.com; s=arc-20240605;
        b=jXadz4z580GpMY0PYeIUTuZMHJVIP1sLm0yGsTmroXlvZ5XyMGFoWpzJ1yxo7vO02H
         YeH2YdKUCu3/2BsVapVnVbRIgoNpBvPqcQ5geKRx1obOt1JULj57vuLY7ASsW0HzGjRy
         Z/yart2A5tGTJQZciztKYvK2hKW3dyXi6m10DDfm3K6miJAg8qDrF+0AmAhDHiQxu7g3
         eZemt6bRmyZOXJK/ZTV4gLTmzhp08AY3AJx2U18dhExNj9+z1FoDHzsKW94YXi2g0DqK
         2rpQslyzp5b/082/HbHLuzyJ3Qc0EhE4Q0AG5YLaEy0LhYQLXPyhZZC/HwXLCDVn0Yo7
         b61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pqh1/q+jSTFm8BIgmM9AiKfqdfgB91912OCIJgeSPxE=;
        fh=jrZolC4ah356i4OtPPZIjT0o6qwXtGqCHkkvYVe7BhE=;
        b=haVZUTP8RwO9TXkri4/4AYL+a606VHU4efWxe8XUVzQwAZ5R4NgUoqD5t85yxLIzcp
         BWn7ijFbDQiTKcdY62QWDvydD4957CmMLaMtMbBjG7xfZlHLv9VGU9N+wM2+j9k4Z9oY
         pF8zEXv1GT6Gw8VY6IMB51dYejqCLphrNPRb/4gvpf0VNbjdHo3Vvzh4yUpiZgrMQTbI
         27od/Z6hDlkJLoR5xu00Rwbv27JkLCKM87FSpWRYxIdjp3w6aspk8FY9r4sENp5SC5sz
         k8+yjcB9OWTn+TnhGjyE7+OcZiaCmf5u/xzxGqDsFg7wGADio62q7P5jfpRf6OYbexNQ
         ARHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779361357; x=1779966157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pqh1/q+jSTFm8BIgmM9AiKfqdfgB91912OCIJgeSPxE=;
        b=AgZLu4tqLY6HtU2zYgwHMAmRXOYclvAnbWBiVb7xulgEk8kaz4wcDwqcdNSIHevevV
         nmbBqrTgoZ13ctOuLeakcaGa1mFfVNUhrj8BxfUsJxvmfKVv8LIYBHEIhfNeQVpIMMNh
         JWzGzByjsERkES5F4V1bMgn4KS046s1pBDXz3tHv6rinO/kejiZUTVGtJSBEGNPrRQ18
         LabZa0CM9wfhpZJ4Bc0rCvudTUOzzkOjbFwyxo/9c0j5TUOaPKzORjUSLwmeGLoR3dI8
         Sd+oLbdizcmYfl9qbcqMk6UGikhgRvflKPPJTA40cSFYui2B160iIA5hBu6IFb0E/tOH
         a2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779361358; x=1779966158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pqh1/q+jSTFm8BIgmM9AiKfqdfgB91912OCIJgeSPxE=;
        b=JWXNsdJstVj9jlla8BSZGmGMISVY46OMR+tannjHkt9/mMz6aIwxkuon9f8CCs+rUH
         MW4qxJHNSt+swcr0vpKlQL7znWCu/gIS+Na+ZGw9TAqbnKPUzWUx8QoykiLb4FxWrbVv
         YHSslW7hJNa1UjazThzisbvjg3748weZKn8E+9znk56Vbz75Q3cCXyaeAwnVKtmnZZGk
         0P47xBecRhbiRYARYTauLbJgRQdZvBwhJJ/Fm+9u34ZJntAT1N9B/Y5m84bcTPfVx2Cw
         fH79nmBXLFyVAez0VbZ12JjL0C36wlWsq9I5yzWH6tspaB+6Lz4Pc3V4MPJGU8GgQsaW
         yIZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/r8yNnvNv/TvrmHX1vdLegNrVRzwQuhY5gIwN1knpgujTgiN21h8MtAsLJm3J3rItRaIe7GfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUXxcvjCrZtMbberwhE6uKBd8oPH06652UE3E3lvm1iundG+iw
	smj1h1EmHO8WYMcRCKfb7foOuxZDZkPuPDuBuF6CVBpV14WdGE/Jqi3Ro7IBHXY/AeodxB0phYt
	DXIOAcki5NhIwGIrh43e+naKQQfYckyI=
X-Gm-Gg: Acq92OEaleGuJuqgX9zHscNQNW8jclYZKFCQgkqcEVCTXMpwp2ugFqzWYNiP/FKtFdW
	KT5QYG/ftxIw2rOkpkHwtYVLescKHiIXxxrwkT8qWWRyeFL1II3L5nTTaX5f1K+yc6gU9rMBGl0
	iPIi8yeGojO9We3hS1DvQNZQnZ5BtsVI1QPIVAYdHKe0sF76On5e3pC4KDPpHdq5oP1yTVXQZaE
	qfxO1Jke9zOOpcCjudezgJVni5WaR4Bty0eLXM2xkdNMA81bhDe+8pz33g7DDGNfXM/BMuqYGWm
	sfAXAGc=
X-Received: by 2002:a2e:9a09:0:b0:392:c9a:ac43 with SMTP id
 38308e7fff4ca-395ca4efbf8mr11156321fa.8.1779361357146; Thu, 21 May 2026
 04:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521093612.207475-1-sigefriedhyy@gmail.com> <a6e9081a-b2d9-4a51-a7eb-aaf27a50fe1f@linux.dev>
In-Reply-To: <a6e9081a-b2d9-4a51-a7eb-aaf27a50fe1f@linux.dev>
From: Uyo Ko <sigefriedhyy@gmail.com>
Date: Thu, 21 May 2026 20:02:27 +0900
X-Gm-Features: AVHnY4LgHbuYgoh2EyMCYClrGtR761ddG2LiD-8vPJHl2NDmfBKGQx7k34gFwhU
Message-ID: <CA+7S2vKqo=wZ5vaXDMogk1xJTAcW8qf0pME_F4h1BrDnkO8NNQ@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv4: igmp: annotate data-races around im->users
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-290350-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: 787405A3BE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>One suggestion: please add a Fixes: tag, like other data-race fixes
>annotated with READ_ONCE()/WRITE_ONCE().

Thanks for the prompt review, I will adjust it in patch v2.


On Thu, May 21, 2026 at 7:53=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 5/21/26 5:36 PM, Yuyang Huang wrote:
> > /proc/net/igmp walks IPv4 multicast memberships under RCU and
> > prints im->users without holding RTNL, while multicast join and leave
> > paths update the field while holding RTNL. Annotate this intentional
> > lockless snapshot with READ_ONCE() and the matching writers with
> > WRITE_ONCE().
> >
> > Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
> > ---
> >   net/ipv4/igmp.c | 11 +++++++----
> >   1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> > index 27d120183779..f2aca659b29c 100644
> > --- a/net/ipv4/igmp.c
> > +++ b/net/ipv4/igmp.c
> > @@ -1541,7 +1541,7 @@ static void ____ip_mc_inc_group(struct in_device =
*in_dev, __be32 addr,
> >       }
> >
> >       if  (im) {
> > -             im->users++;
> > +             WRITE_ONCE(im->users, im->users + 1);
> >               ip_mc_add_src(in_dev, &addr, mode, 0, NULL, 0);
> >               goto out;
> >       }
> > @@ -1550,7 +1550,7 @@ static void ____ip_mc_inc_group(struct in_device =
*in_dev, __be32 addr,
> >       if (!im)
> >               goto out;
> >
> > -     im->users =3D 1;
> > +     WRITE_ONCE(im->users, 1);
> >       im->interface =3D in_dev;
> >       in_dev_hold(in_dev);
> >       im->multiaddr =3D addr;
> > @@ -1784,7 +1784,10 @@ void __ip_mc_dec_group(struct in_device *in_dev,=
 __be32 addr, gfp_t gfp)
> >            (i =3D rtnl_dereference(*ip)) !=3D NULL;
> >            ip =3D &i->next_rcu) {
> >               if (i->multiaddr =3D=3D addr) {
> > -                     if (--i->users =3D=3D 0) {
> > +                     int new_users =3D i->users - 1;
> > +
> > +                     WRITE_ONCE(i->users, new_users);
> > +                     if (new_users =3D=3D 0) {
>
> Using a local variable here feels slightly awkward, but it does save one
> extra load compared
>
> to re-reading i->users after the WRITE_ONCE(), so it's acceptable.
>
>
> One suggestion: please add a Fixes: tag, like other data-race fixes
> annotated with READ_ONCE()/WRITE_ONCE().

