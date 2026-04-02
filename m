Return-Path: <netdev+bounces-274449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OQBEl9AzmlQmQYAu9opvQ
	(envelope-from <netdev+bounces-274449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:09:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA9B3877E0
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 695D531EFE97
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 09:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01D736E493;
	Thu,  2 Apr 2026 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YFC6kE/Z"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E5F36A03A;
	Thu,  2 Apr 2026 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123594; cv=fail; b=mzHN2MIPPd3f4+wLj5nMFsvuBnNXl5aP64d53KQT/tPkXUaQ0gWrbxIG3N34IpaDx3vdIpnXIxvUL7j4znzFmuM1Bah67b8hFL5GBoXwzagbEOnc4XQnwDm6yP2c9YxiVafB78xNds5QcNsA4zKCWjcVzGdZev/0RqHnhxPCHxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123594; c=relaxed/simple;
	bh=zsM13l11f3dzroa3zBkT7V2XT4FHhKahRhTJcKzDgLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tgf6H8atWemEXUroWKRgvRWUPFlGY4iXQW1cHhQOT/gCFYcnQQQhzQ4UMkYe/nkoil14ueyef4n3v3C8SGFs+5JlQuf0IRIH5NCoPSqebxY9UqCXrGx/waQgV+/6HDSMugnfTqCAoOpNKTyMqtWlv704wEEQm/LbVHkcuU0VaZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YFC6kE/Z; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hqa1pjkW7+998cYOtxeESrzKAPNKFFd3PhQjtAAmbuT4oSvhzJQV32UbLo8OW/syzM4BRVXaEIttTAwgtB8m4mWiWfqvamYm+7qLsx5YS75x3KODB6LZGLBwCq2dJ8KmJA39uTQA02WBueMmZuhNDB21KMkJIGvmJxMDSV2BK1D3OtuGsTKcCVNcNue9w5W1DaEvpzqtOngm2b5K0tMR6V4ype4pOmLKL7kylbG+J+OW6yjKvR+o6K4qW0bH4lV/MQsTabht1JKX+d+huVhUqAoSbklNbRjvTaU3MPit8ykzJS1XKZiaF1XCEOUszn/5kHXYa/KJ/3K7wIUhRwJX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UmGBAJ4neYJvCRL1Vl6/3YEMG0ATgvKxcPxKCXO0qc=;
 b=iQ3R4J6hpQn03i1H+gkTdb2Ks9jNCV6AfQ/+8B/abH4J5ofAskeq54hMG8v71jURK+lun0m5PJAplHXBQjpOwp/ELriBCB2xJZZOyJdc3F1h9eSn48VASFRkMYMqUQKH5rLyxdv5F5ErKgPPJifnKBHl/XgzwhWJCCePCopwtjDKRFIW7K/XlcR5TkMSjbuS6C92FUdg8y/NaKobndZCMFj/vgSR74ViXhS0UqssgY5tdM96jypJL3z+p7fTcBFbKFPe9rfl2pZJyuNDBwxrgWhnbimaOohcrMfP2KlrrsFWnNptfKt2Jrf0osArCjGhf6r2Bdhyx4+y7oo22Vo3Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UmGBAJ4neYJvCRL1Vl6/3YEMG0ATgvKxcPxKCXO0qc=;
 b=YFC6kE/Z68x9iXCmWPgUDM3s3rH47zDWNkxr8ZyM3pf7dcv+7L5uJirlnRfe3PMrKwEJ4pmL3qLaMAkEg1yWRHnkyTuJdQQJOtpRwJ3Ea6hTFYP0G7s53spVoXOe8gW0tRs2w4H53MvJaF5TLUUMz1mfE4bo9KGRbX6l36di5bdBa31mQVfJ+Y+oyS/hSy9Ib+kdOiQ7EMOpJtJbWkiabF3lkbonbYDWMhcPIOUc7EyekAlvlumPaPtvYZ+2LUjkjqHt9G73GXtRqfGilnP71Nf2NAr+GybKirWXVVwiNcp4NExq/4XaSQ1bR82jT84MuRzz8CIgQ9Hyyaw2RvsrYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DU2PR04MB8550.eurprd04.prod.outlook.com (2603:10a6:10:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 09:53:05 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 09:53:05 +0000
Date: Thu, 2 Apr 2026 12:53:00 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Frank Wunderlich <frank.wunderlich@linux.dev>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?utf-8?B?QmriiJriiI9ybg==?= Mork <bjorn@mork.no>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v4 net-next 5/5] net: pcs: pcs-mtk-lynxi: deprecate
 "mediatek,pnswap"
Message-ID: <20260402095300.hujib22ag6g5wkts@skbuf>
References: <20260119091220.1493761-1-vladimir.oltean@nxp.com>
 <20260119091220.1493761-6-vladimir.oltean@nxp.com>
 <e0ad52862d34cf4e0169c9850a7f164f127d0093@linux.dev>
 <20260326215404.krh6v3mmnqdlndli@skbuf>
 <d9639ac711ff8f1186a684fa120ba77247669051@linux.dev>
 <20260330190443.bol5vjfqqitz7kuo@skbuf>
 <4dbc3dabfdbc3bdf6b8d411e62a27fa8988e3388@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dbc3dabfdbc3bdf6b8d411e62a27fa8988e3388@linux.dev>
X-ClientProxiedBy: WA2P291CA0038.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::8) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DU2PR04MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: e43cc082-5e18-477c-0d30-08de909da2ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|10070799003|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	m6l250svAD6sVy2J5XSRNZSA/VYsxAO1VbrEvLC3wNHMNtkbHCgEX4/ezfVOB7hGt4q5cr1+gnVFNRIaAOMPPkaOzBx/lCLueBIK3EPUD4+67rLZKtUxgzp+/4XhXl/XcZekT9owH9VPYxQTvLU83WW3ko4hsxKY01qfhUWbv6HhHl317nPbLKR8IyTqIq62G1OMamN2l6YQYxCRDkrcCcZy2srlwa8fl+aPC+JbSjpYzCrovjatH505ATQekDMbS6+5zxvT1p2nbxHA+F3ApFfv5IS8T2wdO5T+fPg/ETcVJiHzN7vifB651N4qJr+t+IShq9ggdd5/Jd4/F+UQpbs4G0SEPdO1//dJAtqjcY2pOy4wv1pszL37qlQvVNTMaan3pOfU1M1XAvLraaBZJSb8bsCgwLfkZHxtMs1TDRr+diCjlsg8I9k91TGeQhq9AL1ZNC1cZBKqGyOuCoSrx+VUmQFpE4WPgbWdmc6/mUVSF7ynyfwTz2luSTF8TwADtlpGXAvRui6M1dYEeG7FPscvhGpF3uS9FY6zK49V0PLghrSknBoky0f4qWTNdiMT8/lMxKq3y/gnZokdcbZXZ2IEY3LP88FjunSzOSX65ODENofzpEz6EIEEr0XkvmEgNNFi1CrXbO4X2FzdIhmMmfcJOxHq38AJKI0sQmeUXJDmzNMfml36ul35BSkrQ931Mq/SmETr46XgFkKUssH1vg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(10070799003)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fYl5qYFfT/OHX1ev/hr/bu01a8HThM6U88tLtFuO/oOLzxeReSlD6UIGlFz0?=
 =?us-ascii?Q?JkyhGGWjHqGDTGgLFU/nitilFMkpPNxQeaLOdpF2ZBQhAj09RlR4mNWFlkRa?=
 =?us-ascii?Q?YgDjd0lVntiN7nO8NvvBe9LKONLzrWygqwaM8RL+SZp/FUW2V4JRuU38Pps3?=
 =?us-ascii?Q?X9X8MrLNhF8LmO7fa7eT1bRHzJU5vnHdsoe17y6w5Bs7ITz5tgIT6OrHwFZy?=
 =?us-ascii?Q?LD4fz8esCu2+3K3OlOgLIiPQRVUj09TPOiRXjrJypt03H9Yqh3g2GOiFPcjn?=
 =?us-ascii?Q?0FBrkT3ed4PKyYa2yHMF/Z1hTFpzolxUzx85o2wCuOGkTzeFpJJIe1oGOjbp?=
 =?us-ascii?Q?LcA/Fnea4DnPok4+c5p93iT8GN8XSeFmiexpz+/96k2ttbzWMbWbPMZhkJOh?=
 =?us-ascii?Q?S/Qr+AjqYkrCn9MEPDMnMokxCUfiyHEuhPLBVTK28WkCLn7C2xktu22W/yBz?=
 =?us-ascii?Q?0dbflJgQp4BSs3ms7Wtpjlk8i7W1LdnHIMXNUy8OershQgt+7nlzv+wBtBRR?=
 =?us-ascii?Q?ft+uPY3LsOdAJS8RP8gUTEjj3G2LDP02qioT/ZAmADviHI2l4YcIt8nI6+7I?=
 =?us-ascii?Q?CRN83g+Gxc/PqjBH8jab5Y3SLs4YRMDuw0XqACsU6iLeeWM8r+U6iOuelLxW?=
 =?us-ascii?Q?I6LwAoruxwhU5GPW1uWo542NslbyqRzN2FYUa5vVmjt9l1eY11/XwAUvRtQR?=
 =?us-ascii?Q?oFAJUSUE4PvKtI1/Em780UnVKu/PbssyHJYuioWCfvBFzrKwhLtAB/MOTV2H?=
 =?us-ascii?Q?6Y0Npz4FrSkFbJkrGUeNrhhThu5c+xFGaje8zfdF/msy1F5R9VUXmdWQwLor?=
 =?us-ascii?Q?tPJigVwJn73YUHAs5yFAuZ0Isx3Lz+a7w4HOD1wCuaQQn4BYx5uxH4GwrKXw?=
 =?us-ascii?Q?hxnyfe492YfykCvr0tiwWbMnsDwUalIAbcaeqp+7IthnNROx6iI29AieuyFt?=
 =?us-ascii?Q?B4bZLKOFfb/jPqKJxbZuE69xt6k08uBGL0QeEAPiXGgoqxGCA7k3Kgy1IObM?=
 =?us-ascii?Q?rD7/hM7XhjhC0SflrjUUDuCh4XfVXmMNGzTVTXzAFSmjrpncec7iDXCxZAW5?=
 =?us-ascii?Q?aBMus12AzvWKCHaxS0v80XkJC3PjVdJajsv7EpziDr33MqUTsNdkway2xZZA?=
 =?us-ascii?Q?vMpZwL+cZIPmPN30ra/iQgwGKi4StYdUSBUD675PiNm7htm5M88/9bTWdUjc?=
 =?us-ascii?Q?dsWBo81AR+o6aPNLZeUi8lmzQWCCVEzgMQZCSsdjIATpl/PPQSlEGYO47RGh?=
 =?us-ascii?Q?yR5qorNqUejJPG1B3Pd6IMB8LQwbZZn+1DITOWppF1c0JSIRftKqlpzdAxMP?=
 =?us-ascii?Q?4vFMg9/LpOdT9NohbZ1K/8Ui4R3as8OFFJgfUnsewwonswck1rMFIXJ35u7T?=
 =?us-ascii?Q?fth9kl6puAOHhUGoZoz+EMpHhyfAEPokwVJHGrIp4rUbDELAN+19ZExzkQAv?=
 =?us-ascii?Q?2keH8StTXPrc6L1vX4P8WsRFZGX/D4fIHp14Qc3Bz/mLh7Rxl5TepLmFHXAt?=
 =?us-ascii?Q?4lfvZ/J9RM7Xaw27ZY+d6pM+3ds6bNGu42+EsWkKRFpYToQLxg9+kbovcY8n?=
 =?us-ascii?Q?+aRCMUMD2nH3Maro0PS+CEt3AS28GwAlJMzVxPM6c4+uOKQberbRMi3CKymJ?=
 =?us-ascii?Q?yCMTMr2uT2M8zvXDC4rRpgJ2hERC36aemxKu+Tu22bbUQ4ikChl9qgAuSSI+?=
 =?us-ascii?Q?K2MUkRwXRfwJ3QpMfoY3jom5wlfxlCLYIq8mwAJGZtBd1ArrPG2Lgcds0guv?=
 =?us-ascii?Q?xoxyz9cBzcxc3lZDv1LEXvdWTQ63vYveJWBgU18lY+BWPS5TD94DMC/LEldO?=
