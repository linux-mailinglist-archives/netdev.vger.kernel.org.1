Return-Path: <netdev+bounces-273301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMkfJDnKyml3AAYAu9opvQ
	(envelope-from <netdev+bounces-273301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:08:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 522D43602F6
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17E8930451DD
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F38395268;
	Mon, 30 Mar 2026 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bP620wtg"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E17374180;
	Mon, 30 Mar 2026 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774897493; cv=fail; b=Gt3GLfgNJr9uNxesbXF4Zmp9ZWlE7gYGqaXblojmrMMHq7ql3Kgc1/UcnWlbyChcktSVFynYZjWSmQwjNyrcRmXXqfIt1n6WsQXP02cjUam8m6FPTGzSDk8w2JWj0G4RG+u5sxQzqYkAFSqw4N2NRm+w+9u9wWo/IVen8UGxINY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774897493; c=relaxed/simple;
	bh=3LG51vec5/VsvUvnG8zIm0LnvMQih446eT81giz+R7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Js/wZtau4RGc0Rn9ccxru6b6W7/t7QyVhqj+GO1O5ZZFLLeLnVVt3xnpQvhk8KViHz7Np5MIF05oqh7EeeLajD0NMugFuEVR5pAwRZVlF5aBs5lxhcZDMNI35FYRgMXFhAKro3h9vCZUNojAAnVyFXmstmj0pXPoIakLXyYjvKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bP620wtg; arc=fail smtp.client-ip=52.101.84.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgMeT3+5KaSWW6DpZyeltWSmMh5WLHdKOv91u76bEWEUAwiZBJ83KYn+14Gf4iZKE+cySK4vyxlxAD/1EEXO5mp0X6EZEhVPytAM8ZR5IxxDJMVXUqm3Nw+cJU3RgKBc78nBIiKO6RaRE7L7VFA4UT7W6rx710uVKHrK+98QubzUrEkIBsVDR5Qsit8rGWqVwVy3JxeqxFoqoELWEbkmJWBfpFd89uQITrV9oz9YjttJBaiwvqCzcIrLG8oHmLChH/lGSYhVyZyIZDNiQdDZPz0v1Y70c2oRE7SrZuyQYzHCw1OxkUJXDIZ54RUCZNT0UdhD+sg1qpnNAmfhi8RDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlLl8aCcjTj4IJadLBfqKEo65s+vGmy+tNjnLTLSfXI=;
 b=TSFgtur8juE7BHX+zGzwddKNiWrA1BeMSU/azJnlMi7RMJewOlY9uzYqq8CeHkv1+H+VuvIZQTUQ++PJoyP00Zp777CHo48G7+//ef7yQckMbVDYwSvoIO9CPZfecZH3JpET6cfJydXJ6ziyI2tE8xVe7KxCIlpqh3uqB+b60HbdgLody3sQx73SrECIoKoQPzzeWIv+tjWQ7xUQ54xdB9bOP88fZdAQsMiNMxywWXqdlfTl31WIGmLMJ5d945xlNowdHUjaMz0KgNfSim0FpOKh7tBKj3X1qltwJWva9TLDD+RIX2JG12jag57+19EBGiRCsizSJ8nYXI4XZLrwpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlLl8aCcjTj4IJadLBfqKEo65s+vGmy+tNjnLTLSfXI=;
 b=bP620wtgZgrQFYOe3VrZ/9z0knFhw63jZVCUj+zSr5YUpsHQeMpcd2xVicoNO8Ng8Zq3cWmIkgSxZY1Ct+XrQBHFs4KzLYeajK5vAUqIx9qevYnEqdL8xDyXAkBcYErq2+FdeXZRxljeUT51faiiHLCOm2Qaya3yTB0eBEawvP+UQHpvQrjD6uW0k7yn2V6zVTswc180grTWSFEfe4g4/smw08iVvxOk9wrLfwdzbOlfsZAnbJny92xBlurHYJbi07RvY/VsNSOLQk4j8557GcuT17rWqgnczsibj1WWQm/lwro5dhTGlTapNPXKQguiErcKzoRyn6ac8OF1XKjc4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA4PR04MB8045.eurprd04.prod.outlook.com (2603:10a6:102:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 19:04:48 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 19:04:48 +0000
Date: Mon, 30 Mar 2026 22:04:43 +0300
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
Message-ID: <20260330190443.bol5vjfqqitz7kuo@skbuf>
References: <20260119091220.1493761-1-vladimir.oltean@nxp.com>
 <20260119091220.1493761-6-vladimir.oltean@nxp.com>
 <e0ad52862d34cf4e0169c9850a7f164f127d0093@linux.dev>
 <20260326215404.krh6v3mmnqdlndli@skbuf>
 <d9639ac711ff8f1186a684fa120ba77247669051@linux.dev>
Content-Type: multipart/mixed; boundary="gg3xcc6lsi5dh453"
Content-Disposition: inline
In-Reply-To: <d9639ac711ff8f1186a684fa120ba77247669051@linux.dev>
X-ClientProxiedBy: WA0P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::22) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PA4PR04MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f64a31-21d4-4ac5-a917-08de8e8f365d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|6049299003|376014|7416014|10070799003|19092799006|366016|4053099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ndbagg7ZXLocAh8wTENgKTYah82HKh2RNuCTQ6MdeeNwLByCMKyqlzpjMnjWaCVbvLy+DMCSi6aikGVdNKfL22WGNVwmy44O1pIZiqvQdOSwJa5tCXb3VjvJpRmW9hVGKBcCq0zYNedfl0IgBG/g4PDPGg4DAnluXlrq735cMjpGAtby0ybIEhXgATjO1k106wlDhOAhH6gRDPd98l4WrJsMBh9pRj9Q4m7AT2AtIhgA6NcfEKu8O4K25midxKXZVz6OjGJXIN45l4DZLT6XAue/0D4KjF7DvbB4pnQO59zi16LlPRjojUUAUswG/j6C1REXOy1F9B49UIM2fHLNxEsbFNcvUmqSiCAb6tORuOLy3JK/MVc1+JriO6ftUI9dKtKaRkAbAiza8svYVwrKjhNlpaukq5Rlutl51zfRstRu9LWcwMv4CPaZYfNGHXRujKLJfqaYHYwcOcWrf/fulmXur7glI2OeLn+OkjjWDI5vTYdQIH8Ouko5v0+UiWQKBxFUrFA6Euw5XzNaTC6jGuEucfCjPbsUs3RZBgKsFq71fRzbU1krzczj55rI0h1NauIjSWxuaVO/Xyb/PFftD6WhzDWGBIJeGgVoKdsKhrX+0OP+AwDQsC3GD6Rw4UI1r69HeC9uwzulVpb40oTsIBSh+v4m7wOqOiFjYWJKg9EOyBQSSBrsnZDe+YFWq6W9fiLAn6PJGYs2wWcmV6flrIEC3DXHr+n5a8R1TWdbRUw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(6049299003)(376014)(7416014)(10070799003)(19092799006)(366016)(4053099003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zh47gwAZU7ukBaCEtBCeurr7qHrNETgBLJEr9CPKx9PDzEcou90y6o8ZIPq+?=
 =?us-ascii?Q?7Sqsovg53cN3ugnAsv8bH5xCW/bf1axpKj9TT4HDitmrt6NcrH/OEg2Snm78?=
 =?us-ascii?Q?6z04psYMzVQ4Jh05WCxHOjMCdPjpNCHmJ6B119HcjH1/Fa/ZW6Cm/yQwsMn6?=
 =?us-ascii?Q?P+CJmYDnx+iFi61TCm6dCWaXY2CuipNvu+iofAeFfZMGSux1oCXNoEeABj1/?=
 =?us-ascii?Q?UnHQ06tOirHQEnmU0STlXpFEietqFCD4YDUqrA3nGgL7BjKdMDgtvkLAxX4S?=
 =?us-ascii?Q?/pD+Swzd2RwrBloN+bJYm05ZIFOM+HHHRoCh9LKKcgc4PWH/zFVngsA7Lnio?=
 =?us-ascii?Q?lXiXPItrkLwvOV+3ikDrWFbyATKfP5UCWwyqnAeatIiL3aa9KMgzdjctIISy?=
 =?us-ascii?Q?yzi5k9uhJbBk9LxLDAqUS46bl5ATbDrnNhzm4engVtJya3pmdzYomboTppQJ?=
 =?us-ascii?Q?0NuOzqbn9FgKQsd4+f2y+vR67EtsdyU//LHV3QxCU0i9TrA1Q0tn3nBccaQC?=
 =?us-ascii?Q?IrLYus7a2xZraIqR3v5iCppCIsBV8EgXc3PCtrh+ansO8/rVBA1MDuZZdgUp?=
 =?us-ascii?Q?qAGJlS74+N1mR5irN+PxzA99kXt0XnhOA65q8qTNym3IM26RdisWHPo0Ccy8?=
 =?us-ascii?Q?u6DRNBiJkX3t2+Ohsj0gczG5lz4W1ZMmyCywO3YR3O5Uz+2aXIgyr2/QOR7A?=
 =?us-ascii?Q?LFNJrQ/0l4UA/1K4hd2ynEXFYz/+ghe59Yp9pUo8P1fQojRGBf4+X41ZZB7n?=
 =?us-ascii?Q?w6f4bdyl6ql7EVZdHQhfW+r6FkJk9fm9mQlSin8u+geplc+kgKHErNeCbHKb?=
 =?us-ascii?Q?4I0MTUZo11B1ud72uFxF0QvunTm3kVXCgpLxNv5K15K/n/5Sp/5gF3DDqrxh?=
 =?us-ascii?Q?WjMziEYc6GgGDN0Mpdzef6nlNZxpksF9roQeCLCro4fOr7TKJoXUou3PobnB?=
 =?us-ascii?Q?Qah8QE/Hd3RmdDds1Nj4e7gCvlkCqrgdGlpuxMmi/h5A+peL8RA+N5y3BWBW?=
 =?us-ascii?Q?zmnTVVCAwPpRBW4glmFqReswErnJDsP5HB6MIZD2hAA5xddorsYU6CGlN+XB?=
 =?us-ascii?Q?HPWLBgUQg1VPvl46mHwUS6glZ3l4CzK6w7b+oXd7glQUtwRu0NNZFAWJhBRA?=
 =?us-ascii?Q?QW9Td+4PJFdkJUz2lLvrGTHhXWxZ6bf+1aHkhOpo4w5AWqQxxWWTKfZfIIMi?=
 =?us-ascii?Q?G77DBLvbF9XE9C93CrVmaQAC3AtvwA95xbhACdXELKl3WAJs1zt8tX2d3sTu?=
 =?us-ascii?Q?oKV1nuzGR+wPO+9yGBCofQ2txeKBO2cUBFOlZibtSuk45UpbojC3nzNQHF7n?=
 =?us-ascii?Q?2T4hL8t7B6LfqC60G37kG/xX+whj2Hfy5AZ+HLYrdYrw/uhnOcrXCZOCpGqW?=
 =?us-ascii?Q?4YsXAIymesX5HgeqMTo90+Da8zIVC2VOy9lyRNeXakW/m8C8KVJIpa3yN/Wg?=
 =?us-ascii?Q?YQYox8/Vh9486+sgna+/qZ2NurwX18SI8etwgSF9qgDvdbUOSHh+iWjSZQ+7?=
 =?us-ascii?Q?V+QMoZ++d0W4lP8JA6EcmMOrbopuZu8dd4zfkerxUe6LquHw+KUAa04Nzidh?=
 =?us-ascii?Q?4Y3bmx8j+bqOsAjOlVGXFkn8NLfaMkS6Gxvvh3m+sux43WtSBNgR/oxQj/Xd?=
 =?us-ascii?Q?mu4o8CR2ZJojyDt+lH+vJTZf7OIRaOHz502x//jxW3CeEDyv8seHNQ5fhvEs?=
 =?us-ascii?Q?F5XAl9+jhrjiLxtWGAQiSL7c/9B2QtNp3O1tKEZbmfY8wxQKs8tGYCm3KrrX?=
 =?us-ascii?Q?P74lqRb2TeSVpIlMdZTFzQNgKkl+SXPddS+H8VaKyPPZQxiPidvBQcSt8Vge?=
X-MS-Exchange-AntiSpam-MessageData-1: 7fdTPaGC+bsE0q3/Ff3G2SPFM2UZZyBKT3o=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f64a31-21d4-4ac5-a917-08de8e8f365d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 19:04:47.9317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58G2ri9SVW4go7eVKOSEJHVgs1ReYPFGoaLjQmpefyXcqxjpvy1R4B1Jy9eA9ZO7TM2NESaKCsah8FRp0fOxRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8045
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273301-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,makrotopia.org,microchip.com,mork.no,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,fe80.eu,arinc9.com,mediatek.com,nbd.name];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bpi-r3:email]
X-Rspamd-Queue-Id: 522D43602F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--gg3xcc6lsi5dh453
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Frank,

