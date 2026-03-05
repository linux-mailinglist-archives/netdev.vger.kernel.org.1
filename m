Return-Path: <netdev+bounces-264491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPxgG4S7qWnNDQEAu9opvQ
	(envelope-from <netdev+bounces-264491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:21:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BEC21610D
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 776FA30073DD
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E773E1205;
	Thu,  5 Mar 2026 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NrGXlW7B"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7A93E3D8E
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731226; cv=none; b=fYSZZbWbP5K6Eklp0KHixbKROWquzPE9i2t0axEWCQKiWeSp3IFkJ0Z6fEBucgapI8QHvpSbMFB9MBjNVXK4r70NgDOmLAFEzAZH2xf2UafgkCSzHVNdt67MGUndmuCS1pMXfJdh1sZ3x8BIFd72isrhc7sxjwoCxd7gjGOuBqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731226; c=relaxed/simple;
	bh=Y0ouDDQ+LaZB66ZT0jc8u+1ijrITArKjExVbr5WCYiA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ApD3HhNCVLMXu06Gb6bkpPxCiI8KBFScMIVkswHOffrrdNizvHgJuE+rbJdsEsSnfGl3NxlKwCX9DjxA/7zq1XGJ8WQhRrE4vC0SIs1SgNe3OwTnkNyRgGJycRQxLZfPjH3vPUnQ1zvlrSFfb0T/KTmzZl+Ufu2P+7mR4us0wWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NrGXlW7B; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 36C371A2CEE;
	Thu,  5 Mar 2026 17:20:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EC2005FF89;
	Thu,  5 Mar 2026 17:20:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 85C9F10369912;
	Thu,  5 Mar 2026 18:20:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772731221; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=rPnXgfPKw4spCG6JXJt/GjbmiMc0No/2f9PmD3Slfdw=;
	b=NrGXlW7BUHdVHWPQUEG0djj9HLR5zAYk03wLItf0WAFtLmXEqqUjrvI/ggUTRnde+txv0R
	QTUmFbiyplk4JNUNkiXRfCA8S2+zZ8iqDsFfqe00+JiAN0lRpsLyYbouljuPou0TK6tKA7
	3fOqYA96Bzgwfcs7nT6WTW0xejeb9jE8yWITVdr0anN3uOFBW9l8PfdgES6A0ezRHv89Hg
	3BMQLqArAU/TnRNuL/jbwE6O9FebIGuJfNiCo3ACo69SYQL/YGe/JNiVy2DCOY+9VCwrcw
	K6QTWyq2a7BTV3OszOQFeyx0N+yqnoItxX2hTZ9nMooSIUGzq1pjLGNSJpvxcA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next 0/2] net: macb: implement ethtool set channels
 count operation
Date: Thu, 05 Mar 2026 18:20:13 +0100
Message-Id: <20260305-macb-set-channels-v1-0-28e3a96a3dc3@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSwqDQBAFryK9TkM7okKuIln4eZM0aCvTIoJ49
 0yyLF69usiRFE7P4qKEQ11Xy1A+Cho/vb3BOmWmIKGRSmpe+nFgx86/2TA710NsIG2sQiuUf1t
 C1PPf7MiyaTh3et33FwqnKnBtAAAA
X-Change-ID: 20260305-macb-set-channels-5bf6e07f3270
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paolo Valerio <pvalerio@redhat.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: C6BEC21610D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264491-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add support for changing the active number of queues. Tested on Mobileye
EyeQ5. The first patch is as expected. However the second one might be
more surprising:

GEM has per-queue Tx SRAM segmentation. If we do not touch SRAM
distribution then we'll only be able to exploit a portion of it when a
smaller queue count is configured. It also is beneficial if bootloader
stages write to the register and we don't reset it but attempt to use
all queues (the default).

The operation is only hidden behind MACB_CAPS_QUEUE_DISABLE, we do not
introduce yet another feature flag.

As this series must s/num_queues/max_num_queues/ quite a lot, it
conflicts with other in-flights series touching MACB in the netdev ML.
I'll make sure to resend once net-next gets updated.

Have a nice day,
Thanks,
Théo

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Théo Lebrun (2):
      net: macb: implement ethtool_ops.get|set_channels()
      net: macb: distribute evenly Tx SRAM segments

 drivers/net/ethernet/cadence/Kconfig     |   6 +
 drivers/net/ethernet/cadence/macb.h      |   6 +
 drivers/net/ethernet/cadence/macb_main.c | 235 ++++++++++++++++++++++++++++---
 3 files changed, 231 insertions(+), 16 deletions(-)
---
base-commit: 3d0508701c2bff577d2ce4fe73bd8954fd969f43
change-id: 20260305-macb-set-channels-5bf6e07f3270

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


