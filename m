Return-Path: <netdev+bounces-264579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD4HBqoUqmnFKgEAu9opvQ
	(envelope-from <netdev+bounces-264579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 00:41:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9942196B8
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 00:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6972031A1D4E
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 23:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7F0369202;
	Thu,  5 Mar 2026 23:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="bGZon8dJ"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F36370D54;
	Thu,  5 Mar 2026 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753520; cv=none; b=jgMyoXX58AJ9jxnvXGvHM4F0wxKolY+7uvezo3dwzrPXCxRq4thlnu0QXc+WvstRjDo5MQ7QBsF7ZNpZMtlo1XFt7/VhJ2XLfzu/s3xHaKc1GXmtqq4nQh23hYVIC6NzQ3FsGWpen8ouQArQ85loiOvSvXRTwhtWxN2EIQhtKbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753520; c=relaxed/simple;
	bh=gdJT7K1pKjQBOSjWRelJahkezXPG1ww/h/3ZYeVts6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uas4kbnPSEz03XXczq5WSLfTnKZuNEaYtWCcXmnOCHJaXNHivn36OL2+O2MrSyDGke/HSvy9APNBdhee4R4RgDHn2IsFxcqxCPyzxSBR5MU11xd4bvZdQvkJR4vuyZ0NGKRQe03VV0DAm5r4+dkNihxE/kEChH10Ek6MZqh6XD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=bGZon8dJ; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vyIAP-00EUZ1-Kc; Fri, 06 Mar 2026 00:31:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=8LWn31xqqYR+DksBi9atiCH/RgX+9qrk7M9IefQaoMc=; b=bGZon8dJbeXZyyTY4uSgtjXTa+
	zB4PHn92c/D5m55kF0HgorZl4z+cvCthP7pw9goRRYszTXpEA6hdQO65LWhj2l3OI8G+yv7x232GU
	TU4DFW2dvTUEbmIA/qkWJePUqICTTwttm7JVGNVhjPV/YxHKKVvhpOM/RT3CMZpYkhgKk342k1BnR
	G0Yfv5HIYlhzz9qp2u1H7o2zuDBfZnh+cyqKkPdSXo+3dxNxrIXDnQk0m7HrRp2Wt30h2HQEiDy2T
	zdFK7xl1vjqQCRKy5AqZg1aNEKa+trd6mXLYo/gRsskbwPbPo4JCm9L4S903xahWrXwr2NOrIEFvg
	cAmmWsSg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vyIAP-0004Bc-BG; Fri, 06 Mar 2026 00:31:41 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vyIAH-00141B-KO; Fri, 06 Mar 2026 00:31:33 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 06 Mar 2026 00:30:55 +0100
Subject: [PATCH bpf v3 1/5] bpf, sockmap: Annotate af_unix sock::sk_state
 data-races
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-unix-proto-update-null-ptr-deref-v3-1-2f0c7410c523@rbox.co>
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
In-Reply-To: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
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
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 6F9942196B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264579-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rbox.co:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,rbox.co:dkim,rbox.co:email,rbox.co:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

sock_map_sk_state_allowed() and sock_map_redirect_allowed() read af_unix
socket sk_state locklessly.

Use READ_ONCE(). Note that for sock_map_redirect_allowed() change affects
not only af_unix, but all non-TCP sockets (UDP, af_vsock).

Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/sock_map.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index b0e96337a269..02a68be3002a 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -530,7 +530,7 @@ static bool sock_map_redirect_allowed(const struct sock *sk)
 	if (sk_is_tcp(sk))
 		return sk->sk_state != TCP_LISTEN;
 	else
-		return sk->sk_state == TCP_ESTABLISHED;
+		return READ_ONCE(sk->sk_state) == TCP_ESTABLISHED;
 }
 
 static bool sock_map_sk_is_suitable(const struct sock *sk)
@@ -543,7 +543,7 @@ static bool sock_map_sk_state_allowed(const struct sock *sk)
 	if (sk_is_tcp(sk))
 		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
 	if (sk_is_stream_unix(sk))
-		return (1 << sk->sk_state) & TCPF_ESTABLISHED;
+		return (1 << READ_ONCE(sk->sk_state)) & TCPF_ESTABLISHED;
 	if (sk_is_vsock(sk) &&
 	    (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET))
 		return (1 << sk->sk_state) & TCPF_ESTABLISHED;

-- 
2.52.0


