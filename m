Return-Path: <netdev+bounces-22931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C263876A100
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 21:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2591C20CCC
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 19:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3711DDCF;
	Mon, 31 Jul 2023 19:18:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C41F19BD5
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 19:18:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A312F198
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 12:18:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xbbhfz8/uR3VhrQjITA8yUVHcdFMVzIQlHmKy/zZqLr8+ZW68fL7jRoZ3rttuhNkxrChZC0Zf8wUxfVIC9Jt8d6Qx3U2yxuIap1IfllhYoZ8aREYY8LWLcm+x6V1kynaWD230hXY2XgViFZyiPGCHSlxZFaheaUt3FI2Kn0D+Jge8AqKrLYpAR8seToK9zSnriZ3En0wohiklOTxBRt86hr7CwepWAy1bCQFRAOwDRkUj6M2dKATUl7hpSq0HEx4wbI9TSyvUzt/H/aBGuyDQJM4HgaQKbSi+EUSf8fHyhGbn4kcjbtMgzby/9OJeWt9RTv51rurih2QV7p0k9mfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skmMRSQJ/gtp5BB3SmySy3x4h9QuPdopr8usq1wRuKg=;
 b=mXq5dr2Dfi3gXpCf1N4P8nhskkYNepoinVZpa2lfiq6fQTgiVl04Iagr46MSA6T/ZGlWmJKRNIWBHaTe2Yy90EsYctzhw4Fo5i9KN5+4uyxZNLVTQKaKYHuAX8tu2cHjsDsNe5H67F/BCyXfDettB36nWg9s3FHeN+2+NrISbzTDW0czpxzf626L4kuzsZ60ZKCzgPPf1S2zwWgwGfgA673PB3NOb4WZF8Lt1CTT//LnrU23ncxD6pBBaS/6PXxa00eFoRlGBENZEsCvv8T5eTyUyS8/lYHu70ba1HZetKmDEb3v7YHKv7qpKo95DQnvI0LOt7oE2Cwawsbv7FnlHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skmMRSQJ/gtp5BB3SmySy3x4h9QuPdopr8usq1wRuKg=;
 b=d3qftevOWXIFbol5bU6CNAJM5U6aG8llU8Deu5sjy/NJFJ7uPaE1eyvuquSw85EkPxBTwj0ePYuIZqktrk4lgjsBz1d2qOZChMckRILE83ASmGGITkN2jDrgX1sLMocB0ttCCEHUFwR/Jagd9ArPINCAS8tRcmPCukhFgakl6qWhJdY7PKEqB49VMziSzOpiuzSEiQZKvM5M/FTQxM2+ZhGIPNNdpbN2dEbG/Xbh/PpZVQLPv/0FlQpWvpXqwdyyUV6E9iV1dTPv1Yq8CvsoPJvzDK3gxkCrJh9OLXg1qvyaB/DVeSUHwA41zZkJ3ftNp312YjGvF+7Tg0tcXr2bzw==
