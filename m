Return-Path: <netdev+bounces-127388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6AF9753FC
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E57F287ECB
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4185F19E992;
	Wed, 11 Sep 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sK0U+gNR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tA5ZjM3s"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552B51A38CF;
	Wed, 11 Sep 2024 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061408; cv=none; b=co/tW5oMc9xxmUvwW1Tnd4X7Evx0/ij5Dl8/UOaRJpoc8eNp12BjW+nYcS4OBe4O9YmIA29R7lMF8HdrMaFEJZd9gVGxaqdwPPmUveIKX80/sKQqDJzVcoYLECt7mVGG812pFWFN6lhE+OHPPq01wnx2GIs2fNgoPqHLoIwNMk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061408; c=relaxed/simple;
	bh=HPWOFz6QlzqiLm2ycbh4HDRSVVxwgKQjS7UPR0/1PZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dyo489kGHWHRMutec9esJEJuFSmjrfs0RArhyrO7B0L9XnlRLoFIcPXYXykqIWPOToNsQG+vYHx8KXIDt3nxxdJVdi4fipwhP0+9M51kFw51sauxujf0AIk6Zn/b9usJbaFgU6bzLyWEuJjekApj3BDATj6LvapP3PYPeGSDluw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sK0U+gNR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tA5ZjM3s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IS76DhjefyTyiG2SBhgBRCAZ9oiTQKrEuGQl4y3cz2A=;
	b=sK0U+gNRUgsHJFXftng12Ks1kJ44I8kLYqqQPdq8Nt4fSTVIZc4uACWl0Y3W46DyU5TOcb
	0rrUVaue2jJJZP9D8flHeByawe2WVLJ93vUAZ9Ty7Pywc42l0pKfhXit9pYwfTQ+GQKwkJ
	NmglGzb2AQ9upqKlVDcc+pmEs7/0enEn8VXH0sxYZbMyq5YaIvVHuNXschPZyxQG+vjDGa
	u6oowoO8i06Ar4eniq0pVh68I8Q663agOTuBBIcJRX30veEAlO0VzKbH0+23/NC8dXL4Oq
	y114O2YLYxxd6anhCe/X4z50Kw6jGwDWMrmWCDTMKYCzzW/tDusSZBI4uXIe9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IS76DhjefyTyiG2SBhgBRCAZ9oiTQKrEuGQl4y3cz2A=;
	b=tA5ZjM3sALYaMxc3hgTiB0EQDsPOsWq/HOB0NnvkGMTLqWvP86oMpAiJYdD4kWACAJwTJu
	uLoILAXj3nWAoyBQ==
Date: Wed, 11 Sep 2024 15:29:51 +0200
Subject: [PATCH 07/24] timekeeping: Move shadow_timekeeper into tk_core
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-7-f7cae09e25d6@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-0-f7cae09e25d6@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-0-f7cae09e25d6@linutronix.de>
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

tk_core requires shadow_timekeeper to allow timekeeping_advance() updating
without holding the timekeeper sequence count write locked. This allows the
readers to make progress up to the actual update where the shadow
timekeeper is copied over to the real timekeeper.

As long as there is only a single timekeeper, having them separate is
fine. But when the timekeeper infrastructure will be reused for per ptp
clock timekeepers, shadow_timekeeper needs to be part of tk_core.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index e528e283523b..e35e00b0cdd4 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -50,11 +50,11 @@ DEFINE_RAW_SPINLOCK(timekeeper_lock);
 static struct {
 	seqcount_raw_spinlock_t	seq;
 	struct timekeeper	timekeeper;
+	struct timekeeper	shadow_timekeeper;
 } tk_core ____cacheline_aligned = {
 	.seq = SEQCNT_RAW_SPINLOCK_ZERO(tk_core.seq, &timekeeper_lock),
 };
 
-static struct timekeeper shadow_timekeeper;
 
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;
@@ -776,8 +776,7 @@ static void timekeeping_update(struct timekeeper *tk, unsigned int action)
 	 * timekeeper structure on the next update with stale data
 	 */
 	if (action & TK_MIRROR)
-		memcpy(&shadow_timekeeper, &tk_core.timekeeper,
-		       sizeof(tk_core.timekeeper));
+		memcpy(&tk_core.shadow_timekeeper, &tk_core.timekeeper, sizeof(tk_core.timekeeper));
 }
 
 /**
@@ -2274,8 +2273,8 @@ static u64 logarithmic_accumulation(struct timekeeper *tk, u64 offset,
  */
 static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 {
+	struct timekeeper *tk = &tk_core.shadow_timekeeper;
 	struct timekeeper *real_tk = &tk_core.timekeeper;
-	struct timekeeper *tk = &shadow_timekeeper;
 	unsigned int clock_set = 0;
 	int shift = 0, maxshift;
 	u64 offset;

-- 
2.39.2


