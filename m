Return-Path: <netdev+bounces-86493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B9489EFAF
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 12:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA56A1C229EA
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 10:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6C3158D62;
	Wed, 10 Apr 2024 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNy4En03"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E68155737
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712744219; cv=none; b=bmWSDPfvDX5+Z6YlGjwA4UfztVPy1z7K0sHxjhunoyq8RPimx9jmakN4M//mpSy6DxRKDOt/0AAHVX0xV6Yz4JmgTQjHtmiyGpE2sbVgLr36YbvwU994Jm1zdWkKRacJHwaXvZxWz6XIu/LodTYG8I6j2Bh5C/zE09uRr7tkmHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712744219; c=relaxed/simple;
	bh=APFMnIFuItwRd16mAPXH4UZOOrLZxnfCUvZBgH/GZno=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gDJS0KzFYZzYJaClzrlt3QHyvHMtvymQxQJQvJa98xRzuFKh/Yz27LzatVo0NH/VFYOOR9h6gCZppKi7zh2KjGArCy9mBo0YPPpIkW08S6z7UQrqYAkXxylQ7mklf3ysgLxucFgVHkEbLOxmSc8K1Mk2gCRTxYxjNkpMvOwC/Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jNy4En03; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712744217; x=1744280217;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=APFMnIFuItwRd16mAPXH4UZOOrLZxnfCUvZBgH/GZno=;
  b=jNy4En03xQcV3iEBv/sAWGq8guCruVtqcLBplUzcqAXh+rjvqiUYNZNm
   Mh4zBU2lSIkO+tAc05KuFQFRiU7nSBHxgkoyoCrJ2Y+fe2JaYt9s1YlDB
   QpwQd4Vie27CyEA3C5vHFtrQZb1YIl9mVzw1SBxBYeekU7VKNdYnfyXom
   33FAWLakf/Zl/Rp+R43AQ99e5nlIX0x5j5kMrwM3qpozzbc/XNK/a51wx
   6oCiEbOeBKPqbXM1RVkUABLtG0yj/8S8m+oirwLhaMMQcvquTB4eVcRNp
   KeMkXhns0dv3AMKqBIrUQwglWt9CeDYBHrA5+vg68rper4HDR/zlT24yE
   Q==;
X-CSE-ConnectionGUID: W4l/RgdJQcWeB5GwYTRT6g==
X-CSE-MsgGUID: 9297R3/PR32qcecVpbmWXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19525384"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19525384"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 03:16:56 -0700
X-CSE-ConnectionGUID: +xVvnjjzRG+xaBd1Wk6KNg==
X-CSE-MsgGUID: afgF+IoeRJaFE5FLUeTL+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="51737638"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 10 Apr 2024 03:16:54 -0700
Received: from rozewie.igk.intel.com (unknown [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9FF3C28790;
	Wed, 10 Apr 2024 11:16:52 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	stephen@networkplumber.org
Subject: [PATCH iproute2-next 0/2] PFCP support
Date: Wed, 10 Apr 2024 12:14:38 +0200
Message-Id: <20240410101440.9885-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New PFCP module was accepted in the kernel together with cls_flower
changes which allow to filter the packets using PFCP specific fields [1].
Packet Forwarding Control Protocol is a 3GPP Protocol defined in
TS 29.244 [2].

Extended ip link with the support for the new PFCP device.
Add pfcp_opts support in tc-flower.

[1] https://lore.kernel.org/netdev/171196563119.11638.12210788830829801735.git-patchwork-notify@kernel.org/
[2] https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3111

Michal Swiatkowski (1):
  f_flower: implement pfcp opts

Wojciech Drewek (1):
  ip: PFCP device support

 include/libnetlink.h         |   6 ++
 include/uapi/linux/pkt_cls.h |  14 ++++
 ip/iplink.c                  |   2 +-
 man/man8/ip-link.8.in        |  10 +++
 man/man8/tc-flower.8         |  11 +++
 tc/f_flower.c                | 126 +++++++++++++++++++++++++++++++++++
 6 files changed, 168 insertions(+), 1 deletion(-)

-- 
2.40.1


