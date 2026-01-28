Return-Path: <netdev+bounces-254273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJZkLs4XemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:06:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D634A2794
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AE3E300D9ED
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108B523C4FD;
	Wed, 28 Jan 2026 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q08SQs3X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA95234964;
	Wed, 28 Jan 2026 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608960; cv=none; b=GxSoiwYfBN7yp70/A5dpj47LeWgboaHJxcqJPiJb/+1l0ol0kRWm4iX1c+kAlty1x2Fk9n7jKb5YOY0YroE2W0d1TuunX/eEoEXJd0LjPqSys/c3bAGRiFJCoPPuLPdAOgljCkir3+/qaVy5RlnBidllJS3ghPdeksBF3bzxmjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608960; c=relaxed/simple;
	bh=DJYJy6rAk8mT7ZaSQdUIpTiwpwqy148hC1cHlbsyWMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uUwnSbFEY2pqB2It88xzlITal83M/NBj/Jtz1Y20WaQ8Ki7d3Q8sADCR5IvshXCEGWbBybBHJptmivcIr2a4M2puBuAFdh/US7qGSXj7gEtr4VgY1jt2kPzlXedJIj4+shOcDp+4zdHaDMiDmya9rsofxaoN3Ekgrlou8N9WHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q08SQs3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5FCC4CEF1;
	Wed, 28 Jan 2026 14:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769608960;
	bh=DJYJy6rAk8mT7ZaSQdUIpTiwpwqy148hC1cHlbsyWMs=;
	h=From:To:Cc:Subject:Date:From;
	b=Q08SQs3Xfz4etQe09Uf2U07aKF8yM3DjGfCHspwWepYA6a4QMYujKntJdJT23t8R2
	 LjMzRMGqjS2IbK4OCx351wRmzgvot4atywiaJr/9BO8HDTuS70url9H6UJhUi9Dtxk
	 juZHnWQAq6CGv04Rx6rk1msE96O478gaC4KxoLpArKIOWsQrUEhjhwyHEFYmqdrBVG
	 CGZZ8oKf7a2zkZKmessyFz1TvrI2numIePwaxzW9SLTD+imj6e+lkZr30ktMkMzb13
	 +4te8RaxgErCavsbk3CiKQIzS/C9g+CcBi7fAwZnrjrBy6D95T2nNPwuHSQh0gqH6y
	 mPDhSsHJuNOpw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Cc: devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] powerpc: dts: fsl: Drop unused .dtsi files
Date: Wed, 28 Jan 2026 08:02:20 -0600
Message-ID: <20260128140222.1627203-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.ibm.com,ellerman.id.au,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254273-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D634A2794
X-Rspamd-Action: no action

These files are not included by anything and therefore don't get built or
tested.

There's also no upstream driver for the interlaken-lac stuff.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../boot/dts/fsl/interlaken-lac-portals.dtsi  | 156 ------------------
 arch/powerpc/boot/dts/fsl/interlaken-lac.dtsi |  45 -----
 .../boot/dts/fsl/pq3-mpic-message-B.dtsi      |  43 -----
 .../fsl/qoriq-fman3-0-10g-1-best-effort.dtsi  |  80 ---------
 4 files changed, 324 deletions(-)
 delete mode 100644 arch/powerpc/boot/dts/fsl/interlaken-lac-portals.dtsi
 delete mode 100644 arch/powerpc/boot/dts/fsl/interlaken-lac.dtsi
 delete mode 100644 arch/powerpc/boot/dts/fsl/pq3-mpic-message-B.dtsi
 delete mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/interlaken-lac-portals.dtsi b/arch/powerpc/boot/dts/fsl/interlaken-lac-portals.dtsi
