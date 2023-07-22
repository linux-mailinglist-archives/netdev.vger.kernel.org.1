Return-Path: <netdev+bounces-20149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8CB75DE02
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 20:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58EE281E70
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 18:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4E2626;
	Sat, 22 Jul 2023 18:01:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3557F
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 18:01:15 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E8D2137
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 11:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1690048846; x=1690653646; i=frank-w@public-files.de;
 bh=fyCHIv32ppf15FXTHxcSYZOOeLtE19Mjk0jVgTAGIGA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TgHiuPUJGv4V8FV5MmPkKSrWR+d9FbWAM6bCuCvx5zY6uMfBbUsinEcDLhSogjEa6TuA7hE
 DdJ1ueDoaHBxXlMCnyhVYAgSycRCPQBeEh1XDhje5gX/IGUj9j1ZOi+oQ5GYPjiExhiIeJhfp
 Dk3iezbhV9hOiqVp9uQ+PUdc59GhM/ClRMdsfaUMBh+xINx9aixwaNaaCJa7nGQEKI+9muiKl
 0OkOt5oz8k+puCuwqFjY2XE1QHYHYJ8cVGxxLJakFrc5djNiz4eJgPaXQAwwoIX6E6fjacuwH
 SSOggAIJFCs4gBos3J7Pp0Rklp81HPhRfXqJOOJNhOM5ciL8OoQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [80.245.78.13] ([80.245.78.13]) by web-mail.gmx.net
 (3c-app-gmx-bs09.server.lan [172.19.170.60]) (via HTTP); Sat, 22 Jul 2023
 20:00:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-f1c6da4d-e12d-474a-8d18-e1328c47f771-1690048846519@3c-app-gmx-bs09>
From: Frank Wunderlich <frank-w@public-files.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, David
 Woodhouse <dwmw@amazon.co.uk>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Felix Fietkau
 <nbd@nbd.name>, Jakub Kicinski <kuba@kernel.org>, John Crispin
 <john@phrozen.org>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>,
 Mark Lee <Mark-MC.Lee@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>
Subject: Aw: Re: Re: [PATCH net-next 0/4] Remove legacy phylink behaviour
Content-Type: text/plain; charset=UTF-8
Date: Sat, 22 Jul 2023 20:00:46 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <ZLwAdTvTIH3VakJS@shell.armlinux.org.uk>
References: <ZLptIKEb7qLY5LmS@shell.armlinux.org.uk>
 <ZLsJWXyFJ0oKLkEq@makrotopia.org>
 <trinity-d3292c8a-89e4-4d5e-838f-cdf1f65ff58b-1690029105348@3c-app-gmx-bs12>
 <ZLwAdTvTIH3VakJS@shell.armlinux.org.uk>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:3wJAnxuAhvq9bmn1pci7P5WqtopOjd041zylrF5h6TPpok9crfTtQMcNss38DCVTftubX
 iMs/xz1f52UCqtk7jOIH4e9P9S4XRUV51YwsGYNSu9907bJWP62kCQ8bPUKzDIWXgjVAgNmsxCdY
 I1V5ZrAhhdg/bvV78xdHRCYVry3B2nYNDWGmRJDTRhrcOEq49OwoZA8XcAX0BKZ0+5yTv7N0T+/E
 +pzV9d6lw77EN+daNrY72YR+B3+tMooDrzksVESthaHRDc5ov3Y2B5jIYhgONaucnH0wK4ECaCN8
 WY=
UI-OutboundReport: notjunk:1;M01:P0:e6iXXcz9Eb0=;uj+G0GZvH1RP3aLPnCf5F+jD8Ac
 F7z5SaeyVCqir+W2ulq08+mYTNpXbpkQh515e2WMdEAAtJygp7Y8y8aCrLf9IePvj76oooHFa
 sOcAtc9NUZOcmwdQNCIPY0YZAywj+aGQnFkpOzKOru5u8BDg4ky1OuzclOhRezFZfiMFOiztY
 G5GGsx4k5vRE81XG/ROlc90CNW6KadVcljeOkNvb5TzzZfa8AZF+r7SW1Pppint8ETCQn/1MY
 XmRnmbLzH8uN3llt7xSa5BdkPJawV4CN8OJ71lFeZ/RkapwpbwFZIfJnvNli8wZdRe98TJ7mh
 5L18PkQ2f2l1xUlK7aHPuuBdn+KWIRbW8EnXV6gftOWGEtVIhTi/qPsYoTLGXDQrlPbRDO1pj
 QbUbIBO5MwSYHbkGyJgYkg+EZqjl4JjuPtEtyxKm6VxzUSpmH59olMoaMHZeVLraLqsQFoAYY
 +LHLg6sGXCBdo7jDWjnYn07dkmA2R8JsJtfO6xOaHGVZMXxa0fkb2w/mN6/fMCfgcyy6TWE2n
 yq0MwOPx39jsqZ29Kyvujwn90m1/1Lo7SBZ/rBhtt9ZivZJCOuUSpXK0ico0RzgC0qIwgVlD0
 +rl2IT1bs8XTIVFJAAlhETkTISneZzWKf1E0d7jPFeA502LxM1Yvv8j2bWaTeSrz2RL/TUeTa
 0tv+6HVdEnSl+SIFoA1vchP6Z68paui6pkOuWQEp368HlViyrgE4/CkhBsOyZN5w6yrl3kw7t
 MNUPhqQZe4+UXH/tAR+VKnNBizbgql+qhJd/WLIh1yWsNHW7oKYOUDyIs7xIoi+VP9b8LbjM9
 9YLQmCzXOFbVSfk8wvIsDKBg==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> Gesendet: Samstag, 22. Juli 2023 um 18:14 Uhr
