Return-Path: <netdev+bounces-286619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPJOON29AWpqjQEAu9opvQ
	(envelope-from <netdev+bounces-286619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:30:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3F050CBF1
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C34A730056F1
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E708D371049;
	Mon, 11 May 2026 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TBaiEhsP"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A32571A9;
	Mon, 11 May 2026 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498688; cv=fail; b=hFFm4rbBm+q2wciviRzT1m2Qasb+DK50Grlbl6Q2z1PT21Hs/0hcjxppzDngFKHIlF9FRC17iTye67J1ESyM0uRAC6y4HIpZ9Im6X0qgHyJ98Znd1gezhTZBS2y2NhZSuzKisJoNsdPTkit5cAvSihN2L82OvID0SqJj1JaJiGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498688; c=relaxed/simple;
	bh=7NI+WsGeFEVFui4MhljNpoLH/h7PuA2TjX6PfeLGrrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eQTofAaZX1qVvFuhHsGKc/bRbfXXOMe8PtPm+OUIjzO/cX2pB/XcUnr9Mb6KvwgqhfQUw6D5pM8jlA5bSX4i6xpYjgeJE2lndOHo6ijSPy6MJHxB8JhgExdsWCkOWK7UEm46hbp9bX9g7xTe9ODZJIWSPJgPeCWgFIM+m91NdCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TBaiEhsP; arc=fail smtp.client-ip=52.101.84.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KstFZBLiqUCXz4NghrUt1+kUTh8T0AXrKWudA+WNP1G2NzZYUkTaOTxt20qy/t+Jzvu2x5TejsiNKO23USnxMwBd7ZiRFoSpY0/mDW0998nrt9lclL0zHkWwUO7bTF70kMaRpVBqwMnJoK1Aw8PcAgD1uf37cucx6nVSk4chPIHRISN7TqoYjhZB+ykHdvZyGa7Q7TcKgMiMO56ueftd8cO9JqzfkZm/vauyGQbBnfUaJmMU1VrSzU4hGfoEp9bb1uiY7LhD/tMKXWsqQT9FQAOTdqDpcYsM4kfxiC/OBl8AE+KSRAFTuGJAGXyquPoDY1FKv40y2x8XNgTx9KUmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3Vz/rnREUiqd4G/Z59cJVvZen9/iBGcJ1ZbCsaR7Mo=;
 b=E2/tDnLQiDVw7WpV+s3TPSnCCf8Q26HRpSHkuKKio08gOcRSXGCqhcJ7JfQQPzwabX5XbxUKVlOZfKqa4GMhN7oA9J/Ko6a/IcSULxlfSb3rfPvTmFonOuJeeQONX8CWnsikKsQ3oTX9ANEj293WfuK6Ap6p98bBUK/Ce02G939Jc/hvMwcNmqU3RbKIJomXvW77sqai03RjxeeX3EBTigqN0adXChT0M52scHVR9zRorqBdQ79hnGPwjaSE4yG5WEQpB9mpPW+4yUimnsJ5MPrmVx3H0EntiMSmbouW5QELCg/Lexpu0NZ4kSG3DQDnvQNa+9WnEydV2HF+cafbjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3Vz/rnREUiqd4G/Z59cJVvZen9/iBGcJ1ZbCsaR7Mo=;
 b=TBaiEhsP+oxSIVoKNyXC04H965D9AIbnH/P7ZDQbWwLeEjSXU1mPrMTnwfiUgiZ5SpFJkhmrDFUER8tajFh32Yd8buwSzYoW6IIuqQZSQIayff2hvyb7K/PBlhi7/SUaieO988Jhv9GcRuO1cTE0gCtRZC02CO8CI7ZBdKB5BTkzC0nFxYH5YKZkcig4rjClobsGgryawYIbcAZXdgThbHppCkZCT4z6/6Hdcuy7Ey+RiXx7VNcFzxTDHy556SLXbm0X08BE+5MjjzbNQ+2KE7Wk8CfTQDKNNjDEC/rnZ+5ZOeJx/N2PGeoaGmWAh/NVlvqrd4UKtf0hZMTtPRtRyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB8160.eurprd04.prod.outlook.com (2603:10a6:102:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 11 May
 2026 11:24:43 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Mon, 11 May 2026
 11:24:43 +0000
Date: Mon, 11 May 2026 14:24:38 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Alexander Dahl <ada@thorsis.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 2/2] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Message-ID: <20260511112438.4fxvhelf242emzft@skbuf>
References: <20260511-imx8dxl-sr-som-v4-0-64381b3bf80d@solid-run.com>
 <20260511-imx8dxl-sr-som-v4-0-64381b3bf80d@solid-run.com>
 <20260511-imx8dxl-sr-som-v4-2-64381b3bf80d@solid-run.com>
 <20260511-imx8dxl-sr-som-v4-2-64381b3bf80d@solid-run.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-imx8dxl-sr-som-v4-2-64381b3bf80d@solid-run.com>
 <20260511-imx8dxl-sr-som-v4-2-64381b3bf80d@solid-run.com>
X-ClientProxiedBy: WA1P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::15) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: 864da223-84a0-4595-147c-08deaf4fe5ff
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|10070799003|1800799024|7416014|376014|22082099003|18002099003|11063799002|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
 fXH0GiQDqkk1J8k9JdeaZvRCxp0vmo66Bazb/HKiMy7fXEkcTd0HJypMFYF47OFXla7S0FlR2vzzzDUXFApuxtv3UaUtdmnzFl45ri4dsOBcxSCYqwDhmh3zdchC20kQc8B23jxWcODmN80lbe4keM1xBlcMTFKL5+/MYRff0Ne9VohOKiNElA6WgfAUwLY6mTiPK8Tx4krsAYlNzy6lsveevcKobfbwFIlutLrpOOP5PD3iwWxs83OODmGxNiP6x+SnglIKFbFkQks8+0o0SLniEZiSg0jmSFnCAhWiCxz3avoAw9Dqj1rFgZHVzTPQB8Xpem44Rk3BifVwJ9uV3WOUuy8uZff/6SSCCpjKMSdqIJawP1OXLINOQ50h5uhaZRRxdETqXzAoBsFFi+YcOVCAp5v+c8j7fpWc7k5zUFCa/2nPLpP0oOn4WUxMOtmdgc/2Gnixc3kOUjF/I2zdMzpsfH+NOsVPTt2v1G5bG6nz/mbjoXP7t8eGxxBAsflgzM5IUETJZ/eEopIKM1/fbpm6KXhgqzHq6Hwko0Z9YtxT4yFaqBc486q+MMErarTcM0plnjo1dkANV01yaKC0/iO0x8ap+oEonpal/NGLvrmg+3f3yas2aG2wIxkNMpaoGVyRGt3e8cR8b4qmDqAXBMLmoo+c/vXASsXXVRaLND3XZZM02AwcshaHua565lBJ
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(10070799003)(1800799024)(7416014)(376014)(22082099003)(18002099003)(11063799002)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?C73hCY3kilGn5vNbmcbNBGF4Nb3csaoE3tCq4PT9LaJrQrV1Slq5Col17/YY?=
 =?us-ascii?Q?jUiBVd1+lAf0jhU84sreQiJEA8oCGwD/QRnmMZhtBC6demMDTQ/4wRt4i1L1?=
 =?us-ascii?Q?26mZtzIzTV1RuCtG74hnGZsZ1DWqmSY/pK/cbSQhTeaa6iYtGyRsht+WFZuM?=
 =?us-ascii?Q?DO75kjckneE4ioRHkaer1oVAqmo/z/zNLxvQBKXtOOy+t7xYcvW8SiyTGxg3?=
 =?us-ascii?Q?Tg3ho4TGScbs0+LUrHciDtYoGg/IXYsRAYHJGpjTgNy2pYPVBWid/wgJy41k?=
 =?us-ascii?Q?fPUG39Mkmg16dUa1QI0/lvDkKMv4bxpux1pDHxyugM0RX6XwsrUX6BT9htzd?=
 =?us-ascii?Q?L9MqsgVFM8/iDSZpCuZdNefN+ptbSCVDPrlHIRmdJfD0CfiTIoWulWptlNye?=
 =?us-ascii?Q?gnw6Hlz3mnoptltUFfZrX7BXlaxefpSxGBpzv7FneMeHx9wbk/cmf+CddFLh?=
 =?us-ascii?Q?C81r5qve0/CzMcLCdECEoXYavjfzZxgfUzvIUfypX6m2EO8VeIpHGVaT4AEO?=
 =?us-ascii?Q?0RXUw4Y6EAhkd/HvLxLPOmUD8gB1FTt1W81xTQ12m659XbI/abOq2CnOBgnd?=
 =?us-ascii?Q?G+gmAhSSD4P8xxclRXMx5hWfXJMy4yb0aG7o5rR+0GNIPq4WOnZdK8KGie/n?=
 =?us-ascii?Q?n/iJzCM2BAHzV7fe0esuyXQr5gJsnv3/7K0JJkdeE40AyoEQyZxPED/FI3t0?=
 =?us-ascii?Q?5R348jFyefDAp4MBl/pSGRWuZRFmPX2XUswqk8szWwYuSlxBEjuIXQQVi7vT?=
 =?us-ascii?Q?7CLYyfPC5b9LOm1ypP5uyIChPRE2agX9HTEKHIrNp1atlLSoAbszdMAbAFWB?=
 =?us-ascii?Q?FUrVyHa7jqIPiaY9pwS1lho4RQTojmTqcWBWzgp06xr+4+j0z72L+lA0ywKe?=
 =?us-ascii?Q?Dz4o9MfD6CQkD7udDS+7gDX0AjJNSA4nUmOeGiVZqNE4YxEgwmOHHeqIFN9K?=
 =?us-ascii?Q?gpAN29E3TfRgKxCgPerYOXXtnquphDHUn49U1YxssxCRtjPjdprd1Rr4LrcV?=
 =?us-ascii?Q?ZyNbt72br3YZvVJ2qy8sIlqZPznktW3vn2f1EuZZbcVseyljdPIzGYRqkCo0?=
 =?us-ascii?Q?bGHZ9JXfmUuDTBVVCZNrlFTq/xzjSCPYaHjz8Kt4OyvzIppguv7NDKE3MUrm?=
 =?us-ascii?Q?rILETXP8/bsxxij7XXidZbTw4Hu0Kr0EiJ1nuYM3k3MRps1ztll5DghPBTdB?=
 =?us-ascii?Q?rigI/Dpmy8NlGOcJIGQe2uJfKZytHMa4wdqrFbDaBfsdNQwylLxm+Wbwe04I?=
 =?us-ascii?Q?htaXzMy4eLOwsFUq8LsJHeZA/ejBaiAegwfAIELFT87P316LmOi6cGuo9j8o?=
 =?us-ascii?Q?y59eC/GA+yV/IvlLWG3MhGIQ356IgPfgRU1aX2/Dornown2tWosePOrqIiib?=
 =?us-ascii?Q?u7klgvg6r3uOEIT+biopR/tBCMd/gqpltFbC73EOjaEo70FaqwwApktlX5+A?=
 =?us-ascii?Q?sVUo9405+emTtlJL5xu19MEStdW5Bjy/3vuhOKewFPsaT3axaM4tAzwaiSxs?=
 =?us-ascii?Q?x4SBhQ0bPWXMzPyfeVcRuB6Y58x7x0a0P4xpCZ4rk+5KlRLbFrjdd8NZDjYg?=
 =?us-ascii?Q?wjeWHe2btjwZIf6OodJrAQuBki6u3Q6bewesQLZDbpK4cPtbvY0TGi+qJi8r?=
 =?us-ascii?Q?LpatuhDkCZLmidw25eFxuzTzwgqW4+AmdtyC7jCa6WIMNebowlNrWNQhbqNC?=
 =?us-ascii?Q?Ei/JEqG/CeP84xS6Wfv4ZkeiNBxeI1XQ5UCNaqQoauIBnp7NeCxFullm0J7D?=
 =?us-ascii?Q?9y+io379rRXBGutjPW19ysqBkBP1W8PnA76b2RfV1JhTXoJpolihzMm4e2b5?=
