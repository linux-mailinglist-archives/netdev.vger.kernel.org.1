Return-Path: <netdev+bounces-285897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOz2H28A/mkTlwAAu9opvQ
	(envelope-from <netdev+bounces-285897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:25:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF0D4F8A63
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F22430037C3
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 15:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A15B3F7AB4;
	Fri,  8 May 2026 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ky6aJNku"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B94D37DEAF;
	Fri,  8 May 2026 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778253659; cv=fail; b=iqqg2Kqr9hFQ4Pv+t9u+4mcx1DpZHxWCoy5NzboRAt67csdOMgCGiBhVWQgAlZuMCiJw8HneAcX4mdpTz15j5AyZNTj9zp+2mVdIY4e25Qf6wgGH420lS5gWpQIUfNRUPsbGVabSozebSUcuYv3us4IhNlNi31nbXgnRnZCdYs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778253659; c=relaxed/simple;
	bh=7lqnllfz/Buno8nKyfidUWYnM2N/i6J8ls8jTvCqlLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tOjMvUvnAYb9FpIfP0OemlIYaeL+RRCDKfIUWeC5h13Vov38VV6MX8+/w3KIsr1eXLpeF6v9QI5GIk0rQ8kBKHn/o4+ZMfA+G41hXG8d2Nc6F3O9WegrJwXCOlvJ1f3RXRoYK1RmOSFF+deuOKuuh3XmhAY2y0JdNmhWJFP/+E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ky6aJNku; arc=fail smtp.client-ip=52.101.70.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxqsdJRScvoYlkGN61xcwkQZJnXkyiosC4BoDMQmQDaO26kuQhfBrgwUsAWUkAbBd4aswMgR1k+7sbGS+ZiqCab8FXQ0xV5BZHD698edbjC7HWUK0pTV97eF0rclWyj0/0ZcEHXTzNm9HpXQddGsSDicr95/3LHIzmq8AhS5N/J2uWac2ryt5GxaPAFVQ3FW3d/iREnhTrQBuz3NzoB2c8A4+L+fUI9gTQ2JWNh22lK4hCdS2mbYYsZX2HCOyoL2JeQUJ902C6/XrrRYqyAGe9XqxSPir+xJaLG7AfcRowwN71Qn9fkivprx7Xbir1GN7GmhMI2+BcIvXCn2KONTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T18lkF0CGqGHoLOXbpYciChZs91sqEGHYoCMJX/NjPE=;
 b=Je/Vtx963Ykq2N7SoDQNCyZB3zHpRtooo+YT+Olp1FiS2R8hnUKm9Zj0vl1+JOA0xKpQPkAPC2RHsBjRB8nH0bXCyNdSJgDnG2+UjIaAHLjfHzCaUI4EGC3q9DW2aWzO0XNWpiiYCwNmfKFIjd5IekV5sFuVSXhddqDmEVEYK81i+hDMxxWHGK6yNF7wbtouAzTyzqD1ajyrVfDTG70tsXZWLH/5Julfm1wtSC7vN8kjkXahDym14x/VqGixJdNGDsg0jorHRqgBnFndPPJxG9sB1niwJK3PdZodhLBVvPr4thDbrEd8LZm+svSClOH/kq/i90MEo1O3QFI+uCMLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T18lkF0CGqGHoLOXbpYciChZs91sqEGHYoCMJX/NjPE=;
 b=ky6aJNkuyGnKn/VqlUjJOjyykAnRx+qdgK7k0ktSmn/iZtmS9IOHaiXFibR25xPRS772ORQOvynkeSZ3+5vdMHpPo70F55mb9bHm2q/4w8h626sVB51Nbi1dgZJFTa0eclGk+yy0yoKAFHm0sslyhUtvxiz+8rcWu1fNH+TGeeLC+72PLVoJ1R3Hx1WM57bYhqrcNDc7oqR4K1ICaB+7QXpXYfuye8yYgjTPpN/VTkEPvm+SaSVRaThpozX/veToLgvC4eTdzEzoXd0dAJ2lDZmL/UXeE4VejureYHMlyYxTNEXxXcOd9x1p0qtM31YoxwMtgzVlvnJrOCaNOYEuLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by GVXPR04MB10804.eurprd04.prod.outlook.com
 (2603:10a6:150:214::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 15:20:52 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 15:20:52 +0000
Date: Fri, 8 May 2026 18:20:48 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 09/13] dpaa2-switch: offload FDBs added on an
 upper bond device
Message-ID: <66om4wzu6hjsg2srrac2mb274no2kuk4mjywi2kkuk4gsqyvmp@ktrubqeal55v>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
 <20260506151540.1242997-10-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506151540.1242997-10-ioana.ciornei@nxp.com>
X-ClientProxiedBy: FR2P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::17) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|GVXPR04MB10804:EE_
X-MS-Office365-Filtering-Correlation-Id: 85093c1b-668d-4f44-50e3-08dead156455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|3023799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bCHmtsKFYlf/t+Dj2U+HGmasWlxfUsosw20mE+EIquGfvvoClkiS9jRJaxDuf+vdFu357g8Npy4bvAJf/BKVBiIl1FiLICBFe5dDIQ95PaXdcC9r2U3whB42Mi36j5Jwd5ZfppFAshoa+IrvqSuzDvTo05z8Yb2ZnBGPFrtwkZfzW9t34ZnGk/xjT09FEFYn4zJUYf+C7aOEm4iypazaWS6HCkNrV23r7E+6CuYszW+33zk38QGmTtdfBoF9vZsz6r+O4M3OTLgEOMBS9lcdGPTn4CyZ9rVi7SNNQmXGcWh0zpP1ApWs9Tf0CoTbRWegsLvoibZXki8mDVwDBccGiiSd1EF6NrWDf7h1TrvLkpDS1umZAXD7V02BbEwFHr85oi9RX4lNnPsLyVJMbRL4wGtOiuneSrvYmU8BtrRfGURdHZrqtAdiMtPuXXiajdmbmm2gcHksZm2dXeeApXY9ZYRhHzxL/CvZDwBKCspDcCkTWXl3DRA2+Bmt3IuJhvgkPK/0ULV6zANddtYD12LMp9RlEogM6Ojkd7u/EHeHE4UcUg5top4u0Ad7NDG/m3TFaSjJCwo77f4+EP36GQqsluHtJScnx0looGZCXtPDwpcdnWmAAsqET4tiUENnkAHz9p6eCPhokbRRP7E6GNbxnz7hXQJHbhZkVotcaV2GA/S6NBAskAyI7W4Xjh1Qu2C/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(3023799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?70TGLk5MNzfpNjwNTnGz+Yhc08/+LeNDPnuilrc8BfY0HGKFZNDzKUi0zNH0?=
 =?us-ascii?Q?+uncbYkGSsgisayRx7orvuHESbEQ4EPU/b7+tsDXfVhrTENoJFXFQqeMs3fW?=
 =?us-ascii?Q?pdZ//tMpIVCsuDdMeGsK3eiaJR2tWiUv8ltv1XhnKS1i3o5sNY3/MiJaR09t?=
 =?us-ascii?Q?9zPh28H7RWJXOxwrg/31rjmOTHPNoscS2zD71mKd1F4+GAhA1Xla8IR7iK6T?=
 =?us-ascii?Q?kQnJjfq+dWvOJm1G+fCzkj3m900Sgu/FoaXmxU19FGxrR3PQ+nfxNzqx8VVr?=
 =?us-ascii?Q?owtar/l3uxl1zajFRyD7JwaYBxh4Z0c5jv/LCyvCJfX34Iebzjabg9naYW91?=
 =?us-ascii?Q?ZhhlWYHLfnhsk3JJKhBaQpODu7RvITvOQl8LMjInrkFYxeUY8uHuebv7OLkX?=
 =?us-ascii?Q?BUgbus0CWWeUrmHF8PWGNhTuKMbr8P/Pmj+K8FvyY0XH2oS9aqefGUBEUnUd?=
 =?us-ascii?Q?5d+DLETtf82lSnqyJeutPed311ewjx3SrG37WCYQ+j7uquFe57WZghomaYtb?=
 =?us-ascii?Q?Gwoj03MjSTBADXXuCwxvjPvMjGgZ1Ivhqx3hLnhOVd5tcTsdGMCjiyFh5KD4?=
 =?us-ascii?Q?N5j19svW2sWxXZ7ewoOjzObIa3Vhsd6Ax8i0N1pMmKxO3JYRSh0BxhX3Zs8x?=
 =?us-ascii?Q?Hx/WmAJrPANDreVLAQhtz4gq8Fo8wNuWSBdPs02AYFeWPrAiBzaucHrbITJ+?=
 =?us-ascii?Q?HM4a6CW6iVe1cxQvNk5xplOfa9EkhiG2voS53GdlK2uxXs06B0VFEGmKThYz?=
 =?us-ascii?Q?Yws7PqtShz2z2uCh/2v9rFhw9IWya7ZnCtySgEevA9w0uVUefhfOfskW/54F?=
 =?us-ascii?Q?VF6qB4JfslkcMi9UFWs6e++3wGZkYLE13ARQhYZe3fHjuDG+kHn7n0+JIRh1?=
 =?us-ascii?Q?G7bZs5V1yhaCnru6XJQcto1F4oCIwTqZ15TlZT55Otn0oGygd/HFodKi1dxw?=
 =?us-ascii?Q?Q5G2CcyDRYGfVanD7fW2SyaOUQYhA8R6tV5Nk2i4G9PWbvEoT98+Ga59YI+x?=
 =?us-ascii?Q?xfCGppO3Eyxwjo4YkxBTvTmFWfKKonCY+Gc6S7LAz6dat9SX0mLllA/n3m5+?=
 =?us-ascii?Q?DaWFdBg/GFHVy3ywQlr12p0PYZjtmXZLGbDR7v+TzTjUTQrBxT9hQ6MIqdvs?=
 =?us-ascii?Q?u6AY/yCjSKb+N7la0IXsi3lHTurfanH2XtYOxuSZnPVSSC5mkzxpNPaDs9xF?=
 =?us-ascii?Q?hLf+C0khaXJJKJ4br2SeMJ3ZQNQ9j50xLIVtTJmemzpKcfnrzUfG2XVrneIy?=
 =?us-ascii?Q?2kSpgPp6TVsCb64O2iMhQ0rlN2Bq+uZndLnzUCYaA/1arjx62sxoUTmm1lZ6?=
 =?us-ascii?Q?sHBebMRQYZggM2XONx9nQ0I6jnopsRyhg1TIh9W5HVVVCRTiQwgnTZTU3otL?=
 =?us-ascii?Q?VW/4PFnJNoMPrIC1tGEvDXLPT3J0pt7jLvbeFNFEYc98RwEkFwdfJVLotFI6?=
 =?us-ascii?Q?6yAN028+LUt1GiPsITcZglrFc34R7DexpC4p3OOlAFNxBL3pSgkKztSppdPe?=
 =?us-ascii?Q?5YtR9Mi2vbdWBd4r+xa8CKO6AfzVug1ee9mqW6lOmL1WMEIXfBq9WVCD4dyN?=
 =?us-ascii?Q?lRJ6DsJxI+cHIyRO2fQaroVgPJ5jJX/D/XQDl1E1xpYp89H0teDdWhpKD7BA?=
 =?us-ascii?Q?MFMLK7u1rypVI77OPULYhxTeZnFAqZZGtSHcPJTo072MQBQHc6qm0QQFTVJk?=
 =?us-ascii?Q?Qs9GbCkgv+fuTloNmnQdGyEmvXwlYssOs+++phsf9WdbMua9RUbzEp2Ih1hk?=
 =?us-ascii?Q?Jt97O3y7XA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85093c1b-668d-4f44-50e3-08dead156455
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 15:20:52.4999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHrxW1W9jSKzJD+gJLqV+CztVRo3T9IzJ74f9+GeLBr0Bt66dGZCPfv5g4uyVg+PZhTDpdKINZPJJz/YT991EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10804
X-Rspamd-Queue-Id: EAF0D4F8A63
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_FROM(0.00)[bounces-285897-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 06:15:36PM +0300, Ioana Ciornei wrote:
> This patch adds support for offloading FDB entries added on upper bond
> devices.
> 
> First of all, the call to switchdev_bridge_port_offload() is updated so
> that the notifier blocks needed for FDB events replay are available to
> the bridge core.
> 
> Using switchdev_handle_*() helpers is also necessary because each FDB
> event needs to be fanned out to any DPAA2 switch lower device. This
> triggers another change in the return type used by the
> dpaa2_switch_port_fdb_event() - from notifier types to regular errno
> types.
> 
> Handling of the SWITCHDEV_FDB_ADD_TO_DEVICE/SWITCHDEV_FDB_DEL_TO_DEVICE
> events is updated so that the newly dpaa2_switch_lag_fdb_add() /
> dpaa2_switch_lag_fdb_del() functions are called anytime a port is under
> a bond device. This will allow us to manage refcounting on FDB entries
> which are added on the upper bond devices.
> 
> The DPAA2 switch uses shared-VLAN learning which means that the vid
> parameter is not used when adding an FDB entry to HW. The current
> behavior when dealing with FDB entries with the same MAC address but
> different VLANs is to add the entry to HW every time while removal will
> get done on the first 'bridge fdb del' command issued by the user.
> 
> The same behavior is kept also for FDBs added on bond devices by keeping
> the refcount on the {vid, addr} pair while the HW operation disregards
> entirely the vid parameter.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 190 ++++++++++++++++--
>  .../ethernet/freescale/dpaa2/dpaa2-switch.h   |  22 ++
>  2 files changed, 193 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index bced37335a9e..cce0af47ca07 100644

(...)

> +static int dpaa2_switch_lag_fdb_add(struct dpaa2_switch_lag *lag,
> +				    const unsigned char *addr, u16 vid)
> +{
> +	struct ethsw_port_priv *port_priv;
> +	struct dpaa2_mac_addr *a;
> +	int err = 0;
> +
> +	mutex_lock(&lag->fdb_lock);
> +
> +	a = dpaa2_switch_mac_addr_find(&lag->fdbs, addr, vid);
> +	if (a) {
> +		refcount_inc(&a->refcount);
> +		goto out;
> +	}

Sashiko noted:

	Could this refcounting logic cause FDB entries to leak when
	ports are removed from a LAG?

	When an FDB entry is added to a bond,
	switchdev_handle_fdb_event_to_device() fans out the
	SWITCHDEV_FDB_ADD_TO_DEVICE event to all N lower switch ports,
	which calls dpaa2_switch_lag_fdb_add() N times and sets the
	refcount to N.

	If a port leaves the bond, switchdev does not emit delete events
	for existing FDBs, so the refcount remains at N. If the FDB
	entry is subsequently deleted from the bond, the delete event is
	fanned out to only the remaining N-1 ports. This would drop the
	refcount to 1 instead of 0, meaning the MAC is never removed
	from hardware and the software entry is permanently leaked.

I forgot to pass the proper context and the notifier blocks to the
switchdev_bridge_port_unoffload() call. I think this will fix the issue
raised above.

> +static bool dpaa2_switch_foreign_dev_check(const struct net_device *dev,
> +					   const struct net_device *foreign_dev)
> +{
> +	struct ethsw_port_priv *port_priv = netdev_priv(dev);
> +
> +	if (netif_is_bridge_master(foreign_dev))
> +		if (port_priv->fdb->bridge_dev == foreign_dev)
> +			return false;
> +
> +	if (netif_is_bridge_port(foreign_dev))
> +		return !dpaa2_switch_port_offloads_bridge_port(port_priv,
> +							       foreign_dev);
> +
> +	return true;
> +}

Sashiko notes:

	Does this change inadvertently break FDB offloading for
	standalone ports?

	If a user adds an FDB entry directly to a standalone switch port
	or a standalone bond, orig_dev is the standalone interface
	itself, which is neither a bridge master nor a bridge port.

	Because of this, dpaa2_switch_foreign_dev_check() will evaluate
	to true and cause dpaa2_switch_port_fdb_event() to return 0,
	silently ignoring the FDB addition. Prior to this patch, these
	entries were accepted.

No, there is no such think as a standalone switch port or a standalone
bond that also somehow handle switchdev events.

>  	INIT_WORK(&switchdev_work->work, dpaa2_switch_event_work);
>  	switchdev_work->dev = dev;
>  	switchdev_work->event = event;
> +	switchdev_work->orig_dev = orig_dev;
> +	switchdev_work->vid = fdb_info->vid;

Sashiko notes:

	Does orig_dev need a reference count here to prevent a
	use-after-free?

	Since the pointer to orig_dev is stored for the asynchronous
	switchdev work, and the work queue later uses it in
	call_switchdev_notifiers(), could the network stack unregister
	and free the upper bond or bridge device before
	dpaa2_switch_event_work() executes?

	If so, taking a reference with dev_hold(orig_dev) and releasing
	it with dev_put(orig_dev) in the worker might be necessary.

Sure, will fix it.

(...)

> @@ -3917,6 +4067,8 @@ static int dpaa2_switch_probe(struct fsl_mc_device *sw_dev)
>  		ethsw->lags[i].ethsw = ethsw;
>  		ethsw->lags[i].id = i + 1;
>  		ethsw->lags[i].in_use = 0;
> +		mutex_init(&ethsw->lags[i].fdb_lock);
> +		INIT_LIST_HEAD(&ethsw->lags[i].fdbs);
>  	}

Sashiko notes:

	Will these FDB lists be properly cleaned up when a LAG is
	destroyed?

	When the last port leaves a bond device, the LAG is marked as
	unused (lag->in_use = false), but it doesn't appear that the
	driver iterates over lag->fdbs to free the remaining FDB
	entries, which could cause a memory leak.

I think switchdev will remove the FDB entries from the ports any time a
bridge port is unoffloaded.

