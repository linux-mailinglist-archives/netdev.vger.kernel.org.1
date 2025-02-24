Return-Path: <netdev+bounces-169156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB95A42B4B
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28AC188C617
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92092627E1;
	Mon, 24 Feb 2025 18:24:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25E3CA64;
	Mon, 24 Feb 2025 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421458; cv=none; b=MffrJtkDS5RLA2Y9qwtx2otw+CM3Jy1+FxaFbEhAeealcUWDqqAREEYLa4Lesd1NUryIPPKehmQQuW1tAEW+FVKyArVvQlB/v1bJ/OKRLCjYSl7SAPqyUcfrjrd4To4wHXu5h0ELDC6J+P3uy/fVgvQH9guq6ial3U6/kb4tYbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421458; c=relaxed/simple;
	bh=dgCErDO9h/N1MhFZbuMJ73o2WXT5GbPB62QPT4I7eZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HMp76lASZdkrkRxyHSs2UjA/UgE4i+qlEYTVx212w8METgjj0lV5T0PF5ZNeBI44wtzKFtUoAx6E1KjZ5eRjiw0n5mRGARsPLzIaFxf5sM0Ts7HTAfzmF/3Tn8zNr8YDQKpTvCZU/u4FjRviD/2+QbKPP0jSbQSbIq9nn3WmUm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso691884866b.1;
        Mon, 24 Feb 2025 10:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740421454; x=1741026254;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDgvsbr2nJF/1NmDg0ILx3mnE80A/MBTVeP5elD4IFU=;
        b=CGVxCQPnnBkOJ7CqTLzHNisISCcjLcIydM/0KnuUxnA0zsfPK/vpYEfENhtURwj8gd
         Hi4wQjzrQYzEbQ0FsYrUEsLJJ5Rvz6vp6n7j3/YwbteqSFXC9fq8+ltS3fLEsJQ2igKn
         uNev9WEt4JvcUuA5AVof4z/fopU8ivcEe8/jOQWm5xG17Y/U/G2DUxtwmtX7zMdym1SS
         5UoUKA3dWsulw5EXmU+EOUDHidAc63GJMw94bvM93TOA6DiZAJuh4HB4yjdxPCDgGwLd
         EeTveNlTqlWjqh6y8FWM0z3N1Bo0jhLEPg4pG7Qi4ocM8fScZweZ4kSop9nnO90M8Ra/
         UEeg==
X-Forwarded-Encrypted: i=1; AJvYcCWmkWdka6f/kKDkkRTNMeTG492SFu0hvYzkVMriJeJkxOcckbeoi0VUd0PrgqfnAoaqtCoHN0+VQ/OdiZY=@vger.kernel.org, AJvYcCXZTPND+/ol8+QJinas9A90pYW8pikLVLE6MS8sJkbxObmua02ezqDf9v0+7ZqyHYd5BNCpWePqAIKFvNiYbMEnfauz@vger.kernel.org
X-Gm-Message-State: AOJu0YxS83LSr5DDmAVyvVHZSiAO7un5HC7xL0ekxm4zC/hJFiCTZ0/V
	Ngw7iZwSme+DUsaYp3o8xwjBQmTUvrJUVPzVLzV5DCURaGDvpQz3Hkp5CQ==
X-Gm-Gg: ASbGncv6oewPb73LP+gqxBhiaKRaGibL2VcMyHmoV6Z3ZuLtj9iYpVw+EnuyN/E5cIt
	d9ODt6OJ9F4tOQLTb0D0FzL5ousFahFUm2TJb0MifeyWa1afbG+xQWiL0WyoPi6drmz+c5nLqsL
	5mOdiJlSb5z/W7TYMigV5Zu297TIcaxOEFEQyWisxE3WAJWbqDYx3VgcX6NoW8Uzmh9f2H48iUl
	9bu+tGwrNGBxMuH3/6WrdhWfOm01IbHqqOoH0SV0TUn3NE9jkp61NXJtrSGwboCCLyoycane0Qw
	PDJmyFN1NOLFSflb
X-Google-Smtp-Source: AGHT+IGb9a5KiU4eh46EzYb11zjfrtsNUt03A/cJP59RsbPayUyNo5ZwvCc1M+kTO0wUSEZQWm1TyQ==
X-Received: by 2002:a17:906:30d4:b0:ab7:ca9:44e4 with SMTP id a640c23a62f3a-abc09a0c527mr1331674066b.15.1740421452942;
        Mon, 24 Feb 2025 10:24:12 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed205c42dsm856466b.157.2025.02.24.10.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:24:12 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 24 Feb 2025 10:24:00 -0800
