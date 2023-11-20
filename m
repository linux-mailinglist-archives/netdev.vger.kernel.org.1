Return-Path: <netdev+bounces-49185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 340937F1111
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDEAC1F23801
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EE9E550;
	Mon, 20 Nov 2023 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QLMv1SyJ"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89DD85;
	Mon, 20 Nov 2023 03:00:20 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D58620009;
	Mon, 20 Nov 2023 11:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700478019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SevVOQa0o44sLKWupaK1qz1vurt5ESp4z76EDE2t4g4=;
	b=QLMv1SyJaf+p4aFY2Kz/PuCQXpMQNqifD7RcXYjxi6JNY7hDFOCEJx1etd31z3cBUn5a1r
	W1fn0DTN0GeGmDYgL8PAqcbxI9GdXN5zXF8Te24Ur+C5jApv77LJ2y9vpF5xKWgs7iPRmt
	sIBXvQ6saYkeUnbuJLu33+MDWhoG5+EwF5/StuHbarTVH+80c16otA9m+kxSoRTj4Vsfcf
	0PKslS9zMWOw2Q0twblcQWN1w/sCbgtjDDOmy+AK7RUSJssnoebZ2cppasG7LYD2Fl8Mfg
	t4Gzt6NvfrNyXCi8bPI/4wqCnEH7ZCynFoqXnjBhVIKHsBTZdz5osyuOnl4Nmg==
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
Subject: Re: [PATCH wpan-next v5 11/11] ieee802154: Give the user the association list
Date: Mon, 20 Nov 2023 12:00:17 +0100
Message-Id: <20231120110017.3807933-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927181214.129346-12-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'83fcf26b00d77e4a0ec920524fe85350a27e9c05'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2023-09-27 at 18:12:14 UTC, Miquel Raynal wrote:
> Upon request, we must be able to provide to the user the list of
> associations currently in place. Let's add a new netlink command and
> attribute for this purpose.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git staging.

Miquel

