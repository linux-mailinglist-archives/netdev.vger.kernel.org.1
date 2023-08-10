Return-Path: <netdev+bounces-26399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE1A777B45
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5A01C20F1C
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 14:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7BD1FB4D;
	Thu, 10 Aug 2023 14:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719CB1E1A2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 14:50:22 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6752694
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 07:50:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXCnuGn6eutJtReLzDkthauAdQHHDFc6azJprtOMR+bqxFzMlzyeChPV7IZwKctM5HW45GvpKdl3cN2DjCx8cFFNcM54qD7uQncYGxyy0PcyedOviI3XaLVXp0/HUiZi/N/O+Mra1psDxiAMwrCqiS+Gaf/cvUnVwe/YT5bBdXmiYUDGAmK3VzwiChDXrZTPFWxWt1TiEMO7ydlQNxObYOP/4w3CXS+X93PqymS6+I3tNfqSewxK0hokVfL2pKJaQnEa1O2uf/Y63hHZBCIYd+P7pBfsTkTui0oiCs47HAWj/eQc9jEBNDNC/58MZHwOjr6FpPVFUoL1rm43LNxmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66Y+7FTOmtpc4sC5zEQh9xA89FXX+1sFcmphZqco4EY=;
 b=Ouj/x9jdgfjSlDOP9a+h/MaCu3HKFQfXu78ashAhbbRhEqlP6bu1+BO6dg1McYu5LE+GH6LpO9ilYv6OaFl5UVYaiSm0/hsiZxiKt4PEcZFDONOL2cRiEca6s+cgVbF1j7WI9Z8/LxKvcI2+vr+910lOkQK8jh9yk2Vc3//JR2fc8ewhBORQg35lj+9FznSwjBy/mPpWhfzuZTKTOG+bqjBmjj2nNSg1vhvVNps/aQ8tnzLwPVlTlzpuovnxHwclW5Yxfpm5pMjFybeCv40r6nDAv3UFTj+1+e400ztl2/vTag0OgsQYpS9B8wfPicTF7vP1KwH7uuPmw3BS3J8UoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66Y+7FTOmtpc4sC5zEQh9xA89FXX+1sFcmphZqco4EY=;
 b=o1eA0TAHL7vB6yfcBxBkSPdhEbhLDlvhipDE1GjaPVQqc1kaQsh0rubV2Ojt02pEVm8K3VUfvl2ktaVJFXmRmGIMVIQMkjVorgWPKsWqfmL2x2GzCexdR+ESn/7YBKcJSx8fuF+9Sq0lIW22O/qpQU0gVwYr72458MgTICfPCk+Ri7FwQcNjM2mJ+ShPv6hOKrjqR44dNqT1Kxly+w/q9sDrBB+59KCeahKgFgDNHiLl+pFr9jsbYSxu3OZkqvOuvc5KtPZ4iRMI/94unIWKd7pN3JMi4iJ8YqnJPsrhcTICtfC0jI0WbJQrsOhH4uZstfsMwGJ3PRvzE17d2yXKGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 14:50:18 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:50:18 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v12 11/26] nvme-tcp: Add modparam to control the ULP
 offload enablement
In-Reply-To: <1f68b7ee-b559-177b-650a-a8683fb86768@grimberg.me>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-12-aaptel@nvidia.com>
 <1f68b7ee-b559-177b-650a-a8683fb86768@grimberg.me>
