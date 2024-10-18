Return-Path: <netdev+bounces-136977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF299A3D5B
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC251F21C1D
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB6F4207A;
	Fri, 18 Oct 2024 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MutKdnMz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8697D2F46;
	Fri, 18 Oct 2024 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729251514; cv=none; b=tpQJjFAvNf8qDPnM/NU3IXHlkfVJDT6i0/8kuqIuLVzlZz+/tTocbpCGH26QzQfnRnNRjWkhkUr7NiOoEQMtkr0v7rYqHCdTcegDbaNKtOOMtycESy6kbXHa2GLkiE4caZkqZbZ++QmWntNNOLj9P3xxYgwypmgWXqQ3yXQLJ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729251514; c=relaxed/simple;
	bh=J0za06IGZ7hNiodBAAwSWJmzkNMuFK0t/t8z3Gq857Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SjML6czy0Ura0oeTs6sS1KEpo8B+AXSHfGpXLei/CMuXuCU9BzphmHmtlXfVmroQ9UIW8KjJGVpvmaLLYFQgZ2FmZPvmDD6AzGOWm+9ygfTEM2W+265Q/2peV+TGzMXX7WM06Pg9eDpNU0DGIlUB2G7hGG27QWnikfzG3YEx/gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MutKdnMz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729251512; x=1760787512;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J0za06IGZ7hNiodBAAwSWJmzkNMuFK0t/t8z3Gq857Y=;
  b=MutKdnMzzqD3PiD4bVPdbFv5mIUIFqtiV1Reac3UozkAgK1kzVDNPd8s
   sWaFo3Brxnl3EFxJogXSWDrytUKoaRVcNm6IImTxFJfuaxOBMhHHvCDxW
   iaO12dBb3bqe6QkVXpZmpKghBkyqBSsbCILAipg8r2MGfkD0K1d5qHPZn
   kS5ifvqRYjcqMt/T0hIeF/WRm4qAXC4LySZRjT6ABUxUWjQ/SObjzI+YC
   NHZJl6gGkC6jkx5RpTjmugYKZyQgXmAvN37K/zMe3xFqsNmuk6vpTfkMm
   XgYvdRr6f3V5usRzcjaFVK9+cgd100LwVPjjWyE3mpX1hiyehjZCQgA7c
   g==;
X-CSE-ConnectionGUID: KtX6u2wGTb2arHjqRlNmPA==
X-CSE-MsgGUID: xJw7oKTiTxOVPIXHMEiknA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28988142"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="28988142"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 04:38:32 -0700
X-CSE-ConnectionGUID: +ds8bnIlQjaTK0A9ZM9BPA==
X-CSE-MsgGUID: /PQAPOWQTtKO+zepwijFkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="79270967"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa007.jf.intel.com with ESMTP; 18 Oct 2024 04:38:29 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.186])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4A9F5284ED;
	Fri, 18 Oct 2024 12:38:26 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Cc: amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Kees Cook <keescook@chromium.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v4] cleanup: adjust scoped_guard() macros to avoid potential warning
Date: Fri, 18 Oct 2024 13:38:14 +0200
Message-ID: <20241018113823.171256-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change scoped_guard() and scoped_cond_guard() macros to make reasoning
about them easier for static analysis tools (smatch, compiler
diagnostics), especially to enable them to tell if the given usage of
scoped_guard() is with a conditional lock class (interruptible-locks,
try-locks) or not (like simple mutex_lock()).

Add compile-time error if scoped_cond_guard() is used for non-conditional
lock class.

Beyond easier tooling and a little shrink reported by bloat-o-meter
this patch enables developer to write code like:

int foo(struct my_drv *adapter)
{
	scoped_guard(spinlock, &adapter->some_spinlock)
		return adapter->spinlock_protected_var;
}

Current scoped_guard() implementation does not support that,
due to compiler complaining:
error: control reaches end of non-void function [-Werror=return-type]

Technical stuff about the change:
scoped_guard() macro uses common idiom of using "for" statement to declare
a scoped variable. Unfortunately, current logic is too hard for compiler
diagnostics to be sure that there is exactly one loop step; fix that.

To make any loop so trivial that there is no above warning, it must not
depend on any non-const variable to tell if there are more steps. There is
no obvious solution for that in C, but one could use the compound
statement expression with "goto" jumping past the "loop", effectively
leaving only the subscope part of the loop semantics.

More impl details:
one more level of macro indirection is now needed to avoid duplicating
label names;
I didn't spot any other place that is using the
"for (...; goto label) if (0) label: break;" idiom, so it's not packed for
reuse beyond scoped_guard() family, what makes actual macros code cleaner.

There was also a need to introduce const true/false variable per lock
class, it is used to aid compiler diagnostics reasoning about "exactly
1 step" loops (note that converting that to function would undo the whole
benefit).

Big thanks to Andy Shevchenko for help on this patch, both internal and
public, ranging from whitespace/formatting, through commit message
clarifications, general improvements, ending with presenting alternative
approaches - all despite not even liking the idea.

Big thanks to Dmitry Torokhov for the idea of compile-time check for
scoped_cond_guard() (to use it only with conditional locsk), and general
improvements for the patch.

Big thanks to David Lechner for idea to cover also scoped_cond_guard().

