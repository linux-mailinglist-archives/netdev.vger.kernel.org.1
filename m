Return-Path: <netdev+bounces-23557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C07176C7A5
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4755C281D2D
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AF66FCF;
	Wed,  2 Aug 2023 07:53:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BF56FCE
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:53:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::61b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C653C26
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:53:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXasv/xRNqXcPnUvxIBiz4iYAc7eM4whMKFZGXH4BbxlhjS2V7Oexoh2fqYL02f62GqIOQdl2H0T+ccS3PvtopqTF/qWR2rMjGq3eZfhxctXooXeyMFtCKdNnByB6awaSkguCpV+ewkbYy+vdja/DVMLnaVWuNEhQAbU9P4moZe52HO2Q+N3kujwdggFkkyR+FeuI7nWFM3QtJ7V4asPeXHneMlmyQVcqnwnAlapwav8ChRhnxhyGyalOmLrmWkrut8DRC8Qfr09IY2BRCK3WZKbsdKMYTRTm7m/NqAyO9DFAbrRhHNcJBGmFd/ZzgjuDHYzasiIy+QtUXlMpXDs0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVE5uJDdadeuYWsbduiSi9MZMIprPtLV9TpuN6/G49k=;
 b=I4aXvfHBOqBJX0iF7Oi6VOtbXLJbj5MLRTVf1Amyt2G/OjSqCrn09fyCRKwJKoa7kgGdoLcxXE8LxvvxMtS+UPiuLwC24Y18mRhJOXqwu37FyMZujpFwYKtpqBY+kUfT7Wa0vBnd26sWl7tI7cwwfuF+kPy/4dTerGljRULYeVYqB6REJEtpYVGHw9hoK8wmE9a47jU+CfrhL8J+udR/juz3HdQ7jpcvqEZTb2HTf5YdzcxDsOjlIZ7jbn0ZAqkb4IBD/rK3aYEc87ovx944l/P7NYcAA3CkQ5E3ySJYXj9x0K6XgZXsL9Y6MzEv12+XnG0o8NsE43cHN3DdSQTZKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVE5uJDdadeuYWsbduiSi9MZMIprPtLV9TpuN6/G49k=;
 b=CGAYDBhDCvD8wc+11asQCpW/uzrT4I2rCxfyh7Rha0H4IQ3E7Zzhuw3JA4nZ/hRLYVlDp1IZeFbReM8ynFBGi5k0wgqtD6/P5x0rvyspMnpQBTITrGWrYfKgP1/r/n8yGhtE+p4pT1REmJt2P6YvYsS9je3++dk2QOrAXfFCOTjyUuXLUUdS8kwFEorDl9ZF+jeyJ3oPBgU56VY9EAO20yIEMpVlAwPhko5UsCvGFkO70KSSsR6PRIJCg+QS88VLmp2vmoBTrFy4Hc+qiBiNn2sd3uio7zTuLhUbmk/DrXUYJZWnr32o8v96NJdob0t9GU8DisnlUkvVhIhcqh+Q8A==
