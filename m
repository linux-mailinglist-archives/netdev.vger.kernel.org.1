Return-Path: <netdev+bounces-184270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CEEA94062
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 01:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD43C4646A5
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 23:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F4D22D4C6;
	Fri, 18 Apr 2025 23:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXzRXqo9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500292B2DA
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 23:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745020186; cv=none; b=qMflW83hJ+o1r/iPldISGrHFtmWIec2JCnJ9XZZI7EzaomJjCy5EeX+TL0VGqf1QflsiiYhNtYNRTP4n0osF+ci+otmpxIas7QUxk0TJ8YTT9jv93RxNsW4yrEcuU4GkMWKtGKZ4QDR5zvHvc+86+91N6hvm5qUCs5aUsRFAnw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745020186; c=relaxed/simple;
	bh=DwRe2LfNhFsEetvCgbYKXkpNcTwgyCT8P7tQF6xqipM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=beX/u0kaa9JOn5bdlLt/K9S1He4FgF0GMjpQY5ovtF3u2uMuczpluXcQvRqyzXu2dRlyGlBEt0bdHylg+VcyItz8Dt/CCnf9lKpmW92HSD7hA33LRPhaF/V/WjTdieno1K6na5+KNNxjlwRP+vEBcdHF6SbocE/HWl9nViHwWPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXzRXqo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A64C4CEE2;
	Fri, 18 Apr 2025 23:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745020185;
	bh=DwRe2LfNhFsEetvCgbYKXkpNcTwgyCT8P7tQF6xqipM=;
	h=From:To:Cc:Subject:Date:From;
	b=IXzRXqo9rLHXeeEMNvkqpdEq/NXKGjE5vlqdIUC8+euU6zInbiwoAPQwMGKaaICs6
	 37wtCDDmNJfuL2fhrxg7xJN2A83v4Nfm76hIrJrYChDwnGnw8pmMOdKCYuqtnPVv0u
	 dyHk8vQ2CoLk0dKNtdJYofPOH+2pVU4On4CCGOlQLUUzlMGml5rAsNxRwNz8NhmchS
	 1gtPWo7Qq+a3Qa+2Af/PxVPi+WvYX9fa4MV2NMZVXvIbAu+KrnAMztNa+mpJ0Px6t9
	 yZ0w49IvMXcggaUl+K3o5U50Ab+uefJovfJQ9BOazX5FLKjXIJXGP1USEV8cTKoUsC
	 dFRKPwwYMVhXA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com
Subject: [PATCH net-next] tools: ynl: add missing header deps
Date: Fri, 18 Apr 2025 16:49:42 -0700
Message-ID: <20250418234942.2344036-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Various new families and my recent work on rtnetlink missed
adding dependencies on C headers. If the system headers are
up to date or don't include a given header at all this doesn't
make a difference. But if the system headers are in place but
stale - compilation will break.

Reported-by: Kory Maincent <kory.maincent@bootlin.com>
Fixes: 29d34a4d785b ("tools: ynl: generate code for rt-addr and add a sample")
Link: https://lore.kernel.org/20250418190431.69c10431@kmaincent-XPS-13-7390
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: jacob.e.keller@intel.com
---
 tools/net/ynl/Makefile.deps | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 385783489f84..8b7bf673b686 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -20,15 +20,18 @@ CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_ETHTOOL_H,ethtool.h) \
 	$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h) \
 	$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_GENERATED_H,ethtool_netlink_generated.h)
 CFLAGS_handshake:=$(call get_hdr_inc,_LINUX_HANDSHAKE_H,handshake.h)
+CFLAGS_lockd_netlink:=$(call get_hdr_inc,_LINUX_LOCKD_NETLINK_H,lockd_netlink.h)
 CFLAGS_mptcp_pm:=$(call get_hdr_inc,_LINUX_MPTCP_PM_H,mptcp_pm.h)
 CFLAGS_net_shaper:=$(call get_hdr_inc,_LINUX_NET_SHAPER_H,net_shaper.h)
 CFLAGS_netdev:=$(call get_hdr_inc,_LINUX_NETDEV_H,netdev.h)
 CFLAGS_nl80211:=$(call get_hdr_inc,__LINUX_NL802121_H,nl80211.h)
 CFLAGS_nlctrl:=$(call get_hdr_inc,__LINUX_GENERIC_NETLINK_H,genetlink.h)
 CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
+CFLAGS_ovpn:=$(call get_hdr_inc,_LINUX_OVPN,ovpn.h)
 CFLAGS_ovs_datapath:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_flow:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_vport:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
-CFLAGS_rt-addr:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
+CFLAGS_rt-addr:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
+	$(call get_hdr_inc,__LINUX_IF_ADDR_H,if_addr.h)
 CFLAGS_rt-route:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
 CFLAGS_tcp_metrics:=$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metrics.h)
-- 
2.49.0


