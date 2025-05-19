Return-Path: <netdev+bounces-191432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10641ABB792
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05551889605
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080A7278744;
	Mon, 19 May 2025 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bPlkKWF3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cNC42jHk"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A49277800;
	Mon, 19 May 2025 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643629; cv=none; b=NMS0cIeV52dRCS9ko24Y4XfirnkQxDhVuyyH8cnN6qNepshkNwL3xJ45Asqdl85iSCDguwZkv5rv7MiWF+zGlmKvNi7atqSvBEeJSDUN3DNVQ2gpj4MHV5WsLveZXtqZBfzq5dW4dIyp+juYproUSgiCT+mAmvMv8KeLe6Z+B6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643629; c=relaxed/simple;
	bh=9U7iTSAF6zkbJ6asv5JJaKoo4ejTpSehXvpToCZTnmM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=eHSkbJ4UOrRwklpp0x9tBpzgFj/WmCt10OwqrGnhaPl+tL5e1LRCUrexhWxXDA/5lf8GfFD8KZ6DMPKgYrhrPILdlOEDnjL+baqj3zJYU/AaxJzy8V2InHZTx+S1y3rW6FO4g+lXcoxpkibHw1k4iZ3GN9SDyE8Kp2HUvKRywCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bPlkKWF3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cNC42jHk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083027.209080298@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1D0z/j/auw0PNfUJbi9PcKAbzfkUI9RWpEnF/3jaOYY=;
	b=bPlkKWF3C3QGb/AxjSDd6jKF3MM7FfI7fmEKRPJyf9w/Tpa3/Hlq3hhQqW+09YiXGu7b8m
	yRfoROqGeKwhDA2r3+t25o9ugRJARK90tAPYodZkN9LXFzwKkATrxadub9Kn0H+Ihhj3hS
	PUj+AlCm7QMpn0vUzmBirxiBszys3w1LQ5aXQ9Or48HbOw+mKc3y5oyrTLHrhrrVbPWgKe
	kl+816S+uJQ615lCzFl3J6AhPIZ7yIb8gReCTgCUeVk2qwD/sBOFQ9g0MaLUTK3CtyPA70
	ma1Nb2X0M/GQJg+F/cJ2YNT3tXBxyW2if8gtJx3qtZ9b7gCfZU/6LIjulzVxfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1D0z/j/auw0PNfUJbi9PcKAbzfkUI9RWpEnF/3jaOYY=;
	b=cNC42jHkWgdPRmX6/OVa6PrctCPzyQ9pc8h7B9O787EzQasKq4rXNr+nw/C5WCTdQs8Ttj
	/ExQ5OxvsohmRLAA==
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
Subject: [patch V2 26/26] timekeeping: Provide interface to control auxiliary
 clocks
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:46 +0200 (CEST)

Auxiliary clocks are disabled by default and attempts to access them
fail.

Provide an interface to enable/disable them at run-time.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/ABI/stable/sysfs-kernel-time-aux-clocks |    5 
 kernel/time/timekeeping.c                             |  125 ++++++++++++++++++
 2 files changed, 130 insertions(+)

--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-kernel-time-aux-clocks
@@ -0,0 +1,5 @@
+What:		/sys/kernel/time/aux_clocks/<ID>/enable
+Date:		May 2025
+Contact:	Thomas Gleixner <tglx@linutronix.de>
+Description:
+		Controls the enablement of auxiliary clock timekeepers.
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -14,6 +14,7 @@
 #include <linux/sched/loadavg.h>
 #include <linux/sched/clock.h>
 #include <linux/syscore_ops.h>
+#include <linux/sysfs.h>
 #include <linux/clocksource.h>
 #include <linux/jiffies.h>
 #include <linux/time.h>
@@ -2900,6 +2901,130 @@ const struct k_clock clock_aux = {
 	.clock_adj		= aux_clock_adj,
 };
 
