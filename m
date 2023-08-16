Return-Path: <netdev+bounces-28074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9807077E21B
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 15:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A2B1C21098
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 13:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676DE10967;
	Wed, 16 Aug 2023 13:03:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556DCDF60
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 13:03:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A09C1FF3
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 06:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgTDY3S1+C+LnvNxIrFZQqPsyJIzNipbHvYd3DnkTm9nfNaPY6tpd2ghhtWICQWuJqp4XLrNlOe8l4385KgcArlWMUiLJ17eqQ0UoO6S0bpiGto7bb0fsHkVhQxWyjHb4lzyhlKQ9NqIGqg+3DAdD+3t+0VN10FtycA5fgxVwid7xY7jGY63InGpAIfZFcMEoqaBHCSpMSVrgUD0NIQv9K2fPFxcY8FtfIdDghwaAB2lremFrMp5g5CAaARDngFJzg6FMKPUi54W3dcR+SebBHtGaetR+qTb0yWkbB5drSKnLkcht5I2wagVbUB/YmD1t5HpOCG0YbDGOPhfTzH9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68z1IcZcXraTIIyqRgCo3ru+wLphx2KtBw9+ikxU0sM=;
 b=NfNf8X7ehtKvgX7vQB3i+u1AK9pebHsCy7TITvax9VrF4wKjePpU12VNFthf8pG1dFGn4sAfHzGmetUFScSaDrMTPlaWduCTOEe69+yB17c5QmuzqVbhwd/MvaaCOEla2e62jDqcNhHM5rnHzr6RR2+7rQghfV+AGB22V5jbk3k04wG4R41RnnZw98MIbvXVULeNaJ8PhvUzN2pyRsOVjKFLnZx8Nfj3GCWZctJU3lbvPH6F+0Vci3DqzE84z3mX+NL17Qsg5SQIgEtKlEF1tUyJWuoJ89XxW0YRWwuhSIx8X1Gl5x4oksUJdacm8FTVtkCJqVfMwbItZu6p7ZDbSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68z1IcZcXraTIIyqRgCo3ru+wLphx2KtBw9+ikxU0sM=;
 b=ebxPNEBai9mgjaB95eA29eHlvTmLqBrkv5Wo4vT/CQHI5y8WVxoLqBU3cl4mo8CWfd9KkaD23H8+Pm+LVaE3JhU5wg0hLU1hiUiOZjbAzFYK3t6I+PqyEiuwC46hFMw6nUfgYrpfAgVTkS3AgALlrNGmpPMCy4SpLpNQysU+LrQeWcCPZLkeV5FjZUer6/Bwou6kIJ4qhx5OtnuQjNywrxQHFnP91BBFeQonsqR7mDdsaRZ3pO5HiSDt1JyBmn56JSRitYLJ6txh1Hg0CYvGA0wfUNdYbCrR1/VZfBQqSJBTe2Qx4V1zcdNag2eEZwCirtUnzIgesPIX7NYw+xhJ4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 13:03:52 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 13:03:52 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Or Gerlitz <ogerlitz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, yorayz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v12 10/26] nvme-tcp: Deal with netdevice DOWN events
In-Reply-To: <b94efb3f-8d37-c60c-5bf6-f87d41967da4@grimberg.me>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-11-aaptel@nvidia.com>
 <b94efb3f-8d37-c60c-5bf6-f87d41967da4@grimberg.me>
