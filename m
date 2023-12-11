Return-Path: <netdev+bounces-55935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB1C80CDAD
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70CB0281E53
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03F54D139;
	Mon, 11 Dec 2023 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gnt3G5qR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E5C268A
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:08:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITCbkJpa85Lv+vUKKVCfWA5wDdgkrG8yQvs0h78CvgW9ohA4n0pscN8B4SKzHS83PTXKQPCq0UWvRixNgnNCaVoGI6oLozm8lcAE/87HD9vqpmn9Hc+ZiAxoZwPkCFnd/g3mWPsh+uG62eF0NdAepNIu0ebqPeV33USLbufWn/DBcEi1oDUtcJBOxAf+OkOxBt6wj2hSJO4K7PugkrCptcgadO5eGMQf/CG/5QVxuYuiri72jJxLSqYVMta1Qq8LuRMos+bStjOHzjsxVN7AtU4WHz3J1gMv8tJqpGMIV9wd0BK6Lvzi639dgmwQbvMMdY3Y6NHpq6cwOU/XH9aT+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bT/MIWOWf/FpoOQXEAlTvcGlfc7cLFeB2ulJDxNhSk=;
 b=HUkObmzinxc7b5sayOUJnVfPQd0uFYjGTbeWMW/0vRE0WYyx8rIG3xPJeBqIA+rmVZUU+P98/SEgLK0QkSpvCEnLhJTuI2h4cHhqKEN/RAmcm2ECDqEu4vQwnMt6vD1/cVvITbPR98imk6ZBuGEYboVz4W0esZnqA8GeANjbiqGM7XGZZ/hCryntwb2uHP+XwTrYEPYJ9cgZa/ExEidQtS0s20oueWZYr7QmbTAnmbVUxdUb685U74hvxFZwhabKczkQAOZL9p3rsSHZTROyVRTdMxYxB8+Pn9PF3VhYJsyFI0KbwRrv2u03j1FeFAOoqOBCjZJW8ZnWb0gc0QHy5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bT/MIWOWf/FpoOQXEAlTvcGlfc7cLFeB2ulJDxNhSk=;
 b=Gnt3G5qRStll1fACC7vN5QihPKquaduJ38G4EDbKyX//UsfkqPYzPJRceggoFwfQsfSWhAcY6UAObznLllijZPXfrW+kSsd7qDHWb5LM8h+K5P/WnvEovxhkP3gfIdFhPuOjCCijAXhqw+3bBIzp3HkT/aqaRBZ1/4R5TR1yi/p7cHXvaDnywq8MeCyYO6kUWP0CtZ3pU4PZ7ZQSrYn7+I9ez2IHe5AhiHmCqPiLlFqkwNXz6VNJ4/pef5VQNyc4L6AbyLLnAbyI7PmmebljI/09deUa6Ts51BspxXmju4YalChc/z/wOw9QhCE0uUn9ZvJDSFMFn/8rtTzuFFO9xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:08:28 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:08:28 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 19/20] json_print: Rename print_range() argument
