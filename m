Return-Path: <netdev+bounces-304720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TO7EFYZhSWrM0wAAu9opvQ
	(envelope-from <netdev+bounces-304720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 21:39:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6A0708443
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 21:39:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=F7ym3FDR;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304720-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304720-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B43A300623C
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 19:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA762E7F20;
	Sat,  4 Jul 2026 19:39:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000472C15A5;
	Sat,  4 Jul 2026 19:39:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783193983; cv=none; b=VUZsdqmy6QyKemHddLKfOvAS4etJ1ZLM126J3MpNxcxDUzMB2FCQE8V1sCWWJk1p7Hq07FqI0CH2V3L5Jl0S/GealRrt3J3aFgP7LCaxTgNNyUn2fvVeucZrljcvTWIjtCemwbjHSpYEJy8X6kSde1GcIqfowPMDjahGw7sREBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783193983; c=relaxed/simple;
	bh=JjRpRO7NwqoABk5ZPGMoaY4cLUVJ5TD2zxG7Y9xij/8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YIFRmeWryx2BmIzvebocxF4vacMoiJdZF03Jp8wGKMVO64KRmj/4oSa3i+sWsp44VQBLct7WvmOB3V/GACXuoRajuYD7g5KxM0haT9RHM87XnPujGY8tmY2poNE0PYDIgl7kG6MF7wxDDFzXzneaPFXhvRo6DId0+L80k3nPTmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7ym3FDR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D82F1F000E9;
	Sat,  4 Jul 2026 19:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783193981;
	bh=tHdy471i05c0QrpAe/LbUWSkBra3lAcqZ5uBIQozFDI=;
	h=From:Subject:Date:To:Cc;
	b=F7ym3FDRCVHooc2IE5ilOWnHgUJs+UeANKrc16NYRvN8t/NkrHoXFP6pZUopM3M7U
	 PP6p+SbyAPUzCsm0TN25vxl5QOB2e5mHM9+9e2u2ws9Vdt/LEnp27Fu2sgmsMlL/yJ
	 EdO+hCQVTiVZSJWZlFT6NgHsEtUc2r/LK03APnQ/zc8lFLPuwAFmtGF3zZQ/yddlyS
	 r+zVSwzJCrQ11vHmf/bk+PYlVzMMeV//2ZOc6y2xi+SmYGiJDeKfLyAYLU5A5urnRk
	 Nc6gosV/9pZPMyFq4DABnmNCAAx1iY72IxpX/5CM5VndSck8AgwtgPvncKJovLgyIy
	 vYWVmt2tECXOA==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next v7 0/5] net: dsa: microchip: Add support for
 KSZ8995XA/KS8995XA
Date: Sat, 04 Jul 2026 21:39:32 +0200
Message-Id: <20260704-ks8995-to-ksz8-v7-0-2af0eaa545a8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XOz07EIBAG8FfZcBbDAMMfT76H8dDSYRfXtAZqs
 7rpu8t2D1a5zWT4fR9XVignKuzpcGWZllTSNNbFPhxYOHXjkXga6s6kkEag8PxcnPfI56lO344
 DRhV9cNJCZBV9ZIrpsgW+sJFmPtJlZq/3S/ns3yjMt7zb21Mq85S/tu4FNnGvAfO/ZgEuuBWDo
 Ki7DqN+PlMe6f1xysctfZE7L2XjZfVoQQYxBE8WG6/2vu1X1QdUIhoE73xsvP71RqjG6+oJELS
 nKIFs43HvdeOxeu/6jnqNZEz7f7P3rvGm+sFD5YqGEP76dV1/AAdjsgMJAgAA
X-Change-ID: 20260509-ks8995-to-ksz8-15f3f9c8271f
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:marex@denx.de,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:Woojung.Huh@microchip.com,m:devicetree@vger.kernel.org,m:linusw@kernel.org,m:nb@tipi-net.de,m:krzysztof.kozlowski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304720-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A6A0708443

This series breaks with the dated attempt to polish the old
KS8995 driver, and instead implement support for the KS8995XA
in the KSZ driver, and after that delete the old KS8995 driver.

The hardware clearly has the same ancestry, the KSZ8995XA is
just a rebrand of the much older Micrel KX8995XA switch.

The old drivers referce to "KS8995" was actually KS8995XA only,
it never supported the sibling devices KS8995E or KS8995MA.
This is reflected in this patch set.

Add new compatibles, add special code paths for the KSZ8995XA
and add a new tagger for the special front tag found in the
KSZ8995XA.

The patches were tested with the Actiontec MI424WR rev D (which
has the KS8995XA) and OpenWrt as userspace.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v7:
- Rebased on v7.2-rc1
- Rebased on top of Bastiens cleanups.
- Rebased and reworked on top of my patch changing the SKB ownership
  model in the taggers.
