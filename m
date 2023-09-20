Return-Path: <netdev+bounces-35291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB417A8A93
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 19:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCC9281DE4
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 17:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027421A5B1;
	Wed, 20 Sep 2023 17:26:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5001A599
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 17:26:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CE6C6
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:26:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eP+LDfEb9N+Gog6bCB5G95dnNETTm4cBUHw/rewyFTqt7Sk0BL4p2aI//l4coFXzX0/e9/PhZkse71n4mg9+djHxHvTo0duJRiXeuoot0B9yTNBC/KTYsMusbWTttBNTFdDSb/rInBvLgdzVLKCBETkqXHxAIPPBlrf3zSSH/5FctTnAAWJZMAxj7Ieu4pvAadpATyNvK/bd1TDDIdiPcWUwNbe2DMyF9KYIbe7yLM2m5BItZvG3XzDti2yBFxDtfq04GZzl7U3Q8ahmMs9au1g8CrUYwz1DAljL+Gsuwrvm1uB+ybb9yOoB5nGItAwbxssyeCfVg89brPGzfeJ6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOmxGDCPpzg/cuQWCXLhTLvNc9grL1XTCDZVwBsTlAQ=;
 b=Xz1G5xv7DwAvRGQiI+6Un16OR/r7z9/4r9K8Ge+ohqZu0e9nm3EMKWR4g0yBxnHXMO/XG8yUxj8byyOtpqYBLORCkoX3hlgfEJEU9apAqUDa5ugVOQPh3EQwCH0yreDx7WoaoiUZI5blEuhBm7cILqayNHUstz9S9+FE6m18qw1Y90ImKG95MBxFagAlTDH0bp1gA5jtQkTP0wokqjFaImYOcFYhDOC5O7zeLK7BXHAggaG1x6SkEABtSwqrhQs9uW+RHhdNaV0OpsUyjazednPjIdH6NZTr6mnNi1e4T2UCseH1gC3xB19DaCNDU1KiJKXu3b2SQ4SbiJSiZWsISQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOmxGDCPpzg/cuQWCXLhTLvNc9grL1XTCDZVwBsTlAQ=;
 b=ZAaxgpgeqCcrs8DCI9TtcJP7rAJl8uEcCLqXyAhNtW6rTGuK8txxJHYN+EhHZLyHe5Et3LHN9/CgJuhcJEdf45pj+5wb1Z/HdxeHBKT8vG4+9uyfpI59tat+aEwQRMNPRC9m07Zgn9fbV5Jn2SN90r/5qdpbEQ95NHMd+Li1gPe7LyorR+nEPrWHxXm6MVuFrtJkX5OJv4RAqZVU6/b96pD5tj4aTFWYW4kBTgofxmxSy95WL0nQ48a9ErTNyhBYuQV16bZSjTRMGP6/D80z4XgRkxIHJjY/yWXrbw29lMYzDQnPz6Q8vBHDfWu0w5XKE6u7ejzljBuGhAZxMchvzA==
Received: from SN6PR2101CA0009.namprd21.prod.outlook.com
 (2603:10b6:805:106::19) by LV2PR12MB5774.namprd12.prod.outlook.com
 (2603:10b6:408:17a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 17:26:33 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:805:106:cafe::5e) by SN6PR2101CA0009.outlook.office365.com
 (2603:10b6:805:106::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.15 via Frontend
 Transport; Wed, 20 Sep 2023 17:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 17:26:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 20 Sep
 2023 10:26:13 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 20 Sep
 2023 10:26:13 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Wed, 20 Sep
 2023 10:26:12 -0700
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <olteanv@gmail.com>
CC: Asmaa Mnebhi <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<davthompson@nvidia.com>
Subject: [PATCH v2 0/3] mlxbf_gige: Fix several bugs
Date: Wed, 20 Sep 2023 13:26:06 -0400
Message-ID: <20230920172609.11929-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: f238e858-9134-4123-a7cb-08dbb9febc00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ufxI2JqIwOWGvwLgjYp5TPNuqbzIOZMpwB/gkqcL6WUoyR/vPPW/U7jQ0lGyr2dGt0CBqfsGahl2giJqnoF8UGNQXEoW1IEknbsG7ooF9mbAVtMGuLlvtLuuzVar/xoqEBrMgAe8LTVp5Al8zsTOB8Q5Zap7GsqB8YCQ8Iuv1EMVlNlRBUfStB0wZTiesro6LwlDZ+PO26Tj4kWLSBPZGpZohgW53uozlVWbRSrae58jpJxkNG9Sc5VGg/0ll3LoIw2ld8tKHHrs5GVWS7Hk4hBmxnTEfJonccyzYi35FSRZqiS/MCDHHYsDUwqeokQM2rSAX/JSWRO5eQsDtHYJYJUaYMJD2DTwDhr3dQWkPKBYHf+hu+p+P8AYGQqLra9PJ9YspZN3rO0rm04FZb3o91CUYXw1EMdWELlgwaf+HxPojerh7a4sjSwqdUMjWJcrHVwxZKuIoEkxYD7p8FmFLfC2RNDhIcUInoEYPJiI8EFTb7GeTM2eVD35at6s3NwKgttrXdfKNrGE5OS1ze69lGXm9Ycz5p/eocrvftP/xlaiZ1tQFShBhsLc0IUZP8mQMg3nsNYKGp58BiFTmWo4Gv29CYmKUnt2MBzFK9aBR/28gJJySk159aYVN5zsyWew669cscPheLiWN5brZCOjmluaefuFqtOHbLvSQbd7XnfacgdocpTML7+QTc1Cip9/EFDByge6ocHyjCU3oDSYLWp2+DwHkvG47hk9zzf3lOor3v+pGBLuXIvFJTprTUj4
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(82310400011)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(36860700001)(47076005)(478600001)(36756003)(2616005)(1076003)(107886003)(336012)(426003)(26005)(7696005)(82740400003)(6666004)(356005)(7636003)(83380400001)(86362001)(40480700001)(8676002)(4326008)(8936002)(41300700001)(5660300002)(316002)(70206006)(70586007)(110136005)(54906003)(4744005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:26:32.8642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f238e858-9134-4123-a7cb-08dbb9febc00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix several bugs in the mlxbf_gige driver:
1) panic at shutdown
2) no ip assigned although link is up
3) clogged port due to RX pause frames

Asmaa Mnebhi (3):
  mlxbf_gige: Fix kernel panic at shutdown
  mlxbf_gige: Fix intermittent no ip issue
  mlxbf_gige: Enable the GigE port in mlxbf_gige_open

 .../mellanox/mlxbf_gige/mlxbf_gige_main.c     | 45 +++++++++----------
 .../mellanox/mlxbf_gige/mlxbf_gige_rx.c       |  9 ++--
 2 files changed, 26 insertions(+), 28 deletions(-)

-- 
2.30.1


