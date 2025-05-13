Return-Path: <netdev+bounces-190185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86791AB582B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76281B4510A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D4E2BDC18;
	Tue, 13 May 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4sRbRDjw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7xJuSwhI"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E2B482F2;
	Tue, 13 May 2025 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149180; cv=none; b=q4aFJqbKQO2on36QGDHs5Iq8TkeYFjXumyFtOGkRz7CyJh8ULrdSle/eY64R8Cq07JhdLkpX1Jvi6aQa9MnfpX5SxsAMU0AKBupuaLNEqbDK6HX//F8dhRgwyQZLNqUze838XQSYmZlgGrCQplei2m89tvpNAgoAHxVUfxxrlfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149180; c=relaxed/simple;
	bh=H5LZ7r0BO9UJwvNwXDzJW1WeWZKHWrNuAEaUA+3FKfU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=MZxWzsEcayEGoGw129/uzgYICCzmQh9N/AMftx8tnWwr34sZCjcXZKiLmwY07oHcOlmfQ4bP7cH1TymD5ORp5m9TVpB9hmtsDIzVncrXrMVxfUcnm3HakTxsdTpWuC6gWRNmCtqwlzovjb/ZHbLihVdUNBjm70bU4T39hAjAGv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4sRbRDjw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7xJuSwhI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145136.727753386@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=L4D9JRJvf/qDRslz7xOrYCaTiKUlQohZZE5tQ+PqCuE=;
	b=4sRbRDjwLBjc1LgNoaU+koDAO+LMPs+JW3T8zfOQU+TdG7MB+nORvZqRIIaz22YdE/Csbw
	GSsGoaFtD6XTFd3/R9624Fm4ot92aSLejXTDEKwZjE2m1bfPl6A7VWbPJuc+U+h1C0S454
	dnqBvcsds45v7G4F78W2MoA6LYww97y9Kc9tpYdkJ3FCXTPmgStIHxMt3Ov4xpsPt/yvUW
	N3F9ry4OG0DWmS+vxxxcYhnfDTn9GlK/MNzcCcL1S/SZT/ZmcvxTX78srFtPnNwDzyrQVX
	v7OqS5tqk9R7AijIrIgLJ8d8AuEWkQKqVfgpFZteLTWmsYU6XFbu0jLDZHIFfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=L4D9JRJvf/qDRslz7xOrYCaTiKUlQohZZE5tQ+PqCuE=;
	b=7xJuSwhImgbI69OMvECaVten+kRz29lrT3K6fzgNrJfL5/RbZBm04LoKsvMDJtUs3u+jdd
	k2pCkbNcvN+gyZDw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
 David Zage <david.zage@intel.com>,
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
 Alex Gieringer <gieri@linutronix.de>
Subject: [patch 01/26] timekeeping: Remove hardcoded access to tk_core
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:12:56 +0200 (CEST)

This was overlooked in the initial conversion. Use the provided pointer to
access the shadow timekeeper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/timekeeping.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -663,7 +663,7 @@ static void timekeeping_restore_shadow(s
 
 static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int action)
 {
-	struct timekeeper *tk = &tk_core.shadow_timekeeper;
+	struct timekeeper *tk = &tkd->shadow_timekeeper;
 
 	lockdep_assert_held(&tkd->lock);
 


