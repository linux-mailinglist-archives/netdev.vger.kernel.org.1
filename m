Return-Path: <netdev+bounces-137882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5009AA4BC
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D6E8B223AA
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F4B1A070D;
	Tue, 22 Oct 2024 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="o9RaLwNZ"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A0919F13B
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604653; cv=fail; b=E1Z3sD1KnBVaDAP7wS4vRieMfsJQNRV5ur0OUKcYFyKYSpZXNboUoJ34chJxP7xnJmkqmuHR7LZtUeNMB48t26qlUoFCc35Ou/BdZuwcm/s1PrpqPu2H8tmDWKDHALHr7woFjlbFIE3iXUxsAoVKsM53FZd79mDFeqTCb6h+iwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604653; c=relaxed/simple;
	bh=OKCiOG3C5JsHkVQR+qOb3PLVSTNYOm9e0aXZzix9zhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cJg/Dq9dYfu4y3omm/RE+QNmGxU6Wdm9n2dtypu925k2JJF7dxmYqJ4pL9JSIGCULwxs/Lndz4+cWDV0gMUDBiHmTsVFg8LL6pWzhvfCGXa2iBF/PBnMMEO5fmtpBpKSGJjgvc3hW3YjE3/OchYBZGetzPzTLZeNY00mjEIGRpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=o9RaLwNZ; arc=fail smtp.client-ip=185.183.29.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 75DDA340661
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 13:44:10 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 6AB2448005C;
	Tue, 22 Oct 2024 13:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWLj+oF5ijgdPzJDcxbSfhZ+lwz7+sXiDsCEx7LS5AGpLznyJ3c7VXwmXTbjXth6Q4oaVhuuOh+cYLxxNzTvp/HjCGdtmMq4TV2GG/FuFu3BUNdDs/LYfMNt4nNrmNJuMOs1AsrgQ//ExiUuucPD0RBgdqiq1Vp0V5QlexZMWou+8P5OqIUmJC9Sg2lkz9UHn/4yuYPkJot2xtzG8w7hbZPQZ37opuMldNQ6CVG2rybcoCZjYEQ/qQn0qD+kHTCTNm/yrfk//xRcj8cmL75FDYbO0Yr6RTespQ5XSNuBDm2IQeRMYcaseF79CdS1MmPXS3GK686KOWlIqQ0niN7dAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23ZsMgA+4a6qSMX6V/8kkIwrJxqx0JJwTX3PBPxX/YI=;
 b=N/G7MUC86wBARSHk4jvMHTWyXvwYUSCwEuvJRWpAebW15XgfJB4ESD2wfBLhQBaqf9jPMAqfk++WvJzY19YxqjfuJ243Ao4B3JxwWeyjMmNeUotr2xRDwijFTPnvemgxZVcJVO9JwWDiKGvg812SnC6SNqoFuwfBp+6HuMA015SqcD3Lq2BhggHQqdH/FbYi4EkUfMkbOne14CMNbbVDW/m5oRdiXbWrzf5MR2uYlgXtCQ3wYi1AMG0HqscFFsXmZCTRQoCswk9buN6XVFTpQmrEnUUWZqLQhq/fVaSE7Eptge4gpiFrQPDafRvwG0VR+eD6PXOWraRSDD9ObO7bdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23ZsMgA+4a6qSMX6V/8kkIwrJxqx0JJwTX3PBPxX/YI=;
 b=o9RaLwNZ39YmApHVkk83M4N6/duBN+ArbMDvuBsab5DEZM0+hd2NS2hL+FMUJoG+GF6ThdZsdwwpftH2q4dcyMw4kw1tQ339/0pspSMZ1a+Q4KiNeaDXwAV6ly0XWm2Oetux3Y3I+G393rAZXf6QBhOM38sJmni7HjEfcS3EhgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by GV2PR08MB9928.eurprd08.prod.outlook.com (2603:10a6:150:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 13:43:58 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 13:43:58 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v7 6/6] neighbour: Create netdev->neighbour association
