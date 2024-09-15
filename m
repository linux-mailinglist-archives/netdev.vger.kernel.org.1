Return-Path: <netdev+bounces-128437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3C5979892
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 21:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A021F223E1
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 19:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D041CB500;
	Sun, 15 Sep 2024 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="SVaNL6+/"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25B61C9ED4
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726429722; cv=none; b=i5YBKo61zRErrujS4s1kEm01XkFl54DT+frd9wZSL3BjqLDSLrIcy60IqfRbxuaI3+Lv+cT6GcvhczadTIUMmG5TkBpZUIwZ12nfIwV9OHqNY4hRUm6MDAWcOzTULtswBWlmXFWRtsYUPcoie8FtpFfnyG2p+MWeuHnmKMzdQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726429722; c=relaxed/simple;
	bh=OWOVlbCaDRJk8g2+9EKHF+brpTDaEMqM2pX6WStokk0=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date; b=Kr06Fu2MUVEcDluELkRpRmJ42STN1TLI6NQKL0IRtNko1zQHxeK4Tv43IWvWnIAs0mDc4pzj44JfHpwebIxLayi2MCItczQs4ZhMQixwaAtpD7MwpkMiUY9lI4gVaAy8Ly1NUphg8Yimm5BiCZGnHGpp13cAhQoMaA/wKbxVq/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=SVaNL6+/; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726429697; x=1727034497; i=hfdevel@gmx.net;
	bh=zSVP99HbjuXunvhx/t7Z/55utGJVyMpftUHnpSDEtCQ=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SVaNL6+/GAtMBbetRjDaKWci9C94Jb3sropiwDcQj4UAuAfJJB5gHyk3n6ayASJM
	 4FQVf/NMgvz1kFx/fUhnV05T2hBOPDSeyu/TAkgTQmd1ODglzZhdOa2EhYzfSyYBm
	 7bL7IXfyf5o3ofoCFZdqXG8zwUou0gfthl2dMUkaooQBCyYJFZdG1OsGMgk/2h1ya
	 XtIQ1qteZrR+qyvsFPV3vvKqGeU7xvQu6Jbzzuo6GDtkFHnwseZDmRU6Qtxx4fLJG
	 vsGwSpelzlxjuLniNMSGzRoqFwmu8UqJX854D+7KylLPUpo5TSo0/LJTcQYgoE12U
	 gnmQG7SvWU6AxinNqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [77.33.175.99] ([77.33.175.99]) by web-mail.gmx.net
 (3c-app-gmx-bap07.server.lan [172.19.172.77]) (via HTTP); Sun, 15 Sep 2024
 21:48:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-602c050f-bc76-4557-9824-252b0de48659-1726429697171@3c-app-gmx-bap07>
From: Hans-Frieder Vogt <hfdevel@gmx.net>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH net-next v2 0/7] net: tn40xx: add support for AQR105 based
 cards
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Sep 2024 21:48:17 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:tP3I1jB2ep/H/9Q5825p6UzCM/4pf2F0g6H6+q9akmCPdfH3glVzCB36DwDgpnbLdk++5
 em1yFlWrexMceu1mBYpeJo4susG3fIZhWDcEJWRRXBam/HSNBXhqSfaRrgoBPAdxLtV5LmPw/Kfp
 pjCyDgbefCvg+BPQZhs0ytPrvfY8o8y2b+v/Dhl7oBEkahvZ1ar2wCoFDUDaEXLkhUc8eMgyxdof
 kL/rQ1BqYIVlw/oyHClsSqUWurAj1/kPniBcWADOM4BtbjJpptXhlN8cT0ASKD4Bt6ojafM1LmVi
 P0=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iDpKg7ffR6E=;nyc0X6bsPtcXdhIa+aXxGSeukaZ
 XCCxzJpj9IfPzmNPd8xXTX8YmLpXOrsaEeVEucvHJJO3jDEFOscnJnEey0xXhbwtEaLxjsYCU
 44JZXBvcn4EshZN9EZ0FEYyepdaZE7Jx0ODb0ZmfjuwU+cdflmwsMJrVNpaQJ8tt8p4WneTlY
 QHifcwB6ZFL9Kz8hLRH0n12sQ9ibnNdAo0gMc2c/dCAIsnTzROjnXH2x5HCZXfgoo6jwHYCKq
 eT8XPOq3ewMY7b55ygm2DjnB2ZcXKixvq1Id97lYlxIRzeZawDUGd/ipxxqqWELVjNB1OCS8T
 fXZD6MPx1gOD93cZ9owK0sumtxy0wBY6G3lVJn+umi/lVkaGc+qhiQgPa5T2bt5cMJN5RcvYH
 5TXcIMsLMIUnpMKBascyJUtIDR1dUBQkDqe4P0+06+PbyjsBrqYNDFG4IvEQ9e+cqNnT+71Mo
 VpYD1Y7JmMfGsLBR9P0O++WtclZ6nCIkB9rdgWz95UM3DJ4MT0Sv3XOpu+tAiMYyGFoSxHnOx
 ja6cE5MzD9wrATDJVSgFfG4YAISZODXBQLfft1+zvWIb7YA0goYznqPLjp9cIOrtUl+9Ngs50
 86sN3PHTnI1/S7jem01s40CvjqVWhK1ZQDttWe3e1wqD4FpiBuovihiUr4mtsn9gfRXm16Znh
 FMNbF503gFui3XSNjwyyZkEHktn4cQab+QMwzZ5kYQ==
