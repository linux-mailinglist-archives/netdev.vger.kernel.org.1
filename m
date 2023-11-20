Return-Path: <netdev+bounces-49195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8087F1129
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1AA4B21966
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E9412B71;
	Mon, 20 Nov 2023 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JafUyBoc"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498B39C;
	Mon, 20 Nov 2023 03:01:02 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F00C20012;
	Mon, 20 Nov 2023 11:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700478061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SWPv7qmXbYMZsh3tgZrj6JHRyyZ0V+GeU5V2lZZNkDw=;
	b=JafUyBocuw6O1vMH7aL1zKFSfui9j3iokT4kne7i3Gjoxy+f1VDOPynauyHCEhN1l4qE8U
	UEJQJwy1Qo0eX/zn1x45vyq5s/TNSFKJNICWsQ+9jsQxN3gqO4PtvX6VEt2bJNXWHFu28F
	xV65sJXXXCDmMrkHheJQPW7YSGtoT5UbQEQ0GdML/qHu+ZOUvROevrChapCG4YvG1ABepY
	FM11bU16j+dg0DDP1KVP5ubsMEAmQKPjIkdN4SlFP2LwMBFzSOUQwd1Yr2v4bWamcA8a+d
	763RvLeAUv6J6YTe06rzhUTVP2TWrQlnfkU2/qkONUsApR4x/gX9gH7Byh1YXA==
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
Subject: Re: [PATCH wpan-next v5 01/11] ieee802154: Let PAN IDs be reset
Date: Mon, 20 Nov 2023 12:01:00 +0100
Message-Id: <20231120110100.3808292-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927181214.129346-2-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'5260adf86b6732c75136fc1b159bb370062ddfa8'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2023-09-27 at 18:12:04 UTC, Miquel Raynal wrote:
> Soon association and disassociation will be implemented, which will
> require to be able to either change the PAN ID from 0xFFFF to a real
> value when association succeeded, or to reset the PAN ID to 0xFFFF upon
> disassociation. Let's allow to do that manually for now.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git staging.

Miquel

