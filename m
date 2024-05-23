Return-Path: <netdev+bounces-97844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C4E8CD7F6
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 17:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71551C21A11
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE20112B7F;
	Thu, 23 May 2024 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="aIg7aBWv"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1FA171A5;
	Thu, 23 May 2024 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479969; cv=none; b=IP00+WEwyLZSwadP8sZdi+2rSLQYAi13LqOZ1mGeI1r3MxJezRg1uZEIDNl/QbtPgGLa1VhGKKQzYMSQ+/AM5Vl2Z/5aSQ759aaWmuoWxHPJ4fBiYlRV2Yhcoov1TPMOH+c2bkryAzhyVNUA1qeEYCNgqwxQMHzS9Cf3FIELaTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479969; c=relaxed/simple;
	bh=JGJHVbAXREx1YposaI5pL4OYAxdq2OORRDHQ3rwMd1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YefJJ9kb6sq3WfJAzU2cir38Q6sF51+X7n8WSeqLWxyDj27RBvz3nNgFIgoVrhUdkq4qG7xlYgoXNVUu/a01x7Dno6Zd76Q3zCquVTR8F/9cxwRECQWS+2DQKxGeT2BiuxLSXsneljETaY4CGZsxSN6qQd++MjWk+OSFhqrPtHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=aIg7aBWv; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=gJ59MV97xAM6rbyxIepdxd7qoWHfADATNbo0tb5q0wg=; b=aIg7aBWv9kDWr1+/
	EaSzwW3oPSoFZS8jfgjWDb8tCgWkrODguLPeLhax2zuAsTImvTeVHTFhknpRy+mm8qGFLgXKV3duM
	XyI1WfO13fPvdqvzJKX39cA66+BY2gfzjyoVOMK4rj98pb2QfT9q/TrdR1IDERfkEtlMH3pRb1ATp
	tm1rFJ07CRish7ReFtTAgQlRgNHU13WbRSaVdsK/7eojkUi2kFMzolRbpkwA6SH0LhAMsej6NAxOM
	hhFkr8CVV5j+ifaajj5oCpUA5nGOYUzYseTss15tmXTyjwF+Yq7gp8ukRe2YbhkczEMamwFCm0jTo
	NiW/coNP8C5l3WMOQA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sAAqi-002G1C-2I;
	Thu, 23 May 2024 15:59:25 +0000
From: linux@treblig.org
To: isdn@linux-pingi.de
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] mISDN: remove unused struct 'bf_ctx'
Date: Thu, 23 May 2024 16:59:22 +0100
Message-ID: <20240523155922.67329-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'bf_ctx' appears unused since the original
commit 960366cf8dbb ("Add mISDN DSP").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/isdn/mISDN/dsp_blowfish.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/isdn/mISDN/dsp_blowfish.c b/drivers/isdn/mISDN/dsp_blowfish.c
index 0aa572f3858d..0e77c282c862 100644
--- a/drivers/isdn/mISDN/dsp_blowfish.c
+++ b/drivers/isdn/mISDN/dsp_blowfish.c
@@ -73,11 +73,6 @@
  * crypto-api for faster implementation
  */
 
-struct bf_ctx {
-	u32 p[18];
-	u32 s[1024];
-};
-
 static const u32 bf_pbox[16 + 2] = {
 	0x243f6a88, 0x85a308d3, 0x13198a2e, 0x03707344,
 	0xa4093822, 0x299f31d0, 0x082efa98, 0xec4e6c89,
-- 
2.45.1


