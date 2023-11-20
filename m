Return-Path: <netdev+bounces-49193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 173A97F1127
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73670282391
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ADC11706;
	Mon, 20 Nov 2023 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HNFoP/I7"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A84CA;
	Mon, 20 Nov 2023 03:00:54 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03ADE1BF20F;
	Mon, 20 Nov 2023 11:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700478053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+/rElJpyeEE7sYCnBh0dkb67KhQptIAe00a1V96Mndg=;
	b=HNFoP/I76MeUlEMmKcQ0MDV3+FpYEhjkIgoE6RMZd98Tq+6aZv1IvQti/SY0618uedoTXG
	higkq6pfb0loxcxYaLMb44q0yQMFdXt8D42+/j8Xaov/OSlh6gi5BgsKZ66mvDizGqs6Tq
	zqbGCg0mulhiNM92WVZIY1HE1wXlQiVhXRtQPtzLYjlx2AKNVcJ74QNELbzcXLr4Na+sCu
	IVF1iPNzMM31TqRFMbtOa1LR30yV8g6wPAHxCTseUWsl483o1oB/+hUKpSACd2qV7pNQ/v
	61tzur07jSAxB2CpIqEvFLLGaJC/+gHjRJRmJXUSAe3dP7pe3tC8Os598F2syw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	linux-wpan@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	David Girault <david.girault@qorvo.com>,
	Romuald Despres <romuald.despres@qorvo.com>,
	Frederic Blain <frederic.blain@qorvo.com>,
	Nicolas Schodet <nico@ni.fr.eu.org>,
	Guilhem Imberton <guilhem.imberton@qorvo.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH wpan-next v5 03/11] ieee802154: Add support for user association requests
Date: Mon, 20 Nov 2023 12:00:52 +0100
Message-Id: <20231120110052.3808220-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927181214.129346-4-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'05db59a0619969a47ab87050985344177c662cab'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2023-09-27 at 18:12:06 UTC, Miquel Raynal wrote:
> Users may decide to associate with a peer, which becomes our parent
> coordinator. Let's add the necessary netlink support for this.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git staging.

Miquel

