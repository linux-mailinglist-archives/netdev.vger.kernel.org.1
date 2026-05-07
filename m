Return-Path: <netdev+bounces-285282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFmTBh57/GkwQgAAu9opvQ
	(envelope-from <netdev+bounces-285282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:44:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8CF4E7A73
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52AB3301983B
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1D43DCD88;
	Thu,  7 May 2026 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GEg7wxS3"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010008.outbound.protection.outlook.com [52.101.69.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF6A3176FD;
	Thu,  7 May 2026 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154154; cv=fail; b=sBTGVEpBM2MeKqLyLoiPzY41i0xblXMCCzZIasZ/e29pJhvm1k7qQp8pfn6VA5ll0NblOCyvEkaLDK/RXPbnDc6jt0X3ZvOrW+vT2kyU6nfA+xC5NahB2CjpZb3mVx8OTJlDFatDdj234sPWehbE62fHihEps8HZu+GVNMO1RgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154154; c=relaxed/simple;
	bh=MvTkW1bPUTSr5Uay+MYB9NkPTCmVFwlvktO7jqLnNHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=StXiq8+A2EvKb7d0szBxCXDkE8vPzCKPYDCSWg8/Fk+As2yvXGggilwKEYYdoXHsY/QcIO4SztBW5xlP9VLjqTI1oirI50rPdyW4J5jW08wFxGAg3z2ypucFZTHjjp3Y8FU7GXmh1NCugzuzXfFU4hCVXVZC1NqA8esVeUmUuwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GEg7wxS3; arc=fail smtp.client-ip=52.101.69.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6/s/u6pCi+isPcj9qkyePVbv//Kx9mX1HtgjejFXzjh9O0qjw3RUgnQ1gRdziZ+xEeXIR1LoLx3Ba02O7ycid1YZAlGfsH7aOzAH0wjSH+dQiq0nG14QKUrf6lFR0LQdT7e/AfUX/vJDVa+Hap9AStCCnFwmLoN/FZoClqpCznhK/z87MPDxSU/WH+UzRUeBV8wojBidQuDfXqoBSWq6+mCka3SPRMZM2Chc4a3/qgB9kMQ1rsB7HBuDGW5ldVZFun8xZ+KrlEBzwLGe/8isGKcVpqHX2Xbl+4g3fbUX7hCeRDpPptdve1KDcCxjDhI5HU4gYouR/xbms5oI3Bj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLe2WlC5apNLiJwGvfSqNqUJPVLE3OOeg5XKKaMuuIE=;
 b=xXI2gtiOhFxswqresdoIwaSE5pa4S9v5O0ogOQM/nbF6axSEu6QSrVyD5g5tgG7YagUp9khrH2OlH2hun+cP7y1IIOhMnl8lk4/lqCzi8cU8YpromApIQzVam/P9BrPa2qmHxNXe/7wYBeabWhEEwBVIlCDadXK2Qrlclf0uBeLdTolr65WMem51POmiJh5AL+DFR1+e5h4pnk8PyO4fktuIw0CLkwx0Vv3FuhKlg7tETuhNbCyPT5+z9kJV6Mdcgq/9AsVJaPM9Nm+BomYCHbIsHjWoitH4EEBxRVy1+RuVjDPUO3lwo78bbzXDBnORpQ/1THkP+63k1x4LR7hpnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLe2WlC5apNLiJwGvfSqNqUJPVLE3OOeg5XKKaMuuIE=;
 b=GEg7wxS33uxehZlTkf1jXp5wxcqifxOV/o1GeYNPIRghR3N0Aq26lm5amMUWPoLe7M4b+99mvZ9/n0HVnHq2OiznohXHaj1V4C73EjItrdAJRHQ8j/8RqDZ3sgIBJ1KJ7Z1sGctDDD/l8QUqa1Ntqc3BXJdwiMNnSJfeTYyRphDKee6nSZnlxgizqOUbmFpRdxsdUQA5VU2PPnA9UWUpYgcyXDaADwRj22o+tPXDUNTnYBmk5dq6/Jy5cINLRnsbcsHNDLzjVF1M51dXopGzZ+of7q+IfC47m+q3xQR5temiXrbQppKnAazJ2IBn9Rci4A6eIRBD6aYNNCi6o5y6NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by GV2PR04MB11933.eurprd04.prod.outlook.com
 (2603:10a6:150:2f4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 11:42:29 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 11:42:29 +0000
Date: Thu, 7 May 2026 14:42:25 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 12/13] dpaa2-switch: add support for imprecise
 source port
Message-ID: <bz43o57memx674fovfxmgulqolrigq7jcpreh26nkv2rhao4fb@mjq3hqaqojrc>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
 <20260506151540.1242997-13-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506151540.1242997-13-ioana.ciornei@nxp.com>
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|GV2PR04MB11933:EE_
X-MS-Office365-Filtering-Correlation-Id: d65341a6-9a1d-4a75-9ac3-08deac2db7d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	I3+jATT9malf+eFr2UB7Kpm/9HnWEfolUD5Mvo9s+xdsnP0NnFiQDoVnIdw7YVi0kzTFRex3Amk/MwI+LixSmdXlVMnPKbH+y4i/JoiZsyF55cqlSBV3Q+GaV0CcxORNT2CX+xUZ2QWqtKGb8oyCS+Mdoho44+jP/YupB5JlFcIVKAmRSdIxUIPgzLG6GcCq88ffl3bry4v4GoT58ZL5HYNKJCeY12UxmbMyWUd6DGds5KzWeaX4/0OZfD4KkAlcPXzLIt/9GeyEeZLVICknRRoodyO31gMLI6xDUgIe+ONJIbD56gJ1GSr9MjswxJ0udSf9z6qFvswdxALw9aIOzB44wra6/3t8Q8i8vs0vVbeDb6PcjVZFJ+dAUI/e2n0D8A5zPT+D3X2qeo7Z2/dVSqSlJjey0OZ67Asjed45eiRwIs7yjAbf3ZimXhyAUVlRMaA/wDeJ4O1M/vQ7ebTD1H0Jx6L2UKYhFE4nNouFQVxqI8Pa/S7x3XdSAp4e/u2vkdkxuK4GwcpH46uwtcBdl86iDtXvWe9AwP5Z6V+BASA9FCbdLWfmMm5OF1C0100z1Li4JwkPaFSwi4x8bDUIZePXZhIjJHrbbpnN6qlRB3gHZbL1XLm8l6BzSG0HYHmWQmDlUMX3z1ic0PuHVE6nkjfM773joQy8Fdq3W+V3DOxyXW/YInvEnc+yzrfGObjL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Fbk/79R6ZN6Y0VtAIrVUr5pfber9MA2l6cWCajmZSmntO/Pr9nb056Ih0UX?=
 =?us-ascii?Q?gL1EzQCvLJQgBKnSsM2Us9MdOkhNWeXHIDM4i0DpBIgjViW2YASFyF94WtJc?=
 =?us-ascii?Q?XgThm2ByhPnDN5o9s5b55Y3d9iDs5ESY6VgtuTWIUpABADg8dP7enKUnPIiB?=
 =?us-ascii?Q?U2DmL1d2p6K2XG21Gn5Cic9/Z/mOAwyUKITBC/TN4D5WV81521zjNggDJ3qC?=
 =?us-ascii?Q?UUz8anPtHf5aFOU5fVkICCpJkr1cDY6Y2VcSptaik+ZCfR8f3kIfGp0bO/fg?=
 =?us-ascii?Q?WZXwd0Nw1sXEQVCnnYr2Mr9KLmvfttnw2Bsv3EfQ0JsLcc/NAhc4q4xl6a5M?=
 =?us-ascii?Q?+xTOr/g2QLnsKZ90E+4oJPluhW1BUWW1+tWfn9H+p5JiN4zc6uCT3XtU+6YH?=
 =?us-ascii?Q?0cV/BWW2z+lFduuyh6HSWCeuomJGIvH5CtJSoZ33kW9Q5ogRKo5Tqgum8hkZ?=
 =?us-ascii?Q?xMtW4cWuwPNZ4OhUALk2cJ0pWTtNZYVkfMWI//KebMtu8F8BVBmrIDuLb2Fz?=
 =?us-ascii?Q?UD9380vgOdahM8CPfiEy6Y/TH1GTxAJy1axzX+fPs6P70XYTLKlQrAdWT5uk?=
 =?us-ascii?Q?MtiWNAuxHfBqaZBX2g51loIzqWqZu9tbmZMOzxGIj0+4MY7VgfOOzYsoWcqo?=
 =?us-ascii?Q?sSqfDQv/MXe5qjPw4d/pmZuSM+OlVGygABeUG76KX/Mka0/w8nGgam/gf6l2?=
 =?us-ascii?Q?IAlQMjttPaRUqOXVoIURRUzaaMzNCYlIDA6kE5CalDNcarqPw2MPucKC6qIP?=
 =?us-ascii?Q?yjSd+0UkoakcNpI7CrXAeD6gvtkisHxQWwsVPWaU38W6hnlbVxZnX9rMbNap?=
 =?us-ascii?Q?qeaVUnbCrFwuMfKaNRdwpQeJzCOMvCwQFh2OaJ/jMRalvs704GbQy1M7mfsb?=
 =?us-ascii?Q?jrpu8OfkwhN3ektB81tCK0QwIKnh1/yj0nUnl6ZjCGEah+JuCUAC020Zdisx?=
 =?us-ascii?Q?/MKv4lmPz9Pq3kEp/yPI/zG4dLAuOS5XSfPqpmwzHmFDPCEUWZhe8Bi7q8B0?=
 =?us-ascii?Q?TavxG+pslqyltwsaksUBA/gyis8y7DdArrSfuTDipJRqHcH4bg8+oh0pMIpj?=
 =?us-ascii?Q?qCxGmQqCSpcRFtZLzUU0ADXD0+16LsJlD4TxKZqxLdj6C8oX7CLp0ilUHbO4?=
 =?us-ascii?Q?ayMgCMdMsgSDdNiRU119Eg2cO8rThP80d/aOKSk4dJXJvm1/AAZ9Ayrg2aw+?=
 =?us-ascii?Q?OUQOM37ep1wIF2yeZVFGzdTGmdaaJmnUTY+jpXY6hbJECnSjVv+M8vq7wh5W?=
 =?us-ascii?Q?vJSARsKR+6/8DgGz5DhB77+2/PmJ3iwLw7rCVVSDkXpR9y8nATE5qIB1d+Gm?=
 =?us-ascii?Q?2/o2rHwJU/Dt04sHd0m0a5+HvrFjcLZqQFHx8j9h+KWjdQZpJXTdcgjjq3kH?=
 =?us-ascii?Q?RwotVSFL2Ewi7lp+ECmMS8udGUIKhrCAw9cU9jGs4LKLlg7dzQJ3CWqYBG0m?=
 =?us-ascii?Q?PrRQlw3Cvk1aOhxGm7mNuB6ye7O4zhaNOhIR14d63RIEZSbwhTrY0irgKROU?=
 =?us-ascii?Q?ZeX5ZfgVfUEnVxwKvRF1opKBem7xQa+Um4QmO7OtkRFSZ0xi6RTKXYe0VEmt?=
 =?us-ascii?Q?c8H5heFJzZzsflWUHcR2GtnB4Xq2QFjZUUU+f8D8zXRult/vi8czrL8+cUkh?=
 =?us-ascii?Q?pdqg9FcKRgXODJzoSKHGp8dScgKnZWOWZhci30EnIdmRGbpP9OC529/DcSL6?=
 =?us-ascii?Q?J7lqkR512vMKpffZHmXLmuKuDZdl6S9UhQuiag2PdIqAvFlkwiKkiFjUsabN?=
 =?us-ascii?Q?aGWFRWSaKg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65341a6-9a1d-4a75-9ac3-08deac2db7d1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:42:29.3154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUgQ2s3xwhi7ucZI+LOXav1AWRI4f8qbt8KvztStirsJsRFUzTtMdKf2SzhKfniIhfl5eATwWxq/YLFlHl4k3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11933
X-Rspamd-Queue-Id: AF8CF4E7A73
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_FROM(0.00)[bounces-285282-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 06:15:39PM +0300, Ioana Ciornei wrote:
> Switch ports configured as part of a LAG group are not able to provide
> a precise source port for all packets which reach the control interface.
> 
> The only frames which will have a precise source port are those that are
> explicitly trapped, for example STP and LCAP frames. For any other
> frames (for example, those which are flooded) we can only know the
> ingress LAG group.
> 
> Take into account the DPAA2_ETHSW_FLC_IMPRECISE_IF_ID bit and based on
> its value target the bond device or the specific source netdevice.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 10 ++++++++--
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h |  3 +++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index 59ed06ed7ef6..8353d2230c72 100644

(...)

> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
> @@ -87,6 +87,9 @@
>  
>  #define DPAA2_ETHSW_PORT_ACL_CMD_BUF_SIZE	256
>  
> +#define DPAA2_ETHSW_FLC_IF_ID(flc)		(((flc) >> 32) & GENMASK(15, 0))
> +#define DPAA2_ETHSW_FLC_IMPRECISE_IF_ID(flc)	((flc) & BIT(63))

I saw the patchwork test - this breaks the build_32bit test.

I will use BIT_ULL in the next version.

Ioana

