Return-Path: <netdev+bounces-55934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B21580CDA6
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2A71C2106F
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BA54E1BD;
	Mon, 11 Dec 2023 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MQNzjMZ2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAF6A27D
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:08:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZ1+4yNW3EkFkaFRpp5cw/uavl9iYHQLpftsGjmFzcLLOUpHvX7Mqmh9nWmwZHAxWBCLgGHLS7G32NIUEQp2rnRL+yZw3tN3SzUsik2mS58nH+g8MTHPHHDccw2c5LkcgJllMf8n2dmhX2N6Dqn2zjoBzRxEeeZ8wJS5r1nkHSFDn+2K4p/8XVZDyPtcQm+Us/9HKfmQBl8UfB3H23b5kV4NVRpJPOZgZF/cKlSTObHpOcwruXoEkvsMhpMDZGF3JhKPYPDfrAttrjy6AO7AqAMVrjwgTB6AxcYAORHHqQpqJlsAypbrZk64+Vh//3lIify2OYZzGAVumKQqpWaquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WLBdPCV+g2NcQI7j912WueceHHf2JgDu/PD93Kkv78=;
 b=CoQYwaOqB6DbmAi7yHPQhRI0MkQTxLqXE6BHh5I8RJi+G2VilRbxV7rOYB4WHIi8blHXA3JSWoKJcmVlU+VpKF8JY6D1HdG0X3hqbCsUGLe1nAj3yDSU8Ky+rc/hZO6i7ifGPwnRmjJPMRYY8qjS0dVAkdV7tFPnW6By3sQ4tL6bJA8YN0Af4N+0Ec0HVw7cbfyNJq1mQQ9U+3TCcDo0xMJ6feSW7mnZD6H+AYMk3+bg59pOmzVwGuqRs3aLn7oyUFDEUrbjF1r7FHubhUFb2VkNtOM07skQYmYu2Hfn3Ktq7czjfVaXtsitoQDLcR783WJobpgUbfrRJJMfUj+AtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WLBdPCV+g2NcQI7j912WueceHHf2JgDu/PD93Kkv78=;
 b=MQNzjMZ2AkG/v66ZkVBktNpxyTXqLlFBJyKC+qD0u9fiyEvLB9urdscdGN2ue/qjwd2lrAG4fRoygU8BRS3lK30ANMeWPTiCjOYXHTShpuGeHRrARBoCXvZWrz8p2PK0+mKosCfmE5Jc4smXkNZOa4wQFCbAhbxJjhdjuy0zJz2jzgNm3EuK8+AXpRyCV5tCR3t0P7aSoSH0fkqPjNPwuWjRGrg/tM58Qaw6EIm9EmSvfbjBWL5apF+oUaUHp7/t+Dercig1H6t5Q4abGwGqwIN0qhF7NIsYAODQaKDs1Jj9dMFf/heK+ReliPkY3kbmuY89/JEdO43GLQykreg4Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:08:26 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:08:26 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 18/20] json_print: Output to temporary buffer in print_range() only as needed
