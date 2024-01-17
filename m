Return-Path: <netdev+bounces-63930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B89D3830335
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 11:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628F82812AE
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 10:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DFA19BA5;
	Wed, 17 Jan 2024 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ntCql7fV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEF414A83
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485832; cv=fail; b=XN7o71M5cktzWCpTJtAmdMx7wJ/B8k4IspaS1EgiW850HNjelbLw4jR7PKKL2YduuHMR+u03MPlOTPTMh+coK9Lolo8pgpVeZdfFdAC+cioXN4fRzGCxUZZ9lH6cV4bHpKs3FCvJkWspW9CEaLE89T5jjQEb62rCON/riru7Mx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485832; c=relaxed/simple;
	bh=I6nvf6Xt3OKfc498LAbBvtCOAWFHY4w9GrJOfS3q1nY=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=XVRN57mVlB2re7rZbYbVpnyvZMqnexJgnLBMa5xQSLGGPZK33Evb0Bzdav0eFYyZdRm6bKQdzJNRL8nyC5luwNij8RjeEjMP5xQyWZLEJUf4WD4smTh1dsyZGSIApPluueOQBVLxbBJ/fEGKimpeR7e79QaKnMtuFOIUquVGQWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ntCql7fV; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSAOPlXHHkq1X/UEs2p5TIf9EGSxvOBJ/XDLUiEytQ3zsRbemQ4jg7FurAsmKt9cRRqQHF9M3juJONQMMDa5EtTgO+x/c8BdjaGSxMklTjXCdlFElWwhoAZHsIvTzz9JjwxfMVJG+2qO9jkuPlQrmDVcNLmSyV+FGFdeGugeB5Wr9HcfvWSwlTxRiZDQNrkorbiUqJeCYo+kYQMPRiZeqKI73JOtbp79ofU321jm1IMXYZnkzLgOHFC1IvIc8SX5z7h3kaejLQTWr0VtqTcBb0BAjpq7UH31TWtEzYhvaGie6vhb71G2+k1Fn3kToASUwvp8RCvF7Ysz93ifG+xTPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6nvf6Xt3OKfc498LAbBvtCOAWFHY4w9GrJOfS3q1nY=;
 b=QWeggoqVyTDGBFbRSRkUrwLpgCNqx8+SP3w7wTCMyyKp681Y3+tKbvJVPHB3g+fKtoZ6BJNBBcq+xnlrP4brXjcsOOeUbFu2VWhA1IqCQeMtXbylvJY1v1jgMEJOx1tVOy5eFL/9y639K6chcLw64WNIruFKbDNePH5ZphYjfGgaGJ3w8VoYAQq57pKllivW2+qT1OOozQJFERdDNlt0j8jt+zUSsnO6tVzGs4B44oNCS8WFdXWfGaKbQmCNdDQ2PmYZs6sT4OdV/s9uYnETosjJ4uQu5pa5r5r+CgrsopFjtEh2f3ZtOLScr2uTq0FoPMA+k9rIQjFFF4vo47qXBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6nvf6Xt3OKfc498LAbBvtCOAWFHY4w9GrJOfS3q1nY=;
 b=ntCql7fV5gg82oNDTjx9rV07I+rDy9MgYxn1WwqzbUQJWYcwt6fjGLE1CnefYCuwn1XXeh5b+pk8vHVmDXQDZWewR3z20SuFRYV2ZoNvF/bd34xyekG0LUHrSRFKttxGAPSSxRsXiI+JjRqRHZt1EWnMRxPZGTMvHg6ysm6llrw2T2eaKcuKxHPBPiR7t30Enc+MbooMyMy2kD/5xLBbZxwDu9BQWfGBqLreMsynBzc6hp/PKPQ1ziNXP5dhmwxYwk3FuFY/tZilxM+/aStEEBphtIQgciI2u7O3Bh/XlzfXmyNXdeZy/d0PU+OWMrHjU4ocOrZ/f5pYDHGRzwcqYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 10:03:47 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::9fbe:fc95:e341:78aa]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::9fbe:fc95:e341:78aa%6]) with mapi id 15.20.7181.026; Wed, 17 Jan 2024
 10:03:47 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v22 06/20] nvme-tcp: Add DDP data-path
