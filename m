Return-Path: <netdev+bounces-270367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIsEGGnZwGn6NQQAu9opvQ
	(envelope-from <netdev+bounces-270367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 07:10:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B09682ECDE7
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 07:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24539300B9C0
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 06:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CEE2848A0;
	Mon, 23 Mar 2026 06:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OAVdRnQh"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013004.outbound.protection.outlook.com [52.101.83.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6F12BEC4E;
	Mon, 23 Mar 2026 06:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774246003; cv=fail; b=I7VE7Njd3S3HUCzUxpOczZJr4Vi/ePtT+XCAGyAimApK80lvsKquT8W+uoiS4vOWtVFaO18TJWBKOXqGJso7mUj9dXTk2pt4uSd/tqgl5Bq8jCP8Eip2aPOvtg1wGT3TnuYjUIAR64+ca2dntoFCKcpp2GWp1miWDh8XthFWbO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774246003; c=relaxed/simple;
	bh=aLYxflmNmJc0OcXvXGpbL4DFtdIc9EZPwT37lXnra0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gXquh7hFZ5p1zerPEPTsTiGTkF2TaOUV+g3qDmi6IStAyLgzvkIGffWrhBaPYix39e8F7gsE8/TG3gW5fRTquDDDveKXAx3BY+gJmY0Sr17/BvizO0K0iE0Yqv34aPeYssSAEV2CL7/DXqNuX5aqRr4HmbAkJ4FVg+1XaosIr80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OAVdRnQh; arc=fail smtp.client-ip=52.101.83.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXrmouo2d/y7MrhkBTGjyhQ5s9mshc2k1DDGkdHXe7TerrFmAvRZ+mZSz4Tx97wYWs96G9afXgv3Jk/TCrhlcVdYhikWwUtIGWEtbGK7cc5DbHYQ/J4+hMPFhjI+zdOb2O+i4/D/XZQb1NROaBJbRqSkVeHC0GE7o8nOaCv86HhRsykf3t7zO/sfUKUvBogNQx4SjgqTs7VJXhag1NGpman7oFnb4lndjny/omA+7h3MTFz5qy23yE7jc8yf4RHsXQXISKrY22FA7nS1+VZgHFLGKc//TdzEVesxH3/2By3hjG2exHXL1CFZw6WldQ3s/jOioLqoD2+Dl5ZtQI77Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Biz3Z8TYdAr8j8h6kXOQCq+Y3rJg0Nc/Tp8eWGxfvXE=;
 b=QOsf6YNiyMQgy8S/IZyfn8wPcnIsOBRArPpo87Qukl2K85UJH2nZtnMC1f5rPWAFv0939a6PPMgNxjLxLa9CY6z42Mmll6R4oHStYSWGbsbY//OVNrxuZWqR8HR3Qq1urCEI5+ST3kTO/LLlojZiaCsmMQnZSsriZfPFl4mS9VV5d9eU+pO/HRuliShgGD+N/Cp3yTdpd/cZ5IVbM5gLREzXuTfpKW3hp0PBiCsiVw8ybcEHSF02vhzDOpK89Rc35E6AlOwJaAVfHHpRdwLUIzZ449c/30cV9UimWdDa+rtRLxDOTiqHozJLmyn+e+jP1v6YnOe62aqer7e4aMbw1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Biz3Z8TYdAr8j8h6kXOQCq+Y3rJg0Nc/Tp8eWGxfvXE=;
 b=OAVdRnQhulgvkC6rD7cdmI4qZLhjtgyJtNURPwGZLhcY3r9ccDR6LYvPbWj/uOLmHuFKKmf7kNC2X/JyrSq1fcTRPuyAW52s7HyCdGq5tQltUWwC0aR4//ew+U0IbVVTmE3qfrkA8mzFfZU6YWJUZFGUO0z7+65INj+ja01C6iMp5SbcJYYatxDryc4J/8EJ5MqD7R9xtnF3TrDhRXZtDquCyVKhHF39k+519MlNlTWnIkhFSebqeTLTPMjWwSBgb/fqakDw9myISN8UxHiWFNZelwblB0+ibfAWE80GyAZoXhg3IG8MWAC77RfAdPx5CCaIFPVTfBELaXCZl9Y18w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by PAXPR04MB8911.eurprd04.prod.outlook.com (2603:10a6:102:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 06:06:10 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 06:06:34 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 04/14] net: enetc: add basic operations to the FDB table
Date: Mon, 23 Mar 2026 14:07:42 +0800
Message-Id: <20260323060752.1157031-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323060752.1157031-1-wei.fang@nxp.com>
References: <20260323060752.1157031-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|PAXPR04MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e94c9e-ca22-4a18-ef5b-08de88a2555b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|921020|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Nv306Di0i8ywRVIcbyY4HUkV/426wOVjgoMmbCJczE8zxKLU9tINffaGjdJqE4j0crRmE2GKTjPgNgiVgdJduEy7esosGNyhOmHADZzMsj0i2lcbwQDWiEHiS0MVS9ODuDsuj5HaDoiX8xWMndS0r3T6SIeM7H0GdUBU0MvbHtxKgiLY8rDteNlMqdLFD+YwMfroiZbXCbQvMz7KF18kpjoPq+FC2+Sj4grt3mtirUgLEAZ+s1GWXXyxeSEcP4FQQzWg6qhsCtuYG+d0VbKd8SaySYNqYYqxlGlXn7y+R2XGNS8MdexcBeBX4rcqitLlAGmVfwzcxWl3oMm7Wlf7xs+nvE1E8bsOGLRbglvGq4Jv4DE9X0mdK1aRd0VPzTUnhZd7rW3AOPnDMUdFmwEfhXzS2VzSciEVLxG8S5VGStlw+KT7d8NT+DVqd5biZ4q5+FQBuJW48/qRFD+yllYPnXhle9fdyzO4RNbhVqtuE8zsqqbitQ0ak9n9RrY3ATNV9nfThjxKV1zqy6sa4ehInFoCxWgEBrmCa/0XeNMARZtn2fd0a54sQl8tNd8LKCGIABIeu9vBlLONEcdX0deaorzdV8weDYHVaS8qT4vCl/k0DRWpQ+bumqMIhtKLjVgEmnBFGGI0q8scc9saLTNW4wQa+/kOT8YxxWqgm0urzWbcgFwiCgLQlBGl+Q0DRJB4c+ESJ9laZsmjL36yBIrBYLMt7tfrtOpjQbi/hMIMcMl1MWL/dlbRN9gCNVlAXYV/lOm0eKgsgkr6gdRjc+foFXfNHJHtbZLN23zld0OkH6P923WR7C+fggM8yp+l035K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(921020)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yDX3g/F2rGKiq+9ZRHjKd524rZPPwmtRn/FCGUyX7Fq7+PjhAArCVSjpQzKj?=
 =?us-ascii?Q?mc4T9bM+1GMR4s86bw0Cf9m5jyrPQNnuK7qQNBgUH4PVH0y9BzNpz7gaIxJH?=
 =?us-ascii?Q?AQjX9hUxWDiTp1QIZl4/iXgBXD7B/sHp8P5mf7Y4ui8RYa1ux/RtYoiWdBNf?=
 =?us-ascii?Q?aBXR7lEdBRJRF2NdpYbr4LXmquzv3vnTQ8W1Ttq6TwyxxtQ5LXVId0v38gFZ?=
 =?us-ascii?Q?9KW0JGKCqD3eUSDedDyI5pWLKkfI5OLy9V62eT8ifvEh40NBUnXZbfGjNFYf?=
 =?us-ascii?Q?87fET34v9WeOfwPQUWx/ir/kmL6Ol/99qNbc4O6qG1jw43ihVLGpbCDKod9e?=
 =?us-ascii?Q?iSV77ILlANr87p4yAjcY70wToQwrYB4KQ+mnzY2vSgGqd064DxVwuQk/nTBv?=
 =?us-ascii?Q?0XILnD/Fyj+qJGRgstjcfXzo6GvMo24HPUuPNIwhO/8wJNfdOqrKF3VIlvEH?=
 =?us-ascii?Q?GSRvdFgeKJvn/njR3Dtt6lvIrQ4m2bIQMiieDGPbPGSLVZbNz1EUcI3wYfb/?=
 =?us-ascii?Q?ibBYOMRuhEixrdOe12PAhpFhfQGQKOA4gzNreBN2ZKlMsnn1xYwXfK0bEbK0?=
 =?us-ascii?Q?Gml4/m1zRG4UigM82SK3wFNO85IZfxIYijopH9aQ73uu27OC/CkIemd5IJTX?=
 =?us-ascii?Q?hLWf9UIotAN5zYUP6LBVtyIJWfp08AGnwKz9mszBa9BAh+zqEgiJjY2UfTav?=
 =?us-ascii?Q?kaiZHCk1cyFZXJ8W3eTnRUBUaDsm9omEhlKb1tUNolVEtWrpVThNxevp40F1?=
 =?us-ascii?Q?DCGqsLcccinFvU0n1YCa7c0nrWztqs4rkqpuLuRtOXtWyWlopUTmxAAe/bqV?=
 =?us-ascii?Q?rptECFCL8FPp33HlEr85Pb8QTGLMkZ61hvcoQkfziQOXtPAhKCjCgYLkEIpw?=
 =?us-ascii?Q?+6U0vFgfq2oYpUEUKjl7oVXBcm1dmG3yvB9pleEe0sBH1kGubdKGDtC14b4U?=
 =?us-ascii?Q?m0BSMfTsrRwusEhXycuOPF2u4C4U27orPFDLjD1CuTz53yP3cBAaSCVAle77?=
 =?us-ascii?Q?UMsqS8vfXfyv4YX3Oy7OSHWKvLxiDmOZIERvo29QavUN09diSqGyqVdEWfFf?=
 =?us-ascii?Q?XroE+0IdqtklKLmZCJoe4ElYXnHkgOLyexH1zYFhydc2nrrKkKLp08AGjmta?=
 =?us-ascii?Q?dDYZhWksr4+lbvC+Ca+zFDsFgPooGbOJ9aik/ro83C3r8fHHyRzw26z7Y4H6?=
 =?us-ascii?Q?jVZJTdIXY+jUV8G7LTJptH48eC/cST0i1qsawKx9D9KijSj8uX9uMh9VpfHs?=
 =?us-ascii?Q?g3KYvdmjTAq1pkuAbJCJrG1vCY3GmxRxOmWHmDvA79sotWzIY9Cyi1HeDEhm?=
 =?us-ascii?Q?Gw7ogcbbved0PGYR8QjjaPfMlb46dsKZfnqTjVQW0imWpmgpBlCo0ub3jWZW?=
 =?us-ascii?Q?4v9GJ7qXQtV8Ly93U8Ba7JD+XxhN7HzpD/8In623i5yH0VLaGm4sEpNEqQTJ?=
 =?us-ascii?Q?DuTt3WlMng7Hu3RhOpxLaxWqj1r3oHVaouKnc3S8BfoBX+s6XAwk6yUZVyrw?=
 =?us-ascii?Q?ErBdiUaEE3JREAEXkiKFGaNF4ZLVJBxEs6JEojP5bACp1u49JUVjQHbAjO0r?=
 =?us-ascii?Q?bQzqOGf4mLu6+tS9fxs+gHd1Nj4eP0gDa1PNecxT+b2sfVXUqkTGRgaxIq7z?=
 =?us-ascii?Q?OoS3LD1pA14EBZG3Qe3cZt4xvaC3eVIJlPtnGQd+kefY8RKR8oxh5RVwt1Gr?=
 =?us-ascii?Q?hiwywP1Ncb0m7ycA89gtM/04hGeYKpBhnwnlhBaN7N2qj8pb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e94c9e-ca22-4a18-ef5b-08de88a2555b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:06:34.1955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuVj+2e1u/0RhJEV2LzPA+e1t/bQVF5hH0ZVDCbqb1LYzW5EKh/amB9uFcBCMGn0/ezNh25q1QHT6RlZVxPddg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8911
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270367-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B09682ECDE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The FDB table is used for MAC learning lookups and MAC forwarding lookups.
Each table entry includes information such as a FID and MAC address that
may be unicast or multicast and a forwarding destination field containing
a port bitmap identifying the associated port(s) with the MAC address.
FDB table entries can be static or dynamic. Static entries are added from
software whereby dynamic entries are added either by software or by the
hardware as MAC addresses are learned in the datapath.

The FDB table can only be managed by the command BD ring using table
management protocol version 2.0. Table management command operations Add,
Delete, Update and Query are supported. And the FDB table supports three
access methods: Entry ID, Exact Match Key Element and Search. This patch
adds the following basic supports to the FDB table.

ntmp_fdbt_update_entry() - update the configuration element data of a
specified FDB entry

ntmp_fdbt_delete_entry() - delete a specified FDB entry

ntmp_fdbt_add_entry() - add an entry into the FDB table

ntmp_fdbt_search_port_entry() - Search the FDB entry on the specified
port based on RESUME_ENTRY_ID.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 199 ++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |  59 ++++++
 include/linux/fsl/ntmp.h                      |  67 ++++++
 3 files changed, 325 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 703752995e93..f6f4316169b6 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -20,11 +20,15 @@
 /* Define NTMP Table ID */
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
+#define NTMP_FDBT_ID			15
 
 /* Generic Update Actions for most tables */
 #define NTMP_GEN_UA_CFGEU		BIT(0)
 #define NTMP_GEN_UA_STSEU		BIT(1)
 
+/* Query Action: 0: Full query, 1: Only query entry ID */
+#define NTMP_QA_ENTRY_ID		1
+
 #define NTMP_ENTRY_ID_SIZE		4
 #define RSST_ENTRY_NUM			64
 #define RSST_STSE_DATA_SIZE(n)		((n) * 8)
@@ -225,6 +229,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "MAC Address Filter Table";
 	case NTMP_RSST_ID:
 		return "RSS Table";
+	case NTMP_FDBT_ID:
+		return "FDB Table";
 	default:
 		return "Unknown Table";
 	}
