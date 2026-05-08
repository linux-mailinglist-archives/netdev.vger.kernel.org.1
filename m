Return-Path: <netdev+bounces-285801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH+8A/LZ/WnjjwAAu9opvQ
	(envelope-from <netdev+bounces-285801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:41:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3704F67B8
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4B8030069AB
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63393DDDD4;
	Fri,  8 May 2026 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cDrPgXhD"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D763DDDB0;
	Fri,  8 May 2026 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244007; cv=fail; b=XXFsNiruJWVNpF/oQ4lUzj1JDkAKab0SCS5y1y5vkkzZsAlqUcI6VE1ULU6SKIEDp+O+Kw1MszQMn9pOmNpptKcgfVvHvmFv+JDtSiYeDCrWmjeUjgy3tC1Ujbw2Qn+yEpS30EuDqzyTGI8XHUMlvw+vbygnNc49MPLmku/GEIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244007; c=relaxed/simple;
	bh=b+B9tfzLBJnLvEXEtsKs1IzDdwiNdShw+WqC7FtlbCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hfpsSkGXgLZ73bpf7veW2CQHLEpexuYS3W6Hk4DWkyImb+CYxe3NGm16nE3nGP1Fn4wzxTf1bdCGJaNZk6xsfceGM6vAmbMnWtlRO7+EMYbccj9+H2SHb4BFbkrPcJdHMjvnBlktuYmzs6hFhr6yHqoE62dWtVSW1juZa3YnaVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cDrPgXhD; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5imQ2AznITmilmIteLsvIbFdbgizhrOLnBeaEYbB1ZN/WNASI+oO4kTT661AtYxAHM1m5u7AmDdarbvQFXIrURNROD0RrPiJjiLb+sJN5IqtqgH8tIB1VYjJ7vNHPrmSwEkls5P8OUBGcQ2ZTOX4lgjRdgYgaBYukGywIpr5mqtgtqTi0/jB7KTGHQjqmtqvC92YCd7/XHGfpE6HaEdg2GPWGbPYvDF/5h06IV63ZNMkSaljskbT2rdAI/YN61pVkeS57YDPIaIv2YOYLTTUgi4AI+csb80Zo1+v1AuqOcKvZr3D+V6SHt5rG+JqU9ms2TlXGgQ6fmDzteeMipPJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56IZhT3PHMNoMC9gSATXP8OvYs5qSSlvIbtLr34Q9Pk=;
 b=RHpEURCOKVbKj+DuAgjuYcVDq2K7c+1kbQwBN/Fl7qDxJb7OnWEXh2uHhSN+BWvnF4k2jO1jkqlAr3SXLFDlHcLTL5YaArcmI+G495DP6Ni0FAXMeWxScSqizsPfWIlwTC+nC93XP4HBckEyQGQDVbUjlWiHkYJ7KlYl++MQFeQfmQ3cHcAh0FKkGCw60ElV/KFw2kqD4VgCH9PUosrUiP+2hjsPqABC30ztuycv8xbSt3KhndywVqcdTKBvA8ExzNMGopo35e693wksV3MYtQ57POzdNPnpxd5wVptgUtGtaS6CHJSfo8WXp0jXtzB6R3lcwUQXZLaUiCuLViZn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56IZhT3PHMNoMC9gSATXP8OvYs5qSSlvIbtLr34Q9Pk=;
 b=cDrPgXhDtmH7p4ALXjRver4/RlzA3MoSDWghQHXygQ/lkwD10TzvtaJLtp4t66sT8VT7vmAxuI+efCf3ONbFN1yMJH3hzsAHcJy8BIOQIHMq8u8SbraoRQRLH6nEn53R2rZOqfk0t2QyLF+oHfmSCyBxNJOZw+7rpqYotlTMXcTxOElWI8/5Z9DvUyBPTg7KURzyTd0bjy16cZk6W+TGPxRv7hXdzK/SLDnfTOHBTPYQXbR3XhlMqHcj2VBbrOzpHvWMVbNzm0P2H8WXEb5BJZN9hOPCTAmTdKDwEiy8PjvB8nEdkV5eWOGIlj93QqBijsgneOlLEjXCNHl45EbMmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by GV1PR04MB10153.eurprd04.prod.outlook.com
 (2603:10a6:150:1a4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 12:40:02 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 12:40:02 +0000
Date: Fri, 8 May 2026 15:39:58 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 02/13] dpaa2-switch: add support for LAG offload
Message-ID: <v2gmnstl5rgy4xvqfsrw2ynl2vusujt5lgkeg2m76dushtcxhs@qpq4rafnts3z>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
 <20260506151540.1242997-3-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506151540.1242997-3-ioana.ciornei@nxp.com>
X-ClientProxiedBy: AM9P250CA0017.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::22) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|GV1PR04MB10153:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ef5780-9e1a-43d5-f5e2-08deacfeec43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hBmVPerFoAqSi+As0+ga5lgLNsUjwrAbuGo+GQ7mhSbgOZerdvP3DUOFLTcY7jRQatPEHZAq5F/QsWhEzg1ARLBtTBo4YPFne9zMSUkmRS+ZU9co8scB7N8xVGfyiBD0eCk81/YxlZIPyOAMtNfwrIG3JhzLr8CGFBkTlHNBr5ul0Ij8ttEoMb80u50L2JxSpq6Ugy/tin79O6hhsBKJZ4b1+MFpCeuWMvfPd3K2MJ82Gk+ypPSCPypseD6nJQ0Jb/3VssLSwnC0o9ro48EeBDsoTSsuuex8rAgqpw0a/Nw7gUAkk4OZAojMN+sFnAD2UBFIlyOKw1bc0XUPC8Y192dt6Tqj04kk3j1rl//FZQ2htd5Y4/y7o6j4/oJfnTtL7Irg8fwOvD4vHOkUrB/h8BfctZYpw6XBsUAGIQiiqzLePXs/EO0ySD2lWXcs1uuuSdnWbuPwRfQ3Y556jcaTH/ZLvac7SvHBLz0yacWvEf98gXzf9lvwSbi2yES1yPemepg71Bvktt7q3bcK29JA8IUiIiEkG+qSNNO2w4MM+xF1I2jJlaVyMlJaVl2N5R820XQ778IfM1JlH2ZpznPYapArROXbRy9ye/ThDLyQAW0fjxbgt69JFq27EYtl3AUHyGh4Sc7ON3iJ+fiZo5R1P8SJMUE4oYqHUF3YwB7Nmpj9IPIh0JKmU7/vtmRPXCDi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zyXyKZZeiiS1TGWvWUHlsII/aJqVoV72hg/Oqk4FEjIeoOtL3+F/yLeirB14?=
 =?us-ascii?Q?XAum8FpSOFTqzJ1cvqGDKRtfai+noA+l/AfcyUkqi9ufEW+EVP9robMBYojU?=
 =?us-ascii?Q?yIqXtfEibI7VRm29ZHi5SN1FoVGrR7/9DKFOxHo+wJV++7bVVqguTmVS9FyX?=
 =?us-ascii?Q?mIqmTdMDgsrtkOacGqC/92h1gjMFl+enQcsepV6jkWk6ZBj37+70R+USE+Ox?=
 =?us-ascii?Q?xaJW73WPd5fsjgbHgXlOlTbZnjlCa0Xzth+og9BJX5uVrfr9u1Umso3pdxfZ?=
 =?us-ascii?Q?Lg4HufX7VHEMJRag3X7vGpEDcIZHhbsemac1oiqXicnptkPazqdW4j52gQl1?=
 =?us-ascii?Q?VuVHDWSMIXBJozBbEpjoSilBJhOLGUftAGvyTY00DRRzHGGAAXqbCYDgUr1W?=
 =?us-ascii?Q?SAqwN4WtBEUGiMHdamiomb1rLWjKbAgW88/wZbc3n3T5y5tCaWuj+tS+j8+C?=
 =?us-ascii?Q?lkLr130WwWTZeK1D/UsIUYNmnZpohZj4GPcDi+IJOHLXbCR0q4Uhki3bSOkr?=
 =?us-ascii?Q?Ldp517cX4UvLJiYePLEcmcr+Oj+wfL755XOYK7komNRnY9l9k21Wyv0lZsIH?=
 =?us-ascii?Q?TzeMxkwhrhDf5JFnSTFCWKQf1Bnew2r13wor63PTMyI7rpdr7mkTSCU5zF5x?=
 =?us-ascii?Q?arrnbtYnrBYX3hOy0bkaJcUndGJtuM8J52IT5RDADqEgP/kilFUD7xe2xCE1?=
 =?us-ascii?Q?gqJKt+QKUskIx6kfYIrkB8GD1ZsHThMXlz15yOvQLr+pAQWrFkRMalbSPwBM?=
 =?us-ascii?Q?RGBqegynhiTjddpty2nybeUcWFag/h0N0enemNjER16/adEcSHmFMA7H5Lw7?=
 =?us-ascii?Q?nBmlBCtTjO/pR7yVoRUxwBUY8oRBPypCDiqIkYKuW60OLwwi314tG2ZnbJd9?=
 =?us-ascii?Q?7Mpf9jJmcdj1WFFIyQRAI7HEv76Byl9QhuCGmkBRoxJVKgLyCVi3rWvPGaA9?=
 =?us-ascii?Q?EreVquNW9dVnPTWSGlXnYc4WoHgJYWPPbVuNmS8ksH3bgV3hE9mKdPIomenD?=
 =?us-ascii?Q?wH4hRputuGmhZmgWDhZ0l15OogrTLxYjDJta127fsWDhqutI2ZQkgl/v1Oqf?=
 =?us-ascii?Q?ijB8jGUQc+jMu+bvfphTjNZH2IJDZijZbItxb3wHPC5ow9ZzoaUHpODyAnJy?=
 =?us-ascii?Q?2yCZ7v0ku1Fxl6KVScm5yitWbqJOyMXz4IwYNJLiVaxO5T84GxjYY5Ffg27c?=
 =?us-ascii?Q?PU+0/vwdBlOxpOCH/kA48FcjllciUsxt4lib/HlNmmlkjcdXWaUeVJpQhcv9?=
 =?us-ascii?Q?Nexm5UjPJHSxjKl9TXOcDt7jJ3Ew5jhLA48aSkKlmEPJyffLf96saVpl7ASd?=
 =?us-ascii?Q?e9An92dcBzUEeNL3coRAHk4FH+1ImmnpSsXWFwfxF8aTo8eVPH5T3VjvzmqW?=
 =?us-ascii?Q?qgZaHrS5SF/SCnEQ/mwpSgA26XGugOipbUQGaGYTAvk6NZuw73zN8T9op9Wf?=
 =?us-ascii?Q?Nw8g49XAJMBY89A4dNBFJMf83oHt1DOF+derA30iRrbdCB1YgPA4I245KqgI?=
 =?us-ascii?Q?qjy+11BwIQL1gPi+eUtiupDtQ8Up9/DvhYZw35n6jXeZr39u6comC3Y5VMta?=
 =?us-ascii?Q?uYmFtYvdSNzIWDD/C7L7aApuX/mRQCzzy6oCOqtIhUNoo4q/CSYcRswrBpY+?=
 =?us-ascii?Q?8llYxr21tV2qImfxBK6X+9P7/pnjbEY1wLqdaDKiddowp+rmlLgf+ekqeD19?=
 =?us-ascii?Q?/NDhcATFSzdGrh3dTHwWAL3hk0hzrs4IlepxReipKNBtR9wvRSSJPTL9yzZR?=
 =?us-ascii?Q?5EHHg5W/1Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ef5780-9e1a-43d5-f5e2-08deacfeec43
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 12:40:02.1104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRYfNMu/ZXacde4FqtpR4mqjl3SpwtYH/1mLerQWIYHxChvPnbPBjhnE0wGv/roU5RDABDvDhKJejeqBmymaww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10153
X-Rspamd-Queue-Id: DC3704F67B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_FROM(0.00)[bounces-285801-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 06:15:29PM +0300, Ioana Ciornei wrote:
> This patch adds the bulk of the changes needed in order to support
> offloading of an upper bond device.
> 
> First of all, handling of the NETDEV_CHANGEUPPER and
> NETDEV_PRECHANGEUPPER events is extended so that the driver is capable
> to handle joining or leaving an upper bond device.
> All the restrictions around the LAG offload support are added in the
> newly added dpaa2_switch_pre_lag_join() function.
> 
> The same events are extended to also detect if one of our upper bond
> devices changes its own upper device. In this case, on each lower device
> that is DPAA2 the corresponding dpaa2_switch_port_[pre]changeupper()
> function will be called. This will start the process of joining the same
> FDB as the one used by the bridge device.
> 
> Setting the 'offload_fwd_mark' field on the skbs is also extended to be
> setup not only when the port is under a bridge but also under a bond
> device that is offloaded.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 390 +++++++++++++++++-
>  .../ethernet/freescale/dpaa2/dpaa2-switch.h   |  14 +-
>  2 files changed, 402 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index 52c1cb9cb7e0..6367873401c0 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -51,6 +51,17 @@ dpaa2_switch_filter_block_get_unused(struct ethsw_core *ethsw)
>  	return NULL;
>  }

