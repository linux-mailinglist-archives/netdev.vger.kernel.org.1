Return-Path: <netdev+bounces-285865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IBgOp/0/Wn5lAAAu9opvQ
	(envelope-from <netdev+bounces-285865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:35:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1AB4F7CAE
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80A473002F51
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 14:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3316B3EDADB;
	Fri,  8 May 2026 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K/nCH6pN"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B5E3806C2;
	Fri,  8 May 2026 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778250891; cv=fail; b=G3u9vrdvJ0XvxHz2wzIOl4IemOgjz4klZ1JLRVyrHO4ZygzPXcGYQVwZMot3uwyNz1K3lsFFgNCHdhX4WAzOKLQ7pvY1wb6rQcAlZnjxUQcMwq/R5EZXGXs2Ut5Y/y1uE7hSQ9OH61L/u4rzdNwGi0zcrkGi0ARCgeI0W0HzEmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778250891; c=relaxed/simple;
	bh=tFsOY2VoLOEdXBtfPypcIClsCu4s8ePvdYvhs27S+UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Moa/DILzeRbinDYaENWlLWs6gTCgBXpFFlZOU7wHBNpuaxa0EE8fcwnHeO20dpHIGWA6FlpBy1lGHRei06MhNJN9Tg5lTM+9djVju69BzqFF5WnIWx+SwOo3UlrwLoX8Cn5Hn0shz2AcWdSe7SU7P89IvZbab5IDopZp+hEW+So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K/nCH6pN; arc=fail smtp.client-ip=52.101.69.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnQPZvL6MEiLcMCwNGFp06F5VkwttV7PLHEYBzk7R5AVOxYPaz/6s8EjPzFlaEFRi6cmf+sGgGR50EoyNRRkM65Qlu4cmQM1Cjvv62bW+6VlPm0ml6duflmLfhWAlfwOaR5OvLTVyJDOcpndj7UsJyLJHRJ0w/AdHzED74g/sE3iaBf5lBJAA9u1QE3kk27FF2ALG5+0/WTJhv+ItdYgg1dYZOTUXIYVFitF1gPa4WOC1OMDjCHsAXPGFFiGTtnq/vRvw/b/hUV7BUtc8SUaBM8J80yf1mtwJI3QuEDA8q0pAvm54Gh3Vj6wsWoskoWOoS8QxFXotY9L28EnJ8Eh9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XduUpI3NLu/eFhcrCytaFnLvXoGxy2/yQYLYHHcl7xw=;
 b=umR0WYjia+HzDOqr0haH2NpIVYH3DuPF1QYmphY6DvtvtZMOBidw2oFXYY/hNnpHoayyBwMspK0q3i6oEwHGdLPmMnNhyB+aXV4HTD0AJslUeNETBDemUcUE9s3TrNDPeloCPutaRhId0lAIp9OoadncyhlD8PiCn5B4+m6MpqB9dky5Kvv59v9/gu7X+j4f1C6cnRDhEohhIS93CQJSTN0uBBsunCFdz0ICVfkstQALydguc2Fk6Rl1QvE3CQRFSkmyEjNhQubTAKkuO0FQzRrI176ZlqzZbN3R4m0sGIqVRJk+X0IAOLmBoJVQURm408YEJV9sEje3yIoYa9crGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XduUpI3NLu/eFhcrCytaFnLvXoGxy2/yQYLYHHcl7xw=;
 b=K/nCH6pNQx5b1PhBJ5MLZbI/3+gD+JfbhaFOk4ko//bo2qISAwmD2B0BBEXYpVSt27gRlGlYA6jYoTaav0h4GWblEukQ+52rWtG6z+8G01rjStWi7YPm+QLKHlrLV+W7u2KdO7fsTWieYtDeu+tOy8r3HekOCeBwinWDSBRIoJ73DDaqmsTVhDKFbw13LeBgifwUgo69lqfUT2oxkPvDxrRWwvT4dCeoQ+5KJloI9ssAvFpbsClj5ZCWXDEkQKWw7sB7C3CLlMsKLQz6SR/KUmGBMJLkiITmGqSBMHS+B0hcE8fmXpyVYK4SciTFknO5QOuUnJaPTzk2mV2TtU6UzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by PA1PR04MB10795.eurprd04.prod.outlook.com
 (2603:10a6:102:491::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 14:34:45 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 14:34:45 +0000
Date: Fri, 8 May 2026 17:34:40 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/13] dpaa2-switch: check early if an FDB entry
 should be added
Message-ID: <ohambdgrexlqpssr3qgsqmby5t564zzd64rz5o3lu2snmnilrx@na3igzdxtcgh>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
 <20260506151540.1242997-8-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506151540.1242997-8-ioana.ciornei@nxp.com>
X-ClientProxiedBy: AM8P251CA0011.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::16) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|PA1PR04MB10795:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe44074-1358-4b7d-5568-08dead0ef2f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7s1k5IU3yTiPvEu5a13/7rtQljF0xrZxTKmQjRYTCvl+JD/liEDiQj/kreXQtYGU51LkDdhutrOAkjr3uhukSjWzv8B68jBDw42X1Gz8gpIiiVZI9pZNTr0cuq+gjbzVyj0g98+AnLAZChBSq5Ir25xaOz+I7c6vYHyqlS/7HcUvmnx9XzzyiUoFOpT9rfp5WZmKj9NAv2OPwpCkoHgeDzjgSbv161I2dxMUTGS0qZ5SvYWwPK4yL4CPk7oVOLZ4fP3DlKRj+t8W1eVVXB6Qybgh7frHG2rfA5r2yx0/rIKa8aBMn4hdHHhL0ZoF53IsggblhkXvXIFew9W4Jarxvk6Go+fl0pD+N49qcuW6DekZBw5zkGRLTcXfwDRF0/3tS/Na+zk9WgqNmxcmSuq6+LQQoajRdZeA/rOFq/XY1lIP8Bx4BE6zgOsWvUGS1BuAr+0JFYLgbj6KoAB7dmyjFKqtYxHYKYI1Emy1w37rKtjpcdJCKfR6mLV7kZkNviEjXX83siZonlmMTz1lVwZawWZ7l987offToV0+/thkPtfS0RPSarjhs8XbV3YfgP5oT0gy6Dxn6KLF3PLc0K5ii2Wne2mzJF8kFwRR8XSfdfY7u8goJGYdSVREoL7+ne12mroLwB+FOX9MR6C0KB95XD1U1OsFKHfipD72+cpYr93GGLE30on34tR/4tL9Tsh3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dcmVaUEJOVHSBoWm3EdTcd0gKock8h3qPUU4KsG9ccMwjCe5WzsTt7K48Oqg?=
 =?us-ascii?Q?h97I97Bo0w/Fr7+QXjCfc5S8ZiiOwaMjjV/hWFXtSpeXP+DIcdmhGmWZR1ep?=
 =?us-ascii?Q?4HWoZu/GEAy1oSezLbIquTPPYi7Lc3NSEVa904I6l3Y6WkHPoPWZfWFQJADz?=
 =?us-ascii?Q?yMsz4/yWD/h5R5Cf6ArfG60YQnmiQljLughpJLTIL3qBl8KdzCMLPIfESWv7?=
 =?us-ascii?Q?TKMbcEVilo4Ik5Fc8YL8sPJbatkwxA45mzbVmu9dYNGLzuorF5UXCzLSv2A/?=
 =?us-ascii?Q?3bicOgucEynRv0ryQYZ5hB9aJNP+cwjVsDQ4vk0cCL758XWgq3u7/R6UfCxk?=
 =?us-ascii?Q?WqMcwyhLHE9pRorfTWl4KstImoB8uWU0lcLWF8aA4KG6jEqjestZPP73Wy5/?=
 =?us-ascii?Q?O6BWzN/l+E1ZslY1EZKPyO/u18SfmgVGRBrNwVlKg5oNxF2bM2qcic0lIlfD?=
 =?us-ascii?Q?Cn+f/kq2DVxqg1sdptQnzC/NgMzFnFzXz6G3HodpIxabqs9EFoK422XL+D/f?=
 =?us-ascii?Q?qv7paFP06dmUznFLO6QVeyfQjtr9hFN5ZISphUl5lpvMCQHXOlfgCyTQgEXq?=
 =?us-ascii?Q?SSFyhrUNM+ogCb78EXpjTs/keee1t2uW+oQhvnBfoYqUnvX49PQ6Gb2aQhH/?=
 =?us-ascii?Q?OeUN1s9b+JEKixPWQfmlwoq4WVgFQipyVnJi3lRAC9KvweUnSLhE+ckY0yBS?=
 =?us-ascii?Q?6Gkvs+RWoqNdeE7BKHMa1HB+jmGwydWsuLGLwYsbDnThGLPHBbkOEgIcWGC7?=
 =?us-ascii?Q?fs6kcjBSwuVpfBEiNWt56N7zNCB9JhbbSGh7C8Zukw5r9Kbn/3DUY4OVRM/V?=
 =?us-ascii?Q?5PtptvP8cCipCz8XjfYqeaOWWn4ZOt0Sn4Acn5n7tV2rSs6mltgn6xxG+2gQ?=
 =?us-ascii?Q?ht89f4hr0zQoFYECZUUjHHJnOq1A910oBuhZHQZxdCnnbWKYZNMZ/gMgknqV?=
 =?us-ascii?Q?Nu62Gyefh8o6rVmEM6gF0Nrkill+P8Vc7Es/D4g/y2kqNNNhu9V2SmPdsSRm?=
 =?us-ascii?Q?8xE8Y/0bMdiOqmojMK9L0hhcelaJztgRw32KWafzmyKkRftFxLf6Utror3WZ?=
 =?us-ascii?Q?0QHP2PvNVP1Bc0DO8gLUalSU8bSd3ioqlLPxOQcw53YSSX5cX0foZCRPxlaZ?=
 =?us-ascii?Q?/QoU3yItrGkNdO8m087sBvcAQNhnpmOdVf8H8euVkdE4DIdxKWMZ1ByuDcA1?=
 =?us-ascii?Q?mHmnxovb8bHcGpetPiF5MMWmJWaj0uFll3yYf04aPEEFP9bMR1+7LiJScnoI?=
 =?us-ascii?Q?XfibEZvNtioK3HuDItsDbLNFbgHv3h6dWeaVw1W98ffDO7vYorNIoOi0JZIO?=
 =?us-ascii?Q?aaCmntapXjtkzgDtMX8lGJRuhELfxWkcrYyjODQpOTje7A4fuOiemZuLKl28?=
 =?us-ascii?Q?lPiSZWmasF9thzolE/vte/JXUSv8mGKkUNt+pMUp/HGoSpBeK+VK8PiPgWXt?=
 =?us-ascii?Q?ogYWMsdIudA4oU+uiFJos0Ry0EagzQXGdUHs+AONKrlD1XmHeScC9H+sJfOc?=
 =?us-ascii?Q?vJUjQ4nZJfvjgosX/Yq2RHHQChH3oTI7guF4hAs4TdRJrfhoDT/1FMYkrBAx?=
 =?us-ascii?Q?SYCmgp3m61/X3ovQNJRD1EBgEu6fMpkptYHJGiPnd5Mqbor6ZtVag42tOAoJ?=
 =?us-ascii?Q?AlidBpLWw12xapElZAh3s+5LUxGuhkLQKBrdHQc0qgqyPGD9qo0Zs70EdZ0r?=
 =?us-ascii?Q?gWmxCD4S7YGT8ZziEw3r7xvbQWip/1iEaekfJChBj7D8i9tKUpmt3VNE5uOW?=
 =?us-ascii?Q?+u1XGlSf3A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe44074-1358-4b7d-5568-08dead0ef2f5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 14:34:45.1663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFXEpOOi45M37g17RxZ3VtbY5puYtOxF8VkJq46LtJZBvf4kLhazrToDpZPEZ/oF6e0pB3qfqeD6jZ+t03y0Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10795
