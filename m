Return-Path: <netdev+bounces-29411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD367783086
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 21:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971EF280EE8
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61526F4FF;
	Mon, 21 Aug 2023 19:12:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8A9C2FD
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 19:12:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC5ECCF
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 12:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWMShOae5lRi8o0uytn400TDArL58sKfzJaw8xSJzaaGl8FCTTVOhkrTiCRF6JJNPwTbQTaZ09p/MOQKCuwjTslvmwRYnML9f+1CZyn4RSG4+3tm8Prtcqu2+h4DM0j5Nx0/RLdnTzhAQXJShRGrOpAGkvEfGZpdXxMRE4QtsYhwT1IRUlG/RKVeSiU51Zpu+l1zcO4leLS6AYGgorml9dAogVyuaQrnRf95tdpMH44HgCYeVIszQoBnRKkMo4KeiON88Iy/fqfa526DrNRS9i4+H7eYIrPXhbn1Clc7rzcvukGnnYbJZRB75hf5HyBQmeUnu1hazjczz5vaq7zIbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPBwiX1P12UW0pP74KEMlk46ucVLXS96LSXc8MllYlQ=;
 b=Ckhmw7pB6er48z5UOeuYcngqB1LNlw60Oqa/c9/NBxjmJBdsnfFQQ98HsXHQ28tqSpty2k/uOvxvD7IGEgLxfybq4gGnVdvyA9StHTdxiWNmuO1HAMifp3FHMW4bG5P9msOWtOzxjgRWKXWJ8MZRZUuHsSvMKaSOlkWha7lo2Hd+21pXm2S5KgOySSwGutiCiPH8nCVDAX0bwZfpyQgEGBCHe6oJCHLaSlq+kaQxRlmVbNF985mjs6qJAsQRtXDt579esBK+RVPVvRbiG674vFERQIpuglJ+hOLkxdGSNR57vRK4fBYNqlmC2lgBBxjIibPZecMBVUE60Tv5E4JH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=mojatatu.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPBwiX1P12UW0pP74KEMlk46ucVLXS96LSXc8MllYlQ=;
 b=hkWiiS+lxGH6vtixoI5XIamPSt/SoSRKadL+JdYmOnwEobtFVX0DanREhSc3azx5EfI37TfJs9CGkr86mdyVYEHzvWw2bL3ndUIKYtPbc2HNHMolbAGdEGIJsNs2fkqzsaz2TV5lMNOcBnrrCEBss7z2MRo+xyMeZ4tXHuHnRuilhDd8ypDZvs7yQhEE8J1RhCJDG9jfL2axOHztbA8ByapJKOPaYHjsdkTdbqYjMk30CijJ9QYt+hq5VTGai/yoJhf7tEXbF/9GKXADOdBkxWN0SYRo1nBR8HWB1aQ1br1t5OnDhh2aYiQUkBt9fKYp+/9nCxk5buOuF8PD9PFEDA==
