Return-Path: <netdev+bounces-197892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51AEADA33E
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 22:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4F13AB21B
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 20:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B0D27E7FC;
	Sun, 15 Jun 2025 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="SnQIebM+"
X-Original-To: netdev@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB426193077;
	Sun, 15 Jun 2025 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750017735; cv=none; b=t9qZyFqZm55ih2ObyqgOBuJ6WReJAbma8uxobf1CDTBjbKjACURlTvbhl0I1UrVzYoiGwyxM/L2be3+JrdMSOyqwscLAq5R+JqakMj2pmnco7X/FwLDMLXWJaJtHymV2ohbfbmlm35XhLlKS/63qZySboxDB0OgMqdVmI41j10Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750017735; c=relaxed/simple;
	bh=vs8jb1PU/vxkiHvNerIZ+GtkHQLrmz7zneV497xt+aA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=L9a/DftrJNw2GleVupBQQEfY29FqrXEHcbBdcGXq4hlICqRd4vSMzwsh3xbrKMJh6H8WDFgWARks8SJZcGUlNyHTwycUek1fpBGhK1+e4eR02s7E1s9qFos33/cpaMaK+ov+jRYMSpGM0Mz6fcUOEH4iLDLN0NubysLtdIqvfdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=SnQIebM+; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
	by mxout3.routing.net (Postfix) with ESMTP id 6324E6022C;
	Sun, 15 Jun 2025 20:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750017729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+pAFU9AytArnIwqdWcPlCccdu0jBWh6uQ/wP44N9Jo=;
	b=SnQIebM+9MKdNtdv9x3At12yoE/FHiYKjhbH68HfMwBOlmVkpOuzTKRvB1Z24RYj+BPSef
	HI+Riy+dj13SXZnMnoiCOcJHPXyn7WeqyA0HQpENSV3rHU2e/aTFyDa/Yiza/xi8bAPU+V
	5kLMeS8lrn3noh0JkNEIu+18Og2Hv2o=
Received: from [127.0.0.1] (fttx-pool-217.61.157.124.bambit.de [217.61.157.124])
	by mxbox4.masterlogin.de (Postfix) with ESMTPSA id 84A6C8034B;
	Sun, 15 Jun 2025 20:02:08 +0000 (UTC)
Date: Sun, 15 Jun 2025 22:02:08 +0200
From: Frank Wunderlich <linux@fw-web.de>
To: Daniel Golle <daniel@makrotopia.org>
CC: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Simon Horman <horms@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5Bnet-next_v3_3/3=5D_net=3A_ethernet=3A_mtk=5Feth=5F?=
 =?US-ASCII?Q?soc=3A_change_code_to_skip_first_IRQ_completely?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aE8ja1fbAtvWx2GN@pidgin.makrotopia.org>
References: <20250615150333.166202-1-linux@fw-web.de> <20250615150333.166202-4-linux@fw-web.de> <aE8ja1fbAtvWx2GN@pidgin.makrotopia.org>
Message-ID: <B8138460-D6EA-4142-B0D9-14C93B15D5B8@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: 9b720d70-be23-44b8-94ac-4f9468184a23

Am 15=2E Juni 2025 21:49:43 MESZ schrieb Daniel Golle <daniel@makrotopia=2E=
org>:
>On Sun, Jun 15, 2025 at 05:03:18PM +0200, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> On SoCs without MTK_SHARED_INT capability (mt7621 + mt7628) the first
>> IRQ (eth->irq[0]) was read but never used=2E Skip reading it now too=2E
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>>  drivers/net/ethernet/mediatek/mtk_eth_soc=2Ec | 11 ++++++++---
>>  drivers/net/ethernet/mediatek/mtk_eth_soc=2Eh |  4 ++--
>>  2 files changed, 10 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc=2Ec b/drivers/ne=
t/ethernet/mediatek/mtk_eth_soc=2Ec
>> index 9aec67c9c6d7=2E=2E4d7de282b940 100644
>> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc=2Ec
>> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc=2Ec
>> @@ -3346,10 +3346,15 @@ static int mtk_get_irqs(struct platform_device =
*pdev, struct mtk_eth *eth)
>>  		return 0;
>> =20
>>  	for (i =3D 0; i < MTK_ETH_IRQ_MAX; i++) {
>> -		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
>> -			eth->irq[i] =3D eth->irq[MTK_ETH_IRQ_SHARED];
>> +		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT)) {
>> +			if (i =3D=3D 0)
>> +				eth->irq[MTK_ETH_IRQ_SHARED] =3D platform_get_irq(pdev, i);
>> +			else
>> +				eth->irq[i] =3D eth->irq[MTK_ETH_IRQ_SHARED];
>> +		} else if (i < 2)  //skip the 1st and 4th IRQ on !MTK_SHARED_INT
>
>Please use conformant comment style, ie=2E do not use '//' but always use
>'/* =2E=2E=2E */' instead, on a dedicated line=2E

Ok,not sure if the comment should stay :)
It was a comment for me and i forgot to remove it=2E

>> +			eth->irq[i] =3D platform_get_irq(pdev, i + 1);
>>  		else
>> -			eth->irq[i] =3D platform_get_irq(pdev, i);
>> +			continue;
>> =20
>>  		if (eth->irq[i] < 0) {
>>  			dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
>> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc=2Eh b/drivers/ne=
t/ethernet/mediatek/mtk_eth_soc=2Eh
>> index 6b1208d05f79=2E=2Eff2ae3c80179 100644
>> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc=2Eh
>> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc=2Eh
>> @@ -643,8 +643,8 @@
>>  #define MTK_MAC_FSM(x)		(0x1010C + ((x) * 0x100))
>> =20
>>  #define MTK_ETH_IRQ_SHARED	0
>> -#define MTK_ETH_IRQ_TX		1
>> -#define MTK_ETH_IRQ_RX		2
>> +#define MTK_ETH_IRQ_TX		0
>> +#define MTK_ETH_IRQ_RX		1
>>  #define MTK_ETH_IRQ_MAX		3
>
>Shouldn't MAX be 1 now?

No as we still need to loop over the first 3 irqs
on the older devicetrees=2E Or was the MAX
intented for anything else (e=2Eg=2E array size for
storing the sw irqs - not changed this yet,but
imho thi should be 2 now if SHARED_INT does
not need 3 entries)?


regards Frank

