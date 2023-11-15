Return-Path: <netdev+bounces-48118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C94B7EC979
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F821C208A3
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5801128372;
	Wed, 15 Nov 2023 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZT/YRkws"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDED18E
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:16:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQkkM682oqWtPMhAv1Tas2bFZLWgsN/6TKsp6AGTzVWSPuHxkEG/+9RkJKv/qtbBGNNFHCq4makczmZAT0cwfrpwcb4Wx6pseaZ2kVSCpdbkDW85C8euLmJ4n+RaRzW3VqJHMzEeIFfBhhUWwuQz5PwI0zNBSAVQSVLc8q5vBZhPMJu2t4QRsqmMYoXzNbnoO/Pa5n7yJUsnLWHwvKzt8BfzTWKDLh17eMb8yGX4/X0Gv+J/gd1sIta4QeDz0B1atZRqH8XZP/K9TR007Ehq/A+kMFK2rwZj75aBRPyFcw1JFO9daHYb6Hva13aTjovcae7/2ERPmifeH5XEh8SQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcPU6Y/Q6LChQBjAEwrH7EyDvZ2eZzqXGQlTUphjJkU=;
 b=ZCCKQZNHslO1Wpun4bVByLVj2MSunPTWaHmr8H3io//aIOKitTZuw/W+ebY18pYmny3R7RUz1n3U01g2V3yj64llUNSodZptXSU7U5UjiZ51bn7BA05H4TE5TVkmzu9EgPsDLTzK82x1emUEzom3wNIrielotL5jRAmp4bwQxpNn+6Wg5dAhT3bW+uOrCFZMJb10by8goOKu3B8r2gJMnfpWXFGi8qPCL0vJjlgIaPNK9HqxICeZ/ogtFnGWo77QA6r2vgqdelCqCmkf0T16Q4XCKUuh/hI0jYx3oA7cMJrxzICwjMGoowndmhkrN8Zq0HrDRnZ1v5GQRZiLpTLepw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcPU6Y/Q6LChQBjAEwrH7EyDvZ2eZzqXGQlTUphjJkU=;
 b=ZT/YRkwsMSXUWmQcjMU816jCBSp+INZhQ2DMNryGKAmCMFyJHtaVzsyYdszDf5H9CnCzWdJ7gCGBny+E7RwsNyRakRhiH7RgbKv5Msxb6mFU2W6vXFIhS0w1clXoV2H1U0plKm+Ll+szpPBtkBzeEOYtHx3ywamtpF62dnQTLXihsH91EyI8kvlb7Un978fnEzrXmLEgPKOt7LaV4LjMBkB7pze3ZfaoO+bBxcuTLb6UnejHg74/bDsuQM4a3WgMYmhKKH2g06jn2hAhq5vcrTAadAChpD+NxTs2WlHjmPQ+IRkJ08EnyjZtFG2nEQ/dAH8K1jOt9GeFa4YBF+ZXVg==
