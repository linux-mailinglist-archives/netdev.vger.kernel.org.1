Return-Path: <netdev+bounces-298327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5gp/BOYUK2pc2QMAu9opvQ
	(envelope-from <netdev+bounces-298327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:04:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A16B5674EF0
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:04:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Itx50RKn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298327-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298327-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29C09305F6D0
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D2C3AD53B;
	Thu, 11 Jun 2026 20:01:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865E13AA9D8
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:01:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208090; cv=pass; b=l9HU/QX+LY5K0e4QXSU0MU6FOOjmX2WrNShwL/A30JftKpo7rsPEvyEj8+hw4nnUbTyjyLCKOA+t2/nrzTBpwo5RIpxymFGgmeaj4RESm7DjPXR5Y+51bwVcEKuOecwThBuNvkbUipT77FS3bhDPz9S+/tsMB3yJ6FwxuQYj3GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208090; c=relaxed/simple;
	bh=4OG4S8BRL2yKEIPr/FwRta2jeQgaLmx8WH8XaDWgXd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L27H+X/6C4XUcp1tCnhf/HQcWYkCaZZAkqR1zJL2KudfrpfKuXZwNWKKxg7LbyjvG9+Bo+3jSu3nh66iV4GcsTcTLx51n4k4BYNahyeCHCqRF5Ryog8q3761Wcpz9sk4v40EoNH3bUuuwJDocWanZQspeqxVs3mICLAHEUV5D94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Itx50RKn; arc=pass smtp.client-ip=209.85.219.43
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ce9df4732cso3704886d6.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781208087; cv=none;
        d=google.com; s=arc-20240605;
        b=lVTilqnkCqQsQ+UO3VVWTOGPyIbEu9Yw5Sf60XM+FsRjjGZ5BEfuUK/2RbQiiDXBz3
         98C1Yt/TjEYnymqeQExAiFUJZLzChDrOLzBCuY+S7XInvPSqMj4EVTaOAil7ghYtjtT8
         EmhMbO+JN5v/Ly8aRm122DiwxcJMU/PdkZZJVTjWx25xGeJoqm4EifIgVtO8GKS7aamY
         uIIpNrCLlPDhdd5jRmq4/pYR5ytuYovFpNQb8JnSUc23qKKdNcpBwe1NeT0djz3CtIPW
         ZgYine7W16ceXKsrPGBYgnYgTu8dh7ucZMXWy0KAISHKLr+efPdjxd9FsaFsBaZMjfyL
         i/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m5k0HABmkY5O0BOEX4XOx6bwDxv5Uin7RpNPaKbQwcw=;
        fh=cZunyNqGKfDJY98WtKsDjbkRLUbku+Gx+wa5W/QZFI8=;
        b=JkSEwaeu6NxMDoZ+C5zyiwObPYWExTeQC0T9qX1RS5U3kMD5pZu+Tnn2UrRsHhaNET
         eTd417VJRK+3hBt2f7qM2pbm5Hqa6frqOieQI7uIRvL4q8yzhlNx355l5LvkJaU8Akqo
         4Je90E/+OKD3FmKUEzYYe7p1GYGDzXBDt+36OWK1sh1GoU3Rez3oNT7lYi4SQmrt5/KW
         PQYwRKgM+5SQyTakenZXnB+ma3qMYN9sEKKTv/BPy87dle6XbW7ceBiDB6U47OzBnNoI
         6MXFdslY7F+4UGw0GJKvGlvAP36nJFWEibSlU9NElt6bW36NCDJUGRmYAlYXAWfruG/m
         z6bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781208087; x=1781812887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5k0HABmkY5O0BOEX4XOx6bwDxv5Uin7RpNPaKbQwcw=;
        b=Itx50RKn4ZC1dCY6HDdJGCMylgizOPOayw27u+p/wylb8cssw98yN51L3SVNU/qMwe
         OI23JBcoMoguLMjsXeiM4jFU2clcCvTk9YsmAmZjrWxb4NF3u8CNkhlwfVTJy0+D1JVH
         3rbqH+0ORHNqBRamhFLxfXhTPr9JMLYExC/OP26tegqXL/Czqz/Re5VaFdy9t+Ab4oI/
         OKQqGEqyHVwcr2cux/bTzgNYiGP3Hz6vSsGzg4GB9pqcpTRyGL+s5SoMW2OTusfz+KxG
         cqsNdwtE1KOqd6sHSY9XwSPm0yIOGZHmxl54othczoKQpMaC421jMjc2cHB+j7UVB+YY
         iD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781208087; x=1781812887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m5k0HABmkY5O0BOEX4XOx6bwDxv5Uin7RpNPaKbQwcw=;
        b=Sce638fPsG6breAMqrG91Ta0U3nh//qFNtpN9vCXTbznu7cws/HQOUEwItAe65i7bu
         NpG3Nfrw5OsX/iTc84pfhtXyYO2pDRVWvZ5mj0Tr65wUqtzxT+s5HKEtCbXulM07IEBn
         Wegh1MnqX/QfOzjqB6gJYi8okQzKZoNCTxfR4uKTr+K2IyUcpC0AfVCc4Ijtuwi4FVH0
         B42VT0ASfWt/Z1n33rIhakdbvv1v3s0R+e6FORLzS0gDmMobOdIqZ6wj6rd2KA4UKBlZ
         VgUaGcduSJl3HougZSSTA/pUvbdITlG9c4pD4dNUMReGPGBVhqHLWAu8JC8n2zdqwp7e
         t27A==
X-Forwarded-Encrypted: i=1; AFNElJ9CcYtuKQoRA08va7tYETYx3mYCwiFcNT6wQylsB8n2qvtLaNcyTXofFU5WCkDQRBSL7Ri2oqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+6lp2m/s8xmSBBeVQXzB1BDbrIdcVLOlEeyC0b9pn8k3z1vK0
	jRpABH6HvtLQ2VM1NKoP1hKNHTFpo9zI6gNNf4OFaoHCUNLsMV0yaIeBLXSt+V5v/+Z3JMcUdNb
	nLkDLyGJJ3YDXSkzH16j6RwJusfDmyraHaq++dRiI
X-Gm-Gg: Acq92OHO0WdpQ4aYB5x8O8L1mQZ7zbjMd8FiV9ZtT5pQhoFu1ImAHJweCBLjm0DOq8o
	nk8QSr+lrVMDmAhQt/pRgfxjXZOnOR6xVPBZhEC+Ya9VYUUig7Al1EicvDWKg+TKKGzNDq6RZ/J
	l4rE/w93DQakR3vhb45df+HUvRm4iYPjATXy2vqPFZMx2O4sB5yVUCWQppAkJcDAf6TUIXbNc1I
	gYQG8kvaUzbtaLNoeNQVxnhTvbLVyKClkqlxC/oqJizWFjxqpGHoK7OjOhQd1SfFwhX+5g23Shs
	jxQhCYtSEgALNzSCPt2iqA5hlNUElB4JgUAVtWJOgpz838ujl5+doe3aybKdRWvmGMIvUV0DE57
	QygTtRxzjeK9e3CYL848=
X-Received: by 2002:a05:622a:99b:b0:50d:9e8d:9837 with SMTP id
 d75a77b69052e-517edcd8315mr62393771cf.11.1781208086325; Thu, 11 Jun 2026
 13:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610161836.1275531-3-edumazet@google.com> <20260611183037.1948556-2-kuba@kernel.org>
In-Reply-To: <20260611183037.1948556-2-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 13:01:14 -0700
X-Gm-Features: AVVi8CdK1YyCLr8JoyjsJM4ypMJ2E_s1yU36jJAEdsJyz-tCgtIWE0QZzQKd2OY
Message-ID: <CANn89iJpKYUgcH5-ehZP0RhzxgFDndTYdxJJdduEq-0LNmy32w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/5] bridge: use atomic ops to read/change
 p->flags in br_netlink.c
