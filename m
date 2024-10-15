Return-Path: <netdev+bounces-135787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1884B99F392
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 785C5B21CA9
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45DF1F9EB8;
	Tue, 15 Oct 2024 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="HU+dXS9H"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3433C1F4FBB
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011594; cv=fail; b=ti3qWvgeVOxZ5nUvjAbp7unu+RekEYIOTSt6aL6JP788dlxctKBSUomnUaBOvCClXzE3V7hR/QcTry00ecGMFZRXd+BexKEHCDedJo9jBF8Xt4r/iaVDYA7QqBoYlQVSb6gWiocZiaVQUUjyvVmx9zfT1xh9JFq02Ro9ARuxkG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011594; c=relaxed/simple;
	bh=07A2N/b28n/u59nTYk0xtg0N7IDeA+zlBQ0+dtfqAZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K0ca4rpm6rIcT/CB9NtrkGz4i0CCtSey5BQl4j6UVcDHf4nka9taMWaT1+NshJZFmeFrITbALTdV2euMNEEPyLINO9a0Q1963CYipqrD5BTZRy5V9lehXJ06pHl7ujQHQkbK5WM4LuZ/QpYlNPj5gXaUJUEzonN7kA9yAoL/IDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=HU+dXS9H; arc=fail smtp.client-ip=185.183.29.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2172.outbound.protection.outlook.com [104.47.17.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 9C5C434005A;
	Tue, 15 Oct 2024 16:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r20CxdOnnCXtluUNo2xSs2ZHZbcYU3EdDfNr+LAtNBJsSQ0MSVHnkbcbEA7//R1ltWcPoFPQF73qJ/z5PaWioe+rSfgOjsZX54kphndlJEYlqLCGzo/E7oKaAlxq87f/fYO5GzPHM5kJ4xCJVwqt89YDNgDpr4rzK83kx6J4WsA+vpemwWeKHf2PGcinNC1F7dge3uojl1S+qKY0e+hCNGAgobYFbVc4xbNDZ6dgagUrL3u9qHphcSfTmv8kPekrxXnsijxuWdQkqP8jCwhJKC0ZP1LupnyZT4GQ65q1OkhVvMCrS4NEHQ+noqTbL6xkcp7fi7LcrTsD4Rag5Ev1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4I5Uh7JSsfgHtT+ozN6AbXrFUZizsi7J7DIyroK6YQs=;
 b=mNqf+KBQfd7Cd8rsQhyDFMcEqvZ5DWMTcxrAeWKVxjQ0e951DSBq3OzrUGq4p70yhcVj8Zn9aGPhyez8xxGhXeSZ7EME9hAGcU2ddDmOFBQ6QlL3uMcMpxaY6uBpfkL9q4RO+qVd03xvDuVLxKgyRqEq+8fEbJ9oRv+ekiLyQsfu4C5I+FmCbtNgA9Sq0ZcS6cbSjYzvJBMBBYvnvFSBo67F1MPFPadQ/gnkvjZGUXFGdigIuysx9LMeM9bauD4VkhUk2S1BqHBmVHiq+g5JzVceQJtY6dJf1TLv2LXWlEYoj74hAbicscZAJziJQsnuBSUiscesmlvN4d/OcGu9fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I5Uh7JSsfgHtT+ozN6AbXrFUZizsi7J7DIyroK6YQs=;
 b=HU+dXS9HNBAFv0P1C4NNnl8PClZ0D61ocvSzRzGi2W7173vcQ2+Oeo8AFcQM0kPn3J1zKcq6Wq7GpKgPu5pZombEJ2Jk6BHv5yHzBfLy19BwRlDgm/a/sBPd+vrktG0suKaafB3yKUMim18QglYqFzIeUSL+XRECuO/9JQjVLWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AS8PR08MB8249.eurprd08.prod.outlook.com (2603:10a6:20b:53f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 16:59:47 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 16:59:47 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v4 6/6] Create netdev->neighbour association
Date: Tue, 15 Oct 2024 16:59:26 +0000
Message-ID: <20241015165929.3203216-7-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241015165929.3203216-1-gnaaman@drivenets.com>
References: <20241015165929.3203216-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0059.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::23) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AS8PR08MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 014f4181-37ff-4ee2-115d-08dced3ac66e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mQOYwzZEtaPYRMwWkMTM9EIxvE343Lb0Z0SMF1gZRDmeYk56x2uvFESupenh?=
 =?us-ascii?Q?BJVB//B/g3+aLABVN2jApLVUYQut3vC1kYJ3YrzHNIsqdo216KGcDs9Z7nq1?=
 =?us-ascii?Q?EnEajEFdXL1/QTfLFO0Rfjhfa2DchpBTYSjXJYMDXE0rQzWEkI/0o/DjjqIg?=
 =?us-ascii?Q?s62G+M/zP9pKf7JKXc8nCXs0oOOWSRsocEAC2oifrXZ8LTNBF2uMsGrlIJzi?=
 =?us-ascii?Q?tgwmFxMZIdeLEKEo2DCBWCn8NALLl8OjfAXzt1+oXdy258x7cuzD6GDfFAtr?=
 =?us-ascii?Q?oZiUkV1xUH2As+EazNU5PEysyY7gOOF9UgWXjtuFV/noxhr9My6E43k5nq+L?=
 =?us-ascii?Q?r7U8wRs1nh/8LN3Bc3x6X5xp56VrxaD50ykBWyuoBBfrQgsdQZth935qUaL4?=
 =?us-ascii?Q?hjZc0rtsOtmkeBxoG/alVth8TYJGbzk0ik6FGqxRgLCn3sF7Egn4YX+l3Eqq?=
 =?us-ascii?Q?7ARo/hoTTjkq1VF+1FjPEebliERHj1VVy0wAOLA0tjFHPXfPUkj1v+wdUwKi?=
 =?us-ascii?Q?CZxToJZ8eYscvtu4GSI3mlgKfPOvLumBx1U9LUPGpmkIj0HAWVVPl8dV43N8?=
 =?us-ascii?Q?v/9MUUef6Z72bCRHNpytUp+wjM+IRWx1dDPgKTmd3pe8tp75a4aDQvvWMHdG?=
 =?us-ascii?Q?fpWLyuh4eeqL2W/AoQcKnY5pDUiJ2Nn+Iohz5Is19CTf8ZxWF1K5vrC4oXV0?=
 =?us-ascii?Q?fnXehHW5+tOz15eyapKrp6Ccdie2Ws0R97n2jgIhirZiRVeS9SnEHuHiC548?=
 =?us-ascii?Q?YCdHG9vFqSyPDpZGe5MIrFD5zXZQt36obOagYymnTdzKDcvGI9ROHOWjARLr?=
 =?us-ascii?Q?brAciyyLhfdOHfY/mphyVlFCol73Mg4IvjJRBkeDgFBej1UQ2qvvEzwC6HVj?=
 =?us-ascii?Q?rQ9uah70uAXOpndLs1D/8emiEfIB7QvOvSHxAN+myorpS6Dqh1jPz950y4c2?=
 =?us-ascii?Q?be5W5TMrXb1DMyW3b1oDc2kFwSt7/nb0T3y0eV+VkK2lxGHolBRl6ysbN4PQ?=
 =?us-ascii?Q?8ASczGbXibWUi775VQLqOBcqkXRPTf2+CWFjv1KS30Pj1tycpGhd7TI0JJ5V?=
 =?us-ascii?Q?mllP6z3lZOgPSAXEN/OnnooTBAYdoOVvQzDjvE1PovX/KTeKmcgYlKFXzzQH?=
 =?us-ascii?Q?hWfAbuOH487Mwrpr4APQhmHiBWRfQ7cVgEM6hITudN8PhLcZdm2Zdgm13Tub?=
 =?us-ascii?Q?n8teCmxTjm3eZ2q+Xz4w7hCi8qBJTZZTwz7FYo3zFt9ipyogVuldF+UKMDDu?=
 =?us-ascii?Q?BkejjADMRvRuSxqjauAr7wVJji9nLfaopUawCN1rET9o83dIjT1eDhyjwlWS?=
 =?us-ascii?Q?qYxP2w2wnaz6Yt2IEUgLftL5C2D6BhyxXtw8C+qyl2Z7Xw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bQZ8Mc+GBzH2xKrrzTrdJERJ2s7Mc5wNCl6oAkpQuqaHQUro858HnbphyeDU?=
 =?us-ascii?Q?e3GQ8b6ea+WNTh6cxfFj1+hp/rPFGed3hR6CxZg3VIsKgmCeoWJe1+JDXgju?=
 =?us-ascii?Q?hOV71SMTT1U+xCfF3fH3Pndct/l4Oj0XTHsVTp5VTKegLVcGzQZlGLqcQ+kF?=
 =?us-ascii?Q?uJrD2Jgo74L79iiobLHsmPdzuRiiiMaSogS8bNI0vepozWGa3s4Ih/MXfFWX?=
 =?us-ascii?Q?y9NexMfas7iSFE+Cob2LWnG+z4HamiyfAlUvUVaoZ1H4oI9e+ITS2qXrpZMj?=
 =?us-ascii?Q?m0En6MINz4ymXqJ+aHa1scy6eUShRx0/l45Bo5btBHJR7AOettYkpWCdNZhR?=
 =?us-ascii?Q?Rv2NRn+lkUv93Rd8gnvhbeosiy697lAxE3Bn2uVi9pUEuNMOR93Bu2oIVmCm?=
 =?us-ascii?Q?Su3yWYirFnuwH0wvDTZUE8oRk4UFAMFdgkaC+QNEYgMc0znwMeTt1e6gK1AP?=
 =?us-ascii?Q?+18UkHJM9nMWRI7JawyXDIC9C9wcUWdGJwZ4uq/DPud3kpRyOaSJNBN/ldED?=
 =?us-ascii?Q?XksVssZ3aZZC23YwtBO8yOqLmhc2odfB5kV7LtM2gJspM0bna0YXFDTtUReF?=
 =?us-ascii?Q?ti6uu1ZEwmaZOEofSTLRnNl69bann0OxNHnxOpvQKlbNp4L/22d6tE3mUigS?=
 =?us-ascii?Q?rLq2W6Vp0pfg5/TDBFV8dGIkM0wUe6wvqlGf/xJU4A4apMjQchUKyVRmOdMC?=
 =?us-ascii?Q?9b+QOMQf0RhAkECT6aZRVGP+53RFzmZYz+VAgyG4wil5eTqAn/F7OvmOxIXW?=
 =?us-ascii?Q?CKyTTSWyi/kpKqtZsE3iQ5MCLYK/bhJqGEYIZjJFLA54zbgfmlmZYsq7rh6g?=
 =?us-ascii?Q?5+tXJzONFMPku+krqqiVjN5bV4gZI1Hb/UE9p0R4VLVelRFaOfb87gC9o1PH?=
 =?us-ascii?Q?wlIRNJQDzJ9wUD71D0W5E6WPI8hNkqWXWyiAVHRxU8r6fhDArNA+75XTCI3m?=
 =?us-ascii?Q?Xk/HCaALSAGiwjVA06A7uHbuayYhEcVAbOKz+W4bSWyw76fa4OvTFwBpw4vr?=
 =?us-ascii?Q?PC8bKfDhwPQrB/pu4WNBQpKMwIgD8zBsElLQgUtN1nJJ3FsfUn9w+rXwvuAS?=
 =?us-ascii?Q?0IwAymdrWVT1NJZqc3UnWk2WDXHyTGkDJ11HCaqeMIerZs65B9m+hbCJiHYY?=
 =?us-ascii?Q?nth6NRWv/WzgLfcAVJ+j+W27UuLXKMhUTuQ72Y0AupbRVgt2fKUrhFCUunII?=
 =?us-ascii?Q?iSgtUpHHcIHQ1cAxlr7Lt88zhqep/sBz0dKFuzelu0i3jlan9+tiD2dhcyvo?=
 =?us-ascii?Q?bmOzvTgY3QgS+ncK8uS/2utqvFgggJwbjBxu3iaP/RirBvhVNRnc9L4Nzgpn?=
 =?us-ascii?Q?hSP/CvYt2VXIYJ45MZ8/VDv1Ajd3n6dXx0x3eW4O6lhZFljWp4AHG+b7DRH1?=
 =?us-ascii?Q?dTTN+8Ue5CBdHXxd5ze6XOrVJ0e25ziUOLLUN6lEl9jDNW6wSFCPfL5NH/4b?=
 =?us-ascii?Q?5ro0RnKEJUV1G/v1HQ7KjICJRoycOzNcaOAAwzPjrJkDkGfW7Ne1tTB0rfMT?=
 =?us-ascii?Q?jR+X6QTzwGqXFgSN/h1uGQ41E5uarlBbNzXZOi3A0f2IGcFobNmcoeuZ/nAt?=
 =?us-ascii?Q?KW3+xNFc6jdGYpYLMJvVGbTXPhRQ7VPcP+25F8iOP/sqXLdEBcnNYX/onN5z?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v3AC8znCDi+eDinrhwY8Sw06mB6sjAFM3LlBehhyfqjDqBCtMnpGRF1TGWh+ba3NqrYvlN+MRf8du4WsyIy8nVVa1tsGQgDG9lgnemPzLHrmzU/RnM/AXCN/PqwZMBzGSsI+Oy9B69RbVw0erW2Rb9vqmQrN7TzxQzgh9nxfI04D3yeoRy6Su9Zh3uxQxl3RiX1nWXvIrFihVF4IMgN0bUc/9KHQViuj6fXhh3BugG4B3Jm+02bwg8rT33etgEksP5Po0WeLIi7ZTr/zy4r/RJ9zgLAU2q0T12qsQApNBZx5ZSEPseANZgF3BdV5gWcTKPvNp7l0XMm7nxX7rXRtSHH81SS4PcW3baYkH8e/Ai+YkK2woGr2hXThqoud6OJOgyaRTPz6NGiFEGyzoVDksTDYbrXN9lc0kGVYZSd7G0Jo2y2Hv8uaPEjbwBBO5FPE0IpDucuJ8gPP8YCYGEt7Do8yzNsnjJuN/EBrDYGFbvOLRJiNYRJ1yHi7mHVoFmcIS9Gk9vgc3kLZkuU5PUZBFSyV4pVSXjkoG1BiaZqMLqXer0fRSfOEp82Y7QfBW+YyzPQMntlR6XW2NatNec0id/SHqMzDLpP49caR/BcghP5vDQfhnaITqHBiEnmwoHzy
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014f4181-37ff-4ee2-115d-08dced3ac66e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:59:47.4057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j74C+QPI40cJwc8O2mX+1dJViXpDqiBC44NwDND8o1a8P2SGZnnN+Pa12coguUlvnqIco1RrjbB07dDiOUkypQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8249
X-MDID: 1729011589-EiczDBLQw0FE
X-MDID-O:
 eu1;ams;1729011589;EiczDBLQw0FE;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Create a mapping between a netdev and its neighoburs,
