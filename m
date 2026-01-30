Return-Path: <netdev+bounces-255142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPzVCvavfGmbOQIAu9opvQ
	(envelope-from <netdev+bounces-255142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:19:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8013FBAEBD
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 772473007F7A
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AA329346F;
	Fri, 30 Jan 2026 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DOMD7Bez"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D94F28466F
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779183; cv=none; b=DxmFCdDYQOm99dtAW9WFMXDvyOZ8F4BMdruwngvnBvHpYioBw7COAnHClfAZjpjVPXWYF1QdFW9plR5a1i7ojfoFcE4QNa1xa62AuXSMl5cCuxoG6rsxpcJCGYTGhvbAMV4guOdp6HpfXwtqfGQ5Gk4yUwlLxyT9/KThjyh44Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779183; c=relaxed/simple;
	bh=GPGinCQroahYT06bixhJuzGEVunNCmKgVO1Cw29JfFg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QEYSuR32NIt0YnMb1sjuEOp7DX5YA6JtqN0c9tnrPoVf2c7FfpJ96Q7EfrQQxY56FK9QiUYfDky0dy/Er6PH2X8xcKIxPWi94tzcsysS1j7l1aViRPyCnFTPT8y9stSjU6siVc44r+2nXDqSj2KWEsiMUT4c5n/wpjpVnaPCLyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DOMD7Bez; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806f80cac9so12936925e9.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 05:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769779180; x=1770383980; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HM7frh05im77oZIDqVclBmpgKOAVmImS7J83MO9Bgs0=;
        b=DOMD7Bezm1Yx12C1v1027Xnka18s17PZLutCmpjxvcc5dmUjvxHnqbV5dLitv86K3c
         uux+5crblve8u8S5RvuG/a+chifI4TpeVPtTyAJ90MdeG2Drci+D+AGLfusgL1LiRpv1
         IxlilPsoDFhL4x3xFu0QSukQUqvnNsQMQoQwx3rySJcu9Wllp7uqPud1JKaiCnNhAG4c
         dCRLuLxGz/75XavNh5v4G/NahLHlGQvo3q0YQ07mTfcnTtyXo323bq8Ukm6I5Z3LpfkB
         LGnhlA8p0+rauanayRuWp/Is6KZ6gJMR670AWZ5lAjQbZE5uNQs3N7C5tvlaa7Lpm5kt
         t5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769779180; x=1770383980;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HM7frh05im77oZIDqVclBmpgKOAVmImS7J83MO9Bgs0=;
        b=fPTZ0WY819UmtmqFR86+11HzqR73DGI4EK+fdm/iXld29Rtd+JkeP8BufhBNsua6vW
         Wc2LWvY1e1WiKfSSO4pbWnxuNG4QP9aj7jYBmekd+NYS2Vm5hdKA3CjyXZJR8q6ubzXd
         VgC3Z9xlOp6yp9QMhV2uYPxm73yRiEKPKlRy5xeYC+YN4vCI87BDgymqIk+sElgrUHjq
         ludpWBa11MFkDDofV0ypGezlY1SirslJq2/wl6MOY8kkqHkqMbsguTy8IPeeU+BGKVwR
         oGD4leArQnT5NQMnTKPCUbjAD5CU+Vn9KzXneT3Xn4MAeXx8j7OwvKeeVN0c3aAqZ+hF
         zWRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Z7B5JoORum5uCU/2O0xOrdVbbV/aLpFbvF3usW92RHmfHwbFnoTBi2Mdsh30dWxVqFbob1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu4Cc6ugnrFFuVyNpDJ8J0ZhhoXKGvNc1AQC7Ul+EFBSTMJYTM
	eassuOyXZ+4vbtP9bvwtlQ3xehF3CwHy0l/D8eDwxUmeIJk6YipAqE7blwmYPOzuwDc=
X-Gm-Gg: AZuq6aKuKdpkZCE3znGBtHjyuQVoyou8ULS6BDmrFhcFzx8EXBSJgsoP583I1uKvnE/
	Po1VMfm7jTLI4MT97VvENRjVmMs2jWT/DyswhepjYyGkis/8H+z3eDXAPtkN+0xKEE+Vegl2/T2
	hBPKENPnS50DseXZKEYP7GENJkVzfsQMVglKZ9rOhLdQDZyXaU/I3E4Va92cogEH0yJtnFC+2zq
	ii6fdZ+V5DZCY0xqLl8nz8NythEmmj3vjFUa91U9F43x4O+GGK3vgNubEJZJWUpK4rRbHm9EqT7
	RCbY0Xm/zYKc1GKAZfPC7Jjqgklgn2T+BQQVpPFzQ6ArzMzdKMNOTkgGlKZtS5ulmSeyl/t+mb5
	E1zb1NE2qAtogK9sadiuutglYYlVFXiWBRNTO85hlcxJ93T0KcDyv5C0q6cfprYGnXqhUO7tVZk
	KWD8lpsr17tKQ/y3RK
X-Received: by 2002:a05:600c:870c:b0:47f:1a8d:4f30 with SMTP id 5b1f17b1804b1-482db4e2501mr31706135e9.26.1769779179560;
        Fri, 30 Jan 2026 05:19:39 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd78d3sm203603435e9.1.2026.01.30.05.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 05:19:39 -0800 (PST)
Date: Fri, 30 Jan 2026 16:19:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chester Lin <chester62515@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <mbrugger@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linaro-s32@linaro.org
Subject: [PATCH v6 0/3] s32g: Use a syscon for GPR
Message-ID: <cover.1769764941.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,kernel.org,davemloft.net,vger.kernel.org,google.com,gmail.com,nxp.com,oss.nxp.com,lists.linux.dev,lists.infradead.org,st-md-mailman.stormreply.com,suse.com,redhat.com,pengutronix.de,linaro.org];
	TAGGED_FROM(0.00)[bounces-255142-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:mid,linaro.org:dkim]
