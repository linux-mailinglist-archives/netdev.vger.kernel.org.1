Return-Path: <netdev+bounces-284434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFlCNvT++WkqFwMAu9opvQ
	(envelope-from <netdev+bounces-284434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:30:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 407D74CF6B3
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 721C3301952F
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 14:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F0847F2E4;
	Tue,  5 May 2026 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SqSIofmr"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07BF2DF6E9;
	Tue,  5 May 2026 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991119; cv=none; b=ir/3Z3XfR8bnQZ1BszzXotcKAFPDq5l++zJT8BqLVLzIAbMZBhrn/X4QS7PGEW0bPDBJEBlgZvMPw4i8KlcE/yO5WFbvqMtt9PSmSpRsVpQg9nERJawDr04oewgW2ipI4tu81vHCemlb1lzTI1DB3xIt20TULYBAZQNGRkRTuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991119; c=relaxed/simple;
	bh=ylSgTa0W72DyxCju9ySjCPcxAefQfKuaXww/WOQYwpA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AdRCcKvXyQqdPYfSpeVcSA5lsCeByDWy6iN8h3ofQe5SMDHa7MZjiB42/2/qk41R/R0sdBG8Sf5uqlVUR/KZbSqrBAfXVmn8xPDU9VZac3DoE+Y0uFwHdXARp+S8Ity56Bn4xLIBuhIraN2/QpMjrhUt/zlLeg9qkMDLkXESg9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SqSIofmr; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2213A4E42BCE;
	Tue,  5 May 2026 14:25:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E80486053C;
	Tue,  5 May 2026 14:25:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7547711AD0239;
	Tue,  5 May 2026 16:25:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777991113; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=aICNKv9lnpWK0l6apCC+oqRs1NaeSiAP2OOVEKHg8i8=;
	b=SqSIofmrOgv6P6jDJPnQdc/TM/RnqZ2H7LuG1rn0ohEHAoKkgqpIu+pamwBxP+7B57KeMC
	ulIsoMpmPByJ/doFDUWTw6PwJa4SeQf47FAGBarf3KEr5ShtWsI49B2oGex+YAR++lIUGF
	ZoX4NTneN2aYtknS2O90T3AM78xAgJnrNS4V3cPtintuvTWVFr1TN3rJnwQlCUs1bk+O72
	9c4tj/pu84mqoC3ZmK2VbYrp/QeLehv04HKR+M+nhHSA96+oOGV97x/Brw9S0UxywSxWja
	QgRKnIi3CiPbz9cZuOkBu9tbIWKE+0CWwsWECqVEg8NH7aiowHk6su+HUXemWA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next 0/9] net: dsa: microchip: Remove one indirection
 layer
Date: Tue, 05 May 2026 16:25:00 +0200
Message-Id: <20260505-clean-ksz-driver-v1-0-05d70fa42461@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALz9+WkC/x3MQQqDMBBG4avIrDsQY6NtryIuJPlbh5ZpmYiI4
 t0NXX6L93bKMEGmR7WTYZEsXy2oLxXFadQXWFIxeedb1/iW4wej8jtvnEwWGHfp6hDDLdxDTSX
 7GZ6y/pc9KWZWrDMNx3ECkPUANWwAAAA=
X-Change-ID: 20260326-clean-ksz-driver-7d40ec585951
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 407D74CF6B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284434-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]

Hi all,

This series follows the discussions we had on a previous series that
aimed to add PTP support for the KSZ8463 (cf [1]).

The KSZ driver got way too convoluted over time because it uses a common
framework to handle more than 20 switches split in 5 families (see below
table)

