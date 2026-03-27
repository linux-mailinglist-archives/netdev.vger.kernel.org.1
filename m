Return-Path: <netdev+bounces-272616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKH0G9euxmmiNgUAu9opvQ
	(envelope-from <netdev+bounces-272616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 17:22:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B653475D5
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 17:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ABB8315D9F6
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7E4347530;
	Fri, 27 Mar 2026 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="DFy4uEAn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6525C344DBE
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628213; cv=pass; b=q0rGaju4oXAAOmyBn7F6Q7ZDkd1rD/wF+cap0lkYgIf9H+xMuMu4vbGEI5hv0261+Z/Rb+G0XF9T5ap3z3Af5q5+xYmPfgpd+iALRLOgd0qV23NX/GaGr+G3/DGixUJLJCS0acpJr+Zvk96EzNtsXi1Qwnrttd8vO7k6gPWy/oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628213; c=relaxed/simple;
	bh=frz4p06SnBq2LbkdgMPdF69AiDSG1rVy9h0kmRJdqeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esZOKioFWHgjNJW7+Q3BnfwqPX8CJ7JBkk2s5dGFjNCxnQSEJk7paHGnbNN90BTbMAuE4RVdx7MaBdkMXtRYNR8mE7iE4DKSoDU1RVR8dg/whtH2qZ7GW/yOQEsqapnYHG5JTCAp3ud8ff4ZYRK67Bx0sueU2k/wwPUONeB9Tsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=DFy4uEAn; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9358bc9c50so321729766b.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 09:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774628209; cv=none;
        d=google.com; s=arc-20240605;
        b=QSTxPbPGFhCnBbANOWFfUYABOiBMMILpHUmki/Nsh6NSEon092o+VplrytoHtvhG5e
         dj1Q1wtbTnwBKgZH4hNfKFmBF53MGHO0rcVZUmcbSMOoiyApjNndXDBEFggLbps0GiWU
         p7fpChBsy9AKDO+EtL4/ZDXoVpHPsuhc5+hXh88YS8Y8KkN1rY4dZKlu6RZid7OdCmZV
         7+HHUBuDZrz+nwTGmDYH8by0YR1gtBdXKQcWksWZR06ZCPICPPUCy8smr5yL9coc9CL6
         kLVsaGEuzdMdQ49rQN5+I8Da7qxyyzOOmYzM7dOsk18muEuhwznI0z1TG8//bSHLb7xC
         /A4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZWBSGmgMx2VtQsPuBnSVVG+3OGW1QLkqIN3lGz/DvMk=;
        fh=4odBnGn8JM0FdZN1urASS1qicWjbfyLYdIkOi+5S4tg=;
        b=WU2DBqLkgSXFaT/tlOkxL3zbrVK/Agy8I85hm2HeJiDNotgyiGRCN9N/PbOnSjChqk
         x8F4YJVzvokA9nSjwmxcD147Hnuy9+3iIrnqRtozUoj3YDxNSzVKM2KNKV0Xn/Q/VQbZ
         i5T7EdCFwRp2c4ayB5cmy78BpdaZzU+NkKGnMCkGTf1kdelX0mAIsA/MYMcXd6R/cpri
         3CLgF8995HYG41sBotYb7q/9YrUAaORq3n5mEyDUz6yOGfMLLWAnzGinlIhtdJxgPd5U
         eGy+YkaClnsqqVKXDAGh6HYfGmfKnh1OXigl6ELHUGCzxn/dc+9hGsvEgIwAwAnUmg5F
         SUVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774628209; x=1775233009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWBSGmgMx2VtQsPuBnSVVG+3OGW1QLkqIN3lGz/DvMk=;
        b=DFy4uEAnTlnFHKKUHkBYeA9chXDxANDkjgQJjc1mGUnvk4lzd8F63TY3Yov3FJNJ6D
         x6CiT4w91n4oqLC3gZ9NEafT05O7Eupppi/ePWoO9/Z1rUeb/kpPK9+wTxQ1ikWAJxv+
         hPCy4lQh9EgGi5f7Go5vGprQT3Vgh4k3SNeEGHZ0QopHK/i/58TtIUd0J0JLGNBLGTu+
         AWpT9qmDOX6oGtAoexjl4eHY9d5ipt8yPIR+5YI5D6RvZqc4M4bT/RNrT9qSxKsXk0O4
         excuqyeZMiKdiXmcsvlHGth4oY30vnMdLHMaFMu8ZPrTK9RMXoAcEKpe3Fpkk/ckKZxJ
         SBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774628209; x=1775233009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZWBSGmgMx2VtQsPuBnSVVG+3OGW1QLkqIN3lGz/DvMk=;
        b=h3EvoupgrXOxMyCPKbldKzcBPfKsMKebmVA+cHZNfzNDS25zLhKAMVWhyA4xfiLhLF
         +ri96qjAXDQOQMGrU27+Vyli/0Fyn7WLkfz34F3d7gg8PzxCIQ0mr1pagUIDhDVCO36b
         YN5kFXKnvJnZKzIM+OiXiwY5E4HKVRM6cOehu4YvT8cIvmXWc9dPyCPFQKULYQI9bOws
         pZa5kQbeiAlO91hW4PK7oyBJVC9y4B+7Yz58rPkOmi3uj5EdrqRObcgvVxne/9H345tt
         5MiFIy5BNf4Xt+gGTwQbml7pKWT6wzJdNekLUdInv+7BI+z9JVjG7ydB3g0DGRTykOyA
         bdNA==
X-Gm-Message-State: AOJu0YybsrA8kWHO6jn77Tz3mXNANOrbJ1QpkSv6sQkUyNms3oFmgKyo
	Kq9b/K+zplHSgEN/1rjf2tp5LAW2zU4zcv+HfPpFa6ipeu3RWhkbbFzKdGnCaqXtg6CDR3GEdMN
	aNltmKQrMBE8O9j1qYgAGx8xVPGxGT3D77KqFy5r/VMXdWUIGvn6wImPZHQ==
X-Gm-Gg: ATEYQzxg/OxpAG49CF+cRF/t6KxZvBZ4c9j+ujb4/s9mC0JP3BiDqqufXmJe30mLSNw
	wJD8wzbV8nxZ3weKW0J+KiL/gmwDPPN6ne0bnpC9PsmJieIkKz9qhJPxD3UX1u+YTwbPSwRNDD5
	qDLQ3pDXfHPkErGrk8uYoZZAAr0fI0m+s7uzBjrz9Q/w7QnseUElOJQ7s36HgI9gmB9X3WG8sDp
	G3h28RpwbWE88lUOiFSTRjH0adRWjERscCnqdsn35GCGnCmqKQ11DvdMN8llE1hETQZeAWceEN2
	wa8BqA==
X-Received: by 2002:a17:907:809:b0:b88:6164:6421 with SMTP id
 a640c23a62f3a-b9b50351d51mr240512966b.16.1774628209355; Fri, 27 Mar 2026
 09:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325134439.3048615-1-louis.scalbert@6wind.com> <20260325134439.3048615-2-louis.scalbert@6wind.com>
In-Reply-To: <20260325134439.3048615-2-louis.scalbert@6wind.com>
From: Louis Scalbert <louis.scalbert@6wind.com>
Date: Fri, 27 Mar 2026 17:16:38 +0100
X-Gm-Features: AQROBzBRs-WiOd15Hl2riQv8IqvG1MboKmjqbWz1RnhuaaPq0QwngJF8IQOBW8E
Message-ID: <CAJ5u_OcpOGSPYK-EzYeW8LdpJrLd16fGn6zN6cvk+tCjCi+QxA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/3] bonding: 3ad: fix carrier when no valid slaves
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, jv@jvosburgh.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com, andy@greyhouse.net, 
	shemminger@vyatta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	TAGGED_FROM(0.00)[bounces-272616-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C6B653475D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi everyone,

Le mer. 25 mars 2026 =C3=A0 14:44, Louis Scalbert
<louis.scalbert@6wind.com> a =C3=A9crit :
>
> When an 802.3ad (LACP) bonding interface has no slaves in the
> collecting/distributing state, the bonding master may still report
> carrier as up. In this situation, no slave is actually able to transmit
> or receive traffic.
>
I=E2=80=99ve just realized that the issue description is not entirely accur=
ate.

Bonding links that are not in LACP Collecting/Distributing state are
excluded from traffic
distribution in favor of those that are. However, if no links are in
Collecting/Distributing state,
the kernel considers all links as valid for distributing traffic.

> As a result, upper-layer daemons consider the interface operational
> while traffic is effectively blackholed.

There are situations where traffic is not blackholed.

For example, a Linux machine A is connected to machine B using two
aggregated links.
On A, LACP is configured, but not on B. As a result, LACP will not
reach the Collecting/Distributing
state since B does not send LACP frames. However, the bonding
interface will still be up on both
sides, and traffic can be exchanged.

This behavior is, of course, not compliant with the LACP (802.3ad)
standard, but applying this fix
as-is could introduce regressions in some setups. Under normal
conditions, having no Collecting /
Distributing links means that no interfaces are operational for
handling traffic - that is precisely the
purpose of using LACP.

I will publish a new version with a knob to enforce compliance with
the LACP standard. It will be
disabled by default for backward compatibility.

What do you think of "lacp_strict" or "lacp_enforce" ?

>
> Fix this by asserting carrier only when at least 'min_links' slaves are
> in the collecting/distributing state (or collecting only if the
> coupled_control default behavior is disabled).
>
> Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
> Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
> ---
>  drivers/net/bonding/bond_3ad.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
> index af7f74cfdc08..6d3613755d45 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -745,6 +745,22 @@ static void __set_agg_ports_ready(struct aggregator =
*aggregator, int val)
>         }
>  }
>
> +static int __agg_valid_ports(struct aggregator *agg)
> +{
> +       struct port *port;
> +       int valid =3D 0;
> +
> +       for (port =3D agg->lag_ports; port;
> +            port =3D port->next_port_in_aggregator) {
> +               if (port->actor_oper_port_state & LACP_STATE_COLLECTING &=
&
> +                   (!port->slave->bond->params.coupled_control ||
> +                    port->actor_oper_port_state & LACP_STATE_DISTRIBUTIN=
G))
> +                       valid++;
> +       }
> +
> +       return valid;
> +}
> +
>  static int __agg_active_ports(struct aggregator *agg)
>  {
>         struct port *port;
> @@ -2120,6 +2136,7 @@ static void ad_enable_collecting_distributing(struc=
t port *port,
>                           port->actor_port_number,
>                           port->aggregator->aggregator_identifier);
>                 __enable_port(port);
> +               bond_3ad_set_carrier(port->slave->bond);
>                 /* Slave array needs update */
>                 *update_slave_arr =3D true;
>                 /* Should notify peers if possible */
> @@ -2141,6 +2158,7 @@ static void ad_disable_collecting_distributing(stru=
ct port *port,
>                           port->actor_port_number,
>                           port->aggregator->aggregator_identifier);
>                 __disable_port(port);
> +               bond_3ad_set_carrier(port->slave->bond);
>                 /* Slave array needs an update */
>                 *update_slave_arr =3D true;
>         }
> @@ -2819,8 +2837,10 @@ int bond_3ad_set_carrier(struct bonding *bond)
>         }
>         active =3D __get_active_agg(&(SLAVE_AD_INFO(first_slave)->aggrega=
tor));
>         if (active) {
> -               /* are enough slaves available to consider link up? */
> -               if (__agg_active_ports(active) < bond->params.min_links) =
{
> +               /* are enough slaves in collecting (and distributing) sta=
te to consider
> +                * link up?
> +                */
> +               if (__agg_valid_ports(active) < bond->params.min_links) {
>                         if (netif_carrier_ok(bond->dev)) {
>                                 netif_carrier_off(bond->dev);
>                                 goto out;
> --
> 2.39.2
>