Received: from DS7PR05CA0022.namprd05.prod.outlook.com (2603:10b6:5:3b9::27)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 19:12:21 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::c0) by DS7PR05CA0022.outlook.office365.com
 (2603:10b6:5:3b9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Mon, 21 Aug 2023 19:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Mon, 21 Aug 2023 19:12:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 21 Aug 2023
 12:12:11 -0700
Received: from fedora.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 21 Aug
 2023 12:12:08 -0700
References: <20230819163515.2266246-1-victor@mojatatu.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Vlad Buslov <vladbu@nvidia.com>
To: Victor Nogueira <victor@mojatatu.com>
CC: <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <mleitner@redhat.com>,
	<horms@kernel.org>, <pctammela@mojatatu.com>, <kernel@mojatatu.com>
Subject: Re: [PATCH net-next v2 0/3] net/sched: Introduce tc block ports
 tracking and use
Date: Mon, 21 Aug 2023 22:07:48 +0300
In-Reply-To: <20230819163515.2266246-1-victor@mojatatu.com>
Message-ID: <875y586whs.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b36238-f289-470f-f61d-08dba27a8b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yOpvN6E+4eHX+FC7lDMlLeGNwB6eLPinYz2H063rjDMRb9QDLs4bMRRhiU0ZX4IqJv6Hh2jUtbqrmqllCu6Pfy+TD59Wfrg7BPyAKmvE+NZIDOrEHAGz6AfhQDa4ff/UBsZp2Xa2JbTeMbL1114vQPqdCmqnr1Ac1b7RMy7o1QgUtSwSC6ylKY9E6a5gbHSsrpEhJo34b7tcCyAYJdDETYOXAe0PkZIy6bsVD+xo7Uxd8UxmpYoL9hhe2Iy/HmxDuPi/7IK3AyWHpnda3p3Wq5rP4zdkvzDZNSXF2O0lLbKpmJJ6AjUT/I85+5yaqeSaXtIJYcTpr2RqwP7mXKT7UwE7cgUvmL24RNc/Wx4iiVOZe2BLnJGeqJlR+HQCUN3tg7zzihlZO4BfeqrB0C+MlvAirFBGWLx+QmcpP6kTr04jdl6JNczXpXsaRkpdjdD7qNc1hIN8BC7kLQ+i6x5Wo3weqjEBhlp5vlZeEceXwkgTQR5UXp0cQ0wxMy14o1fJrV6M7FQATiPj3z3nXBNW1v6QpIrCCYOVfXsx53Ih4pL2WbZ/9RMjHfHt35nT8wU2yf3EJWbstE0Ervaa6z5uMUml4bxdd/eFryedfIjfP4RsoDlhlumRfEpYsVeTPeflkyqdWFIZciSXqnYtznuPk74cG8E6ii2502Wf1USGgjIf515DDjTuv/OAjA/bjlCEfMDWCUqJ3vnpIADED4TP9Rq1HeXLjSS0kVnijVfDlIrZCnwBxZbsfL37p6uYSCFS
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(54906003)(6916009)(70586007)(70206006)(316002)(8676002)(8936002)(2616005)(4326008)(7636003)(36756003)(41300700001)(40460700003)(356005)(82740400003)(478600001)(6666004)(40480700001)(83380400001)(2906002)(7416002)(86362001)(7696005)(47076005)(36860700001)(336012)(426003)(5660300002)(16526019)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 19:12:20.5185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b36238-f289-470f-f61d-08dba27a8b18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat 19 Aug 2023 at 13:35, Victor Nogueira <victor@mojatatu.com> wrote:
> __context__
> The "tc block" is a collection of netdevs/ports which allow qdiscs to share
> match-action block instances (as opposed to the traditional tc filter per
> netdev/port)[1].
>
> Example setup:
> $ tc qdisc add dev ens7 ingress block 22
> $ tc qdisc add dev ens8 ingress block 22
>
> Once the block is created we can add a filter using the block index:
> $ tc filter add block 22 protocol ip pref 25 \
>   flower dst_ip 192.168.0.0/16 action drop
>
> A packet with dst IP matching 192.168.0.0/16 arriving on the ingress of
> either ens7 or ens8 is dropped.
>
> __this patchset__
> Up to this point in the implementation, the block is unaware of its ports.
> This patch fixes that and makes the tc block ports available to the
> datapath as well as the offload control path (by virtue of the ports being
> in the tc block structure).

Could you elaborate on offload control path? I guess I'm missing
something here because struct flow_cls_offload doesn't seem to include
pointer to the parent tcf_block instance.

>
> For the datapath we provide a use case of the tc block in an action
> we call "blockcast" in patch 3. This action can be used in an example as
> such:
>
> $ tc qdisc add dev ens7 ingress block 22
> $ tc qdisc add dev ens8 ingress block 22
> $ tc qdisc add dev ens9 ingress block 22
> $ tc filter add block 22 protocol ip pref 25 \
>   flower dst_ip 192.168.0.0/16 action blockcast
>
> When a packet(matching dst IP 192.168.0.0/16) arrives on the ingress of any
> of ens7, ens8 or ens9 it will be copied to all ports other than itself.
> For example, if it arrives on ens8 then a copy of the packet will be
> "blockcasted";-> to both ens7 and ens9 (unmodified), but not to ens7.
>
> For an offload path, one use case is to "group" all ports belonging to a
> PCI device into the same tc block.
>
> Patch 1 introduces the required infra. Patch 2 exposes the tc block to the
> tc datapath and patch 3 implements datapath usage via a new tc action
> "blockcast".
>
> __Acknowledgements__
> Suggestions from Vlad Buslov and Marcelo Ricardo Leitner made this patchset
> better. The idea of integrating the ports into the tc block was suggested
> by Jiri Pirko.
>
> [1] See commit ca46abd6f89f ("Merge branch 'net-sched-allow-qdiscs-to-share-filter-block-instances'")
>
> Changes in v2:
>   - Remove RFC tag
>   - Add more details in patch 0(Jiri)
>   - When CONFIG_NET_TC_SKB_EXT is selected we have unused qdisc_cb
>     Reported-by: kernel test robot <lkp@intel.com> (and horms@kernel.org)
>   - Fix bad dev dereference in printk of blockcast action (Simon)
>
> Victor Nogueira (3):
>   net/sched: Introduce tc block netdev tracking infra
>   net/sched: cls_api: Expose tc block ports to the datapath
>   Introduce blockcast tc action
>
>  include/net/sch_generic.h |   8 +
>  include/net/tc_wrapper.h  |   5 +
>  net/sched/Kconfig         |  13 ++
>  net/sched/Makefile        |   1 +
>  net/sched/act_blockcast.c | 299 ++++++++++++++++++++++++++++++++++++++
>  net/sched/cls_api.c       |  11 +-
>  net/sched/sch_api.c       |  79 +++++++++-
>  net/sched/sch_generic.c   |  40 ++++-
>  8 files changed, 449 insertions(+), 7 deletions(-)
>  create mode 100644 net/sched/act_blockcast.c


