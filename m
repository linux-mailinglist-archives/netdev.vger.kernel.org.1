Return-Path: <netdev+bounces-132099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE70990635
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3611F216C1
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 14:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1292178EA;
	Fri,  4 Oct 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NxgVCtX+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9FB25570;
	Fri,  4 Oct 2024 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052549; cv=none; b=ZKjfrX4xOCVa8DgWBBYsGrI103FuD3QXR7Zc/4xzQttUiUr7550CqQGfDDijNKlY9iPydg8cKz1KuTj9WDSw2B6psz33gmSMMGkUAIP3ZAjtN7Q+NjSplG6ADCJhkFtFZglgUULBQipaLmosOJNwgvefzYG1ayB5XVQZZg4V/G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052549; c=relaxed/simple;
	bh=NPaGkd9I93kZSAwXcXLVEbGVA36XcmcV1+TSet2nlW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGEqaoT/2VKbeU2mkVJlyYbq4Fr4diEdbWyMekNXrqyQ/PdSI7cTJtQiEf3JbMX1HZuxQIEjKZlfivi27/OA+DFWwEZKboGJx9JpAk4WM9OChthJUeaiKabkARKKvyZ7zL+LB1/LV1jXBVxMI24+gYAGkcY1I4NabMXa55lZ26s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NxgVCtX+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bhFhJmgoa3030ovjWgbnUyD55AMgRVCWwU3cXoQF4ow=; b=NxgVCtX+G/qE6qgSSuqWSlbPDZ
	VfeyeyYLlYE6/Dt2VfieLAedyziM7FLYsVBilNywbeXgt5mVZdWIjTGLfVHHaqoH2zNlUXShoCui2
	VenE8DCoUXCoKN2dijtPHeu8+QkrABHNk5oIupiLUVab6iKK+Rm8diQI3YAGUKfU+JbX4bqpqeeBE
	FN2Bp7sfCfon2JDTJRxJK5E4V1leZteo6aEAdbEVdfW55XB0fSdEdSG3tDQXHzTpJoslxC3RgJVvy
	73m8PhSHLC1JYMaVDr+wxwZvXW8k2kcfkgHPD3R9fl6QQBIAqKzdYzbbUdeu+FOeiiv4c0xNs8e89
	Q1ux6zpA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53032)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1swjOn-00027h-1p;
	Fri, 04 Oct 2024 15:35:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1swjOg-0001FR-1p;
	Fri, 04 Oct 2024 15:35:10 +0100
Date: Fri, 4 Oct 2024 15:35:10 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: Aw: Re: [RFC PATCH net-next v3 3/8] net: pcs: pcs-mtk-lynxi: add
 platform driver for MT7988
Message-ID: <Zv_9HuaHqtgIA4Et@shell.armlinux.org.uk>
References: <cover.1702352117.git.daniel@makrotopia.org>
 <8aa905080bdb6760875d62cb3b2b41258837f80e.1702352117.git.daniel@makrotopia.org>
 <ZXnV/Pk1PYxAm/jS@shell.armlinux.org.uk>
 <ZcLc7vJ4fPmRyuxn@makrotopia.org>
 <ZiaPHWXU-82QMrMt@makrotopia.org>
 <89bd21ac-78f3-4ee4-9899-83f03169e647@public-files.de>
 <trinity-af6fdd0b-b72c-42a9-bbae-af45c02f539f-1728051457848@3c-app-gmx-bs32>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <trinity-af6fdd0b-b72c-42a9-bbae-af45c02f539f-1728051457848@3c-app-gmx-bs32>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi Frank,

Sorry, but I've not been able to look at this, and I've completely lost
all context now. I was diverted onto a high priority work issue for a
while (was it from April to end of June) so didn't have much time
available for mainline work. I then had a much needed holiday (three
weeks) in July. I then had a clear week where I did look at mainline.
Since then, I've had two cataract operations that have made being on the
computer somewhat difficult, and it is only recently that I'm
effectively "back" after what is approximately six months of not having
a lot of bandwidth. I've seen the cataract consultant this morning, and
just found out that my optometrist appointment for Tuesday is too soon
after the cataract operation, and needs to be moved two weeks. The
optometrist doesn't have availability then, so it's going to be another
four weeks. FFS... I wish I'd known, then I could've made an
arrangement with the optometrist months ago for the correct date.

Now, XPCS has introduced a hack in a similar way to what you're trying
to do, but I wasn't able to review it, so it went in. We're heading
towards the situation where every PCS driver is going to have its own
way to look up a PCS registered as a device. This is not going to scale.