On Mon, Mar 30, 2026 at 05:52:17PM +0000, Frank Wunderlich wrote:
> Hi Vladimir
> 
> Thanks for the patch and sorry for my delay...i was away this weekend so i was not able to test.
> 
> traffic works again (but there is only read now) and this is the result of your debug prints:
> 
> root@bpi-r3:~# dmesg | grep SGMSYS_QPHY_WRAP_CTRL
> [    2.706963] SGMSYS_QPHY_WRAP_CTRL = 0x501, intending to write 0x500
> [    9.134081] SGMSYS_QPHY_WRAP_CTRL = 0x500, intending to write 0x500
> 
> R3/mt7986 has 2 MAC, and switch is on the first, so value will change, not sure why this is different.
> 
> i have not found SGMSYS_QPHY_WRAP_CTRL or something related with polarity in ethernet/mac-
> (drivers/net/ethernet/mediatek/mtk_eth_soc.c) or switch-driver (drivers/net/dsa/mt7530{,-mdio}.c)
> in case they manipulate this register too (of course they should not). Also looked into the pcs-handling
> in both drivers, but see nothing related to polarity. And looked for possible duplicate register const
> definition (other name for 0xec).

This result means that your default QPHY_WRAP_CTRL register value has
the SGMII_PN_SWAP_TX bit set. Whether that comes from U-Boot or hardware
default or otherwise, it doesn't really matter. Curious that the
SGMII_SW_RESET doesn't clear TX inversion, though. I guess you wouldn't
have documentation that would suggest this setting is sticky?

In Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml,
it is not specified what happens when the "mediatek,pnswap" property is
missing. I thought the most logical thing would be for the lane
polarities to not be swapped - because how would you describe normal
lane polarities otherwise? My bad for thinking the original vendor
bindings were more sane than they were.

The only way to describe the polarities that this SGMSYS block needs on
a particular board is to use the newly introduced 'rx-polarity =
<PHY_POL_NORMAL>' and 'tx-polarity = <PHY_POL_INVERT>'. Which I strongly
recommend you to do, even if the attached patch should restore
functionality with your current device tree.

--gg3xcc6lsi5dh453
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-pcs-pcs-mtk-lynxi-preserve-lane-polarities-when-.patch"

From 6b5fe06ec16e8a1e752fc871c135d2f12a37ce33 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 26 Mar 2026 23:46:46 +0200
Subject: [PATCH] net: pcs: pcs-mtk-lynxi: preserve lane polarities when not
 described in fwnode

Frank Wunderlich reports that the BPI-R3 board has a default
SGMSYS_QPHY_WRAP_CTRL = 0x501, aka TX inverted and RX not inverted.
At the same time, neither rx-polarity/tx-polarity nor mediatek,pnswap
are present in the device tree.

The original driver logic was to enable both TX inversion and RX
inversion when finding mediatek,pnswap in the device tree, and leave
SGMSYS_QPHY_WRAP_CTRL to its default value otherwise.

