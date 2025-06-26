Return-Path: <netdev+bounces-201565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D36AE9EBA
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC2018878CE
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7134328C009;
	Thu, 26 Jun 2025 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tIbW0I3w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0sgelXYS"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AD328BAAD;
	Thu, 26 Jun 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944453; cv=none; b=BxDHcrqXM3SPCBequipkUXaFXgpwEPvMUR+1gj/7fMJv4pEGcdXGhw8x8aZFlJPx/9KfeTqs0tBsDOI3reJXeZUMXTYNL+W521yePZ6548RltmRJpo646/9+JLHmpIcOXG77InXPs5M3ifZgFHGeMgfW/I2fIHgD1VkvEq56kr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944453; c=relaxed/simple;
	bh=+g2xAtY19rs9wmZVdJBWvJTRN2jcGk4G9wKZczvbe00=;
	h=Message-ID:From:To:Cc:Subject:Date; b=Ku+czmNY2OuSKkEQ99MdcVrU9tsixR30zj8CgbDUSA+6nVzcPYiPCynRykkFQjBt+uFzS29DiwnV3bA00TQbP4iC7EKaJHMVqHzEnTONOEH8ZjxRsnPMh8hYdsVUf2IKuamsCXNeOg/PYwCE7XckxoN04CEbRifreCRBRT9JJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tIbW0I3w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0sgelXYS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250626124327.667087805@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750944449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=QWgJWSmIUCV1467V2UYeprQ3/qYWMoWGUhlIF1YZ6bM=;
	b=tIbW0I3wMyX7NEqzAuDAegPqhqqHZOwhr4gu8MQI2pfhZe1XV7Yz0ERBgITuWRDRsbjN8/
	KGwB7Wvz4FA40ldoo/1Ae1MENY09zmYbWYfNeNK45iAphw1HalhlWN3UaK1nG2hb5HnwVK
	l1E/pr/qXDD887MURy7YpwJ9KBmCwCdDWi57BjsU0c0Kxnu2UPj9j/GcoWS3xZaS5NBVBm
	U4RnqIO2QChtWs7DMFlTkoI2w8lx+qofEeoHVvrnyeeWsySW0I7TGgNU2LERcY/mi5W4jH
	vgnfgI5KiQFgr7qgsz1S1rgI04WOAG2mVwORv0opgl5yu5pjfA+J3+lkbDkbwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750944449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=QWgJWSmIUCV1467V2UYeprQ3/qYWMoWGUhlIF1YZ6bM=;
	b=0sgelXYSNMB3dpgn02rqW0G8Hsomh0utPuWwA0EZEiOXpX9XsJ6vvshKC9FH+agUR/L+2+
	J8mNLEQ8e+ZbjsCQ==
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
Subject: [patch 0/3] ptp: Provide support for auxiliary clocks for
 PTP_SYS_OFFSET_EXTENDED
Date: Thu, 26 Jun 2025 15:27:28 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

This small series enables support for auxiliary clocks on top of the
timekeeping core infrastructure, which has been paritially merged. The
remaining outstanding patches can be found here:

     https://lore.kernel.org/all/20250625182951.587377878@linutronix.de

Auxiliary clocks are required to support TSN use cases in automation,
automotive, audio and other areas. They utilize PTP for synchronizing nodes
in a network accurately, but the underlying master clock is not necessarily
related to clock TAI. They are completely independent and just represent a
common notion of time in a network for an application specific
purpose. This comes with problems obvioulsy:

   1) Applications have no fast access to the time of such independent PTP
      clocks. The only way is to utilize the file descriptor of the PTP
      device with clock_gettime(). That's slow as it has to go all the way
      out to the hardware.

   2) The network stack cannot access PTP time at all because accessing the
      PTP hardware requires preemptible task context in quite some cases.

The timekeeper core changes provide support for this including the ability
to steer these clocks independently from the core timekeeper via
clock_adjtimex(2).

This is obviously incomplete as the user space steering daemon needs to be
able to correlate timestamps from these auxiliary clocks with the
associated PTP device timestamp. The PTP_SYS_OFFSET_EXTENDED IOCTL command
already supports to select clock IDs for pre and post hardware timestamps,
so the first step for correlation is to extend that IOCTL to allow
selecting auxiliary clocks.

Auxiliary clocks do not provide a seperate CLOCK_MONOTONIC_RAW variant as
they are internally utilizing the same clocksource and therefore the
existing CLOCK_MONOTONIC_RAW correlation is valid for them too, if user
space wants to determine the correlation to the underlying clocksource raw
initial conversion factor:

CLOCK_MONOTONIC_RAW:

  The clocksource readout is converted to nanoseconds by a conversion
  factor, which has been determined at setup time. This factor does not
  change over the lifetime of the system.

CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_BOOTTIME, CLOCK_TAI:

  The clocksource readout is converted to nanoseconds by a conversion
  factor, which starts with the CLOCK_MONOTONIC_RAW conversion factor at
  setup time. This factor can be steered via clock_adjtimex(CLOCK_REALTIME).

  All related clocks use the same conversion factor and internally these
  clocks are built on top of CLOCK_MONOTONIC by adding a clock specific
  offset after the conversion. The CLOCK_REALTIME and CLOCK_TAI offsets can
  be set via clock_settime(2) or clock_adjtimex(2). The CLOCK_BOOTTIME
  offset is modified after a suspend/resume cycle to take the suspend time
  into account.

CLOCK_AUX:

  The clocksource readout is converted to nanoseconds by a conversion
  factor, which starts with the CLOCK_MONOTONIC_RAW conversion factor at
  setup time. This factor can be steered via clock_adjtimex(CLOCK_AUX[n]).

  Each auxiliary clock uses its own conversion factor and offset. The
  offset can be set via clock_settime(2) or clock_adjtimex(2) for each
  clock ID.

The series applies on top of the above mentioned timekeeper core changes
and the PTP character device spring cleaning series, which can be found
here:

  https://lore.kernel.org/all/20250625114404.102196103@linutronix.de

It is also available via git with all prerequisite patches:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git timers/ptp/driver-auxclock

Miroslav: This branch should enable you to test the actual steering via a
	  PTP device which has PTP_SYS_OFFSET_EXTENDED support in the driver.

Thanks,

	tglx
---
 drivers/ptp/ptp_chardev.c        |   21 ++++++++++++++++-----
 include/linux/ptp_clock_kernel.h |   34 ++++------------------------------
 include/linux/timekeeping.h      |    1 +
 kernel/time/timekeeping.c        |   34 ++++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 35 deletions(-)

