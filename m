Return-Path: <netdev+bounces-164123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5B8A2CABC
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 19:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B0D188C133
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC8F1990A2;
	Fri,  7 Feb 2025 18:04:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89C8479;
	Fri,  7 Feb 2025 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738951495; cv=none; b=eOjoVa8wIt08T2Ql6FKdOP2uYz4YMhWbfOxQYpXFx/eczxYwL5Z2ILgSuDObr14NgejHLiZpqOfhywzor9v5UhdZSydjGXiIWYIowLbRS76m1opcGOSOSk41lD0X+kmsSPZmlNxhc/HcDh3jGBawQGYNaizycF03GdVDdU3862Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738951495; c=relaxed/simple;
	bh=tvo5NDkfWGS1QCxE9BRsTOO9ib/fhBg1vpDi7HXyydA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nIi13ciDVuAhwAu6BgH1U8XU7HSzTiiDV0wLLtejIZjRZH+93UEEAkWeV7+HQjl1HYDDA2WkqoW7CYVWA77cxlSlPESky2Of/kmVhIoGOHw1/+Cq75r5RhplsMzDd6JfdruxWLSmkLdgHmjUmaLrxj835Jx3KT29yLaN6z8Bt1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dcd8d6f130so4703073a12.1;
        Fri, 07 Feb 2025 10:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738951491; x=1739556291;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BEG0ZGL7WR2xRJMYONjM2DZlvzrNSsGBEyaJEQhqy7Y=;
        b=d4ghzYE2YBok+VCwGP7akRL/ep5eSnWyx/oyVkwO2FaxbJGVf7s8TDoA4eshE/elW5
         WIixU0G8sSIUKauYQTpCvSHB94cmA7pM/bNqENa+/wFDZcPxYwUePYkNPDgsdNrX4go2
         pbRImfut+iK2p2o+S8MKeSZQwhFF8vBZax+ZJQubGZS7F5EPIzY45CZH+QG609RH3zSG
         D5cAxzhin0dWHDkoWCULtcNmcAmfqap+MjiruF05fAGk1Sr5elN9pPsCUKqysPNzuOch
         u0ONF/XQyQmfE4JvVMhXeoqLynkC2imnsocFTOODODf9D1XYUB30k19E+Yo6o1o+rtOx
         3bTw==
X-Forwarded-Encrypted: i=1; AJvYcCUTD7yWDUJSRCXHHlZ4re7yJvUEJZx9VWXQNiHwTK2zZm34do12J1cTe/knRd6P3Pd9A7C69asgvJyVfzLE0XkyU2wD@vger.kernel.org, AJvYcCVumvsxPUkYLJeztAd5HwQV7gE8AdgW5LmdAGJYxnmjwGZNj2LDMHO8kjhxbD3EPCAiMwNGDi2b3spGE7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAamRqaBgM3cTWoxg953YlXym+UTUom/sJHYtmw6KVVSpG6wKo
	FJr8/jMy3VbblHEbjok+f/xB4hkJc2rgcl3/dfT10VhZEI1JzY2X
X-Gm-Gg: ASbGncsdsaQ7GhPcTsK72mVxLqJDbj6ZAtgLJwYAtq6hKPetwGaTvjW3dw3wzgHBfTY
	NHL17WKV6QqQj/TxN39vkyJ0LJSeMOv9EVqC4Z78jCwhkJ23xpWJzxc0ogaA5BNOm54rs5hIpcg
	s/USV1LlRQV7y/6nZlibA1ls1853oSpcYv2gWp6YHHMI1oo8FnsrKIgIwhECNc8M3hohEY47pKW
	8HCINbQi6Z4nO1ZO+CuwDtz6vHGIcEzPGWL8Trlk+WDImiVKnIVLjY58Yop1f0Y2pHP3+w+AfWz
	qXIsYA==
X-Google-Smtp-Source: AGHT+IHphCsXNhMeNQVH7Ib2GeF+KatME8KGOMIDRzOSqeYur303sjJDqjpMEcEi3mxHHVqgFvd/Og==
X-Received: by 2002:a17:906:360a:b0:ab7:5c95:3a66 with SMTP id a640c23a62f3a-ab789cbe59bmr347184766b.40.1738951491250;
        Fri, 07 Feb 2025 10:04:51 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f8442dsm307309366b.46.2025.02.07.10.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 10:04:50 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 07 Feb 2025 10:03:53 -0800
Subject: [PATCH net-next] trace: tcp: Add tracepoint for
 tcp_cwnd_reduction()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-cwnd_tracepoint-v1-1-13650f3ca96d@debian.org>
X-B4-Tracking: v=1; b=H4sIAAlLpmcC/3XNQQqDMBBA0auEWZuSia2gq96jSInJqLOZSBKsR
 XL3gvuuP7x/QqbElGFQJyTaOXMUGBQ2CvzqZCHNAQYF1tiHQWu0/0h4l+Q8bZGlaEuIvu871/s
 JGgVbopmPS3yBUNFCR4GxUbByLjF9r9WOV/+r7qhRt91kyITu3s7uGWhiJ7eYFhhrrT8rbdwYu
 QAAAA==
