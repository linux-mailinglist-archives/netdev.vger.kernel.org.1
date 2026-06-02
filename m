Return-Path: <netdev+bounces-294256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U9C2MGzrHmpoZAAAu9opvQ
	(envelope-from <netdev+bounces-294256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:40:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 440DD62F5DD
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:40:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=EhBGFvdc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294256-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294256-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E850531C8F90
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 14:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD6540243A;
	Tue,  2 Jun 2026 14:27:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6E03ED125;
	Tue,  2 Jun 2026 14:27:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410446; cv=none; b=awW88qwMx1VKLFbGDG4UNK127j8zfRzddwN3T9hcOAosFpp57LRmhkfKGaFKSq6lBTCAAaJXouAK2EXU7ga2fhMyTW6aCliSAdfdrWx1s/7FD6bobDw+KFgjvVEK9C0/rgwz1UxLCKdiljP74Zyd+BqFzj0q1ebIykM4CF50Bu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410446; c=relaxed/simple;
	bh=a8OZ0VQVcVqKMElz4At9zliiyj4sQ7kpQY6cjBx99mI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OQG0eLDFbO+SIv5k/iGiWtsbnH+dl7VvXr0iRH4gW8iE9lu5oiDK/KaS9lsXecjpUdeTCsgBCJIByJqil3IM/IfTQdPCxMGLWQVHXpJcuPjzm1yqYtd1EbrgN447MfylCYLD/bnwTnL6hk+xLmGnN7e19orRmVd8tvDh46Ti2mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=EhBGFvdc; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=nsiVq/97Wtoja7S6snhY2IWdkOS5E9msHwXR3VbmBXE=; b=EhBGFvdcH2cIXgUVWRKtrcACxt
	RUVCRG/cZ16P9Xh4H07VpOo1NiU6skiH/ScqpmELivnt5eIBT6PdPFFE/XXrK0jKmZ1nB1fXdsZS2
	7NBSYAfN79mwtNFYnnPVRUJIxKmMHcKuIvHXu3iih4jhdvOQCWk6V9qWcIDiV765CiDgIgzICLnhk
	g6vlD6UYTnMi3RnYBUqedQPx9IykAtHXdkbB2KYIa/0d+/Hls6G2B0zXlDRGux5dIjbTmwXaAeSBd
	sHBoebZTp9GeCsAXm2wi+hrcqBdRmWwvMF+Ttt5gqv6JTtVXAawYzB5u+fty6ZeyHcwitc1fe/vX7
	Qn53puiA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wUQ5T-0031Hp-1F;
	Tue, 02 Jun 2026 14:27:23 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 02 Jun 2026 07:26:59 -0700
Subject: [PATCH net-next v2 3/3] netconsole: take target_cleanup_list_lock
 in drop_netconsole_target()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-netcons_fix_before_move-v2-3-eca3f8a8b1a3@debian.org>
References: <20260602-netcons_fix_before_move-v2-0-eca3f8a8b1a3@debian.org>
In-Reply-To: <20260602-netcons_fix_before_move-v2-0-eca3f8a8b1a3@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1848; i=leitao@debian.org;
 h=from:subject:message-id; bh=a8OZ0VQVcVqKMElz4At9zliiyj4sQ7kpQY6cjBx99mI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqHug5b/5U4hO7R8o4Sw0W7DUzAbVrflugwjEXN
 TEi4BwG07CJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCah7oOQAKCRA1o5Of/Hh3
 bXmZD/9gOS3rd9opE5NRUnGkVYintgTLZJVtxkSGysjiwnGLvP6GMCzxiJ+fA1AdKqJKjM7zS/C
 WQXsgGgI0dxQzgurs0xzNLceltrG3AfYO9WxL+QJ60vm3R6s8qrf89a8SrHOwPzhIxeBVcGnjB2
 kecRuA1zfXqb7ZV6qQjzQeAnmnmqdhWbogPzMvfeDGFk6oHJ0sKfwl5mIzwHyGlN1MJ0rrIdmuC
 DqETVec2l5T0SbkRlUb/uBvHzGYwdjHPYCxUlYp7en412hM5fp5wX+IuyIklajSOCsqyoJvoxsu
 nyz4kSiTRUIIbVZjRW2SS3e6SlNKJZUMCeAIzbEO2j9U/QIfXjOO5iGBuEuxpXrGjpqhzwE3p+t
 spwaO71H2tu+sQUBHNuBjvAI15Rz8OXoTV7RX4TK15BhrFBJ780nY2sz5ze7pYCeYluRTgZd8G0
 SjG+zcPswu+ujrcBqxsBTv4D+1wHRkwyAw7jDEwcb2UksegAlimnkQ+9rSyxd62dJnzYHkxE00F
 R5lrFMDKvIiutBQQ45wj2COnS2qjgn9MQVWZby4wtGsPivkIheGuAnFJ4Cm0jbbokuwjMdy/clV
 NKMemA+B2Li/yA2ZkieSpW9nbvjcZRVLy3u/maUqDFHes5ENmPqDmOGHhT77UeXNGZbcGd0wbtg
 chl56ibKYoUF2wg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294256-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 440DD62F5DD

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
index b77879ead641..59712d1d75fd 100644
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
2.54.0