X-MS-Exchange-AntiSpam-MessageData-1: S7OwFHUukE/JDkuoawsyxxCxa6u/YyaYwcM=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43cc082-5e18-477c-0d30-08de909da2ec
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:53:05.6518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBjA4YCtJb9B615xJNypjMTUfSXUyT0CFZQNOU0CKAI9DeOZm+eMOlGGaQJqrSHZOYylJPyJrzQgEoRb3CoJ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8550
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274449-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,makrotopia.org,microchip.com,mork.no,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,fe80.eu,arinc9.com,mediatek.com,nbd.name];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,0.0.0.1:email,bootlin.com:url,0.230.104.96:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: BBA9B3877E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 05:50:33AM +0000, Frank Wunderlich wrote:
> Hi,

Hi,

Please don't top-post :(

> i tried using these properties in sgmiisys0 node (which should be mapped to mac0 and the mt7530 switch) without success [1].
> 
> it looks like these properties are not read somewhere.

Can you please clarify whether your problem is with the SerDes connected
to a switch port or to a GMAC?

Because if to a switch port, mt7531_create_sgmii() doesn't have any
phandle to the SGMIISYS. That was from existing code.

		pcs = mtk_pcs_lynxi_create(priv->dev, NULL, regmap,
					   MT7531_PHYA_CTRL_SIGNAL3);

