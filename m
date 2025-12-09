Return-Path: <netdev+bounces-244092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77531CAF98E
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 11:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 612B234899B7
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 10:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7781E322DC1;
	Tue,  9 Dec 2025 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="ZQfRzPzL"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CC4322B78;
	Tue,  9 Dec 2025 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274630; cv=none; b=QCoxxgHM/HWZFk9KB4FsURcE0EyjldLTTpwAsdbj4GKXSyDIiVG+PKbzrbcngEIT9FXRHEEzANeztXh1IjYsG0QVZaVDtX9YUuJN3nz2DwgzswGh+vPpwX2pn944CkDPWQR/g7+5UTWJU/3wZcMtzTxy7L+ULMh9aUKGF+l7dHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274630; c=relaxed/simple;
	bh=tsxt7GqGU2Y6aR3ftGYfuyEw4FuK0QVGoidAfI/vkNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FD7EkLvG1GEYVQZ8YokcVCghh2mHfCVX3hmQ/oSs2U0ceejGlrQXw3gG+Ds75uMNFOSOUmbHlSv63p3SdlCKpSoulf+T+61hiQCbIjFdbP4Mbt1tlV63S+7qx8P8lxl4BsnF7k4gg/XCz6wIRzkOE+k4iMXU2MPis6kPqz8KGpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=ZQfRzPzL; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vSuZ7-00GyzU-Bw; Tue, 09 Dec 2025 11:03:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=pUFM0r0NZk4jg8TL6THMB9VhU15mhoWWVIu+KybWqt4=; b=ZQfRzPzLWP1GmEp0SqbsMwethi
	W1EzKrihUmwgeYDcIyPWkDzOH57KzFGGqkH62T/UzvyUDQyOLB/wN/PY3HozPR6wBVTuRpt4WtWt2
	Ar4QVg7n9DcNn+tLOFWRhVxRCpTu+2oxnZLTSzuewV62yMd1I8qu7u2/afxS7fWPHKFBjDVPLFlNC
	HxLD5xiO7T7KUmrsZhI6565OOA/nsYl/DWWY+MHlts5deUJUAw9UjClq8m4mfrwCkCJS1vc8aJTYd
	XohmYfKzwbeDTBKzthLr9nt/ocGhuWQjDXEeIJTb1UxQZG877GtsyxWU/U63bSVua8qgOpO8QFoXu
	muS0Z2zA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vSuZ4-0000Dd-U5; Tue, 09 Dec 2025 11:03:27 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vSuZ2-00CND9-G4; Tue, 09 Dec 2025 11:03:24 +0100
From: david.laight.linux@gmail.com
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Crt Mori <cmo@melexis.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@netronome.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 2/9] thunderblot: Don't pass a bitfield to FIELD_GET
Date: Tue,  9 Dec 2025 10:03:06 +0000
Message-Id: <20251209100313.2867-3-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251209100313.2867-1-david.laight.linux@gmail.com>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

FIELD_GET needs to use __auto_type to get the value of the 'reg'
parameter, this can't be used with bifields.

FIELD_GET also want to verify the size of 'reg' so can't add zero
to force the type to int.

So add a zero here.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 drivers/thunderbolt/tb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index e96474f17067..7ca2b5a0f01e 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1307,7 +1307,7 @@ static inline struct tb_retimer *tb_to_retimer(struct device *dev)
  */
 static inline unsigned int usb4_switch_version(const struct tb_switch *sw)
 {
-	return FIELD_GET(USB4_VERSION_MAJOR_MASK, sw->config.thunderbolt_version);
+	return FIELD_GET(USB4_VERSION_MAJOR_MASK, sw->config.thunderbolt_version + 0);
 }
 
 /**
-- 
2.39.5


