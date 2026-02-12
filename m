Return-Path: <netdev+bounces-258445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GORsLfyzjWl96AAAu9opvQ
	(envelope-from <netdev+bounces-258445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 12:05:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2435112CD63
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 12:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22D5D3020D75
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 11:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE1F3446AD;
	Thu, 12 Feb 2026 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="X0LfRl5Z"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838233446C9;
	Thu, 12 Feb 2026 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770894194; cv=none; b=fLicBVkdOEjEYGXutFo3Z9je6UqGpyl9hBAnomuwdTE7IUB0N88qDySuS4M5ofOwxMoj0/FuEEqMV09IRstDh3Ni/hvGTDFkx9/GhLx3FOvrBwhsVX84bgLhj1xIAPpm0QCJ9p0pTNv8bQqlVszw2zFUa4hlftFZtzV+4Xt/hfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770894194; c=relaxed/simple;
	bh=lvhfM1RcsuG2yW1jVLZ0HWMlZZkBniMMzCrnQtl85qE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=EMmfnJKTgMAJJtKJRMMSAYH0LuvhIvx3dmKXYPv8eGcAIfS8Yh1z2l+/UH1eVgKYDIekoDUXBREOxA4flC9D4As5OJsG9zrUEkWtqwchHo4/MwHVdL9DI0LS1HxLGXvlNfDJjavXhVwxyH4sFZvSmv2W+J73tV8Nb+3BOM0a8Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=X0LfRl5Z; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1770894192; x=1802430192;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=lvhfM1RcsuG2yW1jVLZ0HWMlZZkBniMMzCrnQtl85qE=;
  b=X0LfRl5ZRwh6D30pWWXhDOZ/dqvZ63rZU8b5ki4uJD299qDplEZH57e2
   uH522stzl9EK0qXga3gCF1F23O1LyutfRGujb5h0WckCJuZaG1O0qSond
   lEWULqCalL7zJMpHGE+emHAXK+YX5T5UU8m7wnS0GaCLNnpmVCvprYC7D
   xcgNGw9MpTpIzGnFPr6L0jkNO2ljkAMtiBs41chNhfr+b1TctMkMF/8/g
   CDO/aRjFdfo1fIIma+89qoRKbgxB7/MK7++DCWeQnt9TDjL3L7yirP1C2
   4VkOWmOGWmobYYjOd0e2YABwzcd5FCsoDV10jGdspmTDKpRhxhVVRQezf
   g==;
X-CSE-ConnectionGUID: Yy0qGjpOT4qWCWFiT3Tmhg==
X-CSE-MsgGUID: f4Kq8AOCR5SFzIM1w1Ugyw==
X-IronPort-AV: E=Sophos;i="6.21,286,1763449200"; 
   d="scan'208";a="52581677"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2026 04:03:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 12 Feb 2026 04:02:41 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 12 Feb 2026 04:02:39 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 12 Feb 2026 12:02:30 +0100
Subject: [PATCH net] net: sparx5/lan969x: fix PTP clock max_adj value
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260212-sparx5-ptp-max-adj-v2-v1-1-06b200e50ce3@microchip.com>
X-B4-Tracking: v=1; b=H4sIAEWzjWkC/x3MQQqAIBBA0avErBtQKYmuEi2mnGqCTDRCiO6et
 HyL/x9IHIUT9NUDkW9JcvoCXVcwb+RXRnHFYJSxymiNKVDMLYYr4EEZye14G2ybmaeOnJ2IoLQ
 h8iL5/w7g+YLxfT89sFuQbAAAAA==
X-Change-ID: 20260211-sparx5-ptp-max-adj-v2-54ceb8ad6baa
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258445-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2435112CD63
X-Rspamd-Action: no action

The max_adj field in ptp_clock_info tells userspace how much the PHC
clock frequency can be adjusted. ptp4l reads this and will never request
a correction larger than max_adj.

On both sparx5 and lan969x the clock offset may never converge because
the servo needs a frequency correction larger than the current max_adj
of 200000 (200 ppm) allows. The servo rails at the max and the offset
stays in the tens of microseconds.

The hardware has no inherent max adjustment limit; frequency correction
is done by writing a 64-bit clock period increment to CLK_PER_CFG, and
the register has plenty of range. The 200000 value was just an overly
conservative software limit. The max_adj is shared between sparx5 and
lan969x, and the increased value is safe for both.

Fix this by increasing max_adj to 10000000 (10000 ppm), giving the
servo sufficient headroom.

Fixes: 0933bd04047c ("net: sparx5: Add support for ptp clocks")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
index 2f168700f63c..8b2e07821a95 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
@@ -576,7 +576,7 @@ static int sparx5_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 static struct ptp_clock_info sparx5_ptp_clock_info = {
 	.owner		= THIS_MODULE,
 	.name		= "sparx5 ptp",
-	.max_adj	= 200000,
+	.max_adj	= 10000000,
 	.gettime64	= sparx5_ptp_gettime64,
 	.settime64	= sparx5_ptp_settime64,
 	.adjtime	= sparx5_ptp_adjtime,

---
base-commit: 83310d613382f74070fc8b402f3f6c2af8439ead
change-id: 20260211-sparx5-ptp-max-adj-v2-54ceb8ad6baa

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


