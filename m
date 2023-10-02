Return-Path: <netdev+bounces-37368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD527B508C
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 12:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A07D2283C20
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 10:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCDEEACD;
	Mon,  2 Oct 2023 10:45:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5492FD2EF
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 10:45:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528BFAB
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 03:45:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOkGazKMxrPn+rUhVpOViK1IOWbsYef5iLBA7EXpTChtSqeetBypSGXnwV8JwcodgqR41HM5/ecLpbY4tBu6XbooIk8lJux6jLquzDjlHfLJflfjUdtbOOy4hcjZojFoFhlW+cJcGip+LADHnjvemUjv4mS/K+ExYW/HBaSHbU/YGCG0d+04AT69JrkxlBE5VVdbye8+hbBRIizhb1RW4oRXKZ4T7w9bHxpQhjX0fyMwTNHqxYHODIKFgQXtir6bUdrnIUVi17s6ZVsiZcdErzXdBFqr+isRkKkG6Phev/m9iZE0rHwn5QS7F0eoXuGiyHmAHII/dT86nJsE/eMD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hsaEeQ5XVLO4tcYNzrJxfkUj7LRjErsYtX2BgLjryo=;
 b=NACoAFmSdAx7Kv56Iix0CMLW3xWZiB4NLz4NXc4LUuTHrhGtIgewWnI8cbiLfZHMHKEvLIUEkqD/9w0wOq49wyBHKYNj3UL+FyMs1sZ9UCnvUJYeh0sCBn+GqKbUon5Ewnb7w9zYkscPc6N/VQMI9Kb5flMXIK9/UkvQHFfVIJ+TJenhvskonGiLax/SQ3v74IQLyuF5jHzr3rOsNrXmdJf3e4C4DgfFkwJM8h6myih/JHkw3tSsAVGZSjho51Njo9XaUzcFC62yubn2Fasz4J66E66qQhn+moSDvxC+F7XVN0ZsvamNMDirBLTifc9oiytcT0YulQ8Oerfo1nv3Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hsaEeQ5XVLO4tcYNzrJxfkUj7LRjErsYtX2BgLjryo=;
 b=ryLa36kDtQ34kZAXJcl1Y74O5XTa+Ow+bgLDXzVbafhXjvqdRi0hMYiaUTutUGtfeXccX/C+IHp6YViWs2UsWqqXI8e2qE9AWNPYqdPTbj+3PqJa0oAMSLIt7TM0s/sfHmYhE5/t8oaetv0yIvbXOqlIORODg9elN1VKk7p5zr6YQtKN8gKj4ENr+c1A8OwEnhb38nnRSHD4rI3WV6ACQyeIgXXMU20OmE+XTTHod7qAb2PWM8nbOYNMT+3YY/pIJt9E/gTIz40IIz80DtDozi5FoQMWum6GT79JpGDVMu1wtMdr2pSthIIEFNCz3wdQlYz+4ntQQzhJKgsn+FKxyQ==
Received: from CY5P221CA0162.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::28)
 by IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Mon, 2 Oct
 2023 10:45:07 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:6a:cafe::1b) by CY5P221CA0162.outlook.office365.com
 (2603:10b6:930:6a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Mon, 2 Oct 2023 10:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 2 Oct 2023 10:45:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 2 Oct 2023
 03:44:53 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 2 Oct 2023
 03:44:52 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Mon, 2 Oct
 2023 03:44:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>, David Ahern
	<dsahern@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
	<jiri@nvidia.com>, Dima Chumak <dchumak@nvidia.com>, Jakub Kicinski
	<kuba@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH iproute2-next V3 1/2] devlink: Support setting port function ipsec_crypto cap
