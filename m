Return-Path: <netdev+bounces-290841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEVzLAJfEGobWwYAu9opvQ
	(envelope-from <netdev+bounces-290841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 15:49:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1BC5B57D8
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 15:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E52BD3182611
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F23A3AB5DA;
	Fri, 22 May 2026 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N64Baokz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1493AA4E8;
	Fri, 22 May 2026 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779456104; cv=none; b=PBK9gnMogNQkXEjXn3QVCsiDNhc97aKcfTo6EpghvWtiWzUh5xDK1icEHPugZAbemxoblZh+90peux1yla7ix59ekm6YtcvZ+5pZuGNnr+hFlBgco7IzgvcSjNPAEi84f2cb8t448b/SkBSFAIDhlJvKHJzqBOlO8ubEeaGmQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779456104; c=relaxed/simple;
	bh=w2uC4KEU/XGM0jk2e74rArLy20DXVoL5AqLuH4INTh8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K5m+0tI22zk6azyetuOBQwA4AYszpaolEvKVcUo5GJCywSIFkFGG2s6Vl4HJqH+1kErzeS0WJLGlvCiwciwKBv4XY9oQPVyIKIMF53R/2oytRjGH65eKAGr/4gkzR3SmRrB82rzUB8gyeTODYRa3QrrchPP85ys1KuIn8UkqFdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N64Baokz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F5A1F000E9;
	Fri, 22 May 2026 13:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779456098;
	bh=AFXnbDIOp70mSGa808OXTFdaVCnAygQDwPE1EOrUSLo=;
	h=From:Subject:Date:To:Cc;
	b=N64BaokzKL+1T66c07adCMQSsHX0Srb5Q32B+xeuZsH8KIFAYO9wqb77bdj/00Ig6
	 SuRRT/UmhO19SBd0hgbRpqxbOg+Jecw/DldgUTpH8wobUXl3ugE03HaXC4FYN2dXyZ
	 +KxYsiuly2/acoDIhx3kZ4R+xDymbpLiYy5va18LxzVJAOCFS2LcLZMrCzPszAc9ch
	 +gkZ7yma1nqC6Jen6zTNTBBVYpg+xDpybj0P/4MJrAEOqf7r3mOSjcB2Y+O9oY+geI
	 0hlvOS0I5krWX/PdF2Di07Yx7vf7sUzxjnCN29vIV94+pttkQaAuNfWjz3utwbhxwi
	 i7851FYRLHC5Q==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next v2 0/5] net: dsa: microchip: Add support for
 KSZ8995XA/KS8995XA
Date: Fri, 22 May 2026 15:21:22 +0200
Message-Id: <20260522-ks8995-to-ksz8-v2-0-5712c0dc9e75@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NTQ6CMBCFr0Jm7Zi2UqCuvIdhgTCFqmlNWwlKu
 LsFdu7ey/v5ZgjkDQU4ZzN4Gk0wziYjDhm0Q2N7QtMlD4KJgkmm8BEqpSRGl9S3Qi71Sau2EiX
 XkEYvT9pM2+EVLEW0NEWo9yS8b3dq4/q3dgcTovOfjT3ybbFjePGPGTkyLFnHSOdNI3V+eZC39
 Dw630O9LMsPj5AXS8kAAAA=
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290841-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4B1BC5B57D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/dsa/Kconfig                            |   8 -
 drivers/net/dsa/Makefile                           |   1 -
 drivers/net/dsa/ks8995.c                           | 857 ---------------------
 drivers/net/dsa/microchip/Kconfig                  |   1 +
 drivers/net/dsa/microchip/ksz8.c                   | 166 +++-
 drivers/net/dsa/microchip/ksz8.h                   |   2 +
 drivers/net/dsa/microchip/ksz8_reg.h               |   7 +
 drivers/net/dsa/microchip/ksz_common.c             |  70 +-
 drivers/net/dsa/microchip/ksz_common.h             |  11 +-
 drivers/net/dsa/microchip/ksz_spi.c                |  33 +-
 include/linux/platform_data/microchip-ksz.h        |   1 +
 include/net/dsa.h                                  |   2 +
 net/dsa/Kconfig                                    |   6 +
 net/dsa/Makefile                                   |   1 +
 net/dsa/tag_ks8995.c                               | 132 ++++
 16 files changed, 395 insertions(+), 904 deletions(-)
---
base-commit: f2dfcc4b4bc28ba8ad45bce43ad76fa9575e27f5
change-id: 20260509-ks8995-to-ksz8-15f3f9c8271f

Best regards,
--  
Linus Walleij <linusw@kernel.org>


