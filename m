Return-Path: <netdev+bounces-278852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGxlGKvR32kNZQAAu9opvQ
	(envelope-from <netdev+bounces-278852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 19:58:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F6F406F00
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 19:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72671300A131
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53FF3D5662;
	Wed, 15 Apr 2026 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="jLky/l8Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354F63E3C63
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776275648; cv=pass; b=O4d7xYViY7MYWHwGb0Tjjn9bkV59FfKe1OdYraUJY1yn/8LhBCnRnAiiBFBOk6jACrgTcQKYDgs3PAkmBGkeX/axrr7poRJy82tOGhUZ3EfhfkQdCk45X5Phq70GmYWzP3uSj/Qpf5m7QLjkAgp8BgggoEgk6SOD09GPxKuOIAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776275648; c=relaxed/simple;
	bh=Z5joNXyR+M8aT9cw64pUTn9PMB96Gm9eaO2VJUaw/vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btp1sLRAtqwDX95MZEVlsRJx/mRI9k47mYGsdNocvxoXvjhggPlAZSD035Y9mJL6FRZibZupNIk8rZ+WewwRDxNQfSq6NpfZ8gOCOgb7ltcpHfXTScGfpgR44e56V8ald9XsE0+guxTb0yb+OZcexehR1ywTq75wC8yAfm+F4Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=jLky/l8Y; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-671ff4b716cso3732966a12.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 10:54:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776275643; cv=none;
        d=google.com; s=arc-20240605;
        b=DK7GLrv+MGVkyuewC6Kvy/2SXjV/ArtN/mEVwJTwTI3nkQUQ0G+fKqLf/J1AQBCzaf
         odnSllbPf8Y7GGYl//wtO6mcuy2G5O2qqg2BSh6l6fEzZFyhn3ZytuanEmhr1t7I2w7o
         MyTvFpMLjewUTB2fh02bua/OQxkzT+BwxTQGZqCiKJ7wmqOTGy+qlNjmPsHTy2wz8EB7
         H7lg5v9cKx0TarRBIF+fiIONWi9RxX+rIZ7nJsB5bO4bLK5A+iOByT7OfRckxzVXv0Ns
         +DrMMXvv+0Ydtwi1d6yHZeeacgE/MxyC0zCIfmAd7nN9uDG+6kPaQOWt7Gt9fs6OpZtP
         yWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q8ih2c68QZZtOd2V+FBPE0tMjfOyUKfv5mMF5/lHzZQ=;
        fh=8i4BkJ7A2sbsgM1+Fe68SjLDkqmJfGNb+pxYd/lDi1E=;
        b=DwZw7B6AEswEoZeNtELzcHCzG8ebFtE6aninbnVoikAinZg0zP0wDYy8keCgMziXD5
         yS9NMjLH7tH8voXooXzSK64r+0hx/Hy3gxXZZDc03RIgrBr+4+D6wRMBW+jiXLsFZ52b
         9qKSnRz0B2kVWF7+YPFtZeS8YqxfdtphRvqiBNH7S1H/LpvBOVleKMKAbU/QsL0Z2gw3
         ak+JmwF5YBQljE6q7lsPlQKPrR2GJBzMzQ1nzpipON29eZ7dDpYmw4wkkdE4XiU0SN2L
         O1U0BIGTQmHFj0MaBGP+l8/i/c6bI3hmtXjBA8oyxTpztmZdiU4y0QsIkgbtzlwhkJeO
         w5TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1776275643; x=1776880443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8ih2c68QZZtOd2V+FBPE0tMjfOyUKfv5mMF5/lHzZQ=;
        b=jLky/l8Y8bEog1Mh1ulBSAYL15JVtrVYNwvqIkuImrsWEIB6yZeVGyKypAGM/K4+SL
         ZBJq0li/TZT/9tlRyQJBNIEDEggmwAn8UfdmLK8LoAslHWwMTZ91mM2oAoKf933qjK/o
         7ebY8kreoAp8eSibM52yC0uAmh4btFxXSXsj1TbMzAtNHPSJGRHGyF7AogJMGY4QFL1j
         j9JCIdFpH+DL2EYS0catj5BSfiJdXqmIMXeLAkX7Ssv1oS7GHW7v52c1jfgcNPvyK+Rm
         D0k6EOmp0J89F7wydyBoNgIrm2u8A1Dcys9LROoDt2VvB/gunXtG1h/SDlJODdC3NYbK
         Dh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776275643; x=1776880443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q8ih2c68QZZtOd2V+FBPE0tMjfOyUKfv5mMF5/lHzZQ=;
        b=SZRAHPh3DbXtXoGE2ZoOP2tOKCIMysUYGo26ESgks7dAezgzU78M1iIlm2DsX6dZxh
         Dp7YQmkjVMBarTVA7vwOuZ99F7TilV6tcvTxp9qTj9nvCDw8NHPFb24Ta5cwwMfGsAWd
         YFXkhjSkg9PC9dR9WPJH9Ra7X7mtrVPmBuzD0TYe3zCz8XUv192lJyHTn4dQefRM0xAH
         M+xnnyxhtv+pXxtjh+UuZ2pV2nPK3zjODr481D0YUVZ1vxOFos23i201Z6f+KvwKPELL
         MA6zV498Qea6Kp7Lv60AgVI3dMi+BQS9aFWoYqyzg1xQBS34YicyMvMei6vaRbRCTZaT
         vtVg==
X-Gm-Message-State: AOJu0Yx1kBma+w1itYp0Pi0t4fGl/1lCu6CHmT9E0eVN8/TP78058XdF
	pLzVoovg8NDiZSh80aZKrvKTqmaH3C9dvu6dNdO7aFMZ9pJWhDx45jSNFTXE792WYn/X9UiBMOL
	UMnXBtHtFqS1Vjqi18zOX1T4CjTK+vBLU17g8wOH3FRusfu/RVybAy1Kuag==
X-Gm-Gg: AeBDiesG/lHmhlFvJYucMRppHVPZ4aQGUgasH5vVJ3QlikAGWtSk2kyyVqa5ZwUt3uf
	FjR89R1gI/pnS2Fjq+Fj1Exn1jmVMRpj0EWkNcZmdUCCKBTbzOSq2qKazxvOz8OkQxkX2JeOx0q
	95qQe4C810hjYlzu7dGOPghcPfUuHq9BMAd4dvMnyP/KA7zuXkpaPwwxbgS2jGVpJLkxaQhgcdx
	DZ0kvhos/3BYdHEkbyVJuIJIkz9wnwkeHdk40vTpMZ3/R18X0CCKCw/kQdOwm0bYlhSc6KkTG9W
	Nqscpm8CbLeA2Kj7BqT5iNS20aX59r4dZvXGOJ1D
X-Received: by 2002:a17:907:3d9e:b0:b9d:ed70:6b5e with SMTP id
 a640c23a62f3a-b9ded706c0amr667704266b.1.1776275643222; Wed, 15 Apr 2026
 10:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408152353.276204-1-louis.scalbert@6wind.com>
 <20260408152353.276204-3-louis.scalbert@6wind.com> <707939.1776099707@famine>
In-Reply-To: <707939.1776099707@famine>
From: Louis Scalbert <louis.scalbert@6wind.com>
Date: Wed, 15 Apr 2026 19:53:50 +0200
X-Gm-Features: AQROBzCfA-UWlhBpYV8KZAQbYWixRBHN-yFf_bKcrP5IVmyPOWOlgJKQ4gdRB6c
Message-ID: <CAJ5u_OdK8kw5+7ZV0WwQHZOF5w+8rHXwgvsB5CDm5Ha0oSd0cA@mail.gmail.com>
Subject: Re: [PATCH net v3 2/5] bonding: 3ad: fix carrier when no valid slaves
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com, andy@greyhouse.net, 
	shemminger@vyatta.com, maheshb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278852-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jvosburgh.net:email]