> Von: "Russell King (Oracle)" <linux@armlinux.org.uk>
>
> On Sat, Jul 22, 2023 at 02:31:45PM +0200, Frank Wunderlich wrote:
> > Hi
> >
> > > Gesendet: Samstag, 22. Juli 2023 um 00:40 Uhr
> > > Von: "Daniel Golle" <daniel@makrotopia.org>
> > >
> > > Hi Russell,
> > >
> > > On Fri, Jul 21, 2023 at 12:33:52PM +0100, Russell King (Oracle) wrot=
e:
> > > > Hi,
> > > >
> > > > This series removes the - as far as I can tell - unreachable code =
in
> > > > mtk_eth_soc that relies upon legacy phylink behaviour, and then re=
moves
> > > > the support in phylink for this legacy behaviour.
> > > >
> > > > Patch 1 removes the clocking configuration from mtk_eth_soc for no=
n-
> > > > TRGMII, non-serdes based interface modes, and disables those inter=
face
> > > > modes prior to phylink configuration.
> > > >
> > > > Patch 2 removes the mac_pcs_get_state() method from mtk_eth_soc wh=
ich
> > > > I believe is also not used - mtk_eth_soc appears not to be used wi=
th
> > > > SFPs (which would use a kind of in-band mode) nor does any DT appe=
ar
> > > > to specify in-band mode for any non-serdes based interface mode.
> > > >
> > > > With both of those dealt with, the kernel is now free of any drive=
r
> > > > relying on the phylink legacy mode. Therefore, patch 3 removes sup=
port
> > > > for this.
> > > >
> > > > Finally, with the advent of a new driver being submitted today tha=
t
> > > > makes use of state->speed in the mac_config() path, patch 4 ensure=
s that
> > > > any phylink_link_state member that should not be used in mac_confi=
g is
> > > > either cleared or set to an invalid value.
> > >
> > > Thank you for taking care of this!
> >
> > > For the whole series:
> > >
> > > Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> > > Tested-by: Daniel Golle <daniel@makrotopia.org>
> > >
> > > Tested on BPi-R2 (MT7623N), BPi-R3 (MT7986A) and BPi-R64 (MT7622A).
> > > All works fine as expected.
> >
> > have you changed anything?
> >
> > in my test with bpi-r2 i see boot hangs after link-up on my wan-port (=
still trgmii-mode configured), no access to userspace.
> >
> > [   10.881844] mtk_soc_eth 1b100000.ethernet eth0: configuring for fix=
ed/trgmii link mode
> > [   10.891611] mtk_soc_eth 1b100000.ethernet eth0: Link is Up - 1Gbps/=
Full - flow control rx/tx
> > [   11.005814] mt7530-mdio mdio-bus:1f wan: configuring for phy/gmii l=
ink mode
> > [   11.016654] mt7530-mdio mdio-bus:1f lan3: configuring for phy/gmii =
link mode
> > [   11.025685] mt7530-mdio mdio-bus:1f lan2: configuring for phy/gmii =
link mode
> > [   11.035122] mt7530-mdio mdio-bus:1f lan1: configuring for phy/gmii =
link mode
> > [   11.045370] mt7530-mdio mdio-bus:1f lan0: configuring for phy/gmii =
link mode
> >
> > [   15.144255] mt7530-mdio mdio-bus:1f wan: Link is Up - 1Gbps/Full - =
flow control rx/tx
> >
> > removing the cable does not show link down so it looks like completely=
 stalled...but also no panic/crash or similar.
> > When booting without cable it hangs too (without the up-message of cou=
rse).
> >
> > > To apply the series I needed to resolve a minor conflict due to
> > > net: ethernet: mtk_ppe: add MTK_FOE_ENTRY_V{1,2}_SIZE macros
> > > being applied in the meantime.
> >
> > i used yesterdays net-next (6.5-rc2) and put series on top (also neede=
d to do one hunk of first patch manually) and
> > then my defconfig,buildscript etc. maybe i miss anything?
> >
> > afair trgmii is basicly rgmii only with higher clock-setting...and if =
this is dropped from mac-driver but switch is still using it it cannot wor=
k, but i'm sure you know this ;)
>
> Have you tried bisecting the four patches? Does that give any hints?
> Does the net-next base you used boot successfully?

sorry, hang was caused by me (missing rootfs and wait in bootargs).

only see throughput of only ~850Mbit (tx) and 900Mbit (rx)..wan is on eth0=
 which is the trgmii one, but without the patches it is similar (quicktest=
ed 6.3-rc1 i had already on this card which has similar results)

so for me it looks good so far...i'm not sure we had more than 900 anytime=
 on this device...

regards Frank

