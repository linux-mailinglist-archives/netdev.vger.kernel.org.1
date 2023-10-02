Return-Path: <netdev+bounces-37369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA337B508D
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 12:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 72CFEB20BF2
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 10:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA70D51B;
	Mon,  2 Oct 2023 10:45:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB1A10783
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 10:45:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851B4B7
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 03:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2lAKm4h0JgdAWUsK2O3akKjDN2JSmy7xE7XzwdCou0/VV5p0qk2V5nmD0Ej3puUgznWbaBlOK8SFXo6lb9N5bek9/aP5e90CKYycoXZ1SjRNHuUWBLQqo6ZhOvrCIaU1OB2FvBJMNOgbGrS01S/940jsCUQbMIwDI94i32Enmr3BGP4f2cP2gIT5A9noXzSRF1Wc1hLx0UJ7fu3sYidyi07RSifSArKVER82O+s+k9AtEt9IlD93yjayly1OKl/73hZqXjpn3myONmx/vVFf5rHrox3kXymlTW3RcEMq7Rd9fU5BvsxdoXbrL/wdaZRVIpHfvFJ/GGqLfHf5Hc27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PflZPZtU20sO/U4g6aKLdVO8p0SkdGFCJFfEI0bg7WA=;
 b=abyTuYYKlqGqnm9zdrupT9ft06JAv/WO0s6tEF4VphVtQd4rTkidHVKMjDZRrt7JUsu+QN8WDQ+p/ejgFQzbH+KISF27R9czof0GWaBzua0oPboPMpPGp5jiSSv4f2T5kk9o0yPmBfZDqlhKk8rtP7Y3NgrE7ifIYhWliU4kfto3U8aN7nUY/14Wp61+yLxMytr8uQNNNnCm1tuET7RfvtlCPfReUpm4KD7mVrdAKxWv2shN71ERrlINnqJoAKqHnHHlDG9boPSum2hfln8suSzKUQhCLcuECDT/cl0tUjcIVWaEg7q0vzYcOZh9O2iiqgLjYfGwcFysGXikg4xaWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PflZPZtU20sO/U4g6aKLdVO8p0SkdGFCJFfEI0bg7WA=;
 b=EY0AYtTI1so6fzg8BRE3TjbLNVIgFA8dj0x9mLsaWt8TmW3BMi0mJxEuHfzx/M2z6tFyDiWihI+NZrW3CwDLv5BBEo/TZnQsbhn8K7pAmv2LeCpxAnuT75fBtqfIyoPnpr6f4LZQE1wHNjLdmXWSftkJ5QdCdCWMQwAb2xrirMri1s1KZv9kWVM+sVzh/eNkVS/x2j3dYl/H5AliqMhOKsXiTpZYiM9Z4m/VHH4fkjRcxioSPBfc0PjC/zwuhJRC47ESJ03czhjf6d5QKtej5lJO8UJuq6h61pz9DaLY5XVmRFq0XVphti/YmySWDKEvyj0zEVSUbi35qZS6yQljTg==
Received: from CYZPR14CA0015.namprd14.prod.outlook.com (2603:10b6:930:8f::9)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Mon, 2 Oct
 2023 10:45:09 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::19) by CYZPR14CA0015.outlook.office365.com
 (2603:10b6:930:8f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Mon, 2 Oct 2023 10:45:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 2 Oct 2023 10:45:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 2 Oct 2023
 03:44:56 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 2 Oct 2023
 03:44:56 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Mon, 2 Oct
 2023 03:44:53 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>, David Ahern
	<dsahern@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
	<jiri@nvidia.com>, Dima Chumak <dchumak@nvidia.com>, Jakub Kicinski
	<kuba@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH iproute2-next V3 2/2] devlink: Support setting port function ipsec_packet cap
