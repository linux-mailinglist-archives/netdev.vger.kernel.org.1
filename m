Return-Path: <netdev+bounces-201110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AC9AE8212
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0857C189219E
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FCA264A73;
	Wed, 25 Jun 2025 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g9751myK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BG7dIOjN"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A20D263F5F;
	Wed, 25 Jun 2025 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852359; cv=none; b=rvFTWfeSW51WcvZybS0tMy8c5vAJrrdtqM4FcLflntk7rhU/uY8nq4VTN250lftQ1+HqBB1aBHkl2nw8tLlAwAqOr79JrgFvR8D6LMVgBiaDt687TW7gOXlQl5DoSJD2hTKnXxITc5hloxubNtPKGnfmWvyOUcQoCxL1oacLQaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852359; c=relaxed/simple;
	bh=rr8fAWb3kvA4H9Yz13Px2yWrmokXRJ6gC7oMdc9px6A=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=VhSN+isDyrtqL3tdCt3wHdr2rZTo61DRzzqUSC98oSlXKaYvbvA4TqnBJthU/BSuLTB27HT/7yd3S8MlJPPuGZz7Ez6b98rpElctGG4wTbhYM204E12jMLH0iK+dgxe8uXoH5WO+yD+xZUTnMDzqcvZNTFunx2c7SM0C52YZpo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g9751myK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BG7dIOjN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625115133.302755618@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750852355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=W2EkBRRcHKOl9PBQoHJSVchzsp2H3hQ5VGDL4cgKRa0=;
	b=g9751myKgNq6yPRwDM7xJtMOU2PIy3jK9LiQI6lPc/WFCn8LCBOCFE/l/kEkXuLuwDEUVt
	xpC9p63dcS98UXUWxemLvxwBa6ulbaKLRyB4eK2Vl7Eil0XKdCIplptkN36y0UFNHDlbrq
	5uH9208Qv1n0hq8Pi8EFgaXGi98qzxt/Mpt0Sb/DTE+91ot2WBK/JIu0wl44AayMlxF4Q5
	UyfkYkn0v7rXrpraRjoPd3DA4H3vm6Mucv5tEJ48tst4/cTw5J3wq31d7TPLKK03xRVh53
	06OZguDBYDF9M5aBZL9q2SaO/VXwR5cMDAqxGCz4+yQjqH8XVuFK9mKecOydog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750852355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=W2EkBRRcHKOl9PBQoHJSVchzsp2H3hQ5VGDL4cgKRa0=;
	b=BG7dIOjNPg4eTyTMKXBq6hCR9aX0lvZr3urymw9c5yWiih/vOy9sku3k73zJLIAt1ZIwuf
	mHEwoSFXooTti6AQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Subject: [patch V2 10/13] ptp: Split out PTP_MASK_CLEAR_ALL ioctl code
References: <20250625114404.102196103@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 13:52:35 +0200 (CEST)

Continue the ptp_ioctl() cleanup by splitting out the PTP_MASK_CLEAR_ALL ioctl
code into a helper function.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

---
 drivers/ptp/ptp_chardev.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -442,6 +442,12 @@ static long ptp_pin_setfunc(struct ptp_c
 		return ptp_set_pinfunc(ptp, pin_index, pd.func, pd.chan);
 }
 
+static long ptp_mask_clear_all(struct timestamp_event_queue *tsevq)
+{
+	bitmap_clear(tsevq->mask, 0, PTP_MAX_CHANNELS);
+	return 0;
+}
+
 long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	       unsigned long arg)
 {
@@ -504,8 +510,7 @@ long ptp_ioctl(struct posix_clock_contex
 		return ptp_pin_setfunc(ptp, cmd, argptr);
 
 	case PTP_MASK_CLEAR_ALL:
-		bitmap_clear(tsevq->mask, 0, PTP_MAX_CHANNELS);
-		break;
+		return ptp_mask_clear_all(pccontext->private_clkdata);
 
 	case PTP_MASK_EN_SINGLE:
 		if (copy_from_user(&i, (void __user *)arg, sizeof(i))) {




