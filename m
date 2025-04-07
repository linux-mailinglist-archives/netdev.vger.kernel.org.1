Return-Path: <netdev+bounces-179654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 410D2A7E00C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 15:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB29188444C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C29E1A9B5D;
	Mon,  7 Apr 2025 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i+b9Qm4R"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D8C1A8F6D;
	Mon,  7 Apr 2025 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033587; cv=none; b=b1lcqUKGlNrEw9yaDTfxUKvKFkzXhsUO8PyEs8+axlfqbkgMZyF6ixtP8+yBrWcIRmO2t2LxGvo8/E4smD2zgrvpnh4LmRjHQnsdedJz6ke233Atc7GHZ/noKFLnMYG54hDIEirH8MtLBqNy+XF6DO8yDzVoewV+MvMtBvT1p34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033587; c=relaxed/simple;
	bh=2sgdfPDLUZQq25ly4X6z/HegrTfy4G1nncio2f3/Lp8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KpyX5KJsoV8VQtg/WeodlaUc5pgceEtOQMQC1/ANusugrzjeSBUmtajxKFhaVHSvkGfDUk6O8Rwl8cnGf5Y3OhmdBy2SIOeTUWjqF2mzpIr040Wldv7bXCIkkNWiUx6VVSMlMBTq6hoeN6M6Y8Y+5XGE2A6YLadMCZyuTkvJoFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i+b9Qm4R; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F29B4442A3;
	Mon,  7 Apr 2025 13:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744033576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+3Vrefcf/NQ+JQxSP5ld2ShyoQDx5GSabMC/kL9H49g=;
	b=i+b9Qm4RpUC95spqhOdbohwP/qQCK6GvMnmHFO1cOgPcmWCoafh0BxHuEexLCgRmKA9t21
	Yu0Q/18Zcal8laTx28aA/x05T1OZFL47PL/yj9rq7bnpcWWEtnj9G1kkj9yBSJzr62gg+R
	CqqBDHtv70zvA743gHo+0lbyXnmwsvngB+SRboyDmmOUDOTa1qOAn8TsX8PvRVN45UHSIS
	OV10edGh87/+0R4PG8VSijPOtljEhrcoXYKFnNy1YKHfSS8hrfnyfWxKC1kkakNxmjb1fL
	2l3O0Dy/J71nfvX4+R5Ng5kAJXgte8njuIIK8XerrQObme9frsaq55OOuFZYQg==
Date: Mon, 7 Apr 2025 15:46:13 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Marek Pazdan <mpazdan@arista.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de
 Bruijn <willemb@google.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Mina Almasry <almasrymina@google.com>,
 Edward Cree <ecree.xilinx@gmail.com>, Daniel Zahka
 <daniel.zahka@gmail.com>, Jianbo Liu <jianbol@nvidia.com>, Gal Pressman
 <gal@nvidia.com>
Subject: Re: [PATCH 2/2] ice: add qsfp transceiver reset and presence pin
 control
Message-ID: <20250407154613.00e7afe2@kmaincent-XPS-13-7390>
In-Reply-To: <20250407123714.21646-2-mpazdan@arista.com>
References: <20250407123714.21646-1-mpazdan@arista.com>
	<20250407123714.21646-2-mpazdan@arista.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepmhhprgiiuggrnhesrghrihhsthgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhnthgvlhdqfihirhgvugdqlhgrnhesl
 hhishhtshdrohhsuhhoshhlrdhorhhgpdhrtghpthhtoheprghnthhhohhnhidrlhdrnhhguhihvghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepphhriigvmhihshhlrgifrdhkihhtshiivghlsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
X-GND-Sasl: kory.maincent@bootlin.com

On Mon,  7 Apr 2025 12:35:38 +0000
Marek Pazdan <mpazdan@arista.com> wrote:

> Commit f3c1c896f5a8 ("ethtool: transceiver reset and presence pin control=
")
> adds ioctl API extension for get/set-phy-tunable so that transceiver
> reset and presence pin control is enabled.

I don't think pointing and explaining the first commit is relevant here.

> This commit adds functionality to utilize the API in ice driver.

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submi=
tting-patches.rst#L95

You could simply write:
Add support for the newly introduced transceiver reset feature in the ice
driver.

> According to E810 datasheet QSFP reset and presence pins are being
> connected to SDP0 and SDP2 pins on controller host. Those pins can
> be accessed using AQ commands for GPIO get/set.[O

Weird character at the end.

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

