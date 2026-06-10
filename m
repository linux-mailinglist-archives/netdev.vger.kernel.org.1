Return-Path: <netdev+bounces-297679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vgFaFiBjKWphWAMAu9opvQ
	(envelope-from <netdev+bounces-297679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:14:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4DD669A07
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:14:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GqZNqFqb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297679-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297679-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF3453009F05
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3319405C41;
	Wed, 10 Jun 2026 13:10:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2F127B353
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:10:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097031; cv=pass; b=oFq9flDaHpboCg1e/WWoS2LjFUI8kIfxj8kxfzF+xXQezekaEB6h1c9ZjzzEOqvANCBqbipmMZERMl58jbpFWlkBYZbF8BdDPjwZRPU5F3xg+Lyk56AJgtI0s0BkWJdP6fsGQJhRmAZcoXMyBxKWhXY/IfjhBQJn2x3vcgafBhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097031; c=relaxed/simple;
	bh=CO80aREBKT4jwJQ1+t1e5YeUYBJqmiXpHflXmYTKDQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyKp62x2k3Elhfx+W4b/bpt+THx18qQitx/FhfGXlO2G+X82yFptJpHKBBMAeyeXxCMESPmfKPkevZoG6ulgwMxVLgEh6O/cqF2SJ9m6Zy3Nv67EPYbOBTrcpm9kFTJqqAEgfLJOAMhJEXJWRxeM2c0MARxkXPq2QnLqPj0ktfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqZNqFqb; arc=pass smtp.client-ip=209.85.128.181
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7e2fc11088dso61017627b3.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:10:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781097030; cv=none;
        d=google.com; s=arc-20240605;
        b=al0n/AXq/bAszTxIx/Rm0EG1Rg+DH9pepBpmdVarYtu2wghzuF4/sQc7XwhXKwvenO
         8ba2+CUe+6h+v91rAoSORg7MD38+qcYHlXprguj6/xt9MJK3ZNoSY8YiULa6FJpRZyqH
         xFPowyZxi8os0RwWJPtho/g5gze7MsKtb7MUwE1ZmNqfp/f8qXjcrPrxMmFJB2Nfmjv3
         XUU9FTxihKSNQjldkqb15KkWTyaZ2/VVtgaUTBVYnqyNixNW4ui1oI6QuPPWbBKt+v/0
         Q8hBiyLLn/DrtA2Qon4HGezZ4JThRk8kf3AEYJZLZh6K8J1FT7rKlGvcAvmRVBb8RMzc
         2NKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XZ3cqlRT6t+bS9u/ulWJ1j1xI14SQqJ0tTJW5gmHh3k=;
        fh=ijVgaA7YFtgz5U5Dur2p9oq1+XfLbktOBQNilcELb4Y=;
        b=iCEUGmrr8jPRkOus0FTFr0qaABOY6CrO9MOK/Gxtavrw6+VJ9H4WZZgki6Da9jK1uw
         +lm6qApc/c0NU2NABKpjEFIPYYRyPNwDF+Nr8VY99ogzxE17nWEf55iucjvWV/RR4Qk5
         qxlEkSwm0VueStrM2wRWRFp9uM5GwGSBXDtDCS96pCQwd23cf04OGJWQKqI56s8famGL
         iBFchlMg6CkKWUoI4ImXmnj35TuzkQZ7+k8G5AZsWWzRQJ/2yCV50SwuxJqKEOxRdt8H
         aRBG79hJ6jU0jLUyaR9OxqYbfrorimCrhNZTKjvViOJc/YfD+kXBj9UJ/20v3QP/4R6s
         D1mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781097030; x=1781701830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ3cqlRT6t+bS9u/ulWJ1j1xI14SQqJ0tTJW5gmHh3k=;
        b=GqZNqFqbrHsHzf/1kIgEpsEIOAOIrX3yldiLe7fW0cEM5aocdwfmBaGM0G5mInt2o5
         o1mgQloWQRrS3+aSfszdbDXVqZnepsHiQBxPZG4mGKMTS5elYEU5AOtM4iwG2AlY6vb4
         sXlt98IfWUqVo4aKTo4ce0Di14cHEiOVUpBb4cGKD0YI9pbp4ROaZdTN1bqfYNXv+JKm
         BmAGGyQGcg6Jp9HJ4aTakYyBaFOc+yxfqMQdHXx4DnOhY6a89iqbOrAumx76ipc9YTdb
         ukPuwTBRL1iaywJ0Xc2SmKM/AelXph7mRIx+hvBZbCz2lQN9Tf7MHJm5NFQSbcX8t/3H
         bGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781097030; x=1781701830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XZ3cqlRT6t+bS9u/ulWJ1j1xI14SQqJ0tTJW5gmHh3k=;
        b=d6VbbU2n/2mUELQDyNNoMlFjAv+XxZ4U+p5CNjh5M6tJnYUxIk5jI14Rh2PIEin0dm
         iKAkziCiS2bgXi/h/ZvL1kiVgX0SOJfwlg5rQh6sEIm3ZhErm2XQ8x5uSC0yt8eUW0QW
         1qslvHLql/1MaUtOEE5ZVcM5bRSOQRtphRe9oEq4dnRHBYqKmPfHciRiy0VkhA0BPHgw
         qVCdJFU7rJO27YCjyUeaBENmueHRqwGiWyK1tvByT6ZVfzq0As/cpp712JKq14cDA2cA
         BLX39K4fH3WsF4i8EQF9zmhs9xsaoUxSgTmmwJOcyhIZxN3TQCntmTWVMDmNjxddKyuJ
         2RCA==
X-Forwarded-Encrypted: i=1; AFNElJ/9nf1+M8eeKh5DZDdbcW2CRnjDCQxJh4v0A4vEkvkc4L6ZPL/qB3uoG1pHcWsfRd+6IVpk6KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX7rZH8pZ6wpwcD1QHEarCw/qYozYo6Kh1hrNWaN92MBIQoQCn
	IwFBZTjilKG8CyybdcOIqQoABmXz2Nv33cTZjNJhzUVemLy/pKd0JWm2uTb7+ZqAb5xRi9xhTpP
	Cvuugw6QuSr3/Oe0cm7WXp8qpxwCmeCs=
X-Gm-Gg: Acq92OHmxAKC7fzoYPio0En3qlURJH+v2nXRO1U3LhM11Ct5RbwLQQS5wuIFwCwv1Bh
	p6d1INv+Aw9rZGsYo5gHXuh1lbQo26tRLve/w2G7Ja+qTv962KvCKfTDs1JMX+4XjJP11ky5z7m
	LKG1xEijMhNzNZhGuYK+BBIO6VIQvoUZu07NV8tdHSTNmQHJTQVCYrUbbvEClqgeUMhA0JTVu8a
	bEIqMuKUwYs8i35Bmd0TC2i1Gt10CC4j40p4OlaDAThq8r8DhIRGLUjl/kcjnJB1LAnMdprt1gH
	Xhg0xawO0cTajX3BrX8deKE8MrBLZ2flQv3WfZ+bVrsU9TMHFTg=
X-Received: by 2002:a05:690c:6d08:b0:7db:f1b4:15ed with SMTP id
 00721157ae682-7ed0a200dc4mr240287727b3.3.1781097029483; Wed, 10 Jun 2026
 06:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610120812.49054-1-laoar.shao@gmail.com> <1f949cfc-eebc-4813-9dfc-b9a9ec79494d@blackwall.org>
 <CALOAHbBeBez2DAQD+1PPc1Dmm0HH0PQcytG-eaxgWyThRt890A@mail.gmail.com>
 <dd10cb23-261c-40b1-8b33-15a519f366c8@blackwall.org> <CALOAHbAnKP96ZZrVZw8duABJTUhmdcUZ_yWcJoRdjCCV9_pb2g@mail.gmail.com>
 <e1745196-d315-4dcc-8157-8a56a91f4e20@blackwall.org>
In-Reply-To: <e1745196-d315-4dcc-8157-8a56a91f4e20@blackwall.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 10 Jun 2026 21:09:52 +0800
X-Gm-Features: AVVi8Cf-I_bA34n6I3A9X25h7PWQZzeM9D7tCYB1QxkVLq4i1JJwUygsE7udRnU
Message-ID: <CALOAHbAXFmpG83RaaM9NMzQ_pT7Dseh1vYuMurG-0QMsFFk_Hw@mail.gmail.com>
Subject: Re: [PATCH net-next] bonding: add sysfs interface for broadcast_neighbor
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, Tonghao Zhang <tonghao@bamaicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297679-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:razor@blackwall.org,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:tonghao@bamaicloud.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[laoarshao@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laoarshao@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bamaicloud.com:email,mail.gmail.com:mid,vger.kernel.org:from_smtp,blackwall.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E4DD669A07

On Wed, Jun 10, 2026 at 9:00=E2=80=AFPM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 10/06/2026 15:49, Yafang Shao wrote:
> > On Wed, Jun 10, 2026 at 8:45=E2=80=AFPM Nikolay Aleksandrov <razor@blac=
kwall.org> wrote:
> >>
> >> On 10/06/2026 15:39, Yafang Shao wrote:
> >>> On Wed, Jun 10, 2026 at 8:30=E2=80=AFPM Nikolay Aleksandrov <razor@bl=
ackwall.org> wrote:
> >>>>
> >>>> On 10/06/2026 15:08, Yafang Shao wrote:
> >>>>> The upstream kernel has supported broadcast_neighbor for 802.3ad mo=
de since
> >>>>> commit ce7a381697cb ("net: bonding: add broadcast_neighbor option f=
or 802.3ad").
> >>>>> When upgrading from our local kernel to 6.18.y stable, we switched =
from our
> >>>>> out-of-tree implementation to the upstream one.
> >>>>>
> >>>>> However, the iproute2 package on our production servers is too old =
to
> >>>>> support the broadcast_neighbor option. To enable this feature, add =
a new
> >>>>> sysfs attribute at:
> >>>>>
> >>>>>      /sys/class/net/<bond>/bonding/broadcast_neighbor
> >>>>>
> >>>>> This allows enabling the feature by writing "1" to the sysfs file, =
matching
> >>>>> the interface we previously maintained in our local kernel.
> >>>>>
> >>>>> The result is as follows,
> >>>>>
> >>>>> - For 802.3ad mode
> >>>>>
> >>>>>      $ ip link add bond0 type bond mode 802.3ad
> >>>>>      $ cat /sys/class/net/bond0/bonding/broadcast_neighbor
> >>>>>      0
> >>>>>      $ echo 1 > /sys/class/net/bond0/bonding/broadcast_neighbor
> >>>>>      $ cat /sys/class/net/bond0/bonding/broadcast_neighbor
> >>>>>      1
> >>>>>
> >>>>> - For other modes
> >>>>>
> >>>>>      $ ip link add bond1 type bond
> >>>>>      $ cat /sys/class/net/bond1/bonding/broadcast_neighbor
> >>>>>      0
> >>>>>      $ echo 1 > /sys/class/net/bond1/bonding/broadcast_neighbor
> >>>>>      bash: echo: write error: Permission denied
> >>>>>
> >>>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >>>>> Cc: Tonghao Zhang <tonghao@bamaicloud.com>
> >>>>> ---
> >>>>>     drivers/net/bonding/bond_sysfs.c | 12 ++++++++++++
> >>>>>     1 file changed, 12 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding=
/bond_sysfs.c
> >>>>> index eaba44c76a5e..24eb23634d98 100644
> >>>>> --- a/drivers/net/bonding/bond_sysfs.c
> >>>>> +++ b/drivers/net/bonding/bond_sysfs.c
> >>>>> @@ -750,6 +750,17 @@ static ssize_t bonding_show_ad_user_port_key(s=
truct device *d,
> >>>>>     static DEVICE_ATTR(ad_user_port_key, 0644,
> >>>>>                    bonding_show_ad_user_port_key, bonding_sysfs_sto=
re_option);
> >>>>>
> >>>>> +static ssize_t bonding_show_broadcast_neighbor(struct device *d,
> >>>>> +                                            struct device_attribut=
e *attr,
> >>>>> +                                            char *buf)
> >>>>> +{
> >>>>> +     struct bonding *bond =3D to_bond(d);
> >>>>> +
> >>>>> +     return sysfs_emit(buf, "%d\n", bond->params.broadcast_neighbo=
r);
> >>>>> +}
> >>>>> +static DEVICE_ATTR(broadcast_neighbor, 0644,
> >>>>> +                bonding_show_broadcast_neighbor, bonding_sysfs_sto=
re_option);
> >>>>> +
> >>>>>     static struct attribute *per_bond_attrs[] =3D {
> >>>>>         &dev_attr_slaves.attr,
> >>>>>         &dev_attr_mode.attr,
> >>>>> @@ -789,6 +800,7 @@ static struct attribute *per_bond_attrs[] =3D {
> >>>>>         &dev_attr_ad_actor_system.attr,
> >>>>>         &dev_attr_ad_user_port_key.attr,
> >>>>>         &dev_attr_arp_missed_max.attr,
> >>>>> +     &dev_attr_broadcast_neighbor.attr,
> >>>>>         NULL,
> >>>>>     };
> >>>>>
> >>>>
> >>>> Then update your iproute2 package, sysfs use for options is discoura=
ged
> >>>
> >>> Could you please explain in detail why this is discouraged?
> >>>
> >>>> and is not being extended on purpose. Move to netlink.
> >>>
> >>
> >> Networking has been moving to netlink-only options for awhile now. Che=
ck for
> >> example:
> >> 1e16f382ae0b ("net: bridge: add warning comments to avoid extending sy=
sfs")
> >>
> >> The preferred way to configure device types is via iproute2/netlink.
> >
> > Thanks for your explanation, but I still don't understand the benefit
> > of it. Could you elaborate further?
> >
>
> The benefits of netlink over sysfs?? There are so many.. it will help if =
you
> look into how netlink vs sysfs operate. Netlink is structured, transactio=
nal,
> typed, easily extendable, you can dump, do specific queries, it is less c=
alls
> and it supports notifications. I'm sure I'm missing, but in a nutshell it=
's
> preferred. :)

Thank you for the explanation. Requesting package upgrades on
production servers is often challenging, particularly when additional
library updates are required. Consequently, sysadmins prefer utilizing
native shell commands, such as echo, to avoid these dependencies;-)

Honestly, if a feature needs userspace tools to be upgraded, it will
take years to see it in production... ;-)

--=20
Regards
Yafang

