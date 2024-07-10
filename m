Return-Path: <netdev+bounces-110550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA42392D07A
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E32528A7A7
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 11:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150CB18FDC4;
	Wed, 10 Jul 2024 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="rCWjRU63"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E3439FD9;
	Wed, 10 Jul 2024 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720610316; cv=none; b=YaqDG0pg9Gy7EG0225AY3E7ASzWY9HYmSWlOpjDDOjOLRJyuHknkvCZncHc5XgE9ZkCoFFFMH2vhv2vdfIzmUvnwLteTtcF+yQ5aSZT7XkOHTHS0ClO/xyl0zemexr1tOKtezH6ZA4IHnIDocfQg6wK+HQ5hSwGDLv8qKrcxMe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720610316; c=relaxed/simple;
	bh=/ZTJ7fTPCEnisQs345orW0oeonVYxB7ONFLGm1Unb9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gaKT16/PSwueW9vdKboV6Qp7X1TNuZdNAYA/gP7iRd9d842JKchu58iDgvK07ghzsI/KqHFMe2ixhaqMAH1xYSGGZ+xl5MKAsuzQs+HCgNYmBgzGlc0gsiTYuXjYqzER9Q6M32zeTw8dLfDlNem6SKK7YEt9E2v2atqaB5+LlKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=rCWjRU63; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1720610278; x=1721215078; i=frank-w@public-files.de;
	bh=2XG22J089mzPI+eK2EL6VTNdwoAgCyY6nPbb0hFmE0w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Reply-To:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rCWjRU635CskmmnrLs3LCn5DWPuPVk1KZgNxBy/KKdpBrSrO09qzTYYISsPI/eXX
	 JpRk0ZKpOB4Aa3LSKlowLW9CRkflJW1wh29srOXGbjWQ0+ZBaXwYBsa80xyGGE/GY
	 dUiJfLlUwZ9gRTeto9f/AKRlaXoxZCDkCl79XdlG4iM1ELbPggpLGzL9O8gvqe96l
	 cMrnLmmg0bmxy4s1Cflc/RpA2ZfEy9b/62HjY8GFKU/0Ufxvx15KY1ycfDv1FUl1y
	 MP8D1Pb1NRUJsfMlE0kqogrlLJvYBMSyp03Yc23/VnbIB3+J/j6wS8OtqddOTN5oU
	 qIwUzNZeMpiZ9rNp0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.21] ([217.61.158.245]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGNC-1shNkx2uEI-00QRxs; Wed, 10
 Jul 2024 13:17:57 +0200
Message-ID: <89bd21ac-78f3-4ee4-9899-83f03169e647@public-files.de>
Date: Wed, 10 Jul 2024 13:17:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v3 3/8] net: pcs: pcs-mtk-lynxi: add platform
 driver for MT7988
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 John Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>,
 Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexander Couzens <lynxis@fe80.eu>, Qingfang Deng <dqfext@gmail.com>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>
References: <cover.1702352117.git.daniel@makrotopia.org>
 <8aa905080bdb6760875d62cb3b2b41258837f80e.1702352117.git.daniel@makrotopia.org>
 <ZXnV/Pk1PYxAm/jS@shell.armlinux.org.uk> <ZcLc7vJ4fPmRyuxn@makrotopia.org>
 <ZiaPHWXU-82QMrMt@makrotopia.org>
