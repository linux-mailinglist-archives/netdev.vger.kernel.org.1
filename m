Return-Path: <netdev+bounces-272939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLnIIshXyWkuxgUAu9opvQ
	(envelope-from <netdev+bounces-272939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:48:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E2B353223
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 603FB3003813
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32783815C3;
	Sun, 29 Mar 2026 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZsZoG98"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D16381AF8
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774802884; cv=pass; b=cRIisIlPY/Xbw/bzdOYGS0v863txQMEwOI33ZdSwVZHG4ATqatQQzlkbcEqrxGTKqOIX9d8VAufDQ68DtBLXJkKxoiZ+3q4a6glC3WzTJRT5vuwCf9AkF7573EJinrUz2bUcYHdiad93cHiwinNE6PNmfUzcSNL8Vew1DOPrtp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774802884; c=relaxed/simple;
	bh=22XCQ5cw2XvPtiWgDCr799g86U/aC1l+E5HPTFpFwnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5SL0aWeeisDvvHB/91nMkKQpz5IiU0p6GSXV0clT8kWS1s7Qsn8Sf0BSdViqPBegDxg/Uo88k9Kw10PyhZ1UD/d476wg7ByGDiACCJ3yb9RDC6ZC2l5SSB0iu9H7ghQkQpD/GMtT08rhLyJ9epziFEJn1I+mog2UnONIQ1VKPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZsZoG98; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66abe08cdf5so5721019a12.0
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 09:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774802879; cv=none;
        d=google.com; s=arc-20240605;
        b=HKyBfkUoYbchoOcZW1eS+NsUJczTYlkYdb+EDUSkFnGbztS1ePbLRiWY4fOJ+nP4u0
         5rBegRn5vsFwGic/60tdfg7gheUwbkGd/BnWI8bgOMuOfkoctprZMGcbJFh868fXu+sE
         ATpefskHnjdoq4p+hjXnaIO4+JsWgz4LufvxHmMsza1nyMgiGPpurVUhRhH0TZuNM6wa
         ACRklDtCsUdkMeQlhc1hyH/c8KYAHuYsVKfost4TSj0aWdXUNT7HE2UVooHFodMnCUs9
         tymkFkxvNBJHXGwz1mwZNuhMH+8taoNiaKZYA6BqgKeUyLE4EOrw/dvmDHkSuXZYtRos
         u7zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9qj3EOb+/iGYWvhnba0jt3qty9UdQZycXj5N05MeZkc=;
        fh=kznvlDGkquLI6zdlmg2II2MwFW38gsMu9tzV5tRjjpg=;
        b=bQLixufOT/cT+6gmbkhVE2D2DUpctsgRKmfpWAQEkjvT81RaXCLMwNy/7XksprsmHz
         WvONqV5uZnruwH9cCzDLj1DIaVVvRipZ2RQcTI+Ui+SE5zpTuRzcFv8IfLM2rWpsw6Am
         EIabjx35QwhG8wHc6fE5qmWQdnvRLg1soDFVx6cI1oCK+Y7OSMHX+Mk5XONpPshW5ESq
         E3za7WFRVzVxBdZke5m/gREGNjzZl69T/wgRTJoudIg5q7v+l4Ap8kS59hSQjr8Q2tic
         Mu6nQQwlCfg1man8XiKgZOWFzZrkcUaM0AUuSFzQvokgBp1dniC07FXkUWm7PS84Az5K
         0MGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774802879; x=1775407679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qj3EOb+/iGYWvhnba0jt3qty9UdQZycXj5N05MeZkc=;
        b=hZsZoG98a4mHNsdsaXpz65qh6C1P5L+9oR5wQvSXixFUlc/q4Hfv65bh9BNsdOA+0v
         xiVAhv0oPpxg/Xd1il2Dn9NtXhuWd0Rgk7fvMWNsx4TbdJv2sbG5SjdIXnZI3ZpNca8T
         BR5/3o7/hH+kM0uz1w3S6oNz9UIwScLWl9+k5kPQETZonIiWTtL5iGzDYugOHZfX0/os
         2OHwC2O05z+MNhxq5kqVdxSC3mOA9nLuSDYC20dkUFU2hMPV5HQSNXvw9jMeRLGmHZju
         V5sCkf4x2438SVCvwY5yxhmv28guQiMa/OoxTG6jNyYSLWw2tu0BPzCCzcYM0+89+H0z
         zscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774802879; x=1775407679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9qj3EOb+/iGYWvhnba0jt3qty9UdQZycXj5N05MeZkc=;
        b=Sn7atoqvxzW6z/yH/84RpC09sBcAdHF1xc8gJjWOlKiDnDe65zznEaRICm1FMVKYl7
         4kH2UnbMmChktZZhFQNKfORulw+PbjbGh4SAr0joRgMzB6YbgHhjzWU/YA5eEeqoOWhS
         tMtbWo50EI3jv/B62Cxku+wrMV8NLl/3tVX6p9NlS3vMpfFDE1wbPJS97I00G/TGWLGp
         bxiE1Z2Ht5d372oJPdVBxXCBroLxUhCCIMIYaHqVdYRndc9HS8iriHeuv4iyBYF461bp
         TXtKiQdbZ48agxQsJxW9+yqt0xdR52X4Pa13H4uBukNnqS9wTFBoalFPOA6zJ0X+x7ji
         qqSQ==
X-Gm-Message-State: AOJu0YzzYbL8th0vPIdkMO5M0gPxcFUL8sUNfua/3trMAF9PZBxN0elW
	gTTcsgZ7tG4+T8BAMdSndnt6cEb1/pLRQsqT4Lcs8d7G/QmxzBfIxB1tok539h5XFo597tErbn0
	6784MMRDRdX1GS27W21tufHZ5STNWyY4WQQ==
X-Gm-Gg: ATEYQzykEfV+9vNNhJWRDa0BLjeu5JKWRIhrXtSErlZlrNqjpktXbpuFnF/ne/IEoMq
	cyCoMPL1yJZne9VQFxbLYb1Eg4ewOY11d3qB7jXc+1hq3GT3IBJvKcYrqVvjn3s0UpxeTduLDUT
	qg6Jh+n9qXSbEzvy4oxFVVa/Iv4CRA4VHu/w2me8k90uaQ4TshgAzGSkb/J4tFald3Jxl6OO27K
	gVRXRE0rnukRGUyUoW7lgw7vw535rR/Cu+6rpadrLZFBFxkiPtOg933D6G+TsrBscAStt+WS0aq
	ccQ=
X-Received: by 2002:a05:6402:44c6:b0:665:f31:3197 with SMTP id
 4fb4d7f45d1cf-66b28365051mr3756562a12.1.1774802878667; Sun, 29 Mar 2026
 09:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324152503.1522071-2-wagner.daniel.t@gmail.com> <20260324190601.1616343-1-wagner.daniel.t@gmail.com>
In-Reply-To: <20260324190601.1616343-1-wagner.daniel.t@gmail.com>
From: Daniel Wagner <wagner.daniel.t@gmail.com>
Date: Sun, 29 Mar 2026 17:47:47 +0100
X-Gm-Features: AQROBzBBkVeryCDE43G6q3fIEFlEiagj3FgPgF1uKeaOLEaq4oYb_WULMuOzRck
Message-ID: <CAMsLQxGcnD1Q8REcgKWJQR-cgS2Z1KaTJgs9r989p2pxz6vV4Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: phy: bcm84881: add BCM84891/BCM84892 support
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	bcm-kernel-feedback-list@broadcom.com, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272939-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,google.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wagnerdanielt@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 24E2B353223
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I see v2 is marked as "changes requested" on patchwork; I believe it
addresses the original points, but happy to make further changes if I
missed something. LEDs will follow in a separate patch.

Daniel

On Tue, Mar 24, 2026 at 7:06=E2=80=AFPM Daniel Wagner <wagner.daniel.t@gmai=
l.com> wrote:
>
> The BCM84891 and BCM84892 are 10GBASE-T PHYs in the same family as the
> BCM84881, sharing the register map and most callbacks. They add USXGMII
> as a host interface mode.
>
> bcm8489x_config_init() is separate from bcm84881_config_init(): it
> allows only USXGMII (the only host mode available on the tested
> hardware) and clears MDIO_CTRL1_LPOWER, which is set at boot on the
> tested platform. Does not recur on ifdown/ifup, cable events, or
> link-partner advertisement changes, so config_init is sufficient.
>
> For USXGMII, read_status() skips the 0x4011 host-mode register: it
> returns the same value regardless of negotiated copper speed (USXGMII
> symbol replication). Speed comes from phy_resolve_aneg_linkmode() via
> standard C45 AN resolution.
>
> Tested on TRENDnet TEG-S750 (RTL9303 + 1x BCM84891 + 4x BCM84892)
> running OpenWrt, where the MDIO controller driver is currently
> OpenWrt-specific. Link verified at 100M, 1G, 2.5G, 10G.
>
> Signed-off-by: Daniel Wagner <wagner.daniel.t@gmail.com>
> ---
> Changes in v2:
> - Separate bcm8489x_config_init() that allows only USXGMII. v1 also
>   allowed USXGMII for BCM84881 (which doesn't support it), and put
>   SGMII/2500BASEX/10GBASER in the 8489x possible_interfaces which I
>   can't substantiate on this hardware. (Russell)
> - LPOWER clear moved from config_aneg to config_init. Characterized on
>   hardware: boot-time only, does not recur on ifdown/ifup, cable
>   events, or link-partner advertisement changes. (Russell)
> - Dropped LED support; will figure out the PHY LED framework approach
>   for bicolor speed-mapped LEDs as a follow-up. (Russell, Andrew)
> - PHY_ID_MATCH_MODEL(). (Russell, Andrew)
> - is_bcm8489x() helper removed; the interface mode now suffices as a
>   discriminator in read_status since only the 8489x config_init allows
>   USXGMII.
>
> v1: https://lore.kernel.org/netdev/20260324152503.1522071-2-wagner.daniel=
.t@gmail.com/
>
>  drivers/net/phy/bcm84881.c | 48 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/phy/bcm84881.c b/drivers/net/phy/bcm84881.c
> index d7f7cc44c5..f114212dd3 100644
> --- a/drivers/net/phy/bcm84881.c
> +++ b/drivers/net/phy/bcm84881.c
> @@ -54,6 +54,21 @@ static int bcm84881_config_init(struct phy_device *phy=
dev)
>         return 0;
>  }
>
> +static int bcm8489x_config_init(struct phy_device *phydev)
> +{
> +       __set_bit(PHY_INTERFACE_MODE_USXGMII, phydev->possible_interfaces=
);
> +
> +       if (phydev->interface !=3D PHY_INTERFACE_MODE_USXGMII)
> +               return -ENODEV;
> +
> +       /* MDIO_CTRL1_LPOWER is set at boot on the tested platform. Does =
not
> +        * recur on ifdown/ifup, cable events, or link-partner advertisem=
ent
> +        * changes; clear it once.
> +        */
> +       return phy_clear_bits_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1,
> +                                 MDIO_CTRL1_LPOWER);
> +}
> +
>  static int bcm84881_probe(struct phy_device *phydev)
>  {
>         /* This driver requires PMAPMD and AN blocks */
> @@ -201,6 +216,15 @@ static int bcm84881_read_status(struct phy_device *p=
hydev)
>                 return 0;
>         }
>
> +       /* BCM84891/92 on USXGMII: the host interface mode doesn't change
> +        * with copper speed (USXGMII symbol replication; the MAC receive=
s
> +        * the negotiated copper speed, not 10G, so no rate adaptation).
> +        * Skip 0x4011; phy_resolve_aneg_linkmode() above already set the
> +        * speed. Only bcm8489x_config_init() allows USXGMII.
> +        */
> +       if (phydev->interface =3D=3D PHY_INTERFACE_MODE_USXGMII)
> +               return genphy_c45_read_mdix(phydev);
> +
>         /* Set the host link mode - we set the phy interface mode and
>          * the speed according to this register so that downshift works.
>          * We leave the duplex setting as per the resolution from the
> @@ -256,6 +280,26 @@ static struct phy_driver bcm84881_drivers[] =3D {
>                 .config_aneg    =3D bcm84881_config_aneg,
>                 .aneg_done      =3D bcm84881_aneg_done,
>                 .read_status    =3D bcm84881_read_status,
> +       }, {
> +               PHY_ID_MATCH_MODEL(0x35905080),
> +               .name           =3D "Broadcom BCM84891",
> +               .inband_caps    =3D bcm84881_inband_caps,
> +               .config_init    =3D bcm8489x_config_init,
> +               .probe          =3D bcm84881_probe,
> +               .get_features   =3D bcm84881_get_features,
> +               .config_aneg    =3D bcm84881_config_aneg,
> +               .aneg_done      =3D bcm84881_aneg_done,
> +               .read_status    =3D bcm84881_read_status,
> +       }, {
> +               PHY_ID_MATCH_MODEL(0x359050a0),
> +               .name           =3D "Broadcom BCM84892",
> +               .inband_caps    =3D bcm84881_inband_caps,
> +               .config_init    =3D bcm8489x_config_init,
> +               .probe          =3D bcm84881_probe,
> +               .get_features   =3D bcm84881_get_features,
> +               .config_aneg    =3D bcm84881_config_aneg,
> +               .aneg_done      =3D bcm84881_aneg_done,
> +               .read_status    =3D bcm84881_read_status,
>         },
>  };
>
> @@ -264,9 +308,11 @@ module_phy_driver(bcm84881_drivers);
>  /* FIXME: module auto-loading for Clause 45 PHYs seems non-functional */
>  static const struct mdio_device_id __maybe_unused bcm84881_tbl[] =3D {
>         { 0xae025150, 0xfffffff0 },
> +       { PHY_ID_MATCH_MODEL(0x35905080) },
> +       { PHY_ID_MATCH_MODEL(0x359050a0) },
>         { },
>  };
>  MODULE_AUTHOR("Russell King");
> -MODULE_DESCRIPTION("Broadcom BCM84881 PHY driver");
> +MODULE_DESCRIPTION("Broadcom BCM84881/BCM84891/BCM84892 PHY driver");
>  MODULE_DEVICE_TABLE(mdio, bcm84881_tbl);
>  MODULE_LICENSE("GPL");
> --
> 2.47.3
>