Date: Mon, 2 Oct 2023 13:43:49 +0300
Message-ID: <20231002104349.971927-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: cde22a37-29f8-48aa-36df-08dbc334a60e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YfyZ63ZGUtJZkWVmH3xefTFLdmRdWy5mYYoPQM4UNjCKUvLu8RxIu6MwGWTQLyUbE4SnXjD8KBknE6aqvviN8Kbb54vbxHLYH9i1gTc/+szh0u97Hcb6NfWZkR5KFM6tKr8kk0s9Msj2dSWzMof5XP4nKrstnpqjUsONz+2TT4CLurn26wZaf+BprXQyv1hE+Pa9h6KbPsKEqRBjuF+CWnhJ4gl9I8m4CkRs7ufaFVbukJIzCn3N6IPYxjQR6ffz2cbDc3bbtNtw/mWIJAg96zU5+rjznPznh7C57SkZczi85gBz/CXjVothAe2PwTcP8unO5FfQY+EL2ho5EEFFmgNeO0vV09EQmU4iLgFD5cINFrBYSNXpcXtL0Gcs6WoffLvwvmZc6AGttkY00XcZlOVa14hN3C/Fucxi7il8txVlgFJ1UYtC9d5GYbBIKTJIK6aAzPRjGeddN5TPECgNK0YwqBqRI0+Id5QXAlZYwZnKHhGHOsZlP/XzhdcVpvf2h2JEqhZNp03qnlCRx3Svo7gSl2PMmAEhDEB1U65k4lFwOnUl4gpx6ixOr7WjhNYQAIQIGk2tZpb9DyluedW+qglNdh3I7Ek66e49PXcsbHvU+ab2iEby+r2xji9vVyu2pxXsO5wQEwO1+AmpNqa6kv9j0lcWSzljBb3O2aa+So2f0zfk6BMywgnUrTougdFoHBS2uWjP2iQJiN2YACxgmg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(46966006)(36840700001)(6666004)(5660300002)(1076003)(426003)(26005)(83380400001)(107886003)(336012)(36756003)(36860700001)(2906002)(356005)(82740400003)(7636003)(86362001)(7696005)(2616005)(47076005)(40480700001)(8676002)(54906003)(8936002)(4326008)(316002)(41300700001)(478600001)(110136005)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 10:45:09.3316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cde22a37-29f8-48aa-36df-08dbc334a60e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Dima Chumak <dchumak@nvidia.com>

Support port function commands to enable / disable IPsec packet
offloads, this is used to control the port IPsec device capabilities.

When IPsec packet capability is disabled for a function of the port
(default), function cannot offload IPsec operation. When enabled, IPsec
operation can be offloaded by the function of the port.

Enabling IPsec packet offloads lets the kernel to delegate
encrypt/decrypt operations, as well as encapsulation and SA/policy and
state to the device hardware.

Example of a PCI VF port which supports IPsec packet offloads:

$ devlink port show pci/0000:06:00.0/1
    pci/0000:06:00.0/1: type eth netdev enp6s0pf0vf0 flavour pcivf pfnum 0 vfnum 0
	function:
	hw_addr 00:00:00:00:00:00 roce enable ipsec_crypto disable ipsec_packet disable

$ devlink port function set pci/0000:06:00.0/1 ipsec_packet enable

$ devlink port show pci/0000:06:00.0/1
    pci/0000:06:00.0/1: type eth netdev enp6s0pf0vf0 flavour pcivf pfnum 0 vfnum 0
	function:
	hw_addr 00:00:00:00:00:00 roce enable ipsec_crypto disable ipsec_packet enable

Signed-off-by: Dima Chumak <dchumak@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 devlink/devlink.c       | 20 ++++++++++++++++++--
 man/man8/devlink-port.8 | 13 +++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 7852a47fc98a..3baad355759e 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -2283,6 +2283,18 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 			if (ipsec_crypto)
 				opts->port_fn_caps.value |= DEVLINK_PORT_FN_CAP_IPSEC_CRYPTO;
 			o_found |= DL_OPT_PORT_FN_CAPS;
