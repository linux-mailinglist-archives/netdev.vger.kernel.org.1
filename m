Return-Path: <netdev+bounces-49190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DD27F111E
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594B71C20C24
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C81D111A2;
	Mon, 20 Nov 2023 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E6QqkROA"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BB09D;
	Mon, 20 Nov 2023 03:00:43 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B7029FF819;
	Mon, 20 Nov 2023 11:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700478042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HY0cOjnTk0cP42r9GGzJwxyjVdJbgtLoifU4IuGCSd4=;
	b=E6QqkROAH3frSPYOanrFRDr7PxFSQc6zI+vfWtVxlyU+Xp4cpXRQFOVUss4lsvG/n4D24E
	Pngle3AOb5K90o7zIHBYy8t1zT4pThMKSM6vg9+YOmdozPEroRrwba9+poKntcdMElM90w
	0kHLId5bZMuc0ZYnT4jFhUa0PbWJybh+AO8DTS26TVhKVWrjSfM2KDfigRMpgQsRRBEFlp
	4yC5vP9kadMAjhsGHzPOpDsNzO34p1ldrK7bWaw1QUvGOu7Ltnur09HfDsll7eJRGCk2m9
	PxVkjmmYsLF5BZEm/gJqswPJqszyXF0nhDy0l0kMpfDqS5fu3Bwj1/V88TImxg==
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
Subject: Re: [PATCH wpan-next v5 06/11] mac802154: Handle disassociations
Date: Mon, 20 Nov 2023 12:00:41 +0100
Message-Id: <20231120110041.3808118-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927181214.129346-7-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'9860d9be89f420f3793fb798faadea11c723e08a'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2023-09-27 at 18:12:09 UTC, Miquel Raynal wrote:
> Devices may decide to disassociate from their coordinator for different
> reasons (device turning off, coordinator signal strength too low, etc),
> the MAC layer just has to send a disassociation notification.
> 
> If the ack of the disassociation notification is not received, the
> device may consider itself disassociated anyway.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git staging.

Miquel