Date: Mon, 2 Oct 2023 13:43:48 +0300
Message-ID: <20231002104349.971927-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002104349.971927-1-tariqt@nvidia.com>
References: <20231002104349.971927-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|IA1PR12MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a7a660-6b29-463c-8be3-08dbc334a464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i+Jt4zqoYtcS3+lHUHQAcbMm1SKtrnC7z7tVwcAv80Y70p2KhGeWDmzwKkhmYD+v8/tj64NcT61XoncKSpmqkXqd9cdTMBzpMwOJXtjYMi2Y/+qnRtXCD65tz4rqmApZNyEVPF72+b62uCqDhq/hMHJTFL9jOq7uhWXBUCLrwLoY2cfAXC3AI3SPcpn2gj5AW4vnugM4AUcTmTVQyxcOf6zIY+gzBSBI+iGyjY2Cbxof6J4Y4xmZEygbN6cC17dd8/YW7YKOs7F/suF1ik0EJ1TwCEs3Yi5KsHZXeSqNXSugOBfQFkrttZoqQFS8U65WhCiR17ryS/2AYOOIiC5+6FcaxLgJNPMe+GMduJS+FN4/eNCP+BbyhpJ4kht0PXWIVrNebwZdez/pXggWgr544xvoJKgS8I9TkrOFAMXXkeKInU3115CxEqHyMg/wzgXdnGAm2K7XJJHM4bIiq8VjYH7mACGpOiYIXyT5dsq4Zl6OR60XHoY1rbjp6PAOuLGuB4aspJHM4BGi7Fy25BEyXwVNniwWY1NtKoZOLfrj9Ht65qPkn87b5GE0e61c9tZUbS9pFgYFViqeVsAgJF3qVLodO/tlJ/uwV12Qut95JaGD7ERExVt+XP2m8KQ2Sna31txkhNkDcYhp7VlYg6PjNm6Y+vEg08UE4r8FAZczBy0UXXYjtRnq6AyipbcOK2OKXZFJWVV80zygxh82i5g78RJXYLB5VeeSgJhE25hsMqTuI/cmmPMKtuteDUAa1V09
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(8936002)(5660300002)(7696005)(2906002)(8676002)(4326008)(316002)(54906003)(41300700001)(70586007)(110136005)(70206006)(478600001)(1076003)(2616005)(107886003)(26005)(426003)(336012)(40460700003)(83380400001)(36756003)(86362001)(47076005)(36860700001)(356005)(7636003)(40480700001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 10:45:06.5419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a7a660-6b29-463c-8be3-08dbc334a464
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Dima Chumak <dchumak@nvidia.com>

Support port function commands to enable / disable IPsec crypto
offloads, this is used to control the port IPsec device capabilities.

When IPsec crypto capability is disabled for a function of the port
(default), function cannot offload IPsec operation. When enabled, IPsec
operation can be offloaded by the function of the port.

Enabling IPsec crypto offloads lets the kernel to delegate XFRM state
processing and encrypt/decrypt operation to the device hardware.

Example of a PCI VF port which supports IPsec crypto offloads:

$ devlink port show pci/0000:06:00.0/1
    pci/0000:06:00.0/1: type eth netdev enp6s0pf0vf0 flavour pcivf pfnum 0 vfnum 0
	function:
	hw_addr 00:00:00:00:00:00 roce enable ipsec_crypto disable

$ devlink port function set pci/0000:06:00.0/1 ipsec_crypto enable

$ devlink port show pci/0000:06:00.0/1
    pci/0000:06:00.0/1: type eth netdev enp6s0pf0vf0 flavour pcivf pfnum 0 vfnum 0
	function:
	hw_addr 00:00:00:00:00:00 roce enable ipsec_crypto enable

Signed-off-by: Dima Chumak <dchumak@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 devlink/devlink.c       | 18 ++++++++++++++++++
 man/man8/devlink-port.8 | 13 +++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index d1795f616ca0..7852a47fc98a 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -2271,6 +2271,18 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 			if (mig)
 				opts->port_fn_caps.value |= DEVLINK_PORT_FN_CAP_MIGRATABLE;
 			o_found |= DL_OPT_PORT_FN_CAPS;
+		} else if (dl_argv_match(dl, "ipsec_crypto") &&
+			   (o_all & DL_OPT_PORT_FN_CAPS)) {
+			bool ipsec_crypto;
+
+			dl_arg_inc(dl);
+			err = dl_argv_bool(dl, &ipsec_crypto);
+			if (err)
+				return err;
+			opts->port_fn_caps.selector |= DEVLINK_PORT_FN_CAP_IPSEC_CRYPTO;
+			if (ipsec_crypto)
+				opts->port_fn_caps.value |= DEVLINK_PORT_FN_CAP_IPSEC_CRYPTO;
+			o_found |= DL_OPT_PORT_FN_CAPS;
 		} else {
 			pr_err("Unknown option \"%s\"\n", dl_argv(dl));
 			return -EINVAL;
@@ -4644,6 +4656,7 @@ static void cmd_port_help(void)
 	pr_err("       devlink port unsplit DEV/PORT_INDEX\n");
 	pr_err("       devlink port function set DEV/PORT_INDEX [ hw_addr ADDR ] [ state { active | inactive } ]\n");
 	pr_err("                      [ roce { enable | disable } ] [ migratable { enable | disable } ]\n");
+	pr_err("                      [ ipsec_crypto { enable | disable } ]\n");
 	pr_err("       devlink port function rate { help | show | add | del | set }\n");
 	pr_err("       devlink port param set DEV/PORT_INDEX name PARAMETER value VALUE cmode { permanent | driverinit | runtime }\n");
 	pr_err("       devlink port param show [DEV/PORT_INDEX name PARAMETER]\n");
@@ -4769,6 +4782,10 @@ static void pr_out_port_function(struct dl *dl, struct nlattr **tb_port)
 			print_string(PRINT_ANY, "migratable", " migratable %s",
 				     port_fn_caps->value & DEVLINK_PORT_FN_CAP_MIGRATABLE ?
 				     "enable" : "disable");
+		if (port_fn_caps->selector & DEVLINK_PORT_FN_CAP_IPSEC_CRYPTO)
+			print_string(PRINT_ANY, "ipsec_crypto", " ipsec_crypto %s",
+				     port_fn_caps->value & DEVLINK_PORT_FN_CAP_IPSEC_CRYPTO ?
+				     "enable" : "disable");
 	}
 
 	if (!dl->json_output)
