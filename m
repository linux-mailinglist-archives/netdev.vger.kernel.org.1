Return-Path: <netdev+bounces-126500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3998971891
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C64B284687
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284351B5808;
	Mon,  9 Sep 2024 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gDjOj2Y9"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA2F42AAB;
	Mon,  9 Sep 2024 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882419; cv=none; b=ja3hzV8sQ7ODUiHLUjf8GLG9EIsKIQldOmbYlku9HsmMBsaWO7adAliGm4d8E0/nu6Iid+hCykAh9F7UJFvs2bWbURyeSlw6lH2g56rHeHODpQmTQPFvf+76VnpIGP1YjkH9fcVul4bzcW8UcDcS0Z9Kc3EUR+D85CsUax1pctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882419; c=relaxed/simple;
	bh=EN7K547/V3hc6OwQMX6UH/ciPClOzecDiiFtQmXg4MU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pxKY66BCcqCBia0mqmqftTCpQHjKO2D+CYW1uQP/vMskkA95lsDu+epw+wwExeLWrFWdwhblpejvCiKbh5z8oAK6HM/Pl3AOx5EjY6s7FlKL9cn07o3khJ+JVxel0lUn1yriQ9Go62eaa9OCzwiaoMCh4qck1j/hsv2k9bcbAuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gDjOj2Y9; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay7-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::227])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 7DE16C1C7D;
	Mon,  9 Sep 2024 11:43:47 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 799E72000A;
	Mon,  9 Sep 2024 11:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725882219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tsWOPP+pUgTAtYznrRMXi9VjftC2DkYnCvG3d7W5xfA=;
	b=gDjOj2Y90kYIp6akYM9daUjcSl07DITnEXP5vZ74/anm9k5jgejF4QB7U+7UatN2EPy8QZ
	sN3yhFRc+uUmtkEfA87Lt1ib/sJcuP664f69TYB3hGe2EgIXPp62oD4I0KbwcOT1sQ1Oi+
	s9gsE2BUsffSDWTXxts3EFPE5sO53YF83F+qlEw+WIzcM5kbCHe7Kze1gDqkZLY7WIkmq/
	RU5s660DPziFgHsoTApU5AVf7R1BSnVS3XkvApwrbz0IqK5S+g9JVKKCdjcW+rVINVdKx/
	vGnp/iQka1plHVRVe3D6V/nQK54s6RXWdyWoFGzh3wGQqOUWT+M2/vRpwLLunw==
From: Kory Maincent <kory.maincent@bootlin.com>
To: linux-kernel@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	thomas.petazzoni@bootlin.com
Subject: [PATCH net-next v2] MAINTAINERS: Add ethtool pse-pd to PSE NETWORK DRIVER
Date: Mon,  9 Sep 2024 13:43:36 +0200
Message-Id: <20240909114336.362174-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

Add net/ethtool/pse-pd.c to PSE NETWORK DRIVER to receive emails concerning
modifications to the ethtool part.

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Net mailing list was missing from v1.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca1469d52076..710df2e236c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18418,6 +18418,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/pse-pd/
 F:	drivers/net/pse-pd/
+F:	net/ethtool/pse-pd.c
 
 PSTORE FILESYSTEM
 M:	Kees Cook <kees@kernel.org>
-- 
2.34.1


