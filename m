Return-Path: <netdev+bounces-222840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C370B56723
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 09:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B3687AC317
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 07:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD6220FA81;
	Sun, 14 Sep 2025 07:07:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECFD1AA1D2
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 07:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757833630; cv=none; b=U8I/1pL+A0vXhdh/b4q9xaigigyfD2gfEuQlEyHJngZbwUJnd4LZneLqSiCDAbrVFdWU90GjNDyvXWWWJp1JksS3o1h0usZTn7V+jCxnTOjW0Sq43zzRBWCMLaUC6Q3qqhg9iOGmEJDbQuc5W1VlrVoMAng7Q5iryl1nHU8GIYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757833630; c=relaxed/simple;
	bh=IlJagysJYUQUPlk5oqzmYHPsxKlwdPkHd+MvNhMa//s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=niIXtmWCsqClKzUp09TvZbNFAa4AhKwnVFw9QMmIVbZvOJ4ICv211ZbfjAKhnTuAwLWRw12MkwsO3WfQ0RSAg2AfFvYprVxj9kQGK4fuD4V982MX2bRWfN7WymTzr4MF7lpTFo681IX4jzy+70ECgq2ajsu3bbeMKU5uODSJd+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=114.132.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz4t1757833591t991aa4fe
X-QQ-Originating-IP: kzqkpxbmBYEZy6qw4WJ/6EUJulMnzf8ACxs3aiZ7eaI=
Received: from MacBook-Pro-022.xiaojukeji.com ( [120.244.234.174])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 14 Sep 2025 15:06:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8066187958116989696
EX-QQ-RecipientCnt: 4
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH RESEND iproute2-next] ip/bond: add broadcast_neighbor support
Date: Sun, 14 Sep 2025 15:06:09 +0800
Message-Id: <20250914070609.37292-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NC8a1JKFOHmWknerBmCa4pCiuLVOl52g9nMohvmE8zGiFNIMtTHwanF3
	grXBQO3SxplC8xqJ3QxMDxgOifa4WM9oWrr3xVngck36/ljkFANq04M4Ey6D14Ji3gMgrbk
	dGWIJAITiRgeRvbZflyUFxvUEPBaVvDUKLD2Gr3/VztHDaV0uvnaheuE+FZwC/hJM4iwujl
	Rd+tumyEoFqeu939zR+kY6goN2ekTciNr4c6jZX54YTUTR3NaxLAcVVstKl57XVUkKvTdNX
	Y5QOjg1WhptIPAHF4GS1NIA1b6/zVm9ZiMuUVc+h748acCS3squycLNwa7R607nYkSlXdoM
	T2vT+kGukCN9OJDG0CbJavZFvziU/w93s92Q9txw664d+jwq41NyouKWeftfy46EKUOkuGd
	HaCKwz5Op98L8uwUej5SVt+UV/18wqBa3/FXDkXwD5agzmVsvrqNBDpcw8rMPYi9vZ2Srrr
	515m7Q1vkMjLg7cTEmp0QeCkp1vvMd9RFjkVryUVMiZzss9SRcaFfcM32UFmmLXFi6qInXa
	q8O8r4ZzcqARZOGap59DrxeOecVvm9sIdENHifjcrTY415hoqQKed+cX8aaLl5Q3SWcBA9Y
	I5oM3PrhzOz5EqxtmTRzBvOCU1aw+13GZcF2RK/zPNonq0+BsySCESEWIOmdB4idq45x1gw
	2PHrmrsdSSe1FphCapmUYF96Azv5yuEXBIIZ+6Jj2HOjpxp0bIXS5/d/vZ5aVfPtRaPSUf0
	X85xYFHgDoKiw7jmcK8/jKCoJsFCDXDdnQ/reRHxVgSsccta00sxoRtK4cGEI1JgDpQC5sK
	1yac75JR87nn0a4s6zJsUi42i4qaTgM4fkmHE/URClyPtLzuUZHHmH5gTac21otrpz73v0Z
	oUBO4kvcdsyHfZMw60E0FfUYxwf40gSYGIeEVPw9//oVmRWwnRMKfUUqJZBUO7pGRxGjxCO
	ELAAayI3FIIAwMKX5vwqLpto4TQFq4WvaQV7j06ncQECQqRB7ffYefhwpcE9I8lerQD/rBN
	7I3ur7DLsWOlRQbxhT
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

This option has no effect in modes other than 802.3ad mode.
When this option enabled, the bond device will broadcast ARP/ND
packets to all active slaves.

Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
---
1. no update uapi header. https://marc.info/?l=linux-netdev&m=170614774224160&w=3
2. the kernel patch is accpted, https://patchwork.kernel.org/project/netdevbpf/patch/84d0a044514157bb856a10b6d03a1028c4883561.1751031306.git.tonghao@bamaicloud.com/
---
 ip/iplink_bond.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index a964f547..b1b144fb 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -149,6 +149,7 @@ static void print_explain(FILE *f)
 		"                [ lacp_rate LACP_RATE ]\n"
 		"                [ lacp_active LACP_ACTIVE]\n"
 		"                [ coupled_control COUPLED_CONTROL ]\n"
+		"                [ broadcast_neighbor BROADCAST_NEIGHBOR ]\n"
 		"                [ ad_select AD_SELECT ]\n"
 		"                [ ad_user_port_key PORTKEY ]\n"
 		"                [ ad_actor_sys_prio SYSPRIO ]\n"
@@ -165,6 +166,7 @@ static void print_explain(FILE *f)
 		"LACP_RATE := slow|fast\n"
 		"AD_SELECT := stable|bandwidth|count\n"
 		"COUPLED_CONTROL := off|on\n"
+		"BROADCAST_NEIGHBOR := off|on\n"
 	);
 }

@@ -184,6 +186,7 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
 	__u32 arp_all_targets, resend_igmp, min_links, lp_interval;
 	__u32 packets_per_slave;
 	__u8 missed_max;
+	__u8 broadcast_neighbor;
 	unsigned int ifindex;
 	int ret;

@@ -376,6 +379,12 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
 			if (ret)
 				return ret;
 			addattr8(n, 1024, IFLA_BOND_COUPLED_CONTROL, coupled_control);
+		} else if (strcmp(*argv, "broadcast_neighbor") == 0) {
+			NEXT_ARG();
+			broadcast_neighbor = parse_on_off("broadcast_neighbor", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr8(n, 1024, IFLA_BOND_BROADCAST_NEIGH, broadcast_neighbor);
 		} else if (matches(*argv, "ad_select") == 0) {
 			NEXT_ARG();
 			if (get_index(ad_select_tbl, *argv) < 0)
@@ -675,6 +684,13 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			     rta_getattr_u8(tb[IFLA_BOND_COUPLED_CONTROL]));
 	}

+	if (tb[IFLA_BOND_BROADCAST_NEIGH]) {
+		print_on_off(PRINT_ANY,
+			     "broadcast_neighbor",
+			     "broadcast_neighbor %s ",
+			     rta_getattr_u8(tb[IFLA_BOND_BROADCAST_NEIGH]));
+	}
+
 	if (tb[IFLA_BOND_AD_SELECT]) {
 		const char *ad_select = get_name(ad_select_tbl,
 						 rta_getattr_u8(tb[IFLA_BOND_AD_SELECT]));
--
2.34.1