+static void aux_clock_enable(unsigned int id)
+{
+	struct tk_read_base *tkr_raw = &tk_core.timekeeper.tkr_raw;
+	struct tk_data *tkd = aux_get_tk_data(id);
+	struct timekeeper *tks = &tkd->shadow_timekeeper;
+
+	/* Prevent the core timekeeper from changing. */
+	guard(raw_spinlock_irq)(&tk_core.lock);
+
+	/*
+	 * Setup the auxiliary clock assuming that the raw core timekeeper
+	 * clock frequency conversion is close enough. Userspace has to
+	 * adjust for the deviation via clock_adjtime(2).
+	 */
+	guard(raw_spinlock_nested)(&tkd->lock);
+
+	/* Remove leftovers of a previous registration */
+	memset(tks, 0, sizeof(*tks));
+	/* Restore the timekeeper id */
+	tks->id = tkd->timekeeper.id;
+	/* Setup the timekeeper based on the current system clocksource */
+	tk_setup_internals(tks, tkr_raw->clock);
+
+	/* Mark it valid and set it live */
+	tks->clock_valid = true;
+	timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
+}
+
+static void aux_clock_disable(unsigned int id)
+{
+	struct tk_data *tkd = aux_get_tk_data(id);
+
+	guard(raw_spinlock_irq)(&tkd->lock);
+	tkd->shadow_timekeeper.clock_valid = false;
+	timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
+}
+
+static DEFINE_MUTEX(aux_clock_mutex);
+
+static ssize_t aux_clock_enable_store(struct kobject *kobj, struct kobj_attribute *attr,
+				      const char *buf, size_t count)
+{
+	/* Lazy atoi() as name is "0..7" */
+	int id = kobj->name[0] & 0x7;
+	bool enable;
+
+	if (!capable(CAP_SYS_TIME))
+		return -EPERM;
+
+	if (kstrtobool(buf, &enable) < 0)
+		return -EINVAL;
+
+	guard(mutex)(&aux_clock_mutex);
+	if (enable == test_bit(id, &aux_timekeepers))
+		return count;
+
+	if (enable) {
+		aux_clock_enable(CLOCK_AUX + id);
+		set_bit(id, &aux_timekeepers);
+	} else {
+		aux_clock_disable(CLOCK_AUX + id);
+		clear_bit(id, &aux_timekeepers);
+	}
+	return count;
+}
+
+static ssize_t aux_clock_enable_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	unsigned long active = READ_ONCE(aux_timekeepers);
+	/* Lazy atoi() as name is "0..7" */
+	int id = kobj->name[0] & 0x7;
+
+	return sysfs_emit(buf, "%d\n", test_bit(id, &active));
+}
+
+static struct kobj_attribute aux_clock_enable_attr = __ATTR_RW(aux_clock_enable);
+
+static struct attribute *aux_clock_enable_attrs[] = {
+	&aux_clock_enable_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group aux_clock_enable_attr_group = {
+	.attrs = aux_clock_enable_attrs,
+};
+
+static int __init tk_aux_sysfs_init(void)
+{
+	struct kobject *auxo, *tko = kobject_create_and_add("time", kernel_kobj);
+
+	if (!tko) {
+		pr_warn("Unable to create /sys/kernel/time/. POSIX AUX clocks disabled.\n");
+		return -ENOMEM;
+	}
+
+	auxo = kobject_create_and_add("aux_clocks", tko);
+	if (!auxo) {
+		pr_warn("Unable to create /sys/kernel/time/aux_clocks. POSIX AUX clocks disabled.\n");
+		kobject_put(tko);
+		return -ENOMEM;
+	}
+
+	for (int i = TIMEKEEPER_AUX; i <= TIMEKEEPER_AUX_LAST; i++) {
+		char id[2] = { [0] = '0' + (i - TIMEKEEPER_AUX), };
+		struct kobject *clk = kobject_create_and_add(id, auxo);
+
+		if (!clk) {
+			pr_warn("Unable to create /sys/kernel/time/aux_clocks/%d\n",
+				i - TIMEKEEPER_AUX);
+			return -ENOMEM;
+		}
+
+		int ret = sysfs_create_group(clk, &aux_clock_enable_attr_group);
+
+		if (ret) {
+			pr_warn("Unable to create /sys/kernel/time/aux_clocks/%d/enable\n",
+				i - TIMEKEEPER_AUX);
+			return ret;
+		}
+	}
+	return 0;
+}
+late_initcall(tk_aux_sysfs_init);
+
 static __init void tk_aux_setup(void)
 {
 	for (int i = TIMEKEEPER_AUX; i <= TIMEKEEPER_AUX_LAST; i++)