+----------+---------+---------+---------+---------+---------+
| Family   | KSZ8463 | KSZ87xx | KSZ88xx | KSZ9477 | LAN937X |
+----------+---------+---------+---------+---------+---------+
| Switches | KSZ8463 | KSZ8795 | KSZ88X3 | KSZ8563 | LAN9370 |
|          |         | KSZ8794 | KSZ8864 | KSZ9477 | LAN9371 |
|          |         | KSZ8765 | KSZ8895 | KSZ9896 | LAN9372 |
|          |         |         |         | KSZ9897 | LAN9373 |
|          |         |         |         | KSZ9893 | LAN9374 |
|          |         |         |         | KSZ9563 |         |
|          |         |         |         | KSZ8567 |         |
|          |         |         |         | KSZ9567 |         |
|          |         |         |         | LAN9646 |         |
+----------+---------+---------+---------+---------+---------+

A unique struct dsa_switch_ops is used by all the switches. Next to it,
each switch family has its own struct ksz_dev_ops with family-specific
callbacks. So the dsa_switch_ops operations handle the specificities of
each family through these ksz_dev_ops callbacks and/or conditional
branches based on the chip ID.

Vladimir initiated a rework of the driver ([2]) which I carried on. On
top of the rework I added PTP and periodic output support for the
KSZ8463 (which was my first goal). There are more than 60 patches for
all this so this series will be followed by several others and if you
want to see the full picture we can check my github ([3]).

This first series aims to split the unique struct dsa_switch_ops into
5 so each switch family will be able to implement its own set of DSA
operations.

I haven't finished yet to group all the patches into meaningful series
but here is more or less what I plan to do next:

- A series will remove from the struct ksz_dev_ops the callbacks
  that have an equivalent in dsa_switch_ops to remove one level of
  indirection.
- A series will split again some operations to get rid of the
  if (is_kszXYZ) branches.
- Maybe a fourth one will be needed to completely move out of
  ksz_common.c everything that isn't truly common to all the switches
- A series will add PTP support for the KSZ8463
- A final series will add periodic output support for the KSZ8463

[1]: https://lore.kernel.org/r/20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com)
[2]: https://github.com/vladimiroltean/linux/tree/ksz_separate_dsa_switch_ops
[3]: https://github.com/bastien-curutchet/linux/tree/ksz_rework

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Bastien Curutchet (Schneider Electric) (3):
      net: dsa: microchip: Remove unused ksz8_all_queues_split()
      net: dsa: microchip: remove unused port_cleanup() callback
      net: dsa: microchip: split ksz_connect_tag_protocol()

Vladimir Oltean (6):
      net: dsa: microchip: move KSZ8 ksz_dev_ops to ksz8.c
      net: dsa: microchip: move KSZ9477 and LAN937 ksz_dev_ops to individual drivers
      net: dsa: microchip: move phylink_mac_ops to individual drivers
      net: dsa: microchip: ensure each ksz_dev_ops has its own dsa_switch_ops
      net: dsa: microchip: hook up ksz_switch_alloc() to chip-specific dsa_switch_ops
      net: dsa: microchip: split ksz_get_tag_protocol()

 drivers/net/dsa/microchip/ksz8.c         | 506 ++++++++++++++++++++---
 drivers/net/dsa/microchip/ksz8.h         |  62 +--
 drivers/net/dsa/microchip/ksz8863_smi.c  |   8 +-
 drivers/net/dsa/microchip/ksz9477.c      | 283 ++++++++++++-
 drivers/net/dsa/microchip/ksz9477.h      |  24 +-
 drivers/net/dsa/microchip/ksz9477_i2c.c  |   8 +-
 drivers/net/dsa/microchip/ksz_common.c   | 672 ++++++-------------------------
 drivers/net/dsa/microchip/ksz_common.h   | 106 ++++-
 drivers/net/dsa/microchip/ksz_spi.c      |   8 +-
 drivers/net/dsa/microchip/lan937x.h      |  21 +-
 drivers/net/dsa/microchip/lan937x_main.c | 164 +++++++-
 11 files changed, 1108 insertions(+), 754 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260326-clean-ksz-driver-7d40ec585951

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


