Return-Path: <netdev+bounces-161356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAF2A20D26
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A8C3A78CD
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FD11CDA0B;
	Tue, 28 Jan 2025 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vj0AY3g3"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9540A1B21B7;
	Tue, 28 Jan 2025 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078555; cv=none; b=s+hCXhMoOqcB+egU+LB3jT+M2U0WvwhONNVSpjOq+OvT1Cdtgcq2xg8OEi+3DGlNB9XhMqbde+eZ+PsAW43vCD5hFIulEcRq+kqffx5wGb9U8wyoOmKo57IdJVaXNYY/mb5XngSsYyRunU9jy4UK8auR1jzE8rnQFo2gNoeeoQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078555; c=relaxed/simple;
	bh=K7A9OfTgQh5DqDTl15dnKmViFVjuAzefui8SDV7AiFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GxWMm3WmodevWyB83XefFQWcIe/6Smuf/pqA6NTmLUM4LSVE64Mop0h27AKZCO8S7EkSK52TbLMqsPUpdnE7DadmRp5BnCC5Hvl8Whtm7J5CXwz/9Pw8qjJryWQIoNNKzJpO5wWvCsOlzt83aP6og6ONYZvi05mUygUmYcO9h4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vj0AY3g3; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7129F432F9;
	Tue, 28 Jan 2025 15:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738078552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uRBKtCobNrlNtRGzslmZSgmULC1PNapEHs9o/owjhZ4=;
	b=Vj0AY3g3ZxPH1cFgYZdRd5h4C5YDW+5hiQ1wqIVF22EFW3+8K8Cz58b/gr58uBS5lx0zwz
	DSPI1kFmy6ibjTXekUuAo6rNXF5nGN+UP8SmqC9zk5und5NSamlD1qlx1eRZVYK9IXPqDp
	fgIsWjGWOPCboTf5jO2yEOr0iqvntN8wr5YRZ+c56pWQUbEhcnnUZdV8QjetqP8dfWhQSS
	xxBOA7pjH4Qy5cxzsimgPjKJiCHbi2kJ4289klt4c43sn7Bx53NyBfOqwu4NQci+ZvuQj7
	C7ETw8AhQZepGHztT3dLMj8MNLLwGI843YzAwpPgmuANlXQqJAj1C7X8PhAe+g==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 28 Jan 2025 16:35:46 +0100
Subject: [PATCH net 1/3] MAINTAINERS: Add myself as maintainer for socket
 timestamping and expand file list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-fix_tsconfig-v1-1-87adcdc4e394@bootlin.com>
References: <20250128-fix_tsconfig-v1-0-87adcdc4e394@bootlin.com>
In-Reply-To: <20250128-fix_tsconfig-v1-0-87adcdc4e394@bootlin.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvefgvdfgkeetgfefgfegkedugffghfdtffeftdeuteehjedtvdelvddvleehtdevnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

Add myself as maintainer for socket timestamping. I have contributed
modifications to the timestamping core to support selection between
multiple PTP instances within a network topology.

Expand the file list to include timestamping ethtool support.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1899ef93e498..1052131a141d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21729,10 +21729,14 @@ F:	sound/soc/uniphier/
 
 SOCKET TIMESTAMPING
 M:	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
+M:	Kory Maincent <kory.maincent@bootlin.com>
 S:	Maintained
 F:	Documentation/networking/timestamping.rst
 F:	include/linux/net_tstamp.h
 F:	include/uapi/linux/net_tstamp.h
+F:	net/core/timestamping.c
+F:	net/ethtool/tsconfig.c
+F:	net/ethtool/tsinfo.c
 F:	tools/testing/selftests/net/so_txtime.c
 
 SOEKRIS NET48XX LED SUPPORT

-- 
2.34.1


