Return-Path: <netdev+bounces-23659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C8876CFFE
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 16:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730E0281DFA
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 14:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF848468;
	Wed,  2 Aug 2023 14:27:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B7279CA
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 14:27:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A18271C
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:27:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrqLyi+0omi6DuW0FZMoRJJMSQ6LjH15lQroL+ay+WrgbS5WiJiJwh8xJtkquCqLWD5sspgR1pkfiaYfwwoO4oU64tsAW7ytbkfP4WBrAMJlkvDPp1wf80iHPDBEdAoRHRD+t4SXiIK5bv0Yn3h3M1mLlh8w2QZXsHaJsE+r2JZmIO54JkOeSIV2WBaQRCksBEG3qjxXvHPkV3qaKZAGF5Q8AOVmpiq91SHVO43NW2GmH+D9FCZZDq4WKIFOLRB6OCnep8fVvLX9IzVYCNuVHJFlfL7rRtEYTNIEf9C7c2WcXD3H6X+b+TyV3oECETBGZyMxiZHLpyQRe8FxlEi4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xT1H1WeXRYy88Don2Bxgaudrc2nM2Sx+JlJ+GK1gGhM=;
 b=A/FKe4PiA+IU6NjoQe48XjKKIDrmNRz923EmmxmUtYRzHOo71NrDPpojPN+AdXmSbT7Bp1KIkqaSMxkLJNFIuE0+oP5Ofu9qiDejREuBXL6PPi6uXGB8VdcOsF+f3d+osmyeMwB2E8wHdTTI45P9qfVRP4s67cuH9SUiypZ6mGQcq8qjZVbMDlqd6rGYBSrWq6j+7DMAVKHFSyIG/XmhOKbf0UJ4IyHUyE8def5GsZHQt0pBB8ojlEYstaA9xSSvA5IX6XA+DVn7c3KFn+O+1dWwctFUg03F6mXZVmBdJ/IsHNidEixXdJlfkSjHJQmanEaW3jn6orUyJpVAOobFOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=alu.unizg.hr smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT1H1WeXRYy88Don2Bxgaudrc2nM2Sx+JlJ+GK1gGhM=;
 b=De8Ak59kskmNFAhcX16nYtzAnJ3VokZKDDp+UVCQ8nQUtcLQKG22OXeLo/Vu/uM5Mv1COEzHuIJkFOsP9NZLFY2LUGHxft3Bl3Is/6705TxNKvE+DV5uebVwIrgoe7Z/AwnR7e/iefQM+4a4K1RUl3Qnoz+IzYdUEZ/u2kTPONkyIJOvA/B/kvMF+0w/QEHhz+xypuhgMRlYIq/hn4TWYhn6dha2hoDgdi3O99QyEf9PUSoJ5me/MQFIRuLVoQrtEkzcr48fgo1ODtfNaHXq7QttcforxxUpIQeytLPet3wqjWAyJOjRKLUHQotS66ocyqxluOmMq2Rk82Vr7oEWSw==
