Return-Path: <netdev+bounces-296536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zyvcEea4JmpAbwIAu9opvQ
	(envelope-from <netdev+bounces-296536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:43:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02538656495
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:43:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b="MHOr9N/h";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296536-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296536-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9560B303051D
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 12:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDA2372ECD;
	Mon,  8 Jun 2026 12:38:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013052.outbound.protection.outlook.com [40.107.162.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC9D26ED3C;
	Mon,  8 Jun 2026 12:38:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922283; cv=fail; b=nfRFsV2ZSt8gbEY3GSO+ZvzkUOmvB7v05iyThbYkrwtmxAkePWOqHetBHmbVc+3gu6Ru+iOaLLteKq2cGK7v/M4t+vDK2TVfL74h0nHELh/WVhnWTSsGROfzaqIkEqHC7vwx1hs7xx7gmC+zbXdVr0NGG4/mmNGJ4NbrtcFx4nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922283; c=relaxed/simple;
	bh=TL6wSD9dddwdOKzZXYtDf0NeGU9qv0WFM/eTk+vUqVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gQCOQC72Ft7W/xWBiejFN4zuRp+IY/r654LtHfp9yJc6xIqyyfcgPrSKFTfFBFGtxsi+1+KESG+D78FtytcAFmJZClQVElIZXpLxF9gggOliFMFuWqnQ4ql66CTLuvu6V7W7Icc1OjdcYeiVamxRnGx2ybSchheLA89lxYUadXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MHOr9N/h; arc=fail smtp.client-ip=40.107.162.52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZt4XPO7mdiYx44k9yigR+22ZPGDysvullvT7D8iV+MBdfW5KmXf828C3YXPmirCwGyf262dnn+nSHu7XZ/UCusV9PzozoyYLnzHkHZWBSPTyrzJBl9YJ29ykABKdQ/xeYDfzjeaBO9pL28syQTm91uMkmwRNxYoZlOeV3iCQvKGz8FPlLq8fqkGGx7qzAUnU28SO31eNQne4Z+M0/CTAUsH3za8MiSa81QA/lp9bBKCc3ZGm/c0kd9CWZgmIKbGgXY8PypE6LPEq3UnZKNMppWSqQdy1KPQZsrSI1XPwfMQrnGqzMmtF7MPpNLj/1mjbzBlHZKYmnkFZQUFBBUmBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1sO9HA2rpkjFOrxpJb8CP1rO3Ou2K77pi5oe+YgFl8=;
 b=DuQg9eeFfS68QjOcpUffxmfi21KaTdeIR+6rmRqC8mHIM7RYa3Mnc4XX/Fle0IskCuH0rPGR1BLD45TPwe52qpyiRposg9QzKvgmHnuLIbxxhqPF0GBcyjcrWJ4PfHLbj71shzwkZE71+ZPv1mJUO+XlDqVPQweVzUpzMSbNezvdMFDxLrDet1UaSxRbNheirPgTEYasWLakD3I8z96UrjjUpK564PeeUiHvfdKyR3I2q4q7z0vyhii/dmrCWb5f2DHpA39qSVeKlHYh4miAGk03Rxc6zkKOcb2ojEnDoF0D+YOLfQ2b5Kd3hDBHLauP/D3u8cop8RTiFURP4BLpwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1sO9HA2rpkjFOrxpJb8CP1rO3Ou2K77pi5oe+YgFl8=;
 b=MHOr9N/hXaAkm5yRj4GsAPRN05cNq00MSYkpph06IXmcrTgvwTA0+zVTe9fRwyBbTEFdzRVIGITWw++EzeSyDYUbDu9/U1yHirNQKu9a3Irc0r+x340DDtFQFU+h/rkFXEHslSu3dx/oa35VfrbEbLVHBKZv7Vh9aI0k+DlveMsYfaE9wdtmfe9pgxNJQqh+5p5IkzthD3FyoBQlIrJg6IGg3pPndzUPQVbLUGLEWF/Dw7TLxWYJdnaM+8igF1szPYErS2t5NlxReV3ASH/eQEPghPToUwLcuUILP+TA6hejaJxO2PNgckfhBkSGoaE2o8cUQHcKz69gXD8q8A5cTw==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by MRWPR04MB11518.eurprd04.prod.outlook.com
 (2603:10a6:501:74::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 12:37:57 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.010; Mon, 8 Jun 2026
 12:37:57 +0000
Date: Mon, 8 Jun 2026 15:37:53 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 12/12] dpaa2-switch: add support for
 imprecise source port
Message-ID: <jb4hgasrmsfuplb6vznduyst7eyhyxq7ggl6bwf5biogbjqz2o@uvkdmdiahhyc>
References: <20260603143623.3712024-13-ioana.ciornei@nxp.com>
 <20260606021104.4124892-2-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606021104.4124892-2-kuba@kernel.org>
X-ClientProxiedBy: FR2P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::12) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|MRWPR04MB11518:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ffb953-0b79-4ee7-3c9a-08dec55ac485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|18002099003|22082099003|4143699003|5023799004|11063799006|56012099006|27256017;
X-Microsoft-Antispam-Message-Info:
	6jALH5/AxLhxRzm9lRO07x5y9km8uQk2HHZUU1CKUXvf/0YOClWO4UoPpxD13LkOseM1WfGAtE1uSYph+5a6JBJAiY9x8PqIBhwa6rGvAwcyriaXJMxUFQkKNxqReNWYYeLWqGQNuQWXk09oKQF87gm/ly3x6gMGCJ0wSjYufIZPPOaUJg0LvaSgAWmjKIRcbEbzV2nVXd3rpR9zqQCCgsHAGTcMfwpg9ZeL6rmLOQj7KGys6slQIhle7DxXPG50rht4Am8AFdC6Vjh2Le6ZXxlhJ0lvARh5Aitm3cdsZrpeZbLujzz3MRIQA8A5fbO34zRPIA98IXcaYD2fkNB8U18hrlYmZwg3jamyWaVYl7L+ggfxeqLBEqgfaDQBKqEp9upW+kp7cZfV148cJ96keBael8M4Ed7tVH5/r0gsUS5G3cBiNNq4T/clbDhPU9UhkS6QWPCs+WUDHY7oXyitBfRAP07fu2LpSvkYXiYDcI8249YZACfeuyJbwNuKnmLsZmcOSZHx61MNTDAG4r5JjTG6g28btDGHqtz/Li+vlTP5UZ1gb27DoUhkAtkqx8BGzs//5DNZ7Xmgb9m8G7FsAneWwg+Oe7SyQ7EAKuhuCjudoQei6NOUfKvjZng1uvDlMfgjW07EpcVkiPIb3WVeSX4CZTbH0PEMrC+OYVbVdnmrKYw8dtr4PDnrWUjUHFwKaLQ3FeshVBk5/N/Z2baR0mWXlmAzCb0FKEIWUOBmAauWVSU1urbtyet7IzzmI8V1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006)(56012099006)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G/nrE/28nApzHvuDjxCrBN0CAIldNACi6iKsNumsttCneW07yqbq1VxGKHZk?=
 =?us-ascii?Q?EC7SkFwrPvvyP4ph/PUwacM6zXFMM2rSHdZcDWi6/NeS77Rlj9qfoFf9Gz5V?=
 =?us-ascii?Q?5UQtlyaGg+n8QHnpDHKSPZl/zcM44lusqE+JmfDE4qAFamlcng/5WidWSw7x?=
 =?us-ascii?Q?VfCm9fgSba/O4iTWaFnMAEOqnz25uytIDFacGehPMhX9F/YCLXPxJEfq2CiJ?=
 =?us-ascii?Q?gcLPKFBLryDJipGjLsa67g3/lG5pZy/FoW8iFaW5bRpv1doMipmKvDewhtPD?=
 =?us-ascii?Q?wdiGNCAdQLH6iScAzfTshxpP8lECKFFvhe3RTcaQGGQ9uBHP0+UyQfTazfR3?=
 =?us-ascii?Q?9eW0AvKZNg6tGCr39rCcmvAdnKthN3Xgi/vzjPbkyzVA8Uc5+LGV7QLP3mUz?=
 =?us-ascii?Q?Dl7GsnDxVXtConi/oYYLJOWp8RNiwHnP9VqaJP9yWoQ8w37uaDONOaQ9QR9G?=
 =?us-ascii?Q?ylViJEIddj0RAUAVeRSrqcK79x5oIRBkjrV69tf4XrTgTOOOvuijvK+ThMox?=
 =?us-ascii?Q?AwiSTKppw1McDN8egHzAFVpMUWWUDaJZbLivRBuWLvR56w4qOXC97BTrbvIl?=
 =?us-ascii?Q?bwo2ZYlrK8oY3OfeS3AUSuECrTJq6/n0cz5Y6OaAeg8EgGF+mgkYbiYjf+7W?=
 =?us-ascii?Q?739g5/L2lyBgX5MzN/5zcxS9aHmReHjYge2b61EaQvJzrC0fSix6BOtxQUn4?=
 =?us-ascii?Q?YsUUtO03sMc02vD1zEnk0vUPIxFTYe7kOQzTpNxqLTVpAGF5bbx3DOX0h+PQ?=
 =?us-ascii?Q?nPHDhSnMD+72E6igXA/ak4zwoo5BiXH1UQXmzm6Eeaec3JLxAd6evJaIVK9K?=
 =?us-ascii?Q?KI4kAcRVy2jbKI8lV/Jc2YWcWbtJU8130+FqjlqbtSR/sk3h7dRL7cGrTe3Z?=
 =?us-ascii?Q?AswKRqlnDRzQRTSXs6MQ6VSqxRDKgoeL1O9oanTsMY65+NKV/TiXD0rvOnfV?=
 =?us-ascii?Q?dmCQmgFy2O8BU+fI27MhAjwThKLoBBKh6eij0+ibBvAD5QCGB4YphhCTaA/m?=
 =?us-ascii?Q?7SKIzkPwyWStVQIrBvbKWTarH7p0EXKzFnCt50IbYkXDaky0S2XbSD3sL6WI?=
 =?us-ascii?Q?/EqVdg3rxQnh+bic9xMiSE3N01UW/ZZPYoQFoyzQTRNKQOp33V1ODsLXsXDc?=
 =?us-ascii?Q?r1iz1OBnGcfPSCMMLCRAMpkR5uRLvWDTpSieyknrV6Vo4cEvUHc+U3i7HCz9?=
 =?us-ascii?Q?dH9k99/kS52ywK4eHY1SjEUmrBb5eNVDw4gb/msoXbPDAwJAGn8Q+uCFbkCP?=
 =?us-ascii?Q?9DfLRrqwzK5J/5TpwDtmqafw8Xt9Hu1zGisqgvmxb2VJJfgeFgIoEldBtOr2?=
 =?us-ascii?Q?2a7ymGWmIiqxGy6EQH50e0zN7JuSxUJ1Y5dAmrtjIhytEf6x2oLvgzZ0u/xs?=
 =?us-ascii?Q?gQszXTTN3TRlasoSCkv5bP+tyHgbWGTjejkOmofPXPt4v1Bja4cBopGhexir?=
 =?us-ascii?Q?u7DdqT8WNsk90oRHk12oGxK/oNBd3aJEUnTFVkeKYfmm1Z8xL1y9JBi1AEUi?=
 =?us-ascii?Q?PEkgLGVQyMshoU3XKTQJMRz+10rfAwJcVxS1N+uoJ7eixvXWuJDqPlY+UxY2?=
 =?us-ascii?Q?XYC1xoYGv7+17WTeSvGQljuApckqwlvI+0uDnLntmkyvB8EZqh+54TeKrYks?=
 =?us-ascii?Q?cTIRxBgi2Xuz+EB5qCuC+rNIa+MAV9u5ydQfSFUJAjFjUClrQSXMOAAWnxjA?=
 =?us-ascii?Q?N0g1jPq9WELq6QvmE4pGrkR2nXKPwZLA0hJr3K2zV4w0Z4VgUU1nAWazOEAi?=
 =?us-ascii?Q?vMh712iVBg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ffb953-0b79-4ee7-3c9a-08dec55ac485
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 12:37:56.8849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fx/48mU03FMnsmfV92Rw/ruNzSbi9FCyvwC+DhrnHkV/Q8S8Ml64lcyh4Bp1yYYupRBqs5fBav6t3GkaJYXpBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11518
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296536-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,uvkdmdiahhyc:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:from_mime,nxp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02538656495

On Fri, Jun 05, 2026 at 07:11:05PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> dpaa2-switch: add support for imprecise source port
> 
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
> > diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > index 7aef34778e220..163f6c51c1606 100644
> > --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > @@ -3270,8 +3272,10 @@ static void dpaa2_switch_rx(struct dpaa2_switch_fq *fq,
> >  	rcu_read_lock();
> >  
> >  	lag = rcu_dereference(port_priv->lag);
> > -
> > -	skb->dev = netdev;
> > +	if (DPAA2_ETHSW_FLC_IMPRECISE_IF_ID(flc) && lag)
> > +		skb->dev = lag->bond_dev;
> 
> [Severity: High]
> By assigning skb->dev = lag->bond_dev here, isn't there a risk of a
> use-after-free on PREEMPT_RT?
> 
> The explicit rcu_read_lock() is dropped before handing the SKB over to
> netif_receive_skb(). While NAPI's local_bh_disable() provides RCU protection
> on standard kernels, softirqs are threaded on PREEMPT_RT and do not provide
> an implicit RCU read-side critical section.
> 
> Between the rcu_read_unlock() and the internal rcu_read_lock() taken by
> netif_receive_skb_core(), the threaded softirq can be preempted. If the bond
> device is concurrently unregistered, synchronize_net() will not wait for the
> NAPI thread, allowing bond_dev to be freed before netif_receive_skb()
> dereferences it.
> 

From what I know, the NAPI context already has an explicit
rcu_read_lock() taken from local_bh_disable() even under PREEMPT_RT.
So the feedback is incorrect from my point of view and will not get
addressed.