X-Rspamd-Queue-Id: ED1AB4F7CAE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_FROM(0.00)[bounces-285865-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 06:15:34PM +0300, Ioana Ciornei wrote:
> Instead of waiting until the last moment to check if an FDB entry should
> be added to HW, move the check earlier (before even scheduling the work
> item) so that we don't just waste time.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index 476ee8b46921..a057fd85bd27 100644

(...)

>  	if (!dpaa2_switch_port_dev_check(dev))
>  		return NOTIFY_DONE;
>  
> +	if (!fdb_info->added_by_user || fdb_info->is_local)
> +		return NOTIFY_DONE;
> +

Sashiko notes:

	This problem wasn't introduced by this patch, but looking at the
	surrounding context in this function, is there a pre-existing
	out-of-bounds read issue?

	Could reading port_priv->ethsw_data happen before ensuring the
	device belongs to the dpaa2-switch driver?

	Since switchdev notifiers are called globally for all network
	devices, an event on a device with zero private data (like a
	dummy interface) would cause netdev_priv(dev) to point to the
	end of the device allocation.

	If the allocation ends at a page boundary, would accessing
	ethsw_data trigger a KASAN panic or a page fault when an
	unprivileged user creates a dummy interface in a network
	namespace and adds an FDB entry?

I don't think that can happen since dpaa2_switch_port_fdb_event() is
called using switchdev_handle_fdb_event_to_device() which checks if the
interface is a dpaa2-switch one using the dpaa2_switch_port_dev_check()
callback.


