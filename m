Return-Path: <netdev+bounces-43025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEBD7D1008
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0EC1C20ABB
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F56A1A72E;
	Fri, 20 Oct 2023 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rH18xUSq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7791CF9E
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:58:10 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592D19F
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:58:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a8ead739c3so10382847b3.3
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697806688; x=1698411488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mLjUl2aLCrBiziD+kk4oN1wvnlfj1PdIazDKJ7fmS4k=;
        b=rH18xUSqTCqCeATyO5XxCtTVlepQIixFmpw0fnqmmhgzqeUoTBmrvepstpsKwZsYIf
         RAoLVycBIEH8iJVo8R9tqFbFE1g0P9nAlY8s5tXOhGHYgKZCX0BEVIe/biNfAzNtOVZ5
         YpBKou1b82vaXQVwG/bI3CD9ztKfCobiNL2ZB/p+iPTRnw72Li3+8Jfd9v0wqnOlFFNS
         BPF0BceWNOxSjrjJ8Xy020HFkUvgOweCDOcXxbhLcVvUpbq96mKCk9XKsumU0KCS6uih
         CQAHrRcqFt8N8QyjBD4LYhiQEjL32YRxN9dlvJz40bRVGV3UCZQz6/H0tpPAm3pamkJz
         NYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806688; x=1698411488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLjUl2aLCrBiziD+kk4oN1wvnlfj1PdIazDKJ7fmS4k=;
        b=xTk41K4yyS9YqYoNn6oYsyfQhw3vxFpWLlyOYow9VJyR++oCvc1uNaKljApAYThnv7
         A1Qq9y/iCt+aImL+/FDVJk8UtB5nH8ZItjOKZT0bj/m/oqfNEyD+o3NNaO3O6XCMj/Jj
         45hvc5xH2zmtJbgGpiMDmPN3zbatbpNgR+TxoeBnBZBHkWQuL/DTEvr4ynvZ/35oZ6pl
         rz2S03MXeJFjL+sgobc7cv0upv16VWB5kRv8Yar6lNGI3UnaXP9gIe4/puBBHekK5OCE
         jsn4E9IU9WYwx4hEBEClYITWUq9dfe6TqcpsbADDq51U9PNNeyLuYVr/DipAg/lvT8yT
         eBpA==
X-Gm-Message-State: AOJu0Yw8YM9AsJ+w1FxTeGLTdOlOgLYFQj/LJCfcU/jt5wqPLEmbxCtm
	c0glrkqobtydiRqlxrsfRb5D2h+E0Prucg==
X-Google-Smtp-Source: AGHT+IHwTN+xExcqGxom4btXgP/Q3udX3wplmnVefAwlEWDoTbSqZTiv162iIYjgJHBM0PgoA7H7LupPox2KPg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:dd02:0:b0:579:f832:74b with SMTP id
 g2-20020a0ddd02000000b00579f832074bmr41771ywe.10.1697806688543; Fri, 20 Oct
 2023 05:58:08 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:57:46 +0000
In-Reply-To: <20231020125748.122792-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231020125748.122792-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231020125748.122792-12-edumazet@google.com>
Subject: [PATCH net-next 11/13] tcp: introduce TCP_PAWS_WRAP
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Wei Wang <weiwan@google.com>, Van Jacobson <vanj@google.com>, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_paws_check() uses TCP_PAWS_24DAYS constant to detect if TCP TS
values might have wrapped after a long idle period.

This mechanism is described in RFC 7323 5.5 (Outdated Timestamps)

TCP_PAWS_24DAYS value was based on the assumption of a clock
of 1 Khz.

As we want to adopt a 1 Mhz clock in the future, we reduce
this constant.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index af72c1dc37f3dd4cd6858e9c8f6aa7ef31541652..0ab577869d7ac61c5c3b687e98068a16b69bb3af 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -166,7 +166,12 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define MAX_TCP_KEEPCNT		127
 #define MAX_TCP_SYNCNT		127
 
-#define TCP_PAWS_24DAYS	(60 * 60 * 24 * 24)
+/* Ensure that TCP PAWS checks are relaxed after ~2147 seconds
+ * to avoid overflows. This assumes a clock smaller than 1 Mhz.
+ * Default clock is 1 Khz, tcp_usec_ts uses 1 Mhz.
+ */
+#define TCP_PAWS_WRAP (INT_MAX / USEC_PER_SEC)
+
 #define TCP_PAWS_MSL	60		/* Per-host timestamps are invalidated
 					 * after this time. It should be equal
 					 * (or greater than) TCP_TIMEWAIT_LEN
@@ -1619,7 +1624,7 @@ static inline bool tcp_paws_check(const struct tcp_options_received *rx_opt,
 	if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <= paws_win)
 		return true;
 	if (unlikely(!time_before32(ktime_get_seconds(),
-				    rx_opt->ts_recent_stamp + TCP_PAWS_24DAYS)))
+				    rx_opt->ts_recent_stamp + TCP_PAWS_WRAP)))
 		return true;
 	/*
 	 * Some OSes send SYN and SYNACK messages with tsval=0 tsecr=0,
-- 
2.42.0.655.g421f12c284-goog


