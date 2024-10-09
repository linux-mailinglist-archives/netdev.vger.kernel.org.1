Return-Path: <netdev+bounces-133534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5129962D0
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AEE1F23A4A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3186E191F88;
	Wed,  9 Oct 2024 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aWgT2Gn1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9h2b0jNg"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C289618FC86;
	Wed,  9 Oct 2024 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462566; cv=none; b=VR+Hek9FOdB8+voyCo05D9cHJiQ65cGE+/voc8clvtF77yOScdG34m9LRxffm9nwzDEJMviINDsnd7ZUGNtqKMfo1Q0nMteqbbzKy+IqIhcGy1HA0nq83iCn5QatHZnwseb0WwcaKCsUQNZNqhoC7CiXBjs2buw4XYLZZRRBI6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462566; c=relaxed/simple;
	bh=yFxmegOrxfY1kdAuzvtcvTabjp1FL3Sf++7UBkCOy74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jhc7cCcwya0pncefzNXpMAKfWKKQhtvnCZPH3/U6xLf+MLYRNXhwSL1qOQ68hsyhfZTb3jD2LuqB/3gtFMwfYw3DJPGMLQGvzN6ZwVT+5/gqgzLqA3xDtRCX8ZQH0zT3OI2mr9Yn7kls1f6F7rMy40V/lXx3SHMLc0a2e1BiErY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aWgT2Gn1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9h2b0jNg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eoUlvD35oQHkwv1qwQ5WsrLRNLxDye46TStt/7cTBQ0=;
	b=aWgT2Gn1kwkB9vpNC5asC5vrvcckmA1e/PVN18k8Bap6QlNnYtuPy55rlXrvzq35IjYUCG
	Pjs9yJ//wrN+d7JeeBjCruYObcU3hZQ3+vIV36rkBIeMrAq/IPOYWvsXKAXlSBftjP06UT
	/C4qLJGqpPZsD35tgYi2+VjHycPwENu1hAnRXMzjBdqazJaPE7p9v/7XcxOoGfqwzpBOii
	C50FIILW094PIj48CISkumqYSWGTsMIUlu3DF/RoMULRMLa6AX3RBPPhOTkqMtZMQgllyc
	qzDIRC6yAdiLQ6nU9rk4AU60QWRmLngQPPXQ72/8GuQW8TVK6bBVKZJwzh2PhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eoUlvD35oQHkwv1qwQ5WsrLRNLxDye46TStt/7cTBQ0=;
	b=9h2b0jNg4VFKJcvnAZRb/vs7QkqWXE/03Pr5h+kW31TrbI8FE/QAOhfrf++aoxNAsHhteU
	QKCxOHQ77CBZPMDg==
Date: Wed, 09 Oct 2024 10:29:17 +0200
Subject: [PATCH v2 24/25] timekeeping: Remove TK_MIRROR
 timekeeping_update() action
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-24-554456a44a15@linutronix.de>
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

All call sites of using TK_MIRROR flag in timekeeping_update() are
gone. The TK_MIRROR dependent code path is therefore dead code.

Remove it along with the TK_MIRROR define.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b2683a589470..67d7be2e02fb 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -30,8 +30,7 @@
 #include "timekeeping_internal.h"
 
 #define TK_CLEAR_NTP		(1 << 0)
-#define TK_MIRROR		(1 << 1)
-#define TK_CLOCK_WAS_SET	(1 << 2)
+#define TK_CLOCK_WAS_SET	(1 << 1)
 
 #define TK_UPDATE_ALL		(TK_CLEAR_NTP | TK_CLOCK_WAS_SET)
 
@@ -797,13 +796,6 @@ static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsig
 
 	if (action & TK_CLOCK_WAS_SET)
 		tk->clock_was_set_seq++;
-	/*
-	 * The mirroring of the data to the shadow-timekeeper needs
-	 * to happen last here to ensure we don't over-write the
-	 * timekeeper structure on the next update with stale data
-	 */
-	if (action & TK_MIRROR)
-		timekeeping_restore_shadow(tkd);
 }
 
 static void timekeeping_update_staged(struct tk_data *tkd, unsigned int action)

-- 
2.39.5


