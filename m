Return-Path: <netdev+bounces-18355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5527568F5
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 18:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC19281130
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C60BA55;
	Mon, 17 Jul 2023 16:19:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EFE253CA
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 16:19:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178D2E6F
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCO1cyN8uSuHeOU28jzzgZLQ0mx7ZR7xpFl0tR0a8WhBUb1YooSjkSXxArJdprFUUNMavhxf5pLsQ0WKn+J6Def8c8bLg+Ig2su0yJm/0Bmbrgmjbjf7A0vVrgmDILT/uVMh7JOH4zBw9x2CpkDhRFZjzfO3Cq0+9iBx8Xi7XJpAeg3c0Wg5BcG6oMMyRY8E+TjN22V7WJ4WisNVzCAlYmLBNTdjaMEZLggLl0DWr2IFPjiBXOy2F59E882cMqyhO0j5gxPp4Jk2KaMpYg+VYLGRXauVi4HVxl+SZ7UHX/hZQZ0Bnu5yfowzZ9ckg5xorpiqGaEIsT2PGDAQGWN3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMDBHoxOWbMIw3vb1INSpVJb9qsOspHLkJBi5mBfUSQ=;
 b=cWpn/x00aFY92XSpP1I0yZTy9oA7JUUy277u9Q4SweHq8mcMYTiEP5tXCZSZ6yF/IY6BnTNK3nn2lK+9XwcvYpla9t892daj00NSnC+vEuCt5qe9dMeDmUBLOS/NDM8mjYGC3NR4yHwPBZDo8JO2JIk/0d5T0ODhYZEbgJ4dSboygNfC5fxBCB7nuhHdLi+/n5o+8F2rtct7k3mWDM/2k3aTq1lltHFN79oOfavqVVOFj6WJ0RHnIUd0EdI4Jq8yW1TTSnbKp5r8m1xI66OK6CRobKyCIjEj8qk4Sukb7P+hvfVtIfSpxTmO+VN9KWSRU7C/BFg6HvScQ/uVaSzS+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMDBHoxOWbMIw3vb1INSpVJb9qsOspHLkJBi5mBfUSQ=;
 b=r2Q7zyLLiLh/vJQSB8c0vAWQRznhzKS8DDChvqOW2kp8bXEn1Qew60fEnhOlBW62t0eQEQf/RRc7OluLCoXmkUAGq7Bg1G29Mi4Cl/QKkmyKK5EXucuO3C8nBbK0n9IZo89yQRqOHrMo7q0ZqKncBvNlgG87q6sOuBXZxtc1t0UY95qanU79Ock4JHYeWARfSjrr2pZ/mck1cKh/aYg2jE6JPnCZIGJIoTQvEdnoib6T4lf3zneKXsxn8Q00kxZUB6JaofEcsie3AWmB2Gu5MFG3P51+qIyUzh+F5ZDizFyAu8909wDosCMvfFKzMiJU/waPYeTfk3UasIjjBWAurw==
