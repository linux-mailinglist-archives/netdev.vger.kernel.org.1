Return-Path: <netdev+bounces-285858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBrZF9/u/WlJkwAAu9opvQ
	(envelope-from <netdev+bounces-285858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:10:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B579F4F7940
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A278300E250
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C023DF002;
	Fri,  8 May 2026 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mEEPspf2"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013019.outbound.protection.outlook.com [40.107.159.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88D41397;
	Fri,  8 May 2026 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778249436; cv=fail; b=lYE8QwmUdJYogN6q9Qs5a3oj8g0Wl+Hap+sO3N+i+yDV64/MR6PUKmtJelrWGPUHHcpfKDktWdBl+qHNU643N4zfJilc8UR6LxoB5nnTl1UKTxX6jzRRPzivz34qArVghm31ckou3cM4TDETwXmM/lmWBGMoo8/4COvePSbS4xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778249436; c=relaxed/simple;
	bh=CCAKOKzrlXZVE7YKen9SD3uzbXaoSyxLQHxF0n/Cl08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g0arSPzo2OuuztlTLtcb5ZWoQlzXnQ6thvmky1Yp+4aGOkTIPbbq+K7uWeUH5SsFPOY7rNcJbXRDKdBmmKkDAgKwA++BDIxNlPqDxepwOsPJSF6opYveJpM6EsDe1gTutmU2x7Y3WmBj94X+APNtL6nmR5qrqTSgLAXOjYf+hyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mEEPspf2; arc=fail smtp.client-ip=40.107.159.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeSjmOjDcIuA2rDdLYgBMh1R2a92m6p7nkfYS6wiUvv24LhWuh/THrh5P5DRAAbVe8UkSWqebqAaHKNYcLBiSzpBf1prrKBsSHTOqq1OMmnER70ZmXMKntCW7N7gJgXHg7NrmsGeu0q4e31OX5W7arj4Y5x0/N4IT4VJ4QVbBFq9fLoTllF0RziheObW/ZmqbIk53R++C+hAWLZ2VIFsMLbrYD9VT7j3boE3XDnasjnAKgBxHGuZ2dbPLsMJ0aU04Pkw37L9Qo+KTHzLZ6hoUbL0faq1s6ojswVccAS6LEG/2YYdBtBceqnFaeVWojVwKszt+89BxZVzE9Dd7zUejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvjKmTovJIl9DduV5d7Cey4OdRpblLVj9PFW9vZtDms=;
 b=BBEmYkQoU5/E7flop10Q//Su9AnH57BER9c4jDxHGZAz6+7vnrJtG7/eC9/p6Ub0TmIto8t6x7nm8L2seJWdzWmd3vL0FcXGbJ6b1sc3Kbu17Lf/TQ81xaovshX6gUdYsgrqOyqAvgcsX8MTkh2BB5EyxuaZJlglzsWSGo+qBUXto5rbPTvExGUykr2AWGBF6byOV0hxlKUkTZGM6MVIj+JWbL71Z74QWEPp3saNGGryxinOHd3vTPK6ZWK211FNoyEdbPlCDYsVoutVct8L8Pritn7C2DTNMOvEqcVL/WoVysSyBBV8zKPH9E/28eW9TR1+d3As+t8fNfa8QmFCGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvjKmTovJIl9DduV5d7Cey4OdRpblLVj9PFW9vZtDms=;
 b=mEEPspf2mc0v2pTnvf+uOysH56uXzqSHt4fpxNTv4FwMKwco75mneltbmOWPxITHU0ksN4RtTSvba0eu0/um+2pGYJR/a2Rp7jaKO2EjveN0n/C1Gcmt9ytdmCGQiTIeu2e1t0AS27+I4JSJNPMzUUdD3HqWsuQu4K+IOtnea8zvX52TQ1nQph2YT+aX6dIa0IvdFzeq38NKdK7PffEthwl7eo4AsYzME+iz059lmDAy7Mf1DJ3zdUfD39OGhf+eLP2Cx7iEn30UYvmMB2f6J3A+OAKQcw4cSbTNeZU8fg/+01IS8WYMU+GhjU6EMKLXcCokpP0FtQiUM3aY2KGvnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by PAXPR04MB8861.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 8 May
 2026 14:10:31 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 14:10:31 +0000
Date: Fri, 8 May 2026 17:10:27 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 05/13] dpaa2-switch: add
 dpaa2_switch_port_to_bridge_port() helpe
