Return-Path: <netdev+bounces-179653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E689FA7DFDF
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 15:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DDC63BC503
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BD11AC882;
	Mon,  7 Apr 2025 13:41:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B381A3159;
	Mon,  7 Apr 2025 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033263; cv=none; b=Wa/E3HvBuM6gcDFBxzxfHexKJ8ZmUC6hg23yiDvQ8Km6jGVThT+xd8EDxIoOMrvcmVmfoKHSzC8qgx+XB1q8fz1Wh0FkYO4WlVbETaTvCVNY0yG0I5KvaDeV3B1kA0tYyol/YuQOJO9co1Ke63EBTFklGk+7pwRmgl9LyKy4/w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033263; c=relaxed/simple;
	bh=9Snlz9SuT/2zVOUbuDlRK3+VEmBqQ+OGh127cCQOO90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kfNoSotXyIbZNR4nw5wJldJXZ9Y6N6bYwQyAUr65qAO1ZbD48oF6JrMcd6sGpoYkF8Sz3NAZ62ZGDzT+pRMEDeFH20vb4kWrRQXrKK2oPyqs6tS6aWJxHimkNmEC2f6QEyYDBCClL2PGjMXuUTv3hkN/rtgrWCxSb3+KvK7J5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abec8b750ebso743644266b.0;
        Mon, 07 Apr 2025 06:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744033259; x=1744638059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVubAsI/sazCBkrI5SX2ql2bcxDP/IcO0dwkdrXNHWk=;
        b=SuIhMtlfhIU0/E8WLNSUjCK375Nz6O4Ataz6DWyy18n++WObXRlcStGiSxiQ1K0nGp
         p5nByvUwVf+yxYE0AQ1FGZh+exglfHjrUItCkeScSXuP0tY0DnG6nUeymc6jD5meefuM
         IA5v2bGb89lBBhvuOHtyenFAfnVBzNNfp7HzOnMPtaTmKyGySuHqoHRJrUVDogj0tpFP
         NZDMqHT6YE5HDi1aKCYQX1tVmxlM7A45b3pHY3NOY2HpIgLA8qh7BQ4oDtuuK92TQ1hG
         5lM4OT9xPdUSvWkOItwbw/YAQmKMOIlAeXjIKpfF/e8MzP5GTonXyvlSLtczH2FIdoK9
         6aaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9wGLC6vZD2dIM5bi6etLjB8KrWFuX0/LjaaMLhXSf4uilc6IKhH9TWOpRTPyHvG8WVJq1E/9rBky6AHk=@vger.kernel.org, AJvYcCUuYwBQN41bl+gCBeCQJN7Wfi48nq266uWds6WtfaPHSJSKbUUIfPt6SnJAgGXO6KZV3GObvnOQ@vger.kernel.org, AJvYcCVszfRnSBBwGnsQ1q9rpH0YeOSOCfGRXoXRhT3ct9jpYmS4VwMbbQj0z6NQHnqu3T4yfw+N9xEDjpD1aB+kWfKQf1qS@vger.kernel.org
X-Gm-Message-State: AOJu0YwCpQXveqdxFnGNnxpGGY3+4BkmLXtiFbJo/hlXVMBmEi2LefR9
	RVlE3KOZY+Nft054fTSCCtmv8fxbBqkm6PctFeDMuXmia2i4OF96
X-Gm-Gg: ASbGncuP9uGCgczTpE7xx8ip2BDhfzZgyrgty3cRePwMmxBtFYQRYtsk5/sSwjDIBVY
	83RmHsYLzicz+wfWCTckmkQIInk69AecHsg0b5py78+lA9wdZCpr1roLdN66tg8US61e/UWB8Hy
	nVuGlq5+sodbR5ziRwTsHK6xIFWj9806JdUIcUek867G7K4Pu+ItBTzlw6oFbtMXBHfs58nZEgQ
	I6XzQ6xk1rh6ffTkFScy2bx716yYKzZ9/2e/Hr/FJMDzemySUSTt7t+IUdlDEzj3MS1EsPhiQId
	qSFBTltNhAG62iYdsAdLw99EwdXEGlC15Cc=
X-Google-Smtp-Source: AGHT+IF+MJUEj4ylRMNfJTbPqy49H2qRMfeGGoj2a2yX7f5x8Hmh+0VIMpyCZxIblLCvIFiCS7U/rQ==
X-Received: by 2002:a17:906:6893:b0:ac7:eb12:dc69 with SMTP id a640c23a62f3a-ac7eb12ddbcmr630993066b.28.1744033259025;
        Mon, 07 Apr 2025 06:40:59 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c01c2c13sm736933266b.182.2025.04.07.06.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 06:40:58 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 07 Apr 2025 06:40:44 -0700
