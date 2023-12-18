Return-Path: <netdev+bounces-58626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6D3817963
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 19:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 658FEB20E29
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 18:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550185BFBC;
	Mon, 18 Dec 2023 18:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hIoArl0U"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DB45BFAE
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWyvonoVDY8HnrRMiMr+uN3Vpnt3syxEmDlurcfIAN/mD0t3bk1OZ4n3fjMOt6xltZcMH5YVNvvpgoNx9al4ecDH6CMAyZOqlkZppWxhfZ/YJsaSOwdVTwguIQnJva7gysGQ6cBPcl2f3RaHCo2rAd/AbTsl98e1XuUVS6GS+ocJ688EfPZc7hxP5dICsLozgH6vZbMCMhE4HgUmbz4ewppT3/KBe1ThB01xUN+3jOIFP9/F9jftDm9Ry4s2lUFyDugRkZ88cdzP8GUPPrUSW8nZJsBHt8iQ981Jep1izfly6+v3/p8uBJzk/Eqfvlw80axznThpwNILg1hNoWgZ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrQYkkcMOSVIFKcCbHwi/a75kQk48tHFuyfcWCm15HA=;
 b=HQk6WbFJS6zM5sndQvJ8e2Jn9G5CR96nAKYBb6Tp5BrgUriOSHgUBDPQ2A/hZv8CD8DZDeQferN6kjL4NZqv0uMXwBZnGvVVHBGdgJb6sDq9IJ9/alxmBbbjAfn4FgddNtmApq/7ur6Yfs6DLFJd4ODMJpA0b/y4HuHp63+UUBQhegRiCOC+dYOKzboRsEx30+tiyFIXRQaAxx/DrD+nm6rJPPN88oRiMEkEHDpLYuQn4YC6fJn7nHJ4hySv4fjwJKOkOO/iocU8iGm01Fp5YjJEN3M8ewcx8MYIbj8yvkHht3vOq3S8Oy09as0lS5wszDlXn91wkvz3QtbPoX6ejA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrQYkkcMOSVIFKcCbHwi/a75kQk48tHFuyfcWCm15HA=;
 b=hIoArl0UanNCTTAbJ0xuzLL5qqz7uitWbobv8NPtQAJ0k/J8PytsbK1qVaaCnlPF3Gds6h7jrUtwSfmXydFOWW2Bx6ARqRYivwHSj5NLboPcl1FtRctvs6SW3jQLRi1uv0hBPXle6FJ/6mzXxMNPCtkKVLxToW2IWxkeSjaH6qsDgLAn+ZLABd/Vk3FDiAb3nJPPGMR/EjKP5zVeZAx+GOXbN29BY33NhG3zYfEtphWyDdKptnWSAArSR3akS652202nhzPTN0qSP/lWdBrUgOFdtMtgtBjaq1QqdIe4vlH9FKIZsEiIgLir34RQGkPsujYbe8gCK6oPpVQnVRGSZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 18:08:58 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 18:08:57 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com
Subject: Re: [PATCH v21 06/20] nvme-tcp: Add DDP data-path
In-Reply-To: <1b0b08f9-3e1a-106e-15ec-46cfe07b1e28@nvidia.com>
References: <20231214132623.119227-1-aaptel@nvidia.com>
 <20231214132623.119227-7-aaptel@nvidia.com>
 <1b0b08f9-3e1a-106e-15ec-46cfe07b1e28@nvidia.com>
