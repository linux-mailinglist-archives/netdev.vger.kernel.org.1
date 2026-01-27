Return-Path: <netdev+bounces-253762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDfHD5SAeGkzqgEAu9opvQ
	(envelope-from <netdev+bounces-253762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:08:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C450917F5
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46B1D300AB06
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 09:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A541A332918;
	Tue, 27 Jan 2026 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IDaIa0ht"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E797D331A7E
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504822; cv=none; b=UZZiNyZ5EybaznMPHwGqHdU5JRbfsJk1Q7PkwTWQk+sARzA+Vt10sddXdObGX0lY9rXDUvgZAg7qyacOBQieIG0qRwE1egxO2ig5AR9ik9ZwefaX/tgdXrAhJQWsjtOKUkZqh3xE3hB3iZOZQIxKkOxB++3c02kPBvE4bKQ69vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504822; c=relaxed/simple;
	bh=pYgD8kpQ3KVctR8d4QpdOWdT04id6w4N6KRQX1I6p0Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BNdH+EAVVqSlaBblon4HIEf3vE5CL2MRM+Yum++o/F7kWp1KX7vHWX0jVFigNblVka8/RZPB8K6okMjKOgA4TIocLEGcqMsuRKgl6IO1+Oe3UCx+tZqfloo34gqd3m1XTGST5dvgZP+OG8thwGBF4h3WSuGkGVBsmXHjkDNT91A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IDaIa0ht; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1F26FC211CF;
	Tue, 27 Jan 2026 09:06:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 16F59606F5;
	Tue, 27 Jan 2026 09:06:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26043119A8673;
	Tue, 27 Jan 2026 10:06:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769504811; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=0+t3TZRcYNIcXkOZ+SQRewZV56xnQrNY8WSAj2iUXA8=;
	b=IDaIa0htaYhvfW+qELkxc+lk3rV8nwd+nSSRqH1jRtxVxe4md4rWWhOFipH8NI1TvI5E5+
	NNUPI2bW0QRCs+IllE/wIK2Dt7hbDirMB9rxQyGXZ8yirMzql22RYx7VqjcXes2zHnYiEa
	iOIesw+vKnxep09sxBHW8LwTCAJUSxg1c1GdNgYmV+qnu+XWfACk3njte6PZUR6NaGIBSa
	IbxFZS5KLsQnMi+Qtxba2bqi18aB91rbyFOmkaHpHgQZdJtuE8VHoiVDKgxheKcn/NxjaG
	/9qucNUQvQ9KzwKBkpIVygE/72fRU+A9slk6JotbwiLeeE/284aKOu7XaBh5Mg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next v4 0/8] net: dsa: microchip: Add PTP support for
 the KSZ8463
Date: Tue, 27 Jan 2026 10:06:42 +0100
Message-Id: <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACKAeGkC/2WOzU7DMBAGXyXyGSN7Hf+kJ94D9WA7u9SCJiE2U
 UuVd8ekHBpxXH2a2bmxjHPCzA7Njc24pJzGoR7tU8PiyQ9vyFNfbwYCjJCi4+/527VG8alMPEQ
 LKnpLPrasEtOMlC6b7ZUNWPiAl8KO92XGz6+qL39z8Bl5HM/nVA6N8j0RWINWS6ElWhuw7cn10
 KEPMpJw2lCgzXVKuYzzdUte5Ca710m9q1skFzWREJwSkbR4CeNYPtLwXN9upgUeaIA9Db+0MU6
 RjqhF+E+rR9rsaVXpjkQHHoNrO9jT67r+AIs5ERJ6AQAA
X-Change-ID: 20260109-ksz8463-ptp-bc723ca7fac4
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253762-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
X-Rspamd-Queue-Id: 9C450917F5
X-Rspamd-Action: no action

Hi all,

This series aims to add two-step PTP support for the KSZ8463 driver. It
depends on a previous series that was recently applied to net-next:
https://lore.kernel.org/all/20260105-ksz-rework-v1-0-a68df7f57375@bootlin.com/

I've encountered weird behavior with IPv4 and IPv6 layers -- maybe that's
related to the incompatibility with the Linux stack mentionned by commit
620e2392db235 ("net: dsa: microchip: Disable PTP function of KSZ8463") ? --
So the support is only added for the L2 layer.

Patches 1 to 4 add IRQ support for the KSZ8463
Patch 5 adds specific dsa_device_ops for the KSZ8463
Patches 6 to 8 add PTP support for the KSZ8463

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Changes in v4:
- PATCH 4: Fix the unused variable warning reported by the bot
- Link to v3: https://lore.kernel.org/r/20260126-ksz8463-ptp-v3-0-9f092aeb8492@bootlin.com

Changes in v3:
- PATCH 4: Fix the unitialized value reported by clang
- Link to v2: https://lore.kernel.org/r/20260122-ksz8463-ptp-v2-0-b6683f5ce50b@bootlin.com

Changes in v2:
- PATCH 8: Disable PTP by default.
- PATCH 5: TX path: remove timestamp handling
- PATCH 5: RX path: zero the PTP header's reserved area before
  forwarding packets to userspace
- Link to v1: https://lore.kernel.org/r/20260115-ksz8463-ptp-v1-0-bcfe2830cf50@bootlin.com

---
Bastien Curutchet (Schneider Electric) (8):
      net: dsa: microchip: Add support for KSZ8463 global irq
      net: dsa: microchip: Decorrelate IRQ domain from port
      net: dsa: microchip: Decorrelate msg_irq index from IRQ bit offset
      net: dsa: microchip: Add support for KSZ8463's PTP interrupts
      net: dsa: microchip: Add KSZ8463 tail tag handling
      net: dsa: microchip: Enable Ethernet PTP detection
      net: dsa: microchip: Adapt port offset for KSZ8463's PTP register
      net: dsa: microchip: Add two-step PTP support for KSZ8463

 drivers/net/dsa/microchip/ksz8.c        |  12 +--
 drivers/net/dsa/microchip/ksz8_reg.h    |   1 +
 drivers/net/dsa/microchip/ksz_common.c  |  95 ++++++++++++-----
 drivers/net/dsa/microchip/ksz_common.h  |   6 ++
 drivers/net/dsa/microchip/ksz_ptp.c     | 178 ++++++++++++++++++++++++++++----
 drivers/net/dsa/microchip/ksz_ptp.h     |   9 ++
 drivers/net/dsa/microchip/ksz_ptp_reg.h |  11 ++
 include/net/dsa.h                       |   2 +
 net/dsa/tag_ksz.c                       |  70 +++++++++++++
 9 files changed, 334 insertions(+), 50 deletions(-)
---
base-commit: 3adff276e751051e77be4df8d29eab1cf0856fbf
change-id: 20260109-ksz8463-ptp-bc723ca7fac4

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


