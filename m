Return-Path: <netdev+bounces-270879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AndM6Ipwml5ZwQAu9opvQ
	(envelope-from <netdev+bounces-270879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:05:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9417B302938
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A30B83044655
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 06:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F233AF650;
	Tue, 24 Mar 2026 06:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcpDzhpv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625A53ACA79
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 06:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332270; cv=none; b=Nz2dpebVber6l7Rfc+MwjdVMnLnaJ/1vCmZRsX7afsrGK+SYte4YtiO/FKS+mqXTDZW0eXq99GR5DpNQ/spWfM8Cul00wGKU8Jq6ev2yx26biVp+v0JoN0AXYwkEsZke6X6z48cHmQ9iHcQdhQvmyjuzhlWOiyhhXouOdeKXYRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332270; c=relaxed/simple;
	bh=vDPZKHBUYge/g17hzmq5toRf4WT7oxJcyJZTa2pK1Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3mt0L342IK7jx0fRWh8f+80ndwJUt60A15I2gxTnal6fyMNsl+epDC8MbiNF6x5FyN5j1O9eTVq8s+IIFgchTVWrW4jyYNbA8cmfw1ZH/L1KoCQS4g+O+yqMPt/3/dtlI3Q1yaevZq5p68dDe0D2hAZxMFvqRIgsmfg4s+m9gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcpDzhpv; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d91f82d819so776848a34.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 23:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774332266; x=1774937066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdUAuQeuJDXiY6t8B3u7gtUDmCHorI1qmUGWnWOYpWU=;
        b=hcpDzhpvPmhdFAl6MmhNCFrPgkhxrY1TUjfNMCVwhdI5v0o2XjqDHLuWXWhSux81T5
         phGLX1MQMrM4L3NDqBFcvfJds1JrpdWystuOuA0EQXaa2MSzUcdy/m7//32QJns2Ih1/
         7MJZ9ZS+YugO2rk4fFM+oHn/kc3xwqBy7Q5jyfBNvpUDnhGPsU/631hFoPsfBBK0c8Jb
         m97U2c8hmQw/Q7XNF+Dr7EoI9UF4Bp23LLKxiWDXt3/vK+WKUCoGbyEARIomzAo4iSei
         7OPCk+mYMINIO94vnpa8K7HBOEdl4TyzX8SgsOQxUYYB1MlCAD0QGtHz8st8NiIo+lt0
         ek2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774332266; x=1774937066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VdUAuQeuJDXiY6t8B3u7gtUDmCHorI1qmUGWnWOYpWU=;
        b=PI1P/Nbu7NgLXBQdm0kvsQEh3OFXMQd+fIOdt0iKTy8ScOTqvZEk1deLUEWjhDLn6c
         VBaddCvpxa4K5vEvWwYk7tu6iYbQmDcv2PAta4Ek5cY1mM8zyJAQhhHSaa3eH+Ixd99N
         DspC1nKcEetsa2PPvD/FTAxQjSs7F2JklZaKVeAEJo4scGLTykGzB6Ck6G9AFULcCK/q
         qmd0T0h2SpokOMQb2FH67PK3fF2p7kUVt6pqZQJ0hXsWVdq2bIOA/Q9oCdnxdJu4qG+J
         3+K105IP//folvObgkR3L6WwwHMo0/Qf4vlyfH4px8zaQLq58IqrKWlMtTUfHFpqlmzn
         AKzA==
X-Gm-Message-State: AOJu0Yz+QRsGVswjenBxzkX9LLlqYMgOcLYZfCq099n7d6Ov08Aq+Kiy
	ykfCigyDaCH8U2XQB+TX/SCQE4MoBxZWi/cPrDLUel5LBDJKuUcg0s1cUGGT18AX
X-Gm-Gg: ATEYQzzWnjFh1MEgtV1oYhiWFYQqHAzOxaxE9oRlnenxT+sJJQBjdpZgotiMt+TC7a4
	yVs0h0UseRzkw4OOGi/m4nyJFikmrOn1l9z28VOSEwDepDapxw6U+TPvgNZNFaopSwy8wcC5sbJ
	Z7Dmd7X7IRWUpuMluKGCqMT11XzdQPZ/em7uQt7GOhdQ+DMv1F/a2F6FhPNzwMm6NGFD7Fq5d+y
	uwcc3KDXMXegnYLZdjsOGPD9JMRg00p/iAd875dFBFCdXIXEKq0e3gJmGzSGJwqOspvXc9VeqpY
	OErqjaVs8iZk4czF3Do37DeUJLYOqz9rIZLH7MM/ofGDJof5gpKxHQ86ylSPXcht62lL3af+rHC
	fZgAAZkaDQqKxRXozgq00hxvs636t/I0GkNJLw0W/evp6u68aCsSNitUW1Yy4+4lBENGfFnppkq
	vVOi2dFhVac32yBiG60iYrsAv6AYBPwPnXPyYgTUw7n/0iHskOWK4II9JADRzMVnPNqQD3XOZei
	o1LMVpNlPhGLg8O6CHkxN7Z18dI3tCqsWZ3/K2MjA==
X-Received: by 2002:a05:6830:82e6:b0:7d9:b0d7:ffda with SMTP id 46e09a7af769-7d9b0d80e91mr5744843a34.11.1774332265864;
        Mon, 23 Mar 2026 23:04:25 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadcb757sm11429957a34.15.2026.03.23.23.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 23:04:25 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	gmbnomis@gmail.com,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH net-next v2 2/3] tcp: keep scaled no-shrink window representable
