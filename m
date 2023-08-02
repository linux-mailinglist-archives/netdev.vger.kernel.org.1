Return-Path: <netdev+bounces-23628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E981A76CCAA
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 14:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F06B2813ED
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 12:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8201C746C;
	Wed,  2 Aug 2023 12:29:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EDC7460
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 12:29:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ADF2701
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 05:29:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSwZmZ+t7cH837oc1TyVCWkM18ro9GQYb1zztF8Dx6DIyboPpgoId5an3ORnNiBDjkCsLl8ssAyPs6V7jhzw8aKWL/NlgXdBZc1ecMIKEn35aFTBKxX6IXckjA4l1ZfEMX1SK81A2cYUAcuzgUCVvt4mJs/S3cp0PzzQDc3dupP79csXll4uSF3KlEc2+L0Zj2usaNE9QV8osD3mHKzb1q6xk1VInEiEUISq/4cIzs2F1Ua1QZPABn4XVPuNCJiv4nMzfp4cdb7vX7ZY/QsAmnh0Ca7llDVOLTkwJMVdqCIgxaOKV1NxYN+aNEhqaphK9z+ZnWL1Jc/qvOqD+CqVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8etVXdKUot8uUtzNJNRjC+NttcW47b51HNFfv5LtaY=;
 b=LpTVHi31B1Ggk/kyz+5UIb5fnjP0kS+pmyOmqxSNAl80/STI8mufEGV98Lpq+uGCU/+BfG2TxcKPm6aO+GmU0rsoxdN9bysASbiUI7c6nXMwo3/w9UdImg9g/dif4u44iLqr1GFY/diDfh2DAiCwCrfChp8VcwUuT4WF0/zxuLGR706JhpL3nym8c7DRrMw4HsUUZ28PG5cnrckmLTY+oiBXExbOklU/ODvzzreZmSCMPWSbqumLpvFkZ4P/vqCtd9EMDg55GhWiGKmE3fxXzTPOC2SzZt+eEWiadIspLG33ZzN7jVxUzWZZjQxGLsnWf1CnLRRtCVhC6LRRrCk5Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=alu.unizg.hr smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8etVXdKUot8uUtzNJNRjC+NttcW47b51HNFfv5LtaY=;
 b=e9AUR+vka/SuBFGHJKo0wQcmmIsZx1VgY8OR+2HKpYsYkl0NVqGuSl+uhUgyi0gmyAIZe3+it8S8gyxLUaCkS1Qz1b3ZORIu4EmV7TBmTkBL3yu4UmZIoex73W+BLaBhxJFeAkss7+Z69/I4tZ5qDRRgEcBeawuBGq5oGwImPDdzVOY61yV53mwrmc8r8e5qZWl68c2rg0hCQjYS1uYajVQC9x0wyF3WWOs/n6PZ17Mg77v+vit5eDNLwoBeYxlD+2/tCIvEup/MAOtSlpnAQ40h8dxdUPucyKTMWFRaWvVPfkU9aFy7W6xVtrGmXwDf+oAeElzIJCvJTkRgsucr7w==
