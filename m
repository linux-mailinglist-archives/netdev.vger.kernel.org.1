Return-Path: <netdev+bounces-52465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2447FED2D
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 11:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C5C281A52
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 10:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931872FE20;
	Thu, 30 Nov 2023 10:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lfJAScfi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDA110DB
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 02:45:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH+AUpwCsQHq5rkrkR568Njf5l+C1R9gMeVe0/uJ6Xl6bG7LCh7997vbvdFuEuN6RfQo+ZVL9v6J4mh3w5hT8VoWA2b9LKFGhamyMn6YuqElXSm9tVR6aygPLgwm4DbrNkSg3EsmneLlMbjwCMOTXaKMSK3PtlHyFSBDzK9Lptj7Gz4UrUjxU5cm6s38b1NYPPkr6da1ShlzS3ag4sA7SNlvrK4oj6iYjTwcX4Hvx9vvNvMOrG4YJUm6dAs0Nb+/57JYJ7jBEx7m6O5Ww8wtcY2AhKa+VNt299iSFaIH3TE7LQ6yxUpxWoTP/XhHHyWhP9/mnNXNCUN3Sn1dWBtG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZ2F7s+J7I8hrTC2qEj5BkDdsoxql/yiCvxKhb6jv2I=;
 b=AZP5OJC/4QOr2raP93z4vqiY6aGzdQ5ksDJ5kbeomLgg+ysOQWl8VZ2CLAi4QzPCxkbF5ai3pUHszz50oRq1YN3oGtSPTIzIDQRQohl1rkiWfF+tWsKM/XCGH4E711VbQoOrrxaDDF1gKX8Qj/r4fl7M5W9tP8OCE+Mk70vGC6bvhYt6JvNAzsVy/WgdXt2Cc1fW7O9XYj1q72YSInSXl0DVjLwXZKA7tDZUGhQwhwhWzzC5aJCALfG3NxrQ9JrqZD1PLjdC2lyKbyEYJmGhpZcXa+JG4M6FBououjglZN6ec6uJN8WIpsbKKrYdpNnC0q2+RVOVDDOioXcN5VUqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZ2F7s+J7I8hrTC2qEj5BkDdsoxql/yiCvxKhb6jv2I=;
 b=lfJAScfiNPjRFO9wJHhqv4Qnovn5TAvLbVqSlLatiRFoi4KG2+RxwVPCt0Hi3x3bMMi80ORZSTiJjCZBkKbLLuIrgCvZuVd8YNIE9o698/aA+Q8OrWf1qAv30CqU5mPM9zuES1Dy5Kb7VLbQ65bCgxE/RpHXNROrNCI7ktCKBXekvltI6JQ1rRQgT+wYvo6crshrhAFvSFccb9ucLLwaTYzE3YhwCxRChd6nO3KqZqVpxjXlgXBgOETeWtj6Sc5AYciV5qdr30DDAyvGR/I3fCwfFoU0ppJAk5pppVvQGcRw7lvBtbaDFVGRqwHgJgzV1KZExqRyQdvE59Hz3RI5wA==
Received: from SA0PR12CA0015.namprd12.prod.outlook.com (2603:10b6:806:6f::20)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 10:45:25 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:6f:cafe::9b) by SA0PR12CA0015.outlook.office365.com
 (2603:10b6:806:6f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Thu, 30 Nov 2023 10:45:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 10:45:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 30 Nov
 2023 02:45:10 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 30 Nov
 2023 02:45:08 -0800
References: <cover.1701183891.git.petrm@nvidia.com>
 <20231128200252.41da0f15@kernel.org> <87il5kc0je.fsf@nvidia.com>
 <20231129063048.3337bded@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, Amit Cohen
	<amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 00/17] mlxsw: Support CFF flood mode
Date: Thu, 30 Nov 2023 11:43:47 +0100
In-Reply-To: <20231129063048.3337bded@kernel.org>
Message-ID: <8734wna5am.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 35995a83-da8d-4422-3900-08dbf19175c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Rdu41QKOBQR9LEK6pa3AeaWe80kg7f2JDBjwDm0ep1O+Dmrt9U7D+RDvkrwLEml81KZq8cSpmnBognvbyEdJqu6+8zdZhnLB/Otu36dajYBtNlIZ9mlxyoR6PuSm0WYgrUbl8cH0Zs5fc2yuZLRSyus920Kvkv59F4J0vnhf49cwbV91DF+hj/XDgQfv6Pu1u4SSAJc0Jpw7jHhjZkvD9gxoTWvD1wRWj0CSoBG4hrGvkddxxaRCm6yecmwG+J872mLbsYgLM5m2l8M1QB1Cs2eJtCKLFU8geLA/IFSGWkFgKvCQ4+VOp4wgvz7Y5LbUwwjQZGSjXy4jxWqCiEQyJNGslZTfA5+yp47yaNjKAlhwH9YDMRKNzbowRHpSyDQbIdySx8XORZAB8YGv2Pk8wtBuWgMSE+D9qu2YCCaX2s5U6t/YCVVsmrUHh6FfNdUFjA8/2Rd51yDFRtz8kMdY0ScV5C1znLaf/o8LWMhfzE3O9wMKsBRx4NxjUU4GVwUilUZndoIDNVDEzjTbSwdsDn3VePFXXpIHG/7pTYHuohC69giLZqA/vs57NSeOHY020XhGSypNwXfBKpOy4NlJBMlDWsif6ZqXfVeeh4yjfU9/YHz/yJ3EQ6SdHm8pfpCRudaQ4f7qqn70Y3Y1AQhuWwelo5YmyrjvnKutzjV6zm0ZfJrXZpLY9xmNVc6Dz0xA8HN7Gsy2Ad8tipIdB8GLyni1r8960CxWcY7q0cuYW0OfUMauV+FUrOPS9AYCuZC9qaU0pDTA/q9K/vb0PKGLDw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(82740400003)(54906003)(6916009)(316002)(6666004)(70206006)(70586007)(40480700001)(4326008)(8676002)(202311291699003)(8936002)(478600001)(40460700003)(5660300002)(4744005)(47076005)(83380400001)(2906002)(86362001)(107886003)(16526019)(426003)(2616005)(26005)(36756003)(7636003)(41300700001)(356005)(336012)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 10:45:24.9734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35995a83-da8d-4422-3900-08dbf19175c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346


Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 29 Nov 2023 11:30:27 +0100 Petr Machata wrote:
>> > Is there a reason not to split this series into two?
>>
>> I can do 5 + 12. I'll resend.
>
> It's okay this time, just keep that in mind going forward.

OK, I'll be more careful about the patch limit in the future.
Thanks.

