Return-Path: <netdev+bounces-263717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPlGDCcHqGnSnQAAu9opvQ
	(envelope-from <netdev+bounces-263717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:19:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E78F1FE37E
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B71F303AB43
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E1E39EF33;
	Wed,  4 Mar 2026 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PhtzsyZF"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B7939F185
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619543; cv=none; b=LkYmlhZBJbYWmJB80509j9p+ETLzvugzcAElB32y5xhAVjf07fksQLffOJvVWGDVXCW6XEH/MU2v0sd9rCN3QxC2JZ9LenraJNdu7x60PTrCEmuDSBB36kENL3KMNyZ7QhaEkk2ezfoo4P2pdZta1/UsnrLIMrxwH0WLyAn88Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619543; c=relaxed/simple;
	bh=4OwQDno+1oWkopi42R171an7EPFlc3BJe5VspknCAsg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uGfhTzlA0YHlpcmxOOYdmRSBSW3HAb0h3S/49H1YJZs1bxrH3FOCyjjebMgFktTJ24SD0Vkc1zFEy1g1kup3SWcpbywI3Scd2w46zpNHT/yDv66ATaUpZrKtG8ylFiqYJgiF/YW/Tz0OzzBpujZtvESFuB2A80D+MChrlf3YhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PhtzsyZF; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 10E7C4E42539;
	Wed,  4 Mar 2026 10:19:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D87445FF5C;
	Wed,  4 Mar 2026 10:19:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A99431036977C;
	Wed,  4 Mar 2026 11:18:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772619539; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Igyu6RtMirMiXXuCengiK07i/LaV9oqAdKqw2NptrLI=;
	b=PhtzsyZFRR/scUq8nl8V2Vrw1CiHC+AVaxqEejg6b7tTslfojzyYijMNYHZc9DQKorD3qY
	mujB5tiZwaPVeBfJPtg915lggDLrgKpeEofTXVS0zUhhbe4aJKkbArvPmhMXrwIBjQtnwQ
	SStA9LA3zdiHLhtM/GAvlWfHYppqhX5bI1d31U1LNvh28vyAQZZlSO6vLoRor6GNLV6Qp1
	aJtLsJWwSukjEH1I2HdPmm8yoAkxZnCc0Qr6U3AYzr0PNdMmECSK2DCmft6ITofJCJfZ3Q
	BgvlY+3XiHAicKq7ZTu2VbrPAYpG//KXUT80BFmeI9xgJZI14vtNqbynwljSnQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next v6 0/9] net: dsa: microchip: Add PTP support for
 the KSZ8463
Date: Wed, 04 Mar 2026 11:18:51 +0100
Message-Id: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAsHqGkC/2XNTW7DIBAF4KtErEsFw4/trHqPKgsgQ4PaYtdQK
 2nku5fYi5p6+Wb0vXcnCceAiRwPdzLiFFLoYwn66UDcxcQ3pOFcMgEGmnHW0ff000ot6JAHal0
 DwpnGGydJEcOIPlyXtlcSMdOI10xO62fEr+9Sn9f343gJKffjbdme+ILWGa6qmYlTVrY8QiuY8
 4q92L7PHyE+u/5zqZ9gowFqDQ+tdSu8cqiY3Wux1brWoujOsw4M2lZ2sNdyq5tay6K1AmTAjcF
 W77X60/B/WxXNrQPpbaehOdd6nudfxevxVb8BAAA=
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
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 8E78F1FE37E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263717-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Action: no action

Hi all,

This series aims to add two-step PTP support for the KSZ8463 driver

I've encountered weird behavior with IPv4 and IPv6 layers -- maybe that's
related to the incompatibility with the Linux stack mentionned by commit
620e2392db235 ("net: dsa: microchip: Disable PTP function of KSZ8463") ? --
So the support is only added for the L2 layer.

Patches 1 to 4 add IRQ support for the KSZ8463
Patch 5 and 6 add specific dsa_device_ops for the KSZ8463
Patches 7 to 9 add PTP support for the KSZ8463

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Changes in v6:
- ALL: Address the warnings about lines exceeding 80 characters. Some
  remain because readability is better this way IMO
- PATCH 1: Add a comment to explain why the introduced 16-bits read is safe
  for all the switches.
- Link to v5: https://lore.kernel.org/r/20260226-ksz8463-ptp-v5-0-1bc24fb9627d@bootlin.com

Changes in v5:
- Rebase on v7.0-rc1
- PATCH 1: Add Maxime's Reviewed-By
- Add PATCH 5 and modify PATCH 6 to share more code with already existing
  tag operations. Also address Jakub comment about alphabetical order
- PATCH 7: Add details in commit log
- PATCH 9: Set the pdelayresp_flag in the xmit worker to avoid race
  conditions
- Link to v4: https://lore.kernel.org/r/20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com

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
Bastien Curutchet (Schneider Electric) (9):
      net: dsa: microchip: Add support for KSZ8463 global irq
      net: dsa: microchip: Decorrelate IRQ domain from port
      net: dsa: microchip: Decorrelate msg_irq index from IRQ bit offset
      net: dsa: microchip: Add support for KSZ8463's PTP interrupts
      net: dsa: tag_ksz: Share code for KSZ8795 and KSZ9893 xmit operations
      net: dsa: microchip: Add KSZ8463 tail tag handling
      net: dsa: microchip: Explicitly enable detection of L2 PTP frames
      net: dsa: microchip: Adapt port offset for KSZ8463's PTP register
      net: dsa: microchip: Add two-step PTP support for KSZ8463

 drivers/net/dsa/microchip/ksz8.c        |  14 +-
 drivers/net/dsa/microchip/ksz8_reg.h    |   1 +
 drivers/net/dsa/microchip/ksz_common.c  | 101 +++++++++++----
 drivers/net/dsa/microchip/ksz_common.h  |   6 +
 drivers/net/dsa/microchip/ksz_ptp.c     | 204 ++++++++++++++++++++++++++---
 drivers/net/dsa/microchip/ksz_ptp.h     |   9 ++
 drivers/net/dsa/microchip/ksz_ptp_reg.h |  11 ++
 include/net/dsa.h                       |   2 +
 net/dsa/tag_ksz.c                       | 223 ++++++++++++++++++++------------
 9 files changed, 439 insertions(+), 132 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260109-ksz8463-ptp-bc723ca7fac4

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


