Return-Path: <netdev+bounces-266702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F4fOMGbsWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:43:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4696E267813
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8CF83013688
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF233E1CFD;
	Wed, 11 Mar 2026 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FftUn82e"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087BF3E0C5E
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247326; cv=none; b=eTeAczs9rLqClKUHNrdev/O6M7sFUw5H/WX/dfOrCE1EoYAX+x7LqLI7HrG1eiGdIE4N52At4WqPV0B0v+PRyNLm23fo+ugUoUdKHrxTywf8EPLouldT7NpDaYHmVT4cwlkBg86amMywbcZ0lQUEqFEizzmDk6MlJ6k4ddIBQ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247326; c=relaxed/simple;
	bh=Rxwu7P2BsBf7J3IMi0b3ZYktsM6QyOeW9SKkUNzmkwM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V4PAnt/8oMWPaBOFzGFMx+ZNcIeVVhVhlaO8uuM/RlSjDrsw0FaK1e55ewPseF0seI8Zfy7tm0/sKwqF0ENjwAmlFsVssG2HlRrFcQUrgx4oXMzDbSuOFX+OCjbCa+xiXwVR9WMkLjTZ2oZWQA0u+ghiR96RC6TVw1Qsg2cwgS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FftUn82e; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 92CA9C41588;
	Wed, 11 Mar 2026 16:42:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3971B60004;
	Wed, 11 Mar 2026 16:42:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36DAA10369C3E;
	Wed, 11 Mar 2026 17:41:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773247321; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=JcIMZNMBI1wXpXximaDXv28O7qFSIHi31ekLqyAd7Hc=;
	b=FftUn82eNPTqQwYk+E19drRGFnglXM5f2DDFCtgUh7JjlbtFMXtSNWzMmSo+0ztL6YEoqL
	IqmdyfCOoEeRnibpNB7ZN8AOUqm1q0OjGPGDZ9s/5gVPf4F+I8jpDbZjtd2qlsNYFB44fH
	iX4MRw59LnpFJeljZ+iTkmzrKeJuXG19q//ST2MXjt08jFm4N5rvWZg25XGN/p1jNETBbn
	NnDREneC2eHLUOZCqHFkPVIPEpcFtfTve/1DTbPJTS31r2B5ry0u+kvJJoHRywzNAbiKsW
	Y7v/Wakna6Q9xHeI9242304sIljtSkEzsBUUx+ul70do+XavgFSjheIwfGdgTA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v2 0/2] net: macb: implement ethtool set channels
 count operation
Date: Wed, 11 Mar 2026 17:41:52 +0100
Message-Id: <20260311-macb-set-channels-v2-0-982693a1f5fc@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFCbsWkC/32NQQ6DIBBFr2Jm3WkQorZd9R6NC8SxTqJggBgbw
 91LOUCXP+//908I5JkCPKoTPO0c2Nkc5KUCM2v7JuQxZ5BCtkKJBldtBgwU8YctLQGbYWpJdJO
 SnYC82zxNfBTnC2xuWjoi9JnMHKLzn3K214X/8e41CpQ3UvreajUa9Ryciwvbq3Er9CmlL6GtE
 cy+AAAA
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266702-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4696E267813
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

As this series must s/num_queues/max_num_queues/ quite a lot, it
conflicts with other in-flights series touching MACB in the netdev ML.
I'll make sure to resend once net-next gets updated.

Have a nice day,
Thanks,
Théo

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
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

 drivers/net/ethernet/cadence/Kconfig      |  13 ++++
 drivers/net/ethernet/cadence/Makefile     |   5 +-
 drivers/net/ethernet/cadence/macb.h       |   9 +++
 drivers/net/ethernet/cadence/macb_kunit.c |  73 ++++++++++++++++++
 drivers/net/ethernet/cadence/macb_main.c  | 118 ++++++++++++++++++++++++++----
 drivers/net/ethernet/cadence/macb_utils.c |  56 ++++++++++++++
 6 files changed, 257 insertions(+), 17 deletions(-)
---
base-commit: df99d268555f52fb2ac3b9fc9a6198ea0579c48a
change-id: 20260305-macb-set-channels-5bf6e07f3270

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>


