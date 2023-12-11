Return-Path: <netdev+bounces-55977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E3C80D0B3
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D901C211C4
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3123E4C3DD;
	Mon, 11 Dec 2023 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ByraldOb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C639B4
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 08:13:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlfWS1c3SRgyFr1b+j/jOkSQFHq5HHTg5oDMaAx12JUz0PpRvguZZWR1hriELDNH/IuuU1LmfRNNfkkj1icZr1iDD5xUZ/S76sLfYgedoTEyhGqw/DHlnkU3fXHZbRX+dxAYeokR0DqofVVYeg4y3qV78hHnUIcO+5V/J4Kijm2pkajXKAy8t9oTgzffWzQyUhmaC9YReOAsO2fESIORUWG07psC+vVPTkAJ2MPyh5FCf4oxZFEakp8Gbu6S1+3oO+i9SyuMr3byMZBtAa/54CQYiANZu1gIJFZUEaOFwG+/WwyVZlK2bo7a1+ZIEzpzH8B+h2d2MVGnppeRYnwmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zpO1nGU5/5VpL1EykW5P8ELIGjTztft/z2Zzi1SrOM=;
 b=UfQi1KI6TkVL5HTiwc6lEsD+YB/fD5ZCM66M5++XM60XCA6PN7ru0VSZLjQX/gClTXO/SvAwwBXuLLj+JKRoNDMJeb6qBAK7HPohekzc2c6/OOggr7N7GBN+noHAANNapBNwsCDkcDCOSWbAVDo3DhwS0Kh0RIFSTIq4P84ZoTSoEsL931ValeoY2Rv/Eant9oz9AmGfX+K1zpNPHi9JdBBzI5YPhYoA9TNBZwABq5GYXCKcA2VYztG6J3pB4Ble8zbMvtdW2cQsb298hSZErSZ4Ai+SmTx37XyCIhHrMAawXv05E9j1RI6gCrKWEuof1XbuEE05DU10N/mo+JOIoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zpO1nGU5/5VpL1EykW5P8ELIGjTztft/z2Zzi1SrOM=;
 b=ByraldObGtCul/0+useZ2+KdJ0hiyZbwLQpq78PzOmN7eLpzEqDs49oLE2ASpd0wBy1M2TKknOOIHrYS4urei0S+y+AsHrJE6bDjuBwW7jQ5PIhQbYh046ks76YNGJ2xNBj4gATFCO9hj7STS0ojZtIKjV/CRN8lQKbAU/rCNNYKVY1Bn93+c4plvMkTa4V5okyrWSRDp3gBPPJv1J5uwOetyTHTNQLCKIRbDynusY7YqspoxuknZlgEZzx8GWZj/f1VowjflMhKBraX8f+Rp7tliU6iXs8ODXs9p9n7eNLMC7mX6zhIL9XuVxFEnQtfe8WbR3Hvwut9vT7DGg2F0g==
