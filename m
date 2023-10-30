Return-Path: <netdev+bounces-45229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BD77DB9D8
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 13:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355B42814EC
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 12:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E62515E8F;
	Mon, 30 Oct 2023 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GIdjG8ls"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC1715E8C
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 12:25:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B6AD6
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 05:25:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clm94x+wyKFqLRzNKtXQnazPutKEgItUWNkunWAkInu+mAEmc8QDu1EaNN77HrLDE8GtQssU3befvBBuZydv3Ib/sHtBEtW6gEX+7r6pTavb3Kmqj56VfvTSjDllepvPOTml7V9nR4CtO3AYvjUwhTq3yCs9M5QWCDaMUe/AxHVAyQPmySoCsIjtmQm9qQWrmvqpMWCdsvqOKCjzC7kfrLigO/w8u87wfWEvJdNlr4pQITa4hp4kQym9MvmBusevhPB0U1Tkq6ufPX84P6/Uc09zs4A06eUscY1BvFJKKJ10ZX6mGSgZK4AXVHFREMc60M9Z2mM5/nxjMtxu66MjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOkjGiv12HRed4etXU/STksSdAfPvxUv0g7g39cHAvQ=;
 b=bI2mkvJOj/t2TAMC3WbInP8pASiFK9GP9P5cb3aBh5B6BYMV0dt8xBuNSFOrq2kf/eoyLE0/7G6PR7bQ1FO+1ZlVCIrf9/VTqTnO+6OkKWGlEmej+IyQIRIF3mTUxMTDzLlrIuIJOw/VJO6eb6k6ipOlRORoR/2JoXI+NLtf2c7nBgCvtNCkehUceFOlQwbfPIK+P7XhPpHc35vOVCqD/0ihon27WJSftXzsS50kdEVssw/fBaUzZ+7YJAbSL2X6FuA32MHx7WR4h8hAVgHmk5M5JSmIewNll07OEO8V7ZUn8cp/SoctzqI6s3vO0iAkRTnLgK34MyTDBKby8CTuzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=microchip.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOkjGiv12HRed4etXU/STksSdAfPvxUv0g7g39cHAvQ=;
 b=GIdjG8ls8V57uX+mshBrmIeIWwm83T8nWviz3JxS3Fcmr5bhXQKyaMr9PvQv25NxIZ6gEPrFammBtFnmCLGN4fssYE7DfseIMu50+1KLytyAGOyGUIyfU8vYnhFrI47K0EwQr0vJMk56aOGridYz08saYVsi8PBNtouEvuvFsVsvP/HRxX80o6ZDc8TLFLcunNm1KErs5cyTQb1AN3Uelc1IbDACLW/UiUFQZek6Ll1/KEYSLEQQJ0a0aKHcqdSVcEZFZuRjytmk+wEVYF37bNtrmqMQQtqjssXqteS79951427BBGFNnDa72gCzcmXYmMG79u59tHeurkReSLKfqA==
