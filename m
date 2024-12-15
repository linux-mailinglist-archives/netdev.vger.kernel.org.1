Return-Path: <netdev+bounces-151995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8BB9F24CE
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 17:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00DB51886181
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 16:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3D6192B9E;
	Sun, 15 Dec 2024 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="R3CjxVGv"
X-Original-To: netdev@vger.kernel.org
Received: from outbound-ip8b.ess.barracuda.com (outbound-ip8b.ess.barracuda.com [209.222.82.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0FB18FC75;
	Sun, 15 Dec 2024 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.190
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734280525; cv=fail; b=qUanbbLJMjHwgUEN6ozdc2r7R4c4TpjPmQO77woDhcSMQ88TNF+9e/K5tF6Ej3pv2m5l45ezdC5hEchCR6xZzLI0OSN/gWc2VAkdFTttTuFjGFrjn/p367GKFjOU/+t+heOjJy7qIWhEICyjpUrUdyIIq1WNlj/VgSLzNXQur94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734280525; c=relaxed/simple;
	bh=QspOdM4fMq9kvTrp/t/6naVvalvooUZLGtxWLo4ze9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=otE92t0ZUEJPcOv6CWL4L8RmfHYl9Hb5j/hVkvpZbZGsRUjqNleT58jsF5o7PK8V4PWK2MdVPmo3sl2t33TdRCGOTavZ1IOdEUMK+woNT3Rj19GqFeDjF9KXyRoKgckiguI078yZRMLuq8Vuamtsn8PsqK8iX8EpirwAd9A5mDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=R3CjxVGv; arc=fail smtp.client-ip=209.222.82.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48]) by mx-outbound20-179.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sun, 15 Dec 2024 16:34:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbDcYY8sYdfqJz/MJPaEkFL2S613zneJ/TOVDN8jTQoJ6Kvhnf2t1bN2CjIbgQro4A/3+dbYwIWvG+tNvok+NJiPZM+apwiGWdkJ/br1h3a1k1ZGPq7Ij8xeuQXQLeMwMR444XjefR2+s2vrKdxRi0HcGMAvVSMRA5B5979yor+GCIq70vK3KwODRLui6GCpEXx6Isn6YauXWNqhJhp703rmEqk5K0P2zn0h0+enZ40D4Tco1j3YP+0Wh96knv9wwGPdImPl98IjRGhzF0Emf3wWs8EoJlhZS4zLnAV4A9x6xVPKo9OobA+9Ea/9slcHPkHd5xD8aUlITuRVyftCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzZRIhVAGbEnB8JGGuIOIW9EHP59lbSwAl7pQ5Vx0Fk=;
 b=UCj1Bo945kGGFtfi6b3bWeSQdZj8wFVRcvukTfQCXPIE89vWxSB2mwrtnfNLwHgFS6YfWP+eKWoqxV75yeYbhaidzeNskbCySSW1u2edzXmjYXbeR4qH8l4lh7yy1UKEtQTmqBCd4oA6zePZQWp9w5jrC7hGeR8RgXG6hA0xtFNLFs4dA/0Sgyog+Qus3sOsIVZQOmoauE05F1ZwAGQpdRy7BJ6Hnq6evE8saGrCnIfLded8HZkPGdji8a/T4PgU4NAZdpFtaeNshtV6oBgAGy7jgfH/CWdA+ln9xRvSDwbkbzpkAZDYQ5/gREUPuZEiKJ5OAp/ezO4YpuWh25FwrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzZRIhVAGbEnB8JGGuIOIW9EHP59lbSwAl7pQ5Vx0Fk=;
 b=R3CjxVGv+gx86uveUWqb6XYVXVE+NwNaB+HFPQbPAVg+Jmqt/1bplqeZa66w/7XIx+LDFnBm8Rae+qo4jMAuY9k3gq395+mRCVglw6qEDPRAmCfoTrfDQMjZgg3n8CCqjnBvUhgkvaLD8zvA/U/BMXvLD4NgpXv5RTagKExCUj62ROtYJjHSZo7ClVBYkMGb0g4nVqG12z9lNsnd+nUELHn3SCvpTh1Eb8wHv6Z2wkl+kCTFVaYFxUIaC7jyx/SrrpreUW1OvI5bJQ7cL048mYVxsJq19g8hH8r5TJ3+IteUOR2kuuVHzIbS6fbHFgrT+XG0Vc7pN1xTJmOMFZVo3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by SA2PR10MB4570.namprd10.prod.outlook.com (2603:10b6:806:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Sun, 15 Dec
 2024 16:34:16 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448%4]) with mapi id 15.20.8251.015; Sun, 15 Dec 2024
 16:34:16 +0000
