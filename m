Return-Path: <netdev+bounces-295328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bwhcL7enIWrMKgEAu9opvQ
	(envelope-from <netdev+bounces-295328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:28:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B65B6641D67
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:28:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=Z1bqRZA5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295328-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295328-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA6963080E21
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C44A47CC83;
	Thu,  4 Jun 2026 16:10:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D144847D959;
	Thu,  4 Jun 2026 16:10:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589453; cv=none; b=T1VxfkojeZm8tNSrurD5ehQc//NFk9Qg949b+/6hWCsk9v4ls/utlidT+jdKt5Hq5SitofSAtZuiqPDKKijY01OBU/KDLLxspbUSprplvr89F/RAx7sDw1H6NJZ0HKfdJNZ+NqipbebVwvAVTpmLRsBRX0MzCKsn6904A5nVe8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589453; c=relaxed/simple;
	bh=YaN4a7w2amMQzJRoGcsAWVnJA3MY2r7yAmdHp90h8cI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ujhn+UluHFFBG1vqpWzNZv/1wQOs3cvgPBHP5h57MeBpJdg0ZNpU9Pkf2HKjglQUpuO3x73lM+0UwKtvvuNK0NfRYYbMfsaiO3NSZWjMmBypakOrlPxIF4lhzOtZ4n3ZCRbguTsv74q+gtHBvCpEzVSKUwC171LzFggFS8KfjmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Z1bqRZA5; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=O2sFf1rMAObxsHbRdptfxA5iNeX8K8Ii825MHDg3280=; b=Z1bqRZA5yjBpInSaiTz0tSJ2Av
	XeADzE0MBS8tNFqd2iO+nz0sDh2oOtjVcsfXVUNPbRZ7beHscWmOrGK6GqjU5XMMHSQNxXP4AUblm
	xikesjbPOIZdrk/XVWaq9AtZS4ie83lXp7J7EtUj5yI7IWvP1mTsN2Q/RjSPiz13j/GaZ+YBm/JNm
	ye6ZeGVXv8JZ3hUfcc7q4AUVDWWH4dwdH+Wa5Ke6CdWW0f2Mj9Pxaczf3ZkqVRLvdTIVqY/ytEBbT
	7+XB6Qqd1JXdca82U1qAwsulboeOWgM1hC8VV7L89vQOv/tsCKShpKVSUQ9virUb69qXO18qMwgpr
	lycctKvA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wVAec-004dOF-0w;
	Thu, 04 Jun 2026 16:10:46 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 04 Jun 2026 09:10:12 -0700
Subject: [PATCH net-next v3 3/5] netconsole: take target_cleanup_list_lock
 in drop_netconsole_target()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-netcons_fix_before_move-v3-3-ab055b3a6aa5@debian.org>
References: <20260604-netcons_fix_before_move-v3-0-ab055b3a6aa5@debian.org>
In-Reply-To: <20260604-netcons_fix_before_move-v3-0-ab055b3a6aa5@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1853; i=leitao@debian.org;
 h=from:subject:message-id; bh=YaN4a7w2amMQzJRoGcsAWVnJA3MY2r7yAmdHp90h8cI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqIaN1rqG01i4P6/gJ+baqEG8ngK9TNKNaYmNtY
 agwhv4dusGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiGjdQAKCRA1o5Of/Hh3
 bc12EACqTP2l998VnxSVrW064Jto7lJX06ceb3lazJ5GkhnUySkAZwUEKPgFJKIhoXwP7mBbKgU
 80kvpd6HMWOKlhl91RxS6+Ps7dn8+Uky2UoRVNTrMv6q2E8Uk3LxfpjR0I+FcivHHkK4LHfJ5T6
 lyRmJ9oFX6TuqhiKfRHwdgv13T5wR9LqFEpyM57WkxV1qFNtBUAJV533SO7tpYtxBUhJVFc/t/W
 P8D7JqzlZmRjNhRfnkmL5qYd/BheZ1oerr9/IzF1Fx2E/Wp/KxpRBOPiYWUFvAmbgMtelFaYsOU
 4d+tJesxL4vU5td9aNUHYprjAQc6zG1Dib4B38JkfiWRzorWGQ0MOpIURghtz5ryl4gvzhF/tjc
 G0hA4SEuYqAuqJLmWRsr5d/VMfsNWcHcMSn9Tj1pdBIYvtlLAGHUHcOrqv1AsgIy2EpPqdzhseM
 3TsYBVyby3JMxcmCQiS46oFV8kF2K35TdxFlztbR+Ge1TlsWCHqgAEWl0n1TDuCNFFjFTHswv/W
 BfLTSx0e3QIpjzYVKfHBPeI7aeRgGgk/FmdQl3KnaH27Qk8ODE+rMJSVeLl+h4TVHIvW+QJ7EO3
 djVM2C4LPnWwOluz5bIXmkcUHpEFQtJ9y21XU18XLpBbueALGuU9/84jn4Mv2ZTwkXpPfzeIbdy
 qVHnHyhaceOulYw==
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
	TAGGED_FROM(0.00)[bounces-295328-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B65B6641D67

drop_netconsole_target() unlinks the target while only holding
target_list_lock. However, when the underlying interface has been
unregistered, netconsole_netdev_event() moves the target from
target_list to target_cleanup_list, and netconsole_process_cleanups_core()
walks that list under target_cleanup_list_lock only.

If a user removes the configfs target at the same time the cleanup
worker is iterating target_cleanup_list, list_del() can corrupt the list
because the two paths take disjoint locks while operating on the same
list node.

Acquire target_cleanup_list_lock around the list_del() so the unlink is
serialised against netconsole_process_cleanups_core() regardless of
which list the target currently belongs to. The state transition that
downgrades STATE_DEACTIVATED to STATE_DISABLED is left intact and is
performed under the same combined locking, preserving the existing
ordering with resume_target().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 58250e648f8b..d8be2fef3826 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1452,6 +1452,7 @@ static void drop_netconsole_target(struct config_group *group,
 
 	dynamic_netconsole_mutex_lock();
 
+	mutex_lock(&target_cleanup_list_lock);
 	spin_lock_irqsave(&target_list_lock, flags);
 	/* Disable deactivated target to prevent races between resume attempt
 	 * and target removal.
@@ -1460,6 +1461,7 @@ static void drop_netconsole_target(struct config_group *group,
 		nt->state = STATE_DISABLED;
 	list_del(&nt->list);
 	spin_unlock_irqrestore(&target_list_lock, flags);
+	mutex_unlock(&target_cleanup_list_lock);
 
 	dynamic_netconsole_mutex_unlock();
 

-- 
2.53.0-Meta


