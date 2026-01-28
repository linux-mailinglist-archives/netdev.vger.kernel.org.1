Return-Path: <netdev+bounces-254469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF7lCsd9emld7AEAu9opvQ
	(envelope-from <netdev+bounces-254469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:21:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6C3A9110
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB7C13007495
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E6233A9D1;
	Wed, 28 Jan 2026 21:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FjVn8pjA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3333033F4
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 21:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635266; cv=pass; b=hGntuGHvr5v9fmVdSroyJPThTUjesJ35aE+41GLiNR2XyR4GziizcW1p80K8MSgGrAt5CdqrdBUKmaGfag7rUWVOItuZZGtA2t1/vPwKJ7HX2t8FQYtmdHTaKLPmyH5gZ8+T2bTcDjXP5CwH8ufkebKlNcdE+pp3YlgWEbobs8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635266; c=relaxed/simple;
	bh=WQkN8WEZ2ANY9z3rxIK0d6tV7FybPoKAvZYM8kOVJpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2DB1hYJw4QRlQpHVr9E0p4cdAfaw3bXWGC5/rDP6KJ8hRWpqTlOkTC8Ak/fJ4+qXrCxk2weN1RPxkUCsMCKVjF1mLjh9oE0U4SMxdcw/tHJ/csuYuhSpu8gRDDfmevEpVTJCGgmfTitcNZccmE1FprxfXjiYSM/9LKOtDvUZ3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=FjVn8pjA; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b6fd5bec41so628862eec.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 13:21:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769635265; cv=none;
        d=google.com; s=arc-20240605;
        b=L9utGUJbUInPtM3HCI8tZew2C/4e2amMG+QEIDZSPrGap++zKdPU6YKezDLKJkbhDI
         QFes+DaAx06ux9kpy7MAUaaV+eXNWimUoUHBXTra9m8vT2g4DwukhXr67UtrE7uH7EnA
         sLRow83FEuX2w9I0RUjHZFQYbFViVOpR4jRWdARtksfAAvfhKQ2kTYNzoj8RRIuciMDw
         lGmj8hE0QGTWc0IlBA1gGpYi1j9CMp3KgQoXtdABH6NOLmCjNJfJGZguR9UPZQrpOnae
         3Jv8nDzU0BxWzmmt/k7xda65/xGjUWjeJRW/7J62dP9eofhJp2pxVRg12OxeWS6c/nWx
         eTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=196fYB1ny++ckXPgc6Gd/2GIlKheTEW/DwwNpsiJguo=;
        fh=5qcuMBlaOCHYts5wzpZnEtLaySr18Uyg0LZoD3RNggs=;
        b=DYGFFBGWn6vjIjb1UAWeNB0tPg25EjHnyzbcxzqnAcIAVtdVydXwadTqGFjHIRT+TN
         6KNX6+SXSaOpXl3nQV3Oyy7tsinZDtw6KNUf0yL6OOF86d1hdfK8ivEAH5IFMLnndC7I
         +viMqPrkANp+5wrF7GIUoGEtzxwDyvAinb7sk5O5s2G5owYHdIzGZ0mz6+ts4uVxl1uJ
         +OXeh/mgYbosqoHe1i/NXpKO4eiN+zN82YgFOWuLJZHelnCOM4nuxH30lbZbQZUB5RWe
         XCOoyEWmcz+qsF/ApFv59881p7T6DOC01rIcJwj2wLzBPrrpFAKILw/uESdw5aWIvzNf
         HxwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1769635265; x=1770240065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=196fYB1ny++ckXPgc6Gd/2GIlKheTEW/DwwNpsiJguo=;
        b=FjVn8pjAXlo6AuPpFOgJPd+SbW8E0k7m4zAift+WLE0kDREFwfMnbXcvfSbwKDmuh0
         qnKqZV9NC1RM5gdvE+4mM04Nx6sna1ceFXEjiO2CYCrZ/cUPH7RhBhsCMYm7eXFLqIw7
         6gZ7RSwzEkKQ9XMf9XTH+c0f+lsnc4j5WCKds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769635265; x=1770240065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=196fYB1ny++ckXPgc6Gd/2GIlKheTEW/DwwNpsiJguo=;
        b=v49uZGUUwMrpS+g3e/cclEHhissr5u9Os02Jw6t6NnJ8qDxgZJipwZpu/tditsw6/f
         qaCz/kGx/pvqjrgFiC5mJEKhsmVmpmEJDCGx4n+srP2VWfR6Ooo/bY1qhZHJ+t0vMwl2
         SrUW0JBb8UKZeTEDykOLtDiF2y01FLrUwP3QQ5iGsmrpk/GQ+Dp2poPUuxVpvnVpFfp1
         lB91M/JFGeKHz6EAc2SHE/h2DoT6VR4UD2dzWT1R/tt5OgUHhcvo/N1+Wt1R4GQQ2/j4
         MrBGVhkNNP8260ped6pH6G2Vkn5/gg2NEBtlFDMED1g0AO3A+RhBmP1F8Oy+PBA8zPLV
         c3ig==
X-Forwarded-Encrypted: i=1; AJvYcCVB+fWXAMhBge4PjxZOMDqqVTUsrBsq1dZQjSP0IrzmpRinWx6/s6Pp6DpIcPEir9DsanI3I3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz349wlk9fNc3cjBm/zihtESeHHXj09O9qnSOrtZ6NUJ0RJNtkz
	xo5M9Shlh94ns+Q5zBjPSHfNdDuaOfNgkhf+N+fAyhFlkDJs9gwxjvshHarcaPvsKYVGbo8Oazf
	s2lHcGhuaM+7L8tGNN6+r4J79mvK3U3HTrDVJSdTJ6w==
X-Gm-Gg: AZuq6aIKhOtawHCEsbP1foUo2QPS6MBA5it7xdhsKHGkzKjr2XF3dWBlxan2c9OjXAl
	E5Xml8u4qySvsKyR2YPHlasRdiC7Af779sXu7LhXyXq/h2AHjIBjQHj1Y7MbIfA0v/PEn0e7IwP
	ocWiDrG+aU1S8puRDs4sPa6IWmLr6aXvN1lD10/ajP4kzWJ49YqTMRJhihx4GHWYfyI55HG7B6i
	0EVowl8ggVVBwW52EDFCYPlHJvhXcWiTdAzi4F3WBgFOLZBXV8pZ1s7eOFU2BNKG/IWzvAOJV/V
	e62BAksvYn6eJmqZcIkwyoTy+g==
X-Received: by 2002:a05:7300:ad09:b0:2b7:3281:6c33 with SMTP id
 5a478bee46e88-2b78d8d389fmr3828383eec.12.1769635264611; Wed, 28 Jan 2026
 13:21:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128094644.302313-1-michael@amarulasolutions.com>
 <13d1018c-d9aa-4838-8bb3-35c509cd3e35@lunn.ch> <CAOf5uwm30=AVhqm67yz8Y5TkX9FWdxizTevCGSeaQuJS0KqtNA@mail.gmail.com>
 <aXoV-U-yqcDJj2vk@shell.armlinux.org.uk> <20260128202634.gqevi76o6wnf5xno@pengutronix.de>
 <fe9385a5-170f-474c-af8d-24bbfa5eb3ab@lunn.ch> <CAOf5uwkr0Rmb_x0U88JAfozCQpkOoFOZ-V7BNteVZfcnNQF-Lw@mail.gmail.com>
In-Reply-To: <CAOf5uwkr0Rmb_x0U88JAfozCQpkOoFOZ-V7BNteVZfcnNQF-Lw@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 28 Jan 2026 22:20:53 +0100
X-Gm-Features: AZwV_QiIFrADFNxzm5F2oW2aYAjM_EJ9TkrxZD9o4caIe8dShn0VnY7xFM5-uBY
Message-ID: <CAOf5uwmzRfB-8qJPtgoCjV++TTTBawvifhuw_x08f=ehw6Rknw@mail.gmail.com>
Subject: Re: [RFC PATCH] net: phy: integrate reset-after-clock quirk into phy_init_hw
To: Andrew Lunn <andrew@lunn.ch>
Cc: Marco Felsch <m.felsch@pengutronix.de>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, 
	"open list:FREESCALE IMX / MXC FEC DRIVER" <imx@lists.linux.dev>, 
	"open list:FREESCALE IMX / MXC FEC DRIVER" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[amarulasolutions.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amarulasolutions.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-254469-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[pengutronix.de,armlinux.org.uk,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael@amarulasolutions.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amarulasolutions.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,0.0.0.0:email,mail.gmail.com:mid,amarulasolutions.com:email,amarulasolutions.com:url,amarulasolutions.com:dkim,lunn.ch:email,panicking:email]
X-Rspamd-Queue-Id: BB6C3A9110
X-Rspamd-Action: no action

Hi

On Wed, Jan 28, 2026 at 10:04=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> On Wed, Jan 28, 2026 at 9:51=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrot=
e:
> >
> > > The issue was with the out-of-band reset coming from the FEC driver
> > > which doesn't honor the phy state-machine.
> >
> > Could you explain this is more details. Is the FEC doing something
> > wrong?
>
> The fact that the phy should be reset when the clk is provided to it, is =
not
> connected at all with the fec. I think that fec_main does not register it=
self
> as clock provider, You "should" define the phy to have a clock if this is=
 needed
> during the restoration and we should not give any "magic" at controller l=
evel.
>
> * Marco * Your commit bedd8d78aba300860cec3f85d6ff549b3b7f2679 is clear
> and I have tried to use it but if I remember the problem is the clock
> is provided
> by the ethernet controller.

I have created this patch at that time but not solving it:

panicking@panicking:~/work/wandh/distro/linux-wh$ git show
bfe2e98b653637526213ba06dee92d2cf1f678b4
commit bfe2e98b653637526213ba06dee92d2cf1f678b4
Author: Michael Trimarchi <michael@amarulasolutions.com>
Date:   Sat Aug 23 09:34:22 2025 +0200

    ARM: dts: imx6ull-mrmmi: Describe the Ethernet PHY clock

    From d65af21842f8 ("net: phy: smsc: LAN8710/20: remove
PHY_RST_AFTER_CLK_EN flag"),
    the lan phy is not always reset the correct way and let time to time ph=
y
    not configured.

    Change-Id: I21549981bdca7581dc65acf06007136c24be5d56
    Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-mrmmi.dtsi
b/arch/arm/boot/dts/nxp/imx/imx6ull-mrmmi.dtsi
index 03a870e317cd..0a1618ced6aa 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-mrmmi.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-mrmmi.dtsi
@@ -237,6 +237,8 @@ mdio {
                ethphy0: ethernet-phy@0 {
                        compatible =3D "ethernet-phy-ieee802.3-c22";
                        reg =3D <0>;
+                       clocks =3D <&clks IMX6UL_CLK_ENET_REF>;
+                       clock-names =3D "rmii-ref";
                        reset-gpios =3D <&gpio5 9 GPIO_ACTIVE_LOW>;
                        reset-assert-us =3D <4000>;
                        reset-deassert-us =3D <4000>;

Michael

>
> Michael
>
>
> >
> >         Andrew
>
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

