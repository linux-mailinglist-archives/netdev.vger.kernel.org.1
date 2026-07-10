Return-Path: <netdev+bounces-306529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +wS4L4HdUGoy6gIAu9opvQ
	(envelope-from <netdev+bounces-306529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:54:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3D173A73F
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:54:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b="WS/aDT0s";
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306529-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306529-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0F083002D00
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C8A41B374;
	Fri, 10 Jul 2026 11:54:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306EF41CB43;
	Fri, 10 Jul 2026 11:54:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684471; cv=none; b=V056i+2jOPJI3ar60yFR0+UbcNYLQSqZ+JgqLeaORKWWD+rxTKbEbi0UXAfMAh7xugFw7fzbhLtkXeGyracWvHqav1p+4vIEuEAX0rrJBWTRJH1MWQuSF/wR/ihqTd30IPSzWW18e9zcyJMBKWArrj8ERlGgq0fuW6LFf2yctRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684471; c=relaxed/simple;
	bh=FrHrWtgVfE58Feh6du91FulP4WKEswSCdpmYM3JxkIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pAyEDyWKqQ1jPyHexOSUJgzoa5eMPedP+saHXR0/Gq+xoxv+9MK+hd5Q0rP59obKTT4wvYM+cn11CFHZuO1SM8Jop/9R4lH34TZRG2Oms/fgk4XUUOeitLjAEjsKR2mDYTs+W4K39MpoPYhgtyI+QNN2vnJlEAhMfPcSL93l4eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=WS/aDT0s; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=xMDAPaptgDk1W5/odzMbgIuEUp9S3c4/7fP44O+s2vM=; b=WS/aDT0sRqgEvLz0UNXXrm2c0k
	cQ81V4Vow9qI+19cYrM9TOu/cMsKfPLd+LUatn5jTJhRSQdqHypCsovshcnbXzvt7p40QWCebHf7V
	dEryG9QKWnbFTg3+2IFZHqoMdOW5vUeXajBrHYwP0ModE9zXvYf9WaVhTQLL2vPXhK7CWMFulVdBb
	Do6nXAJt1qjSAFf8yRDFXXyJ2cZjEFzdsOgtSrOXZGMkrFWO/7YTIfHZWla784VmEtwTIQesAGHSQ
	8VqTKo6NMak+6WBIymD2mV10wys3+bJCJ3umfVnurzv/brU0Igp7ECdNxrpYVFOfCcmM67Ah6OwA/
	apbYhpFw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wi9oC-004SXT-0C;
	Fri, 10 Jul 2026 11:54:20 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 10 Jul 2026 04:38:53 -0700
Subject: [PATCH net-next v3 1/9] netconsole: clean up released targets
 dropped before the cleanup worker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-netconsole_move_more-v3-1-6f63f76b28bc@debian.org>
References: <20260710-netconsole_move_more-v3-0-6f63f76b28bc@debian.org>
In-Reply-To: <20260710-netconsole_move_more-v3-0-6f63f76b28bc@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, asantostc@gmail.com, gustavold@gmail.com, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=1855; i=leitao@debian.org;
 h=from:subject:message-id; bh=FrHrWtgVfE58Feh6du91FulP4WKEswSCdpmYM3JxkIU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqUN1j2raR2AuzZH3+BiTSCbZCGUz7sCYdiB9eu
 5/BHjx2QMyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCalDdYwAKCRA1o5Of/Hh3
 bVPYD/wI9YuySwYfil4Xgr10aGR1nibWiWVwGXlRX6UmS7FkSP1umBGo7UT+tUG1ZbNRLXUx1wh
 JF5W30wDXDyG0krYS1uCft0rUo9sKM/DQmgN9PNDZGVB1NKW2tlAbpi9POGpMsdj0/gp065a663
 WJDLyZnFAXCajiAO+5M7zrO67/rcVa4koPInZrx7n5oOCtNRwz9bJYqN5OFmcmuHstZDHBxoqS5
 4TqudBDVOQ8jAIN++zdCI0U5bkb0AFuEDSHiP6riMONp52EXxeGs0Y4hK7Cgh6zw5vN9tuhMO0G
 6Z0rXMoU331PSatN0iH7q3iNb46hu569G2WhgyNlLoj5c7yT0DKAvxoTTV68ocrhkPsWvO42x+m
 tFwGqwaGRn3nzh1LlvCPSzb0wVMa6qxjtkDqRgwpEacDL4Vjm5HMBfmERdvawsqYi7ENsbzMKmM
 qnZk8zsMIvmjjACJqC3dXX1wEEKVKHr6nUJTuF4z2EaYKvzD+Lh4ISw+gltUNQm0SrCbi0bQfOq
 sXo/L1tkdNi76AWXpJJfiiJmbdtiLS9rovEs9poZFT+dMrlC6rN3qrd+ImX/2fNSIYC5M2a+9ft
 ufiCs6jGmg7h6lwM0Yv62XcNb1Fco0NFWWltM8/DWT1GesW43bo63SbNkSRQ3UofDEz90JGvO2o
 jd0qh6mt59SgtgA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306529-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:linux-kernel@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D3D173A73F

drop_netconsole_target() might eventually tear down a target that
netconsole_netdev_event() had moved to target_cleanup_list but that
netconsole_process_cleanups_core() had not processed yet.

Always cleanup devices that eventually have a device attached to the
target, independent of the state.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index c1812a98365b7..a939daa07cf9d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1481,15 +1481,15 @@ static void drop_netconsole_target(struct config_group *group,
 
 	mutex_lock(&target_cleanup_list_lock);
 	spin_lock_irqsave(&target_list_lock, flags);
-	/* A STATE_DEACTIVATED target may have been moved to
-	 * target_cleanup_list by netconsole_netdev_event() but not yet
-	 * processed by netconsole_process_cleanups_core(). Unlinking it below
-	 * hides it from the cleanup worker, so this path has to clean it up
-	 * itself. Record that the target still owns a netpoll before the
-	 * state is downgraded.
+	/* A target moved to target_cleanup_list by netconsole_netdev_event()
+	 * but not yet processed still owns a netpoll; unlinking it below hides
+	 * it from the cleanup worker, so this path must tear it down itself.
+	 * This covers NETDEV_UNREGISTER (STATE_DEACTIVATED) and
+	 * NETDEV_RELEASE / NETDEV_JOIN (STATE_DISABLED); key off nt->np.dev,
+	 * which stays set until the netpoll is cleaned up.
 	 */
 	needs_cleanup = nt->state == STATE_ENABLED ||
-			nt->state == STATE_DEACTIVATED;
+			nt->state == STATE_DEACTIVATED || nt->np.dev;
 	/* Disable deactivated target to prevent races between resume attempt
 	 * and target removal.
 	 */

-- 
2.53.0-Meta


