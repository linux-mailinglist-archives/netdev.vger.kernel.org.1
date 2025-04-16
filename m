Return-Path: <netdev+bounces-183470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B99A90C36
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 21:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4968F175817
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8041B224AE4;
	Wed, 16 Apr 2025 19:23:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FCD154423;
	Wed, 16 Apr 2025 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831404; cv=none; b=BuIZ8JOStS2/qjq8bd1cCwcVK+bYWaIPDw830iNWhCmaczHBUzJRgIq1IIEq4DtB70TbPdhwgpwjar9lwayj2S8zJ1bBp4gGtSjPUSWYYs1fAZn6j5ren/UHT4XGMvej+6Do2d7sqzAn00+AjpM5xvh/jurkL3IzY3B+WvK/WAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831404; c=relaxed/simple;
	bh=zPqCUW5FHSqjS6mCQuOQEChLaLAlO+lp/lYq9RLrTzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FOUqqjsffAXN+51nQSoW8eKU+rewlIUfxPGbMTmcqG2KrDwg6DA4n3EIfU9S9iC/FV765CgOLzJOjr8cisCJ8/+e/PVO+i76zWttAjXxcJCobGR/2zWnY5tlmrBN0rhw0KwUcLybqTvQp9CItPLvobggYsXL7m5GJkOffIa3lIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac7bd86f637so218630966b.1;
        Wed, 16 Apr 2025 12:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744831401; x=1745436201;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+3YjreBtb1t7HHFuK5VkGfPxROKRBPNO1Zq1vct3O8=;
        b=dmnuFl9aSOVo6iIVYCgkg8vo8f6F9ZwCZ0VM8WcEJiSOf5IfZEuqV0qzvosZxN1+aW
         uEscudsJuFhE3YmG2eLsGtMBceUZwXS2bqAcm05qAQMbys5HLOehvLlzTGcgGlKbQPmh
         Aj9t06+voSbVAM4C+feYTaajpgOpWnXLLZFT/cYeExFjcraAXvT5QRSFakDAYksT0LGF
         OEzmyRgvHlc9bg82RB5zwfAmeJqKcxWSPRfQqCwo4JW9K4YwnUpRuTAn3eCC8WRJc0zA
         96tgfZucrhP73iK/ZTsYOGWi4a9pzae5cvsJrldGcy0XJeg+4in3TV3cANuWzNkiXAjs
         eCYA==
X-Forwarded-Encrypted: i=1; AJvYcCU3CnsMROywKzqw9tqKMxOYkYInpjebfVHlz23rIINmmk7SH9pE3CTzaI6k8ZfK7HPg2aiWfjcLCA9Vq+Q=@vger.kernel.org, AJvYcCXSR4L7atG5SFDvJ11XdLjqHPe+0y5b3PREUvvioe/qruxA7sY4brp1UAEAWA8txIZ/e51ZzkaVrhkMYIwmDbtr+Rip@vger.kernel.org
X-Gm-Message-State: AOJu0YwxE3fROHPa87dvpxhYdiiHNt10vZEylH4FZFqmUOsJ+Dk6hR0V
	v5Bj+yqP76NzaRDw4x8bBXT0jbhXHqpJF9FrnKI+Pjsf5MU7SXzj
X-Gm-Gg: ASbGncvWMjJq9tCW1XqQGf8v8778dZU+feqYLmxearcNAJillOLa9GY5eI6n0LqF8zX
	C8J/BLexPU8PIEDD9g05Szrgq+2SsM+Dju82awzwl/IgtvVt3CI20MwR36lELRkivKc041brB4q
	zJ9caG5C2Er57nZ0LzLtEDFoJ0IokFsviQXDjpEZ0OL0/NY1aL39XnaO2FK1+5Mf2I/cYabpdUa
	KjN6IDM8kdYFPVGhIkX8RTWXdVS9mqPhaf0Kz+X0qNZqklc2Wioz88ApB13zN6HvNIgERhKmOlU
	rX/CgVdzmXaIZZi0EVjKlAs4LrqAZkA=
X-Google-Smtp-Source: AGHT+IGQMO3jL2AvL1n5SrGgU9mNYlGlU4WDP29gPTWzOD0TR0zPHqZl4iaqNTPhegkYu2JzCMEETg==
X-Received: by 2002:a17:907:2683:b0:ac7:3929:25f9 with SMTP id a640c23a62f3a-acb5a6f968dmr7551166b.29.1744831400550;
        Wed, 16 Apr 2025 12:23:20 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f526ca6sm9216498a12.68.2025.04.16.12.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 12:23:20 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 16 Apr 2025 12:23:09 -0700
