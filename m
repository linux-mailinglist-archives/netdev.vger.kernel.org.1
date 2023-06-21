Return-Path: <netdev+bounces-12661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 570A07385C8
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1492815C8
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 13:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6782182B6;
	Wed, 21 Jun 2023 13:55:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FD21774A
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:55:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2103.outbound.protection.outlook.com [40.107.237.103])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B966619AC
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:55:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgjb/MZkpAy2MyVJJGYsok2Xz8YgGz6ajnNPmwR6XZWWYDJUPoNz0W6ak3zeWy5YogFPivbpe9rZLyzEu2Tq/+qX8l0tj8ppWz5K7bFVXZbsE5B29N42fX2t2OoXUVZ6uvN2zHlad7W4FJBsvySMmkaZ6ADJNcz29k3FIduiMXw+gMvhOGsYITeKJtNivgngjcoDoiLQm6mtf3iFDi0bFTTUsNGDp3FJ8c3/ZcwBpml77rd3int1UAYZRQucpx/dvuGLerIOM7RicBRCSCq88UU60oAegQr8hCR8hXOcGEUq6LG+7K06sZr35wdt5OB+RBjreaCgGEU8cOkT/409qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26BB3FiZbliY/xz28p72TA7jWLb/2rDXJA4hS+DyjSM=;
 b=VJZUKAoJFC1+70awoUW+bs44eLtQUxlc9saMTseTYJuRhq+9TMFYPTOLTPXbR6C49tBcnrWpvS9aGKJ9Wc/CvVqECLtdCXvub8bJ3JOO4IjJJBhrQk2y9vK8U+y6kms4o78KZT5hrC8zsy6xG6SpEN1LwrZAnyy3emk6nzY2Or1s2qEO0VQWSMR5FiGrhekteQduzwqPk/BInW6YnU8nKW+Au115Bg00VE0fMrC21yY81wrP87XuetY7AVK5lZRqT5YZbZoxvOX7aoMnuSa3myjtvCUL/XwIo2HIrlR46KVrvUYiZeS383QcCdInRfKRMwxU0RqRgm+Vzxij8eGjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26BB3FiZbliY/xz28p72TA7jWLb/2rDXJA4hS+DyjSM=;
 b=SEp6FoItBbfdTBOhAYFFzBPwIys40fcgUkE2HaFELv4f8kWNsmhjO7UsyIcsnNDccWM/D7O/TQ2Xi/tGezC3MfCAgxhsQT8sthDkvMZJOHnhipRmNIcpcTxumImarPDUo5Nx6xWx9h50827VtvBafMhm7oHqlvK7pkyXo1945gI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY3PR13MB4851.namprd13.prod.outlook.com (2603:10b6:a03:36e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 13:55:32 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 13:55:32 +0000
Date: Wed, 21 Jun 2023 15:55:25 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Wojciech Drewek <wojciech.drewek@intel.com>, jiri@resnulli.us,
	ivecera@redhat.com,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: Re: [PATCH net-next 07/12] ice: Switchdev FDB events support
Message-ID: <ZJMBTQaCbz/6PyPN@corigine.com>
References: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
 <20230620174423.4144938-8-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620174423.4144938-8-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: AM0PR03CA0088.eurprd03.prod.outlook.com
 (2603:10a6:208:69::29) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY3PR13MB4851:EE_
X-MS-Office365-Filtering-Correlation-Id: 060f8f0b-6d02-41e0-6380-08db725f2dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nZHHw5k/IwDuQwUiyHJ2I4KBdg4JW0vIni3RdyqFmkH+YhVbhHKUBBOnyz31XH2Lsl3DakSCr9/KghIXhH8WIZfFr1TwO+kIZEq7tvieQGIJaSkRuUQpoxdqymAODawsjfrapX+decCGrIXtawMyjtdF6X+9NyCfuRWGe4iGfuJCKNmAbluAC8WmRInkK8lzSYKxBXiKv7fdSI2HxpZQtX/IC95lRefAG+9y03790lYPsDy/+d+uOBCk5ThCLzSwgknPmCxBunOnR0jyrz5U6TdheKRv0nbtNcBNIyTf9SmJdqChAv7yGqlcPIijUfdyNlKVjctbZoXG/QvkbNEy9Z9GrO/bhLdHb+XP19gE7lTuJ0HO0ln6PXyQT6v/hbgY6wYrWQvRMGDmTpVwiJsreQfRjQbuBE7UVbggttcKSh124iwl9Gr708m4+phyWLa5rqdIi6rGcAFsa5pMnVrlJgh3EBRIBgbkqCdIi/o+zxizGqjmQSC2rugJTH5gCOYfmsJC3JuhubouyMkOOU686hPW8lchAgtKvzU0wyStw+bj6/37mn7LsWaaarPXacSqAcaA0EJyXaEhWSJ+HIarMOFv0QTvXPoQjGha/PxWgUo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(39840400004)(396003)(451199021)(7416002)(66476007)(44832011)(66946007)(66556008)(6916009)(4326008)(316002)(41300700001)(54906003)(8936002)(8676002)(2906002)(5660300002)(478600001)(6666004)(6486002)(6506007)(6512007)(186003)(2616005)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kZTSxNZeu43gfODBCE6/c6Nu5xvt03KZLHheLUWWU3BHi6WRhcubs2004Ipk?=
 =?us-ascii?Q?hFDg5gtrfS0PiHnwsVAq26S1ifgTBnc/lnkeo7/rBQIvYldkDEG/WX5PyHjT?=
 =?us-ascii?Q?g2BygObYPlJ9KdJ8bYckisxJvBp1z0M5COupRZcxVqWo8niGUpBTqKN0qEm0?=
 =?us-ascii?Q?VaNqHnr8O/W5i5Cyq8ahDlVIw9h+ImxA/jNtO/yCaYEusJj2JLv1qU0bwQ07?=
 =?us-ascii?Q?ZNT88KGBG0QXFSgEoJeIws+moXTqxzIoQTVlWhoeWqJHCz/1njeHKdhSBx7e?=
 =?us-ascii?Q?4fsaPRYENnmoMGPVhCukvvDxpY+octnhWAr9cMpdTu1g0GVCy1R9acrlyYNG?=
 =?us-ascii?Q?QEKOXeYsO7z8TkpAzWC4XAkqqbf6PXGI2h8ZG5H/MAcne/0vH7em+GF8Z2F7?=
 =?us-ascii?Q?1l0AjYK8K1poMTWAeGuK+ohJ0LpTo3HEBb3Ew5dfjGINorYgHE7NBpfwh27H?=
 =?us-ascii?Q?cP/7guxy72SnFYiE2WxMR0zaCRNQsPh7+y1vMw53XXbP20TDkDTVcD8n/036?=
 =?us-ascii?Q?TrN1GxL1BvqyRwjzFTdwrws5ZeK6opCTsSpVYwJC/we9EtrkS+OVO8sM/J1m?=
 =?us-ascii?Q?JC181Fk4nl21dC0YC/n3jYb6v03nFzGJD39xR+Kk8KZXlGt79OTwvO4KC9n6?=
 =?us-ascii?Q?wsutbdk9LQWDD5nZw61tMNOxEkKbGq6g/l+7YD8w4fhewKFNxe1gJ4itZJsL?=
 =?us-ascii?Q?SuQJSmujQEm1PDmLGzCgd8IilXAAlyhFTGaTKmBuAfsP36twan53Ix3xIUfU?=
 =?us-ascii?Q?aFAjI7o9utXxqSxQnE+CpvqsCfQILjp0iQRlrZkIbi31U97niDrxRCz2Exdf?=
 =?us-ascii?Q?por+cZuRqT2S0W45M/j2vISQ0jQ075qiDyQA6G4fQMQHFFWdaZ2AMHs4m/5A?=
 =?us-ascii?Q?yhwOupWH5v+ww44vvyLavZ/6pJGxCQxwd5tyUTn+Pb9VC3WYAMX0cnWr8m+p?=
 =?us-ascii?Q?BH28u8TcHathTZC8Gf+fVFQY2LOqpRhzcd0k7CDx8lCTLHCG/2S/MJUNmwzG?=
 =?us-ascii?Q?qqP2/vPSXlAhj6kxazcgOXGmdlUrSmdzCsrzWh08vla91yLeYzVAyf9sE0Tk?=
 =?us-ascii?Q?mNd9EcrDCBJU+AaSW18r+lnGHYxWa232/N0n/Qvfux8oRJsw4hJwtEhdTHVv?=
 =?us-ascii?Q?Pdhu/sxBexM2uW3xJQXPSMB0kzGN4KgQ5QkjZXWz1hPbfhQ0TQ+znUBYsrT8?=
 =?us-ascii?Q?pQXmowxT/jzPKbXcxBtX/TWgpdenK2nayziTXxkbnNNoLeIKGJkBT4FN2grt?=
 =?us-ascii?Q?0g3owLtV9BeWJYDfujay5qYikh97eoJvWIQFKN7SqntvdYSuLpFv8FgLCh9Q?=
 =?us-ascii?Q?8qtZ2hPIDbWdYoj6AqChxAGiWF/kj9chNRuM0z982agrSVTuzo2M4Le7E1QD?=
 =?us-ascii?Q?El/OVJN8TyvGvOHAow+iwsQRihrZbaeuUfztMwenHmpSSiMjhisqr8u+p1M2?=
 =?us-ascii?Q?4GtD0K6G99qKAhO3hBiawbPWrSASBhu59XUWezgjpzr3F9IG1CSu1FyTqZuD?=
 =?us-ascii?Q?Y4AYKIm17ocxc/3bydZWzj7vieZv1rG9xq0BTczTtRTe0zWyFut3IKP8n/P0?=
 =?us-ascii?Q?Pgpb18zmgkNVc5hGGzyhaIfbW8zXrc4WtzCrysd/QqUZjWbXQB4LXWnFRj+o?=
 =?us-ascii?Q?fzXeMgzMnDxvTEIcTI/T3+hqvr4SJfCTzvgWzYXA3985RPi5NRcbLyAxMbbd?=
 =?us-ascii?Q?DGyFHA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060f8f0b-6d02-41e0-6380-08db725f2dcd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:55:32.3042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWYqheaT+lCv+fHZMNvs+8fs48nTJEK36OA/ORjjfm/0oJriIapmkuwSA/9yDZ7mx5/+SKklnQ60lKOtsGFlxlicDWcNh7lB1rZKH9Id9b0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4851
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 10:44:18AM -0700, Tony Nguyen wrote:
> From: Wojciech Drewek <wojciech.drewek@intel.com>
> 
> Listen for SWITCHDEV_FDB_{ADD|DEL}_TO_DEVICE events while in switchdev
> mode. Accept these events on both uplink and VF PR ports. Add HW
> rules in newly created workqueue. FDB entries are stored in rhashtable
> for lookup when removing the entry and in the list for cleanup
> purpose. Direction of the HW rule depends on the type of the ports
> on which the FDB event was received:
> 
> ICE_ESWITCH_BR_UPLINK_PORT:
> TX rule that forwards the packet to the LAN (egress).
> 
> ICE_ESWITCH_BR_VF_REPR_PORT:
> RX rule that forwards the packet to the VF associated
> with the port representor.
> 
> In both cases the rule matches on the dst mac address.
> All the FDB entries are stored in the bridge structure.
> When the port is removed all the FDB entries associated with
> this port are removed as well. This is achieved thanks to the reference
> to the port that FDB entry holds.
> 
> In the fwd rule we use only one lookup type (MAC address)
> but lkups_cnt variable is already introduced because
> we will have more lookups in the subsequent patches.
> 
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


