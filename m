Return-Path: <netdev+bounces-49187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CF87F1117
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050072823E4
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F1811713;
	Mon, 20 Nov 2023 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pJeCcT/K"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51862A0;
	Mon, 20 Nov 2023 03:00:32 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC31A6000B;
	Mon, 20 Nov 2023 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700478031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ka429IEFLwPlIfXES4thmZ9kYRptQ+QGWcjMTefmfQ=;
	b=pJeCcT/Kj33W/cSFrayGIzN9WsUEY6c+hcwuEX5BDMaAY/CjaDXW2YKQKihOMg7RcPCUqC
	I9DAxDuCjFGesgO0sofpD3PLTTxMLVAOWXdIMMhRccJ9tgTxZAxCgLunrxN4JlrkumIvn6
	dalO678kGpqlTdjOFF+zp/gcPVGW3WF4UVRUGX2zoYde+BoiBL+2CiByv/y5yS5cAtkwFk
	o6Bet2q3UK15YoibiTR5grtu2pVLtipPYkSPc+3Hm5gUmPQNS2WytX2QjHfJwfOyqBcaNZ
	6dbxRT7QjP1dhM1njkEVjd21ouD+mUv8sbiI+5uwA1XyDpYzcjlroobqCz45aQ==
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
Subject: Re: [PATCH wpan-next v5 09/11] mac802154: Follow the number of associated devices
Date: Mon, 20 Nov 2023 12:00:29 +0100
Message-Id: <20231120110029.3808019-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927181214.129346-10-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'80f8bf9a2a7f603662e08f7663643a58087a2cd4'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2023-09-27 at 18:12:12 UTC, Miquel Raynal wrote:
> Track the count of associated devices. Limit the number of associations
> using the value provided by the user if any. If we reach the maximum
> number of associations, we tell the device we are at capacity. If the
> user do not want to accept any more associations, it may specify the
> value 0 to the maximum number of associations, which will lead to an
> access denied error status returned to the peers trying to associate.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git staging.

Miquel

