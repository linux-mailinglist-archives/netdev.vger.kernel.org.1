Return-Path: <netdev+bounces-137879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DCE9AA448
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401851F237FD
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3301A00C9;
	Tue, 22 Oct 2024 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="VxRhYkzo"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3C519EEC7
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604652; cv=fail; b=I8SqIyquWAjVlWqDeyScu9N4eT2JS8IINjnPhIDlb0yeKu2AslAXyOMZYpeHXcHHxkpdsdN36hs5MkBVDh6+83ul4DTMh6PiATqehHvG6m0HMBayV82slARcbKkpSDQ0cVl6DPaR9PJ44kCqZv7B7uMsLxEfPT5d4+vkE5T9d3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604652; c=relaxed/simple;
	bh=8obzbqWFluULiPWIcD2Ia5X94nIIJAO7gk8WhIbeMW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OnU0HDzjnaQwo4EpTF6clE6sMCe0niM7g90eDrtxyhYgE7iagBW5cb1FcUNri9K/YF4yYneu71Oiqpd4/JxC/7aF6IqA18I0Tw6r6EMaO622GS0GeWGd3wt87HkqNQZErSjl3P+Q3JO9jYtMTM5w9L1MEXBjpaURWKaoI7lriGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=VxRhYkzo; arc=fail smtp.client-ip=185.183.29.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 74EEA8189A
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 13:44:09 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D1D8D480061;
	Tue, 22 Oct 2024 13:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFb7pomGdanQpVqru7X6btUka2bSkyAbqJGzOla/bWr6QSuB+VobiONwRSQ1LqHNP6qbxwF6euqNCr+80YEOiSiZNvX5ClGwExex/QgVoH3gg0eSTmJ8DB1tq/53ZPzPBR1zI4WhH/MaThReG3O+U9lgDGwPKtX0w3typPLzTuqChxPBf3FCGSrzSDXXl9j24bdAIeLd4YDOu6bEfD+M5mNFOUBeXajj15ra2kGptH6d9C0vaWrMMYrWVqLkdmqCc5WwyhqnkN1DBJtO28iG3iwI4GR47uhAwPGB5X5+z+UHLkGaLW4GVMsGnB3OywC9aLcFmbK9RoBwCz5JdhCmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMuORxLc2CeQrv7llk+FMcVOzXT+Hz464psQ3Jf4gos=;
 b=O9ybjr86HOE6eqVvxorson8EosgljZzudOlRz56pDfsWda4oFmhYg3qlAe6TiaQEt63rm2WRxQ97XDb/rROBdb6CNRp/WJuhtxo9g+DyCaaqSZaf4G1jeO+1/IAlrKxjI5bjzFkkKz45r1/j02D3aQ0obEpuXj54pADYr1HJhv3bbPO1kZ6etZ6HsD0EhKqx4+MlbCtmvbS+EMD0mi/ja135zhNjR8vjrRZsFYP7woPdfxMH0TkSLjZ91/4P/PowZFD+O6xp0NE3HuPQtU+7FJasx39QL3ZajuA+bDf+ChYbSic0E3ylLsQqc9JB/Ul7Zkw7cqXU2BoXhWbdyCIuwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMuORxLc2CeQrv7llk+FMcVOzXT+Hz464psQ3Jf4gos=;
 b=VxRhYkzoUp+Y20qG/imEVFYrShrZgNfP3kv6/9xJI8ZlZfYd7UScTg4oKPzDWNOxrlpGiVWpZuB593XvuLMc0LvgWffKM3YAPVxbKR0MT4b8J3S04YXUUoYLBopfmc3lRJmUx5fArmr+5OOBzbYChXclHfn/Iw34ZOub9yeClMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by GV2PR08MB9928.eurprd08.prod.outlook.com (2603:10a6:150:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 13:43:55 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 13:43:55 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v7 3/6] neighbour: Convert seq_file functions to use hlist