Content-Language: en-US
Reply-To: frank-w@public-files.de
From: Frank Wunderlich <frank-w@public-files.de>
In-Reply-To: <ZiaPHWXU-82QMrMt@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qt60yZYKSQkkT7n/BfAs9kWOlcgtz22v1MQ50bZlSfRvgTs1NnN
 HnEPP370x+qDM8QXkXyc4jXuZu41jmePc3OvBy5lRSAyZNAc2sEij6tQIhZ5WAXKIoZJItc
 FYlG8njZjCk5QP7hCTtZJpIiCnA5oKV8EVSfcxY+MiX3itSXwK5AKPdhwAne+q9bRqz174I
 qEhPl8jH8QaF1I5rGe7lw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yIhczklmtWY=;4Le2aGlTYSHVWdPINKU4YngjsZF
 ytIId6tTei0mhjJ671nCuvXPPchA/QO28kXkOerm2Qy/ZrxsJazWksSlINxjPLq+X8bL/AEAo
 YGv2oS77VR7Ni2ei8S90TFi+LiS6uZvlccFhc4xK8FOTFnza22INrTxJoJb1EYtCwPTeeb4xS
 zVd2vbLRK0XJS72LT/J8wXbjJT9DUjmC27i4HFtOjIBzzftutmjmchtn4H110S3PeStQsgSk/
 RkPnzKhOvrJ1rRyKQIU3r02c88wi8f0O+HvaXjQZozrIDaPeZYim3UJh6m2s4yif0QaG2BsVA
 o1zlcacwLQtxpQjmRm3HHu979F4tIQcnM91VjDp7r0hcciUgCtX5f+DMslF2Upj6CXdeOtWIS
 tTzIs+XqWX43YA3JIFX7vqdJYbB4MVhA7mbyYNldeE2MKrXmhkV+jZgAqR4r7YYPuUyezVN8s
 biMgBjeGLXs3cwp6t6WnRDhIlPhiL13S4ytdkLLMkj51a5xO6sy+G5+JREm1DiT3VUASGdt81
 uexTy+AHCy0TJ4XY+cb1fbFk0kP0YvbOdLiADMOpWGIqwDb4RAIz402NqZXgFF+Mh576jA/pW
 D5HT9yrwa+vJNxji9q7xvdMjE4ypn7ci7K3hLNXQngZhQD1GjMRz1Eps9BX5fSRqpl4CCQm4L
 YcD0iVwmI3fBbmpD8L6hrmv0I4/tU2bcxbXU/wgZNSVJOy+LC3t20q1IdB3P3rXxOV1K1XA6N
 VkTERSTgl3zLsqdk6pgppr3p0CaUxBrpgNntOuACFIdlABnU718W44G7Qx6IHstq4GcglOX88
 QfcwspE4uxy27zLmC/mesR1cjF4v6Lb8mMEt/OnTaPyh4=

Hi Russel / netdev

how can we proceed here? development for mt7988/Bpi-R4 is stalled here
because it is unclear what's the right way to go...

We want to avoid much work adding a complete new framework for a "small"
change (imho this affects all SFP-like sub-devices and their linking to
phylink/pcs driver)...if this really the way to go then some boundary
conditions will be helpful.

regards Frank