allowing for much cheaper flushes.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     |  7 ++
 include/net/neighbour.h                       | 10 +--
 include/net/neighbour_tables.h                | 12 +++
 net/core/neighbour.c                          | 85 ++++++++++++-------
 net/mpls/af_mpls.c                            |  2 +-
 6 files changed, 75 insertions(+), 42 deletions(-)
 create mode 100644 include/net/neighbour_tables.h

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index db6192b2bb50..2edb6ac1cab4 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -189,4 +189,5 @@ u64                                 max_pacing_offload_horizon
 struct_napi_config*                 napi_config
 unsigned_long                       gro_flush_timeout
 u32                                 napi_defer_hard_irqs
+struct hlist_head                   neighbours[2]
 =================================== =========================== =================== =================== ===================================================================================
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8feaca12655e..80bde95cc302 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -52,6 +52,7 @@
 #include <net/net_trackers.h>
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
+#include <net/neighbour_tables.h>
 
 struct netpoll_info;
 struct device;
@@ -2034,6 +2035,9 @@ enum netdev_reg_state {
  *	@napi_defer_hard_irqs:	If not zero, provides a counter that would
  *				allow to avoid NIC hard IRQ, on busy queues.
  *
+ *	@neighbours:	List heads pointing to this device's neighbours'
+ *			dev_list, one per address-family.
+ *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
  */
@@ -2443,6 +2447,9 @@ struct net_device {
 	 */
 	struct net_shaper_hierarchy *net_shaper_hierarchy;
 #endif
+
+	struct hlist_head neighbours[NEIGH_NR_TABLES];
+
 	u8			priv[] ____cacheline_aligned
 				       __counted_by(priv_len);
 } ____cacheline_aligned;
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 21c0c20a0ed5..d0bc618d4fe2 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -29,6 +29,7 @@
 #include <linux/sysctl.h>
 #include <linux/workqueue.h>
 #include <net/rtnetlink.h>
+#include <net/neighbour_tables.h>
 
 /*
  * NUD stands for "neighbor unreachability detection"
@@ -136,6 +137,7 @@ struct neigh_statistics {
 
 struct neighbour {
 	struct hlist_node	hash;
+	struct hlist_node	dev_list;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
 	unsigned long		confirmed;
@@ -236,14 +238,6 @@ struct neigh_table {
 	struct pneigh_entry	**phash_buckets;
 };
 
-enum {
-	NEIGH_ARP_TABLE = 0,
-	NEIGH_ND_TABLE = 1,
-	NEIGH_DN_TABLE = 2,
-	NEIGH_NR_TABLES,
-	NEIGH_LINK_TABLE = NEIGH_NR_TABLES /* Pseudo table for neigh_xmit */
-};
-
 static inline int neigh_parms_family(struct neigh_parms *p)
 {
 	return p->tbl->family;
diff --git a/include/net/neighbour_tables.h b/include/net/neighbour_tables.h
new file mode 100644
index 000000000000..bcffbe8f7601
--- /dev/null
+++ b/include/net/neighbour_tables.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _NET_NEIGHBOUR_TABLES_H
+#define _NET_NEIGHBOUR_TABLES_H
+
+enum {
+	NEIGH_ARP_TABLE = 0,
+	NEIGH_ND_TABLE = 1,
+	NEIGH_NR_TABLES,
+	NEIGH_LINK_TABLE = NEIGH_NR_TABLES /* Pseudo table for neigh_xmit */
+};
+
+#endif
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 61b5f0d4896a..dbfd27f79bb8 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -61,6 +61,19 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 static const struct seq_operations neigh_stat_seq_ops;
 #endif
 
+static int family_to_neightbl_index(int family)
+{
+	switch (family) {
+	case AF_INET:
+		return NEIGH_ARP_TABLE;
+	case AF_INET6:
+		return NEIGH_ND_TABLE;
+	default:
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return 0; /* to avoid panic by null-ptr-deref */
+	}
+}
+
 /*
    Neighbour hash table buckets are protected with rwlock tbl->lock.
 
@@ -216,6 +229,7 @@ bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl)
 	write_lock(&ndel->lock);
 	if (refcount_read(&ndel->refcnt) == 1) {
 		hlist_del_rcu(&ndel->hash);
+		hlist_del_rcu(&ndel->dev_list);
 		neigh_mark_dead(ndel);
 		retval = true;
 	}
@@ -357,46 +371,45 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 			    bool skip_perm)
 {
 	int i;
+	struct neighbour *n;
+	struct hlist_node *tmp;
 	struct neigh_hash_table *nht;
 
+	i = family_to_neightbl_index(tbl->family);
+
 	nht = rcu_dereference_protected(tbl->nht,
 					lockdep_is_held(&tbl->lock));
 
-	for (i = 0; i < (1 << nht->hash_shift); i++) {
-		struct neighbour *n;
-
-		neigh_for_each(n, &nht->hash_heads[i]) {
-			if (dev && n->dev != dev)
-				continue;
-			if (skip_perm && n->nud_state & NUD_PERMANENT)
-				continue;
+	hlist_for_each_entry_safe(n, tmp, &dev->neighbours[i], dev_list) {
+		if (skip_perm && n->nud_state & NUD_PERMANENT)
+			continue;
 
-			hlist_del_rcu(&n->hash);
-			write_lock(&n->lock);
-			neigh_del_timer(n);
-			neigh_mark_dead(n);
-			if (refcount_read(&n->refcnt) != 1) {
-				/* The most unpleasant situation.
-				   We must destroy neighbour entry,
-				   but someone still uses it.
-
-				   The destroy will be delayed until
-				   the last user releases us, but
-				   we must kill timers etc. and move
-				   it to safe state.
-				 */
-				__skb_queue_purge(&n->arp_queue);
-				n->arp_queue_len_bytes = 0;
-				WRITE_ONCE(n->output, neigh_blackhole);
-				if (n->nud_state & NUD_VALID)
-					n->nud_state = NUD_NOARP;
-				else
-					n->nud_state = NUD_NONE;
-				neigh_dbg(2, "neigh %p is stray\n", n);
-			}
-			write_unlock(&n->lock);
-			neigh_cleanup_and_release(n);
+		hlist_del_rcu(&n->hash);
+		hlist_del_rcu(&n->dev_list);
+		write_lock(&n->lock);
+		neigh_del_timer(n);
+		neigh_mark_dead(n);
+		if (refcount_read(&n->refcnt) != 1) {
+			/* The most unpleasant situation.
+			 * We must destroy neighbour entry,
+			 * but someone still uses it.
+			 *
+			 * The destroy will be delayed until
+			 * the last user releases us, but
+			 * we must kill timers etc. and move
+			 * it to safe state.
+			 */
+			__skb_queue_purge(&n->arp_queue);
+			n->arp_queue_len_bytes = 0;
+			WRITE_ONCE(n->output, neigh_blackhole);
+			if (n->nud_state & NUD_VALID)
+				n->nud_state = NUD_NOARP;
+			else
+				n->nud_state = NUD_NONE;
+			neigh_dbg(2, "neigh %p is stray\n", n);
 		}
