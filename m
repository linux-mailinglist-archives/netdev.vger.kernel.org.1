Return-Path: <netdev+bounces-208938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F8BB0DA11
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E2407A1820
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 12:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5EB28C2AA;
	Tue, 22 Jul 2025 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nnmZSk8B"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C36724467B;
	Tue, 22 Jul 2025 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188495; cv=none; b=NqRbbLPpkeAlvz2hqji0TOly7aX9aRmTHNc1Z3o5BiLRAb7CS+t5qjxYYF4/anFSOtj6GDSP0rwfLDceqUV1M4Vnyl3AmjR1ruXyOiakjC2w+QlheIXeuxOnY3zwB/jOM+96QR+N/83Whv3vjWWYkhUElmpDhbfJCaJsBBC3iic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188495; c=relaxed/simple;
	bh=/yIxqrnzluFHj9TqLjrY/6SyPBFMZXFZI/JpCXQrTiY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqv2B1KeYncHuXtMfqm4LEiYkIsYVcsuHnPTuuofaha2ry+G8l6sHkEeKN8KKOJhrzCmZWwBxOQlmvQy9qfraMRrhlKFiSRSSOGkUDxOYmeq2tJ7h0bMRgBjXXBaS2ULTM1YisK81YAEEOjDtfvBBOSTAwoKzXOGQ117AtDSVLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nnmZSk8B; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DFF7F44418;
	Tue, 22 Jul 2025 12:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753188485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUo8VzMpbPTsIOoCrITkRVF9uqYE50JackCo8hbt3/A=;
	b=nnmZSk8Bck1Ipn5A3as+/CIaxE3KGooGipDHkJTNG/bOOgB8M+xyUR25t6dzD8zvvumHHC
	M0mn80Ej3wP2ybOvZHfscdDd02R4lc2NDEj1bZsNx1Ry/SxotWWWJzVzlUBCBXyQJw1LJ6
	EcdUHMSGMUcH8gaq6XYQG5WD12vHb2zB/qi4+sl+H8bnnQkVaV+y/7WPDKhofm4ab5bEWg
	l8Etm5VGfHvFjYqs9xRTFtiiIfrEuJa4erAD3eYV/D2643PGwE2wU9z1GbmJasELC0rUAQ
	ZqnMoViFPqtjMB1AVX+Vj98BX/Fon/Rv/j07SdN6lx1ZefGRGKNx5bXaofjakA==
Date: Tue, 22 Jul 2025 14:48:02 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: stmmac: Return early if invalid in
 loongson_dwmac_fix_reset()
Message-ID: <20250722144802.637bfde0@fedora.home>
In-Reply-To: <20250722062716.29590-2-yangtiezhu@loongson.cn>
References: <20250722062716.29590-1-yangtiezhu@loongson.cn>
	<20250722062716.29590-2-yangtiezhu@loongson.cn>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeelgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepledtrdejiedriedvrddujedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdejiedriedvrddujedupdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtohephigrnhhgthhivgiihhhusehlohhonhhgshhonhdrtghnpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrt
 ghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Tue, 22 Jul 2025 14:27:15 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> If the DMA_BUS_MODE_SFT_RESET bit is 1 before software reset,
> there is no need to do anything for this abnormal case, just
> return -EINVAL immediately in loongson_dwmac_fix_reset().
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Do you know when that could ever happen ? I'm asking because this logic
for the DMA reset is duplicated in several places in this driver, maybe
this could be useful for other users as well. I'm guessing this is to
avoid waiting for the timeout when the DMA reset fails, but that is
usually when there's a missing clock somewhere (such as the RGMII clock
from the PHY), in which case I don't think the RST bit will be set.

Maxime

