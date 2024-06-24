Return-Path: <netdev+bounces-105999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD429142D0
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 08:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB511C22CF0
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 06:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EBF2C184;
	Mon, 24 Jun 2024 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Dpf9f78k"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A263A1DA;
	Mon, 24 Jun 2024 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719210874; cv=none; b=XvzBUFE/npMGjj38FaXW0us5rD/iYLIQIvK+ABl4qTZzlDnubwgxNzmLSyrC7jETrI9PpSmIMc8MPBzfdVJ0hhxxvchAGTLHZsm4xwyDu39kXtT3J+AaCHRqY8ODdoW2LtDBNT4RF7UThIS47EU/A+3Tr200vp9AvoqqquOd9Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719210874; c=relaxed/simple;
	bh=1DMakykCIfUAlpVADCUSyn5T4zIsvaNezaKnvW8q8W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdMbZx2f+Zro9hDpaly+TJVVBTY6DrsDgyBpj1HLpC+GsLVHluViEybXb9htNJv4eEOdkmHv/Nb7XGslfs5OCdjq3rRTWr0/4inKNUWx1xaEMUiGR2j8yCnUEE5ZzfCW62ViZgZXmxcmPjL/KANxMSVRs89gHpLBbxB13hW0H6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Dpf9f78k; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719210830; x=1719815630; i=markus.elfring@web.de;
	bh=1DMakykCIfUAlpVADCUSyn5T4zIsvaNezaKnvW8q8W0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Dpf9f78kjCnyvPbDW90cWnTiE1Eql/65se/QMCiPrClB4aeB6jLUQCg50zSES4uT
	 PZVMnaX3GhcTi9pLzjjxWHXmAepMOv9KVqxYFSGr5V3/pyMCoLbdH9cpUrqkK+kFu
	 owYBD9zPtCFjRG4luAX1yst1A71YZWTlV/cxNRlI7ziP3mn/Cdg1NNJcjBFNdlReT
	 fUIEc3FTnn4+WXoISG5uZSj2nCKiv+YBi+qR60kyFhpdS9h85IU/+o6tSJzAreduL
	 J218W9g5S/9/t1BDyrNmUT8FLBd01zoRg6Bkb5k4onruarW19IBqlId7O7RZKX4s7
	 22aJvNWkTplcYhbORw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MkVwo-1slfEG3F2E-00aped; Mon, 24
 Jun 2024 08:33:50 +0200
Message-ID: <94b76f8d-5886-4a1e-8469-712be369ee9e@web.de>
Date: Mon, 24 Jun 2024 08:33:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] net: fec: Convert fec driver to use lock guards
To: Wei Fang <wei.fang@nxp.com>, Julia Lawall <julia.lawall@inria.fr>,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, imx@lists.linux.dev
Cc: Peter Zijlstra <peterz@infradead.org>, Simon Horman <horms@kernel.org>,
 Waiman Long <longman@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Shenwei Wang <shenwei.wang@nxp.com>
References: <20240511030229.628287-1-wei.fang@nxp.com>
 <657b4098-60b8-4522-8ea0-f10aa338e1b6@web.de>
 <PAXPR04MB85106653965E0694C2C84E4C88D42@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <PAXPR04MB85106653965E0694C2C84E4C88D42@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zYDgtPUyGbVR494S2aaAhBezw2rAjlld6p7OKoMYRntp28QZx/e
 CE4/G6HTWYHbUNijX/hEDkeAY4myZih3TWhk+FqR4Fe9hC7XyeVKX+bxl36mGrP1iA+B0Ad
 6hgucoBUn43z9X/uFhcCxC2dkcKXyDF+JZ+39hOmsTymyW5Iw1GdaEhNcGmPfrA0LaFf3xC
 IRo/XaGOn+X/K79Jn2i6g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Wq5Ia2J9EVg=;FGkgTGR3qAAXJ/99JgodSWi8s+M
 cnUK2GRemrHPTe2GKsB9KEmM4cOhm9RAcZxXtfCzRHMqYEBR8kXh0LfwDRla4/m3vba+LKmal
 pr580LPxSRi+cU/ZfQPtYsknXz07n6oqea45rOyAdcvXb20mEPBZbXZajfB92LDxglLTljme6
 /ozqj9GX8YgUNRDFB+jk/AQDyXJoZei3L1RGxbFfoJsvxiAk28QSnV87zFFmnf2rLIMYk+Yvb
 VdHqYrLKci3e8eia8zaSt3rlO1rK4ilS5HcFNCpYq+BTl6KynXV7lAFWHGnmaRJYbnK3xnHjA
 3PO/GSAtFPEdQTNLDAgxeQvuGAHpGyoFou8qLkzg9PrY9gUO9WRN2NqnlHqk5ITKc6NlzHDVN
 U2DZOW0GelBqesJloWrbN9n3bdm42XSI4djR5uir+AzoGkw/F3QhMP+k5NwtkDpruBEK1pPtc
 MiSsvgVTxQwIBfOEsMVwqPRF7+QuhC0/0lQ648VqZcMHabTpflRlT3ovpUUZ4CvudLOwSLjPg
 x9OWYOiN7Gsu+dNqsVgwJjzsEg8QUI1Lsk1ITxDXzkjcm0Qglyv4LM7K+l59/88UlH2j6F/5d
 t0zGLUWVRlSHq1e3ZJ3a4t5065FAEyCYW1z/QWl4Qc7p8FV4vOBGD48DgEGDmc8ggW9/FbE1X
 02TwRPMRPDb0fedQM7ECtaoZpOaoniXdpsXzmicUqwyc6XaR/LPn0ADB70FpKXvDipwICP2fO
 Qpd3GEBVjdHtFpV5c9eijXwUtlUj+P8d/Nlp3UR3L+9CiWtL1F8DC9RBK0DCjwGFNniqZoGjK
 ifwfmlKYYFBgC2B+Lp3U7JpUluxsKwfz0Wh6pLUIpmIjI=

> This patch has been rejected because netdev people don't want these sort of
> conversions at present which will make backporting more difficult.

Advanced development tools can help to adjust involved concerns another bit.
Some contributors got used to capabilities of the semantic patch language
(Coccinelle software) for example.
Will any clarifications become more helpful here?

Would you get useful insights from special information sources?

Looking at guard usage (with SmPL)
https://lore.kernel.org/cocci/2dc6a1c7-79bf-42e3-95cc-599a1e154f57@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2024-05/msg00090.html


> The LOCK EVASION issue has been fixed by another patch.

https://lore.kernel.org/r/20240521023800.17102-1-wei.fang@nxp.com

Further software evolution might become more interesting also around
the commit 3b1c92f8e5371700fada307cc8fd2c51fa7bc8c1 ("net: fec:
avoid lock evasion when reading pps_enable").

Regards,
Markus

