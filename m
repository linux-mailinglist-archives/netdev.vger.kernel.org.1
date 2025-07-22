Return-Path: <netdev+bounces-208937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D803B0D9EE
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A0E173683
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 12:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3D22E8E0C;
	Tue, 22 Jul 2025 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AfKo1a1U"
X-Original-To: netdev@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00A528C2DE;
	Tue, 22 Jul 2025 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188257; cv=none; b=CkiRW9TmOLyRbUjZlPy/H3UDbPIzezGm7VtUkvW5nchvFjWTiGcarXYpMeYTHzvtf9vmaQ7wvxjNucxJ5KAmA+c6xJWer8jwohkm2JSR+d10HRuVC8UvOyBNcnBGegK4bD4R4ZhYx57Fo+ON1cdAwwRE88TJE3FOPRXQHJact3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188257; c=relaxed/simple;
	bh=6nLcuLW2GIpVhXNXP2vLv8B8EKF8M+ZWP1AwkGvq7XY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OothEmkp+nnjBrRP3fZMIweS0/0RvJB1Sg5b6m747mJvIS5KU+A84+JSlFpFxBE+O+5GhOrpRcZBVSmehyO9uX/7DpegeRqTgYaDZqsgQMUyiKfA1/5tyP8kHcmU508+eXpozsiwE3d17HVbPC/0wZHCbq9YA4UH4SZ3Mpo7FXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AfKo1a1U; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A0884317F;
	Tue, 22 Jul 2025 12:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753188246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tF7WN9uFRv1gjyhhbMaSaPZJD2NsGzk5bTg83j7U7Zc=;
	b=AfKo1a1UwDZi3i+n3ImaXaa9KS0gwye0vX1J1Heodyg9d3nyVinUGlWp9osJZ9tE8o8FQa
	up0xAo2U9u3QnWgcXgf1aUn33BkqPFG1HeiKTuSxKSJwh8kaLPowh+kGtipZbPKgQVMdms
	ebbfWRtf7cIkaE+bTGDjh5ZK+7yObEJCAeUbFvCgLMHfAvTzykwFT9fKzC8DlSyPNubpwE
	CyUK+bDLk9qzVFp/Ts3VJM1/RAR9yduU1rJ3jovK9nARvxhqL9pehFM9hEX3hxTU2JnK1Z
	7Lk6JUov7Q8xop4e58Kaf1SdPMyRFn59wu6TNhxcB5/4emdBH2PlIVqj81J9Lw==
Date: Tue, 22 Jul 2025 14:44:01 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: stmmac: Check stmmac_hw_setup() in
 stmmac_resume()
Message-ID: <20250722144401.3cedec44@fedora.home>
In-Reply-To: <20250722062716.29590-3-yangtiezhu@loongson.cn>
References: <20250722062716.29590-1-yangtiezhu@loongson.cn>
	<20250722062716.29590-3-yangtiezhu@loongson.cn>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeelfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepledtrdejiedriedvrddujedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdejiedriedvrddujedupdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtohephigrnhhgthhivgiihhhusehlohhonhhgshhonhdrtghnpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrt
 ghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

On Tue, 22 Jul 2025 14:27:16 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> stmmac_hw_setup() may return 0 on success and an appropriate negative
> integer as defined in errno.h file on failure, just check it and then
> return early if failed in stmmac_resume().
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

