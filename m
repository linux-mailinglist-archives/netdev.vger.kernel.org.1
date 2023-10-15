Return-Path: <netdev+bounces-41072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 481007C98FF
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 14:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2BB28167A
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 12:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDCF63C6;
	Sun, 15 Oct 2023 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="hpAaDbTW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF65FEDB
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 12:37:10 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2112.outbound.protection.outlook.com [40.107.20.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928C0AB
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 05:37:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PI1vQi1We9n/a72q0+VQ2SCVY0raKU0jWCsgWOET1zPwC2oLpMnvH5UCjCE1EUoamSCIGbR/BOyrkW/I6YyI9E31j/pVf5G4RYKcy9eHpdkay8c4oMcmxnmV8LFqdk/ZY4k45jEVA2gAHDxAAn1ycCAaDtJrAIp53R1v4/+U35OKFrqs1Lx8t12nMgEso5pUGW9UQE+6knFj8gjzq3xE7Fn8xUvyWbyQWTLZOUYdAhgbLDa9UwgZdsi4TJgNf7PrPBfNo27u/m3U3X7Y9BhrgssnSwd0AQmkEajFNvU6CQXzLiL3gO0tqOo5juM3HccAHHA/rx0/7PV/Wtb8uN2Sdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvgzguQnNuPk93uE0ZhDpoocOMH1CohPVY+sdiPg8+A=;
 b=BgOVEAjKSqNw3Vzu5fYzXPR3Jq5RsgUcmZSGa62mJPN0sz56UdC6PJgNnNij5RRXpn6tiO2gT6xEZadH4o2nf2UjLgO8XIV0y90IJyK4kDOqS4sXDyFvB9n0Ks0N9hSi/tmgiU1MatHjv52NZTCM9y6FoP+Rdcrdt1J0F9TWJp/D9uqcqaQw37kRLm6+gQWMyx/u20C3HFmmFh+sb2mVAaMandXp64RokPsqhWNQ+96SSCPtdX/1INjxvE7EkrXkjqD2Cmkt7b7TjcDq9CarC6OEVJypG4ccmHKZvHZzvs4BmPDbrDHxS1p1YAe6gY2AAxd6IaSgR75b7NvWmXi+aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvgzguQnNuPk93uE0ZhDpoocOMH1CohPVY+sdiPg8+A=;
 b=hpAaDbTWGc/WecPO0GijL47g420rQNIxWxwRKcc9gPVFWRuPJYE6PO5F16zZ9VJZcQi76FMwdvIFuC3roKiXhAEYaZJ6pl3mi2zDY5tWsIZgQDUlKUjW0JmQoyD/5wr6EKkGI9KxSxILAtPKhjDhUyOlYEqBfZBvmFPYEk1dsoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=voleatech.de;
Received: from AM9PR05MB8857.eurprd05.prod.outlook.com (2603:10a6:20b:438::20)
 by DB9PR05MB8123.eurprd05.prod.outlook.com (2603:10a6:10:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Sun, 15 Oct
 2023 12:37:05 +0000
Received: from AM9PR05MB8857.eurprd05.prod.outlook.com
 ([fe80::cd64:d5c9:2116:1837]) by AM9PR05MB8857.eurprd05.prod.outlook.com
 ([fe80::cd64:d5c9:2116:1837%7]) with mapi id 15.20.6863.047; Sun, 15 Oct 2023
 12:37:04 +0000
Date: Sun, 15 Oct 2023 14:36:56 +0200
From: Sven Auhagen <sven.auhagen@voleatech.de>
To: netdev@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com, brouer@redhat.com, lorenzo@kernel.org, 
	Paulo.DaSilva@kyberna.com, ilias.apalodimas@linaro.org, mcroce@microsoft.com
Subject: [PATCH v3 0/2] net: page_pool: check page pool ethtool stats
Message-ID: <lzjlafhtal5ho5wvle5v7uu5uw7afbxe26ztqvcz3cnjjaq42g@bpudjgnpikci>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: FR3P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::11) To AM9PR05MB8857.eurprd05.prod.outlook.com
 (2603:10a6:20b:438::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR05MB8857:EE_|DB9PR05MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b1c3ee5-1979-4484-3d4c-08dbcd7b6fd5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aGq2mvXFZCd+oEdou3hDkhuV+x+TIRyXHqVwr162NfP5aCE3g6M0LORVfsmNaAoQAEYRC61lq36TLVH+aV6invk5W2NWupmNd1HhE8rfSxcOT5KtuvaS8MIHRJ2ErxkjA8fIXjAMNTf4dkXEvRpR6uCbFsswYkH6yRo+HAw5D8X4wptSH+zFik6QNv6WKwoK7mdHxdyC3SDwk1MJ0WvvXsDCwBjvPkF7k6u4026d0NW4s7hbcGjf1koI9MC+ZPYCqCBiOKS+TYif4d9HCDvjSW69yOVJB0c7eEtT+gmpsbJqLyBhfhzBA1qSUcvclZH8PJ/kphE9CNfTWAsQxvZqTrxzx3xym5DImGZjg+FF/TyjuaGYEv3EPRmfdzE8ZNbUFudx5o276LgxySmx232FbZjNp/NbiSh4o6KaNpgT342ntgfDWb4sdhSTtmeTYnRTNOMdTFwqQ6GxZ0sjo4nE8KR5kscLqPNeD81CV/w4YTeZqO4oH15fUfPsweDFHDZFFld6aPV+vmfN3NGYdhKA/cNBMwgsbM/7EhwrQsYRcmv9d8UPo0FB0YQa+kmDnv9DTucXJCyVsmJhcwt8wmnXm7XI4ltqCUe/E4OuYMNNfkY8mZireJ3aMVbcsv6M/Odx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR05MB8857.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39830400003)(136003)(376002)(396003)(64100799003)(1800799009)(451199024)(186009)(6666004)(9686003)(6512007)(6506007)(5660300002)(8936002)(8676002)(4326008)(6486002)(478600001)(83380400001)(26005)(6916009)(316002)(41300700001)(66946007)(66556008)(66476007)(86362001)(38100700002)(4744005)(33716001)(2906002)(44832011)(27256005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dcDFuqIgy31OOV7VlzdK6/kde37cv7uY0yx9IoPhytyXvdoygaK8h6/P/ksu?=
 =?us-ascii?Q?LrkDpWb/3fQ8wXYoylHBbPtdh4YIVkwJNhKZ3QvkgJw6xWwIX6tkExG255Vx?=
 =?us-ascii?Q?09Rc/Klr3cWVqBM3Z1pq+WHDA10RX3qmirw/ICR9z6IDpKG+ylwLyXgXSaSy?=
 =?us-ascii?Q?J6YaAWCi0sxAbJmyusq/W7nnHzOjN2e+CPF74/hyKO2RRLimXV9clg1SzcIZ?=
 =?us-ascii?Q?tZUOvF/SMRSYCfTQyO/IRAiC8qmQAF9oaRlrb7KvcUxri1v6asW8nPweR8Uw?=
 =?us-ascii?Q?UeDMvTWDFUtSJp4jpj1MPsWrDU5iWOtsQfyiujBHkh9O5X/mewPF9APrNH0D?=
 =?us-ascii?Q?EgJ3j1WnSKwlucnU8elLZ04sDVxkRmcE0BmS8ojsGh8yr0GtYbUjkdo0SfIn?=
 =?us-ascii?Q?ExDmwXAgyJSZzLhpIHnAoNWnrriql4vvgv5NR5DgeXbyj02UUOpgVxqZCymu?=
 =?us-ascii?Q?p2upB8pmrR6TcMUzAW4AOI4+NMjktvRNUmXWg+XKogFf+y526ooTUEoZYz2x?=
 =?us-ascii?Q?zfV8HmuGTt1lOcZJR/cwV8PertabXHQOxSR7graQRuR755vUbPjNda75v1hx?=
 =?us-ascii?Q?drYKlQnohr0wPrBu7LU0CdJbqYEypEvdtR6h3RJ+2Ic2lquvz8RHmsFAKbgp?=
 =?us-ascii?Q?gfOaF3vJ7pW3HAo/gfPJhr7xaauWndQww24XSCswxBwD7345Gids3iFlOTD5?=
 =?us-ascii?Q?JKd6+T1AptMG66okrLYqoCttpu2cJBCOEx2f0Mxo5bV5niqm2nd3ZmT3vyzt?=
 =?us-ascii?Q?e/di4fPK4ZXyKBT2KWyOCTw5X5UUJjwt/5YbJ0e96WjJLvT6DM3tApJMB854?=
 =?us-ascii?Q?KdPhG9URkO63BeJxpbhBM21q8WIYoRZgRbJvR7g8Rm6BgruHsTAASxiDM5+U?=
 =?us-ascii?Q?ecbLGF+4kEaNaicPbDxGWawXhUFZVBq5Chd0kM5xb6/lfgLSfzsswhBgSVG1?=
 =?us-ascii?Q?PU5HtPDTnT0s0p29wVkJMH7sAb8MDorGzESC+uBBvSN95vWKIZNkmii/HaEC?=
 =?us-ascii?Q?6OMuGN4NYzqTAWAxV2H5x9Okyu9eAof6dWGQBmzY4y9VsFL65WoKPF3z+MEx?=
 =?us-ascii?Q?GTKHR3q5ItTIf8OgoZf76HZneYG9uEMSURzGuPrYN7rFGSmSTWFiGq1mbQ/t?=
 =?us-ascii?Q?di7p5LmE+9KvrXTIVp43BzGINW40r4AMQK5k+ROZ718HL130thNP9bIH1Jsh?=
 =?us-ascii?Q?h9vair4Z0z3wp20dcbZ7FCvoT/HUDdcNcARJTc1sFI0gfTY667qGR1HntfG7?=
 =?us-ascii?Q?ZRCwmLvBDGY0OUqIvl3w6CuaeXjuThUu5lMhTmSPePtxJvyVfG9vU22XuIs/?=
 =?us-ascii?Q?H+nTNUDtyeOE3YdDUSegMckzBWNSZAKhnburxa24TyurHN+QzyUFUmEC6/wt?=
 =?us-ascii?Q?CIeYHCLmSLmnOxToI+Dy33sagPPzkgi9MBHma5ooJUNa2MxLYUXBBUgvh7fG?=
 =?us-ascii?Q?YJ9rWsau258HQVHENEIDODrAbLPMcfkorxoPEoOTdICop0D+fvJ4h8IKGlXm?=
 =?us-ascii?Q?eqrBzqBFKSSJncU3inE80w6UV/Ae2cfTzKWFWKrTl7xNFt32fce7IJ7IZP0M?=
 =?us-ascii?Q?Ro4WIZa+C5+IoI8/aep9pSltESAXSW/DjyFggy+skkTbntSfqto5ETe9nfxu?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1c3ee5-1979-4484-3d4c-08dbcd7b6fd5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR05MB8857.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 12:37:04.5763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I++Zqs979rGozIuN6uOPBNs03NGIlG4HjexixnwkUmivmIDb0Wm0pbDm68UFZ9SkSdVjozIse7mAUopXtMb/Yw3a+edVwfVhSfZ8iXuLXqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB8123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch series fixes up an error when an invalid
page pool is send to the page pool ethtool stats function.

It also fixes cases in the mvneta driver where no page pool
is used and allocated.

Change from v2:
	* Fix the fixes tag

Change from v1:
	* Add cover letter
	* Move the page pool check in mvneta to the ethtool stats
	  function

Sven Auhagen (2):
  net: page_pool: check page pool ethtool stats
  net: mvneta: fix calls to page_pool_get_stats

 drivers/net/ethernet/marvell/mvneta.c | 22 ++++++++++++++++------
 net/core/page_pool.c                  |  3 +++
 2 files changed, 19 insertions(+), 6 deletions(-)

-- 
2.42.0


