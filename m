Return-Path: <netdev+bounces-293904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMNlG07uHWotgAkAu9opvQ
	(envelope-from <netdev+bounces-293904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 22:40:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDCC6253C6
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 22:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDC29309F4A2
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 20:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A040C3FBEBC;
	Mon,  1 Jun 2026 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MfWLJQOj"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013025.outbound.protection.outlook.com [40.107.162.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6D03FB7D4;
	Mon,  1 Jun 2026 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346192; cv=fail; b=W3uOA0e/FVY3fIDWGcE7aOnFeGXKtt+C1N/C70A8/cwn93Iyeufp0BtVy2TqRFP0jyFRcmPyr5ZhOFNlGO8iZRu82SRRnC6rW0RnklrmffoZ/t0DKtcuuAu91rNEmnD5hTs2GfNy1baRiB/yoPH3IBQTClPQkNdDtAoWFlms9dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346192; c=relaxed/simple;
	bh=p+T2m87lPVSv97lSTgM9r9IJOL02Wl9904oJX8JpTZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R/xOkQNORG7F99DeD18P7rFkE39IkB58FgQB/h7+16bHFAybB94eal7ikwk2nveVXkt5kKtD5iBh8Mz/wTVBPH/C/HIYuZcaAb0z/n8ndMdU8+/7KGBprM1No06hDGwO8gvgT1vA6WxNQufJbUdhrfelQ+uG6gx4rUMMXBuWxzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MfWLJQOj; arc=fail smtp.client-ip=40.107.162.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcnMYZ/scZFUuMH5sN105DN/WLfoQkiu6KSuehs1X/jsaoAz5/linRAjcpzXX9xbj4jRdgw+3v3fXTcXiVWT7/YOWtCglBhrjO1BpuOwqZmuk6lHhyxvtSP5K3x/jeQlQ7V/YXEKObwOAICm+uXO4jU44FLVRC34KQf23QFf/LKztoFrxlCVL7aetifbViYdGTyVDVYF1vidiaC4O9Mc0jv3AjA3zsYXHwiAlNk6Lai8MnumuI+DcBjATWr2CSjQfvh4Or1/O6uoBRleY6+IHZfLWZPiTtYG0LkAP8PElJE3uITsNNCyapTvMeFb6Cf/MqYn8aWUPrrNnDe1lxuibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSgOQt7jdfRERUZlsJnmJON800HbW5sCVXxY8ujBDLs=;
 b=waPpEI025Qnw8GFu8W3gtj2oMhf3fy7k4hZpUzUhw669dKlVyD1ytAbfWRL+swA3oUp/2sO31SXXzxeAJt+XcrPulxD5hnUZJUcdkBYCxhyDW3JJ6xnGRJO3fXGx+74MwJdqTSW1xpiJ/C6n79v86LRAhHEL1LNJVt+Sr7MJL6aKX+r0zqGFeXCAZQpIs6lFw7Bt12sMtZVzisL4v0z4xlMZvjKf3pKp1E2QCX+Rat5Hu5YJBG5O4VVS0VxJGZ4RKDMSXc1pwIi4MdrA3Foe16KUZIxm/Uq86qhdQXZz1tXrHPcxGH+KsYF7EhS+Ar7PsQ9l4XH2RpA2EmWIoOO6BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSgOQt7jdfRERUZlsJnmJON800HbW5sCVXxY8ujBDLs=;
 b=MfWLJQOjbYviCSs+QKrCdi8/b2R1/NHC6htXeQR5icgD0jW18SSRyNTiotY/3eInO1mL0nkUem5LNTClBJU1FpTLx5mBJhKsuMvj6X2J9GkleWCAX/6I1a/SuPF90URfio7PkQpT06m5BR3nRZcZJpHNusOaArrIEyYBDLaByEvfgGHtHQBpfY/SjvhnHrvOp0GlTzdRDbJgxyBRL4Gopx5q9LSwt7B4IanA76EIdVhI5P+SDQFHhkEIZvkn0/5xznOTxguLfhYfwUfrBHMCeH+2y6dg6z+QdS/Ra7PnPtVan1sDkzVVl96XdEXzna+0eJVBgYiwT/a8AaEV1Bc0Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB7043.eurprd04.prod.outlook.com (2603:10a6:208:19b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 20:36:28 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 20:36:28 +0000
From: Frank.Li@oss.nxp.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Josua Mayer <josua@solid-run.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Alexander Dahl <ada@thorsis.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	netdev@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v6 0/2] arm64: dts: imx8dxl: Add SolidRun SoM and HummingBoard
Date: Mon,  1 Jun 2026 16:36:21 -0400
Message-ID: <178034617107.522644.17438294893077437359.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260524-imx8dxl-sr-som-v6-0-37932c6eb7e4@solid-run.com>
References: <20260524-imx8dxl-sr-som-v6-0-37932c6eb7e4@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0189.namprd04.prod.outlook.com
 (2603:10b6:806:126::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB7043:EE_
X-MS-Office365-Filtering-Correlation-Id: 6907269f-7fab-4aed-1bbb-08dec01d74bd
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|921020|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 D+sVSzktzbvoMix4UHywEedASl99SFVaIfUdv5lShc9vOmO5X5aLHT7dwhqc4ryJcpLHNrYLXDo7x/tzF6dk1W6n/fZUkps/4TAKm6IlwPNdFB4RH7uEdLmjJptBL73hbYYLgg4qpkYt+0dcLbq5k+TrNXDdinKBdg4VQiq8NDLhtLdkm23pvjECb1dMV04l01zdFG+wNBRB73VHuq1pkLeVwihM3+Y6CaIeF3KpTcVrbFkVyicN9Tn6vvdqYHAi5v77LxpVnhmNEMupeuPbb9vboXAh0abqK5h7aNWs9X/NU6Ihu/79Ntvkvnk4HytgevVkmsFy9nbH5TvcDcElu+fFnXLqEP8bBvbojFtztSwumFv7k91/oz/IYlugnt0JvS8Xk/cHawCzTX2sUrSR8hBDipUipL1bgodOCA3AuFE0EMCpfp/vvKbvtcQrZ1p+RsNgVpveJuG/+HncjfC9tfOKAsge/MNT4f7owB7sot/ma9ChEzDZJO2ItEV0Dw2gps5Cev89vZ63CfIoArmLeBze41B+uPe5w3wnxTlX2nml0eD8+G577MYfgvLfLzbEPtUAmal7GFp3AxWYEfX6J0Q8/1XJaMail/o0qEDZXQTXDqgbdyi0TSvyT0ig5e7YZEHznexZYAWC+jfM9sG8S+ilApDzC1ZNXvaU6OA5pjUt9lT6QMP635PGCq/ac+uInjw88BTyahRnKPlGtoNXXgsIiBhJgLTGti2jmhtMsq4=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Y21TcDMwUmNtOFRHZGxxeHRZK0RHSy9aSiswWElvblVGQ2Z4aUV6TWtHd0d2?=
 =?utf-8?B?TGc4V0tJMDBKTGF5eDBPSHM1Yzl4OEFBa0ZCVWlNcVJTeVJSR0dXYWNDN01S?=
 =?utf-8?B?ZjZpRnlPeTBSd3F5M0ZheHVuZURCU0ZQNmhvQUZlNVMvS2VYd0pkaG0vM2Rt?=
 =?utf-8?B?bDVCd1AvcXlKTklPRFdsOERRUzRGeFE0NUNVR0FPM0xDNmxRcUlIdXU3WC9C?=
 =?utf-8?B?V3U1TkxrQkNQQURxcHdWeFdXZ3RDMW1JOUwyOFFzKzBBZFhOWThhV2xXMWkv?=
 =?utf-8?B?VDluak5pUU5iVXpVOFQvS1A2My9HY2tZdGhsZjM1R2ZUZEM5VGFEMm9Wazhy?=
 =?utf-8?B?a045M24wc1VMUGpCLzJsUWxuN1J1VTIyamJZSEZvZEo4UnBYbmdiNUl1YkU5?=
 =?utf-8?B?K3p3MmpEWVZvNWJrcGoyWEZFYzJmZGw4NXhmVVhYSFZzNXdzd3c2QjVMWk9a?=
 =?utf-8?B?TFVCUWNNK0h3Y2VCeFREODEvTmFNWHcwS0R6aGlweE5xbGV3M1JZek9GM05v?=
 =?utf-8?B?eDl1WCtLeGJGdllqNjZ5NVNIQ0hvYkE3VVRRck13MFFiVXdBZUlBendsbGN2?=
 =?utf-8?B?UW5CM1pDN3B3NEJ4U0svWmI0UGd6ejhybk5aS01KZzYyaDdpTFQrTTdjYnJS?=
 =?utf-8?B?UWZVT3BuYjdTbTFKekswWUJjNFpXRnNDcVowZ2s5RGRVUUxQQ1ROWmN0a0xx?=
 =?utf-8?B?ektna3dSdGFZalpsK1RjMElvRHdFQVBCcUF3RW5vTXRJV2xRSi9DWlZpazFi?=
 =?utf-8?B?dlJtZGFpYzE3ZUlzNXFEK2VEQ0JobkdkT1pmZjBoaTF2ak9KcHFwb3BrRlBL?=
 =?utf-8?B?Y3gwdW5kNGt6Q08rajlqd1NQNk0vTzhuODdwb0I5d2xGc25qb0x1Kzg1a2FZ?=
 =?utf-8?B?U2RFSTNncEV6T1c1UXNKNjdRdU1wZ0tBbmgxL1NVd09Vend1NUdkb3plazEz?=
 =?utf-8?B?UlNIQ3R1Wm05ZzNkMStuVWpsNGxmSVNUL1pVb2hXQ2haM3Zrek9ldGpuUEFQ?=
 =?utf-8?B?QjEreEVYSitqR1hMOEVzNzFIYXI3NXFpVWVnMFdGdHh0cHVpMDVad01ScFJl?=
 =?utf-8?B?MUQvTkUxYkl1aVI2WGN5UHoxdWpKNGxGa0FXNXlNWXErUzJmc0syOTJheHdM?=
 =?utf-8?B?dWRoSUNZQVRQcXpwSkE4dityRWNHcUhQaC8xVTNpb2tuaTRvZzdRd1hZdDlH?=
 =?utf-8?B?dXRoTHQvdG94WCtqWW82bmxkcHdVRjNYaVd2UDJBWWpadDlaZHB6RVRXeDRN?=
 =?utf-8?B?RjJqcU9Yck5XOEEveFFPdzBhclVRcXRNV1ROYkNxRjVWNkE5bkdvci9WeDJB?=
 =?utf-8?B?R0wyZW1sc2ZtZVpGMXpHSFRscnZMQ0FBOWsvV1pmU0QveTdDOTRVNG5Camhr?=
 =?utf-8?B?OGFETTloSm90RHhPb0dXNDUvSlJBcDZwM0ltbHdnaEFxVEMwaXFmK2FrMWJj?=
 =?utf-8?B?RjU1SlpMYWJKNE02ZEdKUDVFMVBaQUpYODZzUDA0MTBQRkFrcWg5NzAxcHVX?=
 =?utf-8?B?QWVJVFNycktxQVhCdGg3YkM5eUUzclYyOG5NUE8wZ3hhUDFZNGdTTmx3YWww?=
 =?utf-8?B?aGFsS2hBNmhDeDJqMUE5Nk5qeFRWay9FcVd4aXlaNlUyTzZIM2Y0MXNGNDdv?=
 =?utf-8?B?OU5hdS9MNFIzcHBXTmRybFFkNnhYUFlYV2RmVjZUdUZ0ekZTamRJNjFmN2gr?=
 =?utf-8?B?MVBxdytDenRETGUxdUhxOGJZakpZRSsxNEtTWC9GQm9TS0hYNjh0S0NwSXli?=
 =?utf-8?B?Q0cxa3FIWDVMeGs5aHZTUG1MaE5XaGRObVhoR0tlUXE5Q213ZVJoU3BnM2xM?=
 =?utf-8?B?NTVZSVNVVk9Bb29PalpQWWZkdDdGMkdhaTJhaVp1bFhPamtpTmJrNTMzd1FR?=
 =?utf-8?B?eGtVQU5hZmFBVWhMTzZmVUFHcWM0T0E1d2M3RWdoN00rZFNYTU1HeE5oK1NM?=
 =?utf-8?B?b2FwWXo2MlljTWlyRzNjekJxSTdWZmg5SS9KRXE1cm1pQnRGVU9LNXBzUDY4?=
 =?utf-8?B?V3I2L3pBcTF0UXlYZlMvNDNCZ0dTTGtkVHk5OHd3L0cyekpiOFRtajQvdll2?=
 =?utf-8?B?eXlyU2RnbjdmR1J5UEFLR0loOElYODU4S1pwRDZyVE9XT2REUTJKaHdoTThL?=
 =?utf-8?B?VFB2a2lQWFZ6QkV6Z0V0WHZZRi9MUS9nTEJ6aTdZdTBxQ2RBaTBETUhEM0g5?=
 =?utf-8?B?eEtuYnora0JMS3RNUFAxa2kxejUvRGFDU1pVSVUxR1dGNmljVSs4L290U0pq?=
 =?utf-8?B?eE1BVFN4Y1lueUJUNm9qUlRJOFIvQ09uZ0RrVkxUNUJtR1phcE1NMnFRTjNi?=
 =?utf-8?B?NzY0bWZ6bzA2d25wbGpkUDR2NW5OUWN6N1c1VEhaZlpIaHZ6Vm5TVVZTaDUx?=
 =?utf-8?Q?Bpta/f+V3xW9CfdGPnC5AAWJsh0zBU2TEovwi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6907269f-7fab-4aed-1bbb-08dec01d74bd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 20:36:27.9903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2NpKkGAQWIFoVuvPhupG9P/Il2M5ykIVCCksg19KOIxRL6uUgpx+1xuqErNC5GS+Rrqh7TiQeU3UOruAh8lP6GjgNLfxXEzbcho7QbtKQoBJvnK9IQhbPNqJnBbzRYQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7043
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,solid-run.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-293904-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,NXP1.onmicrosoft.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DCDCC6253C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Li <Frank.Li@nxp.com>


On Sun, 24 May 2026 14:03:08 +0200, Josua Mayer wrote:
> Add bindings and description for SolidRUn i.MX8DXL based SoM and
> HummingBoard Telematics.
> 
> Modify SJA1110 Ethernet Switch bindings to allow SPI Mode 0.
> 
> This patch-set is based on v7.0-rc2, because rc1 was experiencing
> deadlocks with imx8qxp clock driver.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: fsl: Add SolidRun i.MX8DXL SoM and HummingBoard
      commit: 5576da12dac3f360737a4fee990add0d42e2fc83
[2/2] arm64: dts: imx8dxl: Add SolidRun SoM and HummingBoard
      commit: e8a17d1cc036bb73a4f8f87def569502e7e2ea48

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>

