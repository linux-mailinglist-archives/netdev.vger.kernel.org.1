Return-Path: <netdev+bounces-43143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2057D18F9
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 00:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F10D1C20A46
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 22:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771BE32C93;
	Fri, 20 Oct 2023 22:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOPM9KKe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A99F321A4
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 22:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BD2C433C8;
	Fri, 20 Oct 2023 22:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697840309;
	bh=Stoe6dKh+53RQ9YVwiIy83ae2t3P18qUvZn2XWrjduk=;
	h=From:To:Cc:Subject:Date:From;
	b=VOPM9KKeqvfbs64AnsHnhq4wLbsg2OdDQHXOdnuC9NYl7TYhXswjacpHtGtZKnJUc
	 xCLOcw58TU1o/bzymHd7nZ8F6+mNrBvcGyW6SeONcVA6KPByvA8lyyqeI54lJPMe4r
	 /xcPeOCBHV2sEpOWOkWRrJCSAWSes+XaHuVXMDhOWIOBMlnyTc8idhvqn3MwpVMnbH
	 699ekOgEKFOlH5hYd6VqFdTezZJIR5Z0befmUBXvsgyTVdHaIeM7QmZg56SKVTI6Ep
	 2NFZCxjF03ersg4NJixktSY6YFOhbC2asgOWk6w3MwG9muIcZpTXweNEWEyDp9u8qj
	 zm52p4LKMxqJw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	amritha.nambiar@intel.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	chuck.lever@oracle.com,
	sdf@google.com
Subject: [PATCH net-next] tools: ynl-gen: change spacing around __attribute__
Date: Fri, 20 Oct 2023 15:18:27 -0700
Message-ID: <20231020221827.3436697-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpatch gets confused and treats __attribute__ as a function call.
It complains about white space before "(":

WARNING:SPACING: space prohibited between function name and open parenthesis '('
+	struct netdev_queue_get_rsp obj __attribute__ ((aligned (8)));

No spaces wins in the kernel:

  $ git grep 'attribute__((.*aligned(' | wc -l
  480
  $ git grep 'attribute__ ((.*aligned (' | wc -l
  110
  $ git grep 'attribute__ ((.*aligned(' | wc -l
  94
  $ git grep 'attribute__((.*aligned (' | wc -l
  63

So, whatever, change the codegen.

Note that checkpatch also thinks we should use __aligned(),
but this is user space code.

Link: https://lore.kernel.org/all/202310190900.9Dzgkbev-lkp@intel.com/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: amritha.nambiar@intel.com
CC: jiri@resnulli.us
CC: donald.hunter@gmail.com
CC: chuck.lever@oracle.com
CC: sdf@google.com
---
 tools/net/ynl/generated/devlink-user.h   | 32 ++++-----
 tools/net/ynl/generated/ethtool-user.h   | 82 ++++++++++++------------
 tools/net/ynl/generated/fou-user.h       |  2 +-
 tools/net/ynl/generated/handshake-user.h |  2 +-
 tools/net/ynl/generated/netdev-user.h    |  4 +-
 tools/net/ynl/lib/ynl.h                  |  4 +-
 tools/net/ynl/ynl-gen-c.py               |  2 +-
 7 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/tools/net/ynl/generated/devlink-user.h b/tools/net/ynl/generated/devlink-user.h
index 4b686d147613..f5656bc28db4 100644
--- a/tools/net/ynl/generated/devlink-user.h
+++ b/tools/net/ynl/generated/devlink-user.h
@@ -134,7 +134,7 @@ devlink_get(struct ynl_sock *ys, struct devlink_get_req *req);
 /* DEVLINK_CMD_GET - dump */
 struct devlink_get_list {
 	struct devlink_get_list *next;
-	struct devlink_get_rsp obj __attribute__ ((aligned (8)));
+	struct devlink_get_rsp obj __attribute__((aligned(8)));
 };
 
 void devlink_get_list_free(struct devlink_get_list *rsp);