Date: Tue, 22 Oct 2024 13:43:41 +0000
Message-ID: <20241022134343.3354111-7-gnaaman@drivenets.com>
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
X-MS-Office365-Filtering-Correlation-Id: c8494e53-450b-417e-168f-08dcf29f9441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sSMC3sENgO6+F7CiEt9HJ0RdSIj1NIB/lfoTtzdbKvyj5DjlFq1U/z/OOcxZ?=
 =?us-ascii?Q?P3YrXPqAq2kc5k24zJe9GlNuxKOGJtdu2I2wwLxlmo6qoQP6ZekV99+sGBk6?=
 =?us-ascii?Q?SYHOSjl5HWNuMVp/C3+YAKsIUePikgAaO/J0JD+Wjy88flUXdJTHEMeL+kx0?=
 =?us-ascii?Q?eZu7oP441XLUtywQZmZdNp9mTAYkjegjBA8plC06htxKl4DPK93GV4HyY/Ds?=
 =?us-ascii?Q?YKIRy04M4oSS+9BbgK/GNaQE6OsZe3VZm8jGFciD6p8pY9XlrybRPMS7PVWj?=
 =?us-ascii?Q?KblSozTRNMXYvBwFo20ttTxGtYBG4GcXUtWkeLaDjEPp2zZgg9I1RWpMizmi?=
 =?us-ascii?Q?hI5SrhSUeqirk/qyMy92Pv1XSAXVTYM5unbJ7LyMT3PbVZJ+VjHYu3USUmOz?=
 =?us-ascii?Q?RHTqyjJrv3JrykkTeo4+evoyEd9s6ZXuAH2K+qPQIAk6yuHbbmXfr82ylXdZ?=
 =?us-ascii?Q?VQKhrZf+77HMmHI0eFmwZWtxWlnQSYz/B0y3oBNBwkW4do3i96kDEV/dJ6ow?=
 =?us-ascii?Q?Y6kyawQ+OofKmQeomUW8wXF1Ljdioq470jsJGFQVCHbhNJIEgv6ZSRCoyukl?=
 =?us-ascii?Q?v3Y1aFBlw52Lib7ZaZ9nmJ/kr3wfDe1jjTRDuyB2+Ak+O8hzBk/F0ljG3f+G?=
 =?us-ascii?Q?Nrn3IsvFJTdkZsuk5euIxcLwEgCuO4SUUe6DwJfAbIGvJKvDIvDkG8elU9eY?=
 =?us-ascii?Q?e016Ti8rCKirKfqoWsxLMmPOIjxogvuv/ufwpajJPvSuiMPwHKNg674MwIIu?=
 =?us-ascii?Q?AKL4REIkkpOAgv+3PNbtefqscuDesRH2wD7NMtBf+VXNQf1L1MwdCr20nJ6P?=
 =?us-ascii?Q?DWMGT8m86SpflTBe5UQLVEV0TAxGjGAFZitwWDyAmCfB9Yvcqx0J5Rk9h2Xm?=
 =?us-ascii?Q?PClEuLdx+7hUwW0fWQd/j/n3FyubpSPqzdid8YDob6P5taGfXmI8TYzKFne5?=
 =?us-ascii?Q?f0+WeZ7Haj6jS0edlw9fULJglf3bOOMY3Gft8Rjng2bhKxsfbe8CzxUV7Z9l?=
 =?us-ascii?Q?3CErIPphE6j7v2woL0Dc3ydAeBZCsuIehGBZOmv+DE8hbXJIL/5zSH7efrP1?=
 =?us-ascii?Q?ZPW8ki3Xu9tHCQwGJacz5wdKCuPix84NVQnvlmS+SQtzLbml3VwkXo/XzbNk?=
 =?us-ascii?Q?HoUgI2U8WPmK+DqLrEMpLs0isy/CCT+rTXIbKfaebQ1eTq8DgUDy4uO8Fv+u?=
 =?us-ascii?Q?0J/LvspEWbd4iEmbQYRWwUHv7QLZ3mTm3UAnzfTRs44kpE3EMJwDiBA2ngbo?=
 =?us-ascii?Q?rhacaq0y6/EXlwSyRyXTyRhF8OiSxpI4hB0GsUDZXzRxvsV6eJKRLiOs59Vd?=
 =?us-ascii?Q?F6Io5DhTwY6cKB4vLKZEphwwEt0kUKvQSSluQE4QekPTf2gNZQjPKZF5hYvA?=
 =?us-ascii?Q?jBOqOhM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LNT7DC6aJXU0aEk5wYHo7O2ST0l87zpKxXEP89GzkwAxS+bjbQo2+VokAyDo?=
 =?us-ascii?Q?5kN42OMJR8q93eAtaLd1cUVZM8mBNk/Tdz7/C4vsRmRUEBnDZCKt5EqycDec?=
 =?us-ascii?Q?lXD5cM5Tmepfuer8JYedvbUIz78HYdgoIh4ReIMXaWucg9cqtMYAgCDWbIrd?=
 =?us-ascii?Q?YrdLLj3t++DJt6FZ2Pue7h+VM753I+3z9Gdv9jKBNjCAHO6ICKmxTB9fD+cd?=
 =?us-ascii?Q?0KoxM34MzYtPc3223LDSAFRsW79xdEgBt8VTBbwCp9CEKO/NnoouGFslI+p5?=
 =?us-ascii?Q?Tmm+e08Mu2kUIrdjGI8sf+oFcruYDtBydensRIKaFUGxVejbLpgAkRen/div?=
 =?us-ascii?Q?tXOFDGxEwk980WeHnQqyFGyJ5RAhCC5YmJUXZty4xuj2sM9ZDj9W7BlBlw5X?=
 =?us-ascii?Q?06xv9fXnvBQaf+VOEhaDpp7RNUfvxWCVe6fFGbWnKHhincHV+49J2MjeS80G?=
 =?us-ascii?Q?H2S51mZRaLMc0kvIQIfOG7wIlKSLtpfIWXbEYCpL0qYc2WcteMux4HvFIh4p?=
 =?us-ascii?Q?9TjHHbC+68kXJaFf0I9l5TWeNz6yF+MFTtdWsftoV8kGKFc7iwqwbHy3cS8w?=
 =?us-ascii?Q?c0HvizCXnJRnvrr8dL+OrQp2YUE4c0B9qmylw97PkIs4EiaFkQ1H8JhySoF/?=
 =?us-ascii?Q?IXwf14OePSv3KeP+hA31OxfNjqQ6aHa8mL+ve6sJttN7JbPOChV69Dc446PM?=
 =?us-ascii?Q?+WrzaNhiaYEwXVqSXdziNE1Q/oAg0wrwiBO4IZJxJQ91IvJ+ghMdhcNxD8FO?=
 =?us-ascii?Q?NxoTM5EGrxcEVvbLHx3KHhFJ6GPsSl2C00/IppG48/WPIOERzcvT8u87TEJU?=
 =?us-ascii?Q?datxu7eZjzRrg8qpm+XgyqBkhZax/H3dUy0tOwKsybWdx1r+/FGbTcI5Oiyp?=
 =?us-ascii?Q?zd8qUKvguvbf+3zlMEeQnq+WALdvKCiiQNWRsKyyiYiHqlU06nK73pF213hR?=
 =?us-ascii?Q?rwixeaKVlYNgIQ8k5NEf2sCAs3MCIcpXhKGUaQ0/pd4QDPV5p+DxR1kcl1h2?=
 =?us-ascii?Q?u+Mg9NRhI8whXy6I8ENYqBItpK/Iuxf1f/uWpC2lRFxVjCB2FVbNv73eV4J8?=
 =?us-ascii?Q?tsny5lIZJI3u0rBaAYnp0Eq/XLW0IUEmsK8t8TkSkgI+AXIaDkSNTPv25HOz?=
 =?us-ascii?Q?EpCaqKSC+/lB7GRg1J9iMT/TchqItFItdL/F3b3VIM6X8lyNW68LtDgGcBpW?=
 =?us-ascii?Q?254JE2VqfwgyRxVuErrhBoP2YZBguBdrvMDKLjAjxGW4DboszIq62+xhELS2?=
 =?us-ascii?Q?d4jC+fKMhBDRuDGou/171sDgFW9FFQFaBLsGmjuQylETHQj2g71B1dv9xPk1?=
 =?us-ascii?Q?OcaySjZehhxXiXuV5wtKpkqcTaedl8Sv2TCSRnStVjcV7rDXR14u7NpmFhKR?=
 =?us-ascii?Q?Vy/Adk8IEWuWIQcQ0Upe4v0Rs5oVINm8LWU+3K1AcbZeFDoWkwpH57nvyQSP?=
 =?us-ascii?Q?OAh/a46FM4GemJR/Hwa5YZe1bzQiP7Bk4/N/uWafjR7QwrHMj5xuliwlJvl+?=
 =?us-ascii?Q?Ae3IDBF37L/2IidJIF2PotZXnowPflC7uonvnzNzeVRhYJzEJkBns4jbCV8S?=
 =?us-ascii?Q?XI99rIsNC8KHAqZ0R3T2rdwdSk070nKPLJcVkk3k?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b4fmWipyu/cIiRD57lJFtNpI6PZHfoJsxqxPboum6sFtqUcvsiZrhWlGulULNGp5MY4mVaiN+DScfrIVNb3D+DytlTeGSidJ5u/j8t9ohNzXpyo+ZbdQidmMAzrkju76kHw7lali9YA+GEoejwUMIUyWzSD1NHDvyq663B5wVVDzGBr5pQsg0Qh3uUrAtURv+1VOMg3W8TlR7X/Ml2ATCUSfsy5lPandFEwhZwh10bPis8mM1dn3Sn9lJLfZEVwHQW9m9hIJ5r8/6sIMLEHYkMTR5oqc273Fii3BueJ3zHsRtdHlYKD+LZoP2PY9/LOOa7gEO8WGUTy01oyOOR+eCuZykoNVn5q0JmeMsf5yGVv6vur+Nx+JQJ9cQM8q+dnQ5ozpnXpngzRzbmV2G7ZQ2X8ePSoRvMNZMDim8W0V2nuXtrQ2btG3stOe8iPwBy0pPWWquAcjsi0pWk675jCXqfjqKe9UDhBvKTk6olz4+A4gGCZekrDRQFji1HJQn/LtIyKPm4Awdh1MUodyNCJtazfSN/AwMUV2gFJcum8sauNiBgm112c+HmqcQYlI/jpvjalQvFhxnnA87h6DpIkFsQZdn4xsqk6Pj/Loj/Nw2pdD/8I7/qcEuVAcXERP0byN
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8494e53-450b-417e-168f-08dcf29f9441
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:43:58.2097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wuLYuIpHzPFcej3AOPdrIwY9x+5Mwq2gKw39ia8oIur+InrdGCNPCNL1Nd0PGpv5daAZEllEU0LRATvpmCo5Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9928
X-MDID: 1729604642-JEhC97yFqzIM
X-MDID-O:
 eu1;ams;1729604642;JEhC97yFqzIM;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Create a mapping between a netdev and its neighoburs,
