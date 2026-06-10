Return-Path: <netdev+bounces-297709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sSNxCxx0KWpjXAMAu9opvQ
	(envelope-from <netdev+bounces-297709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:26:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD29366A338
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:26:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=RsglTPh3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297709-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297709-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AB833034C7D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175E33264EF;
	Wed, 10 Jun 2026 14:26:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B9426F46F;
	Wed, 10 Jun 2026 14:26:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101582; cv=none; b=Lxq5aP50DFtUUNflG73+8nUSOpc3GPKeb8ej6naDsVrIORNEu5cW2s3/pxGLT5klVFInlnej0MEC0mwP93McIwJ3Xsij3VEcaZWS1PQ6WapoOEGR4RMU9Dtzt2jSoq1adpO8sMiApgjMxIN360i5uvuEqtK4vvbUGedQPFsnJRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101582; c=relaxed/simple;
	bh=SxIcZR5DL6wkuaHVR0EdGoX3yLb5LHiiUVbHxBWmMfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pewwx4Rm4a2s/jet/iK8TWgCtCsrkioEejlQlOyPzVQrfO796PhQj6JhyEryzYmesuZXigbaeXrbWB4lyK7nCRSTlZaFbFh76WvfBrtMd47Vsv9RR+aa4WUeHr/w/WZ/J2Uu7uGJ4R117ThZ6OlZLaBlxhqpE4Q1E+chKwZVXWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=RsglTPh3; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=qXpz3az42DpzkAdgLnMGCIIarhxdnB8K32mfTrVRPng=; b=RsglTPh3dmvpAvxCbQFJZoxiBg
	CLSTOhII5jmM9CYU+mXPIEg6sPfEuC5wSawH/jvkfeI32MTXvcFB1TqrDS9Iv5x6tDVL6cX8hFnKA
	P5YajG0/GsQm6pH6uslaNck0LkWkMBYo60wXeBEUEx6dawz7vwecGOreRpGFf+cTzhd7r71FvABxJ
	XHHoGjFAJgVaVd65cnTB7klC2TIIMDXaAy1AamEJTTZ8ObcvdX3NwREgf0Wu+HMEWJR6fc3oZvCi4
	kZGykpz1Tk9HBLntcLlNqcmp0MXVHghAI9LSKgoOqsPM8vYDEMRUKdidXyXkU4cq23ppZl+iDArxa
	5F4jnFSw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wXJsg-009FfU-2F;
	Wed, 10 Jun 2026 14:26:10 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 10 Jun 2026 07:26:04 -0700
Subject: [PATCH net-next] netconsole: clear cached dev_name on
 resume-window cleanup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-netconsole_fix_more-v1-1-a18652c47cef@debian.org>
X-B4-Tracking: v=1; b=H4sIAPtzKWoC/x3MUQrDIBAFwKvI+46gKUjxKqWEYJ7JQrsWlSKE3
 L3QOcCcaKzChmhOVH6lSVFE4yeDdKy608qGaDC7ObjgnVX2VLSVF5csY3mXSuvvfr0x5BASMRl
 8KrOM//qAslvl6Hhe1w+mwmAfbwAAAA==
X-Change-ID: 20260610-netconsole_fix_more-181a3e6f66ce
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2443; i=leitao@debian.org;
 h=from:subject:message-id; bh=SxIcZR5DL6wkuaHVR0EdGoX3yLb5LHiiUVbHxBWmMfo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqKXP+KPMsyvTsJamYsHoGT7uwkPFzekW8ZItJ4
 52eN5STrZuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCailz/gAKCRA1o5Of/Hh3
 bQQ6EACKPSDbl9HwoV9LOGPuw8ttns9GRaMVL0Sqw4KBlXiMPvWZSB25dcQRB2ZJOHhWb97FBF3
 DLOkKw8tm/NRSAOsYaONaLr4iKtkS3lCxtKl06wGHJgI7tvtXwxOQxKp1HA47DlIzcJCwMTUDs8
 heKeanZj4nYL7dxouh1AvMvrJeAIhdBa1f3/xk2qtsT8afIUteNwZ4jCWnQVBUc6WUB5ahQ8CG5
 j/WKVHFfxncoN4CEyyoGSzVjOsGzOneIyWWKqp38zzuIgBd4oFF8fdgm37EpqrXhDNT7fSNpqGE
 14eS+DvYiHi3NRA2oH8Plif2B+S7ipY5JUy1YynSueZSksJEWFoGkviPdHW4NeWScIbEGLrhbHi
 9vxM/0mk+L3VdAykx4BjXCIY3AmBIj7PGllHR4ONY5h5Murf8EO1diQ9QEv0/QO8zlKVS60c2Hr
 PAYE/W2AlN8GMoUeUPnVREexwnJ+Qa+UdCPo/kf1CvOnQEiT5ovS/vD6OE/+3wiZaAhk+Ezdpni
 DZoPrOe+ySp58/vdl+xbp3UVInuHoQm2CBbg+UiUf/tBvpOphl4MDT5DIFmpFMNFxpxYVMRUBE7
 9fjBzUPyJN8F7lQIRQaqOYsYZrG4357s7VFxGVEGFZ5C/GOCEcSqrB/0gPFi7ddaz7KkWm+NwON
 Qijurx5D0ID2HMA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297709-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:leitao@debian.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD29366A338

When process_resume_target() catches a device that was unregistered
while the target was off target_list, it calls do_netpoll_cleanup() to
release the reference but leaves the cached np.dev_name in place. The
other cleanup path, netconsole_process_cleanups_core(), already wipes
dev_name for MAC-bound targets because the name was only a cache of the
device that last carried the MAC and may no longer match.

The pattern is the same in both spots, so fold it into a small helper
netcons_release_dev() and route both call sites through it. This makes
the resume-window cleanup consistent with the notifier-driven one so a
later enable does not let netpoll_setup() pick a stale interface by name
when the user bound the target by MAC.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 606e265cdfd77..a159cb2939811 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -283,6 +283,13 @@ static bool bound_by_mac(struct netconsole_target *nt)
 	return is_valid_ether_addr(nt->np.dev_mac);
 }
 
