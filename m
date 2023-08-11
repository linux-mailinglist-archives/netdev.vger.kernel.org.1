Return-Path: <netdev+bounces-26882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D293C7793E1
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9C41C21805
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65E311720;
	Fri, 11 Aug 2023 16:00:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F4D11707
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 16:00:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFF43598
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZc6L0odtcm40PaT2luyqNfoYmYFAV58AG4FUwPzUoJmuHTVDZiopo729TPNjYr4w73OLpyCcsng3wnCP7rSR1RNm4D51Sx5VFgkeHowvZt8JEYfAEPNbtJ41wBiGhFbUcD2hYRPcIYf09EOb4ZV0xja3MqxidxSe+6PyDAaGUNkN2z8YYqZEFW5PfptU4W/JuJ6gbFgBsW97d/LgmlUkrmNw6O+ZUCWtgFAE5vM+MI7pcb9OBa6HVI7nOnP7cN3CivFo6hoGRCMeg8w5GMwv2MW7fegL9TteqmbLQHuj8Q2wwOWqztQkFPSbdh4N0O0DJylqbu1h1eAMm3Pb9deew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnrV8Ck2JdD5FKdKh1MJRe4B+SSVM/qtEZomGqPDzp8=;
 b=H/1ZGdI31PwB3zIoAfb7G46KWb+8RqypnRgAn0V0fH+lJCWTGgCNrcXQmxftEBvCkUL/wAs8DE7SLDlez+8+rf7cFYK3Muepy7JZg7RclZmJL+IQqHcWiBtabEyY3aIgc/XrTdXRXXlg0bbXW/Y91nOSfTK2JTTLN2g0LOfSKVbmwggvzjUEgzDpFkdX2z1Lp9y4gEtDkiWhMjdRdpifXSNMunSr+xTMAxSsVRAww2bNkXwItEyItluRGcqqXRut0i1TUA+Xxow3mwY/xK5GBCqzjGVDkRsAiOBJu2jqOxLAgKGhftqthXLwzDJT7ZTNEjScktNM5d5n3rkNW9hfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnrV8Ck2JdD5FKdKh1MJRe4B+SSVM/qtEZomGqPDzp8=;
 b=bCeR730dENskaEksDpBB9Om72DyByFTw9zLt0tvVtfRK8oZhPczlCXVlhNCTEJ2ymiFyD2tj8MC6Km6h2syngo6tGfq3XvGfRna+TS1VotQX090YgtPelt/Tg29z8Ol7I5doyDoX/cXJS35sGaXNQZH3CawDTd8W7IkV6cfVLIyEDn1sE7S9QcpfV+rYIe81YzMt2FG2D553gij3w7aWkV8cwoGMlaCgVEv+WmLzjgbe0jc6ZTAJCLzFzTEMSS3MO/V6V/ZEuDHtlchkfBX5DCbYs1NtOt1uc1UdJA2LDctFtdn/HeU1uP5RVlwNgRpfGQVZ1RuPEklsu2m7QvASwA==
Received: from MW4PR04CA0338.namprd04.prod.outlook.com (2603:10b6:303:8a::13)
 by PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 16:00:20 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:8a:cafe::ed) by MW4PR04CA0338.outlook.office365.com
 (2603:10b6:303:8a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 16:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 16:00:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 11 Aug 2023
 09:00:07 -0700
Received: from localhost.localdomain (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 11 Aug
 2023 09:00:04 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Mirsad Todorovac
	<mirsad.todorovac@alu.unizg.hr>
Subject: [PATCH net] selftests: mirror_gre_changes: Tighten up the TTL test match
Date: Fri, 11 Aug 2023 17:59:27 +0200
Message-ID: <3ea00504d4fa00a4f3531044e3df20312d472a39.1691769262.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|PH7PR12MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 00975567-3b89-41d9-8122-08db9a840ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dIau4Gbwq2xbc37Ngk4qPwnnlNta2V1FD1bKyH0YefBJRD79xQXLhUVlf6a6nLGMesNjHlhxiRgHiixm+sfvtFRzRQt0H8rGrZwiX4ss772VhL0Xwj6WSE+ocwJw6G6STT9+pbMdIE9v+J2TGo3cFit6ly+xmQjafPhNh1THQNxZTihQ6z6NZykSdWldi0smGzvL7kPpSgVWXSUb50v1J08pi/nPnxqVENJ3PUe+y0oYjbzKJyNmkuS6A6cIE9bg0hfBPRDaCgfoYjoPJAy+PeS9YIal5JW3cWYAL/jH+xvZtYz3A40lBtn8RSJDK36LVLsUItypLEDkaTMIjDeK8Aa+WeIstQfFADINhoQREMHSTWQFW/QqkJoaMUKZp60/ZeT2tVSXRDF4wLFAETDf1Md3JpW3l4xKs5oGRPzS41Wlc1mkHvBMyhiIifUazxReVNgW9Y7L64I79H16VNT5RgiDLsv1jv7j9Fhwjk7AXPsX1rCAoV6jlzmFBuPgGWfzwtYg2nC9/q7F9cLywPuVJ6FzFHnodF5J5A1iD1d5d8ViZkxtcvol0nrnofpGXoFvTAqYF8KvsMzHYIyM51CeSfJS9DA1cIz7I2zxPTBPKWkCrC9NnRRxxHiOjqh1xuR9rAkTC5+405tP2+f24/CrgRE2GS2+OXaBWy8jKyYgerKrG5a9PiJC6DywZPKWcjzFrRJFWNa9Z5dAL/6CJgp5HE19rquAKx9Xc/iTdwCUwyZSJC5Xi9L54+BDKxAFYcd3
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(82310400008)(186006)(1800799006)(451199021)(36840700001)(40470700004)(46966006)(26005)(40480700001)(6666004)(40460700003)(47076005)(2616005)(16526019)(426003)(36860700001)(36756003)(83380400001)(82740400003)(316002)(336012)(2906002)(5660300002)(110136005)(54906003)(70586007)(70206006)(4326008)(86362001)(7636003)(356005)(41300700001)(8936002)(8676002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 16:00:19.6621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00975567-3b89-41d9-8122-08db9a840ffb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6660
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This test verifies whether the encapsulated packets have the correct
configured TTL. It does so by sending ICMP packets through the test
topology and mirroring them to a gretap netdevice. On a busy host
however, more than just the test ICMP packets may end up flowing
through the topology, get mirrored, and counted. This leads to
potential spurious failures as the test observes much more mirrored
packets than the sent test packets, and assumes a bug.

Fix this by tightening up the mirror action match. Change it from
matchall to a flower classifier matching on ICMP packets specifically.

Fixes: 45315673e0c5 ("selftests: forwarding: Test changes in mirror-to-gretap")
Signed-off-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/forwarding/mirror_gre_changes.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
index aff88f78e339..5ea9d63915f7 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
@@ -72,7 +72,8 @@ test_span_gre_ttl()
 
 	RET=0
 
-	mirror_install $swp1 ingress $tundev "matchall $tcflags"
+	mirror_install $swp1 ingress $tundev \
+		"prot ip flower $tcflags ip_prot icmp"
 	tc filter add dev $h3 ingress pref 77 prot $prot \
 		flower skip_hw ip_ttl 50 action pass
 
-- 
2.41.0