X-Change-ID: 20250120-cwnd_tracepoint-2e11c996a9cb
To: Eric Dumazet <edumazet@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2341; i=leitao@debian.org;
 h=from:subject:message-id; bh=tvo5NDkfWGS1QCxE9BRsTOO9ib/fhBg1vpDi7HXyydA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnpktBtueCo/j+Z0lpU9qnH3gCdzZ8cp6UDHd/Q
 j1d/m6wY1aJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6ZLQQAKCRA1o5Of/Hh3
 bRUUD/0UdyGBWm96xj2/FVv0DVk7gty8wf/UptvkUkSPbo9NrXezaIKzk2idOMC6idwuWUIfdbr
 zxeYjTFoSwVii4pWPPCdMjvtf2szUzkZSzw++EZi0SFnIL9l3DXWcQaOrzDVMSzoLCYt9dRZHqK
 x/17PnNIM07geOPLFsgEbNkUAgj5cqD+U63pguPSVsHDPg2bEvsygkA63PfozdedeLB3sPeyxfx
 qHOQY5G0XIRuWwiB7t89yNg96M3ZY3MsWdDdiSI2AAs8I4rPJM8U7FL1BPQ4n5jR+/izL6nz5jH
 OVZD0BpgQpnnJZpAAhHWyCbrUp6sgvv8tlrsBCeQM2QybuQzChUX7UYLgv+XNZCB7/ZiWr5NyHh
 OrOH6q7TLSoaUuX+3uuAcZN91ZRjoybm2D+BYy6uh/FInn75sypNEuM+Spba7705//mgz3Gs2WZ
 7SXFK9M1kYPwWlsUYefPyMdlk7NvaOX0xKQs9Vxmzm9TALU69d9C6QWI+BZAfinALMQ6U314d+v
 dzhKeTUoWyD4l3AUunn7Ulc1eytn2tHJFdFLRCBId9dD3LFJ+apUWZ37kAkuVWfaSGmjy/HvQc6
 qJ/4bf3BTPLAsMnITBFQO8yz22gMkovromDa0/Xe0iWck92as0lS/tonLSCsoT6pa7YtYHHntAp
 ewDwt56xEUNBnmg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a lightweight tracepoint to monitor TCP congestion window
adjustments via tcp_cwnd_reduction(). This tracepoint enables tracking
of:
- TCP window size fluctuations
- Active socket behavior
- Congestion window reduction events

Meta has been using BPF programs to monitor this function for years.
Adding a proper tracepoint provides a stable API for all users who need
to monitor TCP congestion window behavior.

Use DECLARE_TRACE instead of TRACE_EVENT to avoid creating trace event
infrastructure and exporting to tracefs, keeping the implementation
minimal. (Thanks Steven Rostedt)

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes since RFC:
- Change from a full tracepoint to DECLARE_TRACE() as suggested by
  Steven
- Link to RFC: https://lore.kernel.org/r/20250120-cwnd_tracepoint-v1-1-36b0e0d643fa@debian.org
---
 include/trace/events/tcp.h | 5 +++++
 net/ipv4/tcp_input.c       | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index a27c4b619dffd7dcc72fffa71bf0fd5e34fe6681..d574e6151dc4f7430206f9ccefe0bf0d463aaa52 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -259,6 +259,11 @@ TRACE_EVENT(tcp_retransmit_synack,
 		  __entry->saddr_v6, __entry->daddr_v6)
 );
 
+DECLARE_TRACE(tcp_cwnd_reduction_tp,
+	TP_PROTO(const struct sock *sk, int newly_acked_sacked,
+		 int newly_lost, int flag),
+	TP_ARGS(sk, newly_acked_sacked, newly_lost, flag));
+
 #include <trace/events/net_probe_common.h>
 
 TRACE_EVENT(tcp_probe,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index eb82e01da911048b41ca380f913ef55566be79a7..1a667e67df6beacde9871a50d44e180c2943ded0 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2710,6 +2710,8 @@ void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked, int newly_lost,
 	if (newly_acked_sacked <= 0 || WARN_ON_ONCE(!tp->prior_cwnd))
 		return;
 
+	trace_tcp_cwnd_reduction_tp(sk, newly_acked_sacked, newly_lost, flag);
+
 	tp->prr_delivered += newly_acked_sacked;
 	if (delta < 0) {
 		u64 dividend = (u64)tp->snd_ssthresh * tp->prr_delivered +

---
base-commit: 09717c28b76c30b1dc8c261c855ffb2406abab2e
change-id: 20250120-cwnd_tracepoint-2e11c996a9cb

Best regards,
-- 
Breno Leitao <leitao@debian.org>


