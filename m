Return-Path: <netdev+bounces-303894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5MnHFc6iRWrFDAsAu9opvQ
	(envelope-from <netdev+bounces-303894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 01:29:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A80646F2494
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 01:29:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rbox.co header.s=selector2 header.b=UBVquths;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303894-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303894-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=rbox.co;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75AD13031ADE
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 23:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D626F3FA5E4;
	Wed,  1 Jul 2026 23:29:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC9B39A7F6;
	Wed,  1 Jul 2026 23:29:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948553; cv=none; b=EEPkO8B0IoLOD+N7tvcss5akT2Iqy4IArh16uRHHYOGQJ6UIJECBhAvvfSarrvDlkTflaOFRja+4PI/A+xbdhel7ligF7jG90rcwHmkkT3EzKYhbORHtv2vWf4sqcwYBGySDxdJErToOINTO43ugDVexynbDVxRujUFWsEwRC3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948553; c=relaxed/simple;
	bh=R+PDzFKU62NfCaCLr8ElinIvVbuWnFq0dWlVthEw3r8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZGozuYTPaNus9wuJSi5rmsohye/BiFovRQihVVRQA8M741MLmjwA38Vnu9hMKsD1KdZyIEyx+89fuTUv2o9ZYVP6DsOGk6ncvPpEDw9LybFosx3jIaZ+eslGl9SSzSHZgTAbOcPwfrx6D88rxrPsaCi/rl6PzonNqrfOZjd93RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=UBVquths; arc=none smtp.client-ip=185.226.149.38
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wf4MZ-00APZW-AR; Thu, 02 Jul 2026 01:29:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=JY6vyu4ew/YbvfbysQ3sEbAPWeh/UANUY1m4KLaXAW4=; b=UBVquthszWp+2JcebPNIWIzfyu
	uvqEW7Gphm2d1Sy8KBkPudXu00OBywmWr9ZbmMz1tZmXmyqbByJ6bK/4UV6aH5CYX+LTyUcW6c1Mp
	ZQ6f9D6blyBRRq0WPkgU3TUaWNjOZ8Xb71Qw5kZBG9BLczyEez22/G+l7C9TN4lvy5vMd40u/kGM5
	VpT2RH96LV7d7MfjDPgw4zBxg9m9Mi0uKZS/K523mdCnHwJ9wbdPbpvPFnYAe32rqGG9y+aDP/IBc
	9FiO9IRHqGrpS8p8TkCFKWhPWeSJPnaPW/KNUcEhSPw7uDtQzomsga7Y7qULKg0JkpIaB6cZ9eGVS
	zOZZRK1Q==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wf4MY-0005GM-Ku; Thu, 02 Jul 2026 01:29:02 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wf4MR-00467f-0f;
	Thu, 02 Jul 2026 01:28:55 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 02 Jul 2026 01:28:21 +0200
Subject: [PATCH bpf v3 3/4] selftests/bpf: Adapt sockmap update error
 handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-sockmap-lookup-udp-leak-v3-3-ff8de8782468@rbox.co>
References: <20260702-sockmap-lookup-udp-leak-v3-0-ff8de8782468@rbox.co>
In-Reply-To: <20260702-sockmap-lookup-udp-leak-v3-0-ff8de8782468@rbox.co>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Cong Wang <cong.wang@bytedance.com>
Cc: Michal Luczaj <mhal@rbox.co>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303894-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,cloudflare.com,google.com,redhat.com,davemloft.net,bytedance.com];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:cong.wang@bytedance.com,m:mhal@rbox.co,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[rbox.co:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rbox.co:dkim,rbox.co:email,rbox.co:mid,rbox.co:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A80646F2494

Update sockmap_listen to accommodate the recent change in sockmap that
rejects unbound UDP sockets.

TCP: Reject unbound and bound (unless established or listening).
UDP: Accept only bound sockets.

While at it, migrate to ASSERT_* and enforce reverse xmas tree.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c       | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index cc0c68bab907..b87118aab7c4 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -53,8 +53,8 @@ static void test_insert_opened(struct test_sockmap_listen *skel __always_unused,
 			       int family, int sotype, int mapfd)
 {
 	u32 key = 0;
-	u64 value;
 	int err, s;
+	u64 value;
 
 	s = xsocket(family, sotype, 0);
 	if (s == -1)
@@ -63,11 +63,8 @@ static void test_insert_opened(struct test_sockmap_listen *skel __always_unused,
 	errno = 0;
 	value = s;
 	err = bpf_map_update_elem(mapfd, &key, &value, BPF_NOEXIST);
-	if (sotype == SOCK_STREAM) {
-		if (!err || errno != EOPNOTSUPP)
-			FAIL_ERRNO("map_update: expected EOPNOTSUPP");
-	} else if (err)
-		FAIL_ERRNO("map_update: expected success");
+	ASSERT_ERR(err, "map_update");
+	ASSERT_EQ(errno, EOPNOTSUPP, "errno");
 	xclose(s);
 }
 
@@ -77,8 +74,8 @@ static void test_insert_bound(struct test_sockmap_listen *skel __always_unused,
 	struct sockaddr_storage addr;
 	socklen_t len = 0;
 	u32 key = 0;
-	u64 value;
 	int err, s;
+	u64 value;
 
 	init_addr_loopback(family, &addr, &len);
 
@@ -93,8 +90,12 @@ static void test_insert_bound(struct test_sockmap_listen *skel __always_unused,
 	errno = 0;
 	value = s;
 	err = bpf_map_update_elem(mapfd, &key, &value, BPF_NOEXIST);
-	if (!err || errno != EOPNOTSUPP)
-		FAIL_ERRNO("map_update: expected EOPNOTSUPP");
+	if (sotype == SOCK_STREAM) {
+		ASSERT_ERR(err, "map_update");
+		ASSERT_EQ(errno, EOPNOTSUPP, "errno");
+	} else if (err) {
+		ASSERT_OK(err, "map_update");
+	}
 close:
 	xclose(s);
 }
@@ -1289,7 +1290,7 @@ static void test_ops(struct test_sockmap_listen *skel, struct bpf_map *map,
 		/* insert */
 		TEST(test_insert_invalid),
 		TEST(test_insert_opened),
-		TEST(test_insert_bound, SOCK_STREAM),
+		TEST(test_insert_bound),
 		TEST(test_insert),
 		/* delete */
 		TEST(test_delete_after_insert),

-- 
2.54.0