Received: from CYXPR02CA0062.namprd02.prod.outlook.com (2603:10b6:930:cd::25)
 by SA0PR12MB7092.namprd12.prod.outlook.com (2603:10b6:806:2d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 17:16:31 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:cd:cafe::f4) by CYXPR02CA0062.outlook.office365.com
 (2603:10b6:930:cd::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Wed, 15 Nov 2023 17:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.19 via Frontend Transport; Wed, 15 Nov 2023 17:16:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 09:16:21 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 09:16:19 -0800
References: <cover.1700061513.git.petrm@nvidia.com>
 <8ca3747c14bacccf87408280663c0598d0dc824e.1700061513.git.petrm@nvidia.com>
 <20231115075921.198fad24@hermes.local>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: [PATCH iproute2-next 3/3] lib: utils: Add
 parse_one_of_deprecated(), parse_on_off_deprecated()
Date: Wed, 15 Nov 2023 17:57:27 +0100
In-Reply-To: <20231115075921.198fad24@hermes.local>
Message-ID: <87pm0bvswu.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SA0PR12MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a3a2b7-22be-40f4-5ddd-08dbe5fe9c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XXMEffD0KYyhE/FW9D9GhMgIxmWKEd7FaHx78iifwDnoKVWTIpZ6EtOErZNgvd7IaTQpXFPDlsLJZxhRICL+AbP8l2vIxcHaS8BRk8gYEAespFTisHKIrIkgF9+oJjH7ZkMh5dt6vxCXXtWaz/gaSK119u7ssWM5WRyI4i77lTXIZM+HVTnKBs+973obvUiLVwHQRgvMCUrki00334LApP10cP1Xes233cQ9nUh9DzDOIKNdVLYJZKZI6p2o/MyzTNbO96N5hE8p5JwImmWvH168blAs6ZOv2WE9U+Sbtrvxb5aTF0fxMOJXxP2hhYRi1KPNp0cIod5Nu1yhihkUNQVrIXdrJIdS0K9vZ/73ZpbTcqLApm5bphRDl8ogVNeRPQkkHJd2t40j7hW2DxUk5NUX2TjGARiw0ROe0rRT9VSlTn6ArQ1UEIdeOzsFP3h0V+UQC+RQx/1t092rVD6NU0+nQByQynZikMo0qpXVZdLgB14gwLA1S/x7GP+FQ29ZB+yz7HDoIwDJQAT8xDGYR8zwkbDj62K+J01JoZ5dAEKfJTelhRrCsSphIe4Npp1B96hvr0Cnq0EVx8b8+Xuke8I59Q805IENLZFK7BoV1lfQjGsMe7sU8k8BDWqZxDgnXY/ezm96P/mmM956ZOvYFY9JVvtEfM/mMS98lOQ7oB2MbpGioIawcf7honyttC3nAHKxCCYhpUvLavvUQsyrkkiQSv7levcz4Xb8q4HfL1C/9LHfg8EsjJscXlViF0tr/m2eZ2Vh9WGGlVEYP79JvRI7Oi53pnzVK4Wew5UF/ak=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230273577357003)(230173577357003)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(46966006)(40470700004)(36840700001)(26005)(40460700003)(16526019)(107886003)(336012)(426003)(6666004)(2616005)(36860700001)(83380400001)(47076005)(5660300002)(4326008)(8676002)(8936002)(41300700001)(2906002)(478600001)(6916009)(316002)(54906003)(70586007)(70206006)(82740400003)(86362001)(36756003)(7636003)(356005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 17:16:31.0583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a3a2b7-22be-40f4-5ddd-08dbe5fe9c6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7092


Stephen Hemminger <stephen@networkplumber.org> writes:

> On Wed, 15 Nov 2023 16:31:59 +0100
> Petr Machata <petrm@nvidia.com> wrote:
>
>> The functions parse_on_off() and parse_one_of() currently use matches() for
>> string comparison under the hood. This has some odd consequences. In
>> particular, "o" can be used as a shorthand for "off", which is not obvious,
>> because "o" is the prefix of both. By sheer luck, the end result actually
>> makes some sense: "on" means on, anything else means off (or errors out).
>> Similar issues are in principle also possible for parse_one_of() uses,
>> though currently this does not come up.
>
> This was probably a bug, I am open to breaking shorthand usage in this case.

There were uses of matches() for on/off parsing even before adding
parse_on_off(). The bug was converting _everyone_ to matches().

I figured you'd be against just s/matches/strcmp, but if you think it's
OK, I have no problem with that. Shorthanding on/off just makes no
sense to me, not even by mistake.

How about the parse_one_of() users? E.g. the disabled/check/strict for
macsec validate, I could see someone mistyping it as "disable", so now
it lives in some deployment script, or testing harness, or whatever.

Maybe do the warning thing in this case? And retire it a couple releases
down the line in favor of just accepting strcmp?

