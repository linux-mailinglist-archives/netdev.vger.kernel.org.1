Return-Path: <netdev+bounces-269924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEL8EuVVvWlr8gIAu9opvQ
	(envelope-from <netdev+bounces-269924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:12:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A31FB2DBA69
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB01330B010D
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844412FF669;
	Fri, 20 Mar 2026 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="PLkGtpCP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1511031AF1B
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015629; cv=pass; b=hoGSwfBt9irvB6lJNKeDKamAIwWK2WzCcBu6FMVUSC3ft0jt1+jxF1pU5K40vgxYpKGTSZ5vWg/X5lQa64ag1SMh3bpYF+IdqNQJFSiL/T3xYjD/G/L+ZSikdClq0pT4gZ/RbMJo73R4Dm1x+dH7c3alZFH4UsTog7hXw3rhvsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015629; c=relaxed/simple;
	bh=F6EMXv5BofljJPrsFVPkQRT7nWuYU82mXPfN2FK5lCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAJePiUhBy6ZRLc1PFDSKVqF0QyulSINGSFaZga2emANQOcMSrKU/XUL4LzK2NNEK5S+nxxYJ1/XRIl6ORsAVOysKVLgxAdbx9cy9fquFr4vDggfWJ/7Gtf3GBKzDaIS8g992QOpOGaQHHJ1v+S2TQDAfNAMTN8NQpHzJwL8luk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=PLkGtpCP; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b97e6e48b24so111479466b.2
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:07:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774015625; cv=none;
        d=google.com; s=arc-20240605;
        b=INl+wNOgnC1lZzMlIPPW0CRhPtNU4XqfKtqBpnUk8HAilLJjpMWbp6L3fRoIa7KFsk
         JkdI7e+Sp3VjOVP7eAUhI3xZ9q39w6fVkJA/9w2Sj4h6LPrMEtIu0DLFPNcrwp6/Eezq
         SP3lLLtnjHcblCtjsrIK0LK19Sa+cX8P2JU/+UBewS3qeChtjxV5WvsYq0bRScK/W5J0
         4xiw/IJ5ZfsriRnYOutduhh3+vqOso6ZGc3Ojfq+xl1FD1w+gWC/TtE6LnIQEukq7wEa
         OICG/25OysgkReC9AICgolCytU5cOhtv7cokTFVEyrRV0eeL644D8J3qwhBSlVuWamfR
         wC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lMIG1U/5jE1WqakFRhwedPbyTfCu6rH084V6lIaY+jQ=;
        fh=sX2BpxthOmpF3lc0gPhGYZGab2rPsYAl+LXD+fnUZF8=;
        b=EJKq8vCnmyhdTB5yRFFBwTtxyJQaP/ep5ExkAg5PfJe7wiVAs5OifMYhnrSOzquP8R
         FqikaZr2NfFS8sbY8+kdKhW08aJ6hsCQsG/+FObtD7yTJGfIZTLHGgMWxf01OeqKAcTd
         m5sh1SOb86cqx18Hsec2l9NRYkqMpNkdhws+UCwf21l1hKDxs5CWoRHPPrJp2ny98iJ/
         dcoVg9Qz9pmU0kfnjDSjAphWcE2rspPktAY+a1C/Lf/uEsh0NVRPz3WfM+CNIeXzI/Np
         lIYejPC1nAu/9oNZa1zC3tDmmeq8Ywf539e39oKH95fo92FHwbQ7pxGTvgh0bVNlNCiG
         iCmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774015625; x=1774620425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMIG1U/5jE1WqakFRhwedPbyTfCu6rH084V6lIaY+jQ=;
        b=PLkGtpCPHSQI/Oulhwi0nz7HUENH4YFaRw7+Vahq486tt1QW+kRNivj2wCwLryfBCq
         hnJ4r20pWEH1qFAje4dI3I3ZPAORJW+Ux6n25n3e4ks44dUmSU+LkCo75EtOF+BfAiHq
         sXW17zWXM64OYE7iqR6Vb+DgTiOLbKYNSaiV6Ax4eKZRsS8j4aAW7kRe8wlivlg5DhER
         2DN0f56UCJxUnyzquDBrfBQJxKPZZQNZ2TRz895AldgKbonDCnAsJ2ZBIAdtWB0Xl9BG
         1I/aCq4P2G6f47iziGPO9CucGI3zKSTelbjH6SbZHPZv/UNycwXyVYgdAQ7nkWDyywNK
         7LSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015625; x=1774620425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lMIG1U/5jE1WqakFRhwedPbyTfCu6rH084V6lIaY+jQ=;
        b=WGSwYMonhjjTujJDI7RCs2I39WZgvOfHSvUIeP9ITHCXJEAXl5S9vM8EVNUe4yDvKa
         Vcpo08JDrHvBMUtzqalNkaZYJYDBvt4T4XSeTbNaWg3dhwno4sYjkyAIPHwePQgaR5mN
         Swa35lkZzo04tSSlkvfLh65supBVE7uFuVfSDxmVkWL4jjazNRl53zn/uh9kf8T4TeHM
         EHQ05lBZcfNKLwe4ynZ7ReXt0ycB15RLhVuXW096csEz1hby+7K4/M7ACs354xGbxE2S
         jQbUMdZE3j4z80FIPBdLvA0fuAhWB+IR4eJxO8uCrvvNRCPJ/TEEsHWDMobKiB8D6azh
         BobQ==
X-Gm-Message-State: AOJu0Yxe4BfzpWYaT5bTNYJ+O57ZA59Z4nKCeZYZdSWA1b94MDvxZbJP
	03FfFU4SdTEfu2dg8WXrtyk4LnisXqNyG5xFQJ9Oml8tTjyYDTvePbtaptGMdRIE7vyusXyNnVu
	clWvPUd4SsCJJEWbVG3aUF5yDXqVl4XLFt7WVf1mu1Q==
X-Gm-Gg: ATEYQzyL6j2A+i5+OvJqe/a3MATPeyWMc7+XlpyD60T4Yriky/ay9b43Swb0lE9zKpW
	ZBhgQ+I5GfpuE8kP3f9/IpVZKxqiuiH8t0pI4o3JeaGvuyMlIcTETrXK9zfERDpPwhEFpm2nMb6
	FaYI6robUmn2cD/YFZmsQSUamgE8mBBV2WxlwLiMCMm5jT/9qE3+zrfQERNda778o8K4JzoSsQD
	HfPihd4K+LTTlnwqeNCmVwnUvjZs0jCzK1KI9wbJopJp/JoKmP8YiT3ijAUwFdFqPZIEfXfk6y/
	DzGM8w==
X-Received: by 2002:a17:906:d8a:b0:b97:a0d6:f6b2 with SMTP id
 a640c23a62f3a-b982f220f20mr197539566b.4.1774015624839; Fri, 20 Mar 2026
 07:07:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316131838.3257889-1-louis.scalbert@6wind.com>
 <20260316131838.3257889-2-louis.scalbert@6wind.com> <1943614.1773882866@famine>
In-Reply-To: <1943614.1773882866@famine>
From: Louis Scalbert <louis.scalbert@6wind.com>
Date: Fri, 20 Mar 2026 15:06:54 +0100
X-Gm-Features: AaiRm50ADX3HuIpx0i-A_7effFu91htL3ae5L8Qa0oJibbE7h_MPucNX25GXYzc
Message-ID: <CAJ5u_OdRg1fuiPvBc2JebgT7wNHg_bXat+ERTuai49tdnLhyPA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] bonding: 3ad: fix carrier when no valid slaves
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, fbl@redhat.com, andy@greyhouse.net, shemminger@vyatta.com, 
	andrew+netdev@lunn.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269924-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.940];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,6wind.com:dkim,6wind.com:email,jvosburgh.net:email]
