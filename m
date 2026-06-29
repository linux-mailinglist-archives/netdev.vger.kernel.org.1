Return-Path: <netdev+bounces-302819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h3N1CDTLQmqWCQoAu9opvQ
	(envelope-from <netdev+bounces-302819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:44:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F146DE7BB
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:44:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=xs4all.nl header.s=xs4all01 header.b=ieupvcVc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302819-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302819-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=xs4all.nl;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D824305D840
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E81C3A2E36;
	Mon, 29 Jun 2026 19:42:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5FA3D25AD
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 19:42:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782762155; cv=none; b=EbDO90bj1aWGFRzjlqUx50JOk7xmdPeKSQyfflUkZScED45o2oJbDbR8wnOHrlhFpoLN9pwBndWqnxLERhyfs/Ne0ZTBe55NWhhDu9QcZFOSjygYmO4uO50q/FBAuHELYx9DdBXbr/+1D9/Wam7a7Lf+fN1CNd0yqpzvT83jAaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782762155; c=relaxed/simple;
	bh=TrkodI12UGvel1nfDdqsf6YfPXTJyXgrdgUwQsOIdYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5lPp3tP5uSn6+7gBLyCtI+UobrMES4MD4LlK/k3WW10NwkhCKMEc+qD0o5CwMkAUEoTz8gNI/dugykAWcZqpE2c33ALk2b4Rg+Xqbtq289EbWv4PHvlgbSM7Tgk4QlVpGH9qQTtCakB5SbNZ3jcWiNVA/HL+fldrMoeF7u3iNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ieupvcVc; arc=none smtp.client-ip=195.121.94.183
X-KPN-MessageId: ab877244-73f2-11f1-8f53-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ab877244-73f2-11f1-8f53-005056992ed3;
	Mon, 29 Jun 2026 21:42:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=28PHYHEn8mc28E7Z6GTT/MVjZYIrnqmjcLU8hANfD3s=;
	b=ieupvcVcjPxTOosN2imuXBIy6RgmVUgXNr7ul7javjPEK5mCqrVP/Ic3BAAJnVxYj44t4XkFiVIf3
	 +E6vHvuwmniFS4YCpNq9eIB7d1D8r4PZvGWwT50v6WDgyRNqV3G+x0mDiztLJlu/w7HWz02lGXZEUr
	 zaDOD6HdTyfuTi5QCqz0VUMNwPvF2xoQjgjHqcxSkVSdUT48aCBoq3Bob/u+s1933tDtkim0L1hUIA
	 tAer6+oXtLrlC2+VnUcSBT21+3SnQSI5nSWgI9wtBEDyJ6XMclNf9HPiuZ5b4AqGfA1aUzqnPpon/y
	 A/6ENAnXfLoDWQwGojVrzG8w+YZtLrg==
X-KPN-MID: 33|0k1zxKMPpuH9s5bFTbC9+Ur1tpSdXjdageRw15yDq5AvXwej5MSUlyRH/HcaiD2
 dzOPboIj1s/lq5iW2N3EjIBGNR0yqzD+QeF9gjoVbqiw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|eQg/pDbESz5ZQowN8l+3fjiP6/g9uv7BSlKgL4bLXcaG4DmwF9EnytaTvDED7jh
 l7G0aoIdVuxO3v+xCO7Q/QQ==
Received: from daedalus.home (unknown [178.231.11.185])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id ab43b1d3-73f2-11f1-8076-005056998788;
	Mon, 29 Jun 2026 21:42:32 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH net-next v3 4/5] net: af_unix: replace copy_from_sockptr() with copy_safe_from_sockptr()
Date: Mon, 29 Jun 2026 21:43:26 +0200
Message-ID: <20260629194327.2270798-5-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629194327.2270798-1-jkoolstra@xs4all.nl>
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,xs4all.nl];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	TAGGED_FROM(0.00)[bounces-302819-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:cyphar@cyphar.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jkoolstra@xs4all.nl,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,xs4all.nl:dkim,xs4all.nl:email,xs4all.nl:mid,xs4all.nl:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8F146DE7BB

Replace deprecated call to copy_from_sockptr() with
copy_safe_from_sockptr().

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 net/unix/af_unix.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 83274ce18e06..07a0b07cd65f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -933,6 +933,7 @@ static int unix_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct unix_sock *u = unix_sk(sock->sk);
 	struct sock *sk = sock->sk;
+	int error;
 	int val;
 
 	if (level != SOL_SOCKET)
@@ -941,11 +942,9 @@ static int unix_setsockopt(struct socket *sock, int level, int optname,
 	if (!unix_custom_sockopt(optname))
 		return sock_setsockopt(sock, level, optname, optval, optlen);
 
-	if (optlen != sizeof(int))
-		return -EINVAL;
-
-	if (copy_from_sockptr(&val, optval, sizeof(val)))
-		return -EFAULT;
+	error = copy_safe_from_sockptr(&val, sizeof(val), optval, optlen);
+	if (error)
+		return error;
 
 	switch (optname) {
 	case SO_INQ:
-- 
2.54.0


