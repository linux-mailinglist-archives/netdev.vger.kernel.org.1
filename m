Return-Path: <netdev+bounces-130664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1C498B0B9
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 01:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25301F232FC
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 23:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7390D1946A9;
	Mon, 30 Sep 2024 23:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5OhkNGr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D049F5339F
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 23:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738396; cv=none; b=oTYcpkPxI29FopZCQuZhqI1BiYMAxhr+5wS0cQYGcdQ6Qq7Vxwz+sxHhwvLQW9npwiGOjySEWQ+liAJ034F4gZixssIyu7OQkuIWb8ret3zQAlO1tsENQo3MlTF1BwGX94Qza4ggC46ftKZjfJvdCPObPaswtSxU1Gk9GcSrEZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738396; c=relaxed/simple;
	bh=A6+48JkxnF29+aMdP8Osm90p1/2lcRAwp/aNj0ptMos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lPhf5V6QIl4kCAE8pdRpv04sSy0g8ja5ZKnoHMqlsaXJV94/vMZ+pWRbSMR8HboYe2Nxi/z3TjkNTN8Z2TRZIOIOM2z8vr1qkeEfPrRwfmjXmrs6/MhgVPJliooQ/O1ouTubnaQI71Oq2WsCCnAvG3M74+MeVUZvJxyVnaFhOR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5OhkNGr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727738395; x=1759274395;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=A6+48JkxnF29+aMdP8Osm90p1/2lcRAwp/aNj0ptMos=;
  b=U5OhkNGrefrkJO0Lpx0O7/H5H2ETEHo9YDz7fFOV+03jxFnH0CRykZEJ
   AOKmPikqLpQp2zNSQ8m1b/jKBgFIQRuIRACesASUTnd+PkTXlJbkc9E3/
   fPe3aJmbGOpg1osGBEG1h2aXwWYguaJXdMFWXK+Hz83e6EKAh3NqymJua
   1mQotdv4PcMInu0FHl4vXn3so+2ISzIk/hRPwGs8gIWdpq3/rGT9kBD3w
   fNxl56NlzGCK2UbKrh3vzzMYCSNKMZhQNNag7AkhaJGKKO1ejB1Mt6FxX
   9Mo+S5G+E0iN9tR82Cm0Cd6gMxWCwJlGjHRiNKYYIf/oKntYecB47lPPh
   w==;
X-CSE-ConnectionGUID: A+sp+y8FQwOjTvE376+KWw==
X-CSE-MsgGUID: PVIbYuhwSLmIxVJxxDv0hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26660316"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26660316"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:19:51 -0700
X-CSE-ConnectionGUID: 8SEwjHw7R7OwjKDGD/nvxQ==
X-CSE-MsgGUID: MVPGq5w7QqqaABOcNARQ6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73356433"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:19:50 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 30 Sep 2024 16:19:34 -0700
Subject: [PATCH net-next 01/10] lib: packing: refuse operating on bit
 indices which exceed size of buffer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-1-94b1f04aca85@intel.com>
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

While reworking the implementation, it became apparent that this check
does not exist.

There is no functional issue yet, because at call sites, "startbit" and
"endbit" are always hardcoded to correct values, and never come from the
user.

Even with the upcoming support of arbitrary buffer lengths, the
"startbit >= 8 * pbuflen" check will remain correct. This is because
we intend to always interpret the packed buffer in a way that avoids
discontinuities in the available bit indices.

Fixes: 554aae35007e ("lib: Add support for generic packing operations")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 lib/packing.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/packing.c b/lib/packing.c
index 3f656167c17e..439125286d2b 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -86,8 +86,10 @@ int packing(void *pbuf, u64 *uval, int startbit, int endbit, size_t pbuflen,
 	 */
 	int plogical_first_u8, plogical_last_u8, box;
 
-	/* startbit is expected to be larger than endbit */
-	if (startbit < endbit)
+	/* startbit is expected to be larger than endbit, and both are
+	 * expected to be within the logically addressable range of the buffer.
+	 */
+	if (unlikely(startbit < endbit || startbit >= 8 * pbuflen || endbit < 0))
 		/* Invalid function call */
 		return -EINVAL;
 

-- 
2.46.2.828.g9e56e24342b6


