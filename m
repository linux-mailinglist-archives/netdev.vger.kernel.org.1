Return-Path: <netdev+bounces-274543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAF7JP9uzmnxngYAu9opvQ
	(envelope-from <netdev+bounces-274543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:28:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4639389BBA
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F148E3146F62
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 13:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A39334BA49;
	Thu,  2 Apr 2026 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="T//vQhcj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD131690A;
	Thu,  2 Apr 2026 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135622; cv=none; b=itEM9HX0K9jl/tkS2aJ3+aj5ogp7cG+MYtCrwE4L1t9ARpf2fE7+6ON7njn6dCgMQCOytm6RGObFH/qRqjsPkrStVbgpwtNAMMv6aAxALSrPKQ7oCvhpj7AelhYkARj5hBzHvkOl0SHiquL8w2DxDm4tCdAWh8nsdt3L7pY7BFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135622; c=relaxed/simple;
	bh=C2KY7sy/BojAlYbuWIeT4FOySSmwKdjjEEo4+Jx0PSQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OFEx6hiYeRzHtIyT+ZEd59nXe09bfIy+SbqOz0JpwMhci+pGQ+wPwzc9cz0pUXkxcXiRYE6hvuIUTjn4c3GQFQfKu3KGM8dH0LM6bMrr6Ana7yHVTzkdJ19t2PYThYB+boaI8JhRsBIQWxpHh8Y0kM06dQKSjcxbaQAFyopysS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=T//vQhcj; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775135621; x=1806671621;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C2KY7sy/BojAlYbuWIeT4FOySSmwKdjjEEo4+Jx0PSQ=;
  b=T//vQhcjM13s7ybSevf+Rhvc3YNHwVU2+gkW1DlWpgTRDPd8CZqa99G3
   MStvLTZhlqNBDFVCTUXSsIJY0LsV38swUuqbeVRu/QdAOGjqNO5VeOL3s
   QgKPjKespfi7IWRpfDJL/qIuXKOqsygNGOoMtSgVHkj5rBkMHWBloLPvQ
   qIy7r85FOzaLo3dRxiZIiQIYuoAEieQLtvIKwrSmvOvSM0Vs/hbX0jUqp
   KTAGt4F2IBBZx/Bs3XRjv3wlvSIochlBz5yI4/ydcav5/XuuvY8sjAsfE
   iyR2tOlfP4vwGrqkVDRw9cA+fdJINyD5/1ZNBJSWDKfye1dJWXUCq6+Ii
   Q==;
X-CSE-ConnectionGUID: DSzgFxBLReScRspQAdm+CQ==
X-CSE-MsgGUID: qccmT4tXQ0WnJLRmxcHZIw==
X-IronPort-AV: E=Sophos;i="6.23,155,1770620400"; 
   d="scan'208";a="55583661"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Apr 2026 06:13:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 2 Apr 2026 06:13:02 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 2 Apr 2026 06:13:01 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>
Subject: [PATCH net-next v4 0/3] Add support for PIC64-HPSC/HX MDIO controller
Date: Thu, 2 Apr 2026 06:12:21 -0700
Message-ID: <20260402131229.319599-1-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274543-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,microchip.com:dkim,microchip.com:mid,lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email]
X-Rspamd-Queue-Id: E4639389BBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

This series adds a driver for the two MDIO controllers of PIC64-HPSC/HX.
The hardware supports C22 and C45 but only C22 is implemented for now.

This MDIO hardware is based on a Microsemi design supported in Linux by
mdio-mscc-miim.c. However, The register interface is completely different
with pic64hpsc, hence the need for a separate driver.

The documentation recommends an input clock of 156.25MHz and a prescaler of
39, which yields an MDIO clock of 1.95MHz.

This was tested on Microchip HB1301 evalkit which has a VSC8574 and a
VSC8541 with clock frequencies of 0.6, 1.95 and 2.5 MHz.

This series also adds a PHY write barrier when disabling PHY interrupts as
discussed in [1].

Thanks,
Charles

[1]: https://lore.kernel.org/all/acvUqDgepCIScs8M@shell.armlinux.org.uk/

Changes in v4:
- 3/3: Add the PHY barrier patch (Russell, Andrew)
- 2/3: return FIELD_GET() directly instead of using "ret" (Russell)

Changes in v3:
- 2/2: Add a MAINTAINERS entry (Jakub)

Changes in v2:
- 1/2: Make "clocks" and "interrupts" required (Andrew)
- 1/2: Add a default value to "clock-frequency" (Andrew)
- 2/2: Remove #define for unused registers (Maxime)
- 2/2: Add "c22" to clause 22 read/write ops (Maxime)
- 2/2: Remove the call to platform_set_drvdata() (Andrew)
- 2/2: Make the clock mandatory (Andrew)
- 2/2: Use 2.5MHz if no clock-frequency was specified (Andrew)
- 2/2: Change the error message for bad clock-frequency (Andrew)
- 2/2: Fix a use without initialization on bus_freq (Andrew)

CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: Heiner Kallweit <hkallweit1@gmail.com>
CC: Russell King <linux@armlinux.org.uk>
CC: netdev@vger.kernel.org
CC: devicetree@vger.kernel.org

Charles Perry (3):
  dt-bindings: net: document Microchip PIC64-HPSC/HX MDIO controller
  net: mdio: add a driver for PIC64-HPSC/HX MDIO controller
  net: phy: add a PHY write barrier when disabling interrupts

 .../net/microchip,pic64hpsc-mdio.yaml         |  68 +++++++
 MAINTAINERS                                   |   6 +
 drivers/net/mdio/Kconfig                      |   7 +
 drivers/net/mdio/Makefile                     |   1 +
 drivers/net/mdio/mdio-pic64hpsc.c             | 190 ++++++++++++++++++
 drivers/net/phy/phy.c                         |  27 ++-
 6 files changed, 298 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
 create mode 100644 drivers/net/mdio/mdio-pic64hpsc.c

-- 
2.47.3


