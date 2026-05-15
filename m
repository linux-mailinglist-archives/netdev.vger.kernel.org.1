Return-Path: <netdev+bounces-288238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GL9OC/eBmp4ogIAu9opvQ
	(envelope-from <netdev+bounces-288238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:49:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CCF54BB87
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 518DA312D28E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF4F40627B;
	Fri, 15 May 2026 08:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oTlDHcbb"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2364940B6ED;
	Fri, 15 May 2026 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834332; cv=none; b=LfCLYU2+bUp/Sz3gLcTF6MFzzEVvY1Tv0EqaErkTj9w29tRvxWoVGD4Blaq7b2JD5dAwIN6NjctDNaAc/5GrnMPHhFXrvfjhsu1LLfPPK6n3U/otLFv7+ewxxFrkMkQCYwf9neV6mtGMqFWa8Gy5qdChPY1Xgve2MmMzfk+mSnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834332; c=relaxed/simple;
	bh=VCkcfRpbv9b5dtqBMjM3iSVKt+J37ohgcYnfnhvDCIo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZiYWsDqRuOrD/0A9ZJi8OGxJtnU4bm2DK2LL9peKNiXPsFAv3V15eGhQqQ58Y7JlDuVisZE3+UJGe9dUZC1NL/fi4KqiPsPxvb3snHqfVCLNE0g6Z6CZCLBy5G7uJ/eskSYUTag/VXZdTi5PfQK9vCKwkL2OOliHlVDBmV86YPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oTlDHcbb; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6DE43C5CD6A;
	Fri, 15 May 2026 08:39:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1B1A5606FD;
	Fri, 15 May 2026 08:38:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5399011AF8DB0;
	Fri, 15 May 2026 10:38:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778834326; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Xbue0L3dMbDxUEb9yOeuYbYnCHVUV5F8i0WSiWlEXNM=;
	b=oTlDHcbb6IYx784p9sG3HYhVWHpW3st2KQtSFscrpRhBI1t6M8XrjH3i/Yn1wIZoTFeLsY
	UykT6lPQa6/tIl/QWwe6lUrukP0t53IKcLfQZvUmZVtt4Fh8+aaMr5U1b5VHUDrRm2/p8V
	a/VxbouNXOT2ulCKZBvzWKsJ7ieQCJCCpbcBUJbvg5NTp2Jq/wUYWtiabKHtxEhqbpyPO0
	I9WWplN/77xjrS1wDb3/l8K/HD/rA82qSSm8qOFEUAXJRKod2IC0BaVmatr31VlXM3JDmi
	FOT2gyvhlhmrwr9hYD2uam8SaG4/ZuFZC1uwjiiyUV+E81ovgW1fmWDtWMnOvA==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next v2 0/8] net: dsa: microchip: Remove unnecessary
 ksz_dev_ops callbacks
Date: Fri, 15 May 2026 10:38:35 +0200
Message-Id: <20260515-clean-ksz-2nd-series-v2-0-35a968a739f6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIvbBmoC/22OQQ6CMBBFr0Jm7Zi2BAiuvIdhAWWqjTjVthKUc
 HcruHT55+f9NzME8pYCHLIZPI02WMcpqF0G+tLymdD2KYMSqhSFlKgHahmv4Y2Ke9xozLuqKEj
 XtTYCEnr3ZOy0zp6AKSLTFKHZGk+PZ/LErf4eLzZE51/rE6NcoZ9P/feNEgVqIUypSeSVaY+dc
 3GwvNfuBs2yLB80glcB2QAAAA==
X-Change-ID: 20260511-clean-ksz-2nd-series-3b755ec99cf0
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 50CCF54BB87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288238-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi all,

This series continues the rework of the KSZ driver initiated by a previous
series (see [1]), following the discussion we had here [2].

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

The previous series ([1]) replaced the unique dsa_swicth_ops struct used
by all the KSZ families with one dsa_switch_ops struct for each family.

These dsa_switch_ops structs still rely on common functions that redirect
the calls to ksz_dev_ops operations which are custom to each switch
family. Many of hese ksz_dev_ops callbacks have a direct equivalent in the
struct dsa_switch_ops. This series directly connects the implementations of
these ksz_dev_ops operations to the relevant dsa_switch_ops attribute
to get rid of one unnecessary level of indirection.

On top of this on-going rework I added PTP and periodic output support for
the KSZ8463 (which was my first goal). There are more than 60 patches for
all this so this series will be followed by several others and if you
want to see the full picture we can check my github ([3]).

I haven't finished yet to group all the patches into meaningful series
but here is more or less what I plan to do next:

- A series will split again some operations to get rid of the
  if (is_kszXYZ) branches.
- Maybe another series will be needed to completely move out of
  ksz_common.c everything that isn't truly common to all the switches
- A series will add PTP support for the KSZ8463
- A final series will add periodic output support for the KSZ8463

FYI, I only have a KSZ8463 so, unfortunately, I can't test other switches.

[1]: https://lore.kernel.org/r/20260505-clean-ksz-driver-v1-0-05d70fa42461@bootlin.com
[2]: https://lore.kernel.org/r/20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com)
[3]: https://github.com/bastien-curutchet/linux/tree/ksz_rework

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Changes in v2:
- Remove patches 1 to 7 since they were applied on net-next
- PATCH 6 (previously 13): Create a LAN937x-specific port_setup()
  instead of using the KSZ9477 one
- Link to v1: https://lore.kernel.org/r/20260512-clean-ksz-2nd-series-v1-0-c00f6ce037fa@bootlin.com

---
Bastien Curutchet (Schneider Electric) (3):
      net: dsa: microchip: bypass dev_ops for port_setup()
      net: dsa: microchip: call DSA's phy_{read/write} to do mdio {read/write}
      net: dsa: microchip: bypass dev_ops for phy_read()/phy_write()

Vladimir Oltean (5):
      net: dsa: microchip: don't reset on shutdown or driver removal
      net: dsa: microchip: bypass dev_ops->setup() and teardown() for lan937x
      net: dsa: microchip: bypass dev_ops->setup() and teardown() for ksz9477
      net: dsa: microchip: bypass dev_ops->setup() and teardown() for ksz8
      net: dsa: microchip: remove dev_ops->setup() and teardown()

 drivers/net/dsa/microchip/ksz8.c         | 235 ++++++++++++++++++++++++------
 drivers/net/dsa/microchip/ksz9477.c      | 184 ++++++++++++++++++++---
 drivers/net/dsa/microchip/ksz_common.c   | 241 +++----------------------------
 drivers/net/dsa/microchip/ksz_common.h   |  22 +--
 drivers/net/dsa/microchip/lan937x_main.c | 169 ++++++++++++++++++----
 5 files changed, 520 insertions(+), 331 deletions(-)
---
base-commit: 822d4a8e390a08ccfaf2abb347ae670b230b196f
change-id: 20260511-clean-ksz-2nd-series-3b755ec99cf0

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