Am 22.04.24 um 18:24 schrieb Daniel Golle:
> Hi Russell,
> Hi netdev crew,
>
> I haven't received any reply for this email and am still waiting for
> clarification regarding how inter-driver dependencies should be modelled
> in that case of mtk_eth_soc. My search for good examples for that in the
> kernel code was quite frustrating and all I've found are supposedly bugs
> of that exact cathegory.
>
> Please see my questions mentioned in the previous email I've sent and
> also a summary of suggested solutions inline below:
>
> On Wed, Feb 07, 2024 at 01:29:18AM +0000, Daniel Golle wrote:
>> Hi Russell,
>>
>> sorry for the extended time it took me to get back to this patch and
>> the comments you made for it. Understanding the complete scope of the
>> problem took a while (plus there were holidays and other fun things),
>> and also brought up further questions which I hope you can help me
>> find good answers for, see below:
>>
>> On Wed, Dec 13, 2023 at 04:04:12PM +0000, Russell King (Oracle) wrote:
>>> On Tue, Dec 12, 2023 at 03:47:18AM +0000, Daniel Golle wrote:
>>>> Introduce a proper platform MFD driver for the LynxI (H)SGMII PCS whi=
ch
>>>> is going to initially be used for the MT7988 SoC.
>>>>
>>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>> I made some specific suggestions about what I wanted to see for
>>> "getting" PCS in the previous review, and I'm disappointed that this
>>> patch set is still inventing its own solution.
>>>
>>>> +struct phylink_pcs *mtk_pcs_lynxi_get(struct device *dev, struct dev=
ice_node *np)
>>>> +{
>>>> +	struct platform_device *pdev;
>>>> +	struct mtk_pcs_lynxi *mpcs;
>>>> +
>>>> +	if (!np)
>>>> +		return NULL;
>>>> +
>>>> +	if (!of_device_is_available(np))
>>>> +		return ERR_PTR(-ENODEV);
>>>> +
>>>> +	if (!of_match_node(mtk_pcs_lynxi_of_match, np))
>>>> +		return ERR_PTR(-EINVAL);
>>>> +
>>>> +	pdev =3D of_find_device_by_node(np);
>>>> +	if (!pdev || !platform_get_drvdata(pdev)) {
>>> This is racy - as I thought I described before, userspace can unbind
>>> the device in one thread, while another thread is calling this
>>> function. With just the right timing, this check succeeds, but...
>>>
>>>> +		if (pdev)
>>>> +			put_device(&pdev->dev);
>>>> +		return ERR_PTR(-EPROBE_DEFER);
>>>> +	}
>>>> +
>>>> +	mpcs =3D platform_get_drvdata(pdev);
>>> mpcs ends up being read as NULL here. Even if you did manage to get a
>>> valid pointer, "mpcs" being devm-alloced could be freed from under
>>> you at this point...
>>>
>>>> +	device_link_add(dev, mpcs->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
>>> resulting in this accessing memory which has been freed.
>>>
>>> The solution would be either to suppress the bind/unbind attributes
>>> (provided the underlying struct device can't go away, which probably
>>> also means ensuring the same of the MDIO bus. Aternatively, adding
>>> a lock around the remove path and around the checking of
>>> platform_get_drvdata() down to adding the device link would probably
>>> solve it.
>>>
>>> However, I come back to my general point - this kind of stuff is
>>> hairy. Do we want N different implementations of it in various drivers
>>> with subtle bugs, or do we want _one_ implemenatation.
>>>
>>> If we go with the one implemenation approach, then we need to think
>>> about whether we should be using device links or not. The problem
>>> could be for network interfaces where one struct device is
>>> associated with multiple network interfaces. Using device links has
>>> the unfortunate side effect that if the PCS for one of those network
>>> interfaces is removed, _all_ network interfaces disappear.
>> I agree, esp. on this MT7988 removal of a PCS which may then not
>> even be in use also impairs connectivity on the built-in gigE DSA
>> switch. It would be nice to try to avoid this.
>>
>>> My original suggestion was to hook into phylink to cause that to
>>> take the link down when an in-use PCS gets removed.
>> I took a deep dive into how this could be done correctly and how
>> similar things are done for other drivers. Apart from the PCS there
>> often also is a muxing-PHY involved, eg. MediaTek's XFI T-PHY in this
>> case (previously often called "pextp" for no apparent reason) or
>> Marvell's comphy (mvebu-comphy).
>>
>> So let's try something simple on an already well-supported platform,
>> I thought and grabbed Marvell Armada CN9131-DB running vanilla Linux,
>> and it didn't even take some something racy, but plain:
>>
>> ip link set eth6 up
>> cd /sys/bus/platform/drivers/mvebu-comphy
>> echo f2120000.phy > unbind
>> echo f4120000.phy > unbind
>> echo f6120000.phy > unbind
>> ip link set eth6 down
>>
>>
>> That was enough. The result is a kernel crash, and the same should
>> apply on popular platforms like the SolidRun MACCHIATOBin and other
>> similar boards.
>>
>> So this gets me to think that there is a wider problem around
>> non-phylink-managed resources which may disappear while in use by
>> network drivers, and I guess that the same applies in many other
>> places. I don't have a SATA drive connected to that Marvell board, but
>> I can imagine what happens when suddenly removing the comphy instance
>> in charge of the SATA link and then a subsequent SATA hotplug event
>> happens or stuff like that...
>>
>> Anyway, back to network subsystem and phylink:
>>
>> Do you agree that we need a way to register (and unregister) PCS
>> providers with phylink, so we don't need *_get_by_of_node implementatio=
ns
>> in each driver? If so, can you sketch out what the basic requirements
>> for an acceptable solution would be?
>>
>> Also, do you agree that lack of handling of disappearing resources,
>> such as PHYs (*not* network PHYs, but PHYs as in drivers/phy/*) or
>> syscons, is already a problem right now which should be addressed?
>>
>> If you imagine phylink to take care of the life-cycle of all link-
>> resources, what is vision about those things other than classic MDIO-
>> connected PHYs?
>>
>> And well, of course, the easy fix for the example above would be:
>> diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy=
/marvell/phy-mvebu-cp110-comphy.c
>> index b0dd133665986..9517c96319595 100644
>> --- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
>> +++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
>> @@ -1099,6 +1099,7 @@ static const struct of_device_id mvebu_comphy_of_=
match_table[] =3D {
>>   MODULE_DEVICE_TABLE(of, mvebu_comphy_of_match_table);
>>
>>   static struct platform_driver mvebu_comphy_driver =3D {
>> +	.suppress_bind_attrs =3D true,
>>   	.probe	=3D mvebu_comphy_probe,
>>   	.driver	=3D {
>>   		.name =3D "mvebu-comphy",
>>
>> But that should then apply to every single driver in drivers/phy/...
>>
> My remaining questions are:
>   - Is it ok to just use .suppress_bind_attrs =3D true for PCS and PHY
>     drivers to avoid having to care out hot-removal?
>     Those components are anyway built-into the SoC so removing them
>     is physically not possible.
>
>   - In case of driver removal (rmmod -f) imho using a device-link would
>     be sufficient to prevent the worst. However, we would have to live
>     with the all-or-nothing nature of that approach, ie. once e.g. the
>     USXGMII driver is being removed, *all* Ethernet interfaces would
>     disappear with it (even those not actually using USXGMII).
>
> If the solutions mentioned above do not sound agreeable, please suggest
> how a good solution would look like, ideally also share an example of
> any driver in the kernel where this is done in the way you would like
> to have things done.
>
>>>> +
>>>> +	return &mpcs->pcs;
>>>> +}
>>>> +EXPORT_SYMBOL(mtk_pcs_lynxi_get);
>>>> +
>>>> +void mtk_pcs_lynxi_put(struct phylink_pcs *pcs)
>>>> +{
>>>> +	struct mtk_pcs_lynxi *cur, *mpcs =3D NULL;
>>>> +
>>>> +	if (!pcs)
>>>> +		return;
>>>> +
>>>> +	mutex_lock(&instance_mutex);
>>>> +	list_for_each_entry(cur, &mtk_pcs_lynxi_instances, node)
>>>> +		if (pcs =3D=3D &cur->pcs) {
>>>> +			mpcs =3D cur;
>>>> +			break;
>>>> +		}
>>>> +	mutex_unlock(&instance_mutex);
>>> I don't see what this loop gains us, other than checking that the "pcs=
"
>>> is still on the list and hasn't already been removed. If that is all
>>> that this is about, then I would suggest:
>>>
>>> 	bool found =3D false;
>>>
>>> 	if (!pcs)
>>> 		return;
>>>
>>> 	mpcs =3D pcs_to_mtk_pcs_lynxi(pcs);
>>> 	mutex_lock(&instance_mutex);
>>> 	list_for_each_entry(cur, &mtk_pcs_lynxi_instances, node)
>>> 		if (cur =3D=3D mpcs) {
>>> 			found =3D true;
>>> 			break;
>>> 		}
>>> 	mutex_unlock(&instance_mutex);
>>>
>>> 	if (WARN_ON(!found))
>>> 		return;
>>>
>>> which makes it more obvious why this exists.
>> The idea was not only to make sure it hasn't been removed, but also
>> to be sure that what ever the private data pointer points to has
>> actually been created by that very driver.
>>
>> But yes, doing it in the way you suggest will work in the same way,
>> just when having my idea in mind it looks more fishy to use
>> pcs_to_mtk_pcs_lynxi() before we are 100% sure that what we dealing
>> with has previously been created by this driver.
>>
>>
>> Cheers
>>
>>
>> Daniel
>>

