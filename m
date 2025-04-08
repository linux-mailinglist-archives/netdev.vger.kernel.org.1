Return-Path: <netdev+bounces-180430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D606DA814AB
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56957887426
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E930A241691;
	Tue,  8 Apr 2025 18:32:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257C23ED72;
	Tue,  8 Apr 2025 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744137141; cv=none; b=LjuK8mH2HFcwMpzVqEXCV0gJFHHZftmR+ylfBh8QtKN8GKoBjN6++vaVPlcbSH7g9owBsZ4u/5kVBRuOGDIRGwx7wmim4zefh8MRswiboGrjAz9/dcTGGJlwSDQvGin9GKGChycAja45hUrvcenpKIYYpijSNrFu4su5M0Mgz8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744137141; c=relaxed/simple;
	bh=rQ8hyR9oiHg2KsZ+lDVGyJ4BSv0od8Sa7HW79HCLVwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UUoANgISQKhYD/6kCLNtUH2YelLDOpOF9eiOqUSrbpSvPgoHyhKWT3MyZ6pTDi5hr6a7gOn77Xyk5rqh6iyCnYnaVnX2+Toq52ldd4ISH53xXNJrDJTMCFoNEwWB5lPhgOjZZAlK6qdRrtGMkwNTaVmeI8AibHxGD4uf5+kj/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso1054019566b.1;
        Tue, 08 Apr 2025 11:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744137138; x=1744741938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhY4Z3oAJKd03SrzATbzNjahPXsmuoOiwYMLC9powFE=;
        b=uWDCWFNkUL2umIk2xs/FUVxJFCrVTKlpBmerCEf2DJ01cLc91JDlgkn+ulfH1MxVII
         Zo5/35IxM1sbmCCCmbbf3yT27vDJb33HNajal6r0TpZvhxQw+Ivq0wo/ZkQ/OgCbc0KP
         5Q7kLX+QC1kjdPi/e24meosU+fLIXRLS1RCuUK3ZmFvdvSeiveVlJoDMk29wSCp8Bjb7
         WKggaKIgbKUFuqSL+WzRvNnSuIF1K7ma3k+usWu6ztdA+WZ6UcJ/4MssHxwmFwftglo7
         wAFVMtT53a728Sxz5sPcgzeWfWsrEQKpN2p2lj9Osf+SIqCIomjjaU2HuX9TFxw1p/HH
         1G0A==
X-Forwarded-Encrypted: i=1; AJvYcCUfuoBFeHsByEHe61irlXs+yKSY2NCVR7kkG7SC9JFWs9uhPMu5huJPGv/aXLTqI9DpGEGyMKfCXnOO3h8=@vger.kernel.org, AJvYcCWNwgzHioHRng/5Omnnkw41wUnRtUPvQEnh/fLSWoF65m/YpRU2mJo3INuT7WVZk9c4MqRyD0Da@vger.kernel.org, AJvYcCX3N8Tidi80/WNtGz7k0fIUzi3DF+MaIJ7d24qrsve5ZpKHoQ24a5s0YBG+hHjN2aSUse4VPbWLao5N20noSXmhgXgA@vger.kernel.org
X-Gm-Message-State: AOJu0YxHQ6JzTq8+HQ7XhbITjC+is6KCbcvlb4AyzoBxxLd6r8yozklE
	XBz7t444tAC7aq7281KxBRf4RGl4GCS8l0CYiGf5liwJaSXCupPJp81DnQ==
X-Gm-Gg: ASbGnctA0Q6QF1R+Bofq2i6qE/4j7OWOfWu+lhQPABIDq7VhZizF9/1C9uj6KrVkHmf
	swkn2arfs735KELg7X3IJ9g1732lwcaBwhlPKoi0iwZ4QGkoTFrplPfAAgQGq+MZ2JkdrzK5WFq
	FE4DnV9uKkV38qDdUCGcU5+Ic5BDGVv5l/3A02SdFrp4q2Lt/HUQI6T2AD3MOMEbVl508oI5r4d
	ZoLY1NvG7D/htxrzwYEWZTEBc/gR/Nie1X5nRb8gUOKaunWhji9YgUJWLNge64B+PZL+lqgItaC
	p2vtr7X8P/LigyKMknI7aM4ZMz+vFtjaCoSj