Received: from DS7PR05CA0029.namprd05.prod.outlook.com (2603:10b6:5:3b9::34)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 12:29:39 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:5:3b9:cafe::76) by DS7PR05CA0029.outlook.office365.com
 (2603:10b6:5:3b9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 12:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 12:29:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 05:29:24 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 05:29:20 -0700
References: <20230802075118.409395-1-idosch@nvidia.com>
 <20230802075118.409395-11-idosch@nvidia.com>
 <20230802105243.nqwugrz5aof5fbbk@skbuf>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Ido Schimmel <idosch@nvidia.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>
Subject: Re: [PATCH net 10/17] selftests: forwarding: ethtool_mm: Skip when
 using veth pairs
Date: Wed, 2 Aug 2023 14:27:49 +0200
In-Reply-To: <20230802105243.nqwugrz5aof5fbbk@skbuf>
Message-ID: <87fs51eig3.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DM4PR12MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a2d6566-75ab-4086-9a2e-08db93542410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TxrJ2CC6ErmX48oVaISnFfvvq9d7NUjm4YgNw6DIm0vxo1bH7c+T4/vMoG7EAomdmKXKCklZloRgClKdTH6lHulXhWdw0pigICL09hbFLKwBa1YR3BW0bxWICW++xqij/IyZEzINVZhn0tvehO6fXcLCLBPJY95yGIIvWjIk559uOwkXdae/Pk/XO6fWHHOJ5Z+gYJ31ix3neiwPFh3+ayisYbgBMUEkRuwQ+D4AlzuGcvUNplJ0WYZy8bixNfRsDTnimOu60mIc3FQAOlv5hJgILYoqq7DXty7eph3aT4FzNwbwQWqg3FJ2x5YDv2cPKjw0Txov8xsGOJ8k5GF/pemqOa2/x/YJLJvnlhgIiJVilqc+v7FoJz5/16FrswC/yrIbqN+DY/9K821M7YgnKqoV4Adw9SkCNytJay716AspLQDYBzJB82f8BsIW25e56XdI7s5q1rF+dCcsTReVk6mgdBHAJqjxF98L4J3c8O6UtxmvExPtpuDI3FtcSTwdBVHfU0EnireaOkYy5yuDfDo1T7wn2Y9uIUoV31LiHytBmvAUxp6Eq4aXJTJ+s8X16Ic95R3hA516zQz4CPdzn3jbAFi2wt1DAP/+Dy4Hc2mnX5UpFU0P8kQvD2/sVxbeQDXQd+GyOrtr0hdSOkgye3sCAN49ub/pDkAP76GLKkm4FMhiRh4wxgAcDnvL6ehekuWjPWyO3QG6d+v80LatZCeJOh2TflCXSwl6BIFLFUZq9jvPPsKZXyBInxH/W6WVhBtIE//vUEALW5VJlsCsPMojPv33F7EgZdFlOI3KZuI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(8936002)(8676002)(426003)(47076005)(41300700001)(5660300002)(2906002)(83380400001)(36860700001)(40460700003)(16526019)(2616005)(40480700001)(186003)(336012)(86362001)(478600001)(7636003)(54906003)(316002)(356005)(26005)(70586007)(70206006)(6666004)(82740400003)(6916009)(4326008)(966005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 12:29:39.3254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2d6566-75ab-4086-9a2e-08db93542410
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Vladimir Oltean <vladimir.oltean@nxp.com> writes:

> Hi Ido,
>
> On Wed, Aug 02, 2023 at 10:51:11AM +0300, Ido Schimmel wrote:
>> MAC Merge cannot be tested with veth pairs, resulting in failures:
>> 
>>  # ./ethtool_mm.sh
>>  [...]
>>  TEST: Manual configuration with verification: swp1 to swp2          [FAIL]
>>          Verification did not succeed
>> 
>> Fix by skipping the test when used with veth pairs.
>> 
>> Fixes: e6991384ace5 ("selftests: forwarding: add a test for MAC Merge layer")
>> Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>> Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
>> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
>> Reviewed-by: Petr Machata <petrm@nvidia.com>
>> Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>> ---
>
> That will skip the selftest just for veth pairs. This will skip it for
> any device that doesn't support the MAC Merge layer:
>
> diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> index c580ad623848..5432848a3c59 100755
> --- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> +++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> @@ -224,6 +224,8 @@ h1_create()
>  		hw 1
>
>  	ethtool --set-mm $h1 pmac-enabled on tx-enabled off verify-enabled off
> +
> +	h1_created=yes
>  }
>
>  h2_create()
> @@ -236,10 +238,16 @@ h2_create()
>  		queues 1@0 1@1 1@2 1@3 \
>  		fp P E E E \
>  		hw 1
> +
> +	h2_created=yes
>  }
>
>  h1_destroy()
>  {
> +	if ! [[ $h1_created = yes ]]; then
> +		return
> +	fi
> +
>  	ethtool --set-mm $h1 pmac-enabled off tx-enabled off verify-enabled off
>
>  	tc qdisc del dev $h1 root
> @@ -249,6 +257,10 @@ h1_destroy()
>
>  h2_destroy()
>  {
> +	if ! [[ $h2_created = yes ]]; then
> +		return
> +	fi
> +
>  	tc qdisc del dev $h2 root
>
>  	ethtool --set-mm $h2 pmac-enabled off tx-enabled off verify-enabled off
> @@ -266,6 +278,14 @@ setup_prepare()
>  	h1=${NETIFS[p1]}
>  	h2=${NETIFS[p2]}
>
> +	for netif in ${NETIFS[@]}; do
> +		ethtool --show-mm $netif 2>&1 &> /dev/null
> +		if [[ $? -ne 0 ]]; then
> +			echo "SKIP: $netif does not support MAC Merge"
> +			exit $ksft_skip
> +		fi
> +	done
> +

Ido, if you decide to go this route, just hoist the loop to the global
scope before registering the trap, then you don't need tho hX_created
business.

>  	h1_create
>  	h2_create
>  }


