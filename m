Return-Path: <netdev+bounces-35280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B313F7A893F
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 18:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67486281BED
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 16:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681D83D38F;
	Wed, 20 Sep 2023 16:05:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FDE36AED
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 16:05:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A227CF5
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 09:05:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJJpIYlIIWqDOLq9JQeOPFsQWxMhyqRhXaziPby4KZo4BfPLAdXhFnoTe/xbtikMyseB380P0Vvb6RtdL8hf5haqptlS2F2HuC6Y+ZGiWMrE/uWCM/LwHxJCL+EAWBXmAq0CPWzyoy/adUDxccXUu/r3KKOAuVs9D1cy8vrhiPqt9X3YYaUN4sbd9MmP7AoAVfcW6rFOR246r4YN/TDNKX2sMSKxoutFfd/DuYhdijMLe1gLeOhB1dyUPItNxFVaAqQoXx9J+BS4yG8zXnei4CumTim5E2VAJo4MXZUqDcKqCprcQb3tKng+hYxY5I10XjhIwuXpScSk3/VFuFY/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXsaYEYL3s/DUo3RiaipYZNtLyCUIcNSQHHoOsOHWic=;
 b=l1+ryu/gyzGl2X5M4blVRW5MT+8OwGOCD1fxzKdbntLN92Xed53MJPPplV9JSOGl0+ZgsYqManA5iMBb4A8g4KMmfeQ9yr/DbxOk7mVsXx3dUMIxlClhSSfRM7C7KdXiaML/HAuGuQPlh5mKkSesy61MuXVxCvV8w3e9hQ2IlpGFi0hlk6pnjj2lVldv2DyWIHhGcwq2Q+gC3fdvPIWYoxGu3cVLd0/0aC9bk9jAUy6GiR8k3y7Vd0GiGmBvHfRRjwIlFK8GzOndKAl/ETeMMDwg+aeNlQVoBaInVoApdka9XnzuNgPiyF2Gog3O6XGDGr0OsZYFmuK8/0ckjgnc+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXsaYEYL3s/DUo3RiaipYZNtLyCUIcNSQHHoOsOHWic=;
 b=EayHtWEV526XWzbvanCuLiSvZ7KG1lLpHXAXhud0DTCTEB2r4TextvT0al9fZ7UYMAY0ySPsROzxbwIiorvBx7kdOvWiB8uvS1lkmBvOlrWD7BB8aZXnm6S7XivHz4sVnMbmZNAbasLMleJEsAMaAGZpVqU5w0yv0qCcP+mKzVRec3+mZsXs/39Zem99BQu09HmShCKgB1iIGpjYYZ0IpHVctt+BfXyg1p7wz+VoeqImQGN8tXqmdM7LSzkU6bgaLN+aa6mnaABTg4eT1J1GyzVcYv8VS4aiijZNi4IkdmOMEiPhzC2IPJvdxOmaDclNvfnd3Cr418NHDC0S+zzH2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 16:05:06 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6792.021; Wed, 20 Sep 2023
 16:05:06 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v15 06/20] nvme-tcp: Add DDP data-path
In-Reply-To: <b82d4ecd-77f3-a562-ec5c-48b0c8ed06f8@grimberg.me>
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-7-aaptel@nvidia.com>
 <ef66595c-95cd-94c4-7f51-d3d7683a188a@grimberg.me>
 <2537congwxt.fsf@nvidia.com>
 <5b0fcc27-04aa-3ebd-e82a-8df39ed3ef5d@grimberg.me>
 <253v8c5fdc3.fsf@nvidia.com>
 <b82d4ecd-77f3-a562-ec5c-48b0c8ed06f8@grimberg.me>
