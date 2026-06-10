Return-Path: <netdev+bounces-297671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7xLSNF9gKWrXVwMAu9opvQ
	(envelope-from <netdev+bounces-297671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:02:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF7066989A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:02:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NewJnCjw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297671-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297671-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0DBD308EF8F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA79401496;
	Wed, 10 Jun 2026 12:57:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB1D3E95A9
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:57:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096257; cv=pass; b=tfYPqv/1yvsx3kJ9rjiqcZGGo5gruaChIYWqHKmOC0XSc0l6z4EkxKC2BvwlI8akNESuhSZ8ttQLKTPnYXvslKXQSiumd88c5MrMvU3r6J0HWNnY6AxZTzT0IzdfglhOx5cTdD307Kt7/vswI+S9AH+tfEc5JzVVgenBuoLb0wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096257; c=relaxed/simple;
	bh=q2xrk2+3HgVBwtdYlqpdYX5IRzhRsvOcg4kEjVmgO2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chN5nGm0bdrsKf+NetBwmzdsEIdhDBtEDbJnfO4yiT6tuyHKOGcH+dTFSdx/+g3ZupXP9x12NyQmKmudCZxh3ckCRzRa+8bd2vWm32elaVluqj08B5b1UAbp7l3d7ZjVdAHLsc6PB7OOUPpulGJFMLI9vyMkH8N/DL7htmGHELs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NewJnCjw; arc=pass smtp.client-ip=209.85.128.181
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7e0fc8ead7eso71832467b3.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 05:57:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781096247; cv=none;
        d=google.com; s=arc-20240605;
        b=BU4r5AoQMZxXDficUI+wO2oeifbU27GMacA6fEb2YSOJSETqoE0Et1MCi31qtv1bHD
         QLtdhOV38IUEAdkOXV/0ryO4HIu7iYMXJsv/uIFzTFWOq9BnB+c6HtjnCJWgxphKdzQd
         zvTpOgzSbtunj/uEeDfEoBDQ5FpFsh8gYxf4CMq0veK1djUP6ccGU6bXiRreSmm5mZh4
         JWsVmBYOumyHYJ7Xa7F8gItQyVjfc06xIz7ouXsKUGEPkW2MFzWPXkK0pw49LELotiFq
         OIc1hl5P80A5AekuxFMYiR3/5m3mVKUUtKkwyl44yAVWHPzQCgQWfPSUJ7cq8uVoEV5A
         wiFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qgB64hxjLKV54PVNKO9CubkDHQaU9AKR4BLgHTuoKgU=;
        fh=02xq1mbVUlueCs600WjfOh4avCXnXbGBIQ4PWA+Pu2Y=;
        b=by/qv/4D8dz/Vro0EKVm7Gon3XdIVceE7ML1GLn81j/a66iMwigejObMhdKuYfLKUB
         bpFETlI+PoK/bh2qhvqFG2Nrk3rVM6Uk8QRoowr/c++TIJwxiMmlWYSCo31/Qk2qQ3wv
         9b9ClKtrYjBd7TiFhsMj7IgH6c9HOc2zM5VNXvOvIu6z/VDjyCOryBZGjkSRdqWXCo+Y
         R/jMt7gypTHTqV46SjdWWwUvx1WDDH5CDT2zJ4sCarqWI8pjnewxwO2VISiwlt3Wv+tP
         l0BuvmnhJyfJFxwEapuRaQt3LyqSKd2AqZ9/aCdNGxCh5ph3Gd0iz7vHmcxAZGcHsrWJ
         eB1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781096247; x=1781701047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgB64hxjLKV54PVNKO9CubkDHQaU9AKR4BLgHTuoKgU=;
        b=NewJnCjw8sgiSbGtR6pyHLDeuEbzFgLypp9t8s0zNclnj2gMsnvdnE/6SeAeqGRSK1
         yD8Bc7YEiDGHGKKop6ftsudm04WZ4BSw6KnzFtaK7cIr/zFMKP//X6kZiAbxjQAn6TsC
         TmzHbHHa324+htcuuL3sCnXDpWKkYR+gV+nHREK0FCKC/CZSnpUJ5DxfrNXUugGEF46q
         6tiYtHVADYy0CN+y+bMGMgcZLd2NYsYYpPmdpSHYvhkr5VYh6Bgy/qeqFrqj/XbrPj09
         vFgO4o6GSn197SjMU8yANb7x/Lrdz0U2Q2YgRChQR7IVz2n+tN0GutZ514I9ISDOXe4G
         EH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781096247; x=1781701047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qgB64hxjLKV54PVNKO9CubkDHQaU9AKR4BLgHTuoKgU=;
        b=rA2byuJjqR+s8Iahz7wsbhS6zsIrr38weLqQdfoxMhVyHoqYNoD3/czBa2+soQxzd0
         X2UaPP+CNNTDtzc7gCap68y3uiDfulfx/DeWteUaTO4hcRtH2nc+PFlaCdPvb7Ab/TUu
         D6I2nC8DL1w5a4fK/c4mej/CcJy3FVxSUFjlVmnDjdyG/q4cvDxxcpinHpVR7VRM9Pdu
         fSiB3ov0gsBzX8pJ7eh93uphtk9vNt9Pk++0LUhPy/J7kq8VGCm+6Vp469oFGajgX2Yx
         LnzFqNTW/syavFYrN9G+uJ31CgspTbBgSPFG8Mz6XrdLOZdWurHHhPqjKcCcfQYJAcOn
         iOMw==
X-Forwarded-Encrypted: i=1; AFNElJ96OI1z+HAxrEYjJ8HxqZeRL7We7GYjuhreqI19GQ49vg7o4O4m9N2b6+t4OicXJAofv0tyWDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJpRUlvPUUGMzKV6KfObvLVcnTR8bQ/GoTenwvAK5jH33htr/l
	Id2hyyCg1zes02TIdaeB83wByHK7kRm6Qqhvj58pS+jt3Q6bSdPnaXxUUiLRVZJtMXn7IjAMUAE
	Rxk9i04fXMNB2q8cQdQYtsAKRylJDq0w=
X-Gm-Gg: Acq92OE6udIxIedDXC5LdBaOtfPdet5PjDR6cUkAsd1Lxs1Gd6LGiWtgEvbBSyTtDvH
	y3O0CUh8lXSM+5AjxALekrUICaMnZA6/1Wyygm9A6IuCnLYkA1NiVJ5LIzGb40+sFQbycUBeE3J
	eSLy/VS8SIwUI3Bi+c/+xDXFDBENNFORAPnGo8uHcVdTgZ8yfpZiycDFR320i7+GXQDTUKfMUzF
	Lind7DVJ1o71kNakMYK8qhA2lOydnW7jDZIP5kg2MfjGla/1BoC8NrP8LD0pqDET3QDl9lNo+bV
	nl86We0rb05E84Mtf9vgrNDFb9mCK1e6Rt330mbz8U43o2MdHd4=
X-Received: by 2002:a05:690c:e3ec:b0:7c0:de77:f475 with SMTP id
 00721157ae682-7ed0b874511mr247378527b3.8.1781096246753; Wed, 10 Jun 2026
 05:57:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610120812.49054-1-laoar.shao@gmail.com> <1f949cfc-eebc-4813-9dfc-b9a9ec79494d@blackwall.org>
 <CALOAHbBeBez2DAQD+1PPc1Dmm0HH0PQcytG-eaxgWyThRt890A@mail.gmail.com>
 <dd10cb23-261c-40b1-8b33-15a519f366c8@blackwall.org> <69e48cef-5c98-44c8-8855-5a2ebe615c94@blackwall.org>
In-Reply-To: <69e48cef-5c98-44c8-8855-5a2ebe615c94@blackwall.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 10 Jun 2026 20:56:50 +0800
X-Gm-Features: AVVi8Ce3T2su91XKm-hLYAiIPwd3EF1Y39K5uZr_TnJRNQZMSKNSVg93xiCq9VQ
Message-ID: <CALOAHbC4Z1TFL9xY4QZzdDsvQ9h-MfxkZRjPVG_JPHCzGNjpyw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297671-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:razor@blackwall.org,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:tonghao@bamaicloud.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[laoarshao@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laoarshao@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RSPAMD_EMAILBL_FAIL(0.00)[laoarshao@gmail.com:query timed out,razor.blackwall.org:query timed out,tonghao.bamaicloud.com:query timed out];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,blackwall.org:email,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bamaicloud.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BCF7066989A

On Wed, Jun 10, 2026 at 8:52=E2=80=AFPM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 10/06/2026 15:45, Nikolay Aleksandrov wrote:
> > On 10/06/2026 15:39, Yafang Shao wrote:
> >> On Wed, Jun 10, 2026 at 8:30=E2=80=AFPM Nikolay Aleksandrov <razor@bla=
ckwall.org> wrote:
> >>>
> >>> On 10/06/2026 15:08, Yafang Shao wrote:
> >>>> The upstream kernel has supported broadcast_neighbor for 802.3ad mod=
e since
> >>>> commit ce7a381697cb ("net: bonding: add broadcast_neighbor option fo=
r
> >>>> 802.3ad").
> >>>> When upgrading from our local kernel to 6.18.y stable, we switched f=
rom our
> >>>> out-of-tree implementation to the upstream one.
> >>>>
> >>>> However, the iproute2 package on our production servers is too old t=
o
> >>>> support the broadcast_neighbor option. To enable this feature, add a=
 new
> >>>> sysfs attribute at:
> >>>>
> >>>>     /sys/class/net/<bond>/bonding/broadcast_neighbor
> >>>>
> >>>> This allows enabling the feature by writing "1" to the sysfs file, m=
atching
> >>>> the interface we previously maintained in our local kernel.
> >>>>
> >>>> The result is as follows,
> >>>>
> >>>> - For 802.3ad mode
> >>>>
> >>>>     $ ip link add bond0 type bond mode 802.3ad
> >>>>     $ cat /sys/class/net/bond0/bonding/broadcast_neighbor
> >>>>     0
> >>>>     $ echo 1 > /sys/class/net/bond0/bonding/broadcast_neighbor
> >>>>     $ cat /sys/class/net/bond0/bonding/broadcast_neighbor
> >>>>     1
> >>>>
> >>>> - For other modes
> >>>>
> >>>>     $ ip link add bond1 type bond
> >>>>     $ cat /sys/class/net/bond1/bonding/broadcast_neighbor
> >>>>     0
> >>>>     $ echo 1 > /sys/class/net/bond1/bonding/broadcast_neighbor
> >>>>     bash: echo: write error: Permission denied
> >>>>
> >>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >>>> Cc: Tonghao Zhang <tonghao@bamaicloud.com>
> >>>> ---
> >>>>    drivers/net/bonding/bond_sysfs.c | 12 ++++++++++++
> >>>>    1 file changed, 12 insertions(+)
> >>>>
> >>>> diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/
> >>>> bond_sysfs.c
> >>>> index eaba44c76a5e..24eb23634d98 100644
> >>>> --- a/drivers/net/bonding/bond_sysfs.c
> >>>> +++ b/drivers/net/bonding/bond_sysfs.c
> >>>> @@ -750,6 +750,17 @@ static ssize_t bonding_show_ad_user_port_key(st=
ruct
> >>>> device *d,
> >>>>    static DEVICE_ATTR(ad_user_port_key, 0644,
> >>>>                   bonding_show_ad_user_port_key, bonding_sysfs_store=
_option);
> >>>>
> >>>> +static ssize_t bonding_show_broadcast_neighbor(struct device *d,
> >>>> +                                            struct device_attribute=
 *attr,
> >>>> +                                            char *buf)
> >>>> +{
> >>>> +     struct bonding *bond =3D to_bond(d);
> >>>> +
> >>>> +     return sysfs_emit(buf, "%d\n", bond->params.broadcast_neighbor=
);
> >>>> +}
> >>>> +static DEVICE_ATTR(broadcast_neighbor, 0644,
> >>>> +                bonding_show_broadcast_neighbor, bonding_sysfs_stor=
e_option);
> >>>> +
> >>>>    static struct attribute *per_bond_attrs[] =3D {
> >>>>        &dev_attr_slaves.attr,
> >>>>        &dev_attr_mode.attr,
> >>>> @@ -789,6 +800,7 @@ static struct attribute *per_bond_attrs[] =3D {
> >>>>        &dev_attr_ad_actor_system.attr,
> >>>>        &dev_attr_ad_user_port_key.attr,
> >>>>        &dev_attr_arp_missed_max.attr,
> >>>> +     &dev_attr_broadcast_neighbor.attr,
> >>>>        NULL,
> >>>>    };
> >>>>
> >>>
> >>> Then update your iproute2 package, sysfs use for options is discourag=
ed
> >>
> >> Could you please explain in detail why this is discouraged?
> >>
> >>> and is not being extended on purpose. Move to netlink.
> >>
> >
> > Networking has been moving to netlink-only options for awhile now. Chec=
k for
> > example:
> > 1e16f382ae0b ("net: bridge: add warning comments to avoid extending sys=
fs")
> >
> > The preferred way to configure device types is via iproute2/netlink.
> >
> >
>
> The author of this option also had sysfs initially in his patch-set and
> then removed it, here's my comment at that time:
> https://lore.kernel.org/all/d0e0379e-79fb-4a95-b160-6c1ca4276081@blackwal=
l.org/
>
> and also Jay's confirmation that sysfs shouldn't be extended:
> https://lore.kernel.org/all/1319073.1747143053@vermin/

Understood. So we'll have to keep this patch in our local kernel.
The production environment is complex enough as it is... ;-)

--=20
Regards
Yafang

