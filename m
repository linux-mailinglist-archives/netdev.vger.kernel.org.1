Return-Path: <netdev+bounces-25301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81A9773B3D
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A911C21036
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B6D134DF;
	Tue,  8 Aug 2023 15:42:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775CD1426A
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:42:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::624])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B3949CB
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ze2t/nWbE518RinpzwFFV4qiLgfCQJ2PwBkI3vd2q1tPrYTblKyXF9Q0McGs1xQSQb7haPAlUXE4/uc7ZgyjcnCjM6V5TOz6UGgSaMECq+Aj3swUkm2WRzYCZEOPRBQeujv06MTGQNm4L0HFYWJ+WH8JiEYVJ588lneQOuuPXR9MRtWjqPMOGlcWujNYjxBe7nCuDJFeRKcOtM/dUZj1Co2K9wX49Q8sN6ltsseMKmOq22WVrPuryn45cmwZHaNI+0Df1e7wXGl7imQLS32v3U9yf1ZGZspp4JKpWm+XLMilTt14jAIkFUcVY8UyRnutIrLZjbDMyGqi7oY5O///Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehIchy6ee/mMpqzkQ1NMYacqJj0bAWFZqY+uFIqdo3Y=;
 b=dJQ726vyYpK3SUtByNYg+l+BXxNEARwuxBuyx+otFuPG0VqVZHU65u2XhWmXllJFgF3hAjv6q4EJY5t/A8AVyQsaqQBaqY1WZJ6i54szizUGkkKzKCEwAP3VajOWrpjjA9gBd9jQy1ql90tenUDjIH+jikXzE3bQKsSrTyyIbpMXtp1zI7swQeS3cA3vJPdZ2jmRh3V3tmELKo6LrrNUWyDhMmirWkJCJifXPDx+PKy+3VOGZ6yfKIKDshyu4t58eZaz6g3hXpUrSdkNvaULSIBKNyQ6FqYcveukJm4YwSTp09qLzPHu8QQS5TtumbhGUfYROH3XIpIqbwzsgBsFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehIchy6ee/mMpqzkQ1NMYacqJj0bAWFZqY+uFIqdo3Y=;
 b=e6C9n6csbDx9b8GZcP6x2XC7lFSZZxMYs/cOcywpPCjr9JnxGbP3u/2Hvx4gZ76g5ZF0GQeFyy1oM9pL8FAt8XUthE83E+rik5ICWKmMhgQmGbkEvkDTeYQ+rJg1ikvIBowAiwM1cijfwspEF2FYOr50CJHJri720SFKskYWxRHWN1ErtxWTdG8zV+yLfH+vs2u9LRBTpUBlhzpgMYf+/khEHy/9YdUyNBd7yDEI1xY/8mhqiD2JlXx7cW/Tido8uBij1kHBbbGtzvY5Y1t71SIYXsMB4aMleXSQPCSXVGN4cLeGrre4zZw8fuUTa4aQsERByj5VAg6GbHfxkv/gAQ==
Received: from SJ0PR05CA0141.namprd05.prod.outlook.com (2603:10b6:a03:33d::26)
 by SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 14:16:30 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::25) by SJ0PR05CA0141.outlook.office365.com
 (2603:10b6:a03:33d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.17 via Frontend
 Transport; Tue, 8 Aug 2023 14:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20 via Frontend Transport; Tue, 8 Aug 2023 14:16:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 07:16:18 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 07:16:15 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v2 16/17] selftests: forwarding: bridge_mdb_max: Fix failing test with old libnet