Content-Transfer-Encoding: quoted-printable

This patch series adds support to the Tehuti tn40xx driver for TN9510 card=
s
which combine a TN4010 MAC with an Aquantia AQR105.
It is an update of the patch series "net: tn40xx: add support for AQR105 b=
ased cards",
https://lore.kernel.org/netdev/trinity-33332a4a-1c44-46b7-8526-b53b1a94ffc=
2-1726082106356@3c-app-gmx-bs04/
addressing review comments and generally cleaning up the series.

With Vladimir Oltean having provided a patch to repair the logic of the wa=
iting
time for firmware loading of the Aquantia PHYs and to avoid an error messa=
ge
for an expected behavior
 (https://lore.kernel.org/netdev/20240913121230.2620122-1-vladimir.oltean@=
nxp.com/),
my little work around of the first patch series has been removed.
However, Vladimir's patch is a requirement for the loading of firmware fro=
m the
filesystem for Aquantia PHYs to work.

The patch was tested on a Tehuti TN9510 card (1fc9:4025:1fc9:3015).

Changes v1 -> v2:
- simplify the check for a firmware-name in a swnode in the aquantia PHY d=
river
  (comment from Andrew Lunn)
- changed the software node definition to an mdio node with phy child node=
s, to
  be more in line with a typical device tree definition (also comment from
  Andrew Lunn)
  This also solves the problem with several TN4010-based cards that FUJITA
  Tomonori reported
- clarified the cleanup calls, now calling fwnode_handle_put instead of
  software_node_unregister (comment by FUJITA Tomonori)
- updated the function mdiobus_scan to support swnodes (following hint of
  Andrew Lunn)
- remove the small patch to avoid failing after aqr_wait_reset_complete, n=
ow
  that a proper patch by Vladimir Oltean is available
- replace setting of bit 3 in TN40_REG_MDIO_CMD_STAT by calling of
  tn40_mdio_set_speed (suggestion by FUJITA Tomonori)
- cleaning up the distributed calls to set the MDIO speed in the tn40xx dr=
iver
- define supported PCI-IDs including subvendor IDs to prevent loading on
  unsupported card

Hans-Frieder Vogt (7):
   net: phy: aquantia: add probe function to aqr105 for firmware loading
   net: phy: aquantia: search for firmware-name in fwnode
   net: phy: add swnode support to mdiobus_scan
   net: tn40xx: create a software node for mdio and phy and add to mdiobus
   net: tn40xx: prepare tn40xx driver to find phy of the TN9510 card
   net: tn40xx: optimize mdio speed settings
   net: tn40xx: add pci-id of the aqr105-based tehuti tn4010 cards

 drivers/net/ethernet/tehuti/tn40.c           |   15 ++++++
 drivers/net/ethernet/tehuti/tn40.h           |   30 +++++++++++
 drivers/net/ethernet/tehuti/tn40_mdio.c      |   69 +++++++++++++++++++++=
+++--
 drivers/net/phy/aquantia/aquantia_firmware.c |    6 ++
 drivers/net/phy/aquantia/aquantia_main.c     |    1
 drivers/net/phy/mdio_bus.c                   |   14 +++++
 6 files changed, 130 insertions(+), 5 deletions(-)


