Return-Path: <netdev+bounces-83973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF67895256
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7171F22C76
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 12:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267186E602;
	Tue,  2 Apr 2024 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYynJrmA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EA06997B;
	Tue,  2 Apr 2024 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059341; cv=none; b=WysRzs5zh0/a0WVMVh8S1j7jwjvYZ4uwoA5+ZGCSfkr5/yvcFwkWKGooC0u90D1caDwMRFzHjF1Bdxa4DrR5hCH1n9Cc970Kbs+aVawRzwbjmjCgW2hjuI9bFuBUotTZdjHjePovLTnY9Qaga+3n1LpL96I9qwlaXFOPuNbhBNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059341; c=relaxed/simple;
	bh=L9kxXD48M3R+dEIlc+aRKazbrVnivr3btH9XrbQapYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AWqBAm/1nuQ7eASS5R0TgNgNFSVAw8vPqzC/qoWKUQ5f93skpAv36tq4DtI9acB5QlXhSOPO6zLatOiWWS3F+mVhghDnW2TcHXPxGXAoR0OeTvonHjC5SQUo77ARGN+sNtoubWax9at8dTYglFOq6rGrwjLwZgDV5gTwDbU85+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYynJrmA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712059339; x=1743595339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L9kxXD48M3R+dEIlc+aRKazbrVnivr3btH9XrbQapYQ=;
  b=aYynJrmAMSxNR6EmuaIFUy/ny1eMobWez1O54VduMdeUcFXoy4huX90+
   4LnIZcd2oC1TSXe9bHnkxWpkH5tThs86f9ifZUBcTZ9jguC+KJlD/YTSd
   bdYveitvq9phExP9FWxfWgselF9r3L8Ilp61AmIZO2aLwQGnAip4ky0Ky
   zxsQ4v8OVzmgclAWNziSbMT1fwR2COLzu51W/FhTX12T1EfHrDXKnPjPi
   ybwHVglyBd9U2bPWD49ANJVbJiLtz4Y/tzQs8qRE1ZLMss735aN0GrncK
   NHnbB0BHcnMMQifCQ41MoagOraXPBiujF21McBGJp+ghsOrXSnIU1Te8d
   g==;
X-CSE-ConnectionGUID: 6KqeoOTcTT2jAXEh2R3rnA==
X-CSE-MsgGUID: vF2mB+I0QLCGFiwg/ixTLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7067035"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7067035"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:02:19 -0700
X-CSE-ConnectionGUID: 68MMRf1ETpO0rm7kzZcUbQ==
X-CSE-MsgGUID: Je7BpCuCQ4Wne6MkaaoEhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="55494356"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:02:15 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Subject: [PATCH bpf-next v3 3/7] selftests/bpf: implement get_hw_ring_size function to retrieve current and max interface size
Date: Tue,  2 Apr 2024 11:45:25 +0000
Message-Id: <20240402114529.545475-4-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402114529.545475-1-tushar.vyavahare@intel.com>
References: <20240402114529.545475-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new function called get_hw_size that retrieves both the
current and maximum size of the interface and stores this information in
the 'ethtool_ringparam' structure.

Remove ethtool_channels struct from xdp_hw_metadata.c due to redefinition
error. Remove unused linux/if.h include from flow_dissector BPF test to
address CI pipeline failure.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 24 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  4 ++++
 .../selftests/bpf/prog_tests/flow_dissector.c |  1 -
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 14 -----------
 4 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 6db27a9088e9..1cab20020f94 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -497,3 +497,27 @@ int get_socket_local_port(int sock_fd)
 
 	return -1;
 }
+
+int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
+{
+	struct ifreq ifr = {0};
+	int sockfd, err;
+
+	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sockfd < 0)
+		return -errno;
+
+	memcpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
+
+	ring_param->cmd = ETHTOOL_GRINGPARAM;
+	ifr.ifr_data = (char *)ring_param;
+
+	if (ioctl(sockfd, SIOCETHTOOL, &ifr) < 0) {
+		err = errno;
+		close(sockfd);
+		return -err;
+	}
+
+	close(sockfd);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 94b9be24e39b..de4d27d201cb 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -9,8 +9,11 @@ typedef __u16 __sum16;
 #include <linux/if_packet.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/ethtool.h>
+#include <linux/sockios.h>
 #include <netinet/tcp.h>
 #include <bpf/bpf_endian.h>
+#include <net/if.h>
 
 #define MAGIC_VAL 0x1234
 #define NUM_ITER 100000
@@ -61,6 +64,7 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 		  struct sockaddr_storage *addr, socklen_t *len);
 char *ping_command(int family);
 int get_socket_local_port(int sock_fd);
+int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 
 struct nstoken;
 /**
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index c4773173a4e4..9e5f38739104 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -2,7 +2,6 @@
 #include <test_progs.h>
 #include <network_helpers.h>
 #include <error.h>
-#include <linux/if.h>
 #include <linux/if_tun.h>
 #include <sys/uio.h>
 
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index bdf5d8180067..0859fe727da7 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -495,20 +495,6 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
 	return 0;
 }
 
-struct ethtool_channels {
-	__u32	cmd;
-	__u32	max_rx;
-	__u32	max_tx;
-	__u32	max_other;
-	__u32	max_combined;
-	__u32	rx_count;
-	__u32	tx_count;
-	__u32	other_count;
-	__u32	combined_count;
-};
-
-#define ETHTOOL_GCHANNELS	0x0000003c /* Get no of channels */
-
 static int rxq_num(const char *ifname)
 {
 	struct ethtool_channels ch = {
-- 
2.34.1