Date: Wed, 20 Sep 2023 19:04:59 +0300
Message-ID: <253sf78g79w.fsf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::15) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CH3PR12MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2714fa-148a-4f02-5792-08dbb9f35b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kopY/6UimpApIt7aczBBD1udOPD4+xVvsd0iVWlWdBOVcC5gd/O2Cr21TCtBFlsgft4HI4llaGZnOkUveclCIuA8M/4Vq8VZaUtk7+OkURdmtdxKEjIDsSUQ6JR2VKKy7Lk/KcjFKkCQ+UUBR/kLeFPhoHetTVz6w+bcXUdmeWm/3r3KTh/e0kCk1TDBXUMzhMGt9tlPNbicPmvZddY6wJt/VEJkklMpPuFuB64CY6rdW1yHremW+poRx84ZckgL34Bcjx4IX0YADTbkw2G0j06Fcqt6IlasVHDUv1151RCwvKjoJu01cLTCzfUuQjixYhTDV9jzf6Ub4xUtDOL9ekeoMULEVWhg3cawR1UWKIJT6+u9wA8e8qmB8K3U4KR7tUa/SZejGyoi3eFySeRwI/fL0YIOH0m/LJemqB7UCrYUvoEAbOnEBLia4xKYVDRkT+FqYpytFnY/MSDJaCxPW17wg8yLonF6gkMSTf2sw9IJitWMSa5w3VHaNPiXcPcmRm7c96aGIX0j+1L4AqYZHgHyjkom4lIrZVgj8Qugxvyj+u+d4bGgt1o44G13Gi3B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199024)(1800799009)(186009)(478600001)(7416002)(41300700001)(5660300002)(83380400001)(6666004)(2906002)(66556008)(316002)(4326008)(66476007)(8936002)(8676002)(66946007)(6486002)(6506007)(6512007)(107886003)(26005)(2616005)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mjk0cnR4MFdkWklGQi9BRlRacTFSQ1ZoRXZPWmd4RkxXWXdhMUU5UkxkRGVX?=
 =?utf-8?B?ZVk0azdnT05GNGJDdkVRMWFDVDZpZUEraW5VdmtjS3phTGlBWDlNRTRyMkdo?=
 =?utf-8?B?ZFR4bG1xTFhja0pSUWlsWUZWRWVmbnBiVDlzUVhFb1lENC9oSmxac1VnTU1V?=
 =?utf-8?B?aThkckRvbHE2TENwbjE4RWs2LzlMeDRJdktZZjRqLzZHaWJqZ0pqOXdsZHNI?=
 =?utf-8?B?S09vMUJKMjhvb1puOHVsa0ZUTVBxTitYVkJTM0t1eVBIRStWV0NUWTBqSEJY?=
 =?utf-8?B?b0tZVGQ2YkFadk1hL0k3L0hzUFJLeXZUMkFpcEMzVmpRRW5McG4vdlhxcW5U?=
 =?utf-8?B?R1hhK3IrZTlSYnZFMG81dmF0dkVCemU0Sms2d2RKQ0t0SjA2THRVU0RoYVNG?=
 =?utf-8?B?MThwWTR4OXpUUFNYbTFMMWRmd2YyK3hIZ0VaOGVIZ3pDTjVJYlhXMUtGUHhJ?=
 =?utf-8?B?Q2JVUzZyemJpZjlHOHlsRTVPWTZ0MDAxakxHZGlzVVlKR2MvZ0U0Uzgzek53?=
 =?utf-8?B?TXNyaVcxZFhEK1NOd2I1YVhWelM3QytiM0VDS2N4OEZYNmllcW9pM3NLeTJC?=
 =?utf-8?B?R2NGdGFObWQwanYwbkUyQVpRZVBQR0ZCTjF5SWVseElvck1iSXFMeXg5YVlB?=
 =?utf-8?B?aml3QTZsekRwdURocXpNQTNDYVY0SG1qdUhmbUQ1cHora2I4WGNWZkRLdmUz?=
 =?utf-8?B?V01uWmRPcXFWamtqZDQvSXZPRlgxUDlrb1krNHF4dWo2cVpyNU1TRko0QWJy?=
 =?utf-8?B?bmZKRCtpVEFqMnlIRXR5N3JOM1FaNjYwTGt4cm1XZzRMQmVJUGNudHVQRHNh?=
 =?utf-8?B?c2hHa1VSMGNnNmF5MWtlVEhGQXphVmpWYVltdnlNNVpBMEhKZXcvN2FkZTlL?=
 =?utf-8?B?ZkprbXE4Q0NFc1pLaUJod1BhVEtuWXJ6bno3NlNKVlBvelNNR28zQTNtc3NY?=
 =?utf-8?B?dkRwNXBzblBDOUlYclZydjVEMTBOS1BLN3g2L1NvOHYvVVlaVjR4UTlPVW5N?=
 =?utf-8?B?VjRoaFFzazMrQzVmb2xOUVY2WFkrcjJtVUh5UkM4RlluQU5objIxaWltUTR4?=
 =?utf-8?B?cEgyd0dabG1lek9iTGxjN1laSlVVU1Yyb0YzK1hBbXZTeDRqM0hwY3E3YWpw?=
 =?utf-8?B?N3lwRmxCNUNhRWdEMXJYSDc2QkRRbmFTQ2JUeFVCU3NrU0NqZ0RTUWNjRXhH?=
 =?utf-8?B?cjBCNUFIZm5SaUVBSW9hazVaVXNMdy80c2VvSlZSNHQrT2ZidlF3ODVtTEw1?=
 =?utf-8?B?QStBUHl4YVkwUVZLaFVHYUNrWm1ub1E1b1pBdTk1cEtBaTg2KzhLWk1WRDZi?=
 =?utf-8?B?ZGVORzlKclRvUWQvTm4yd0VOaGZLVmZQd2g1QmlUV0JnWlpSSHozdm0xQ0Q0?=
 =?utf-8?B?US9kbHBITWtrYUJIb1RmWk9qVk9KejRWSHgyeGxsNkhOYnhLdlZhazNtcmRu?=
 =?utf-8?B?R2d6czJYR1ptR0ZRcEJaWllpVTMrWWpyQW95dVlVRk1TTkhNNStpOU9scGVE?=
 =?utf-8?B?Q1FTaEZVYVFHYU1uT1JlSlZmTmw1M2V3M0RSOGZSazZJcmJqdlZqZ0xHL2dU?=
 =?utf-8?B?alFVKzFNS0FFNFM5bnRGRzM3amFHTGJ0aTlJbjFZeXpQanNXMkpRTjVPRzgv?=
 =?utf-8?B?c0FYL2g0VjEyaHpzUWJhTXVOanh4V0xJREsyeWFFaEx0YlFubWJ2QW42M2Y1?=
 =?utf-8?B?RFU0ekRyZGl2NzJKZVk1MC9GM0psSUY1UXdpMlNGZW5tekFUUXE0T0h5NHI1?=
 =?utf-8?B?UUxYa2dxY1BmOHUwS3kxdGx5QlpWeGpmVEw0RFlEZmVvV2ZLSStwUzJGNUdE?=
 =?utf-8?B?SGxwRkx4SndraVl3a0NnZzk0eFk1S3N5NlZSS3ZpTGl0ZStDZE5idmR1NVhI?=
 =?utf-8?B?SUlLZEd3TGNSb3lUYmI0dk5TdUtkNkkreFd0eEY3V0tmaXVabzd1a0ZtV0du?=
 =?utf-8?B?ZnR0SU5pL1VZWnB1MDVocjFJUU95M1pnQ3BZZCt6RFdsODE2c0R1azFUQ1FD?=
 =?utf-8?B?MDdkUldyaGNLU2VrTVhraDJIZXBGVmxWWHNWOFhLVWRNUnFjZ2VjQW9VNzFY?=
 =?utf-8?B?Q2trRFd0MnBsTWx2QUFGc21uUVdhUitSNmU0ZlFkckRyaTY5b04xWmVRZGp2?=
 =?utf-8?Q?dR7XYxwJmll4/IGz2HY3LSpHR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2714fa-148a-4f02-5792-08dbb9f35b17
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 16:05:06.1571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWJeXVdpZKOvtfHQeQFv1sZU2JwBxjW97no+m9FWUJBJxmVQOZ37uJFz+ALt4NEO0s2q0O4WGvP3JE/FCUBZhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9026
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sagi Grimberg <sagi@grimberg.me> writes:
>> Sorry, the original answer was misleading.
>> The problem is not about the timing but only about which CPU the code is
>> running on.  If we move setup_ddp() earlier as you suggested, it can
>> result it running on the wrong CPU.
>
> Please define wrong CPU.

Let's say we connect with 1 IO queue on CPU 0.

We run our application which run IOs on multiple CPU cores (0 and 7 as
an example).
Whenever the IO was issued on CPU 7, setup_cmd_pdu() and queue_request()
will be run in the context of CPU 7.
We consider CPU 7 "wrong", because it isn't q->io_cpu (CPU 0).

It's only after queue_request() dispatches it that it will it run on CPU 0.

> But the sk_incmoing_cpu is updated with the cpu that is reading the
> socket, so in fact it should converge to the io_cpu - shouldn't it?

Yes, that is true.

> Can you please provide a concrete explanation to the performance
> degradation?

We believe the setup_ddp should be called from the CPU core on which the
nvme queue was created so all the IO path SW-HW interaction will run on
the same CPU core.
The performance degradation is relevant only to specific cases in which
the application will run on the "wrong" CPU core on which the NVMe queue
was not created.

If you don=E2=80=99t see it as a problem, we can move the setup_ddp to
setup_cmd_pdu().

Thanks