In-Reply-To: <7ff7046d-ce4d-44d0-86f5-8ed7cb0229a3@grimberg.me>
References: <20231221213358.105704-1-aaptel@nvidia.com>
 <20231221213358.105704-7-aaptel@nvidia.com> <253zfxehmum.fsf@nvidia.com>
 <7ff7046d-ce4d-44d0-86f5-8ed7cb0229a3@grimberg.me>
Date: Wed, 17 Jan 2024 12:03:42 +0200
Message-ID: <253mst4uvi9.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::23) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM6PR12MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b0c8f5-993e-44a0-d7fe-08dc174398da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FxjKy9zwhO1/0z96FgDZnIyG3CEimH2TK5Q3/gV263ketjDTeGZolcGXgplFnNdgws2XoDhqPdfbLAz08gSiNWZvYfGzAupPBOQlvIYf44jpT+5at9FH18YU6sl08kLXJf+Ahq7fL6jdNb68Z0GRCOYOTOu2Vw8NAKgyILSWP/zn529ncqA0Csw//pAfBXvjzi2Gv6C1QEey7yf32ohfARCCm777AAruDjjWl8V1Ddjhc6OBz3jYQIiJw0UzSoJgUFhTB7TzvuE26a9v02W1b/f2DpsnYXRqWH18l8FMTTU/aiSte3S6UWVCBwaafFomckhsYl29EK8orjWkxkuaY2TJez9neFIjjd59tBUsB5CC/vs8BQg4n6dYxVCp2rKoSoXmEaHNNxP0anzVMvnElSAcAUcYN+1V6KnZAkyUXWGzNEqIhaZLYSn+X8uKX+DQHgqAUh06jKzF/H9dSIWlxC0ltmjBKH2rbuCB8rHR7hpDBLcTjpXA1axJbs3cpF8x4hG9Ihl/ubf12BCde7droVr/5vg3RctZE5R0RCdPjTgipnbR2cA8gw1NMsilqdai
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(107886003)(6666004)(6506007)(6512007)(9686003)(38100700002)(5660300002)(7416002)(4326008)(8676002)(41300700001)(2906002)(8936002)(6486002)(478600001)(316002)(66476007)(66556008)(66946007)(558084003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8xa2KPmUa7YmRbVrKXlWGCEpNJZxHP3Jl+fJhe1+W6YN8NsXCJlBjUoQwM1R?=
 =?us-ascii?Q?Rye+EBaphLyRi/s22IY4jQ/E8ICfE5bDI5MnEZ4QCuU93vHRCaZ/xDfOVGET?=
 =?us-ascii?Q?d8cAYw0YbUJvy6AO7zQEEUzEkbmt3SYSF02RLAKKR85DrS6icdZ6eBu/SIUA?=
 =?us-ascii?Q?hY7/L6MObAqpZAKWKKDHB3GQN15J0oEmYS2KZTT+q5qCyBUCb/oamWRDxOTK?=
 =?us-ascii?Q?gLQ12GZ12To+ZE93hJFYArjtDlgbAotsCnr8XUCvZQRTnAEKDavIbQWdxd5G?=
 =?us-ascii?Q?AvUGQezt+lhb7yuzwbZa53SxRKa4qtkXE9Wo/g37JOtMDCTOelZuHMHv7OlC?=
 =?us-ascii?Q?KkJ9MMx+J1pZDQeeiKCyFXntCX4gBKdlJX+hxKJzgYnJuMTk8PaWEvrS4Lz0?=
 =?us-ascii?Q?sFWFx5fcL1G8qZweF4MEYQDBbjk7Fpc2nUYCJCgr41GVp5XwUFhbL81kfTLU?=
 =?us-ascii?Q?GdLXNz87+EY/7tIVO1FflXk8JU6g8I02xvgz8GmXnB1UrTmF4huvwfCLWi7C?=
 =?us-ascii?Q?jPqYDibKxCrfdS7jM2ifwOFWh6B+eZoDUenjXONsSutC5e1V21NOaqjItMdy?=
 =?us-ascii?Q?ZjKVNIGV6B3vM5gmit4C8OxGH8Qh+gjVNzM+pseeQJvi/DYn+ZsdIGBx9Apg?=
 =?us-ascii?Q?Walxd5vdWNrlA8h0Q5v7s5QfEuakK83qLIcgTi6FI3V1tZyVCRyZvltV3PRO?=
 =?us-ascii?Q?p2YoS69zeZDSiAg/cwemxgeju9DVmk6XdjyJpYc2ZoHNcRa/aX4lJrvQXCZu?=
 =?us-ascii?Q?AZ48akaMv+np9ptLW4HV8nNWjj1LFs+CrmrDLoFQKS5q03/509WCUcGPImGx?=
 =?us-ascii?Q?FD6OI9fqyUb9MkG+RQOnQNvTw6/z4WzkHwiSRtpRxkjkOBmaVlVh43Jqdfxd?=
 =?us-ascii?Q?4jREyv76hWg0IzySfFZ3kRIEwwHVbmuJa/P+Q/c8j+EQnt1HqslLwiHC3Z7n?=
 =?us-ascii?Q?DqZZE3jsAYt/lIvY760g32xYTxnj5Fl6r58NsRS1DstR4W18NJ6ctV3PRVeh?=
 =?us-ascii?Q?ezhvy2t9hiwTGs4c6QK8n2bjGvOed/sEk1PpD8nnW7QMcFmVh73SbX0lQCn8?=
 =?us-ascii?Q?Y41m0ILixzdNTItviyTVj/GMiGCzzdGh9gbKxxCPoOdl6+4YByBMy9qJSQO2?=
 =?us-ascii?Q?PrQ9vLqb6Ya8N8J8K1CllZvs8OQ2+1R93DyMOdAivfGak/Szqw2Jnap+fpPR?=
 =?us-ascii?Q?lkNSofASySNMlS/2u7PDImwvAc0wySUX/XoBGB681nSXx5i/ZeMLHYqxDENz?=
 =?us-ascii?Q?i+mT6oWWa9ZXi+K1cYaR1SPWb8GOlWLoWHEh/Kp96goySgP6kb/Lz6EFpCex?=
 =?us-ascii?Q?PkSUiPpdpk+Mcusv4PUEc1xWfNT+tyF/GBivokJlVT/4gn6x/lsszDEhHWLj?=
 =?us-ascii?Q?UyH5uKsqFXczqYIGo5fXdOcOb8QuknpZvUIgBmi3VQcP9VJPekeckaEmUTtJ?=
 =?us-ascii?Q?aZBqOqCMfFZHtLWh9G4S5+9FvsPm+1NqMMbNgakEI3cdQv/UcPS1iPBO5vFj?=
 =?us-ascii?Q?jkozFoVQWU9H6eY517wMEGWN2N3OJ5sVKAi7DkEHSjfLqOlM6GO1nL6zTYzG?=
 =?us-ascii?Q?3/OqgmypKO7qyvL4ZzUEc9amxJDtCaUP4mwyWttN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b0c8f5-993e-44a0-d7fe-08dc174398da
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 10:03:47.6049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fbm018z7yz+ylCC4B1+vm2gBmwHPxnk2EeF6dTIQKhE7WtyS7XzwZBjEkeLGAUcG1Np6uFQBIM74cCmsbk+aYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356

Hi Sagi,

Just a reminder, we are waiting for your review on all the nvme-tcp patches.

Thanks

