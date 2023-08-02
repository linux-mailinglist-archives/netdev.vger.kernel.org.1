Return-Path: <netdev+bounces-23654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C720776CF22
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEEB71C212BC
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 13:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D9D79CF;
	Wed,  2 Aug 2023 13:47:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3246F746C
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 13:47:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B8B26B6
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 06:37:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iW+9GrrRAbM9qEYZywHZ3lDkA1hRb86AkJbaSqTMbENO2YOa1M7e1P8hsZaJMPCYwSs14zBDA/7X70nPJI5HDUPhVhLkS5/rmelFeNkwCSCuV0rcsoBzluUPsCaPXsIuQnPrzt5yU9KX3giZRBQBT0neOaylqJiD/HYdjlv9Ah04hiCr6GwykQiV5phHdqmS0ynAoBJFIOm+ugd5Aaqw9OsF6ikw6QSUNoWq8E74F1IqpCAJnRUeL1N7DsEHvfTd1vgwRVp8L5dwEdDYZB2V7hPX28QJ56OS77VVNdvR0Bazo1aAXBdD4OzjX0BomtGDWAb5bvHNwds9AI7DbZUdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NiU11jYfOS6Tsol9IL4NJ8DFoe2tCO5dI1ApDdxRH4=;
 b=W85QZe4DZaV1BcsG8G3vZwe/eCz+eoUOmRdlGYXThduh/jV5gSGaFNIQCQaqV120G2cfRNco7kGWevplz0V+ZuuyOoFezv9OjUGSq+VqUQA/07ueNxF+lcDVbc2c7fcEPug972tiDcHsIdLUqY6wwqRMdRxOlgvZwmMnvz/BMBPlkKkr4NzNKbTcArh/i0VSL+c66Wk6Up/1PsMK2Ce89YH4NM/4NLYI8Q/UGOvkgJ7064giWe3NZslL2NPUYk0E70wPf95o03Tic8CaaTStRoPjtEcHATnlLiOQPPIts40V5y6dgSWuicyF1arrank2OBGrhkvzdlxSfEReg4Awfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=blackwall.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NiU11jYfOS6Tsol9IL4NJ8DFoe2tCO5dI1ApDdxRH4=;
 b=d/hjYHJ+0vZiszzqstmIRbPPlzDfkBhYsCndK8DZMWjEfHxnj3NsBQCrN8yufTbtHu7iJ+2qRCpoG38CXP3d6d83rG6oLijmoM7k7g3PbmE67JaI/6CuhrOpNKD3i+DW+Cnssbtv6f5VC4ZNllzsdSWP1HJaAoKj5GR1CJV48vX0CMRlmSOzNK2ydUS1z/f5nrWxX+lQGsV18kosH87vq+sMYSssAM3TnpPbZPDB/6rMcqvAKo4MFlCdB4P2RoX8EUDgX/61b1bZxmT647gTZsM/nbadWter+ziZRfdJLU1ADpxdsGGcPh0KrL7CMJo2CPpYrjLcNOA5aoD8F66Cpg==
