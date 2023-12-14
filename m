Return-Path: <netdev+bounces-57308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C980812D51
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463672826E7
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 10:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BC33C49D;
	Thu, 14 Dec 2023 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6QT4jhz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EA5115
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:49:06 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d0c4ba7081so95073697b3.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702550946; x=1703155746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SsBUA/EniiFBGQWuvtK6NJnHZuwxA5F+UsHwX3gN7uE=;
        b=i6QT4jhztRQNJzNfX8/8i/r7V4z6BMsRaraOaygevzlKfM1xToajwe1X03Fp+UXzj4
         Ze4nIDtHWiRi3UzhkmmfBjHXW5okltYw3PzNOXCikEKa5PZsQvOTkWNSGNq6hpq/VzwT
         4aTDLjiWKcH7MVrzAe5LNAwj4+ZQZfBERwFAUEU4A7QJxnuRLJVMqfLxRzmXZm2EBqqI
         ci3Bqm39cIoDQQPXAytUo4LMVl74MTs8J3kRrQ1QScq6vrzv34Vcha+DSvglfnDtMckU
         RErQH6wUfT9gI5ipDheLyESXZ91spTK94r1AnoDFmw/OW7jzyVMyXyQh6ogY2ePLZDs2
         mWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702550946; x=1703155746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsBUA/EniiFBGQWuvtK6NJnHZuwxA5F+UsHwX3gN7uE=;
        b=GwVpHHjhd3Iwjl8gpnNgg7r+5W236cHCylOtNyX619ftqx6nnlpDHpFoZWXjPMsUrb
         nzAdyO/kD346AlpHDVYzxJLucWvNI/xG2DcNtXpvNgS4iGhZX7h2YO/139wV4fH9HOLA
         8C4Jc937SXGsLKFoLvhWououbK4uJL9Nwwixm2bAqnAkTR3m1YwvmM3wup+SyLjRWGV8
         6IYW2Tk5yaKcJoIUBMqbu0OU59DIbudmF4HzZ+Ug0w7Whk4jodUux6hhXup+JVubynUg
         vwrjJ5+tpA9xpB315bR9zKcW5vNhi9Jlv5PR+EhHUqk5dCduLFMqfX5TKbxCDGGlrSCo
         IP8Q==
X-Gm-Message-State: AOJu0YydhMdLxmZHdNaYjfzBa9Qwzoz6OVcB8lKrdDp3uXaAwCYuT967
	HXAVK2xvaxg+egcnakszi45bkKKI0S6w7Q==
X-Google-Smtp-Source: AGHT+IGPSuwEp6rAZc2zd/wN4TzgSPbWmpqMRMoyENQDuSMVEaAgxYmemJDQjjsAZmdr31UqkImoaorn58j3NQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:18c2:b0:dbc:bcb7:c9d5 with SMTP
 id ck2-20020a05690218c200b00dbcbcb7c9d5mr58818ybb.1.1702550945916; Thu, 14
 Dec 2023 02:49:05 -0800 (PST)
Date: Thu, 14 Dec 2023 10:48:59 +0000
In-Reply-To: <20231214104901.1318423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214104901.1318423-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214104901.1318423-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] net: increase optmem_max default value
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Chao Wu <wwchao@google.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

For many years, /proc/sys/net/core/optmem_max default value
on a 64bit kernel has been 20 KB.

Regular usage of TCP tx zerocopy needs a bit more.

Google has used 128KB as the default value for 7 years without
any problem.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/admin-guide/sysctl/net.rst | 5 ++++-
 net/core/sock.c                          | 6 ++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index c7525942f12ce996e55afd3f2badda30ffe3c311..3960916519557f60cb91a7477015a5aca285e268 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -345,7 +345,10 @@ optmem_max
 ----------
 
 Maximum ancillary buffer size allowed per socket. Ancillary data is a sequence
-of struct cmsghdr structures with appended data.
+of struct cmsghdr structures with appended data. TCP tx zerocopy also uses
+optmem_max as a limit for its internal structures.
+
+Default : 128 KB
 
 fb_tunnels_only_for_init_net
 ----------------------------
diff --git a/net/core/sock.c b/net/core/sock.c
index fef349dd72fa735b5915fc03e29cbb155b2aff2c..08ecdc68d2df6167f0d45f7e421e307cdc2f0038 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -283,8 +283,10 @@ EXPORT_SYMBOL(sysctl_rmem_max);
 __u32 sysctl_wmem_default __read_mostly = SK_WMEM_MAX;
 __u32 sysctl_rmem_default __read_mostly = SK_RMEM_MAX;
 
-/* Maximal space eaten by iovec or ancillary data plus some space */
-int sysctl_optmem_max __read_mostly = sizeof(unsigned long)*(2*UIO_MAXIOV+512);
+/* Limits per socket sk_omem_alloc usage.
+ * TCP zerocopy regular usage needs 128 KB.
+ */
+int sysctl_optmem_max __read_mostly = 128 * 1024;
 EXPORT_SYMBOL(sysctl_optmem_max);
 
 int sysctl_tstamp_allow_data __read_mostly = 1;
-- 
2.43.0.472.g3155946c3a-goog


