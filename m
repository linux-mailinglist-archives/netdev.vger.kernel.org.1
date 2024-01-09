Return-Path: <netdev+bounces-62615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B14828344
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 10:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC4C4B23AE1
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 09:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA7032C63;
	Tue,  9 Jan 2024 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cphkeZuL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8556135EE4
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNnTr9WFb+eB15190oN/K1gQyy6LkHZJs2TMxgoUYTUr0NfoXyMf2AVU26u++xukmGgNNT1veHlYk9ZXpWvKytSX15FsrIKXiev4SHzETRbRhCtMV3C0HzmZQH9Z52yb6C4RULIg+IZ8imuG1tm03MHi71hfUax6+89QAc2TU4ZGiXRmvuGcr0fj32DSgA/mkQeKhg8jkFsBiXMehUzjbYh3/+KPVerlN8ZFH0GAzotXASEedg31AuK6AZg4wq6dldLa7drVD/k3GyC+GysB7/dvxqdzXuRnefJtACuHv38n7GFhmK0IdHti/+cXt9Vh8DW2gHF41fOdC5Y8DGDA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjc/FNuARQrjfMmr8ZmbCSGgLm9L9Rj4DASsAUnsL5E=;
 b=CjJmO2h/j7MJBQKIoG0LMS2IqFzZ2HueAtS+PUSC6ONtnhZsVF8eMCDdiPjvT0/ybBK9KpaF8hmjry7VSakSE8SkSaRzYIRKmvKrlJ6lj2UvZvzBg8mZpl8erT/324adwnIP2sCV2vKKh/pQ6YggESLhq768BY2oqdkhvRy5porfZUVCK/TihOj0MceUf5JmO2/VvB7t94KTAINhoXLW3iNt1xuUwJCCnbcNNqUdqe19ltIdFi5ZrHmt4InRwHqq1oUAg6XoQUKJ4a8TTzdmlDWtxirqxIls0YDm+GP3+PK+8nATXkOM6HzY3H5vYk35PRVHVeU4zQBNmULpANKhGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjc/FNuARQrjfMmr8ZmbCSGgLm9L9Rj4DASsAUnsL5E=;
 b=cphkeZuLHH90aFm0T92hxh86fy8Fp/PZnxvY1xdSvYwsBf7ORBkCGOnjTmSW/ZWjNTKum6qov5e+sxdcxGJOIUh2aXBjs9Ga1Mn7JCyt+HT3DZKlY5Gk/R1PQDuiGUl0/BOOvyTpW1TRsNYgj9VK/66NDcPskKafAAYdvQ+tb8yrJQyQ8iFtYvkBKMW1zzj8nSKE+M3qp5CA7LTW5/gtDpLMoon4rZYgvevTjeprdplezNoQ14AhCHDaEG9Kimt8vGdkiLxMpoSILMXnIF4stpS6In0rdjUlz2A0aU1CbErb2ILZD/UxiYGt/s9dYlYMqc8jF1hR05cb/AELPMPoDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CH0PR12MB5315.namprd12.prod.outlook.com (2603:10b6:610:d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 09:34:14 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 09:34:13 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v22 06/20] nvme-tcp: Add DDP data-path
In-Reply-To: <20231221213358.105704-7-aaptel@nvidia.com>
References: <20231221213358.105704-1-aaptel@nvidia.com>
 <20231221213358.105704-7-aaptel@nvidia.com>