Received: from DS7P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::19) by
 IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 12:25:14 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::89) by DS7P222CA0003.outlook.office365.com
 (2603:10b6:8:2e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27 via Frontend
 Transport; Mon, 30 Oct 2023 12:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Mon, 30 Oct 2023 12:25:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 30 Oct
 2023 05:25:04 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 30 Oct
 2023 05:25:02 -0700
References: <20231024100403.762862-1-jiri@resnulli.us>
 <20231024100403.762862-4-jiri@resnulli.us>
 <61a6392e-5d77-4f15-bcd2-7bd26326d805@gmail.com>
 <878r7o5dht.fsf@nvidia.com>
 <a9b610e6-b0ce-46b6-89ea-faef78c5a4f2@gmail.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>
CC: Petr Machata <me@pmachata.org>, Jiri Pirko <jiri@resnulli.us>,
	<netdev@vger.kernel.org>, <stephen@networkplumber.org>,
	<daniel.machon@microchip.com>
Subject: Re: [patch iproute2-next v3 3/6] devlink: extend
 pr_out_nested_handle() to print object
Date: Mon, 30 Oct 2023 12:03:57 +0100
In-Reply-To: <a9b610e6-b0ce-46b6-89ea-faef78c5a4f2@gmail.com>
Message-ID: <871qdc5mcj.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f13e0c3-f46f-409e-f5e6-08dbd9434495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UlzHtQcnfKOURdMcQgUpHqi7lKqdgFsCT4AMmnhkWE1VGJv+9nVw92K1FHKJ6SHDHRSBwDRl+Rxpfjh19bC3BLciOrw+Ub9evfF01qed7UxaHvw9tlYTZrl2t/hRLnBNMT/7FvZVOrfZOxZ8DArFo2tHmpM41QPsoj4/uQejxKESarAwSAcLOf6w95AM/+3BadKqGupMhbCrasQZKzrUTpP/wO78noWhu5pF6IW5Gt2nrRJvtRwl3mXEGxA2k4E9+SIwM5e+IT2RpLIyWqbF8ALjzCNIdWuYnhkghMUEc1KxleH1qYlZHQD2T84nnpqAFytiji6+N7DXaf9AfukiZRLMDATC4s/vM9zgsbHCw15TCXSvBOAhJ8sH0j8rnHULhz1CtVEAz88XmiPYvew3V4nCz99BIL1nbYj2jwiPKaBr+2tYD60mj7Pe4dUFat8NNVVrKNLrenCXij3p6pbw69Z+JAFfKLjT9PZA8sEOkQz4hxAwqdFKEnUPwZBR7+yH3ysboAnZafQ7/ts77n+KJksXYSmQgsNvtKzQ7nJLwJ8fz3l+8ZUbfIXJEzaZ5EoRNcISM3NG8Sk9va7fowlv9uJuk0yOUPeSG6pVJ92zevjZvz2xRIWRq5DxrYoai32krS8Ohs/Z//16cXnGXHP84OK5uC8ICBqSdtILapibu2dXvD8pt31IIHoFq0ydcOHJtG0VqUEvb/ag5g+RwWT/WaH0pmnd5jFsamkVAvC8zlfnMj5flc6D+cAZ+VQW/dXi
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(2906002)(86362001)(41300700001)(4326008)(8676002)(8936002)(5660300002)(40460700003)(36756003)(478600001)(40480700001)(47076005)(6666004)(53546011)(7636003)(6916009)(54906003)(316002)(16526019)(26005)(70206006)(426003)(70586007)(336012)(36860700001)(83380400001)(82740400003)(2616005)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 12:25:13.8365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f13e0c3-f46f-409e-f5e6-08dbd9434495
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301


David Ahern <dsahern@gmail.com> writes:

> On 10/27/23 7:12 AM, Petr Machata wrote:
>> I was wondering whether somehing like this might make sense in the
>> iproute2 library:
>> 
>> 	#define alloca_sprintf(FMT, ...) ({					\
>> 		int xasprintf_n = snprintf(NULL, 0, (FMT), __VA_ARGS__);	\
>> 		char *xasprintf_buf = alloca(xasprintf_n);			\
>> 		sprintf(xasprintf_buf, (FMT), __VA_ARGS__);			\
>> 		xasprintf_buf;							\
>> 	})
>> 
>> 	void foo() {
>> 		const char *buf = alloca_sprintf("%x %y %z", etc.);
>> 		printf(... buf ...);
>> 	}
>> 
>> I'm not really happy with it -- because of alloca vs. array, and because
>> of the double evaluation. But all those SPRINT_BUF's peppered everywhere
>> make me uneasy every time I read or write them.
>
> agreed.
>
>> 
>> Or maybe roll something custom asprintf-like that can reuse and/or
>> realloc a passed-in buffer?
>> 
>> The sprintf story is pretty bad in iproute2 right now, IMHO.
>
> It is a bit of a mess. If you have a few cycles, want to send an RFC?
> Just pick 1 or 2 to convert to show intent with a new design.

I picked at it a bit over the weekend, but came up with nothing that I
find comfortable proposing. The static buffer approach has some major
advantages: nothing ever fails and nothing ever needs cleanups. This
keeps the client code tidy and compact. Anything dynamic adds points of
failure and cleanups, which in C means more client-side boilerplate.
Anyway, I'll pick at it some more and see I find anything.

