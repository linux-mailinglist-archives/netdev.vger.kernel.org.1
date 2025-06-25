Return-Path: <netdev+bounces-201299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C13EAE8CB2
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148987B6967
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE0A2E0B53;
	Wed, 25 Jun 2025 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SLiwMDXN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XKye40fo"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855232D9EC8;
	Wed, 25 Jun 2025 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876726; cv=none; b=o4E/qIm3jQgSVuGnRTN5KTNwC2rRyOr/41OFubucK2Jfa9as8bOi5y8mbnj/yLhVDGLGBLgOPO6MmtbHZwbTAcEaFgLs3hV+u+OUaGteRuaoan06oIaGxGe5Gy6HDUiNW4o0iHQq7a3iKrEV8gVQxZAOLJjMP1kSXQNblMQnv00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876726; c=relaxed/simple;
	bh=rB/EnRxu0imXWgJA4w5Gjj1lvQ8UbNidQsMiPmpllUs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=PoaLGIUJQGSNInmoYGu4x2PX9DcPmptRhuK66ikLKzyha8xfrzw7LToSoIbH6eSilwS8Gci7Y2jM+YX33c0fLtGrahQ0+0nZOk5swl2mxntj9gq+786DLFo2S9e/h1Jf+XFxk8d7Q0Ge4r6W6HVC9W5xcPb9JqZb55GDaOb7u3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SLiwMDXN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XKye40fo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625183758.124057787@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750876722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=YIM8V9tSBfvx2tx7O5vH1ndpneATAeuGOg9AVw4OPCY=;
	b=SLiwMDXNYxOSbLg3LTR1W6VGgeWl07lp2xbixAQDEfiP0yzIKwcEfkoPAYlabAg4X1SB4H
	+hCP82/SXUysVe/pcJikTa7Jb3ZQY46R26dRE6qCCEYIwNYzFjSezJ5eW0k+E71jP6uZ56
	3ZaYAWKAzG774kvPj1szKapjCMd/znDcTnFpJ4vD6K2wjvkFyTZ8sRpJr5UwdhzZzUX5nW
	XlCN8Yu2DgMX3UO7FlB8B4lIyt5fk/07kyuBl/MaDSzfHu/8mSMrbTN222YD2ZAE3hY1vc
	8m6bM/mFs+sybrCXUTFoDOD/iJKd+c8XC/s7rTCpCQPvrOIcVw0APUjJBmC/JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750876722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=YIM8V9tSBfvx2tx7O5vH1ndpneATAeuGOg9AVw4OPCY=;
	b=XKye40fo0BAtIXJHCtw83SIPTg/qPIKugqQfj40FvHx0i5mUROzXYTzedXO4GrOvmIdmTV
	pSnZMUl/1So7p7Dw==
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
Subject: [patch V3 06/11] timekeeping: Add auxiliary clock support to
 __timekeeping_inject_offset()
References: <20250625182951.587377878@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 20:38:42 +0200 (CEST)

Redirect the relative offset adjustment to the auxiliary clock offset
instead of modifying CLOCK_REALTIME, which has no meaning in context of
these clocks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)
---

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1448,16 +1448,34 @@ static int __timekeeping_inject_offset(s
 
 	timekeeping_forward_now(tks);
 
-	/* Make sure the proposed value is valid */
-	tmp = timespec64_add(tk_xtime(tks), *ts);
-	if (timespec64_compare(&tks->wall_to_monotonic, ts) > 0 ||
-	    !timespec64_valid_settod(&tmp)) {
-		timekeeping_restore_shadow(tkd);
-		return -EINVAL;
+	if (!IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS) || tks->id == TIMEKEEPER_CORE) {
+		/* Make sure the proposed value is valid */
+		tmp = timespec64_add(tk_xtime(tks), *ts);
+		if (timespec64_compare(&tks->wall_to_monotonic, ts) > 0 ||
+		    !timespec64_valid_settod(&tmp)) {
+			timekeeping_restore_shadow(tkd);
+			return -EINVAL;
+		}
+
+		tk_xtime_add(tks, ts);
+		tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, *ts));
+	} else {
+		struct tk_read_base *tkr_mono = &tks->tkr_mono;
+		ktime_t now, offs;
+
+		/* Get the current time */
+		now = ktime_add_ns(tkr_mono->base, timekeeping_get_ns(tkr_mono));
+		/* Add the relative offset change */
+		offs = ktime_add(tks->offs_aux, timespec64_to_ktime(*ts));
+
+		/* Prevent that the resulting time becomes negative */
+		if (ktime_add(now, offs) < 0) {
+			timekeeping_restore_shadow(tkd);
+			return -EINVAL;
+		}
+		tks->offs_aux = offs;
 	}
 
-	tk_xtime_add(tks, ts);
-	tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, *ts));
 	timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
 	return 0;
 }