Received: from DS7PR06CA0016.namprd06.prod.outlook.com (2603:10b6:8:2a::29) by
 DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 16:12:59 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::c4) by DS7PR06CA0016.outlook.office365.com
 (2603:10b6:8:2a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 16:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 16:12:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 08:12:44 -0800
Received: from fedora.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 08:12:41 -0800
References: <20231205153012.484687-1-pctammela@mojatatu.com>
 <20231205153012.484687-2-pctammela@mojatatu.com>
 <87jzpso53a.fsf@nvidia.com>
 <77b8d1d8-4ad9-49c7-9c42-612e9de29881@mojatatu.com>
 <87fs0fodmu.fsf@nvidia.com>
 <540b2a79-d10e-49a5-8567-2b1b5616ecb8@mojatatu.com>
User-agent: mu4e 1.10.5; emacs 29.1.90
From: Vlad Buslov <vladbu@nvidia.com>
To: Pedro Tammela <pctammela@mojatatu.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <jhs@mojatatu.com>,
	<xiyou.wangcong@gmail.com>, <jiri@resnulli.us>, <marcelo.leitner@gmail.com>
Subject: Re: [PATCH net-next 1/2] net/sched: act_api: rely on rcu in
 tcf_idr_check_alloc
Date: Mon, 11 Dec 2023 18:10:28 +0200
In-Reply-To: <540b2a79-d10e-49a5-8567-2b1b5616ecb8@mojatatu.com>
Message-ID: <878r607m6h.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: bce58d96-7df4-4652-31ec-08dbfa640b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2PUtiRxAy8MhU1ZBOE6zn+Sby9CmCEiqnA/rJ6hyxubJ65ypwdV5BAf3uzXHDTl/bc2hM9hiun2SAvEv+s4d8vmfXr04kvMaBfsgjEUxAfd5nCU/MHFQ9oy4rPuNhGyVV6lWsusj/ZUK7i943vcBciNDsVnu4Rcyzn7TfHW0mNUIJiK3V7arCmhuoOZDrqjfGKxqsWx+UgS0uapwFeRu/fc+DxBN95FUxj8a6etzx/Hpr2+Tma823KaR9FlcTKqrcU7kmAyM6Z8tVlwZTUBqdM17ZvkBZljOg5/8ypGNGyfFIyCJVwdrCdkWTa8dX4z7ajUUaLH9zKF12srl/1I1uMVZ5cdw+t/VP3cn6BeCI8eqBdviC2pK9jnaSa+i6XGEumgc1mvhVMfN3sGkojDl2mqvUxfwUd9OqkmQBy3JzsoXEG5esWMo0sYuFJJlwlN/DbXek9N/LPSlZm0dJp+6TOg7TOw2U2+wmnj6w6MUwy6jSQhRRY5h1qrIN1b+cYUY1DpT2Bv13hXZMV7XaZIz9q4sDWwy2W6twivvk7B25ExlwI90OgtM7nNIkDVIgqvTb2bEbLdzW8wF44i2q4/EKLjfr6dix8YoI7seyEgWnZHHfSc93UEr86r9zDxtb9Ckla38CxLcxmSMtFQG50SEIiumzUu+FQ/qJX5WhC4L0HcjvecgBxeSIgvZPJyIaCcSJTcASYRlCmFMatodUeFeSMtOwtv1Modn6vSHAk/MVSKOLl7Fu0aq6jNBV2mkuDgC
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(478600001)(6666004)(2616005)(26005)(16526019)(7696005)(53546011)(36860700001)(356005)(82740400003)(86362001)(36756003)(7636003)(41300700001)(5660300002)(54906003)(70586007)(6916009)(2906002)(336012)(47076005)(426003)(83380400001)(7416002)(70206006)(316002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 16:12:59.5981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bce58d96-7df4-4652-31ec-08dbfa640b5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464


On Fri 08 Dec 2023 at 18:07, Pedro Tammela <pctammela@mojatatu.com> wrote:
> On 06/12/2023 06:52, Vlad Buslov wrote:
>>> Ok, so if I'm binding and it's observed a free index, which means "try to
>>> allocate" and I get a ENOSPC after jumping to new, try again but this time
>>> binding into the allocated action.
>>>
>>> In this scenario when we come back to 'again' we will wait until -EBUSY is
>>> replaced with the real pointer. Seems like a big enough window that any race for
>>> allocating from binding would most probably end up in this contention loop.
>>>
>>> However I think when we have these two retry mechanisms there's a extremely
>>> small window for an infinite loop if an action delete is timed just right, in
>>> between the action pointer is found and when we grab the tcfa_refcnt.
>>>
>>> 	idr_find (pointer)
>>> 	tcfa_refcnt (0)  <-------|
>>> 	again:                   |
>>> 	idr_find (free index!)   |
>>> 	new:                     |
>>> 	idr_alloc_u32 (ENOSPC)   |
>>> 	again:                   |
>>> 	idr_find (EBUSY)         |
>>> 	again:                   |
>>> 	idr_find (pointer)       |
>>> 	<evil delete happens>    |
>>> 	------->>>>--------------|
>> I'm not sure I'm following. Why would this sequence cause infinite loop?
>> 
>
> Perhaps I was being overly paranoid. Taking a look again it seems that not only
> an evil delete but also EBUSY must be in the action idr for a long time. I see
> it now, it looks like it converges.
>
> I was wondering if instead of looping in 'again:' in either scenarios you
> presented, what if we return -EAGAIN and let the filter infrastructure retry it
> under rtnl_lock()? At least will give enough breathing room for a call to
> schedule() to kick in if needed.

Sounds good, but you will need to ensure that both act and cls api
implementations properly retry on EAGAIN (looks like they do, but I only
gave it a cursory glance).


