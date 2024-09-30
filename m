Return-Path: <netdev+bounces-130388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D6F98A57D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F951C21A92
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42451917C9;
	Mon, 30 Sep 2024 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b8VOUVac"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D56191484;
	Mon, 30 Sep 2024 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703557; cv=none; b=OeMfMPI7Q6VShOMF7Aphd2HB6KTr38Grm62BC6z+oCU9XYVuB1NHq9GAx938qDSyaXmtl6/sy256R1stTNUCZprRFDveFIJsAhCrGg/+UwZ7xQcSKYgiij5RBm3zIPJnwPVq2QQVAyRph6znajK8cgydBLq9WAmUrK6YILZOdnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703557; c=relaxed/simple;
	bh=n/mLZYq5jt13yyR5gu6Fi389pXb+dS+E37pYL96U2UA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ipmeU52QJtJ89vrVJdV7OnOTZ6gDTTQURQx5imiTAIfYPM+8eqXaO3FZM2bePAugzGfvZKkDCF8II2AdX6/jVmfmAuQnQI2H0Tf90Mh1KDO7IEqI4YJ9xFI54LGza66dSB4T/xnPrVcNxXa/jbLtRUUeimRR2KFRU96iLcmW5Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b8VOUVac; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727703556; x=1759239556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n/mLZYq5jt13yyR5gu6Fi389pXb+dS+E37pYL96U2UA=;
  b=b8VOUVacc/TTVSQI8rUKhQsTEewIke/aaNRzXHduami+lqP9IBx7hXYQ
   8ZDjmZmUhbv8+BhKjzSxWXKSIelmEAEoebm5grEH9XjHa8a06Zsk9OcRV
   iUC1bYSJUdXUgFUmU3E4dxHPli8QzOb8tyM25gkk8gjsWKKaTqQx5+Usk
   icHQ96ExGorDsm9lDjr5ycSFWQcQ2O1mHUx17CO5KXd3kJ/qYxQcraAfy
   8y3sohVRpeEQTwOoQtCDC7ntf+lyHz+Zpzkve+pNMeyVrbEi7s2T4VBaY
   753TztSnysgeFuysF+AYJa2L/M38koZv4rmqjB3D992N7rILcX+Zc+saO
   g==;
X-CSE-ConnectionGUID: DaR6Adu/SMafJyugk7Ufbw==
X-CSE-MsgGUID: B+AQ1VH1SLSEkbsEO2+I9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26600983"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26600983"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:39:16 -0700
X-CSE-ConnectionGUID: c8+ntKJJTruGv1qR3GiFsw==
X-CSE-MsgGUID: R5U3TOHXSQiszy+ipYX0lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="104109623"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 30 Sep 2024 06:39:12 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9AF9328195;
	Mon, 30 Sep 2024 14:39:10 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 2/7] devlink: add devlink_fmsg_put() macro
Date: Mon, 30 Sep 2024 15:37:19 +0200
Message-Id: <20240930133724.610512-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240930133724.610512-1-przemyslaw.kitszel@intel.com>
References: <20240930133724.610512-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devlink_fmsg_put() that dispatches based on the type
of the value to put, example: bool -> devlink_fmsg_bool_pair_put().

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 include/net/devlink.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index db5eff6cb60f..85739bb731c1 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1261,6 +1261,17 @@ enum devlink_trap_group_generic_id {
 		.min_burst = _min_burst,				      \
 	}
 
+#define devlink_fmsg_put(fmsg, name, value) (			\
+	_Generic((value),					\
+		bool :		devlink_fmsg_bool_pair_put,	\
+		u8 :		devlink_fmsg_u8_pair_put,	\
+		u16 :		devlink_fmsg_u32_pair_put,	\
+		u32 :		devlink_fmsg_u32_pair_put,	\
+		u64 :		devlink_fmsg_u64_pair_put,	\
+		char * :	devlink_fmsg_string_pair_put,	\
+		const char * :	devlink_fmsg_string_pair_put)	\
+	(fmsg, name, (value)))
+
 enum {
 	/* device supports reload operations */
 	DEVLINK_F_RELOAD = 1UL << 0,
-- 
2.39.3