Date: Tue, 24 Mar 2026 00:04:09 -0600
Message-ID: <20260324060410.1137199-3-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324060410.1137199-1-atwellwea@gmail.com>
References: <20260324060410.1137199-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-270879-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9417B302938
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the scaled no-shrink path, __tcp_select_window() currently rounds the
raw free-space value up to the receive-window scale quantum.

When raw backed free_space sits just below the next quantum, that can
expose fresh sender-visible credit beyond the currently backed receive
space.

Fix this by keeping tp->rcv_wnd representable in scaled units: round
larger windows down to the scale quantum and preserve only the small
non-zero case that would otherwise scale away to zero.

This series intentionally leaves that smaller longstanding non-zero case
unchanged. The proven bug and the new reproducer are both in the
larger-window path where free_space is at least one scale quantum, so
changing 0 < free_space < granularity into zero would be a separate
behavior change.

That representability matters across ACK transitions too, not only on
the immediate raw-free_space-limited ACK. tcp_select_window() preserves
the currently offered window when shrinking is disallowed, so if an
earlier ACK stores a rounded-up value in tp->rcv_wnd, a later
raw-free_space-limited ACK can keep inheriting that extra unit.

Keeping tp->rcv_wnd representable throughout the scaled no-shrink path
prevents that carry-forward and makes later no-shrink decisions reason
from a right edge the peer could actually have seen on the wire.

This removes the larger-window quantization slack while preserving the
small non-zero case needed to avoid scaling away to zero.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
v2:
- rename gran to granularity
- clarify why representable tp->rcv_wnd state is required across later
  no-shrink transitions
- clarify that this series still intentionally leaves the smaller
  longstanding non-zero case unchanged

 net/ipv4/tcp_output.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 35c3b0ab5a0c..e5c4c09101be 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3375,13 +3375,19 @@ u32 __tcp_select_window(struct sock *sk)
 	 * scaled window will not line up with the MSS boundary anyway.
 	 */
 	if (tp->rx_opt.rcv_wscale) {
-		window = free_space;
+		u32 granularity = 1U << tp->rx_opt.rcv_wscale;
 
-		/* Advertise enough space so that it won't get scaled away.
-		 * Import case: prevent zero window announcement if
-		 * 1<<rcv_wscale > mss.
+		/* Keep tp->rcv_wnd representable in scaled units so later
+		 * no-shrink decisions reason about the same right edge we
+		 * can advertise on the wire. Preserve only a small non-zero
+		 * offer that would otherwise get scaled away to zero.
 		 */
-		window = ALIGN(window, (1 << tp->rx_opt.rcv_wscale));
+		if (free_space >= granularity)
+			window = round_down(free_space, granularity);
+		else if (free_space > 0)
+			window = granularity;
+		else
+			window = 0;
 	} else {
 		window = tp->rcv_wnd;
 		/* Get the largest window that is a nice multiple of mss.
-- 
2.43.0

