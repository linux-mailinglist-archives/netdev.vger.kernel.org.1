Return-Path: <netdev+bounces-124572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB6396A025
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889F7281271
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54FC47A73;
	Tue,  3 Sep 2024 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="oqiv1463"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01BD26AD0;
	Tue,  3 Sep 2024 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373004; cv=none; b=p49gVQOlIMCW6T231Xp0GYk0x18bXQqGTP54Ol2F6XVoQxglTO3alrkMYHk6mf/xSi9vGsMw5My/k/QrWLZGMenoCmYZRTqrcNm9j1ovLzwNmUcAnzfFYq5RhuOphjeSGgEa+guodJMY5DLwvdm4Sq+3/o+FIdIA8tFG+TydRMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373004; c=relaxed/simple;
	bh=Wj0/CkZjNtPEN9TmeojDd8DReHMeuuUivOijpUh8fG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lrabdmqi92eHfzYZKZnGGjrgXISzGManaRghZDmbIVUyCPfUUc2vnXTjqNZ5MqPGuYHyGXItnUXzIMCZRNWhu5s48FGoDfxzWZuYnbXu6EIpM4lTsZh17qGFkZDE7xthaEJhUX7rH4zxH8+fPenarqNtBYf4QZ7LPk7j78Njxao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=oqiv1463; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E0F2CA0A26;
	Tue,  3 Sep 2024 16:10:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=c1isXRtW6S6Xq9eW9dV/
	yijfSpFZrqCLG5+XN8gwzGU=; b=oqiv1463LDdbv77UwTn6xSZTQh6huAHS2iRw
	rTcE2sEvKhjno1i29wSCO122UWI1ZjqEMSwhMuJm4g2r70AW+gqB8iIMLH57DF+k
	JvDLIvOsf23hIMiO/VfleCa5ntxyMSebaYRF1vHae7RJtxen7ATYkhhrix/pHR8W
	FF2TaH/12t/lWrFDrexd3x/K0LAjCD7hA1SCBOPfVUe1p309XUbF1fQLpWKBwSO4
	2SnB2aFiykblvFjQFBGW57TEFQ92Gw0rGbQmseJVkYjgAoM7Bh/l51f7d+A8lT33
	hRNk0gQAw5aHY9Be7M/yrb2ahkxkbeeK3dUEqmBo+kC6l05Mj9E5HtRVTiPd1ZoK
	TUq9OqBQBNo06aHME0e6PiNziaafjjeX9cAP0cAXYNxLpE8jt2UUoWPkmzfrn1w5
	GSOOBdFTkXNmjNrIgY8/sToF+cUjuPmyYFVn3/SYVTaZxO/Snmix6mUYR314Wxyd
	MdLT/3mDD9w7eXof8znKdHRDYd+IMKfrzxWtArsRniaVBfLHq7h4lAYaXmEYziWn
	0ZG7zenfoVbJN0brIDzYdiVhIqG34Pw2NHWR5joeYAg3iER+iN0D/urSnnG77VAE
	Wixmr/ykL/tnUuFiMF7k1ZWlmee5e0gUsOK/iZgZw6dQh2osL6jiLKplPdJgEk2K
	wUMzJRo=
Message-ID: <311a8d91-8fa8-4f46-8950-74d5fcfa7d15@prolan.hu>
Date: Tue, 3 Sep 2024 16:10:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/3] net: fec: add PPS channel configuration
To: Francesco Dolcini <francesco@dolcini.it>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, Linux Team <linux-imx@nxp.com>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, <imx@lists.linux.dev>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240809094804.391441-1-francesco@dolcini.it>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20240809094804.391441-1-francesco@dolcini.it>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94854627567

Hi!
I already proposed this 2 years ago. I was just about to resubmit it and 
found this series.

Link: 
https://lore.kernel.org/netdev/20220803112449.37309-1-csokas.bence@prolan.hu/

What's the status of this? Also, please Cc: me in further 
conversations/revisions as well.

Reviewed-by: "Csókás, Bence" <csokas.bence@prolan.hu>

Thanks,
Bence

On 8/9/24 11:48, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Make the FEC Ethernet PPS channel configurable from device tree.
> 
> v3 to just add the missing "net-next" subject prefix, sorry about the spam, it
> seems like friday morning plus the mid of august heat wave is badly affecting
> myself ...
> 
> v2: https://lore.kernel.org/all/20240809091844.387824-1-francesco@dolcini.it/
> v1: https://lore.kernel.org/all/20240807144349.297342-1-francesco@dolcini.it/
> 
> Francesco Dolcini (3):
>    dt-bindings: net: fec: add pps channel property
>    net: fec: refactor PPS channel configuration
>    net: fec: make PPS channel configurable
> 
>   Documentation/devicetree/bindings/net/fsl,fec.yaml |  7 +++++++
>   drivers/net/ethernet/freescale/fec_ptp.c           | 11 ++++++-----
>   2 files changed, 13 insertions(+), 5 deletions(-)
> 


