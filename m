Return-Path: <netdev+bounces-289765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF0CJbY/DWoxvAUAu9opvQ
	(envelope-from <netdev+bounces-289765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:59:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26232587A82
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BF963031F7D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2D42D46B3;
	Wed, 20 May 2026 04:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oc1onfxU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6B41EDA0F
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 04:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779253170; cv=pass; b=KZx1D0Wvmi9QlLOX/y4TI8Dxtfx1C1qfaWaiMq2Bl9/6bEkoZxgBIAJiAA6rsNjiBEgThXfPwIwkuQZEkbTbhwqpMEHRnaiSJ9iTSXZH/Vx3yK03YEY7JbGl2mOvoOqJZ2LcQqVfIm9rx/5G9Xk3TxKL/cWVjDSyebBpFvzlbqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779253170; c=relaxed/simple;
	bh=HYFjTcDDliE//xnnnvg0LQHyeeaallxRi3EtvhN1dWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSZNlzR1UVOlLE369as80ws3XI67+X7b2jnIgEkcd1vVUjcIYA9hLs5+9d2JbdmsFd+SIvhqMsLb+cwzT+ZWsHfNeyV4c0ukuWM912geApMIa67ALq721VGqw+a8tTOvC6uOP6SevbWDUHIuSt1MUO79inkU6TeSdYD333Eq898=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oc1onfxU; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5102582e237so42580591cf.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 21:59:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779253168; cv=none;
        d=google.com; s=arc-20240605;
        b=W9GdT5Dk7em7+pv637G47hVeQ4opJZ8px4blgdFa76pLbKcca/By1Pb9gwDeGnhA9D
         W+FsijeLGbcIgR77GLOh7wzuRmLpOVAHiwz5zUH229HolFUg/nLogC5D/arleUxLG1Gu
         tC3VJjbc/TYRsuSNVa+g2M+i6L2j1R3PI3e3SBXhD/Pk/g8abM17MCcU2u/mG/Ob0OfG
         MO7QrI8apNC+UsA/sSNTI01nT0BwkfiweGXkH7jxaZDD9kGpG69IoiBIYfn4/CUsO15D
         eT6hPqt2KcThasclKFEifRRruV19VVffO1o+BCcG0qLr/GrANk0hJpA9DuKegx8qXlxz
         ZVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nYbq+ThIxdGUV9vQDNJ412rD2sMe+ST0iBAyU7Yu+w4=;
        fh=I0rnY6Szik/SCm9Rhj0af2fK03JRyCV/P52ggChBrzw=;
        b=LQYpSRCD9+4AMOC6QfG83gnCH8dk/FY/pq0Gna/vUfwxwt7eF2jzx8xSKVdyAOHFcF
         ZK3Z8isYuQB2NGNM46GbUnGtgrb0frwP1RGQ9xBLIiJ1hzKcVl5DI2tySxGh7W1nlIl4
         MPQsV37Wx2cdcJohELSYfaZ+z/LzxutRW0d4LwTmQVKguN4YWXFRe/t6/Xf40/1Wt9S6
         KVyeDNPWnTG1Nb+AB/HBbyi5THY8bukkpUSrtHyv5F6I000xdQ1P1UOex40eM9WEZ+kd
         +CUIP4hoGHg4fVRuJNyLCdT0U4lbMHph1sJB1WkQzHkGOIUzIPQP3Zeb8sb9YEwUwlBO
         1ubQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779253168; x=1779857968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYbq+ThIxdGUV9vQDNJ412rD2sMe+ST0iBAyU7Yu+w4=;
        b=Oc1onfxUMplTWeRkidUBEJEyKy26OaXty3mEcDvYhzhb1TbzU6mFZ+hdQCSGXkX+zl
         QhWqHeWDn2VfAj1jZgcXYt5hTN3zXP4oyQcMRJhXYg5FBt7vTAsjWrSvmWtgP4rmFWG5
         bTcbXKUWz1fUiwFdZQ3A8oOTP13ceQ1Cy0KuQH4cl9EdstvT+sDZZ7k7lJJjCsQeAeJp
         dcOr3juzcqZ0/A/5zB80pMkrfjNkeYSjHgYxn7aUhwyT+4b4a7Bd8l7akENtl6AyyKSS
         +6oPpbGX1Szfem8dXb3ABWB0C9QNqatakzIvoddilgNla1iYWvg3q0UJA2rApVXbkNMb
         BOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779253168; x=1779857968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nYbq+ThIxdGUV9vQDNJ412rD2sMe+ST0iBAyU7Yu+w4=;
        b=oFgM4WOu2BeBH7zAz5VDbOICUmLTf6kUlBHMx03bZWJQTmYy0y1WX4NJ6bKU97OZiI
         DmIh/dQ1BBh71MJzdO3OBXfGQKX9FhpUMEKmSb27sFHQHhPEb6dsvbJJEGk6VLNg6gd+
         QsZBtDCIf8LjunbaqJaCC+lV0SoO/1d9hcUvLtPCGxcny+o5/XleBTY1oEj9ywhmMzAG
         zpQ1JQhkv9jzI9zQICtUg9zVoVaIxn064X40hjVa5asNTU+ogzpAaP32PNq27aT6K5+j
         jrI/up6nEdeosdB0nxA6dR3L3FTvNBbp4vBJJofgj7/9A6WEttPLBRybYq4sNiMo3iXj
         +NMA==
X-Forwarded-Encrypted: i=1; AFNElJ9JrxJLPkiw6QbGyt2TDCkEA/XN4DU/Zb7RWvo9mlrh/Zw1wexKnAOUxxRP7wiMA+4WeLC/fGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGYjlSx8LlN4mDwgMcC7l4R17Mza8xd48ClzDpMQAo5SQDVlSQ
	c+MQVHPCl5oIKuJofuWkF3PXvWoYt4kDr9cdUwXm8FvaCFdhIkR+QlZwDqek6LE3BDcfExvIJ1n
	Z7WItvwf1SftxWxeWn8N2+quXTtc1JEp+B2EAIVGFqw2GzNOITm5GHkQ8
X-Gm-Gg: Acq92OHrd/FJDJGaXiE30+yuQSSqheYEViN4r6fbzwq1ShAhGGKzWK5lcUlYc73uCVT
	Ck/J3c5CHaTKc6D/Muml/OlbO29mMN+kfmJqvzDuI59nbyvlvvjy+3ZUKKPBzcktzxRk18BKM6B
	GWaUjYjb6pPpShgrOj5lYP7NNstpgjlTs90PkfJHmAc7QOplOLyJdrBQhlCLqhhUZuTNbyMIR2O
	BjzldVu3TmHwzvrxN6smVY+Bdp9aoECnIY1dLj6woxoyE257MYD5700obng8vICHkSpjDX0x9Hx
	hFvIDM/ixd3zhhJ+fPsjZm4lBn1zDpGxyOZPNqA73j/DIPiDbSq2LLP6ihl2qlm1tIs7VTzKgft
	qUt9pqs+HF+uibTdtJ3XfHBZYCn17j4SagzxZvM4nYcSOiHJ4C1SgDS1kvsNl+NQH
X-Received: by 2002:a05:622a:5908:b0:50f:135e:d5d with SMTP id
 d75a77b69052e-5165a007665mr315311941cf.8.1779253167450; Tue, 19 May 2026
 21:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518130531.1015332-1-edumazet@google.com> <20260519171501.GA520442@shredder>
In-Reply-To: <20260519171501.GA520442@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 May 2026 21:59:15 -0700
X-Gm-Features: AVHnY4KICLaZ3OwuWz7eMrTmA4vWLGMoKwHT00ruVBH28M_iE_-ugKF9gmlBt-Q
Message-ID: <CANn89iJ_Hgk-o9kccx-BpOJ51qouj2fnCnF8rCLdcjYtAgB6zQ@mail.gmail.com>
Subject: Re: [PATCH net] net: bridge: prevent too big nested attributes in br_fill_linkxstats()
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+a35f9259d08f907c06e6@syzkaller.appspotmail.com, 
	Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,blackwall.org];
	TAGGED_FROM(0.00)[bounces-289765-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,a35f9259d08f907c06e6];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,blackwall.org:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 26232587A82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 10:15=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> w=