The blamed commit has broken that by assuming that a missing
mediatek,pnswap would mean non-inverting polarity.

Restore the original behaviour by reading the SGMSYS_QPHY_WRAP_CTRL
value and using it as a default polarity if mediatek,pnswap and the new
rx-polarity/tx-polarity are all unset.

Fixes: 8871389da151 ("net: pcs: pcs-mtk-lynxi: deprecate "mediatek,pnswap"")
Reported-by: Frank Wunderlich <frank.wunderlich@linux.dev>
Closes: https://lore.kernel.org/netdev/e0ad52862d34cf4e0169c9850a7f164f127d0093@linux.dev/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/pcs/pcs-mtk-lynxi.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index c12f8087af9b..7518c98fa98a 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -126,11 +126,24 @@ static int mtk_pcs_config_polarity(struct mtk_pcs_lynxi *mpcs,
 {
 	struct fwnode_handle *fwnode = mpcs->fwnode, *pcs_fwnode;
 	unsigned int pol, default_pol = PHY_POL_NORMAL;
-	unsigned int val = 0;
+	unsigned int val = 0, orig;
+	bool has_legacy_prop;
 	int ret;
 
-	if (fwnode_property_read_bool(fwnode, "mediatek,pnswap"))
+	ret = regmap_read(mpcs->regmap, SGMSYS_QPHY_WRAP_CTRL, &orig);
+	if (ret)
+		return ret;
+
+	/* RX polarity:
+	 * - if standard 'rx-polarity' exists in 'pcs' subnode, follow that
+	 * - if 'mediatek,pnswap' is set, invert RX polarity
+	 * - otherwise, leave unchanged
+	 */
+	has_legacy_prop = fwnode_property_read_bool(fwnode, "mediatek,pnswap");
+	if (has_legacy_prop || FIELD_GET(SGMII_PN_SWAP_RX, orig))
 		default_pol = PHY_POL_INVERT;
+	else
+		default_pol = PHY_POL_NORMAL;
 
 	pcs_fwnode = fwnode_get_named_child_node(fwnode, "pcs");
 
@@ -144,6 +157,16 @@ static int mtk_pcs_config_polarity(struct mtk_pcs_lynxi *mpcs,
 	if (pol == PHY_POL_INVERT)
 		val |= SGMII_PN_SWAP_RX;
 
+	/* And TX polarity:
+	 * - if standard 'tx-polarity' exists in 'pcs' subnode, follow that
+	 * - if 'mediatek,pnswap' is set, invert TX polarity
+	 * - otherwise, leave unchanged
+	 */
+	if (has_legacy_prop || FIELD_GET(SGMII_PN_SWAP_TX, orig))
+		default_pol = PHY_POL_INVERT;
+	else
+		default_pol = PHY_POL_NORMAL;
+
 	ret = phy_get_tx_polarity(pcs_fwnode, phy_modes(interface),
 				  BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
 				  default_pol, &pol);
-- 
2.43.0


--gg3xcc6lsi5dh453--

