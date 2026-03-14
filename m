Return-Path: <netdev+bounces-267732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOLmJBdVtWnAzQAAu9opvQ
	(envelope-from <netdev+bounces-267732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 13:31:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FAD28D253
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 13:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98E03300D4EE
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D0A1EDA32;
	Sat, 14 Mar 2026 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZFXNB1u3"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E33F335BA;
	Sat, 14 Mar 2026 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773491472; cv=fail; b=uLJMf+1NqHOwdWVl7iK5fQTHxCGDQNx9R8/aLwuH/YP6gLTkg5E4gHnht7MG4rv5gerPRCUVsNdRY/cJYbNBPAph8d+9W9l1f3K4+J7HeeS8kA68O5GJyNnnaPX93vk6xLjVWRjC5U/OmXRk5qChGaa4CJtqjNYIT71VUndlxUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773491472; c=relaxed/simple;
	bh=Lw6Nwa3ZTPU8J6+w0A6BDw0C/CnXJ/jgNUnGt+LpTX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mw3oy7svs4b5elASiNDnXC16Tekx35n5Xj0AJyQnrI7ihh+hsbbTdVCdxEQJ6jy9IbVzUeFhcwh66Q3P8wsO3dPdaLCa+q6lccmzbjJrVSlR5G1Tubl/O4aQjylxmrDSrZl578llGM9UvLjPVCaLTJfVMtFZYz3No1xSjwKzv2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZFXNB1u3; arc=fail smtp.client-ip=40.93.195.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LV7wZz1hbixNQ76nVmkdGhGVypOIOT0UtirISGSC0l77xWQA9y7jt3+bdxhOvFOSUxAlK8J2KiMHXa0MWNMpoRUQ/+k5qDSw1J8t2cHoLVL+CT8M3Ui5qVhqQlVIXFz+wslIVXk/RI9FrEurEYhzBBvrnj6fRoQ4s6USh5odAeqnPA10gU+/uulJOT7yMsg4w34JubHdVYSyeuyoy4YfOGYhFxcc6wvNifDPMaKYHz7+Fv/gQhwa2+mOP18pGOvDMvdcB4b15sujGdOwpW+NPYaXBtowH0cCtvvNXt2syZ4IVV7+5ruTfEXu5uJ+QUIn2rqbIWfPbggd823jVlRe/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DntHmpJj+bDX0jcQ4UQcCYmUV05Ksghxyk2jWxSek1s=;
 b=NM5dJU4U4+4bC8ReIypgwSoBFiJcv7/d8UZo7/bCaETHpXcePdCDix30rHT2LlhAsv7k78iFgyZ5gcG0uthF/pFmGsfEgG8rGI/orZAFLV0UoPq02mda5BLE5UsiFXfqx8aE/9ETif6Txz3UnOY1g6Xd/kRYDSlVZVbrXH8OPBbfcvbj+3jLQ/9gbmPGs2eTvnVSWDd6RV/t2NB1/eRPcZ1uUcI0wB6hxBlPBWhqtLvfKgQ5zhkHfJ4IG20MdIpXLANu8O5E59R/Gc+9Y2tg5inMBVkziUgbCuVaLIaf9RCk1JNOZmzGanktYQqY+bJpkjVPgHX9LvSdG/YNIXCgag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DntHmpJj+bDX0jcQ4UQcCYmUV05Ksghxyk2jWxSek1s=;
 b=ZFXNB1u3f7N1bDg3OQ1XdNpZoALCmpAHdFpSsk9uMFjTYThwVpQvZX+nFrjQBmStAilBZ4WNKv/7Cui7WTcLW4Ql1lxSEd53omjztThFHu7qbQ+kcKzrz1G8Toq1y21iKqsBK3hIUVF1bw5ilFCI9CXgU8dwn5mevdMmzaK0gxs=
Received: from CH2PR07CA0057.namprd07.prod.outlook.com (2603:10b6:610:5b::31)
 by IA4PR10MB8398.namprd10.prod.outlook.com (2603:10b6:208:56d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Sat, 14 Mar
 2026 12:31:08 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::9d) by CH2PR07CA0057.outlook.office365.com
 (2603:10b6:610:5b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.21 via Frontend
 Transport; Sat, 14 Mar 2026 12:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Sat, 14 Mar 2026 12:31:07 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 14 Mar
 2026 07:31:06 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 14 Mar
 2026 07:31:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 14 Mar 2026 07:31:06 -0500
Received: from [172.24.233.103] (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62ECV2C01738719;
	Sat, 14 Mar 2026 07:31:03 -0500
Message-ID: <8598edfa-4201-47b4-8929-be80dcca4617@ti.com>
Date: Sat, 14 Mar 2026 18:01:01 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: dts: ti: k3-am642-evm: Add ICSSG0 overlay
 for dual EMAC support
To: Meghana Malladi <m-malladi@ti.com>, Nishanth Menon <nm@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
	<danishanwar@ti.com>
References: <20260311053852.1034244-1-m-malladi@ti.com>
 <20260311053852.1034244-2-m-malladi@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20260311053852.1034244-2-m-malladi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|IA4PR10MB8398:EE_
X-MS-Office365-Filtering-Correlation-Id: 58652406-3a30-4dd2-8108-08de81c59108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3h5WVmB20IsZQ7MO5JCR5zqioDmSQ4TMpOR9dXhVPaPL/G0d/lmcm9g9DQQNZGipZW/tzakPdeHpFdfdrX5/6c0wcf3UGINxdpNFJZFyoUovfcOiL25AyJmxOcV6H/1mDvvVu8TIlT1HRbF4LbPMFP3W8hO42rePwDfSGz6C0JNEFGZoawn25Me/zOZWZ7+FqYz3zhFlvBBGrtrpjsuG/t8sIYOSdZCo9M9755ms/BlTi/laCKTx5xCf63cC5bMaiASwoMFjj91YkeHn/UouEupCmGDaNTzfyrKReJ8dJJGDquESdpg27qh+aRQWM0F+n2cVazv0RS0FkuAR2vmBf4cmhlmpQ6BOj4Qf3eE4V0B6SoyzYYzlYd0n619dJWiNF6SR07oyAocYPWrKpD2cOiF0rSchze52TOfCHK+pMSrlskBrSc7w/lgYtaiU4ahp35kOnBVmr/t11GgL5f6v47H/eQE4sFYfAlbWsSwydEgD0+GBV143XShaPqnJceCBZXwgtJoKRhmhou/hO/enjxCrY1bM7dACy5VtAvswVS/0wh9NWRtY+HxJqnNTehLweFWzvaCLq2R302zeII+5+3O99JmnegVHnfZlIJdiHFsW2thfKis+OCsxZYLG6KZhJf7yOgZ8274cwhera9soNLRsGRgh9WT515EVb8Npbr7TTtp757SQkfnDMI6s/tGurrrZmlbBCXnfm4rcsmB5HVi88gtBaw+CYYNZdIDtFoY=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2+A+/27YowM7M0ThtbF2cNAy9TPTvmW++IFougVq16WViyTJqCkp1w2CFzActlMUbG4C1BkIeEhNNt1yj5ZMwyx1jrGFzfkt1b/rQBOhLqTWdB4XJrhyEKbjEWESLm0GbpNZnJxBvQ3e6BtGyN2nAs4ZmfW5FX1E2Rl/KQUS+byVYZkTWRLU9IZW0Y+k0a28SUfjr4wCM6lpl0qWAyCHMK8WJHcxh1UPSnI4Z2HCE6KKd4IUXoknyCDs5cjoCe1CFZG6KU3eLVMgmF6yrxTnN1HuHbSj0SivbI5kIl1u9eLtO6SrtGgGZpCiZd/8J2yEXtAQ+R694jXArh5y9v/sax8AwZ/r5tiXzYwU2qzDkye7GupLCs/I7NkPottkVaSn1pUauylIkf7qEmDNQVxWrqCvwhTWh1saFnlgBJWhlr0CdCCOaLu5JIVdTUIb9agl
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2026 12:31:07.4019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58652406-3a30-4dd2-8108-08de81c59108
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8398
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267732-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:dkim,ti.com:mid,ti.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vigneshr@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 94FAD28D253
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi

[...]

On 11/03/26 11:08, Meghana Malladi wrote
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-icssg0.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg0.dtso
> new file mode 100644
> index 000000000000..f19acf1896c3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg0.dtso
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/**
> + * DT overlay for enabling ICSSG0 dual EMAC on AM642 EVM
> + *
> + * AM642 EVM Product link: https://www.ti.com/tool/TMDS64EVM
> + * DP83TG720 daughter card link: https://www.ti.com/tool/DP83TG720-IND-SPE-EVM
> + *
> + * Copyright (C) 2020-2026 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "k3-pinctrl.h"
> +
> +&{/} {
> +	icssg0_eth: icssg0-eth {
> +		compatible = "ti,am642-icssg-prueth";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pru_icssg0_rgmii1_pins_default>, <&pru_icssg0_rgmii2_pins_default>;
> +		sram = <&oc_sram>;
> +
> +		dmas = <&main_pktdma 0xc100 0>, /* egress slice 0 */
> +		       <&main_pktdma 0xc101 0>, /* egress slice 0 */
> +		       <&main_pktdma 0xc102 0>, /* egress slice 0 */
> +		       <&main_pktdma 0xc103 0>, /* egress slice 0 */
> +		       <&main_pktdma 0xc104 0>, /* egress slice 1 */
> +		       <&main_pktdma 0xc105 0>, /* egress slice 1 */
> +		       <&main_pktdma 0xc106 0>, /* egress slice 1 */
> +		       <&main_pktdma 0xc107 0>, /* egress slice 1 */
> +		       <&main_pktdma 0x4100 0>, /* ingress slice 0 */
> +		       <&main_pktdma 0x4101 0>; /* ingress slice 1 */


Any particular reason to use ASEL = 0 unlike every other definition of
main_pktdma that uses ASEL=15?

> +		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
> +			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
> +			    "rx0", "rx1";
> +
> +		interrupt-parent = <&icssg0_intc>;
> +		interrupts = <24 0 2>, <25 1 3>;
> +		interrupt-names = "tx_ts0", "tx_ts1";
> +
> +		ti,prus = <&pru0_0>, <&rtu0_0>, <&tx_pru0_0>, <&pru0_1>, <&rtu0_1>, <&tx_pru0_1>;
> +		firmware-name = "ti-pruss/am64x-sr2-pru0-prueth-fw.elf",
> +				"ti-pruss/am64x-sr2-rtu0-prueth-fw.elf",
> +				"ti-pruss/am64x-sr2-txpru0-prueth-fw.elf",
> +				"ti-pruss/am64x-sr2-pru1-prueth-fw.elf",
> +				"ti-pruss/am64x-sr2-rtu1-prueth-fw.elf",
> +				"ti-pruss/am64x-sr2-txpru1-prueth-fw.elf";
> +
> +		ti,pruss-gp-mux-sel = <2>,	/* MII mode */
> +				      <2>,
> +				      <2>,
> +				      <2>,	/* MII mode */
> +				      <2>,
> +				      <2>;
> +
> +		ti,mii-g-rt = <&icssg0_mii_g_rt>;
> +		ti,mii-rt = <&icssg0_mii_rt>;
> +		ti,iep = <&icssg0_iep0>,  <&icssg0_iep1>;
> +		ti,pa-stats = <&icssg0_pa_stats>;
> +

-- 
Regards
Vignesh
https://ti.com/opensource


