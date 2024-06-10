Return-Path: <netdev+bounces-102195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32115901D14
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 10:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7431F21695
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 08:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F331156452;
	Mon, 10 Jun 2024 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jaYxa65N"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D8D55887;
	Mon, 10 Jun 2024 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008772; cv=none; b=DraGHvszZ0NIgiBUsNlZDQF7q+mryguKAlkzqQ0aEQKytr3nyHAdQYwHvnlB9PiC2BBF70Q5bBLRlWNO9AxSyxvRyhObzfxCkulmhCGjd1fqhX+rKGbdNgDI0OTKe36XNLz+m0J/9ghyZQwbFH0y1HPHKyAs+bGtzpiXsqvnN2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008772; c=relaxed/simple;
	bh=368XwNYZD0whAtsmeET0VZaclcSeD6ddAe2PyDhTmoM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n8B8KzyKNSOxpS3BqO0xiA7LGDEebJtozzPNDbopcQ2SuM+W+PJHbWdRYYlww0W1jm6ZunpLK3AY9EC0JgtGizuneYewt+46uGjuornyOEARzCzuQmVLS7bLoJG+mQQ8ahohnuuzdz04vz9NA/Xnc7C4xGC7zvdzBNYXLMDML9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jaYxa65N; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 95C4CC0CB4;
	Mon, 10 Jun 2024 08:35:31 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AFE59C0006;
	Mon, 10 Jun 2024 08:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718008523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4x4zWTd7CusdePzcDcFLJfurMsnhAhcRxR1EoRyEerA=;
	b=jaYxa65NzGG0q0RJifMvIuGaA9nKgPajR0t86xHSqtWwNtR0Uv8Noh5nuYgblyFNH9sSWJ
	NQVb/bWNF4gUdr5sev6tPKFlSUefXtD1kmu9e2JhvkZwpqGJYYDK1x/iQLQUhNVB1cd3qI
	wUWyE6u8m756i/ukzq2qxUZRAYo6KZpmVAPRgceJhafb3uSUEcmAz4K2ZmgLY6Vv+uUOpk
	e+XW6ao0mZI0NitQsVSN9AeCDAxzcDIIEWKESnlNOLQJauMOBfaKLS5vsthqWDeCLC2fDv
	8a8ACYh3f+CKGYEJgE0D7hPVIb8S1sze6xChM6WSo5JU3Fxm4JA7C2Bfje+vJA==
From: Kory Maincent <kory.maincent@bootlin.com>
To: netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	thomas.petazzoni@bootlin.com
Subject: [PATCH net] net: pse-pd: Use EOPNOTSUPP error code instead of ENOTSUPP
Date: Mon, 10 Jun 2024 10:34:26 +0200
Message-Id: <20240610083426.740660-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP as reported by
checkpatch script.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Fixes: 18ff0bcda6d1 ("ethtool: add interface to interact with Ethernet Power Equipment")
---
 include/linux/pse-pd/pse.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 6d07c95dabb9..6eec24ffa866 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -167,14 +167,14 @@ static inline int pse_ethtool_get_status(struct pse_control *psec,
 					 struct netlink_ext_ack *extack,
 					 struct pse_control_status *status)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int pse_ethtool_set_config(struct pse_control *psec,
 					 struct netlink_ext_ack *extack,
 					 const struct pse_control_config *config)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline bool pse_has_podl(struct pse_control *psec)
-- 
2.34.1