We need something better than this - and at the moment that's all I can
say because I haven't given it any more thought beyond that so far.

On Fri, Oct 04, 2024 at 04:17:37PM +0200, Frank Wunderlich wrote:
> Hi netdev,
>=20
> we are still stale in adding pcs driver here...can you please show us the=
 way to go??
>=20
> daniel posted another attempt but this seems also stale.
> https://patchwork.kernel.org/project/netdevbpf/patch/ba4e359584a6b3bc4b34=
70822c42186d5b0856f9.1721910728.git.daniel@makrotopia.org/
>=20
> @Angelo/Matthias, can you help solving this?
>=20
> left full quote below....
>=20
> regards Frank
>=20
> > Gesendet: Mittwoch, 10. Juli 2024 um 13:17 Uhr
> > Von: "Frank Wunderlich" <frank-w@public-files.de>
> > An: "Russell King (Oracle)" <linux@armlinux.org.uk>
> > Cc: "David S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@g=
oogle.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redha=
t.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski" <krzyszto=
f.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>, "Chunfeng=
 Yun" <chunfeng.yun@mediatek.com>, "Vinod Koul" <vkoul@kernel.org>, "Kishon=
 Vijay Abraham I" <kishon@kernel.org>, "Felix Fietkau" <nbd@nbd.name>, "Joh=
