Return-Path: <netdev+bounces-16712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B7674E7AD
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB3E2814BC
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 07:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F41171B2;
	Tue, 11 Jul 2023 07:08:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84437443D
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 07:08:53 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A38CA9
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 00:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdx5QFEhTWXMvwgDlT2KvLe/1gKbwEAd8n2qfUUh3vKPWMHzJs/Z9lPvbiwS8+rFTqIxs0AnmgzaNUeC1aIwDLZbYmjmRbCj0vZ1qpyHFw7AMRFMEbNiNsY02xdWrYO03OP/DFjngpbZkiWUI0gRopWkNyqtRuZiEK9lhGnq207E8JszdmQ3NjQkCNQH0lsosQQu8q8eGWwssFFV4zkH2qLtlNe7fexB3i4lZk7C4ulYUFdt8NH7PwG7Ng4uHbi4zkY1oZ0rh1SZc6pp06kls3db7GmBaU6I92t35cY8mWtN0Xm6aHQxK5S9stiqjbdYAN/OjS7E5Of1OdduTY+atw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xgu+bhWpObXJy5H94BGj7oxHXf9P5X3tPFijn5Ry+A=;
 b=QvFhB03RWe+GfvoQmKUdVCFnWTK6sfdup2kvUUNV28RTY2DbgBxADPp45a2vJjX9t3PPFaA9SGlIOZJN7YWRFgf2iLr2bjQpCGTBYBHCfcMIiSpR32DKmI/5y2vY601jfsOpqzMz+X9doRGQ0/p3j6HKsFzWALjvvtZlQ2gsrj0kFVvZteHLHLnbSeD8JmfbW3qY39u+GYnPAnG39t4OxpRTVKq3HDV4otz8B5RL/MtOrp1WyVuaqjT4bMhroebjEmpWrJUeO/+XwH3mvWBGZQxhnJ7z2fCeK6M3V//RBjpQbqNVuxX8SMw3m9esAZ1H7TqtsYBJXKv6h9hPXj+wDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xgu+bhWpObXJy5H94BGj7oxHXf9P5X3tPFijn5Ry+A=;
 b=eoX2hl38ZUMmnMcYLkdp/wu7R9KgPPDuHwQRK8oyK3MFXuiTsaEGL7TaX4wynEDEzQWYJjT9GvlmvVuItCHOnxLgl1c3yDwwjl+8iPsI4w7sl7UkfviXgczYVelZNWIIHuEY2z16B+4yz2vYQaPbynr6pmmKpcw5bn2JJqKlHhgLn8aa9lS/bp2hihdS/6Jcyd16nOx94lIco3xMbylF9sqCpEfLYNO2+Bs7IXrofjz6AD4mn0qaGE8z7Dxw2rdMD0HY1j4hAaTsvIbccm9GuxZAYXBp/AvcR8AxIsVkXbaVovOdvyfrsp1HrIhgWlnAFC8rOnZdEopsQoV8phBHyg==
Received: from SJ0PR13CA0170.namprd13.prod.outlook.com (2603:10b6:a03:2c7::25)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 07:08:47 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c7:cafe::ed) by SJ0PR13CA0170.outlook.office365.com
 (2603:10b6:a03:2c7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Tue, 11 Jul 2023 07:08:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.19 via Frontend Transport; Tue, 11 Jul 2023 07:08:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Jul 2023
 00:08:32 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 11 Jul 2023 00:08:29 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>,
	<jiri@resnulli.us>, <amritha.nambiar@intel.com>, <petrm@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net] net/sched: flower: Ensure both minimum and maximum ports are specified