- Drop bogus reset routine, keep per-port reset but use the right
  defines.
- Properly implement the 2way queue split support (low/hi prio)
- Drop bogus surplus ops assignment.
- Link to v6: https://patch.msgid.link/20260608-ks8995-to-ksz8-v6-0-d91eb43edcc5@kernel.org

Changes in v6:
- Provide a prompt along with the transition symbol NET_DSA_KS8995
  so that oldconfig works.
- Clarify in commit message that the platform data probe path is
  unused in the kernel and it is fine to delete this mechanism.
- Link to v5: https://patch.msgid.link/20260604-ks8995-to-ksz8-v5-0-98baeb45e665@kernel.org

Changes in v5:
- Rebase on net-next again to be sure we apply.
- Fix the codepath where DCB was set up per-port, damaging KS8995XA
  port registers.
- Fix up the transitional symbol NET_DSA_KS8995 to depend on
  SPI and select both NET_DSA_MICROCHIP_KSZ_COMMON and
  NET_DSA_MICROCHIP_KSZ_SPI.
- Link to v4: https://patch.msgid.link/20260603-ks8995-to-ksz8-v4-0-e15149ef21e7@kernel.org

Changes in v4:
- Create a stub symbol for NET_DSA_KS8995 to phase over users to
  the new driver.
- Link to v3: https://patch.msgid.link/20260526-ks8995-to-ksz8-v3-0-c530f651989f@kernel.org

Changes in v3:
- Rebase on net-next again, moving target!
- Fix a netdev_info() print in the tagger to be netdev_debug()
- Add net/dsa/tag_ks8995.c to MAINTAINERS
- Link to v2: https://patch.msgid.link/20260522-ks8995-to-ksz8-v2-0-5712c0dc9e75@kernel.org

Changes in v2:
- Avoid trying to configure TOS priority settings (DCB) on the KSZ8995XA.
  It does have some support for this, but let's add that later.
- Pick up Krzysztof's ACK on the new DT bindings.
- Reset the KSZ8995XA by disabling and enabling the switch like the old
  driver does.
- Move mutually exclusive Kconfig over to the patch introducing the
  old Micrel compatibles to the Microchip ksz_spi driver.
  (this complaint from Sashiko.)
- Use __be16 instead of u16 when casting into the SKB in the tagger
  (this complaint from Sashiko.)
- Do not modify the hdr->h_vlan_TCI if no hardware accelerated tag
  is detected, it would get nullified. Use whatever the Linux network stack
  assigned to TCI there.
  (this complaint from Sashiko.)
- Avoid dereference of NULL in debug prints in the tagger.
  (this complaint from Sashiko.)
- Ignored comment: Sashiko complains about ilog2(0) being potentially
  undefined but that is clearly defined as 0 in the Linux kernel.
- Link to v1: https://patch.msgid.link/20260516-ks8995-to-ksz8-v1-0-70d0ef4aa5f4@kernel.org

---
Linus Walleij (5):
      net: dsa: microchip: Add fallback Micrel compatibles
      dt-bindings: net: dsa: microchip: Add KSZ8995XA
      net: dsa: tag_ks8995: Add the KS8995 tag handling
      net: dsa: microchip: Support Microchip KSZ8995XA / KS8995XA
      net: dsa: ks8995: Delete surplus driver

 .../devicetree/bindings/net/dsa/microchip,ksz.yaml |   1 +
 MAINTAINERS                                        |   1 +
 drivers/net/dsa/Kconfig                            |   9 +-
 drivers/net/dsa/Makefile                           |   1 -
 drivers/net/dsa/ks8995.c                           | 857 ---------------------
 drivers/net/dsa/microchip/Kconfig                  |   1 +
 drivers/net/dsa/microchip/ksz8.c                   | 187 ++++-
 drivers/net/dsa/microchip/ksz8.h                   |   2 +
 drivers/net/dsa/microchip/ksz8_reg.h               |   7 +
 drivers/net/dsa/microchip/ksz_common.c             |  54 +-
 drivers/net/dsa/microchip/ksz_common.h             |  11 +-
 drivers/net/dsa/microchip/ksz_spi.c                |  33 +-
 include/linux/platform_data/microchip-ksz.h        |   1 +
 include/net/dsa.h                                  |   2 +
 net/dsa/Kconfig                                    |   6 +
 net/dsa/Makefile                                   |   1 +
 net/dsa/tag_ks8995.c                               | 137 ++++
 17 files changed, 408 insertions(+), 903 deletions(-)
---
base-commit: b73bc9ca3686b78b642fb35dcc1fdf874ecb74a1
change-id: 20260509-ks8995-to-ksz8-15f3f9c8271f

Best regards,
--  
Linus Walleij <linusw@kernel.org>