n Crispin" <john@phrozen.org>, "Sean Wang" <sean.wang@mediatek.com>, "Mark =
Lee" <Mark-MC.Lee@mediatek.com>, "Lorenzo Bianconi" <lorenzo@kernel.org>, "=
Matthias Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno" <a=
ngelogioacchino.delregno@collabora.com>, "Andrew Lunn" <andrew@lunn.ch>, "H=
einer Kallweit" <hkallweit1@gmail.com>, "Alexander Couzens" <lynxis@fe80.eu=
>, "Qingfang Deng" <dqfext@gmail.com>, "SkyLake Huang" <SkyLake.Huang@media=
tek.com>, "Philipp Zabel" <p.zabel@pengutronix.de>, netdev@vger.kernel.org,=
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel=
@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-phy@lists.i=
nfradead.org, "Daniel Golle" <daniel@makrotopia.org>
> > Betreff: Re: [RFC PATCH net-next v3 3/8] net: pcs: pcs-mtk-lynxi: add p=
latform driver for MT7988
> >
> > Hi Russel / netdev
> >=20
> > how can we proceed here? development for mt7988/Bpi-R4 is stalled here=
=20
> > because it is unclear what's the right way to go...
> >=20
> > We want to avoid much work adding a complete new framework for a "small=
"=20
> > change (imho this affects all SFP-like sub-devices and their linking to=
=20
> > phylink/pcs driver)...if this really the way to go then some boundary=
=20
> > conditions will be helpful.
> >=20
> > regards Frank
> >=20
> > Am 22.04.24 um 18:24 schrieb Daniel Golle:
> > > Hi Russell,
> > > Hi netdev crew,
> > >
> > > I haven't received any reply for this email and am still waiting for
> > > clarification regarding how inter-driver dependencies should be model=
led
> > > in that case of mtk_eth_soc. My search for good examples for that in =
the
> > > kernel code was quite frustrating and all I've found are supposedly b=
ugs
> > > of that exact cathegory.
> > >
> > > Please see my questions mentioned in the previous email I've sent and
> > > also a summary of suggested solutions inline below:
> > >
> > > On Wed, Feb 07, 2024 at 01:29:18AM +0000, Daniel Golle wrote:
> > >> Hi Russell,
> > >>
> > >> sorry for the extended time it took me to get back to this patch and
> > >> the comments you made for it. Understanding the complete scope of the
> > >> problem took a while (plus there were holidays and other fun things),
> > >> and also brought up further questions which I hope you can help me
> > >> find good answers for, see below:
> > >>
> > >> On Wed, Dec 13, 2023 at 04:04:12PM +0000, Russell King (Oracle) wrot=
e:
> > >>> On Tue, Dec 12, 2023 at 03:47:18AM +0000, Daniel Golle wrote:
> > >>>> Introduce a proper platform MFD driver for the LynxI (H)SGMII PCS =
which
> > >>>> is going to initially be used for the MT7988 SoC.
> > >>>>
> > >>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > >>> I made some specific suggestions about what I wanted to see for
> > >>> "getting" PCS in the previous review, and I'm disappointed that this
> > >>> patch set is still inventing its own solution.
> > >>>
> > >>>> +struct phylink_pcs *mtk_pcs_lynxi_get(struct device *dev, struct =
device_node *np)
> > >>>> +{
> > >>>> +	struct platform_device *pdev;
> > >>>> +	struct mtk_pcs_lynxi *mpcs;
> > >>>> +
> > >>>> +	if (!np)
> > >>>> +		return NULL;
> > >>>> +
> > >>>> +	if (!of_device_is_available(np))
> > >>>> +		return ERR_PTR(-ENODEV);
> > >>>> +
> > >>>> +	if (!of_match_node(mtk_pcs_lynxi_of_match, np))
> > >>>> +		return ERR_PTR(-EINVAL);
> > >>>> +
> > >>>> +	pdev =3D of_find_device_by_node(np);
> > >>>> +	if (!pdev || !platform_get_drvdata(pdev)) {
> > >>> This is racy - as I thought I described before, userspace can unbind
> > >>> the device in one thread, while another thread is calling this
> > >>> function. With just the right timing, this check succeeds, but...
> > >>>
> > >>>> +		if (pdev)
> > >>>> +			put_device(&pdev->dev);
> > >>>> +		return ERR_PTR(-EPROBE_DEFER);
> > >>>> +	}
> > >>>> +
> > >>>> +	mpcs =3D platform_get_drvdata(pdev);
> > >>> mpcs ends up being read as NULL here. Even if you did manage to get=
 a
> > >>> valid pointer, "mpcs" being devm-alloced could be freed from under
> > >>> you at this point...
> > >>>
> > >>>> +	device_link_add(dev, mpcs->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> > >>> resulting in this accessing memory which has been freed.
> > >>>
> > >>> The solution would be either to suppress the bind/unbind attributes
> > >>> (provided the underlying struct device can't go away, which probably
> > >>> also means ensuring the same of the MDIO bus. Aternatively, adding
> > >>> a lock around the remove path and around the checking of
> > >>> platform_get_drvdata() down to adding the device link would probably
> > >>> solve it.
> > >>>
> > >>> However, I come back to my general point - this kind of stuff is
> > >>> hairy. Do we want N different implementations of it in various driv=
ers
> > >>> with subtle bugs, or do we want _one_ implemenatation.
> > >>>
> > >>> If we go with the one implemenation approach, then we need to think
> > >>> about whether we should be using device links or not. The problem
> > >>> could be for network interfaces where one struct device is
> > >>> associated with multiple network interfaces. Using device links has
> > >>> the unfortunate side effect that if the PCS for one of those network
> > >>> interfaces is removed, _all_ network interfaces disappear.
> > >> I agree, esp. on this MT7988 removal of a PCS which may then not
> > >> even be in use also impairs connectivity on the built-in gigE DSA
> > >> switch. It would be nice to try to avoid this.
> > >>
> > >>> My original suggestion was to hook into phylink to cause that to
> > >>> take the link down when an in-use PCS gets removed.
> > >> I took a deep dive into how this could be done correctly and how
> > >> similar things are done for other drivers. Apart from the PCS there
> > >> often also is a muxing-PHY involved, eg. MediaTek's XFI T-PHY in this
> > >> case (previously often called "pextp" for no apparent reason) or
> > >> Marvell's comphy (mvebu-comphy).
> > >>
> > >> So let's try something simple on an already well-supported platform,
> > >> I thought and grabbed Marvell Armada CN9131-DB running vanilla Linux,
> > >> and it didn't even take some something racy, but plain:
> > >>
> > >> ip link set eth6 up
> > >> cd /sys/bus/platform/drivers/mvebu-comphy
> > >> echo f2120000.phy > unbind
> > >> echo f4120000.phy > unbind
> > >> echo f6120000.phy > unbind
> > >> ip link set eth6 down
> > >>
> > >>
> > >> That was enough. The result is a kernel crash, and the same should
> > >> apply on popular platforms like the SolidRun MACCHIATOBin and other
> > >> similar boards.
> > >>
> > >> So this gets me to think that there is a wider problem around
> > >> non-phylink-managed resources which may disappear while in use by
> > >> network drivers, and I guess that the same applies in many other
> > >> places. I don't have a SATA drive connected to that Marvell board, b=
ut
> > >> I can imagine what happens when suddenly removing the comphy instance
> > >> in charge of the SATA link and then a subsequent SATA hotplug event
> > >> happens or stuff like that...
> > >>
> > >> Anyway, back to network subsystem and phylink:
> > >>
> > >> Do you agree that we need a way to register (and unregister) PCS
> > >> providers with phylink, so we don't need *_get_by_of_node implementa=
tions
> > >> in each driver? If so, can you sketch out what the basic requirements
> > >> for an acceptable solution would be?
> > >>
> > >> Also, do you agree that lack of handling of disappearing resources,
> > >> such as PHYs (*not* network PHYs, but PHYs as in drivers/phy/*) or
> > >> syscons, is already a problem right now which should be addressed?
> > >>
> > >> If you imagine phylink to take care of the life-cycle of all link-
> > >> resources, what is vision about those things other than classic MDIO-
> > >> connected PHYs?
> > >>
> > >> And well, of course, the easy fix for the example above would be:
> > >> diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/=
phy/marvell/phy-mvebu-cp110-comphy.c
> > >> index b0dd133665986..9517c96319595 100644
> > >> --- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> > >> +++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> > >> @@ -1099,6 +1099,7 @@ static const struct of_device_id mvebu_comphy_=
of_match_table[] =3D {
> > >>   MODULE_DEVICE_TABLE(of, mvebu_comphy_of_match_table);
> > >>  =20
> > >>   static struct platform_driver mvebu_comphy_driver =3D {
> > >> +	.suppress_bind_attrs =3D true,
> > >>   	.probe	=3D mvebu_comphy_probe,
> > >>   	.driver	=3D {
> > >>   		.name =3D "mvebu-comphy",
> > >>
> > >> But that should then apply to every single driver in drivers/phy/...
> > >>
> > > My remaining questions are:
> > >   - Is it ok to just use .suppress_bind_attrs =3D true for PCS and PHY
> > >     drivers to avoid having to care out hot-removal?
> > >     Those components are anyway built-into the SoC so removing them
> > >     is physically not possible.
> > >
> > >   - In case of driver removal (rmmod -f) imho using a device-link wou=
ld
> > >     be sufficient to prevent the worst. However, we would have to live
> > >     with the all-or-nothing nature of that approach, ie. once e.g. the
> > >     USXGMII driver is being removed, *all* Ethernet interfaces would
> > >     disappear with it (even those not actually using USXGMII).
> > >
> > > If the solutions mentioned above do not sound agreeable, please sugge=
st
> > > how a good solution would look like, ideally also share an example of
> > > any driver in the kernel where this is done in the way you would like
> > > to have things done.
> > >
> > >>>> +
> > >>>> +	return &mpcs->pcs;
> > >>>> +}
> > >>>> +EXPORT_SYMBOL(mtk_pcs_lynxi_get);
> > >>>> +
> > >>>> +void mtk_pcs_lynxi_put(struct phylink_pcs *pcs)
> > >>>> +{
> > >>>> +	struct mtk_pcs_lynxi *cur, *mpcs =3D NULL;
> > >>>> +
> > >>>> +	if (!pcs)
> > >>>> +		return;
> > >>>> +
> > >>>> +	mutex_lock(&instance_mutex);
> > >>>> +	list_for_each_entry(cur, &mtk_pcs_lynxi_instances, node)
> > >>>> +		if (pcs =3D=3D &cur->pcs) {
> > >>>> +			mpcs =3D cur;
> > >>>> +			break;
> > >>>> +		}
> > >>>> +	mutex_unlock(&instance_mutex);
> > >>> I don't see what this loop gains us, other than checking that the "=
pcs"
> > >>> is still on the list and hasn't already been removed. If that is all
> > >>> that this is about, then I would suggest:
> > >>>
> > >>> 	bool found =3D false;
> > >>>
> > >>> 	if (!pcs)
> > >>> 		return;
> > >>>
> > >>> 	mpcs =3D pcs_to_mtk_pcs_lynxi(pcs);
> > >>> 	mutex_lock(&instance_mutex);
> > >>> 	list_for_each_entry(cur, &mtk_pcs_lynxi_instances, node)
> > >>> 		if (cur =3D=3D mpcs) {
> > >>> 			found =3D true;
> > >>> 			break;
> > >>> 		}
> > >>> 	mutex_unlock(&instance_mutex);
> > >>>
> > >>> 	if (WARN_ON(!found))
> > >>> 		return;
> > >>>
> > >>> which makes it more obvious why this exists.
> > >> The idea was not only to make sure it hasn't been removed, but also
> > >> to be sure that what ever the private data pointer points to has
> > >> actually been created by that very driver.
> > >>
> > >> But yes, doing it in the way you suggest will work in the same way,
> > >> just when having my idea in mind it looks more fishy to use
> > >> pcs_to_mtk_pcs_lynxi() before we are 100% sure that what we dealing
> > >> with has previously been created by this driver.
> > >>
> > >>
> > >> Cheers
> > >>
> > >>
> > >> Daniel
> > >>
> >
>=20

--=20
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