Date: Tue, 8 Aug 2023 17:15:02 +0300
Message-ID: <20230808141503.4060661-17-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808141503.4060661-1-idosch@nvidia.com>
References: <20230808141503.4060661-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb82e1c-7581-4c63-c80c-08db981a0f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C1kVoizVbEs8119VeloCrQ7Vt0+AD2wZIy7IW6gieihvKCVWIL+67BogcInHVzZ+woF27CuqdFIBRclM/CXhAPN9X6SKGsVAxB4Ddpi+mVgZA8jVkn4iQKde8HhPz73mD0maAg5jsUoco65PHM8CSiDeAYbiM/Y5dlgiVA9sJLPv0iYy6/JTI8c/gVpUKyJkz6OE/CNb852hSxLVhr/l15BZx6NfvllhPseTkvQIUpUmn+xZF9xsY6rhVoY3ao7xRmcojJAsWPAp6HKyIjEjABCf1rfhZUjLMMXhSluG0MclrNdgsEhOKM3v67F1X9fsC0AuNQjDoSRQ1SH/csrPSsFU66YcVx3b9hwsVEfKrPxi0xpCHkt7w4I84W8M6B0xYuNovq7/bIv9tfWJ4hUEDcEL+Yf7CSKMg+H/hRgqji+XmygosAGDzSqftCBZ4BnnrORh+dKVCWktTuJj9sSGNtPYN+bjtR8x0rjPJ8GsOB467Y1zfOioYaGbL1QDjo/ta+27nguFC3xPxbljvsgoBkN0W085ILdgJ4voX+itfXbDgHkjf0/IPZLcLjRGDvVzZqh/MUdwn0YQbOlSYm2i3s+mO6zRuIprT/E15kiacl2bIjrF7Pj0XB0xaErg9aJVfLev2ydJmeLJuup+ApOa4ghRbuIerE+9Ukix6woIBRe3Q26Op8V1x6wUj343ErrltAIn1OC2Cx5/abFbyHbZlBaklXo3zfNB+rsRvd1KUj4Dm/bxHFXHdl0qXCL9rnwI2OymxJjZa/7BuN5k4Z94ZAesGUlVwyoV3+cun4P4xU8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(1800799003)(82310400008)(186006)(46966006)(36840700001)(40470700004)(40480700001)(2616005)(40460700003)(6666004)(966005)(86362001)(7636003)(478600001)(82740400003)(26005)(107886003)(36756003)(1076003)(41300700001)(356005)(316002)(5660300002)(8936002)(8676002)(2906002)(6916009)(4326008)(70206006)(16526019)(70586007)(54906003)(336012)(83380400001)(36860700001)(47076005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:16:29.8920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb82e1c-7581-4c63-c80c-08db981a0f82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As explained in commit 8bcfb4ae4d97 ("selftests: forwarding: Fix failing
tests with old libnet"), old versions of libnet (used by mausezahn) do
not use the "SO_BINDTODEVICE" socket option. For IP unicast packets,
this can be solved by prefixing mausezahn invocations with "ip vrf
exec". However, IP multicast packets do not perform routing and simply
egress the bound device, which does not exist in this case.

Fix by specifying the source and destination MAC of the packet which
will cause mausezahn to use a packet socket instead of an IP socket.

Fixes: 3446dcd7df05 ("selftests: forwarding: bridge_mdb_max: Add a new selftest")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 .../selftests/net/forwarding/bridge_mdb_max.sh     | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
index fa762b716288..3da9d93ab36f 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
@@ -252,7 +252,8 @@ ctl4_entries_add()
 	local IPs=$(seq -f 192.0.2.%g 1 $((n - 1)))
 	local peer=$(locus_dev_peer $locus)
 	local GRP=239.1.1.${grp}
-	$MZ $peer -c 1 -A 192.0.2.1 -B $GRP \
+	local dmac=01:00:5e:01:01:$(printf "%02x" $grp)
+	$MZ $peer -a own -b $dmac -c 1 -A 192.0.2.1 -B $GRP \
 		-t ip proto=2,p=$(igmpv3_is_in_get $GRP $IPs) -q
 	sleep 1
 
@@ -272,7 +273,8 @@ ctl4_entries_del()
 
 	local peer=$(locus_dev_peer $locus)
 	local GRP=239.1.1.${grp}
-	$MZ $peer -c 1 -A 192.0.2.1 -B 224.0.0.2 \
+	local dmac=01:00:5e:00:00:02
+	$MZ $peer -a own -b $dmac -c 1 -A 192.0.2.1 -B 224.0.0.2 \
 		-t ip proto=2,p=$(igmpv2_leave_get $GRP) -q
 	sleep 1
 	! bridge mdb show dev br0 | grep -q $GRP
@@ -289,8 +291,10 @@ ctl6_entries_add()
 	local peer=$(locus_dev_peer $locus)
 	local SIP=fe80::1
 	local GRP=ff0e::${grp}
+	local dmac=33:33:00:00:00:$(printf "%02x" $grp)
 	local p=$(mldv2_is_in_get $SIP $GRP $IPs)
-	$MZ -6 $peer -c 1 -A $SIP -B $GRP -t ip hop=1,next=0,p="$p" -q
+	$MZ -6 $peer -a own -b $dmac -c 1 -A $SIP -B $GRP \
+		-t ip hop=1,next=0,p="$p" -q
 	sleep 1
 
 	local nn=$(bridge mdb show dev br0 | grep $GRP | wc -l)
@@ -310,8 +314,10 @@ ctl6_entries_del()
 	local peer=$(locus_dev_peer $locus)
 	local SIP=fe80::1
 	local GRP=ff0e::${grp}
+	local dmac=33:33:00:00:00:$(printf "%02x" $grp)
 	local p=$(mldv1_done_get $SIP $GRP)
-	$MZ -6 $peer -c 1 -A $SIP -B $GRP -t ip hop=1,next=0,p="$p" -q
+	$MZ -6 $peer -a own -b $dmac -c 1 -A $SIP -B $GRP \
+		-t ip hop=1,next=0,p="$p" -q
 	sleep 1
 	! bridge mdb show dev br0 | grep -q $GRP
 }
-- 
2.40.1


