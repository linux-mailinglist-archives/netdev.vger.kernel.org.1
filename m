Return-Path: <netdev+bounces-296953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g+VjG9/HJ2o02AIAu9opvQ
	(envelope-from <netdev+bounces-296953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:59:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBA765D775
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:59:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=XBR59D0f;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296953-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296953-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A803A3047413
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 07:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D8F385D7C;
	Tue,  9 Jun 2026 07:56:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046A53403E5
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 07:56:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991811; cv=pass; b=CJbL++uqh8Zlu9V99jH/rFG6aQ+WAAfZK7AwEnVdzEj4JawlnFXWq3W8Dw3FzfhMDJ6b3R90OsCJzXBx+nyRw2klKHrkNgI865CwbGKJFpw6Hwkf+ON0AFBXnVsfi8c3+8CZJL24/NhW9f+3ngtf+irQDbjs2uDXNluK7tsLyPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991811; c=relaxed/simple;
	bh=D/PjZZW3iigL2V46ozkn8FuHHslvndqsqplywR7ggLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQIe7gBDDYiVYhF8ZmhIw4RIlzt88J1/ZCskwy/5mf6cPuu18mlSAZMvlrBD2ptvLMiyAm6whHNmCbe/y8j9YgGavwJ3q0w1v/kF04tuKQg3qXwYgSKf2AWG0iH6R8qkl3ZvNgtIOBYdPgWRISZ3wKLbEbNmu4+A8rgNZHUo7Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=XBR59D0f; arc=pass smtp.client-ip=209.85.208.47
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68ca6f01079so6139024a12.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 00:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780991808; cv=none;
        d=google.com; s=arc-20240605;
        b=RERiMzlPI7IinS4Brgz0gIHFsGGJhjdBS+jnvEptZJ48Mx0S6Yidqv+PZ2plY6SpvG
         ltNr69QpZwVSOPQEQr/xknihdRNEUCTV1nshgrFPHXgKmeP+rM/VkxdJ0ijloGEZVJus
         T5VztklKIA39BmMrJFs8C1/a3BmvTsq52WRVE330/NCxa+CWwz8vPjx7+aJ1aZJlekMQ
         9Kgan6xb8TXF3mz29eK2AdVE26B0/ehQyY2Tg5RwYL7WFioYFe9apHOlXqbzmugg3bud
         qo3iDn0dyKHB/MKOCIs+uekOmLPAhzN0fSw/hjUSeHkHr/GHsZCxUCXBKftKefeEjIgp
         YRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qlXpqdSIvaDRYi3v4lu9lGZ3LDCxsAMCc0+aS5zAWNo=;
        fh=mXilKxTJGDOPTefkyrsG8lNp05KyOGit73pQqKosc60=;
        b=JHkY6fwl1KnHIhJ4qQbMuyBltffGgsPkkCiLroGdp3SE3J7c0VwJLLPwVzqswvqOYD
         XBAAaYfLAZ3ddtMoHuNEkBVwhxTmzb2hUu/zteqPXEdw6aMNiQnkQ4bYVC3nw6bvIXM/
         +0huyDo0x1w6Elv62VAj0n5qm6IAID3HuS8Lod1VOWLn6w/1d+0f1GDv4fNFzQ43mu+o
         bux+8YYZnGwf/1XjnPuZx4nEQvCaGG4AqIMU6h4fa7hYTJNpsLZfuiheP00mDTvm1lPM
         CKSvCLywl2ejLqc2fk8C7sCiSPbF2Hgx90vE3vbBbQhg5UBQmE+7/YccJkP0eDQC19pv
         aiDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1780991808; x=1781596608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlXpqdSIvaDRYi3v4lu9lGZ3LDCxsAMCc0+aS5zAWNo=;
        b=XBR59D0fkbPldsktNEBlvs8CyNI/zL6LFAQyd15RKqye8TpJ8hu8DZiVHsDgq17luL
         OoCNNf7kdOLqQQSYU+enLXFoneFViu8Y0cEO9xr3dnPMwOdXkYtcyMXjCHhwXCJzGflp
         WT7afGK2S2cm7/JYzYscjdWiiemxvzB2tSGidY55g2by7zguWD0LxEp6jD7V/mYQPifS
         +CltfBUpDWSAc4sVYbszbWiT3irkMELVLj/m9f20lz1uGgCiNE78LtY0bvvM3HOTXA7T
         XvyHBdpJuuWRcJi3hB8+33j7cWI1mtr+b7RARbWPFxVI4O6P/HfVSFqezJvESKaSJAp1
         ec2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991808; x=1781596608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qlXpqdSIvaDRYi3v4lu9lGZ3LDCxsAMCc0+aS5zAWNo=;
        b=pyLAj2UxgA/EPWD3HvFgSM1opJZ5XabG2X/ZEdxF/tG5O6ZD9A6ztaCKzwWdzm0hFS
         zUlE/0f+Kr0VL3kgSfldpDc6xJovcSegiKlx8Hsm8lrcb95cb6IxrtwHeup0lQgjV8vy
         Umyit3w7K5oeFEZThkIsBUKTxdNstdjMFbb07fq+9AqMYqenFzMzRIpRUouTo2kxCYOq
         PXnrrczX7azPn4hXEopT7Idtyr1BsSe2NNP8Ib2BVbxTU3BzlEo6Pg5t2nJPtaZiSn+V
         sbQ3yUBXJrs8SBvpMhuwJyhtJDpw/AJa5rj4VYo+IUD4LCbswq9UyIuQl8HFsIbe5ckg
         Jpzg==
X-Gm-Message-State: AOJu0Yy5R8PGLtayH2alL6hrFeJjmL6MMDB+N8+wsmhtRB5+cG8GuDv1
	zqrAb3hU4rV03DGNuW4nui1tHdJ6BVPu5cski8ka+Hrgv1D47NzVTL6YViYRoa8aLD2SrxyjQYp
	wX0/lw+FeOLgfS2TyXzZqoyrXlB9GQiEyNugqactFog==
X-Gm-Gg: Acq92OGhJlW/Ow6G5O3TbUEel2v3e8Pq2y84MHKM1WiiDY71VVy2rkS/88tpBQQ0+Cd
	cWD1GGjDjneq94sW5XQijyimASE9x4nBkugkk16nIReYKYsZ+2E7olli+t0gAg6edeM6tLaZB8M
	vxyod4CKbZrhe5P1MwVdfgXLkv3WrtdNYTxRAVAqiaD3AZtHCnjtDQqTwZ3RFp/A6ZKaiGhcDWW
	oMX+r8ZqRnW4dHM642zRQTt8daNELBRNdH2bh57KEdd0Smnksys3cirO9deo1Rtbk6WT7u4L1Mb
	UWZF2dHmxzpHDTZrjWrmwP1Gurm6l3ZLk8nu7BjrLkGUCzu8l7f6JjOd4SQ=
X-Received: by 2002:a05:6402:847:b0:68e:4c0:f5b1 with SMTP id
 4fb4d7f45d1cf-68fa4c00598mr7993774a12.2.1780991808218; Tue, 09 Jun 2026
 00:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603150331.1919611-1-louis.scalbert@6wind.com>
 <20260603150331.1919611-5-louis.scalbert@6wind.com> <1041444.1780954642@famine>
In-Reply-To: <1041444.1780954642@famine>
From: Louis Scalbert <louis.scalbert@6wind.com>
Date: Tue, 9 Jun 2026 09:56:37 +0200
X-Gm-Features: AVVi8Cf6lUI8UQ4AsHoThF_evQAKZij1-N3GYYIQdFdAbzFyiH1wiOYxUsAfUS0
Message-ID: <CAJ5u_Of1+eEL4iVe-sWzhOOva6xx3gPCeXeRP4Y3yCqny8=gOg@mail.gmail.com>
Subject: Re: [PATCH net v8 4/6] bonding: 3ad: fix carrier when no usable slaves
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com, andy@greyhouse.net, 
	shemminger@vyatta.com, maheshb@google.com, jonas.gorski@gmail.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296953-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jv@jvosburgh.net,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:fbl@redhat.com,m:andy@greyhouse.net,m:shemminger@vyatta.com,m:maheshb@google.com,m:jonas.gorski@gmail.com,m:horms@kernel.org,m:andrew@lunn.ch,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BCBA765D775

Hello Jay,

Le lun. 8 juin 2026 =C3=A0 23:37, Jay Vosburgh <jv@jvosburgh.net> a =C3=A9c=
rit :
>
> Louis Scalbert <louis.scalbert@6wind.com> wrote:
>
> >Apply the "lacp_strict" configuration from the previous commit.
> >
> >"lacp_strict" mode "on" asserts that the bonding master carrier is up
> >only when at least 'min_links' slaves are in the Collecting_Distributing
> >state.
> >
> >Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
> >Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
> >---
> > drivers/net/bonding/bond_3ad.c     | 26 +++++++++++++++++++++++---
> > drivers/net/bonding/bond_options.c |  1 +
> > 2 files changed, 24 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3=
ad.c
> >index f0aa7d2f2171..98abb2fdd7a6 100644
> >--- a/drivers/net/bonding/bond_3ad.c
> >+++ b/drivers/net/bonding/bond_3ad.c
> >@@ -745,6 +745,21 @@ static void __set_agg_ports_ready(struct aggregator=
 *aggregator, int val)
> >       }
> > }
> >
> >+static int __agg_usable_ports(struct aggregator *agg)
> >+{
> >+      struct port *port;
> >+      int valid =3D 0;
> >+
> >+      for (port =3D agg->lag_ports; port;
> >+           port =3D port->next_port_in_aggregator) {
> >+              if (port->actor_oper_port_state & LACP_STATE_COLLECTING &=
&
> >+                  port->actor_oper_port_state & LACP_STATE_DISTRIBUTING=
)
> >+                      valid++;
> >+      }
> >+
> >+      return valid;
> >+}
> >+
> > static int __agg_active_ports(struct aggregator *agg)
> > {
> >       struct port *port;
> >@@ -1179,10 +1194,10 @@ static void ad_mux_machine(struct port *port, bo=
ol *update_slave_arr)
> >               switch (port->sm_mux_state) {
> >               case AD_MUX_DETACHED:
> >                       port->actor_oper_port_state &=3D ~LACP_STATE_SYNC=
HRONIZATION;
> >-                      ad_disable_collecting_distributing(port,
> >-                                                         update_slave_a=
rr);
> >                       port->actor_oper_port_state &=3D ~LACP_STATE_COLL=
ECTING;
> >                       port->actor_oper_port_state &=3D ~LACP_STATE_DIST=
RIBUTING;
> >+                      ad_disable_collecting_distributing(port,
> >+                                                         update_slave_a=
rr);
>
>         Is there a functional reason to move this?  I don't see anything
> obvious in ad_disable_collecting_distributing() that depends on the
> actor_oper_port_state.  Since you want this to be backported via stable,
> fewer actual changes reduce the chances of an issue applying the patch
> to an older version.

The path is ad_disable_collecting_distributing() ->
bond_3ad_set_carrier() -> __agg_usable_ports(). __agg_usable_ports()
reads port->actor_oper_port_state

It was found by
https://sashiko.dev/#/message/20260526084048.1696544-5-louis.scalbert%406wi=
nd.com

>
>         -J
>
>
> >                       port->ntt =3D true;
> >                       break;
> >               case AD_MUX_WAITING:
> >@@ -2105,6 +2120,7 @@ static void ad_disable_distributing(struct port *p=
ort, bool *update_slave_arr)
> >                         port->actor_port_number,
> >                         aggregator->aggregator_identifier);
> >               __disable_distributing_port(port);
> >+              bond_3ad_set_carrier(port->slave->bond);
> >               /* Slave array needs an update */
> >               *update_slave_arr =3D true;
> >       }
> >@@ -2128,6 +2144,7 @@ static void ad_enable_collecting_distributing(stru=
ct port *port,
> >                         port->actor_port_number,
> >                         aggregator->aggregator_identifier);
> >               __enable_port(port);
> >+              bond_3ad_set_carrier(port->slave->bond);
> >               /* Slave array needs update */
> >               *update_slave_arr =3D true;
> >               /* Should notify peers if possible */
> >@@ -2151,6 +2168,7 @@ static void ad_disable_collecting_distributing(str=
uct port *port,
> >                         port->actor_port_number,
> >                         aggregator->aggregator_identifier);
> >               __disable_port(port);
> >+              bond_3ad_set_carrier(port->slave->bond);
> >               /* Slave array needs an update */
> >               *update_slave_arr =3D true;
> >       }
> >@@ -2830,7 +2848,9 @@ int bond_3ad_set_carrier(struct bonding *bond)
> >       active =3D __get_active_agg(&(SLAVE_AD_INFO(first_slave)->aggrega=
tor));
> >       if (active) {
> >               /* are enough slaves available to consider link up? */
> >-              if (__agg_active_ports(active) < bond->params.min_links) =
{
> >+              if ((bond->params.lacp_strict ? __agg_usable_ports(active=
)
> >+                                      : __agg_active_ports(active)) <
> >+                  bond->params.min_links) {
> >                       if (netif_carrier_ok(bond->dev)) {
> >                               netif_carrier_off(bond->dev);
> >                               goto out;
> >diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bo=
nd_options.c
> >index d358b831df77..94b7b0851f16 100644
> >--- a/drivers/net/bonding/bond_options.c
> >+++ b/drivers/net/bonding/bond_options.c
> >@@ -1706,6 +1706,7 @@ static int bond_option_lacp_strict_set(struct bond=
ing *bond,
> >       netdev_dbg(bond->dev, "Setting LACP fallback to %s (%llu)\n",
> >                  newval->string, newval->value);
> >       bond->params.lacp_strict =3D newval->value;
> >+      bond_3ad_set_carrier(bond);
> >
> >       return 0;
> > }
> >--
> >2.39.2
> >
>
> ---
>         -Jay Vosburgh, jv@jvosburgh.net
best regards,

Louis Scalbert

