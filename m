Return-Path: <netdev+bounces-133520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7CA9962AD
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08AC0B2462D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FC218E344;
	Wed,  9 Oct 2024 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CsQiryeB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YUihAkcy"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7BC18CC0D;
	Wed,  9 Oct 2024 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462562; cv=none; b=fG0Wup/X1VEUFn6IexfxJoiSXtRlDdcT+fjfZ0kUlfe3PMUNd0F0SYODd3wFyTbPVpACQx1ZyB9ziA9C+Jgb0c6pjENpSR/cKixWhu2W/AYL+Qzbo1C04GXf8YQ+1D/gz3g/NKBU0VqVXT6QH7TNZkNMOJGokdPFmBYbITh2DdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462562; c=relaxed/simple;
	bh=VmpacbXvFICUwe6HFWWyFXiddgpQsONmFUPY0mpNvc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QTtc7Vm2A4W8k0i7GrLtvFlSAnSrUJfA1RKWe/UNqju7025WIlRDeZosV24TT3lFm6vWbQO3G7R2UAY5AbWSz5XAFNt9uqHlqLA2ezeOaA9rsKRJqZJdAn/YA28uVRBavaD2LCOL7QB9BacRuQp+37wo7W66c+8Lgu3Hw2BaqkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CsQiryeB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YUihAkcy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63USMTPRy4krudbQE7I3ZBsVQpkprmvzSEp3iWRhZlU=;
	b=CsQiryeBLJsNBz2jKFmcxvrfWox/mTlGnCvdLq4bvsn7YFFM9f03Yr8UaikBE0Rt0as8Vn
	tH+T7BvubJEgetj1SlM5tsR44ei68KK+2tMMGyeBJhKvnSTKylLyD9+OXjTw6QsqYuQO7h
	2qW5RmXsd4aJwtkk1XGZubFV2g1otzsdIDbcqDGiPat6sJzjBnG1jYrdpyyZRi7k7Ik8sZ
	yLsEVhkhlSAUp5TWQPA5etJpP3Z/mfQpevVa9c2d1vkh9pkPLuhqQWqQ8kr/m3ab9zD2aj
	oLwWv84RjqpjPZdZAShRO6ZGedJCaiteZ6VK9imlvwDnD0To6lOv2KBemCS9/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63USMTPRy4krudbQE7I3ZBsVQpkprmvzSEp3iWRhZlU=;
	b=YUihAkcyZMaZghMDfclMsOmqBcSKiCPtyO+8XZLxjKW3sOI1yYvmzXbVBRuhBz70wcjnrm
	QvkZ+eD0AyT9K9BA==
Date: Wed, 09 Oct 2024 10:29:03 +0200
Subject: [PATCH v2 10/25] timekeeping: Define a struct type for tk_core to
 make it reusable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-10-554456a44a15@linutronix.de>
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

The struct tk_core uses is not reusable. As long as there is only a single
timekeeper, this is not a problem. But when the timekeeper infrastructure
will be reused for per ptp clock timekeepers, an explicit struct type is
required.

Define struct tk_data as explicit struct type for tk_core.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 8557d32e5e3d..40c60bb88416 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -45,12 +45,14 @@ enum timekeeping_adv_mode {
  * The most important data for readout fits into a single 64 byte
  * cache line.
  */
-static struct {
+struct tk_data {
 	seqcount_raw_spinlock_t	seq;
 	struct timekeeper	timekeeper;
 	struct timekeeper	shadow_timekeeper;
 	raw_spinlock_t		lock;
-} tk_core ____cacheline_aligned;
+} ____cacheline_aligned;
+
+static struct tk_data tk_core;
 
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;

-- 
2.39.5