Received: from BN8PR15CA0010.namprd15.prod.outlook.com (2603:10b6:408:c0::23)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 19:18:38 +0000
Received: from BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::11) by BN8PR15CA0010.outlook.office365.com
 (2603:10b6:408:c0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43 via Frontend
 Transport; Mon, 31 Jul 2023 19:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT096.mail.protection.outlook.com (10.13.177.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44 via Frontend Transport; Mon, 31 Jul 2023 19:18:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 12:18:23 -0700
Received: from fedora.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 31 Jul
 2023 12:18:21 -0700
References: <20230728163152.682078-1-vladbu@nvidia.com>
 <ZMaCB/Pek5c4baCn@shredder> <ZMeEU/Aqq0ljY8NE@kernel.org>
 <ZMfXExktiYeVEo/3@shredder>
User-agent: mu4e 1.8.11; emacs 28.2
From: Vlad Buslov <vladbu@nvidia.com>
To: Ido Schimmel <idosch@idosch.org>
CC: Simon Horman <horms@kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<amir.hanania@intel.com>, <jeffrey.t.kirsher@intel.com>,
	<john.fastabend@gmail.com>
Subject: Re: [PATCH net] vlan: Fix VLAN 0 memory leak
Date: Mon, 31 Jul 2023 22:11:04 +0300
In-Reply-To: <ZMfXExktiYeVEo/3@shredder>
Message-ID: <87leevsxdx.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT096:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: a45b85ec-732d-4f9b-89ee-08db91faf1db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yrJSif+rHF8jWXN783G2FXutHw3Qsl30i8JOuBlvIiBp8a4tEqWNsDepAhmrygCUpQS1vrzgT83+Mc1aZMr4t18df+AWSkhBnCJLMyT3Hj4PBLcaW73jAmFqlc1+t9P+mtx4KtvqyJu/Cc0yVS6lzO/Rc+igRgHzvoROCEoKzxo3cK62O9lKnaGp5n6cIwezKWfc0035MHwCcI69MLnWDx4g6nEeGvLDyP8j3p2D9yS9jRIn8DtcVsfz8rfuiHqhk303qHMtHX26PRyIslWgiKAlp/QE31FqfywHo9jjs0qPVfRsDvLNrL8IFky4guXToW0usVDu+7KKy5SfXLEqECdFvImdCxlTo1tvzihP6HjjQvpm5UobY0sBrxzwfT3APYY4iQwNzFTYuqta3LWAt2rADJ+q46dPexKTVvtKxoscRZDbZOy9NCRIVgR+scnTaLWmsBQ1WEKt8sXTwjjzdb6OJ4kipohCZoSU2Zxa4mxBX3z+A7ki9dmrvtei4P6UmVfJpcOGQjo5zMrLF5eEcbeAd4DacnwUYcsqioguJPaEWDO7UG8Qu/wms+peUduk4X6DHZOON3ufqM0vi8jaA/Ihuv0IYhIImig+S/t8+GYrP/Hdfxkv11xoxOPwTWvJhBL6+G5Etbj176C82rL4wuOYNM9r2e0+gSzniOZc0sfG4yS5rdnufg9dBQcGdylHphmwOWnqltjnL0YqFuWY9sp4cKlpXYYMPPZSuLU64CmkFyyDLJ6yCA+9HZk65mrxDSQtO7YMflR342kXk8B0wA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(8936002)(8676002)(26005)(54906003)(41300700001)(82740400003)(316002)(6916009)(4326008)(16526019)(5660300002)(336012)(186003)(7696005)(6666004)(478600001)(70206006)(70586007)(7416002)(86362001)(2616005)(36756003)(426003)(47076005)(40460700003)(36860700001)(2906002)(7636003)(356005)(40480700001)(505234007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 19:18:38.6730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a45b85ec-732d-4f9b-89ee-08db91faf1db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon 31 Jul 2023 at 18:45, Ido Schimmel <idosch@idosch.org> wrote:
> On Mon, Jul 31, 2023 at 11:52:19AM +0200, Simon Horman wrote:
>> perhaps it would be worth including the information added
>> by Ido above in the patch description. Not a hard requirement
>> from my side, just an idea.
>
> I agree (assuming my analysis is correct).

Sorry for making it more convoluted than necessary. Just disabling HW
vlan feature on the device and removing the module is enough for repro:

# modprobe 8021q
# ip l set dev eth2 up
# ethtool -K eth2 rx-vlan-filter off
# modprobe -r mlx5_ib
# modprobe -r mlx5_core
# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff888103dcd900 (size 256):
  comm "ip", pid 1490, jiffies 4294907305 (age 325.364s)
  hex dump (first 32 bytes):
    00 80 5d 03 81 88 ff ff 00 00 00 00 00 00 00 00  ..].............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000899f3bb9>] kmalloc_trace+0x25/0x80
    [<000000002889a7a2>] vlan_vid_add+0xa0/0x210
    [<000000007177800e>] vlan_device_event+0x374/0x760 [8021q]
    [<000000009a0716b1>] notifier_call_chain+0x35/0xb0
    [<00000000bbf3d162>] __dev_notify_flags+0x58/0xf0
    [<0000000053d2b05d>] dev_change_flags+0x4d/0x60
    [<00000000982807e9>] do_setlink+0x28d/0x10a0
    [<0000000058c1be00>] __rtnl_newlink+0x545/0x980
    [<00000000e66c3bd9>] rtnl_newlink+0x44/0x70
    [<00000000a2cc5970>] rtnetlink_rcv_msg+0x29c/0x390
    [<00000000d307d1e4>] netlink_rcv_skb+0x54/0x100
    [<00000000259d16f9>] netlink_unicast+0x1f6/0x2c0
    [<000000007ce2afa1>] netlink_sendmsg+0x232/0x4a0
    [<00000000f3f4bb39>] sock_sendmsg+0x38/0x60
    [<000000002f9c0624>] ____sys_sendmsg+0x1e3/0x200
    [<00000000d6ff5520>] ___sys_sendmsg+0x80/0xc0
unreferenced object 0xffff88813354fde0 (size 32):
  comm "ip", pid 1490, jiffies 4294907305 (age 325.364s)
  hex dump (first 32 bytes):
    a0 d9 dc 03 81 88 ff ff a0 d9 dc 03 81 88 ff ff  ................
    81 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000899f3bb9>] kmalloc_trace+0x25/0x80
    [<000000002da64724>] vlan_vid_add+0xdf/0x210
    [<000000007177800e>] vlan_device_event+0x374/0x760 [8021q]
    [<000000009a0716b1>] notifier_call_chain+0x35/0xb0
    [<00000000bbf3d162>] __dev_notify_flags+0x58/0xf0
    [<0000000053d2b05d>] dev_change_flags+0x4d/0x60
    [<00000000982807e9>] do_setlink+0x28d/0x10a0
    [<0000000058c1be00>] __rtnl_newlink+0x545/0x980
    [<00000000e66c3bd9>] rtnl_newlink+0x44/0x70
    [<00000000a2cc5970>] rtnetlink_rcv_msg+0x29c/0x390
    [<00000000d307d1e4>] netlink_rcv_skb+0x54/0x100
    [<00000000259d16f9>] netlink_unicast+0x1f6/0x2c0
    [<000000007ce2afa1>] netlink_sendmsg+0x232/0x4a0
    [<00000000f3f4bb39>] sock_sendmsg+0x38/0x60
    [<000000002f9c0624>] ____sys_sendmsg+0x1e3/0x200
    [<00000000d6ff5520>] ___sys_sendmsg+0x80/0xc0