@@ -453,5 +459,198 @@ int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
 }
 EXPORT_SYMBOL_GPL(ntmp_rsst_query_entry);
 
+/**
+ * ntmp_fdbt_add_entry - add an entry into the FDB table
+ * @user: target ntmp_user struct
+ * @entry_id: returned value, the entry ID of the new added entry
+ * @keye: key element data
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
+			const struct fdbt_keye_data *keye,
+			const struct fdbt_cfge_data *cfge)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct fdbt_req_ua),
+	};
+	struct fdbt_resp_query *resp;
+	struct fdbt_req_ua *req;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, NTMP_QA_ENTRY_ID,
+		      NTMP_GEN_UA_CFGEU);
+	req->ak.exact.keye = *keye;
+	req->cfge = *cfge;
+
+	len = NTMP_LEN(data.size, sizeof(*resp));
+	/* The entry ID is allotted by hardware, so we need to perform
+	 * a query action after the add action to get the entry ID from
+	 * hardware.
+	 */
+	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_AQ, NTMP_AM_EXACT_KEY);
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err) {
+		dev_err(user->dev, "Failed to add %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+		goto end;
+	}
+
+	if (entry_id) {
+		resp = (struct fdbt_resp_query *)req;
+		*entry_id = le32_to_cpu(resp->entry_id);
+	}
+
+end:
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_add_entry);
+
+/**
+ * ntmp_fdbt_update_entry - update the configuration element data of the
+ * specified FDB entry
+ * @user: target ntmp_user struct
+ * @entry_id: the specified entry ID of the FDB table
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_update_entry(struct ntmp_user *user, u32 entry_id,
+			   const struct fdbt_cfge_data *cfge)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct fdbt_req_ua),
+	};
+	struct fdbt_req_ua *req;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, NTMP_GEN_UA_CFGEU);
+	req->ak.eid.entry_id = cpu_to_le32(entry_id);
+	req->cfge = *cfge;
+
+	/* Request header */
+	len = NTMP_LEN(data.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err)
+		dev_err(user->dev, "Failed to update %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_update_entry);
+
+/**
+ * ntmp_fdbt_delete_entry - delete the specified FDB entry
+ * @user: target ntmp_user struct
+ * @entry_id: the specified ID of the FDB entry
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	u32 req_len = sizeof(struct fdbt_req_qd);
+
+	return ntmp_delete_entry_by_id(user, NTMP_FDBT_ID,
+				       user->tbl.fdbt_ver,
+				       entry_id, req_len,
+				       NTMP_STATUS_RESP_LEN);
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_entry);
+
+/**
+ * ntmp_fdbt_search_port_entry - Search the FDB entry on the specified
+ * port based on RESUME_ENTRY_ID
+ * @user: target ntmp_user struct
+ * @port: the specified switch port ID
+ * @resume_entry_id: it is both an input and an output. As an input, it
+ * represents the FDB entry ID to be searched. If it is a NULL entry ID,
+ * it indicates that the first FDB entry for that port is being searched.
+ * As an output, it represents the next FDB entry ID to be searched.
+ * @entry: returned value, the response data of the searched FDB entry
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
+				u32 *resume_entry_id,
+				struct fdbt_entry_data *entry)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct fdbt_req_qd),
+	};
+	struct fdbt_resp_query *resp;
+	struct fdbt_req_qd *req;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, 0);
+	req->ak.search.resume_eid = cpu_to_le32(*resume_entry_id);
+	req->ak.search.cfge.port_bitmap = cpu_to_le32(BIT(port));
+	/* Match CFGE_DATA[PORT_BITMAP] field */
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_PORT_BITMAP;
+
+	/* Request header */
+	len = NTMP_LEN(data.size, sizeof(*resp));
+	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_QUERY, NTMP_AM_SEARCH);
+
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err) {
+		dev_err(user->dev,
+			"Failed to search %s entry on port %d, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), port, ERR_PTR(err));
+		goto end;
+	}
+
+	if (!cbd.resp_hdr.num_matched) {
+		entry->entry_id = NTMP_NULL_ENTRY_ID;
+		*resume_entry_id = NTMP_NULL_ENTRY_ID;
+		goto end;
+	}
+
+	resp = (struct fdbt_resp_query *)req;
+	*resume_entry_id = le32_to_cpu(resp->status);
+	entry->entry_id = le32_to_cpu(resp->entry_id);
+	entry->keye = resp->keye;
+	entry->cfge = resp->cfge;
+	entry->acte = resp->acte;
+
+end:
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_search_port_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 34394e40fddd..9e2a18cf3507 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -11,6 +11,7 @@
 #include <linux/fsl/ntmp.h>
 
 #define NTMP_EID_REQ_LEN	8
+#define NTMP_STATUS_RESP_LEN	4
 #define NETC_CBDR_BD_NUM	256
 
 union netc_cbd {
@@ -27,6 +28,7 @@ union netc_cbd {
 #define NTMP_CMD_QUERY		BIT(2)
 #define NTMP_CMD_ADD		BIT(3)
 #define NTMP_CMD_QU		(NTMP_CMD_QUERY | NTMP_CMD_UPDATE)
+#define NTMP_CMD_AQ		(NTMP_CMD_ADD | NTMP_CMD_QUERY)
 		u8 access_method;
 #define NTMP_ACCESS_METHOD	GENMASK(7, 4)
 #define NTMP_AM_ENTRY_ID	0
@@ -101,4 +103,61 @@ struct rsst_req_update {
 	u8 groups[];
 };
 
+/* Access Key Format of FDB Table */
+struct fdbt_ak_eid {
+	__le32 entry_id;
+	__le32 resv[7];
+};
+
+struct fdbt_ak_exact {
+	struct fdbt_keye_data keye;
+	__le32 resv[5];
+};
+
+struct fdbt_ak_search {
+	__le32 resume_eid;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+	u8 keye_mc;
+#define FDBT_KEYE_MAC		GENMASK(1, 0)
+	u8 cfge_mc;
+#define FDBT_CFGE_MC		GENMASK(2, 0)
+#define FDBT_CFGE_MC_ANY		0
+#define FDBT_CFGE_MC_DYNAMIC		1
+#define FDBT_CFGE_MC_PORT_BITMAP	2
+#define FDBT_CFGE_MC_DYNAMIC_AND_PORT_BITMAP	3
+	u8 acte_mc;
+#define FDBT_ACTE_MC		BIT(0)
+};
+
+union fdbt_access_key {
+	struct fdbt_ak_eid eid;
+	struct fdbt_ak_exact exact;
+	struct fdbt_ak_search search;
+};
+
+/* FDB Table Request Data Buffer Format of Update and Add actions */
+struct fdbt_req_ua {
+	struct ntmp_cmn_req_data crd;
+	union fdbt_access_key ak;
+	struct fdbt_cfge_data cfge;
+};
+
+/* FDB Table Request Data Buffer Format of Query and Delete actions */
+struct fdbt_req_qd {
+	struct ntmp_cmn_req_data crd;
+	union fdbt_access_key ak;
+};
+
+/* FDB Table Response Data Buffer Format of Query action */
+struct fdbt_resp_query {
+	__le32 status;
+	__le32 entry_id;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+	u8 resv[3];
+};
+
 #endif
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 916dc4fe7de3..ba56d4ae0ff4 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -6,6 +6,8 @@
 #include <linux/bitops.h>
 #include <linux/if_ether.h>
 
+#define NTMP_NULL_ENTRY_ID		0xffffffffU
+
 struct maft_keye_data {
 	u8 mac_addr[ETH_ALEN];
 	__le16 resv;
@@ -29,6 +31,7 @@ struct netc_cbdr_regs {
 struct netc_tbl_vers {
 	u8 maft_ver;
 	u8 rsst_ver;
+	u8 fdbt_ver;
 };
 
 struct netc_cbdr {
@@ -61,6 +64,36 @@ struct maft_entry_data {
 	struct maft_cfge_data cfge;
 };
 
+struct fdbt_keye_data {
+	u8 mac_addr[ETH_ALEN]; /* big-endian */
+	__le16 resv0;
+	__le16 fid;
+#define FDBT_FID		GENMASK(11, 0)
+	__le16 resv1;
+};
+
+struct fdbt_cfge_data {
+	__le32 port_bitmap;
+#define FDBT_PORT_BITMAP	GENMASK(23, 0)
+	__le32 cfg;
+#define FDBT_OETEID		GENMASK(1, 0)
+#define FDBT_EPORT		GENMASK(6, 2)
+#define FDBT_IMIRE		BIT(7)
+#define FDBT_CTD		GENMASK(10, 9)
+#define FDBT_DYNAMIC		BIT(11)
+#define FDBT_TIMECAPE		BIT(12)
+	__le32 et_eid;
+};
+
+struct fdbt_entry_data {
+	u32 entry_id;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+#define FDBT_ACT_CNT		GENMASK(6, 0)
+#define FDBT_ACT_FLAG		BIT(7)
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
@@ -76,6 +109,15 @@ int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
 			   int count);
 int ntmp_rsst_query_entry(struct ntmp_user *user,
 			  u32 *table, int count);
+int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
+			const struct fdbt_keye_data *keye,
+			const struct fdbt_cfge_data *cfge);
+int ntmp_fdbt_update_entry(struct ntmp_user *user, u32 entry_id,
+			   const struct fdbt_cfge_data *cfge);
+int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id);
+int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
+				u32 *resume_entry_id,
+				struct fdbt_entry_data *entry);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
@@ -116,6 +158,31 @@ static inline int ntmp_rsst_query_entry(struct ntmp_user *user,
 	return 0;
 }
 
+static inline int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
+				      const struct fdbt_keye_data *keye,
+				      const struct fdbt_cfge_data *data)
+{
+	return 0;
+}
+
+static inline int ntmp_fdbt_update_entry(struct ntmp_user *user, u32 entry_id,
+					 const struct fdbt_cfge_data *cfge)
+{
+	return 0;
+}
+
+static inline int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	return 0;
+}
+
+static inline int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
+					      u32 *resume_entry_id,
+					      struct fdbt_entry_data *entry)
+{
+	return 0;
+}
+
 #endif
 
 #endif
-- 
2.34.1


