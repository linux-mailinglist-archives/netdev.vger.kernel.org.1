Return-Path: <netdev+bounces-191411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CC9ABB756
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487E916ACB7
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF9026B2DB;
	Mon, 19 May 2025 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p+/DUNs0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pT391Mru"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD226AA9E;
	Mon, 19 May 2025 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643603; cv=none; b=rW9qgp18c0F0Dur95xW7YjVv9sSE3XYdNpvTqtDGdu0DQasYoV8ewk9grR4LLijXDPBMKhmwJqAg//dwIxv5mU0D0XqA+kY9voKzzF+83MzMLXt7eXSOVYTAY7BlxT2eOtM/RNZxsyo1VkjRyTS6lCpYm8rN6PK8wgaqetsBle4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643603; c=relaxed/simple;
	bh=yZ2CxMBFDslosCsaU9H6xC8XDWQs6w4ZmIcPTpft4A4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=cF740MirehckAbaoBnXU42pR/9TWthysMwtfzdU6lBu1keOP2u7Z5jlH6JbmjLlQzuImLb6xB/jdEJVy8DE4m//uFexGdMpFzKIptpLMDEXsIBdideOJPHX9z817wTn6raEImZ+jvobwhYHwNa4iNyMEyDFHDYvF41UrHm8UIN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p+/DUNs0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pT391Mru; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083025.905800695@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=tDFFxWQgqXHC1kYIc4ua9v4PhXUgIm5hvteunQy/FmE=;
	b=p+/DUNs0fwBiQlFFRDFKUekpBBGL8l535M5GVBlTlzWtRJBi9gaYl7MoTsd79s5SmBbNuG
	JfcxBKEXox9D5EWzCYHTGMKZXgbesKCN0nwgD1oIbOiIrgzsV15tc62wfLFOjkq6td+Bwq
	aSinChCf9bcXuhMxk4I34D/phV6KODgkv3cOJHhKs3Z1opv96l9yZVEaqgxd/QmgR7RA4w
	iwWgUwUsG/6Dcx0XZI+fz0fNekpQCWS8LFd9fcLwztSwSMCjDIvbdcu23Zn7NV0ijGOJ0v
	5Mw7cieTfpQzK5oTa6t9hmTYrtydfFJQgb0wxlR4CafyRQ8j1PBSTYhe3jeW1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=tDFFxWQgqXHC1kYIc4ua9v4PhXUgIm5hvteunQy/FmE=;
	b=pT391MruRl+C92/xlOm2g2pnfLwazPEUucBB7+6/vKBxtt029OieyYx3/pV1zfMmt93VMx
	OktfVfCaaFoLZdBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
 John Stultz <jstultz@google.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Miroslav Lichvar <mlichvar@redhat.com>,
 Werner Abt <werner.abt@meinberg-usa.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Stephen Boyd <sboyd@kernel.org>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Nam Cao <namcao@linutronix.de>,
 Antoine Tenart <atenart@kernel.org>
Subject: [patch V2 05/26] time: Introduce auxiliary POSIX clocks
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:20 +0200 (CEST)

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

To support auxiliary timekeeping and the related user space interfaces,
it's required to define a clock ID range for them.

Reserve 8 auxiliary clock IDs after the regular timekeeping clock ID space.

This is the maximum number of auxiliary clocks the kernel can support. The actual
number of supported clocks depends obviously on the presence of related devices
and might be constraint by the available VDSO space.

Add the corresponding timekeeper IDs as well.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/timekeeper_internal.h |    6 ++++++
 include/uapi/linux/time.h           |   11 +++++++++++
 kernel/time/Kconfig                 |   15 +++++++++++++--
 3 files changed, 30 insertions(+), 2 deletions(-)
---
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -14,10 +14,16 @@
 /**
  * timekeeper_ids - IDs for various time keepers in the kernel
  * @TIMEKEEPER_CORE:	The central core timekeeper managing system time
+ * @TIMEKEEPER_AUX:	The first AUX timekeeper
+ * @TIMEKEEPER_AUX_LAST:The last AUX timekeeper
  * @TIMEKEEPERS_MAX:	The maximum number of timekeepers managed
  */
 enum timekeeper_ids {
 	TIMEKEEPER_CORE,
+#ifdef CONFIG_POSIX_AUX_CLOCKS
+	TIMEKEEPER_AUX,
+	TIMEKEEPER_AUX_LAST = TIMEKEEPER_AUX + MAX_AUX_CLOCKS - 1,
+#endif
 	TIMEKEEPERS_MAX,
 };
 
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -64,6 +64,17 @@ struct timezone {
 #define CLOCK_TAI			11
 
 #define MAX_CLOCKS			16
+
+/*
+ * AUX clock support. AUXiliary clocks are dynamically configured by
+ * enabling a clock ID. These clock can be steered independently of the
+ * core timekeeper. The kernel can support up to 8 auxiliary clocks, but
+ * the actual limit depends on eventual architecture constraints vs. VDSO.
+ */
+#define	CLOCK_AUX			MAX_CLOCKS
+#define	MAX_AUX_CLOCKS			8
+#define CLOCK_AUX_LAST			(CLOCK_AUX + MAX_AUX_CLOCKS - 1)
+
 #define CLOCKS_MASK			(CLOCK_REALTIME | CLOCK_MONOTONIC)
 #define CLOCKS_MONO			CLOCK_MONOTONIC
 
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -82,9 +82,9 @@ config CONTEXT_TRACKING_IDLE
 	help
 	  Tracks idle state on behalf of RCU.
 
-if GENERIC_CLOCKEVENTS
 menu "Timers subsystem"
 
+if GENERIC_CLOCKEVENTS
 # Core internal switch. Selected by NO_HZ_COMMON / HIGH_RES_TIMERS. This is
 # only related to the tick functionality. Oneshot clockevent devices
 # are supported independent of this.
@@ -208,6 +208,17 @@ config CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
 	  interval and NTP's maximum frequency drift of 500 parts
 	  per million.	If the clocksource is good enough for NTP,
 	  it is good enough for the clocksource watchdog!
+endif
+
+config POSIX_AUX_CLOCKS
+	bool "Enable auxiliary POSIX clocks"
+	depends on POSIX_TIMERS
+	help
+	  Auxiliary POSIX clocks are clocks which can be steered
+	  independently of the core timekeeper, which controls the
+	  MONOTONIC, REALTIME, BOOTTIME and TAI clocks.  They are useful to
+	  provide e.g. lockless time accessors to independent PTP clocks
+	  and other clock domains, which are not correlated to the TAI/NTP
+	  notion of time.
 
 endmenu
-endif


