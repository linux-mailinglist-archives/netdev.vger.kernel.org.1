Return-Path: <netdev+bounces-296042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JSl4B22zI2r7xAEAu9opvQ
	(envelope-from <netdev+bounces-296042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 07:43:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B1B64C98B
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 07:43:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Jh1Eu6S5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296042-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296042-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53959302BDE6
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 05:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC43308F3B;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE1B284B3B;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780724569; cv=none; b=QogECi80gwhInHyC60kf1/0sktOtl0my2/LyI/oLbWXd7AFjCyAcwCIfjMsz1gkz2Ua3xuXXyHRdv5FyCXr2GM3on3Tg2Wq2ZvmGzvwvD/FTam8ef2uTYursDqugfclUwhs1HkCasaGlUxmg2uYWZacQApbDVMhVDcPuqgKJJeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780724569; c=relaxed/simple;
	bh=dAOA6SjpWMVvSYsnDvoLrQBjwg5fA4k8JH4p1r9yoy4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h8aw8WRrPpU3CUV0N+objTuyw6LQ/GYMBwk/0yzVjaER2iaOXA4Bl3s+LhwBm0MxPyXIBAh4r/UT9OwyPf6vBotMafaRmgZZwblUFCT+Uf34i+1DefxIONSw0teBhthucA+Jrg69MmY74cqjiyPFJoUlLVxihsEigmI0aL4R2Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jh1Eu6S5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CF19C2BCB0;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780724569;
	bh=dAOA6SjpWMVvSYsnDvoLrQBjwg5fA4k8JH4p1r9yoy4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Jh1Eu6S5d0SZlSh+Q4zYhH4/gU3VPe+2CvEmGCg+qM50WU8jfNQZQyGYjkMgoYo/N
	 1kMq5AYD3KdDbHMpkXFNPrGWJxPBIDIjkq+l9eiL+5BKdqtoTwJpczbBCMtSY2xlMr
	 0KOoXQS7yo2LCSCrLIygHJMvkLx6qNLAMXIXGIGJV8iKOFFkWPJSf8WQ6PSX0c4duY
	 tBLU+AaEDf74N9Zr0XDCbgaFG8JTI5uwJzo70e1cYWMn0pqfWwNbTN4gweVZ4C9F3Q
	 SYabbP4rYKKL+nFncbobBIyqE3mvEzBWfNapKoHELSURqWAWf3Ujsv2BSro9lCmO+D
	 bmSNOXfuplmfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F179CCD8C8D;
	Sat,  6 Jun 2026 05:42:48 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Subject: [PATCH net-next v4 00/16] Support for onsemi's S2500 10Base-T1S
 MAC-PHY
Date: Fri, 05 Jun 2026 22:42:31 -0700
Message-Id: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEizI2oC/yWMQQrCMBAAv1L27MKa1Ip+RXpI48auYBqyaamU/
 t2ox2GY2UA5Cytcmw0yL6IyxQrtoQE/uvhglHtlMGQ66uiIak5E+HIe0/hGnVOacsE2WMcXQ2E
 4W6htyhxk/X1vELlg5LVA/zc6D0/25buFff8AyBajKoMAAAA=
To: Andrew Lunn <andrew@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780724562; l=4265;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=dAOA6SjpWMVvSYsnDvoLrQBjwg5fA4k8JH4p1r9yoy4=;
 b=qx2oYI5fXg+6Xkpr6RmdC6IHzvzkJPrcyap4R79wuSo6V2yTXvPJ7/Ft/+2ho1SzwEcSVoylQ
 4NggIhtkOj1AxKzm+y5nlfHKs3s3PmqGrYVbuJoEKBzhZ4U/B0IcuO4
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296042-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:pier.beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:selvamani.rajagopal@onsemi.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:Selvamani.Rajagopal@onsemi.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[Selvamani.Rajagopal@onsemi.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0B1B64C98B

This patch series brings support for onsemi's S2500 that is IEEE 802.3cg
compliant Ethernet transceiver with an integrated Media Access
Controller (MAC-PHY)

Previous versions were submitted unthreaded, without coverletter
and changelog.

Changes in v4:
 - Added return value comment for genphy_read/write_phy_mmd functions
 - Added genphy_loopback_fixed_speed helper function to be used in
   set_loopback callbacks
 - Updated networking documentation for OA TC6 framework to elaborate
   on what is expected in the ptp_clock_info structure for registration.
 - added spi-max-frequency in YAML file based on alert from sashiko-bot
 - Removed model/version from the onsemi driver's private structure as
   they were useful as "information-only" data.
 - Replaced the non-standard selftest with Linux's standard selftest
   and made it as a separate patch
 - Changed bit manipulation, shift operations to use macros so that
   it is clean and readable.
 - added new read_register and write_register apis with _mms postfix
   so that MMS (memory map selector) can be given as a parameter.
 - Fixed the wrong condition check with NETIF_F_RXFCS to subtract
   FCS size from the length of the frame.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
Selvamani Rajagopal (16):
      net: phy: Helper to read and write through C45 without lock
      net: phy: Helper to modify PHY loopback mode only.
      net: ethernet: oa_tc6: Move oa_tc6.c to its own directory
      net: phy: microchip_t1s: Use generic APIs for C45 read and write
      net: ethernet: oa_tc6: Move constant definitions to header file
      net: ethernet: oa_tc6: Support for hardware timestamp
      net: ethernet: oa_tc6: Support for vendor specific MMS
      net: ethernet: oa_tc6: Remove FCS size in RX frame
      net: ethernet: oa_tc6: read, write interface with MMS option
      net: phy: ncn26000: Support for onsemi's S2500 internal phy
      net: phy: ncn26000: Enable enhanced noise immunity
      net: phy: ncn26000: Support for loopback support
      onsemi: s2500: Add driver support for TS2500 MAC-PHY
      onsemi: s2500: Added selftest support to onsemi's S2500 driver
      dt-bindings: net: add onsemi's S2500
      Documentation: networking: Add timestamp related APIs to OA TC6 framework

 .../devicetree/bindings/net/onnn,s2500.yaml        |  67 +++
 Documentation/networking/oa-tc6-framework.rst      |  76 +++
 MAINTAINERS                                        |  13 +-
 drivers/net/ethernet/Kconfig                       |  12 +-
 drivers/net/ethernet/Makefile                      |   2 +-
 drivers/net/ethernet/microchip/lan865x/lan865x.c   |  61 +-
 drivers/net/ethernet/oa_tc6/Kconfig                |  16 +
 drivers/net/ethernet/oa_tc6/Makefile               |   7 +
 drivers/net/ethernet/{ => oa_tc6}/oa_tc6.c         | 476 ++++++++++------
 drivers/net/ethernet/oa_tc6/oa_tc6_ptp.c           |  67 +++
 drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h       | 190 +++++++
 drivers/net/ethernet/oa_tc6/oa_tc6_tstamp.c        | 202 +++++++
 drivers/net/ethernet/onsemi/Kconfig                |  21 +
 drivers/net/ethernet/onsemi/Makefile               |   7 +
 drivers/net/ethernet/onsemi/s2500/Kconfig          |  22 +
 drivers/net/ethernet/onsemi/s2500/Makefile         |   7 +
 drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c  | 354 ++++++++++++
 drivers/net/ethernet/onsemi/s2500/s2500_hw_def.h   | 225 ++++++++
 drivers/net/ethernet/onsemi/s2500/s2500_main.c     | 632 +++++++++++++++++++++
 drivers/net/ethernet/onsemi/s2500/s2500_ptp.c      | 233 ++++++++
 drivers/net/phy/dp83867.c                          |  11 +-
 drivers/net/phy/microchip_t1s.c                    |  32 +-
 drivers/net/phy/ncn26000.c                         |  63 +-
 drivers/net/phy/phy_device.c                       |  75 +++
 include/linux/oa_tc6.h                             |  36 ++
 include/linux/phy.h                                |   6 +
 26 files changed, 2662 insertions(+), 251 deletions(-)
---
base-commit: 903db046d5579bef0ea699eae4b279dd6455fc9f
change-id: 20260601-s2500-mac-phy-support-4f3ae920fb73

Best regards,
-- 
Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>



