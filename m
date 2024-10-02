Return-Path: <netdev+bounces-131373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844B998E58B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B221F22C7B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 21:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B971993B0;
	Wed,  2 Oct 2024 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VR1lAgEV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4CB1991A3
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905923; cv=none; b=cYL4cVeuxfKLDTyQmtlsXAfdo7GJH9xkO3E15m+K5xQaLL5AXZRMRV1gLQvSJAgl+f5nWxWqY7X3b1aJVaE2sNZpgUHBlpRExMo7W0qyIk6OLNEyq9q+xG+USrHDgLiZRnpex+z6H4aHaTbm/gT3Gj3XZedf6B5E98lxHDD3fFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905923; c=relaxed/simple;
	bh=FQ6bAxu/fVENsuX1Pcz231bPe6QUGLfPSw0FscBgfPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DH0ACXfj/w1avdasjABXqFPJNvOimMrw1ycaEvcXvyXDPCVkuVYvmj64z01bvCyd34Fsph1MPZFYdeu3XZ9Sv5Yvnh887IJhDoHpvV+mxNE7GCDhMaJ2WBkjJ4XAl8i8Rw4WSURUB6/pNBR3O1eGlP+hLp0l9v2zn43yCboENgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VR1lAgEV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727905922; x=1759441922;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=FQ6bAxu/fVENsuX1Pcz231bPe6QUGLfPSw0FscBgfPI=;
  b=VR1lAgEVuJe2VBVkDCezYrg2aKCQ4mu4aXbBPcxBofzhH+g4IAE7KLdr
   vaL6u2ovSlsYNdRwLbfVlqFS5nIbedj8nqn1rkRs3kQ0ekLSS58BSvzf7
   TE1fIdEHF//J2/updwmZuzNXNIUr77oYV784OuZYXFP+YuYEfd4+3+0gu
   JqrmHGaMTafiSkFL0pJxDxxYfCMEUce0L2yKSUfhbOH64LdSWVYf75tuY
   xuIHo736vGpSzaXI/pVtNW7oGw3yJIEauHiYnZiEK20+zy/AcJ9Hp9arR
   ijMtj9I3wqg/Ulbqfzf0Ym8iCL7N7iyvHjK4V2sjGRmQb2K93jqdKwVf9
   A==;
X-CSE-ConnectionGUID: ursbqSjzTWKOlBU/IvwCuQ==
X-CSE-MsgGUID: 9+3x4qVxTE+Qyto+0lkk+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27262025"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="27262025"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:52:00 -0700
X-CSE-ConnectionGUID: xOic2BHnTUWo4Dgl8G2k5A==
X-CSE-MsgGUID: 3m0Xy4xyS4qAstV22p+Alg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="78673888"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:51:59 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 02 Oct 2024 14:51:52 -0700
Subject: [PATCH net-next v2 03/10] lib: packing: remove kernel-doc from
 header file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-3-8373e551eae3@intel.com>
References: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
In-Reply-To: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
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


