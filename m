Return-Path: <netdev+bounces-34637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 724AF7A4F52
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C671C21877
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691741D6AD;
	Mon, 18 Sep 2023 16:39:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7461CFA7
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 16:39:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384D1E8
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 09:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TO+sE9hX1atzAsbVm5KWOd2VvFehJZd6LD2BVb2JrYkblihE5qhrfPZ3KaT9nHdvTgd6lWYBjeq1KUTWC/TCoUPWWfuMyWPRPviC5BGw4iZ/l3Cpzg+zPPRZ2HFqx85vkv+LaaywjOwgmF/hDaif0/z9HujGZ9ikIF9c7YzZnNEWO9wdr6UZqEUi1bd+I+b3wXm5QmtdHkTGenPCOZnq+LZZa/0WIQU0efQvYf3OtEC53Q5E4BNTryaHVLccX4Ukcyj3WjAgwlxXWc382BkoD6X4RXo2LXuvtlM6iZHOnmrTY7q8DAVfp25h2jUGgt7IPdCxgar6SmW/4WvN8soKAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wga9zWKtPHVyKGzjUfoHaq15VBOqPkyI8N9maoOd11A=;
 b=ic+80xOai7HXnKCZRzqp57delLrVt1nqsViFqypjCMv2XgSsQ2vng4UVfjzUCChRifgkdP2+Xb6BfNNGX+YnO/iWbxCaKaJNDvKT0FuOGOb6lPkFYr6Ss9lK2VqTJ7S1m2LuW8zG8E0Zqi2CkV1uySY7z8YP8JNuAyWvAJp1gloUzowiLkOV/raY4zkRPKA39ish0QiIUNk4rNPYQ9NNc0oQlkZwvlP2ktZ7O4SISHZQkJ+rYUyQoWw//v+HKgcUZNwtth74ivT5A7MZKEJSK1D+T9IS1q8om+Oyw+oHQbMHfKlWu8j+8WBTfEdiLR7ckY4CmEmcSt3NB/1A7YnxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wga9zWKtPHVyKGzjUfoHaq15VBOqPkyI8N9maoOd11A=;
 b=YUp3MFMbwx3+QOHZGQYf0yV5R0vBFp4wVugpsEO4V0/9lBQBbGYvcGuAZFDqPxpESEya6Q9RhSvxVGVriTqKTfk9RUAZHRNe8rBgKo0rZW03NXJ/WImsnPZ5KUZqlr8ET1nXgMB4Ww7H06NwAdK1Y9JabKcKvBavyEODkJYBgdus8yCcQyRJ60SYTTtk9wJOYK/i3XBoJNnYp0qspsMGO8LY4u1yDlxy9SneNBDDXLkuv8jhfiTQ8NwsPaJbW7jFgtZeByn+VbrCUbz77fq5rEV55A1YSpP/vKeLVEQsU74P0nBhbOAeVaoeTFvsPDXXvcfEXqcpzng49Rpv2AJIFw==
Received: from SA1P222CA0130.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::21)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 16:39:21 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:3c2:cafe::48) by SA1P222CA0130.outlook.office365.com
 (2603:10b6:806:3c2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 16:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 16:39:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Sep
 2023 09:39:08 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Sep
 2023 09:39:07 -0700
References: <156bb2949a091c8daa1ce1f4a8c6d7125eaad7f3.1694807902.git.aclaudi@redhat.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Andrea Claudi <aclaudi@redhat.com>
CC: <netdev@vger.kernel.org>, Gioele Barabucci <gioele@svario.it>, "Stephen
 Hemminger" <stephen@networkplumber.org>, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH iproute2] Makefile: ensure CONF_USR_DIR honours the
 libdir config
Date: Mon, 18 Sep 2023 18:36:34 +0200
In-Reply-To: <156bb2949a091c8daa1ce1f4a8c6d7125eaad7f3.1694807902.git.aclaudi@redhat.com>
Message-ID: <87led3xwpi.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: bdab32d6-2f8e-4922-3f93-08dbb865cfaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HNvZHdAxe3cZTdx/5EdJ+3F7HNpy466RGIfaQ1iQWWWq9Q2Fy7o/d9m4ZCO0gtLctm2UDZGhnsM73HsGvx2R+wDajbETnORCodWn58UgbShp+KKYxgjnhHB3kjc2dBP85xuSD9yrODXIBWORbpBM0XGmCqQ5hySDBG3JKtHaQ6u0wNPUfVLkAyLBHlX1aJMcK1+5wRNcUcSqsEQ9xrtbcLwIf88HZWXVt3Ji++rdI5aEG84aBOBpJMH6s4CAWslevtrU46CxZbnQZM+TlwQUDR1EQUp993m3aMza0TJuwO8BTgAkLAk+B+ez/DuqRnG9VkxHPe2H92GXmaqzSEXSh9GBXm6v6qBswwrKkSlGQp7DDd/9/6zzvKNvqRxxN3XDRB9X6WxmJrE9dMt+Jyf7F73YFOCd+eMjZWIuoAII04HMDG7SbtSO8/JKAhaLUPY2+RpiAxt1Pr7S8CxhXw1tgRoRYerzJtg10Yj5KteHHPLUA/xYTwqfTJMlKGkCmnlUIrGCE7UwA0YwSwfoCmHLYUH6kQFqRGSQCJiGBJCypTjxxLpe2Xyz0oWr5+Xkr0dhKLzTvJ78x34N8fe71H9put89YlT2iwyEi5FH54mbfIxNyYiL9lrGHl820+FoRqMYt/+JAlhrLDRmO6GyYSbv/pO2X5XXvsiy6T25mMq9cs0ts+/9A6p29ZTqMD2+0zOxclbTDJVI46Ut41WzDboPXg+VZa5vnqOBoKUpDkCihr4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(6666004)(82740400003)(356005)(7636003)(86362001)(36860700001)(47076005)(36756003)(2616005)(426003)(40480700001)(336012)(26005)(16526019)(6916009)(316002)(41300700001)(8936002)(8676002)(4326008)(2906002)(70206006)(70586007)(54906003)(4744005)(478600001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 16:39:21.6899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdab32d6-2f8e-4922-3f93-08dbb865cfaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Andrea Claudi <aclaudi@redhat.com> writes:

> Following commit cee0cf84bd32 ("configure: add the --libdir option"),
> iproute2 lib directory is configurable using the --libdir option on the
> configure script. However, CONF_USR_DIR does not honour the configured
> lib path in its default value.
>
> This fixes the issue simply using $(LIBDIR) instead of $(PREFIX)/lib.
> Please note that the default value for $(LIBDIR) is exactly
> $(PREFIX)/lib, so this does not change the default value for
> CONF_USR_DIR.
>
> Fixes: 0a0a8f12fa1b ("Read configuration files from /etc and /usr")
> Signed-off-by: Andrea Claudi <aclaudi@redhat.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