Received: from BN8PR04CA0038.namprd04.prod.outlook.com (2603:10b6:408:d4::12)
 by BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Mon, 17 Jul
 2023 16:19:07 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::bd) by BN8PR04CA0038.outlook.office365.com
 (2603:10b6:408:d4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Mon, 17 Jul 2023 16:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 16:19:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 17 Jul 2023
 09:18:54 -0700
Received: from [10.223.1.249] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 17 Jul
 2023 09:18:52 -0700
Message-ID: <5c8e2eba-88c9-5913-ad18-db272484adf5@nvidia.com>
Date: Mon, 17 Jul 2023 19:18:50 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: EEH recovery failing on mlx5 card
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>, Ganesh G R <ganeshgr@linux.ibm.com>
CC: <saeedm@nvidia.com>, <netdev@vger.kernel.org>, <oohall@gmail.com>, "Mahesh
 Salgaonkar" <mahesh@linux.ibm.com>
References: <c13fa245-64ed-f87c-fd1e-e618fe017359@linux.ibm.com>
 <20230717131006.GA346905@unreal>
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20230717131006.GA346905@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|BL1PR12MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 524f47bc-cdfd-41f0-7558-08db86e18c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DawrN+en2LyMgb2TNcRF6x+v1Uw/dVgbM3L+X3kSEXA6pgCoY1+LjQc21XUqKpKGx2goJHc8/OFNe4PX2cwCgMm4tIXDIa1zXnTuH3vWPPohqWFqkarucqu3/tE6rKY2m2l0SY/VOQ4b9FhlDyxFsIUhjhwkzCjoIiHixNuZ5o9JXnQxtm22bfOBB1O5Q1UJnaCbdqIwwPi5MLTahSIkGH23azHAzoXSHMzYiBQuW7eeox9ob6SXe0h5mwtWOANgoV3XrOuYhWE04KJ14Elpjqps4NwsUF2c+sgL0ri61+p+tJOSWK/Lh14ztDypUusK/JwzOJpLpx9TICqJynKJCspsRnFsyq7CKpHBCe7aQGJe+GDUNejk+Om1BOigUqNdtFgQZ+3fq7LQ/q9Jjm8wtzBujpBZkePrKoCnc7u5v+6DuAxfNlCRo3qDl06G/w8yywTxl3bbQObFna2iPU5RruRF5ROSL74N+1HAp01rmL6sLyxrSMKX+uSiVKPHBwikIQhYHriYi/wQ9TRBkJi7t6qLL4Q5YJwWOBQM/MJzRT0EMLl8GOlaV+jJqRA56STcCMhFNODPpWELrgnTKqsW3wcv/9Cwrc7qAxV20IIR22KWK3fVOVCQFabhTulwgUPBmVnuHPILVVBKMxBzsAzqp0RC2Q2MvGFAFzodoBJU5DxcLyjUSb0TpDEDGx1209cbNM946h7VnHpX8eQGz/yV6MENJxEGY5gZajGr9D13lNqN97sz0WuJ74HdDTw+Bl7IgV6/tPUuDvrROnjQAXTYCA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(41300700001)(110136005)(40480700001)(478600001)(16576012)(54906003)(2906002)(8936002)(8676002)(31686004)(5660300002)(316002)(70586007)(70206006)(4326008)(26005)(53546011)(40460700003)(186003)(82740400003)(7636003)(356005)(16526019)(47076005)(426003)(336012)(83380400001)(2616005)(36756003)(36860700001)(31696002)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 16:19:07.5826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 524f47bc-cdfd-41f0-7558-08db86e18c03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/17/2023 4:10 PM, Leon Romanovsky wrote:
> 
> + Moshe
> 
> On Mon, Jul 17, 2023 at 12:48:37PM +0530, Ganesh G R wrote:
>> Hi,
>>
>> mlx5 cards are failing to recover from PCI errors, Upon investigation we found that the
>> driver is trying to do MMIO in the middle of EEH error handling.
>> The following fix in mlx5_pci_err_detected() is fixing the issue, Do you think its the right fix?
>>
>> @@ -1847,6 +1847,7 @@ static pci_ers_result_t mlx5_pci_err_detected(struct pci_dev *pdev,
>>          mlx5_unload_one(dev, true);
>>          mlx5_drain_health_wq(dev);
>>          mlx5_pci_disable_device(dev);
>> +       cancel_delayed_work_sync(&clock->timer.overflow_work);
>>          res = state == pci_channel_io_perm_failure ?
>>                  PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_NEED_RESET;
>>

Hi Ganesh,
Thanks for pointing to this issue and its solution!
I would rather fix it in the work itself.
Please test this fix instead :

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c 
b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 973babfaff25..2ad0bcc0f1b1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -227,10 +227,15 @@ static void mlx5_timestamp_overflow(struct 
work_struct *work)
         clock = container_of(timer, struct mlx5_clock, timer);
         mdev = container_of(clock, struct mlx5_core_dev, clock);

+       if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
+              goto out;
+
         write_seqlock_irqsave(&clock->lock, flags);
         timecounter_read(&timer->tc);
         mlx5_update_clock_info_page(mdev);
         write_sequnlock_irqrestore(&clock->lock, flags);
+
+out:
         schedule_delayed_work(&timer->overflow_work, 
timer->overflow_period);
  }


>> Regards
>> Ganesh

