Return-Path: <netdev+bounces-19477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6787F75AD48
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 13:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF826281E1E
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 11:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A317718000;
	Thu, 20 Jul 2023 11:44:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AEF17FFF
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 11:44:48 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337FEEC
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU3tVYfzk+jC1qhf/j1u9owKS+r3jTC57yqbQ5GmXvCKJRjQISdbUYHbhXF8u7FVwEvC6k6eyxQ3vPQjC4HIKpBbKNBcalEBHehvcYyby2euLB1BKKg89eKTy1qogXKotcJmMF+KuWzxqOmoQxIsTH3Miom2a/vd8+/S/qtPO9LDbg3zSfXgUuj4r/Mm4/bpz/Yiq1UiZZBOrCVtsQXZEElCZ6s1xqOTOp+vDAbhpgny44Vv3vlxobKkSPU5xej7op80thd5ppf9Er8jqnqmaQUnTvjB4soruUqZYhdBem6vaAZpE9JqCrmEe/qPXz/+LeyRbL1sIrZetG4AOhsc4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktS4izFR7AhMxIE66vVYBTrloaIfMO/RzugS63S/Sd8=;
 b=n2hNL+ExwqzT7ST0qBauTEmQurnKRqE5DSml2Qc304NlokQj1+xWeRDYoCi7zZuACrsHKK5QH9d4QIdzrDyLoeXRvisfotHL/Jq1bExUZXY3jayfxQ0j17eKrx6t8SY8SqcGB4/5rE/jtBAjf805KpY1B1g89yrCpF/2xtaWl7FlXJXcOAO34lPs0dA7ejq6+Xn8GHvi2B7zM3qS3zh5jibuEO0byfkbKcxX2/wDywwlyW654sXoeD6si7pxT09OcYG+SQfYBFRb1dRuGMNLyMin1Hpv63FXGUULFhhT3KFACRDFXR0oTehUzOfQTW9ZuAeso9xK+Y5773Yp3CImAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktS4izFR7AhMxIE66vVYBTrloaIfMO/RzugS63S/Sd8=;
 b=LCJuPwO4lygjMLaFr5zXSjiSBZSQF4kQVv6Xp0hvl1lKdjrUOyollB71v7RXVSSn0r7XsrqMs+Qhe9HklB4jg4rdDgrmOlZQlWwHQ1ePkaeuq00gvZr/KbDv/B3Wb4IIwNLAa4RtvPFsRchKyfT3DZjtQ5vhx0Afjn/X/JEsCXdLCdAv8WHAg/MNHU/rlG31ZfaEOxdO1mbZrS6YMuZTHLU9M68Pmd3vVvJAgz5Q1Ri401PT1RGwfaOnQsQHBfeOmKJSBD9OfEwFnrsl+DmMtbIggVvOelzsYyEemkELhfgB60f2P5LapH49YdLfbvqfMIKdbXpDDXfuk0q6NBAQcw==
