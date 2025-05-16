Return-Path: <netdev+bounces-191142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC652ABA285
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165DF1893F7E
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 18:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC9325487D;
	Fri, 16 May 2025 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="helmUN14"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA9526AA99;
	Fri, 16 May 2025 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747418971; cv=none; b=ONscfmKZSlpUsimeH7X2+KKY9Yu5wQ9WSLvZVD9grrySH6p2Reg2qNBPak9vHqbaMcZRyP1lyb30sO3Uq0psuUuTR4pcIoJxo64JdlKAn/A7bBKMow8+xGEIbN9FB0wEyX1w3faOz8I47lkFi9DkZiFVIsp5Q0T9tCfUMLlnbTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747418971; c=relaxed/simple;
	bh=uZBemo+s9tZ46ZmMNSJ1HzqwmHJHgZnXJ/eHEboAgD8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=o/WyLKzeBEaPQwVvsHQ257rMjy+1Pwq6FGxrQTpCKlQxUQ08lNU6agSrnWjxD2w5TKckJUtvxWTy3z8ZdoR5bF2Lo19iS5Jq6Z3WThbTWAsDFoxjOGTKRtQqe2AdIeteAD+K+FKkeVou6BRi/zAI3evEFiwNFQAOrZorkJPtLHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=helmUN14; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1747418936; x=1748023736; i=frank-w@public-files.de;
	bh=uZBemo+s9tZ46ZmMNSJ1HzqwmHJHgZnXJ/eHEboAgD8=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=helmUN14BNEhxRiuRj6yN+bIO+rDByJrAXQ/f5TDptyWjLNN7+atqaQn/E/xV9qP
	 +MVciHX/RZ0NEYQFqG2l3eOsPlUJeKRaNldi0qz4qVS0gjY8lY/BRVPHAPBZ9pP25
	 OlBsVEBLo/HDOMLDYvBoKlUE6Kzu20tnUA5lZsZ5/NFkvZHp35iz2BSul2SHFZncV
	 2ewD3jzua4Z7zQewXld2UAHOepT4b7j61oa3nZ3nW1hnxY76nXcDs87t7D1kAzsRH
	 DeInImnLsFKbPA1XccjFNKV4ndqzxsxmxfAeh8KPmhS74KYZzdaxfm2HtLQhhXDvs
	 FvtJ3LEDpuo8rS3RbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([157.180.226.139]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mkpex-1ugkeV1kCN-00oC6a; Fri, 16
 May 2025 20:08:56 +0200
Date: Fri, 16 May 2025 20:08:47 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: Frank Wunderlich <linux@fw-web.de>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daniel Golle <daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
CC: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Landen Chao <Landen.Chao@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5Bnet-next=2C_PATCH_v2?=
 =?US-ASCII?Q?=5D_net=3A_phy=3A_mediatek=3A_do?=
 =?US-ASCII?Q?_not_require_syscon_compatible_for_pio_property?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <20250516180147.10416-3-linux@fw-web.de>
References: <20250516180147.10416-1-linux@fw-web.de> <20250516180147.10416-3-linux@fw-web.de>
Message-ID: <D997C4DB-1B03-4AFD-B48C-BFA19AB6194D@public-files.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yKB+wisqAoqC+shOlsR18tKggjY0Rri/wFlIaCyYrcMn3BzYE4e
 rzKlBHCP7BX+tjmmmPQ2rh+EYtwn0Av3aNaXLhZBcprxfPD3keeBxqTPwwiOD/IRqFxrIU1
 FxI/jkv+kQDufhR1eP7RaaTcPuGSMFBvL98095LYi0CX5aYacAg7V8FLXDMJ8/G48J6hwaC
 qmu9AybK8uLe8VXOk2LgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F6B7f3YTBPk=;DNKu0wTMKuEZDh31C6ZmpJWxjwj
 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
 PO8UnZtQriHGhiUV3ghD30=

Sorry, resent it by accident while sending v2 of my dts series=2E
regards Frank