deleted file mode 100644
index 9cffccf4e07e..000000000000
--- a/arch/powerpc/boot/dts/fsl/interlaken-lac-portals.dtsi
+++ /dev/null
@@ -1,156 +0,0 @@
-/* T4240 Interlaken LAC Portal device tree stub with 24 portals.
- *
- * Copyright 2012 Freescale Semiconductor Inc.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#address-cells = <0x1>;
-#size-cells = <0x1>;
-compatible = "fsl,interlaken-lac-portals";
-
-lportal0: lac-portal@0 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0x0 0x1000>;
-};
-
-lportal1: lac-portal@1000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0x1000 0x1000>;
-};
-
-lportal2: lac-portal@2000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0x2000 0x1000>;
-};
-
-lportal3: lac-portal@3000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0x3000 0x1000>;
-};
-
-lportal4: lac-portal@4000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0x4000 0x1000>;
-};
-
-lportal5: lac-portal@5000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0x5000 0x1000>;
-};
-
-lportal6: lac-portal@6000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0x6000 0x1000>;
-};
-
-lportal7: lac-portal@7000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0x7000 0x1000>;
-};
-
-lportal8: lac-portal@8000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0x8000 0x1000>;
-};
-
-lportal9: lac-portal@9000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0x9000 0x1000>;
-};
-
-lportal10: lac-portal@A000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0xA000 0x1000>;
-};
-
-lportal11: lac-portal@B000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0xB000 0x1000>;
-};
-
-lportal12: lac-portal@C000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0xC000 0x1000>;
-};
-
-lportal13: lac-portal@D000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0xD000 0x1000>;
-};
-
-lportal14: lac-portal@E000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0xE000 0x1000>;
-};
-
-lportal15: lac-portal@F000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0xF000 0x1000>;
-};
-
-lportal16: lac-portal@10000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0x10000 0x1000>;
-};
-
-lportal17: lac-portal@11000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0x11000 0x1000>;
-};
-
-lportal18: lac-portal@1200 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0x12000 0x1000>;
-};
-
-lportal19: lac-portal@13000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0x13000 0x1000>;
-};
-
-lportal20: lac-portal@14000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0x14000 0x1000>;
-};
-
-lportal21: lac-portal@15000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0x15000 0x1000>;
-};
-
-lportal22: lac-portal@16000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0x16000 0x1000>;
-};
-
-lportal23: lac-portal@17000 {
-	compatible = "fsl,interlaken-lac-portal-v1.0";
-	reg = <0x17000 0x1000>;
-};
diff --git a/arch/powerpc/boot/dts/fsl/interlaken-lac.dtsi b/arch/powerpc/boot/dts/fsl/interlaken-lac.dtsi
deleted file mode 100644
index e8208720ac0e..000000000000
--- a/arch/powerpc/boot/dts/fsl/interlaken-lac.dtsi
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * T4 Interlaken Look-aside Controller (LAC) device tree stub
- *
- * Copyright 2012 Freescale Semiconductor Inc.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-lac: lac@229000 {
-	compatible = "fsl,interlaken-lac";
-	reg = <0x229000 0x1000>;
-	interrupts = <16 2 1 18>;
-};
-
-lac-hv@228000 {
-	compatible = "fsl,interlaken-lac-hv";
-	reg = <0x228000 0x1000>;
-	fsl,non-hv-node = <&lac>;
-};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-mpic-message-B.dtsi b/arch/powerpc/boot/dts/fsl/pq3-mpic-message-B.dtsi
deleted file mode 100644
index 1cf0b77b1efe..000000000000
--- a/arch/powerpc/boot/dts/fsl/pq3-mpic-message-B.dtsi
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * PQ3 MPIC Message (Group B) device tree stub [ controller @ offset 0x42400 ]
- *
- * Copyright 2012 Freescale Semiconductor Inc.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-message@42400 {
-	compatible = "fsl,mpic-v3.1-msgr";
-	reg = <0x42400 0x200>;
-	interrupts = <
-		0xb4 2 0 0
-		0xb5 2 0 0
-		0xb6 2 0 0
-		0xb7 2 0 0>;
-};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi
deleted file mode 100644
index 71eb75e82c2e..000000000000
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi
+++ /dev/null
@@ -1,80 +0,0 @@
-/*
- * QorIQ FMan v3 1g port #1 device tree stub [ controller @ offset 0x400000 ]
- *
- * Copyright 2012 - 2015 Freescale Semiconductor Inc.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *	 notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *	 notice, this list of conditions and the following disclaimer in the
- *	 documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *	 names of its contributors may be used to endorse or promote products
- *	 derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-fman@400000 {
-	fman0_rx_0x09: port@89000 {
-		cell-index = <0x9>;
-		compatible = "fsl,fman-v3-port-rx";
-		reg = <0x89000 0x1000>;
-		fsl,fman-10g-port;
-		fsl,fman-best-effort-port;
-	};
-
-	fman0_tx_0x29: port@a9000 {
-		cell-index = <0x29>;
-		compatible = "fsl,fman-v3-port-tx";
-		reg = <0xa9000 0x1000>;
-		fsl,fman-10g-port;
-		fsl,fman-best-effort-port;
-	};
-
-	ethernet@e2000 {
-		cell-index = <1>;
-		compatible = "fsl,fman-memac";
-		reg = <0xe2000 0x1000>;
-		fsl,fman-ports = <&fman0_rx_0x09 &fman0_tx_0x29>;
-		ptp-timer = <&ptp_timer0>;
-		pcsphy-handle = <&pcsphy1>, <&qsgmiia_pcs1>;
-		pcs-handle-names = "sgmii", "qsgmii";
-	};
-
-	mdio@e1000 {
-		qsgmiia_pcs1: ethernet-pcs@1 {
-			compatible = "fsl,lynx-pcs";
-			reg = <1>;
-		};
-	};
-
-	mdio@e3000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
-		reg = <0xe3000 0x1000>;
-		fsl,erratum-a011043; /* must ignore read errors */
-
-		pcsphy1: ethernet-phy@0 {
-			reg = <0x0>;
-		};
-	};
-};
-- 
2.51.0