Message-ID: <4qbqkauqmvm5s55xlce5ax6ltgecvmg6plylwqgfkwqu5qvweh@5muxo7k7jsfw>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
 <20260506151540.1242997-6-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506151540.1242997-6-ioana.ciornei@nxp.com>
X-ClientProxiedBy: FR4P281CA0417.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::8) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|PAXPR04MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: 6209171d-dbcc-4206-9419-08dead0b904a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|56012099003|22082099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	UXP2oYRZ0ixEgRQJpXmo7cgcsV6Hi1Y8W/95BtxMjOUfTfgt61RdZ3NiTShFhgXEPkM0UNnwnn5KZK1aSrXXjHNKpuIgnJDg9KN8dqYWY+2t9C1mHx1w50ocAhxVK3vVlQZWaWuYUc2xkNrUWFhtf9+rhhK5JTBv2KFsAVlqGyoEW9YSzPaJE0fdgIEVurceQBCiXD+HFN9FRf3fh3x4lGcnk3pZiQBbPEb8gCCe2M88VbIOe1I0vjHJo1KUyWIE/eEisZJ39++lDJ+mGGBGIBPxYtD74fvBAuO7ysquopP5y80RW34ejwEEVe7fbVrK1Rn5toIYag4x10X3coga/+JRshmzdP0q1vZCfMHHBpXHpnrZ2SUZ3VAeGJffwXGOp23n7gRUrOLgToN8KbJ/RKtNPenqttxPaUCwfrEuklsytuU86ZNw8Q+do+hNNuBGMFsWYi+EcfReOBLKB6PjRiVkftUsem35kCBtcEpQ77q3hePCmS92nrcyjyK9Kr+3mjbmWxEdanY1M3YAStytItriYHeGudXyak3HsAwTq3UpikgBQi9voLiV5UTg3oDBW3rTwaLfJNNhOLgE0fbwRfwVOdfbYrmK74U6BKk8YFi+vnb/CJufmDABiE/zskGij0ISpqFBGhyrVDIn9jI40GOecxNdkS9NagLMkqL6vZY02dajL0TZT3EHXU6miUSm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?drGGDdIFo8I0AayCKZysvpL3C3NPMr6RVc2ZyuRJDYpKYlxWhFuKbR1p6ZHe?=
 =?us-ascii?Q?xE0ze+ek877RCavqsKRFLrXG8BfXCyFGtSstBIpUKcdT+bA9eb8vNay6xDUs?=
 =?us-ascii?Q?QgSjp/TdTWrrsy2Ie8t/UCs9WGRwGu5eKV1SPkQnzuv39dARuM3XNrlsgRW+?=
 =?us-ascii?Q?HlFHcXfKM5xFlnA375Cc+gE+V5TZh1PzhFthsxUHGZEDuZaPlzM4coKwU5ZB?=
 =?us-ascii?Q?vdSuP5eMnvCLZSjA4zR+ZgyiKkbqyhcsL9mvR5z8oK81KeQZns9IuFFDhwLW?=
 =?us-ascii?Q?1o9NaU2Mj4VlHYCBbi0tReFT0jhuXp7H6KoxrKXYb9D6LyyL2jha5VqGjNwm?=
 =?us-ascii?Q?DX4mKA5pLO9PfqkqELqVq/UnL7JSssHY01suUBl6TFdi4HkawS2UWMrn3y3F?=
 =?us-ascii?Q?A3DIbt840D7LPsEpywVYThoJeCxdI2gomveUsyJiRW1iC8DjwdhBis05SqD+?=
 =?us-ascii?Q?k/hRQNG/B3m0BdGBbw0XD9aqKA3BOAD7gOuYrZA0FQdroiyX7LHb7RmQ/GCK?=
 =?us-ascii?Q?VbWvY1fzufZ8xyg/aC+yi75M/0rk1zgjBbEATFOe9UjdGIcsvjJ9Kl/fa5Ls?=
 =?us-ascii?Q?45Tro6tP2p4R6ppaXQJYdhqqtHedcexOq0P1s9e5urr/VuqA+aYR0X6qTzoH?=
 =?us-ascii?Q?0TJNSNzTZFri01V0pKd4odPPPiKvHl0M0BCod/3d/0SvbG0RdSXr/yJucJHP?=
 =?us-ascii?Q?771H9EXbO25QQbolwjiM4igo9efW7Pe9urp5dBTkq+ignrDnpA/z2xiC5uEw?=
 =?us-ascii?Q?2k7U5iBQV3/RqPY6voOEt6gKCYPdaUK5z6J8aXAOKa/ga2LxdA6o6nVXSUVf?=
 =?us-ascii?Q?Lk2+o4Jm7xd+butr5ZQ/nO1jSDqAWUHPBAariqN27c8JR1aMgmw7DTlHGGDA?=
 =?us-ascii?Q?8BVT0BCcBZ2SNpmhoMe4DY+QSorCEXZNU6MyPC1XuSsP9H+Qt8RyWYXjsPHU?=
 =?us-ascii?Q?2s3mjwhrd+ktGywDLuQzMDkSOLeklplSJDe2dnMxD5tWN51Iv5EwxXPhlYQr?=
 =?us-ascii?Q?tMOExSOGMeG7xY/QQZ/hD4PrpkEie6uZa9nkkDyjeqvUIxAOZLDM99xdoyr7?=
 =?us-ascii?Q?mJfkWz1JKe2Fol/lMaXnA9Oe0Ig3Z/3p59elFv/53ySjB6kb7o1RMGdlQGkk?=
 =?us-ascii?Q?AJd/Tz9Bx5DCMt+3ob+EKW06Z4Ya6N0BeP5vrpgNFFPSfGbB/V9/ypoEU/VE?=
 =?us-ascii?Q?CkeSMLO37kx5WjLqd4hsqU5UHQi4LMeCWRCVvuudoFCyruglygM4AqIAM5Fd?=
 =?us-ascii?Q?gFjmLCGLieRCX3908p2xgYtZrPLgRFIVFZfzcTYqwcPtfg6o53EwABUqGtZM?=
 =?us-ascii?Q?bn3lXs/FASHZdgEKtFQ+2SfD3w+3uKzfueRdjRQBO+xtluiz/heYgqAGc9fA?=
 =?us-ascii?Q?VizrK3kh0R5ENGN5e1ni/FhRNu0qN74LaXtRZPtZEjtFH02JWtiCkAnDoX2Y?=
 =?us-ascii?Q?d6QRwDHmhRlRYoHyh2NReKEyk3u4doZ0xLaYJwDPgvKzPSNs7xhBY5DQ9Ec4?=
 =?us-ascii?Q?/22KbvtegkHVsM+NRUIUfxoPXWl6G9Zu9ZWLyNq52ucdYqtmhHKk2StZQwyx?=
 =?us-ascii?Q?geiunrOsmcMOyB9CoqS9EMP4+DD5fAn2X5E7LKzXyspG1n3/iIYIAcQyy+qL?=
 =?us-ascii?Q?zkM5AsYYKb8qVu/ZQZ1usEQ4WDKa7FqaStKTMf7WV+yk/kOingiPw9G+oNdu?=
 =?us-ascii?Q?Ksco14+n2OGwOLh7QLAhu2AfsCKrJM5aTmEq/YTdc//YHGsgbQp8P3xAVt3Y?=
 =?us-ascii?Q?Eq7Td/PAow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6209171d-dbcc-4206-9419-08dead0b904a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 14:10:31.1972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49fo7qEeD2QY9HtEinS3iuNwAZfk4+vDcIlza7XhhLuqVI4SqLUwI8jIVhOXu0pHA2nZM9M2f/8NGNhBKH+TQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8861
