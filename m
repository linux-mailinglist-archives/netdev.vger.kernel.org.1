Return-Path: <netdev+bounces-278472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cX9gOzFN3mnvqAkAu9opvQ
	(envelope-from <netdev+bounces-278472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:20:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 435AC3FB0EB
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13A9A30D06E7
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE1E3E868F;
	Tue, 14 Apr 2026 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ECnfTSB0"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ADE3C13F9;
	Tue, 14 Apr 2026 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176046; cv=none; b=uIbgMPMY8t9PKU8mov+XEzM9DziTFLUdNCiL3KQBMWgD2XLF3mU3lRuZr+C6h5+KFtw1SmhjaMhGMLoIi0tH5GsDQPebKjqhE+1wI3EG8/nhV/fVh4WJWTKg4xXnc+xDuMZVPHlyTqdW+OSFbR1BDAKqDl2j0GhJ8xKqvhF+fBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176046; c=relaxed/simple;
	bh=Tz5h4ysCy2wr77Qnz7wSJx6KWOsFG8dDm3YYaFhM24U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d8eg7Zxvu5qntKFtbsoAGVzCvwf/+o2Iz6wahuaWojQUarXjfG43JwgG8gCUs7AiMpCsv2+J5Dj2skVSzpUGDD6HJNlpZEU09LKHuUNzkYBYXGKrYFJhYSELtH7RbG3l893lLKEfRO2UVxY7ePPn8D6zjbuAKh6pOCeEncThdOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ECnfTSB0; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wCeWK-00FB5K-H0; Tue, 14 Apr 2026 16:13:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=k0G6DZFxuXzBdBD0yGiDWDu5betWefJe5EZr40nlZbo=; b=ECnfTSB0iwQd3K1wyBC85TUEEj
	bjAM6l+NVyDavLcjENB2pVRUEnRCjuV27U1CTHeZvN9gZX5UPhKwEnkdlnyb2x8nzlRtANUe9kzk4
	Di5jjhk4wtQa4WDzohyk07134naA+7yaDJWi+H6zpaWcomaRhU7MQ3/Z1//+bIf/tI2J3nDOAvM7r
	7A/XNBbK6HzSGbm4bEYAmCa4lXtqqhDRWmeCtsD4s3gatdfrVVXGt67U2PAL/x7XAgFWH1nN41EZn
	cKu5bRiHfoj6LCaH0JSF92jzxxgydhdpzwnfj+DM0IG6FXsfWw/1EoJip8Tvo1g8KFTo2lxTBk4xv
	dmbFJ5GA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wCeWK-0000UZ-6J; Tue, 14 Apr 2026 16:13:40 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1wCeWC-00DhbX-SV; Tue, 14 Apr 2026 16:13:32 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 14 Apr 2026 16:13:17 +0200
Subject: [PATCH bpf v4 3/5] selftests/bpf: Extend bpf_iter_unix to attempt
 deadlocking
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-unix-proto-update-null-ptr-deref-v4-3-2af6fe97918e@rbox.co>
References: <20260414-unix-proto-update-null-ptr-deref-v4-0-2af6fe97918e@rbox.co>
In-Reply-To: <20260414-unix-proto-update-null-ptr-deref-v4-0-2af6fe97918e@rbox.co>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Cong Wang <cong.wang@bytedance.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>, Jiayuan Chen <jiayuan.chen@linux.dev>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278472-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rbox.co:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rbox.co:dkim,rbox.co:email,rbox.co:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 435AC3FB0EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Updating a sockmap from a unix iterator prog may lead to a deadlock.
Piggyback on the original selftest.

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/selftests/bpf/progs/bpf_iter_unix.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
index fea275df9e22..a2652c8c3616 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
@@ -7,6 +7,13 @@
 
 char _license[] SEC("license") = "GPL";
 
+SEC(".maps") struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} sockmap;
+
 static long sock_i_ino(const struct sock *sk)
 {
 	const struct socket *sk_socket = sk->sk_socket;
@@ -76,5 +83,8 @@ int dump_unix(struct bpf_iter__unix *ctx)
 
 	BPF_SEQ_PRINTF(seq, "\n");
 
+	/* Test for deadlock. */
+	bpf_map_update_elem(&sockmap, &(int){0}, sk, 0);
+
 	return 0;
 }

-- 
2.53.0


