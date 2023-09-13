Return-Path: <netdev+bounces-33621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BF179EEE8
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 18:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B7C1C210FD
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 16:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4958719BCB;
	Wed, 13 Sep 2023 16:41:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378C51A701
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 16:41:25 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A044C3D
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 09:41:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfZzZ5DXpB/288HrNu7BhYTV5HljQ/CCZHKPlNGJWyeCpzLgDzWT4e95s2/DSHyuVBNx2ZYR3ejKKZLkn9OZGgUmr0MndkLRyhx4ewnXQeGNO5HUDEtBRLL0guRA6ZPApCrm16Un2GLJExwhgeNwAsilhloETdRNmHcJPPZXRqGdd/bGiiO2lBjRgdjSKo3baQ97bHegobFYObx1wd07o4P5Dr0Q5tOjHc6JFRQ43NRUs53bOoK2iwcbuaFkrKQRsPG8+E2agAnHGWywxCoXDJMHAJnCRUdThLtx7X/6AtiA9YDMAT8Rs66PlzqGZdf9S5UgNja61NVIkcfFZ793Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOvw3o0220GUcZ19H9lswljCBRKO/b/9gp5T+SSDzcI=;
 b=kJrH7lSSxDn5hu1qrA0cLn9qwSanohYHTMY9i/eYobibwsngR39sJ0GMTF39nkV/UsZKNOK38dTPn4DupNJBUI0RaQ8EJtOLQLrDwiWDXA/MnfrQGRvfjOck18FGkthPXa/YGM/dbOekjwRoD+vbF0lKKhSr2GUbyn0nOv+DRQjkj3sWXgqIBRuyN+IFsakIY75475TQ5ZKieBc7jY2osi2tVkW/ANhWTeiZPQavlQLOJI6Fr+VAOLAFNMYochH8Mm+Ql9jnf0+bf8YNIRntfSdeOTlwftJgb6qIeEWWBN5vPFgRjbFBZzP0UtXDzfXhi90IViLIIJfceY8ZJeC8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOvw3o0220GUcZ19H9lswljCBRKO/b/9gp5T+SSDzcI=;
 b=JATiEOtkw3zra/B213luHKGCgMxqHnqfMq1rBmY/9z88331hxq8QciOS09eZ3T+Ah9V8bqxIszfyoRPQftpq6dtcOe08ThLo8U9h+EDg2uNKvd9Jc3ZTNT9TfJmsjdGYrK50gbN+al0wKGcPWSb6MbXlziJ2AW4K6+TW56N/ctzn4xOBD8mPC0Gz/9BvWc82XpiCD0/4t6LiRCzeFn3UdCpl3nNGJsY7a/Zvqrscw1ayWQakuCHRjyCCBnMvKrqGWOxP53UjzmEpGAyaxgqUWNZ0dObfTq122C8vjFhKFJ8ie71r0fZgCa99tz3fRCXNIFuOvm522poRqp1yOJ8mQA==
Received: from BLAPR03CA0040.namprd03.prod.outlook.com (2603:10b6:208:32d::15)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Wed, 13 Sep
 2023 16:41:22 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:32d:cafe::92) by BLAPR03CA0040.outlook.office365.com
 (2603:10b6:208:32d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Wed, 13 Sep 2023 16:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Wed, 13 Sep 2023 16:41:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 13 Sep
 2023 09:41:07 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 13 Sep 2023 09:41:04 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 0/3] mlxsw: Improve blocks selection for IPv6 multicast forwarding
