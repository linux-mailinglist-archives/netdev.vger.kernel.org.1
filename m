Return-Path: <netdev+bounces-23603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6B076CAE3
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 12:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A8A1C21257
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A3B210A;
	Wed,  2 Aug 2023 10:33:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F011872
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:33:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815B94EF1
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 03:33:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XK9AoAx/puYxQhS2jcT5CYexHHNZhniF5m1T8V/+yxbn7OjpYuEZFrmILsDgo2tjj21UdHEtbCofLpyQf66I2Kj8y6T9KnOtlTCU4cH5IUwIUAG99K7dtDQaWCkH8NRhvc5HNNmDWWzV5tt/aSAWa3XtS4hxMufGwTisApS3euaCxf6AI5qmUhNGZ+C7pOTZtn0p6HCZCCTF9CIQk8G8MzbYmIROXlpKDwouxkCBT0H/aa3fa/Y4cG47ZTXL8NpjKktDqfxg1SLYaNSk/hBfeQpZovaexUxRoqAhilI/Gq78db2RqZ1QeSbLQhxo8ekilIH+BuJSs0tFxWdGF2uIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3Ojwd2/W8d5wqaEbDaKh5LgVxWbc6ixsXQCIqYi8zI=;
 b=hibxBv0/I2LhQeplPdEAtszrlGgUcoI2qnWByg/xsyqzfZKMY2FABwB1WoaY1q3DHKvN7vyVLgyBjh+uMzyLQh6rY70vqXMIsi6bg5eT328rG6nv2UF650PmQelswCgzMBXzh+75eNZ7lofw7aA+eqS+p+IR7ZJuE0x3L8kkJEFMPfx5noOiLLqVUa9CMH4S6wqzufdujbA5XXT1BEVXztYh6WQYZCZlsns3WJ7aPXiY7XStF+9egIgOBVfGpX11kPJH8Q47r8pdAb1dVG/SqdS5iknyLK3Qi/Ub0VTq5jLHVzJgs5TqOMyGmsMovYJvNNcUO83lPa6gs8ZHMZsTdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=blackwall.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3Ojwd2/W8d5wqaEbDaKh5LgVxWbc6ixsXQCIqYi8zI=;
 b=ctiKzVdnXNzKwqmFEfHWUc+Pu8FKQ6ydRpJBNog9fmxmg6ZntUtp/Ad7RSEmdUmoY5eCGs5TV8rA+3ul4sD/X1XX7ychUDxuH1G+ntGXEVA4794QYS3IflQYFgzqMBkenTCO95KzdCwDH2h4ob6ExSibSDUKUB2IK6WmtDTkLgFF77LFyRl3XbloXsFUxXZzCe637rHaZtIA4t7EyEI9zTuldVe98YsFZGkq9lI63kH5QPpab0YKWjYU8IDBkQEUyIi0XPyrsVbCvRJJGYzSy0Y0TQjCZ1yeTBwkjeYkr7dRulpgS9nF20pvCkKdLak+jK6dRsT1th8eraYtF9IQIQ==
