Return-Path: <netdev+bounces-272619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJBhCW6yxmmiNgUAu9opvQ
	(envelope-from <netdev+bounces-272619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 17:38:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD43F3478CD
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 17:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 121C5302D693
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3A923EAAB;
	Fri, 27 Mar 2026 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9lwDqVK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9731427A
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774629482; cv=pass; b=nffPKvWmGTD+nprmspaAeRjpWo5HH67X1xHuioK9vac65Y+utvQt56xgrFZ0BqXRZAG+RztfoqvCZMBZM26u0hkCP0pk1R9CM6lnOC9twTMwI4yCDmdnuX4uvNwr5L3OeOh1H0NyPzeDGlIBiocxDBQ7/cB6jScOhEMYgJpYmEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774629482; c=relaxed/simple;
	bh=GokTuLMhIobPSbdQrXwZZwX5RKLJyz3ofmzV1l1ir38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgDwQx6tHheh72va2s/rPlpbWnpZB0lqx6qponYZoghKbbufcbzJChE6LQm4av0r4wKcQnyEQ7Q08xIvLgGv/ZBvn9mQaRBgv9bOPjtN9ac0RiSGYgx8M9jl8qSBXh/HT3GR5YUhZrGh+cpNIJnLz73D6yhvkDb4jtR+Ya9o7eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j9lwDqVK; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5091ed02c54so530671cf.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 09:38:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774629480; cv=none;
        d=google.com; s=arc-20240605;
        b=CM6hbsu2LmVcY/+ch0lk9TpUagZ7yBgsvFBhAwcghflT7xuMFmyij9kG8x4eG81SWd
         jEMNUqpkBGXpm/7JyYOzXqZo7asR2OMT2Jb6jT3aC4/w30xH2rpTWlwYNFzkSEJSpwx6
         INcfmBqMIPWTf0I88XL7+QETf8MSdVfcWZJ7cFRb8KOZyxt1AGmSrZ0JQd2GSJBOu0oX
         0DS+OthFsw9UewC0PfuIigc4raPffFBFu/cTJ4FU2OsRfcO+KY1F6+aOdOqoj/TNgcaF
         TGu2saYi5TrGHQPB6czcyXF6Itu1yTTOM58N+C8/YnGEcAELS21g331/fQ4uyI1H4gyB
         M8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ogtTF1xlzyX8b2OV+MkXixyOfngUXZUbZmozqazuWJU=;
        fh=3Zucjh3cXLxuxNuYJN0oOLoO7wGTNiq9E5Scr9qGMzg=;
        b=V4wiCPEbpt9xYYC+HAjJUF6qjaGB5zohgGQs8PSnpvnaPsbik/RaRG3JJCL99iphtF
         YqHt0bRmyxBuGCRvYGbne6JRj2kuOnfg7asACsgMsOt4zLaMII5AOfGIpqFzfP1hUKOz
         V4nSFnY7oyjxsdQvXyXXj8vmKAisCQd5iLx6LcCivIk00M5j4TeEdzfk1Fa363nw3A9j
         CEe6h3HZGFxQSWXtm+GDgZG4uhGZm3G6jgEI+KQT8dUfw4GaaHOroHMltEBfIog6WtmL
         XMgyG+QrlsldfEYZWRwuJ5QNNgr3D0EE6ooVvztot2/jc5z2++tQb2TpE7GVBAv3JkW4
         gV7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774629480; x=1775234280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogtTF1xlzyX8b2OV+MkXixyOfngUXZUbZmozqazuWJU=;
        b=j9lwDqVK4veyYYmQ25FFu6c0xBMOGjtMiaetonVZahk/Le15CDd56vloNuSBZ+jijf
         HvqfiSDvVKA/7warPzsnupCSNAFFMzbUoDozGnaRj8xr5vOPfgYBEFamQa2E9Lah1fNZ
         Q9ggnRcbrrcEcEF4QuZG66uEr03m66qCR8USgyipeNo0yUncNX60G9d7peFw7bIaiMQF
         71mU01LB4eDiKjVdT8wnYfsJRAsnWqSCwuT4oS5l0SPzIyzJJKnpPaQDdk8YJCHyWNw5
         p0excsVRY6YqQTKxBwrsMHpslWGvE2qTrOI1ftfO9+CgUcNkz2GA6LLpcNN7p9NorTTN
         hcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774629480; x=1775234280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ogtTF1xlzyX8b2OV+MkXixyOfngUXZUbZmozqazuWJU=;
        b=ZQ/8jn2aG/jePOBCGjzd3u6KSmpPo0Mcu7Kxby0hEql4yYfg4vmmRxKt77aJlNLBtb
         zbgAK8JRmvbTxf+8WpPKAfHscBiSqDpYQ1ZdHJMDm0kEH9zLvbgP1dFqBglc4Tz2fiBI
         393oe3GPS5prhRxt+W60kelHs44C0AEfHhy9G4IVjzX7f7/4LefkXE9mctmbL5wk+4oE
         0HUZLXujEfGTfEdizyuZ6N3o6lykKpEfSXDs+ec1AyKfDOxKVDdHzWvfZtV+M4G8idPn
         RXw0waw/DnRTXRJLFHTyYSThQ/CnQVT2hAvq7+yRAXoclewPewyD1OLfQayaFz/3E3AY
         YrqQ==
X-Gm-Message-State: AOJu0YzJ7PCDWNMq+/i7ubGVIXlLvroNRwnmiWqliMX72fTmd0jwMFL+
	mlAq4ty4C5qkJ4xU+BEaeXIfai1jCnPleZJsmGO5BhibtkLFrvE654v45cb+LVNfjUpZgp5i1mF
	Fwt4dJ87oPjPtBraLc8QE1+9xnQXPAI0H8wc9tzyFv4x9ubYnhFR1IaC5
X-Gm-Gg: ATEYQzwjkh5ml8thV/18wslK7CVbwIVv5yyTlLU2vedOpOuIJpjYdiW8ot5o3HRcwpu
	VzyVCOV7X4JlhhAQRWWKR+n1IElMxm+vi8uAH3rG82KempNgQx5Jz6sdRa0MtoLkEhOjEdgizn0
	eQx2db6XKwDsPnzcA6ORQ9Mil4sjY4pdYsLS5qJlBDtU6z1RYBHVnXdyKAxSdhVic01gQ+lhR84
	8xz3Z2U6vW05cL7LLydXhCcBgY8nit1+Tv+JVl5SKW1wW1EvNdmGMQADR97h9qdhwecWCdd3opA
	HfItaMZDecMijyQBnYgRJKsKUNaNx+W+LLQB13Q7/w==
X-Received: by 2002:a05:622a:59cb:b0:509:1cf9:ea11 with SMTP id
 d75a77b69052e-50ba3252239mr5056631cf.7.1774629479028; Fri, 27 Mar 2026
 09:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325134439.3048615-1-louis.scalbert@6wind.com>
 <20260325134439.3048615-2-louis.scalbert@6wind.com> <CAJ5u_OcpOGSPYK-EzYeW8LdpJrLd16fGn6zN6cvk+tCjCi+QxA@mail.gmail.com>
In-Reply-To: <CAJ5u_OcpOGSPYK-EzYeW8LdpJrLd16fGn6zN6cvk+tCjCi+QxA@mail.gmail.com>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Fri, 27 Mar 2026 09:37:32 -0700
X-Gm-Features: AQROBzC5RoyR-MA-WNLGukD5D6GDubUPMrtmdWnIACu8StwWeIcp-tNmkeySk-0
Message-ID: <CAF2d9ji+aoMdA3ydstkPVb-pnCz56woJF6F2reftd4nPOEvBEA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/3] bonding: 3ad: fix carrier when no valid slaves
To: Louis Scalbert <louis.scalbert@6wind.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, jv@jvosburgh.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com, 
	andy@greyhouse.net, shemminger@vyatta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.13 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.79)[subject];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272619-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maheshb@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD43F3478CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 9:22=E2=80=AFAM Louis Scalbert <louis.scalbert@6win=