Date: Tue, 09 Jan 2024 11:34:09 +0200
Message-ID: <253zfxehmum.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0072.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::36) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CH0PR12MB5315:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf07750-dc17-4988-a954-08dc10f62441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KymDTtQZeVLIvTIjNsnqCZU5TGMW5jaJ6lMKC0ObFTSzDW+DY/4K6YmcbQITP5ep4/WphPT9D2TC5MJ/TFqLxJcDdm8OCRUTMfTQb5l39WIE00VTFUYmnEnd6dnriOHeDYl5FnyapuRFvEANtC4HusDKuUvnHDL9EFbb+m6dIoYdw+5dQxS/Z0WfXbDzGBVtWUQnczJNMGtoqPDHWZotTzd4cXiRoGtKizD8fOqTbXCta4ur5Ql+jYwYJ8pL9qtHk2nW2jbOQikCWjlJMguR9MwFRwIslX2nssKrQ0e1vFyRWtAOEj5PK8yRrwaMCZjDS4iOufmNALisD1D1DwBXOvg7AIGgSB4IJ0QwtqDa1ZXZG9nPC0vNkzmC39+qVC5ceb8b2FRAwhVpLbcqTqTwWBX3mnty4U1GC1hhWXSpWnwMJotqIr+fb3J9HlWyYIpS7LNsgqhw2hSKBwlWBKC/sS6AUbz1ci7NuSC6kvSBYLGVpx9+dNN2+TLdu8E2dcelv+VQR3K9nY64hdOUmNwhzN/EKMcTZFWHEeG/s+fr58ozawJTMqANT2KZp2HOTocZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(7416002)(5660300002)(41300700001)(83380400001)(478600001)(6486002)(558084003)(2616005)(26005)(107886003)(38100700002)(6666004)(6506007)(6512007)(8676002)(8936002)(4326008)(36756003)(86362001)(66946007)(66476007)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WZkQQQGAtmbTcKHq4jtYzyMJLlPkpvrgWym3ucOHfE5bY/vevEvJTciuXEtY?=
 =?us-ascii?Q?oY/zwluwE8lctpVwx55t2qdPaTXVpl8aEAF92VNyTrAJL7KaQW258Qmc3LtX?=
 =?us-ascii?Q?0r1gyo9qP1IuZkn7LKE+uGNuf1xYVbNlb0l0+rbA52i6jwSXm77rsE8iFUl7?=
 =?us-ascii?Q?4DMHYkKdz1BaQj4Ahk0INB2/5mNdh/f3nzbnVzuM0QyUMWNikyujj3iE+UaF?=
 =?us-ascii?Q?FknaRwEtyNxy03ktq1uyMzqIH3yCkWZatv9lh5cTOJt0rb60SHT2puGLgQ0W?=
 =?us-ascii?Q?6+76UspM8Rnr+qSdO61FtWZ1SmzSh/GzGwlmS/5WZMzAdf+d+MlL7whhvJ0d?=
 =?us-ascii?Q?lRbB4d+vXQbAh9pmqJn1g0DIP1kgjsVJbR/l7JfHmuKyDFC4bxnawnaUEO+p?=
 =?us-ascii?Q?RQGP1f0o7yyiKnEGQVRqGisQyF6R/FI6D6JVUiiR/W36ojk3EdSAwAMMst8H?=
 =?us-ascii?Q?lC4aRE0kvFwPsHtGr0d4O1O7Wbzw3mZq7qUKqNmaR8jH0voB25jrilWmGLqT?=
 =?us-ascii?Q?MgaARYMIvCu+ishTiRxzp9BY3UU2xcPU79bcnsStrCBoczBR760bzGiddje6?=
 =?us-ascii?Q?l5bfNP4K0JmmaTAatC45QmF66XDrsOSA7FGHAPzxXGAUgSXa55JIs9z9TtmV?=
 =?us-ascii?Q?B69WQav/xViix1RZ6VhznMzudRLV37idJ2V4P3AAXuofXr6r8P34U76S9+6X?=
 =?us-ascii?Q?VA5Tbx7tChUyYsxbKtMhuGDXb7qJ3k8HaG4P01By+Xp/GQJdJ5KR4QU5t4Bg?=
 =?us-ascii?Q?p0j+cQW4KQc1uUgRV34h2FPWFXKkNxxKnHH/Uxub0d19xJD7/GU912g9WPsB?=
 =?us-ascii?Q?XWEIZsHaBCoXWvwXxfPzftA04sH2nI3lvWOoiwvMKmtzypmG4IRwM/JneWtF?=
 =?us-ascii?Q?pegld063G78kvqThVef3nk083iYybwKLDWdJGkfzadHDLgi8sr0KZuy3n3VX?=
 =?us-ascii?Q?6ClrXRTp6uW26IIbvr3GZyq4hgUHSKOCwPqSDNzV5aaFeUPThT6XcyxuFv94?=
 =?us-ascii?Q?UF6cJpnbOgfv3WRVhUu3nW1siImTcHeL7yAa3vtNy5JlfMRGtEmW0KImJ4TR?=
 =?us-ascii?Q?4kxMEIXDOULlPFr3wpa2sDWHdj8hJoTaU6lcg2fud099iU1HhWsWw/QsQnCI?=
 =?us-ascii?Q?8rHKLwRIiWV4GvxO4a3QLw1XEGceT0E+567WO8BDdODsGaERl7i6Jc/EgtsW?=
 =?us-ascii?Q?gD6PCsUqTa+2H9eINHtgt8Z/7prtCuP+xJNOT+C8I/a56/gRGe4Wyxm10bPl?=
 =?us-ascii?Q?tGeB6o7lrYcyClM3Nyb33rAOW++FrE6cStsK41PZTdF88zPTAy+BdQr/feYD?=
 =?us-ascii?Q?6kF0oA2ro88AgS7VRGABYo5pBXeEU8kbWQ7q1TPfO4ECgECpkJky6N7472qO?=
 =?us-ascii?Q?t+f81B0Yse0hIg1vln05wMGMKFzevzmBDLrsAlBG/zV/naoF5a3hTcnDx1To?=
 =?us-ascii?Q?xmqtTXoMwZzUPLHDjmqbgYpdIuHBp7oD9xE8/q3T8w0M3lpIiSjGCIdk2z0k?=
 =?us-ascii?Q?0Sb0160TUjdU6g8TyC3JjeE3gfYmb+GBdoOAZXhyKXYDL8q2wBMuDWcPRbKM?=
 =?us-ascii?Q?jxZrC5Rs0fgE027u0vIYdgaJhGVtUzA9rLMQ7Nly?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf07750-dc17-4988-a954-08dc10f62441
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 09:34:13.7889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JltXs78PGzG4btWmlHQKi7Cr0LPmY3P9KXNsxyvlbuyXB79Ou6DXobE0PnE1EDoV/Y5mVf0YZC7N1sbF2Wc3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5315

Hi Sagi and all,

Do you have any other comments on the patches (nvme & netdev layer) we
can address while the netdev mailing list is closed?

Thanks

