Return-Path: <netdev+bounces-134195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5F8998575
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6431C23615
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A50B1C245D;
	Thu, 10 Oct 2024 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="j1PJjz3p"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA711BE245
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728561722; cv=fail; b=jtaU3GzeTj6aj43aRpxaazTohUR4q+Ypv+QXHs+HgLZqO0CykUAujCbvNLtYlBmOGw5xFoHKYPYduYgXMQj3zUeUj0C4n14P2xck0zNnNUmZpjk2EvY/kTfb1KYFz3iDXSKS55zPEAuLIBuuZvwiNoJ8WtuzsxRicGZN5PyMMV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728561722; c=relaxed/simple;
	bh=Klqbw2Q3yjGGpKXcCmxBAHcLNYen/6lX2KCZLyXhhgU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gTclTU5DBYg1CBkpZJXRrBy02bqlH2yygvqQeBCz8OOfNurVO+NDtN8OjJA9zLTLDTc9pXkvQ+AJKsF0xfrkpxP8SFg4jPAqRvdzJ0GYUngNxAEj5ezbh4SLeGdsg4kqz1OvcMyLBHFUudQzoAwjAith/II9WYWVIzLgUh0sxcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=j1PJjz3p; arc=fail smtp.client-ip=185.183.29.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03lp2172.outbound.protection.outlook.com [104.47.51.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id BFFD81C006C;
	Thu, 10 Oct 2024 12:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qku8tPepiZd5LeVFBVV0JthX3w8VeQ2EQorttxi2e64xq/AoyCxbF7tL8wordVHqREeqELC1JWgo1YQss7YbuJ9nl5JSDjlmmoywsLxmxV/1cbp87+9esVEbEXqImqHxWyZH8HPvP+iV8FaYQaLXBy7dWJwLZMgOeIqU9Ee/wPIWQWqemGxStEGwEJqvZ4CiwrGgviKKbaQQwSqJyC7RaoqiXVDf6v3LYQsTdW6ycqZ9vTxElFTxDsMYxm+ee8sl71fQFq/wnSnNSdoNbJW/vbHDMtVoydVz8plj6cefLzx0JIr0iLHZxxN9KATjsLSyIZPnsGIjGqVJayD/OL+GxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEs3zS/H+qtgCmw8wUJgeJvtxxSA3CuO/40qGH/+6nM=;
 b=vouM6BlsvN17H3PEU9ZY3cDvzbL2I62xT+Bw8LvwKBrXPm6B60wGvAy342R63JsXq5foLj2U0Ydmthpoam33NIpmxmIS3Zia58DHI9Teo+yH19nQ43nC+znEaqAjtFV8MzXgkM1lpxNcmrRulwqsQKeeuwmYd3HpSZdA0+Fw8jjjVY7JjlpmP+IsH5polcYUZ+7xwLUDbQ21KCEIehispBnCwM4zHG0PXpoL95r8UB4xy/mzmAoQrI72nO3k5B4VO8135FqPvvA3TU5lCSbzlGiUvc/6PshcEQ7432I9xhDbftwgn+TCC62l2w1WegXPt9CCyFSL7zVKInu+eKhzcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEs3zS/H+qtgCmw8wUJgeJvtxxSA3CuO/40qGH/+6nM=;
 b=j1PJjz3p7L8Qd8nuaDjvORhQZU+My6iksIqvJ7lKlHaHGNXil5w6vNWL3DBnFSAtZ4mhMhzXC5NIuCF3UFocOJ7sHpoLPfK1M/qN/KcgDzoyAHSNt5qmtM/mPuVJRJgre99QaW+FF3B4nuTlHWFU6pbn0o2nnfMTlwiedmAHEX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by DU0PR08MB9909.eurprd08.prod.outlook.com (2603:10a6:10:403::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 12:01:49 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 12:01:49 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gilad@naaman.io>
Subject: [PATCH net-next v3 0/2] Improve neigh_flush_dev performance
Date: Thu, 10 Oct 2024 12:01:23 +0000
Message-ID: <20241010120139.2856603-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0533.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::18) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|DU0PR08MB9909:EE_
X-MS-Office365-Filtering-Correlation-Id: d198fa82-f30b-4bc0-28fc-08dce923520a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lF9e7OHSISom5/2HsF67tVJsZlsnCpM757WpmktToyA2K/Hddna3VvB6bcDW?=
 =?us-ascii?Q?dzD6f0PyihthW8o6Imn8iDAH8s5d5sjbz8mP6PZik117evbkM9shF0ANjUIx?=
 =?us-ascii?Q?++H3AQOJ4kDxAXB7EBLIvjIu38Dky5VF+ef3u/5DH4LZxG6iMeq5UGImr8DW?=
 =?us-ascii?Q?NRJJARz6BZUmzvyeIEsBXlDT371hh+ZFFFTqerhR7A3BwK0AIAGvtan6chDY?=
 =?us-ascii?Q?oj9RFAVLL0O/Q0BGFfBG48LKQGkf+fBH8ah+HHQ49H5oNLVmNkhoiUrlomv4?=
 =?us-ascii?Q?CwNxxFWsdV1aocy0zRC9/BmaFs/LKYmsxK+grvH7YS3N1zrPVA3TSfCvk1Uo?=
 =?us-ascii?Q?jWMBBzcuIIxJ4cdGENvPxxIqH7eHGy9MmkYslBl4CN/+WVfrcC1qXZjEP+rU?=
 =?us-ascii?Q?lqUEXSebECdM9b0hnRhy3M6KrAlqNu9ZktP++Bk7tMZfPLSAgH7vyT6s1WzJ?=
 =?us-ascii?Q?Yor/Bwcsi6k9L4+ojzbkwg6jhgdOhCuF/qWr0GUubfOA/fyd7LaeWmQiZDtx?=
 =?us-ascii?Q?hjCT8Hsp1wqy7ebX+gcp+TlGgj/3hnioBxvgc59IDmgVqIE9M/769zFCqswO?=
 =?us-ascii?Q?lIa5NwcAB0lSNsMSnq7eHgj93Op9n/LkkHRhCBN/+unShcCMxq2HPxAaVMnp?=
 =?us-ascii?Q?c3/5Tqc4KJnOjb1xLNXXVFiUzoD0y5h0ykNbQ61TEbD6NcbMxHWv1cxDVLlZ?=
 =?us-ascii?Q?CBa17yU6g9oCgavX7mCVav3RhlQksuk1ox2Qg3hXTRDLSaBmImpWdoq1CzCn?=
 =?us-ascii?Q?k380kEFWExDX1E/EJ2Km1Q3msYflijuKvAftzvw2zOa1rGLGTP9FkARBTBvS?=
 =?us-ascii?Q?51AlzSbQWjzACa/zRCAxa1ES4O66aDR7Mk3xvUbFMPeruIzMClHrW7qJIaQK?=
 =?us-ascii?Q?uMEzkHSgPT09Qr8TIN/LshsXjNDujATq75dpEoaKnQDE1BrUWZ/9AAW6puSN?=
 =?us-ascii?Q?ivISsR62EJYpvKtNiGTCb2IhGaebfKa8CwADALUi4nsXIcFJfz9DPGqcOuWe?=
 =?us-ascii?Q?kGJnTdc0AwCWSJUNA/4NqzxFzFdQyj1vbSmGJrdQf4hZrZoRo5auODN6rXda?=
 =?us-ascii?Q?gPArrn88FJqHWY8+rd5ESkcIQeF7JxT7pAZRHh/WFkUYB8Vo/cmdcFxiZC0Q?=
 =?us-ascii?Q?UydK2vyKCtFxgHVtuL2dyGK5hF6RHI0CgJAnk5GJMOiUBtypyfqrFdS9BetN?=
 =?us-ascii?Q?O8cEScNIOwhz/DtuNHm+6zCe+N+kMMxOMYDYb0wSyqnNnyi0P195i0PUCiE/?=
 =?us-ascii?Q?UO0CorpbmMAn8vxHywgn+R9VVaqGWTLlmOyJ36pK1D+Rzi8yG7wMT5FTLDM0?=
 =?us-ascii?Q?aL/ir8BjMNBE+85/GVUB6XrtCIy/jXDD+Ks77XuSiYAf/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?paKGj/fstqddnbxJyHUU0rPvpjaXvh3yBtTkjEmOP6J51xawkoU2Ixz98BPV?=
 =?us-ascii?Q?pNnpxiB/wiegNPkuq3gPam5HErD2A/LxVgYPO8gwJ+ygEAJPVfRe0N8BevPA?=
 =?us-ascii?Q?v9yablTi5xiQelB26RRtEUJpgfDyBB1zgQM3+r41A6K4WxqQ4B+t/aButnJm?=
 =?us-ascii?Q?lLpma+fhd+tqtjhEkrr4/bDW42l/4wtfLvPK6uLjiGYcBWul2UNNSHbTs5MO?=
 =?us-ascii?Q?gh7PX/kc6STbYmCXW5bExqNC4YAM76ZqUd4HEJLo/kDIKSqG5Gej2qvdk78l?=
 =?us-ascii?Q?JEtO9zeISNj+NW9bc8RgibS1gsmHG+ZrHqYmFU/0sVTgYBTc2fFWrE25SKLQ?=
 =?us-ascii?Q?ido0s9tBZuS4Lhl0W9iIxiA7xHhN7q/Cv+SPL6gFXvwDjbo4KYx381pXcLgf?=
 =?us-ascii?Q?wwLzzH5VgXi0+gGjIALonZKhRd+XLQ1L+bd/1iCZGyHX1fsR+1DAsZHCDriC?=
 =?us-ascii?Q?TWIztjwPp91QR1WQs8UAdpt8NIHE+XjqLmz1jzFdOohGOht0LTjrOu6xo/67?=
 =?us-ascii?Q?WysqWhS3egO9nHvz6YyuOIvHOx9dTuIkORpdXMg+TI4ezkJ/skA2HCS4Y7L6?=
 =?us-ascii?Q?CVS/AhFyoUtPDVJXNLDSoY3Vwun7UbGLDaZ2Dtm918KoYGpE3IQ/FrNEd/le?=
 =?us-ascii?Q?0DAG2zMQAzC5GB43XWtEnjM/LwP8btTZp4K/J83OkuQNYz8NZ5vgq/d2HcZo?=
 =?us-ascii?Q?Z3iS2ACeOLH6TD96fEAVmkTZLIXh1GzXBX+mk6AdImmB+3uTR1pkX7ykwBHB?=
 =?us-ascii?Q?hRyBBVIBo+qBQXWM035Cu4Hkh04DxRGTchQQcO04leHm4rH2ik5xQRDx/3ML?=
 =?us-ascii?Q?jaFpav0XMOmz1GzlkcyyE/cWNvCsZhBbu8tBy5vce4EEbdm6YwUxf9CLtkgy?=
 =?us-ascii?Q?YmPjPmMXl76gt9+0SfzCRHyZRfrF1sG6TyexoK98JI8cbeR9snBiM4yopJpH?=
 =?us-ascii?Q?k+NBudiSqWPg2cI3NERr062vp8UY3g9Kc/PQS02ylBzEM2isMPfmtIB1qM5T?=
 =?us-ascii?Q?/PzyLH7AfA94znbZNPexuS6QlLgDmQ61TPsXT3OP7Ct7XN9lm0U1iT1BpPiR?=
 =?us-ascii?Q?pYnDfFGJKdEvh+oPNAuhrlygxas5OjXvw2qA5bxSKfBaEy+irVM2tg2j0gGe?=
 =?us-ascii?Q?POFjomfQDjmGkSiAhpHnAzUi1jm/7nlCimKsFQ6Gjg8g0iYvETbt3QxfvLYF?=
 =?us-ascii?Q?D+SzXbDHQBZRO6QkBMWR0MM4fyuM40GCvfP+sinH5cB02Cpe+0ykrMjzpCbp?=
 =?us-ascii?Q?MIvqilfpuJIJKzV3VqjRVXscECipAqEQyY9OmzyfBCscSVdThqmS2db5s/4k?=
 =?us-ascii?Q?eT1lCDiCHGWFnqsRb9OywhtgVAM4sEE1UlY1P/lqfHczRT2KjbuMtLtxn77q?=
 =?us-ascii?Q?9iAD0EdQ/l36RWZx7P2JyhjHArvnBuNTweZ9AeZt96NhtJMz8YAz3Bv4eNq4?=
 =?us-ascii?Q?/fADmzXrE7Bu+h9mfrUSlMayEWFtXseHLUwxQI2fYrIevjTrkuNNUJMQq4UF?=
 =?us-ascii?Q?plNcrhZaku70MMisIfPCT/PYkIDfd8jR/mS/4mtGX60Vdg7ATZXHm/fnNYa3?=
 =?us-ascii?Q?11Jry2X4o+bAAuITQIE8/Bf0x1mEUu0si9tW+cJL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E3afGEIJTRquNLWjz/LgHUGzkNw8FyYCTSTC6t3EXHM68tPA11n2X78zkcV9Z850bh7A8H8mvaEEfIBPFDrHMIao0f8KJo9Ezjs+wR0Aausz2YEeyybVehAxUsWIL3uWRFbFm3KP+ESS1UuO/IBib6Qg4NI4wEuwJRTsMcWeOyUw6LMlcs4mJo8kOw1fNIvL80XHXlXmyTK2kB9eRLV+4YPu8/AdZ60ENWl7mAomg9gRzilkXcxo8r3TrNbXnixfnGlgmQFCXp4hHs0Ysdn+dh9Y5YnFvYWg/BAn5L8l6tO7SDkH1v7lVBD+CklGCjrNMkEAynvrycaXRLTVHS0ncAAmxwYNsgV7+XWf89QPQ6MXg/i6qW33BP6grsJ8ALaiPutU3WG4c9C3Rv6MhAjVDkGdcQofYRHANN6kTcXKUAMVwGg8o7qIDXS5cEGdHoTJkyWnOOzCAqXyHaMtfBZBdKdB5CrWNiad3UXhb6I/rGXnt32ped4q+ADSqCiGxViuQ+GSG+EjWln7C5kZr6UVyxATz781ioh3Uz1EDVX2RCY3/WBm6M5i+6unqLZFP57tr0o0pLP3nGpl0sIp9830IN/5TPjoHgyeS6GAm8fz11gfVOACW9mU/GUh/iEm7H2k
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d198fa82-f30b-4bc0-28fc-08dce923520a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 12:01:49.0596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FekDeFuhmbtCgMfTTnQESrO9x0qIeWKLmNdyWIAsXDTIuQ4M0qVpx+bnyr158908aJLISErEp8nDvUH2PvqhmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9909
X-MDID: 1728561712-YgL65ti94Rxx
X-MDID-O:
 eu1;ams;1728561712;YgL65ti94Rxx;<gnaaman@drivenets.com>;2328388050003780ca43480a2715a176
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Gilad Naaman <gilad@naaman.io>

This patchsets improves the performance of neigh_flush_dev.

Currently, the only way to implement it requires traversing
all neighbours known to the kernel, across all network-namespaces.

This means that some flows are slowed down as a function of neighbour-scale,
even if the specific link they're handling has little to no neighbours.

In order to solve this, this patchset adds a netdev->neighbours list,
as well as making the original linked-list doubly-, so that it is
possible to unlink neighbours without traversing the hash-bucket to
obtain the previous neighbour.

The original use-case we encountered was mass-deletion of links (12K
VLANs) while there are 50K ARPs and 50K NDPs in the system; though the
slowdowns would also appear when the links are set down.

Changes in v3:

 - Fix rcu_torture failures (misusage of _protected)
 - Convert first/next access to for-each macros where appropriate

Gilad Naaman (2):
  Convert neighbour-table to use hlist
  Create netdev->neighbour association

 .../networking/net_cachelines/net_device.rst  |   1 +
 include/linux/netdevice.h                     |   6 +
 include/net/neighbour.h                       |  18 +-
 include/net/neighbour_tables.h                |  13 +
 net/core/neighbour.c                          | 272 ++++++++++--------
 5 files changed, 176 insertions(+), 134 deletions(-)
 create mode 100644 include/net/neighbour_tables.h

-- 
2.46.0


