Return-Path: <netdev+bounces-44683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A577D92E3
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368561C20FCB
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E45F156D4;
	Fri, 27 Oct 2023 08:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KCXNUyLG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C653F156C8
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:57:52 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7E91B8
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:57:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqqZuJ6LS+WHYT46t84RF75vTREuDO16JebfUja4/h2ztXZgyIIdFPDpH1z0/lJ3WmWQjTfiS6aveqHBYc2gP1rAHdUrHWvoEjECFOamFMzT+ZEbQ6mPXMyZIn1IidDFFDUBAMoQxR7W5SKMY3StOKHDhkzeAO6ZPMovErdwqaAjsp0RBVZ1X3TCdq8pJh1ap5n6zLQ5V+52ZMSp5c+SjNSYp3gFzX8is1PbIrexNendqjtg5iiZWMOto7c88NtMtM+hBiA9/1eA+dElZUBWMnkB5cDLPMc2XdfjSZJi1WeKIo/7OKrEcxmW9eTjev4nXVmmH32vN7+46ejD5LOogA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxBLQjK2h3m8WjqlDWt3n/kU/r/6GeiauIe/yMtvt4k=;
 b=TWh5xXYZL/aCmhdXjix+9USwwC8d50812RXsDiu0vjFrEV63Obr6JlXJABJQS0FtFImzIySroBxUFCWwl7xupu2r1GzWpahq+n8D0lNHjHMlVNOhX9uEZ9kk49/8sb31GzRGS7py7YG3V6l55JPoHaTqG5tCKs9bo0nNxNpiBnh/z7QE0cS4XUp7m2MAJVED07KctfFNDdlsEKcJMQOfxjKTX/5XD+MkzQcy1bBtI/9gPIMo7ADBJ6427xhrITZRO2L5M42XE/EGW9kuA2mmagfoLsQKd9HiiMHzosoE1ObgtqM6hAhRLsna/LD+TTw2rArKP4wW+iLmAkMsBHplWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxBLQjK2h3m8WjqlDWt3n/kU/r/6GeiauIe/yMtvt4k=;
 b=KCXNUyLGqjEeWvvaR+Qo8jmjgwOxmhtp1wHbpFEco3+SOkBSYnujkxzWKvluV83g7Xhp7AhTXZfW2uRzoFu8+TDeAcQWKXN7oe3FXhIsfYnb9pbIiUJOacgdRtFbs3BxEeqACQS4k6UASIU0vhg/l+nGejTmlLgrsHcnlYLqY9gDWHycTnYIEZM6ppSk3C+uyGTqyKQ3t2G+C5KLYhJO+FgP9z4x/IsO09qExUbM5JgGF5g4CSva2P1u9ffPwie1+IHdxzsJ0e0iq7u2uqoY+ZW7M2EnkkYUEmZu6wHpd/SsFvF1gI+lTE7Ib4uQHpcFh2b5ien+eUQQtvgPGRdzlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PAXPR04MB9303.eurprd04.prod.outlook.com (2603:10a6:102:2b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8; Fri, 27 Oct
 2023 08:57:48 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.008; Fri, 27 Oct 2023
 08:57:48 +0000
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: netdev@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	dsahern@gmail.com
Subject: [PATCH iproute2-next v2 2/2] bpf: increase verifier verbosity when in verbose mode
Date: Fri, 27 Oct 2023 16:57:06 +0800
Message-ID: <20231027085706.25718-3-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231027085706.25718-1-shung-hsi.yu@suse.com>
References: <20231027085706.25718-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:404:14::27) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PAXPR04MB9303:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e96e3a6-4c1b-41c8-4c64-08dbd6cacaea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XGH+XdKN2gxYX0ctJQbqROJO+bvLybW0cK6xkYRSnVtBMPPzYxUNEQmqL3dRF1lfUsR3NG7kLHKqmbmt98/gy5Z4I+wgPdGwrlfoiLFUquLBSyMKYMB69Mn192ZuVvjZmLGb2sT3Ot/QZfDhQLFDMzMRjW5GN2VcmRarxxzWdOMaD1sOq0Mh3hxs19cZX6eYrQYKHgk2CuR4OmYD3sePyGHQ2pHzgCPMNgZ/Xm11+WM2F/hwsfn/SyytR97aTOjMB+9Cs6UThDpnSd8eGHCLL8CrKv4IBy0CcRX/wNqTOWhCJr6VeS1c4VQz3NEDpE/e4+tjH9prViWx/+ZDs51ZTjcfbJEKBeGtEA/OdAfuoPfAz3LxKMNO/Z9NFHfDrgn/D9qQKZ8+C/5Szwh/DtVa5FTPpOrEYfVa4BcxyGp6kDz7UoK2PmaMYGTZdHqi/ATn3jM3y5IE1ynhZXMvPZ8NxSV5OPR20n8HJXC1900SgqfIBx4nAxpPXmgBgJfdAPrYpXxt5sh96rGS4SKceWR7qUD67Ts1iLaZMJPFAqWr9TY2MoR+M6PGyIkowt3GsUQz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2906002)(41300700001)(83380400001)(478600001)(4326008)(8936002)(8676002)(6486002)(66946007)(66556008)(54906003)(5660300002)(86362001)(316002)(6916009)(66476007)(6666004)(38100700002)(2616005)(1076003)(6506007)(36756003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VaUq9+urk181DXXDYOXQDcqxHEG0ipMCIbMFdj0PGgGdYNfe1sRgfDgvv74D?=
 =?us-ascii?Q?EKIlA6jvziAPgUdhRBQddw+k31zZKtIDZNrk8HTQ/4Yy7amem9N4hTgOsWTs?=
 =?us-ascii?Q?opxblQXu7I+ED2wX2Av+urbyKeIGd14CWYI0/aVbmP7JfeOkGpJxTbNQVbXY?=
 =?us-ascii?Q?aHMFKBoTQ5qWp1pj+qaX9ESQK5pSCZN6GJxh2Kdx0cKKW4PckVpQRWKgIC+s?=
 =?us-ascii?Q?y9jHIYJNLXbnVTNuZbNMoe9IjqJvWGIkLxJd+SdA5ZiPRptMk1Nzwb7KKN2k?=
 =?us-ascii?Q?RuTKXCfPHrNO7A0H+ETlI8W8gyUb2yMEYzZb26R51UAIu6ziNRY1wulyVukA?=
 =?us-ascii?Q?hJj70pT78PQmGC4jQ+htmpBLAHhU5ZNZDK+9hp95aKPYKiatz8ARs3zCNTRF?=
 =?us-ascii?Q?1UOV3KFR71NwXxE8vN/UUiGgoOo6lUt1icohZsM5pGXdXOFtKwgVV0QNy3Fn?=
 =?us-ascii?Q?T9RYTMq+mZ1SW42IjFZIn7JUj5ixA22oNTo5076HUre90DGIbhl5pWpTBVvJ?=
 =?us-ascii?Q?laG8xhF1EuyRhTuNPUeaYXWCLnXPiWMt0o+/vOo58PBGVtqsg8zRHDg4sC90?=
 =?us-ascii?Q?qbStpPRNDo68YMq+4jrC97azSSiVWDUxUWrcsxghmQF3XjIE4uF2NOt0HyXr?=
 =?us-ascii?Q?OB7KJuyfV5XrYU6wmIGUMj8WacSmY5qNusqW915iYYXh0GMSi6PeB6IQs4m6?=
 =?us-ascii?Q?4ISfautn+BNonzeadzu5GoQjfG5jV349DMh4kTRwF3Xe2LJ0lNhuSGfkCwHy?=
 =?us-ascii?Q?KmG/WxfeTgdI3XkhiVTACXgkAC9NpkirsiqMyvvcCAcSGe7+SgU3OUm8JsQZ?=
 =?us-ascii?Q?Y+GswORPb1gzhBnZjH0d8luRSUn8W1Xzj969uEY2fCx/sQUvBA1/+yM/Lq/5?=
 =?us-ascii?Q?O6HxEbFF+BntVcwaTrg+HCrEEXsoY7BNPP1/+zvuQ8zF7k7hH53cFXKmw4i6?=
 =?us-ascii?Q?oXgGY2rPdfhvBZJSMANcdfE8M7gpw1dTy8WF5I1E93wvMMvnLrosPpYMMyL6?=
 =?us-ascii?Q?IA4JXOpXQg13BHBKCjJPFKtBqyJdR6trpF/HGBf9l5K2vl/JokhI9hKJ33xv?=
 =?us-ascii?Q?wg2wiZ1qrrPxfkH93up49HW8PEu5JuWs0N1NHCu7kzPohVPOeTOTMaAsd1n1?=
 =?us-ascii?Q?LDAZep5pytw9RcyKASQW3IWjHTJ0W5D2iKPNAVEHzsDtAZEev3KvHUfc69QL?=
 =?us-ascii?Q?8JEjRf+MeTX07r7B3700G9PFgcKUkr5Ti9yXvuNc3667J/u+WzLxkYUChnix?=
 =?us-ascii?Q?ObLZQ3+ORrUqg0U5RNjt8e9H2XOeEFlJTB64C12xj61zozW9ISkpw8WFBKWv?=
 =?us-ascii?Q?IlhDkevrFFMIMC9jf9a/D74cCNJ1dmAVilROy8myUAR1zqhlHakJgCp9IOGZ?=
 =?us-ascii?Q?N6bnnrzt+y42Nc2aKUbgyVSB/rIuuD4S6aV+QlJFYUIENJot6pbfsq1BhkQ4?=
 =?us-ascii?Q?ZeYuZAtpomHQ3vYpw16n/+lWrRpHhQKMmtiS4cXt2kRMf6xgQzERcQNSoqSL?=
 =?us-ascii?Q?rNJZRBR24F/a9nhhm5qB26J+WWWLizdA27x/34XGPItvVdN8pbN9jIjm2hSb?=
 =?us-ascii?Q?r1R8NB0Ol6mS1nbYB/lLr9kwsg63nQ+t8JSjHfk6XeDsFawwf0OVT9xem+mw?=
 =?us-ascii?Q?1hl2EF7JOlmm9JsWhjAyUsplEKFb6M3CzTiMvcA3pUczbcMC7KrR/vu3knXX?=
 =?us-ascii?Q?SJ3Rqg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e96e3a6-4c1b-41c8-4c64-08dbd6cacaea
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 08:57:48.2153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDglTuD6WkynjMvKhEqB+KqLRto6EAPGU0JHXkN7AUoIy4qAu411yDMu6BoHi52AhcsNy3pEd4W8OnCadNkvzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9303

The BPF verifier allows setting a higher verbosity level, which is
helpful when it comes to debugging verifier issue, specially when used
on BPF program that loads successfully (but should not have passed the
verifier in the first place). Increase the BPF verifier log level when
in verbose mode to help with such cases.

Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 include/bpf_util.h |  4 ++--
 ip/ipvrf.c         |  3 ++-
 lib/bpf_legacy.c   | 10 ++++++----
 lib/bpf_libbpf.c   |  2 ++
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/bpf_util.h b/include/bpf_util.h
index 1c924f50..8951a5e8 100644
--- a/include/bpf_util.h
+++ b/include/bpf_util.h
@@ -273,10 +273,10 @@ void bpf_print_ops(struct rtattr *bpf_ops, __u16 len);
 
 int bpf_prog_load_dev(enum bpf_prog_type type, const struct bpf_insn *insns,
 		      size_t size_insns, const char *license, __u32 ifindex,
-		      char *log, size_t size_log);
+		      char *log, size_t size_log, bool verbose);
 int bpf_program_load(enum bpf_prog_type type, const struct bpf_insn *insns,
 		     size_t size_insns, const char *license, char *log,
-		     size_t size_log);
+		     size_t size_log, bool verbose);
 
 int bpf_prog_attach_fd(int prog_fd, int target_fd, enum bpf_attach_type type);
 int bpf_prog_detach_fd(int target_fd, enum bpf_attach_type type);
