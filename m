Return-Path: <netdev+bounces-201293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC43CAE8CA2
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F11817A1F76
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8D72D660E;
	Wed, 25 Jun 2025 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vvv5A7N7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rPbv0I9b"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB06E1AF0BB;
	Wed, 25 Jun 2025 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876713; cv=none; b=Jl2G+ZsgLXOuXUMzV3foFl9TW1n+yA5yo3c7K5j5WlwlnRUdsC4lzli+vCuiHo0Vm/K58IbCQc6ikTxM/V4ix6w5AiU9p0W3M8EC54TJ0JFWsu5JsEf4sagjoxfaJ9+7GT6j39azgPFEZmOQMHakcUEqY4uls20RdNmkeRCm9jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876713; c=relaxed/simple;
	bh=vhIpbL8PX1zuLkauw/1TluiZTOdJeUcJLbeWVxmstB0=;
	h=Message-ID:From:To:Cc:Subject:Date; b=upQijAVk3X51V0i65qnsoeWQmNb7M/WbN2g51DJAKSx838knjmqZ95BXn0oQcNi3MfgBAdNENyvA35UxqX+fPRPLH2UGIR3y9d6uo9nUL73Xt6+FBkFd+1FFBZseyktUK8M4dQPpeBpOFGmOfM5NW6dVd/U4GnnJXho6zCrywT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vvv5A7N7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rPbv0I9b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625182951.587377878@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750876707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=vtyXAHESSpGD7UpiGsAjSdb/OwZhsKJr4dsRrO4YTfE=;
	b=vvv5A7N7HVrhlNOuUYrNXKklHpbSiaMu/wtFA/BR7cFYx+x0ecvi8sg2o4SZ4CmbGDSo5a
	77aitqR6B9xh2mCRkh0AzE9ZyncT2ry8lWC8ctiC5TeM8RZELPaTZGpLLvLJQX+TA7HUaB
	PJyfpGstoAH3oTEpGCY8OmrMJHjW+V7zL/0ujlJQnP4pvHpR3oJ0BXEfxa3ndtXBaGUsZQ
	LZThj08CvFwJ8ZaravLs0luB0ogmWjkgRpEIqoboAblOLAld2R/jB5uYKwsgdCWgpRjwQg
	QIK9c9gfSAwgi0ixUP91TW8/BXyKw2bk5NKTY0wW8CQX2DURdqF6LhmA2ZV8ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750876707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=vtyXAHESSpGD7UpiGsAjSdb/OwZhsKJr4dsRrO4YTfE=;
	b=rPbv0I9bDXpOA5f9Qpmwsin4dawmyyCxpDccsGoBvdNmiBIGnycxeVB7YUbWJlivJCkJZs
	yMmXgw32nGY88vAA==
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
Subject: [patch V3 00/11] timekeeping: Provide support for auxiliary clocks -
 Remaining series
Date: Wed, 25 Jun 2025 20:38:25 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

This is the remaining series of V2, which can be found here:

   https://lore.kernel.org/all/20250519082042.742926976@linutronix.de

The first 15 patches of V2 have been merged into the tip tree and this is
the update of the remaining 11, which addresses the review feedback.

Changes vs. V2:

  - Use kobject.h, clockid_t and cleanup the sysfs init - Thomas W.

  - Use aux_tkd, aux_tks instead of tkd, tks in aux clock specific
    functions for clarity - John

  - Remove misleading clock TAI comment - John

The series applies on top of:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/ptp

and is available from git:

     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git timers/ptp/clocks

A small update for PTP to support auxiliary clocks in
PTP_SYS_OFFSET_EXTENDED is going to be sent seperately as it has a
dependency on pending PTP changes.

Thanks,

	tglx
---
 Documentation/ABI/stable/sysfs-kernel-time-aux-clocks |    5 
 include/linux/posix-timers.h                          |    5 
 include/linux/timekeeping.h                           |   11 
 kernel/time/posix-timers.c                            |    3 
 kernel/time/posix-timers.h                            |    1 
 kernel/time/timekeeping.c                             |  484 +++++++++++++++---
 6 files changed, 451 insertions(+), 58 deletions(-)