(...)

Sashiko notes:


	When a port joins a bond that is already attached to a bridge,
	this calls dpaa2_switch_port_bridge_join() which calls
	dpaa2_switch_port_set_fdb() again. Does this second call
	inadvertently find the bond's shared FDB on another port and
	mark it as unused (in_use = false)?

	Also, when a bonded port joins a bridge here, is it correct that
	dpaa2_switch_port_bridge_join() calls
	switchdev_bridge_port_offload() passing the physical port
	(netdev) as both brport_dev and dev? Switchdev relies on the
	bridge port state, which might fail if it is expecting the bond
	device itself as the logical bridge port.

The logic around the switchdev_bridge_port_offload() is amended in a
following patch named "dpaa2-switch: add
dpaa2_switch_port_to_bridge_port() helper".

The dpaa2_switch_port_set_fdb() function is also updated in a later
commit so that it takes into account a bond upper.

Will consider reordering the patches.

> +	if (err)
> +		goto err_bridge_join;
> +
> +	return err;
> +
> +err_bridge_join:
> +err_lag_cfg:
> +	port_priv->lag = NULL;
> +	dpaa2_switch_set_lag_cfg(bond_dev, lag_id, ethsw);
> +err_egress_flood:
> +	dpaa2_switch_port_set_fdb(port_priv, NULL);