diff --git a/ip/ipvrf.c b/ip/ipvrf.c
index 12beaec3..e7c702ab 100644
--- a/ip/ipvrf.c
+++ b/ip/ipvrf.c
@@ -253,7 +253,8 @@ static int prog_load(int idx)
 	};
 
 	return bpf_program_load(BPF_PROG_TYPE_CGROUP_SOCK, prog, sizeof(prog),
-				"GPL", bpf_log_buf, sizeof(bpf_log_buf));
+				"GPL", bpf_log_buf, sizeof(bpf_log_buf),
+				false);
 }
 
 static int vrf_configure_cgroup(const char *path, int ifindex)
diff --git a/lib/bpf_legacy.c b/lib/bpf_legacy.c
index 3542b12f..844974e9 100644
--- a/lib/bpf_legacy.c
+++ b/lib/bpf_legacy.c
@@ -1098,7 +1098,7 @@ int bpf_prog_detach_fd(int target_fd, enum bpf_attach_type type)
 
 int bpf_prog_load_dev(enum bpf_prog_type type, const struct bpf_insn *insns,
 		      size_t size_insns, const char *license, __u32 ifindex,
-		      char *log, size_t size_log)
+		      char *log, size_t size_log, bool verbose)
 {
 	union bpf_attr attr = {};
 
@@ -1112,6 +1112,8 @@ int bpf_prog_load_dev(enum bpf_prog_type type, const struct bpf_insn *insns,
 		attr.log_buf = bpf_ptr_to_u64(log);
 		attr.log_size = size_log;
 		attr.log_level = 1;
+		if (verbose)
+			attr.log_level |= 2;
 	}
 
 	return bpf(BPF_PROG_LOAD, &attr, sizeof(attr));
@@ -1119,9 +1121,9 @@ int bpf_prog_load_dev(enum bpf_prog_type type, const struct bpf_insn *insns,
 
 int bpf_program_load(enum bpf_prog_type type, const struct bpf_insn *insns,
 		     size_t size_insns, const char *license, char *log,
-		     size_t size_log)
+		     size_t size_log, bool verbose)
 {
-	return bpf_prog_load_dev(type, insns, size_insns, license, 0, log, size_log);
+	return bpf_prog_load_dev(type, insns, size_insns, license, 0, log, size_log, verbose);
 }
 
 #ifdef HAVE_ELF
@@ -1543,7 +1545,7 @@ retry:
 	errno = 0;
 	fd = bpf_prog_load_dev(prog->type, prog->insns, prog->size,
 			       prog->license, ctx->ifindex,
-			       ctx->log, ctx->log_size);
+			       ctx->log, ctx->log_size, ctx->verbose);
 	if (fd < 0 || ctx->verbose) {
 		/* The verifier log is pretty chatty, sometimes so chatty
 		 * on larger programs, that we could fail to dump everything
diff --git a/lib/bpf_libbpf.c b/lib/bpf_libbpf.c
index 4a8a2032..08692d30 100644
--- a/lib/bpf_libbpf.c
+++ b/lib/bpf_libbpf.c
@@ -289,6 +289,8 @@ static int load_bpf_object(struct bpf_cfg_in *cfg)
 
 #if (LIBBPF_MAJOR_VERSION > 0) || (LIBBPF_MINOR_VERSION >= 7)
 	open_opts.kernel_log_level = 1;
+	if (cfg->verbose)
+		open_opts.kernel_log_level |= 2;
 #endif
 
 	obj = bpf_object__open_file(cfg->object, &open_opts);
-- 
2.42.0