Date: Mon, 11 Dec 2023 09:07:30 -0500
Message-ID: <20231211140732.11475-19-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::33) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b6e7e2-4cbb-4569-34e4-08dbfa52a48b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KoTV7x6gbt+p56oVM1tH2DWf8k7mhCu3s1IZQ1lI//QxuBvGAllq51VruR3gLTXJAmwQdiHlyJJUv622IM9mDdFtLBBKUYJm/y/jtdTHZ3EQ8U1quJ8iRsebVvACv2gaeI+bJBaHZad5kw1K5Ndicq5IMERoouQ6tqybmRqmIRQ5FxYV8xTeUbTq/gqt2b1l0tu1CksQilHgJbYdK1Nzkz8QUfPtagKk6EEtdr5OH6H2WGV+chgGBncewtlOeVeZMwAlAbBYcX03NfBr0Tc6RYibMk4c9RS29paFqkDBHeuxKCKULDurP5QahGdsGirV9mnYjgNITRyKRMiLlsBpLJSeZFtQ+bYmdpxRVt4aA2gWveERv09BTghx2z5iNYaj4GmLLJ6/R+4P0tMpFsy1E0jOFcOP1/FxG1cJ7dc579WVpxP83Q61iaEIsTmwmDGmpMO6/QQtJWWWl5G/W9NuCPbw2cYyNc3Ap0BAzdX9WJIVYefKRkuY5UgDExT0ThWfbjaa+SjChDNtHPdk7vZF5Yk3tRR2mDNFovcsUrcWyIP340RU7hAosVlJ2vSwWZjX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(6506007)(1076003)(5660300002)(26005)(2616005)(107886003)(36756003)(66946007)(6486002)(54906003)(66476007)(66556008)(6916009)(4744005)(2906002)(83380400001)(41300700001)(478600001)(86362001)(8676002)(8936002)(4326008)(316002)(38100700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KvqM60i9IXHZGV2Wmj7s6cbN1NGazfvB2jXN8txyfGWYTVYhGclsVVBFd664?=
 =?us-ascii?Q?AUUqWL5petI6dodDFZg8fDm6TfdoBc3aknPupPtJLGLu8pXWlyQdm1ab9sHY?=
 =?us-ascii?Q?LsVtxd/RqBNb/dTGe0Ah7aYnmgjrheuLNMSv1cKl9oYno7RW9Gk/jj1ZAweC?=
 =?us-ascii?Q?yjaNxk+WqDNz50Mgkoqrpyw54gyzeJMhETxf2QrI5qB3hfBMmivGH9zkzyrk?=
 =?us-ascii?Q?gFrbGSxyW5ZP6DMOsHsoT4EJMKQykKff8hQ6eeKvX+g4BOyb5ZJMuAtoMw8D?=
 =?us-ascii?Q?HNzxPalFZwxXKeMFxAEHoMd7JuucxxE4vFXSkYVqQWCEfeH+HkeZzcOyB+Mc?=
 =?us-ascii?Q?Znz0/4agJPfa+6DLVbnU9vvby35eQ2/f6mO93UYy+NPmPBPSKyEeqhtlSC0L?=
 =?us-ascii?Q?dZuNeWYSeqd3ACM3o76Kk8sdUExLX6MT3KJBtht8H11bDDzW7u8oxty2sr/A?=
 =?us-ascii?Q?E7z5fMgtXfleYyKcXb1EVG0PZJwmRce3dqdBCNaOpkUR+ZU4u+98p3jr/iCo?=
 =?us-ascii?Q?PXxLAV0djM+L/OthLgsa+dOyRDhev2jzWm7ETeMZAVVHz4P4TiyI5KeOLzTI?=
 =?us-ascii?Q?bB/nBYLJGUT+Cv9YgOmlG8Fw90ZeeH0Jsq2PPcbNqhyD4Ki1a0HDAZuIBgvv?=
 =?us-ascii?Q?VUdLZRe0H1ydSMOfsI/vMgWtxL6pS2NPF/RGY4X5nxvsn8aT+LxMstdhflUB?=
 =?us-ascii?Q?Hi7KR2mlBBgM70J5xZ7znoBMN9TktVnnLAT05zBKbDakohuqoBgLzLGRHPgj?=
 =?us-ascii?Q?2WHFzxss2QUU+xcF+KrjUdLjq9f4chSSLVJPHH1MG8qOHjNhjVbBK5dpSRCX?=
 =?us-ascii?Q?gssgBE7bWur4+DaUBJVCoZfxDc0OZs/ypG0F4zDzOtMAirsHzZHgki4NwvcP?=
 =?us-ascii?Q?Uoea8igqfe7t1COMRs3Mni3aoz9uFmbGFDB8tYr7pzc72+cE2gpCXPQaYoYm?=
 =?us-ascii?Q?pPlZ5ge6+BFKrVqZoeEW0KQMLDjeM7vVguCe0xDLSERJE0UmziNxcbu6DNCv?=
 =?us-ascii?Q?+sux8goHpocYOFNCEd9iKPuAtDJLBj7ahG7/uLHvFY+JksA75QLKr0MtaRvI?=
 =?us-ascii?Q?vvwgtC2CZAEwsNbzGh1tXZb5cq1Rb76g3E5/kalnJkKPCxRBgB0fb0WR/+qi?=
 =?us-ascii?Q?EyMaM4VGgCNPE8Z4y5qZHyFqJcBBjmxrnXeeY/gEhRBphKMo5Dv5+Hu8bOS4?=
 =?us-ascii?Q?0B2rwtdlhXSnwRfy8VmY6uy9Cfuocrnk25r2V2mR5cNTiL+58EAgCsIvMTKY?=
 =?us-ascii?Q?uhRf+KeAM2VNwhnqjEddnjNmaSwjWvoW8uz4O7obiVTOsqYfHkay/tjRxrQu?=
 =?us-ascii?Q?K69IbYBbU/XhWDrels0Whbe77ZFR/p6YH2iNACFu8FbYt01u5fvLa0gze6aP?=
 =?us-ascii?Q?oB0gGQd6kJr16h1lcWFkver/DpFjW/Q9lSIIYAXaS3ggR51G4mQTE8nh9llT?=
 =?us-ascii?Q?ZTgJJnI3uKjR+Aj3OIOuDVg1V8A4QdkbMLwh/vCk1n9XG3sITHZDUosX0i+t?=
 =?us-ascii?Q?Owf1DdMIbVOAwcFNojN9AVY81seUOhSrn6XkJ0X1QJpqytO0SRMfmrvZhcMJ?=
 =?us-ascii?Q?RTqfsHiHEP7WwiCjuaAeJaRPPmkcM08Z/G4BwWRUU9Ti6ZHp0pMZ6umJ7bbK?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b6e7e2-4cbb-4569-34e4-08dbfa52a48b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:08:26.0403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9G6py+KoTrmF88Pc5iNay57+QF+/qKAwFvrCaHdurq+f/7964QKxYO5H91XBVVCZwz5Dsgwkf25uDXAc1L5v2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136

The string that's formatted in the "end" buffer is only needed when
outputting a range so move the snprintf() call within the condition.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 lib/json_print.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/json_print.c b/lib/json_print.c
index 072105c0..f38171ff 100644
--- a/lib/json_print.c
+++ b/lib/json_print.c
@@ -377,14 +377,15 @@ int print_color_rate(bool use_iec, enum output_type type, enum color_attr color,
 
 unsigned int print_range(const char *name, __u32 start, __u32 id)
 {
-	char end[64];
 	int width;
 
-	snprintf(end, sizeof(end), "%sEnd", name);
-
 	width = print_uint(PRINT_ANY, name, "%u", start);
-	if (start != id)
+	if (start != id) {
+		char end[64];
+
+		snprintf(end, sizeof(end), "%sEnd", name);
 		width += print_uint(PRINT_ANY, end, "-%u", id);
+	}
 
 	return width;
 }
-- 
2.43.0