Received: from DS7PR03CA0253.namprd03.prod.outlook.com (2603:10b6:5:3b3::18)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Wed, 2 Aug
 2023 10:32:59 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::4c) by DS7PR03CA0253.outlook.office365.com
 (2603:10b6:5:3b3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 10:32:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 10:32:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 03:32:45 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 03:32:43 -0700
References: <20230801152138.132719-1-idosch@nvidia.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: <netdev@vger.kernel.org>, <dsahern@gmail.com>,
	<stephen@networkplumber.org>, <razor@blackwall.org>, <petrm@nvidia.com>
Subject: Re: [PATCH iproute2-next] bridge: Add backup nexthop ID support
Date: Wed, 2 Aug 2023 11:55:26 +0200
In-Reply-To: <20230801152138.132719-1-idosch@nvidia.com>
Message-ID: <87sf91enuf.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d30840-25cf-42f9-b2f4-08db9343d780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p5pdV5ztjP8xwuwANu+zyTIreAFToBoq4Fdf8XRb8gssPs2cwk+p8WkIeykCa2O3QVRIXS1X0rDQ8SgPP74hBWm7IR8fiG/giVB0VcG5T9cTNqhCRL96ZbT9wZaJenmoSdrPxFPbVGOmeH2l9eU5tRhzpNFuDBBugPuz59e+cceUngYjmFjeMA/fh7Tj1UzRXnG9gBoo3a2t84+3aunh7E3JfHL0uVdaZly/JJb+l15mQ2LMGGBTwAkkvwxiZ5GIeVOfWaq1KOY6wZjRKH6OJyE/QEnnIz99Py53AH4uxjyiSDQ8cUnI862a16B4i6aww7k/WOn9zKf/K/4wCbDx3eOvFGQv83qe47g16TQyjl9k3E8PFcRIv3RMWB0qlQasn1S5fsGdiyrtplN+2RXnCaNusH1Dv3ph4LCAJUSIcOA2FXM9bIMGOfgAWVdO+nB/tH9KVhOzfGLoXE89ysKTbL0tVCpQuQ5H6DrVdOuXwikx/qrQeeuN2ZT1u+LPsi6VEfDZnS863XQoT5f1BqjoTmC6v9eColE0TVkKEo948qpX4gz5IFXQ3KVNPKg3+2nKjKsxsuFM/BGO0ncTc1IvFPNRLf6KCLl4H9PQaG37Ll/VEASil5VcbMGKfGlFrSKRHbirv8K62eDYxkvfpCoPpuTcHZ/XOxr2ZOpint8X1d9HWkekOP1amLyt+3yzwKnLew70XypTl1uhaaSVr/KVztf1FXvpy5xBI6S+yNbpn9fjSxyGyaaPoGezef8vPHto
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(37006003)(82740400003)(54906003)(356005)(7636003)(40460700003)(36860700001)(6666004)(26005)(36756003)(6862004)(8936002)(8676002)(5660300002)(70586007)(70206006)(6636002)(40480700001)(107886003)(2906002)(426003)(2616005)(83380400001)(41300700001)(478600001)(86362001)(4326008)(186003)(47076005)(336012)(16526019)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 10:32:58.9278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d30840-25cf-42f9-b2f4-08db9343d780
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Ido Schimmel <idosch@nvidia.com> writes:

> diff --git a/bridge/link.c b/bridge/link.c
> index b35429866f52..c7ee5e760c08 100644
> --- a/bridge/link.c
> +++ b/bridge/link.c
> @@ -186,6 +186,10 @@ static void print_protinfo(FILE *fp, struct rtattr *attr)
>  				     ll_index_to_name(ifidx));
>  		}
>  
> +		if (prtb[IFLA_BRPORT_BACKUP_NHID])
> +			print_uint(PRINT_ANY, "backup_nhid", "backup_nhid %u ",
> +				   rta_getattr_u32(prtb[IFLA_BRPORT_BACKUP_NHID]));
> +

This doesn't build on current main. I think we usually send the relevant
header sync patch, but maybe there's an assumption the maintainer pushes
it _before_ this patch? I'm not sure, just calling it out.

>  		if (prtb[IFLA_BRPORT_ISOLATED])
>  			print_on_off(PRINT_ANY, "isolated", "isolated %s ",
>  				     rta_getattr_u8(prtb[IFLA_BRPORT_ISOLATED]));
> @@ -311,6 +315,7 @@ static void usage(void)
>  		"                               [ mab {on | off} ]\n"
>  		"                               [ hwmode {vepa | veb} ]\n"
>  		"                               [ backup_port DEVICE ] [ nobackup_port ]\n"
> +		"                               [ backup_nhid NHID ]\n"

I thought about whether there should be "nobackup_nhid", but no. The
corresponding nobackup_port is necessary because it would be awkward to
specify "backup_port ''" or something. No such issue with NHID.

>  		"                               [ self ] [ master ]\n"
>  		"       bridge link show [dev DEV]\n");
>  	exit(-1);
> @@ -330,6 +335,7 @@ static int brlink_modify(int argc, char **argv)
>  	};
>  	char *d = NULL;
>  	int backup_port_idx = -1;
> +	__s32 backup_nhid = -1;
>  	__s8 neigh_suppress = -1;
>  	__s8 neigh_vlan_suppress = -1;
>  	__s8 learning = -1;
> @@ -493,6 +499,10 @@ static int brlink_modify(int argc, char **argv)
>  			}
>  		} else if (strcmp(*argv, "nobackup_port") == 0) {
>  			backup_port_idx = 0;
> +		} else if (strcmp(*argv, "backup_nhid") == 0) {
> +			NEXT_ARG();
> +			if (get_s32(&backup_nhid, *argv, 0))
> +				invarg("invalid backup_nhid", *argv);

Not sure about that s32. NHID's are unsigned in general. I can add a
NHID of 0xffffffff just fine:

# ip nexthop add id 0xffffffff via 192.0.2.3 dev Xd

(Though ip nexthop show then loops endlessly probably because -1 is used
as a sentinel in the dump code. Oops!)

IMHO the tool should allow configuring this. You allow full u32 range
for the "ip" tool, no need for "bridge" to be arbitrarily limited.