Date: Tue, 22 Oct 2024 13:43:38 +0000
Message-ID: <20241022134343.3354111-4-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241022134343.3354111-1-gnaaman@drivenets.com>
References: <20241022134343.3354111-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0192.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::36) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|GV2PR08MB9928:EE_
X-MS-Office365-Filtering-Correlation-Id: 711e122f-8dd3-4f33-8fe8-08dcf29f928a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bH7lZNQV8fLxT79dRdArVpmufFsBREC3l2p9cY74N80MWRlOic5fnLdVxAD3?=
 =?us-ascii?Q?fKss5iHuZ7ymjKaaGC+9TOuBKV2JCTVttzgiLDM5WIwkJUY1FLIkXCWj5n85?=
 =?us-ascii?Q?kRex79TTTZnZbqRFZZNZ9+gIxX+Y8sg0PrHj6YakvC1K0r2zyNegKrENq819?=
 =?us-ascii?Q?TtLup8Mrin2XPacM+x+/HXJvwpLaddvP4E7nVVphzrSslEX0NwBlfce+p4vz?=
 =?us-ascii?Q?LnChiF2yrBh+0/nKAFgsmOXiZnV/UW0fqDQtebnSIWP7fzXUUp/POTSd4VdV?=
 =?us-ascii?Q?ysMpzo+hmW9OrYcSuixPCKfckL202lMp3ryfbDu+YKfk948TeXi5UfZhhosW?=
 =?us-ascii?Q?3K9aupBMcCWi0qu7gIMw3GVU2zlW8qiLRTrnEMPydlqeDpsoQyuC8UvwPRUU?=
 =?us-ascii?Q?SXZqvsWbwaAAPSDbRanh3lG5SNAAcChTqrmU7YgbJJfkISQRKBhRqj6w+W2V?=
 =?us-ascii?Q?P/k27ABh35VYy/GbK3gCm24Sd3iBRdxNZvWwN6gl95VV/oDmhSVSCRkL3iPj?=
 =?us-ascii?Q?6OGZ1SMH65HhFg7nzOycNJm0oQuof/b94boMfG+XmZ9kLi0+wyXqvjziq0bZ?=
 =?us-ascii?Q?03l2Pwm3RqSZpf82oU0nu4ajgCot0u8xZXoo/fhaplXZZgspGBnTg4jfpXei?=
 =?us-ascii?Q?u09tFVmymWmylsZ3S+JFRO5VYFy5OFq1YLYAd7rHwIZ5CTCI8b5eyArx6f+m?=
 =?us-ascii?Q?phNIFlO9u8n+pyv6wxscJ1qxIPUmZNRYBza6kqE3aS5WXjyvHwwBapFv4l8t?=
 =?us-ascii?Q?4S8MkTKqiFX0H1MXPtYhdLeTrhEIPEYdKzwmx19tcX4QiStEuxP5qcOe8oN3?=
 =?us-ascii?Q?TU8GGJqQu2CbidqXZ93mlOWX1SVzBG7OPRZDrVFoIQkuQZtcbPOcg1jEJjF8?=
 =?us-ascii?Q?DpvAKdgm3ZGglAtYgje+3tsH28Pa//B40kWsxGBnkinIGB2Q15pFL1Or8rhu?=
 =?us-ascii?Q?P2AqqQnfNgxYdmk1cYEp9w5Ud99ErCXxgJmsBpfS/USKEQyNSzB6S0y1g5X6?=
 =?us-ascii?Q?dmzUgqlkdKPzrfFjWVY/mypp0Td74DQIJTZdrYU1Wo2l4FDcGDJJVGjo43H6?=
 =?us-ascii?Q?mX4PdKapBrAazbHIxs6rBarfwMkswOJeBU97x46E9qDfVk4eqR8pOUc/Pix9?=
 =?us-ascii?Q?2rFWUFKp8VSeMlc6y1v2ofeaSfaZ4LyxF4MCuqEHDP27m/I3UbV0i/NF4TZP?=
 =?us-ascii?Q?e4ekvK5BUQBP0lAcGScI3KIxVzE1OjxbV+MK5ec6jaNgYQFjDaEmkNOro4BM?=
 =?us-ascii?Q?D2T8KKkXdVwMPb6XyH3VZ+SEg7xzbgdtu0SFuDK/q2iuXLuZo6KAj2/bNizD?=
 =?us-ascii?Q?5OhTWfO5ldaS0MWToCGhC3VeWAu+68IK60ga9A6v7fX81eyW4VjaBYzAsAGq?=
 =?us-ascii?Q?UgI9bbE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p2bAvvZVDQ8r1VlX2IHJ410aQvskCu+yC8ziLCuV+6VQ545Aj5gnZazlWnbS?=
 =?us-ascii?Q?Vhw/dnh/jmSW3bWKlHa0Vwgj4lGXTeuycSKrg5L2ozXoaxR7tUZXOhmB/+5a?=
 =?us-ascii?Q?PVPLrwjyTihPcNAoUMYx9rPWVGMYCsck2h7M3LOXLOmI2yt7foAp8MLlLRUe?=
 =?us-ascii?Q?hjNhB58XlDMYRRiSD9ZRI9VSKAdxBK1Eb9UPFScsL3BbhL3QAgtmNjHA687s?=
 =?us-ascii?Q?HeluuKTjRygitGTe8n7dzH/ZXYyyEd9sTS6iBEpmA6elDOqOJrUEwy7GLqLq?=
 =?us-ascii?Q?9YDEzD4R03qMwo74SQWZiSP8tetC8MAIT+00joPhCz5d9fc2WzX+38gOqcQv?=
 =?us-ascii?Q?QZMwaFe4I7LNPl1n3CF6/bKib3u601dYyxMGAfFR+DwzN3fxWz4vdcamKf7V?=
 =?us-ascii?Q?yR5YI5N/zoKu06Vuba3TrlM/VXIx4dZcmfhVALTWz5EHqvAfehd1A62Aee1/?=
 =?us-ascii?Q?h66IHR/jJLP4NusSCaihvz0sG2lUG57K6BJtRd49g/gXCHsSmBp11OBFkH9l?=
 =?us-ascii?Q?bPDzgqdPIMIXyDCS5JLs5XvrVT6jTwwrFrboTTwzKgFGP9kwBNRiamVV3RLq?=
 =?us-ascii?Q?08YP7IA+98drX4I4yILchhux3eSXYrzMUDMfIiEiZG7yJbh1YBP081uFJ/ZP?=
 =?us-ascii?Q?UDhpXsxMx4RHzKDdKWI0KNBm/5kgyxijl7wJ3l0bTjN/gCDIIiO/TFVSpF21?=
 =?us-ascii?Q?Yb4pwvS6SvoBWwTxfmRcUjSSxtdfEsYcCGaQmU7I6vM9BDbdopItX85rt0CG?=
 =?us-ascii?Q?2ALnEE0Z/z/9n0m0CnfTqS90IJwyfJL7yarak0lxx7MXl6mS8vStoXyiXJsD?=
 =?us-ascii?Q?tA7N4VzLXt1FnBiFSD4CEtIP1qft3+HCWamvY7RnI3khGwZ2V7O06OAm1qz/?=
 =?us-ascii?Q?y1HzqfgVXErUWEtBQmiLdkft5QQlyDq4DkAhYVGWpoOEOHiTq4jYb/dUlkog?=
 =?us-ascii?Q?aSI9kiH5j1l70l3rgw3alJdUxKe49o0XmsGPHHx6X6k51x8te+cAiJMNrCGn?=
 =?us-ascii?Q?9U+6AnuzKa6ET7KsfnfQN5DZOwYl3Z9hdIYIOb/7GR/JeUs6WoOXXMXkDyJP?=
 =?us-ascii?Q?6wY+VFM5eIT+dEqDs/b95KyzV/LKf7yAvVD2/KXnENIhsWMivG7KgrgmssL6?=
 =?us-ascii?Q?akaUsvMhsHecJGqgE4j5e8OZiNWWLJ1/+a4QKOtQTio+z43Jp/YrBYKJRoIo?=
 =?us-ascii?Q?+ufy9vrIE70kO0nMX6HLtcbltbBgsEW1zBrMGbFaCfpEZ4PW/xlYQcajWiC1?=
 =?us-ascii?Q?YUdrQumFzyIFH9LRC9tOX5o/NrZCd2iFsg+NEIJ4yTa5rclvrT4XkjbMj+rK?=
 =?us-ascii?Q?PqoxTZplrFdecn9MG3cF9QctHKyTF4p1viu7lDZc9S/QnG/3N0Smtds7CxqK?=
 =?us-ascii?Q?x6KD19/tomJHGr6Q4eDptNLza9rWj5MSfH3sbGjcK/yQKqO9R99UffYqrfE7?=
 =?us-ascii?Q?DWG2I6C4PjyjI1MT+D0gRuWFm3IKsJsAdl40UoldjyXxQuI4UkvFrhA1Nwlk?=
 =?us-ascii?Q?cNo9YWy8VHUyFkv152kVn4Rzde5QKbWlFFyacdPMnqGxWiyk6LnH7RIFaFGw?=
 =?us-ascii?Q?nCqICt+cI6ShAOw3meCjrUpeXqurYnljhd3MYse6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ewnNN2wlIpaZn0eb07+SKO0kjd9x7wOePN2m9rLCJ61swWeKXaAvkWzK9Ym6d7Ik2VBdJMkwGH7Uk+abzlme14g/Y00HzbBsqSyO6VvYxCe2RaPud2ptSlbdDawOd0Q8STOCDMiKi9rJ+Xk9ElH1ZNHkUuoHpKRtQG4noZ/MMKLctXklwcOZAfV2ke4fuZ0hqQrirmTxO/PC+3zVmPuqNdDUIaUPHDXmd12XvpdTtxBZbgwkaJGe9DLT4iizeu0pqzmWsLnK7X6QZsNqTixZZMoq1rtMdFbcc2Qx3sbDcAHpzdWix+7Pq5nWbK0QR4RNQpzwlNJEArkr1qERLiO+DcNKFTuOES5YvSGDXF3DWbRZ/fzfCkqF3AOuY3wlTOQ2dcLR9zbdD82sXqGcBnqlwbSXnuSQG9U3FPKQE+iEoGbXjxlXdQj1vkn9GWDBu6R4bA0nUJbVB4JZyh3DxfHfmDJeNHzrYMtEIUt2jZtbyk9KXSrNSc+dMAVfL62BCjUStTD4IMiRoeEaV2y+IZxq9FS3txBIE9Xhb7PTGakZRRAzMl44Bee6E20lmj3OnMhh7EokisMD2YFyfumwkITzmlHToIienkJkPXSIQfw3bPNt7K9UMAIw/QFw3hwhea8l
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711e122f-8dd3-4f33-8fe8-08dcf29f928a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:43:55.3250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCxjwq1L99v4Bz0qDpTDo0qQMKPTvXwtxe5NKqG/QuEfb2g0vyd4HtQFvhLNKeg0Y7IHqsqrOXjoHqPash9cLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9928
X-MDID: 1729604641-uYmGoQ50e_iR
X-MDID-O:
 eu1;ams;1729604641;uYmGoQ50e_iR;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Convert seq_file-related neighbour functionality to use neighbour::hash