Received: from BN9PR03CA0807.namprd03.prod.outlook.com (2603:10b6:408:13f::32)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 11:44:45 +0000
Received: from BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::64) by BN9PR03CA0807.outlook.office365.com
 (2603:10b6:408:13f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Thu, 20 Jul 2023 11:44:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT079.mail.protection.outlook.com (10.13.177.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.28 via Frontend Transport; Thu, 20 Jul 2023 11:44:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 20 Jul 2023
 04:44:31 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 20 Jul
 2023 04:44:29 -0700
References: <20230719185106.17614-1-gioele@svario.it>
 <20230719185106.17614-5-gioele@svario.it> <878rba98fl.fsf@nvidia.com>
 <88ab68eb-2ddd-50a7-a9ea-c3e213406373@svario.it>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Gioele Barabucci <gioele@svario.it>
CC: Petr Machata <petrm@nvidia.com>, <netdev@vger.kernel.org>, "Stephen
 Hemminger" <stephen@networkplumber.org>
Subject: Re: [iproute2 04/22] tc/tc_util: Read class names from provided
 path, /etc/, /usr
Date: Thu, 20 Jul 2023 13:33:50 +0200
In-Reply-To: <88ab68eb-2ddd-50a7-a9ea-c3e213406373@svario.it>
Message-ID: <874jly959g.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT079:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 31447c0e-a56c-4bc1-37d0-08db8916b6c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nDHVS4yI6u7Mt2PxfH4+NpZrTbNEt+LMgvwOsHjbwxhte6ZfkltJS37iNaVgRcdDmUgv8MmvG/ygwx0xh/xAl0iQ6QU354xs8jEeOfm2aESX5llqw7uhzJjSJxI3nVn8YpMM4k9RS3srekmrYmNotLsdN9CbPzuKtPlnCAe9ZdcI5XfOcxjXeIW0RLClMlvr6u/DQ8sNYli7R2fXRb6NcezFufUzQAdfdrOnKkJBKa/GNhoPGj0915/OaJJgHLG5kdJKW4I/CXrVO5E3sF/hwldam8n8IG4c5MP2ObqPF7hM7QWF4clnSmSn+BvunD00x9mFHSotEHPgBFYZ5Naj6SvfczTi0zzT7deSpvjLEbSvw572DujtvtTSATPa2o9Wf/roqR9v2dk6Z01HReeiBLGVUvoM2Juafhp+rg5ddReE23Jo/ftjVjRHfAV5UrJbpwtckk8YaPEjqMeJf4Fqkrd1nVLEAFSYQFlXCz1PqVwN7ABcg77LlFukfOdH83XXv9QjXk9dsKdQOalrcU0Wmn6A7Hai7WjrNRVDVsvgptuHptA+9zrCH32HCK4kH8LuvB3+BjtuiRcdPGfEdtR+tRX6FbFiVIuHCflp7R0k5crsOcor0UcCh2VnKqmYkfAirTIv+efZSfG2lNLeRuCa8ynvtGjdiLdLjBmURJamWyZo6DeuWRTo5bYzmT1bnWf2vKFR2IAa6YqUGTnmMzOXl4HyFIi+LgzIPQ7NpmhEhKw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(41300700001)(53546011)(186003)(26005)(16526019)(336012)(478600001)(426003)(4326008)(70206006)(70586007)(6916009)(40480700001)(316002)(8676002)(8936002)(5660300002)(6666004)(54906003)(2616005)(356005)(47076005)(36860700001)(40460700003)(2906002)(83380400001)(7636003)(82740400003)(36756003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 11:44:44.9821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31447c0e-a56c-4bc1-37d0-08db8916b6c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Gioele Barabucci <gioele@svario.it> writes:

> On 20/07/23 12:10, Petr Machata wrote:
>>> diff --git a/tc/tc_util.c b/tc/tc_util.c
>>> index ed9efa70..e6235291 100644
>>> --- a/tc/tc_util.c
>>> +++ b/tc/tc_util.c
>>> @@ -28,7 +28,8 @@
>>>     static struct db_names *cls_names;
>>>   -#define NAMES_DB "/etc/iproute2/tc_cls"
>>> +#define NAMES_DB_USR "/usr/lib/iproute2/tc_cls"
>>> +#define NAMES_DB_ETC "/etc/iproute2/tc_cls"
>> Is there a reason that these don't use CONF_USR_DIR and CONF_ETC_DIR?
>> I thought maybe the caller uses those and this is just a hardcoded
>> fallback, but that's not the case.
>
> Thanks for the review Petr.
>
> The reason why I did not use CONF_USR_DIR in these patches is because I wanted to minimize the
> number and amount of changes. But I asked myself the same question when I first looked at this and
> other similar occurrences.
>
> Let me know if I should update the patches to use CONF_{USR,ETC}_DIR.

The change would make sense to me, it looks like rest of the code tends
to use those defines. But it should probably be sent separately, yeah.

