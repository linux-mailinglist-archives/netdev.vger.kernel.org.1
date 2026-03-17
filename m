Return-Path: <netdev+bounces-268678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APnlBx9/uWmxHAIAu9opvQ
	(envelope-from <netdev+bounces-268678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:19:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B93F92ADCE9
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59D8B3034C7B
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA657306B31;
	Tue, 17 Mar 2026 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ch0WEW4W"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2264D309EF9;
	Tue, 17 Mar 2026 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764364; cv=none; b=CH3adTn/2kB0v/AWi2fQI0a5OhyB6IRF74B54r8RkJgCSyPJHKBGR+2iNYdAQCjczE9ldXxf878kyLo0nZx/A1rcj3uLyMBY3Hhya4FDcP5qSIOLr1KwKtB2kooBsjsNxgCqC1IqqhIEc1sC0//xaGe7exQtfYdDCYtOuTCE1JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764364; c=relaxed/simple;
	bh=bl7AFz1ukel+Q8DeXTgCfmG4N1OLXXAx92mqWosOac0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CmQx1/zLOftI+o4ck5GjmWLCXWl52csRMp3GiG7Bn9RCMZv0mjZSve/nA0AgWc+ol9vbns3NAmfyxaxgPfepQKyITn71c8XiOJmFschDqQWAZG61poDoVPHKI0Ak/lNULS+gQpMyMkp7Eg9ZG09lLA+XiWRkKZK7kSFu8Bws1gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ch0WEW4W; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5A9594E426D0;
	Tue, 17 Mar 2026 16:19:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 104455FC9A;
	Tue, 17 Mar 2026 16:19:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6797810450640;
	Tue, 17 Mar 2026 17:19:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773764358; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=th6/tJ8KIrKVzPm4D39/MqG3gFzhiRP5oHdvb/5lKP4=;
	b=ch0WEW4WaC5bomXNwmHUlxYrNp/RpcmW4x0siHT/0rtGxev5VYnPI1YGq7Du5QR4mzCAhp
	4PtyuQ+T4VAiUdcYllJDEXXMFhFs2uN6Uqfc52ULexSaBl/8pwS957rCj0CLWops7ErnjZ
	g+Zcc/rpnThoHZfsBA663ncEMue1dZTrfCoVqwR63XUnOTE0LU2hvaNY9zYjrHTPOr7Q41
	HjY6sHsPGFbb57rbdFUAT4P7nbB4P2uv8CqB9g4WWdNQ+eUQsatsYTvm+iCECsccJWukRy
	oiKGiTjmDnP/bkT3bf2cJaniRRVFB4X3LqM2GKZYkPDhRh5xO/Wt3V4Vu9LCWg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v4 0/2] net: macb: implement ethtool set channels
 count operation
Date: Tue, 17 Mar 2026 17:19:07 +0100
Message-Id: <20260317-macb-set-channels-v4-0-1bd4f4ffcfca@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPt+uWkC/33NQQ6CMBAF0KuQrq1pO1LAlfcwLtoylSbYmpYQD
 OHuVlYYicufP//NTBJGh4mci5lEHF1ywedwOhTEdMrfkbo2ZyKYkAxYSR/KaJpwoJ/aY59oqa1
 EVlkQFSN594xo3bSaV+LzpcdpILfcdC4NIb7WZyNf+z/uyCmjokZQjVTQGrjoEIbe+aMJj9Ubx
 cbgfM8Q2WhqIRtQ3JbW/BqwNWDPgGwYKXVV1bxtdf1tLMvyBsRp6jlGAQAA
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
X-Mailer: b4 0.15-dev
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268678-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B93F92ADCE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Have a nice day,
Thanks,
Théo

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v4:
- macb_set_channels(): drop `count == old_count` check, it is redundant
  with both netlink and ioctl codepaths. See early returns in
  ethnl_set_channels() and ethtool_set_channels(). Discussion @ V2.
- Rebase to latest net-next (8737d7194d6d); nothing to report.
- Link to v3: https://patch.msgid.link/20260313-macb-set-channels-v3-0-c66b7781ddb8@bootlin.com

Changes in v3:
- Makefile: fix compilation of kunit tests. This bug was hidden before
  because everything was builtin so it ended up linked together anyway.
  Now macb.o is the amalgation of macb_{main,ptp,utils}.o and
  macb_test.o is the amalgation of macb_{kunit,utils}.o.
- Kconfig CONFIG_MACB_KUNIT_TEST entry:
  - Turn into tristate; no good reason to restrict to bool.
  - Drop "depends on MACB". We do not need to compile the full MACB
    driver to test gem_sram_distribute_segments().
- Add usual MODULE_*() macros to macb_kunit.c.
- Drop unused init value of `ret` in macb_set_channels().
- Rebase to latest net-next; nothing to report.
- Link to v2: https://patch.msgid.link/20260311-macb-set-channels-v2-0-982693a1f5fc@bootlin.com

Changes in v2:
- Move gem_sram_distribute_segments() from macb_main.c to macb_utils.c
  and kunit tests from macb_main.c to macb_kunit.c.
- macb_set_channels():
  - Add comment about MACB_CAPS_QUEUE_DISABLE.
  - Refuse operation if netif_running(), with code comment.
  - Drop useless sanity checks on ch->{combined,rx,tx}_count.
- Add help text to CONFIG_MACB_KUNIT_TEST.
- Fix `checkpatch --max-line-length=80` warnings.
- Rebase onto latest net-next; nothing to report.
- Link to v1: https://lore.kernel.org/r/20260305-macb-set-channels-v1-0-28e3a96a3dc3@bootlin.com

---
Théo Lebrun (2):
      net: macb: implement ethtool_ops.get|set_channels()
      net: macb: distribute evenly Tx SRAM segments

 drivers/net/ethernet/cadence/Kconfig      |  12 ++++
 drivers/net/ethernet/cadence/Makefile     |   5 +-
 drivers/net/ethernet/cadence/macb.h       |   9 +++
 drivers/net/ethernet/cadence/macb_kunit.c |  77 ++++++++++++++++++++
 drivers/net/ethernet/cadence/macb_main.c  | 115 +++++++++++++++++++++++++-----
 drivers/net/ethernet/cadence/macb_utils.c |  56 +++++++++++++++
 6 files changed, 257 insertions(+), 17 deletions(-)
---
base-commit: 1b0fdd40f80731e63c6c7559d67ffde224a63bd2
change-id: 20260305-macb-set-channels-5bf6e07f3270

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>


