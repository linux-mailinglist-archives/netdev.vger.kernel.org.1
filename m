Return-Path: <netdev+bounces-233470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF7AC13EB4
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 10:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505C1189A68F
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 09:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82C92D877B;
	Tue, 28 Oct 2025 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGuPwRhB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24ED2C3769;
	Tue, 28 Oct 2025 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645114; cv=none; b=IOWbofWtpjLbA0bshY0W/2sycBBSV/Y2g3PoftXhXu3WF6FHZF4iEchFUNVvsk6+xIHk53l34KIksYuDk3kneSZHL/Gyk3gn6Pj3PZd7xH6eWGEkCj/hmCmbbTu8eE5v+FJn5CtCvufj8v3nlimP50fiuYdAP0gf9m6yUM6IE/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645114; c=relaxed/simple;
	bh=0aJBsF0Nh35ZXCIg0A2MFQvLvoZv/+TME8lqz/VCkLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3ploH79bMOFxOHTM3EfjSQOyUliNGw6VO+kL9BBBkcIw2dJQcvxN9IPHuQriciTmt3k6aF7yjn0x+Mlw1dfPgLmyOcrm+3JH65OAHOmnJtpfsxDRclNR42UhnufI71SszzBStvREWrvtH8oT20H1odCXHuOHyk/JinpNPXdfwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XGuPwRhB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761645113; x=1793181113;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0aJBsF0Nh35ZXCIg0A2MFQvLvoZv/+TME8lqz/VCkLE=;
  b=XGuPwRhBlwragNCqnss4es3QE0O4vN/VCR0oxq++wC+/M4FlXHvTxYSx
   beLGMwq+EbA92IdqLqrLYBNhWh+rE/5MpZD0iCAwGb3kp0hzKc01Nt7In
   9x637Iz9YX+oiekir0iv05rMoNs5GuU/pIYgOj/XALPp4sIt1jFUgOdS/
   3ie3AD1e8W1osH6v74kBwzSbqf2aE9rWAk5KKpZ7LJdJJyIzA8JkS4zeK
   4jozbwg7e72PdBrVTCc21DwdAsD/XlfFWM2MMnUjPEcUpsDjp/Bk29pz4
   B6UOmTXDcVk6XqNHl/p6GfawLJlLy2MlRXDsA1acgi997Wihkf9Q9otcL
   g==;
X-CSE-ConnectionGUID: RwK1e3XyQrmj5/EK8cxiXA==
X-CSE-MsgGUID: 3qO16LPdQPa3E20GrRd0Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67604836"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="67604836"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 02:51:51 -0700
X-CSE-ConnectionGUID: r9XAsKgXQ0+GpTj/ryCjAA==
X-CSE-MsgGUID: 8fTScKfZSceEzg8NXNf90w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185390454"
Received: from junjie-nuc14rvs.bj.intel.com ([10.238.152.23])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 02:51:48 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Junjie Cao <junjie.cao@intel.com>,
	syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com
Subject: [PATCH] ptp: guard ptp_clock_gettime() if neither gettimex64 nor
Date: Tue, 28 Oct 2025 17:51:43 +0800
Message-ID: <20251028095143.396385-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reports a NULL function pointer call on arm64 when
ptp_clock_gettime() falls back to ->gettime64() and the driver provides
neither ->gettimex64() nor ->gettime64(). This leads to a crash in the
posix clock gettime path.

Return -EOPNOTSUPP when both callbacks are missing, avoiding the crash
and matching the defensive style used in the posix clock layer.

Reported-by: syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c8c0e7ccabd456541612
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 drivers/ptp/ptp_clock.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index ef020599b771..764bd25220c1 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -110,12 +110,14 @@ static int ptp_clock_settime(struct posix_clock *pc, const struct timespec64 *tp
 static int ptp_clock_gettime(struct posix_clock *pc, struct timespec64 *tp)
 {
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
-	int err;
+	int err = -EOPNOTSUPP;
 
 	if (ptp->info->gettimex64)
-		err = ptp->info->gettimex64(ptp->info, tp, NULL);
-	else
-		err = ptp->info->gettime64(ptp->info, tp);
+		return ptp->info->gettimex64(ptp->info, tp, NULL);
+
+	if (ptp->info->gettime64)
+		return ptp->info->gettime64(ptp->info, tp);
+
 	return err;
 }
 
-- 
2.43.0