Sashiko notes:

	If an error occurs and we jump to err_egress_flood, we revert
	the software FDB pointer. Should we also call
	dpsw_set_egress_flood() to revert the hardware state so the port
	isn't left physically stranded in the bond's flooding domain?



(...)

> +	/* Recreate the LAG configuration for the LAG group that we left */
> +	port_priv->lag = NULL;
> +	dpaa2_switch_set_lag_cfg(bond_dev, lag->id, ethsw);

Sashiko notes:

	If the bond was attached to a bridge, do we also need to clean
	up the switchdev bridge offload context here?
	dpaa2_switch_port_bond_join() calls
	dpaa2_switch_port_bridge_join() which allocates context via
	switchdev_bridge_port_offload(), but it does not look like there
	is a symmetric teardown here.

That is not true. The switchdev_bridge_port_unoffload() function is
called from dpaa2_switch_port_pre_bridge_leave().

> +
> +	return 0;
> +}
> +
>  static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
>  					    struct netdev_notifier_changeupper_info *info)
>  {
> @@ -2216,6 +2487,9 @@ static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
>  
>  		if (!info->linking)
>  			dpaa2_switch_port_pre_bridge_leave(netdev);
> +	} else if (netif_is_lag_master(upper_dev) && info->linking) {
> +		return dpaa2_switch_pre_lag_join(netdev, upper_dev,
> +						 info->upper_info, extack);

Sashiko notes:

	If a port joins a bond that is already enslaved to a bridge,
	does this bypass dpaa2_switch_prechangeupper_sanity_checks() for
	the indirect bridge? This might allow joining unsupported
	topologies like VLAN-unaware bridges.

Good point. Will fix this case by checking if the upper_devis also a
bridge port and in case it is, to call
dpaa2_switch_prechangeupper_sanity_checks() which verifies those
unsupported topologies.

	Also, looking at dpaa2_switch_port_set_fdb() and
	dpaa2_switch_prechangeupper_sanity_checks(), they iterate over
	the bridge's lowers using netdev_for_each_lower_dev(). Since
	this only yields direct lowers, will it skip ports under a LAG?
	This could cause standalone ports to miss LAG peer ports and
	allocate a separate FDB.


Another good point. The netdev_for_each_lower_dev() will have to be
converted to a netdev_walk_all_lower_dev() so that we check all lowers,
not just those immediately adjacent.

(...)

> +static int
> +dpaa2_switch_lag_changeupper(struct net_device *netdev,
> +			     struct netdev_notifier_changeupper_info *info)
> +{
> +	struct net_device *lower;
> +	struct list_head *iter;
> +	int err = 0;
> +
> +	if (!netif_is_lag_master(netdev))
> +		return 0;
> +
> +	netdev_for_each_lower_dev(netdev, lower, iter) {
> +		if (!dpaa2_switch_port_dev_check(lower))
> +			continue;
> +
> +		err = dpaa2_switch_port_changeupper(lower, info);

Sashiko notes:

	When a LAG device is removed from a bridge, this cascades to
	dpaa2_switch_port_bridge_leave() for each port. That function
	calls dpaa2_switch_port_set_fdb(port_priv, NULL) which allocates
	a standalone FDB.  Does this inadvertently break the bond in
	hardware by placing slave ports into isolated standalone FDBs?

This is yet another reason to reorder the patches so that
dpaa2_switch_port_set_fdb() is updated before this patch.

> +		if (err)
> +			return err;


Sashiko notes:

	If info->linking is false (a teardown operation) and this
	returns immediately on the first error, could this permanently
	strand the remaining unprocessed ports in the hardware bridge
	configuration? The network stack cannot revert an unlinking
	operatione

Even if we would continue with the other ports the state of the entire
topology will be inconsistent so I don't know if it's worth going
forward will the remaining ports.