CC: David Lechner <dlechner@baylibre.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
PATCH v4:
scoped_guard() - go back to have the guard ptr init in the for loop header,
 to fix compilation warnings of v3 with CONFIG_PROFILE_ALL_BRANCHES=y
 (the "hard to deduce" part is was analysed by the compiler once more,
 thanks to #define for if()).
now both macros don't have common helper for the bulk of their body
 (as it is the case prior to this series too).

PATCH v3:
cover also scoped_cond_guard() to be able to return from them (David Lechner);
capitalize comment (Andy)
https://lore.kernel.org/netdev/20241011121535.28049-1-przemyslaw.kitszel@intel.com/

PATCH v2:
drop Andy's NACK,
 (the reasons for NACK were in RFC v1; Peter backed up my idea for this
 patch in PATCH v1 discussion, and Andy withdrawn the NACK);
whitespace/formatting/style issues - Andy;
additional code comments - Dmitry.
https://lore.kernel.org/netdev/20241009114446.14873-1-przemyslaw.kitszel@intel.com

PATCH v1:
changes thanks to Dmitry Torokhov:
 better writeup in commit msg;
 "__" prefix added to internal macros;
 reorder "if (0)-else" and "for" to avoid goto jumping back;
 compile-time check for scoped_cond_guard()
https://lore.kernel.org/netdev/20241003113906.750116-1-przemyslaw.kitszel@intel.com

RFC v2:
https://lore.kernel.org/netdev/20241001145718.8962-1-przemyslaw.kitszel@intel.com
 remove ", 1" condition, as scoped_guard() could be used also for
 conditional locks (try-lock, irq-lock, etc) - this was pointed out by
 Dmitry Torokhov and Dan Carpenter;
 reorder macros to have them defined prior to use - Markus Elfring.

RFC v1:
https://lore.kernel.org/netdev/20240926134347.19371-1-przemyslaw.kitszel@intel.com
---
 include/linux/cleanup.h | 53 +++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 038b2d523bf8..c81fe02df2f5 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -285,14 +285,21 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *      similar to scoped_guard(), except it does fail when the lock
  *      acquire fails.
  *
+ *	Only for conditional locks.
+ *
  */
 
+#define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
+static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
+
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
+	__DEFINE_CLASS_IS_CONDITIONAL(_name, false); \
 	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
 	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
 	{ return *_T; }
 
 #define DEFINE_GUARD_COND(_name, _ext, _condlock) \
+	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true); \
 	EXTEND_CLASS(_name, _ext, \
 		     ({ void *_t = _T; if (_T && !(_condlock)) _t = NULL; _t; }), \
 		     class_##_name##_t _T) \
@@ -303,17 +310,40 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 	CLASS(_name, __UNIQUE_ID(guard))
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
+#define __is_cond_ptr(_name) class_##_name##_is_conditional
 
-#define scoped_guard(_name, args...)					\
-	for (CLASS(_name, scope)(args),					\
-	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
-
-#define scoped_cond_guard(_name, _fail, args...) \
-	for (CLASS(_name, scope)(args), \
-	     *done = NULL; !done; done = (void *)1) \
-		if (!__guard_ptr(_name)(&scope)) _fail; \
-		else
-
+/*
+ * Helper macro for scoped_guard().
+ *
+ * Note that the "!__is_cond_ptr(_name)" part of the condition ensures that
+ * compiler would be sure that for the unconditional locks the body of the
+ * loop (caller-provided code glued to the else clause) could not be skipped.
+ * It is needed because the other part - "__guard_ptr(_name)(&scope)" - is too
+ * hard to deduce (even if could be proven true for unconditional locks).
+ */
+#define __scoped_guard(_name, _label, args...)				\
+	for (CLASS(_name, scope)(args);					\
+	     __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);	\
+	     ({ goto _label; }))					\
+		if (0) {						\
+_label:									\
+			break;						\
+		} else
+
+#define scoped_guard(_name, args...)	\
+	__scoped_guard(_name, __UNIQUE_ID(label), args)
+
+#define __scoped_cond_guard(_name, _fail, _label, args...)		\
+	for (CLASS(_name, scope)(args); true; ({ goto _label; }))	\
+		if (!__guard_ptr(_name)(&scope)) {			\
+			BUILD_BUG_ON(!__is_cond_ptr(_name));		\
+			_fail;						\
+_label:									\
+			break;						\
+		} else
+
+#define scoped_cond_guard(_name, _fail, args...)	\
+	__scoped_cond_guard(_name, _fail, __UNIQUE_ID(label), args)
 /*
  * Additional helper macros for generating lock guards with types, either for
  * locks that don't have a native type (eg. RCU, preempt) or those that need a
@@ -369,14 +399,17 @@ static inline class_##_name##_t class_##_name##_constructor(void)	\
 }
 
 #define DEFINE_LOCK_GUARD_1(_name, _type, _lock, _unlock, ...)		\
+__DEFINE_CLASS_IS_CONDITIONAL(_name, false);				\
 __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)		\
 __DEFINE_LOCK_GUARD_1(_name, _type, _lock)
 
 #define DEFINE_LOCK_GUARD_0(_name, _lock, _unlock, ...)			\
+__DEFINE_CLASS_IS_CONDITIONAL(_name, false);				\
 __DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)		\
 __DEFINE_LOCK_GUARD_0(_name, _lock)
 
 #define DEFINE_LOCK_GUARD_1_COND(_name, _ext, _condlock)		\
+	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true);		\
 	EXTEND_CLASS(_name, _ext,					\
 		     ({ class_##_name##_t _t = { .lock = l }, *_T = &_t;\
 		        if (_T->lock && !(_condlock)) _T->lock = NULL;	\

base-commit: f87a17ed3b51fba4dfdd8f8b643b5423a85fc551
-- 
2.46.0


