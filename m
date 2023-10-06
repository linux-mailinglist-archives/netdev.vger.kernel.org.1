Return-Path: <netdev+bounces-38528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339487BB533
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C682821DC
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 10:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC7DC2D7;
	Fri,  6 Oct 2023 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uMyPnk5a"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EC223A2
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 10:30:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D22BEA;
	Fri,  6 Oct 2023 03:30:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzqHl25/baY23q9dZipCkR9QGlXyGDCjMnYj61eWTfHtoWiMOL7lQA7hZPOGayzNyEmfNVsi0dYP/KaA7qXMR3tRk75tPzh6h8YHnl0Hqiyi63hKNAQYiDqq7WNNkVLoBBCFyv4IjBJNFi87rhY/9Yg27KaobWO0PKbizT4RLM3oYFVa+Sut/ihnahGenudswDyGqwrhkNjmm3CgI59gqKhD8JEdojKKz1U+Qizpm3+nV+o63s136eypr3JawOyAmyuiMsTUY382SbfUAnTjjTyK6P/oG2vMja3LbGoMJejIXr4jNTjSGh7qncW5pYguo48zcdu/0IYBRAlP5Xsxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1Asc2iTBpjxais0K515wEDZiu0j64oaARyaM69U8aw=;
 b=Ni88NWaVWit9kJ8X+CjCHkoAayjd5Dcq1VzsfVeh32Dx8ilY8dpxc2qzg1vQRc6zy2X3nEg39VKa0F5PGwezJ0ronBCZduuIbgPhItCyIcFzdDAw/95tq63vZTpUfrUEGBNu/NvW5gt+DDFyEZ7woA6u93YyoiYaUbImk7ZUT7m79ZMzp/y3CIfZnP+Yr7FvbxN1mVtO5XbzgoZP2a9bIIyUSKP8X2/BAkEcu71i640rP68S9vEVEfbuAQMtx7gy51kMG7yDiqIhajFUJtNA4mHpkcd646DKkGKWRYlNa9zjfLS4I+3L/rO+/cCyWasRFYctrw6TZ9sFlNuFSwzkSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1Asc2iTBpjxais0K515wEDZiu0j64oaARyaM69U8aw=;
 b=uMyPnk5a28UujnrDf1WyZfqG6PN6pDNGp6bgz2thaTx1/f8cb/0D8Ljg93ukBKa3qbu++4lFeO4re8exdysg7d+7cJvlR1HyCgDYV02D/SrWY11FOiy8Tfr1rXlek5UYSggbX54zu12OEq0qV444M3eFJC4pn8l3hWfHqZ1GEvfqHmDk/Vwt9OKx3l+GXViqJndM7tT9OqajC3BZ/rN1ZEsSkZIcE2Ta3+tC2welncqexup4Xq7fPl0j8fXhsmebSCigllPIPGoN8Fqdxeg8bKxkja5k1371GM+gpXleNyaBkyH+niU+1acQpzwBn/F16NCw5qVrr5TAD2UtFnXBaA==
Received: from SN7PR04CA0014.namprd04.prod.outlook.com (2603:10b6:806:f2::19)
 by LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 10:30:11 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:f2:cafe::4) by SN7PR04CA0014.outlook.office365.com
 (2603:10b6:806:f2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37 via Frontend
 Transport; Fri, 6 Oct 2023 10:30:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 10:30:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 6 Oct 2023
 03:29:59 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 6 Oct 2023
 03:29:56 -0700
References: <6b2eb847-1d23-4b72-a1da-204df03f69d3@moroto.mountain>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Ido Schimmel <idosch@mellanox.com>, Ido Schimmel <idosch@nvidia.com>,
	"Petr Machata" <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH net] mlxsw: fix mlxsw_sp2_nve_vxlan_learning_set()
 return type
