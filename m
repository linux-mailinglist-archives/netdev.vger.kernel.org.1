Return-Path: <netdev+bounces-197345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6859AAD82FD
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 08:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E215B3B3467
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 06:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BBF256C80;
	Fri, 13 Jun 2025 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qg6CdPM/"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0AB256C73;
	Fri, 13 Jun 2025 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749795286; cv=none; b=aOW8j6GsK1ynthqMWzExPLhlb4dfrumQSS/ZkUFU4CXJCdxRjGHJxAXe18OengyzcGV35lfJ044sTRkPMK/f2SnCVZgw61ylRsqyg6AGlEqXi/5agkvi/Wye5Zs0UYOyMxt+xVCN1JVGzMPGy/OEudWuLFYUmKtCOmN5ddowTek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749795286; c=relaxed/simple;
	bh=BpTx1JlaU8t2NnSVcT1U5Hw1DGdpTHC0qys6/y6tlak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhisJQud37qNVAkFqZ8iPQIef2D+FkEc4VQsDzrzRYFu+90PoANvWQymKLXfcrxccCvr2Q1xXlc/Cy1eAO0nllb7Q9Cp7uuRh12GaixDhOkuoLQIeKk4+oVDZQ7jX4pIqYNYt1goDSG42h5bS1n4hnjIWdEY8R8BMu4ma8zSXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qg6CdPM/; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 45C08442B2;
	Fri, 13 Jun 2025 06:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749795282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whxBYE463gQ4dvnKL9epaVnqgXjwtqwBi/Pgw4zDGAo=;
	b=Qg6CdPM/9/G53Ye6rnkUDr/xFI5pnFi0Qc2CNo1k5EJ9FV6eeqEo9HcGkBncQNINKnTK98
	fFM2dOiZpmv915v6xjq0WEIz6AmeUYd9byqGSpg+Lz4n8SxLd86euyc46UGqdsULU+N1Tc
	7WrZMQVzSXLDZtvOaX6ufHwhVYG9UmE+/DwyiMg8vIuR7BiHJXLYgnbL+78gmDh/qqAFrP
	+qgd+urf+ygVbQn5z2gtF0L0ClUhuNkizcnLVIm99OlxY+N7yXptSwfSPx3ETcyV1dyNrQ
	Pa/ziU7E+M9dWpsuV40eIYOf1Rr85jOcyrkOxOYbTrve/Ll7IorDwei5XjJdTA==
Date: Fri, 13 Jun 2025 08:14:39 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Mun Yew Tham
 <mun.yew.tham@altera.com>
Subject: Re: [PATCH v5] dt-bindings: net: Convert socfpga-dwmac bindings to
 yaml
Message-ID: <20250613081439.2ad972ef@fedora.home>
In-Reply-To: <20250612221630.45198-1-matthew.gerlach@altera.com>
References: <20250612221630.45198-1-matthew.gerlach@altera.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujedvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopehmrghtthhhvgifrdhgvghrlhgrtghhsegrlhhtvghrrgdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlo
 hhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Matthew,

On Thu, 12 Jun 2025 15:16:30 -0700
Matthew Gerlach <matthew.gerlach@altera.com> wrote:

> Convert the bindings for socfpga-dwmac to yaml. Since the original
> text contained descriptions for two separate nodes, two separate
> yaml files were created.
> 
> Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>

Sorry I've been spending some time away from netdev@ lately... This
looks very good, again thanks !

Unless there's some more comments from the DT bindings maintainers, you
can add my :
 
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