Date: Wed, 13 Sep 2023 18:40:44 +0200
Message-ID: <cover.1694621836.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: ce3f1879-1924-4491-6e23-08dbb478433b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	opVrvsr2iaNFxbG4l/CNCrbI+NlbHgIdw0jdPZTMh/Xwfd5ZcgRA9QyiZFs0PlImcI6qeSU8iZVh5woHPMCb53Zg6Zzbet950J1MtoUcygXl0cmNIJmsYmLdI1RqkJvuwgRjpRRWI1ABFxC/u5cSp45YpDWIFaOEx5rj4iy2P1eV3WIPsw7AhWJJ5HYJGxhQ0ulFTGW9yJNhM3i5mNkE+veoNxGFdRTdy5aL4aZCdzBw3m68WuyxwONCyRYZQZK9BOwCVlvgQwkVydKRiuXl1305BigTyN/4KNnAxUQigRp7yb180RGai/Koz13iBAZlDJ7NROA4EA7BOxHA6bkbM8EejwYsziStZZkcANo2/L3KvKGdRkQ9IqsoCA6pLgzbDnlP6CvG/jwmyPY4xfwZOUPkAfSI0W4FjI5phN5DdwfdkRw6QbvyNOMdxbrrMy8usVoVaRedStK8Xwt70feE4XL7alEEd5i3q6p7o+xmd+05WXi7PmprG5HI1GK2P6qArAEpCDcAYh6iEiiTGvlVUINP5aYOpy4y4/2RVEQcnTzoBz7R01CzmwhLuwCsnk/KrIsS8zBe0F+49YuewCNqsPe9QWN0pIfXpjUZGXCAjgGqWZMaYPX2StkQ4e2LgKTGT/wXOT/1a0RE38iCzI1lB+51uiex4xsqusWNb/lFkMSE2UHVsRLlT1M67O9S+Cu5sostbqplzIFUXLLOGxqxUl7x+DF2x41wvTC+MQr5T2bYRBwLou93eiE4NMT+nPqI
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(186009)(451199024)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(41300700001)(7636003)(7696005)(6666004)(70206006)(26005)(47076005)(36756003)(40460700003)(86362001)(82740400003)(40480700001)(36860700001)(356005)(336012)(426003)(2616005)(2906002)(83380400001)(110136005)(8936002)(70586007)(4326008)(8676002)(16526019)(5660300002)(478600001)(107886003)(54906003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 16:41:21.8069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3f1879-1924-4491-6e23-08dbb478433b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738

Amit Cohen writes:

The driver configures two ACL regions during initialization, these regions
are used for IPv4 and IPv6 multicast forwarding. Entries residing in these
two regions match on the {SIP, DIP, VRID} key elements.

Currently for IPv6 region, 9 key blocks are used. This can be improved by
reducing the amount key blocks needed for the IPv6 region to 8. It is
possible to use key blocks that mix subsets of the VRID element with
subsets of the DIP element.

To make this happen, we have to take in account the algorithm that chooses
which key blocks will be used. It is lazy and not the optimal one as it is
a complex task. It searches the block that contains the most elements that
are required, chooses it, removes the elements that appear in the chosen
block and starts again searching the block that contains the most elements.

To optimize the nubmber of the blocks for IPv6 multicast forwarding, handle
the following:

1. Add support for key blocks that mix subsets of the VRID element with
subsets of the DIP element.

2. Prevent the algorithm from chosing another blocks for VRID.
Currently, we have the block 'ipv4_4' which contains 2 sub-elements of
VRID. With the existing algorithm, this block might be chosen, then 8
blocks must be chosen for SIP and DIP and we will get 9 blocks to match on
{SIP, DIP, VRID}. Therefore, replace this block with a new block 'ipv4_5'
that contains 1 element for VRID, this will not be chosen for IPv6 as VRID
element will be broken to several sub-elements. In this way we can get 8
blocks for IPv6 multicast forwarding.

This improvement was tested and indeed 8 blocks are used instead of 9.

Patch set overview:
Patch #1 adds 'ipv4_5' flex key and changes the driver to use it instead
of 'ipv4_4'.
Patch #2 replaces 'ipv4_4b' with 'ipv4_5b', to be consistent.
Patch #3 extends some key blocks to include subsets of the VRID element
and handles the required changes to use these key blocks.

Amit Cohen (3):
  mlxsw: Add 'ipv4_5' flex key
  mlxsw: spectrum_acl_flex_keys: Add 'ipv4_5b' flex key
  mlxsw: Edit IPv6 key blocks to use one less block for multicast
    forwarding

 .../mellanox/mlxsw/core_acl_flex_keys.c       |  6 ++++--
 .../mellanox/mlxsw/core_acl_flex_keys.h       |  6 ++++--
 .../mellanox/mlxsw/spectrum2_mr_tcam.c        | 20 +++++++++++--------
 .../mellanox/mlxsw/spectrum_acl_flex_keys.c   | 18 +++++++++--------
 4 files changed, 30 insertions(+), 20 deletions(-)

-- 
2.41.0


