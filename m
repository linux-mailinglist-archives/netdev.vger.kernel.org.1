Return-Path: <netdev+bounces-166512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C85A363F5
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 18:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1808A3AAC66
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74315267AE8;
	Fri, 14 Feb 2025 17:07:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94006267706;
	Fri, 14 Feb 2025 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552850; cv=none; b=N9yZam+DfXUM2IgXFcQ1kdnFno72kwbK+Yi1T208WuFiF0iC6yV5sKHrbppeT2/39m5j9LgmmEEsolTcZGYQTbDQ0k5tShpSY3CDPezlfuO0tWFE+RTHdn6gBLAI6HFKjYpUBHCqEh7yap+Ure3hle4c+jUpQocBtLXBtBZKunY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552850; c=relaxed/simple;
	bh=4lxofitPsYrHNm7bi3LfUMF9ZD1wJq6AEPk0sbeQ7X4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kur+5DEtF9KisLTfdtjkalsAi6v9Ks/Fz5Tkr6huueT61s2/QXJ6Uln5ZWRKHl9++yeHlCNZJ5k9d+5E/o8L0MeI+af/VTDq5yxNSGc0B5d/7b053kDnxoGRBq5A/J6mgG4X4ZCGdyWgHZRJJNCi0kduDOnASflBzzmV/nL1M4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7c501bbecso341665966b.2;
        Fri, 14 Feb 2025 09:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739552847; x=1740157647;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIrO4AUyyPAuiO56g6/OhKbTYoxtm/sXhUq9qEndj9g=;
        b=s2ivOP/SfA9XBnP/VYe7uSO+lY7EK0fh1TLPeKU70ltE8ecWOTqcAjLBO8pExoUjXn
         /vRnYH47Ttyv+Fs098CzYj4rDbHfnMJj25Qb8kK9DV975xRGxubtA5+kdBG8K9AjAnSq
         hH2QpZla/iPB0MZDyd4BG0neWc6wtun6uGTqqfv3owZ0zVsEgoueacxqcuwHKB47Fkkj
         Zk99bLSeHJbQ22L0h7wGOtEeoAT7gab4uptwqL+ImmTvCCZTaPsBZ9yhhsz1R24YlYVu
         4V2HkmTSxcZw68t0eSHoaBNUoNcoboyjuFvOPTfa/ifqwNIgI6wXYx+1gbLlDnT799rq
         xXfw==
X-Forwarded-Encrypted: i=1; AJvYcCUpV8mkIsSZ/2TEwx38vJdZNwCiIYTCw4FlPGG+dQF4L+oZTXTsGmqq3zvJTyucP9zYtz6yftdVEVtAN8U=@vger.kernel.org, AJvYcCWmVN6C6d3tQiUvC48TunXhWGOS9ZVPP+VhS3ONoK84k00bnY5FK+rfZ/SUtF4GFt9Nm9ssOgTw7n0gh6nRN/Dw4qsp@vger.kernel.org
X-Gm-Message-State: AOJu0YxM0eWGrzc9zB27XU1Yl7tGKn9f8EDcsjvEDaPEO1YvpXHFhSNg
	0SKj2rLpNmheWyJ81BlJsfu8yoLJQxVI/iP3Z3a4Jp0XagigFFxd
X-Gm-Gg: ASbGncv6hJlMnEZ0eEDz02f6KWL1xfKC45ibeARiY1X78tIvcvuzLB7Kb3eUNFUwj8V
	T2gfO58zF1ecKZT0ezXy14uoM5Xb+ZvCc7ir7qpCoUZTC3h6S5dtPgFUNKDEYmqflBc3CmBOaSp
	jJXH6NJofe6KyEIcdf1uuj1XclRH81NS8cA12npYBrO3gTykE6/nJwjcpAQLfVdM2ectwRiP7mH
	tCZAMElKvJ1Grg7FOR1i8L8Bvh9KoNUjkOdV8q7ACczZ6mDCytRAHRajYaDJ36XhKmAQV1xZ6dM
	EETvuA==
X-Google-Smtp-Source: AGHT+IGcx6b4t8RM4Fx7WnQoAc1OzmsxgOSJ23g5olNhu1HxNmi6drUByzGPykqu5+gR/vAUTGrLyg==
X-Received: by 2002:a17:907:608e:b0:ab7:e8d6:3b12 with SMTP id a640c23a62f3a-ab7f334500dmr1277008866b.1.1739552846600;
        Fri, 14 Feb 2025 09:07:26 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53231f36sm373755266b.33.2025.02.14.09.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:07:25 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 14 Feb 2025 09:07:11 -0800
Subject: [PATCH net-next v2] trace: tcp: Add tracepoint for
 tcp_cwnd_reduction()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-cwnd_tracepoint-v2-1-ef8d15162d95@debian.org>