X-Rspamd-Queue-Id: A31FB2DBA69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le jeu. 19 mars 2026 =C3=A0 02:14, Jay Vosburgh <jv@jvosburgh.net> a =C3=A9=
crit :
>
> Louis Scalbert <louis.scalbert@6wind.com> wrote:
>
> >When an 802.3ad (LACP) bonding interface has no slaves in the
> >collecting/distributing state, the bonding master may still report
> >carrier as up. In this situation, no slave is actually able to transmit
> >or receive traffic.
> >
> >As a result, upper-layer daemons consider the interface operational
> >while traffic is effectively blackholed.
> >
> >Fix this by asserting carrier only when at least 'min_links' slaves are
> >in the collecting/distributing state (or collecting only if the
> >coupled_control default behavior is disabled).
> >
> >Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
> >Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
> >---
> > drivers/net/bonding/bond_3ad.c | 22 ++++++++++++++++++++--
> > 1 file changed, 20 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3=
ad.c
> >index af7f74cfdc08..7d7661972c5e 100644
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
> >+      }
> >+
> >+      return valid;
> >+}
>
>         Did you consider instead rolling the COLLECTING / DISTRIBUTING
> test into __agg_active_ports?  It appears at first glance that the users
> of __agg_active_ports would do the right thing with the "able to
> communicate" logic.

