Return-Path: <netdev+bounces-31397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5278678D617
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 15:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8186128119E
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 13:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64347538A;
	Wed, 30 Aug 2023 13:23:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54704567F
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 13:23:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A07B137
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 06:23:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEwp7j++WlRpQhM9GGfVuUWD21N3NV2CZpRztz+tnKo4YdaxIeBb5zVCQFes7i8eUr273S6Lx/KhbsEh46v64V2j5+5oOUPDBoPDirbjBfn7mSfJURTctS6LRLi3ub1CMEKfwzHf2vbNTSzrGrnlHMevQ7jV5td5YAZ9hi7yjWSl9YVZ15Z2AUz87JJKgYPrE5H8tv3hQpFtJ4GaiU8bBCTO+DvJsxB7+d9RzBoI9gPFoRjdV3f+3HvInXbc/1DlTJeD0qrmI2u/znoXUFHvMhThbo/63ZusYOnX5HfUYsS1JFh9OFo8p/I+uuflTZXqnYjpdFV4gLGyfJapVRKAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Jjon+jzR2V6/91bTLGBQqd/M0tVRUXIGtDO0D1dR7Y=;
 b=IXCdpIl6s1/UM+WqHvM+aJKjhlCp9FhNYqJUi+k1kKzev1smAm80tlNRfv3x5SbDMn4Y2nrgd2V1vKHUQl0AeQ/U9vxgOWHu8ejyibBwAL6L3dQkeUYhghHX9xg+nFbLSFCQ/1MErAmRghXZ1WFMtGHFklJ099VBp448VdsllJINMpnRaC6+85x3VCjzk32AMo4qULJbvtFtWZkhfMZSfZwwntP3qxyghwbZwf4T6tjXtykPTHxiToUtXV2M8/MW4MTEa4DWsIs0AVqSpgfPvVnymr9SE8zncBLM6Q0EOk/Toxc/CI9HKuFTBxOMAvV9VK7ID2GqeN808HkIEkpGUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Jjon+jzR2V6/91bTLGBQqd/M0tVRUXIGtDO0D1dR7Y=;
 b=FiQfAh9VuTAHAL2k/laL+OfmxHAumVtDpXPYNZrVVdwznczG7fnMOUpUbDMxMnSHRdkZQWHa60OEsVY7vYvp+2LKOexOj/vvDkNhiaOv9LHnNJMm17fHYQ6e/PYI+rZrYYUCmGKGigNpQfdxHTMNO8WIIWzfq9RR1+8L3r9CY148xWdOT2cai5rXNFJF8DFvptEjCnuNyp61Tt9eRylGcrN7m5WRstaxV00TyC0vUzfDXQo2L7EiQbyYqmgBZuRGq/h9zkRRk5AjKq065C3x92ZhvX0QhaEPYLoa4h1vVggKVyGyyWir8Y/7iqHKtkr2YcIWHB2cdXomf39bbRPevg==
Received: from BYAPR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:c0::20)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 13:23:35 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:c0:cafe::2) by BYAPR05CA0007.outlook.office365.com
 (2603:10b6:a03:c0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Wed, 30 Aug 2023 13:23:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 13:23:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 30 Aug 2023
 06:23:23 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 30 Aug
 2023 06:23:22 -0700
References: <20230823100128.54451-1-francois.michel@uclouvain.be>
 <20230823100128.54451-2-francois.michel@uclouvain.be>
 <87y1hurv2f.fsf@nvidia.com>
 <172898f6-56a7-6ce3-212c-a468f4ad6262@uclouvain.be>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: =?utf-8?Q?Fran=C3=A7ois?= Michel <francois.michel@uclouvain.be>
CC: Petr Machata <petrm@nvidia.com>, <netdev@vger.kernel.org>,
	<stephen@networkplumber.org>
Subject: Re: [PATCH v2 iproute2-next 1/2] tc: support the netem seed
 parameter for loss and corruption events
Date: Wed, 30 Aug 2023 15:22:41 +0200
In-Reply-To: <172898f6-56a7-6ce3-212c-a468f4ad6262@uclouvain.be>
Message-ID: <87pm34slyw.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b5174a-9306-4daf-7540-08dba95c4f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GpewBpiHjgjqSckSOj7MgNPSrpO3A+StwrDbZvP81z00K5/JiwwkNE0aQOCVg7fSWqQqjaCVbu+8DMT+KOllCKOCQJga6M2t/H1zSQBVPFtAL6Ov3o8v573qALhYeNMUJOnBuKlK0+h8tFVsKRMuiL8WF27Pq6t2h2gdlOmcmkEJ8qcF/DjW5P+qYiTSb+0oNkcQqqRpCh7VpSVKFeijBFeiXQvXrN6ZSUU+Kf4DRgqCNT30+Pf3k7lV7QGkS8GbzkNNjju4Re31eAsx4vYEEDMAOPIDjqk43cTHY7W/0WoLeSsmp9iqx+MeIG5Envnids+9zInH0JZ4AQYe8r4Uk3I0DeMEmj8nE6x2freBrRAKWBE/b7QV+bLgnYkczm85xnHRohOx2W1Ri649HH6kzFnSKob+KLuD10igzkUnzrlq0dUl/2dLYvSSz44bZ4flkN6G+P5Kr8cysWkzmuMNj/rkJ1RRHc3YEHUMWYFb1HCbRy4A064QfUjHgokXhuGdJCzLjyeD7bVFOz67FT4TUYI/9digU8MwHIqSLAq4WOnJ+Ytwe/4xKlGx1555lwxMiZrwWHUrbIr676a3U/9SAoqaPNqVzmdmMQRSlFEQpZf17l1qon1rOBBRM674XXm68dmUZyJHw0o7GZJRYRa43UfSs3sNt3l9zi5xb0bPnTzWsrQhPheYNbtB5WaM6Kipem5Jg1/DwnCVkHCaBlrnfAetV6HqLhjtrwl6fbGYQD/kABOOIqBEdKcmo/1Z2bg9
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(82310400011)(186009)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(82740400003)(6666004)(4326008)(47076005)(40460700003)(86362001)(40480700001)(36756003)(356005)(7636003)(2906002)(36860700001)(426003)(4744005)(336012)(26005)(16526019)(478600001)(70586007)(41300700001)(8676002)(8936002)(5660300002)(6916009)(54906003)(70206006)(316002)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 13:23:33.2387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b5174a-9306-4daf-7540-08dba95c4f2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Fran=C3=A7ois Michel <francois.michel@uclouvain.be> writes:

> Hi,
>
> Le 29/08/23 =C3=A0 12:07, Petr Machata a =C3=A9crit=C2=A0:
>> Took me a while to fight my way through all the unreads to this, and
>> it's already merged, but...
>> francois.michel@uclouvain.be writes:
>>=20
>>> diff --git a/tc/q_netem.c b/tc/q_netem.c
>>> index 8ace2b61..febddd49 100644
>>> --- a/tc/q_netem.c
>>> +++ b/tc/q_netem.c
>>> @@ -31,6 +31,7 @@ static void explain(void)
>>>   		"                 [ loss random PERCENT [CORRELATION]]\n"
>>>   		"                 [ loss state P13 [P31 [P32 [P23 P14]]]\n"
>>>   		"                 [ loss gemodel PERCENT [R [1-H [1-K]]]\n"
>>> +		"                 [ seed SEED \n]"
>> The newline seems misplaced.
>
> Sorry for that, I don't know how I could have missed that.
> Should I send a patch to fix this ?

That would be the way to get it fixed, yes.

