Return-Path: <netdev+bounces-49197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837FA7F112B
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A30E1C21609
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8182912B87;
	Mon, 20 Nov 2023 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ihDqXRdw"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799B3F2;
	Mon, 20 Nov 2023 03:01:09 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 727FB240004;
	Mon, 20 Nov 2023 11:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700478068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7gpsJCHq0VsT7gsYb4JYKcVh9EWoEm81K8a1V3zqilI=;
	b=ihDqXRdwhtBMy2L3Eh3CWE3nW+P7Ow+OhGB0YJ0BJUy7aYBR6kPSXX+lkF4Nq8TEBUu1YZ
	rugpGXoKmtQi+SDyqfcSC7ZZBMZE1y9rxyxwnRiPJMLVbpEPAsTaiRwO1sUL35DoCWhhfB
	i7z7HKYWsO2lPMIj1ahMO/2IQJY7i4rcg42LGmJzrrjq4TdT1RPsraZy1JsQksxzbAj8Iq
	cv/yrFL6mN0Ph6mJ1mBuM4aCyP3r0GoWQp4YSkosapZ5npWWai6/EdAj7xEEXB7b1ffOuO
	H6p11wwiRuqj1BIbTl/8O+ozT8JQp6iWohLN8jW6bPRbqIgjZmmNnOHcLY/RqQ==
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
Subject: Re: [PATCH net-next 09/10] ieee802154: fakelb: Convert to platform remove callback returning void
Date: Mon, 20 Nov 2023 12:01:06 +0100
Message-Id: <20231120110107.3808358-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117095922.876489-10-u.kleine-koenig@pengutronix.de>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'99d8a4a283c92bc9976674adce456dab1715c48a'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2023-11-17 at 09:59:32 UTC, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= wrote:
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

