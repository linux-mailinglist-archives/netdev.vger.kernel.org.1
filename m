Return-Path: <netdev+bounces-299043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SJCHJXa9LWonjQQAu9opvQ
	(envelope-from <netdev+bounces-299043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:28:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2553F67FA1D
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:28:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="E/bcTQNn";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299043-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299043-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DADF3004908
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8473603D9;
	Sat, 13 Jun 2026 20:28:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E156B3385A1
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:28:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781382515; cv=pass; b=ViNi0nLxD6OmpW3eyky4eVpq2L1UFM4vla6bsjSlHHysn02WuERNT46j//brkd6kGqSab1TLRwsAw7VnBHHf1oN6AVbMS8Q8WCkcVZaRXQ1XswFTKm7w5Al0QA2T/cIBt2oseKVi7Tea2a0Jic+YcM8rC7rEEw2XxFGTfc/QSok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781382515; c=relaxed/simple;
	bh=3WGjAjXNArdO1yzilUP6chOsgUUnCST0+f/suJYITic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNxyftPscgOrVC2xMME/BPXqUEHFrdxhGa5unxR1zaMQR9F5i8lhyyFoAYK/VQehf6COO54Iu/dOeEZ0TvGn/QJ0H58kb3nrU23LNJ1SsAdO6OBvXCYWjiJJuZyF1pD4tD/KeWalZWQhDGlLvKIFXZ1hhSEn4F5DUaQPc5tqNfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/bcTQNn; arc=pass smtp.client-ip=209.85.218.51
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bec4639953dso348782066b.1
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 13:28:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781382512; cv=none;
        d=google.com; s=arc-20240605;
        b=LVd3LdHiv0TYeQ+B7navQ3KzgAIl1qwviy1glUBbbReGfsIRUdeEiC5h8Rc0fb3fGb
         mVxK/pQwMbxL6fb87RSq1Lu/7il2sL6FMJop22iGVpp3SWfWR/a7DeKn/B3ihzIUbjSV
         k9rW3M5u310PVnBCtblh806ArfxEqbv/OU+eOrDupWwSZ8p649NpI01bGdRkn9rEmhdl
         WC9VX/m2QxkJVtVlv2KF3mThdiOCywmdUFKn0Ii0KoQ3Ggn9UflZ57BfTcsrDzilPSHb
         xNxvol3irTn2uqYOtrjZhSD1f17c8Pw1CZOfUqn52ITQNGpb0hW/RnKOike/BzytuuUz
         5POw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XSCYMTARn4AyRio5zxnLgTYAfhKGyX1h6b/Ea1g7z90=;
        fh=H+jcawAJ2Z/hVSS9vzCI1x00Dg/vW1HwOUaIr4bPBmI=;
        b=KOh012XxFhHT9NtSEqXBkrel9wUEKXMia6Q7nMlAYY/jfS2JqTtxuDI0gce2lh4xlB
         UfAP+DiOoAGXBPQaHW6H8ZmY9g6m/ZWsyo6q9YP93IKEJPN08cYMk+lhyQ/n3spQHZxM
         0dynEG1DxPz4o/ThWiOxxhnUfonzh1OxC2QOu/OchHnpLNATOntgiIT/Wh1FPtb9Oqzm
         mCYh2GEYvYsnIyK0IJcpBlTzXbsSiEBRW3d5m4j0t7rN9O5waMz8rU7NIFAyJj1pxqbL
         RDvXmrS6jDpkE58nMum606SV18xkAqxz2g+JEwz5a+0JK7ljVDidaQYMButt9GRGRHiP
         CMXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781382512; x=1781987312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSCYMTARn4AyRio5zxnLgTYAfhKGyX1h6b/Ea1g7z90=;
        b=E/bcTQNnTTgPL+V5UY6EpW/DxN9eqq/9SfwCiKMgyAUaYqo1GvGC+tpp3RgvC74+g0
         /PAa4slLnWtxGOwgbltQOgHzgx7xuAW0KfCgPaRMyOpj/FefCHOCdYvNu3euelro/fAt
         ke800TsbFi+hAnICRTZX6EVuawIUj73Yi4T+CW1d7TmGmPvBpYj7sb66QcnlFkf/GooI
         BGIr8aYQIrG5gSgCyS/O3rzeE2LCdnipEEqj8MyPAqjZABkP6DHen4n/mnC2/oc/FnAi
         rdm4ZnKfyBjGZjJqlawRejtD9nNYdmS3iux+y0gUEXnr7qvv1AsgmbKyEHfqpcPsr2DX
         lPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781382512; x=1781987312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XSCYMTARn4AyRio5zxnLgTYAfhKGyX1h6b/Ea1g7z90=;
        b=pGb6MSDTv1QWHup/oi6il+WgSpxbFLZFkNV3m8jNIVesfZTxgbxG7h0Q3a2oZo9F9d
         /8o2M4ThRDv/VJuxdmXiIPuIbCJ3RFHzC9ny+hHK/KCI6wsRdTK5bzanH3cJ1Y7V1liA
         3JrO57qSf4ZclctHyNaaJj5jKSVm9DXPArBhZRfOikmxcfffUX2HLyFFzGpOZBHgj/fX
         k4eVXG5Fn4kLHM7W4rilJnl+R2/kPb1OhEEFPY66VRZDtE9icyCiFvNzk5FCipF+bwPZ
         NFyOGJHZXMY7Mfc3Bb5bzJXt54FWbeh2nrJp9MreSx/qHaBokou01m8RN+0tEZMlcICj
         hSqg==
X-Forwarded-Encrypted: i=1; AFNElJ8YgInY6li+ikZuOoHduCansuJ8Z6Ola6Sg/lYC62PfzXNCp/Vr4KVHS3H/mx8Cs0P5tmnWQ4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTmmhJ+vVKh6DfOKLVT1HgssELX57t6X+jZ2WqH50GvRpki6hv
	HN5DT7TiBsqCIj3zmdRWqtMh28x9F+J75hldRW1SJQGNpyKrxeaCbLMHqoammg7qecVjb0Jj+Ld
	nlbmC/XC6Uh9s7eJwHSRDG30MRAlnYL4=
X-Gm-Gg: Acq92OE54VFCGk8b5PWXvPIDjVhDSKdPhCBGqq2UbCmIlSWtR0u9yOmVoi36VRXvLBT
	wihH7YQ+euW+bEXSJU6vrQzhUpY44FLUj6IcR3P83BghqN2SGWSyTYbsWmyJfLxyY23Bpfe9HpC
	XTVWnj+tebiIrfgF9FzykGNS9Fq11cAbL/FTaoUphz58TApGb1cDxs+e2iq6fZ3BrRHrpEv0Koe
	+VnXkan3ljh90oXO68BlulBJtWsv/xN6EU1iAXrdFI3rrjpdDLGnbOXri/rcMB+ouGcgNwp6WUz
	rTMIOtt5OTI6IlV/A8NMv+49eZkhW4E+KyfglAtR
X-Received: by 2002:a17:907:6092:b0:beb:c327:8e7a with SMTP id
 a640c23a62f3a-bfe2a321ef7mr352847366b.35.1781382512268; Sat, 13 Jun 2026
 13:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-rtl8366rb-improvements-v1-0-9232286fc20c@kernel.org> <20260612-rtl8366rb-improvements-v1-4-9232286fc20c@kernel.org>
In-Reply-To: <20260612-rtl8366rb-improvements-v1-4-9232286fc20c@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 13 Jun 2026 17:28:17 -0300
X-Gm-Features: AVVi8CdKgJCvF199HMu4aqGWB1QklpN4WAXMeFPTxrNkDj2hpBls7A3H1aOZn90
Message-ID: <CAJq09z72ZOkHXpTa4sr+FvNeoJscvqhqAFvsKeXBXC2iVZHagQ@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] net: dsa: realtek: rtl8366rb: Switch to
 generic learning enablement