X-Rspamd-Queue-Id: 8013FBAEBD
X-Rspamd-Action: no action

The s32g devices have a GPR register region which holds a number of
miscellaneous registers.  Currently only the stmmac/dwmac-s32.c uses
anything from there and we just add a line to the device tree to
access that GMAC_0_CTRL_STS register:

                        reg = <0x4033c000 0x2000>, /* gmac IP */
                              <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */

I have included the whole list of registers below.

We still have to maintain backwards compatibility to this format,
of course, but it would be better to access these registers through a
syscon.  Putting all the registers together is more organized and shows
how the hardware actually is implemented.

Secondly, in some versions of this chipset those registers can only be
accessed via SCMI.  It's relatively straight forward to handle this
by writing a syscon driver and registering it with of_syscon_register_regmap()
but it's complicated to deal with if the registers aren't grouped
together.

Changes since v5:
* Fix O vs 0 typo in yaml file
* Add Jan Petrous's Reviewed-by tag

Changes since v4:
* Return an error if regmap_write() fails
* Add Rob's Reviewed-by tag to the yaml patch

Changes since v3:
* Fix the yaml file format
* Add netdev to the CC list on all emails so the CI triggers

Changes since v2:
* Improve the documentation in .../bindings/net/nxp,s32-dwmac.yaml
* "[PATCH v2 2/4] dt-bindings: mfd: syscon: Document the GPR syscon
  for the NXP S32 SoCs" was applied so drop it.

Changes since v1:
* Add imx@lists.linux.dev to the CC list.
* Fix forward porting bug.  s/PHY_INTF_SEL_RGMII/S32_PHY_INTF_SEL_RGMII/
* Use the correct SoC names nxp,s32g2-gpr and nxp,s32g3-gpr instead of
  nxp,s32g-gpr which is the SoC family.
* Fix the phandle name by adding the vendor prefix
* Fix the documentation for the phandle
* Remove #address-cells and #size-cells from the syscon block

Here is the whole list of registers in the GPR region

Starting from 0x4007C000

0  Software-Triggered Faults (SW_NCF)
4  GMAC Control (GMAC_0_CTRL_STS)
28 CMU Status 1 (CMU_STATUS_REG1)
2C CMUs Status 2 (CMU_STATUS_REG2)
30 FCCU EOUT Override Clear (FCCU_EOUT_OVERRIDE_CLEAR_REG)
38 SRC POR Control (SRC_POR_CTRL_REG)
54 GPR21 (GPR21)
5C GPR23 (GPR23)
60 GPR24 Register (GPR24)
CC Debug Control (DEBUG_CONTROL)
F0 Timestamp Control (TIMESTAMP_CONTROL_REGISTER)
F4 FlexRay OS Tick Input Select (FLEXRAY_OS_TICK_INPUT_SELECT_REG)
FC GPR63 Register (GPR63)

Starting from 0x4007CA00

0  Coherency Enable for PFE Ports (PFE_COH_EN)
4  PFE EMAC Interface Mode (PFE_EMACX_INTF_SEL)
20 PFE EMACX Power Control (PFE_PWR_CTRL)
28 Error Injection on Cortex-M7 AHB and AXI Pipe (CM7_TCM_AHB_SLICE)
2C Error Injection AHBP Gasket Cortex-M7 (ERROR_INJECTION_AHBP_GASKET_CM7)
40 LLCE Subsystem Status (LLCE_STAT)
44 LLCE Power Control (LLCE_CTRL)
48 DDR Urgent Control (DDR_URGENT_CTRL)
4C FTM Global Load Control (FLXTIM_CTRL)
50 FTM LDOK Status (FLXTIM_STAT)
54 Top CMU Status (CMU_STAT)
58 Accelerator NoC No Pending Trans Status (NOC_NOPEND_TRANS)
90 SerDes RD/WD Toggle Control (PCIE_TOGGLE)
94 SerDes Toggle Done Status (PCIE_TOGGLEDONE_STAT)
E0 Generic Control 0 (GENCTRL0)
E4 Generic Control 1 (GENCTRL1)
F0 Generic Status 0 (GENSTAT0)
FC Cortex-M7 AXI Parity Error and AHBP Gasket Error Alarm (CM7_AXI_AHBP_GASKET_ERROR_ALARM)

Starting from 4007C800

4  GPR01 Register (GPR01)
30 GPR12 Register (GPR12)
58 GPR22 Register (GPR22)
70 GPR28 Register (GPR28)
74 GPR29 Register (GPR29)

Starting from 4007CB00

4 WKUP Pad Pullup/Pulldown Select (WKUP_PUS)

Dan Carpenter (3):
  net: stmmac: s32: use a syscon for S32_PHY_INTF_SEL_RGMII
  dt-bindings: net: nxp,s32-dwmac: Use the GPR syscon
  dts: s32g: Add GPR syscon region

 .../bindings/net/nxp,s32-dwmac.yaml           | 13 +++++++++
 arch/arm64/boot/dts/freescale/s32g2.dtsi      |  6 ++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi      |  6 ++++
 .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 28 +++++++++++++++----
 4 files changed, 47 insertions(+), 6 deletions(-)

-- 
2.51.0


