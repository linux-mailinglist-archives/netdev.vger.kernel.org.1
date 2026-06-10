Return-Path: <netdev+bounces-297665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NtLiJ0ZbKWpjVgMAu9opvQ
	(envelope-from <netdev+bounces-297665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:40:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 225C16695E0
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:40:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Z91wcEt9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297665-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297665-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BEA73032692
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C818A3FFAD7;
	Wed, 10 Jun 2026 12:40:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E80B3FB06B
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:40:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095236; cv=pass; b=K630LrMB2Z0p6VJwXtpH/y8lVhZ/dGBF70A+n91h+Lq/k0KT8nexGnXknU3IgZhYl7bJcXzrwboDsqX5/OHKUlWcjPlneBvwJfiEp5ds6UNOUdrxA6z31f+CXNqfO/+PpBzwTbFbSl4RdLy5F9u2/oosca09eAzp4toidyLq5uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095236; c=relaxed/simple;
	bh=cTKHBimgFTP3cQwXDhhiTJFbyDNHW1Wc3JO7RqAcbas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRaUKf9TRWLXR4onPzfdzbt5hk/2DqIYWNtCYH6bKqJVPyItpZRAFQHsBCDMvy/nri8poflzFTGEd2AJ49yPzYjdiPJdGvV74H31TNq+jF2cWAuX4W6Odh7fqwJfF+rq2PTgT8iR9re0qO/XQQ0NQ9Zt49UgvHI+93yDfqCe5Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z91wcEt9; arc=pass smtp.client-ip=209.85.128.170
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7e053987001so61682577b3.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 05:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781095234; cv=none;
        d=google.com; s=arc-20240605;
        b=d2Ew5h110ZYpk6n4ibaVLtshGa2BGI4ViybYOOQlrEl/2qDwbMovSOzlF6kNMmWksa
         9G18VfTjA9WAp73/BBz5rnz32ko2lhkvZ0aNBHwBPfp9MWSjvaStIK8VBam+BBCaXFn3
         e4KvsJJPqLSecNKPp27QHkN6zOn9oCE23FSiflPdO4v99d4PPv1IECMHOaWsJDrlJwWG
         vxbkmQ39da5ATCc8ZMhOq3RIbmfU1faE5rzEeO8vA/l2M5CAJLcwXfXQJAqt3l2+O0Y8
         h7C7jK1Rh82QHVWGImWPjqLDS39ER/2pO3TQ3O5YfuMTqqnWVThry+QbRRdGZTfUFBcC
         Ve1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5H1jBOYYY3PeAkd4J7mLCgYfvkPn6xRIFo0bYZfoRu8=;
        fh=yoivYsvNbUAS1EHEuaUKM24sMIu6OM3XEMhtDleJXUA=;
        b=QAGN69SN4GOiU8UvVBvQG1TP6VMNMGreh9IZKL+UCwZ45dQ9K4p//1lC1gP5ZO5VVE
         IA7jq5yvxZn9wBG+8QTvqWXh6dWC0MPjlssEZiyawPO3cGVonunKx13W4cAblcokyuZ5
         ldpduN30C/Kifhb2Sn4PRBg76F32PDf4/pwyh18LmhkCcaLAzYqUHvlbDM+U022T4BSp
         4im4iKIdybtfNaKvTuvaXgROWoip5f2N9Cmy/3pqvfKTi8Htt2/IaUcXSR6+0u/6bcRH
         dCFysCDICaYNjizqLZJz3HjMvPOC8AT+jBY1cUQpX5cCvX3gHgBP3hgjNTj4BhdWmTMx
         4lMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095234; x=1781700034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5H1jBOYYY3PeAkd4J7mLCgYfvkPn6xRIFo0bYZfoRu8=;
        b=Z91wcEt97i8DPDVEAaGF43lhXxRPgA+2JEvAKRzmVx0pLtH/6mpkqhsJNqEu5Yag9Z
         CoYgZJ7aHDbrCUHquARGDgfTWc8hCo7H5C0/UExz1IT0ctrOyh5J86SjuWopB/Hp53nT
         8f4tuhHQmEeE8LNYv+Ydla/fxd69R+pmKNAo6aDaqys87/PCt1/3eBbmC+GExkwwP0ia
         4/t+TA3jFfvuwVIah3DfZ7fd5i3dhschJx0cWrtkanWPDZtjZ6GdTgp+h2UiQy5+cwJn
         V5yTV0wwzRRAEg7BBOolKHsXHY4Aj1QNz1vyootMAF2efydvbZSySbMc7IPIF7JThxZV
         I7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095234; x=1781700034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5H1jBOYYY3PeAkd4J7mLCgYfvkPn6xRIFo0bYZfoRu8=;
        b=Oaa0cjahlN/4AAFRMR8pz8m4S4tqWEV786bPdeZGF+mjIzTRQ6by04rZRgfAC+a9Gt
         Mrm4AqOXFqK0a6O3LZoyzboYnzj77BGttg1DzL7VPdGN9Sll5JX4nmhnXzrUzAsT8biJ
         rXprfpzvO+JW64vhEKcNNo14ewWLNOBGWMsX0hA7FoJdGdgqqHdqqpB7/siFoMW86udp
         cTI6ZQmEzvNasLc5ZqUWNFzkoRRdgxYF+63mT2foEkVSOw5vK7/jdylePvIJklolWCtu
         Oj4GF2zccBSBogFJNsP4Iw7S1iHhy2PbE8lXJMRnj2jIJA+4PHhCyRiRpnRJByPP9VPf
         X/3w==
X-Forwarded-Encrypted: i=1; AFNElJ9YR6WH+Y4mf8ZLas4nC5+aoTCh+hJjpatm4ooKLFWz66+EJrayoDWa78jqMEgGimGLNMAiVDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUyhvjJhAS77LsFGe+A/ZZkgiyBGF1Ij5CZHJOhJ/R4B7IBD8S
	S5ZuNuFndVCzzQYwI5GJbaEGzRvd8wlX1Zrux8RhjG0epCBfQb0WeRO9P/Ya+IHkWvyzl2ALrM8
	SoINAwDNiZv3OwzdrnRQhXLomz9y8N8E=
X-Gm-Gg: Acq92OHdoqcJzIUkz6TelpQckElh/kdZiGFn2/nhSmRMys7h1sloAkcGTCiKfETOFJN
	5TaM8lUPk/KZvzUT3gXgGm+pGwwphihbpTrgWaiWPeh338f9wqurpCboOtxVuL6VRqn9odZQzB/
	v+goW+vVObSot52ah+EHIyLUV9dtKSnSjPeqmC7gAPOy0AsHLpF6qQwHbrvNfcYUZ24uRXBOwQf
	BpPr+3SPhMU2AGBLDsmSHOWwe7dq8y9hcSuzFhQ3Z2VFGaphBtK++l0TtRwLd/MLZaWKGTpEjBU
	4o20XkCZa2SCMrBt7H54BvN1WK6lEB+ZJnNQtbtuWyR8gVQysfM=
X-Received: by 2002:a05:690c:6106:b0:7bd:9a25:f39f with SMTP id
 00721157ae682-7ed5028e58bmr182960677b3.4.1781095234448; Wed, 10 Jun 2026
 05:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610120812.49054-1-laoar.shao@gmail.com> <1f949cfc-eebc-4813-9dfc-b9a9ec79494d@blackwall.org>
In-Reply-To: <1f949cfc-eebc-4813-9dfc-b9a9ec79494d@blackwall.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 10 Jun 2026 20:39:56 +0800
X-Gm-Features: AVVi8CcO2DTbEHqga4RnxUkLkOH85qFDqmknHaj9LORAv4IFs_2V9oUMuG5Xo3A
Message-ID: <CALOAHbBeBez2DAQD+1PPc1Dmm0HH0PQcytG-eaxgWyThRt890A@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-297665-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bamaicloud.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 225C16695E0

On Wed, Jun 10, 2026 at 8:30=E2=80=AFPM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 10/06/2026 15:08, Yafang Shao wrote:
> > The upstream kernel has supported broadcast_neighbor for 802.3ad mode s=
ince
> > commit ce7a381697cb ("net: bonding: add broadcast_neighbor option for 8=
02.3ad").
> > When upgrading from our local kernel to 6.18.y stable, we switched from=
 our
> > out-of-tree implementation to the upstream one.
> >
> > However, the iproute2 package on our production servers is too old to
> > support the broadcast_neighbor option. To enable this feature, add a ne=
w
> > sysfs attribute at:
> >
> >    /sys/class/net/<bond>/bonding/broadcast_neighbor
> >
> > This allows enabling the feature by writing "1" to the sysfs file, matc=
hing
> > the interface we previously maintained in our local kernel.
> >
> > The result is as follows,
> >
> > - For 802.3ad mode
> >
> >    $ ip link add bond0 type bond mode 802.3ad
> >    $ cat /sys/class/net/bond0/bonding/broadcast_neighbor
> >    0
> >    $ echo 1 > /sys/class/net/bond0/bonding/broadcast_neighbor
> >    $ cat /sys/class/net/bond0/bonding/broadcast_neighbor
> >    1
> >
> > - For other modes
> >
> >    $ ip link add bond1 type bond
> >    $ cat /sys/class/net/bond1/bonding/broadcast_neighbor
> >    0
> >    $ echo 1 > /sys/class/net/bond1/bonding/broadcast_neighbor
> >    bash: echo: write error: Permission denied
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Tonghao Zhang <tonghao@bamaicloud.com>
> > ---
> >   drivers/net/bonding/bond_sysfs.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bon=
d_sysfs.c
> > index eaba44c76a5e..24eb23634d98 100644
> > --- a/drivers/net/bonding/bond_sysfs.c
> > +++ b/drivers/net/bonding/bond_sysfs.c
> > @@ -750,6 +750,17 @@ static ssize_t bonding_show_ad_user_port_key(struc=
t device *d,
> >   static DEVICE_ATTR(ad_user_port_key, 0644,
> >                  bonding_show_ad_user_port_key, bonding_sysfs_store_opt=
ion);
> >
> > +static ssize_t bonding_show_broadcast_neighbor(struct device *d,
> > +                                            struct device_attribute *a=
ttr,
> > +                                            char *buf)
> > +{
> > +     struct bonding *bond =3D to_bond(d);
> > +
> > +     return sysfs_emit(buf, "%d\n", bond->params.broadcast_neighbor);
> > +}
> > +static DEVICE_ATTR(broadcast_neighbor, 0644,
> > +                bonding_show_broadcast_neighbor, bonding_sysfs_store_o=
ption);
> > +
> >   static struct attribute *per_bond_attrs[] =3D {
> >       &dev_attr_slaves.attr,
> >       &dev_attr_mode.attr,
> > @@ -789,6 +800,7 @@ static struct attribute *per_bond_attrs[] =3D {
> >       &dev_attr_ad_actor_system.attr,
> >       &dev_attr_ad_user_port_key.attr,
> >       &dev_attr_arp_missed_max.attr,
> > +     &dev_attr_broadcast_neighbor.attr,
> >       NULL,
> >   };
> >
>
> Then update your iproute2 package, sysfs use for options is discouraged

Could you please explain in detail why this is discouraged?

> and is not being extended on purpose. Move to netlink.

--=20
Regards
Yafang