rote:
>
> On Mon, May 18, 2026 at 01:05:31PM +0000, Eric Dumazet wrote:
> > After commit ff205bf8c554 ("netlink: add one debug check in nla_nest_en=
d()")
> > syzbot found that br_fill_linkxstats() can send corrupted netlink packe=
ts.
> >
> > Make sure the nested attribute size is bounded.
> >
> > Fixes: a60c090361ea ("bridge: netlink: export per-vlan stats")
> > Reported-by: syzbot+a35f9259d08f907c06e6@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/6a0b0da3.050a0220.175f0c.0000.GA=
E@google.com/
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> > Cc: Nikolay Aleksandrov <razor@blackwall.org>
> > Cc: Ido Schimmel <idosch@nvidia.com>
> > ---
> >  net/bridge/br_netlink.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> > index 6fd5386a1d646542c184702e13cc2e6c8ee1820d..e15a08a34aeab2429b6c49c=
5a0ecab9b47582f06 100644
> > --- a/net/bridge/br_netlink.c
> > +++ b/net/bridge/br_netlink.c
> > @@ -1827,6 +1827,7 @@ static int br_fill_linkxstats(struct sk_buff *skb=
,
> >       struct nlattr *nla __maybe_unused;
> >       struct net_bridge_port *p =3D NULL;
> >       struct net_bridge_vlan_group *vg;
> > +     unsigned int limit =3D U16_MAX;
> >       struct net_bridge_vlan *v;
> >       struct net_bridge *br;
> >       struct nlattr *nest;
> > @@ -1841,6 +1842,7 @@ static int br_fill_linkxstats(struct sk_buff *skb=
,
> >               p =3D br_port_get_rtnl(dev);
> >               if (!p)
> >                       return 0;
> > +             limit -=3D nla_total_size_64bit(sizeof(p->stp_xstats));
> >               br =3D p->br;
> >               vg =3D nbp_vlan_group(p);
> >               break;
> > @@ -1855,6 +1857,9 @@ static int br_fill_linkxstats(struct sk_buff *skb=
,
> >       if (vg) {
> >               u16 pvid;
> >
> > +             limit -=3D nla_total_size(sizeof(struct br_mcast_stats)) =
+
> > +                      nla_total_size_64bit(sizeof(struct br_mcast_stat=
s));

This was indeed a typo.

> > +
> >               pvid =3D br_get_pvid(vg);
> >               list_for_each_entry(v, &vg->vlan_list, vlist) {
> >                       struct bridge_vlan_xstats vxi;
> > @@ -1862,6 +1867,10 @@ static int br_fill_linkxstats(struct sk_buff *sk=
b,
> >
> >                       if (++vl_idx < *prividx)
> >                               continue;
> > +
> > +                     if (skb_tail_pointer(skb) - (unsigned char *)nest=
 >=3D limit)
> > +                             goto nla_put_failure;
> > +
> >                       memset(&vxi, 0, sizeof(vxi));
> >                       vxi.vid =3D v->vid;
> >                       vxi.flags =3D v->flags;
>
> Thanks for the patch. A few things:
>
> 1. I used [1] to reproduce the issue. I can confirm that without the
> patch (but with ff205bf8c554) the warning is triggered.
>
> 2. After applying the fix we get a different warning [2] due to
> EMSGSIZE. I believe the WARN_ON() in rtnl_stats_get() should be removed.
>
> 3. I am aware that the double accounting of the multicast stats makes
> the patch correct, but it looks like a mistake. I find something like
> [3] clearer (on top of your patch).
>
> [1]
> ip link add name br1 up type bridge vlan_filtering 1 vlan_default_pvid 0
> ip link add name dummy1 up master br1 type dummy
> for i in {1..4094}; do bridge vlan add vid $i dev dummy1; done
> ip stats show dev dummy1
>
> [2]
> WARNING: net/core/rtnetlink.c:6332 at rtnl_stats_get+0x294/0x2c0, CPU#4: =
ip/4404

Good points, I will address them in V2, thanks!

