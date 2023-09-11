Return-Path: <netdev+bounces-32803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E89E179A751
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 12:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265361C209AE
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 10:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D8AC2D4;
	Mon, 11 Sep 2023 10:35:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7D81172E
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 10:35:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8CB120
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 03:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXJ6x51a4NYrFdnaFWKBOYO+vF7QS0qj+PBXspbyUZl/dg+XEN6gJjptbQtK3AZG9e8M29inWTHthHNnt6Xidt9wCTlb8QYQXMDTNPeaHeXuCbDhTQbG1IFtrYTT9Y5BnC+aXwNluMFrCIIECksIoxBfh4EqVRBGCPDMTVWoa7dhDZVjvKc2CtySAuR3L5C/BtJHIg4DYWys2wI3hSe/pJblQEHKKQLDrOxh9viJMXrBFT3g2botj4lQu91XsBhVSHBYq+K2YGqrePiozMTH1px5GIeNKKkJcAZo53r3dRkHAdL4TC9k2MAo0Eu/UJEsKeUGjIqwxEDr5njJyUbEaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07GR6IsZYJZKDqXbSRJYrs/EwVEfLE77Crh/MJ381Bc=;
 b=HhIwdmCMXxaodO+R5xAr56uNf832aDbB7EfdMSa0orb7A4xFKmRuEb2yDYCJkpusW7ILJCgqtlmCy5F2iOTniKQTk8y5udhiGqHJuPp8DO0YGDupDh7hP8yNIb9dPy2LSS3ksuVQjoSlyTPsNWb1jGHHvG6KKm02in9WjcF0lwhoFeulG05aMxsx1947mfOUq7nsBAU3CnsLbkcB124sE4Nhkv9wUBq2GGC2r2YxdPL+bSvn7DKqqyw952dWJ58BCmGfURaHXJG0n3VsiuEnl22CcHrx2/wZZ7U3sZ7dMRqYyMItNHjMqrhFsm7DkyCTaa6p+j0WUbki1v1oFwAG2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07GR6IsZYJZKDqXbSRJYrs/EwVEfLE77Crh/MJ381Bc=;
 b=R1567OWSDEgcwJxYb57S9M6CQi3JLYx7aqfJ2VimJ9N6Tr/JmTXWV3GSAKzwk/jUzteRbKuPfys+oc4XLCmbsM90jZvddnrGcOwLkvxS4JgndtZiGFH0CvasVAJziPkHdIC8gxpLGsZad5Q5MRfIG+cjDoNAwVa3lvtrcEeiKF8Yx0I+NiAJVVLmf4UkJvRiv3EcQ/2GIDjeo46OAZFlKvwyzJItVi8mpIMFCFy2y+9FmwcR0a2OAa9tziiGFolmLd5yZo6q1G/BZ52507FXADzZPwumF9uUhxfRsjXD84QbkzotplI/Ho4SqIpE3W0afPUNBHmdpNodc8gaD15G7A==
Received: from SA9P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::19)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 10:34:57 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::74) by SA9P221CA0014.outlook.office365.com
 (2603:10b6:806:25::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 10:34:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.16 via Frontend Transport; Mon, 11 Sep 2023 10:34:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 11 Sep 2023
 03:34:38 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 11 Sep
 2023 03:34:37 -0700
References: <20230911044440.49366-1-elasticvine@protonmail.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Sam Foxman <elasticvine@protonmail.com>
CC: <netdev@vger.kernel.org>
Subject: Re: [PATCH iproute2-next] Enable automatic color output by default.
Date: Mon, 11 Sep 2023 12:20:02 +0200
In-Reply-To: <20230911044440.49366-1-elasticvine@protonmail.com>
Message-ID: <87sf7l3sn8.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 5837db07-e347-4490-71c1-08dbb2b2be92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U1iatqRSrMg+2XSQnAlX8o9dxySH91onNthPWuBtR9wpxO++2Uu6lPA9D8VwYPAhBoSTuQ79QTX0BgO2gmKY8DRPF0+axwI8jYrVv8kC/aua3EdKjlwzxbBNE88wasdGWIEKSo9kgXuNgXoMk9EaMBUWw1eAxoRHABZOA/7VK2WEhschpyFgP1Al9+qlsXU9EdwGdpQaB3tyw7iOclM5iRfq5LhhQKXUwOW77lxjpKuhcILLqp3FV8EMOSobS/IHQl9AUh1pbLlXc2v1YBBuAWVO592Py6nUbGkzstv2L7QBV0CTm2Q3iwkjToht09n2OXuPjS720Xk6N8lgr1AM1pQ7kuvm1kYRvAy6aC9q5SgejQrOpqsxODZh1JZtuxTa1l0uxrXXSrKnO87IAXkvEBWrN8sQLgccC0e+sFd91vgsN7bRLtKTso8DhtTI2Zm5S2YC9Jz/FEu6K1QCaX/s5ajBK9fhzbLYO0lguUcCihDWYSTQCpB2LkbOf60r8yAggnrgQNoKGwd2GXrv/dg5WfYBGJRpmrv6TVYmfERTGAZQ110T2EnyWSyV9GxPSkInbGWlEj+AGQ+/hxSeOK+8jYYLnf/izmskJJanWS+gc8fV1pt4qBgMU9Bm7raqbnWMPLFRe6cwD4ntDYADO0WDhC/tgOS8bkq7OknkzMxo2EB+tYDzrd1xvxuHw0YjUrnZ2iQKbMhmyYtW9inVUZlG4g0wmPbaocOkrpkM8gzvEAOpYbkri5AX73askTXsaZxN
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(1800799009)(186009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(86362001)(26005)(336012)(426003)(16526019)(2616005)(6666004)(36756003)(36860700001)(82740400003)(83380400001)(7636003)(356005)(47076005)(40480700001)(478600001)(6916009)(316002)(4326008)(41300700001)(5660300002)(8936002)(8676002)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 10:34:57.2842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5837db07-e347-4490-71c1-08dbb2b2be92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Sam Foxman <elasticvine@protonmail.com> writes:

> Automatic color should be enabled by default because it makes command
> output much easier to read, especially `ip addr` with many interfaces.
> Color is enabled only in interactive use, scripts are not affected.

tc and bridge should do the same.

FWIW, `ls' on Fedora is aliased to `ls --color=auto' by default. My
guess is that the reason that it's not auto by default was the
performance hit resulting from having to stat every file.

iproute2 tools do not have that issue -- overhead from those escape
sequences must surely be noise? So it would IMHO make sense to default
to color output for iproute2 tools.

> ---
>  ip/ip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ip/ip.c b/ip/ip.c
> index 8c046ef1..aad6b6d7 100644
> --- a/ip/ip.c
> +++ b/ip/ip.c
> @@ -168,7 +168,7 @@ int main(int argc, char **argv)
>  	const char *libbpf_version;
>  	char *batch_file = NULL;
>  	char *basename;
> -	int color = 0;
> +	int color = COLOR_OPT_AUTO;
>  
>  	/* to run vrf exec without root, capabilities might be set, drop them
>  	 * if not needed as the first thing.


