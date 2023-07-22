Return-Path: <netdev+bounces-20132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B1075DC8A
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 14:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7536C1C20F1E
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 12:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EBC19BDB;
	Sat, 22 Jul 2023 12:32:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD530DF44
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 12:32:23 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEB5E0
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 05:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1690029105; x=1690633905; i=frank-w@public-files.de;
 bh=rvO3syQy8p2eF0WNoTmES9a/lxxiAQ0F3RORzZidV/A=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mBtI/5RpZrvQPPlOCFyKZzPGnjq+OLOgS7RYVmQAP/OvhJijbIR5NzMHyE1mHQPYITvwsZk
 qQI2SSVT4aZprIgWFI0bFSEdd8oN8tM8/m3M/Gl/4tPqo0OpXIjkXwcWotP+VSf1n4EGBKDa0
 8NBd+INESIYJtlD0tqyM7GsoU8P5MTk9BpZafdd10PVYZqLLSpJNzPko+GsVbmIYgNIV6wGPa
 MI3xR8R+tikS1/VovN+UpKrsk3zOIW76Hk79ly9kXda3e/joadAjJ6WNFmos2U22sTzwpDo23
 PbY8qzbHa+NlPFqQ+CaAEfK8F5my8MziMe8fErb638sAA/DubDPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [80.245.78.13] ([80.245.78.13]) by web-mail.gmx.net
 (3c-app-gmx-bs12.server.lan [172.19.170.63]) (via HTTP); Sat, 22 Jul 2023
 14:31:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-d3292c8a-89e4-4d5e-838f-cdf1f65ff58b-1690029105348@3c-app-gmx-bs12>
From: Frank Wunderlich <frank-w@public-files.de>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
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
Subject: Aw: Re: [PATCH net-next 0/4] Remove legacy phylink behaviour
Content-Type: text/plain; charset=UTF-8
Date: Sat, 22 Jul 2023 14:31:45 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <ZLsJWXyFJ0oKLkEq@makrotopia.org>
References: <ZLptIKEb7qLY5LmS@shell.armlinux.org.uk>
 <ZLsJWXyFJ0oKLkEq@makrotopia.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:FnS5gDkMzYIQdXsIBbt3U8OtC9v3S7ceUa6YEWbss5Uaquf3VQO93KSSQL++J1XtkwlDT
 Jk6B/EYF6IsYrQ0EdZTY9yWzv5FQt3kC2OszjU6Po/DFHYuenqw3Q419uvTTetn5lqAog99X6KZ9
 kGMCzr9ZrRqKSI/h36wUvxuE4NVqBKr6DDSkibk4zRZbAEvNjTFjlFVoyx2bPJpgLKVS/A1cMudw
 yWRM8vxT6CwzUPEPMnCbkFZGpL9Y867p2uhaDsZiUutpv/vFcn0H3P88bz/zysaLkwAcr3LWHfP5
 ck=
UI-OutboundReport: notjunk:1;M01:P0:9nB3fUsKP2U=;ozWUwmE2EsqZM/7jmqJykWNGVQO
 A5bfnWipOw/j/k9aH3UPdFBPzdzFDEJgy2DI2zUJEgGewpzB9hjdGpaYiaAmkBPgQyNYkMzLg
 rbdz7KSKNPfHKMp8WkPIP7ruibNFydltW3s2nbsVJtkQxJfjKf12jIAnBPcY6ggiQAYpxfg0b
 tHXyL5XAUXgNz+gzT42FrnKlGEoeHaknbKIA/GJ/jRNu4o8RTIi15Y71ArEAhWq5InLV2okmA
 hXNHcvEoD01vs/6MZr2o5IKrZbCMt0oiiV6L9HA69jePO5b9NzBjCLEdAbqMu5SAbvpTbikrK
 T2s4BJi6WJS7+VQXX93yoy1/YrmWNaIFJiN/19w3lyOeXCuwJFqsNZDnF6vXjSqZHr5S+A4up
 dE3dkRUFbkZVEae0pS+iSQlSSjipiTjm7oY5U6L+/nX11egyKOBKL8aMdgxK591VmO5e5lW8G
 1Dcp2ucK26lTUEAzVtSQYLucOOcmYamnLSj9yemjBVeTk8hT8jhbP7t3q+NOgBHjFN7yaG5dy
 dNq3DdYk1fq42w+IZ4++7Y869/D/jOwk0Xw0aW03ZHsbq3g9jr5EK+p4I4vMVbjUU1SIDik2g
 V3GBU9xQScLRGiLYItxgr5YuJBcaD09TjW//7Y7pyfeGYKHRyC0OctLh2xpBI75S/Q5wdWT3k
 081g6OH1ciaFxOIHAfwoqRG/eyIV0bqur+DIWcfNejiwsAH0/tE3tPBPSffMs3cWB8+TZRK36
 hgomKW/vcHUE1sSMtK5tWkTEq+wM3w3n1kgVjSM+u6585j2sjqwNnQnBMkzc6CIncwwKZGyAg
 RhcEZ4Ph4WlAWMiwxhgtCJpA==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi

> Gesendet: Samstag, 22. Juli 2023 um 00:40 Uhr
> Von: "Daniel Golle" <daniel@makrotopia.org>
>
> Hi Russell,
>
> On Fri, Jul 21, 2023 at 12:33:52PM +0100, Russell King (Oracle) wrote:
> > Hi,
> >
> > This series removes the - as far as I can tell - unreachable code in
> > mtk_eth_soc that relies upon legacy phylink behaviour, and then remove=
s
> > the support in phylink for this legacy behaviour.
> >
> > Patch 1 removes the clocking configuration from mtk_eth_soc for non-
> > TRGMII, non-serdes based interface modes, and disables those interface
> > modes prior to phylink configuration.
> >
> > Patch 2 removes the mac_pcs_get_state() method from mtk_eth_soc which
> > I believe is also not used - mtk_eth_soc appears not to be used with
> > SFPs (which would use a kind of in-band mode) nor does any DT appear
> > to specify in-band mode for any non-serdes based interface mode.
> >
> > With both of those dealt with, the kernel is now free of any driver
> > relying on the phylink legacy mode. Therefore, patch 3 removes support
> > for this.
> >
> > Finally, with the advent of a new driver being submitted today that
> > makes use of state->speed in the mac_config() path, patch 4 ensures th=
at
> > any phylink_link_state member that should not be used in mac_config is
> > either cleared or set to an invalid value.
>
> Thank you for taking care of this!

> For the whole series:
>
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> Tested-by: Daniel Golle <daniel@makrotopia.org>
>
> Tested on BPi-R2 (MT7623N), BPi-R3 (MT7986A) and BPi-R64 (MT7622A).
> All works fine as expected.

have you changed anything?

in my test with bpi-r2 i see boot hangs after link-up on my wan-port (stil=
l trgmii-mode configured), no access to userspace.

[   10.881844] mtk_soc_eth 1b100000.ethernet eth0: configuring for fixed/t=
rgmii link mode
[   10.891611] mtk_soc_eth 1b100000.ethernet eth0: Link is Up - 1Gbps/Full=
 - flow control rx/tx
[   11.005814] mt7530-mdio mdio-bus:1f wan: configuring for phy/gmii link =
mode
[   11.016654] mt7530-mdio mdio-bus:1f lan3: configuring for phy/gmii link=
 mode
[   11.025685] mt7530-mdio mdio-bus:1f lan2: configuring for phy/gmii link=
 mode
[   11.035122] mt7530-mdio mdio-bus:1f lan1: configuring for phy/gmii link=
 mode
[   11.045370] mt7530-mdio mdio-bus:1f lan0: configuring for phy/gmii link=
 mode

[   15.144255] mt7530-mdio mdio-bus:1f wan: Link is Up - 1Gbps/Full - flow=
 control rx/tx

removing the cable does not show link down so it looks like completely sta=
lled...but also no panic/crash or similar.
When booting without cable it hangs too (without the up-message of course)=
.

> To apply the series I needed to resolve a minor conflict due to
> net: ethernet: mtk_ppe: add MTK_FOE_ENTRY_V{1,2}_SIZE macros
> being applied in the meantime.

i used yesterdays net-next (6.5-rc2) and put series on top (also needed to=
 do one hunk of first patch manually) and
then my defconfig,buildscript etc. maybe i miss anything?

afair trgmii is basicly rgmii only with higher clock-setting...and if this=
 is dropped from mac-driver but switch is still using it it cannot work, b=
ut i'm sure you know this ;)

regards Frank

