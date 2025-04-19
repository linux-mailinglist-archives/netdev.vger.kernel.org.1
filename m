Return-Path: <netdev+bounces-184278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEA6A9425E
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 10:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DC88A4DA8
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 08:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD7917C224;
	Sat, 19 Apr 2025 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ERd3VQjT"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DCD2AE8C
	for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745052518; cv=none; b=e3GbNt/njC9g/h5dluZRFHz1hRyGmoV8k0vpRqSelP96Xki5N43QY4Y6qnsIMqCW2S02bQ3/EmWDjduShhvQexCwDMUFVxtNvwHJHAKRhsO1TmNghMwosh9ziNqd/IwQJoUt9DHDOyQY85gfkOY2Y1LgKUgk9JTE3ZQmmdRUNIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745052518; c=relaxed/simple;
	bh=KBUYJ2juIEKPyGQeq6A8gm+Nuy26BfxA0D+BTWMA5vA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlAW69aRaUp0gQ2k1zPb9YLaar8x73lhBEQA+cObYa8KNkJ+lSO2PBW1KpZQph31wQ25L9pBGhAXY4X4NkmrO6qbfhBodajfid57InRRY2f1VGboFpqzu+jZmyqawN8Wpu58+/i/cZjNc40nkdRzxLttFKuES4KqiYplagWeioE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ERd3VQjT; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B903C432ED;
	Sat, 19 Apr 2025 08:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745052508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBUYJ2juIEKPyGQeq6A8gm+Nuy26BfxA0D+BTWMA5vA=;
	b=ERd3VQjTFOyU/6F75PbVJ1OzD1Px+KzHLqewQYuie1kNp2crpbgN3ba+qvFB5EhVmDpnH1
	QAmg7pzTWnyYUyYsWbZ7uGew6hG4++gZPxZ42Vt6F0v2Ap1/ZeVoke3SqP7BqxsATHGAhF
	AehpRfMrOxJqA2tFsmp58Bokx0v/X4fL830GjW5JkjU7TIsfx+1m8B3In98c6PKpq9JgZ3
	FUglFE4IWPyMJg/cFvZBRtyXsFQ+uB6v+yBS2Ky5rozthzMjWXU2CtYYAJf+LX/7Jurkt/
	A06g+Dkeum9P9a02qthEAADMGvIPxpWATYLtC01WKdUQ7+2LGA8W8oAYZA45ag==
Date: Sat, 19 Apr 2025 10:48:26 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, jacob.e.keller@intel.com
Subject: Re: [PATCH net-next] tools: ynl: add missing header deps
Message-ID: <20250419104826.5aef120e@kmaincent-XPS-13-7390>
In-Reply-To: <20250418234942.2344036-1-kuba@kernel.org>
References: <20250418234942.2344036-1-kuba@kernel.org>
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
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeegheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhudevkeeutddvieffudeltedvgeetteevtedvleethefhuefhgedvueeutdelgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudelmeekheekjeemjedutddtmeduudgsudemleduuggsmeefvgelheemrgekrgdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkeehkeejmeejuddttdemuddusgdumeeludgusgemfegvleehmegrkegruddphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvr
 hhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Fri, 18 Apr 2025 16:49:42 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> Various new families and my recent work on rtnetlink missed
> adding dependencies on C headers. If the system headers are
> up to date or don't include a given header at all this doesn't
> make a difference. But if the system headers are in place but
> stale - compilation will break.
>=20
> Reported-by: Kory Maincent <kory.maincent@bootlin.com>
> Fixes: 29d34a4d785b ("tools: ynl: generate code for rt-addr and add a sam=
ple")
> Link: https://lore.kernel.org/20250418190431.69c10431@kmaincent-XPS-13-73=
90
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Tested-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

