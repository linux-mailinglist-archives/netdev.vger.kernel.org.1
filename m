Return-Path: <netdev+bounces-108369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FFE92391A
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F92B20C3A
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029B314F9E4;
	Tue,  2 Jul 2024 09:05:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC4C14E2E8;
	Tue,  2 Jul 2024 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719911144; cv=none; b=f1/JK/RYiO44TMSX0ap0huGDOem1vwNMCMUzYupCHMoluErTNP47gdasN1xAcYpO/wnDQAr/ZrLi/xRHBSeOydgXdINzPd76ivo+JWA60mmvNb27cQRJDo535sRPnVTuH8YAc07oiFa5M/89bZRR1j84JuM5ByYK2Gh1A2N+qz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719911144; c=relaxed/simple;
	bh=MPRyW1RvhsLIXbCr3vfsubrMJwYXGQhfyrMaSdBpN68=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RFXYqLM1iOHrxRMl/mEGi8v8pgsZvXWSZZqUsm5Tisc/NBohuw+CvHd6Qj/EuYoQ+YogjqJMEr/HmXK2EN61+rC3FEb+6aX93BjjTadMzd3MP5tDt26Urz6BjCF1FFYSdwXbnEOSpM0gG1UgklJwjLCvWrox3V21uypIBGbm0/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_128_GCM_SHA256:128)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sOZS4-00000000346-1GZX;
	Tue, 02 Jul 2024 09:05:28 +0000
Date: Tue, 02 Jul 2024 09:05:19 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: linux-mediatek@lists.infradead.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Elad Yifee <eladwf@gmail.com>
CC: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next=5D_net=3A_ethernet=3A_m?=
 =?US-ASCII?Q?ediatek=3A_Allow_gaps_in_MAC_allocation?=
User-Agent: K-9 Mail for Android
In-Reply-To: <3bda121b-f11d-44d1-a761-15195f8a418c@intel.com>
References: <379ae584cea112db60f4ada79c7e5ba4f3364a64.1719862038.git.daniel@makrotopia.org> <3bda121b-f11d-44d1-a761-15195f8a418c@intel.com>
Message-ID: <C24C4687-1C00-434D-8C37-BDB85E39456C@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 2 July 2024 06:58:22 UTC, Przemek Kitszel <przemyslaw=2Ekitszel@intel=
=2Ecom> wrote:
>On 7/1/24 21:28, Daniel Golle wrote:
>> Some devices with MediaTek SoCs don't use the first but only the second
>> MAC in the chip=2E Especially with MT7981 which got a built-in 1GE PHY
>> connected to the second MAC this is quite common=2E
>> Make sure to reset and enable PSE also in those cases by skipping gaps
>> using 'continue' instead of aborting the loop using 'break'=2E
>>=20
>> Fixes: dee4dd10c79a ("net: ethernet: mtk_eth_soc: ppe: add support for =
multiple PPEs")
>> Suggested-by: Elad Yifee <eladwf@gmail=2Ecom>
>> Signed-off-by: Daniel Golle <daniel@makrotopia=2Eorg>
>> ---
>> Note that this should go to 'net-next' because the commit being fixed
>> isn't yet part of the 'net' tree=2E
>
>makes sense, and the fix is correct, so:
>Reviewed-by: Przemek Kitszel <przemyslaw=2Ekitszel@intel=2Ecom>

Thank you the fast review!

>what about:
>4733=E2=94=82 static int mtk_sgmii_init(struct mtk_eth *eth)
>4734=E2=94=82 {
>4735=E2=94=82         struct device_node *np;
>4736=E2=94=82         struct regmap *regmap;
>4737=E2=94=82         u32 flags;
>4738=E2=94=82         int i;
>4739=E2=94=82
>4740=E2=94=82         for (i =3D 0; i < MTK_MAX_DEVS; i++) {
>4741=E2=94=82                 np =3D of_parse_phandle(eth->dev->of_node, =
"mediatek,sgmiisys", i);
>4742=E2=94=82                 if (!np)
>4743=E2=94=82                         break;
>
>should we also continue here?

Good point=2E As sgmiisys is defined in dtsi it's not so relevant in pract=
ise though, as the SoC components are of course always present even if we d=
on't use them=2E Probably it is still better to not be overly strict on the=
 presence of things we may not even use, not even emit an error message and=
 silently break something else, so yes, worth fixing imho=2E

>
>4744=E2=94=82
>4745=E2=94=82                 regmap =3D syscon_node_to_regmap(np);
>4746=E2=94=82                 flags =3D 0;
>4747=E2=94=82                 if (of_property_read_bool(np, "mediatek,pns=
wap"))
>4748=E2=94=82                         flags |=3D MTK_SGMII_FLAG_PN_SWAP;
>4749=E2=94=82
>4750=E2=94=82                 of_node_put(np);
>4751=E2=94=82
>4752=E2=94=82                 if (IS_ERR(regmap))
>4753=E2=94=82                         return PTR_ERR(regmap);
>4754=E2=94=82
>4755=E2=94=82                 eth->sgmii_pcs[i] =3D mtk_pcs_lynxi_create(=
eth->dev, regmap,
>4756=E2=94=82 eth->soc->ana_rgc3,
>4757=E2=94=82                                                          fl=
ags);
>4758=E2=94=82         }
>4759=E2=94=82
>4760=E2=94=82         return 0;
>4761=E2=94=82 }
>
>

