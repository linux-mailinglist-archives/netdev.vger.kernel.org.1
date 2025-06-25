Return-Path: <netdev+bounces-201100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E715AE81FE
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF58D1BC4840
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7DD25D1F1;
	Wed, 25 Jun 2025 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vsASjqtW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hsBpLRmK"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA33FC8EB;
	Wed, 25 Jun 2025 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852347; cv=none; b=Dc85StxL6fylzHXCheOHSaAhWjLUuWN2pdR5cOjAisqBstMw7iBHB1WFj3Yrnd+ksa8HbQnzbwQUzKO8Kpk8tQ/h290f2ZnBdqMRStCflL5BcxTTMhGE/ggGG0TIZ8Tw/yaHcNgQuVABxxBT2YmxMsTCo/eL4vMwJJLpWaXxGDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852347; c=relaxed/simple;
	bh=92LUKS8BrqpqLPkyzxrv5DbFSbpv7LU7YBrXq7pfPx8=;
	h=Message-ID:From:To:Cc:Subject:Date; b=LQdroF1zQsxWN6ga30dfpOUBR9UDW6/tchUvqNCL0K97vhxrQmiURkidT0OCDndEqod0GvqALaoV88Yh9/BPZH9t8RBJBi7ZIVeVeR/6xC2HGNI6T6MZCKWxqhgf/vtmOrDYz/CKd2JO7rj6nc0F+YfyltZTtU+SHHQ7vrsZyMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vsASjqtW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hsBpLRmK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625114404.102196103@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750852343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=c9qnrUieLvDAzmNeK9TtFgurdMMjN0JpU0mb4zuN8EY=;
	b=vsASjqtWHr3BuW5WI6k+0IHJ3JXshFGviGuNIrmqnUF1LUm9vzjuakNFSz2sXC81WF4+pn
	73FwUHVLTOXEy1i84BHHxM1sIiYbpg+caAsHEJ1F2S5P8bobmdFRGpxBHl/X2EqXMtKH+3
	O2pVCvk3vt+FGP2d11jceWuKzqlCMI4M2FUQx7u9frK9WuC/+qZW5TGy+dY9Ow//Ot406X
	N6Jm3jVm2jUwOuxtcPPCx3tESx5o6/ubMXh1FRqEWjOvGpTOy79c39qORArmJTzUQ0x9uu
	yT7eNhqTdm5HLoqtVHXdmfoLAqqCzLrZZevvXwrXvfAYPOaYXTHjvroBg4Li2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750852343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=c9qnrUieLvDAzmNeK9TtFgurdMMjN0JpU0mb4zuN8EY=;
	b=hsBpLRmKjdFcA3vTiwBIZ3+ZriNYzMPHPbndmfPQgM+Q4B+Fg0rGshgiDzirb1v9qt1XEG
	uH1GUdFcY12tllCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Subject: [patch V2 00/13] ptp: Belated spring cleaning of the chardev driver
Date: Wed, 25 Jun 2025 13:52:23 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

This is V2 of the series. V1 can be found here:

     https://lore.kernel.org/all/20250620130144.351492917@linutronix.de

When looking into supporting auxiliary clocks in the PTP ioctl, the
inpenetrable ptp_ioctl() letter soup bothered me enough to clean it up.

The code (~400 lines!) is really hard to follow due to a gazillion of
local variables, which are only used in certain case scopes, and a
mixture of gotos, breaks and direct error return paths.

Clean it up by splitting out the IOCTL functionality into seperate
functions, which contain only the required local variables and are trivial
to follow. Complete the cleanup by converting the code to lock guards and
get rid of all gotos.

That reduces the code size by 48 lines and also the binary text size is
80 bytes smaller than the current maze.

The series is split up into one patch per IOCTL command group for easy
review.

Changes vs. V1:

  - Picked up Reviewed tags as appropriate

  - Dropped the pointless memset()s in GETFUNC/SETFUNC - Paolo

  - Dropped the __free() in ptp_open/read() - Jakub

Applies against v6.16-rc1 and also cleanly against next. It's also
available from git:

     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git timers/ptp/driver

Thanks,

	tglx
---
 ptp_chardev.c |  734 ++++++++++++++++++++++++++--------------------------------
 1 file changed, 341 insertions(+), 393 deletions(-)



