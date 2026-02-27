Return-Path: <netdev+bounces-261879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD7/MM+zoWmMvgQAu9opvQ
	(envelope-from <netdev+bounces-261879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:10:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 604111B9767
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC36D303AAA4
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6A143CEDC;
	Fri, 27 Feb 2026 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="E3eIrlyr"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E2643C046;
	Fri, 27 Feb 2026 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204932; cv=none; b=dB7/C6aG/RBuR5fTD9SOvMPR7BRiV8mVPQlg/sBaNCwb7UxZ/v9LL7N5mynTTYp3sk0xMwIKO1AGf876cNqETslVooG2Yx/HQD1w6MurLVaYSA3JeUEkIWaVfIhjHZe8xLG5i90tk47buMPajgchB9A6B+FDl3V+Hh5FlZvPTSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204932; c=relaxed/simple;
	bh=mYoK1FihVJvEr0NMlfRRBuE7/55cVkFDth49zLmyEKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iACgzTFw2hbSB2mlTKnPTGw5+3ej9HoFP2C+mOw4wVupQ7Xe62emy+jTPYjmS6mxWx9ySqaYJfhwIQm8hNWOLgJcBgqFiYWFHEM+s/KHDcoMEKojPwvVmUYCub90/Jmgoi8rEfeR+vb0Hmww486K86i0/9/qOoxTErXm+jdM40M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=E3eIrlyr; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 00EFCA5009;
	Fri, 27 Feb 2026 16:08:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772204926; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=c5YmtHEwmcbZmGCVvz6y3GMkg0blJKUkEfPrdXSW/30=;
	b=E3eIrlyrmu6UOSb0bcHzxlrUE61b0rdu1dNwgAA7tDneUOw6D8jXgm+UL5lmgoLLODAZoy
	e2wyLbxIkkfgqCXW6u1YVIyXUM2ha3TBxdCD575yTRfZv/2YrZPT8Cl6PRyKCHUXZPoCsh
	7S0ETUNJh30K9TjyhRluRWoQgkzS29eq+FwVpUfZ5vw7zq9C0FMj9Ux6YThHypOw0nS7XH
	idIgdEyu+gbymX9/XT7z2nx3XVEW+TXHR8F1kwa6zj3TrQK4JnruMiRrHBIDgHtz+uiUdb
	KKNrpJT1kwnsVtbwHB7R6KIVGct+i6MeLDAziq7i794dGujT+IkU5tKvBcYffQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	claudiu.beznea@tuxon.dev,
	nicolas.ferre@microchip.com,
	linux-kernel@vger.kernel.org,
	theo.lebrun@bootlin.com,
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v5 5/5] net: cadence: macb: enable EEE for Mobileye EyeQ5
Date: Fri, 27 Feb 2026 16:06:10 +0100
Message-ID: <20260227150610.242215-6-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227150610.242215-1-nb@tipi-net.de>
References: <20260227150610.242215-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261879-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:email]
X-Rspamd-Queue-Id: 604111B9767
X-Rspamd-Action: no action

Set MACB_CAPS_EEE for the Mobileye EyeQ5 GEM instance. EEE has been
verified on EyeQ5 hardware using a loopback setup with ethtool
--show-eee confirming EEE active on both ends at 100baseT/Full and
1000baseT/Full.

Tested-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 0196a13c0688..58a265ee9f9e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5518,7 +5518,7 @@ static const struct macb_config versal_config = {
 static const struct macb_config eyeq5_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_QUEUE_DISABLE |
-		MACB_CAPS_NO_LSO,
+		MACB_CAPS_NO_LSO | MACB_CAPS_EEE,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = eyeq5_init,
-- 
2.51.0


