Return-Path: <netdev+bounces-25282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17EA773B02
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F43C1C20FF6
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA06912B8E;
	Tue,  8 Aug 2023 15:36:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9851412B83
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:36:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4359E
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:36:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQfpDV5s22OBtUdQqFs22LLmOO0SicuJWAAkxK08cws2yT5NC+v5IGq1Tksw7nXPDjW5rXb7DfL/7tWfXxkhdfTfe1KmS+QVYzjieqt1HpoxBjld80mGBJcSF1Hp1VDbQHP6paU/MW9N6UFEuktOtp3jPf/YKUZlaEziL8sIh+tq1FWkCMN6xY0kuH/+FIrCm3dt6A3coAiPXiU4ce9/Cs5K8553vpo/tKBKxeI24WgHFp+wx4ibbIEBZF21XYh83U6jscWZGLtJycXidaHJbKfgDvw3wZiZrudd2134wiu7e+ezCQeET9MpxBKE2N0pOhM9fu+fu+pIR9jKS9WFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBBW/2jnpCdTZuwapZKaTHWc/uOD79xYDSWGRWCJ5Ys=;
 b=QFs/CWchce3mtTdZw58ZW3PnukqVTeM4eO0xQB8gn0d4CD67FTBQsVgGDVFgGxoMBRn73mA4ma+B1lrm825ORfbQiyRB4dZZ+ag0mrw8nlOUR1nsn+sU2+uAPIHLuEpYRqi5wiNo+69CijLmCQX00YhorsQ1yWsJf60tRg5YWwFF27dheg6Zm+7EGAJxYqFxRBjdPLNrw9hfjAQXfz6S0FSbv6+YZvQKLxquGe+7Pc0Ul9kTK8NiGIrO+NCmhH6ls5CpnKL3z2OZbqC9zOEoSJ1EzpNNJRcaTNrVZCNiSqKqwJSVqvvgxaMU/T3pijT2GmB7SYw5D0D/wBiclYfsNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBBW/2jnpCdTZuwapZKaTHWc/uOD79xYDSWGRWCJ5Ys=;
 b=nxDJtIGuPqIVaU+DTlE+XncZWv2kiacilQA+wGHjvBFUuGrvaxOGIexApYwHV46HW2nlMoLdk+dqIpdSN2sopfF3bfHDtnF8yxjpQDxh2+b9kliz7DvDz8OMo8lhmwjouTkUH4UoGuuqckad1uB4rRGvClvPE3+87V19sdUfYcGDSAZbf5XEuE/iroErRxUX5DX2wKRFIJiTdfT1+tFdiSMkKPVZ3p1+zF/0Kk6HxDlDUTztoBRgkBzLXnUQtWbzVSNrhyXISf1OO7/3uURkWDfOG3KGtx7Ye4Nfpv+LAmjoa4UeYelQyPOs6xOfoaqy61pCRZsLs9urJslzvNFpfw==
Received: from BYAPR21CA0023.namprd21.prod.outlook.com (2603:10b6:a03:114::33)
 by SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Tue, 8 Aug
 2023 14:16:05 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::a7) by BYAPR21CA0023.outlook.office365.com
 (2603:10b6:a03:114::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.8 via Frontend
 Transport; Tue, 8 Aug 2023 14:16:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 14:16:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 07:15:49 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 07:15:46 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v2 06/17] selftests: forwarding: Add a helper to skip test when using veth pairs
Date: Tue, 8 Aug 2023 17:14:52 +0300
Message-ID: <20230808141503.4060661-7-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|SJ2PR12MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dcbb19d-35be-420e-12c9-08db981a00c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oaIEgwq5g4B2TfHFg9zy3eUfXfCzDYioXoNyOtWTXpBkI/u1xQgV48DAXKK8AAUXesqNgxSLp+ImGHkvEG8kxcYOW6zvU6o0r5d2i6OhK6NbcSg45Eka53ALDJ6zV641xUN3f952z9NqdUj2PENieIr2S1xk6oafEmya+N+2fZmeREQ6UrFf/obLwWUZyyBZC4ql4WMYqXvkScdYbwGLjN1czWLTYUYEWiPmgsX1Fo82bmVBDo9VMipEX5/GyeamIZaqoVq7bqr8NsU8j4YYQpNJ4sREejsFUmYmdTKovoQ/WNnlyNmByLdorZ+ROBaSVuVAxV4HJ8gX8NTs9GHHYqciCaow+zH+K6qv/B/9j7jsv4z/pgL4K5FuWYaBDRRkSxU+GayjnWT6eOoBVedb20n428x/1oGr1sSgYJSEnPfXSeAeYBursyAQHqw66oYdbBWUN40hFTG3i+Adovdt+ZYXpvKLuNCLswZyc4maV7sXscOmrmgNBPev4WPA1RHac7ISJLb7soswapaaVgIgCU917bWKhxQ3mTsg/xww96evKEY86wUnk/WjVuRefM+asmdDyldyKlYooYIejQFh9DMhE0NPoWcZ1kzTX6VOBa+83zyPCYAjArVXi2uyEm8foxFgdoEWAe6HKPw6jHeSFpHAqY7+Uu+ztTGV+pQrWFhGXZhylnPeUY48JTHXNc8VlddLefr+7gQy7Eet87qQp+ook0MD9OPUHp6U3xKLuWSV7Xk3yI6gMxtcEMHua9BaegrzPbyFa5eTgchWe3nIxmgzx4xXePph1TcBlgvveaeZHpzfveqxb5i4vbWW0JDt
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(186006)(90021799007)(451199021)(1800799003)(82310400008)(90011799007)(46966006)(36840700001)(40470700004)(40460700003)(316002)(86362001)(426003)(83380400001)(47076005)(16526019)(1076003)(26005)(5660300002)(36756003)(2616005)(2906002)(336012)(7636003)(82740400003)(36860700001)(356005)(40480700001)(8936002)(41300700001)(8676002)(107886003)(478600001)(6666004)(54906003)(4326008)(70206006)(6916009)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:16:05.1868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcbb19d-35be-420e-12c9-08db981a00c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8650
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A handful of tests require physical loopbacks to be used instead of veth
pairs. Add a helper that these tests will invoke in order to be skipped
when executed with veth pairs.

Fixes: 64916b57c0b1 ("selftests: forwarding: Add speed and auto-negotiation test")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/net/forwarding/lib.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 40a8c1541b7f..f69015bf2dea 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -164,6 +164,17 @@ check_port_mab_support()
 	fi
 }
 
+skip_on_veth()
+{
+	local kind=$(ip -j -d link show dev ${NETIFS[p1]} |
+		jq -r '.[].linkinfo.info_kind')
+
+	if [[ $kind == veth ]]; then
+		echo "SKIP: Test cannot be run with veth pairs"
+		exit $ksft_skip
+	fi
+}
+
 if [[ "$(id -u)" -ne 0 ]]; then
 	echo "SKIP: need root privileges"
 	exit $ksft_skip
-- 
2.40.1