Subject: [PATCH net-next] udp: Add tracepoint for udp_sendmsg()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
X-B4-Tracking: v=1; b=H4sIAJ0DAGgC/x3MQQqDMBAF0KsMf20gRpOWXKUUCc3UzqJTyWgRx
 LsX+g7wDhg3YUOmA42/YvJRZOo7wuNVdGYnFZkQfIh+7JPb6jIZa33b7Px1LENI8VJiQkdYGj9
 l/283KK9OeV9xP88fJzC8gWcAAAA=
X-Change-ID: 20250416-udp_sendmsg-084a32657a56
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 kuniyu@amazon.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, yonghong.song@linux.dev, 
 song@kernel.org, kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1743; i=leitao@debian.org;
 h=from:subject:message-id; bh=zPqCUW5FHSqjS6mCQuOQEChLaLAlO+lp/lYq9RLrTzw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoAAOn5mbT3Nh1lezkBUwPc6nTkgWY9I8QADe/b
 NqF4nG2MDKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaAADpwAKCRA1o5Of/Hh3
 bRUxEACEhl0MyaNlAMl7LapBMzilM5wEZ5fhOFHKhqAE8PUNheAf4S/Q9nCrsoosZbMh61o92Wz
 tp2+6AJQUqKRyniBRgFXQAWyHTK0NXdoPaaFvsSkVwZLOlPf/MXMFWOPoCsw3iKIqk3hi5r3gp+
 t+uE4dqTK4hDCuTrGPKb0knrhgRA8d9bMxV/o4PdrRrc22ZpTr2dOTDCLEO0Wg7yimYSdhbElkH
 g1h9uaPXCdzr+HI7LRB1JnNhJinvaXdMLkOsar1UeEs3XHPl+ESA8ebjazSLbGv0nd1lNzaR661
 2yXJigRdERZdhvOZYPP6zhYxxWZeqtA5oFaHd0nQkqWCBB9X/ebR+ljRd7Q1PqyU1u/ejgVykCM
 RjvKrJXNBnyiumr0+yrqibPnfxWE2QvHw5kO3y+i72fHPithUtdy6GssMzfcNwA/HbVqkskXpXM
 NmCT7Tcuo0WwpvxSs/+GVaT1IHkjHyIyBgrNnFvtQpaKHTsC36sb3W/hJaqgPSkbeW9jK7t7vve
 +Q7je6NXTXFqS0BLjQK+vvLEt6J6qJuMq6I9RMCSsMDgR+vvxP9/EFEKySJBCfqlQBlluoJkzka
 mcxE9pB8J4Zf4AaNpTBRPF/V37XaVfen8AE4TbIvb4qQb64I4MTF8JaSJMMLto5a3x2f71b1dts
 EW3rcKHaoDjM4hQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a lightweight tracepoint to monitor UDP send message operations,
similar to the recently introduced tcp_sendmsg_locked() trace event in
commit 0f08335ade712 ("trace: tcp: Add tracepoint for
tcp_sendmsg_locked()")

This implementation uses DECLARE_TRACE instead of TRACE_EVENT to avoid
creating extensive trace event infrastructure and exporting to tracefs,
keeping it minimal and efficient.

Since this patch creates a rawtracepoint, it can be accessed using
standard tracing tools like bpftrace:

    rawtracepoint:udp_sendmsg_tp {
        ...
    }

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/trace/events/udp.h | 5 +++++
 net/ipv4/udp.c             | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/trace/events/udp.h b/include/trace/events/udp.h
index 6142be4068e29..38ab24053b6ff 100644
--- a/include/trace/events/udp.h
+++ b/include/trace/events/udp.h
@@ -46,6 +46,11 @@ TRACE_EVENT(udp_fail_queue_rcv_skb,
 		  __entry->saddr, __entry->daddr)
 );
 
+DECLARE_TRACE(udp_sendmsg_tp,
+	TP_PROTO(const struct sock *sk, const struct msghdr *msg),
+	TP_ARGS(sk, msg)
+);
+
 #endif /* _TRACE_UDP_H */
 
 /* This part must be outside protection */
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index f9f5b92cf4b61..8c2902504a399 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1345,6 +1345,8 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		connected = 1;
 	}
 
+	trace_udp_sendmsg_tp(sk, msg);
+
 	ipcm_init_sk(&ipc, inet);
 	ipc.gso_size = READ_ONCE(up->gso_size);
 

---
base-commit: 1d6f4861027b451e064896f34dd0beada8871bfe
change-id: 20250416-udp_sendmsg-084a32657a56

Best regards,
-- 
Breno Leitao <leitao@debian.org>