Subject: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
X-B4-Tracking: v=1; b=H4sIAD+5vGcC/x3MQQqEMAwF0KuEv7ZQo47QqwwuxEYni8lIU0QQ7
 y7MO8C74FJUHIkuFDnU9WdI1DaE5TPbJkEzEoEjD5G5D3XZXSx/fQv9GmfuXuPQ5hENYS+y6vn
 P3jCpweSsmO77AdWIxO1mAAAA
X-Change-ID: 20250224-tcpsendmsg-4f0a236751d7
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, 
 yonghong.song@linux.dev, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2057; i=leitao@debian.org;
 h=from:subject:message-id; bh=dgCErDO9h/N1MhFZbuMJ73o2WXT5GbPB62QPT4I7eZo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnvLlKk0sulahuIUUdM5a55NOEhMNrmM3KHpc4I
 0E84Ekur7eJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ7y5SgAKCRA1o5Of/Hh3
 bZMgD/9ClXylX0rlWBqAsTmSsnAmkkZj4S24/KxUbRs2G+eVJ6LLWGo3dcE14ZjlqqrYJZArkjg
 85zwWXq/zd5cp8nMVoX664zZiLo5VAybfE9UoVxfxHNBBDxuEZ9wNJ49ZUBnIeqkJaF/S/M9gQ+
 cYsZ0gAX3Ytb8T8TcsLxTBdAemLSTOmafbOecb6thMqSnl977OwfJeMTcGuEsoq9jsYoR7TLwEA
 Z5ca5WLzRZmKVQYg3obOFYaGG+2ApD3jifQxbQUcJ2UGqZd80kcLdtOHvqdTdb+qkAefVaABdBx
 JrKiXsAVcHpJgVY+J7Bq5Y+21BO2t2D+HPvhmL9dxwTnOZxl9S82SuSZSzkhcbyXKAflgN2pST+
 hT3uWl8Blwlimu/L7O8bfDpBzwbYErCrtOomTUxshDo3PXVmPRqY9m3YLJZ+RpY/nmWP+IJnAuc
 S3rGLDEn0NJ1Ze1Y+4KtaIjWl3DajQvQ0dhGtaKe9HFyxFy0z1aZdMNNrFhITcHcW8d2tukvA5T
 Kr3H4jBFntqyj0ee8ssO9/d3WEHS7qBm7XrYPASAim+sKktmUa3GcS5AE+7+ZHmacFXqJxDBAWE
 TAMWOi2ShnvalXNnjbFBwub6BcH6Ni2suyiKfpTubA5f3kgD96gNU8BN84180eDvYnyxXFJnbCG
 rF/yBzLo3HTv+uQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a lightweight tracepoint to monitor TCP sendmsg operations, enabling
the tracing of TCP messages being sent.

Meta has been using BPF programs to monitor this function for years,
indicating significant interest in observing this important
functionality. Adding a proper tracepoint provides a stable API for all
users who need visibility into TCP message transmission.

The implementation uses DECLARE_TRACE instead of TRACE_EVENT to avoid
creating unnecessary trace event infrastructure and tracefs exports,
keeping the implementation minimal while stabilizing the API.

Given that this patch creates a rawtracepoint, you could hook into it
using regular tooling, like bpftrace, using regular rawtracepoint
infrastructure, such as:

	rawtracepoint:tcp_sendmsg_tp {
		....
	}

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/trace/events/tcp.h | 5 +++++
 net/ipv4/tcp.c             | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 1a40c41ff8c30..7c0171d2dacdc 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -259,6 +259,11 @@ TRACE_EVENT(tcp_retransmit_synack,
 		  __entry->saddr_v6, __entry->daddr_v6)
 );
 
+DECLARE_TRACE(tcp_sendmsg_tp,
+	TP_PROTO(const struct sock *sk, const struct msghdr *msg, size_t size),
+	TP_ARGS(sk, msg, size)
+);
+
 DECLARE_TRACE(tcp_cwnd_reduction_tp,
 	TP_PROTO(const struct sock *sk, int newly_acked_sacked,
 		 int newly_lost, int flag),
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 08d73f17e8162..5ef86fbd8aa85 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1362,6 +1362,8 @@ int tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 {
 	int ret;
 
+	trace_tcp_sendmsg_tp(sk, msg, size);
+
 	lock_sock(sk);
 	ret = tcp_sendmsg_locked(sk, msg, size);
 	release_sock(sk);

---
base-commit: e13b6da7045f997e1a5a5efd61d40e63c4fc20e8
change-id: 20250224-tcpsendmsg-4f0a236751d7

Best regards,
-- 
Breno Leitao <leitao@debian.org>


