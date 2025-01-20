Return-Path: <netdev+bounces-159680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DADA165FA
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 05:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3663A828B
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 04:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4C616A395;
	Mon, 20 Jan 2025 04:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Wx2zn+bp"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8598A14E2E6
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 04:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737345751; cv=none; b=pSGzbi4VhU6w/oHmoQ0fnWJirlsnMy4hj87vCL9t3vDHll5tnRTt+RE9j+H+HHKLkdT+VgTdhvFO+FQLzpG5iL5LvEfR0q/gKZthRjLX3e3Ssu80xFwEnwkdWOMVIvvep7KFQwiSMZsBMl+TY1uqU7IZJcUTt+Q7vQQMfM8Bq+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737345751; c=relaxed/simple;
	bh=p30xOcwbUqTNEpk/GcEcICQIbqxPdZ9uChSunNiYWyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sWjfeSuJlcMFOl+kZq01Yk2uOQCr7bmWqAEfR0Qy/N13DDHlCJvF+fhD6OjopoIiGM/+3zgFlK2iDIK9bqjlovyhCMSO4ZDYfiPMFjJX0O3/TAqVhPIhNLxBqMGhLkr3bD9s9qfvIteLFRt0nhFhPd+LY3ne9rl6WsWmrDG+lS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=Wx2zn+bp; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D3D7B2C0A6D;
	Mon, 20 Jan 2025 17:02:27 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1737345747;
	bh=xkBe5AqvbWT6u6iZBh4mVX7gBu9uKHTpwHDeYPmXMtA=;
	h=From:To:Cc:Subject:Date:From;
	b=Wx2zn+bpn6B6Vxj/wz7GfV6YjnbEUoYblWf8jBLdCa9RfNliZJvsRVbOaXj1WRtRq
	 ZLuCjTiwnGSwp94W0YEUpVQ1D3bV6mKPWFEXOd75RTffGxQ5t6Y2Wwcp5N6ya6ptVX
	 PVOTC0A8Jysr6xqTxZReAoyBvs5aMn0SM+JKtyf+I2KV/7kkmwqe666vcDC9+n7ep5
	 dBt7WDG6gqZeiGMV6CJ6cCVTcgPKxiT6j9UXRmmwdHGts8hg3pVZ5Z+g9aZRht8GAV
	 LC6ySkgPeAr+iq7RMa60gS5CTyMfBGZCxmbztCVDBzxPF/N6ONMd0rSRkPerQMt7hX
	 IOgdw/W88CSyA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B678dcac80004>; Mon, 20 Jan 2025 17:02:16 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 8302313EE2B;
	Mon, 20 Jan 2025 17:02:16 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 7F3632801C2; Mon, 20 Jan 2025 17:02:16 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tsbogend@alpha.franken.de,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	sander@svanheule.net,
	markus.stockhausen@gmx.de
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v4 0/4] RTL9300 MDIO driver
Date: Mon, 20 Jan 2025 17:02:10 +1300
Message-ID: <20250120040214.2538839-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BNQQr0QG c=1 sm=1 tr=0 ts=678dcac8 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=VdSt8ZQiCzkA:10 a=1Opl5N7dmqp52ZJA_ycA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

This series adds a driver for the MDIO controller on the RTL9300 family
of devices. The controller is a little unique in that we can't access the=
 SMI
interfaces directly. This means we need to use the hardware description f=
rom
the DTS to compute a mapping of switch port to mdio bus/address.

Chris Packham (4):
  dt-bindings: net: Add Realtek MDIO controller
  dt-bindings: mfd: Add MDIO interface to rtl9301-switch
  mips: dts: realtek: Add MDIO controller
  net: mdio: Add RTL9300 MDIO driver

 .../bindings/mfd/realtek,rtl9301-switch.yaml  |  24 +
 .../bindings/net/realtek,rtl9301-mdio.yaml    |  93 ++++
 arch/mips/boot/dts/realtek/rtl930x.dtsi       |  32 ++
 drivers/net/mdio/Kconfig                      |   7 +
 drivers/net/mdio/Makefile                     |   1 +
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 417 ++++++++++++++++++
 6 files changed, 574 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/realtek,rtl9301=
-mdio.yaml
 create mode 100644 drivers/net/mdio/mdio-realtek-rtl9300.c

--=20
2.47.1