allowing for much cheaper flushes.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     |  7 ++
 include/net/neighbour.h                       |  9 +-
 include/net/neighbour_tables.h                | 12 +++
 net/core/neighbour.c                          | 96 +++++++++++--------
 5 files changed, 80 insertions(+), 45 deletions(-)
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
index 0244fbd22a1f..bb345ce8bbf8 100644
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
@@ -236,13 +238,6 @@ struct neigh_table {
 	struct pneigh_entry	**phash_buckets;
 };
 
-enum {
-	NEIGH_ARP_TABLE = 0,
-	NEIGH_ND_TABLE = 1,
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
index 02bc1feab611..f4a772c71f2f 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -61,6 +61,25 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 static const struct seq_operations neigh_stat_seq_ops;
 #endif
 
+static struct hlist_head *neigh_get_dev_table(struct net_device *dev, int family)
+{
+	int i;
+
+	switch (family) {
+	default:
+		DEBUG_NET_WARN_ON_ONCE(1);
+		fallthrough; /* to avoid panic by null-ptr-deref */
+	case AF_INET:
+		i = NEIGH_ARP_TABLE;
+		break;
+	case AF_INET6:
+		i = NEIGH_ND_TABLE;
+		break;
+	}
+
+	return &dev->neighbours[i];
+}
+
 /*
    Neighbour hash table buckets are protected with rwlock tbl->lock.
 
@@ -212,6 +231,7 @@ bool neigh_remove_one(struct neighbour *n)
 	write_lock(&n->lock);
 	if (refcount_read(&n->refcnt) == 1) {
 		hlist_del_rcu(&n->hash);
+		hlist_del_rcu(&n->dev_list);
 		neigh_mark_dead(n);
 		retval = true;
 	}
@@ -352,48 +372,42 @@ static void pneigh_queue_purge(struct sk_buff_head *list, struct net *net,
 static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 			    bool skip_perm)
 {
-	int i;
-	struct neigh_hash_table *nht;
-
-	nht = rcu_dereference_protected(tbl->nht,
-					lockdep_is_held(&tbl->lock));
+	struct hlist_head *dev_head;
+	struct hlist_node *tmp;
+	struct neighbour *n;
 
-	for (i = 0; i < (1 << nht->hash_shift); i++) {
-		struct hlist_node *tmp;
-		struct neighbour *n;
+	dev_head = neigh_get_dev_table(dev, tbl->family);
 
-		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i]) {
-			if (dev && n->dev != dev)
-				continue;
-			if (skip_perm && n->nud_state & NUD_PERMANENT)
-				continue;
+	hlist_for_each_entry_safe(n, tmp, dev_head, dev_list) {
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
 
@@ -669,6 +683,10 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 	if (want_ref)
 		neigh_hold(n);
 	hlist_add_head_rcu(&n->hash, &nht->hash_heads[hash_val]);
+
+	hlist_add_head_rcu(&n->dev_list,
+			   neigh_get_dev_table(dev, tbl->family));
+
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
 	rc = n;
@@ -950,6 +968,7 @@ static void neigh_periodic_work(struct work_struct *work)
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
 				hlist_del_rcu(&n->hash);
+				hlist_del_rcu(&n->dev_list);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
@@ -3069,6 +3088,7 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 			release = cb(n);
 			if (release) {
 				hlist_del_rcu(&n->hash);
+				hlist_del_rcu(&n->dev_list);
 				neigh_mark_dead(n);
 			}
 			write_unlock(&n->lock);
-- 
2.46.0