+static void netcons_release_dev(struct netconsole_target *nt)
+{
+	do_netpoll_cleanup(&nt->np);
+	if (bound_by_mac(nt))
+		memset(&nt->np.dev_name, 0, IFNAMSIZ);
+}
+
 /* Attempts to resume logging to a deactivated target. */
 static void resume_target(struct netconsole_target *nt)
 {
@@ -349,7 +356,7 @@ static void process_resume_target(struct work_struct *work)
 	rtnl_lock();
 	if (nt->state == STATE_ENABLED && nt->np.dev &&
 	    nt->np.dev->reg_state != NETREG_REGISTERED) {
-		do_netpoll_cleanup(&nt->np);
+		netcons_release_dev(nt);
 		nt->state = STATE_DISABLED;
 	}
 
@@ -408,9 +415,7 @@ static void netconsole_process_cleanups_core(void)
 	list_for_each_entry_safe(nt, tmp, &target_cleanup_list, list) {
 		/* all entries in the cleanup_list needs to be disabled */
 		WARN_ON_ONCE(nt->state == STATE_ENABLED);
-		do_netpoll_cleanup(&nt->np);
-		if (bound_by_mac(nt))
-			memset(&nt->np.dev_name, 0, IFNAMSIZ);
+		netcons_release_dev(nt);
 		/* moved the cleaned target to target_list. Need to hold both
 		 * locks
 		 */

---
base-commit: 5855479abc796c3b5d7b2f2ca147d68fc56cae1f
change-id: 20260610-netconsole_fix_more-181a3e6f66ce

Best regards,
-- 
Breno Leitao <leitao@debian.org>


