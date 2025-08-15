Return-Path: <netdev+bounces-214193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF59B28720
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 22:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A771D03A38
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1B129A303;
	Fri, 15 Aug 2025 20:21:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5E257841;
	Fri, 15 Aug 2025 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289276; cv=none; b=qiG95uLKSM4ZxJU8pLJ2dZ395C+/EX3Mxgdy5rGM1NhXDL04jYgy5824Eo/e9cmfcoaTXg7cYe1E66xc/7DGWR4quir9zBNdr2rENmdnxE2DRkzjFhHA1DDu8pPGAZiLR/LQuKdFpSEgf7e1t+Pp47l6UHTaFo3IjEe9fIdncGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289276; c=relaxed/simple;
	bh=GEmD82bjhJHGSgSGuxfVRi16+6y8ej2A81qBHY7azkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kVNWyZ5YuQYgtZl2ADC3pnPbyyGRi8hiO4h7nHxRJeNcrVWPfei31lOH+ipPBng/Hx+/KszhzmK6I7S/7mHG1RC6HijM3zpBNTnJ85hhBfRC6bgirkPllKdJuChZvJqo9YOWzPdyqlCwoZ4md6XgnEoFRVy42iGr7bPiFGl5ERM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id DC145586B43;
	Fri, 15 Aug 2025 19:49:48 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF106441A1;
	Fri, 15 Aug 2025 19:49:37 +0000 (UTC)
From: Artur Rojek <contact@artur-rojek.eu>
To: Rob Landley <rob@landley.net>,
	Jeff Dionne <jeff@coresemi.io>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 0/3] J2 Ethernet MAC driver
Date: Fri, 15 Aug 2025 21:48:03 +0200
Message-ID: <20250815194806.1202589-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegkeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetrhhtuhhrucftohhjvghkuceotghonhhtrggtthesrghrthhurhdqrhhojhgvkhdrvghuqeenucggtffrrghtthgvrhhnpedtieelkeeijeehueehgfegleeuhfdutedvtdekhefgvedvffeuhfelvedttdejffenucfkphepfedurddufedtrddutdefrdduvdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepfedurddufedtrddutdefrdduvdelpdhhvghlohepphgtrdhlohgtrghlughomhgrihhnpdhmrghilhhfrhhomheptghonhhtrggtthesrghrthhurhdqrhhojhgvkhdrvghupdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehrohgssehlrghnughlvgihrdhnvghtpdhrtghpthhtohepjhgvfhhfsegtohhrvghsvghmihdrihhopdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtohepghgvvghrthdorhgvnhgvshgrshesghhlihguvghrrdgsvgdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrv
 hgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: contact@artur-rojek.eu

Hi all,

this series introduces support for the Ethernet Media Access Controller
found in the J-Core family of SoCs.

Patch [1/3] documents the 'jcore,*' DT prefix. While there already exist
a few drivers that use this prefix, up to this point it remained
undocumented. 

Patch [2/3] documents Device Tree bindings for jcore,emac.

Patch [3/3] is the EMAC driver code.

This series already had a few rounds of internal review, so some of you
might find it familiar (I carried over Reviewed-by tags, where
applicable).

Artur Rojek (3):
  dt-bindings: vendor-prefixes: Document J-Core
  dt-bindings: net: Add support for J-Core EMAC
  net: j2: Introduce J-Core EMAC

 .../devicetree/bindings/net/jcore,emac.yaml   |  42 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/net/ethernet/Kconfig                  |  12 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/jcore_emac.c             | 391 ++++++++++++++++++
 5 files changed, 448 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/jcore,emac.yaml
 create mode 100644 drivers/net/ethernet/jcore_emac.c

-- 
2.50.1


