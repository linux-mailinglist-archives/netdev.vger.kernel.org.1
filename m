Return-Path: <netdev+bounces-270760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOklEPe4wWm/UwQAu9opvQ
	(envelope-from <netdev+bounces-270760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:04:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9E42FE0C5
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2398A3018741
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E459A383C70;
	Mon, 23 Mar 2026 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xAwfyU6P"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934ED382382;
	Mon, 23 Mar 2026 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303421; cv=none; b=NpKGLowzpn5pqntM7yBJXTpjG/og+j8aUe2Op3twqOw5qHa9Weyylth6SyHpWLyUS3gVn2iq7bXd9UxT7Z7MlRIaMmOsJLKNhthaPQwqBiCuQBQBao3dMY41R5PTw6XT6LncB1fNPsgM+hsPcQB5P55BNhYfvmj/5YikNY2Ukzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303421; c=relaxed/simple;
	bh=W6p56WqARwafCASdRu4gJctdCbjThR7aTgZWHRuPIds=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SVqDvm8WsVOqyNHMPHH4Yvzzf6g9ur3q/iypNni16CoxgxNd6gejnEZTddD4ONr4UIqMfw2E/Ps8AK8sssuHaSwsXOvKprgFKNuwCZ7U11usf52bqHZslBLjFEtmvo0DjWmclAXyHASMlXHf8LNTSRdP6/Bcftfuocy5RdrY09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xAwfyU6P; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774303417; x=1805839417;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W6p56WqARwafCASdRu4gJctdCbjThR7aTgZWHRuPIds=;
  b=xAwfyU6PhqyPWTQT14y3qeNv9GtNKijZZiFJyiqDd7E3Ys9ln6ky4Wvv
   tA9JPKug5yP5jxR85+bsYqkSt7JNd336Kk1d/SsEv1E9elarvbmgB8g5r
   RJJeAtL32vrV84/FJob5i8RzpxCCLVH7JM9r8Uq8Ds804Q/GErjFoJ64k
   rqGmdyDFLUc8qNKqIl88IKef15EhTVA1hyT3/kezQIT3s4Gbw/C3ey5oM
   ykjWkiUzlmgbkgqdhx9xmTw9zqzImhnTq4aM5qqK3KS3lSStpIZbOIWOD
   ygkbusBKae62oadcGr/YDXQ1c+bHMYq4GNRBluw/XwoaQUBAKSHEkt0j+
   g==;
X-CSE-ConnectionGUID: be8gGiJXQxKWF7PjLJ4JSw==
X-CSE-MsgGUID: +hydt/giQYecqdoCAD2+sQ==
X-IronPort-AV: E=Sophos;i="6.23,138,1770620400"; 
   d="scan'208";a="222348055"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Mar 2026 15:03:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 23 Mar 2026 15:03:03 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 23 Mar 2026 15:03:02 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 0/2] Add support for PIC64-HPSC/HX MDIO controller
Date: Mon, 23 Mar 2026 15:02:52 -0700
Message-ID: <20260323220254.3822444-1-charles.perry@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270760-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB9E42FE0C5
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

Thanks,
Charles

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

Charles Perry (2):
  dt-bindings: net: document Microchip PIC64-HPSC/HX MDIO controller
  net: mdio: add a driver for PIC64-HPSC/HX MDIO controller

 .../net/microchip,pic64hpsc-mdio.yaml         |  68 +++++++
 drivers/net/mdio/Kconfig                      |   7 +
 drivers/net/mdio/Makefile                     |   1 +
 drivers/net/mdio/mdio-pic64hpsc.c             | 192 ++++++++++++++++++
 4 files changed, 268 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
 create mode 100644 drivers/net/mdio/mdio-pic64hpsc.c

-- 
2.47.3