@@ -4960,6 +4977,7 @@ static void cmd_port_function_help(void)
 {
 	pr_err("Usage: devlink port function set DEV/PORT_INDEX [ hw_addr ADDR ] [ state { active | inactive } ]\n");
 	pr_err("                      [ roce { enable | disable } ] [ migratable { enable | disable } ]\n");
+	pr_err("                      [ ipsec_crypto { enable | disable } ]\n");
 	pr_err("       devlink port function rate { help | show | add | del | set }\n");
 }
 
diff --git a/man/man8/devlink-port.8 b/man/man8/devlink-port.8
index 56049f7349a8..534d2cbe8fa9 100644
--- a/man/man8/devlink-port.8
+++ b/man/man8/devlink-port.8
@@ -77,6 +77,9 @@ devlink-port \- devlink port configuration
 .RI "[ "
 .BR migratable " { " enable " | " disable " }"
 .RI "]"
+.RI "[ "
+.BR ipsec_crypto " { " enable " | " disable " }"
+.RI "]"
 
 .ti -8
 .BR "devlink port function rate "
@@ -222,6 +225,11 @@ Set the RoCE capability of the function.
 .BR migratable " { " enable " | " disable  " } "
 Set the migratable capability of the function.
 
+.TP
+.BR ipsec_crypto " { " enable " | " disable  " } "
+Set the IPsec crypto offload capability of the function. Controls XFRM state
+crypto operation (Encrypt/Decrypt) offload.
+
 .ti -8
 .SS devlink port del - delete a devlink port
 .PP
@@ -351,6 +359,11 @@ devlink port function set pci/0000:01:00.0/1 migratable enable
 This will enable the migratable functionality of the function.
 .RE
 .PP
+devlink port function set pci/0000:01:00.0/1 ipsec_crypto enable
+.RS 4
+This will enable the IPsec crypto offload functionality of the function.
+.RE
+.PP
 devlink port function set pci/0000:01:00.0/1 hw_addr 00:00:00:11:22:33 state active
 .RS 4
 Configure hardware address and also active the function. When a function is
-- 
2.34.1