@@ -262,7 +262,7 @@ struct devlink_port_get_rsp_dump {
 
 struct devlink_port_get_rsp_list {
 	struct devlink_port_get_rsp_list *next;
-	struct devlink_port_get_rsp_dump obj __attribute__ ((aligned (8)));
+	struct devlink_port_get_rsp_dump obj __attribute__((aligned(8)));
 };
 
 void devlink_port_get_rsp_list_free(struct devlink_port_get_rsp_list *rsp);
@@ -379,7 +379,7 @@ devlink_sb_get_req_dump_set_dev_name(struct devlink_sb_get_req_dump *req,
 
 struct devlink_sb_get_list {
 	struct devlink_sb_get_list *next;
-	struct devlink_sb_get_rsp obj __attribute__ ((aligned (8)));
+	struct devlink_sb_get_rsp obj __attribute__((aligned(8)));
 };
 
 void devlink_sb_get_list_free(struct devlink_sb_get_list *rsp);
@@ -509,7 +509,7 @@ devlink_sb_pool_get_req_dump_set_dev_name(struct devlink_sb_pool_get_req_dump *r
 
 struct devlink_sb_pool_get_list {
 	struct devlink_sb_pool_get_list *next;
-	struct devlink_sb_pool_get_rsp obj __attribute__ ((aligned (8)));
+	struct devlink_sb_pool_get_rsp obj __attribute__((aligned(8)));
 };
 
 void devlink_sb_pool_get_list_free(struct devlink_sb_pool_get_list *rsp);
@@ -654,7 +654,7 @@ devlink_sb_port_pool_get_req_dump_set_dev_name(struct devlink_sb_port_pool_get_r
 
 struct devlink_sb_port_pool_get_list {
 	struct devlink_sb_port_pool_get_list *next;
-	struct devlink_sb_port_pool_get_rsp obj __attribute__ ((aligned (8)));
+	struct devlink_sb_port_pool_get_rsp obj __attribute__((aligned(8)));
 };
 
 void
@@ -811,7 +811,7 @@ devlink_sb_tc_pool_bind_get_req_dump_set_dev_name(struct devlink_sb_tc_pool_bind
 
 struct devlink_sb_tc_pool_bind_get_list {
 	struct devlink_sb_tc_pool_bind_get_list *next;
-	struct devlink_sb_tc_pool_bind_get_rsp obj __attribute__ ((aligned (8)));
+	struct devlink_sb_tc_pool_bind_get_rsp obj __attribute__((aligned(8)));
 };
 
 void
@@ -933,7 +933,7 @@ devlink_param_get_req_dump_set_dev_name(struct devlink_param_get_req_dump *req,
 
 struct devlink_param_get_list {
 	struct devlink_param_get_list *next;
-	struct devlink_param_get_rsp obj __attribute__ ((aligned (8)));
+	struct devlink_param_get_rsp obj __attribute__((aligned(8)));
 };
 
 void devlink_param_get_list_free(struct devlink_param_get_list *rsp);
@@ -1065,7 +1065,7 @@ devlink_region_get_req_dump_set_dev_name(struct devlink_region_get_req_dump *req
 
 struct devlink_region_get_list {
 	struct devlink_region_get_list *next;
-	struct devlink_region_get_rsp obj __attribute__ ((aligned (8)));
+	struct devlink_region_get_rsp obj __attribute__((aligned(8)));
 };
 
 void devlink_region_get_list_free(struct devlink_region_get_list *rsp);
@@ -1144,7 +1144,7 @@ devlink_info_get(struct ynl_sock *ys, struct devlink_info_get_req *req);
 /* DEVLINK_CMD_INFO_GET - dump */
 struct devlink_info_get_list {
 	struct devlink_info_get_list *next;
-	struct devlink_info_get_rsp obj __attribute__ ((aligned (8)));
+	struct devlink_info_get_rsp obj __attribute__((aligned(8)));
 };
 
 void devlink_info_get_list_free(struct devlink_info_get_list *rsp);
@@ -1288,7 +1288,7 @@ devlink_health_reporter_get_req_dump_set_port_index(struct devlink_health_report
 
 struct devlink_health_reporter_get_list {
 	struct devlink_health_reporter_get_list *next;
-	struct devlink_health_reporter_get_rsp obj __attribute__ ((aligned (8)));
+	struct devlink_health_reporter_get_rsp obj __attribute__((aligned(8)));
 };
 
 void
@@ -1410,7 +1410,7 @@ devlink_trap_get_req_dump_set_dev_name(struct devlink_trap_get_req_dump *req,
 
 struct devlink_trap_get_list {
 	struct devlink_trap_get_list *next;
-	struct devlink_trap_get_rsp obj __attribute__ ((aligned (8)));
+	struct devlink_trap_get_rsp obj __attribute__((aligned(8)));
 };
 
 void devlink_trap_get_list_free(struct devlink_trap_get_list *rsp);
@@ -1534,7 +1534,7 @@ devlink_trap_group_get_req_dump_set_dev_name(struct devlink_trap_group_get_req_d
 
 struct devlink_trap_group_get_list {
 	struct devlink_trap_group_get_list *next;
-	struct devlink_trap_group_get_rsp obj __attribute__ ((aligned (8)));
+	struct devlink_trap_group_get_rsp obj __attribute__((aligned(8)));
 };
 
 void devlink_trap_group_get_list_free(struct devlink_trap_group_get_list *rsp);
@@ -1657,7 +1657,7 @@ devlink_trap_policer_get_req_dump_set_dev_name(struct devlink_trap_policer_get_r
 
 struct devlink_trap_policer_get_list {
 	struct devlink_trap_policer_get_list *next;
-	struct devlink_trap_policer_get_rsp obj __attribute__ ((aligned (8)));
+	struct devlink_trap_policer_get_rsp obj __attribute__((aligned(8)));
 };
 
 void
@@ -1790,7 +1790,7 @@ devlink_rate_get_req_dump_set_dev_name(struct devlink_rate_get_req_dump *req,
 
 struct devlink_rate_get_list {
 	struct devlink_rate_get_list *next;
-	struct devlink_rate_get_rsp obj __attribute__ ((aligned (8)));
+	struct devlink_rate_get_rsp obj __attribute__((aligned(8)));
 };
 
 void devlink_rate_get_list_free(struct devlink_rate_get_list *rsp);
@@ -1910,7 +1910,7 @@ devlink_linecard_get_req_dump_set_dev_name(struct devlink_linecard_get_req_dump
 
 struct devlink_linecard_get_list {
 	struct devlink_linecard_get_list *next;
-	struct devlink_linecard_get_rsp obj __attribute__ ((aligned (8)));
+	struct devlink_linecard_get_rsp obj __attribute__((aligned(8)));
 };
 
 void devlink_linecard_get_list_free(struct devlink_linecard_get_list *rsp);
@@ -1981,7 +1981,7 @@ devlink_selftests_get(struct ynl_sock *ys,
 /* DEVLINK_CMD_SELFTESTS_GET - dump */
 struct devlink_selftests_get_list {
 	struct devlink_selftests_get_list *next;
-	struct devlink_selftests_get_rsp obj __attribute__ ((aligned (8)));
+	struct devlink_selftests_get_rsp obj __attribute__((aligned(8)));
 };
 
 void devlink_selftests_get_list_free(struct devlink_selftests_get_list *rsp);
diff --git a/tools/net/ynl/generated/ethtool-user.h b/tools/net/ynl/generated/ethtool-user.h
index ddc1a5209992..ca0ec5fd7798 100644
--- a/tools/net/ynl/generated/ethtool-user.h
+++ b/tools/net/ynl/generated/ethtool-user.h
@@ -347,7 +347,7 @@ ethtool_strset_get_req_dump_set_counts_only(struct ethtool_strset_get_req_dump *
 
 struct ethtool_strset_get_list {
 	struct ethtool_strset_get_list *next;
-	struct ethtool_strset_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_strset_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_strset_get_list_free(struct ethtool_strset_get_list *rsp);
@@ -472,7 +472,7 @@ ethtool_linkinfo_get_req_dump_set_header_flags(struct ethtool_linkinfo_get_req_d
 
 struct ethtool_linkinfo_get_list {
 	struct ethtool_linkinfo_get_list *next;
-	struct ethtool_linkinfo_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_linkinfo_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_linkinfo_get_list_free(struct ethtool_linkinfo_get_list *rsp);
@@ -487,7 +487,7 @@ struct ethtool_linkinfo_get_ntf {
 	__u8 cmd;
 	struct ynl_ntf_base_type *next;
 	void (*free)(struct ethtool_linkinfo_get_ntf *ntf);
-	struct ethtool_linkinfo_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_linkinfo_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_linkinfo_get_ntf_free(struct ethtool_linkinfo_get_ntf *rsp);
@@ -712,7 +712,7 @@ ethtool_linkmodes_get_req_dump_set_header_flags(struct ethtool_linkmodes_get_req
 
 struct ethtool_linkmodes_get_list {
 	struct ethtool_linkmodes_get_list *next;
-	struct ethtool_linkmodes_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_linkmodes_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_linkmodes_get_list_free(struct ethtool_linkmodes_get_list *rsp);
@@ -727,7 +727,7 @@ struct ethtool_linkmodes_get_ntf {
 	__u8 cmd;
 	struct ynl_ntf_base_type *next;
 	void (*free)(struct ethtool_linkmodes_get_ntf *ntf);
-	struct ethtool_linkmodes_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_linkmodes_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_linkmodes_get_ntf_free(struct ethtool_linkmodes_get_ntf *rsp);
@@ -1014,7 +1014,7 @@ ethtool_linkstate_get_req_dump_set_header_flags(struct ethtool_linkstate_get_req
 
 struct ethtool_linkstate_get_list {
 	struct ethtool_linkstate_get_list *next;
-	struct ethtool_linkstate_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_linkstate_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_linkstate_get_list_free(struct ethtool_linkstate_get_list *rsp);
@@ -1129,7 +1129,7 @@ ethtool_debug_get_req_dump_set_header_flags(struct ethtool_debug_get_req_dump *r
 
 struct ethtool_debug_get_list {
 	struct ethtool_debug_get_list *next;
-	struct ethtool_debug_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_debug_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_debug_get_list_free(struct ethtool_debug_get_list *rsp);
@@ -1144,7 +1144,7 @@ struct ethtool_debug_get_ntf {
 	__u8 cmd;
 	struct ynl_ntf_base_type *next;
 	void (*free)(struct ethtool_debug_get_ntf *ntf);
-	struct ethtool_debug_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_debug_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_debug_get_ntf_free(struct ethtool_debug_get_ntf *rsp);
@@ -1330,7 +1330,7 @@ ethtool_wol_get_req_dump_set_header_flags(struct ethtool_wol_get_req_dump *req,
 
 struct ethtool_wol_get_list {
 	struct ethtool_wol_get_list *next;
-	struct ethtool_wol_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_wol_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_wol_get_list_free(struct ethtool_wol_get_list *rsp);
@@ -1344,7 +1344,7 @@ struct ethtool_wol_get_ntf {
 	__u8 cmd;
 	struct ynl_ntf_base_type *next;
 	void (*free)(struct ethtool_wol_get_ntf *ntf);
-	struct ethtool_wol_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_wol_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_wol_get_ntf_free(struct ethtool_wol_get_ntf *rsp);
@@ -1546,7 +1546,7 @@ ethtool_features_get_req_dump_set_header_flags(struct ethtool_features_get_req_d
 
 struct ethtool_features_get_list {
 	struct ethtool_features_get_list *next;
-	struct ethtool_features_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_features_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_features_get_list_free(struct ethtool_features_get_list *rsp);
@@ -1561,7 +1561,7 @@ struct ethtool_features_get_ntf {
 	__u8 cmd;
 	struct ynl_ntf_base_type *next;
 	void (*free)(struct ethtool_features_get_ntf *ntf);
-	struct ethtool_features_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_features_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_features_get_ntf_free(struct ethtool_features_get_ntf *rsp);
@@ -1843,7 +1843,7 @@ ethtool_privflags_get_req_dump_set_header_flags(struct ethtool_privflags_get_req
 
 struct ethtool_privflags_get_list {
 	struct ethtool_privflags_get_list *next;
-	struct ethtool_privflags_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_privflags_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_privflags_get_list_free(struct ethtool_privflags_get_list *rsp);
@@ -1858,7 +1858,7 @@ struct ethtool_privflags_get_ntf {
 	__u8 cmd;
 	struct ynl_ntf_base_type *next;
 	void (*free)(struct ethtool_privflags_get_ntf *ntf);
-	struct ethtool_privflags_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_privflags_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_privflags_get_ntf_free(struct ethtool_privflags_get_ntf *rsp);
@@ -2072,7 +2072,7 @@ ethtool_rings_get_req_dump_set_header_flags(struct ethtool_rings_get_req_dump *r
 
 struct ethtool_rings_get_list {
 	struct ethtool_rings_get_list *next;
-	struct ethtool_rings_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_rings_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_rings_get_list_free(struct ethtool_rings_get_list *rsp);
@@ -2087,7 +2087,7 @@ struct ethtool_rings_get_ntf {
 	__u8 cmd;
 	struct ynl_ntf_base_type *next;
 	void (*free)(struct ethtool_rings_get_ntf *ntf);
-	struct ethtool_rings_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_rings_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_rings_get_ntf_free(struct ethtool_rings_get_ntf *rsp);
@@ -2395,7 +2395,7 @@ ethtool_channels_get_req_dump_set_header_flags(struct ethtool_channels_get_req_d
 
 struct ethtool_channels_get_list {
 	struct ethtool_channels_get_list *next;
-	struct ethtool_channels_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_channels_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_channels_get_list_free(struct ethtool_channels_get_list *rsp);
@@ -2410,7 +2410,7 @@ struct ethtool_channels_get_ntf {
 	__u8 cmd;
 	struct ynl_ntf_base_type *next;
 	void (*free)(struct ethtool_channels_get_ntf *ntf);
-	struct ethtool_channels_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_channels_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_channels_get_ntf_free(struct ethtool_channels_get_ntf *rsp);
@@ -2697,7 +2697,7 @@ ethtool_coalesce_get_req_dump_set_header_flags(struct ethtool_coalesce_get_req_d
 
 struct ethtool_coalesce_get_list {
 	struct ethtool_coalesce_get_list *next;
-	struct ethtool_coalesce_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_coalesce_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_coalesce_get_list_free(struct ethtool_coalesce_get_list *rsp);
@@ -2712,7 +2712,7 @@ struct ethtool_coalesce_get_ntf {
 	__u8 cmd;
 	struct ynl_ntf_base_type *next;
 	void (*free)(struct ethtool_coalesce_get_ntf *ntf);
-	struct ethtool_coalesce_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_coalesce_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_coalesce_get_ntf_free(struct ethtool_coalesce_get_ntf *rsp);
@@ -3124,7 +3124,7 @@ ethtool_pause_get_req_dump_set_header_flags(struct ethtool_pause_get_req_dump *r
 
 struct ethtool_pause_get_list {
 	struct ethtool_pause_get_list *next;
-	struct ethtool_pause_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_pause_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_pause_get_list_free(struct ethtool_pause_get_list *rsp);
@@ -3139,7 +3139,7 @@ struct ethtool_pause_get_ntf {
 	__u8 cmd;
 	struct ynl_ntf_base_type *next;
 	void (*free)(struct ethtool_pause_get_ntf *ntf);
-	struct ethtool_pause_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_pause_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_pause_get_ntf_free(struct ethtool_pause_get_ntf *rsp);
@@ -3360,7 +3360,7 @@ ethtool_eee_get_req_dump_set_header_flags(struct ethtool_eee_get_req_dump *req,
 
 struct ethtool_eee_get_list {
 	struct ethtool_eee_get_list *next;
-	struct ethtool_eee_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_eee_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_eee_get_list_free(struct ethtool_eee_get_list *rsp);
@@ -3374,7 +3374,7 @@ struct ethtool_eee_get_ntf {
 	__u8 cmd;
 	struct ynl_ntf_base_type *next;
 	void (*free)(struct ethtool_eee_get_ntf *ntf);
-	struct ethtool_eee_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_eee_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_eee_get_ntf_free(struct ethtool_eee_get_ntf *rsp);
@@ -3623,7 +3623,7 @@ ethtool_tsinfo_get_req_dump_set_header_flags(struct ethtool_tsinfo_get_req_dump
 
 struct ethtool_tsinfo_get_list {
 	struct ethtool_tsinfo_get_list *next;
-	struct ethtool_tsinfo_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_tsinfo_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_tsinfo_get_list_free(struct ethtool_tsinfo_get_list *rsp);
@@ -3842,7 +3842,7 @@ ethtool_tunnel_info_get_req_dump_set_header_flags(struct ethtool_tunnel_info_get
 
 struct ethtool_tunnel_info_get_list {
 	struct ethtool_tunnel_info_get_list *next;
-	struct ethtool_tunnel_info_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_tunnel_info_get_rsp obj __attribute__((aligned(8)));
 };
 
 void
@@ -3964,7 +3964,7 @@ ethtool_fec_get_req_dump_set_header_flags(struct ethtool_fec_get_req_dump *req,
 
 struct ethtool_fec_get_list {
 	struct ethtool_fec_get_list *next;
-	struct ethtool_fec_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_fec_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_fec_get_list_free(struct ethtool_fec_get_list *rsp);
@@ -3978,7 +3978,7 @@ struct ethtool_fec_get_ntf {
 	__u8 cmd;
 	struct ynl_ntf_base_type *next;
 	void (*free)(struct ethtool_fec_get_ntf *ntf);
-	struct ethtool_fec_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_fec_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_fec_get_ntf_free(struct ethtool_fec_get_ntf *rsp);
@@ -4221,7 +4221,7 @@ ethtool_module_eeprom_get_req_dump_set_header_flags(struct ethtool_module_eeprom
 
 struct ethtool_module_eeprom_get_list {
 	struct ethtool_module_eeprom_get_list *next;
-	struct ethtool_module_eeprom_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_module_eeprom_get_rsp obj __attribute__((aligned(8)));
 };
 
 void
@@ -4340,7 +4340,7 @@ ethtool_phc_vclocks_get_req_dump_set_header_flags(struct ethtool_phc_vclocks_get
 
 struct ethtool_phc_vclocks_get_list {
 	struct ethtool_phc_vclocks_get_list *next;
-	struct ethtool_phc_vclocks_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_phc_vclocks_get_rsp obj __attribute__((aligned(8)));
 };
 
 void
@@ -4458,7 +4458,7 @@ ethtool_module_get_req_dump_set_header_flags(struct ethtool_module_get_req_dump
 
 struct ethtool_module_get_list {
 	struct ethtool_module_get_list *next;
-	struct ethtool_module_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_module_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_module_get_list_free(struct ethtool_module_get_list *rsp);
@@ -4473,7 +4473,7 @@ struct ethtool_module_get_ntf {
 	__u8 cmd;
 	struct ynl_ntf_base_type *next;
 	void (*free)(struct ethtool_module_get_ntf *ntf);
-	struct ethtool_module_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_module_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_module_get_ntf_free(struct ethtool_module_get_ntf *rsp);
@@ -4654,7 +4654,7 @@ ethtool_pse_get_req_dump_set_header_flags(struct ethtool_pse_get_req_dump *req,
 
 struct ethtool_pse_get_list {
 	struct ethtool_pse_get_list *next;
-	struct ethtool_pse_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_pse_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_pse_get_list_free(struct ethtool_pse_get_list *rsp);
@@ -4849,7 +4849,7 @@ ethtool_rss_get_req_dump_set_header_flags(struct ethtool_rss_get_req_dump *req,
 
 struct ethtool_rss_get_list {
 	struct ethtool_rss_get_list *next;
-	struct ethtool_rss_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_rss_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_rss_get_list_free(struct ethtool_rss_get_list *rsp);
@@ -4979,7 +4979,7 @@ ethtool_plca_get_cfg_req_dump_set_header_flags(struct ethtool_plca_get_cfg_req_d
 
 struct ethtool_plca_get_cfg_list {
 	struct ethtool_plca_get_cfg_list *next;
-	struct ethtool_plca_get_cfg_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_plca_get_cfg_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_plca_get_cfg_list_free(struct ethtool_plca_get_cfg_list *rsp);
@@ -4994,7 +4994,7 @@ struct ethtool_plca_get_cfg_ntf {
 	__u8 cmd;
 	struct ynl_ntf_base_type *next;
 	void (*free)(struct ethtool_plca_get_cfg_ntf *ntf);
-	struct ethtool_plca_get_cfg_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_plca_get_cfg_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_plca_get_cfg_ntf_free(struct ethtool_plca_get_cfg_ntf *rsp);
@@ -5244,7 +5244,7 @@ ethtool_plca_get_status_req_dump_set_header_flags(struct ethtool_plca_get_status
 
 struct ethtool_plca_get_status_list {
 	struct ethtool_plca_get_status_list *next;
-	struct ethtool_plca_get_status_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_plca_get_status_rsp obj __attribute__((aligned(8)));
 };
 
 void
@@ -5376,7 +5376,7 @@ ethtool_mm_get_req_dump_set_header_flags(struct ethtool_mm_get_req_dump *req,
 
 struct ethtool_mm_get_list {
 	struct ethtool_mm_get_list *next;
-	struct ethtool_mm_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_mm_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_mm_get_list_free(struct ethtool_mm_get_list *rsp);
@@ -5390,7 +5390,7 @@ struct ethtool_mm_get_ntf {
 	__u8 cmd;
 	struct ynl_ntf_base_type *next;
 	void (*free)(struct ethtool_mm_get_ntf *ntf);
-	struct ethtool_mm_get_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_mm_get_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_mm_get_ntf_free(struct ethtool_mm_get_ntf *rsp);
@@ -5504,7 +5504,7 @@ struct ethtool_cable_test_ntf {
 	__u8 cmd;
 	struct ynl_ntf_base_type *next;
 	void (*free)(struct ethtool_cable_test_ntf *ntf);
-	struct ethtool_cable_test_ntf_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_cable_test_ntf_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_cable_test_ntf_free(struct ethtool_cable_test_ntf *rsp);
@@ -5527,7 +5527,7 @@ struct ethtool_cable_test_tdr_ntf {
 	__u8 cmd;
 	struct ynl_ntf_base_type *next;
 	void (*free)(struct ethtool_cable_test_tdr_ntf *ntf);
-	struct ethtool_cable_test_tdr_ntf_rsp obj __attribute__ ((aligned (8)));
+	struct ethtool_cable_test_tdr_ntf_rsp obj __attribute__((aligned(8)));
 };
 
 void ethtool_cable_test_tdr_ntf_free(struct ethtool_cable_test_tdr_ntf *rsp);
diff --git a/tools/net/ynl/generated/fou-user.h b/tools/net/ynl/generated/fou-user.h
index a8f860892540..fd566716ddd6 100644
--- a/tools/net/ynl/generated/fou-user.h
+++ b/tools/net/ynl/generated/fou-user.h
@@ -333,7 +333,7 @@ struct fou_get_rsp *fou_get(struct ynl_sock *ys, struct fou_get_req *req);
 /* FOU_CMD_GET - dump */
 struct fou_get_list {
 	struct fou_get_list *next;
-	struct fou_get_rsp obj __attribute__ ((aligned (8)));
+	struct fou_get_rsp obj __attribute__((aligned(8)));
 };
 
 void fou_get_list_free(struct fou_get_list *rsp);
diff --git a/tools/net/ynl/generated/handshake-user.h b/tools/net/ynl/generated/handshake-user.h
index 2b34acc608de..bce537d8b8cc 100644
--- a/tools/net/ynl/generated/handshake-user.h
+++ b/tools/net/ynl/generated/handshake-user.h
@@ -90,7 +90,7 @@ struct handshake_accept_ntf {
 	__u8 cmd;
 	struct ynl_ntf_base_type *next;
 	void (*free)(struct handshake_accept_ntf *ntf);
-	struct handshake_accept_rsp obj __attribute__ ((aligned (8)));
+	struct handshake_accept_rsp obj __attribute__((aligned(8)));
 };
 
 void handshake_accept_ntf_free(struct handshake_accept_ntf *rsp);
diff --git a/tools/net/ynl/generated/netdev-user.h b/tools/net/ynl/generated/netdev-user.h
index b4351ff34595..4fafac879df3 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -69,7 +69,7 @@ netdev_dev_get(struct ynl_sock *ys, struct netdev_dev_get_req *req);
 /* NETDEV_CMD_DEV_GET - dump */
 struct netdev_dev_get_list {
 	struct netdev_dev_get_list *next;
-	struct netdev_dev_get_rsp obj __attribute__ ((aligned (8)));
+	struct netdev_dev_get_rsp obj __attribute__((aligned(8)));
 };
 
 void netdev_dev_get_list_free(struct netdev_dev_get_list *rsp);
@@ -82,7 +82,7 @@ struct netdev_dev_get_ntf {
 	__u8 cmd;
 	struct ynl_ntf_base_type *next;
 	void (*free)(struct netdev_dev_get_ntf *ntf);
-	struct netdev_dev_get_rsp obj __attribute__ ((aligned (8)));
+	struct netdev_dev_get_rsp obj __attribute__((aligned(8)));
 };
 
 void netdev_dev_get_ntf_free(struct netdev_dev_get_ntf *rsp);
diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
index 87b4dad832f0..cfefacb839f4 100644
--- a/tools/net/ynl/lib/ynl.h
+++ b/tools/net/ynl/lib/ynl.h
@@ -157,7 +157,7 @@ struct ynl_parse_arg {
 
 struct ynl_dump_list_type {
 	struct ynl_dump_list_type *next;
-	unsigned char data[] __attribute__ ((aligned (8)));
+	unsigned char data[] __attribute__((aligned(8)));
 };
 extern struct ynl_dump_list_type *YNL_LIST_END;
 
@@ -187,7 +187,7 @@ struct ynl_ntf_base_type {
 	__u8 cmd;
 	struct ynl_ntf_base_type *next;
 	void (*free)(struct ynl_ntf_base_type *ntf);
-	unsigned char data[] __attribute__ ((aligned (8)));
+	unsigned char data[] __attribute__((aligned(8)));
 };
 
 extern mnl_cb_t ynl_cb_array[NLMSG_MIN_TYPE];
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index a9e8898c9386..1d8b56f071b9 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1872,7 +1872,7 @@ _C_KW = {
         ri.cw.p('__u8 cmd;')
         ri.cw.p('struct ynl_ntf_base_type *next;')
         ri.cw.p(f"void (*free)({type_name(ri, 'reply')} *ntf);")
-    ri.cw.p(f"{type_name(ri, 'reply', deref=True)} obj __attribute__ ((aligned (8)));")
+    ri.cw.p(f"{type_name(ri, 'reply', deref=True)} obj __attribute__((aligned(8)));")
     ri.cw.block_end(line=';')
     ri.cw.nl()
     print_free_prototype(ri, 'reply')
-- 
2.41.0


