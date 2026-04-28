Return-Path: <netdev+bounces-281621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHxCO40u8GkHPgEAu9opvQ
	(envelope-from <netdev+bounces-281621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:50:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5F947D2BD
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E7BF301FABD
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD87B320A34;
	Tue, 28 Apr 2026 03:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Z2tZ8s8/";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="zPiN/2NQ"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932702D9EC4;
	Tue, 28 Apr 2026 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777348232; cv=none; b=FE9Z1w947CNlwycV6SAcJj1McoI2gtPh8ZpmjJ/osiKmyIIOxe74i/O5KyMaEjlQQNlWJBf6iGErhETG0+HMyv8ADq88kz8U/mPfJdxMjhVuIrXg6pdStT5J3N60UDk+12AFXfB7wrgUhK+kYUAFSDdOk4pDR1atu6faiLFbU60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777348232; c=relaxed/simple;
	bh=4eekHztIwR+LF/vl/gbR9AsKwvqpzuz5/e93Tu5pT94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mU5A6TUEarkgYxej4bZvG+BGaaRgtXWq7+HIxCAHeKUH1F0FmKqoh+IWniLbdJMjGA6jfNXIQ81jUJ9Ssul0dZv5gZqClsh/OiV9n7DOUqDBdBmYKSEr0S+cfRTFj5nqJYOfoGtnF2p8Mw+XIk2psOwZwAqkE2vMvERGO1q6+p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Z2tZ8s8/; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=zPiN/2NQ; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777347822;
	bh=4eekHztIwR+LF/vl/gbR9AsKwvqpzuz5/e93Tu5pT94=;
	h=From:Date:Subject:To:Cc:From;
	b=Z2tZ8s8/absQzmkxquGiJZV0L9QbrXUDz+PU40ENEKNd1jkehjp7GOzzRfOj711xV
	 WPc0Zau37dTiav545nqR39CZAemL3IFuYm/5U+ekpxtMC0eKCku4k7pEPPfVAIECaw
	 PiPfJ1DpOAXnsPV0Ag7uhiiHJQ87zB2HdKkdunJqptMH4dv+ZO0YgUeU34nU2SGWKM
	 GCBOhCo7QHX2vdyL+bkukW4+Eynm/F3JdKWp4AbFlVAGxx5J73PMx5BrE1H2VSIoQw
	 Dg712xA4JCszltuR4k79UaHJsz+0gm6udYa9XAQFY1eXhjCO8ya+B8v14mEBHOBfS/
	 4xD2g/pTRIIBg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 1619747D83; Tue, 28 Apr 2026 03:43:42 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777347819;
	bh=4eekHztIwR+LF/vl/gbR9AsKwvqpzuz5/e93Tu5pT94=;
	h=From:Date:Subject:To:Cc:From;
	b=zPiN/2NQQ+/MGT2qR9AL8e2t9USq5s88ogWterKOB6YaM83Zm2qQCQrw4qE0px2Lo
	 8/32cEN4rjva+vixfzJTnB5Ajx1ahgLxzbN595CQHLq/MCWt/YmO7NqjqApzndiqlX
	 /GohJQ8qUdNeFVvCtlh0hoVpeBaCniMHhLLC8TDTPLamo3tYgE8J6dCStxZImIUN2D
	 pq5ADzr7liaLAZv4Kxe3cKI1qg0NkMZl35W/FpCqfVfEr/WkigCHeZ/esyTOk5tBlw
	 PiTR3Q50knUt9ClOV/516RXQCBpIeOfl3XL0xpQZC3L9nXvgpn2jNZVm2JPC9k3+mQ
	 BIhM3xBF7IPDg==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id BF299475CE;
	Tue, 28 Apr 2026 03:43:39 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 28 Apr 2026 05:43:38 +0200
Subject: [PATCH net-next] r8152: Fix double consecutive clearing of
 PLA_MCU_SPDWN_EN bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-patch_double-v1-1-27c830a9eb2e@birger-koblitz.de>
X-B4-Tracking: v=1; b=H4sIAOks8GkC/x3M0QpAMBSH8VfRubZipHgVSXP8cUqjbaSWd7dc/
 i6+L5KHE3jqskgOt3g5bEKZZ8SbsSuUzMmkC90UtW7UaQJv43xc0w5VLlwxTI2WmVJyOizy/Lu
 eLIKyeAIN7/sB9jgSJGgAAAA=
X-Change-ID: 20260426-patch_double-1fc3cea4e9cc
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>, 
 Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 6C5F947D2BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-281621-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:email,birger-koblitz.de:dkim,birger-koblitz.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Due to a Copy & Paste Error, the PLA_MCU_SPDWN_EN bit was cleared
twice consecutively using ocp_word_clr_bits. Fix that.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
This fixes the issue raised in
https://lore.kernel.org/netdev/8b324f8c-f4f8-4e90-b5d6-9b87ec3daf2b@redhat.com/
that due to an editing error, PLA_MCU_SPDWN_EN is cleared twice
consecutively.
---
 drivers/net/usb/r8152.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 7337bf1b7d6ad03572edbc492706c07a8f58760f..7dba5f3fd052d4db475e61f5c622d89ada1948c1 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -6839,9 +6839,6 @@ static void rtl8156_up(struct r8152 *tp)
 	ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, RXFIFO_FULL_MASK,
 		      0x08);
 
-	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
-			  PLA_MCU_SPDWN_EN);
-
 	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);
 
 	if (tp->version != RTL_VER_16)

---
base-commit: 35c2c39832e569449b9192fa1afbbc4c66227af7
change-id: 20260426-patch_double-1fc3cea4e9cc

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>


