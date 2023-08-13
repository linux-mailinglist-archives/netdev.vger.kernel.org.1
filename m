Return-Path: <netdev+bounces-27177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8372677AA22
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 18:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48491C20325
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 16:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528DE8C19;
	Sun, 13 Aug 2023 16:49:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469136FB6
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 16:49:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DF091
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 09:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3DJme6OV46xqL6Nop54KBHCOfMb8p5KUibqJEl6wpc7mmbXXTZ6934Cx2JvDyofm+xCZGMrgpG3nNrJNTqNsBgLmvo1jkYfjJZET8ou9gjnMAwwyICeXyEks9N1c52esvvbRM0w3MNMYAiCayLdU1+nQQZdvkHrXM/PUqhSw9nNiiz4h+6xwKwkwAOOPYy19EpXUSrkaIB4wJAVqg0JBg2QkuGFuZN3cF0FvGC+uug+sd3FIaz+b70K4WO1vvkfT6R91J+qWrPwBZoPrVuJE7WzindQ9zIqvfKIGTjaj8iE9LcurM82Z/to8G1oaWZOl/bwkHVj2YPU0aQvRZUAqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lJYJPl6jwALBb2iql91frJjjvH9NZYYpRfsdZVwLsU=;
 b=dElV5tAq/rQCnkdpyAyO5Ir3VyMYoZpEgfiqzFEDwiGyU0N+Ct1b0ySlEKTyvldpiSuwYNrNEqCR5QcI4vf/bOSBGKGZW/zLMEW1ZQtk3TdjEULi+B8FiJBHUtoHR9QNJ1vDpBGfzGlIUEEIfTEsPJ5T6uTuSJtYp9OYI5bmZd+dHV78MnaSpFRF11ZiCj3QukE4ohLA6HAmjDSF5ANq55tT+7Hq8KZY0Dq7uSPqVdFSDlIZBfGxBRbk+rT+TthR+QjVIPH7atHJsDvUpawa94LY8n+V1VrIQAGAvmUhfrzWwe5CtQZlBt/lPX5KT2ucJ31+G/wQDoQPBvfCZLavSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lJYJPl6jwALBb2iql91frJjjvH9NZYYpRfsdZVwLsU=;
 b=HEO1zZw9jt/IraqKZqSmpdfNF+6HKV8GP0BqZb12gR8UzjdBwat2922Di01tIILu0uvGJFqXUvZNOX5KhoTt4IWEi8BPG2NUG9PJbSFKuzg2t7VEk5yybCEDiZwIIysMYIpj4ZE7igBmiE9wlGBFFIycHEb5TCuyH8DOCjt1DsaiSN+MQdCYBK1T+pxS40x0q1Dyrx8EOEZ3iEeFBYn1tAoKupCy85f2PYVOpUg6d8hDm+cfR7ke+NWFb10Vk/aCi3jbg4htXFFxNqnQmnFg8D+fG//h8QQSCjTbtqDaE8iu4560kf8I1ggCrcOYmv0x0pAeL0RlkiKzB9iTvpR2/g==
Received: from DM6PR07CA0127.namprd07.prod.outlook.com (2603:10b6:5:330::28)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Sun, 13 Aug
 2023 16:49:33 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::a7) by DM6PR07CA0127.outlook.office365.com
 (2603:10b6:5:330::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Sun, 13 Aug 2023 16:49:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Sun, 13 Aug 2023 16:49:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 13 Aug 2023
 09:49:24 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Sun, 13 Aug 2023 09:49:21 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 0/2] nexthop: Various cleanups
Date: Sun, 13 Aug 2023 19:48:54 +0300
Message-ID: <20230813164856.2379822-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e56e1f7-feca-40e9-764a-08db9c1d455e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zil1lSauwWyGnopcyVymzFxl6rVhupsa+OJZqTFHUI3gxwiILmcqY1kQf0QJYy3JSzxrdD/W9S0qupDts9eaqICTFwILD3FtmgVYItdfnfJruBVTrCnQHSmBROdPvFUhx1SvCOnxcbTozYV+02gwQjIZXQ0eplIm5d9yAzDGV5/Ot+QsGYCJvU8cY8luNxlZppXNylqEhcW6GQiyOC6MzDy5tqGOhaK9rCu/Mf6la+JoeFeN4VoYhLWQG+8ZSKmfyKUyoIECO9b7xY8uNCOF/5ivIP+VRvGbzLOBKtmJdqLDi8yF6fU7i49TPtXADaAKygT81TJmplgvqHvEyh+HttuadP2v4MLHCoO7rs98WecbB3MMc6bMEtpe0qnmy3lnyggMDhUyJZC6LKr0xk71Mfwofh0RAwwwWWrMpNmAETgclYHuSn1ZRS5u0Fz4nwUd4tcI9/ihPqZG+DDEQZdRLBShsZMSSuSAbKVFqlEM0N90BfAIcrXSvo/YPcpjeDtrI1w/yjncp0gdoxWzxqoY3eqNm9I9BqTltlIZVUa0JA7m0JVE+BrLP2FjivDTohptCDWVSzXobOpjMDgUaECPz8r9ANtcq6Vo+HnFPBXlbSzB/fkPl0Op9rztBWZq/HdYOnq+l/PEzuJYoxYTz4NhA3p9tGE3bE7b3NpOe57leut/IlO3q/rxlj1PnqU2iMzXtSeMmXfBsLALFQsaTppDSZgjokMJCWtFnunF1tyjYzo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(1800799006)(186006)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(6666004)(478600001)(83380400001)(2616005)(107886003)(1076003)(336012)(426003)(26005)(16526019)(2906002)(4744005)(6916009)(54906003)(41300700001)(316002)(70206006)(70586007)(5660300002)(4326008)(8936002)(8676002)(86362001)(40460700003)(36756003)(356005)(47076005)(36860700001)(40480700001)(82740400003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2023 16:49:33.3454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e56e1f7-feca-40e9-764a-08db9c1d455e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Benefit from recent bug fixes and simplify the nexthop dump code.

No regressions in existing tests:

 # ./fib_nexthops.sh
 [...]
 Tests passed: 234
 Tests failed:   0

Ido Schimmel (2):
  nexthop: Simplify nexthop bucket dump
  nexthop: Do not increment dump sentinel at the end of the dump

 net/ipv4/nexthop.c | 6 ------
 1 file changed, 6 deletions(-)

-- 
2.40.1


