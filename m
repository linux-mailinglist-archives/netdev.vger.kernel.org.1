Return-Path: <netdev+bounces-178612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D4CA77CC1
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 15:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5D43B04A2
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A524204695;
	Tue,  1 Apr 2025 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P6B7Jt3V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7BF2046A8;
	Tue,  1 Apr 2025 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515438; cv=none; b=XF9BWj5/LmJPNeiLAYqEpPTOz6aaB/lSsvPd9f3I5Q0HPtiWi8MrPUFnsK4Ra8RSAAmsQ1V9avL/UQ0x9nySQ1HxUf2U3T2cjAX02DfC5O+mKeuteH6+U70ebnPugAPhttc/ISA90xPQ/PqsL7ggoamOCIHAnsOTJBjNWPQJ70Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515438; c=relaxed/simple;
	bh=39dw4BZHdCa1g3Uare5eNbAKiAqjVx6gWMtRg8KXg6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MlltuCj7VcAApK8gLSbYiMa6ah0g2JSlRg+AsSPR33gAxU6No5pAGS+PaXsTAF4oVlsnkCoC+eK2PKcnejSrM91RqeayBwH6jX66lYCJTDmqqUJQnoNhqNqM09tmM8UfLvK9ebNSGgIhhu4NMKh+mF2MUYugF0JnoZGdel1LwqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P6B7Jt3V; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743515437; x=1775051437;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=39dw4BZHdCa1g3Uare5eNbAKiAqjVx6gWMtRg8KXg6g=;
  b=P6B7Jt3VvS9KPznolE1NCkpd9yN5tB3VkvvAsrHsDPgTQFT2sWlT9/fm
   KQt1Uf75TRjA+k1rBVNxm6OfJKwZIGwIbun7BzU1Y3pou4w+SZaB2tQR5
   ixSTnd77RQpxLrKwKAZc4qqwfwnh1kso7WjslaxzQ7IcNRvQnCuBZyhvu
   C8mPZ92/j2kbRdZH0h/tkCuecMNuXpF+a+aSB0DuNTVAHfHlindOpZu0y
   ft8P4D/4oqn5qPX1BUfar98ECjaRnt1K/4xCZjRzM2tlSUFw/zlnZk//g
   v0WD1VL6rL5vdh0GchFZhFfwdhZwJEDPe5qHRUVvHpXpip1NgS0dr/fAb
   A==;
X-CSE-ConnectionGUID: BMRO9NTqT3e/nZ8exRXSCg==
X-CSE-MsgGUID: 6awfa00RRaOwaNXx41G79A==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="43987248"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="43987248"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 06:50:36 -0700
X-CSE-ConnectionGUID: WfeZqm49QkmEdayZ399bsw==
X-CSE-MsgGUID: c2bFjzdNQQ2mnWKppKHtTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="157328790"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 01 Apr 2025 06:50:33 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1391432EDE;
	Tue,  1 Apr 2025 14:50:32 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	torvalds@linux-foundation.org,
	peterz@infradead.org
Cc: andriy.shevchenko@linux.intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [RFC] slab: introduce auto_kfree macro
Date: Tue,  1 Apr 2025 15:44:08 +0200
Message-Id: <20250401134408.37312-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add auto_kfree macro that acts as a higher level wrapper for manual
__free(kfree) invocation, and sets the pointer to NULL - to have both
well defined behavior also for the case code would lack other assignement.

Consider the following code:
int my_foo(int arg)
{
	struct my_dev_foo *foo __free(kfree); /* no assignement */

	foo = kzalloc(sizeof(*foo), GFP_KERNEL);
	/* ... */
}

So far it is fine and even optimal in terms of not assigning when
not needed. But it is typical to don't touch (and sadly to don't
think about) code that is not related to the change, so let's consider
an extension to the above, namely an "early return" style to check
arg prior to allocation:
int my_foo(int arg)
{
        struct my_dev_foo *foo __free(kfree); /* no assignement */
+
+	if (!arg)
+		return -EINVAL;
        foo = kzalloc(sizeof(*foo), GFP_KERNEL);
        /* ... */
}
Now we have uninitialized foo passed to kfree, what likely will crash.
One could argue that `= NULL` should be added to this patch, but it is
easy to forgot, especially when the foo declaration is outside of the
default git context.

With new auto_kfree, we simply will start with
	struct my_dev_foo *foo auto_kfree;
and be safe against future extensions.

I believe this will open up way for broader adoption of Scope Based
Resource Management, say in networking.
I also believe that my proposed name is special enough that it will
be easy to know/spot that the assignement is hidden.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 include/linux/slab.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 98e07e9e9e58..b943be0ce626 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -471,6 +471,7 @@ void kfree_sensitive(const void *objp);
 size_t __ksize(const void *objp);
 
 DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))
+#define auto_kfree __free(kfree) = NULL
 DEFINE_FREE(kfree_sensitive, void *, if (_T) kfree_sensitive(_T))
 
 /**
-- 
2.39.3