Date: Fri, 6 Oct 2023 12:19:43 +0200
In-Reply-To: <6b2eb847-1d23-4b72-a1da-204df03f69d3@moroto.mountain>
Message-ID: <87fs2oqc0u.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2c9f28-bf47-4ae9-ad74-08dbc6573865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hsUKFwn7wBBVhxyzrJkWz/bHtc5E3qK2hlLx5wNmqAqfvJ4jXFbYMPAae8ybDBsUTVk/wy6pB4s0D3OggQof60xx76MrfugLWMhLKC7F+6PGj7DFKH00OpvrpLXEWifkuukNj5GZRJ9kKQ6gtY5Z2hEF54A/YM0LDJij/+HcSmebbkeOj8yoZnI41EZ1A/ml6SYUJc6zKW/kwKEJPo0WUQaNsm1OKFrGVvZSwwdu2A/Aq3npm86ytBnODZGQxNXEp3r99vn+O9ZgHqDSQTFlMQ9ZjyBz3YVl8DTOJRTxEc4mM8PvpnvTGMQoMQfkAkScTd+P0L6UlMnMx6cVPCT1m9DATZHJKZWkgadg4wzES3nK/p3IeMN5pYFUs/0WAw5xyVrIohAc2Pi6kQy5XhZIro5m94PpbdkGsLAMhlIQO9JF+lyWKIi2QoizLBGvU/AU0+6gl2wbGQUjiHY+xL0pjjjVUJ5OhGZCpXhGCy8WLJHxzQtE17zfiMG3/St2w+BueeuWq25QQGLLi+RElh5TdWLkExEqH3SAmFsrKJDFivokR7gMa/MiY/VlaNa2JdPYbcsAp7LpJJgcCc9EXLU5MBZuP2/HCy9SriZbElzpruUJickAxo7Rgq9Md9fiRIf2cv+fwz0s6KyhQ2qkJsL+/gxSIfCdx2TQKYmN42gNLeMhfScYMGqXl8/93Ah8JaZwVDpKvqRRCxCVzCEltrmV8rEQ73VMj42Pt2+0q8/kFn6laVUgtoieGJ8vELgthIYB
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(86362001)(2906002)(5660300002)(8936002)(8676002)(4326008)(316002)(41300700001)(36756003)(54906003)(70206006)(70586007)(6916009)(36860700001)(47076005)(478600001)(83380400001)(7636003)(6666004)(356005)(336012)(426003)(40480700001)(26005)(16526019)(40460700003)(2616005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 10:30:11.2292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2c9f28-bf47-4ae9-ad74-08dbc6573865
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Dan Carpenter <dan.carpenter@linaro.org> writes:

> The mlxsw_sp2_nve_vxlan_learning_set() function is supposed to return
> zero on success or negative error codes.  So it needs to be type int
> instead of bool.

Yes. Vast majority of the time the error code is 0, which converts to
false, which converts back to 0. But for errors this gets sliced to 1,
which eventually percolates to notifier_from_errno(), which yields
NOTIFY_STOP_MASK | NOTIFY_DONE instead of encoding the error code,
masking the failure.

> Fixes: 4ee70efab68d ("mlxsw: spectrum_nve: Add support for VXLAN on Spectrum-2")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

Thanks!

> ---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
> index bb8eeb86edf7..52c2fe3644d4 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
> @@ -310,8 +310,8 @@ const struct mlxsw_sp_nve_ops mlxsw_sp1_nve_vxlan_ops = {
>  	.fdb_clear_offload = mlxsw_sp_nve_vxlan_clear_offload,
>  };
>  
> -static bool mlxsw_sp2_nve_vxlan_learning_set(struct mlxsw_sp *mlxsw_sp,
> -					     bool learning_en)
> +static int mlxsw_sp2_nve_vxlan_learning_set(struct mlxsw_sp *mlxsw_sp,
> +					    bool learning_en)
>  {
>  	char tnpc_pl[MLXSW_REG_TNPC_LEN];


