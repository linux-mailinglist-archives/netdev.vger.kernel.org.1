Return-Path: <netdev+bounces-182245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9314EA88510
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD17C170883
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602F12D11AE;
	Mon, 14 Apr 2025 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="outxZAVn"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969EE2D0A55;
	Mon, 14 Apr 2025 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639569; cv=none; b=C4c4LtRw1uq3xNbLbcNNwCLgLEXbWcZX8nZGhJJZLhHdwzIBC0OyHOalidZ7z/57XnfBf05oZYiR3InidUzd0f5yyZxd88bNfXIQd3WWlCQ29C94PHKLWqL94UVtvqN7ENz/WJRo1sNOjLU0n18cj2Ywyl9+TtgXYBAt0Qpp53E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639569; c=relaxed/simple;
	bh=AVKO2yw5qUoKGwc4FU2QM5dIZa3+z9zoqCXo/iQPA4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOTsMjWbyCWewzPgRgzDBzsEr01T/lsUZhoO0OVJTIBQjdfNo+b+aKDcXcRiLSENZCFwbAWD2IS5KJ7zMpdb16z2WYH1tluTtRxaFOJsPFC0njbPR3XitYFqP4FhRoqlcbw3bR4duFh14m2ch3CC8cLGNsUmYF1IDP4BV1jy3qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=outxZAVn; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C4A0243B77;
	Mon, 14 Apr 2025 14:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744639565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVKO2yw5qUoKGwc4FU2QM5dIZa3+z9zoqCXo/iQPA4o=;
	b=outxZAVnqrIslqOgDlNp/rPOZ4DkeHb7I905Yi5FhhxCuL3WKWrhQhWxzaqitI0Elb9Ozz
	jeZCDctPfe+OBx72z85XfBqnHwggrz5CvzESeR3KCPsgiQTe7ah8kJ3WcwDj+xbc+tCbtm
	E+gY4Jsfr6fz7c1s0m0Ssz6ZUCzoCAnMZ8eXuUhH6bHtZkIro4C8uk41pQbwkZ/sUEOls3
	NhzCCNCGSacLDoEjk/HM3dNZ+X3HIswWOzb/PMbW6d8ZsS9LB+uTcVRy9JOFS1QIUcD9gl
	JAzaKxZGrrr5vN6JIvpdsABPcGNSWJ+/eY9jVSw8OvlND2XbrzY0lXtIfVLiig==
Date: Mon, 14 Apr 2025 16:06:01 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: jiawenwu@trustnetic.com, Markus.Elfring@web.de,
 mengyuanlou@net-swift.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 saikrishnag@marvell.com, przemyslaw.kitszel@intel.com,
 ecree.xilinx@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: ngbe: fix memory leak in ngbe_probe() error
 path
Message-ID: <20250414160601.33194903@kmaincent-XPS-13-7390>
In-Reply-To: <20250412154927.25908-1-abdun.nihaal@gmail.com>
References: <20250412154927.25908-1-abdun.nihaal@gmail.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqheftdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfejveefgeeggefhgfduhfehvdevvdeukeelveejuddvudethfdvudegtdefledunecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtoheprggsughunhdrnhhihhgrrghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhirgifvghnfihusehtrhhushhtnhgvthhitgdrtghomhdprhgtphhtthhopeforghrkhhushdrgfhlfhhrihhnghesfigvsgdruggvpdhrtghpthhtohepmhgvnhhghihurghnlhhouhesnhgvthdqshifi
 hhfthdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

On Sat, 12 Apr 2025 21:19:24 +0530
Abdun Nihaal <abdun.nihaal@gmail.com> wrote:

> When ngbe_sw_init() is called, memory is allocated for wx->rss_key
> in wx_init_rss_key(). However, in ngbe_probe() function, the subsequent
> error paths after ngbe_sw_init() don't free the rss_key. Fix that by
> freeing it in error path along with wx->mac_table.
>=20
> Also change the label to which execution jumps when ngbe_sw_init()
> fails, because otherwise, it could lead to a double free for rss_key,
> when the mac_table allocation fails in wx_sw_init().
>=20
> Fixes: 02338c484ab6 ("net: ngbe: Initialize sw info and register netdev")
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>

legit!

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