To: Jakub Kicinski <kuba@kernel.org>
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298327-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[blackwall.org,nvidia.com,davemloft.net,redhat.com,kernel.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A16B5674EF0

On Thu, Jun 11, 2026 at 11:31=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> Ido, Nik, do we care about this?
>
> ---
> bridge: use atomic ops to read/change p->flags in br_netlink.c
>
> The change converts net/bridge/br_netlink.c reads of p->flags to
> test_bit()/READ_ONCE() and rewrites br_setport() to compute a new
> flags value in a local variable, then commit it with a cmpxchg()
> retry loop.
>
> > diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> > index 7cb24de9c77d..12850f60bfcb 100644
> > --- a/net/bridge/br_netlink.c
> > +++ b/net/bridge/br_netlink.c
>
> [ ... ]
>
> > @@ -934,58 +934,64 @@ static int br_set_port_state(struct net_bridge_po=
rt *p, u8 state)
> >  }
> >
> >  /* Set/clear or port flags based on attribute */
>
> [ ... ]
>
> >  /* Process bridge protocol info on port */
> >  static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
> >                     struct netlink_ext_ack *extack)
> >  {
> > -     unsigned long old_flags, changed_mask;
> > +     unsigned long old_flags, flags, changed_mask;
> >       bool br_vlan_tunnel_old;
> >       int err;
> >
> > -     old_flags =3D p->flags;
> > +retry:
> > +     flags =3D old_flags =3D READ_ONCE(p->flags);
> >       br_vlan_tunnel_old =3D (old_flags & BR_VLAN_TUNNEL) ? true : fals=
e;
>
> [ ... ]
>
> > +     if (!(flags & BR_PORT_MAB) && (old_flags & BR_PORT_MAB)) {
> >               struct net_bridge_fdb_flush_desc desc =3D {
> >                       .flags =3D BIT(BR_FDB_LOCKED),
> >                       .flags_mask =3D BIT(BR_FDB_LOCKED),
> > @@ -995,15 +1001,16 @@ static int br_setport(struct net_bridge_port *p,=
 struct nlattr *tb[],
> >               br_fdb_flush(p->br, &desc);
> >       }
> >
> > -     changed_mask =3D old_flags ^ p->flags;
> > +     changed_mask =3D old_flags ^ flags;
> >
> > -     err =3D br_switchdev_set_port_flag(p, p->flags, changed_mask, ext=
ack);
> > -     if (err) {
> > -             p->flags =3D old_flags;
> > +     err =3D br_switchdev_set_port_flag(p, flags, changed_mask, extack=
);
> > +     if (err)
> >               return err;
> > -     }
> >
> > -     if (br_vlan_tunnel_old && !(p->flags & BR_VLAN_TUNNEL))
> > +     if (cmpxchg(&p->flags, old_flags, flags) !=3D old_flags)
> > +             goto retry;
> > +
>
> [High]
>
> Are the side effects in this loop safe to re-execute on a cmpxchg retry?
>
> The retry path now wraps br_fdb_flush() and br_switchdev_set_port_flag()
> inside the loop body:
>
>         retry:
>                 flags =3D old_flags =3D READ_ONCE(p->flags);
>                 ...
>                 if (!(flags & BR_PORT_MAB) && (old_flags & BR_PORT_MAB))
>                         br_fdb_flush(p->br, &desc);
>                 changed_mask =3D old_flags ^ flags;
>                 err =3D br_switchdev_set_port_flag(p, flags, changed_mask=
, extack);
>                 if (err)
>                         return err;
>                 if (cmpxchg(&p->flags, old_flags, flags) !=3D old_flags)
>                         goto retry;
>                 ...
>                 br_port_flags_change(p, changed_mask);
>
> Can this retry actually be taken?  br_setport() runs under RTNL, but
> several other writers modify p->flags without RTNL via set_bit() and
> clear_bit(), for example BR_MRP_LOST_CONT_BIT and BR_MRP_LOST_IN_CONT_BIT
> toggled from work-queue and softirq context in net/bridge/br_mrp_netlink.=
c
> (br_mrp_ring_port_open() and br_mrp_in_port_open(), called from
> br_mrp_test_work_expired() and br_mrp_mrm_process()).
>
> Because cmpxchg compares the entire word, a concurrent set_bit() or
> clear_bit() on any unrelated bit (such as the MRP bits above) makes the
> cmpxchg fail and trigger goto retry.
>
> When that happens, what is the effect on switchdev?
>
>         err =3D br_switchdev_set_port_flag(p, flags, changed_mask, extack=
);
>
> br_switchdev_set_port_flag() first calls call_switchdev_notifiers() with
> SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS, then queues a SWITCHDEV_F_DEFER
> attribute set for SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
>
>         attr.id =3D SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS;
>         attr.flags =3D SWITCHDEV_F_DEFER;
>         err =3D switchdev_port_attr_set(p->dev, &attr, extack);
>
> The deferred update from a first iteration is already queued and cannot
> be cancelled when the retry loop queues a second one with a different
> (val, mask) pair.  Drivers will see notifier callbacks for both
> iterations.
>
> For br_fdb_flush(), the BR_PORT_MAB transition
>
>         if (!(flags & BR_PORT_MAB) && (old_flags & BR_PORT_MAB))
>                 br_fdb_flush(p->br, &desc);
>
> can re-evaluate to true on a retry and flush FDB entries again.
>
> Finally, br_port_flags_change() runs only once after the loop, with the
> final iteration's changed_mask:
>
>         br_port_flags_change(p, changed_mask);
>
> If a bit such as BR_AUTO_MASK or BR_NEIGH_SUPPRESS was set in an
> earlier iteration's changed_mask but not in the last one (because a
> concurrent writer altered an unrelated bit between iterations), would
> the switchdev driver have already been told about that transition while
> the bridge software-side recompute in br_port_flags_change() is skipped?
>
> The original code performed each of these side effects exactly once per
> br_setport() call.  Should the side effects be moved outside the cmpxchg
> loop so only the pure flags computation is retried?
>
> >       if (br_vlan_tunnel_old && !(flags & BR_VLAN_TUNNEL))
> >               nbp_vlan_tunnel_info_flush(p);
> >
> >       br_port_flags_change(p, changed_mask);
> --
> pw-bot: cr

OK, I will perform two atomic operations, one OR and one AND.

