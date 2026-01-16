Return-Path: <netdev+bounces-250444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06887D2BB9D
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 06:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D88330198C6
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 05:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3CF34CFB4;
	Fri, 16 Jan 2026 05:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Anb1f3io"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC2426F28D
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 05:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768539804; cv=none; b=Gpon7kcHfesFmQzRBB/4OarfX7tHH/scnuc7jDBWlI9B9wS1/Eq5w8GOgBSVSVxtj+tN6MYokPBmIvnMMaKNXUJhClxQjiilYVd3jwQD0V6qZvn08XCsxeOWq8GU2cEjbkwbVqpLIdipI+GXJFCGK3ysleFbJmcbIZwfNtT618k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768539804; c=relaxed/simple;
	bh=/8irlWx212MZNFNuTQquG/o/4qXs4GzUcqgDeIkWkeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EIklChtzK+q6CGhlprvDPVM+m/5RwFlMA/KIjU1Yh9pP5XT9pv59EfVtqux+ODQ4h79qPToqXoOWRjBC1SSf8nLwtrFe+6BpkR2kAsCyxI+zr8AFpVTtZgHtWZUZCZgZCb/ytRaZV+WYnGbjaf+xNjKwScZu1ZEUF5EQPmwTOfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Anb1f3io; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7927261a3acso16912497b3.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 21:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768539799; x=1769144599; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJwRH55S+4zS4rc7LIeDbyFWVKjFx7zOxvxC4DTtZFU=;
        b=Anb1f3iovHiDvlnpirku9R6ubteBBL791YYQz+9ZbGJ0zxCcO9CFupB7IEa4Lkld6b
         AYZSFNHidrxVDodoR5m6s86G/8TftF/m6AYTQVWQd+5OYr1CEojeyJ1mCBTHCh1Z2Xbq
         4OupmM3Ci3yGW5Y3eeSWx6hV3vZXVTiq3FWUc7YvysxhQhrU8NJSqLsKQ1w4yv1w2Cg/
         GMnf0VgWpzpqY9LdyhxcX7z3XKRzTB0NjzY/2xDzuobIn4/mE08a0WK4I4XzrxNc/3av
         JyQKQocsgd/untpIK9cYlIQeYhV5ce9pb6F4qK4eLGzHB3shm6yyygfb0+ahNxmk8KW/
         CdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768539799; x=1769144599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vJwRH55S+4zS4rc7LIeDbyFWVKjFx7zOxvxC4DTtZFU=;
        b=LInKFV6n2woUG/06W7j9u/zxvCGof/QAMYYvAgX809NhG5TZ0DhqIll49CTYvGeOoT
         wTcZCsWQr2OmE98AJIHd8yTnuz46OSNgL9JcSRZuS/ceJpb9qLGjroiBTEYbC4BYEU/1
         xpPcUacGbkipjY7IduYQeM/KGhUuzOMHCuvXl9t7yl47wwrr2UwHSM2LY7LaOizHNSU1
         ZrcSfvelo1PKg0OhmZo3MIkgIuv3MXVMIOu7cohHF1SrXoZ5T0AQftE/9xQq3Pk6Kt42
         GJvw7v2CiM3qDjVJEiv7KvgCSSMz+pHuQQoW2ZqAlLp3DvcEoenveqzmUGj2zOafXNpl
         ytig==
X-Forwarded-Encrypted: i=1; AJvYcCVjIj97C2aXbC5pgHy/gXuK7FXeO1eXuRkXZlThsEQSMBZw4ktzJ9dhAYU/MM7Z/DtsEn8ADHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcCD+C841ylIpP0Euds1Amjo5fDBaOs+CxArG5+jMt3bJZ71OJ
	oeOroHzKEdZNBb5zaTxwO7KaQIAXphrQ4xfHOaDImY6NiqqxXi+/vjES
