Return-Path: <netdev+bounces-173560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C53A59763
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2470C169B5C
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C44722B8AA;
	Mon, 10 Mar 2025 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aPmiX69n"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9FE22AE7E;
	Mon, 10 Mar 2025 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616433; cv=none; b=Wkou7kxvMlXGKEWfV59GPODTyBrIAidr22K8BNz6AM4b+nhJtxpFyMRRlLE8Uw0muyzoisowQ6JKjcL/uQDq2873D48cRMdmvbJidNCN08xpDOwV1zoFw2eUM2aCXCn5WNtS48oZ8lvU1N/p/Ds7lftZhx+vozcfofiZ2Gfms7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616433; c=relaxed/simple;
	bh=Pcjf/q8GOhh0QnIRascQPs5dvt067o8TXug5OHGtutY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8FAVUYEL+ZUNF8TTuh56BgdR2zl65rIa3WZ/Lj8gJmljyHsqZvAjsLhlEjRvPi3T2OWQaSbi8zJ5GTr64HQbK8uFE2TDH7OyoEWxLtsGdHks8tz+3ucwi57aLiMqqXDCSs7Ap9syeSfz649FAvoTDmhB4UncjdZ9wUgparobBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aPmiX69n; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F8D420487;
	Mon, 10 Mar 2025 14:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741616423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pcjf/q8GOhh0QnIRascQPs5dvt067o8TXug5OHGtutY=;
	b=aPmiX69nCJQDGMo7eE5YBNro6eQyWrzFBEbRru7Q1v8yMVA8t9JmrdYoEh+wy86LuXDsR+
	Fu/sAkdiGACrLFT4+ZKEyLCmsGdUjA0axsE//cexrM+6BgJQAUwt0ZrunKYpMaK3W0eaSQ
	q510xmnA0KS3rEJQbfYrUDj+GGNt05zEuBoCSXjD8O5QT7eqgKvAzD+UHLdvzF3R3vnlZm
	A1NEmLnXaLA3Znei+OkqKDUl3aWDoFP0meO7GBkymzaV0RyKGSNBADMyLCyNfwRjoeJRQC
	Q/TsGFZMaSCnILqaK0z7WSfGlinc75Euq8/9nCVl7mr5qO128xOly7GwoQQz+Q==
Date: Mon, 10 Mar 2025 15:20:14 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] stmmac: intel: Fix warning message for
 return value in intel_tsn_lane_is_available()
Message-ID: <20250310152014.1d593255@kmaincent-XPS-13-7390>
In-Reply-To: <20250310050835.808870-1-yong.liang.choong@linux.intel.com>
References: <20250310050835.808870-1-yong.liang.choong@linux.intel.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeegiedrudekkedrvdefledruddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepgeeirddukeekrddvfeelrddutddphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohephihonhhgrdhlihgrnhhgrdgthhhoohhngheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoo
 hhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgtohhquhgvlhhinhdrshhtmhefvdesghhmrghilhdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdhtohhrghhuvgesfhhoshhsrdhsthdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 10 Mar 2025 13:08:35 +0800
Choong Yong Liang <yong.liang.choong@linux.intel.com> wrote:

> Fix the warning "warn: missing error code? 'ret'" in the
> intel_tsn_lane_is_available() function.
>=20
> The function now returns 0 to indicate that a TSN lane was found and
> returns -EINVAL when it is not found.
>=20
> Fixes: a42f6b3f1cc1 ("net: stmmac: configure SerDes according to the
> interface mode")
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>

This patch is a fix it should go net instead net-next.
Could you resend the patch with net prefix?

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

