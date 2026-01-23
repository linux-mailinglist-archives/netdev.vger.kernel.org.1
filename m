Return-Path: <netdev+bounces-252609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDNoBSfdcmmNqgAAu9opvQ
	(envelope-from <netdev+bounces-252609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:29:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF5D6F9E8
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CD763023048
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B90E38A2B3;
	Fri, 23 Jan 2026 02:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NOMa+8vu"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7702F389DE1;
	Fri, 23 Jan 2026 02:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769135060; cv=fail; b=hzR///nfnLGNn+CkCvRcSfMvwiHI8GkIBkDIOhz1c/JU5wLpcS3oAfbLnoGRlinJWJrk4yncmPLfZLqo5/8aXw4/R8QC7uYGLuFdws5EpzK2pYb+ycTVlU1DZFPnbWkJzRigvzYWYJ7QaYFzw3gUfZ31wXXt5edLWoY7I1Oqke4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769135060; c=relaxed/simple;
	bh=i+5hRXS5o4Wi/zYiDKJYJUgn4+pxSJ/EESB/cyAhHsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b1bBU4cOwyq+BHOpUwEJL+AdBIyWn/FrJ0B1tvrpr2mMg6AJy8mIQyCVUAGjQCqJfURWzHa+VrkTIzdVBH4WE91q/9yIgjmfRP7S916frgngyCiWXXpNRuqMuHgF2XTPPQxppWR8vgRJ0tqg+zSl2B/Qm+PdIS+u5jCND0Fcj0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NOMa+8vu; arc=fail smtp.client-ip=52.101.69.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cy/hBjxNPIe7u8s1ilfzCv1t/iEgSi/AZMGEkeR7RWtuyDeT65GKPXIIJ8QGf/IfxVuanMHj4cyar4WoUtMTu8UBv7did5k/qckqoXLqvXAZdn96FfEQe1NfEXln38dwqDCjDB9U+4J3l4GhvoijeXQqkWM5spv3RiXbfETIrCOgMytimGCCvWAElKzWG+qccaDV8sRYrtCFknWRa6eipKN2fKInLjhoXv3ext91YWY5mNpZSA+HoWEB51p3pUeRdjQIn6GEsGF9emK0E37TBIDnGh/TyUFbsyGbngZ2xeybgVCLF/u+E3Sugf2U05MNzjyA8yWkRdtpzyOYV9lWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96NSnKr25dOsQcYSEb13/zRMQlkthS86iFhVkQnPLhI=;
 b=atXu86fsI4PnVbn+AQ9Tusrm8OBV/hYD923twj7UJO2Fi3oJ31RqI1tKUkLBr6D3/KuXv4RmPNaYEkHC1DP3o94VOSXOh7ur2VFojcpQx/q8IpTmB5uPWb0wnZuEM/uRjykohQtFWpyUgvbL7osN276yKhMmykmIu6QS/pUPXyf8d5oIC4rnon0epxgQOKhteuRNYs7FD8+bspT81FtuhH4vig+eRBYKFIin+SVTyxlOULpJLgP2REgotVuaBXXoWVUZ/zKn4zN0JaEcnon4XHF0ooWTvg5JpcjopTb4/Y2qsH1Rq6eLQy3Yv286QW7YtevUtLqG65h4BqH+l5OZHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96NSnKr25dOsQcYSEb13/zRMQlkthS86iFhVkQnPLhI=;
 b=NOMa+8vufCacRDvXQQA7BABBQ3iMgdJRyj1n5inKdqQzzRv/U+y13D0T2CQ+8D8Sferda6+LIdHt73NO7JR8cjOfxVOaYM8n/g9pHvC1tLlozSh7YEAVpVaANtcKbMKs/p7ar3cp39XZt2oVkKZgKQkxborxjQrrvNeejht8fc592InZ5B9bPudqpTkDncnm+8KR/u2t186xgOVu4bGTBEDeI0E89w3/saej8Mb4rgW8wUQVdJVVovdBpvYBBcUwIEF2VgEBAR5Gu+HD5UU4kyjCM36tLy6y4dR88PKAs4yCCBG7puI7aHPQhIWtkOFjxbhvPDoaR1ESItQ+2V5cHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11974.eurprd04.prod.outlook.com (2603:10a6:150:2e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 23 Jan
 2026 02:22:49 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 23 Jan 2026
 02:22:49 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v4 net-next 10/15] net: fec: use switch statement to check the type of tx_buf
Date: Fri, 23 Jan 2026 10:21:38 +0800
Message-Id: <20260123022143.4121797-11-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123022143.4121797-1-wei.fang@nxp.com>
References: <20260123022143.4121797-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV4PR04MB11974:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b53266-eab0-4c15-c01b-08de5a264e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AyVyN6b0ZWWo9gPCMrfOkdZORmW8K+UYCjJQ9yDV5+c2HQ7SNHYaJgbTgTgF?=
 =?us-ascii?Q?bK5yHeZ8NsmP5+AsvW9NeqPrdUB/tV36XGpVuq0mjMYPeQhLUX2uX/uayQwY?=
 =?us-ascii?Q?vQCe+Ac1EJ2uH9kv5czgZYJxbrxqcUASKzNXm7RyfhtvhrGyTz5amTgl2ZLg?=
 =?us-ascii?Q?wdWc3AjEa5y6s6qkdpOnnlWCuj8NySfiekvVALM6ahj6/qS0Bfrr/5+TBRuC?=
 =?us-ascii?Q?8KcKuyg/DyfVIYwuav0nSvludOQ95BLjH8TIcJ57B9170VtZ0L1I7gQYeLvu?=
 =?us-ascii?Q?MZwsf3+ZQbfDvb76GUIPCx+VWw6Z2c9LYbyoGZtkzMAwyhJZEBJIscgUS30v?=
 =?us-ascii?Q?hc+9lUm7sCUI+hAr3twWuh7R9lQMI+JKgbcTALUvt3/l6Zv0oYU+xC7C5GMG?=
 =?us-ascii?Q?/A64syW5xymIhzU9BoGCFomcCoUtqm743HmXDnfWGHS6eM62ZePbtlkL7WMj?=
 =?us-ascii?Q?Jzm787oDyuWUPkX8wiGwWIHx6x6RGAdQm+usA3YhEb22j0iVek0JssWVokwd?=
 =?us-ascii?Q?cJntVZJP917JyGriXz05QgIxrDAycfFJN6F5l7Stiz6/yRkX11JuKoE1H3Qd?=
 =?us-ascii?Q?FtmRo0vGl8gCbr1i/CgaYkvhERzMzYYA3XyRnof4xKvJaYTchvsDG7cR23Zn?=
 =?us-ascii?Q?2Pb5jXcHDtNH3bUdyfjbx5kvTzbxcb0/Pe6TPdKQ82PcNwk3Arqq2Cw9QRPY?=
 =?us-ascii?Q?JoL9dwF5UbaTCMgfaJ1Z/0Xpq8Y/ks4C+wSCwO/PlRFXTIB8LT0pXRDa+jcZ?=
 =?us-ascii?Q?IVmfX7S6EZroyuChvvQ6zQucJkLfqydj5Cuvnwn+dORwN3Et6p37plGxpYGU?=
 =?us-ascii?Q?d+Mg7yl6boNzEzz2Dpva9KYRdronGG8C5TK1RY6IaISuKsexcPb1yZ4L4C2I?=
 =?us-ascii?Q?CfxKBOU0WWnSxtHpPOck+Rl867mnXEIcn7gDAkExcExICO0XgjYzqufUjiI4?=
 =?us-ascii?Q?Lc5jqqksTYy6NI/L3qIY6tF/8s9xo4Ua5F/W9+xXSIA/BqLAhzIcPAE0qdxd?=
 =?us-ascii?Q?nayw5BFDlO72c0gmkKf9bQFrupHAGebPY+NXYyTh829GsQwXxv5rZFqND4NW?=
 =?us-ascii?Q?Hl8aLwr2HEMMV8G3Td7G8sglmdNmz/uTUfHV1xHNo6bXmAqef22vVQjftg5O?=
 =?us-ascii?Q?X7qs3aWhkzAIGF0hj6IT3vl3JS9XLFcATd3j05cd7WTFzXhNc+Xeyzio58dX?=
 =?us-ascii?Q?Bvi3hEKB5zJ1YCNYYuf1pSAaEw91VrXBYWvOEYJH5+hTrCb25BgJ5Sg3b8kZ?=
 =?us-ascii?Q?+i3RUxaAj9rKbwcLSQiIXNDRbg3uL7TcN/TJwn2DNTvw+E3xAOoYWq15E7z9?=
 =?us-ascii?Q?NX2Wmit3jTcvKGuYmHsHSjg6lbooJzx0pJfke11AOAAboTrELZvkjVZpxv62?=
 =?us-ascii?Q?lHTheyYyKsQ/XmLgteBlhmChVTxnYmGMevIcITBgIQQeirlAu6rT63szCaSW?=
 =?us-ascii?Q?Z+EoB86FUvoOsh9KVMBw+d0GwlC86qXrScLzkz33X4nrwohrRPegsB74gGFr?=
 =?us-ascii?Q?VETwId3yq6+Mhz10U0WJJZEOhOfdC39sMlWjZ9Dyvnk4qgQsp228SEENwA52?=
 =?us-ascii?Q?/J8b0vjO/qUnc8yL2CyMJcr5EzxqwRfWh+ODuAGlriUTi4M/wkjzH4p5C4AV?=
 =?us-ascii?Q?F41GTEZ7hxzHCAMjVsj4WDI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7yjVxI6OMeH7W81BlpScVjEIz2RyJe9tRa1oMDrEIgjK5abgg97m1z5as9A6?=
 =?us-ascii?Q?2S5paFrfh9IxablczfwUmlYi/zWLNzNhldyZ8QJSkxt1Jvw7HzLyX5LKmJo7?=
 =?us-ascii?Q?NcAUZ4X8ZWXsqMzPCv8xDzMEFn4i+SdQfQL3WvJ7HFZGmhH61nRMmdf9GXn9?=
 =?us-ascii?Q?bI4E8B0hUCRXKNkqO6DATQ/Vl41KNHPjwo6rcCAcE1QYoHslBS8uFymi3cBl?=
 =?us-ascii?Q?0kvbIWfNd9h+Zb8YNHIMK7LtNEpr91yGtgE19X2qx0Gqs0yUhFgYS9q7sXng?=
 =?us-ascii?Q?veurP62llcfm8JYPy9q37Q4ZFZ2iNfuCGwbLZ4OYQbJLa5xbSLWBq0yAvmyI?=
 =?us-ascii?Q?EFA8ElHxK+7f2L7oxpc/7JJ6UhMut9K1v+LYcGpBVjL7pDzJlBv2ziXMrqYw?=
 =?us-ascii?Q?26fzeBGcOtA2AijBwkAJvhRAMkBnM0fNbehuMnU24yoCdycm8YHuzW7d0lQn?=
 =?us-ascii?Q?OpAFEJLt2FUWDsvtMR70ppFLPlnf5wwitxvZuKKmRQkSYpU+3hWBE4seHfz7?=
 =?us-ascii?Q?ckATgc8yfmwFJmvIOcS0kf4ZV8kyCA0ilOc7J6ZiR+OQ7aPh/6mvuW4Kmlac?=
 =?us-ascii?Q?CszFHVfaTcwdzqrGlt/WtSLQfZez6PKylZ0JlJjTK+tRCx9wOg6p881YteaU?=
 =?us-ascii?Q?yuTZcoh6giybVRQBEHkmYRZ+XQOl329qF8A/LZJQFz72/3yYYpMyxSsJR5tE?=
 =?us-ascii?Q?vR6+LCMH8Vvc5ZA8ug4O6isChpgeu17mBb7qvw/zrjKvLwITXPRqtIxpUr9o?=
 =?us-ascii?Q?Ur5/Kkz+8QysK3inyM5ViXQu3lpNW2MGRzrNtXq5HoLY+0qGEtzq0aA35GZk?=
 =?us-ascii?Q?2IWXfnORHB/wuKoI5PV7A2A0v+EdHDYsUfhEkCPfYvCKUJ6mLimBBdnGRfSK?=
 =?us-ascii?Q?LXTQMBqBsMrhBe1lF86UF0YubHbNwJZDdwZChr3PYdepNUCRdrhB+cjYHaHL?=
 =?us-ascii?Q?cJT+d4+//0Nhkoiv4q131p0h4CWYs82CBWHYYgxHVlWvZ2fIKeI4prpMpSb/?=
 =?us-ascii?Q?o0Rt1kpbqpC8qCUG4MzunwouOFgl0n1OK2Uh50spkpGrK/egplGvd96BHCU6?=
 =?us-ascii?Q?a4OHeGP5ct5KS8hRZxUD9KhRLX84prSHx60dEVNhjxaJnM5rcTpGKocPlxmH?=
 =?us-ascii?Q?3NSe3WeL2OoJpPR9M2eC2JVj8ql0MmX7TSMcH7JkzsBn200HBkr0KMjzHh4g?=
 =?us-ascii?Q?VmfS/+qJ8JeUMDsJstngjE78+pKLoV7DGveywMqObkFXXU0QVqx5waEes+b7?=
 =?us-ascii?Q?yZIYANikFUV3wMDkCPwhs5tOnqubh1LsF1XlEUijIeAalW9/GutwLBVcSO4b?=
 =?us-ascii?Q?CsBPrL6IpkxoMIlnssmB1s1cT19K4ILqUoGzmzzKQdn3hSXC5omfMOKARPkQ?=
 =?us-ascii?Q?n7f6nQKi+6cBSHfHIvKdT2LF6ku4rDXhZ9XjCwc8ICtcv06iZfKbvW/iUGa8?=
 =?us-ascii?Q?3YbryxxsHdNiQweuS7cNwNYJkCt8kGCMOJy2c3+IZDTwUFbqONv6KHqYSlZZ?=
 =?us-ascii?Q?Dm7UpkxUVE5RiZilKnR9mqpOss0KnRX5zgMrnVRGR8vlyCRz0ratEXrapM5c?=
 =?us-ascii?Q?V6eVjkhl2NBv1b+W1yGl3K/axCcbeMes7si6RFpxlpL7cwlHSVztp0bwzvS0?=
 =?us-ascii?Q?UurRYxWSigvy1Q629IutncI+uQWdVswypeuHUfqMJEu+FEuEHd/0hW6QdOTD?=
 =?us-ascii?Q?h7yi/SNNgIUXDKYC/tgrHejUk0gQyyUplRqjMaBCBH7ub9f+Mfp87RhQBkyM?=
 =?us-ascii?Q?GglBVUx2lQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b53266-eab0-4c15-c01b-08de5a264e09
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:22:49.8626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSpw3PTt7bUexEsHYoFtaQCTlM6+Gr5pGcga2rndQJR8jL5Y5SaWLou21PDinoxrldmg1bmlLQ0Ff5l/YVeJRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252609-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: DBF5D6F9E8
X-Rspamd-Action: no action

The tx_buf has three types: FEC_TXBUF_T_SKB, FEC_TXBUF_T_XDP_NDO and
FEC_TXBUF_T_XDP_TX. Currently, the driver uses 'if...else...' statements
to check the type and perform the corresponding processing. This is very
detrimental to future expansion. To support AF_XDP zero-copy mode, two
new types will be added in the future, continuing to use 'if...else...'
would be a very bad coding style. So the 'if...else...' statements in
the current driver are replaced with switch statements.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 134 ++++++++++++----------
 1 file changed, 73 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 2d486a62c178..25747b9aac28 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1023,9 +1023,13 @@ static void fec_enet_bd_init(struct net_device *dev)
 		txq->bd.cur = bdp;
 
 		for (i = 0; i < txq->bd.ring_size; i++) {
+			struct page *page;
+
 			/* Initialize the BD for every fragment in the page. */
 			bdp->cbd_sc = cpu_to_fec16(0);
-			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
+
+			switch (txq->tx_buf[i].type) {
+			case FEC_TXBUF_T_SKB:
 				if (bdp->cbd_bufaddr &&
 				    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
 					dma_unmap_single(&fep->pdev->dev,
@@ -1033,18 +1037,21 @@ static void fec_enet_bd_init(struct net_device *dev)
 							 fec16_to_cpu(bdp->cbd_datlen),
 							 DMA_TO_DEVICE);
 				dev_kfree_skb_any(txq->tx_buf[i].buf_p);
-			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
+				break;
+			case FEC_TXBUF_T_XDP_NDO:
 				dma_unmap_single(&fep->pdev->dev,
 						 fec32_to_cpu(bdp->cbd_bufaddr),
 						 fec16_to_cpu(bdp->cbd_datlen),
 						 DMA_TO_DEVICE);
-
 				xdp_return_frame(txq->tx_buf[i].buf_p);
-			} else {
-				struct page *page = txq->tx_buf[i].buf_p;
-
+				break;
+			case FEC_TXBUF_T_XDP_TX:
+				page = txq->tx_buf[i].buf_p;
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
+				break;
+			default:
+				break;
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
@@ -1509,39 +1516,69 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			break;
 
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
+		frame_len = fec16_to_cpu(bdp->cbd_datlen);
 
-		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
-			skb = txq->tx_buf[index].buf_p;
+		switch (txq->tx_buf[index].type) {
+		case FEC_TXBUF_T_SKB:
 			if (bdp->cbd_bufaddr &&
 			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
 				dma_unmap_single(&fep->pdev->dev,
 						 fec32_to_cpu(bdp->cbd_bufaddr),
-						 fec16_to_cpu(bdp->cbd_datlen),
-						 DMA_TO_DEVICE);
+						 frame_len, DMA_TO_DEVICE);
+
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			skb = txq->tx_buf[index].buf_p;
 			if (!skb)
 				goto tx_buf_done;
-		} else {
+
+			frame_len = skb->len;
+
+			/* NOTE: SKBTX_IN_PROGRESS being set does not imply it's we who
+			 * are to time stamp the packet, so we still need to check time
+			 * stamping enabled flag.
+			 */
+			if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
+				     fep->hwts_tx_en) && fep->bufdesc_ex) {
+				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+				struct skb_shared_hwtstamps shhwtstamps;
+
+				fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
+				skb_tstamp_tx(skb, &shhwtstamps);
+			}
+
+			/* Free the sk buffer associated with this last transmit */
+			napi_consume_skb(skb, budget);
+			break;
+		case FEC_TXBUF_T_XDP_NDO:
 			/* Tx processing cannot call any XDP (or page pool) APIs if
 			 * the "budget" is 0. Because NAPI is called with budget of
 			 * 0 (such as netpoll) indicates we may be in an IRQ context,
 			 * however, we can't use the page pool from IRQ context.
 			 */
 			if (unlikely(!budget))
-				break;
+				goto out;
 
-			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
-				xdpf = txq->tx_buf[index].buf_p;
-				dma_unmap_single(&fep->pdev->dev,
-						 fec32_to_cpu(bdp->cbd_bufaddr),
-						 fec16_to_cpu(bdp->cbd_datlen),
-						 DMA_TO_DEVICE);
-			} else {
-				page = txq->tx_buf[index].buf_p;
-			}
+			xdpf = txq->tx_buf[index].buf_p;
+			dma_unmap_single(&fep->pdev->dev,
+					 fec32_to_cpu(bdp->cbd_bufaddr),
+					 frame_len,  DMA_TO_DEVICE);
+			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			xdp_return_frame_rx_napi(xdpf);
+			break;
+		case FEC_TXBUF_T_XDP_TX:
+			if (unlikely(!budget))
+				goto out;
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			frame_len = fec16_to_cpu(bdp->cbd_datlen);
+			page = txq->tx_buf[index].buf_p;
+			/* The dma_sync_size = 0 as XDP_TX has already synced
+			 * DMA for_device
+			 */
+			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
+					   0, true);
+			break;
+		default:
+			break;
 		}
 
 		/* Check for errors. */