d.com> wrote:
>
> Hi everyone,
>
> Le mer. 25 mars 2026 =C3=A0 14:44, Louis Scalbert
> <louis.scalbert@6wind.com> a =C3=A9crit :
> >
> > When an 802.3ad (LACP) bonding interface has no slaves in the
> > collecting/distributing state, the bonding master may still report
> > carrier as up. In this situation, no slave is actually able to transmit
> > or receive traffic.
> >
> I=E2=80=99ve just realized that the issue description is not entirely acc=
urate.
>
> Bonding links that are not in LACP Collecting/Distributing state are
> excluded from traffic
> distribution in favor of those that are. However, if no links are in
> Collecting/Distributing state,
> the kernel considers all links as valid for distributing traffic.
>
> > As a result, upper-layer daemons consider the interface operational
> > while traffic is effectively blackholed.
>
> There are situations where traffic is not blackholed.
>
> For example, a Linux machine A is connected to machine B using two
> aggregated links.
> On A, LACP is configured, but not on B. As a result, LACP will not
> reach the Collecting/Distributing
> state since B does not send LACP frames. However, the bonding
> interface will still be up on both
> sides, and traffic can be exchanged.
>
> This behavior is, of course, not compliant with the LACP (802.3ad)
> standard, but applying this fix
> as-is could introduce regressions in some setups. Under normal
> conditions, having no Collecting /
> Distributing links means that no interfaces are operational for
> handling traffic - that is precisely the
> purpose of using LACP.
>
The legacy behavior is to "maintain connectivity" by selecting a
functioning aggregator, as long as there are no link events. It's
crucial to maintain this legacy behavior.