Date: Wed, 16 Aug 2023 16:03:45 +0300
Message-ID: <253pm3nuojy.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0125.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::23) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 86cf419e-77ad-4ead-993a-08db9e593d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	woKnnNOWulhGVprUY1ibgxA7iJrkGDHzoKYh85VpYWyWMeak/Gpa1Jeh10+n2Gn5nLdgObpUP1UF+dd+WWBlHG4useKobDj6hr/ax1/HBDeM+Iifj2gSKKYbOsElYBK3hN/TMo/k7m1SpJOSQbjW6KfATMPnZruO+y72hIOyymKRXd5HQ/Af0vsqRCKpbk+rn8GzUo6At0LpBFHqEHaxuoYtZJWjU7KA5B5+KhVcWKXJ3NpYwWae63whIh2/oRsSjPxn8R9IOauuJtZVZmsmmCP05b6hoTPROm52S7y8+ToTZtk/DjEgFPCC2FjBkkc7qjEbi0xjwGUZNBMh6780jUu/0lKib0xcLBd6KJXH7JyX7eD/BRjJ8mlnrx1h3hQRpngy7n6tdAIOZOAETgaX3vhnhsYobhW+qQy7HE17QqtZo4v1HZmpqQpf36ey32HtIo55KSPy6Gfzj/GXN2Y7utoWpLpRoe9Vw2HyeqC6j4BFThuXpIJJvXVWCV+nPGvO/dlJPCW7qB2+WfW5bH37cTLsxPithOHKlLqthBsD6ot24E9LmKR0VLFeZuPaolNZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38100700002)(8676002)(4326008)(8936002)(2906002)(4744005)(83380400001)(26005)(478600001)(7416002)(86362001)(6512007)(107886003)(6506007)(36756003)(6666004)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Qcym5/p5LCIkuNMEK7wCWOg4guMnAaYvw/R+pvmt1zGEhScR3nrwq23h1DK?=
 =?us-ascii?Q?VXEu1wXQd5IboSrpE6AGr/9zIoJGniIltdC+SK5jWuUqRmi870opsoOU1iax?=
 =?us-ascii?Q?Zy7UcEebZ3g+Mtrnh0c++1yRgnMNwWhg1TRH603YgSGiGB96fTTCTdt1a3Mn?=
 =?us-ascii?Q?xFqlQLBmh+6v0E+RmZemHseSQH4AWYbIRvoPBxAXzGHQ2tRALT/UnP80hhm+?=
 =?us-ascii?Q?+0HaWLwIHThCYgWpC3L/uDGaQytkmNWIBrl4qO4a+AbDYCMeT9wB8mr+zJlk?=
 =?us-ascii?Q?BZ8uYLVg3dH5bA7lEAt0V5oOtLTLYfsV4KtVfAEc5WJBqdXrNR6EzVxwPAPc?=
 =?us-ascii?Q?cMUiVR9GC532ErjQGBl74frPuOxAWFO3J28YJ65pAZghdzTHx8xWEqmn19xR?=
 =?us-ascii?Q?h2TF/aUG6+p/Jig4qiMLlxGW7CxKKtZqNfTlwVFXUoWM4NOHMUgJmzP/bRat?=
 =?us-ascii?Q?vOlKo2Ng9zUdib5ozRrHfMZjS8YinJNgnvK0XXVAHESpwHMHumvQCV0Biw9F?=
 =?us-ascii?Q?fal2I1lpw88E4ffXpwFk1E9MtcDF+fWM4ZEM865iN2uLVrxdOi2A0Ema7BPh?=
 =?us-ascii?Q?WFbK6rs1hjZb89P6Yp4wK9IfTvs1rog3yDTPpODUc1Ec4IdEgxAsJ8tc5N/v?=
 =?us-ascii?Q?oF5FE++BuaTBXaMum6FCEZRDwu6MJzRr7a92ggDdBtFNjXFbfOjp8QOglD+5?=
 =?us-ascii?Q?xa10TlSbhcNwOOhjzyJv0mVgm4Ak4aTr7ROKBWRlcoSaxBme4dCFGfx+wmSO?=
 =?us-ascii?Q?ArRYkXxmMGmOo1bNr8WmIG6EuZkzv63MOK+UxMrxaP7ySwEFLTgY4KUo9bcX?=
 =?us-ascii?Q?TvI+t95WhMiIoELI3mcVT7ZpXE/28Zf4uZblnkILzDqZE7jNvZRNINicaFJ6?=
 =?us-ascii?Q?mLJdSEHzomhOvIQwNlG6A63dmbhulg1tsg6imJBi9iT0b0nrrsawlAKM2p5v?=
 =?us-ascii?Q?gkzE7hUu9VAL6zcuWtQZq3Byw92RrtkL1+fxMFlOit+O2e7kpvto+ww2r++U?=
 =?us-ascii?Q?DOD8x1hwlbq9MtkBX8AjF+6QfMQZq25PIJCznPQwnA5k8U7sREOGhVF0BJqc?=
 =?us-ascii?Q?+Z4LDjcegc43fvcSzowZij7/Dmtq67PHfnYAJEnFEum1WjdOfWtwZA7pCc8O?=
 =?us-ascii?Q?NgsPeKq9vFndprJkMKRZesymSY0NoXhrMF63lVjL3IlubsXE+029qsvnGydZ?=
 =?us-ascii?Q?lTC7z0O1PwbkNfw+Em8adRKrz/rh2qqpF2XVa4GojxZUy9g7Q8oEzdFM9MiF?=
 =?us-ascii?Q?Tlr1YRg0ZGDN8jDbc+YUQP4mg7xT6biUq9S7zWf/2K3P+SINojG5H3RFoVWL?=
 =?us-ascii?Q?DiNzK/2Q2FznZLXHzomRzmXEKesx+fF173kczkdEWBZuOEn0OzI2FAD+tb6Q?=
 =?us-ascii?Q?k5rXmEqnx7ZGpFOY0ohYG3PDz352249KGYGOYS0ZuOZVmesa3jj+6ESp3HNG?=
 =?us-ascii?Q?xU1BTF2LQntdK6xnu+9RXEh5wVM/oh6NmXzW17OZwvqx0SsGBwivDRTcUvGL?=
 =?us-ascii?Q?LLxnKBgqBbeNuSsPTQY4Frl9QCIJS6DKgriCOA6pS80wwBnP7raDszmG319K?=
 =?us-ascii?Q?BKnpYhvTh5tzxjuA2iTXZb0+1IfARoBSQkYdhfsy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cf419e-77ad-4ead-993a-08db9e593d2c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 13:03:52.0194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9+gxoP4Z4+5YIztdk+9t7Qq4bcHl/DBdwwcX1kzqu6TKx+FuF/tK3NrqIKdy0Av7Wjq1IAg7/nAQ2+naBgcUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sagi Grimberg <sagi@grimberg.me> writes:
>> +     switch (event) {
>> +     case NETDEV_GOING_DOWN:
>> +             mutex_lock(&nvme_tcp_ctrl_mutex);
>> +             list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
>> +                     if (ndev == ctrl->offloading_netdev)
>> +                             nvme_tcp_error_recovery(&ctrl->ctrl);
>> +             }
>> +             mutex_unlock(&nvme_tcp_ctrl_mutex);
>> +             flush_workqueue(nvme_reset_wq);
>
> In what context is this called? because every time we flush a workqueue,
> lockdep finds another reason to complain about something...

Thanks for highlighting this, we re-checked it and we found that we are
covered by nvme_tcp_error_recovery(), we can remove the
flush_workqueue() call above.

> Otherwise looks good,
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Thanks