X-Rspamd-Queue-Id: C3F6F406F00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Jay,

Thank you very much for this detailed review.

Le lun. 13 avr. 2026 =C3=A0 19:01, Jay Vosburgh <jv@jvosburgh.net> a =C3=A9=
crit :
>
> Louis Scalbert <louis.scalbert@6wind.com> wrote:
>
> >Apply the "lacp_fallback" configuration from the previous commit.
> >
> >"lacp_fallback" mode "strict" asserts that the bonding master carrier
> >only when at least 'min_links' slaves are in the collecting/distributing
> >state (or collecting only if the coupled_control default behavior is
> >disabled).
> >
> >Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
> >Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
> >---
> > drivers/net/bonding/bond_3ad.c     | 26 ++++++++++++++++++++++++--
> > drivers/net/bonding/bond_options.c |  1 +
> > 2 files changed, 25 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3=
ad.c
> >index af7f74cfdc08..b79a76296966 100644
> >--- a/drivers/net/bonding/bond_3ad.c
> >+++ b/drivers/net/bonding/bond_3ad.c
> >@@ -745,6 +745,22 @@ static void __set_agg_ports_ready(struct aggregator=
 *aggregator, int val)
> >       }
> > }
> >
> >+static int __agg_valid_ports(struct aggregator *agg)
> >+{
> >+      struct port *port;
> >+      int valid =3D 0;
> >+
> >+      for (port =3D agg->lag_ports; port;
> >+           port =3D port->next_port_in_aggregator) {
> >+              if (port->actor_oper_port_state & LACP_STATE_COLLECTING &=
&
> >+                  (!port->slave->bond->params.coupled_control ||
> >+                   port->actor_oper_port_state & LACP_STATE_DISTRIBUTIN=
G))
> >+                      valid++;
>
>         Do we need to test coupled_control?  I.e., can the test be

With coupled_control enabled (default), the actor allows traffic from
the partner only when it reaches both the COLLECTING and DISTRIBUTING
states, i.e., in the AD_MUX_COLLECTING_DISTRIBUTING Mux state.

With coupled_control disabled, the actor allows traffic from the
partner as soon as it reaches the COLLECTING state, regardless of the
DISTRIBUTING flag. In this case, COLLECTING is set in the
AD_MUX_COLLECTING state, while DISTRIBUTING is only set later in the
AD_MUX_DISTRIBUTING state.

From the perspective of upper-layer processes, a carrier up state
indicates that the link is fully operational and capable of both
collecting and distributing traffic. These processes are not aware of
the distinction between COLLECTING and COLLECTING & DISTRIBUTING
states.

>
>                 if ((port->actor_oper_port_state & LACP_STATE_COLLECTING)=
 &&
>                     (port->actor_oper_port_state & LACP_STATE_DISTRIBUTIN=
G))
>

If we want to allow collection to start without waiting for
distribution to be enabled, then the carrier must be asserted as soon
as the COLLECTING state is reached.
In that case, this test would not be valid.

In practice, I can only test for LACP_STATE_COLLECTING, because
LACP_STATE_DISTRIBUTING is always set together with
LACP_STATE_COLLECTING.

>         To my reading, ad_mux_machine will set _COLLECTING and
> _DISTRIBUTING appropriately regardless of the coupled_control selection.

I don't agree. See:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/net/bonding/bond_3ad.c?id=3Dv7.0#n1090
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/net/bonding/bond_3ad.c?id=3Dv7.0#n1202
>
> >+      }
> >+
> >+      return valid;
> >+}
> >+
> > static int __agg_active_ports(struct aggregator *agg)
> > {
> >       struct port *port;
> >@@ -2120,6 +2136,7 @@ static void ad_enable_collecting_distributing(stru=
ct port *port,
> >                         port->actor_port_number,
> >                         port->aggregator->aggregator_identifier);
> >               __enable_port(port);
> >+              bond_3ad_set_carrier(port->slave->bond);
> >               /* Slave array needs update */
> >               *update_slave_arr =3D true;
> >               /* Should notify peers if possible */
> >@@ -2141,6 +2158,7 @@ static void ad_disable_collecting_distributing(str=
uct port *port,
> >                         port->actor_port_number,
> >                         port->aggregator->aggregator_identifier);
> >               __disable_port(port);
> >+              bond_3ad_set_carrier(port->slave->bond);
> >               /* Slave array needs an update */
> >               *update_slave_arr =3D true;
> >       }
> >@@ -2819,8 +2837,12 @@ int bond_3ad_set_carrier(struct bonding *bond)
> >       }
> >       active =3D __get_active_agg(&(SLAVE_AD_INFO(first_slave)->aggrega=
tor));
> >       if (active) {
> >-              /* are enough slaves available to consider link up? */
> >-              if (__agg_active_ports(active) < bond->params.min_links) =
{
> >+              /* are enough slaves in collecting (and distributing) sta=
te to consider
> >+               * link up?
> >+               */
> >+              if ((bond->params.lacp_fallback ? __agg_valid_ports(activ=
e)
> >+                                      : __agg_active_ports(active)) <
> >+                  bond->params.min_links) {
>
>         I think the original comment is better; if the new option is
> off, it doesn't require collecting / distributing state.
>
>         -J
>
> >                       if (netif_carrier_ok(bond->dev)) {
> >                               netif_carrier_off(bond->dev);
> >                               goto out;
> >diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bo=
nd_options.c
> >index b672b8a881bb..d64a5d2f80b6 100644
> >--- a/drivers/net/bonding/bond_options.c
> >+++ b/drivers/net/bonding/bond_options.c
> >@@ -1706,6 +1706,7 @@ static int bond_option_lacp_fallback_set(struct bo=
nding *bond,
> >       netdev_dbg(bond->dev, "Setting LACP fallback to %s (%llu)\n",
> >                  newval->string, newval->value);
> >       bond->params.lacp_fallback =3D newval->value;
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

