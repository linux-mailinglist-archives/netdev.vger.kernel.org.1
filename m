Return-Path: <netdev+bounces-223709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995D9B5A1FD
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 22:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671F7327A2E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 20:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D212E424F;
	Tue, 16 Sep 2025 20:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BfoKt/L/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9463A284B29;
	Tue, 16 Sep 2025 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053408; cv=none; b=VOKoZ0OwYtQszS78NEoaWCoTGClBJX47QCb6T7i/1g75IHscB8dL6+gYvA77DFDtRJAHOU0VGTi5+VgS8K8sVXmSnQDVDCUoiTRehhfPxA5MsE283vKHcVqCNPrRP/3Cghyrd3X+N1PiY9TrFMPAQ7Uvpx/3yXPDB7rzaqbPEQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053408; c=relaxed/simple;
	bh=sG1UguvSYSALefbAtByxqgdIGq4a3+WwUJhHmXPgZfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kP3cYPBSNOZ3VK9T5J2yGfHE2XE+xxudUZiDyOLcvMEwjEFPqVMCW7C0SNrjJIVI+cgmE5lu6QuHlE7jDAD7nL9Y5mOVkDeF/6CJ9SfB6406UtUmwyylLlUqHAqqmX6+fdgDYw1IreqnRJz6ISeMo6YWbuF5DIhNja1s7u/ki7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfoKt/L/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758053406; x=1789589406;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=sG1UguvSYSALefbAtByxqgdIGq4a3+WwUJhHmXPgZfI=;
  b=BfoKt/L/J11MEDsQMKH2E2whppU0pmglb6YZ50qiSuPnCXVsgNocVhtF
   HXY+m7Lgb+Y4WFFg3oGtS5eeflzCSsnUhK8V8V/YzoQK7/VcS4Q+qJyG4
   zCDIyMR2djqsizmakBReqTIbNMeqoupDHPlrXrCkDNio6QJR5+qT5+ycB
   j5H8xeOmpMRzRBoIGnL47tbAUmTkdmP8Syj1u6e05DSJJpTJCUpVgl5UF
   HgZR6NScyQfdGd+udh+EP34h7FIJU6wb6WjqrRZXRB95nvx71Vamuleua
   DnGyITKPHbp7a+ubPaD4QxogPof9g1zTva91cfvNNYGGEubfd4IaTdx12
   g==;
X-CSE-ConnectionGUID: Kjxxa4kZSsqL54rd8dDQnA==
X-CSE-MsgGUID: Aq2bgQy2Rx6sVtvZWShVzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="85788647"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="85788647"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 13:10:05 -0700
X-CSE-ConnectionGUID: vn90qRE9QhSC/MRX6GTXUA==
X-CSE-MsgGUID: S98OtFRQQvm6Vf0Ma9eNNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174606731"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 13:10:06 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 16 Sep 2025 13:09:20 -0700
Subject: [PATCH iwl-net] libie: fix string names for AQ error codes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-jk-fix-missing-underscore-v1-1-a64be25ec2ac@intel.com>
X-B4-Tracking: v=1; b=H4sIAPDDyWgC/x2MzQ6CQAwGX4X0bBNYFMVXMR7M8i3Un0JaFRLCu
 7vxOMnMrOQwgdO5WMnwFZdRM1S7guJw0x4sXWYKZTiUbdXw/cFJFn6Ju2jPH+1gHkcDI6QUj6j
 bfX2i3E+GbP7fF5L5yYo3XbftB79OuVt0AAAA
X-Change-ID: 20250916-jk-fix-missing-underscore-e2ffc7e39438
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-cbe0e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1709;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=sG1UguvSYSALefbAtByxqgdIGq4a3+WwUJhHmXPgZfI=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoyTRyQ/61pyhXNnxYsLe2xZ8/H+b/28r5bhKVP7CnsO2
 DmGqW3pKGVhEONikBVTZFFwCFl53XhCmNYbZzmYOaxMIEMYuDgFYCJyBgz/lHOuvAhMzrx5TLPe
 ULB0u8MWyWYNbkNPwRenhLd2a0jFMfzTfHx1y5XfhbuWBHc3qUZZvzv59cymewtSLubqqC9yNWl
 mAgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The LIBIE_AQ_STR macro() introduced by commit 5feaa7a07b85 ("libie: add
adminq helper for converting err to str") is used in order to generate
strings for printing human readable error codes. Its definition is missing
the separating underscore ('_') character which makes the resulting strings
difficult to read. Additionally, the string won't match the source code,
preventing search tools from working properly.

Add the missing underscore character, fixing the error string names.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Fixes: 5feaa7a07b85 ("libie: add adminq helper for converting err to str")
---
I found this recently while reviewing the libie code. I believe this
warrants a net fix because it is both simple, and because users may attempt
to pass printed error codes into search tools like grep, and will be unable
to locate the error values without manually adding the missing '_'.
---
 drivers/net/ethernet/intel/libie/adminq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/libie/adminq.c b/drivers/net/ethernet/intel/libie/adminq.c
index 55356548e3f0..7b4ff479e7e5 100644
--- a/drivers/net/ethernet/intel/libie/adminq.c
+++ b/drivers/net/ethernet/intel/libie/adminq.c
@@ -6,7 +6,7 @@
 
 static const char * const libie_aq_str_arr[] = {
 #define LIBIE_AQ_STR(x)					\
-	[LIBIE_AQ_RC_##x]	= "LIBIE_AQ_RC" #x
+	[LIBIE_AQ_RC_##x]	= "LIBIE_AQ_RC_" #x
 	LIBIE_AQ_STR(OK),
 	LIBIE_AQ_STR(EPERM),
 	LIBIE_AQ_STR(ENOENT),

---
base-commit: 93ab4881a4e2b9657bdce4b8940073bfb4ed5eab
change-id: 20250916-jk-fix-missing-underscore-e2ffc7e39438

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


