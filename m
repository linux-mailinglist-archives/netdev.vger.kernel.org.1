Return-Path: <netdev+bounces-23959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 470C176E500
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2775E1C21493
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 09:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3895D15ACB;
	Thu,  3 Aug 2023 09:53:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262907E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 09:53:04 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B9211F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:53:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLxSZP5xejH/doJd71EacNJCsic7f2zTavxT4eJS5ZulWDJQEAw6fwQXuyCh0BegnW9HHncaKvh2beYy1mnPGkkTh8jumSGwK02BXhk1IKUoTUQs5yByH0OGSrlZHw0P4KRZVZckHT2KjNNyzK80naDUhETE4HNOcv+rETqR1o/D+P0SsAhWFL0/mtHYngpprwDACmfzgj5BtgwpwLidpnHyAwL9Bi6RqGmS/B1fm29rjotHXWH+DHsmd+D20GHwLqYZj3O4jQRlD6GE3thMHy8jn92K9Du76vNb3foDOrrOpTiPcZmdy7jXKcrvQwZDY+9aHHjV0TiZZrMvWkMqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2ckWdSFtIyZvSE+TJh0w1spCtJHVqneQrxA38ClQJ0=;
 b=T2QjHk0oxrX4Ymq9KU5g67F0nb0llP7WRoGgkrSkSFSI1icMO623DU/ngX19zUFRs866+fZo54RuiUQ1k4FIBzaYDQ7imIwn0HO/VSHzRDEJdS+m14Nl7Qh5tGfPw4RwQpxfBNd7n93b86I41aG5RDWSCRq9ZmTpLL+yvADRF5D2KpINj6AW/HHipJtHDfIS6jbOKVALulP7Ccr+rdLLvYrladxP0LW+BxxNxCkJaqvXyJAUbm9SBIyuBrybsem/Ed27CSNjirtvR1hTJ5SKGsAIxyhUesyJcVElSuOpKWerzxFJJRsyMIyg+EQIEVCRb5J89bBLEMwGfcrWKrgORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=blackwall.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2ckWdSFtIyZvSE+TJh0w1spCtJHVqneQrxA38ClQJ0=;
 b=l705vrJ3svSDJGiB1ZUl9tgbCHaRWhZOXWn3IGD0Z3HDP0aHIxkG7W57MsjV9F3frLoCtEDDc/4MloFQPK4TdmqjdFYCCUvVeqvMO3knDogOgO59ievbUvY7rnVkGa8tCYV5cpya457YWC9jY8KrbEzgHJkLV4aYmiWHubv2JGX6771R/M5RMYAmmDdbZCKo0FjQ7lYtdkNGu/nLB4aNaTTx2lTezlAWCwZJm1A5xxcUsNOhcy49tW06e85g96X7uvAKwOjMgNMrxr+YJgl4SUlTTGLFuB9f7MJHaslnD+xCwS+4XMVf8YpVACOL5J853TNU7Sz18TqmcWhenUy8ww==
