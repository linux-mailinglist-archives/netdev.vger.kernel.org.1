Return-Path: <netdev+bounces-302599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qNCyLEBdQmoK5gkAu9opvQ
	(envelope-from <netdev+bounces-302599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:55:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A0D6D9B13
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:55:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=hCQVAKxB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302599-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302599-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFCE130914D3
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A543FE35A;
	Mon, 29 Jun 2026 11:45:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFBD40D581;
	Mon, 29 Jun 2026 11:45:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782733558; cv=none; b=nn1DPZXIm80PlVzpSXjAv7zAdM9OdaI9CZOJYTSuQ3IwomHw//voGc/WkWN3RjZVS7PNSpY0vsNMmUyg+JdAaW+imY1EuqjRXR/16OP2v/J3zdweP2q7xp4w7dQJaIxzv38C+XgwMC7dZLHZz+fwMiXY6BAYUT3nPisdgOBS6UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782733558; c=relaxed/simple;
	bh=UgICwQZXtIMsKIwAp/Fncd6qUNestULQCTQ9VgU7DR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dcK9CoqQ3zEhfLmMAehv57+apS/uE1gzfOSDA4R6RPpzQ4URfYztUQ8dyaRIvuiPtcvLAcPSgHYuJck3M0mPVyqDisREhan+qlTrpDbKPtJ6HTwbbnsUE4MKTLx2Wwz3OIKkYz/rl+VbSGwOEXumKBa2Ff+s3+CD+FGbFmKG3+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=hCQVAKxB; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=//787Myr/VqgUg+Z0Dmgfea+M6q2Lk2wlsBaTrSrcCA=; b=hCQVAKxBNPZcsLiVz1mA8aZwvo
	KW8f9jqGZFCSXfRV1x5hr8C7VJ1bLmVI5AwqQukYSj8UBHgRDje5Wjd0xXYzaTM5nGt09E8tI0492
	pXscbprbReWwQeduSzqiJPkUne5Wj5Im1hRDiIR2kVsk3KmJMBwjG+gKfbM9ONAbTjaub62wa0CG+
	dG0J5RV+d9BjdEV9cFHSh10Z7Xf8bqZyqJoDZl6ahDIvKvfQUerph9sxqHOr3EGptCRipFuLocxO0
	rv3Bt0zyOr0JdNTurvHLzD5NcSPNOfAn+jVdgC6zSsXLvHVAo/FgRz2+gHp4d3iP2ikK8GprbsyW0
	AlhiyFEg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1weAQz-006Gds-3B;
	Mon, 29 Jun 2026 11:45:54 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 29 Jun 2026 04:45:40 -0700
Subject: [PATCH net-next 1/2] netconsole: do not warn when the best-effort
 skb allocation fails
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-netpoll_no_warn-v1-1-f380f0b2cd0c@debian.org>
References: <20260629-netpoll_no_warn-v1-0-f380f0b2cd0c@debian.org>
In-Reply-To: <20260629-netpoll_no_warn-v1-0-f380f0b2cd0c@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asantostc@gmail.com, gustavold@gmail.com, vlad.wing@gmail.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222; i=leitao@debian.org;
 h=from:subject:message-id; bh=UgICwQZXtIMsKIwAp/Fncd6qUNestULQCTQ9VgU7DR0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqQlrpNh8B/kyRotP/O54DpILnxCJ2t3h/V1kP5
 ir2Sn4QkwiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCakJa6QAKCRA1o5Of/Hh3
 bWYQD/9BxlC6CqfL5cmVMoQNqssTCOyc0X+JJXFBeye3gchHOq9uKo/lGcUlfXUyBxrjCrpTstz
 kzjAhut+zmz8KE3YIqYXqw0g7TGzOYuDU48IVUKlFNsg13JiRRnZgM+Cs+Plh46mLDLswe2IGuw
 s9CBUfqQMDyZJAstBLb4NC8gd68sv2KHS0I67ebdCIob+S5E+FEo6p1byBPPDkEOz5I6s6v8giT
 S9h4kCrUOT2LrEk/n2KmIV/z5eCUGHqzY/mbdT9231AnXW+5ruzaowwBwlChlaAbXuqJQ2wYK9u
 wkOtR1Co17wNpECErUs8+Z5ZO9ZhdNT8kfLlmL1wzhrfEPD6ItIAfXkvtUPMdOVBrilJc7Mnm6s
 J/HXDCOCsS7l/C337qm6sRKR+a/kRxSGYlDwt8YSezn56yCKmYCVm4gGjszyswtSFVGEFg+2H7r
 DA4Gn2d5AJ+W0MaqWxswrvG+GeeMRwMgL7cMkC4eeXiVhn+PJv9vxXZLTN/rjnrDPVBKbVmKGXs
 2aaI1tIbYRuzBvhbza9D5qkRiofiM5IWjrElVErlBnbpRbwOIbYhNgWT3Z90E/LdDFk0ktMxJBT
 UBWIugY6itvkWQ5MAXtRpKD6bud7UdZqBH/zXtLUqEeOIzoA8dZGvLyoh7l092P3m6zjf2aGavD
 fhluQO2MHzEqZOg==
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
	TAGGED_FROM(0.00)[bounces-302599-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:vlad.wing@gmail.com,m:leitao@debian.org,m:kernel-team@meta.com,m:andrew@lunn.ch,m:vladwing@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06A0D6D9B13

find_skb() allocates the skb with GFP_ATOMIC as a best-effort attempt:
on failure it falls back to the preallocated skb pool and, failing that,
polls the device and retries. The allocation failing is therefore an
expected and fully handled condition, but without __GFP_NOWARN the page
allocator still emits a warn_alloc() splat with a full stack trace on
every miss, which then consumes the whole SKB pool, that would be useful
printing the real issue rather than the memory failure.

Pass __GFP_NOWARN so the best-effort allocation stays quiet and lets the
existing fallback path do its job.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 862001d09aa84..c1812a98365b7 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1737,7 +1737,7 @@ static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 	netpoll_zap_completion_queue();
 repeat:
 
-	skb = alloc_skb(len, GFP_ATOMIC);
+	skb = alloc_skb(len, GFP_ATOMIC | __GFP_NOWARN);
 	if (!skb)
 		skb = netcons_skb_pop(np, len);
 

-- 
2.53.0-Meta


