Return-Path: <netdev+bounces-12813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A39739014
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5512E1C20F77
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9BC1B8F4;
	Wed, 21 Jun 2023 19:31:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453F9F9D6
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 19:31:13 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7141AC
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 12:31:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgbXhM+Jzjsg4ABP+LAPPsiN8hBjkn+wetradzZ27FnS0+XWW5yCJSkXdIQ+dyJrunxtKcmlRr9o1vorzyWez8kwNH/EsL0udqUAc16FnMsoqePHeH7cTHp4m4USQBaewrYEAwfQIR1lBl3fM39z2mzjR86tQGXa8RLp3KOZO+va4jCbsi5hiGrFK0/38TSbPvdHAETgdXuam5NUjwjWK+dxoEF3z1vovz5mMx3uLmleKbkEBV2o8z5ZVnZSi1yNtKVOfvmKRK5iWxOzeB9seBV5gTdHc/5L8TkrZ7wohNuyj5vxp2aIbb8lTSnHDRwNKK5mLIm1QRMXXon+xNV8zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWb0X2572rubVnNMc+kMa7oNsuIoyiar2dbeFtCELy8=;
 b=hETT2a9VhioHilZVuF1hvWkPzK9lAnHakbrPJB532te833B0sdpEWwfes4EQpZMImfuE3p5C06dCdrfwuJtGJ2estyWj1v27f4S9xzYRigvdfOVxuk9dXM5dwpqpqA/hA1uXwO252aE32s4rs2w0zK28/GvI3E2l42f9tP0F4f7yazffjm1hLv4swmPnK+aO2KPAv/bcZiNsgAORc2RlZ8nLXHHmBs26WOaCX/IqqKaio+V+ZiMIPtXVlDOt5jh5fCREoNmeJ8uWsM0B9GWPTNpchPeI8LdlG33FMtZhPyvJ/jDP5kd/2elurHgtfPy0OGbf5ekc2GFMkJTjhVsUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=corigine.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWb0X2572rubVnNMc+kMa7oNsuIoyiar2dbeFtCELy8=;
 b=hm+viemZSZRx+Z4zV3HBTiUN5yap/892xuwxi44Jjwkz+Tq+YKOhUfX3htejL9pX28Xmf6kH4SiJcC7XQnPsqk5/jTZL/mYEU9b+qEwUlwgPGT7BuPzE/d98o4BV6VSjtIhWsm09SL2GBtZTh+LfrvgKWJ/5xOMnu4PQOWLVD1mkxp98AFXowLa6IfAe7jzPEAKjT/3X1/1a6pbvgFizMNkvmZ+eyw8KjhMgIrKa+59eAbQPstDNT55MbAXxjmq0gZ26vA0yXclzs4Qsap+aL0ZputidKdqkaNtmSRW6prT8Njr8CHxKbM9mMQ1FC16bV4qvg9MyKUey/9Jdwu3CIw==
Received: from DM6PR12CA0031.namprd12.prod.outlook.com (2603:10b6:5:1c0::44)
 by SA3PR12MB9159.namprd12.prod.outlook.com (2603:10b6:806:3a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 19:31:05 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::69) by DM6PR12CA0031.outlook.office365.com
 (2603:10b6:5:1c0::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Wed, 21 Jun 2023 19:31:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 19:31:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 12:30:46 -0700
Received: from fedora.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 21 Jun
 2023 12:30:43 -0700
References: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
 <20230620111240.24b1f6a9@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.2
From: Vlad Buslov <vladbu@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<wojciech.drewek@intel.com>, <jiri@resnulli.us>, <ivecera@redhat.com>,
	<simon.horman@corigine.com>
Subject: Re: [PATCH net-next 00/12][pull request] ice: switchdev bridge offload
Date: Wed, 21 Jun 2023 22:25:39 +0300
In-Reply-To: <20230620111240.24b1f6a9@kernel.org>
Message-ID: <87ilbgvcim.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|SA3PR12MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a276e9-dcae-4449-5680-08db728e0ded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wLRE+kfLObobUMtn1H7Kpy41Zpfq3uL0rs+oinbJCd1I0ZB8q+Bg/zgLn3C+TY+gw3ve9coCRL9Z6HqVmiQGMdAiAAS412kGhoNmV85rrNf5IcXa6547v2S59h/pEi7xZBHwUQ7PY5QhGJnDBguY7MpKqAgt6+2AcyZWVuUf9tcujQpcUiIKFz749EQBQTAB6BNd1VgocvAEFLOdEww+wQDB5EPk76M/ImyWxSKm0+fXG4yZ1+4umIg8mE/uAM4hyCfefvh4VZMsurMAOP+Pol38fFSMh9vzwRI1T12sgMgOUDwSoWBbY7FykJ/PCVnd81hDtdE8SWKyVDMVjJQyPCBD16CGpJXxmk8TCc2mW07pnaJTwTVucwO/dcHBqpoAu39PZzCnvIkdZh0H5r1D7pr6CTMDrZQlg7KQURsfa6NUXlCLtGcbs3r8EVVrg94EW/xuk/HY/MnzxA8YTA1jVI91w7RalYefYPmcWKm0dFf2hQNc11nXV/edF201CVMvlIBBIKmsclAuqz+hPUnF9YP4PASLRe1o0tSwlnXsrOWKV92FkBBTxW5+vLXJUQWKSPuJp/laqy5Qw9VjvqVKNSv/gRG1ISY3y2QiRygaStZz8b8+2ve5bgj5HsJEdsobfI5zVaWCYNCdu9V9YNsmsd2Nz1mXcdE+k1HrS9gnP8b3JQgqrGPAA28VR8sPhjqfOKLLuNWvYLPS4NeEZG3q/M9XopP8FjA/eneKWsXpzCUg+dmJXanJ5oGMEFRhlcOu
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(82740400003)(7636003)(356005)(86362001)(36756003)(47076005)(83380400001)(36860700001)(478600001)(54906003)(426003)(336012)(40460700003)(7696005)(6666004)(316002)(6916009)(4326008)(70586007)(70206006)(2616005)(41300700001)(8676002)(8936002)(186003)(16526019)(26005)(2906002)(4744005)(82310400005)(7416002)(40480700001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 19:31:04.6231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a276e9-dcae-4449-5680-08db728e0ded
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9159
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue 20 Jun 2023 at 11:12, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 20 Jun 2023 10:44:11 -0700 Tony Nguyen wrote:
>> Linux bridge provides ability to learn MAC addresses and vlans
>> detected on bridge's ports. As a result of this, FDB (forward data base)
>> entries are created and they can be offloaded to the HW. By adding
>> VF's port representors to the bridge together with the uplink netdev,
>> we can learn VF's and link partner's MAC addresses. This is achieved
>> by slow/exception-path, where packets that do not match any filters
>> (FDB entries in this case) are send to the bridge ports.
>
> Hi Vlad, it would be great to have your review on this one!

Hi Jakub. Sorry for late response, I'm OoO till next week and seldom
check my work email. Will try to look at the patches tomorrow.


