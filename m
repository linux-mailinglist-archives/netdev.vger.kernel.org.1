Return-Path: <netdev+bounces-28935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A0C781318
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA122824BC
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1295A1B7DA;
	Fri, 18 Aug 2023 18:51:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0501819BB0
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:51:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F412E3C2D
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBqWJ4bW47o3NkMKu/bLrfbYf/2JowC6QB0tJjjuRE1q9qnda0AozHZtX+E9mYG3WPmkUna7ly5IDMe6c0Eaic1XJD+akYwi7CqcRUQK39WBvV0EocB5bne3C0XCkRSN+LBiysd3ARaSHqwH2ecK4Z+zviry9rC81Tre0uFuUe7Np4UJFHsAu0MOTMUso1WC69lYJ/9xNodrMbXvxE/egHMIlFtxQ/4vu/7NcDSYV0oAKnfLbaRczB1hNj7CzDzNCZV05M85Bpt4fD+P920FXnc9oBrGLw67PqfOaEq0fxXY9McU/lL2sLUzUHBW2IHOZJbbkQWiE2l453MjTsu0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKi3cTnyfJ1e7nA9LkqfUu6s3VlAM9ydKk2pkIzAgFk=;
 b=Mo48yqmWtkW49UgPzuJkuGZU5hAs2bVrNsyhatnK8F75KD0h77qYMPvXTtlhgJSmjA0cslu9BFWnaxuK9TcUIPFrY42Lj3c/HMY39hqeHulrexSm1VmPq5qMuQAY5WJBR4dZ7c9eo5UPPOPsLdFh+LnskUFXdm6yiQ70tzocGnxXDh1Ufy4a8fZZF9V3Ygo90Y3qOUE8Pk4XX7adVu7FrBvm1i7kdXTMg2fKfskwq/Oup+dEMGosmLjtAy+sshaPrev492lkSxq/NRPsIrICbxUcZhJUo7m+1VoREHT7d9ismFrpBpQhlZzsZoGWhWxuZuZnQjdOCzMeo+A3IunKqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKi3cTnyfJ1e7nA9LkqfUu6s3VlAM9ydKk2pkIzAgFk=;
 b=Vrq8QqXtIR+ZDl94gi9OynvCoV65mrsoXLei//FK/ZlDxvSQ+CwFF+JUeX6pY1rszuQaigZCBQdkNV6QoontVn9U14SM9l2YcAV+/ypWJPF8l+xaO6W6eQqo//tPPioec5jw5y1YbVK9y337bFViEA22wU6/6UHp34XA5KjWv24YCVjPQ1AHS5a/BNmvMRvhiqVjvXKK/P2SOr6DVkicx9dhBHCT1lJhF67u/zEHOhBIhjofdK6rjSgN46BKPbFsBt7LdHBQNGEEyp6qhGbe5+HrG6FF7XUB+LcfNd9+XFOMuf53nwPJi2SJbQxQKnxFZbRMSFoRkklBHOMq8l93Wg==
Received: from SJ0PR13CA0115.namprd13.prod.outlook.com (2603:10b6:a03:2c5::30)
 by LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 18:51:44 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::a3) by SJ0PR13CA0115.outlook.office365.com
 (2603:10b6:a03:2c5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.10 via Frontend
 Transport; Fri, 18 Aug 2023 18:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 18:51:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 18 Aug 2023
 11:51:26 -0700
Received: from localhost (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 18 Aug
 2023 11:51:24 -0700
Date: Fri, 18 Aug 2023 21:51:14 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 05/15] ice: Utilize assign_bit() helper
Message-ID: <20230818185114.GD22185@unreal>
References: <20230817212239.2601543-1-anthony.l.nguyen@intel.com>
 <20230817212239.2601543-6-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230817212239.2601543-6-anthony.l.nguyen@intel.com>
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|LV2PR12MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad8a50a-96a2-48c7-0e4a-08dba01c2a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	If57IwoiNnItXAtTOogxXDIYeGWtXy8m+rGF1+NAa3V6aLTQc9gdyuTKh5vl1rQwdLAOdNf4/wJSwVKDTHJ08aoNbtcSekBSy7/XA/ft8HJNzOOlDCxzVrEFqTF4+wyFBEgoJSZJczNWpwsIxbBEu2PrxL+tNBLKmHQ0c3NOWq8qyTgxeEoh1gcLPEhxcMjFQ8GcgNkFDj7/MdPJWRKR9MYjl2LubxxEW85NQ7BdOpo6ePaAzrKnZPEw7f7bMYxk7M+WiPIpe/lirwkJRKs7vRXaZCeLTRaBjl+bAkPOVOw+8H9Z6/KwpouudG3QdeZiVPj27Zjd+KkhLDGizJLAaWgcvWCjdK5Dp9Ml8ae7p9d+u+fCJzTXG91PSHmzMJtewcXWtvVWHKdNw/SwF6NEXptlJfwXbxvvcQw8Wu3WsSHO0PK4sKZhlNuTu6R8nGq/8+PCljAoGDWWGy2n4M7LHC2wjiw1a4L4Fgn3tgXZqB85fRjDcJtnS8k9FEGo9c3jp9RvNZKWeFSqkEhU6xfui1jprV1Wch82AJ4xjiEG/rqKBedCXu8wTaJwUXbOnTFFM3eGPH2GqmwYREeDILLzZ27hCc9M9ni/yOgeNVmZCje7UNcdefCnRfNkzNanNYySfiF/dHNrYkxsG2eu/NWI8TEmP/+5BtuHxFT484jnr/6owfyPxx/iLaPOAat4/ySuD3SCqQIDHhGM2d8ec1URBV4OBvGVTPlUnv2wBRqIGLKF7Ru0lgViqTRxgGhaZCNV
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(7916004)(39860400002)(396003)(346002)(136003)(376002)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(86362001)(33656002)(33716001)(356005)(82740400003)(7636003)(40480700001)(16526019)(5660300002)(70586007)(54906003)(478600001)(70206006)(316002)(6666004)(6916009)(26005)(1076003)(4326008)(8936002)(9686003)(8676002)(41300700001)(47076005)(40460700003)(36860700001)(336012)(83380400001)(4744005)(426003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 18:51:43.2435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad8a50a-96a2-48c7-0e4a-08dba01c2a6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 02:22:29PM -0700, Tony Nguyen wrote:
> The if/else check for bit setting can be replaced by using the
> assign_bit() helper so do so.
> 
> Suggested-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