Date: Mon, 18 Dec 2023 20:08:52 +0200
Message-ID: <2538r5ridsb.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1e3521-e57c-42c7-7ff3-08dbfff46759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GmrnoHgzqOCv+E2hEQrBD/KRmlwggw0mE4bpk1T+zA6EmaS3Jlq1WkFzSKKLNy5bGjxd31c0dh7Tm7DbYoDKajIAiWbR2tQQA/CPub4ndmy0BiwOPKmRAKkA/iBJxsQs59lZSHtwAI1gx6xWmwM5czKIUwOyQN2ZIK81/R47K2mD+Fx/TJbyUcRwKQDHUkBXJpUqFzHzBCRlFby/IYnJ5pw4BsDARMP5ZAJaA23mxpyDiHtDrZr9gCoBcfp89+q2tTyAjkP3ysTA1BiGkcPcDYzUpZyf69ArKP758KGBjdQBTPqlcDL45uQRAjrcVrziw78fwHnzmunqaSaEaK0rgeF4+OilfapPgqmMIHJWX//z0Av+NlmHmRO0kDIxNbJRPTcQLPLz42JjTciytEckk3BZPGY19d7lHuJWY0XJRvRHkBA4AxLsxdznUl6jlqTFhzNxd9TNlZCshzFUEkHKF1gOZJtGperawksfIMqwiURkmtN1h+L8sbyIA2xDWebJpne2lOvnMQCq6O0I8UgPZrHPgk6HTmXruPgIvP5/utDIEadmg0XUusGWhB5vDoOyjJD6U8SoIYnPOF9s7372w9s+FYlHDG6YSVUlxlINw0M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(136003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(107886003)(2616005)(478600001)(6486002)(26005)(38100700002)(4326008)(5660300002)(66946007)(8676002)(316002)(8936002)(7416002)(41300700001)(4744005)(2906002)(6506007)(66476007)(66556008)(6512007)(6666004)(36756003)(86362001)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gdrgiuMsT2JAe+wx1bHvZZyGaJ4dSMoXGVyK3pTIu+ZaNLl7731BjWuMqXFu?=
 =?us-ascii?Q?v2lB2xrymy91hh3o7wFsHa4F7Y0rkw7OKHQOmIxX0/Jv9kAQy4PDJfZaeipS?=
 =?us-ascii?Q?Rl1BTXLZoVOmNf0sWzE4hdL20IXPyk1cCnfU9OC/UcXemK6oUzxXOUzIF7or?=
 =?us-ascii?Q?y3k1irYgy7Fx7WqmqLQ4P74D2uXjbcj1r90e/s9f8CxfW0YGBS/gxiABY6bu?=
 =?us-ascii?Q?BPsInwMjq0ltQWYcrpQDSIDKH5Ig03LtkR4NSYwgBB5dQtazSgyLlp/4hLwD?=
 =?us-ascii?Q?xEBPdjmJitE2nilW40+zgKzABq1s/+j7Dru9IL8owSwGmcV89nBSo77idtEk?=
 =?us-ascii?Q?QfzeJF5cS1Zb1vQo3V+NcF1m90MFSkHmNMbzKbv3K65+22y280sgOrU6nk86?=
 =?us-ascii?Q?eBUZonoWSVKtghgr1G50S8I2+TosrgVyfrJam4ZWW7/iib8LwLT9veBoy00n?=
 =?us-ascii?Q?xDIGGCHhlyqnc/SDRxU5+Lk2Bw1fBdZfEkbnhAu+lye5byxPzRxPjJoA8xoh?=
 =?us-ascii?Q?zEX+feTVWJYF0Q7P/qKDoajgv99Bu26eSZ4nJG0liRpzwpxwQ9pJAa2gFahl?=
 =?us-ascii?Q?GjY1IJ8drP7hnXoP5PXWWvyIVV20a9YyHHiNxuBI3nz2ftPz/vbgjXzCFXUk?=
 =?us-ascii?Q?osq6d7Iq7wXKlWQ5Ml0akoDF96PLo8yBr3E2nfJSYtfVGIIWgo7nla+gG/CE?=
 =?us-ascii?Q?1RNl+sCqhET/AvvT03iYgTkX3aR6bS7HPOf5cL3NXwE4pWs/MeirDUvirlh+?=
 =?us-ascii?Q?yg8O9F7IFqrh0hulqK6FiPV+AwEKe5/Zm5DyymLdSYHuWPV35WuqvEJyQ15l?=
 =?us-ascii?Q?DhJ7mZti4QuVlMagb4iK50KaaxmIu14rDEA0k0qY3XmS/jMLIhuZ+pmJNAFY?=
 =?us-ascii?Q?3DU0X6CiSoZR87N/MkXz4L5PLv7Yr9Hle++RqtoL9dM9MU6vU/D5oFPpV2F1?=
 =?us-ascii?Q?/pRYm8OzRSOWggGivQtVhwrrRfA9rrxGPx+yZucJzbx7+x5A5mMCTO8skAwd?=
 =?us-ascii?Q?qeFUXO39fx0lAT+aKyChmpFJMgbLXsBlFwOZnrWw2X6/J7l2CXQOMvTRgkbr?=
 =?us-ascii?Q?2y9eOUS5DFctNR+QqwapTqSQryxuZNcjKKtWqr387aoWWipeSiq8h3Nmy5ft?=
 =?us-ascii?Q?4e4xBkoJh2yo5FR92zNZtNpXSZPXhvmXWc6/rxyceX1XCvcSWxJY/Sb0fsNc?=
 =?us-ascii?Q?Z/6q2OFq7a6+Xx5F+Dbi17r+R/pMDi6G4+pfJ2+VLBbAMtryDEWQVga5mKSt?=
 =?us-ascii?Q?gAETaWMDWrf2R7x5FEy5+O/m+iDJPx5h4Z3Unl3E96xZO4LQADzA8rs+3tR8?=
 =?us-ascii?Q?dt3MohHvg1tjzPTPQf1bhyTkRm9pMwdZKX2iPqbG9EMfbOs/5YVVuUgZpKWT?=
 =?us-ascii?Q?qZPAqF4a6ri8V/A8v8FRptFkFVOP0BTvdhAOLTBHOBfSRID8LVG6/ZVk3oF9?=
 =?us-ascii?Q?kmmpER8ncfkQ+eVxRh2al9T1r1wGCnM2Aynyh4hNl+UVtXw3sH54J2kK47wG?=
 =?us-ascii?Q?hxQL5WF9lbgjJLndUVxnVeBvM1ZjJBdZK2gzhBVlAMXGGuqcZWAzMIURRXf2?=
 =?us-ascii?Q?DPdRfBI8hIS3uf7CmlaRFHSz8ps9jyW1p+q5ljcM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1e3521-e57c-42c7-7ff3-08dbfff46759
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 18:08:57.7906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkxuWbO+DpU0KE1jk8fJLkerdbFZqZmiTSTjg9hgWCuwv+L5cbYrliTIeyedZtp2TVye3f5HXCGUYwG7R+3pzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086

Max Gurtovoy <mgurtovoy@nvidia.com> writes:
>> +
>> +	if (nvme_tcp_is_ddp_offloaded(req)) {
>
> Same optimization here:
>
> if (IS_ENABLED(CONFIG_ULP_DDP) && nvme_tcp_is_ddp_offloaded(req)) {
>

nvme_tcp_is_ddp_offloaded() compiles to "return false" when ULP_DDP is
disabled and the compiler already folds the branching completely.

>
> if (IS_ENABLED(CONFIG_ULP_DDP) && test_bit(NVME_TCP_Q_OFF_DDP, 
> &queue->flags))
>

Same, I've checked and the test is already optimized out.

Thanks


