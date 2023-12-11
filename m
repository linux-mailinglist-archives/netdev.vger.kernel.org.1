Return-Path: <netdev+bounces-55928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A5880CDA0
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF143281DD2
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1319B4D135;
	Mon, 11 Dec 2023 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M7sk5v9e"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A614223
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:08:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLVCUp443MLTL2v26fPf3xjn7TYVUKSh49bjXwFOP942AUuT6Z/HMOdVnlmIm9CZlrvPdEUMaWlPqpJ0UTJhj7NHFQ+emmOGf1JVOizy3rvkOGTKtdBHQzt0LQpVNKGBI9CZ1CalVLEuzVmQGkXMi9Xmv7PSJmjMIHrjshow0wPYBvHoVUarHGyfdrtZTeL74Z/qnJz/u1hosQMdk3vzdmpECxOcVkWO/anItZhK+/WHfkgNw6W0mtoNWAbe7Mj6Cb7whuGzurNf+sw6GXPhk8luRgxeuvSOXmqzi28MsdUbOTRJk+xa8tR70zfr8NZEg25uqYdLsHHgTIGMW+27UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXxcryJrq84VzIo1vn00GcFtws8/MXJ0Vkp17jEYEeA=;
 b=mxt+uwoGUOUDsdbNTuugR8GZ7Zk675NqT7/rD0VMJrK2Tra7pE25AOxW9jHJr0ZoPvsPlQJIxJJ1cNsS5Hx/cftbNNvVIyJ/+q6vzIEdGRZKIQ9/sjahquKbfQhQnhJ2ZIM8ichPrqu653xZMyGMhuFL+GXkRCAO76xlE1dsnu00lI1OtZmF/uvH2Oq/8i1edNQpVupIQrqWho9L1uq4wMD3xsWlTpVvh3YzCmT1mmomCdtr/Mg23EMnDw4r4coNMIt3Zgn3IkSH9Zu//77ftvZq/7l3liEfau0ir1shC9an3lwjCkhs1oIqc8HQPwkh+b0afh8FYmEb+E+oUucLPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXxcryJrq84VzIo1vn00GcFtws8/MXJ0Vkp17jEYEeA=;
 b=M7sk5v9eX3rQjp0kbxo8D5HENwteH1xJlDorrqSHwaX9+5i207eTloQJzMsUZJK1KhGrzTbGanOZtI7ihdWEQ8Q77eRsfrLk8dux52onSvwqtmYc6YNvRwOg4eBHJA/AyY68FDeSFpa/BHtRQzc2HLPlYpzw8PXiFujVnmpUGXBTWH09tyWeroDPSuYgkpVzmMPb3cVMaqM27rs/iGeNzaNHpVS6TDWl6lz56gSK1dj63TatBdpytFB/ZRNDh0Jk/MlcYoQjmy+HgUtQgC1gBVr1yz3IiavXDCl2AO5y2Ck79tB4QT34dXkYIMK3ze4b4VaTe6+jmdC6vxzBaiv4Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:08:09 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:08:09 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 10/20] bridge: vni: Guard close_vni_port() call