@@ -1561,11 +1598,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 				ndev->stats.tx_carrier_errors++;
 		} else {
 			ndev->stats.tx_packets++;
-
-			if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB)
-				ndev->stats.tx_bytes += skb->len;
-			else
-				ndev->stats.tx_bytes += frame_len;
+			ndev->stats.tx_bytes += frame_len;
 		}
 
 		/* Deferred means some collisions occurred during transmit,
@@ -1574,30 +1607,6 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		if (status & BD_ENET_TX_DEF)
 			ndev->stats.collisions++;
 
-		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
-			/* NOTE: SKBTX_IN_PROGRESS being set does not imply it's we who
-			 * are to time stamp the packet, so we still need to check time
-			 * stamping enabled flag.
-			 */
-			if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
-				     fep->hwts_tx_en) && fep->bufdesc_ex) {
-				struct skb_shared_hwtstamps shhwtstamps;
-				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
-
-				fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
-				skb_tstamp_tx(skb, &shhwtstamps);
-			}
-
-			/* Free the sk buffer associated with this last transmit */
-			napi_consume_skb(skb, budget);
-		} else if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
-			xdp_return_frame_rx_napi(xdpf);
-		} else { /* recycle pages of XDP_TX frames */
-			/* The dma_sync_size = 0 as XDP_TX has already synced DMA for_device */
-			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
-					   0, true);
-		}
-
 		txq->tx_buf[index].buf_p = NULL;
 		/* restore default tx buffer type: FEC_TXBUF_T_SKB */
 		txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