Yes, I did, but it is not relevant here. In those other places, the code is
meant to count enabled ports, not ports in the COLLECTING/DISTRIBUTING stat=
e.

>
>         As an example, logically the aggregator selection logic should
> count "usable" ports, not simply ports that are enabled and may or may
> not be usable.

If by usable you mean COLLECTING / DISTRIBUTING, that cannot work, because =
the
aggregator selection logic runs before the mux state machine that performs =
the
transition to COLLECTING / DISTRIBUTING. In bond_3ad_state_machine_handler(=
),
ad_port_selection_logic() is called before ad_mux_machine().

This ordering is correct. The aggregator selection logic is responsible for
selecting the best set of ports among the configured enslaved ports. Only t=
he
ports selected at this stage are allowed to leave the WAITING mux state and
later transition to ATTACHED, then to COLLECTING / DISTRIBUTING.

ad_agg_selection_test() uses __agg_active_ports() to compare the number of
enabled ports in the current aggregator and in a candidate one, then select=
s
the aggregator with the highest number of enabled ports. Using the number o=
f
COLLECTING / DISTRIBUTING ports instead would not make sense, because only =
the
currently selected aggregator can already have ports in that state.

__agg_active_ports() callers and sub-callers are:
  - __bond_3ad_get_active_agg_info
    =3D> used to display the enabled ports in /proc/net/bonding/
    =3D> this is correct
  -  __get_agg_bandwidth
    - ad_agg_selection_test
    =3D> compute the total bandwidth available on the enabled ports. Correc=
t
  - ad_agg_selection_test
    - called by ad_agg_selection_logic
  - ad_agg_selection_logic
    - ad_port_selection_logic
      - bond_3ad_state_machine_handler
    - bond_3ad_handle_link_change
    - bond_3ad_state_machine_handler
    - bond_3ad_unbind_slave
    =3D> the selection logic takes into account the enabled link. Correct
  - bond_3ad_unbind_slave
    =3D> When a port is removed from the bond, check whether its aggregator=
 still
       has any enabled ports. If none remain and the aggregator was active,
       invoke the aggregator selection logic. This behavior is correct.

Best regards,

Louis Scalbert

>
>         -J
>
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
> >@@ -2819,8 +2837,8 @@ int bond_3ad_set_carrier(struct bonding *bond)
> >       }
> >       active =3D __get_active_agg(&(SLAVE_AD_INFO(first_slave)->aggrega=
tor));
> >       if (active) {
> >-              /* are enough slaves available to consider link up? */
> >-              if (__agg_active_ports(active) < bond->params.min_links) =
{
> >+              /* are enough slaves in collecting (and distributing) sta=
te to consider link up? */
> >+              if (__agg_valid_ports(active) < bond->params.min_links) {
> >                       if (netif_carrier_ok(bond->dev)) {
> >                               netif_carrier_off(bond->dev);
> >                               goto out;
> >--
> >2.39.2
> >
>
> ---
>         -Jay Vosburgh, jv@jvosburgh.net