Subject: [PATCH net-next v2 2/2] trace: tcp: Add tracepoint for
 tcp_sendmsg_locked()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-tcpsendmsg-v2-2-9f0ea843ef99@debian.org>
References: <20250407-tcpsendmsg-v2-0-9f0ea843ef99@debian.org>
In-Reply-To: <20250407-tcpsendmsg-v2-0-9f0ea843ef99@debian.org>
To: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2337; i=leitao@debian.org;
 h=from:subject:message-id; bh=9Snlz9SuT/2zVOUbuDlRK3+VEmBqQ+OGh127cCQOO90=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn89Xm6WKbyYT0sJgsO43vaNk9WcRK93pVnUImt
 2QOQanw3NiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/PV5gAKCRA1o5Of/Hh3
 bUivD/wKJNR85jn7cXDGOI1OI4PfopcoBlrmcf6IRm6ZB8zkgQHjA6Q9UiLPVBnzjQA7rfTJcwv
 J61ZLLAQpYe9YXgAN4r9P+Fwj0LP5kr2XkRJDC0w/NUpCMDDv1gmK1VCNE79kfa672yCczrYD8I
 IS8pmCtJuHOQ/F0rijx2tAFYzcOsSr6BSlhsBfyHsLDQw1SHSJsgGspHjfNfXZUm1BadXkhPz24
 jcP90xBlSiv4awliby+XeKP5oATFyG4VNEgvoWJBjLkmwgc/1r35e57J5JmYo2fMY7hNau2aGxW
 hU1duDV7wVLuJo26FSPPlKrKQqFCMhqCSsB7FCOSE8DrR03AUjRooacR1NfKi5NAIEfTfPYz020
 jgojVTcqcWVddMiIwEFSP3mmgyfGHkw9l7OotMkUic+tnoK1DQlvEuO2VMBlrpb95obpITzZBs5
 NaPmhzL4n8BtUV0u7s66s/rSjeep3BKh/Wr/7zYKn8ESWorXykP9oFNkauwSun7gSlDuIpECc0F
 K2kd58Bqy3kUJUyMCwzwhLsjzI8HI3DYeOdNZN+/TdbhbknwnQZFhFXB2tsi6qcD00JXGr09Xst
 f/4NtFp36LVojqJ6C2ycqwItU3GYuuB3NHx84LzTbZp+bQ8ml6fOQRm36p99jWyTYpLaDVloqn5
 jc4sguOmySEjKEQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a tracepoint to monitor TCP send operations, enabling detailed
visibility into TCP message transmission.

Create a new tracepoint within the tcp_sendmsg_locked function,
capturing traditional fields along with size_goal, which indicates the
optimal data size for a single TCP segment. Additionally, a reference to
the struct sock sk is passed, allowing direct access for BPF programs.
The implementation is largely based on David's patch and suggestions.

The implementation is largely based on David's patch[1] and suggestions.

Link: https://lore.kernel.org/all/70168c8f-bf52-4279-b4c4-be64527aa1ac@kernel.org/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/trace/events/tcp.h | 24 ++++++++++++++++++++++++
 net/ipv4/tcp.c             |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 1a40c41ff8c30..cab25504c4f9d 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -259,6 +259,30 @@ TRACE_EVENT(tcp_retransmit_synack,
 		  __entry->saddr_v6, __entry->daddr_v6)
 );
 
+TRACE_EVENT(tcp_sendmsg_locked,
+	TP_PROTO(const struct sock *sk, const struct msghdr *msg,
+		 const struct sk_buff *skb, int size_goal),
+
+	TP_ARGS(sk, msg, skb, size_goal),
+
+	TP_STRUCT__entry(
+		__field(const void *, skb_addr)
+		__field(int, skb_len)
+		__field(int, msg_left)
+		__field(int, size_goal)
+	),
+
+	TP_fast_assign(
+		__entry->skb_addr = skb;
+		__entry->skb_len = skb ? skb->len : 0;
+		__entry->msg_left = msg_data_left(msg);
+		__entry->size_goal = size_goal;
+	),
+
+	TP_printk("skb_addr %p skb_len %d msg_left %d size_goal %d",
+		__entry->skb_addr, __entry->skb_len, __entry->msg_left,
+		__entry->size_goal));
+
 DECLARE_TRACE(tcp_cwnd_reduction_tp,
 	TP_PROTO(const struct sock *sk, int newly_acked_sacked,
 		 int newly_lost, int flag),
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ea8de00f669d0..270ce2c8c2d54 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1160,6 +1160,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		if (skb)
 			copy = size_goal - skb->len;
 
+		trace_tcp_sendmsg_locked(sk, msg, skb, size_goal);
+
 		if (copy <= 0 || !tcp_skb_can_collapse_to(skb)) {
 			bool first_skb;
 

-- 
2.47.1


