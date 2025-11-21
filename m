Return-Path: <netdev+bounces-240802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292D0C7AAB6
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03063A1EAD
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 15:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F7833EB11;
	Fri, 21 Nov 2025 15:52:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AF1345CCC
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740352; cv=none; b=GD1qBFinfB2+90fcZSjsrkdPGPZ7+SRAy1CRCbx7ARGKQFAvCnwyTCvpqo8K4HEz0uGpI63McQ/Evo0GHDDjZM3sOBLD+019TPcq3G6GYRIH0Y1pmnZmyts6XxRVgR3wclQ4MJgEY9tcgyOGmZ5u5b522iTOacuZl3Fjd8AC9/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740352; c=relaxed/simple;
	bh=zHQxOHvYcnTsSzrzz0esYxSj0e8kf6PsrF0/TALdKkA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZguMe1QfBgFd4szojEi38bBAjN6WJ9FuYKg2Ey2a9WnDIFev+GHUJhygWDTs5j2ZOyGIPFywtxltpxasyf6LH20jR4yFlBZJUIegMEe2LhC0c8CktKF+4p9XHTv+5U4uMN4Ys/VElk/lRNpyVTXhdJX8ZSVNBIGm47jp6Coq30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dCfpq4mbNzHnGkK;
	Fri, 21 Nov 2025 23:51:47 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 9DC011402FF;
	Fri, 21 Nov 2025 23:52:24 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Nov 2025 18:52:24 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>
CC: <stephen@networkplumber.org>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>
Subject: [PATCH iproute2-next 3/3] Support l2macnat in ip util
Date: Fri, 21 Nov 2025 18:52:12 +0300
Message-ID: <20251121155212.4182474-4-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121155212.4182474-1-skorodumov.dmitry@huawei.com>
References: <20251121155212.4182474-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500004.china.huawei.com (7.188.26.250)

Supported mode l2macnat for ip add link type ipvlan/ipvtap

Mode was also described in man-page.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 include/uapi/linux/if_link.h |  1 +
 ip/iplink_ipvlan.c           |  8 ++++++--
 man/man8/ip-link.8.in        | 11 ++++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index d05f5cc7..e17e684d 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1267,6 +1267,7 @@ enum ipvlan_mode {
 	IPVLAN_MODE_L2 = 0,
 	IPVLAN_MODE_L3,
 	IPVLAN_MODE_L3S,
+	IPVLAN_MODE_L2_MACNAT,
 	IPVLAN_MODE_MAX
 };
 
diff --git a/ip/iplink_ipvlan.c b/ip/iplink_ipvlan.c
index 691fd6f3..b80ab19b 100644
--- a/ip/iplink_ipvlan.c
+++ b/ip/iplink_ipvlan.c
@@ -19,7 +19,7 @@ static void print_explain(struct link_util *lu, FILE *f)
 	fprintf(f,
 		"Usage: ... %s [ mode MODE ] [ FLAGS ]\n"
 		"\n"
-		"MODE: l3 | l3s | l2\n"
+		"MODE: l3 | l3s | l2 | l2macnat\n"
 		"FLAGS: bridge | private | vepa\n"
 		"(first values are the defaults if nothing is specified).\n",
 		lu->id);
@@ -29,6 +29,8 @@ static int get_ipvlan_mode(const char *mode)
 {
 	if (strcmp(mode, "l2") == 0)
 		return IPVLAN_MODE_L2;
+	if (strcmp(mode, "l2macnat") == 0)
+		return IPVLAN_MODE_L2_MACNAT;
 	if (strcmp(mode, "l3") == 0)
 		return IPVLAN_MODE_L3;
 	if (strcmp(mode, "l3s") == 0)
@@ -41,6 +43,8 @@ static const char *get_ipvlan_mode_name(__u16 mode)
 	switch (mode) {
 	case IPVLAN_MODE_L2:
 		return "l2";
+	case IPVLAN_MODE_L2_MACNAT:
+		return "l2macnat";
 	case IPVLAN_MODE_L3:
 		return "l3";
 	case IPVLAN_MODE_L3S:
@@ -65,7 +69,7 @@ static int ipvlan_parse_opt(struct link_util *lu, int argc, char **argv,
 			mode = get_ipvlan_mode(*argv);
 			if (mode < 0) {
 				fprintf(stderr, "Error: argument of \"mode\" must be either "
-					"\"l2\", \"l3\" or \"l3s\"\n");
+					"\"l2\", \"l2macnat\", \"l3\" or \"l3s\"\n");
 				return -1;
 			}
 			addattr16(n, 1024, IFLA_IPVLAN_MODE, (__u16)mode);
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index def83184..28fa2f7a 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1662,7 +1662,7 @@ the following additional arguments are supported:
 
 .BI "ip link add link " MASTER " name " SLAVE
 .BR type " { " ipvlan " | " ipvtap " } "
-.RB " [ " mode " { " l3 " | " l3s " | " l2 " } ] "
+.RB " [ " mode " { " l3 " | " l3s " | " l2 " | " l2macnat " } ] "
 .RB " [ { " bridge " | " private " | " vepa " } ] "
 
 .in +8
@@ -1690,6 +1690,15 @@ slave device and packets are switched and queued to the master device to send
 out. In this mode the slaves will RX/TX multicast and broadcast (if applicable)
 as well.
 
+.B mode l2macnat
+- This mode extends the L2 mode and is primarily designed for desktop virtual
+machines that need to bridge to wireless interfaces. In standard L2 mode,
+you must configure IP addresses on slave interfaces to enable frame
+multiplexing between slaves and the master. In
+.BR l2macnat
+mode, IPVLAN automatically learns IPv4/IPv6 and MAC addresses
+from outgoing packets.
+
 .B bridge
 - Default option. All endpoints are directly connected to each other,
 communication is not redirected through the physical interface's peer.
-- 
2.25.1