> I will publish a new version with a knob to enforce compliance with
> the LACP standard. It will be
> disabled by default for backward compatibility.
>
> What do you think of "lacp_strict" or "lacp_enforce" ?
>
I don't have any specific preference for the name, but the default
value must comply with the legacy behavior.

> >
> > Fix this by asserting carrier only when at least 'min_links' slaves are
> > in the collecting/distributing state (or collecting only if the
> > coupled_control default behavior is disabled).
> >
> > Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
> > Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
> > ---
> >  drivers/net/bonding/bond_3ad.c | 24 ++++++++++++++++++++++--
> >  1 file changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_=
3ad.c
> > index af7f74cfdc08..6d3613755d45 100644
> > --- a/drivers/net/bonding/bond_3ad.c
> > +++ b/drivers/net/bonding/bond_3ad.c
> > @@ -745,6 +745,22 @@ static void __set_agg_ports_ready(struct aggregato=
r *aggregator, int val)
> >         }
> >  }
> >
> > +static int __agg_valid_ports(struct aggregator *agg)
> > +{
> > +       struct port *port;
> > +       int valid =3D 0;
> > +
> > +       for (port =3D agg->lag_ports; port;
> > +            port =3D port->next_port_in_aggregator) {
> > +               if (port->actor_oper_port_state & LACP_STATE_COLLECTING=
 &&
> > +                   (!port->slave->bond->params.coupled_control ||
> > +                    port->actor_oper_port_state & LACP_STATE_DISTRIBUT=
ING))
> > +                       valid++;
> > +       }
> > +
> > +       return valid;
> > +}
> > +
> >  static int __agg_active_ports(struct aggregator *agg)
> >  {
> >         struct port *port;
> > @@ -2120,6 +2136,7 @@ static void ad_enable_collecting_distributing(str=
uct port *port,
> >                           port->actor_port_number,
> >                           port->aggregator->aggregator_identifier);
> >                 __enable_port(port);
> > +               bond_3ad_set_carrier(port->slave->bond);
> >                 /* Slave array needs update */
> >                 *update_slave_arr =3D true;
> >                 /* Should notify peers if possible */
> > @@ -2141,6 +2158,7 @@ static void ad_disable_collecting_distributing(st=
ruct port *port,
> >                           port->actor_port_number,
> >                           port->aggregator->aggregator_identifier);
> >                 __disable_port(port);
> > +               bond_3ad_set_carrier(port->slave->bond);
> >                 /* Slave array needs an update */
> >                 *update_slave_arr =3D true;
> >         }
> > @@ -2819,8 +2837,10 @@ int bond_3ad_set_carrier(struct bonding *bond)
> >         }
> >         active =3D __get_active_agg(&(SLAVE_AD_INFO(first_slave)->aggre=
gator));
> >         if (active) {
> > -               /* are enough slaves available to consider link up? */
> > -               if (__agg_active_ports(active) < bond->params.min_links=
) {
> > +               /* are enough slaves in collecting (and distributing) s=
tate to consider
> > +                * link up?
> > +                */
> > +               if (__agg_valid_ports(active) < bond->params.min_links)=
 {
> >                         if (netif_carrier_ok(bond->dev)) {
> >                                 netif_carrier_off(bond->dev);
> >                                 goto out;
> > --
> > 2.39.2
> >
>