X-Gm-Gg: AY/fxX6Olpfwoj5OAryGFJWgvGgD9TK/p+Ti4paIzP5Zte6cc8Y2C+WhTq9b4vlSNJF
	7M2JHEXyy2rfZWb15Wwv3WgERKSlduQJT5twIHKwneBTBz7xJTt9F99GK3wsh68IxeZgE7d3Hic
	2KxoY2R+q5JqJtayjk11+Df6qzfASsFCQHezSnW4/Bt2yMiHkt0lKKJnlbYZExHd4UcGYxrp8LD
	w0OEgT8YGT+seootWSMLpV+S4LLQrEGNYr0L4tbNPq/lJaT7yhgtnCI+EAQJ6RtoxwdHq9EOapy
	PfyFFD1uNV4wbHZE5HTV7qxi5Ib85jPYsYsiU0gp1wpp1fKHi45CtOTkUHs+yyt0Rexbyf76t0H
	+l+Cod5Xbnr2ySWJ8jzUhDnZUJPVrd5uhWWji5z7oHFDoyIaHaa3vPPXBwm7nFnWB69NwveVr6c
	6Lolw/yTGKjA==
X-Received: by 2002:a05:690c:4a07:b0:787:d0d5:808e with SMTP id 00721157ae682-793c682d2ebmr12993417b3.50.1768539798910;
        Thu, 15 Jan 2026 21:03:18 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:52::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c68c31dfsm5205817b3.51.2026.01.15.21.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 21:03:18 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 15 Jan 2026 21:02:13 -0800
Subject: [PATCH net-next v10 2/5] net: devmem: refactor
 sock_devmem_dontneed for autorelease split
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-2-686d0af71978@meta.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
In-Reply-To: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Refactor sock_devmem_dontneed() in preparation for supporting both
autorelease and manual token release modes.

Split the function into two parts:
- sock_devmem_dontneed(): handles input validation, token allocation,
  and copying from userspace
- sock_devmem_dontneed_autorelease(): performs the actual token release
  via xarray lookup and page pool put

This separation allows a future commit to add a parallel
sock_devmem_dontneed_manual_release() function that uses a different
token tracking mechanism (per-niov reference counting) without
duplicating the input validation logic.

The refactoring is purely mechanical with no functional change. Only
intended to minimize the noise in subsequent patches.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/core/sock.c | 52 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index a1c8b47b0d56..f6526f43aa6e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1082,30 +1082,13 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 #define MAX_DONTNEED_FRAGS 1024
 
 static noinline_for_stack int
-sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
+sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_token *tokens,
+				 unsigned int num_tokens)
 {
-	unsigned int num_tokens, i, j, k, netmem_num = 0;
-	struct dmabuf_token *tokens;
+	unsigned int i, j, k, netmem_num = 0;
 	int ret = 0, num_frags = 0;
 	netmem_ref netmems[16];
 
-	if (!sk_is_tcp(sk))
-		return -EBADF;
-
-	if (optlen % sizeof(*tokens) ||
-	    optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
-		return -EINVAL;
-
-	num_tokens = optlen / sizeof(*tokens);
-	tokens = kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL);
-	if (!tokens)
-		return -ENOMEM;
-
-	if (copy_from_sockptr(tokens, optval, optlen)) {
-		kvfree(tokens);
-		return -EFAULT;
-	}
-
 	xa_lock_bh(&sk->sk_user_frags);
 	for (i = 0; i < num_tokens; i++) {
 		for (j = 0; j < tokens[i].token_count; j++) {
@@ -1135,6 +1118,35 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
 	for (k = 0; k < netmem_num; k++)
 		WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
 
+	return ret;
+}
+
+static noinline_for_stack int
+sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
+{
+	struct dmabuf_token *tokens;
+	unsigned int num_tokens;
+	int ret;
+
+	if (!sk_is_tcp(sk))
+		return -EBADF;
+
+	if (optlen % sizeof(*tokens) ||
+	    optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
+		return -EINVAL;
+
+	num_tokens = optlen / sizeof(*tokens);
+	tokens = kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL);
+	if (!tokens)
+		return -ENOMEM;
+
+	if (copy_from_sockptr(tokens, optval, optlen)) {
+		kvfree(tokens);
+		return -EFAULT;
+	}
+
+	ret = sock_devmem_dontneed_autorelease(sk, tokens, num_tokens);
+
 	kvfree(tokens);
 	return ret;
 }

-- 
2.47.3