X-Rspamd-Queue-Id: B579F4F7940
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_FROM(0.00)[bounces-285858-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 06:15:32PM +0300, Ioana Ciornei wrote:
> With the addition of offloading support for upper bond devices we have
> to let the switchdev framework know if a specific bridge port is
> offloaded or not, even if that port is bond device.
> 
> For this to happen, create the dpaa2_switch_port_to_bridge_port function
> which will determine the bridge port corresponding to a particulat DPAA2
> switch interface and use it in the switchdev_bridge_port_offload call.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 26 ++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index 9d3a0aef1568..aaa22dc15038 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -2076,6 +2076,18 @@ static int dpaa2_switch_port_attr_set_event(struct net_device *netdev,
>  	return notifier_from_errno(err);
>  }
>  
> +static struct net_device *
> +dpaa2_switch_port_to_bridge_port(struct ethsw_port_priv *port_priv)
> +{
> +	if (!port_priv->fdb->bridge_dev)
> +		return NULL;
> +
> +	if (port_priv->lag)
> +		return port_priv->lag->bond_dev;
> +
> +	return port_priv->netdev;
> +}
> +
>  static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
>  					 struct net_device *upper_dev,
>  					 struct netlink_ext_ack *extack)
> @@ -2083,6 +2095,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
>  	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
>  	struct dpaa2_switch_fdb *old_fdb = port_priv->fdb;
>  	struct ethsw_core *ethsw = port_priv->ethsw_data;
> +	struct net_device *brport_dev;
>  	bool learn_ena;
>  	int err;
>  
> @@ -2094,7 +2107,8 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
>  	dpaa2_switch_port_set_fdb(port_priv, upper_dev, true);
>  
>  	/* Inherit the initial bridge port learning state */
> -	learn_ena = br_port_flag_is_set(netdev, BR_LEARNING);
> +	brport_dev = dpaa2_switch_port_to_bridge_port(port_priv);
> +	learn_ena = br_port_flag_is_set(brport_dev, BR_LEARNING);
>  	err = dpaa2_switch_port_set_learning(port_priv, learn_ena);
>  	port_priv->learn_ena = learn_ena;

