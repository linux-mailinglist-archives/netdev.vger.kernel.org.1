Return-Path: <netdev+bounces-121280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6807E95C85D
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 10:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D670CB20CC1
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 08:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D205146D79;
	Fri, 23 Aug 2024 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wtu366Cc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A5B13D2A4;
	Fri, 23 Aug 2024 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402824; cv=none; b=dAP+6mGkX0XaISYZL8+hoowlKHe35m1epSzugE7ufO40gG4fCZizwqAVsP0uPDDwDflMQAvK9vwg5h5tbTmNbctJNElT3OAtHcjr6dfo4nerVS1cNXgQKBrbbsUKXU0pgTtLlG44epW+THbnREOp2YzVLFBAgL/L6MN364/VVCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402824; c=relaxed/simple;
	bh=1SroNowuQdpcqNjp5ILnkNVA01lc3BF4le6ywRjNpCk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q6+x8XMFQyeYaJEtfhUCFr8h2HFg8WVhV0l1eAFDGy8nnIL2CipG0dZRYQ4TR158y5eNgZ90cYSyFhOVL8Urb2G4JVc1vQQm6GM1zOPRyuo4fD1/J0iAw2Zx7SpGb/ZIs1ZYvGy54k4AWGbfDHd7ylIZD6N3y1s/b0lBOx4bROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wtu366Cc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724402822; x=1755938822;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1SroNowuQdpcqNjp5ILnkNVA01lc3BF4le6ywRjNpCk=;
  b=Wtu366CclbxjZvtb/3WM4PV7cXz3Ebool4Rb5IvLMMMA1y1fUa1xdcRK
   PA/cLT9YP4MtLrS/SD8q+C4fFKJakZe/T8MC1PsCADpaSdjA4G/tI1+Bc
   OijqjP3MDFtswQkYg92j/9XxgVDkoPUKMqTew4uXRirmIa96LX2a5RUJo
   Xf7L/+R+7RtAii1BkGNHDeac4fZ9CG/mgK1Cl7MFLW7+oiycjEmnXUjnb
   Ep4ILh55OsJQMkkMm/WzT0/xS/UiSq0LyqZ1lYBMw/CSmUb9W80NeGS2C
   4Hnd7xgnfMYmy234407scF47dIWHoY5vS8MJ2AxrddTITFeE7sw/Cvzne
   g==;
X-CSE-ConnectionGUID: xZdeGJClQ8yAn7OnaxGvcw==
X-CSE-MsgGUID: Yr9Wa+RAR3iatxur1PyL5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22382373"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="22382373"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 01:47:01 -0700
X-CSE-ConnectionGUID: jzn/5R1OSb+ql7eG39hDAw==
X-CSE-MsgGUID: pmjQ/YuRQu2Gy3yDb4Ul5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="61404079"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa006.fm.intel.com with ESMTP; 23 Aug 2024 01:46:59 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	jacob.e.keller@intel.com,
	liuhangbin@gmail.com,
	linux-kernel@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [RFC PATCH net] tools/net/ynl: fix cli.py --subscribe feature
Date: Fri, 23 Aug 2024 10:42:20 +0200
Message-Id: <20240823084220.258965-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Execution of command:
./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml /
	--subscribe "monitor" --sleep 10
fails with:
Traceback (most recent call last):
  File "/root/arek/linux-dpll/./tools/net/ynl/cli.py", line 114, in <module>
    main()
  File "/root/arek/linux-dpll/./tools/net/ynl/cli.py", line 109, in main
    ynl.check_ntf()
  File "/root/arek/linux-dpll/tools/net/ynl/lib/ynl.py", line 924, in check_ntf
    op = self.rsp_by_value[nl_msg.cmd()]
KeyError: 19

The key value of 19 returned from nl_msg.cmd() is a received message
header's nl_type, which is the id value of generic netlink family being
addressed in the OS on subscribing. It is wrong to use it for decoding
the notification. Expected notification message on dpll subsystem is
DPLL_CMD_PIN_CHANGE_NTF=13, seems at that point only available as first
byte of RAW message payload, use it to target correct op and allow further
parsing.

Fixes: "0a966d606c68" ("tools/net/ynl: Fix extack decoding for directional ops")
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 tools/net/ynl/lib/ynl.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index d42c1d605969..192d6c150303 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -921,7 +921,7 @@ class YnlFamily(SpecFamily):
                     print("Netlink done while checking for ntf!?")
                     continue
 
-                op = self.rsp_by_value[nl_msg.cmd()]
+                op = self.rsp_by_value[nl_msg.raw[0]]
                 decoded = self.nlproto.decode(self, nl_msg, op)
                 if decoded.cmd() not in self.async_msg_ids:
                     print("Unexpected msg id done while checking for ntf", decoded)
-- 
2.38.1


