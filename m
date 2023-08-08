Return-Path: <netdev+bounces-25337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C34773C15
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF2928177D
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569F6174E1;
	Tue,  8 Aug 2023 15:47:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DD8174D1
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:47:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D267D84
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYtH/sBr++9aY/SO2cxu7SZZ2r6O+iKwxJvSW1mRGriuPKGxC7gKgOT3KUaGiEOlkHTVvVWGyVqGY62HHWI66cbzw35zaTUn11JPXQie2t0gp3H8OHoaBhek6/0IxR+DfUDPpJ3mf+Byi0iNSkN4RvFj7CUNLG334VmsPdtUO08lSnwXgYbthAfIBxLEtsMBi37FahNoAoL4SmIZJgEgjeNsBd+B65nM/OKhf3WOxKXJ6zIsh+mUFd3TI2x4tEV23VBZNeHxbjd442B0CBq2PrBy5U+m7Js9/axQuC6TCUDLhoI825wYy8WwrgUHJi02ZxrwGtrVEjyhjOEcrbUB5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T14pdwEM56X5jmGyMKQ9/XX8CofFLtbZuZEKCIilrs=;
 b=WlhUGmgoXisXpqmInlKxGwxxOXABurn4s75iv9FiVlUfk5NOTfT9L77meBqioFs9rYqAzIpsI3TdAAZqwAHVHtUhFMGpyBdXVs95NY8sWBTXfHyxpbOUOP0jHjkQqGWSJy7Faa60AOnPEUw18p1DR283VmQzV87+ZUzsMmYc+i893TjichDlj39sfBjt1xWyPIPcBEGIiuf2tqrwKLTvzuxUtP+pS+HJxLhKQyHd3a2l9cHcZonD3RNr2WRw3ezOKHKN112L8KbUtXRd76brVyGXAWd2nD+jvWltsXuE06qV3uBQM3GiHAb7WBEFyzmWp8rtO2cpy5Dkm0lWz2YEfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T14pdwEM56X5jmGyMKQ9/XX8CofFLtbZuZEKCIilrs=;
 b=oaRbShrCo+4RUFX+deaZo/GtwviwpJARAkNS1+Xcd334mr+VnU4KdPzcJ/LA/ldUX4QG7KacY4OxeLBHtNRJk0BBGYqNIcMaOHkA74RbEJwHjFThKVxRjJcZimRUXPnPEoLc7d4h1J7cUfYxKORLupWzUfAqNw5KPMfxq2AuQKAIRGO6g04Hsmu0dHwfVQ4aN3A7IEanQY8PBab8vb0AP7hDC+7xLEaxSqFBFP4PbrpuNRzT2OlG6KBXm/7FaTwAtFiKTE/SxizEoGKxcurzcv8/Mv+ln1sIt8VBFu+w8vh/YLDRKD5KHVejvc0dx3oG40gQl42t8z/NobRNR+tf1w==
Received: from MW4PR04CA0327.namprd04.prod.outlook.com (2603:10b6:303:82::32)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 14:16:09 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::b7) by MW4PR04CA0327.outlook.office365.com
 (2603:10b6:303:82::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 14:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 14:16:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 07:15:55 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 07:15:52 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v2 08/17] selftests: forwarding: ethtool_extended_state: Skip when using veth pairs
Date: Tue, 8 Aug 2023 17:14:54 +0300
Message-ID: <20230808141503.4060661-9-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|SA0PR12MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da0fedd-dc32-499e-1b6c-08db981a02d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yjuAUNEW0Gyj/qJucOa2KS+pcjME+621QiSCH8ZUvYg8WGPEmm8bLMW9N9edQGcPimr11y3LIiAluwOZjRUSzMHfDVey6medESunMfTBROsxoLYQdrk8phcaklEEKryhPb1E7k4vmauMu71GvVF6Vx1zx2gOuUu0FQJnGEPE/RELg3oLxlqDptq/+/C0pUr6B0jBmhJ/Pi/E+LKfSPum3LvI/XPwcz3HzBHTeva6zZ37TuEzpYIfHiTqXWMQY8fDEOtPzx5BDcDi6bExzocnX+SFZEajQ6aqBiAW2rbEIL9xovlAPKmGrDwyUMOBIzgzmkdCBt9jhz3BxOjA0lWnnmNbE5/Tm6NmY1GnFPHCoNH61IXiD0fVqejy2BP0iuBBBIWe3uBWKhxTPwcFrfln7GxQ24s/buWNZHptzZvY0Qk79gBJQSNDJZBqLgPd91AUckOVBkn1mwHE/q0DTkUjP7TBadTZ8169IU5km0CvCzioMs7/wYKQr3CVohrcE62LgsWHVxjNwg2x0tZm/b2EmCSAyBXdePEA5UZVN7B9SnNUsTVYnm4M/VRFGdsTDX3uS8ZgmJJRwaLNOcPyL8fHUZGcvgTpJ761mxOGtvNyEjD+Bdbzde9BtT2o3E5YwVrB7B7mMwyeEOYHadCcCySM/BvCUS648BDKySw0fgtkJLSuiJNEzktRP7FyFqdXWE3zugPGOlN3j6vG4/KvWcYFmvpuLPc1UAiHiYITyjnIq8A92O4Bd4X+Vln64RTAWTE18KbH8cUefGJ+6+ZCx/AUgt+hI5u4qQUw34ni1vpLQZY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(82310400008)(451199021)(1800799003)(186006)(36840700001)(40470700004)(46966006)(8676002)(2906002)(8936002)(41300700001)(316002)(40460700003)(5660300002)(36756003)(40480700001)(86362001)(7636003)(356005)(478600001)(82740400003)(26005)(426003)(1076003)(54906003)(83380400001)(966005)(2616005)(107886003)(36860700001)(16526019)(336012)(70586007)(70206006)(6916009)(4326008)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:16:08.5561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da0fedd-dc32-499e-1b6c-08db981a02d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ethtool extended state cannot be tested with veth pairs, resulting in
failures:

 # ./ethtool_extended_state.sh
 TEST: Autoneg, No partner detected                                  [FAIL]
         Expected "Autoneg", got "Link detected: no"
 [...]

Fix by skipping the test when used with veth pairs.

Fixes: 7d10bcce98cd ("selftests: forwarding: Add tests for ethtool extended state")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 .../testing/selftests/net/forwarding/ethtool_extended_state.sh  | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/ethtool_extended_state.sh b/tools/testing/selftests/net/forwarding/ethtool_extended_state.sh
index 072faa77f53b..17f89c3b7c02 100755
--- a/tools/testing/selftests/net/forwarding/ethtool_extended_state.sh
+++ b/tools/testing/selftests/net/forwarding/ethtool_extended_state.sh
@@ -108,6 +108,8 @@ no_cable()
 	ip link set dev $swp3 down
 }
 
+skip_on_veth
+
 setup_prepare
 
 tests_run
-- 
2.40.1