+		} else if (dl_argv_match(dl, "ipsec_packet") &&
+			   (o_all & DL_OPT_PORT_FN_CAPS)) {
+			bool ipsec_packet;
+
+			dl_arg_inc(dl);
+			err = dl_argv_bool(dl, &ipsec_packet);
+			if (err)
+				return err;
+			opts->port_fn_caps.selector |= DEVLINK_PORT_FN_CAP_IPSEC_PACKET;
+			if (ipsec_packet)
+				opts->port_fn_caps.value |= DEVLINK_PORT_FN_CAP_IPSEC_PACKET;
+			o_found |= DL_OPT_PORT_FN_CAPS;
 		} else {
 			pr_err("Unknown option \"%s\"\n", dl_argv(dl));
 			return -EINVAL;
@@ -4656,7 +4668,7 @@ static void cmd_port_help(void)
 	pr_err("       devlink port unsplit DEV/PORT_INDEX\n");
 	pr_err("       devlink port function set DEV/PORT_INDEX [ hw_addr ADDR ] [ state { active | inactive } ]\n");
 	pr_err("                      [ roce { enable | disable } ] [ migratable { enable | disable } ]\n");
-	pr_err("                      [ ipsec_crypto { enable | disable } ]\n");
+	pr_err("                      [ ipsec_crypto { enable | disable } ] [ ipsec_packet { enable | disable } ]\n");
 	pr_err("       devlink port function rate { help | show | add | del | set }\n");
 	pr_err("       devlink port param set DEV/PORT_INDEX name PARAMETER value VALUE cmode { permanent | driverinit | runtime }\n");
 	pr_err("       devlink port param show [DEV/PORT_INDEX name PARAMETER]\n");
@@ -4786,6 +4798,10 @@ static void pr_out_port_function(struct dl *dl, struct nlattr **tb_port)
 			print_string(PRINT_ANY, "ipsec_crypto", " ipsec_crypto %s",
 				     port_fn_caps->value & DEVLINK_PORT_FN_CAP_IPSEC_CRYPTO ?
 				     "enable" : "disable");
+		if (port_fn_caps->selector & DEVLINK_PORT_FN_CAP_IPSEC_PACKET)
+			print_string(PRINT_ANY, "ipsec_packet", " ipsec_packet %s",
+				     port_fn_caps->value & DEVLINK_PORT_FN_CAP_IPSEC_PACKET ?
+				     "enable" : "disable");
 	}
 
 	if (!dl->json_output)
@@ -4977,7 +4993,7 @@ static void cmd_port_function_help(void)
 {
 	pr_err("Usage: devlink port function set DEV/PORT_INDEX [ hw_addr ADDR ] [ state { active | inactive } ]\n");
 	pr_err("                      [ roce { enable | disable } ] [ migratable { enable | disable } ]\n");
-	pr_err("                      [ ipsec_crypto { enable | disable } ]\n");
+	pr_err("                      [ ipsec_crypto { enable | disable } ] [ ipsec_packet { enable | disable } ]\n");
 	pr_err("       devlink port function rate { help | show | add | del | set }\n");
 }
 
diff --git a/man/man8/devlink-port.8 b/man/man8/devlink-port.8
index 534d2cbe8fa9..70d8837eabc0 100644
--- a/man/man8/devlink-port.8
+++ b/man/man8/devlink-port.8
@@ -80,6 +80,9 @@ devlink-port \- devlink port configuration
 .RI "[ "
 .BR ipsec_crypto " { " enable " | " disable " }"
 .RI "]"
+.RI "[ "
+.BR ipsec_packet " { " enable " | " disable " }"
+.RI "]"
 
 .ti -8
 .BR "devlink port function rate "
@@ -230,6 +233,11 @@ Set the migratable capability of the function.
 Set the IPsec crypto offload capability of the function. Controls XFRM state
 crypto operation (Encrypt/Decrypt) offload.
 
+.TP
+.BR ipsec_packet " { " enable " | " disable  " } "
+Set the IPsec packet offload capability of the function. Controls XFRM state
+and policy offload (Encrypt/Decrypt operation and IPsec encapsulation).
+
 .ti -8
 .SS devlink port del - delete a devlink port
 .PP
@@ -364,6 +372,11 @@ devlink port function set pci/0000:01:00.0/1 ipsec_crypto enable
 This will enable the IPsec crypto offload functionality of the function.
 .RE
 .PP
+devlink port function set pci/0000:01:00.0/1 ipsec_packet enable
+.RS 4
+This will enable the IPsec packet offload functionality of the function.
+.RE
+.PP
 devlink port function set pci/0000:01:00.0/1 hw_addr 00:00:00:11:22:33 state active
 .RS 4
 Configure hardware address and also active the function. When a function is
-- 
2.34.1


