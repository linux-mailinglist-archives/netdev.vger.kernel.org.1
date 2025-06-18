Return-Path: <netdev+bounces-199117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C0FADF02F
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181FF3A2BF3
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA9619ABB6;
	Wed, 18 Jun 2025 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="Nbknur+1"
X-Original-To: netdev@vger.kernel.org
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CDAF9CB;
	Wed, 18 Jun 2025 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258224; cv=none; b=PlKglEolCdQFpgZBSkjPWx6cCrlOkA+cuOezxJJRall9xuE2JdotQ7neSQg9gMzpocooqLGdtZ4AqdvI3eKqV31M1QYCKlxNlQ5JpNRx7eogebF/64GKhaQxl6Q1DVfo6GtQt55I42z5cKUK9fVg3+pVPCbmPokfOHOQc9gf1lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258224; c=relaxed/simple;
	bh=fB7KyoRN2gpN9HFgeI9W3VaZODcts6RtL/092DIdZ7o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=dnHhWXbs1AJKIFzNCnObYx3/XIPbPa8jklieErT2x1JJR9l/FVh3WXS/yuZJBUKRb1Mpq83iUjsxTY95QeDCI4Dam+mZ/Ry0tHiNvMmi94xVu0NdH0o3/cRic8a5u7XfwlaK7nnWfdcOAURxIqiCwJZk714FjEqRNdOfpQR4Mj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=Nbknur+1; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout1.routing.net (Postfix) with ESMTP id 3474E41ADE;
	Wed, 18 Jun 2025 14:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750258214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N7tr9vCzas4Dcx7c2Tgeu4LP6gHZKQuy1GdaO/TFlr4=;
	b=Nbknur+18KqPDja5RX/s65/bE/pPe42K7+j6BqbbBZ2lfnz1+IlheE52B92cm6xDpE+eM3
	+1J2JXUED1AfYvVCBLE/WbHiocrItKJfci05mR4apGeGPAdDixOTM5mR2MMA0ap8wmz/zh
	dXnO3+qaeB8OGQJndQ74liL4RhdsOEM=
Received: from [127.0.0.1] (fttx-pool-80.245.76.73.bambit.de [80.245.76.73])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 0453F360048;
	Wed, 18 Jun 2025 14:50:12 +0000 (UTC)
Date: Wed, 18 Jun 2025 16:50:13 +0200
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
 linux-mediatek@lists.infradead.org, Simon Horman <horms@kernel.org>,
 arinc.unal@arinc9.com
Subject: Re: [net-next v5 1/3] net: ethernet: mtk_eth_soc: support named IRQs
User-Agent: K-9 Mail for Android
In-Reply-To: <aFLFYe8mq4tbLfdf@pidgin.makrotopia.org>
References: <20250618130717.75839-1-linux@fw-web.de> <20250618130717.75839-2-linux@fw-web.de> <aFLFYe8mq4tbLfdf@pidgin.makrotopia.org>
Message-ID: <601853CD-F47A-452A-87AC-668E73A3E971@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: e609ebad-906a-455e-bb64-4bc71f18ceb5

Am 18=2E Juni 2025 15:55:45 MESZ schrieb Daniel Golle <daniel@makrotopia=2E=
org>:
>On Wed, Jun 18, 2025 at 03:07:12PM +0200, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Add named interrupts and keep index based fallback for existing
>> devicetrees=2E
>>=20
>> Currently only rx and tx IRQs are defined to be used with mt7988, but
>> later extended with RSS/LRO support=2E
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> Reviewed-by: Simon Horman <horms@kernel=2Eorg>
>> =20
>> +static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *=
eth)
>> +{
>> +	int i;
>> +
>> +	/* future SoCs beginning with MT7988 should use named IRQs in dts */
>> +	eth->irq[1] =3D platform_get_irq_byname(pdev, "tx");
>> +	eth->irq[2] =3D platform_get_irq_byname(pdev, "rx");
>> +	if (eth->irq[1] >=3D 0 && eth->irq[2] >=3D 0)
>> +		return 0;
>
>I'd rather extend that logic and fall back to the legacy way only in case
>of -ENXIO=2E Ie=2E add here:
>
>if (eth->irq[1] !=3D -ENXIO)
>	return eth->irq[1];
>
>if (eth->irq[2] !=3D -ENXIO)
>	return eth->irq[2];

I would do this later after the consts are used
 instead of index numbers,just to not add lines
 that are changed later again=2EBetter adding the
 lines already with the consts=2E

>Maybe also output a warning at this point in case MTK_SHARED_INT is no
>set, to recommend users to update their device tree to named interrupts=
=2E

I understand the reason behind (documentation
 which irq is used for which purpose),but
 previous devicetrees of non-shared SoCs using
 at least the reserved irq 0=2E Mt7986 has 0 and 3
 defined in dts=2E That could be tricky in binding,
 so my way was starting with irq names now for
 new additions and leaving existing dts as they
 are=2E

Maybe i should add the mt7988 ethernet binding change from my dts series h=
ere=2E=2E=2E

regards Frank

