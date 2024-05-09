Return-Path: <netdev+bounces-94818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0318C0C55
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 10:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C2F1F21D77
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 08:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E932D149C74;
	Thu,  9 May 2024 08:15:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F60D13C801;
	Thu,  9 May 2024 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242509; cv=none; b=aSPxGynkG9GgtorV0U9mlKH54AhFyOX5GrFHYxkSAwizxpTVzLB7nh54DNd6hORH+PlObYdghMqDOnce2d6nO1B+VTD3pXComTRyPG33DprjLRBKPybPmXzWhOahLI5VwUHHLAT4EnVPRz2wUgIuPM56z+UV0fIHYDgsUpCGDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242509; c=relaxed/simple;
	bh=//abasO0ur86MmKKOqLlg3ovsKIvJeX8HxKXAetlzHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rzIiAddFlQJPBXYTFQ9RRISDo+qKbbxPPK0sLyBJeG17+4foMT9JDMQMh8mVrhwR2KEcQ7R6w3Ej0olPn1550rfN4A+fKfy/12PPsj43loscntroNaiMeWennq5aLf4KFFDOM6MsU2hFMEODv0pYcu3dfIFllqQEplThRgnuZ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57342829409so250021a12.1;
        Thu, 09 May 2024 01:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715242506; x=1715847306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ncDKkzHVIzmJtEEJZ3QrocR62vJ2ZNL029Kbbf/WTLg=;
        b=E3RVK1AgSmBme2hgIGmDasOrSbPhaa6zIGNaEGHEIc/0DG0Q6bmH1Zc9QSE8aRKDNy
         flFiUWhMz01rdE2gs3ysiqxf4eHVza9E/O3WHHOarvjO1lkeFOoxEyB+kqlnf8qO8Kkn
         UBzBUzDl4UfX+3ybvp+DeKmVi4j13xfE4KY7wjUK2OPqlgdsbDD9OpWUebl/fIWmwJ04
         GCmL3aEHfoVSOm9+8dWcpsHaWrNpl+LlWwMSk3jBRrUZL85h2hB5nBTbTQayaTpyoyaJ
         I9b/ZpejWbvDc03Tqz4Me76nlpgZ2f17ANT5qORJzUV33eByr5EAF9qEUWBReejNdXfe
         rRQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+JfLZNqbN9e6EO5qQmkx8upBucpbpPRInh4FbjIBZ10PjAifdmmrRyy2qdtj6+MwoUcYQZBLda1tiB7lJekWAhxpvNjEaM2XdcJ5l
X-Gm-Message-State: AOJu0YxLBsXnCA/DSUS4mUkf8Yt9qjG3FcLjfnNFx667yBl/SN/TJr20
	y2cUXVWNHups6jFwtpsy8K9ZQd1eza4OYCHEk93Vkx3MmlaSJUEu
X-Google-Smtp-Source: AGHT+IFlXUmtBulKpeLlhzuEmt1DBPgYXCfPybA+eX0ViyyLNayUjz7TC8jP49z6/dNQSj9GFNAWBA==
X-Received: by 2002:aa7:d9d5:0:b0:572:a852:c756 with SMTP id 4fb4d7f45d1cf-573327f15e6mr1426390a12.12.1715242506351;
        Thu, 09 May 2024 01:15:06 -0700 (PDT)
Received: from localhost (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea65e2sm444772a12.19.2024.05.09.01.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 01:15:05 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuniyu@amazon.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	paulmck@kernel.org,
	David Howells <dhowells@redhat.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] af_unix: Fix data races in unix_release_sock/unix_stream_sendmsg
Date: Thu,  9 May 2024 01:14:46 -0700
Message-ID: <20240509081459.2807828-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A data-race condition has been identified in af_unix. In one data path,
the write function unix_release_sock() atomically writes to
sk->sk_shutdown using WRITE_ONCE. However, on the reader side,
unix_stream_sendmsg() does not read it atomically. Consequently, this
issue is causing the following KCSAN splat to occur:

	BUG: KCSAN: data-race in unix_release_sock / unix_stream_sendmsg

	write (marked) to 0xffff88867256ddbb of 1 bytes by task 7270 on cpu 28:
	unix_release_sock (net/unix/af_unix.c:640)
	unix_release (net/unix/af_unix.c:1050)
	sock_close (net/socket.c:659 net/socket.c:1421)
	__fput (fs/file_table.c:422)
	__fput_sync (fs/file_table.c:508)
	__se_sys_close (fs/open.c:1559 fs/open.c:1541)
	__x64_sys_close (fs/open.c:1541)
	x64_sys_call (arch/x86/entry/syscall_64.c:33)
	do_syscall_64 (arch/x86/entry/common.c:?)
	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

	read to 0xffff88867256ddbb of 1 bytes by task 989 on cpu 14:
	unix_stream_sendmsg (net/unix/af_unix.c:2273)
	__sock_sendmsg (net/socket.c:730 net/socket.c:745)
	____sys_sendmsg (net/socket.c:2584)
	__sys_sendmmsg (net/socket.c:2638 net/socket.c:2724)
	__x64_sys_sendmmsg (net/socket.c:2753 net/socket.c:2750 net/socket.c:2750)
	x64_sys_call (arch/x86/entry/syscall_64.c:33)
	do_syscall_64 (arch/x86/entry/common.c:?)
	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

	value changed: 0x01 -> 0x03

The line numbers are related to commit dd5a440a31fa ("Linux 6.9-rc7").

Commit e1d09c2c2f57 ("af_unix: Fix data races around sk->sk_shutdown.")
addressed a comparable issue in the past regarding sk->sk_shutdown.
However, it overlooked resolving this particular data path.
This patch only offending unix_stream_sendmsg() function, since the
other reads seem to be protected by unix_state_lock() as discussed in
Link: https://lore.kernel.org/all/20240508173324.53565-1-kuniyu@amazon.com/

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changelog:

v2:
	* Only fix the usecase reported by KCSAN
	* Targeting net instead of net-next
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index dc1651541723..fa906ec5e657 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2224,7 +2224,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto out_err;
 	}
 
-	if (sk->sk_shutdown & SEND_SHUTDOWN)
+	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
 		goto pipe_err;
 
 	while (sent < len) {
-- 
2.43.0