Received: from CY5PR04CA0029.namprd04.prod.outlook.com (2603:10b6:930:1e::20)
 by SA3PR12MB8440.namprd12.prod.outlook.com (2603:10b6:806:2f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:53:09 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:1e:cafe::3f) by CY5PR04CA0029.outlook.office365.com
 (2603:10b6:930:1e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45 via Frontend
 Transport; Wed, 2 Aug 2023 07:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 07:53:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 00:52:56 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 00:52:53 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>,
	<dcaratti@redhat.com>
Subject: [PATCH net 13/17] selftests: forwarding: tc_tunnel_key: Make filters more specific
Date: Wed, 2 Aug 2023 10:51:14 +0300
Message-ID: <20230802075118.409395-14-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230802075118.409395-1-idosch@nvidia.com>
References: <20230802075118.409395-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SA3PR12MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c44af7-b97d-4d8e-a674-08db932d8379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	reT2mWCoj9dFLoaU1VgxbcdCKOaMdApIKyKB/+RtWXPy8K3leEG8z/OqfGTzi5u0cGzNlTI1RknjvbEi9UBOoEYexSqItLteNgIbWTRrIv6lIt3rpbiyOrgXMLHIP3ZR3g2OJVAQmb8oizp8/Ew0pSaZh/G+1KFLWPnRvM4Gxqie7ZhcEOk0SN5h1FkjfUBegmznuP8jrtLCGbaWmcb8mchMCo46uOnO/Ttd1VHoh8pG3/eXAoGrSUptQ27oMJN6J0AKO+6jH4F5No7oEWz7d6zdSHB8jeCsUXgxsVe3XNv/aUvaF355DWDPhcmGmBrcjJBv/Y9uQdiSTbjTvdYQSCKh3LSWqbAb2vNEO4t+LjeJWPadBdo3I41afgwCw077PircGHZYYP+8k7gfcq2rjxxeYwnJWROT4sQ+mOSCaOlpdNAZlh4JNTfluovX9YLlW1+Nt96Xem5lKvx6P5ZlsRhIm5jn/ctRC36Ke7LE+1LlkHPAmswGMdLrEhlU/PlUV0yZSTy43mhios/dbi+f1RWUOCfmcHSFvu1NNdUjeh87H36s4jBO7nfnTFeW7pIiHw7qXQe0pfvE2TgXQC6Mjm0wvhDlYGSLUE+YadvdNrscoXOgE4BAxQmNpWJYT3bL0TiqrxAzqvZbJtvlVUnqxlprR3eLJT231iOEtUDWuCL+nnvAE88DckLmg8nJdj/C2LTRwh5VGIbPxa8Uz73y3LUIUWOtXvqdjBRI486Vs+8AM3cjibFdnWjFyagSSPBFYE1BPspP4sIAnqCRpyPZzsSCYFZuuDgxs7fY2FisDRs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(7636003)(26005)(1076003)(356005)(82740400003)(336012)(186003)(16526019)(2616005)(426003)(36860700001)(47076005)(83380400001)(2906002)(36756003)(5660300002)(8676002)(8936002)(40460700003)(54906003)(478600001)(86362001)(6666004)(966005)(40480700001)(41300700001)(316002)(70586007)(4326008)(6916009)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 07:53:09.0093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c44af7-b97d-4d8e-a674-08db932d8379
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8440
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The test installs filters that match on various IP fragments (e.g., no
fragment, first fragment) and expects a certain amount of packets to hit
each filter. This is problematic as the filters are not specific enough
and can match IP packets (e.g., IGMP) generated by the stack, resulting
in failures [1].

Fix by making the filters more specific and match on more fields in the
IP header: Source IP, destination IP and protocol.

[1]
 # timeout set to 0
 # selftests: net/forwarding: tc_tunnel_key.sh
 # TEST: tunnel_key nofrag (skip_hw)                                   [FAIL]
 #       packet smaller than MTU was not tunneled
 # INFO: Could not test offloaded functionality
 not ok 89 selftests: net/forwarding: tc_tunnel_key.sh # exit=1

Fixes: 533a89b1940f ("selftests: forwarding: add tunnel_key "nofrag" test case")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
Cc: dcaratti@redhat.com
---
 tools/testing/selftests/net/forwarding/tc_tunnel_key.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh b/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh
index 5ac184d51809..5a5dd9034819 100755
--- a/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh
+++ b/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh
@@ -104,11 +104,14 @@ tunnel_key_nofrag_test()
 	local i
 
 	tc filter add dev $swp1 ingress protocol ip pref 100 handle 100 \
-		flower ip_flags nofrag action drop
+		flower src_ip 192.0.2.1 dst_ip 192.0.2.2 ip_proto udp \
+		ip_flags nofrag action drop
 	tc filter add dev $swp1 ingress protocol ip pref 101 handle 101 \
-		flower ip_flags firstfrag action drop
+		flower src_ip 192.0.2.1 dst_ip 192.0.2.2 ip_proto udp \
+		ip_flags firstfrag action drop
 	tc filter add dev $swp1 ingress protocol ip pref 102 handle 102 \
-		flower ip_flags nofirstfrag action drop
+		flower src_ip 192.0.2.1 dst_ip 192.0.2.2 ip_proto udp \
+		ip_flags nofirstfrag action drop
 
 	# test 'nofrag' set
 	tc filter add dev h1-et egress protocol all pref 1 handle 1 matchall $tcflags \
-- 
2.40.1


