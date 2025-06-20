Return-Path: <netdev+bounces-199758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C429AAE1C07
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6673B1C20B57
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67EE28C01C;
	Fri, 20 Jun 2025 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V/LveJ3T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cIJfU+WA"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EB821C18E;
	Fri, 20 Jun 2025 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425869; cv=none; b=bou1Qc4fJW52JO9Y4129PsFEdvtW7ROF4PeEDJQg70CZ8G2wpuadtDubi89lCZvampELrJAoOs/7afNk3yc1EDcxqdAGMA1kW76mDCq1X5D4zTHmpslGiRCKq82sXG0m1ZZjvzyWYVvoDs2amy4RJY0/SvdnsbVKWZdKdVdYYMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425869; c=relaxed/simple;
	bh=SwPzZ1AKNarnUnLWJnoUp/8HVMp/cdN1XP86Yqn8Coc=;
	h=Message-ID:From:To:Cc:Subject:Date; b=CB8RG46iyuC1xXiB5n+KmqGWsmDsQLMDbBSoPwroaatsC1SnnQ8M6wrMjk9t3CCmAX2VczTmb+RegoB/Lf30T3i2NJuL27ssKa+BE8Q+zrzeB7BBdGdfcIg8TDe86Yz9ij9jUOEUsOTr8uxbOcSS3IidYyQH3ANye4+XgC2mkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V/LveJ3T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cIJfU+WA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250620130144.351492917@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750425866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=4zlPo7/gSAstY6IHhvXAhKrcBYtP3LJGvZW9RFkjhQA=;
	b=V/LveJ3T/0WGdiRReWFgStrm7RUf/sutpblhl4JyUWuylo9f7UFD9BeGftEBpHFm3KMwm1
	PmpPOIhlikt6L99RrgRegvzd+f2on/r9a4RTT0Rp7mI0yaY57F3xXMPOIOOjdJs/NQrzYe
	P3McIWBbdKF3acp3i/L8lmWxs41Ldx+PlIrc1h3F3mSBc8UIrqlASMdAliyurjjZ0TFNAE
	IjszIDDpuA+Oq0DbEWagNZeiBlcHYLdamln/akAwzBCuX1Wt1gnqHDaQ2kHRaL4uAIfuYx
	nF+nWMzun0UtDhffBL8Ovq0AinVokPndj7owobIRBVT8Vuiq0MmbwCuBhLZlsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750425866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=4zlPo7/gSAstY6IHhvXAhKrcBYtP3LJGvZW9RFkjhQA=;
	b=cIJfU+WAPu4LcEx8Rqf5yPeGQc3V1qElEc5Ox+4mwBHgwWChq2zK6akwxvbPWnqrd74fcs
	d0Nb9NSdNL1PdSAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
Subject: [patch 00/13] ptp: Belated spring cleaning of the chardev driver
Date: Fri, 20 Jun 2025 15:24:25 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

When looking into supporting auxiliary clocks in the PTP ioctl, the
inpenetrable ptp_ioctl() letter soup bothered me enough to clean it up.

The code (~400 lines!) is really hard to follow due to a gazillion of
local variables, which are only used in certain case scopes, and a
mixture of gotos, breaks and direct error return paths.

Clean it up by splitting out the IOCTL functionality into seperate
functions, which contain only the required local variables and are trivial
to follow. Complete the cleanup by converting the code to lock guards and
_free(), which gets rid of all gotos.

That reduces the code size by 58 lines and also the binary text size is
90 bytes smaller than the current maze.

The series is split up into one patch per IOCTL command group for easy
review.

Applies against v6.16-rc1 and also cleanly against next. It's also
available from git:

     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git timers/ptp/driver

Thanks,

	tglx
---
 ptp_chardev.c |  754 ++++++++++++++++++++++++++--------------------------------
 1 file changed, 348 insertions(+), 406 deletions(-)

