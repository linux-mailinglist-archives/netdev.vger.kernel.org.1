Return-Path: <netdev+bounces-205562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 983AFAFF464
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 00:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1501C484A2
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 22:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB2B245000;
	Wed,  9 Jul 2025 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lWXRs7go"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B2B242D94;
	Wed,  9 Jul 2025 22:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098879; cv=none; b=sn2DpLU1BQDUd6M+0CSjVmD1nSJFvUMv+DMX3gFrpH2oE3Xb+fznzpu23zOnZnr1ufWsjFHPVAkexw2sh8/ezy2ShBG53lYsCK9oQFB+4HpGFb5sunzetw2I/2Kwty4IOJRfW2fJ0R32DTT5u4Qj4G4LyTEktVBPU/SLb9KVw9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098879; c=relaxed/simple;
	bh=z/rM88ZBV406HIusx/8e/6Qh5Lm5bi9iBLSe4tNZoKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELps6phDmwzPSyYrq+TPf5ChCIFbAG+ayTTmp8qVqcViNiVX7fG4wpu/RkkcuKiprT5oORF0un4VHIkbX+jRfcadAzjd3K/3trme6l1VRlSAHTaa66dPztiGN/m/OcWZdm8gn8ykb0iSw8nqA0PwTNXiBJKYpIHokWnLxTCJa4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lWXRs7go; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1175E42E76;
	Wed,  9 Jul 2025 22:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752098875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9/VlT4VXnS3/SL33Vh5JZiH98nKrWop76SZGZCbQIk=;
	b=lWXRs7gog6N7lfdygsqxwjwj7tSwoKhdYXLY3KWGwKPzj/5BIMQ5P4+SP2CsHtz0NMkUBi
	EN9WUn8ABL4nhaVaRyF3I1e5OVAGQ56viBh5cn9RMhMkEI0/eQVEKRoulmT1VjchaZ326Y
	WiVZmMd9scW3FSCFv6Pgj5syKkDzn7/rRf7W59Z+chjqpGMIW3+k+yYBSQxaQCc6CveIHG
	5Pun1ulW0K3zQ28kQwncTDlk2GXftft0C9ARxNMNLBUOXyCs13pO9eUnJtyJqTRRkiPcG/
	MTLEdQ0oSgPaLqZpNv/SWr8hTkIGNHneVcehL0TqrQv6KCjZ/CqhcEkc/P/Qig==
Date: Thu, 10 Jul 2025 00:07:50 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Colin Ian King
 <colin.i.king@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: pse-pd: pd692x0: reduce stack usage in
 pd692x0_setup_pi_matrix
Message-ID: <20250710000750.5c0d651f@kmaincent-XPS-13-7390>
In-Reply-To: <20250709153210.1920125-1-arnd@kernel.org>
References: <20250709153210.1920125-1-arnd@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkeejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgduleemkeehkeejmeejuddttdemkegrvdhfmeefkeehtdemkegtkegvmeeiiegvfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekheekjeemjedutddtmeekrgdvfhemfeekhedtmeektgekvgemieeivghfpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegrnhgur
 hgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvg
X-GND-Sasl: kory.maincent@bootlin.com

Le Wed,  9 Jul 2025 17:32:04 +0200,
Arnd Bergmann <arnd@kernel.org> a =C3=A9crit :

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The pd692x0_manager array in this function is really too big to fit on the
> stack, though this never triggered a warning until a recent patch made
> it slightly bigger:
>=20
> drivers/net/pse-pd/pd692x0.c: In function 'pd692x0_setup_pi_matrix':
> drivers/net/pse-pd/pd692x0.c:1210:1: error: the frame size of 1584 bytes =
is
> larger than 1536 bytes [-Werror=3Dframe-larger-than=3D]
>=20
> Change the function to dynamically allocate the array here.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