Received: from CYXPR02CA0058.namprd02.prod.outlook.com (2603:10b6:930:cd::27)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 09:53:01 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:cd:cafe::83) by CYXPR02CA0058.outlook.office365.com
 (2603:10b6:930:cd::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 09:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 09:53:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 3 Aug 2023
 02:52:53 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 3 Aug 2023
 02:52:51 -0700
References: <20230802164115.866222-1-idosch@nvidia.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: <netdev@vger.kernel.org>, <stephen@networkplumber.org>,
	<dsahern@gmail.com>, <petrm@nvidia.com>, <razor@blackwall.org>
Subject: Re: [PATCH iproute2-next v2] bridge: Add backup nexthop ID support
Date: Thu, 3 Aug 2023 11:49:57 +0200
In-Reply-To: <20230802164115.866222-1-idosch@nvidia.com>
Message-ID: <87tttgcv0v.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|PH7PR12MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: abe8bc55-5a5d-460f-13d5-08db94076c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4Mk+7910zoPHiM6EQGYmQW8lkyHPNWYxwI84ePbrL7i4Ty3+iy7hGbvx/4lxgIYCoPCdtt5VQfuGrPGtuN7O77krbq1BRJVNPPt3KFf0gJ9JrGtn+f/9Oj2F+mOYf6uCFn8IAD+H+ncLa6W1LBZP7QnfkoP8F2eEJnI+Gl60h2/7OZfocZxugIj2vLPAMocwd3h0AV/RII8QRxOuKQVF+y1CFZbeYQML+DwDgcaz953deaF12a5Idh4uayFB3/wLUVhTz4PuZykrD4ShwZuP1swACF2RJF10fywHMcfPxjknCyyL3cfJT7tPzUfejhlObSD0bVrGFCbyEAEqrRQ9TfxkjZ/2ufgBFDzam/LsBa0VX7k9mRKNYG2k+A1iVGMoDfumFYfTO8YzjD7SQWSrpzZ7Os5N4UzO8r1s3/gDGwISqhifjgyEP+BStxQ+CItifarTK/HNSqvHrThl0g3JK8QpF1srzBKRc1FTdDDUQeBkwD+aY6DfDWgSD6XtEyRl/1iWsfpeRn6aad4rRnQErRH+QwUYIOnWRoUKDbsjyGun6iypd+XpwEGRd8XAL1SZGn/A4u8OGcrFhV70B7AU8PL6ZqrJt7ZxEhgMVUx7E8hvp5XzXJTIOnHBKLkkXXM2HYfRyOSO00kh6AgipXEfWYO7HkCD+LMMI6eLW2rKec7Rpm9EIH0qUx/DWehKkNAfffXKLVllsro9lY7qDU8yVF4tfZkYnf9oRsYhMxzWrkIn0ZsGNR+KIU+2VLUp1Fsz
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(40460700003)(16526019)(426003)(2616005)(26005)(186003)(336012)(47076005)(36860700001)(316002)(2906002)(6636002)(70586007)(70206006)(4326008)(5660300002)(6862004)(41300700001)(8676002)(8936002)(54906003)(37006003)(478600001)(40480700001)(356005)(7636003)(86362001)(36756003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 09:53:00.5250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abe8bc55-5a5d-460f-13d5-08db94076c54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Ido Schimmel <idosch@nvidia.com> writes:

> Extend the bridge and ip utilities to set and show the backup nexthop ID
> bridge port attribute. A value of 0 (default) disables the feature, in
> which case the attribute is not printed since it is not emitted by the
> kernel.
>
> Example:
>
>  # bridge -d link show dev swp1 | grep -o "backup_nhid [0-9]*"
>  # bridge -d -j -p link show dev swp1 | jq '.[]["backup_nhid"]'
>  null
>
>  # bridge link set dev swp1 backup_nhid 10
>  # bridge -d link show dev swp1 | grep -o "backup_nhid [0-9]*"
>  backup_nhid 10
>  # bridge -d -j -p link show dev swp1 | jq '.[]["backup_nhid"]'
>  10
>
>  # bridge link set dev swp1 backup_nhid 0
>  # bridge -d link show dev swp1 | grep -o "backup_nhid [0-9]*"
>  # bridge -d -j -p link show dev swp1 | jq '.[]["backup_nhid"]'
>  null
>
>  # ip -d link show dev swp1 | grep -o "backup_nhid [0-9]*"
>  # ip -d -j -p lin show dev swp1 | jq '.[]["linkinfo"]["info_slave_data"]["backup_nhid"]'
>  null
>
>  # ip link set dev swp1 type bridge_slave backup_nhid 10
>  # ip -d link show dev swp1 | grep -o "backup_nhid [0-9]*"
>  backup_nhid 10
>  # ip -d -j -p lin show dev swp1 | jq '.[]["linkinfo"]["info_slave_data"]["backup_nhid"]'
>  10
>
>  # ip link set dev swp1 type bridge_slave backup_nhid 0
>  # ip -d link show dev swp1 | grep -o "backup_nhid [0-9]*"
>  # ip -d -j -p lin show dev swp1 | jq '.[]["linkinfo"]["info_slave_data"]["backup_nhid"]'
>  null
>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