+		write_unlock(&n->lock);
+		neigh_cleanup_and_release(n);
 	}
 }
 
@@ -672,6 +685,10 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 	if (want_ref)
 		neigh_hold(n);
 	hlist_add_head_rcu(&n->hash, &nht->hash_heads[hash_val]);
+
+	error = family_to_neightbl_index(tbl->family);
+	hlist_add_head_rcu(&n->dev_list, &dev->neighbours[error]);
+
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
 	rc = n;
@@ -953,6 +970,7 @@ static void neigh_periodic_work(struct work_struct *work)
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
 				hlist_del_rcu(&n->hash);
+				hlist_del_rcu(&n->dev_list);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
@@ -3052,6 +3070,7 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 			release = cb(n);
 			if (release) {
 				hlist_del_rcu(&n->hash);
+				hlist_del_rcu(&n->dev_list);
 				neigh_mark_dead(n);
 			}
 			write_unlock(&n->lock);
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index df62638b6498..a0573847bc55 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -1664,7 +1664,7 @@ static int nla_put_via(struct sk_buff *skb,
 		       u8 table, const void *addr, int alen)
 {
 	static const int table_to_family[NEIGH_NR_TABLES + 1] = {
-		AF_INET, AF_INET6, AF_DECnet, AF_PACKET,
+		AF_INET, AF_INET6, AF_PACKET,
 	};
 	struct nlattr *nla;
 	struct rtvia *via;
-- 
2.46.0


