Return-Path: <netdev+bounces-300493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uP0RHrsbNGrjOgYAu9opvQ
	(envelope-from <netdev+bounces-300493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 18:24:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E80F86A1943
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 18:24:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DV1C2OE7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=H4I+QKWz;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DV1C2OE7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=H4I+QKWz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300493-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300493-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDDED305331F
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 16:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5582C31986C;
	Thu, 18 Jun 2026 16:23:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09706280A56
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 16:23:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799789; cv=none; b=A28T68j9Xi4cZ3jsizQLesxjNTkl0C48gJkovZLYIR7ckLZyKHZmEJnkYkfSunsKHP29f0wb0i2S3F/cX6KnUO0XCtS/jA4lJVtuuhewaPaaI6yBQc+VP/kqkbvZxo32qe644LUeE9pyubFCm/zjmWICn1ec96JWSGaTJHHvXqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799789; c=relaxed/simple;
	bh=4WhCRS5axusw9dVNdmGWUbo3u8ZT3CKzKFnejCu/JXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLtTtq7+d31009K7kiMKMSslGRg/PCCJfsqsbybi+vvHK4u9ckw+n+uzrTIhLYKm8YLGa2PbKoYMmSIEKIXziMkOVytVd5G0BPqOys+R1iO1fSoacaNSvzo295o7EgBICQ2Ra6HPpSAbJYhag59kFuorU5HIQxR4kqPd0vttAQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DV1C2OE7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H4I+QKWz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DV1C2OE7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H4I+QKWz; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 292386D48F;
	Thu, 18 Jun 2026 16:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781799769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdVCpO9l/cJDRHtLIiGAm/LW80i6Ba8q//bfIyGGZGs=;
	b=DV1C2OE7VGp3+jZ/+42In17UvSLuy0gsBnFA6Pp5TA6okWZvrwF7k7QLLpa/oZsho53iZF
	w/TN2FyWuEpCPQxfMELE1ELplOukDeyPcktAGVjbpjyw4QXfwHoX0KA0dX20nQZhrMGIe7
	Tfabxum/2Y121a1XyI4vEt+0puArVQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781799769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdVCpO9l/cJDRHtLIiGAm/LW80i6Ba8q//bfIyGGZGs=;
	b=H4I+QKWzeo0cBrqSyLs6+0gjyxgoBhHudq0nbVvRXXnt1x31PUTb5jDmVuliGMc628smdJ
	pfYjNcfjepaVh/Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781799769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdVCpO9l/cJDRHtLIiGAm/LW80i6Ba8q//bfIyGGZGs=;
	b=DV1C2OE7VGp3+jZ/+42In17UvSLuy0gsBnFA6Pp5TA6okWZvrwF7k7QLLpa/oZsho53iZF
	w/TN2FyWuEpCPQxfMELE1ELplOukDeyPcktAGVjbpjyw4QXfwHoX0KA0dX20nQZhrMGIe7
	Tfabxum/2Y121a1XyI4vEt+0puArVQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781799769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdVCpO9l/cJDRHtLIiGAm/LW80i6Ba8q//bfIyGGZGs=;
	b=H4I+QKWzeo0cBrqSyLs6+0gjyxgoBhHudq0nbVvRXXnt1x31PUTb5jDmVuliGMc628smdJ
	pfYjNcfjepaVh/Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B618779A8;
	Thu, 18 Jun 2026 16:22:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8FF3D1gbNGqCDgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 18 Jun 2026 16:22:48 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: nicolas.dichtel@6wind.com,
	shemminger@vyatta.com,
	dforster@brocade.com,
	gospo@cumulusnetworks.com,
	ddutt@cumulusnetworks.com,
	brian.haley@hp.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	idosch@nvidia.com,
	dsahern@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net 5/6] ipv6: reset value and position for proxy_ndp sysctl restart
Date: Thu, 18 Jun 2026 18:22:24 +0200
Message-ID: <20260618162225.4588-6-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260618162225.4588-1-fmancera@suse.de>
References: <20260618162225.4588-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300493-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:nicolas.dichtel@6wind.com,m:shemminger@vyatta.com,m:dforster@brocade.com,m:gospo@cumulusnetworks.com,m:ddutt@cumulusnetworks.com,m:brian.haley@hp.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,m:fmancera@suse.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E80F86A1943

When handling proxy_ndp, if rtnl_net_trylock() fails, the operation is
retried but as the value was already modified by the initial
proc_dointvec() call, the restarted syscall will read the newly modified
value as the 'old' state.

Fix this by restoring the original value and position pointer before
restarting the syscall.

Fixes: c92d5491a6d9 ("netconf: add support for IPv6 proxy_ndp")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv6/addrconf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 8ff015975e27..1cfb223476bd 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6483,8 +6483,9 @@ static int addrconf_sysctl_proxy_ndp(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = ctl->data;
-	int ret;
+	loff_t pos = *ppos;
 	int old, new;
+	int ret;
 
 	old = *valp;
 	ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
@@ -6493,8 +6494,12 @@ static int addrconf_sysctl_proxy_ndp(const struct ctl_table *ctl, int write,
 	if (write && old != new) {
 		struct net *net = ctl->extra2;
 
-		if (!rtnl_net_trylock(net))
+		if (!rtnl_net_trylock(net)) {
+			/* Restore the original values before restarting */
+			*valp = old;
+			*ppos = pos;
 			return restart_syscall();
+		}
 
 		if (valp == &net->ipv6.devconf_dflt->proxy_ndp) {
 			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
-- 
2.54.0


