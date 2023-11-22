Return-Path: <netdev+bounces-50149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5DC7F4BA1
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2271C2097F
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA9E56B9D;
	Wed, 22 Nov 2023 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QLz4ir8V"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F4D10D3
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:51:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQ2apx5e/z/qIraun0FYg9OSQpPtTMw+B2fgdBS/u8jzatcfXJJdZcWip05PM1Vsfs4LL1lcK9kmBEokqagy+AwnHvxWuNsCZMMg64vbmlQWJ7VGfmhTz8NmkqBaH8CAODYH8kOgJftfW6nIkC1tg0I6+8DIDdmprMWgsZfcOfYBl8NLmK2/rzf/fqEbYdX0ztSpqfBo5wmdV366OS5cKRp9FbcwwC3hVWU7mOcyWT13fmFUuU+r8h5JCL1HxhHwJfLjS3DGHZzpnZdhIsvJLL4J7VKzuExHaoIoJWDL48Dua49Dy5lRgQvN3WiZ7LMzH7wJTHBPEdvG6ABWvum7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcnEYo2Qf+RDJ/ziMOLO11M3nr+ZxJrmN75fiudum/8=;
 b=juofOglPU12UHHllyFCdKEbmNfYsk6aJaITT6hU35hWZMGnVQQuwIv2v5nLCd0h1N5rwpexIwdvC17jNm6R7AGdy/W+AoDAX7gn97ZxUNYs8dfzQ71oCNo0dgj5ffreNC6uXWjQyg9K9ZF3brgpqs5bPioSdBnYLw6dBsrBmCLivrZtxuU6z2G+JGTx++3Tik2LXP4aj/r+Yz+gFPfQ1O2MHqYNttnOSvEF4gXPJzks6YfxsA6fYSSMFi8f1mhJPTszkPvdOGQycp8iAs6zA/4TUSmrfv5zNAjDPVXSlISJfM1Mx88oyhWAAWllCxHDxcAsNKvaRfV4v0PhG1JfJvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcnEYo2Qf+RDJ/ziMOLO11M3nr+ZxJrmN75fiudum/8=;
 b=QLz4ir8VJP9m1CorDgbMD1jJUHh+BEXepJz7d98e+qEnteYd9WLAl6ClRq6vVlkuaEV+0Ilw3H1Y14V2LDNdgdg7Y2zdU2poAIVr/JtOZvexdjnTeGYi4qQRrYojgiznM4KpIENJbTr4FVA04FwxvWi0FVU8M1lWwMdxl5zSi7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 15:51:27 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 15:51:27 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: andrew@lunn.ch,
	netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net 0/3] dpaa2-eth: various fixes
