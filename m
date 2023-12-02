Return-Path: <netdev+bounces-53239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64657801B92
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 09:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6773C1C208FB
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 08:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11428DF55;
	Sat,  2 Dec 2023 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="MImHQNG5"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EE9EB;
	Sat,  2 Dec 2023 00:52:50 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F167020009;
	Sat,  2 Dec 2023 08:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1701507169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddbaMKtPwL33z0vbJqF3KIOjPGvuVw+bjm4FDZ30cJw=;
	b=MImHQNG5Ii9RatL5upAN8aIPNadAgJxmCKD08WX7dQIW3E16gLNltEfRjKRmIM4KazEhBD
	2WvCfJJP/vO/aUtRRLyGBEx4HHvUUg7Si7+Kf0rO0qwsyZWaBeOEitRhWWyI4HZA7OieRp
	igMmdtRXAnGKjXRvlf1ikXiFEu5iU8qX19mbUTcZ0Wm2CU7NeO6LY9vZs4ykufIQh2SoTK
	Nxy0g+78K1hQbTUE1GdzmCqAjNK7GzGtYT9YUYaPJouoMDGFebByhlMVbJYbquME7Vd5xC
	NwIs15iMJW7u2fVGfpPllPgHswuPKlzbIIsni9/2ob0q8gJMfCsXIXMcHox9XQ==
Message-ID: <45221d69-a780-4e81-b4c3-db1b9894a1db@arinc9.com>
Date: Sat, 2 Dec 2023 11:52:13 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] MT7530 DSA subdriver improvements
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Frank Wunderlich <frank-w@public-files.de>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231118123205.266819-1-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

Can I receive reviews for patches 6, 12, 13, 14, and 15?

Thanks.
Arınç