and the related for_each macro.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 net/core/neighbour.c | 104 ++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 56 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 7df4cfc0ac9a..80bb1eef7edf 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3226,43 +3226,53 @@ EXPORT_SYMBOL(neigh_xmit);
 
 #ifdef CONFIG_PROC_FS
 
-static struct neighbour *neigh_get_first(struct seq_file *seq)
+static struct neighbour *neigh_get_valid(struct seq_file *seq,
+					 struct neighbour *n,
+					 loff_t *pos)
 {
 	struct neigh_seq_state *state = seq->private;
 	struct net *net = seq_file_net(seq);
+
+	if (!net_eq(dev_net(n->dev), net))
+		return NULL;
+
+	if (state->neigh_sub_iter) {
+		loff_t fakep = 0;
+		void *v;
+
+		v = state->neigh_sub_iter(state, n, pos ? pos : &fakep);
+		if (!v)
+			return NULL;
+		if (pos)
+			return v;
+	}
+
+	if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
+		return n;
+
+	if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
+		return n;
+
+	return NULL;
+}
+
+static struct neighbour *neigh_get_first(struct seq_file *seq)
+{
+	struct neigh_seq_state *state = seq->private;
 	struct neigh_hash_table *nht = state->nht;
-	struct neighbour *n = NULL;
-	int bucket;
+	struct neighbour *n, *tmp;
 
 	state->flags &= ~NEIGH_SEQ_IS_PNEIGH;
-	for (bucket = 0; bucket < (1 << nht->hash_shift); bucket++) {
-		n = rcu_dereference(nht->hash_buckets[bucket]);
-
-		while (n) {
-			if (!net_eq(dev_net(n->dev), net))
-				goto next;
-			if (state->neigh_sub_iter) {
-				loff_t fakep = 0;
-				void *v;
 
-				v = state->neigh_sub_iter(state, n, &fakep);
-				if (!v)
-					goto next;
-			}
-			if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
-				break;
-			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
-				break;
-next:
-			n = rcu_dereference(n->next);
+	while (++state->bucket < (1 << nht->hash_shift)) {
+		neigh_for_each_in_bucket(n, &nht->hash_heads[state->bucket]) {
+			tmp = neigh_get_valid(seq, n, NULL);
+			if (tmp)
+				return tmp;
 		}
-
-		if (n)
-			break;
 	}
-	state->bucket = bucket;
 
-	return n;
+	return NULL;
 }
 
 static struct neighbour *neigh_get_next(struct seq_file *seq,
@@ -3270,46 +3280,28 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
 					loff_t *pos)
 {
 	struct neigh_seq_state *state = seq->private;
-	struct net *net = seq_file_net(seq);
-	struct neigh_hash_table *nht = state->nht;
+	struct neighbour *tmp;
 
 	if (state->neigh_sub_iter) {
 		void *v = state->neigh_sub_iter(state, n, pos);
+
 		if (v)
 			return n;
 	}
-	n = rcu_dereference(n->next);
-
-	while (1) {
-		while (n) {
-			if (!net_eq(dev_net(n->dev), net))
-				goto next;
-			if (state->neigh_sub_iter) {
-				void *v = state->neigh_sub_iter(state, n, pos);
-				if (v)
-					return n;
-				goto next;
-			}
-			if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
-				break;
 
-			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
-				break;
-next:
-			n = rcu_dereference(n->next);
+	hlist_for_each_entry_continue(n, hash) {
+		tmp = neigh_get_valid(seq, n, pos);
+		if (tmp) {
+			n = tmp;
+			goto out;
 		}
-
-		if (n)
-			break;
-
-		if (++state->bucket >= (1 << nht->hash_shift))
-			break;
-
-		n = rcu_dereference(nht->hash_buckets[state->bucket]);
 	}
 
+	n = neigh_get_first(seq);
+out:
 	if (n && pos)
 		--(*pos);
+
 	return n;
 }
 
@@ -3412,7 +3404,7 @@ void *neigh_seq_start(struct seq_file *seq, loff_t *pos, struct neigh_table *tbl
 	struct neigh_seq_state *state = seq->private;
 
 	state->tbl = tbl;
-	state->bucket = 0;
+	state->bucket = -1;
 	state->flags = (neigh_seq_flags & ~NEIGH_SEQ_IS_PNEIGH);
 
 	rcu_read_lock();
-- 
2.46.0


