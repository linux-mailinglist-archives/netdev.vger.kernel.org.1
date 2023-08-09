Return-Path: <netdev+bounces-25933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8D0776346
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 17:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F552816E6
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 15:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C012519BD7;
	Wed,  9 Aug 2023 15:05:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D20372
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 15:05:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C8791
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 08:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKdRUrCGsuY+D4upZdjmTXkCd6sTdnDjPxxZgrb05sWEwXQhWhFTwqPnkCTDGws1JTBAXX+NfJa0DH1Xv/4KzrWwdQXwFg8c5IcpkRu5aaPkAwzBBJgvvGSMearUmGGxGf7jGQdxEMntVYFu6lsSQfNuxfS6IaBux8J7lnGr59Nwvh4k1pJqWgj7T9JWLxS8OIHkSynFvYWDxnNe5S2cw/ho0gGxsCVipxhcHJL9PHvKGT2iSHaI+BC3SOTAV0iKXJp8bfo4WhRevhrnPPdDCdE7jfXHDAPJwApWB5mbaxEO8C2B7BL72AoJtGGKIs0NWz+TBOLltdP4ooYb69IH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hXBbuCUvMcc0cK+s2ftDi0cXLQ8FyjxSoBPucOGNls=;
 b=YyapadbSB64/CeqRKxkCzsNFhlcG9GIdy8kw0sR49Gt2WqKzeaRMH/TiL4VynfHBb14duJGm7V/DQbr1PPCQ0DMKb4q+MEDLIAPrDiF8n9SpnuQg1R6siUYx3sF8+jk/cq6j1OYdyAw0nzBfnR/i1olVavhIh3lPVLmGqQlREAoHMKnQ9xn5cND4IeEySmPXvcT+NFKEIgIqcbRSFhd7zq3ugN1I18/Uaddefb7weP02/piKlxQ1j44YZSdm4y3sgt3k6LXsBGXS0CKUnmUbWGkSpOJhOFe9feedIYHhEIUHixHP+qy9fGm+/oq8Lvl+L8oKKkREaaXcbJPn4NvV2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hXBbuCUvMcc0cK+s2ftDi0cXLQ8FyjxSoBPucOGNls=;
 b=aHK2KJbEKis2kxrVQMY1iCaZFugy5TEEi62gmxbR4Y8nD04Z8fy1255SxBDK1zW/89TwFm1wJeoVCg9ahv34PwqOU7kp3QDDEj7ShnOlK46i0RYyyZvxy5uN8MNgbxylJ8Kjrm8nHkwGcpaA0kcciV8qvCa6Rxa8Jo2hBkD90ZyQ1RUlgpbVXooXPXF1Rx/58Xen9VBfkRW2NZCWWfsWAAEmSVyWkOHyK0EYqR4t0GWXcVL9hvlh7YcdUjeXI7qaAZ8ykKemTQW314K6k2e2qo14A0slZUElJsOJH5iTVcfQbRU0+Xy+G1Rp2UtnisNkd6QbrSfsaDXFxa02SCeXFQ==
Received: from SN1PR12CA0097.namprd12.prod.outlook.com (2603:10b6:802:21::32)
 by SJ2PR12MB8112.namprd12.prod.outlook.com (2603:10b6:a03:4f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Wed, 9 Aug
 2023 15:05:00 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:802:21:cafe::b9) by SN1PR12CA0097.outlook.office365.com
 (2603:10b6:802:21::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 15:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 15:04:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 9 Aug 2023
 08:04:46 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 9 Aug 2023
 08:04:43 -0700
References: <20230808145955.2176-1-yuehaibing@huawei.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Yue Haibing <yuehaibing@huawei.com>
CC: <jiri@resnulli.us>, <ivecera@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<petrm@nvidia.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: switchdev: Remove unused declaration
 switchdev_port_fwd_mark_set()
Date: Wed, 9 Aug 2023 17:01:25 +0200
In-Reply-To: <20230808145955.2176-1-yuehaibing@huawei.com>
Message-ID: <87edkcmf3q.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SJ2PR12MB8112:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc82849-f42d-4c94-42cf-08db98ea006c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DpdsGYD5fEW+R7NBk3RuK9xwx0FkbhXWHacjlRZIUpTU0bH+EsiGa9VCYbyPc6M56pTkKDCWY4rFBJrcJHMVhAylkrQBsvMLbzgjMDWqYSjklngMmXZYB+b0/WAwlSwzvf+RY09voGneiMy9rOJkK3REzHjP9k6yWvy1GoHhrKJFmqKqv2iKSbaBAoeBXxXxasBUppEXBzkm4TWcIZYfb6DdZCyHcgpV30EKxsvQMtECtjdfGBqcaWa8FvO8IoBaJdw6raLcCD5q+UmXhpZ45jY47HHqiDh9pByyey27qMhryHM4vpEUDiWANSAYcxeOIsRRXGBqo6DCQgu3OFuhEVFddGtE0htpnavzlAaSzD8o/+HIiwKrJm9aAXgyaouJ0DivcyDu6Iqd5Zih/nhoa3p02b/Vu4voApClGJlUihoPP8YtFPnNPUgvkij3O0qIYKR1JppgUr3ZyJawE4R5ClykPYi+KmOyFEZD+PIRJuSWRbaCCYCysgTeTynplXUrcz2DwqiW+5+QT2ox/qY7qYNnwioBfvh1Fxap3Ba5GyTQ87PLWxgNBPNPAjQtIUQVAjI9Q3trOnewJls+2Oo8aBItD/T0BCxNY116i7K+C20RpRX+WwVKTYDbMKFbRx+4dFYWVnbNzj0T6KwuGnOFDM6CWY3PUzvwSRzZzpzEWYcOlfRklH0rhF86l3QvqU+fRoP182zFOxExfh0T8pOeKr1jT3m9+c9gjAcwxzMjaC+vS8VsFGz2OiyoGQHd06TO
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(82310400008)(451199021)(1800799006)(186006)(36840700001)(46966006)(40470700004)(40480700001)(26005)(40460700003)(86362001)(36756003)(54906003)(5660300002)(558084003)(2906002)(4326008)(6916009)(70586007)(70206006)(8676002)(316002)(8936002)(41300700001)(6666004)(356005)(7636003)(82740400003)(2616005)(478600001)(36860700001)(426003)(47076005)(16526019)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:04:59.8516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc82849-f42d-4c94-42cf-08db98ea006c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8112
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Yue Haibing <yuehaibing@huawei.com> writes:

> Commit 6bc506b4fb06 ("bridge: switchdev: Add forward mark support for stacked devices")
> removed the implementation but leave declaration.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