X-MS-Exchange-AntiSpam-MessageData-1: 8lpi/BsRytXUHy4sLsLp7oQx4/rZOPCB2jo=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 864da223-84a0-4595-147c-08deaf4fe5ff
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 11:24:43.1141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKF9z/zk6xZ4meI6N53/OqiDLmBREtTFKWe6ExPtaU8wA3iOFVgYnvvJ9SSCwqM9WeSVHbRg+5n+8GmnVf184w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8160
X-Rspamd-Queue-Id: 3F3F050CBF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286619-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,solid-run.com,thorsis.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,microchip.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,nxp.com:dkim,0.0.0.1:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 12:11:31PM +0200, Josua Mayer wrote:
> +&eqos {
> +	/* delays are added by connected ethernet-switch cpu port */
> +	phy-mode = "rgmii";

Documentation/devicetree/bindings/net/ethernet-controller.yaml says:

# Informative
# ===========
#
# 'phy-modes' & 'phy-connection-type' properties 'rgmii', 'rgmii-id',
# 'rgmii-rxid', and 'rgmii-txid' are frequently used wrongly by
# developers. This informative section clarifies their usage.
#
# The RGMII specification requires a 2ns delay between the data and
# clock signals on the RGMII bus. How this delay is implemented is not
# specified.
#
# One option is to make the clock traces on the PCB longer than the
# data traces. A sufficient difference in length can provide the 2ns
# delay. If both the RX and TX delays are implemented in this manner,
# 'rgmii' should be used, so indicating the PCB adds the delays.
#
# If the PCB does not add these delays via extra long traces,
# 'rgmii-id' should be used. Here, 'id' refers to 'internal delay',
# where either the MAC or PHY adds the delay.
#
# If only one of the two delays are implemented via extra long clock
# lines, either 'rgmii-rxid' or 'rgmii-txid' should be used,
# indicating the MAC or PHY should implement one of the delays
# internally, while the PCB implements the other delay.
#
# Device Tree describes hardware, and in this case, it describes the
# PCB between the MAC and the PHY, if the PCB implements delays or
# not.
#
# In practice, very few PCBs make use of extra long clock lines. Hence
# any RGMII phy mode other than 'rgmii-id' is probably wrong, and is
# unlikely to be accepted during review without details provided in
# the commit description and comments in the .dts file.

My understanding from the above is that when the RGMII delays are
provided by the switch, the eqos should have phy-mode = "rgmii-id".

> +	pinctrl-0 = <&eqos_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	fixed-link {
> +		full-duplex;
> +		speed = <1000>;
> +	};
> +};
> +
> +&lpspi0 {
> +	cs-gpios = <&lsio_gpio1 8 GPIO_ACTIVE_LOW>, <&lsio_gpio1 7 GPIO_ACTIVE_LOW>;
> +	pinctrl-0 = <&lpspi0_pins>, <&switch_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	ethernet-switch@0 {
> +		compatible = "nxp,sja1110a";
> +		reg = <0>;
> +		reset-gpios = <&lsio_gpio4 3 GPIO_ACTIVE_LOW>;
> +		spi-max-frequency = <4000000>;
> +
> +		ethernet-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			/* 100Base-TX on connector J26 */
> +			port@1 {

Some people might prefer seeing ethernet-port@N instead of port@N, to
fully avoid confusion with dtschema/schemas/graph.yaml (although, the
container node being ethernet-ports now, the confusion should be
avoidable).

Also, if you ever perform device tree fixups from the bootloader (like
for setting status = "disabled" to status = "okay" for the ports that go
to addon boards), please never hardcode fixup paths, but always use eth
aliases to get to them. This is in case the port node names ever change,
to avoid bootloader regressions.

> +				reg = <0x1>;
> +				phy-handle = <&switch_port1_base_tx_phy>;
> +				phy-mode = "internal";
> +			};