Received: from MW4PR03CA0287.namprd03.prod.outlook.com (2603:10b6:303:b5::22)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19; Wed, 2 Aug 2023 13:37:12 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::4f) by MW4PR03CA0287.outlook.office365.com
 (2603:10b6:303:b5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 13:37:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 13:37:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 06:36:58 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 06:36:55 -0700
References: <20230801152138.132719-1-idosch@nvidia.com>
 <87sf91enuf.fsf@nvidia.com> <ZMpNRzXKIS7ZzSVN@shredder>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@idosch.org>
CC: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	<netdev@vger.kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>,
	<razor@blackwall.org>
Subject: Re: [PATCH iproute2-next] bridge: Add backup nexthop ID support
Date: Wed, 2 Aug 2023 15:35:20 +0200
In-Reply-To: <ZMpNRzXKIS7ZzSVN@shredder>
Message-ID: <873511efbg.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 076323ab-ee3e-432e-a0af-08db935d939c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lQ4zkQMNgIvD4UCcjh+OpJIjE/bvv0m25o/VaPvz9dm88nU49MbcyvRDw9z+XCUg8qm0VaaO4E4ou6minunOwRKhwaIrm/cnP7TzFWrIkGWUsNQORuF5hGaQPOVA5A4vEG96etKC3/v52NGIOZp975ZJhNKtyxLb8j5wW0OoOKz8BGV9Fbu/+4hFRJyLPBjkTuiDEinfaWyDpj+CBCJz6PjxA8gtTvK4meWBmxFVGaPFKXaqs4nGIu3jLLhOGqDwBlvrpmACCZAHbJ/PztjQ5a0I/xo9At3sGWqGQuUrwWtdw0cR6vv6Pj/iGXhI/9x+1Dq86DlaVL5P600AtncT9aVHFAbZi063F0ZdXSOhVzKG/ZTLQ+sv9s034cl5/hmhIvEwkX5E4OxLJBGUdlcz1yW3r3LeYSQ1Mz2r5uMCHqsR0ntslP3SjZ6HsfaF4PcNu6yEDt0FvwJVPP3FcpKVFfbQxmnSiKmk5Vyzf0SUP3ciZOHMxAqA/5RrH+A/amULTeuat/21H7HuFBl77WWi6A+W4f8zDA2ny08MkaruRi0bfzZ4AavLKdzjCLm3ZCV/d6b9XZi3czbIGSrLu9gKPJP1pzZstKkTCBzE4vyoq3Pr2weeZn1kdP77FqZ+z2MnNZPORLYdYGBanVNDJPvcQ6lxIhzc+anOCy3WjNGH4WsBJwOHiCcMiHZcPfQglpermILFkqrFl3/StHVytdIdqU4iefMiCrZOIovF8imwrDGn/ZCEnHwXZQwG9Hn6e7Ox
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(70206006)(70586007)(86362001)(6916009)(6666004)(2906002)(4326008)(54906003)(40480700001)(36756003)(40460700003)(478600001)(83380400001)(82740400003)(426003)(47076005)(41300700001)(2616005)(7636003)(356005)(5660300002)(36860700001)(8676002)(8936002)(26005)(16526019)(316002)(336012)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 13:37:11.9251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 076323ab-ee3e-432e-a0af-08db935d939c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Ido Schimmel <idosch@idosch.org> writes:

> On Wed, Aug 02, 2023 at 11:55:26AM +0200, Petr Machata wrote:
>> 
>> Ido Schimmel <idosch@nvidia.com> writes:
>> 
>> > @@ -493,6 +499,10 @@ static int brlink_modify(int argc, char **argv)
>> >  			}
>> >  		} else if (strcmp(*argv, "nobackup_port") == 0) {
>> >  			backup_port_idx = 0;
>> > +		} else if (strcmp(*argv, "backup_nhid") == 0) {
>> > +			NEXT_ARG();
>> > +			if (get_s32(&backup_nhid, *argv, 0))
>> > +				invarg("invalid backup_nhid", *argv);
>> 
>> Not sure about that s32. NHID's are unsigned in general. I can add a
>> NHID of 0xffffffff just fine:
>> 
>> # ip nexthop add id 0xffffffff via 192.0.2.3 dev Xd
>> 
>> (Though ip nexthop show then loops endlessly probably because -1 is used
>> as a sentinel in the dump code. Oops!)
>> 
>> IMHO the tool should allow configuring this. You allow full u32 range
>> for the "ip" tool, no need for "bridge" to be arbitrarily limited.
>
> What about the diff below?
>
> diff --git a/bridge/link.c b/bridge/link.c
> index c7ee5e760c08..4bf806c5be61 100644
> --- a/bridge/link.c
> +++ b/bridge/link.c
> @@ -334,8 +334,9 @@ static int brlink_modify(int argc, char **argv)
>                 .ifm.ifi_family = PF_BRIDGE,
>         };
>         char *d = NULL;
> +       bool backup_nhid_set = false;
> +       __u32 backup_nhid;
>         int backup_port_idx = -1;
> -       __s32 backup_nhid = -1;
>         __s8 neigh_suppress = -1;
>         __s8 neigh_vlan_suppress = -1;
>         __s8 learning = -1;
> @@ -501,8 +502,9 @@ static int brlink_modify(int argc, char **argv)
>                         backup_port_idx = 0;
>                 } else if (strcmp(*argv, "backup_nhid") == 0) {
>                         NEXT_ARG();
> -                       if (get_s32(&backup_nhid, *argv, 0))
> +                       if (get_u32(&backup_nhid, *argv, 0))
>                                 invarg("invalid backup_nhid", *argv);
> +                       backup_nhid_set = true;
>                 } else {
>                         usage();
>                 }
> @@ -589,7 +591,7 @@ static int brlink_modify(int argc, char **argv)
>                 addattr32(&req.n, sizeof(req), IFLA_BRPORT_BACKUP_PORT,
>                           backup_port_idx);
>  
> -       if (backup_nhid != -1)
> +       if (backup_nhid_set)
>                 addattr32(&req.n, sizeof(req), IFLA_BRPORT_BACKUP_NHID,
>                           backup_nhid);

Yep, that's what I had in mind.

With that:
Reviewed-by: Petr Machata <petrm@nvidia.com>