Date: Mon, 11 Dec 2023 09:07:22 -0500
Message-ID: <20231211140732.11475-11-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::20) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c5f84c-689d-4b35-16bc-08dbfa529a5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6kiXxCuby2mS8UAxlEWoEfdHLxEAIlTlqH25bLM8EQMPr07vXxmN6RVJnhEj9LuO6lyokhoGjpvpm5ElO1qV8ZWSfC/aWneBuzG1+iwldT06AeQN/LqN4FPXAWY/o9vVs1cpNqcdK9N8wt0DNnMX2OG4PKV74+miTGx8C9y13MXjcWdqzMLzal+qQzYsR3vXcbGDExCvaAYWYQaUEJ0WImo9KfXjrAG9AtNf+njEhszZgJbslWi0eavbxB/uhPHxbK8JvIHDCn4+11wTVv4TRXnGqzu5Snq3P8KLMDGBWbAKHjpT1j7g97B4kF22lphGYxkGg4c+HD329FjoJ3kqX4Ma42zL33cZ45my77zwyVjwVukpX8t1CbiDXWRUwSGnv0qDXEen/X3xWBBXY04kNJh7wu/y0mRlnU9wS6wUSZMkT/HPghUfcCy+ZcskPGTqQhBpL7ROpqQcgQCwmjD4iIrBVoUjSPHKpu+22Paul4LUZ7EtdaANjcOT4URkBs7LL+SLXOcN9TR2LTWSAQpO90NJYAlZhUIp/jmPJegyintRc+MHJwpplfvjqXkOwaEr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(316002)(6916009)(66946007)(66476007)(66556008)(54906003)(5660300002)(8676002)(8936002)(4326008)(86362001)(36756003)(6512007)(6666004)(6506007)(83380400001)(107886003)(26005)(2616005)(1076003)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BR7Z4TF0Y7G8fpzH5+J5pwMTrSQnRhbAo9SCqxCsPaehC4UNCpDDZMwf6zcL?=
 =?us-ascii?Q?sfsoNcTUMXL6VatgBrEwMtEwgpCj0c430//j5JzdkbxYwLBbdRHMOCm7GkBR?=
 =?us-ascii?Q?RhBbv15lYc7+ZbMKDd/CUgiHZHcDm9X5CIXHHfPL5YFCvGlKCu/5Ig1dZuBy?=
 =?us-ascii?Q?U2QJDqUQ6zNAktBQYxl1L/U6RPnhhDODuHaIpvqjmKYtTeE1FfVMMke3Lezd?=
 =?us-ascii?Q?Y3pLE1HhkQUMppRUdu13iHpuemEbkYcEtm/EuZCVnUQcamlRL06wtQyFdQ+C?=
 =?us-ascii?Q?6eyNw3ibjvAVtZb3qo+H8Fraq51hQw5nt1rfT9AKWJHRX0v2enCAm/M6lbHp?=
 =?us-ascii?Q?hx8DbbdgbBZmCdqPCC8DJJV/Vc73xgvmrNK7t9X0GAjbU3NtPcRJKn8mF1wE?=
 =?us-ascii?Q?HmyWAzCj3xURBYrxaa64q7lCuTogbYRJYYMHLHABoIjgWupmBzn5BkG7nVr3?=
 =?us-ascii?Q?bRtlwcNdj7okBeRZ7ontcma4FGBjsNafVEnWYslM72ISe4mafUNKmzDgLt9h?=
 =?us-ascii?Q?CgvCSbqRsE9hsYOrRyBNuUq3pLtDUrndzFQCqSJSsA4PxaH/kfIWYaQN4Ieb?=
 =?us-ascii?Q?k3nzrxnRrvzHvazUJ8jc4zfZ/Yegt+bx0Ea8gg1BraYUOTGvC0dmMiiqimGQ?=
 =?us-ascii?Q?8d1+Cxkl5VPWsUNg2eLxkSAaZ6NJz/2GVv1/T8A7ZB5Dbu7eehuKnwUVoSj4?=
 =?us-ascii?Q?OKFCg8DqM+gef1t/Bc64cktWwa9zqwdwyPgXYzbXrApZp1qIEoLrfQ1p+x0g?=
 =?us-ascii?Q?TgqfQr4ZYWdk0JNpwt7MOW9q3hoXnDGoULBfXxMgma+W3Tx6BOeoQHHbCmCk?=
 =?us-ascii?Q?fU7ZNFqKnRKNeCy6gqPPfOOnzC7sbJSATKhX9ZhbklR5YRHfPsAYTGr6UMgt?=
 =?us-ascii?Q?YvPNXYMsqq91rrwi+VT5KYjoPYuAtYXXQ7JuIBeilQhfft7ka1kUVVfMxkxH?=
 =?us-ascii?Q?Q1Z0Tfy4bzPPmdpj3kPTUe/c54X92ZAJY/OrUTQzUYAnjN6kYNQF9oPfx8Rd?=
 =?us-ascii?Q?2O+PzmDfhaC25nwT/EICMzPw1cRZAlwDkzG1Rngoi3yrWMuAmzqZ1Uha3SkE?=
 =?us-ascii?Q?zqjuNqNA6Lh34GVrxj4//51ghG7dDyemKBv4fz+kfTmSs8cUbBjrpgdPsAHG?=
 =?us-ascii?Q?7ShDy/miQrVZILAyXLdJScTITDXHKmxPwN2o1YMgGv2w22Zr7okFsvgSVLF0?=
 =?us-ascii?Q?h+bHG1uGPVYiUvbtShLUSzLX9hEleRXkd4LWpeBoeoLT9QHb/ydSGaUi6Wtg?=
 =?us-ascii?Q?4/VUW5P6Q7OR+0KYwAlkpL+/bMr3Hk4FVv9LnXX8j6yYNGt4zjomZg6FfVkT?=
 =?us-ascii?Q?72l8mSjEssolhA2sU2QkDxW2lOu/HNqyL9L+LGspdZKeLoP8608Qv0Pbq4Iw?=
 =?us-ascii?Q?oUop8Uiw4cCRFz+e8k/saghKVrCGozrBE0mLad1CwVwYZ+XfqojNZPr4gD0p?=
 =?us-ascii?Q?kNxSqVjCmVtElIEUhT30kLaAZEw8yPJHEGXKvP5a3p+kTbYeDdOEukLMTbER?=
 =?us-ascii?Q?gj+IM1f/oJ+mVQT8cEGKryhp9Zw0Cm5UmeV4tGgzCtU6vh8Apyke7thLWWC1?=
 =?us-ascii?Q?WctPwlJCs7T5y/LWljzFKRDhkMD/2pwFt1pZKrnPfrU1eJEb4WXJVAqZ8a4h?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c5f84c-689d-4b35-16bc-08dbfa529a5d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:08:08.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHKhDesEWz4QjJHCvJY0Owca0ZwkU3+rtt1OVyvgfim8tUZE+GqGbfHe5acSc7bcO4fI7zbUhH+QXvrJ/8d+Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

Currently, the call to open_vni_port() within print_vnifilter_rtm() is
written in a way that is safe if there is a RTM_{NEW,DEL,GET}TUNNEL message
without any VXLAN_VNIFILTER_ENTRY attribute. However the close_vni_port()
call is written in a way that assumes there is always at least one
VXLAN_VNIFILTER_ENTRY attribute within every RTM_*TUNNEL message. At this
time, this assumption is correct. However, the code should be consistent in
its assumptions. Choose the safe approach and fix the asymmetry between the
open_vni_port() and close_vni_port() calls by guarding the latter call with
a check.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 bridge/vni.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bridge/vni.c b/bridge/vni.c
index 8a6ac245..ca5d2e43 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -341,7 +341,9 @@ int print_vnifilter_rtm(struct nlmsghdr *n, void *arg)
 
 		print_vni(t, tmsg->ifindex);
 	}
-	close_vni_port();
+
+	if (!first)
+		close_vni_port();
 
 	print_string(PRINT_FP, NULL, "%s", _SL_);
 
-- 
2.43.0


