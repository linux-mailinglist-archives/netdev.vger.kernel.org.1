Return-Path: <netdev+bounces-184768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAB0A971E8
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48ED044046C
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF05290BA6;
	Tue, 22 Apr 2025 16:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AcOXqpIj"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75572290086;
	Tue, 22 Apr 2025 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337985; cv=none; b=cx/H/0MyXOqroIMFp8Cha+kvnt65R6G78j6SHd7ig/cR0ajhhr11suOcmnmUuRlH3F+KByzxQ7nePVc8VMlbwS4R55MZUI9Yi6mLUMAX89l0tRHGMS+lQDARHi75Y+KsX+Va+YoHuSqBwc2gYQEqF5zCbjejD9fh99eSOldbJrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337985; c=relaxed/simple;
	bh=l/GKSbrMBp2X50Z2sa9WsYIMj+6sBSQ5RVr1V8Qo+ak=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jsDbxlgH6mP0K83OgtavGJyFHaZgPBElJKgqkPGt1iQPHAY2RXNdYi0+zrrMIXcy4UUThMlKKk5e8I4g97mOpwPUomwbCOjzCJ0hTV5eOMEurZSfG425OeiUNDrtGRHw6YAhZyeGt1OCVLM7zyJxhsgSbBOkQGsypFimXFRoMd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AcOXqpIj; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 43304438C1;
	Tue, 22 Apr 2025 16:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745337980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EYp1PH84CI/1BjGsz+Aop4wrRagREEsClZGhgLNu8YE=;
	b=AcOXqpIj1Y5WHHcyuArtzMkdreDit/Ps1+jloEHY3T8+Dr2Exj7tcyzpHwaaA2YO+Ay+cu
	XxAKVq4fbXpCOOl28MCp4zejQRvHlKBGqVs97g/a+TWVn0Icll1gkDR7WuHnLFVpVcRMXg
	JV9+8FR/4BEsqO/ZYv5NtF1yZbZIsxMJ27keaFOwbWHZ8cPhxJyN8RG1u/VNYwGedA38TF
	DBMj1aOjXK8xP75F3tyJRltTrN7+6UhCOF3JhzpFY/vbrGHq3olR4PGXK6xtp3jVOe3DVd
	tbHXaIg96rp7ImtFUehKsx3cBRyjLoJIB0w7XvxLlY9WVLQJv9NoH7Kd4znQlQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Apr 2025 18:06:18 +0200
Message-Id: <D9DAOEKXJKQB.HHD75KOLKIW1@bootlin.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Richard Cochran"
 <richardcochran@gmail.com>, "Daniel Machon" <daniel.machon@microchip.com>,
 "Maxime Chevallier" <maxime.chevallier@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <netdev@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] net: stmmac: fix multiplication overflow when
 reading timestamp
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250422-stmmac_ts-v1-0-b59c9f406041@bootlin.com>
 <20250422-stmmac_ts-v1-2-b59c9f406041@bootlin.com>
 <aAe2iULNthghEEEt@shell.armlinux.org.uk>
In-Reply-To: <aAe2iULNthghEEEt@shell.armlinux.org.uk>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelkeehiefhfeehvefhtdegueelkeehffffffeuvdekkeekuddvueeguefgieeukeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgtohhquhgvlhhinhdrshhtmhefvdesghhmrghilhdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdhtohhrghhuvgesfhhoshhsrdhsthdrtghomh
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Russell,

On Tue Apr 22, 2025 at 5:32 PM CEST, Russell King (Oracle) wrote:
> On Tue, Apr 22, 2025 at 05:07:23PM +0200, Alexis Lothor=C3=A9 wrote:
>>  	ns =3D readl(ptpaddr + GMAC_PTP_ATNR);
>> -	ns +=3D readl(ptpaddr + GMAC_PTP_ATSR) * NSEC_PER_SEC;
>> +	ns +=3D (u64)(readl(ptpaddr + GMAC_PTP_ATSR)) * NSEC_PER_SEC;
>
> I'm not sure what the extra parens around readl() are actually trying to
> do. Please drop them if they're not useful.

They are indeed not specifically useful in this case, they will be dropped
in v2.

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


