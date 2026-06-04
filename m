Return-Path: <netdev+bounces-295330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +UyQKJGoIWoFKwEAu9opvQ
	(envelope-from <netdev+bounces-295330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:32:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4AA641DB2
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:32:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=quVtbSPw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295330-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295330-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79F9D30BEAC5
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B8D47DD53;
	Thu,  4 Jun 2026 16:11:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7613A48034C;
	Thu,  4 Jun 2026 16:10:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589460; cv=none; b=FiRMFhp06gIBolqD7S6KPaPn1/l2aKbvHcEH7qsG5PsxVSu4RBFwBuGgPwipTIS9uHVk1Ynv1/hHEbR1RuB2bSSmVW6JM5Ki59VH/L1Q9PGEkwU1SmQYoIKist0lR2rKnlN0hySlv5/TkJB/vZNCilylxQ1Lbg18hzXgMPiaWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589460; c=relaxed/simple;
	bh=7Bc2K2DonWTFN4PGky2us44y6fK41MOJLm0kSTR/pI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gsGggSiZYUmVzI0HkLGUYzeKI3xn+xmx+ltvsLSVqpAO5IFbMUDL9hr0gP22BydSeGi2A4KHUB+tqY/UY1KfSOSsebL+uFlAiLiRGIN0t3q8qrdnX9tcHstDPEPsWFegXUvnLh4AahO3uJDIH2rxKPmHFtE0Z7PZ8XkqBQzoEJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=quVtbSPw; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=NIaVfAeJGnzMWaDGjE2J9kNzpNCDQ8Uzp0cqm+Ii8SQ=; b=quVtbSPwpOVWrkMbm5hJ9dXC+P
	s4oOA/z2+mcN7pF4ap28eLE40CzZIm4YDvW3vZXqCFR3eX8vQHHW7tLosmxtCtqhGTrK1jvJwKqHu
	0ypEthgRtkAPqCVpq7yPGdu4udyl+NYTOwBhS5PJkodcaHM18xs3aMpx1pO55MzaOpzQEDCyC+zR9
	pPFQ1Rt+65RVif8Wj84EO2OlRf0hqjKlXtMi2DGu3IHMaiRLay5do2ALWNZDlSjJmdLAopJ/tuU4S
	Mci+uEHfEN/1psr0FYzU7F3fVY6lRDzYd57j2XkMJ3RZ1pc/Bzl8NVVzNHHHfLSx12gmlTLvRTivR
	Kfnh4H3g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wVAej-004dOs-2l;
	Thu, 04 Jun 2026 16:10:54 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 04 Jun 2026 09:10:14 -0700
Subject: [PATCH net-next v3 5/5] netconsole: close netdevice unregister
 window during target resume
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-netcons_fix_before_move-v3-5-ab055b3a6aa5@debian.org>
References: <20260604-netcons_fix_before_move-v3-0-ab055b3a6aa5@debian.org>
In-Reply-To: <20260604-netcons_fix_before_move-v3-0-ab055b3a6aa5@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3162; i=leitao@debian.org;
 h=from:subject:message-id; bh=7Bc2K2DonWTFN4PGky2us44y6fK41MOJLm0kSTR/pI8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqIaN1i6mYANyiL1dETt0YZdXZV0klC/mVyUxJ4
 0kkTL8tORuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiGjdQAKCRA1o5Of/Hh3
 bVhtD/9eEj3DNjnOPIfmMWx4yKHxkWfcFGBL9rb0ECgfC8bP3dWR3D6Of/MDMoch3FOe7tLomOf
 c6x2FrvwZkchjqMAd0TX5v2mk0jAy05ZUPdlpp5ThaK3KSvSijVHNQxnrD/TtYNyWTjRRi/8JiW
 0GkozePPRVJHqmEk17qt7UIbTPLH7PqpXcvVOVyVihySyFy+5brK+R6jleYe/JhOs1YNf08fj1d
 hVUUE61+fLmOh6n7wWF2XgPxNryQQfzJC+41q409s1lt2khn+vIZ7GDY06czPxXZfAkWTBqE6Kf
 kMk+gHCMt8sLcVN7uqjFycFxXR7Dh4ZoU1PI5ecZnDbJY/RZI09vCFgUVz6CyP5/8CtTFgOiOtJ
 2AOhXVzVz8VoUuXnYT3oJusQY2QCItrgyFV5HbqkH6d+Z1PVPh+0BpHetdRmpCQeNQnY0cdKUjs
 4y0B50IVhmSdE/fWNiIogkh5+lOE2N7lJgVdZ/2CN9T2yhzU4zlqgx8BodaML/gA5KGZ+bX320f
 qZWtJVqlZqFnxUfb072R6Vo7IZPfJyMTHpNu6REV1rHhXWwSaq2Am8CywY4+2QcB49WVB1yPpUo
 MlNiyQrHU7y2x+7an3Axx0xSX2NaQ04y3nSE+Sud4DUYpiLCn1DLp3dcuJ2iP2P+f+6Jpydmh/r
 oA9i1EbJh3Y5BTQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295330-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD4AA641DB2

process_resume_target() removes the target from target_list before
calling resume_target() so that netpoll_setup() can run with interrupts
enabled, then re-adds it once setup completes. netpoll_setup() acquires a
net_device reference (netdev_hold()) and releases the RTNL before
returning.

While the target is off target_list and the RTNL is not held,
netconsole_netdev_event() cannot find it. If the egress device is
unregistered in that window, the NETDEV_UNREGISTER notifier walks
target_list, misses the resuming target, and never tears it down. The
target is then re-added in STATE_ENABLED still holding a reference to the
now-unregistered device, leaking it and hanging unregister_netdevice() in
netdev_wait_allrefs().

Re-check under RTNL before re-publishing the target: if the device left
NETREG_REGISTERED while we were off the list, run do_netpoll_cleanup() and
mark the target disabled. Taking the RTNL across the check and the
list_add() serialises against the NETDEV_UNREGISTER notifier, which also
runs under RTNL, so the device is either still registered (and the
notifier will find the re-added target later) or already unregistering
(and we drop the reference here). netdev_wait_allrefs() runs from
netdev_run_todo() outside the RTNL, so dropping the reference here cannot
deadlock against the pending unregister.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 80c5393ffa1c..606e265cdfd7 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -335,6 +335,24 @@ static void process_resume_target(struct work_struct *work)
 
 	resume_target(nt);
 
+	/* netpoll_setup() took a net_device reference and dropped the RTNL
+	 * before returning, all while this target was off target_list and
+	 * thus invisible to netconsole_netdev_event(). If the device was
+	 * unregistered in that window the NETDEV_UNREGISTER notifier could not
+	 * tear this target down, which would leak the reference and hang
+	 * unregister_netdevice(). Re-check under the RTNL before re-publishing:
+	 * taking it across the check and the list_add() serialises against the
+	 * notifier (which also runs under the RTNL), so the device is either
+	 * still registered (the notifier will find the re-added target) or
+	 * already unregistering (we drop the reference here).
+	 */
+	rtnl_lock();
+	if (nt->state == STATE_ENABLED && nt->np.dev &&
+	    nt->np.dev->reg_state != NETREG_REGISTERED) {
+		do_netpoll_cleanup(&nt->np);
+		nt->state = STATE_DISABLED;
+	}
+
 	/* At this point the target is either enabled or disabled and
 	 * was cleaned up before getting deactivated. Either way, add it
 	 * back to target list.
@@ -342,6 +360,7 @@ static void process_resume_target(struct work_struct *work)
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_add(&nt->list, &target_list);
 	spin_unlock_irqrestore(&target_list_lock, flags);
+	rtnl_unlock();
 
 out_unlock:
 	dynamic_netconsole_mutex_unlock();

-- 
2.53.0-Meta