Sashiko notes:

	Does this code ignore the return value of
	dpaa2_switch_port_set_learning()?  If the firmware command
	fails, the driver will silently ignore it.

	This could leave the port's hardware state desynchronized from
	the kernel's tracking state (port_priv->learn_ena), which could
	lead to forwarding anomalies.

True, but the code was there before this patch set. I am leaning towards
not fixing it in this set since we are already at 13 patches.

>  
> @@ -2108,7 +2122,8 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
>  	if (err)
>  		goto err_egress_flood;
>  
> -	err = switchdev_bridge_port_offload(netdev, netdev, NULL,
> +	brport_dev = dpaa2_switch_port_to_bridge_port(port_priv);
> +	err = switchdev_bridge_port_offload(brport_dev, netdev, NULL,
>  					    NULL, NULL, false, extack);
>  	if (err)
>  		goto err_switchdev_offload;

Sashiko notes:

	Are we missing a rollback of the port state in the
	err_switchdev_offload error path?

The same response as above.

> @@ -2143,7 +2158,12 @@ static int dpaa2_switch_port_restore_rxvlan(struct net_device *vdev, int vid, vo
>  
>  static void dpaa2_switch_port_pre_bridge_leave(struct net_device *netdev)
>  {
> -	switchdev_bridge_port_unoffload(netdev, NULL, NULL, NULL);
> +	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
> +	struct net_device *brport_dev;
> +
> +	brport_dev = dpaa2_switch_port_to_bridge_port(port_priv);
> +
> +	switchdev_bridge_port_unoffload(brport_dev, NULL, NULL, NULL);

Sashiko notes:

	Is there a missing switchdev unoffload when a port leaves a bond
	device that is part of a bridge?

	When a port joins a bond that is part of a bridge,
	dpaa2_switch_port_bond_join() calls
	dpaa2_switch_port_bridge_join(), incrementing the bridge's
	offload_count for the bond device.

	When the port is later removed from the bond,
	NETDEV_PRECHANGEUPPER is triggered with !info->linking where
	upper_dev is the LAG. However,
	dpaa2_switch_port_prechangeupper() only handles the
	info->linking case, explicitly ignoring the !info->linking case.

	Thus, dpaa2_switch_port_pre_bridge_leave() is skipped.
	Subsequently, dpaa2_switch_port_bond_leave() resets the port to
	standalone mode in hardware but never calls
	switchdev_bridge_port_unoffload() or
	dpaa2_switch_port_bridge_leave().

	Can this completely bypass the software teardown path,
	permanently leaking the offload_count reference for the bridge
	port and corrupting the switchdev offload state?

Yes, I forgot to also call dpaa2_switch_port_bridge_leave() when leaving
a bond which is a bridge port. Will fix it in the commit managing the
changeupper events, not in this patch.

