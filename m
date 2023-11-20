Return-Path: <netdev+bounces-49196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0154C7F112A
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94154B21728
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84232125BB;
	Mon, 20 Nov 2023 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ImiB3KOh"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6F69C;
	Mon, 20 Nov 2023 03:01:06 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4FAE7C0013;
	Mon, 20 Nov 2023 11:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700478065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4xA0Ht2q7MG4rnIlPgFNx39Bb9irXpYAuc+BZ9xzsU=;
	b=ImiB3KOhaDpwJuWQITyIwFizX6Xpb4855hq8SaDMpg7lurbgPOXdTHOLJYB7CHvmPqBVRI
	1BuD0Shq8ONp3PSOQPe/2y4s36U0pF+kUfClkpH4YrnT14D0Tuv7LQaqCABoW0VYqeoP80
	sp0g6gBjBR5PIJLHbEif1MXWoNtGgf0EMrc8gK2jebtzKAajNCVQKs6Q11ULoafTl85jcO
	adpiy515ehgUvC8cJeETINBgC+0ZPOq93TzIGVbtREiYkvwukTGFcoXx8/A9V7HS5rUWwN
	XjI83i8OgzROPdUvL+p1vOvpHQrQCv0WPHGpw5nGmWgXkOKnGoWhrPy5OhXpSQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 10/10] ieee802154: hwsim: Convert to platform remove callback returning void
Date: Mon, 20 Nov 2023 12:01:03 +0100
Message-Id: <20231120110103.3808326-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117095922.876489-11-u.kleine-koenig@pengutronix.de>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'9d4ccdefcb3e0dfbe3af029015cccb437785070f'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2023-11-17 at 09:59:33 UTC, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git staging, thanks.

Miquel