The LynxI PCS will be instantiated without a fwnode and only the
defaults will apply.

> the flow is
> 
> mtk_probe (eth driver)
> 
> if (MTK_HAS_CAPS(eth->soc->caps, MTK_SGMII)) {
> 	err = mtk_sgmii_init(eth);
> 
> and there calling mtk_pcs_lynxi_create with the sgmiisys-node (for each mac, so imho mac0=sgmiisys0)
> but handling the sgmiisys only as syscon, not a "real" pcs node [2].
> 
> but your new code calls phy_get_tx_polarity and should read out this properties, but from subnode "pcs", so next try was
> 
> &sgmiisys0 {
> 	pcs {
> 		rx-polarity = <PHY_POL_NORMAL>;
> 		tx-polarity = <PHY_POL_INVERT>;
> 	};
> };
> 
> which results in completely strange behaviour (looks like sgmiisys1 is mapped to mac0, but based on code in mtk_sgmii_init 0=0 should be right):
> 
> [    2.765218] SGMSYS_QPHY_WRAP_CTRL = 0x501, will write 0x500
> [    9.143849] SGMSYS_QPHY_WRAP_CTRL = 0x500, will write 0x501
> 
> but nevertheless i tried changing sgmiisys0 to sgmiisys1 and got the dame result as before
> 
> [    2.713644] SGMSYS_QPHY_WRAP_CTRL = 0x501, will write 0x500
> [    9.061509] SGMSYS_QPHY_WRAP_CTRL = 0x500, will write 0x500
> 
> i can only change the second serdes with sgmiisys0, but not the first.

I assume the second SerDes is mapped to a GMAC port which does
instantiate the LynxI PCS with a fwnode, right? If so, the behaviour is
consistent with the code. Only mtk-soc-eth uses mediatek,sgmiisys AFAICS.

> mapping between mac and sgmiisys in dts in mt7986a.dtsi [3] are like this:
> 
> eth: ethernet@15100000 {
> 	compatible = "mediatek,mt7986-eth";
> 	mediatek,sgmiisys = <&sgmiisys0>, <&sgmiisys1>;
> 	...
> };
> 
> &eth {
> 	status = "okay";
> 
> 	gmac0: mac@0 {
> 		compatible = "mediatek,eth-mac";
> 	...
> 	};
> 
> 	gmac1: mac@1 {
> 		compatible = "mediatek,eth-mac";
> 	...
> 	};
> };
> 
> maybe it is time to revive the PCS framework discussion ([4]-[6])?
> 
> [1] https://github.com/frank-w/BPI-Router-Linux/commit/4846a7bb352fe5911136cba33813f099bac035fd
> [2] https://elixir.bootlin.com/linux/v7.0-rc4/source/drivers/net/ethernet/mediatek/mtk_eth_soc.c#L5001
> [3] https://elixir.bootlin.com/linux/v7.0-rc4/source/arch/arm64/boot/dts/mediatek/mt7986a.dtsi#L528
> 
> [4] * https://patchwork.kernel.org/project/netdevbpf/patch/20250610233134.3588011-4-sean.anderson@linux.dev/ (v6)
> > pcs-framework itself had not yet got a response from netdev maintainer (only other parts)
> [5] * https://patchwork.kernel.org/project/netdevbpf/patch/20250511201250.3789083-4-ansuelsmth@gmail.com/ (v4)
> > discussion: https://lore.kernel.org/netdev/20250511201250.3789083-1-ansuelsmth@gmail.com/
> [6] * https://patchwork.kernel.org/project/netdevbpf/patch/ba4e359584a6b3bc4b3470822c42186d5b0856f9.1721910728.git.daniel@makrotopia.org/
> > discussion: https://patchwork.kernel.org/project/netdevbpf/patch/8aa905080bdb6760875d62cb3b2b41258837f80e.1702352117.git.daniel@makrotopia.org/

I'm not exactly sure how device+driver for the PCS devices would help in
this case though? Because the LynxI PCS driver would just retrieve the
fwnode on its own, rather than it being passed by the mtk_pcs_lynxi_create()
caller?

We need to have a very good model of what happens when the PCS provider
goes away, especially in multi-port scenarios. It is a similar issue as
to what happens when a phy_device goes away.
https://lore.kernel.org/netdev/20260311153421.u454m3e4blkstymt@skbuf/

I'm not saying "let's not do that", but we'd effectively introducing an
issue that currently does not exist, with the PCS lifetime being managed
by the consumer.

Do you have any better idea by now why SGMSYS_QPHY_WRAP_CTRL is 0x501
for SGMIISYS #0? Is that its out-of-reset value?

