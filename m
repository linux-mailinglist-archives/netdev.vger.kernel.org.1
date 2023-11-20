Return-Path: <netdev+bounces-49194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD427F1128
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF03F1C21574
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01624F4E7;
	Mon, 20 Nov 2023 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f2KQqgrm"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDE79D;
	Mon, 20 Nov 2023 03:00:59 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 901DB40006;
	Mon, 20 Nov 2023 11:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700478058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4SutgbzTFJbed6CnmBYu/sgR3lWoSNtaZmvPWneWGg=;
	b=f2KQqgrmOrxgiDf0o3Ps7so1Cc5gBKO9Kz2nlm12QTNNdgCAHJKg8CVG1/G6wsr1aTF+ce
	3+o2rI9KmV7Y+LkteHEMX8CcZ2PVLhYSB/73sDUE68j4UreEsyGCzLU+XlapmSKC9496MV
	m9QbdZ7xff46+10GPBwk+YTsZtfJ+labLCMAIGe1niH+FmGhHtzrkfGWk/dUfCPZYEmyph
	8ocplSx6WOpBe5yXLY+1+xyXms5dgai3nUrpcfYgd/ZyJljyDb7RX7JgZ82eDSkQNG3tWO
	88Z4744sMOmA1fEw1PWgmwvQX8gupmP5EH0yDJky5ahGvBvULATZhVMrjJsdpg==
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
Subject: Re: [PATCH wpan-next v5 02/11] ieee802154: Internal PAN management
Date: Mon, 20 Nov 2023 12:00:55 +0100
Message-Id: <20231120110055.3808254-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927181214.129346-3-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'2e7ed75e92fc493ff5484f61aed6489262c78f3e'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2023-09-27 at 18:12:05 UTC, Miquel Raynal wrote:
> Introduce structures to describe peer devices in a PAN as well as a few
> related helpers. We basically care about:
> - Our unique parent after associating with a coordinator.
> - Peer devices, children, which successfully associated with us.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git staging.

Miquel