Date: Thu, 10 Aug 2023 17:50:12 +0300
Message-ID: <253jzu3vtnf.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0219.eurprd07.prod.outlook.com
 (2603:10a6:802:58::22) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: f310f2d0-5b0e-48a5-1894-08db99b11d68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ifa/pry2qRvT3XJtjkQ7OCszkbGAJH31xw1MuJ5K9k0++GHwb5cm4s+0prlVhxuNhP6kuwQB4asHbdeMrTJGNT6CXxU8AetpO8zHDsblv7EUCfJiZxeqrj2Ofsq9rPnX8z8v9vHJdT0LK8Ss0uJZckn4l1R4lvB0Pf9xQ2/Z41+iaueTCi/bTKJ1abQjlunxvL0XEFZKpbzA0iVaS+NnH+hPVAUGpqF3ueehhwhK62rKuRQa/59+vw/ydn+7uwJUWfHvv8rpLhd2T5ZkgD9IGCUvSvSRgmhE2lqCvpQUDUMzRmKIoMBpm4VDXEHVJpWJrWwymRaNjFgQk8Kp//JmvoprqnhtpsBBi1pshZk6EVz8PkYPuK7Zy+Zy4nYwj1SuOJIbYR185gsO/DWL4OTlXcJ1RWbD2jdhyORNRUX2EWPeiCOQ6mbCJ8kWyRUemzyUFhTdbj12DtNaiJdrbOA28lueWNFawb329wtEFz7tK9I5uaSMFjbcdnCAhBBjuQQUZd2eImhNpjf1uDf5zh5L0njEWx+gW7PL0y4vc4kqRCO2eeAORCgqMH5yFbD+E1Wd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(1800799006)(186006)(26005)(5660300002)(6506007)(8936002)(8676002)(41300700001)(107886003)(36756003)(38100700002)(2906002)(2616005)(4744005)(86362001)(7416002)(66946007)(66556008)(66476007)(4326008)(6512007)(6666004)(6486002)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qhWAQbKPRbGjN7j3snDxXIYK4X2NA4+7TcJu4WCHTD//f9++1tuAS6RmCWup?=
 =?us-ascii?Q?FbIxTpc+Y2iveYK6eiobnnFuSZ0LiHutYUvU0ZoJ1bzEwfGIPI4jkVlUESwa?=
 =?us-ascii?Q?Za9UyEWpWW5hEMHmbc9f3pDVddjqsKFXnfmTM3YWIr3JFHplGPw8Y5Xub+2E?=
 =?us-ascii?Q?xDMH2hU8Z8KVuTTiTcfZjVdQtHwhhVAT6vawwk6iPUtjMPUwnFzUxYFaYV+V?=
 =?us-ascii?Q?gPEDOMI60HrIuLw8dlfAsIqmIwM9gQJhekMg87HW7/CWAN+6kVk/WRkl5X9J?=
 =?us-ascii?Q?19GZh/vVP0/lJm9x+maiJ/qljqfAf5rYe6wr/St2q/dvKtOO6HSrIk9wx0sd?=
 =?us-ascii?Q?Y9Z49w2ZTo1rLNk3Z12W14TvYeAVppNkiz09fsa2l7JqN4ZydjMPM3xVjlhc?=
 =?us-ascii?Q?H/fm834sUHlZypEBd2tG9odPxdw+PhOef/s9gEXTVpiYye18xviKf2Bu0Pxu?=
 =?us-ascii?Q?iXOTQ20x6xfg+OTXYPBRnYIlxOqJ3Y+rXFMZhaXxNKf70iPkphw7L5ZlhlDC?=
 =?us-ascii?Q?vRbD1rzDXq1hoOr9AaSrDmERN/Zcjk8fmOE05kfn1xAkbszRhZrNJMeo7uD0?=
 =?us-ascii?Q?2CYfLVXvZOMT6notz53WwParlfHA5O2kJO1bsDYZdofI2l+afAEBEiiSuTvS?=
 =?us-ascii?Q?CZ4vcYfR2m2674UpsX5tSfchs1pnqusHq4nrcY8bMd7ST53h3g1UIgx4P+b9?=
 =?us-ascii?Q?aglLzvnnQaH5+queBuyUz8e2rzP6Rx8C8LWURVZX+lhGG3nq3KeSh+F5ZIVw?=
 =?us-ascii?Q?/73vMOQjC9oFtxaVwpQfdbwrh+RyzjZTWO/P1kptQyDU99RVJJQHC10oQjPc?=
 =?us-ascii?Q?ceDN5IwlogH7Mz+zN4ye15mq+1Zger4CbWMxSGF3gfy2omoLY9xvIEKdO4WX?=
 =?us-ascii?Q?AIiPA+Iwvy8MEN/crFlPA8aaZ7+0gsJ3sYp5Pns3ao8EP3j+bh2uFD8aqtJf?=
 =?us-ascii?Q?Aopuda8KZgUMFOal2G3n+pXD17AGDt1VZzZ+iRO7m2MS+wVuPRZK5b7SYL+U?=
 =?us-ascii?Q?VnveS5M6qpX1xP4498SE5BBSrp6UfvRUyu85cQ5zCYU/E/lzEr3omlc0aT13?=
 =?us-ascii?Q?IYgZKkh+Zq/VSvZ1nSg/zrHVrSrfvWMZHobLjGakXfq3xTGo6rBo7yGKopSZ?=
 =?us-ascii?Q?gF1UWlJGf/OME6F0g5P1zTixiVUg5q9STcTpTEOfFVaua8j6Ykx2+hOFMut2?=
 =?us-ascii?Q?DHE/cF5aHMa6FGj05jGS/LZKi2m+ReXPukUI/IFtOhEwOQW3ztsdHtyyi8uE?=
 =?us-ascii?Q?JQaI+hG47QRY43keOts3iR5HI5jgxOjEDEru97Uh5nZT6m4WzPbEfztQjNxZ?=
 =?us-ascii?Q?3DnTwj8VRYDAN1MxQvV2nhly75fYF/a/tzWUnw/hR2Vh5Fp1m4BUB5knKkjq?=
 =?us-ascii?Q?6XEjGqZQamKkhQpnCyCavA7LXZ+LHeRP+5FEWjW2bOOjAd1RtQTUHojePdCS?=
 =?us-ascii?Q?+egVfZb7rzExxGiztRR4A77VtP9u5IEy50cvWAwNONP2YRxWlad7MB0QShsh?=
 =?us-ascii?Q?UEMp0XPAVXxtEuNPIG5EH4XTSTPdzK2AaviMGWYaZJF1GXON1OWQJOMS89SL?=
 =?us-ascii?Q?9R+FjqEnNQ7JqFOBPwYLrQCCARaAhR8kki5Kvy8U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f310f2d0-5b0e-48a5-1894-08db99b11d68
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:50:18.5933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erpyMYUYkkkIPJOMtkncVbQKLlZmsfluV+tAnKYvYWqbdYPZx+3KIevyoP0+5F3UxJ+96e0AOWEwJxGkoVFW6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sagi Grimberg <sagi@grimberg.me> writes:
>> +static bool ulp_offload;
>> +module_param(ulp_offload, bool, 0644);
>> +MODULE_PARM_DESC(ulp_offload, "Enable or disable NVMeTCP ULP support");
>
> the name is strange.
> maybe call it ddp_offload?
> and in the description spell it as "direct data placement"

Sure.

> This patch should be folded to the control path. No reason for it to
> stand on its own I think.

Sure, we will fold it.

Thanks

