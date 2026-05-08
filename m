Return-Path: <netdev+bounces-285869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCceG0T3/WlilQAAu9opvQ
	(envelope-from <netdev+bounces-285869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:46:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E294F806D
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 433E23029A6A
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 14:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E7F3F65EC;
	Fri,  8 May 2026 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R3ZkCkEu"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2483279792;
	Fri,  8 May 2026 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251579; cv=fail; b=OVLOT109Tg8Wt8s3wiB51yUr55WZd+u4RlcRfeLqYMsJ18QkLPE77kV+XBer80eSCqK6PZhT+gV3/eWDaUpBoSTBfZMow6x4wyguyu8fNTlZIGBAESXZXZOOJ2UV0hfAHCgpsjMa19h+kXfi9ygM7SL98ASmIwej2xtkz+ohZVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251579; c=relaxed/simple;
	bh=f/dF7lyDmJTKYzJPDod+cDIVWXK5emdSCpHpmoLCekU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gvb54pVya5DMUM0spyapAjfUj1PW7DZhhFyw6spfpYAGENRq32knkppr/EE39GIm6b697mVsmUeqg5onPOBlOM+Z8j2KrOOZAiFdBGSsQhbWq8SxOnp4eQQDgp6p5TX2j7N3bmXD/IiSX6K5K18YXHODVquteBpmiHGdcqmGNxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R3ZkCkEu; arc=fail smtp.client-ip=52.101.69.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7DTTcjotmVcqzLaIPg9gI7Bb7JLKRi7Dps1lTzgAfByYvMcWOfcw3tI+hSzSumJk386Rmn93cHl0vCEN6euAAUVveMG7enkSEdBPpLutrPOtsYOKYJaQyx2NHl1CH3dfFdHYR/BBbfnLscNB9tzRJgbZ5SUAfSxKOaUNMgXlVa5GjTubUHmQ8urz03sETPM8MF8A/c6mowV3Hmov2PgDwOISKFT/ekFXjUSddPofYWEmJ1Kqo/br5LEWvPADKGNfyJ4FIDFifXWVAadacwpKcM6TP+FUmiUVCkvCKPiVM1MBhzvHguHTFoEOsv9hPAgS9tmRaamOI+tzvWfTp230Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTAnVIb+4njmlt/1OuBNF2PhcjvsrI9PaVPlx+kux4M=;
 b=I5/JMDgI688uaPJAHIYT4Unl7eC4/V6fj7FYZJXWEnpY8wKiHPiMT1fjX26zYLRtej3iyFTC0NZWg2Ao07B4MN1TpTtoViRtZSc89FBlREA6C6tGUwWcgAJi/Obg/Fo3Dbcka5mCSiAJAcd+Nu7cyJeNlWJpMyGf6O99POHnQ+CPl4LrtZJAgYeG+3/GnqOMuI2992hrUjAFCh/YIAVtp9tBG0gjkebrEWVzddbAIY75cBd9slOJ0JZiDDoBmYWGvUWKd+PT4ouDcxn5j6C3fI3fIns1PDyqySrp7webjhZEFjMFnC/y8fhSmb+ksI5vPAbfkcTEwH5OFE+3vQugvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTAnVIb+4njmlt/1OuBNF2PhcjvsrI9PaVPlx+kux4M=;
 b=R3ZkCkEuuPFUNPEOtAwK3qO1qbmPGe+nRDlCW4PS5xr7Te3Z6pUegwmMuSEZ1vaCxwNaJlee2q9lX01uigJleuZnyQxf62vY5+l0PMnUNCbtdQ+1iievwJIQi4Vm4zTyvSPMKn+1aadTxGEHQW0sP8NaucpCJRA8hj4A/0aeu5h6eVjfTmQx5e1DLTWIDPtBUbGECZh/P5X5NBdf3+d7uDKqrJc7cZ0cEMbAmJ9FHvrmHj3DxB3uolY1ebYayKvtllRVvFeV9HCCqYcM/Tey6N+wTk3ckK1YWUFzWYUQuLuEuaFsiXqMem7ZU1QdKZ0FghvjZPkpLLzqhOzx1avNuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by DUZPR04MB9947.eurprd04.prod.outlook.com
 (2603:10a6:10:4d9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 14:46:12 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 14:46:12 +0000
Date: Fri, 8 May 2026 17:46:08 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 08/13] dpaa2-switch: consolidate unicast and
 multicast management
Message-ID: <xrig3le3xepj7wbbjfagihcr3qkhdkcqyvxgmqyjzybds5sbxk@6lydlpnil4ht>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
 <20260506151540.1242997-9-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506151540.1242997-9-ioana.ciornei@nxp.com>
X-ClientProxiedBy: AS4P192CA0020.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::6) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|DUZPR04MB9947:EE_
X-MS-Office365-Filtering-Correlation-Id: 46943b13-7a4f-4986-77ab-08dead108c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Y2/pm7M6Qx6ZrgFHzIQG1hHaSFIl9OEmt26x6RYw1GchtWRDgxE+nmWxJmRswYzDh7SzsXB//7SL54vaCAPZvhTIJoIdpD0Kc/3DEx++FXE00PFI7t8V04vbx1xGNKeWoHXV8zvv6Ozd5ivcW1avFuIMVwf6UIHLxb4hFNLcDWERGNB8vHmjQONx4fhJ8RSSQZnClJMAIh72vCBOnNmsdVSdID03xw+qVkyrYAbb3cj11QtYkvpv6mqRLxYljfSIWO9LpLg62Wmp6FbsIXZfuV3c/bLiRTI9z7Rrsgk9uLbBzgtGXBJENWbEAcSwoo+o12bWqGeyVbgWbbFWWlosi7f4b70pEv9rKtlhEbKVYxRp2jr0Au2GckfwBNLfEGU7A9Mc7e9+WyNYvHnE/vCh/pNQ5Bj/liNoWtGiDYDDJCeNFwaxKhZzrU1K/qbriPutS0wmObgXKZFsB16tGmjYx0S3sd7kvHjtyE4CWpcmw5QB3W50GYXGb1JgiKUM6nJtef1HpxbhyHvBDcc+nrkZn7W5utBQgd6sKhP8mpw1CtCQMpYCFdhtN7lxF5v1P8HJSJQYxXfij3xmuUrGF+Yjzy5O2bz7wF6e4BUVLry8hytNQ1Kr92ia5gm8pWrMGRbwCpmmns2A++mZ1HCQ+bVytLSp93nzwYFWG5DozKK6Uyz2Z2KjBUSOFKU1gTgdjoU3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?13JQukPHB6X3gQQmyzD5Ta7W1FjBy0B88SJP792CJV5awpOMvjVkFJYJFW4N?=
 =?us-ascii?Q?JZVBHWIDbcwOv/cDwmVu5sRMuoihgSNPKBxELR4zKE40vc5KiZDo6KtAC10w?=
 =?us-ascii?Q?ybKEhCtaQ4QaIYRfxTLhLD2PSRohG7GrDBQPFrGvWnDDnQSMI3XN7H5j2lFA?=
 =?us-ascii?Q?74qXeW30H0m0eEB/xccwtch7gTQxrD77DEGuvdqvThLqLHPgIyg4vfXaPXCC?=
 =?us-ascii?Q?c/4QhOAkIiOFbxwbz04mV51uJSj5kO+0y2q9c/Jf7mS21V9A5svJS9UB5VGX?=
 =?us-ascii?Q?H8jEtIAdFJxfqhDa4DFdq1eAxNuhWolonMIwwHZEDmO90Lo20LQEl+aRPVkr?=
 =?us-ascii?Q?5sOaDLS7FruGSRHPhCoCz40xs/w6xNmDzVaNNAC6xm9k/3fmINl60jZvkcxp?=
 =?us-ascii?Q?f/ft4xTfGMTCwz6CJxMEqkWl2U3kcep5rzkPw3ZNsyXYq5JB2vfBzvxPrN/2?=
 =?us-ascii?Q?roTpO9mq+Qm9VOQZEThTGEHgcO0EZbx7VKQtoUUQTu9qr3/0JD5HbXI7/nXz?=
 =?us-ascii?Q?syE9gGyvnHv6lhWDdoKeSvet9xoLm33C4F1ob+NPLd9XICs9N2fydlTa9J4S?=
 =?us-ascii?Q?8q2HGp2js+Umg6TZYn0AEBrPkA1kFjxzKLmqOHN41Bgw0651fJfivl7hiHdW?=
 =?us-ascii?Q?jKAZcszaeqYAQiiWMaoFcHEWQeisbjQmXh4Ns8TfY/hnV+sU22XF8ix4cRqs?=
 =?us-ascii?Q?3pj5y52xfYHhB/oTXWE7Hja3kiITnH1yvalHthk5M11+w4MuPoRGr9QX2mpf?=
 =?us-ascii?Q?RuOzpkljN89+zmaHnEqvZJ5CvQhOtIQ2yZOCwPJK05rU47uOt0zCP6nNYosy?=
 =?us-ascii?Q?d1UNiOXhndqdjTWSgnFCsBhXxlyz+W/bexbb4ZxNSdjyOUcwd8+/ABvALpTE?=
 =?us-ascii?Q?hZmwbVBmkHSBnZoX768EOwJ6uTb1Ce758egzD0oDy97ASB36BzXuqhOFzE2i?=
 =?us-ascii?Q?3ZkVrfgknvnZyX1GrFYppiGqz2fpTNsCiwF+4EKKr/XDUawYbzGQ5Us9TnP0?=
 =?us-ascii?Q?DBG5On7n16Lzw/Oz9v4vhbBBZanyW+7s4rpeaKu/8XVfXMyVT20DUTeMZsuw?=
 =?us-ascii?Q?wKDJV1HVBoQXZb7I6x+V0JF63Mgth2Frd4l+GR01VPaHIkX7NhsmkBuPuKVc?=
 =?us-ascii?Q?FxY0x0wl5X02IyUuSVfobaD38miPkthwh2iu+4oNH3mxQZrsBh4Etn5NSkQs?=
 =?us-ascii?Q?vpk88zAiHcfDruXt9sv08ssMaEpe9Xzscrd/3YrmjqGnN0VknnbGH0IXJPFI?=
 =?us-ascii?Q?c61XI1EnL+PjlIbYYeSOwIhOvFQLbaMxkQEi/NIHTwkSryWIU2lA5zAFHHYN?=
 =?us-ascii?Q?J/7gutblnz1rwoGDqxXKyaFV3ruVCH8Hb2qhnWq9wK98rmbwSaeE+UNWyfjK?=
 =?us-ascii?Q?sbamhc6qzRMvD5GuVhx5+bmLOKykXs+xNXjSpX+Xsw2ZzQJ0CfmLj9AWlt2+?=
 =?us-ascii?Q?jR2pDHbfay51jpBQYlw6/lDH4VzrQmI+UPN4TUvXwUvK5ktKPZj8waDZVF9/?=
 =?us-ascii?Q?HQPkJMJz88UGtea5/RnEWVPcvQ6tjVL5206gji5DPVwnl/GOgQXmdQhPfCWT?=
 =?us-ascii?Q?Ucan9R8zzwjN4G7vMUDbI1MCwlM8r1gkhdQV0TmgqPCHjxPW+dKpMgkG+aaX?=
 =?us-ascii?Q?jREEV7VBmltsqYUIK0q1oe1WoY+5IStlxHIuuaeJ9Ur4vota7fPn2u+gJL+9?=
 =?us-ascii?Q?D0mK2Z68NnACJ/0bxFRlHKjuRk3epIv8ltPStGfExZqzi48auf0ICxspQkdz?=
 =?us-ascii?Q?FRoRjbt3qQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46943b13-7a4f-4986-77ab-08dead108c90
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 14:46:12.4479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 790WLNG10bCqaT/oTJ1iQNIvwRlyS/QTtD6LSY9yrRdttqtGSxOfqj0haC5TBH7lUFouwQtnMGzVndORlbLG3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9947
X-Rspamd-Queue-Id: D8E294F806D
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
	TAGGED_FROM(0.00)[bounces-285869-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 06:15:35PM +0300, Ioana Ciornei wrote:
> This patch consolidates the unicast and multicast management by creating
> two new functions - dpaa2_switch_port_fdb_[add|del]() - which can be
> used for either uc or mc addresses. Having this common entrypoint for
> both types of addresses will help us in the next patches to streamline
> the same addresses but on LAG ports.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 39 +++++++++++++------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index a057fd85bd27..bced37335a9e 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c

(...)

> @@ -2725,12 +2747,8 @@ static void dpaa2_switch_event_work(struct work_struct *work)
>  
>  	switch (switchdev_work->event) {
>  	case SWITCHDEV_FDB_ADD_TO_DEVICE:
> -		if (is_unicast_ether_addr(fdb_info->addr))
> -			err = dpaa2_switch_port_fdb_add_uc(netdev_priv(dev),
> -							   fdb_info->addr);
> -		else
> -			err = dpaa2_switch_port_fdb_add_mc(netdev_priv(dev),
> -							   fdb_info->addr);
> +		err = dpaa2_switch_port_fdb_add(netdev_priv(dev),
> +						fdb_info->addr);

Sashiko notes:

	Does this code leave an orphaned unicast FDB entry in hardware
	if dev_mc_add() fails just below this diff context?

	When dpaa2_switch_port_fdb_add() is called, it dynamically
	routes the addition to either the unicast or multicast hardware
	FDB.

	However, the rollback path immediately below this hunk still
	hardcodes the multicast deletion:

	err = dev_mc_add(netdev, mdb->addr);
	if (err) {
		netdev_err(netdev, "dev_mc_add err %d\n", err);
		dpaa2_switch_port_fdb_del_mc(port_priv, mdb->addr);
	}

	If userspace passes a unicast MAC address for an L2 MDB entry
	and dev_mc_add() fails, will the rollback attempt to remove the
	MAC from the multicast FDB instead of the unicast FDB where it
	was just added?

	A later commit introduces LAG FDB abstractions, and this missed
	error path continues to hardcode the deletion, which might also
	bypass the LAG refcounting teardown.

	Should the rollback use the newly introduced
	dpaa2_switch_port_fdb_del() to ensure symmetrical cleanup?

I cannot see how the "If userspace passes a unicast MAC address for an
L2 MDB entry" statement could be true.

But yes, the rollback can use the newly introduced helper just for
symmetry.