To: Linus Walleij <linusw@kernel.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299043-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2553F67FA1D

Em sex., 12 de jun. de 2026 =C3=A0s 11:23, Linus Walleij
<linusw@kernel.org> escreveu:
>
> Instead of just writing the learning disablement register in setup
> and a custom handling of BR_LEARNING, implement the generic RTL83xx
> .port_set_learning() callback for setting learning on a port, and
> call this in the per-port loop in .setup().
>
> Instead of the custom rtl83366rb_port_bridge_flags() function for
> setting learning mode on each port, use the RTL83xx generic
> rtl83xx_port_bridge_flags() callback.
>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/net/dsa/realtek/rtl8366rb.c | 43 +++++++++++++++----------------=
------
>  1 file changed, 17 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realte=
k/rtl8366rb.c
> index 155bf0010d5f..d2fa8ff6a5d0 100644
> --- a/drivers/net/dsa/realtek/rtl8366rb.c
> +++ b/drivers/net/dsa/realtek/rtl8366rb.c
> @@ -854,6 +854,16 @@ rtl8366rb_port_stp_state_set(struct dsa_switch *ds, =
int port, u8 state)
>         }
>  }
>
> +static int rtl8366rb_port_set_learning(struct realtek_priv *priv, int po=
rt,
> +                                      bool enable)
> +{
> +       /* Notice inverted semantics in this register: setting a bit disa=
bles
> +        * learning instead of enabling it.
> +        */
> +       return regmap_update_bits(priv->map, RTL8366RB_PORT_LEARNDIS_CTRL=
,
> +                                 BIT(port), enable ? 0 : BIT(port));
> +}
> +
>  static int rtl8366rb_setup(struct dsa_switch *ds)
>  {
>         struct realtek_priv *priv =3D ds->priv;
> @@ -945,6 +955,11 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
>                 if (ret)
>                         return ret;
>
> +               /* Disable learning */
> +               ret =3D rtl8366rb_port_set_learning(priv, dp->index, fals=
e);
> +               if (ret)
> +                       return ret;
> +
>                 /* Collect CPU ports. If we support cascade switches, it =
should
>                  * also include the upstream DSA ports.
>                  */
> @@ -1037,12 +1052,6 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
>                         rb->max_mtu[i] =3D ETH_DATA_LEN;
>         }
>
> -       /* Disable learning for all ports */
> -       ret =3D regmap_write(priv->map, RTL8366RB_PORT_LEARNDIS_CTRL,
> -                          RTL8366RB_PORT_ALL);
> -       if (ret)
> -               return ret;
> -
>         /* Enable auto ageing for all ports */
>         ret =3D regmap_write(priv->map, RTL8366RB_SECURITY_CTRL, 0);
>         if (ret)
> @@ -1341,25 +1350,6 @@ rtl8366rb_port_pre_bridge_flags(struct dsa_switch =
*ds, int port,
>         return 0;
>  }
>
> -static int
> -rtl8366rb_port_bridge_flags(struct dsa_switch *ds, int port,
> -                           struct switchdev_brport_flags flags,
> -                           struct netlink_ext_ack *extack)
> -{
> -       struct realtek_priv *priv =3D ds->priv;
> -       int ret;
> -
> -       if (flags.mask & BR_LEARNING) {
> -               ret =3D regmap_update_bits(priv->map, RTL8366RB_PORT_LEAR=
NDIS_CTRL,
> -                                        BIT(port),
> -                                        (flags.val & BR_LEARNING) ? 0 : =
BIT(port));
> -               if (ret)
> -                       return ret;
> -       }
> -
> -       return 0;
> -}
> -
>  static void
>  rtl8366rb_port_fast_age(struct dsa_switch *ds, int port)
>  {
> @@ -1810,7 +1800,7 @@ static const struct dsa_switch_ops rtl8366rb_switch=
_ops =3D {
>         .port_enable =3D rtl8366rb_port_enable,
>         .port_disable =3D rtl8366rb_port_disable,
>         .port_pre_bridge_flags =3D rtl8366rb_port_pre_bridge_flags,
> -       .port_bridge_flags =3D rtl8366rb_port_bridge_flags,
> +       .port_bridge_flags =3D rtl83xx_port_bridge_flags,
>         .port_stp_state_set =3D rtl8366rb_port_stp_state_set,
>         .port_fast_age =3D rtl8366rb_port_fast_age,
>         .port_change_mtu =3D rtl8366rb_change_mtu,
> @@ -1833,6 +1823,7 @@ static const struct realtek_ops rtl8366rb_ops =3D {
>         .enable_vlan4k  =3D rtl8366rb_enable_vlan4k,
>         .port_add_isolation =3D rtl8366rb_port_add_isolation,
>         .port_remove_isolation =3D rtl8366rb_port_remove_isolation,
> +       .port_set_learning =3D rtl8366rb_port_set_learning,

The bridge flags code is fine as it does not touch CPU port but the
.port_set_learning will also be used by bridge join/leave. As I
mentioned in the last patch comment, disabling CPU learning requires
fdb_add/remove. Maybe we should both check if port_set_learning and
fdb is available before disabling CPU learning.

>         .phy_read       =3D rtl8366rb_phy_read,
>         .phy_write      =3D rtl8366rb_phy_write,
>  };
>
> --
> 2.54.0
>

Regards,

Luiz