@@ -1621,6 +1630,8 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		}
 	}
 
+out:
+
 	/* ERR006358: Keep the transmitter going */
 	if (bdp != txq->bd.cur &&
 	    readl(txq->bd.reg_desc_active) == 0)
@@ -3414,6 +3425,7 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 	unsigned int i;
 	struct fec_enet_priv_tx_q *txq;
 	struct fec_enet_priv_rx_q *rxq;
+	struct page *page;
 	unsigned int q;
 
 	for (q = 0; q < fep->num_rx_queues; q++) {
@@ -3437,20 +3449,20 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 			kfree(txq->tx_bounce[i]);
 			txq->tx_bounce[i] = NULL;
 
-			if (!txq->tx_buf[i].buf_p) {
-				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
-				continue;
-			}
-
-			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
+			switch (txq->tx_buf[i].type) {
+			case FEC_TXBUF_T_SKB:
 				dev_kfree_skb(txq->tx_buf[i].buf_p);
-			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
+				break;
+			case FEC_TXBUF_T_XDP_NDO:
 				xdp_return_frame(txq->tx_buf[i].buf_p);
-			} else {
-				struct page *page = txq->tx_buf[i].buf_p;
-
+				break;
+			case FEC_TXBUF_T_XDP_TX:
+				page = txq->tx_buf[i].buf_p;
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
+				break;
+			default:
+				break;
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
-- 
2.34.1


