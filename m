Return-Path: <netdev+bounces-285760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGvIFNvD/WkpigAAu9opvQ
	(envelope-from <netdev+bounces-285760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 13:07:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA0C4F57BA
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 13:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52E55305F14E
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 11:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A68835D615;
	Fri,  8 May 2026 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FPjblLAh"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011053.outbound.protection.outlook.com [52.101.65.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1C63451AA;
	Fri,  8 May 2026 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778238024; cv=fail; b=JAKQmMGojLjNlj6NiLGHXqz5NpyXqX3v2iTy13GetOMQRtl1U2LraSRSNt6wzYn/NZ8ucHIY3VJU0cNsLK5pu8nS7RTH7fJK/sS8K0zZ+5nlnhbFoEbAfTzfRy147Gl3qPaXbF7zhTVNdkK+49h1BrXMgrd5iE0zCZz6gpXtT+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778238024; c=relaxed/simple;
	bh=TjYPeC9t9jvQJAl4Ze/pA+6daWXVXBVBIUeRxv7z9Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ceZYcRZsS6sAV0b34GyDIg6uq+R/q4oMvGLkWZ2yokb9Y3javlw2HUOcc33yTonVjQMWjYFCFhXO/atT5UCH2hSqk7szMPrDYMbqPrMdjewZTllfJaY1VJr3YPeH8c8GC6YK6qDTxri/NVRUH3QtD1Gjqf5EsVlwLBpkbxLNTqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FPjblLAh; arc=fail smtp.client-ip=52.101.65.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yD/Jokjtm7bbMZA9PhLbTr7OjL6lybyZdOT5sI4itHrs7j7Jn54jXa9C3AmwGhKNsfVFghSMSQHQ4qHDM5Sv3qggYoN3zHdGMIDbxk5De61rTAaE2v32m6RUmnw3jAAKnkOh5Af9ouCBGmLBuE17dTqbTnYoZ3ez9rcZuDjbElMaPzFygsIqx5gLdqgXs0M6fYHmLLH6a/gn4xR0t1WqE8a4zrgM7F1hleqWqW/AbIuc5bCRHO1Jtm58w3ON2JNU2GRhv8Jfw60mea0fauSI+S8PFbj2gEKAbU5qlVi2WzKudajQEVgAukF2CLsQYwN057y8dygmCYBmCHEo6QMPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEvR4dYxLZ/qAXa7r20flSVBSe6u8QwVkUOLZj4uoKU=;
 b=Z1KU7H25MDKJRTuaNcBg3bnUvEThkLCWdfcPD4fPuLhgx7tAgIS+BN2jjG909Y7tOY0NZsCZtwohqz/hdpRE97a1W7bdRxbV3OjMml+gOdTAtDR78eehsn0fBZLnY8kHU8x+xMBjyYula4+5LfpIIhaeU681Dw2iZzeuJzdJYoVQUVOfnrrIjGoGXLnFJsRrYRaFBVhDY4RW3H6ZNBPf3NGoPKof11bKhtHUZa4fOiHlMLafMa+JehKOrt0n79PHZfraBKW4+sRloBdqnGsIjg88hr9LbblYZBq0VkxCfCm1NiLh3a04FVhJ3EmIbeHtmX51hHZ6RE1GEhPu3L1LBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEvR4dYxLZ/qAXa7r20flSVBSe6u8QwVkUOLZj4uoKU=;
 b=FPjblLAhsiVsH9ji4QT/T2MWL39Y/KmNp29g1NCjpqpQGUG3sM0pgCfSxya7D8HVEGNl+2x+EemcRRESio+uDyDi0vodRdZCIk1iL7OPb2dT5mGwtRfCVWTCew+1OGkljy373dOoHI7ia/sEqTfMJ/fd4o8C3vEoVd6kqWAFv49dr5CVV+yIfC0bnvSIGTMU/SdfD3VReFV1pvaZ8eMGMQk4RT8Rbld4lnEK9mv+qTD9LyIs08FTRYI5ggNeI19Ept4VX4orDNs+aa4jsCy7vH8yBvyYmiubaVeMfUfGbzQdTZc5UnP/V933hZ+mSxWYpkx4aaykfhusGTrkxsVu7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by AS8PR04MB7720.eurprd04.prod.outlook.com
 (2603:10a6:20b:299::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 11:00:20 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 11:00:19 +0000
Date: Fri, 8 May 2026 14:00:14 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 03/13] dpaa2-switch: change
 dpaa2_switch_port_set_fdb() function prototype
Message-ID: <omabgs6f4zcf2vymbjdojw5cpoydbwur4tkytmpiv6awm3ao7i@fcahx3jga52t>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
 <20260506151540.1242997-4-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506151540.1242997-4-ioana.ciornei@nxp.com>
X-ClientProxiedBy: AS4P251CA0012.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::13) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|AS8PR04MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b7be5c-83d0-48ed-1b6d-08deacf0fe8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZX+G26gygUUMTlVVMI78dbcs7IqJ2AprFoCub7nF0N60BUBMpoJhHj2uq++sD9HFQM14gFSTcLW/AS0bWz7D3Tt05iyKnOd7CgdwKWTSt2q/R1eLKlTbPcMfS9tEcgNz6UvYoejmIOFHJ7RpBhlv0CYoT9izRXieBdfn9+zd/8m4DEDAjn4tlJFtbSNAQBDUal7EJTXmokOsRVIRu9hSR9F6hP5+hFRhEDyDgz3bACxRctlMMWlWisMRmSqyAv1uMPfrxbJSgAmZgbjlUa6zJXFZ8jU0aTwqhuHAgJPmpaJyrGjmXYk8Kma+Jbt5fFX4/EpHcvhcZI23pI2Y8LNjyBDLYJbkVoF8gWtklQPIljc+ucQ+06OEvSjU9BugapJ3DmqYEgonbo+Epbkyo/k8140oglq6Q68ayHjamjcp+gNvnnwj9E2nNtvClFHqqZT7zmRBSJ26IcbHhsdZKkul1QcxwFN4QuMxR1aGJycNM7tRixh8pjRYcOuTsAW/cWJi3JJp/NBX2eVz2qFdSvBhq1wHrysWIQsSrLLSRHuRlREMNH6FPgVJp5rV7oMgK+/18bmzS2qL/dBhcF5X6n3sYPojwUFw5+gj4qkt3G67QRSps/cwxVLbD75PWaJ/Z/npwaOl1L2ZSqBe5nZp4o4roUu6bQUWWxN7WSQqdiNlLZnToW2IeAHMhSWckIFVQlSi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RdpY567hMf0uF6+HlJvrfvasHvHVeR1SddZ75nqG1AEPVoPE37WYpGdr3zYO?=
 =?us-ascii?Q?QLHzBhQp8cOil0yj3XvYbInBAmPKjO97Sf300FNdLTaf5Rv7zcXXjBAbUNLE?=
 =?us-ascii?Q?NSCcrs4xW3bcaDnRLBQiAmGjzQlyzH25efUdbqycH9sXKfHj+AWLTp6H+qvC?=
 =?us-ascii?Q?A9/QRqirFpr8nVhk7tjP/+y9UJyT8YAiKPV38RAen9b5nnoJOdLpHMvVV3Md?=
 =?us-ascii?Q?B8KY1tvL4TLvZmjmr+VNPnBULPrtEt4DtwEbfX1sZcv5xr4ZLhl0jnWZo8Gn?=
 =?us-ascii?Q?ndbAOGQy3UmRJ2YNhOuHH8ZlcjFtt9ZFtfhE/UesvlE5DgUWH3jXGAiABCJ/?=
 =?us-ascii?Q?yYtN6HS9OqgCrmnBZ0rDQr1jQzy9pB9X1Xrs/12GBn5vkJED352ZhMACxIa1?=
 =?us-ascii?Q?IafWhyTEroDQrgkim+FsaQ/8JkM+N9Z0AFMwBOIDBkCKXDC8nfuX4Gnuk/14?=
 =?us-ascii?Q?+cxSUkIDIrMdrvwZPixcp4PAUgpZ5Df3MzRDUigQQ71XsZwqNeyQIGyOAmh/?=
 =?us-ascii?Q?kld84zBTk3pLktLb7VgfEPZ3lVT98i6c6MJ//KKIe6BtIy5PLEVAeDgt5Qsc?=
 =?us-ascii?Q?254lqjH983Ukez2n3vpwRy0D+v/SMuqJHtvJaLwZyy7uIRJ5ASSHlWA9u+7I?=
 =?us-ascii?Q?mrDiolwfSlK6NtT7TZDk/KqfwYlLNVuE0SZwtGwlJcyEt4ReUM/C9rXJUxVO?=
 =?us-ascii?Q?ORWcmfX8ev7tR9FsjYFnSMUh8mPk7ZGaQZu9z6xQpUcrrUIJO7InAuDVhdez?=
 =?us-ascii?Q?hIRFXALlgYVtf9KX6vnrzbBvdbzvVS8Q5gkyJSNXG/Kunpj/1Nusd7Uos6lC?=
 =?us-ascii?Q?g7qQGEZB91DosrL390eGPONTNAM9vb9Gx33ZEHaA95jUfW4caLaqqa65tGMc?=
 =?us-ascii?Q?60wh8P/kDu6rbmkvKONlpYvLoXLZMsBGDxmCsd8BxPD6Nl6phzsuKZJ7v+2o?=
 =?us-ascii?Q?iHC2UMX/3SnG3/WDkUpvcT8ZF7L9Fq7t88Y+MGaPAcSv5N/3OSnFvwbm/pUc?=
 =?us-ascii?Q?1zPNDGQiRjwDcIo4vaF/150p1sjh9bcfMSi4qV0Y1uJrsaEZ6dANgCh+zXs+?=
 =?us-ascii?Q?0l60kiibnN50zjzJUsCeR1P530i6jdfeeQW6P6L+vYKLkz7yxnZ7ZozSfR2V?=
 =?us-ascii?Q?0aOu+3VsAmnAoyOrBcAxAyhFAuUxXHpYCrnI4p0n+Jyt3HRjIAC8hYvbXBsa?=
 =?us-ascii?Q?MEkwUN0jv88lWQCEMz9ljV+I6fo75NLY70QhvJ2KKLI4oaMdBfTtccPXiEzf?=
 =?us-ascii?Q?X1nxYg1hVEdhy/ot12XHvQO/DaNGFCVskrsZJm5heLCpq+Btm2zGRJexWWNs?=
 =?us-ascii?Q?IlfudHwzIQ4Pt+rF0Jn61b1DSAxHuIqjrU43t6YbVtwdCXJWQHY2CFXggBvX?=
 =?us-ascii?Q?Oyn242ZOu8LjF9DwfQ4BGZBicpTOt3JGTv9KqBiNOEub6yIMXpzWJcVMtA6o?=
 =?us-ascii?Q?w2kmbK4ztmDWNMx+XxcVZ2CQQ2wO13q06jIrPGtat0TaQhLVN5lBNmCiQjBB?=
 =?us-ascii?Q?00dzNuuI15h2uqjuTl4z2Yv4/CPMQSxGDf4JuPp6o4M5c0UO3Tni0sXRZhla?=
 =?us-ascii?Q?5Q4TlUwVdGCe7LEzgDlPJo5uJHl1JMCVcfzKJFmQ5/urHxO8NEg9rnV0jSwx?=
 =?us-ascii?Q?KqXry+PjQui3ZGTN6/DQ4Vk4k9/ZY8LRQThgv8X/+fLdy7a2pguu5xGlSLlh?=
 =?us-ascii?Q?fRHH4JBEE+Xtf1pCHsTtXpp0zyxtD9gCJnRCW+aBuHLVDEUSowQtcgKFM2bj?=
 =?us-ascii?Q?og5B/lOVwQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b7be5c-83d0-48ed-1b6d-08deacf0fe8c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 11:00:19.8165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVIeYgmVKFr2C1UZzuY27MMC9/+XDl7bc6Iyg+ALEXS0ysb9qg8y011t4j1YvjqS9Hsd3XBDgEp8+YLOOugJfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7720
