Return-Path: <netdev+bounces-49188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D40F7F111B
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D13EB217CF
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CA2101E1;
	Mon, 20 Nov 2023 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K2JWdocZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A26CA;
	Mon, 20 Nov 2023 03:00:38 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5E531BF213;
	Mon, 20 Nov 2023 11:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700478035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHYCwZAejicbLqtmlfL6cOGooy6oYeMyv4mfqbbAKjg=;
	b=K2JWdocZZkWI5q91m8cui+c5Nb7pG/c7cvaA8gMnrXhubuRQvermMlgLicGBzi95L8QX8W
	hINF6YOLX/hB75AZk2Nq9htEhMTz0WLc54AFFiN6QoKJTdHYuQ9U5WKGQla3Bub4mn+Ft+
	Ex0px1FwRVEd0Ogc1D6DaoW42Evts4SAYLOqNQRhuaFfrpWRhxfxJz2w+nPPHyZsYiLO35
	RxwImyM4g0jbDxOjw3wJIssDk5Y+JdsIXyJl7Mz/TQ5yNfw1FNaaOwo4lHGhHIsZdfkG8X
	9eIxVFuJwj21Z9YKaDxZuw/OlpsoPEqsODUcvgqRRA7yCO5MfoV7L3t7US1u6w==
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
Subject: Re: [PATCH wpan-next v5 08/11] ieee802154: Add support for limiting the number of associated devices
Date: Mon, 20 Nov 2023 12:00:33 +0100
Message-Id: <20231120110033.3808052-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927181214.129346-9-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'ce93b9378c306e6bcc4e0bd817acf4195b4a0288'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2023-09-27 at 18:12:11 UTC, Miquel Raynal wrote:
> Coordinators may refuse associations. We need a user input for
> that. Let's add a new netlink command which can provide a maximum number
> of devices we accept to associate with as a first step. Later, we could
> also forward the request to userspace and check whether the association
> should be accepted or not.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git staging.

Miquel

