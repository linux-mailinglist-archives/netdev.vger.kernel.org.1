Return-Path: <netdev+bounces-267515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNkLHsgrtGkEigAAu9opvQ
	(envelope-from <netdev+bounces-267515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:22:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A749285DBE
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3624E3013DF9
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ED238C2AB;
	Fri, 13 Mar 2026 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HFPp8o9X"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F15336BCEB
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414958; cv=none; b=eZoWxpx3rQH71/YNnE2ywI/MGptR6v//CXPn+C15ySF/G5RDgLd4x69Xe1ZKwqq8QOp9A14zuqRNkH3yfqHRPL392FZVn5mhgD4GtKu7tR/68zQpuIY28F4nGmNoOgmm82HoiV1S9PexXfm0PnpZLdLlLdCgd1l6tuxrarOvUOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414958; c=relaxed/simple;
	bh=Ce+7IC/LFaOl2mrbqHBFtXOoBlaINgshIiBQmfGrzVc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NIPLXVH+G9/GwGBh3m3VJHFjHdMB6ob9XzSMDanO5RFhpE/kq4aeqYNwJCuOnuSZxx1DYk/FkKd8PkcjQIzKLHcF4vx0tzWwUXq23TVV2Gs1m013OGebs/tL3fNF3tToh3VttYYqj4g+8J3XhME/Nr6/Uqc+BAZy1rxwheG9Pec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HFPp8o9X; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3E5ACC4270D;
	Fri, 13 Mar 2026 15:16:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0A01360027;
	Fri, 13 Mar 2026 15:15:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E01810369F34;
	Fri, 13 Mar 2026 16:15:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773414954; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=jU4TBcbKQQZrRobnR65QkEm67FW9qdOc1tqp92Pb9XE=;
	b=HFPp8o9XRtK3FSGDUw++PIbJa7RPu4PwsLCgJyHbEZKTpOlX4gmnBWHxWhViApPd0Y2m/j
	UZeJFM58QSYcn5JGwkbjXCdT5PVdN38MIPZxUwSW/jxgDCuAFo2bgFQXUA4EU/MTzOzX1h
	iULd/rtyshbtZeApJVy8S9DyH1V61vsUp1gjO02KGmaDBShBuK56GaZiDijH7nq7GaVQP7
	lVWvDexieBzhL2lEMflEo2NJnpNRl1axz/KtJFBL00qr9vGS0qS2NismI7KNmdo6ZFbZKN
	EAH9K+pBY5uRNIcTI74Cjpc5pZRBXpAa1IgtzWf5pPtp/PG3RNhatwOT4PTr6g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v3 0/2] net: macb: implement ethtool set channels
 count operation
Date: Fri, 13 Mar 2026 16:15:51 +0100
Message-Id: <20260313-macb-set-channels-v3-0-c66b7781ddb8@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACgqtGkC/33NTQrCMBAF4KvIrI3kh6atK+8hLtJ0YgNtIkkIl
 dK7G7NSEJePN++bDSIGixHOhw0CZhutdyWI4wH0pNwdiR1LBk65pII2ZFF6IBETedcO50iawUi
 krRG8pVB2j4DGrtW8giuXDtcEt9JMNiYfnvVZZrX/42ZGKOEdCtVLJUYtLoP3abbupP1Svcw/D
 MZ+GbwYfcdlLxQzjdHfxr7vL4BVGlcCAQAA
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
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267515-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,msgid.link:url]
X-Rspamd-Queue-Id: 1A749285DBE
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

 drivers/net/ethernet/cadence/Kconfig      |  12 +++
 drivers/net/ethernet/cadence/Makefile     |   5 +-
 drivers/net/ethernet/cadence/macb.h       |   9 +++
 drivers/net/ethernet/cadence/macb_kunit.c |  77 +++++++++++++++++++
 drivers/net/ethernet/cadence/macb_main.c  | 118 ++++++++++++++++++++++++++----
 drivers/net/ethernet/cadence/macb_utils.c |  56 ++++++++++++++
 6 files changed, 260 insertions(+), 17 deletions(-)
---
base-commit: 5d27b84e6c4f6305765505188d1de27ebfd78e38
change-id: 20260305-macb-set-channels-5bf6e07f3270

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>