Received: from MW4PR03CA0293.namprd03.prod.outlook.com (2603:10b6:303:b5::28)
 by DM4PR12MB5793.namprd12.prod.outlook.com (2603:10b6:8:60::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 14:27:00 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::7) by MW4PR03CA0293.outlook.office365.com
 (2603:10b6:303:b5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 14:26:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20 via Frontend Transport; Wed, 2 Aug 2023 14:26:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 07:26:43 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 07:26:39 -0700
References: <20230802075118.409395-1-idosch@nvidia.com>
 <20230802075118.409395-11-idosch@nvidia.com>
 <20230802105243.nqwugrz5aof5fbbk@skbuf> <87fs51eig3.fsf@nvidia.com>
 <ZMpadrHS4Sp3zE9F@shredder>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@idosch.org>
CC: Petr Machata <petrm@nvidia.com>, <vladimir.oltean@nxp.com>, Ido Schimmel
	<idosch@nvidia.com>, <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<razor@blackwall.org>, <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [PATCH net 10/17] selftests: forwarding: ethtool_mm: Skip when
 using veth pairs
Date: Wed, 2 Aug 2023 16:22:35 +0200
In-Reply-To: <ZMpadrHS4Sp3zE9F@shredder>
Message-ID: <87y1itcyg2.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|DM4PR12MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: 1396dd87-3125-4803-8df3-08db93648841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bFLmXadRHAWDODvm6qei5Uj8YZCA2bHG/RiHvEVyKh8N6ooX4cVrWXu3EPKPWR7FXTGLQ4xiAC+XgWzRreDLqN9qQ4iML7u6yO+wKV4rsVuACorJ/wZxuFhCs6xnFVSFpGbgU9G9UZNjUXNectY17cBp6WLisFUjVeh+D4nhjByIVgz0YKzK39J+C8zo5a0CvUs/UbOs7M6t8DsqWsXk24lItjiYmH449Dxr859gvTq9aBo8w3f/pmQdrZT4wgVslcMld07P+8TrdbNXnTCx6pB5sjYapWClSdiPM13Xrvw/topOo1TGUL+pC980KVt+X7wVDZzxRBuDQC9DkJ3paVyphVKS4Ql3D3MJD5uSaO3eJ3Ltl+Qx0f14qgeaRmA4KWShfBuzcYYv0DlqvfpH5Icy8v4PjN3qN8cyF1OiCukeVWiWmDPEdd9UCTW34xkrX64KvVyZvqOc+4etc6NYCxPoaDbX4b4go4EgKiQfuMO5Dk4TEVBw1W4lm8TK/pW0EqKdnZSs3jnbY4WiQ2c7FiDkePNcrM8RHvIrS2oHjLfWClh/eh4yeSPi6GbWLqTS8awaEM+FFaTd8qX5Hak4S/gB2EJnUQELZNFsP71re3i7mJYHGFFQFN1Wli4S/SSV7ZNnJz/ArQKb5L6BARUc65oZpTl/Zl+IrwjKeLvFke0Jf34TK4WLzgBBqVLHUmk29kPLjzwWd+/Ndf3uSIYo0YniJMjvp1iQma/v7If72h0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(8936002)(8676002)(5660300002)(426003)(26005)(41300700001)(36860700001)(2906002)(83380400001)(47076005)(36756003)(40460700003)(336012)(16526019)(2616005)(40480700001)(478600001)(7636003)(54906003)(316002)(86362001)(82740400003)(356005)(70586007)(70206006)(6666004)(4326008)(6916009)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 14:26:59.3504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1396dd87-3125-4803-8df3-08db93648841
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5793
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Ido Schimmel <idosch@idosch.org> writes:

> On Wed, Aug 02, 2023 at 02:27:49PM +0200, Petr Machata wrote:
>> 
>> Vladimir Oltean <vladimir.oltean@nxp.com> writes:
>> 
>> > @@ -266,6 +278,14 @@ setup_prepare()
>> >  	h1=${NETIFS[p1]}
>> >  	h2=${NETIFS[p2]}
>> >
>> > +	for netif in ${NETIFS[@]}; do
>> > +		ethtool --show-mm $netif 2>&1 &> /dev/null
>> > +		if [[ $? -ne 0 ]]; then
>> > +			echo "SKIP: $netif does not support MAC Merge"
>> > +			exit $ksft_skip
>> > +		fi
>> > +	done
>> > +
>> 
>> Ido, if you decide to go this route, just hoist the loop to the global
>> scope before registering the trap, then you don't need the hX_created
>> business.
>
> I think the idea was to run this check after verifying that ethtool
> supports MAC Merge in setup_prepare(). How about moving all these checks

True, I missed that.

> before doing any configuration and registering a trap handler?
>
> diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> index 4331e2161e8d..39e736f30322 100755
> --- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> +++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> @@ -258,11 +258,6 @@ h2_destroy()
>  
>  setup_prepare()
>  {
> -       check_ethtool_mm_support
> -       check_tc_fp_support
> -       require_command lldptool
> -       bail_on_lldpad "autoconfigure the MAC Merge layer" "configure it manually"
> -
>         h1=${NETIFS[p1]}
>         h2=${NETIFS[p2]}
>  
> @@ -278,7 +273,18 @@ cleanup()
>         h1_destroy
>  }
>  
> -skip_on_veth
> +check_ethtool_mm_support
> +check_tc_fp_support
> +require_command lldptool
> +bail_on_lldpad "autoconfigure the MAC Merge layer" "configure it manually"
> +
> +for netif in ${NETIFS[@]}; do
> +       ethtool --show-mm $netif 2>&1 &> /dev/null
> +       if [[ $? -ne 0 ]]; then
> +               echo "SKIP: $netif does not support MAC Merge"
> +               exit $ksft_skip
> +       fi
> +done
>  
>  trap cleanup EXIT
>

Looks good. These checks are usually placed right after sourcing the
libraries, but I don't care much one way or another.

