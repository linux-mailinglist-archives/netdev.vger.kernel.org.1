Return-Path: <netdev+bounces-240196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6BCC715A6
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 23:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D13504E453A
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 22:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAD6333743;
	Wed, 19 Nov 2025 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="XxidVeAk"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D28E331200;
	Wed, 19 Nov 2025 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592171; cv=none; b=ZUuncyQy0fHLh3F4WGzUhqAa8ji4PFiSEJ30ePP81bFKSCnsc8BY7vvg/hMtWQfeGJOQTVUmgnTxyMmC7vwGGX+d98cqo5jRIjxEClrXbeH9egw+AxVpQfw2bbwJlpeYpJ5G3R19cXiLdj1SNfvmf6BHFK2oP/9nlcY562y5HjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592171; c=relaxed/simple;
	bh=N/IbnlmYobIBjqXyaLWDD1kKA/vX0o9XDEQuSq+W8wM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tBotLpMtOOGA5JlNLDJwecU/7mzS6okSJB7X8ulggN47EvsoWL5ERFQxgHFeeKTYL3S9YkAqXdg87+oQgUW73OSrOnI7hTFWOhbP8/xpKUpWPxmypD7ajl0KtI7TkN83jtPMJTTE/DcvRfA0TL1IQ0XNb82jjpzzzr3KieR2lDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=XxidVeAk; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsx-006ytZ-EF; Wed, 19 Nov 2025 23:42:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=jQD9MKwaMkNHkHE/mXSeUKUpKbq2OrrhCoKJpz21pSA=; b=XxidVeAk4xWpoE93OPqIGOKGSz
	MC1665YFQipa0pE12wbcTAvhBq3jvZPLoT+6vaYol0TutlwGCjGKw/j8E7G36xjmlYuvTK9gjCtGg
	W6/MJ9cU0RaqCTynZsiM5mrl9TzhXTvTu+yOGv543IjukGS23po7egyHwcp3giEiYYBIif1PTc7Df
	s6y1KvuXbs4YiWwvK29hsFTMGU48Fej1i7OHmTKQGmrTvd9HUXBiEGl1Fy+p9tBkiEY7HlraYEudl
	pARYc4IPO5OQNqdI98MVEOH9T6z9X91v3vLWgeXza/7D+0CfDny0VTjD/LUS4lKOeJiVu5GHvlBZ1
	DR+/ly/Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsw-0000DJ-P3; Wed, 19 Nov 2025 23:42:46 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqse-00Fos6-TI; Wed, 19 Nov 2025 23:42:29 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	nic_swsd@realtek.com,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 21/44] drivers/net/ethernet/realtek: use min() instead of min_t()
Date: Wed, 19 Nov 2025 22:41:17 +0000
Message-Id: <20251119224140.8616-22-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
and so cannot discard significant bits.

In this case the 'unsigned long' value is small enough that the result
is ok.

Detected by an extra check added to min_t().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index d18734fe12e4..3e636983df4a 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4238,8 +4238,7 @@ static unsigned int rtl8125_quirk_udp_padto(struct rtl8169_private *tp,
 		}
 
 		if (trans_data_len < sizeof(struct udphdr))
-			padto = max_t(unsigned int, padto,
-				      len + sizeof(struct udphdr) - trans_data_len);
+			padto = max(padto, len + sizeof(struct udphdr) - trans_data_len);
 	}
 
 	return padto;
-- 
2.39.5