X-Google-Smtp-Source: AGHT+IHrblW6iKvZrDCZZnVsYdIASQfGNg4NSLAsnEK7X08Y/yKOXlfNqlhnRhQefJiJdtPrCRXYeg==
X-Received: by 2002:a17:907:7f0b:b0:ac7:b8d3:df9c with SMTP id a640c23a62f3a-aca9bfb1039mr10321366b.1.1744137137777;
        Tue, 08 Apr 2025 11:32:17 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c01c2ce0sm964609866b.178.2025.04.08.11.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:32:17 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 08 Apr 2025 11:32:02 -0700
Subject: [PATCH net-next v3 2/2] trace: tcp: Add tracepoint for
 tcp_sendmsg_locked()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-tcpsendmsg-v3-2-208b87064c28@debian.org>
References: <20250408-tcpsendmsg-v3-0-208b87064c28@debian.org>
In-Reply-To: <20250408-tcpsendmsg-v3-0-208b87064c28@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2727; i=leitao@debian.org;
 h=from:subject:message-id; bh=rQ8hyR9oiHg2KsZ+lDVGyJ4BSv0od8Sa7HW79HCLVwc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn9WutKMiFYZp21UHtkEtORTCNKpJYNNjokz0CC
 /DzeChP98OJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/VrrQAKCRA1o5Of/Hh3
 bZgND/99YiH/dd+FiIPywZsKOzA3EDGLQCw5AjD8k5DllLCIZcdQVnPV3LKL2paa2RScNtSe977
 0fN2CbyPteQhQ2UrO6Fu0aLIs2TXSutLumQj9h3sZBLCKmoZ280oeeGczwL/Hl99Jycy4Fxh8fS
 WZtFnVj+lO/Y8ZZrlmVqbA9aQG7wDk1BelsQXgKwoaYZ9t6efYvfzGRmEJUGD8axm0vAQqTI7kz
 zYFjzaR40LsHLDKncuynhgW1TNbvzJc2pKZ8h89dlgfpLBYcdFAeVFF2Vr+Dhvo7nmJW9DYWSqP
 J8T66A3kjny11xZcBHLqU2M1AT1brf9o7vNkVVBCkhgB41aWOqFsORU0EKPiU+Ie3ULIXk+qhd8
 7tYI+AZ/wYlPJP0zCTmM43qWffjK/q+GRsnJXpVqlXJnMpMrzCI9mqi4BGe3PLKIhOfiTFP+YsQ
 sTacz+/FnhQyc1CjYzpr4/udXCRplhajAHwzac7DEW3DkJ2BV3VkrruntA+tAl+dXkz8h9bJ9pX
 7MkNT7V7ZQPTa1Z+0IF958H2Xe3ZIaCDrWmCv+mU5aorGWxRJ1FpGZZ9qbERJkUyjOLa0WX9l/+
 yDUFa4BDWhkZiNKMMpvTWoWqVXr9leWNO5qVepIrVo4tK3VjPzAsbpwhF3he0KWXFqxlQdizAXp
 5GIzx5PscHRZLHg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a tracepoint to monitor TCP send operations, enabling detailed
visibility into TCP message transmission.

Create a new tracepoint within the tcp_sendmsg_locked function,
capturing traditional fields along with size_goal, which indicates the
optimal data size for a single TCP segment. Additionally, a reference to
the struct sock sk is passed, allowing direct access for BPF programs.
The implementation is largely based on David's patch[1] and suggestions.

Link: https://lore.kernel.org/all/70168c8f-bf52-4279-b4c4-be64527aa1ac@kernel.org/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/trace/events/tcp.h | 24 ++++++++++++++++++++++++
 kernel/bpf/btf.c           |  1 +
 net/ipv4/tcp.c             |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 1a40c41ff8c30..75d3d53a3832c 100644
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
+		  __entry->skb_addr, __entry->skb_len, __entry->msg_left,
+		  __entry->size_goal));
+
 DECLARE_TRACE(tcp_cwnd_reduction_tp,
 	TP_PROTO(const struct sock *sk, int newly_acked_sacked,
 		 int newly_lost, int flag),
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index eacb701bc2be2..475a1317ad275 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6518,6 +6518,7 @@ static const struct bpf_raw_tp_null_args raw_tp_null_args[] = {
 	{ "xprt_put_cong", 0x10 },
 	/* tcp */
 	{ "tcp_send_reset", 0x11 },
+	{ "tcp_sendmsg_locked", 0x100 },
 	/* tegra_apb_dma */
 	{ "tegra_dma_tx_status", 0x100 },
 	/* timer_migration */
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