Date: Wed, 22 Nov 2023 17:51:14 +0200
Message-Id: <20231122155117.2816724-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0043.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::32) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS8PR04MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: b99ceddc-d05d-4f6a-eab0-08dbeb72e33d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VJgX+LTD6/6oIZ2vyXEeLJ8dzimuta11v1Ranmjqzq5TOzHclByq7rvhxD00cMmOmm8e81SB+cDYYX+5ItEHEULHzZi0Mv/qysoFQyPMVACJfDLB8GjOawL+TjMUQLvxJP38XaqkWK2ipvg78WyxycHq94tPJd738JqMGsPLbS6eHWyoAfYJEXcjxPAzNlGvZtCN82FZ6Puk6paQdGzfwPk7wG5k2vNhfRdwmYpuEAaYhNGGD1U3KW41hfrgs88FhOGpaEo6HwAT5GjdSrd6JvQ7oVD672zpEEm4PATF7DXSeodWpJfBK07KI0ndz7CJMKvlgVvaoMtIDtJUt6ULQq2iaBGqgAbVk7E/i8ZpBqRfg7PamaKzrwTd7r8XVzrfQ2BOVXUO49hNmMATq90g/gpAwGl5PZkDIbWe0tbrRf3zud55jg12UvKaj8YNZY2tRwgqhABzGSFhihTT3tC59OlP3r0J8p/pcG4jd3bM+xOhV7tQB8ARpUGE1lBSoC4vySkEWPxoKWA315lcNVuYZtl39Ro4hd8/DgvOTTO6kq6+25zit03VxeqXlXZnUUsH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(66556008)(66946007)(38100700002)(66476007)(36756003)(86362001)(6512007)(6506007)(83380400001)(26005)(6666004)(2616005)(6486002)(2906002)(4744005)(316002)(478600001)(1076003)(8676002)(4326008)(5660300002)(41300700001)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ER3KggPsA1g/vqLhG6HyOOy/6Yw+j7eJEeFsq9k2MVOZmsTM5/FD5yq5Ugto?=
 =?us-ascii?Q?9lkeCcu1iSFL1zSpz2eE2NtPG3Zk/YLu6BvyFsAq9akCK0Pm8aYg1g3zZ5aG?=
 =?us-ascii?Q?sUVB1gEe26dWMyUqAZoT4dGS6E6kknJwDaU19lPtw+E9NLdP+SChIWUW3oX2?=
 =?us-ascii?Q?ypuHy/LOvHnPo14c4HQBf9FFKw9HZNL4/l99wspqgcbzNcjKwjpCJ/FZG8rg?=
 =?us-ascii?Q?1DF3HY3TrOB0xNR0uCtBDOFeo3Q0EuuXY+/siocVGx1NA7GgDA7rSNGzAMNq?=
 =?us-ascii?Q?vGayckC9X6t4IsXYjT1Ij9XUdOF+vONzedHsaOcHizvQFKrFrx3JLk0OVjr9?=
 =?us-ascii?Q?QXjNId8Y/vthdLY7TM1JJXz766+ym5KClgQU3KsclnmlH4zBNhusnLWn/XCo?=
 =?us-ascii?Q?i2pNPBSbLZonkQAczfpjz2VOVxVm90JxZmK8bbjYdT/unuX+RU8X2GNtT2j0?=
 =?us-ascii?Q?PKvAEGA02NCfpxEF68zWIYKrzgdnER6GL3hooTcmNf8MNhqYBH1Z5l0QCKS7?=
 =?us-ascii?Q?EkJdBK0lCV1rV2SP6O8ga2tH8IkJ9GnpFysR43pebhCK1iW/f1dVwQYFhTdK?=
 =?us-ascii?Q?mqK6Zj4SH55okbOb1NzURugJ+deoJFqeY1G2hJvub8p//RwQD90g6PvSaLFR?=
 =?us-ascii?Q?3YAfIS0DxBM8oblufihrExff8p0UFnAzs+9pDxuuFgC5eo1P4cgmyPT1mASo?=
 =?us-ascii?Q?X6S5W28sPjqBITtwAyH2Xm/zTlE78QfAgn1coYV/bAu+7sQNWrb+G9esFbos?=
 =?us-ascii?Q?aUO7M0d555OkkWu+D6Y0wloRlPj3aVptq/Pgztpozm+9XHSpqHuJuK6+u2+B?=
 =?us-ascii?Q?iqI/Z+9nFu+FPkEEpNXQ76iAgR/Auv1FiNmbagaj2AdC1cnah+SLQ9j/tTm3?=
 =?us-ascii?Q?LqXS284mLEzBiI+iNJSDXho2bdYBGrPbNp8C6VH2hRILNrBmReGpyR0WAtTg?=
 =?us-ascii?Q?xJba0kH0gYtseSskazgVH2KqmyZ5Q7twjpWrmv7eRN6GUVIwyCggmZ0BiebR?=
 =?us-ascii?Q?VlvZ5eFLLLFI8n6a9JpcQM9RqLNCopqD6lbkLFYPZErw/bBTUNovEmfPfDue?=
 =?us-ascii?Q?WpTJiskioPT6drdi10nLZQXqwfHd2IkDdo36V8nGtLL7FAgVR+LhwI81yVHt?=
 =?us-ascii?Q?AsK7KGl6ojEbbeLopy1hXAZxuY7YivMax1uS39FajyY2RpDl5F3ftGkxJNX2?=
 =?us-ascii?Q?WSRmKCIkZPASBSGXOVWMU8+NMIQiIuUDfd2OuwmckT/e6O8CQepUCO4nJIEc?=
 =?us-ascii?Q?l+O5ZHD1iCJajkOH4+AglVwjLVNV2zQqrLqlDjToNqhRXC0s8xwL4i5qcxiq?=
 =?us-ascii?Q?8CH/3Bv2HmLXE2ApcWQJCEooVA0LnCuwhzP49qoma9zd3pIT3HJjVgiek6uT?=
 =?us-ascii?Q?Bsg9SSPkfG7MV3XR7j+Z3GJTlTFkYZFK6DWh56vZFlCuXenxNa9pPz5UWQp2?=
 =?us-ascii?Q?+6M4Lf8vt7z54xDPDnEOeYP01BchroW89XggnWieg3cXEfw7FBV4PaOoMq5l?=
 =?us-ascii?Q?5uDGWcQiLxe6FmwoGdEJD1z0dSV7OrlqoBBKGBZ7VSshxWjQAX1yvm5CMeK/?=
 =?us-ascii?Q?z84werkCQ/aALlpjgGNujvRdW63UBcXhigXFLF/J?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99ceddc-d05d-4f6a-eab0-08dbeb72e33d
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 15:51:27.6085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Spu9FEbmkbmjpBtJEo4Re+tnhN2tu+mdmwa1a/lhO6yVec2zFu3uSlqOQ+Ccqi9aA1sap7EmBAtcxzPKdiKyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

The first two patches fix a memory corruption issue happening between
the Tx and Tx confirmation of a packet by making the Tx alignment at
64bytes mandatory instead of optional as it was previously.

The third patch fixes the Rx copybreak code path which recycled the
initial data buffer before all processing was done on the packet.

Ioana Ciornei (3):
  dpaa2-eth: increase the needed headroom to account for alignment
  dpaa2-eth: set needed_headroom for net_device
  dpaa2-eth: recycle the RX buffer only after all processing done

 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 16 ++++++++++------
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h |  2 +-
 2 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.25.1