Date: Mon, 11 Dec 2023 09:07:31 -0500
Message-ID: <20231211140732.11475-20-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQXP288CA0015.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::31) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 527bce7b-2485-434f-7a3d-08dbfa52a5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wkdxUpZvZ/wu2SbNXUp1nMB2gPioqJBPOS4EupG0427diXQoRHjDprHxcF5QBjrMC6WhfZ2OkJiZmYmH0EXzVt8sO3aAhNfc8fzS7f83LZ8L75RnUCQ4aALZOeOyxW3Dvjk9R64cQbrfGrcR7Lrrk3V3Rg3UAsaHZ9Cp3odcHf9fE3Pq3MB/Vi3xCKV3yJYBUWI6buFZoruWjl1/mVdAPlN15L1IEgTb3Hkp1NCbuzydF7m970FSXHI/EM3kijQW1FQ8QgJEJ+W0FAKzUAs2XirvsMSWBOZ54Dr+zl7syy56Pr2vWuZGYG8k3D+9zw/OuFWSx4uCjyDtJ9h9+gT/OcRqyrMSFEiMGqJoU22tgz8teo1dAFZUHL6Z1Nce9yhZGYaPnO54NsQc4MXSsZzCIvI/yrshEpjB6M0RWC7mznk6/X4l+7FHrF5inIodrG/LT2HPGw9tbYFf8eXdZXZ1oA24qDnQtprmLT30hyhqXqRabHI9yQ4cTnAGyohxcWqkRny/uQ/IyOEY8j8S55HYa1Dujw5vUOEKu2UjWvw6Mlm0Tt1WZFwetwOZA9tC4bUz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(6506007)(1076003)(5660300002)(26005)(2616005)(107886003)(36756003)(66946007)(6486002)(54906003)(66476007)(66556008)(6916009)(2906002)(83380400001)(41300700001)(478600001)(86362001)(8676002)(8936002)(4326008)(316002)(38100700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KP3XBdfqSZABXANEfXP9p+Yd2ZzZfRbHdSF9lHKy2MQ9szIBWjoJcI319E18?=
 =?us-ascii?Q?UjCbaPll/NOFaXBEK7mYVpxNLqOxNJRsko12ul4y7x70QXh5DROPP2Wxh3IE?=
 =?us-ascii?Q?DnyzQtwZYdMGIshAugCW3b+MIGWPQ0SOiLfMqJAYRqf0FKoyiOgbpI+8e+tD?=
 =?us-ascii?Q?hVDhaYNQwplrOQdizjfu0BqXGcKHYbDpajzQoxs3+7zmgsizZmYyCrL5toz5?=
 =?us-ascii?Q?YFN6W4mxEFR+hbCNegY+BYdIahDTA6fYKD7Xr5XKMWQmuf1rEFGOyv+u/olm?=
 =?us-ascii?Q?Amr6FfWpWthDqDZLQbiC6XkTVA/J3IBL/7evIhVFEI4xBtXYueFz3VWSHt/R?=
 =?us-ascii?Q?xy/lKE4/ZPhip0zCEuqZsUfzSTARXj6XAbAuiSBVGcOYrIpOf/DM/Uv8mjCE?=
 =?us-ascii?Q?bMaKNiCJAefkMAcgeDb1XwlQr627l82i6raIWejs+4+UcZ7xuQ1tfmdXJXbv?=
 =?us-ascii?Q?lEUlgoBRmiwmJqWBOd8xW4iQ3KpZvsBjj1gpDqxil+2yAAV06xpZIS1FWaul?=
 =?us-ascii?Q?BOpFf9kuTGx40XoCSvydK8yiQXBmx/F/WStvlltxvjnucySbyu/+RamNZNNE?=
 =?us-ascii?Q?DxBYySgu2Eb5EYWVKaIRMoHYnhlCAcMQhfU/aL/mhagIQBvBtAdqjcJA63mp?=
 =?us-ascii?Q?uOVkhkMP8Yy1NmvHrGEPT2Ab1o0pj1Xf4CorZx8BaAoYJOniy42/SISktz/d?=
 =?us-ascii?Q?PAQ7yWiw23kVgoXINXpH+EZ/34k0+bOz3bkV8sExs0VfTgY7o5QbEgXdsSYF?=
 =?us-ascii?Q?D/gjiNBVDfym7iDSWYj9jfVySS76IC/lpJd/p7thA+4qy4n7E4Xx+Jf1xmCe?=
 =?us-ascii?Q?xWbgGqjxvFJxKr20t0cr1HduIKpnxlZu+LE0+l580JOG3o2sbM1ZJUachMpj?=
 =?us-ascii?Q?pcBerEPFDNvYB/eNBESL2dp49QkhYTrgvDry8WpV3brPoDnW8TXm4YTsaW4n?=
 =?us-ascii?Q?ahwuFkBR/x20VYeJEw9Ea0DaXnZaPkqNOhO/0JhKYavD1LUnEug7StX6kRKO?=
 =?us-ascii?Q?P06t3jDs4y5ETp4Cx79VHa/HA0U2aif7qcYkt4kiK3dttQT7p6NEn2/qRjZ9?=
 =?us-ascii?Q?dt4m1KXUc70rwskGQFCQgb5dLPPvKGn/81WPluFfoN+pwrjUR697hVGpWYIG?=
 =?us-ascii?Q?DxabK0QnkLkh8jw6i5Zcm4TI7aG8xA+m6iOlx0+gjQ6s4FBN7aQItUrnOV4o?=
 =?us-ascii?Q?iBu0UpAcGXH7uSF+xEf5rquNI0KhTHFPUdGH/A+TEd0Rid7SlAUMfHkR1ONF?=
 =?us-ascii?Q?offfcIyuh6bwe1MQg8nizLBgJoNJoZAl1sbhX+YGPJgzKJ1rMUWA42LPVc0D?=
 =?us-ascii?Q?k5EAoyN+Rx0VFRX0RkvKcGZsZxHFvP3G2DIzqqpEcF9K7YbBV2s3Jfc5mzDd?=
 =?us-ascii?Q?oS0FnXsetMW5OeULG6yBn9GCmNGNsmF0IR8e9xO2tGTwPah/5G39IBFs9WeY?=
 =?us-ascii?Q?KCiZY1EW++98JPdU9VtmJWk8R3b3ar+zIXsIT5sCyWfSMyUZ9TPDOCJEkNvt?=
 =?us-ascii?Q?tLb36FcMRmn0u8I9Vz0XvFhtpheu9hnj61V9S4yWDSQy4jtKLkynwhOoe7xM?=
 =?us-ascii?Q?5sHgHx5mrqrealsDyYZrwR4geeEfcV0tf5J+uE0A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 527bce7b-2485-434f-7a3d-08dbfa52a5ee
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:08:28.2117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdT3wi+ukQhZYqjl7c/rrVAHv4FSfJ8KFgkDpMNrMLX44HALQ2Ko21IUb8Nxk7UobLNXzbuiRqNSH5UMwMcfUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136

The second argument's purpose is better conveyed by calling it "end" rather
than "id" so rename it.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 include/json_print.h |  2 +-
 lib/json_print.c     | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/json_print.h b/include/json_print.h
index 86dc5f16..daebcf5d 100644
--- a/include/json_print.h
+++ b/include/json_print.h
@@ -97,7 +97,7 @@ static inline int print_rate(bool use_iec, enum output_type t,
 	return print_color_rate(use_iec, t, COLOR_NONE, key, fmt, rate);
 }
 
-unsigned int print_range(const char *name, __u32 start, __u32 id);
+unsigned int print_range(const char *name, __u32 start, __u32 end);
 
 int print_color_bool_opt(enum output_type type, enum color_attr color,
 			 const char *key, bool value, bool show);
diff --git a/lib/json_print.c b/lib/json_print.c
index f38171ff..7b3b6c3f 100644
--- a/lib/json_print.c
+++ b/lib/json_print.c
@@ -375,16 +375,16 @@ int print_color_rate(bool use_iec, enum output_type type, enum color_attr color,
 	return rc;
 }
 
-unsigned int print_range(const char *name, __u32 start, __u32 id)
+unsigned int print_range(const char *name, __u32 start, __u32 end)
 {
 	int width;
 
 	width = print_uint(PRINT_ANY, name, "%u", start);
-	if (start != id) {
-		char end[64];
+	if (start != end) {
+		char buf[64];
 
-		snprintf(end, sizeof(end), "%sEnd", name);
-		width += print_uint(PRINT_ANY, end, "-%u", id);
+		snprintf(buf, sizeof(buf), "%sEnd", name);
+		width += print_uint(PRINT_ANY, buf, "-%u", end);
 	}
 
 	return width;
-- 
2.43.0


