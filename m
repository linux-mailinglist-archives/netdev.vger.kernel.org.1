Return-Path: <netdev+bounces-83974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B0F89525A
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E081F222A5
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 12:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8538879B77;
	Tue,  2 Apr 2024 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IS9FpKpo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD39778691;
	Tue,  2 Apr 2024 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059344; cv=none; b=HAzWSBWlnNDHHiu+2dexQ2NtZXtPOkT++vWYdVo/+QWVJgSCZ+umZOdKq/FY8HMZUQ8/urn6i+5O8yi4EEz2u3E71zj+fNJ5YeybD0bVO0eqzCoNUssQ3qTZYfC0MZKi2TltAUTC43v1lPeCMNNDLDhKGCQwpGo09ijle7Xxrm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059344; c=relaxed/simple;
	bh=tnh61gy3Hi24ulmSCoHJWEcsDEYuQESZN/JaYY3buA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UdAuEND6gXYCo+x+GqxV78jAhlhN0+h5vvSHi8E4LHQhyXMrEHsYbNMNh91CM3hp7jrGE3GErScsM7SnKGrbiZSWK+WfAgkBqVdYdM4fBLDM8hhNplWq+rSOW4IcFg1eU/Dllz/MwQUPBxy1twU0fJPqeuRHC5apOcfcqQCBd2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IS9FpKpo; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712059343; x=1743595343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tnh61gy3Hi24ulmSCoHJWEcsDEYuQESZN/JaYY3buA4=;
  b=IS9FpKpo1OpsCI1I0I3s7/MddhIYhnX+RO+PtVXs9yQgM5IbyvoiMKOQ
   tDJN8o/fbIeM9I9lAIFzRTaqZOyNsfzMF3uUHDQRKFIh1tMqrbCzLZYME
   Ue7DNTgcULfDOS9ZaIqVaPRaijwfp2J4KHVidUdE8f5Ib1zBZH9BGqJBL
   waW+1Av3E8kx0Fdlk9sZEBJTWdCGMW08mGWxxeXxIeUnVksGjL+y4nsAb
   QfLh4CwQyLsJUQ9WBknJuEDg6sOc/SByiKAxdOvb47sqPgRR2Z/CKgASg
   OhF6qUDnjVo5UR7eBmMY0NXCbnFpASaMe+y9Yc2k+2bCbgbZ95L1NrMQg
   A==;
X-CSE-ConnectionGUID: layHTusARS6Tq23BIWX5cw==
X-CSE-MsgGUID: aeHIbWZ3Q5+/EYDo5wlEyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7067050"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7067050"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:02:23 -0700
X-CSE-ConnectionGUID: xOqx1L5FRMyvQU/VmVNICQ==
X-CSE-MsgGUID: maPrLViuSUSX7cGqKVxuHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="55494376"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:02:19 -0700
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
Subject: [PATCH bpf-next v3 4/7] selftests/bpf: implement set_hw_ring_size function to configure interface ring size
Date: Tue,  2 Apr 2024 11:45:26 +0000
Message-Id: <20240402114529.545475-5-tushar.vyavahare@intel.com>
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

Introduce a new function called set_hw_ring_size that allows for the
dynamic configuration of the ring size within the interface.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 24 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 1cab20020f94..04175e16195a 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -521,3 +521,27 @@ int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
 	close(sockfd);
 	return 0;
 }
+
+int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
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
+	ring_param->cmd = ETHTOOL_SRINGPARAM;
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
index de4d27d201cb..6457445cc6e2 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -65,6 +65,7 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 char *ping_command(int family);
 int get_socket_local_port(int sock_fd);
 int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
+int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 
 struct nstoken;
 /**
-- 
2.34.1