X-Rspamd-Queue-Id: AAA0C4F57BA
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
	TAGGED_FROM(0.00)[bounces-285760-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 06:15:30PM +0300, Ioana Ciornei wrote:
> Since there dpaa2_switch_port_set_fdb() never fails and its return value
> was never checked, change its prototype to return void.
> 
> Also, instead of determining if the DPAA2 port is joining or leaving an
> upper based on the value of the 'bridge_dev' parameter, add the
> 'linking' parameter to explicitly specify the action. This will enable
> us to pass the upper device that we are joining/leaving in all possible
> cases. This will get used in the next patches to determine what kind of
> device the upper is: a bridge or a bond.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 33 +++++++++----------
>  1 file changed, 15 insertions(+), 18 deletions(-)

(...)

> @@ -83,13 +82,13 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
>  
>  		if (!fdb) {
>  			port_priv->fdb->bridge_dev = NULL;
> -			return 0;
> +			return;
>  		}
>  
>  		port_priv->fdb = fdb;
>  		port_priv->fdb->in_use = true;
>  		port_priv->fdb->bridge_dev = NULL;
> -		return 0;
> +		return;


Shahiko notes:
	This problem wasn't introduced by this patch, but does this leak
	the previous FDB tracking structure?  When a port leaves a
	bridge or bond (when linking is false), it assigns the newly
	allocated fdb to port_priv->fdb and sets in_use to true.
	However, the in_use flag of the old FDB is never cleared.  If
	this port was the last user of the shared FDB, does that FDB
	remain permanently leaked? Over time, repeated topology changes
	could exhaust all FDBs. Once exhausted,
	dpaa2_switch_fdb_get_unused() would return NULL, which seems
	like it would cause the leaving port to keep its shared FDB,
	potentially leaking traffic between standalone ports and active
	bridges.

That is not true. In case port_priv is the last user of the shared FDB,
aka the last port that leaves the last bridge as noted in the code
comment, then dpaa2_switch_fdb_get_unused() will return NULL indicating
this condition. In this case, port_priv will continue to use the current
FDB which is the correct action since it's certain that this is the only
user of the FDB.


(...)

> @@ -2381,7 +2378,7 @@ static int dpaa2_switch_port_bond_join(struct net_device *netdev,
>  	u8 lag_id;
>  
>  	/* Setup the egress flood policy (broadcast, unknown unicast) */
> -	dpaa2_switch_port_set_fdb(port_priv, bond_dev);
> +	dpaa2_switch_port_set_fdb(port_priv, bond_dev, true);

Sashiko notes:
	This problem wasn't introduced by this patch, but if a port
	joins a bond that is already enslaved to a bridge, does this
	split the bond across different FDBs?

	If dpaa2_switch_port_bond_join() is called, it first executes
	dpaa2_switch_port_set_fdb(..., bond_dev, true), adopting the
	bond's shared FDB.

	Immediately after, it calls dpaa2_switch_port_bridge_join(),
	which executes dpaa2_switch_port_set_fdb(..., bridge_dev, true).

	If the bridge contains another standalone DPAA2 port, the logic
	will match that port and execute: if (other_port_priv) {
	port_priv->fdb->in_use = false; port_priv->fdb->bridge_dev =
	NULL; port_priv->fdb = other_port_priv->fdb; }

	Because port_priv->fdb is the bond's shared FDB, doesn't this
	incorrectly mark the bond's active FDB as unused while other
	bond slaves are still actively using it?


There is no such problem as the one described above.

If a port joins a bond that is already under a bridge, then the joining
port will use the FDB shared by all the ports under that same bridge.

Also, any other bond slaves already under the bridged bond will be
already using the same FDB.

Ioana

