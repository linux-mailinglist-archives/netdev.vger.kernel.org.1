Return-Path: <netdev+bounces-307139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A0WWIwTXVGqbfgAAu9opvQ
	(envelope-from <netdev+bounces-307139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:16:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C1274AD33
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:16:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=I3EydoxN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307139-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307139-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BD92307E5CD
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCDF40683F;
	Mon, 13 Jul 2026 12:10:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013038.outbound.protection.outlook.com [40.107.162.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F610369208;
	Mon, 13 Jul 2026 12:10:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944601; cv=fail; b=Spf1hhaNnIsp2pdkuaDu69wXXfGWcdPTCUcQp2AWqhWkEkpVE3Nd2S2MPVb55okpQVNC4y74z+p99INCPy/2VCyVZOtplJQVlYLMhsQcARahovkSQl/0PoqM5nJU1NJndtnKgopY8fUSp/D9CBRGEqph1OBaj109IQgDbYdBnDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944601; c=relaxed/simple;
	bh=N/9Ul9pwyawNtNFJAWhNRqinAGsWzE9OwNMqOShjprs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ipjFOH35nCqzN0+4HsN9nlo+xg0gzumJCEqDSrD44ROr7bE51DRxIcn578oH7SCUjXaZSxjqjYFmeTW/Xs0YUhslr5WLps6wh1cVy0bmYI2u+bcuiCetnEPrf4ZLmEFql3AYyT/PiZLnWtFXxvZMkjzg7qttkhKQnDaecaQW0LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I3EydoxN; arc=fail smtp.client-ip=40.107.162.38
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Avy1nSFRcZeIZb31KCUy5F4wyI0mVHARbd75bprkwFsRq+0PSEWhubEmD5+oMHetVYi2ZP9l0RHTmUMia9EeFpc06wKwbWQVnyPm56/GM3B0hlkPl1Jt0so6rcUQMaIwwmxaoAjiB2kOA4CwZgpmNn2otYgUt3VAbFt7268qfR/N3usGLlROJ6LSFlxgFVsm6RkDu5vXk6OHvY4YeHG3qjvRnorKIg27vGriiea/CzvZSvtTsJPgalqsgZ7itPImFv5o2Kf4nHozhRXgur0PXBBn+/zkgYhDCImrB9glYv+NNQfHtTg6Cnoxnf3fVf46ZwNfsnurjtOiDJBrlx1H6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IESx8KMf1zzKexzW8e0JN5degDR/bOS50Ii6sV/Vbpk=;
 b=NeaJOhBkSvi0qdfjY8x0JroNWoJFZ4hSrTKqnzYBCzrslMGWJll2dbsFdwtt1t4EzdALoOgYxzCQATLrGEDlQL5e4QL+Frasy7fYvlN1IQBc97ddI6AZqQNwiQoqacS89PA3L9tZU8yKGSw0vyrjP2wDxmY8hzhgV0uaGZNQVRQEB6trSE9NR+al9rA/qmb+HzJYmEc0lF6V8czQxeuc12TV1fkfQdjnJfcDWRazjVIaEUmQsRNot2MPQr3P772xTjNhl5VlNmV81YmJgkIuoOZ6ugLH/O6MKp6TFZStI4Ow8XTK3JtIFa4jhPOcBjJBLArnfA+n89N9eidh5HDA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IESx8KMf1zzKexzW8e0JN5degDR/bOS50Ii6sV/Vbpk=;
 b=I3EydoxNnnb0f2MOwsAqotucN6yx89n8NMzA/AYtOi4jHrJPWd3X63ZPkklLTmv4edWRLIqL3VsiRoqeyp5wU3uZhG5KFvY/xxIKtiw6DbC8VbH30BGhu5/cQCgYvJRz39AJIv2mgjsf96SKZoHTC6G+KL/8Jd7McUnGauc/wHeluYB4X4pEXO26+N6mmwCmO1H1UF61T+RV4yAt1KTcvv9fNlEC6B2S2ddlZwmcm9gkMDdKy8wyiQYGJZBGPCH4usHxnB7lTyP03uObkdxNKh3NF6fdVfFrGxQmu6eTUTtkvzbuh5smU4oOuYeE/7/FepILxiowx8B+hCwJZiDT5Q==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by GVXPR04MB10538.eurprd04.prod.outlook.com
 (2603:10a6:150:21a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 12:09:55 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0181.014; Mon, 13 Jul 2026
 12:09:55 +0000
Date: Mon, 13 Jul 2026 15:09:51 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dpaa2-eth: put MAC endpoint device on disconnect
Message-ID: <2hmqffpehpo74yb6vttsl3ve35itowijxrhln5btfysyzjjntm@xgtqfweiqyub>
References: <20260708111738.750391-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708111738.750391-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: AS4PR10CA0004.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::8) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|GVXPR04MB10538:EE_
X-MS-Office365-Filtering-Correlation-Id: a071d2d3-7c7c-45ad-1664-08dee0d7a6d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|19092799006|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	u41MaAqh3OZZvETVT61oPbDaewEohGWPCFI3wVUOF69e9o8QWsLDmXWlmka75iTyxmaFaFMU8Ny/TfI9tnIHTc+MVR4xhAkqhOqjzIZ5E9rrKBnYMsqECuvcvGMGDhMskz80HYvOI00Bjg3CEURfBH7zLqLOXdk7D+ANHW5f/Gd5em8qRI0z/hBCHZGijYK3aHOHTS8Zck+NftrkOKmbcHUNXKhT3EtttnGRKk2eaGKlc876FM//6WhGlUFHU32qSBi20b+cj6E5gib21dhI+9M3N66u5i1ZG2kLAupG57ubrdmFGdP1fes0zLZJvJc3iqGxjCARgHt2IIuH2RNflanm2XpoP04V9qBZkz//JabfX9CELuJFxrX2LRgDWR1uZUGBSv8c3LQWxdw+hsm/NRvTuzsBs8AEUZ/rvydCrOzYayzexuNa+JCmiNvqgAhp6F03YqCpQVE4n7x3sVjkOLuDlWilXhXalHXEK5Gc4HtdXZX+1k0MsUf2ZhBf+v0IM/kdP7goebI9Rajq4T7dTmSrDmnIzsFg4qvcR/s5BL41TXSH68nu3Zuh5qWshFOcqrcwRmhSZIUBWYjYRhRKJd/A/DjyZVlW43txBA5G88Bb0qtcv8eZ+GKSwsjTae8OBOWu50HFMwtRNYCVSFNZSSULqRSMum9MjlnnXOVwRyQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(19092799006)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zrdtRQfHlta2eT3Ea+1LEAIh4W7mhQz8dI7bm1HwLkpjsqble94+Tyi8hj0m?=
 =?us-ascii?Q?DIorfOCkf6HsaqYe96wZ3Q6DdokdUiD40SVsA5l36dWRI4WnUUvtDQZXrRxg?=
 =?us-ascii?Q?itIZU1cnpB0A6+UwhL5GjUpfg5dxVl5byC0HxxyaEcqVf2bXmUcBxuiOBXd+?=
 =?us-ascii?Q?4kXTcrwD6sYReX2fLwP8lYRsbGVmw/se3mimvaS5oGl15iCQBonITRcIFq0o?=
 =?us-ascii?Q?G8hjrGzIaNO7q43ahdKfJcfwu3QBm1m7l65ywbfWJsRTUJOEFmGaOtgu4rkE?=
 =?us-ascii?Q?Uyq8vwToSN+HKx2XE/2MnQiji+mBaEsof9d1ilYGQfXoITCOg6j/czuuIOfE?=
 =?us-ascii?Q?t+j9S7lfeXe/6qzqtWBbnbEtVBpzOF5SX375H0/wYR0X/PFTxFbnRyf3MFsM?=
 =?us-ascii?Q?z3m19pyhDC8OtK/bDhNqYJsNmx15QFPw3mrpFyI/ipBN+KVoX6j+Aa+yIzgQ?=
 =?us-ascii?Q?FHAymzEVal1KJtbZ241XOoiYmfyZY0+M+lhljN1MS4EXEskdzwqIz3p4Fxjm?=
 =?us-ascii?Q?Ypa3cP3PZFwTGzDwuMp3G3/isPE95SxrPOxLLE+tqq0h6bPFM5XL0v7s8qhw?=
 =?us-ascii?Q?dyTl5kPJOfLl02BOZGdo5QwUf8pQgsvZV0tiWJ227bodGQ9PTTcvlEDaLEeB?=
 =?us-ascii?Q?GOABaGviD5lys3Gb4zdC4LukaDPvbBXxj6gdWswtF6Ki2CABGIyC1qTZZeUS?=
 =?us-ascii?Q?T2Xgv0O48VDshpK4SV2i82uNm9r81MMyTblAHJUFH5+oW9lsoYfa29GPvCNx?=
 =?us-ascii?Q?oj45yw3v+Li/6qx3XgCGo1ZCmHtjj2bMeNigzUkeNmlcTLTZkS8GZy28cd8N?=
 =?us-ascii?Q?3RgB2ho/PBeNo9IQGvPKW1kuTfbS/WiF0SNfu40p6pBkhBYWPAaJe4NTucp6?=
 =?us-ascii?Q?RmEDbt3n+BUFBeR6tX1sohSrcEqRnt/B6IVz4Tan4p15RF8H+KO080vK7pHT?=
 =?us-ascii?Q?yXPy9tZM8emkcmjWV+Udev9ZuZzLS8xOv1mVduWjlcxWNngicqnAfBJDIttu?=
 =?us-ascii?Q?EUjxqiLCLZPCYjYlXWbVeuwAUIEQ9qFUNqotarl+beTAZHVOjOTwvAFapmsq?=
 =?us-ascii?Q?K3v+LbeRiEQjyInPVeZpyiA7y9KwWy22/2YciHYG6hTe07XMGkElJdxUQsJ/?=
 =?us-ascii?Q?sPEl8Un1qngD8AHcu4fEmRdicPV63++DSFo73vjSOoK3QMFXOtma9L9SNkcm?=
 =?us-ascii?Q?grr7pQk1Flbl+9EMYYxkpcT6rzuIS+ULabssiIUm0K8n+BCU/o0L/U+URqO4?=
 =?us-ascii?Q?z519zpnfcdbslZxrzRp6XXhxqPhXMf65Y6QZAL6UsIWkh3ZrIHexb3PZcMWo?=
 =?us-ascii?Q?cm0ymY0ho5Wo0Fdmg2iMWvFBp4jkUn0XFcWBI/s2CWCT0qROfEN03A0Waff7?=
 =?us-ascii?Q?eAuw0l96sVGK6JdHxNq2FEr97Gi42nG2CKzA7AQ6Ze6/8HoYBPSPoF2aVwyt?=
 =?us-ascii?Q?PFgcykFC+cB6f7BESec85vCdf75rSEZfiQTe65HUDvTFgqi+CEuw7fpEu65j?=
 =?us-ascii?Q?b+QN2v1EXjy1IFdUy3BkZBGJkSlbA0XYoXcQ9vj4hHAtFZRogl7MPoA+ryuF?=
 =?us-ascii?Q?8dRBgZSYMSvoEW13bFO843oe+JeVWKHlxhpdWtJRnlfrin0+XZ5CKBc4TVjP?=
 =?us-ascii?Q?1OpU4/oTxbYunYZk6yoN3602QtRKv2PohSZEhhg5rUgshaCofL9u2HK40g2c?=
 =?us-ascii?Q?3zZZwtT+o+SkbK6LJ4+bEqisi3d3NZZZN/3Rv8R1coDKhTMKQLWzfDpA+9/I?=
 =?us-ascii?Q?8fLZ6wAbqw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a071d2d3-7c7c-45ad-1664-08dee0d7a6d2
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 12:09:55.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSTKHSbDFeQdV96ItgmF/MGnuB77YybEGeUt/Toc9qP5yRb/H+5VCWNCkAPch+1pqp6J6XqqdOVSchzGYttKdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10538
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307139-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lgs201920130244@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xgtqfweiqyub:mid,nxp.com:from_mime,nxp.com:email,nxp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5C1274AD33

On Wed, Jul 08, 2026 at 07:17:37PM +0800, Guangshuo Li wrote:
> fsl_mc_get_endpoint() returns the MAC endpoint device with a reference
> taken through device_find_child(). The Ethernet connect path stores that
> device in mac->mc_dev and keeps it for the lifetime of the connected MAC
> object.
> 
> However, the disconnect path only disconnects and closes the MAC before
> freeing the dpaa2_mac object. It does not drop the endpoint device
> reference stored in mac->mc_dev, so every successful connect leaks that
> device reference when the MAC is later disconnected.
> 
> Drop the endpoint device reference after closing the MAC and before
> freeing the dpaa2_mac object.
> 
> Fixes: 719479230893 ("dpaa2-eth: add MAC/PHY support through phylink")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Next time, please mention the targeted tree (net-next vs net).