From: Robert Hodaszi <robert.hodaszi@digi.com>
To: netdev@vger.kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Hodaszi <robert.hodaszi@digi.com>
Subject: [PATCH RFC net 2/2] net: dsa: felix: fix reception from VLAN-unaware ports
Date: Sun, 15 Dec 2024 17:33:34 +0100
Message-ID: <20241215163334.615427-3-robert.hodaszi@digi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215163334.615427-1-robert.hodaszi@digi.com>
References: <20241215163334.615427-1-robert.hodaszi@digi.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::11) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|SA2PR10MB4570:EE_
X-MS-Office365-Filtering-Correlation-Id: d79cd75a-fa17-4428-5b2b-08dd1d265136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RSOIwfmpdDcXpg1HSyHfZTvv5Jou+SKSI6+/MVOK+rTs2jYkBFMWilGiK4al?=
 =?us-ascii?Q?4mVzCaymU1FIzHEgWLrg8KMUMEJYt436671xM/h+JLeBnA2li3vK2TXZGgXp?=
 =?us-ascii?Q?UipmyZ+gpXXVHig4ymuQ5TKiZUOCCJOGrJftEDEMkHiPNgyKXihC7P/3cGgF?=
 =?us-ascii?Q?S+jGXxLOoKz1DfDpn+SCxGLL+cPw6pWMfSARCDutycBCovODzUHph6Sspzm4?=
 =?us-ascii?Q?o+JaFW86/vu3YgyKHL/rixB+QpI/XEQe9JPw1/p3UO6kXmLXiEJjhJsn5ZsF?=
 =?us-ascii?Q?eYg6aQ0Ab4Ix1YJW507Nj58UwYjd1OGhPuUhf8WdGozmRjnr9Xqn51T+ISEZ?=
 =?us-ascii?Q?7O5J3vC0Rv0Bhz++VtSL/ngG/SpHNaTF5VK70T92Si3hxwRGwj7U3mkWfW/m?=
 =?us-ascii?Q?IVGeb1GT/J2q7TmIdBTKNtsZ+aTBrY1jLs9JUOHNyhMM0COTumqd6fnHG0Z+?=
 =?us-ascii?Q?Wcqf4UNOK27y1ECJHG8MsEnmDHIfbC2GYGsHXB4Ieaou1HcOEpxKqSZvxujT?=
 =?us-ascii?Q?SWMavJcICtL+nlGNg8WuH6BQ4IiKmUlrmXflz8PI1BEm8Ue1ZVIfmyUXznXo?=
 =?us-ascii?Q?SrR7PIOzptk0azocduENePwNT57ZEmUnsLyEsrabz78qE3r4aQv9Q6yW92Hs?=
 =?us-ascii?Q?KMXNtsVCIxuRXf5xLek5JFwMxsN1oxIJTGO3pHI4cinc6GmtjUbCFzVYXnb0?=
 =?us-ascii?Q?I4mg1sxfDKo5d95XwOUk77Iwn0sxtA18MFzcIy19eE/WvPi76Zznpszo3kqB?=
 =?us-ascii?Q?LKpLVO2gFvDPfdyCLSh+gj684hphh3M/ROd9pJ2HaI/hHTt6eIrk1WG01Tr8?=
 =?us-ascii?Q?UrAjgFCCFf7Yya7QsyEhx6lvHTbMGYJziqRP5hRRukoAZMuxmSKBc6V+EDQD?=
 =?us-ascii?Q?cD0K4yMEU2sjc+VkgWqAEKpGmruO/pbmtv9w60gCQ0Run1rYMoSaONbVZmHd?=
 =?us-ascii?Q?zzPZt/63UD7xoC1dWkNooLdH7vQJVZmABFX0KZbBvJ2e8DW+iC/QadCSVVAf?=
 =?us-ascii?Q?iYbtb2aY6w9CyMbgPY73nzU3EPPmL400KABCjR36CQHJD4IaBLfGK7lD2RKl?=
 =?us-ascii?Q?Mu4h+KH5igW2KfTuVkGRkNtKEWwXEKcMYTXlValUObSbG2pvDljPBn0ofmNL?=
 =?us-ascii?Q?fVn5R5Io+G+rymNUy1Yaz5cwtpc7QjyTxFDHoC0YUlF0mqlBaNvwv7FeogTc?=
 =?us-ascii?Q?h4qOvyMZic1cGjcRgA4Kk4UGHsqDRshVlrVM+3Y4Tv2VDwshDuGBWspOvu5o?=
 =?us-ascii?Q?rRHQKpk8mb/+B+GoVmpiKWOm13qMtwQJAM8u7AEDnRGIHlOoydVZkIUZ2phK?=
 =?us-ascii?Q?G6OwxhcbdfN2qcBoxHBg52hhaD6aEcwaSoz/FnfHLtB/lF+1aUszEeq/SQdV?=
 =?us-ascii?Q?XsgFMPx+Yr5hA7QbRCDgoI6TTIoycWgP985Z5yvfn+ANecedQi3e8xt6OZzB?=
 =?us-ascii?Q?iQxkCiVa4Dt/dLMfNtz8O982VWoeUuyF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GN1SGeTtKqPZXyyhbBOct7zujHG84UtMck2O8qZUBs8TZMq68XN0DjgqPS/w?=
 =?us-ascii?Q?JLd3Be7cj+ywuji4EZmR0p6m0miV8na/pWCJK98Rgbsd7OfaqHhUPS9JgwW+?=
 =?us-ascii?Q?3gw6RKPTFrbqNkVAX4PiSzHsJLCQKygHEXvxHhld/YNjbcURiv4M0UuZu9Bg?=
 =?us-ascii?Q?xUxu+qlFxnsx042x94npKHtyCFWUE2HwozzCREEy+WSQnyVjhxQ/2lEmCVJu?=
 =?us-ascii?Q?K5rlo8cRoXnQB9ZDyCS9S6+aheUfsVMiUleDiiHQS5wjAtTXmWo5tVX8k4Bv?=
 =?us-ascii?Q?AgXVdEtIzrRLY9G+YzJ+xCtfDZZxhJ2fQxdtUWHGJTSkv4FJ9oCFYi0SVzP9?=
 =?us-ascii?Q?/g6H6jTHGZ+9O1Kpa8/jPNExeSJCasaQ2j/ivJY8OJ9NP3zzZV0Z8ED54gba?=
 =?us-ascii?Q?NgRMes5RF9MfdUQuWCM6dCgJsbGqdJT9fkZeFjVqauvSHW+gy9qLuV4JoznW?=
 =?us-ascii?Q?iBEDbjgipq4SLFwbRaaRkdDkd5nVO3LST44EsegREgVYPvAn3Yr+Nl4+MbQn?=
 =?us-ascii?Q?l686olTD16TQqe0pHt5zQFlDES5RlUs3MVqYMwQ3CyRxpLIuErRN7/IanecF?=
 =?us-ascii?Q?VC71tglOoTkiQ25KUYOh+IlGj3Z3q5OF4Q5f56Pye981cCZphreCC5GOgqr5?=
 =?us-ascii?Q?nEl1VjkD6qjCwWURn/8vwsynB3xak9awlHn8Xshb8WpEw7CwbfMGOUsmg38B?=
 =?us-ascii?Q?hkSxw22snhmUhYixYWwFMNvzkgHQvi8Vm8QmZx2Pvywcyi54rRB3YljJGDug?=
 =?us-ascii?Q?6CDP/GZ7ByrHRe7MprHNglyO9H0Sm4cJcIbV4o+pAS60F4aznNyVXnjJv5go?=
 =?us-ascii?Q?e0KZ6Mgx5CYESWIjbMs+vZUf78ayPg24MyV7GA2Gyxb6mw7tr/1aqp5g9E3v?=
 =?us-ascii?Q?u2lr9Auk7yEq0wVxcje8YW+ZUlC7ZCAoY/BSgiR1vb3y1l56d0xWiZbj+jNu?=
 =?us-ascii?Q?jz0Vyp9sJqxu1j1D4CQRPeZhvbKoLIdenwttip7xYK9AxIPsei0ooz+nEhIf?=
 =?us-ascii?Q?xP9Z36O/PXZaGKG22QR9VoAoAJY9ocveYDnUgAXRx9LAUo6yE2jP4Mh4kBNZ?=
 =?us-ascii?Q?vNxU6k6qJZd/qta5epOKwYplvf4CSIQeLq71t/ADJlu8J4QuEO/lBdg3pwff?=
 =?us-ascii?Q?pmhBcUWz1bAs4+vxWKfsjPPnBZAy6SfoPJ+Jn6vTdPBIlhGGM+M9LjrfAawx?=
 =?us-ascii?Q?CAgZoGQS7yVHGej4n01S21rEvH6eLbL4eszxG9IS+cFe5QZwLk2lMvFAJfGr?=
 =?us-ascii?Q?ucNmCGKuZN2jpTvqbcPg4jFqM9t4dY5JHNuIxKbk6+RqiUFEdxSzhl2778dB?=
 =?us-ascii?Q?XZLEzxQR6Yw9JSGU+HMRTTL5i/RnBLlt921tehqAgWCOoordPT2wUiElofJ2?=
 =?us-ascii?Q?iNf97shq/9stPdczj5cSJ0V1faTyZsMmI7tKydBnPSmRb4u27dEbYyFGQ9NG?=
 =?us-ascii?Q?zDEXy/M0SpMZnlREvLs9v3kZrcusLZdsB+z9mMNxvzKPgFS6f8EAhPYp7AGr?=
 =?us-ascii?Q?MG2IUtJXD7r13/lzPZxUyDpl+LBWSaOAyeg6MvTj2zTCg/4S0GV2eVnmadHa?=
 =?us-ascii?Q?WWiWahVlmn/AdSnL5ikbl8zXY/CBXFl/pxPlfSka?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79cd75a-fa17-4428-5b2b-08dd1d265136
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2024 16:34:16.6302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fg9hD8TaDcgwTSz8CvUTHSa/Ggokryyge4DMnh+/tPhFKkDR/8cH9VZPW1ufIkEBbbQ3bXOYy3oyo8DHkKK6iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4570
X-BESS-ID: 1734280449-105299-13407-1828-3
X-BESS-VER: 2019.1_20241212.2019
X-BESS-Apparent-Source-IP: 104.47.73.48
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaWxqZAVgZQMDHJOC3N1NjI3N
	zUIs002TTZ0iApzRJIJSanmAGRUm0sAPScAnVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261133 [from 
	cloudscan16-190.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

In ocelot-8021q mode, the driver always enables
'untag_vlan_aware_bridge_pvid' to do software VLAN untagging, no matter
if tagging is enabled on the port (VLAN-aware) or not (VLAN-unaware).
That corrupts packets on VLAN-unaware ports.

Exclude the port from VLAN untagging by setting the 'not_tagged' port
flag on VLAN-unaware ports.

Fixes: f1288fd7293b ("net: dsa: felix: fix VLAN tag loss on CPU reception with ocelot-8021q")
Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
---
 drivers/net/dsa/ocelot/felix.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 3aa9c997018a..8a2650a428ec 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -273,6 +273,7 @@ static int felix_tag_8021q_vlan_add(struct dsa_switch *ds, int port, u16 vid,
 	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct dsa_port *cpu_dp;
 	int err;
+	bool tagging_enabled;
 
 	/* tag_8021q.c assumes we are implementing this via port VLAN
 	 * membership, which we aren't. So we don't need to add any VCAP filter
@@ -281,9 +282,11 @@ static int felix_tag_8021q_vlan_add(struct dsa_switch *ds, int port, u16 vid,
 	if (!dsa_port_is_user(dp))
 		return 0;
 
+	tagging_enabled = dsa_port_is_vlan_filtering(dp);
+
 	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
 		err = felix_tag_8021q_vlan_add_rx(ds, port, cpu_dp->index, vid,
-						  dsa_port_is_vlan_filtering(dp));
+						  tagging_enabled);
 		if (err)
 			return err;
 	}
@@ -292,6 +295,8 @@ static int felix_tag_8021q_vlan_add(struct dsa_switch *ds, int port, u16 vid,
 	if (err)
 		goto add_tx_failed;
 
+	dp->not_tagged = !tagging_enabled;
+
 	return 0;
 
 add_tx_failed:
@@ -320,6 +325,8 @@ static int felix_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
 	if (err)
 		goto del_tx_failed;
 
+	dp->not_tagged = 0;
+
 	return 0;
 
 del_tx_failed:
-- 
2.43.0