X-B4-Tracking: v=1; b=H4sIAD94r2cC/3WNSw7CIBQAr0Leuhg+FkNX3sM0hsJr+zbUAKk1T
 e9uZOVC15OZ2SFjIszQsR0SrpRpidAx1TDws4sTcgrQMVBCtUIqwf0zhntJzuNjoVi4Qim9tcZ
 ZP0DD4JFwpK0WbxCx8Ihbgb5hMFMuS3rV1Sor/1tdJZdcm0GgCOasR3cNOJCLpyVNn0sVlbj8F
 qU2rRi1d9aEb7E/juMNAtsfbPIAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2815; i=leitao@debian.org;
 h=from:subject:message-id; bh=4lxofitPsYrHNm7bi3LfUMF9ZD1wJq6AEPk0sbeQ7X4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnr3hMt7hBwgflH6VNNshkd/HsByY3dQgcaq6W8
 Ybx3tzUfLyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ694TAAKCRA1o5Of/Hh3
 bVtXD/914iEFx6I/drSRqpQtHjhCkmfeynnlbBsXv0iOya/zzKL1lr9y7KSzQkuNaWmyhI1WfhC
 jfSCTXqAetgIcg3C3iBcN9jfyXleABjsQ0czTkd85Ab6JtPTyGFdP2dT5+t6E24hHVxA2Y2CAIc
 GqxXCxiqKEOeLlIOHuvaNNo3HhnZ6gwwwBFGFZhEBS6UF1xWslIDzEmWbmcvqiPTeksmP23MZbr
 6FFrFjcalHRDqoyhghjJnRC2Wcy3ToI8xX3YIMCni3gTCQprkeqc6a6VCGoK8Zz5wsz3+oW8idn
 hd64jNIfHvDQpU3eRQ19DW/w7hWS9dO03l393PvJHWwDH8MJk6ETRRB+dc9FhAgifXKvriVrsxq
 +7mHkiyxzoExm8riELtd3EyTrFBlJwCOE2uGXD/h7svW2Fj/a1/uxt90FHyf8rMsDoxrdkP16gc
 139je7c3YgM0hi2nt/Cizx0G7JOQjFVbGJ2CyvN0bYtANLv5cGHeNhuN3TT+/M90lD2/q4Kq34M
 2wBuMxzxPaxm6BNBc1Gz3GLumF0bQRWeB37thxPkDoMEB3OJGOUOpBI/quWc5YazP7/cnTFC+Es
 N7Mrkhc3CXJKHOArGHGm460fbOEj8lxvyBDLszx9YP8vbLDQAC0fp5nGxYkn8aZf+G0VLKmBiLg
 AOzz1t1iax5X1kQ==
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

Given that this patch creates a rawtracepoint, you could hook into it
using regular tooling, like bpftrace, using regular rawtracepoint
infrastructure, such as:

	rawtracepoint:tcp_cwnd_reduction_tp {
		....
	}

Signed-off-by: Breno Leitao <leitao@debian.org>
---
---
Changes in v2:
- Close the parenthesis in a new line to honor the tcp.h format (Jakub).
- Add the bpftrace example in the commit message (Jakub)
- Link to v1: https://lore.kernel.org/r/20250207-cwnd_tracepoint-v1-1-13650f3ca96d@debian.org

Changes since RFC:
- Change from a full tracepoint to DECLARE_TRACE() as suggested by
  Steven
- Link to RFC: https://lore.kernel.org/r/20250120-cwnd_tracepoint-v1-1-36b0e0d643fa@debian.org
---
 include/trace/events/tcp.h | 6 ++++++
 net/ipv4/tcp_input.c       | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index a27c4b619dffd7dcc72fffa71bf0fd5e34fe6681..1a40c41ff8c30a31b5c7002a4109de1cd8ef389e 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -259,6 +259,12 @@ TRACE_EVENT(tcp_retransmit_synack,
 		  __entry->saddr_v6, __entry->daddr_v6)
 );
 
+DECLARE_TRACE(tcp_cwnd_reduction_tp,
+	TP_PROTO(const struct sock *sk, int newly_acked_sacked,
+		 int newly_lost, int flag),
+	TP_ARGS(sk, newly_acked_sacked, newly_lost, flag)
+);
+
 #include <trace/events/net_probe_common.h>
 
 TRACE_EVENT(tcp_probe,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4686783b70defe0457571efd72d41ac88c528f7b..3f79718fdb1ec7a4352dc691147da527448c1f46 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2709,6 +2709,8 @@ void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked, int newly_lost,
 	if (newly_acked_sacked <= 0 || WARN_ON_ONCE(!tp->prior_cwnd))
 		return;
 
+	trace_tcp_cwnd_reduction_tp(sk, newly_acked_sacked, newly_lost, flag);
+
 	tp->prr_delivered += newly_acked_sacked;
 	if (delta < 0) {
 		u64 dividend = (u64)tp->snd_ssthresh * tp->prr_delivered +

---
base-commit: 7a7e0197133d18cfd9931e7d3a842d0f5730223f
change-id: 20250120-cwnd_tracepoint-2e11c996a9cb

Best regards,
-- 
Breno Leitao <leitao@debian.org>