Date: Tue, 11 Jul 2023 10:08:09 +0300
Message-ID: <20230711070809.3706238-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT097:EE_|DM6PR12MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cae8dd6-4285-4c1a-3432-08db81ddab54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SEeP0ZWknyQO1Of4k7Bt48WadslVg4NQgzkkUedjbPTyvP+Kea+nbcpYb66x7pn97mfwmDjy0VeXHAT+Y7YQmU0ZGof4E2bkV8qS0tXpZygw91r+C5rGshU9twDnfJh9SXm7Dxkw3xU4rv3/eB1Miei1XzgufgHSRx8Da9DlF6RB8p3qm5x1GSOxWx0VRociJfwckIsGL2j++O3D1kVQZib6UUv+4DpnuwamJsk3S18aPj1DjfzaKeKyVXQEYkvOztrUmIvmBm0/pZLbF9yyUPw5WMg+J8DjgT5+WxUx+7LYhgSqZm592yB0Ydae38k+hC1pKY/CdEQgdYG29Zj3PSEUUnC8z/M3vcB3KlR7+NT3Q29IlRdJw+i/DsHIVblwLlHTU31G3tzLiZkVl248Dsk2wdXYzi8BM7gJZ3ZVzcm/B69LXGVGkYOqQp+qH821Z6B+f3KdSWbTKQjllnbnxpjDvPu/8AAmnVn/X/onBkEaXVE1jIQH7bgjakFOd33tWXDeUI1oY4BN1nOSV6Or8l3se703MgcNNBAPMk9d/A+FJWTBN6F3o+GTqqhlpEPgmK8iPa1TKnykVZoU0S0Spvn+L/u/vADhLK/Q1aIh5GFpdfkeOMmf6HCSq6+46x5TGgeW2PxbCVF5hDdPk+r8mxjCdeYy2vJ6Zoao5YnJBJlGRUepAsbhWjkXK4XmmZXTzbvLswx9GXGJdQhht0wSaWY5jE4KMWlMnie8rG0lQds=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(86362001)(82310400005)(82740400003)(40460700003)(40480700001)(36756003)(6666004)(54906003)(70206006)(70586007)(356005)(7636003)(107886003)(26005)(186003)(1076003)(2616005)(5660300002)(316002)(2906002)(8936002)(8676002)(16526019)(426003)(336012)(83380400001)(4326008)(6916009)(36860700001)(478600001)(41300700001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 07:08:46.3672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cae8dd6-4285-4c1a-3432-08db81ddab54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The kernel does not currently validate that both the minimum and maximum
ports of a port range are specified. This can lead user space to think
that a filter matching on a port range was successfully added, when in
fact it was not. For example, with a patched (buggy) iproute2 that only
sends the minimum port, the following commands do not return an error:

 # tc filter add dev swp1 ingress pref 1 proto ip flower ip_proto udp src_port 100-200 action pass

 # tc filter add dev swp1 ingress pref 1 proto ip flower ip_proto udp dst_port 100-200 action pass

 # tc filter show dev swp1 ingress
 filter protocol ip pref 1 flower chain 0
 filter protocol ip pref 1 flower chain 0 handle 0x1
   eth_type ipv4
   ip_proto udp
   not_in_hw
         action order 1: gact action pass
          random type none pass val 0
          index 1 ref 1 bind 1

 filter protocol ip pref 1 flower chain 0 handle 0x2
   eth_type ipv4
   ip_proto udp
   not_in_hw
         action order 1: gact action pass
          random type none pass val 0
          index 2 ref 1 bind 1

Fix by returning an error unless both ports are specified:

 # tc filter add dev swp1 ingress pref 1 proto ip flower ip_proto udp src_port 100-200 action pass
 Error: Both min and max source ports must be specified.
 We have an error talking to the kernel

 # tc filter add dev swp1 ingress pref 1 proto ip flower ip_proto udp dst_port 100-200 action pass
 Error: Both min and max destination ports must be specified.
 We have an error talking to the kernel

Fixes: 5c72299fba9d ("net: sched: cls_flower: Classify packets using port ranges")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 net/sched/cls_flower.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 56065cc5a661..f2b0bc4142fe 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -812,6 +812,16 @@ static int fl_set_key_port_range(struct nlattr **tb, struct fl_flow_key *key,
 		       TCA_FLOWER_KEY_PORT_SRC_MAX, &mask->tp_range.tp_max.src,
 		       TCA_FLOWER_UNSPEC, sizeof(key->tp_range.tp_max.src));
 
+	if (mask->tp_range.tp_min.dst != mask->tp_range.tp_max.dst) {
+		NL_SET_ERR_MSG(extack,
+			       "Both min and max destination ports must be specified");
+		return -EINVAL;
+	}
+	if (mask->tp_range.tp_min.src != mask->tp_range.tp_max.src) {
+		NL_SET_ERR_MSG(extack,
+			       "Both min and max source ports must be specified");
+		return -EINVAL;
+	}
 	if (mask->tp_range.tp_min.dst && mask->tp_range.tp_max.dst &&
 	    ntohs(key->tp_range.tp_max.dst) <=
 	    ntohs(key->tp_range.tp_min.dst)) {
-- 
2.40.1


