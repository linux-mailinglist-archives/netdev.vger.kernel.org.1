Return-Path: <netdev+bounces-83970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E50895250
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A021C21314
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 12:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819DC6997B;
	Tue,  2 Apr 2024 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSkUjc5l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15345FB8A;
	Tue,  2 Apr 2024 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059329; cv=none; b=VrJY8mk5KOQZ2CJiZwhQrepnbVrXb7eaQCxTpQO4STY8uZmquKSu4/4eJLDr2S8te0YA+6mFMEoFcHyQ+6E3Fei16f/yd/VS5AHMZmEyBTGn4k/QR25z2+Nr25n6KQYdV6QN+R8PGKAIgNcEJNHN1PCxuJQZiiGkV1H0dm3pX9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059329; c=relaxed/simple;
	bh=68WK/LriuK2JT2Ecg1vmxUA4XNyCXmnPiefFaXCR1kw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c39gP0wPpzbb1B2mouYc0E4aGOSifAcWxfD4CpNF/cq5LPJ7MdOgvGJgn9hKfvkCxtdQV83MbZrHLKlLsDzf2JAu+GtT2Vzqduz5NePKpe4wO/f9cdqpzaSzc5BdU60qP0SrHl/hup9oe2tITKPgx8IH0Ub/GJj+OavBVpcjUpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JSkUjc5l; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712059327; x=1743595327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=68WK/LriuK2JT2Ecg1vmxUA4XNyCXmnPiefFaXCR1kw=;
  b=JSkUjc5lI+UlVoCTU77ijEpqntB3toOfx3XqDYA8WNwIEs7p8UPZs7TR
   8ybvcRJr17m9EYEaE8puszaEvuXBRJxvZXWg94h8tXFBrEbiPo8vcmRM/
   KKU8EGY3OlCzg/0zGfagZ8jMYzKTAlIqCmdHvmIcLjeo11C/R6G0N3KLX
   gBiPr8v5OO8hsZjg7BxJqv/L/Rzre8Y3L/BIsVgW9Y5HXo0J+Uw+dXwTE
   B9P4wkAjpRU29CWF71fOCchTxfj6bZKpgb0QN1vxWxkfAK/nr9ZyiNKtT
   kPjyyY3FDiw+Ljjbe0HKB2UmXsBheo8sLU6susTR6QI1jTXQo1fQcs+iG
   g==;
X-CSE-ConnectionGUID: Z/KhIOmAQXuY4rac4Eb4LQ==
X-CSE-MsgGUID: pZIBDiSdRBuWEXnn2OXPTw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7066983"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7066983"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:02:06 -0700
X-CSE-ConnectionGUID: sGxbX18rRuOgPaIFTRon2Q==
X-CSE-MsgGUID: TH3L/lbQSvOYJaPxfiTUmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="55494307"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:02:03 -0700
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
Subject: [PATCH bpf-next v3 0/7] Selftests/xsk: Test with maximum and minimum HW ring size configurations
Date: Tue,  2 Apr 2024 11:45:22 +0000
Message-Id: <20240402114529.545475-1-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please find enclosed a patch set that introduces enhancements and new test
cases to the selftests/xsk framework. These test the robustness and
reliability of AF_XDP across both minimal and maximal ring size
configurations.

While running these tests, a bug [1] was identified when the batch size is
roughly the same as the NIC ring size. This has now been addressed by
Maciej's fix.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=913eda2b08cc49d31f382579e2be34c2709eb789

Patch Summary:

1. This commit syncs the ethtool.h header file between the kernel source
   tree and the tools directory to maintain consistency.

2: Modifies the BATCH_SIZE from a constant to a variable, batch_size, to
   support dynamic modification at runtime for testing different hardware
   ring sizes.

3: Implements a function, get_hw_ring_size, to retrieve the current
   maximum interface size and store this information in the
   ethtool_ringparam structure.

4: Implements a new function, set_hw_ring_size, which allows for the
   dynamic configuration of the ring size within an interface.

5: Introduce a new function, set_ring_size(), to manage asynchronous AF_XDP
   socket closure. Make sure to retry the set_hw_ring_size function
   multiple times, up to SOCK_RECONF_CTR, if it fails due to an active
   AF_XDP socket. Immediately return an error for non-EBUSY errors.

6: Adds a new test case that puts the AF_XDP driver under stress by
   configuring minimal hardware and software ring sizes, verifying its
   functionality under constrained conditions.

7: Add a new test case that evaluates the maximum ring sizes for AF_XDP,
   ensuring its reliability under maximum ring utilization.

Testing Strategy:

Check the system in extreme scenarios, such as maximum and minimum
configurations. This helps identify and fix any bugs that may occur.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

Tushar Vyavahare (7):
  tools/include/uapi/linux/ethtool.h
  selftests/xsk: make batch size variable
  selftests/bpf: implement get_hw_ring_size function to retrieve current
    and max interface size
  selftests/bpf: implement set_hw_ring_size function to configure
    interface ring size
  selftests/xsk: introduce set_ring_size function with a retry mechanism
    for handling AF_XDP socket closures
  selftests/xsk: test AF_XDP functionality under minimal ring
    configurations
  selftests/xsk: add new test case for AF_XDP under max ring sizes

---
Changelog:
v1->v2
- copy ethtool.h to tools directory [Stanislav]
- Use ethtool_ringparam directly for get_hw_ring_size() [Stanislav]
- get_hw_ring_size() and get_hw_ring_size() moved to network_helpers.c [Stanislav]
- return -errno to match the other cases where errors are < 0. [Stanislav]
- Cleaned up set_ring_size() function by removing unused variables and
  refactoring logic for clarity. [Alexei]
- Implement a retry mechanism for the set_ring_size function to handle
  the asynchronous nature of AF_XDP socket closure. [Magnus]

v2->v3
- Remove unused linux/if.h include from flow_dissector BPF test to address
  CI pipeline failure.
---
 tools/include/uapi/linux/ethtool.h            | 2229 ++++++++++++++++-
 tools/testing/selftests/bpf/Makefile          |    2 +-
 tools/testing/selftests/bpf/network_helpers.c |   48 +
 tools/testing/selftests/bpf/network_helpers.h |    5 +
 .../selftests/bpf/prog_tests/flow_dissector.c |    1 -
 tools/testing/selftests/bpf/xdp_hw_metadata.c |   14 -
 tools/testing/selftests/bpf/xskxceiver.c      |  123 +-
 tools/testing/selftests/bpf/xskxceiver.h      |   12 +-
 8 files changed, 2376 insertions(+), 58 deletions(-)

-- 
2.34.1


