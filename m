Return-Path: <netdev+bounces-266506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PhOHqYhsWkOrQIAu9opvQ
	(envelope-from <netdev+bounces-266506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:02:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D321A25E5AF
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6924D32C3221
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 07:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2753B6343;
	Wed, 11 Mar 2026 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofuhcTQo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913623B38B6;
	Wed, 11 Mar 2026 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215642; cv=none; b=oghicAm8+EWPWqSppYCgD0/l6l/+/wBE+Ix2LLJ1+1b1W5pbRjfTB4clevhVFXff5kse0/egNwyPHNELrO0+kqxlzN9OH6WHqJUS6sR+PDdf//x+SFQA/a/KZzahXC6Hh18A0I77khO5nAtLzh+TBaqZ6TzS2kn7VZq2gbjtnaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215642; c=relaxed/simple;
	bh=5BH0XLykQgNrQNKOTXesrRDorvTmEgpTDI3sJGb8+u8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U4pLwqlmeNIwPGFDlpq+M7bvFMMNqYOhu3It+t7HfBaoqJu4Lle+kL4147Bhwe3RPjysflfUSUZKi2LfDMZIdLhaOfQTGTD143kxMzZmvd1J1ueiB5Ds+1K32oak7LuCBtMjVLa3+Kki59F2TGbwdBot7bpTc3SiTpsmlxNrAzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofuhcTQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9BD9C4CEF7;
	Wed, 11 Mar 2026 07:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773215642;
	bh=5BH0XLykQgNrQNKOTXesrRDorvTmEgpTDI3sJGb8+u8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ofuhcTQoPjfXY+ytNgQgZ06azHReATTnhP/kIlPqAwIDeGcTL0bmxLEMR5AQ/2FY8
	 WtUKYZnuMmhws31G3QyP5yguVktnMZJohg9qFBPfYxgCLmDPWJhge/co0cvP1bIwTL
	 3is+lNciVoro/NibfUjenMf7vaXMv0O1r1fXsLuIoI3XaWhQF4BGGOvixSYYNOZKZl
	 uOd+YUzkr5Dhs0Uc3+4rWVXbrTW6Cz5b5STIUNOaxfxkNxhdohxeQd3sf6fWZOdBbJ
	 s868bpHfqG/NbpV3nE31F1WTJ/zv/YqoxHoeLobSaH7s3T6DjRhiyPeswerO6C/9lx
	 miMTPasYJU31Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D242BFD0649;
	Wed, 11 Mar 2026 07:54:01 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Subject: [PATCH v9 0/5] Support multi-channel IRQs in stmmac platform
 drivers
Date: Wed, 11 Mar 2026 08:53:55 +0100
Message-Id: <20260311-dwmac_multi_irq-v9-0-f0c03ef8d01f@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJMfsWkC/23S22rDMAwG4Fcpvl6KLR9i92rvMUaxFWs1LEmXd
 FlHybvPKRsNcy5/gT4LyTc2xiHFkR12NzbEKY2p73JwTzuGJ9+9xSo1OTPgoAVwVzVfrcdj+/l
 +Scc0fFSusWS4MoAoWO46D5HS9S6+vOZ8SuOlH77vD0xiqf5aQhXWJCpeSaMN+MCjo/q5H8d9d
 z3vsW/Zok3wJxieiVKARQgWHEje8FqUglwLshRkFhC1JAjROrMhqLVgS0FlwQJ5qQgJCEpBPwT
 YmkEvAqFxzmvyqErBrAVdCiYLoHQg0dRCcCyFei2YUqizQJaiDC47YWMG+xDkxs+Y7CLwvMuAV
 gj/75rzPP8A12QUZ34CAAA=
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, rmk+kernel@armlinux.org.uk, 
 vladimir.oltean@nxp.com, boon.khai.ng@altera.com, 
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773215640; l=4657;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=5BH0XLykQgNrQNKOTXesrRDorvTmEgpTDI3sJGb8+u8=;
 b=O6ILZtXXVL4OJaO8m37PvONztWwM2ZzLUzFvenQDmqBrZWN48/OBmVObsizApJWse2xwGE0wA
 ejqrlcHhchvC7tgNrrMWGbSUWqYdyT3E2inNQ38LeX9K/r2nTWH+Kl0
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com
X-Rspamd-Queue-Id: D321A25E5AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266506-lists,netdev=lfdr.de,jan.petrous.oss.nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	HAS_REPLYTO(0.00)[jan.petrous@oss.nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,oss.nxp.com:replyto,oss.nxp.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The stmmac core supports two interrupt modes, controlled by the
flag STMMAC_FLAG_MULTI_MSI_EN:

- When the flag is set, the driver uses multi-channel IRQ mode (Multi-IRQ).
- Otherwise, a single IRQ line is requested (aka MAC-IRQ):

static int stmmac_request_irq(struct net_device *dev)
{
        /* Request the IRQ lines */
        if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN)
                ret = stmmac_request_irq_multi_msi(dev);
        else
                ret = stmmac_request_irq_single(dev);
}

At present, only PCI drivers (Intel and Loongson) make use of the Multi-IRQ
mode. This concept can be extended to DT-based embedded glue drivers
(dwmac-xxx.c).

This series adds support for reading per-channel IRQs from the DT node and
reuses the existing STMMAC_FLAG_MULTI_MSI_EN flag to enable multi-IRQ
operation in platform drivers.

The final decision if Multi-IRQ gets enabled remains on glue driver
to allow implementing any reguirements/limitions the focused platform
needs.

NXP S32G2/S32G3/S32R SoCs integrate the DWMAC IP with multi-channel
interrupt support. The dwmac-s32.c driver change is provided as an example of
enabling multi-IRQ mode for non-PCI drivers.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
Changes in v9:
- Changed interrupt minItems from 11 to 1 to support backward compatibility
  and removed the 'Reviewed-by' accordingly for patch 4
- Link to v8: https://lore.kernel.org/r/20260309-dwmac_multi_irq-v8-0-f0cc5bc811a7@oss.nxp.com

Changes in v8:
- Rewritten queue irq getter, based on Russell's (ready-to-use) hint
- Renamed s32_gmac_validate_multi_irq() to s32_gmac_setup_multi_irq() to
  better describe the functionality
- Fixed typo in commit message for patch 5
- Renamed label in patch 5 to make it more descriptive
- Link to v7: https://lore.kernel.org/r/20260226-dwmac_multi_irq-v7-0-f8fe3b945bb4@oss.nxp.com

Changes in v7:
- Optimized 2 similar loops on queue rx/tx irq reading
- Swap the yaml and dts patches with hope it fix dt_binding_check failing
- Link to v6: https://lore.kernel.org/r/20260225-dwmac_multi_irq-v6-0-245bf1d7110c@oss.nxp.com

Changes in v6:
- Added 2 mintainers which were not covered by 'b4 prep --auto-to-cc'
  but complained on patchwork check
- Added helper macro for loop over queue-based arrays (inspired by AI
  review)
- Added full validation on all channel IRQs
- Link to v5: https://lore.kernel.org/r/20260223-dwmac_multi_irq-v5-0-8fc699a5fac4@oss.nxp.com

Changes in v5:
- fixed typo in "symetrical"
- cleaned negative return value on platform_get_irq_byname_optional()
  in stmmac_get_platform_resources()
- rebased on v7.0-rc1
- Link to v4: https://lore.kernel.org/r/20260128-dwmac_multi_irq-v4-0-82fa34fcf2f2@oss.nxp.com

Changes in v4:
- Fixed IRQ reading check
- Made cleaner the IRQ validity (to get AI reviewer happy)
- Fixed minItems of interrupts property in yaml
- Link to v3: https://lore.kernel.org/r/20260123-dwmac_multi_irq-v3-0-cc53f2be8961@oss.nxp.com

Changes in v3:
- removed RFC prefix
- rebased on v6.19-rc6
- fixed forgotten extra line setting to Multi-IRQ unconditionally
- fixed yaml
- Link to v2: https://lore.kernel.org/r/20260121-dwmac_multi_irq-v2-0-3b829230d071@oss.nxp.com

Changes in v2:
- Fixed incorrect buffer len for 'rx-queue-%d' property check
- Added backward compatibility to not break old settings
- Fixed DT example in yaml
- Link to v1: https://lore.kernel.org/r/20251214-dwmac_multi_irq-v1-0-36562ab0e9f7@oss.nxp.com

---
Jan Petrous (OSS) (5):
      net: stmmac: Use helper macro for loop over queue-based arrays
      net: stmmac: platform: read channels irq
      arm64: dts: s32: set Ethernet channel irqs
      dt-bindings: net: nxp,s32-dwmac: Declare per-queue interrupts
      stmmac: s32: enable support for Multi-IRQ mode

 .../devicetree/bindings/net/nxp,s32-dwmac.yaml     | 47 ++++++++++++++++--
 arch/arm64/boot/dts/freescale/s32g2.dtsi           | 26 ++++++++--
 arch/arm64/boot/dts/freescale/s32g3.dtsi           | 26 ++++++++--
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c    | 36 +++++++++++++-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  3 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 16 +++---
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 57 +++++++++++++++++++++-
 8 files changed, 191 insertions(+), 22 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20251209-dwmac_multi_irq-9d8f60462cc1

Best regards,
-- 
Jan Petrous (OSS) <jan.petrous@oss.nxp.com>



