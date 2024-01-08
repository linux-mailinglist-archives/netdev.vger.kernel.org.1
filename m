Return-Path: <netdev+bounces-62311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C78AA82691F
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 09:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B3A281FB2
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 08:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763DA8F54;
	Mon,  8 Jan 2024 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oxbGXQV7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E569CB654
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lj1lwMocXZTN4vQj6cjGVRj22YO156xeZ6rn4LL4rPvISkY+23hpNWqrxvQepCCABhLQB8D70zxQekI702QtAQQHzp/WwFS1PSu+PBqtt9+UlmS+PvjslEoMRyN0sStiIVCv8tM1UIU/+AH5KDbCdDkYRs8eYltmmYYuyzWcMEzalWjZMbRX0dpdiyiOXiDckuzAJkYZtpM9UC32Wk9tEY6F6vF9jW/wEMvxLfzSBKd1iyPXgpjOutCBPJRGVojtN/rWj42ZYPw2YLVF3ECFMoQ+Hkdpxn8pNv7LbJgOkPFEzjpQXL8o/kiEm2kwCJafyviQxXNvkm68b/J89bBvlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEzOdhsBIAMc2qI53QhsRpQ9AQoEXLc2QVt0eETBGDk=;
 b=MY8C6uv9KDpJ2zySynxZYJ96RgeRwbvXOEwU+fuceEslldNJ9G23IbqyKKwKLMWUHZFBfS+aGmoimA8hMacK9FbjakX3fgZU99SKUGDhcUinCRHpwpC1pt/oQrPUyb/OghHZqMeUdI2HMgToFANmruexKhMn4iZs/xeMmnZ7qtmpUByMoE0ej7ZlCiszYYaIWg2xJv1J/P+m9zhOWW7UIKxa7EJ9mnMabtCShVJ8Updhxt0itJ2IXg16KSbBGgKmvetLbZ/A9RKR38PGz4lpyrTA1WEI2+r8aRI4/MNNMun00Z/MLLcqYfLPN+BlYj7hcszpJ+MTaWaQS2SCtGFmbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=netfilter.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEzOdhsBIAMc2qI53QhsRpQ9AQoEXLc2QVt0eETBGDk=;
 b=oxbGXQV7nhvMfJtCp7dKVx9GeTt+OSQS7c6ov1pq8xeYkYS3PcKTuboFFKNIN3rj91Rnbm+igy7rkEaMDHeL702dgFOqz9yG4Ka/IQRhqtHJSBORA/WW7+ENofluKXekwX5t5LPuQYWo0yM2agdnEwzoORWykV/rt6PGFTr3PxrkaBKqCNfY5cGK4yWiupfAOgesAQttijp2fd8BODv66b5B1grbqUlySZ3p6hAphj+iEWCORGp3j8ZNPioeKMmKjvhUOH0O+aAzWdScrw81Vbe43b/+uL7MYY/FCcwrP6m7RRSxNMl+WiEL4z5N/ChzZemvVcss2o6CdEBL0tanYg==
Received: from CY8P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:46::23)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 08:14:31 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:46:cafe::cf) by CY8P220CA0004.outlook.office365.com
 (2603:10b6:930:46::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 08:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 08:14:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Jan 2024
 00:14:17 -0800
Received: from fedora.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Jan 2024
 00:14:12 -0800
References: <20231228081457.936732-1-taoliu828@163.com>
 <20240103174931.15ea4dbd@kernel.org>
User-agent: mu4e 1.10.5; emacs 29.1.90
From: Vlad Buslov <vladbu@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Xin Long <lucien.xin@gmail.com>, Tao Liu <taoliu828@163.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<paulb@nvidia.com>, <netdev@vger.kernel.org>, <simon.horman@corigine.com>,
	<xiyou.wangcong@gmail.com>, <pablo@netfilter.org>
Subject: Re: [PATCH net] net/sched: act_ct: fix skb leak and crash on ooo frags
Date: Mon, 8 Jan 2024 10:12:26 +0200
In-Reply-To: <20240103174931.15ea4dbd@kernel.org>
Message-ID: <87o7dwmecw.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DM6PR12MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: bae96c1e-5480-4b01-8790-08dc1021d737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dfv+0g6KT7uohiO5KEyXDbSOA0yAQuqmMHSqBtiJ9ZeFUtk9TNugIYEd2jZXYHisdNiYCtXU4DdXPhRgKvBwesdN6/Ub3fw/lD5DRBhKHPqqui1IQMrP3tp1dXZvh+IacFDvq82Q0T9XsoxVnEaj5kgdTOpnYo3cjuOqp2IBWd1OmmJ/UTTz4dAxsHbR/7ZA3Vlw7lF4otHgMoga6oipJ2SYqHkRVcbM2ovbfv2+qc6C0ezo9Srfp4cgQEBfnhuRXYP7vQMKW4BZ/cYv+es7GOS2YUTSYYSYYY9UIF/MC0e3lxUy3BmomjZ015Tlqmzvam8oA53Vb/s1fExyVJNJek4885LKyPlOQNA+6e6AOlhqOd2db6knVsKrLQ+21dkEIRiNxHzvK3VrzgY8y/FBfktoIHTRF+nFfAbfIrGSfJHCCsnhALUCPNrwrHd1i4SZ7fHZ0F+AqVQeTaLjQFAWE8OcEiww00fVtgZipaFz6SYvPA8oVXRawl9DL3vPMdU+nciz5D+L55S0CbXWr6sFCH1nuLpGYoKSuDnqFUBkX0E4NYObDRdREBWY+vF2zT3cTnGbaGJ++2oU/eEg8IjXrJbnV0vpZKFaeXJr4ABFIStAR6FP1RLTqnsRyqvUivCDKMY5R8JYyjFPZsmfi3paC5vuVVXwDNfMl9X8/vVf3H9EefeHGOQmnLnCULLBPf478bT7nsya2Y7hf6VSRtXObNpAciwIWrsfhVgb68JQ+Va388DD6Ahx7EIpRxymu7m0
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(70206006)(70586007)(47076005)(316002)(8936002)(8676002)(26005)(336012)(478600001)(16526019)(426003)(2616005)(83380400001)(6916009)(2906002)(5660300002)(82740400003)(41300700001)(4744005)(7416002)(4326008)(7696005)(7636003)(356005)(40480700001)(86362001)(36860700001)(6666004)(54906003)(36756003)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 08:14:30.9379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bae96c1e-5480-4b01-8790-08dc1021d737
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332

On Wed 03 Jan 2024 at 17:49, Jakub Kicinski <kuba@kernel.org> wrote:
> On Thu, 28 Dec 2023 16:14:57 +0800 Tao Liu wrote:
>> act_ct adds skb->users before defragmentation. If frags arrive in order,
>> the last frag's reference is reset in:
>> 
>>   inet_frag_reasm_prepare
>>     skb_morph
>> 
>> which is not straightforward.
>> 
>> However when frags arrive out of order, nobody unref the last frag, and
>> all frags are leaked. The situation is even worse, as initiating packet
>> capture can lead to a crash[0] when skb has been cloned and shared at the
>> same time.
>> 
>> Fix the issue by removing skb_get() before defragmentation. act_ct
>> returns TC_ACT_CONSUMED when defrag failed or in progress.
>
> Vlad, Xin Long, does this look good to you?

Hi, sorry for the late response. LGTM, will report tomorrow if this
triggers anything in our regression runs.


