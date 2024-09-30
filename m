Return-Path: <netdev+bounces-130666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0605A98B0BB
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 01:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A588B1F22706
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 23:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7D4199E82;
	Mon, 30 Sep 2024 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TiqnhY8Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1E118C909
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738397; cv=none; b=DB2n5D8Di9r39M+8d3obIY7Eh2ZnQLa6murmjGiaFvf6yvuR8XTa8lkQ7nhEYM0u3a9Z3+AAafN82Q66aR5+i5TeBIYEvetkj41n+AOZocjU4BEh85f0lsFmhUMaJ7JO0tPmpHw4v3cRS69ctnHUrie+wBjuMtTIB2Rf8YmstDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738397; c=relaxed/simple;
	bh=FQ6bAxu/fVENsuX1Pcz231bPe6QUGLfPSw0FscBgfPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ul8IJFP86xq5+ioBSzv+p0zbtvabqgR8C7dnQ0dGDGxB8pE+uY8N2+qLTlTyZ51jiW0rG5Q0Mkpm2e/JqIZezU4kPCAh8yQhpUbg08Y0Kt5MGCRx5F9QvTCBBF9myN6kaeVA0XT7+uICVu8w2SxDfgWMCTH+BHFTDvl8F23ILL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TiqnhY8Y; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727738396; x=1759274396;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=FQ6bAxu/fVENsuX1Pcz231bPe6QUGLfPSw0FscBgfPI=;
  b=TiqnhY8Y3r4wtl7wzWZUdFVI9yku5GvHRMMcV0IH6tG944nPDCytQFlh
   SnZsi8DsSSNt//RgynZk1Qz0nOlYgaIoxdQNA0XUZ/AYTkXrBIYRxSoVx
   /Y715wxuOc5UYYy2VsLypj8gnuG3aoxMmzR+HxbiUu9Ev1f3LKdY+eaPy
   FUWJriPiPoESdYkJiA0DYkqVVfDZXCJNbfd+eIdpsQFIMzZGo+tGTSFlX
   rSjMnMF1JQsdBomv/jz0YK4Wsv4J6/APx7ytfu5m0eua5Yyvy3NXDgtRG
   B/IlHQZLxvRXo1MJSQQjWrB/MWQlWiGUJqWKqiOYcQy5tFWSaDhYCbix/
   w==;
X-CSE-ConnectionGUID: M7OhSG1tTRKHzcDxxELJWg==
X-CSE-MsgGUID: Dazd/XGUQCq7h/Ulfi5X1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26660325"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26660325"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:19:51 -0700
X-CSE-ConnectionGUID: Xw6f6Pa/Tpm7Jird6harwQ==
X-CSE-MsgGUID: Q/RL3NiAQfOHRqHbA3bEiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73356439"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:19:50 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 30 Sep 2024 16:19:36 -0700
Subject: [PATCH net-next 03/10] lib: packing: remove kernel-doc from header
 file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-3-94b1f04aca85@intel.com>
References: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-0-94b1f04aca85@intel.com>
In-Reply-To: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-0-94b1f04aca85@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.1

From: Vladimir Oltean <vladimir.oltean@nxp.com>

It is not necessary to have the kernel-doc duplicated both in the
header and in the implementation. It is better to have it near the
implementation of the function, since in C, a function can have N
declarations, but only one definition.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 include/linux/packing.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/include/linux/packing.h b/include/linux/packing.h
index 8d6571feb95d..69baefebcd02 100644
--- a/include/linux/packing.h
+++ b/include/linux/packing.h
@@ -17,32 +17,6 @@ enum packing_op {
 	UNPACK,
 };
 
-/**
- * packing - Convert numbers (currently u64) between a packed and an unpacked
- *	     format. Unpacked means laid out in memory in the CPU's native
- *	     understanding of integers, while packed means anything else that
- *	     requires translation.
- *
- * @pbuf: Pointer to a buffer holding the packed value.
- * @uval: Pointer to an u64 holding the unpacked value.
- * @startbit: The index (in logical notation, compensated for quirks) where
- *	      the packed value starts within pbuf. Must be larger than, or
- *	      equal to, endbit.
- * @endbit: The index (in logical notation, compensated for quirks) where
- *	    the packed value ends within pbuf. Must be smaller than, or equal
- *	    to, startbit.
- * @op: If PACK, then uval will be treated as const pointer and copied (packed)
- *	into pbuf, between startbit and endbit.
- *	If UNPACK, then pbuf will be treated as const pointer and the logical
- *	value between startbit and endbit will be copied (unpacked) to uval.
- * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
- *	    QUIRK_MSB_ON_THE_RIGHT.
- *
- * Return: 0 on success, EINVAL or ERANGE if called incorrectly. Assuming
- *	   correct usage, return code may be discarded.
- *	   If op is PACK, pbuf is modified.
- *	   If op is UNPACK, uval is modified.
- */
 int packing(void *pbuf, u64 *uval, int startbit, int endbit, size_t pbuflen,
 	    enum packing_op op, u8 quirks);
 

-- 
2.46.2.828.g9e56e24342b6


