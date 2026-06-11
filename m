Return-Path: <netdev+bounces-298362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pEXVC4IpK2qq3QMAu9opvQ
	(envelope-from <netdev+bounces-298362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:32:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F1B67572A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:32:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="qmCntyR/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298362-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298362-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B81930FAA3D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F715371893;
	Thu, 11 Jun 2026 21:32:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61C13314C4
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 21:32:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213567; cv=pass; b=GFC5jKKIK1JmawDVTj/z4xo/Jgguawro7noO1gPcM1HvVgvUpwYW4wbOYNIKSdokmjmOfKTjWaBf2hIMjS0mwLCk0PnXTQbAMXCEryN0St6z4ei/ZvIHXIHfGqKCKbiFi27bhak7ziPtW6k79Mm6JUoZ2TtGtyS6CLYI5MdIfv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213567; c=relaxed/simple;
	bh=EOaxGF72YUpzj9UvAsXVb5mIF9+6D5IgXxUjBlaA/uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZL7kVITxkDhycZ4dJuAAOb53FlLG3LeBxwogkZL/layaCWGRmOIY+p7lk8UZW4n9O+iXLIiAgprI785yr0x+23pwmTxobmZhEvDqrBqc7H8KND4IipknNtVbr/5/PS52c3flnTJNq+Obg60APTZdtqG4C1iNBOwbzE8QPtfJzxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qmCntyR/; arc=pass smtp.client-ip=209.85.208.43
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6919f40a0c8so559954a12.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 14:32:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781213564; cv=none;
        d=google.com; s=arc-20240605;
        b=bmBzv1tmz/fCfR44PB5LH1AGLjVlsQzg4JjuGydVbCqUFJ044IFYvxcXMHfOKLsB8w
         AhyqS2mXwImJJfZ2sAR5ZlMWvCPqHjE8dialOw51GItFWiO19BTHHcSNqVrVdUjU9FHm
         PYWPjLzczrylyVGDYEVSL/Pvy2K0c32MBNsCZdpKb+Jt85E9Zm7Y7YNTA/eUkwT0DRFx
         FhpD1WWJl9DWsKLF7v6qxxiJEILwZ1EqP9n1w2zhZPsdyUCipbrrjw8m3SdLpngI0+Qt
         1dbAuyeSgLEAdciogYsjxeTkO1NBn6PpOQ/g7xpkQwfWLHs3FmPCkqZTRsSLYJo5hTGh
         UiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m2NXB6mqdOjXFSq9I6EPc3SAFiBlFzLnhCVGm+82RLM=;
        fh=df0vdMqCHcGqMLsTTvBrqzSR1asbjkHGD7jsvSHOXnw=;
        b=XMuS5bTuFm+MN2z+AUxHdlXplGy6jyHHpqj7h7kDO7lSSsY3MiMl7urCNTaaztybTk
         7j3geoOSmDVlorzzQjd3y6u5qmzZS61YPrTcZv+a9FQeSEq1hcY48J5N2gRYMe3y41OG
         F5nSXYyyIYXvLs+JxrtsimTycx1w4nsytWNxBZyVKUsVTBxL8+DZz+Omp6rHJ3JRM2EL
         SZd0nZJ3whRONYhh5L+51Qp5QJY1+3sqaub9XY+I12qlfY5hHHt8nXAzNTsJh+ZBBctU
         F2fUGmgk45G5oqQfUFzjV7LDy1BUU0OwPp2qCzNDim+eHmgzjgkd6ChJzvo+/DZejFVf
         reEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781213564; x=1781818364; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m2NXB6mqdOjXFSq9I6EPc3SAFiBlFzLnhCVGm+82RLM=;
        b=qmCntyR/nwn+tzKcMyUDx4ISVT/PGyrSGn8oS77U8gWEioOCFhw6jHza/zlwxFPiZU
         zGfEwi9DNgR6/lUmd5zQANMc78u/086UNSxSaPexoX+9kBaE0huZyQe71FN1w/oxgEJu
         9VCQ6G23EEagleS/VafMbH4oaD5EjwZIJBdQhhCizqM0QoeeF52Ptmo06jzcRl4LAkoD
         F+qz7ISVEsWINZ+K6s9jTe2w/llfDkQmv5e5XJSq+TegfIWXxEAvR5pG6tLjvky8mO5T
         rxnPSM5bUzyMC2H5y5KAd2pM4/hAbIIM9tBHoEW1iCEFpE6LWGFEkNv2LamKw06HGoqG
         fGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781213564; x=1781818364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2NXB6mqdOjXFSq9I6EPc3SAFiBlFzLnhCVGm+82RLM=;
        b=GuLYAiAn5VKIV1BjdPU38saIBglH67QBh0jni2Se4VfPhsnrNRKAGjmeL1+3T0zxgv
         eymcdClU9KRPdDwXwnxySOJGdv+h/peR7lrE6v5V0k2Rj0hu5b9KncEgXndn7RQmeLVy
         oc2FJx5UZRoYkRlNZWdZ/Fe5yUKeCl8qhp2aqQg0NmZA4lUgbvGlHTMmRhxGmE2BhSdV
         fpDZzk05XPn/rF2UF2DoZu/uMmcT5AHd7hcB0OUQDb0YGcCKWS+esBwq9trUE/dyQYvi
         ocNLL7BLDZpRKz0HW0oRSIhh+W/9cwPF2oPkGK6tPPx5LXi64Hgs49t7+KD5Zoud5WU0
         yTGw==
X-Gm-Message-State: AOJu0YzBxH21LCgChh78HsmcSGwV12RqSTro9vFDqKICCgSVPJt7WxVl
	mnRw5xoe6ka1jQ3dw9H1016JE3fOPjEi5MR1DnZNhIjZtV3vvipPmmi99kiVBmEpU2Jyc/RNf91
	paBe1HGvzXcRZ8yTgRJrjAmEdoWYUsO0=
X-Gm-Gg: Acq92OFoCy5A1dho1eNipScIRBW5E7wpNp0ctaFmaC6T3/0te2ylv7sR+LvDAENnnt4
	SYJ7qzWp/TiEiau0CxS5rO+C8AJf5i4BQhhK+dAvJbDufzsNedEEDSOTNogM8F4r7U/3SqC5Jb9
	PEpWtAeQ1uSmwtzG18hxUCpBPF53XsiEjwgb5kEOSSguIviiyAItsf5GjkHNXLqqKgbNw0QNODt
	NwCyptKcmG6zKSB9oQM1S0Yo71WYFErbDpJuePbxPydfE5NtUHau4dhx+BX7cSvU3vVqJ+OJkTZ
	x5lV67oP
X-Received: by 2002:a17:907:1df0:b0:bdc:9d31:3f91 with SMTP id
 a640c23a62f3a-bfc865d35b1mr167588566b.15.1781213563888; Thu, 11 Jun 2026
 14:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084120.1100326-1-contact@c127.dev> <0100019eb0b19c71-c9940bf4-4d23-41af-b429-842330edd967-000000@email.amazonses.com>
In-Reply-To: <0100019eb0b19c71-c9940bf4-4d23-41af-b429-842330edd967-000000@email.amazonses.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 11 Jun 2026 18:32:31 -0300
X-Gm-Features: AVVi8CeoKZF2ICiPtMxLrwzbCgvmvOGjWCpdCtL2piQvimpYP_JOyu6zDk97XSE
Message-ID: <CAJq09z4B_P7D0khof-e0hxu=A+UQYAH_anJYt8ppaFcjHCdBCw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: realtek: rtl8365mb: add SGMII
 support for RTL8367S
To: contact@c127.dev
Cc: netdev@vger.kernel.org, linusw@kernel.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298362-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:contact@c127.dev,m:netdev@vger.kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp,c127.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71F1B67572A

> The RTL8367S can mux its embedded SerDes to external interface 1,
> which is typically used to connect the switch to a CPU port. The chip
> info table already declares SGMII as a supported interface mode for
> this chip, but the driver only implements RGMII so far.
>
> Implement SGMII support, with the configuration sequence derived from
> the GPL-licensed Realtek rtl8367c vendor driver as distributed in the
> Mercusys MR80X GPL code drop:
>
>  - Add accessors for the SerDes indirect access registers (SDS_INDACS),
>    through which the SerDes internal registers are reached.
>
>  - Clear the line rate bypass bit for the external interface, tune the
>    SerDes with the vendor-prescribed parameters, mux the SerDes to MAC8
>    in SGMII mode and only then take the SerDes out of reset, as the
>    vendor driver does.
>
>  - Load firmware into the embedded DW8051 microcontroller, which
>    performs the remaining SerDes initialization. The firmware is
>    requested via the firmware API under the name
>    realtek/rtl8367s-sgmii.bin.
>
>  - Force the SGMII link parameters (link, speed, duplex, flow control)
>    in the SDS_MISC register from the phylink mac_link_up/down
>    operations, in addition to the usual external interface force
>    configuration. SGMII in-band autonegotiation is disabled, so only
>    fixed-link and conventional PHY setups are supported, just like
>    RGMII.
>
> Tested on a Mercusys MR80X v2.20, where the RTL8367S is connected to
> the SoC over SGMII.
>
> Signed-off-by: Johan Alvarado <contact@c127.dev>

This code is based on code from other developers. Please ensure proper
credits/Co-developed-by tags are added if applicable.

> +
> +static int rtl8365mb_ext_config_sgmii(struct realtek_priv *priv, int port,
> +                                     phy_interface_t interface)
> +{
> +       const struct rtl8365mb_extint *extint =
> +               rtl8365mb_get_port_extint(priv, port);
> +       u16 val;
> +       int ret;
> +       int i;
> +
> +       if (!extint)
> +               return -ENODEV;
> +
> +       /* The SerDes can only be muxed to external interface 1 */
> +       if (extint->id != 1)
> +               return -EOPNOTSUPP;
> +
> +       /* The vendor driver clears the line rate bypass for all interface
> +        * modes except TMII.
> +        */
> +       ret = regmap_update_bits(priv->map, RTL8365MB_BYPASS_LINE_RATE_REG,
> +                                BIT(extint->id), 0);
> +       if (ret)
> +               return ret;
> +
> +       /* Tune the SerDes with vendor-prescribed parameters */
> +       for (i = 0; i < ARRAY_SIZE(rtl8365mb_sds_jam_sgmii); i++) {
> +               ret = rtl8365mb_sds_write(priv, 0,
> +                                         rtl8365mb_sds_jam_sgmii[i].reg,
> +                                         rtl8365mb_sds_jam_sgmii[i].val);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       /* Mux the SerDes to MAC8 in SGMII mode */
> +       ret = regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
> +                                RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK |
> +                                        RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK,
> +                                RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK);
> +       if (ret)
> +               return ret;
> +
> +       ret = regmap_update_bits(
> +               priv->map, RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(extint->id),
> +               RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(extint->id),
> +               RTL8365MB_EXT_PORT_MODE_SGMII
> +                       << RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(
> +                                  extint->id));
> +       if (ret)
> +               return ret;
> +
> +       /* Take the SerDes out of reset. The vendor driver does this only
> +        * after the SerDes mux and the interface mode are configured.
> +        */
> +       ret = rtl8365mb_sds_write(priv, 0, RTL8365MB_SDS_REG_RESET,
> +                                 RTL8365MB_SDS_RESET_DEASSERT);
> +       if (ret)
> +               return ret;
> +
> +       /* The embedded microcontroller performs the remaining SerDes
> +        * initialization. Load its firmware and give it some time to bring
> +        * the SerDes up.
> +        */
> +       ret = rtl8365mb_dw8051_load_firmware(priv);

I checked the vendor firmware behavior and it essentially initializes
the interface and runs an infinite loop polling for link state
changes. Crucially, it writes to the exact same registers we already
manage in this driver via phylink:

- RTL8365MB_DIGITAL_INTERFACE_SELECT_REG0
- RTL8365MB_DIGITAL_INTERFACE_SELECT_REG1
- RTL8365MB_DIGITAL_INTERFACE_FORCE_REG0
- RTL8365MB_DIGITAL_INTERFACE_FORCE_REG1
- RTL8365MB_DIGITAL_INTERFACE_FORCE_REG2
- RTL8365MB_EXT_RGMXF_REG0

By allowing the DW8051 to run, we introduce a "two heads controlling
the switch" scenario. The firmware loops polling for port status and
sets REG_EXT_FORCE_{0,1,2} behind our backs. While this might go
unnoticed in a strictly fixed-link topology, it introduces race
conditions and unexpected behaviors if phylink is also manipulating
these registers.

Furthermore, analyzing the firmware reveals that right after
deasserting the SerDes Reset, it applies the following sequence:

rtl8365mb_sds_write(priv, 0, 0x0000, 0x1401);
rtl8365mb_sds_write(priv, 0, 0x0000, 0x1403);

These are writes to the SerDes Basic Mode Control Register (BMCR,
Register 0). 0x1400 asserts BMCR_ANENABLE | BMCR_ISOLATE. Toggling the
lower vendor-specific bits (0x01 to 0x03) triggers a data-path reset /
PLL resync. This clears out FIFOs and ensures a clean cold boot for
the SGMII link, preventing silent drops or CRC errors.

I think we don't need the firmware at all. Requesting a proprietary
binary that we don't control to do things phylink already does is
unnecessary and adds a burden to linux-firmware.
I strongly suggest dropping rtl8365mb_dw8051_load_firmware() entirely,
porting the BMCR reset sequence above directly into the driver, and
keeping the 8051 disabled.

> +       /* Pause the microcontroller while accessing the SerDes directly */
> +       ret = regmap_update_bits(priv->map, RTL8365MB_MISC_CFG0_REG,
> +                                RTL8365MB_MISC_CFG0_DW8051_EN_MASK, 0);
> +       if (ret)
> +               return ret;
> +
> +       /* Disable SGMII in-band autonegotiation: the link parameters are
> +        * forced in rtl8365mb_phylink_mac_link_up.
> +        */
> +       ret = rtl8365mb_sds_read(priv, 0, RTL8365MB_SDS_REG_NWAY, &val);
> +       if (ret)
> +               return ret;
> +

If we intend to support non-fixed links in the future (where in-band
AN is required), we would need to implement phylink_pcs and
pcs_get_state instead of just forcing the MAC. For fixed-link it is
fine, but we should plan accordingly.

> +       val &= ~RTL8365MB_SDS_NWAY_EN_MASK;
> +       val |= RTL8365MB_SDS_NWAY_RESTART_MASK;
> +
> +       ret = rtl8365mb_sds_write(priv, 0, RTL8365MB_SDS_REG_NWAY, val);
> +       if (ret)
> +               return ret;
> +
> +       return regmap_update_bits(priv->map, RTL8365MB_MISC_CFG0_REG,
> +                                 RTL8365MB_MISC_CFG0_DW8051_EN_MASK,
> +                                 RTL8365MB_MISC_CFG0_DW8051_EN_MASK);
> +}
> +

Regards,

Luiz

