Return-Path: <netdev+bounces-285410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GZiIfG2/Gn9SwAAu9opvQ
	(envelope-from <netdev+bounces-285410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:59:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C1E4EBB45
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7214230EDD45
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EB844DB76;
	Thu,  7 May 2026 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Gdxekxqm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBA244CAD4
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169108; cv=none; b=Mzw0fs22IX60lAJ5XFLA+uJKZItahh/y3xFURhX3QrZ/syeww8WnPAX2l5VIYhj791t8lweThut7O5umdaGx8HvST2kPRSzwxYDdGFzRBVbEZOPCg+Fw05ulnXZiD6BK8x1uh7UgAjJ4VI9ISE7gmg+8FSUCaNQ+mgkznpOJxE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169108; c=relaxed/simple;
	bh=M15uTKwN3yvrhy6+C4e1xest8u1tFHkbzRM6zHTj0ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdPAjcjY+Pmu+cz9EBu0J3rrPNTerJPnn1I32GsQ05bqmYspUABDQS83yMM5s2Y10rYkY2Adly/kkmZYEeU3SwG2eYEysI4T7THkOspKzmpWP8xVUFKuXqcgrW2B3LhHWg+I/0tCBoojUbM1B2CRBKwJhebpMhaeniaE4hGj3p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Gdxekxqm; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a8720818aeso1293395ad.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 08:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169107; x=1778773907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtLl8kOWvPMx0S+t/a7Mz9vgLX46fqlMMw8qeaNu9sU=;
        b=mLDURcRG0PqQIdktAOz9Hgq4jH7mkvn0DNGz5M2/5TeGhOJFbLPpzvXumX56jVAxNF
         KLTYBMQ2Zxi5Jnq9nGZcKx+im2aADyFpiajAlMoE/4yzeblrmsIuilvRoEg9px+uBbTi
         dk7lohUP1eEbJ44zyLkYZosi2tbDweCeG0JTBdiO18oW3NXVbC4zmHxWfzB7Ts1CtzcV
         /0ja8+5CtRPlkCeCBDg1Dz+jq5Y8fiVOejVFUcb5sxC0e/Hut76GD3MMz+9b8YzBVYpg
         SlCKU4mlWuHHh3/RQzA5M3LjdJqMGbwvGnxfTCX0ReY0CGBewHsCXYnHyRYTXxQph3xc
         Balw==
X-Forwarded-Encrypted: i=1; AFNElJ/VoMYGTbRIQfe72zInP2boHtL5qGL0Hgz4eUUQBY5OzeJgp+sfcZnDUvrcy5xuS2o02e4Ric0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcEcFw1T5ykroI6IU8JVUwwYVfBsnV3cgtn7D6p1+Whn7JJOb8
	0EYNsfaem1HqE1eKAX37r4rXc5Y3hXbamnJoSnhEw78Ovsvs7udnnKX7UdfFMk3MlxeEPi2leLp
	G6NN3tLQni0i/BbDt3sHZMqVz0sVGSRgfXbrGZX+et97ch/nScSwcEdI1OUAc3LSBx1QaJ4OYNP
	Ek4Dsrot62bijORb8doveXynsLn76QMTQBN5A5JT4aaKLPg15P/AofE/Zmad1b+/wyvjTCBlm/F
	ECkxdOBypRMhDI=
X-Gm-Gg: Acq92OEi8YlmN5Yi7c86L52kO2pmkgo+n+zuJbI4qqEBxqeKpvOdrmg2+Sj2zlp+8eG
	sY3gQhPn2E7wwiibBAN5UFI7AtQXlOT4f+3KjiR6cmNIOx+qyqeHUnJ1wppwfDjWAZ6BnBNs3vr
	hUeUhaMv86eTJm546g8FcMV9CFWs0zo2Rh1nsdW3cDQd8UGCPRT4ygo7BP18YlNTd5BfTcZyNzL
	vN2keQDRFXWRd7jyHHHNwKZwRC3Pa/Gj873cZxMCdGUdISFQc/KUs84U09rvNScGdN8FXaEeIUT
	0ca4t8dkWzriQFq+Fzf+E2W2GM+do3h5/L0qa5yagZPzKxAenVc7DZFLu5jc2lclzWVtUO3kCNu
	K1aj+7AifF7/h7lzGNeHJJ4hQ/aMlDUl279OBfDprH2xoLPW3O5I/F2qGs9Lw/+1jJ0Ut+U7BAb
	oLCqhW0GkZ5Y2UMTM7F0antGZpS0lay66Gz5b2xXjw6RhFdV+msfaXXdLL7wmS
X-Received: by 2002:a17:902:da84:b0:2b2:eb6b:72f2 with SMTP id d9443c01a7336-2ba7f5444a2mr48612705ad.7.1778169106620;
        Thu, 07 May 2026 08:51:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2bae70a5a10sm125215ad.0.2026.05.07.08.51.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2026 08:51:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8eb530174f0so24148185a.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778169105; x=1778773905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtLl8kOWvPMx0S+t/a7Mz9vgLX46fqlMMw8qeaNu9sU=;
        b=GdxekxqmEJ3Rx7hl0zllmscamtHQJ4J7UOFpKkbkp8NKpIqdhNX+OiXH8X/Hzzob18
         TOwtRgpjTi54fGeYUicnI7/N8nW+9bJkSWnn5Mq9B0SwpwsuqYoe/1R0HSqV2tb8ALB8
         RePp0S+PgS1JWMB0e6eANZfN4feGMDtfAbuV8=
X-Forwarded-Encrypted: i=1; AFNElJ/bVQzIlbLWARsVAegvQMfok67E7tby5kmQejYdIp6EBI+VX8ujPe4Ee9jJp4JX2S3iBhxVyOg=@vger.kernel.org
X-Received: by 2002:a05:620a:4406:b0:8cf:d953:b4ec with SMTP id af79cd13be357-9051dafefc0mr754137585a.3.1778169105088;
        Thu, 07 May 2026 08:51:45 -0700 (PDT)
X-Received: by 2002:a05:620a:4406:b0:8cf:d953:b4ec with SMTP id af79cd13be357-9051dafefc0mr754133685a.3.1778169104463;
        Thu, 07 May 2026 08:51:44 -0700 (PDT)
Received: from photon-d7fac424c0d3 ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-90642b76d39sm240711885a.2.2026.05.07.08.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:51:44 -0700 (PDT)
From: Ankit Jain <ankit-aj.jain@broadcom.com>
To: edumazet@google.com,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	ncardwell@google.com,
	kuniyu@google.com,
	horms@kernel.org,
	shuah@kernel.org,
	quic_subashab@quicinc.com,
	quic_stranche@quicinc.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	karen.badiryan@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Ankit Jain <ankit-aj.jain@broadcom.com>
Subject: [PATCH net v3 1/2] tcp: protect locked SO_RCVBUF from Silly Window Syndrome
Date: Thu,  7 May 2026 15:48:05 +0000
Message-ID: <20260507154806.18635-2-ankit-aj.jain@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507154806.18635-1-ankit-aj.jain@broadcom.com>
References: <20260507154806.18635-1-ankit-aj.jain@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: D4C1E4EBB45
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285410-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_NEQ_ENVFROM(0.00)[ankit-aj.jain@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

When an application locks SO_RCVBUF, it disables TCP window auto-tuning.
However, the kernel still applies dynamic truesize penalties to the
scaling_ratio.

For small packets, this penalty drops the scaling_ratio to 1. This
reduces the advertised window and causes Silly Window Syndrome (SWS)
along with 504 Gateway Timeouts in applications like Tomcat.

This patch bypasses the truesize penalty if SOCK_RCVBUF_LOCK is set.
To prevent memory exhaustion from large aggregate payloads, the penalty
is still applied for GRO packets (skb->len > len).

Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
Reported-by: Karen Badiryan <karen.badiryan@broadcom.com>
Signed-off-by: Ankit Jain <ankit-aj.jain@broadcom.com>
---
 net/ipv4/tcp_input.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d5c9e65d9760..4b1832b3face 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -240,8 +240,13 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
 		/* Note: divides are still a bit expensive.
 		 * For the moment, only adjust scaling_ratio
 		 * when we update icsk_ack.rcv_mss.
+		 *
+		 * Bypass truesize penalty for locked SO_RCVBUF to prevent
+		 * window collapse. Still apply it to GRO packets.
 		 */
-		if (unlikely(len != icsk->icsk_ack.rcv_mss)) {
+		if (unlikely(len != icsk->icsk_ack.rcv_mss &&
+			     (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK) ||
+			      skb->len > len))) {
 			u64 val = (u64)skb->len << TCP_RMEM_TO_WIN_SCALE;
 			u8 old_ratio = tcp_sk(sk)->scaling_ratio;
 
-- 
2.53.0


